import 'package:flutter/material.dart';
// 페이지 import
import 'package:flutter_train_app/pages/home_page.dart';


void main() {
  runApp(const TrainApp());
}

// 앱의 루트 위젯
class TrainApp extends StatelessWidget {
  const TrainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '기차 예매 앱',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: const HomePage(), // 첫 화면으로 HomePage 연결
      debugShowCheckedModeBanner: false, // 오른쪽 상단 debug 배너 제거
    );
  }
}
