// lib/statistiques.dart
import 'modeles.dart';

// 1. Moyenne pondérée (une UE sans note vaut 0)
double moyenne(Etudiant e, List<UE> ues) {
  if (ues.isEmpty) return 0.0;

  // Calcul de la somme pondérée (note * coefficient) avec fold
  double sommePoints = ues.fold(0.0, (acc, ue) => acc + ((e.note(ue.code) ?? 0.0) * ue.coefficient));
  
  // Calcul de la somme totale des coefficients avec fold
  int sommeCoefficients = ues.fold(0, (acc, ue) => acc + ue.coefficient);

  if (sommeCoefficients == 0) return 0.0;
  return sommePoints / sommeCoefficients;
}

// 2. Classement de la promotion par moyenne décroissante
List<Etudiant> classement(List<Etudiant> promo, List<UE> ues) {
  var copiePromo = List<Etudiant>.from(promo);
  copiePromo.sort((a, b) => moyenne(b, ues).compareTo(moyenne(a, ues)));
  return copiePromo;
}

// 3. Moyenne par UE pour l'ensemble de la promotion
Map<String, double> moyenneParUE(List<Etudiant> promo, List<UE> ues) {
  return {
    for (var ue in ues)
      ue.code: () {
        var notesValides = promo
            .map((e) => e.note(ue.code))
            .where((n) => n != null)
            .cast<double>()
            .toList();

        if (notesValides.isEmpty) return 0.0;
        double somme = notesValides.reduce((a, b) => a + b);
        return somme / notesValides.length;
      }()
  };
}

// 4. Record (min, max) pour une liste de valeurs
(double, double) extremes(List<double> valeurs) {
  if (valeurs.isEmpty) return (0.0, 0.0);
  double minVal = valeurs.reduce((a, b) => a < b ? a : b);
  double maxVal = valeurs.reduce((a, b) => a > b ? a : b);
  return (minVal, maxVal);
}