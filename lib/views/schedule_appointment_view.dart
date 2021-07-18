import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pga_appointment_app/database/databasehelper.dart';
import 'package:pga_appointment_app/models/appointment.dart';
import 'package:pga_appointment_app/models/availability.dart';
import 'package:pga_appointment_app/service/pgaAppointmentDataService.dart';

class ScheduleAppointmentPage extends StatefulWidget {
  const ScheduleAppointmentPage({Key key}) : super(key: key);

  @override
  _ScheduleAppointmentPageState createState() =>
      _ScheduleAppointmentPageState();
}

class _ScheduleAppointmentPageState extends State<ScheduleAppointmentPage>  {
  Slot _selected;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  FocusNode f1 = new FocusNode();
  FocusNode f2 = new FocusNode();

  final dbHelper = DatabaseHelper.instance;


  @override
  void initState() {
    super.initState();
  }


  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    super.dispose();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Padding(
          padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(height: 100,),
                Text("Today",style: TextStyle(fontWeight: FontWeight.w600,fontSize: 20),),
                SizedBox(height: 10,),
                FutureBuilder<Availability>(
                  future: PGAAppointmentDataService().getAvailabilityData(),
                  builder: (context, snapshot) {
                    print(snapshot.connectionState);
                    if (snapshot.connectionState == ConnectionState.done && snapshot.hasData) {
                      print(_selected);
                      _selected = null;
                      print(snapshot.data.availability[0]);
                      return DropdownButtonFormField(
                        value: _selected,
                        decoration: decoration('Select Time Slot'),
                        validator: (value) => value == null ? 'Please Select Time Slot' : null,
                        icon: Icon(Icons.arrow_drop_down),
                        iconSize: 30,
                        elevation: 16,
                        style: TextStyle(color: Colors.black),
                        onChanged: (newValue) {
                            _selected = newValue;
                        },
                        items: snapshot.data.availability[0].slots
                            .map<DropdownMenuItem<Slot>>((Slot value) {
                          return DropdownMenuItem<Slot>(
                            value: value,
                            child: Text(value.start + "-" + value.end),
                          );
                        }).toList(),
                      );
                    } else if (snapshot.hasError) {
                      return Text("getting Error to get TimeSlots",style: TextStyle(fontWeight: FontWeight.w600,fontSize: 20));
                    }
                    return CircularProgressIndicator();
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  focusNode: f1,
                  keyboardType: TextInputType.name,
                  controller: _nameController,
                  decoration:decoration('Name'),
                  onFieldSubmitted: (value) {
                    f1.unfocus();
                    FocusScope.of(context).requestFocus(f2);
                  },
                  textInputAction: TextInputAction.next,
                  validator: (value) {
                    if (value.isEmpty)
                      return 'Please enter the Name';
                    return null;
                  },
                ),
                SizedBox(
                  height: 25.0,
                ),
                TextFormField(
                  focusNode: f2,
                  keyboardType: TextInputType.phone,
                  controller: _phoneController,
                  decoration: decoration('Phone Number'),
                  onFieldSubmitted: (value) {
                    f2.unfocus();
                  },
                  textInputAction: TextInputAction.next,
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter the phone';
                    } else if (!phoneValidate(value)) {
                      return 'Please enter correct phone number';
                    }
                    return null;
                  },
                ),
                Container(
                  padding: const EdgeInsets.only(top: 25.0),
                  child: SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      child: Text(
                        "Schedule Appointment",
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () async {

                        if(_formKey.currentState.validate()) {
                          Appointment appointment = Appointment();
                          appointment.name = _nameController.text;
                          appointment.phoneNumber = _phoneController.text;
                          appointment.startTime = _selected.start;
                          appointment.endTime = _selected.end;

                          final id = await dbHelper.insert(appointment.toJson());
                          print('inserted row id: $id');

                          //clear values
                          _nameController.clear();
                          _phoneController.clear();

                          ScaffoldMessenger.of(context)
                              .showSnackBar(SnackBar(content: Text('Appointment Scheduled')));
                          setState(() {

                          });
                        }

                      },
                      style: ElevatedButton.styleFrom(
                        elevation: 2,
                        primary: Colors.blue[900],
                        onPrimary: Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(32.0),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


InputDecoration decoration(String hintText) {

  return  InputDecoration(
    contentPadding: EdgeInsets.only(left: 20, top: 10, bottom: 10),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(90.0)),
      borderSide: BorderSide.none,
    ),
    filled: true,
    fillColor: Colors.grey[350],
    hintText: hintText,
  );

}




bool phoneValidate(String phone) {
  if (phone.length == 10) {
    return true;
  } else {
    return false;
  }
}
