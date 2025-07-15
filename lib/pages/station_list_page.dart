import 'package:flutter/material.dart';

class SeatPage extends StatefulWidget {
  final String departure;
  final String arrival;

  const SeatPage({super.key, required this.departure, required this.arrival}); // 🟣 ① 출발역/도착역 전달 받음

  @override
  State<SeatPage> createState() => _SeatPageState();
}

class _SeatPageState extends State<SeatPage> {
  int? selectedIndex; // 🟣 ② 선택된 좌석 index (null이면 선택 안됨)
  final List<String> columns = ['A', 'B', 'C', 'D']; // 열 라벨

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('좌석 선택'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context), // 🟣 ③ 뒤로가기 버튼
        ),
      ),
      body: Column(
        children: [
          const SizedBox(height: 16),
          Row( // 🟣 ④ 출발역, 도착역 텍스트 표시
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                widget.departure,
                style: const TextStyle(fontSize: 20, color: Colors.deepPurple),
              ),
              Text(
                widget.arrival,
                style: const TextStyle(fontSize: 20, color: Colors.deepPurple),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row( // 🟣 ⑤ 안내 라벨
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon(Icons.square, color: Colors.grey, size: 16),
              SizedBox(width: 4),
              Text('미선택'),
              SizedBox(width: 16),
              Icon(Icons.square, color: Colors.deepPurple, size: 16),
              SizedBox(width: 4),
              Text('선택됨'),
            ],
          ),
          const SizedBox(height: 12),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: GridView.builder(
                itemCount: 20, // 🟣 ⑥ 총 20개 좌석
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4, // 열 4개
                  mainAxisSpacing: 8,
                  crossAxisSpacing: 8,
                ),
                itemBuilder: (context, index) {
                  final isSelected = index == selectedIndex;
                  final row = (index ~/ 4) + 1; // 1~5
                  final col = columns[index % 4]; // A~D

                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedIndex = index; // 🟣 ⑦ 좌석 선택 로직: index 저장
                      });
                    },
                    child: Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: isSelected ? Colors.deepPurple : Colors.grey[300], // 🟣 ⑧ 색상 조건 처리
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text('$row-$col',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: selectedIndex == null ? null : () => _showConfirmationDialog(context), // 🟣 ⑨ 선택된 좌석이 있을 때만 활성화
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurple,
                foregroundColor: Colors.white,
                minimumSize: const Size.fromHeight(48),
              ),
              child: const Text('예매 하기'),
            ),
          ),
        ],
      ),
    );
  }

  void _showConfirmationDialog(BuildContext context) {
    final row = (selectedIndex! ~/ 4) + 1;
    final col = columns[selectedIndex! % 4];
    final seat = '$row-$col'; // 🟣 ⑩ 선택된 좌석 정보 가공

    showCupertinoDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('예매 하시겠습니까?'),
        content: Text('좌석: $seat'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context), // 🟣 ⑪ 취소 시 Dialog 닫기만
            child: const Text('취소'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context); // 다이얼로그 닫기
              Navigator.pop(context); // SeatPage pop
              Navigator.pop(context); // HomePage pop (두 번)
            },
            child: const Text('확인'),
          ),
        ],
      ),
    );
  }
}
