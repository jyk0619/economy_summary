import'package:flutter/material.dart';

class NewsView extends StatelessWidget {
  const NewsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            '뉴스 정보',
            style: Theme.of(context).textTheme.headline4,
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              // 여기에 뉴스 정보 조회 로직을 추가하세요.
            },
            child: Text('뉴스 정보 조회'),
          ),
        ],
    ),
    );
  }
}

