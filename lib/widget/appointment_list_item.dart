import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pga_appointment_app/database/databasehelper.dart';
import 'package:pga_appointment_app/models/appointment.dart';

class AppointmentListItem extends StatelessWidget {
   AppointmentListItem({
    Key key,
    this.appointment,
    this.onItemPressed
  }) : super(key: key);

  final Appointment appointment;
  final Function onItemPressed;
  final dbHelper = DatabaseHelper.instance;



  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: new ListTile(
        leading: Icon(
          Icons.golf_course,
          size: 30,
        ),
        title: Padding(
          padding: EdgeInsets.only(bottom: 8),
          child: Text(
            appointment.name + "\n" + appointment.phoneNumber,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
          ),
        ),
        trailing: GestureDetector(
            onTap: onItemPressed,
            child: Icon(Icons.delete, size: 30)),
        subtitle: Text("${appointment.startTime} - ${appointment.endTime}"),
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      ),
    );
  }
}
