// lib/deliberation.dart
import 'modeles.dart';
import 'statistiques.dart';

// Définition des classes scellées pour les résultats
sealed class Resultat {}
class Admis extends Resultat { 
  final String mention; 
  Admis(this.mention); 
}
class Rattrapage extends Resultat { 
  final List<String> ues; 
  Rattrapage(this.ues); 
}
class Ajourne extends Resultat {}

// Fonction de délibération
Resultat deliberer(Etudiant e, List<UE> ues) {
  double m = moyenne(e, ues);
  
  if (m >= 10) {
    String mention = m >= 16 ? 'Très Bien' : (m >= 14 ? 'Bien' : (m >= 12 ? 'Assez Bien' : 'Passable'));
    return Admis(mention);
  } else if (m >= 8) {
    // Liste des codes UE où l'étudiant a moins de 10
    List<String> uesSous10 = ues
        .where((ue) => (e.note(ue.code) ?? 0.0) < 10)
        .map((ue) => ue.code)
        .toList();
    return Rattrapage(uesSous10);
  } else {
    return Ajourne();
  }
}

// Fonction d'affichage utilisant une expression switch moderne
String message(Resultat r) {
  return switch (r) {
    Admis(mention: var m) => 'Admis avec mention : $m',
    Rattrapage(ues: var list) => 'Rattrapage requis sur les UE : $list',
    Ajourne() => 'Malheureusement ajourné.',
  };
}