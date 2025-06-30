import  'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/currency_viemodel.dart';



class CurrencyView extends StatelessWidget {
  const CurrencyView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
         Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.grey, width: 1.0),
            ),
            height: 300,
            child: CurrencyInfo(),
         ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              // 여기에 뉴스 정보 조회 로직을 추가하세요.
            },
            child: Text('환율 정보 조회'),
          ),
        ],
      ),
    );
  }
}




class CurrencyInfo extends StatefulWidget {
  CurrencyInfo({super.key});

  @override
  State<CurrencyInfo> createState() => _CurrencyInfoState();
}

class _CurrencyInfoState extends State<CurrencyInfo> {

  @override
  void initState() {
    super.initState();
    Future.microtask(() => context.read<CurrencyViewModel>().fetchRates());
    //환율정보 초기화 (viewmodel 에서 fetchRates 호출)
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<CurrencyViewModel>();

    return Padding(padding: const EdgeInsets.all(16.0),
      child: viewModel.isLoading
          ? const Center(child: CircularProgressIndicator())
          : viewModel.error != null
          ? Center(child: Text('에러: ${viewModel.error}'))
          : ListView.builder(
        itemCount: viewModel.currencies.length,
        itemBuilder: (context, index) {
          final currency = viewModel.currencies[index];
          return ListTile(
            title: Text(currency.unit),
            subtitle: Text('${currency.rate} 원'),
          );
        },
      ),
    );
  }
}
