// lib/modeles.dart

class UE {
  final String code;
  final String intitule;
  final int coefficient;

  const UE(this.code, this.intitule, this.coefficient);

  // 1. Décodage JSON pour l'UE
  factory UE.fromJson(Map<String, dynamic> j) {
    return UE(
      j['code'] as String,
      j['intitule'] as String,
      j['coefficient'] as int,
    );
  }
}

class Etudiant {
  final String matricule;
  final String nom;
  final String? email; // facultatif (peut être null)
  final Map<String, double> notes;

  // Constructeur de la classe Etudiant
  Etudiant(this.matricule, this.nom, this.email, this.notes);

  // 1. Décodage JSON pour l'Etudiant
  factory Etudiant.fromJson(Map<String, dynamic> j) {
    var rawNotes = j['notes'] as Map<String, dynamic>? ?? {};
    Map<String, double> parsedNotes = rawNotes.map(
      (key, value) => MapEntry(key, (value as num).toDouble()),
    );

    return Etudiant(
      j['matricule'] as String,
      j['nom'] as String,
      j['email'] as String?,
      parsedNotes,
    );
  }

  // 2. Accesseur String get contact (renvoie l'e-mail ou "non renseigné" via ??)[cite: 13]
  String get contact => email ?? 'non renseigné';

  // 3. Méthode double? note(String codeUE)[cite: 13]
  double? note(String codeUE) {
    return notes[codeUE];
  }

  @override
  String toString() => 'Etudiant($matricule - $nom, Contact: $contact, Notes: $notes)';
}