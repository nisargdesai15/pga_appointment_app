import 'dart:convert';

Availability availabilityFromJson(String str) => Availability.fromJson(json.decode(str));

String availabilityToJson(Availability data) => json.encode(data.toJson());

class Availability {
  Availability({
    this.availability,
  });

  List<AvailabilityElement> availability;

  factory Availability.fromJson(Map<String, dynamic> json) => Availability(
    availability: List<AvailabilityElement>.from(json["availability"].map((x) => AvailabilityElement.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "availability": List<dynamic>.from(availability.map((x) => x.toJson())),
  };
}

class AvailabilityElement {
  AvailabilityElement({
    this.slots,
  });

  List<Slot> slots;

  factory AvailabilityElement.fromJson(Map<String, dynamic> json) => AvailabilityElement(
    slots: List<Slot>.from(json["slots"].map((x) => Slot.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "slots": List<dynamic>.from(slots.map((x) => x.toJson())),
  };
}

class Slot {
  Slot({
    this.start,
    this.end,
  });

  String start;
  String end;

  factory Slot.fromJson(Map<String, dynamic> json) => Slot(
    start: json["start"],
    end: json["end"],
  );

  Map<String, dynamic> toJson() => {
    "start": start,
    "end": end,
  };
}