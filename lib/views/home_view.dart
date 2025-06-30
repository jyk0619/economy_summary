import 'package:economy_summary/services/currency_service.dart';
import 'package:economy_summary/viewmodels/currency_viemodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {
   Home({super.key});
  @override
  Widget build(BuildContext context) {


    return Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              decoration:BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.orangeAccent,
                border: Border.all(color: Colors.grey, width: 1.0),
              ),
              height: 300,
              child: Text('여기에 홈 화면의 내용이 들어갑니다.',
                style: Theme.of(context).textTheme.headline4,
                textAlign: TextAlign.center,),
            ),
            Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.grey, width: 1.0),
                ),
                child:Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        child: Text(
                          '여기에 홈 화면의 내용이 들어갑니다. 1',
                          style: Theme.of(context).textTheme.headline6,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        child: Text(
                          '여기에 홈 화면의 내용이 들어갑니다.2',
                          style: Theme.of(context).textTheme.headline6,
                          textAlign: TextAlign.center,
                        ),
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

