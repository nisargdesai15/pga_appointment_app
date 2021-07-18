import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pga_appointment_app/database/databasehelper.dart';
import 'package:pga_appointment_app/models/appointment.dart';
import 'package:pga_appointment_app/widget/appointment_list_item.dart';

class BookAppointmentListView extends StatefulWidget {
  const BookAppointmentListView({Key key}) : super(key: key);

  @override
  _BookAppointmentListViewState createState() => _BookAppointmentListViewState();
}

class _BookAppointmentListViewState extends State<BookAppointmentListView> {
  @override
  Widget build(BuildContext context) {
    final dbHelper = DatabaseHelper.instance;

    return Scaffold(
      body: Column(
        children: [
          Text('Booked Appointments',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w600),),
          SizedBox(height: 25,),
          Expanded(
            child: FutureBuilder<Object>(
                future: dbHelper.getAllAppointmentList(),
                builder: (context, snapshot) {
                  print(snapshot.data);
                  final List<Appointment> items = snapshot.data ?? [];
                  return items.length > 0 ? ListView.builder(
                    itemCount: items.length,
                    itemBuilder: (context, index) {
                      final item = items[index];
                      return AppointmentListItem(appointment: item,onItemPressed: () {
                        dbHelper.delete(item.id);
                        setState(() {

                        });
                      },);
                    },
                  ):Container();
                }),
          ),
        ],
      ),
    );
  }
}
