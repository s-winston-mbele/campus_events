import '../models/campus_event.dart';

abstract interface class EventRepository {
  List<CampusEvent> getEvents();
}
class MockEventRepository implements EventRepository {
  const MockEventRepository();
  @override
  List<CampusEvent> getEvents() => const [
    CampusEvent(id: 'aws', title: 'AWS SGB Event', date: '18 Oct 2026', time: '10:00', venue: 'Main Auditorium', image: 'aws', status: EventStatus.registered),
    CampusEvent(id: 'leadership', title: 'School Leadership Summit', date: '24 Oct 2026', time: '09:30', venue: 'Conference Hall', image: 'leadership', status: EventStatus.registered),
    CampusEvent(id: 'innovation', title: 'Innovation Day', date: '29 Oct 2026', venue: 'Student Centre', image: 'innovation', status: EventStatus.open),
    CampusEvent(id: 'expo', title: 'Final Year Expo', date: '02 Nov 2026', venue: 'ICT Building', image: 'expo', status: EventStatus.closed),
    CampusEvent(id: 'sports', title: 'Campus Sports Welcome', date: '05 Nov 2026', venue: 'Sports Grounds', image: 'sports', status: EventStatus.open),
  ];
}
