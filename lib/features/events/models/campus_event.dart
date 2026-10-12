enum EventStatus { registered, open, closed }

class CampusEvent {
  const CampusEvent({required this.id, required this.title, required this.date,
    required this.venue, required this.image, required this.status, this.time});
  final String id, title, date, venue, image;
  final String? time;
  final EventStatus status;
  String get statusLabel => switch(status) {
    EventStatus.registered => 'Registered',
    EventStatus.open => 'Registration Open',
    EventStatus.closed => 'Registration Closed',
  };
}
