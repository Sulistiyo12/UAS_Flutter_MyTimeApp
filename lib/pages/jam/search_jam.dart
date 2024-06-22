import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SearchTime extends StatefulWidget {
  @override
  _SearchTimeState createState() => _SearchTimeState();
}

class _SearchTimeState extends State<SearchTime> {
  TextEditingController _searchController = TextEditingController();

  List<String> timeZones = [
    'America/New_York',
    'Europe/London',
    'Asia/Tokyo'
  ]; // Daftar zona waktu atau negara

  List<int> timeZoneOffsets = [-5, 0, 9];

  List<String> filteredTimeZones = [];

  @override
  void initState() {
    filteredTimeZones = timeZones;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Telusuri kota'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(
                context, ''); // Mengirim zona jam yang dipilih saat kembali
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Telusuri kota',
                prefixIcon: Icon(Icons.search),
              ),
              onChanged: (value) {
                setState(() {
                  filteredTimeZones = timeZones
                      .where((zone) =>
                          zone.toLowerCase().contains(value.toLowerCase()))
                      .toList();
                });
              },
            ),
            Expanded(
              child: ListView.builder(
                itemCount: filteredTimeZones.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(
                      '${filteredTimeZones[index]}: ${DateFormat('HH:mm:ss').format(DateTime.now().toUtc().add(Duration(hours: timeZoneOffsets[index])))}',
                    ),
                    onTap: () {
                      Navigator.pop(context, filteredTimeZones[index]);
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
