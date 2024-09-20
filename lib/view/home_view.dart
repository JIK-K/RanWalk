import 'package:flutter/material.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<StatefulWidget> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center( // Center 위젯으로 모든 내용을 중앙에 배치
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              color: Colors.white,
              width: 150,
              height: 150,
            ),
            SizedBox(height: 30),
            Text(
              'test TextTheme',
              style: Theme.of(context).textTheme.labelSmall,
              textAlign: TextAlign.center, // 텍스트 중앙 정렬
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/map');
              },
              child: Text("Go to Map"),
            ),
          ],
        ),
      ),
    );
  }
}
