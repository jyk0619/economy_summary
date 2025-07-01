import 'package:flutter/material.dart';
import '../models/stock_model.dart';
import '../services/stock_service.dart';

class StockViewModel extends ChangeNotifier {
  final StockService _service = StockService();

  List<Stock> _stocks = [];
  List<Stock> get stocks => _stocks;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _error;
  String? get error => _error;

  Future<void> fetchStock() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _stocks = await _service.fetchStock();
    } catch (e) {
      _error = e.toString();
      print('Error fetching exchange rates: $_error');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
