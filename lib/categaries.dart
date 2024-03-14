import 'categaries_modul.dart';

getCategaries() {
  List categaries = [];

  Categaries_modul categaries_modul = new Categaries_modul();

  categaries_modul.name = "City";
  categaries_modul.image_url =
      "https://images.unsplash.com/photo-1523906834658-6e24ef2386f9?auto=format&fit=crop&q=60&w=500&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxleHBsb3JlLWZlZWR8MTV8fHxlbnwwfHx8fHw%3D";
  categaries.add(categaries_modul);

  categaries_modul = new Categaries_modul();

  categaries_modul.name = "Car";
  categaries_modul.image_url =
      "https://images.unsplash.com/photo-1520116468816-95b69f847357?auto=format&fit=crop&q=60&w=500&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxleHBsb3JlLWZlZWR8MTJ8fHxlbnwwfHx8fHw%3D";
  categaries.add(categaries_modul);

  categaries_modul = new Categaries_modul();

  categaries_modul.name = "Travel";
  categaries_modul.image_url =
      "https://images.unsplash.com/photo-1527631746610-bca00a040d60?auto=format&fit=crop&q=80&w=1974&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D";
  categaries.add(categaries_modul);

  categaries_modul = new Categaries_modul();

  return categaries;
}
