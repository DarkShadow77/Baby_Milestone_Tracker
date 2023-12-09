class BabyMilestone {
  int id;
  String type;
  DateTime date;
  String notes;

  BabyMilestone(
      {required this.id,
      required this.type,
      required this.date,
      required this.notes});

  factory BabyMilestone.fromJson(Map<String, dynamic> json) {
    return BabyMilestone(
      id: json['id'],
      type: json['type'],
      date: DateTime.parse(json['date']),
      notes: json['notes'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'type': type,
      'date': date.toIso8601String(),
      'notes': notes,
    };
  }
}
