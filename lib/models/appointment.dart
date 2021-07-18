import 'dart:convert';

Appointment appointmentFromJson(String str) => Appointment.fromJson(json.decode(str));

String appointmentToJson(Appointment data) => json.encode(data.toJson());

class Appointment {
  Appointment({
    this.id,
    this.name,
    this.phoneNumber,
    this.startTime,
    this.endTime,
  });

  int id;
  String name;
  String phoneNumber;
  String startTime;
  String endTime;

  factory Appointment.fromJson(Map<String, dynamic> json) => Appointment(
    id: json["id"],
    name: json["name"],
    phoneNumber: json["phoneNumber"],
    startTime: json["startTime"],
    endTime: json["endTime"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "phoneNumber": phoneNumber,
    "startTime": startTime,
    "endTime": endTime,
  };
}
