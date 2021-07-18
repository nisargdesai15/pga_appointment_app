import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pga_appointment_app/views/book_appointment_list_view.dart';
import 'package:pga_appointment_app/views/schedule_appointment_view.dart';

void main() {
  //locking to portrait mode
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
    @override
    Widget build(BuildContext context) {
      return MaterialApp(
          title: 'PGA Appointment App',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            // This is the theme of your application.
            //
            // Try running your application with "flutter run". You'll see the
            // application has a blue toolbar. Then, without quitting the app, try
            // changing the primarySwatch below to Colors.green and then invoke
            // "hot reload" (press "r" in the console where you ran "flutter run",
            // or simply save your changes to "hot reload" in a Flutter IDE).
            // Notice that the counter didn't reset back to zero; the application
            // is not restarted.
            primarySwatch: Colors.blue,
          ),
          home: DefaultTabController(
            length: 2,
            child: Scaffold(
              appBar: AppBar(
                title: Center(child: Text('PGA Appointment App')),
                bottom: TabBar(
                  tabs: [
                    Text('Schedule Appointment',style: TextStyle(fontSize: 12),),
                    Text('Booked Appointments',style: TextStyle(fontSize: 12))
                  ],
                ),
              ),
              body: TabBarView(
                children: [
                  ScheduleAppointmentPage(),
                  BookAppointmentListView()
                ],
              ),

            ),

          ));
    }
}
