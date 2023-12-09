class BabyAccount {
  String name;
  int gender;
  int relationship;
  DateTime dateOfBirth;

  BabyAccount(
      {required this.name,
      required this.gender,
      required this.relationship,
      required this.dateOfBirth});

  factory BabyAccount.fromJson(Map<String, dynamic> json) {
    return BabyAccount(
      name: json['name'],
      gender: json['gender'],
      relationship: json['relationship'],
      dateOfBirth: DateTime.parse(json['dateOfBirth']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'gender': gender,
      'relationship': relationship,
      'dateOfBirth': dateOfBirth.toIso8601String(),
    };
  }
}
