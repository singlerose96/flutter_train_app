import 'package:flutter/material.dart';

class StationListPage extends StatefulWidget {
  final bool isDeparture; // true면 출발역 선택, false면 도착역 선택

  const StationListPage({Key? key, required this.isDeparture}) : super(key: key);

  @override
  State<StationListPage> createState() => _StationListPageState();
}

class _StationListPageState extends State<StationListPage> {
  // 선택된 역
  String? selectedStation;

  // 고정된 역 리스트 (가나다 순 정렬)
  final List<String> stationList = [
    '경주', '김천구미', '대전', '동대구', '동탄',
    '부산', '수서', '울산', '오송', '천안아산', '평택지제',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // isDeparture 값에 따라 앱바 타이틀 다르게 출력
        title: Text(widget.isDeparture ? '출발역' : '도착역'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context), // 뒤로가기
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: stationList.length,
              itemBuilder: (context, index) {
                final station = stationList[index];
                final isSelected = station == selectedStation;

                return ListTile(
                  title: Text(
                    station,
                    style: TextStyle(
                      fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                      color: isSelected ? Colors.purple : Colors.black,
                    ),
                  ),
                  trailing: isSelected
                      ? const Icon(Icons.check, color: Colors.purple)
                      : null,
                  onTap: () {
                    // 역 이름 선택 시 selectedStation 업데이트
                    setState(() {
                      selectedStation = station;
                    });
                  },
                );
              },
            ),
          ),

          // 확인 버튼
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: selectedStation == null
                  ? null // 선택 안했으면 비활성화
                  : () {
                      Navigator.pop(context, selectedStation); // 선택값 반환
                    },
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 50),
              ),
              child: const Text('확인'),
            ),
          )
        ],
      ),
    );
  }
}
