import 'package:flutter_test/flutter_test.dart';
import 'package:campus_events/features/events/data/event_repository.dart';
import 'package:campus_events/features/events/view_models/events_view_model.dart';

void main() {
  test('Search matches titles and venues regardless of case and whitespace', () {
    final model = EventsViewModel(const MockEventRepository());
    addTearDown(model.dispose);
    expect(model.registered.length, 2);
    expect(model.upcoming.length, 3);
    model.search('  AUDITORIUM ');
    expect(model.events.single.id, 'aws');
    model.search('innovation');
    expect(model.registered, isEmpty);
    expect(model.upcoming.single.id, 'innovation');
    model.search('');
    expect(model.events.length, 5);
  });
}
