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
        title: Text(isDeparture ? '출발역' : '도착역'), // 🟣 앱바 타이틀: 별도 스타일 지정 없음
        // 🟣 leading 제거: AppBar 기본 뒤로가기 버튼 사용
      ),
      body: ListView.builder(
        itemCount: stations.length,
        itemBuilder: (context, index) {
          final station = stations[index];
          return InkWell(
            onTap: () => Navigator.pop(context, station), // 🟣 클릭 시 선택값 반환
            child: Container(
              height: 50, // 🟣 리스트 항목 높이 50
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: Colors.grey[300]!), // 🟣 아래 테두리만
                ),
              ),
              child: Text(
                station,
                style: const TextStyle(
                  fontSize: 18, // 🟣 글자 크기 18
                  fontWeight: FontWeight.bold, // 🟣 글자 두께 bold
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
