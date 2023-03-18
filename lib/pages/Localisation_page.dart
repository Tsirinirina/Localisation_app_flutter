import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

class Localisation_page extends StatefulWidget {
  const Localisation_page({Key? key}) : super(key: key);
  @override
  _Localisation_pageState createState() => _Localisation_pageState();
}

class _Localisation_pageState extends State<Localisation_page> {
  String location = "Appuiez pour voir votre coordonées";
  String Adresse = "Rechercher ma position";

  //----------------

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Teste si les services de localisation sont activés.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Les services de localisation ne sont pas activés ne continuez pas
      // accéder à la position et demander aux utilisateurs de la
      // App pour activer les services de localisation.
      return Future.error('Le service de localisation est désactivé.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Les autorisations sont refusées, la prochaine fois que vous pourriez essayer
        // redemande les permissions (c'est aussi là que
        // devraitShowRequestPermissionRationale d'Android
        // retourne vrai. Selon les directives Android
        // votre application devrait maintenant afficher une interface utilisateur explicative.
        return Future.error('Les autorisations de localisation sont refusées');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Les autorisations sont refusées pour toujours, gérez-les de manière appropriée.
      return Future.error(
          'Les autorisations de localisation sont définitivement refusées, nous ne pouvons pas demander d\'autorisations.');
    }

    // Lorsque nous arrivons ici, les autorisations sont accordées et nous pouvons
    // continue d'accéder à la position de l'appareil.
    return await Geolocator.getCurrentPosition();
  }

  Future<void> GetAdresseFromLatLong(Position position) async {
    List<Placemark> placemark =
        await placemarkFromCoordinates(position.latitude, position.longitude);
    print(placemark);
    Placemark place = placemark[0];
    Adresse =
        'Vous étes a  ${place.locality},  ${place.country} \n sur ${place.street}';
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Coordonnées',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              location,
              style: TextStyle(color: Colors.black, fontSize: 16),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              'Adresse',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              '${Adresse}',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
                onPressed: () async {
                  Position position = await _determinePosition();
                  print(
                      'Latitude: ${position.latitude}, Longitude: ${position.longitude} ');

                  location =
                      'Lat: ${position.latitude}, Long: ${position.longitude}';
                  GetAdresseFromLatLong(position);
                  setState(() {});
                },
                child: Text('Voir ma position'))
          ],
        ),
      ),
    );
  }
}
