import 'package:flutter/material.dart';
import 'package:flutter_train_app/pages/station_list_page.dart';
import 'package:flutter_train_app/pages/seat_page.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? departureStation;
  String? arrivalStation;

  void _navigateToStationList(bool isDeparture) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => StationListPage(isDeparture: isDeparture),
      ),
    );

    if (result != null) {
      setState(() {
        if (isDeparture) {
          departureStation = result;
        } else {
          arrivalStation = result;
        }
      });
    }
  }

  void _navigateToSeatPage() {
    if (departureStation != null && arrivalStation != null) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SeatPage(
            departureStation: departureStation!,
            arrivalStation: arrivalStation!,
          ),
        ),
      );
    }
  }

  Widget _buildStationBox(String label, String? station, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        margin: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.deepPurple),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(width: 16),
            Text(station ?? '선택', style: const TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('기차 예매')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildStationBox('출발역', departureStation, () => _navigateToStationList(true)),
            _buildStationBox('도착역', arrivalStation, () => _navigateToStationList(false)),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: (departureStation != null && arrivalStation != null)
                  ? _navigateToSeatPage
                  : null,
              child: const Text('좌석 선택하기'),
            ),
          ],
        ),
      ),
    );
  }
}
