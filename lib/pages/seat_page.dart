import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SeatPage extends StatefulWidget {
  final String departureStation;
  final String arrivalStation;

  const SeatPage({
    super.key,
    required this.departureStation,
    required this.arrivalStation,
  });

  @override
  State<SeatPage> createState() => _SeatPageState();
}

class _SeatPageState extends State<SeatPage> {
  int? selectedSeat;

  void _selectSeat(int index) {
    setState(() {
      selectedSeat = index;
    });
  }

  void _showReservationDialog() {
    showCupertinoDialog(
      context: context,
      builder: (context) => CupertinoAlertDialog(
        title: const Text('예매하시겠습니까?'),
        content: Text('좌석: ${selectedSeat! + 1}번'),
        actions: [
          CupertinoDialogAction(
            child: const Text('취소'),
            onPressed: () => Navigator.pop(context),
          ),
          CupertinoDialogAction(
            child: const Text('확인'),
            onPressed: () {
              Navigator.pop(context); // 다이얼로그 종료
              Navigator.popUntil(context, (route) => route.isFirst); // 홈으로 이동
            },
          ),
        ],
      ),
    );
  }

  Widget _buildSeat(int index) {
    final isSelected = selectedSeat == index;
    final seatColor = isSelected ? Colors.purple : Colors.grey[300];

    return GestureDetector(
      onTap: () => _selectSeat(index),
      child: Container(
        margin: const EdgeInsets.all(4),
        width: 60,
        height: 60,
        decoration: BoxDecoration(
          color: seatColor,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(child: Text('${index + 1}')),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('좌석 선택')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text('출발역: ${widget.departureStation}'),
            Text('도착역: ${widget.arrivalStation}'),
            const SizedBox(height: 16),
            const SizedBox(height: 16),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: List.generate(20, (index) => _buildSeat(index)),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: selectedSeat != null ? _showReservationDialog : null,
              child: const Text('예매하기'),
            )
          ],
        ),
      ),
    );
  }
}
