import 'package:flutter/material.dart';
import '../models/currency_model.dart';
import '../services/currency_service.dart';

class CurrencyViewModel extends ChangeNotifier {
  final CurrencyService _service = CurrencyService();

  List<Currency> _currencies = [];
  List<Currency> get currencies => _currencies;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _error;
  String? get error => _error;

  Future<void> fetchRates() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _currencies = await _service.fetchExchangeRates();
    } catch (e) {
      _error = e.toString();
      print('Error fetching exchange rates: $_error');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
