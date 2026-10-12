import 'package:flutter/material.dart';
import 'core/app_theme.dart';
import 'features/events/views/home_screen.dart';
import 'features/events/view_models/events_view_model.dart';
import 'features/events/data/event_repository.dart';

void main() => runApp(const CampusEventsApp());

class CampusEventsApp extends StatefulWidget {
  const CampusEventsApp({super.key});
  @override
  State<CampusEventsApp> createState() => _CampusEventsAppState();
}

class _CampusEventsAppState extends State<CampusEventsApp> {
  late final model = EventsViewModel(const MockEventRepository());
  @override
  void dispose() {
    model.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) => MaterialApp(
    title: 'Campus Events', debugShowCheckedModeBanner: false,
    theme: AppTheme.light, home: HomeScreen(model: model));
}
