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

  static const double seatSize = 60.0; // 정사각형 좌석 크기

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('좌석 선택'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        children: [
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(widget.departure, style: const TextStyle(fontSize: 20, color: Colors.deepPurple)),
              const Icon(Icons.arrow_forward, color: Colors.deepPurple),
              Text(widget.arrival, style: const TextStyle(fontSize: 20, color: Colors.deepPurple)),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon(Icons.square, color: Colors.deepPurple, size: 16),
              SizedBox(width: 4),
              Text('선택됨'),
              SizedBox(width: 16),
              Icon(Icons.square, color: Colors.grey, size: 16),
              SizedBox(width: 4),
              Text('미선택'),
            ],
          ),
          const SizedBox(height: 12),
          _buildColumnLabels(), // 열 라벨 표시
          const SizedBox(height: 8),
          Expanded(child: _buildSeatRows()),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: selectedIndex == null ? null : () => _showConfirmationDialog(context),
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

  /// 열 라벨 표시 (A, B, C, D)
  Widget _buildColumnLabels() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _columnLabel('A'),
        _columnLabel('B'),
        const SizedBox(width: seatSize), // 통로
        _columnLabel('C'),
        _columnLabel('D'),
      ],
    );
  }

  Widget _columnLabel(String text) {
    return Container(
      width: seatSize,
      height: seatSize / 2,
      alignment: Alignment.center,
      child: Text(text, style: const TextStyle(fontWeight: FontWeight.bold)),
    );
  }

  /// 좌석 행 구성 (5행)
  Widget _buildSeatRows() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(5, (row) {
        final startIndex = row * 4;
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // A, B
            _seatBox(startIndex),
            _seatBox(startIndex + 1),
            // 행 번호 (중앙 통로)
            Container(
              width: seatSize,
              height: seatSize,
              alignment: Alignment.center,
              child: Text('${row + 1}', style: const TextStyle(fontWeight: FontWeight.bold)),
            ),
            // C, D
            _seatBox(startIndex + 2),
            _seatBox(startIndex + 3),
          ],
        );
      }),
    );
  }

  Widget _seatBox(int index) {
    final isSelected = selectedIndex == index;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedIndex = index;
        });
      },
      child: Container(
        width: seatSize,
        height: seatSize,
        margin: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: isSelected ? Colors.deepPurple : Colors.grey[300],
          borderRadius: BorderRadius.circular(8),
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
      builder: (_) => AlertDialog(
        title: const Text('예매 하시겠습니까?'),
        content: Text('좌석: $seat'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('취소'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context);
              Navigator.pop(context);
            },
            child: const Text('확인'),
          ),
        ],
      ),
    );
  }
}
