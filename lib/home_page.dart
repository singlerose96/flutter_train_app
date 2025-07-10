import 'package:flutter/material.dart';
import 'station_list_page.dart';
import 'seat_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? departureStation; // 출발역
  String? arrivalStation;   // 도착역

  // 역 선택 페이지로 이동하고 결과 받기
  Future<void> _selectStation(bool isDeparture) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => StationListPage(isDeparture: isDeparture),
      ),
    );

    if (result != null && result is String) {
      setState(() {
        if (isDeparture) {
          departureStation = result;
        } else {
          arrivalStation = result;
        }
      });
    }
  }

  void _goToSeatPage() {
    if (departureStation != null && arrivalStation != null) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => SeatPage(
            departure: departureStation!,
            arrival: arrivalStation!,
          ),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('출발역과 도착역을 모두 선택해주세요.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('기차 예매 서비스')),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            // 출발역
            GestureDetector(
              onTap: () => _selectStation(true),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
                decoration: BoxDecoration(
                  color: Colors.lightBlue.shade50,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.blue),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('출발역', style: TextStyle(fontSize: 16)),
                    Text(departureStation ?? '선택',
                        style: const TextStyle(fontSize: 16)),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),

            // 도착역
            GestureDetector(
              onTap: () => _selectStation(false),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
                decoration: BoxDecoration(
                  color: Colors.pink.shade50,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.pink),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('도착역', style: TextStyle(fontSize: 16)),
                    Text(arrivalStation ?? '선택',
                        style: const TextStyle(fontSize: 16)),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 40),

            // 좌석 선택 버튼
            ElevatedButton(
              onPressed: (departureStation != null && arrivalStation != null)
                  ? _goToSeatPage
                  : null, // 조건부 활성화
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 50),
              ),
              child: const Text('좌석 선택'),
            ),
          ],
        ),
      ),
    );
  }
}
