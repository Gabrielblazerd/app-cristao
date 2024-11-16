import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarPage extends StatefulWidget {
  @override
  _CalendarPageState createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  Map<DateTime, List<String>> attendance = {};
  TextEditingController noteController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calendário de Presença na Igreja'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            TableCalendar(
              focusedDay: DateTime.now(),
              firstDay: DateTime(DateTime.now().year, 1, 1),
              lastDay: DateTime(DateTime.now().year, 12, 31),
              locale: 'pt_BR',
              eventLoader: (day) {
                return attendance[day] ?? [];
              },
              onDaySelected: (selectedDay, focusedDay) {
                _showAttendanceDialog(selectedDay);
              },
              availableCalendarFormats: const {
                CalendarFormat.month: 'Month',
              },
            ),
            const SizedBox(height: 20),
            Container(
              height: 300,
              child: ListView(
                children: attendance.entries.map((entry) {
                  return ListTile(
                    title: Text('${entry.key.toLocal()}'.split(' ')[0]),
                    subtitle: Text(entry.value.join(', ')),
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showAttendanceDialog(DateTime selectedDay) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Marcar presença e anotações'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Adicionar anotação para ${selectedDay.toLocal()}'
                  .split(' ')[0]),
              TextField(
                controller: noteController,
                decoration:
                    const InputDecoration(hintText: 'Como foi o culto?'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  if (attendance[selectedDay] == null) {
                    attendance[selectedDay] = [];
                  }
                  attendance[selectedDay]!.add(noteController.text);
                });
                noteController.clear();
                Navigator.of(context).pop();
              },
              child: const Text('Salvar'),
            ),
          ],
        );
      },
    );
  }
}
