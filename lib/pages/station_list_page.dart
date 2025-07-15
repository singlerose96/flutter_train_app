import 'package:flutter/material.dart';

class StationListPage extends StatelessWidget {
  final bool isDeparture; // 🟣 출발역인지 도착역인지 구분
  final List<String> stations = const [
    '수서', '동탄', '평택지제', '천안아산', '오송',
    '대전', '김천구미', '동대구', '경주', '울산', '부산',
  ]; // 🟣 고정된 기차역 리스트 

  const StationListPage({super.key, required this.isDeparture}); // 🟣 생성자에 isDeparture 전달 요구

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(isDeparture ? '출발역' : '도착역'), // 🟣 앱바 타이틀: 출발역/도착역 조건부 출력
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context); // 🟣 뒤로가기 버튼 > 아무런 값도 넘기지 않고 pop
          },
        ),
      ),
      body: ListView.builder(
        itemCount: stations.length,
        itemBuilder: (context, index) {
          final station = stations[index];
          return ListTile(
            title: Text(station),
            onTap: () {
              Navigator.pop(context, station); // 🟣 기차역 아이템 클릭 시 > 해당 역 이름을 반환하면서 pop
            },
          );
        },
      ),
    );
  }
}
