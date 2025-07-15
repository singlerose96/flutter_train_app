import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class SeatPage extends StatefulWidget {
  final String departure;
  final String arrival;

  const SeatPage({
    super.key,
    required this.departure,
    required this.arrival,
  });

  @override
  State<SeatPage> createState() => _SeatPageState();
}

class _SeatPageState extends State<SeatPage> {
  int? selectedIndex;
  final List<String> columns = ['A', 'B', 'C', 'D'];

  static const double seatSize = 50.0; // 🟣 좌석 크기 변경: 60 → 50

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('좌석 선택'), // 앱바 타이틀: 별도 스타일 지정 없음
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 1,
      ),
      body: Column(
        children: [
          const SizedBox(height: 16),
          // 출발역 · 화살표 · 도착역
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                widget.departure,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,      // 🟣 두께 bold
                  color: Colors.purple,              // 🟣 색상 purple
                  fontSize: 30,                      // 🟣 크기 30
                ),
              ),
              const SizedBox(width: 8),
              const Icon(
                Icons.arrow_circle_right_outlined, // 🟣 아이콘 변경
                size: 30,                          // 🟣 크기 30
                color: Colors.purple,              // 🟣 색상 purple
              ),
              const SizedBox(width: 8),
              Text(
                widget.arrival,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,      // 🟣
                  color: Colors.purple,              // 🟣
                  fontSize: 30,                      // 🟣
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          // 좌석 상태 안내
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 24,                         // 🟣 너비 24
                height: 24,                        // 🟣 높이 24
                decoration: BoxDecoration(
                  color: Colors.purple,           // 🟣 선택됨 색상
                  borderRadius: BorderRadius.circular(8), // 🟣 둥글기 8
                ),
              ),
              const SizedBox(width: 4),          // 🟣 박스-텍스트 간격 4
              const Text('선택됨'),
              const SizedBox(width: 20),         // 🟣 선택됨-미선택 간격 20
              Container(
                width: 24,                         // 🟣 너비 24
                height: 24,                        // 🟣 높이 24
                decoration: BoxDecoration(
                  color: Colors.grey[300],        // 🟣 미선택 색상
                  borderRadius: BorderRadius.circular(8), // 🟣 둥글기 8
                ),
              ),
              const SizedBox(width: 4),          // 🟣 박스-텍스트 간격 4
              const Text('미선택'),
            ],
          ),
          // 스크롤 영역: ABCD 레이블 + 20행 좌석
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20), // 🟣 위아래 패딩 20
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    // ABCD 레이블
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: seatSize,               // 🟣 레이블 컨테이너 50×50
                          height: seatSize,
                          alignment: Alignment.center,
                          child: const Text(
                            'A',
                            style: TextStyle(fontSize: 18), // 🟣 글자 크기 18
                          ),
                        ),
                        Container(
                          width: seatSize,
                          height: seatSize,
                          alignment: Alignment.center,
                          child: const Text(
                            'B',
                            style: TextStyle(fontSize: 18), // 🟣
                          ),
                        ),
                        SizedBox(width: seatSize),         // 🟣 통로 폭 50
                        Container(
                          width: seatSize,
                          height: seatSize,
                          alignment: Alignment.center,
                          child: const Text(
                            'C',
                            style: TextStyle(fontSize: 18), // 🟣
                          ),
                        ),
                        Container(
                          width: seatSize,
                          height: seatSize,
                          alignment: Alignment.center,
                          child: const Text(
                            'D',
                            style: TextStyle(fontSize: 18), // 🟣
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    // 20개 행 좌석
                    Column(
                      children: List.generate(20, (row) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4), // 🟣 세로 간격 총 8
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              _seatBox(row * 4),     // 🟣 좌석 위젯 50×50
                              _seatBox(row * 4 + 1), // 🟣
                              Container(
                                width: seatSize,                 // 🟣 행번호 컨테이너 50×50
                                height: seatSize,
                                alignment: Alignment.center,
                                child: Text(
                                  '${row + 1}',
                                  style: const TextStyle(fontSize: 18), // 🟣 글자 크기 18
                                ),
                              ),
                              _seatBox(row * 4 + 2), // 🟣
                              _seatBox(row * 4 + 3), // 🟣
                            ],
                          ),
                        );
                      }),
                    ),
                  ],
                ),
              ),
            ),
          ),
                   Padding(
            padding: const EdgeInsets.all(16.0),
            child: SizedBox(                                 // 🔴 home_page 버튼과 동일한 크기/모양 적용
              width: double.infinity,                       // 🔴
              height: 50,                                   // 🔴
              child: ElevatedButton(
                onPressed: selectedIndex == null
                    ? null
                    : () => _showConfirmationDialog(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.purple,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  textStyle: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                child: const Text(
                  '예매 하기',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }


  Widget _seatBox(int index) {
    final isSelected = selectedIndex == index;
    return GestureDetector(
      onTap: () => setState(() => selectedIndex = index),
      child: Container(
        width: seatSize,                    // 🟣 너비 50
        height: seatSize,                   // 🟣 높이 50
        margin: const EdgeInsets.symmetric(horizontal: 2), // 🟣 가로 간격 4
        decoration: BoxDecoration(
          color: isSelected ? Colors.purple : Colors.grey[300], // 🟣 색상
          borderRadius: BorderRadius.circular(8),               // 🟣 둥글기 8
        ),
      ),
    );
  }

  void _showConfirmationDialog(BuildContext context) {
    final row = (selectedIndex! ~/ 4) + 1;
    final col = columns[selectedIndex! % 4];
    final seat = '$row-$col';

    showCupertinoDialog(
      context: context,
      builder: (_) => CupertinoAlertDialog( //💚
        title: const Text('예매 하시겠습니까?'),
        content: Text('좌석: $seat'),
        actions: [
          CupertinoDialogAction(
         onPressed: () => Navigator.pop(context),
         // 🟢 isDestructiveAction 대신 직접 스타일 지정
         child: const Text(
           '취소',
           style: TextStyle(color: CupertinoColors.destructiveRed),
        ),
      ),

          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.popUntil(context, (route) => route.isFirst);
            },
            child: const Text(
              '확인',
              style: TextStyle(color: CupertinoColors.activeBlue),),
          ),
        ],
      ),
    );
  }
}
