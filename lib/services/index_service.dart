import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:economy_summary/models/index_model.dart';

class IndexService {
  final String apiUrl = 'http://localhost:3000/indexs';

  Future<List<MarketIndex>> fetchIndex() async {
    final response = await http.get(Uri.parse(apiUrl));
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      final List<dynamic> resultList = data['quoteResponse']['result'];
      return resultList.map((item) => MarketIndex.fromJson(item)).toList();
    } else {
      throw Exception('지수 정보를 불러오지 못했습니다.');
    }
  }

}
