
import 'package:economy_summary/viewmodels/stock_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fl_chart/fl_chart.dart';

class Home extends StatelessWidget {
   Home({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<StockViewModel>();
    return Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              child: Text(
                '경제 요약',
                style: Theme.of(context).textTheme.titleMedium,
                textAlign: TextAlign.center,
              ),
            ),
            ElevatedButton(onPressed: (){
              viewModel.fetchStock();
            },
                child: Text('차트 데이터 조회')),
            Text(
              viewModel.isLoading ? '로딩중...' : '주식 데이터가 ${viewModel.stocks.length}개 조회되었습니다. ${viewModel.error ?? ''}',
              style: Theme.of(context).textTheme.bodyMedium,
            ),

            Container(
              height: 200,
              child: viewModel.stocks.isNotEmpty
                  ? ListView.builder(
                    itemCount: viewModel.stocks.length,
                    itemBuilder: (context, index) {
                      final stock = viewModel.stocks[index];
                      return ListTile(
                        title: Text(stock.symbol),
                        subtitle: Text('현재가: '),
                        trailing: Text('변동률: %'),
                      );
                    },
                  )
                  : const SizedBox.shrink(),
            ),

            Container(
              decoration:BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.grey, width: 1.0),
              ),

              child: Wrap(
                children: [
                  ChartCard(),
                  ChartCard(),
                  ChartCard(),
                  ChartCard(),
                ],
              )
            ),

            Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.grey, width: 1.0),
                ),

                child:Wrap(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      child: Text(
                        '환율 1',
                        style: Theme.of(context).textTheme.titleSmall,
                        textAlign: TextAlign.center,
                      ),
                    ),

                    Container(
                      padding: EdgeInsets.all(8),
                      child: Text(
                        '환율 2',
                        style: Theme.of(context).textTheme.titleSmall,
                        textAlign: TextAlign.center,
                      ),
                    )
                  ],
                )
            ),
          ],
        )
    );
  }
}

class ChartCard extends StatefulWidget {
  const ChartCard({super.key});

  @override
  State<ChartCard> createState() => _ChartCardState();
}

class _ChartCardState extends State<ChartCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.grey, width: 1.0),
            ),

            child: Column(
              children: [
                Text(
                  '종목이름',
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                Text('현재가',
                  style: Theme.of(context).textTheme.displayMedium,
                ),
                Container(
                  height: 100,
                  width: double.infinity,
                  color: Colors.blue, // 차트 영역을 나타내는 색상
                  child: Center(
                    child: Text(
                      '차트 영역',
                      style: Theme.of(context).textTheme.displayMedium,
                    ),
                  ),
                ),
                Text('변동률',
                  style: Theme.of(context).textTheme.displayMedium?.copyWith(
                    color: Colors.red,) // 변동률을 강조하기 위한 색상,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
