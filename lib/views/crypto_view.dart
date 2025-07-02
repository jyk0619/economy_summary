import 'package:flutter/material.dart';

class CryptoView extends StatefulWidget {
  const CryptoView({super.key});

  @override
  State<CryptoView> createState() => _CryptoViewState();
}

class _CryptoViewState extends State<CryptoView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            '암호화폐 정보',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              // 여기에 암호화폐 정보 조회 로직을 추가하세요.
            },
            child: Text('암호화폐 정보 조회'),
          ),
        ],
      ),
    );
  }
}
