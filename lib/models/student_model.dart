class Student {
  final String name;
  final String specialite;
  final String cin;
  final String faculty;
  final String university;
  final String level;
  final int nbRepas;
  final int totalDepense;
  final String membreDepuis;
  final int solde;

  factory Student.emptyStudent() {
    return Student(
      name: "Not Available !",
      specialite: "Not Available !",
      cin: "Not Available !",
      solde: 0,
      faculty: "Not Available !",
      university: "Not Available !",
      level: "Not Available !",
      nbRepas: 0,
      totalDepense: 0,
      membreDepuis: "Not Available !",
    );
  }

  Student({
    required this.name,
    required this.specialite,
    required this.cin,
    required this.solde,
    required this.faculty,
    required this.university,
    required this.level,
    required this.nbRepas,
    required this.totalDepense,
    required this.membreDepuis,
  });

  factory Student.fromFireStore(Map<String, dynamic> data) {
    return Student(
      name: data['Name'] ?? "Not Available !",
      specialite: data['Specialite'] ?? "Not Available",
      cin: data['Cin'] ?? "Not Available",
      solde: data['Solde'] ?? 0,
      faculty: data['Faculty'] ?? "Not Available",
      university: data['University'] ?? "Not Available",
      level: data['Level'] ?? "Not Available",
      nbRepas: data['NbRepas'] ?? "Not Available",
      totalDepense: data['TotalDepense'] ?? "Not Available",
      membreDepuis: data['MembreDepuis'] ?? "Not Available",
    );
  }

  factory Student.fromSupabase(Map<int, Map<String, dynamic>> data) {
    return Student(
      name: data[1]?['Name'] ?? "Not Available !",
      specialite: data[1]?['Specialite'] ?? "Not Available",
      cin: data[1]?['Cin'] ?? "Not Available",
      solde: data[1]?['Solde'] ?? 0,
      faculty: data[1]?['Faculty'] ?? "Not Available",
      university: data[1]?['University'] ?? "Not Available",
      level: data[1]?['Level'] ?? "Not Available",
      nbRepas: data[1]?['NbRepas'] ?? "Not Available",
      totalDepense: data[1]?['TotalDepense'] ?? "Not Available",
      membreDepuis: data[1]?['MembreDepuis'] ?? "Not Available",
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'Name': name,
      'Specialite': specialite,
      'Cin': cin,
      'Solde': solde,
      'Faculty': faculty,
      'University': university,
      'Level': level,
      'NbRepas': nbRepas,
      'TotalDepense': totalDepense,
      'MembreDepuis': membreDepuis
    };
  }

  @override
  String toString() {
    return 'Student{name: $name, cin: $cin, solde: $solde}';
  }
}
