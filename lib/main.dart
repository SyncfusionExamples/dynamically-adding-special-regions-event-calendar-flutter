import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  AppState createState() => AppState();
}

class AppState extends State<MyApp> {
  final List<TimeRegion> _specialTimeRegions = <TimeRegion>[];

  @override
  void initState() {
    _getTimeRegions();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: SafeArea(
          child: SfCalendar(
            view: CalendarView.day,
            specialRegions: _specialTimeRegions,
            onViewChanged: viewChanged,
            onTap: calendarTapped,
            onLongPress: longPressed,
          ),
        ),
      ),
    );
  }

  void _getTimeRegions() {
    _specialTimeRegions.add(TimeRegion(
        startTime: DateTime(2020, 5, 29, 09, 0, 0),
        endTime: DateTime(2020, 5, 29, 10, 0, 0),
        recurrenceRule: 'FREQ=WEEKLY;INTERVAL=1;BYDAY=SAT,',
        text: 'Special Region',
        color: Colors.red,
        enablePointerInteraction: true,
        textStyle: const TextStyle(
          color: Colors.black,
          fontStyle: FontStyle.italic,
          fontSize: 10,
        )));
  }

  void calendarTapped(CalendarTapDetails calendarTapDetails) {
    _specialTimeRegions.add(TimeRegion(
      startTime: calendarTapDetails.date!,
      endTime: calendarTapDetails.date!.add(const Duration(hours: 1)),
      text: 'Added via calendar tap callback',
      color: const Color(0xffbD3D3D3),
    ));
    setState(() {});
  }

  void longPressed(CalendarLongPressDetails calendarLongPressDetails) {
    _specialTimeRegions.add(TimeRegion(
      startTime: calendarLongPressDetails.date!,
      endTime: calendarLongPressDetails.date!.add(const Duration(hours: 1)),
      text: 'Added via long press callback',
      color: const Color(0xffbD3D3D3),
    ));
    setState(() {});
  }

  void viewChanged(ViewChangedDetails viewChangedDetails) {
    _specialTimeRegions.add(TimeRegion(
      startTime: viewChangedDetails.visibleDates[0],
      endTime: viewChangedDetails.visibleDates[0].add(const Duration(hours: 1)),
      text: 'Added via view changed callback',
      color: const Color(0xffbD3D3D3),
    ));
  }
}