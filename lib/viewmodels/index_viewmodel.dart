import 'package:flutter/material.dart';
import '../models/index_model.dart';
import '../services/index_service.dart';

class IndexViewModel extends ChangeNotifier {
  final IndexService _service = IndexService();

  List<MarketIndex> _indexs = [];
  List<MarketIndex> get indexs => _indexs;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _error;
  String? get error => _error;

  Future<void> fetchIndex() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _indexs = await _service.fetchIndex();
    } catch (e) {
      _error = e.toString();
      print('Error fetching Index rates: $_error');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
