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
      // 🟣 2: body 배경색
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: const Text('기차 예매'), // 🟣 1: 앱바 텍스트 스타일 없음
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 1,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20), // 🟣 추가: 전체 padding 20
        child: Column(
          children: [
            const SizedBox(height: 20), // 여백 추가
            Container(
              height: 200, // 🟣 3: 박스 높이
              decoration: BoxDecoration(
                color: Colors.white, // 🟣 박스 배경색
                borderRadius: BorderRadius.circular(20), // 🟣 모서리 둥글기
              ),
              child: Row(
                children: [
                  // 출발역 칸
                  Expanded(
                    child: GestureDetector(
                      onTap: () => _navigateToStationList(true),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '출발역',
                            style: const TextStyle(
                              fontSize: 16, // 🟣 4
                              fontWeight: FontWeight.bold,
                              color: Colors.grey,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            departureStation ?? '선택',
                            style: const TextStyle(
                              fontSize: 40, // 🟣 5
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  // 🟣 6: 세로선
                  Container(
                    width: 2,
                    height: 50,
                    color: Colors.grey[400],
                  ),
                  // 도착역 칸
                  Expanded(
                    child: GestureDetector(
                      onTap: () => _navigateToStationList(false),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '도착역',
                            style: const TextStyle(
                              fontSize: 16, // 🟣 4
                              fontWeight: FontWeight.bold,
                              color: Colors.grey,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            arrivalStation ?? '선택',
                            style: const TextStyle(
                              fontSize: 40, // 🟣 5
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: (departureStation != null && arrivalStation != null)
                    ? _navigateToSeatPage
                    : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.purple, // 🟣 7: 버튼 배경색
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20), // 🟣 버튼 둥글기
                  ),
                  textStyle: const TextStyle(
                    fontSize: 18, // 🟣 버튼 글자 크기
                    fontWeight: FontWeight.bold, // 🟣 버튼 글자 굵기
                  ),
                ),
                child: const Text(
                  '좌석 선택',
                  style: TextStyle(color: Colors.white), // 🟣 버튼 글자 색
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
