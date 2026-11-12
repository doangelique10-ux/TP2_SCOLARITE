// test/statistiques_test.dart
import 'package:test/test.dart';
import 'package:scolarite/modeles.dart';
import 'package:scolarite/statistiques.dart';
import 'package:scolarite/deliberation.dart';

void main() {
  group('Tests du module Scolarité', () {
    
    test('1. Test de la moyenne pondérée', () {
      final ues = [
        const UE('INF351', 'Algo', 2),
        const UE('INF352', 'BD', 1),
      ];
      final e = Etudiant('21A0001', 'Awa', 'awa@univ.cm', {'INF351': 12, 'INF352': 15});
      
      // (12*2 + 15*1) / (2+1) = (24 + 15) / 3 = 39 / 3 = 13.0
      expect(moyenne(e, ues), closeTo(13.0, 0.001));
    });

    test('2. Test d une UE manquante (vaut 0)', () {
      final ues = [const UE('INF351', 'Algo', 2)];
      final e = Etudiant('21A0001', 'Awa', null, {}); // Pas de note
      
      expect(moyenne(e, ues), closeTo(0.0, 0.001));
    });

    test('3. Test du classement par moyenne décroissante', () {
      final ues = [const UE('INF351', 'Algo', 1)];
      final e1 = Etudiant('01', 'Etudiant Faible', null, {'INF351': 8.0});
      final e2 = Etudiant('02', 'Etudiant Fort', null, {'INF351': 16.0});
      
      final promo = [e1, e2];
      final res = classement(promo, ues);

      expect(res.first.nom, 'Etudiant Fort');
      expect(res.last.nom, 'Etudiant Faible');
    });

    test('4. Test de la délibération (Admis)', () {
      final ues = [const UE('INF351', 'Algo', 1)];
      final e = Etudiant('21A0001', 'Awa', null, {'INF351': 12.0});
      
      final resultat = deliberer(e, ues);
      expect(resultat, isA<Admis>());
    });

  });
}