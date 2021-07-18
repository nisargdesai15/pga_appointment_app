import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:pga_appointment_app/database/databasehelper.dart';
import 'package:pga_appointment_app/models/appointment.dart';
import 'package:pga_appointment_app/models/availability.dart';

//Data Service for Cat API
class PGAAppointmentDataService {
  final String baseUri =
      "https://123bf82b-4faf-4ac5-ba25-cb04b000b7c4.mock.pstmn.io/available/appointment-times";

  final dbHelper = DatabaseHelper.instance;


  Future<Availability> getAvailabilityData() async {

    final res = await http.get(baseUri);

    if (res.statusCode == 200) {
      print(res.body);
      var parsedData = json.decode(res.body);
      Availability availability =   Availability.fromJson(parsedData);
      //removing Used Slots From API Response
      List<Appointment> appointments = await dbHelper.getAllAppointmentList();

      List<Slot> slots = availability.availability[0].slots;
      List<Slot> slotsList = List.from(slots);

      for(Slot slot in slotsList) {
        for(Appointment appointment in appointments) {
          if(appointment.startTime.compareTo(slot.start) == 0) {
            slots.remove(slot);
            break;
          }
        }
      }

      return availability;
    } else {
      throw Exception('Failed to load ');
    }
  }
}