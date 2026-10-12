import 'package:flutter/foundation.dart';
import '../data/event_repository.dart';
import '../models/campus_event.dart';

class EventsViewModel extends ChangeNotifier {
  EventsViewModel(EventRepository repository)
    : _events = List.unmodifiable(repository.getEvents());
  final List<CampusEvent> _events;
  String _query = '';
  int _tab = 0;
  int get tab => _tab;
  String get query => _query;
  List<CampusEvent> get events => List.unmodifiable(_events.where((e) =>
    ('${e.title} ${e.venue}').toLowerCase().contains(_query)));
  List<CampusEvent> get registered => events.where(
    (e) => e.status == EventStatus.registered).toList(growable: false);
  List<CampusEvent> get upcoming => events.where(
    (e) => e.status != EventStatus.registered).toList(growable: false);
  void search(String value) {
    _query = value.trim().toLowerCase();
    notifyListeners();
  }
  void selectTab(int value) {
    if (_tab == value) return;
    _tab = value;
    notifyListeners();
  }
}
