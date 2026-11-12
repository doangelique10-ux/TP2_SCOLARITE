// lib/service.dart
import 'modeles.dart';

// 1. Charger la promotion avec un délai de 2 secondes
Future<List<Etudiant>> chargerPromo() async {
  await Future.delayed(const Duration(seconds: 2));
  
  // Simulation d'une erreur si le premier matricule commence par 'X' (requis pour l'étape 4.4)
  // return [Etudiant.fromJson({'matricule': 'X999', 'nom': 'Erreur', 'notes': {}})];

  return [
    Etudiant.fromJson({
      'matricule': '21A0001',
      'nom': 'Awa KONAN',
      'email': 'awa.konan@univ.cm',
      'notes': {'INF351': 14.5, 'INF352': 16.0}
    }),
    Etudiant.fromJson({
      'matricule': '21A0002',
      'nom': 'Koffi MENSAH',
      'email': null,
      'notes': {'INF351': 9.5, 'INF352': 11.0}
    }),
  ];
}

// 2. Charger une UE avec un délai de 500 ms
Future<UE> chargerUE(String code) async {
  await Future.delayed(const Duration(milliseconds: 500));
  return UE(code, 'Intitulé de $code', 3);
}

// 3. Stream qui émet un message par seconde
Stream<String> journal() async* {
  for (int i = 1; i <= 3; i++) {
    await Future.delayed(const Duration(seconds: 1));
    yield 'Calcul de la moyenne étape $i en cours...';
  }
}