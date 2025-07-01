import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:economy_summary/models/stock_model.dart';

class StockService {
  final String apiUrl = 'http://localhost:3000/stock?';


  Future<List<Stock>> fetchStock() async {
    final response = await http.get(Uri.parse(apiUrl));
    if (response.statusCode == 200) {
      final List<dynamic> jsonData = jsonDecode(response.body);
      return jsonData.map((item) => Stock.fromJson(item)).toList();
    } else {
      throw Exception('주식 정보를 불러오지 못했습니다.');
    }
  }
}
