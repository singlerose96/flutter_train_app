import 'package:flutter/material.dart';

class StationListPage extends StatelessWidget {
  final bool isDeparture;
  StationListPage({super.key, required this.isDeparture});

  final List<String> stations = [
    '경주', '김천구미', '대전', '동대구', '동탄',
    '부산', '수서', '울산', '오송', '천안아산', '평택지제'
  ];

  @override
  Widget build(BuildContext context) {
    stations.sort();

    return Scaffold(
      appBar: AppBar(
        title: Text(isDeparture ? '출발역' : '도착역'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: ListView.separated(
        itemCount: stations.length,
        separatorBuilder: (_, __) => const Divider(),
        itemBuilder: (context, index) {
          final station = stations[index];
          return ListTile(
            title: Text(station),
            onTap: () => Navigator.pop(context, station),
          );
        },
      ),
    );
  }
}
