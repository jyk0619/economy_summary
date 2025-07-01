import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:economy_summary/models/currency_model.dart';

class CurrencyService {
  final String apiUrl = 'http://localhost:3000/exchange?';


  Future<List<Currency>> fetchExchangeRates() async {
    final response = await http.get(Uri.parse(apiUrl));
    if (response.statusCode == 200) {
      final List<dynamic> jsonData = jsonDecode(response.body);
      return jsonData.map((item) => Currency.fromJson(item)).toList();
    } else {
      throw Exception('환율 정보를 불러오지 못했습니다.');
    }
  }
}
