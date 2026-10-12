import 'package:flutter/material.dart';
import '../../../core/app_theme.dart';
import '../models/campus_event.dart';
import '../view_models/events_view_model.dart';
import '../widgets/event_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key, required this.model});
  final EventsViewModel model;

  void _details(BuildContext context, CampusEvent event) {
    showModalBottomSheet<void>(
      context: context, showDragHandle: true, isScrollControlled: true,
      builder: (context) => SafeArea(child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
        child: Column(mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start, children: [
          ClipRRect(borderRadius: BorderRadius.circular(18),
            child: Image.asset('assets/images/${event.image}.png',
              height: 170, width: double.infinity, fit: BoxFit.cover)),
          const SizedBox(height: 20),
          Text(event.title, style: Theme.of(context).textTheme.headlineSmall),
          const SizedBox(height: 12),
          Text(event.date + (event.time == null ? '' : ' • ${event.time!}')),
          Text(event.venue), const SizedBox(height: 12),
          Text(event.statusLabel), const SizedBox(height: 20),
          if (event.status == EventStatus.registered)
            const Center(child: Column(children: [
              Icon(Icons.qr_code_2, size: 140, color: AppTheme.teal),
              Text('QR preview — not a valid entry code'),
              SizedBox(height: 12),
              Text('Scan the venue QR code upon entry to confirm attendance.',
                textAlign: TextAlign.center),
            ]))
          else const Text('Registration is a UI demo. No registration is submitted.'),
          const SizedBox(height: 20),
          SizedBox(width: double.infinity, child: FilledButton(
            onPressed: () => Navigator.pop(context), child: const Text('Done'))),
        ]))));
  }

  List<Widget> _cards(BuildContext context, List<CampusEvent> events) =>
    events.isEmpty
      ? [const Padding(padding: EdgeInsets.all(24),
          child: Text('No matching events. Try another search.'))]
      : events.map((e) => EventCard(
          event: e, onAction: () => _details(context, e))).toList();

  Widget _content(BuildContext context) {
    if (model.tab == 2) {
      return const _Placeholder(icon: Icons.qr_code_scanner, title: 'Check-In',
        message: 'Scan the venue QR code upon entry. Camera scanning is not connected in this UI demo.');
    }
    if (model.tab == 3) {
      return const _Placeholder(icon: Icons.person_outline, title: 'Winston',
        message: 'Student profile • UI preview');
    }
    return ListView(padding: const EdgeInsets.fromLTRB(20, 24, 20, 20), children: [
      Row(children: [
        Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Text('Hi, Winston', style: TextStyle(
            fontFamily: 'Display', fontSize: 32,
            fontWeight: FontWeight.w700, color: AppTheme.ink)),
          const SizedBox(height: 4),
          Text('Ready for your next campus event?',
            style: Theme.of(context).textTheme.bodyMedium),
        ])),
        IconButton(onPressed: () => model.selectTab(3), tooltip: 'Profile',
          icon: const CircleAvatar(backgroundColor: Color(0xFFD6E9E0),
            child: Text('W', style: TextStyle(color: AppTheme.teal)))),
      ]),
      const SizedBox(height: 24),
      TextFormField(initialValue: model.query, onChanged: model.search,
        decoration: const InputDecoration(prefixIcon: Icon(Icons.search),
          hintText: 'Search events, topics or venues...')),
      const SizedBox(height: 24),
      if (model.tab == 0) ...[
        _Section(title: 'Registered Events', subtitle: 'Events you’re registered for',
          onViewAll: () => model.selectTab(1)),
        ..._cards(context, model.registered),
        const SizedBox(height: 14),
        _Section(title: 'Upcoming Events',
          subtitle: 'Discover and register for upcoming campus events',
          onViewAll: () => model.selectTab(1)),
        ..._cards(context, model.upcoming),
      ] else ...[
        Text('Events', style: Theme.of(context).textTheme.headlineSmall),
        const SizedBox(height: 16), ..._cards(context, model.events),
      ],
    ]);
  }

  @override
  Widget build(BuildContext context) => ListenableBuilder(
    listenable: model, builder: (context, _) => Scaffold(
      body: SafeArea(child: Center(child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 700), child: _content(context)))),
      bottomNavigationBar: NavigationBar(
        selectedIndex: model.tab, onDestinationSelected: model.selectTab,
        backgroundColor: Colors.white, indicatorColor: const Color(0xFFDCEFE8),
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home), label: 'Home'),
          NavigationDestination(icon: Icon(Icons.calendar_today_outlined), label: 'Events'),
          NavigationDestination(icon: Icon(Icons.qr_code_scanner), label: 'Check-In'),
          NavigationDestination(icon: Icon(Icons.person_outline), label: 'Profile'),
        ])));
}

class _Section extends StatelessWidget {
  const _Section({required this.title, required this.subtitle, required this.onViewAll});
  final String title, subtitle;
  final VoidCallback onViewAll;
  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.only(bottom: 14),
    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Row(children: [
        Expanded(child: Text(title, style: Theme.of(context).textTheme.headlineSmall)),
        TextButton(onPressed: onViewAll, child: const Text('View all  ›')),
      ]),
      Text(subtitle, style: Theme.of(context).textTheme.bodyMedium),
    ]));
}

class _Placeholder extends StatelessWidget {
  const _Placeholder({required this.icon, required this.title, required this.message});
  final IconData icon;
  final String title, message;
  @override
  Widget build(BuildContext context) => Center(child: SingleChildScrollView(
    padding: const EdgeInsets.all(32), child: Column(children: [
      Icon(icon, size: 80, color: AppTheme.teal), const SizedBox(height: 24),
      Text(title, style: Theme.of(context).textTheme.headlineSmall),
      const SizedBox(height: 12), Text(message, textAlign: TextAlign.center),
    ])));
}
