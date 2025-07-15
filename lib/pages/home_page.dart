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
    final result = await Navigator.push<String>(
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
      if (departureStation == arrivalStation) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('출발역과 도착역이 같습니다'),
            duration: const Duration(seconds: 2),                         // 🟣 지속 시간 2초
            behavior: SnackBarBehavior.floating,                          // 🟣 플로팅 모드
            margin: const EdgeInsets.fromLTRB(20, 0, 20, 25),             // 🟣 좌우 20, 버튼 높이 반(25) 아래 위치
          ),
        );
      } else {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => SeatPage(
              departure: departureStation!,
              arrival: arrivalStation!,
            ),
          ),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('출발역과 도착역을 모두 선택해주세요.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],                           // 🟣 2: body 배경색 적용
      appBar: AppBar(
        title: const Text(
          '기차 예매',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold), // 🟣 1: 앱바 타이틀 스타일
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 1,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),                        // 🟣 전체 padding 20
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, //❤️
          children: [
            const SizedBox(height: 20),
            Container(
              height: 200,                                        // 🟣 3: 박스 높이
              decoration: BoxDecoration(
                color: Colors.white,                             // 🟣 박스 배경색
                borderRadius: BorderRadius.circular(20),         // 🟣 모서리 둥글기
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
                              fontSize: 16,                          // 🟣 4: 레이블 폰트 크기
                              fontWeight: FontWeight.bold,
                              color: Colors.grey,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            departureStation ?? '선택',
                            style: const TextStyle(
                              fontSize: 40,                          // 🟣 5: 선택 텍스트 크기
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  // 세로선
                  Container(
                    width: 2,
                    height: 50,
                    color: Colors.grey[400],                      // 🟣 6: 구분선 색상
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
                              fontSize: 16,                          // 🟣 4
                              fontWeight: FontWeight.bold,
                              color: Colors.grey,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            arrivalStation ?? '선택',
                            style: const TextStyle(
                              fontSize: 40,                          // 🟣 5
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20), //❤️ 박스와 버튼 사이 간격
            SizedBox(
              width: double.infinity,
              height: 50,                                         // 버튼 높이 고정
              child: ElevatedButton(
                onPressed: (departureStation != null && arrivalStation != null)
                    ? _navigateToSeatPage
                    : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.purple,            // 🟣 7: 버튼 배경색
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),     // 🟣 버튼 둥글기
                  ),
                  textStyle: const TextStyle(
                    fontSize: 18,                                // 🟣 버튼 글자 크기
                    fontWeight: FontWeight.bold,                 // 🟣 버튼 글자 굵기
                  ),
                ),
                child: const Text(
                  '좌석 선택',
                  style: TextStyle(color: Colors.white),         // 🟣 버튼 글자 색
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
