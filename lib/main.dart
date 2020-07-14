import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  AppState createState() => AppState();
}

List<String> views = <String>[
  'Day',
  'Week',
  'WorkWeek',
  'Month',
  'Timeline Day',
  'Timeline Week',
  'Timeline WorkWeek'
];

class AppState extends State<MyApp> {
  CalendarView _calendarView;
  List<TimeRegion> _specialTimeRegions;

  @override
  void initState() {
    _getTimeRegions();
    _calendarView = CalendarView.day;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          leading: PopupMenuButton<String>(
            icon: Icon(Icons.calendar_today),
            itemBuilder: (BuildContext context) => views.map((String choice) {
              return PopupMenuItem<String>(
                value: choice,
                child: Text(choice),
              );
            }).toList(),
            onSelected: (String value) {
              setState(() {
                if (value == 'Day') {
                  _calendarView = CalendarView.day;
                } else if (value == 'Week') {
                  _calendarView = CalendarView.week;
                } else if (value == 'WorkWeek') {
                  _calendarView = CalendarView.workWeek;
                } else if (value == 'Month') {
                  _calendarView = CalendarView.month;
                } else if (value == 'Timeline Day') {
                  _calendarView = CalendarView.timelineDay;
                } else if (value == 'Timeline Week') {
                  _calendarView = CalendarView.timelineWeek;
                } else if (value == 'Timeline WorkWeek') {
                  _calendarView = CalendarView.timelineWorkWeek;
                }
              });
            },
          ),
        ),
        body: SfCalendar(
          view: _calendarView,
          specialRegions: _specialTimeRegions,
          onViewChanged: viewChanged,
          onTap: calendarTapped,
          onLongPress: longPressed,
        ),
      ),
    );
  }

  void _getTimeRegions() {
    _specialTimeRegions = <TimeRegion>[];
    _specialTimeRegions.add(TimeRegion(
        startTime: DateTime(2020, 5, 29, 09, 0, 0),
        endTime: DateTime(2020, 5, 29, 10, 0, 0),
        recurrenceRule: 'FREQ=WEEKLY;INTERVAL=1;BYDAY=SAT,',
        text: 'Special Region',
        color: Colors.red,
        enablePointerInteraction: true,
        textStyle: TextStyle(
          color: Colors.black,
          fontStyle: FontStyle.italic,
          fontSize: 10,
        )));
  }

  void calendarTapped(CalendarTapDetails calendarTapDetails) {
    _specialTimeRegions.add(TimeRegion(
      startTime: calendarTapDetails.date,
      endTime: calendarTapDetails.date.add(Duration(hours: 1)),
      text: 'Added via calendar tap callback',
      color: Color(0xffbD3D3D3),
    ));
    setState(() {});
  }

  void longPressed(CalendarLongPressDetails calendarLongPressDetails) {
    _specialTimeRegions.add(TimeRegion(
      startTime: calendarLongPressDetails.date,
      endTime: calendarLongPressDetails.date.add(Duration(hours: 1)),
      text: 'Added via long press callback',
      color: Color(0xffbD3D3D3),
    ));
    setState(() {});
  }

  void viewChanged(ViewChangedDetails viewChangedDetails) {
    _specialTimeRegions.add(TimeRegion(
      startTime: viewChangedDetails.visibleDates[0],
      endTime: viewChangedDetails.visibleDates[0].add(Duration(hours: 1)),
      text: 'Added via view changed callback',
      color: Color(0xffbD3D3D3),
    ));

  }
}
