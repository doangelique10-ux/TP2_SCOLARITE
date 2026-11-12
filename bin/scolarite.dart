// bin/scolarite.dart
import 'package:scolarite/modeles.dart';
import 'package:scolarite/statistiques.dart';
import 'package:scolarite/deliberation.dart';
import 'package:scolarite/service.dart';

void main() async {
  print("=== 1. CHARGEMENT DE LA PROMOTION (Asynchrone) ===");
  // Utilisation de la fonction asynchrone de l'étape 4
  List<Etudiant> promo = await chargerPromo();

  for (var e in promo) {
    print("- ${e.nom} (Matricule: ${e.matricule}) | Contact: ${e.contact}");
  }

  print("\n=== 2. CHARGEMENT D'UNE UE EN PARALLÈLE ===");
  // Simulation de l'étape 4.2 avec Future.wait
  Stopwatch chrono = Stopwatch()..start();
  List<String> codesUE = ['INF351', 'INF352', 'INF353', 'INF354', 'INF355'];

  List<UE> ues = await Future.wait(codesUE.map((code) => chargerUE(code)));

  chrono.stop();
  print("5 UE chargées en parallèle en ${chrono.elapsedMilliseconds} ms :");
  for (var ue in ues) {
    print("  * [${ue.code}] ${ue.intitule} (Coef: ${ue.coefficient})");
  }

  print("\n=== 3. STATISTIQUES ET DÉLIBÉRATION ===");
  // On simule des notes pour le calcul
  Etudiant etudiantTest = Etudiant(
    '21A0001',
    'Awa KONAN',
    'awa.konan@univ.cm',
    {
      'INF351': 14.5,
      'INF352': 11.0,
      'INF353': 9.0,
      'INF354': 16.0,
      'INF355': 13.0,
    },
  );

  double moyenneEtudiant = moyenne(etudiantTest, ues);
  print(
    "Moyenne pondérée de ${etudiantTest.nom} : ${moyenneEtudiant.toStringAsFixed(2)} / 20",
  );

  // Délibération (Étape 3)
  Resultat res = deliberer(etudiantTest, ues);
  print("Résultat de délibération : ${message(res)}");

  print("\n=== 4. SUIVI DU JOURNAL (Stream) ===");
  // Test du Stream de l'étape 4.3
  await for (String log in journal()) {
    print(log);
  }

  print("\n=== FIN DU TEST ===");
}