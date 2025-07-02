import 'package:economy_summary/viewmodels/index_viewmodel.dart';
import 'package:economy_summary/views/currency_view.dart';
import 'package:economy_summary/views/news_view.dart';
import 'package:economy_summary/views/stock_view.dart';
import 'package:flutter/material.dart';
import 'package:economy_summary/views/crypto_view.dart';
import 'package:economy_summary/views/home_view.dart';
import 'package:intl/intl.dart';
import 'dart:async';
import 'package:marquee/marquee.dart';
import 'package:provider/provider.dart';

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
            Container(
              width: double.infinity,
              height: 50,
              margin: const EdgeInsets.only(bottom: 20),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.blueAccent,
                borderRadius: BorderRadius.circular(10),
              ),
              child: const HeadLineCarousel(), // HeadLineCarousel 위젯을 여기에 추가
            ),
            Container(
              width: double.infinity,
              height: 50,
              margin: const EdgeInsets.only(bottom: 20),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                border: Border.symmetric(
                  horizontal: BorderSide(color: Colors.grey, width: 1.0),
                ),
              ),
              child: const ScrollingHeadline(), // ScrollingHeadline 위젯을 여기에 추가
            ),
            sectionBox(_homeKey, width,),
            sectionBox(_coinKey, width,),
            sectionBox(_stockKey, width,),
            sectionBox(_newsKey, width,),
            sectionBox(_currencyKey, width,),
          ],
        ),
      ),
    );
  }

  Widget sectionBox(GlobalKey key, double width) {
    return Container(
      key: key,
      width: double.infinity ,
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(

        border: Border.all(color: Colors.grey, width: 1.0),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Center(
        child: Column(
          children: [

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



class ScrollingHeadline extends StatefulWidget {
  const ScrollingHeadline({super.key});

  @override
  State<ScrollingHeadline> createState() => _ScrollingHeadlineState();
}

class _ScrollingHeadlineState extends State<ScrollingHeadline> {

  @override
  void initState() {
    super.initState();
    Future.microtask(() => context.read<IndexViewModel>().fetchIndex());
    //환율정보 초기화 (viewmodel 에서 fetchRates 호출)
  }
  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<IndexViewModel>();
    return SizedBox(
      height: 50,
      child: viewModel.isLoading
      ? Center(child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2.0,))
      : viewModel.indexs.length < 5
      ? Center(child: Text('데이터를 불러오는 중 입니다'))
      : Marquee(
        text: '나스닥 : ${viewModel.indexs[0].price} ${viewModel.indexs[0].changePercent}%         '
            '다우존스 : ${viewModel.indexs[1].price} ${viewModel.indexs[1].changePercent}%         '
            'S&P 500 : ${viewModel.indexs[2].price} ${viewModel.indexs[2].changePercent}%         '
            '코스피 : ${viewModel.indexs[3].price} ${viewModel.indexs[3].changePercent}%         '
            '코스닥 : ${viewModel.indexs[4].price} ${viewModel.indexs[4].changePercent}%         ',
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
        scrollAxis: Axis.horizontal,
        velocity: 50.0,
        pauseAfterRound: Duration(seconds: 1),
        startPadding: 10.0,
        decelerationDuration: Duration(milliseconds: 500),
        decelerationCurve: Curves.easeOut,
      ),
    );
  }
}


class HeadLineCarousel extends StatefulWidget {
  const HeadLineCarousel({super.key});

  @override
  State<HeadLineCarousel> createState() => _HeadLineCarouselState();
}

class _HeadLineCarouselState extends State<HeadLineCarousel> {

  final PageController _controller = PageController();
  final List<String> _headlines = [
    'Headline 1: Breaking News!',
    'Headline 2: Market Update',
    'Headline 3: Weather Alert',
    'Headline 4: Sports Highlights',
    'Headline 5: Technology Advances',
  ];
  int _currentIndex = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 2), (timer) {
      if (_currentIndex < _headlines.length - 1) {
        _currentIndex++;
      } else {
        _currentIndex = 0;
      }
      _controller.animateToPage(
        _currentIndex,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      controller: _controller,
      physics: const NeverScrollableScrollPhysics(), // 자동만, 스와이프 금지
      itemCount: _headlines.length,
      itemBuilder: (context, index) {
        return Center(
          child: Text(
            _headlines[index],
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        );
      },
    );
  }
}
