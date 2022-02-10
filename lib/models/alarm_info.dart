class DataAlarm {
  int? id;
  String? title;
  // String? description;
  DateTime? alarmDateTime;
  bool? isPending;
  int? gradientColorIndex;

  DataAlarm(
    {
      this.id,
      this.title,
      // this.description,
      this.alarmDateTime,
      this.isPending,
      this.gradientColorIndex,
    }
  );

  factory DataAlarm.fromMap(Map<String, dynamic> json) => DataAlarm(
        id: json["id"],
        title: json["title"],
        // description: json["description"],
        alarmDateTime: DateTime.parse(json["alarmDateTime"]),
        isPending: json["isPending"],
        gradientColorIndex: json["gradientColorIndex"],
      );
  Map<String, dynamic> toMap() => {
        "id": id,
        "title": title,
        // "description": description,
        "alarmDateTime": alarmDateTime.toString(),
        "isPending": isPending,
        "gradientColorIndex": gradientColorIndex,
      };
}
