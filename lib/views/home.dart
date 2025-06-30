import 'package:economy_summary/views/currency_view.dart';
import 'package:economy_summary/views/news_view.dart';
import 'package:economy_summary/views/stock_view.dart';
import 'package:flutter/material.dart';
import 'package:economy_summary/views/crypto_view.dart';
import 'package:economy_summary/views/home_view.dart';
import 'package:intl/intl.dart';
import 'dart:async';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final ScrollController _scrollController = ScrollController();

  final GlobalKey _homeKey = GlobalKey();
  final GlobalKey _coinKey = GlobalKey();
  final GlobalKey _stockKey = GlobalKey();
  final GlobalKey _newsKey = GlobalKey();
  final GlobalKey _currencyKey = GlobalKey();

  void _scrollTo(GlobalKey key) {
    final context = key.currentContext;
    if (context != null) {
      Scrollable.ensureVisible(
        context,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
        alignment: 0,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Economy Summary'),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        scrolledUnderElevation: 0.0,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(50),
          child: Column(
            children: [
              LiveClock(),
              Container(
                width: width* 0.9,
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                        onPressed: () => _scrollTo(_homeKey),
                        child: const Text('홈')),
                    SizedBox(width: 10), // 간격을 위한 SizedBox
                    ElevatedButton(
                        onPressed: () => _scrollTo(_coinKey),
                        child: const Text('코인')),
                    SizedBox(width: 10),
                    ElevatedButton(
                        onPressed: () => _scrollTo(_stockKey),
                        child: const Text('주식')),
                    SizedBox(width: 10),
                    ElevatedButton(
                        onPressed: () => _scrollTo(_newsKey),
                        child: const Text('뉴스')),
                    SizedBox(width: 10),
                    ElevatedButton(
                        onPressed: () => _scrollTo(_currencyKey),
                        child: const Text('환율')),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        controller: _scrollController,
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            sectionBox(_homeKey, width, Colors.orangeAccent, '여기에 홈이 들어갑니다.'),
            sectionBox(_coinKey, width, Colors.blueGrey, '여기에 코인차트가 들어갑니다.'),
            sectionBox(_stockKey, width, Colors.lightBlueAccent, '여기에 주식차트가 들어갑니다.'),
            sectionBox(_newsKey, width, Colors.greenAccent, '여기에 뉴스가 들어갑니다.'),
            sectionBox(_currencyKey, width, Colors.purpleAccent, '여기에 환율이 들어갑니다.'),
          ],
        ),
      ),
    );
  }

  Widget sectionBox(GlobalKey key, double width, Color color, String text) {
    return Container(
      key: key,
      width: double.infinity ,
      height: 500,
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Center(
        child: Column(
          children: [
            Text(text,
                style: const TextStyle(fontSize: 18, color: Colors.white)),
            SizedBox(height: 20),
            if (key == _homeKey)
               Home(), // CryptoView 위젯을 여기에 추가
            if (key == _coinKey)
              const CryptoView(), // CryptoView 위젯을 여기에 추가
            if (key == _stockKey)
              const StockView(),
            if (key == _newsKey)
              const NewsView(), // NewsView 위젯을 여기에 추가
            if (key == _currencyKey)
              const CurrencyView(), // CurrencyView 위젯을 여기에 추가
          ],
        ),
      ),
    );
  }
}


class LiveClock extends StatefulWidget {
  const LiveClock({super.key});

  @override
  State<LiveClock> createState() => _LiveClockState();
}

class _LiveClockState extends State<LiveClock> {
  late String _time;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _updateTime();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      _updateTime();
    });
  }
  void _updateTime() {
    final now = DateTime.now();
    final formatted = DateFormat('yyyy-MM-dd HH:mm:ss').format(now);
    setState(() {
      _time = formatted;
    });
  }


  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      '$_time',
      style: const TextStyle(fontSize: 18),
    );
  }
}
