import 'package:flutter/material.dart';
import '../../../core/app_theme.dart';
import '../models/campus_event.dart';

class EventCard extends StatelessWidget {
  const EventCard({super.key, required this.event, required this.onAction});
  final CampusEvent event;
  final VoidCallback onAction;
  @override
  Widget build(BuildContext context) => Container(
    margin: const EdgeInsets.only(bottom: 12),
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(color: Colors.white,
      borderRadius: BorderRadius.circular(22),
      boxShadow: const [BoxShadow(color: Color(0x080D1834),
        blurRadius: 18, offset: Offset(0, 7))]),
    child: LayoutBuilder(builder: (context, constraints) {
      final compact = constraints.maxWidth < 360 ||
        MediaQuery.textScalerOf(context).scale(1) > 1.2;
      final details = Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(event.title, style: Theme.of(context).textTheme.titleMedium),
        const SizedBox(height: 8),
        _Meta(Icons.calendar_today_outlined, event.date),
        if (event.time != null) _Meta(Icons.schedule, event.time!),
        _Meta(Icons.location_on_outlined, event.venue),
      ]);
      final action = event.id == 'leadership'
        ? OutlinedButton(onPressed: onAction, child: const Text('Details  ›'))
        : FilledButton(
          onPressed: event.status == EventStatus.closed ? null : onAction,
          child: Text(switch(event.status) {
            EventStatus.registered => 'View QR',
            EventStatus.open => 'Register',
            EventStatus.closed => 'Closed',
          }));
      return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
          ClipRRect(borderRadius: BorderRadius.circular(12),
            child: Image.asset('assets/images/${event.image}.png',
              width: compact ? 78 : 90, height: 100, fit: BoxFit.cover,
              semanticLabel: '${event.title} artwork')),
          const SizedBox(width: 14),
          Expanded(child: details),
          if (!compact) ...[
            const SizedBox(width: 12),
            Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
              _Status(event), const SizedBox(height: 12), action]),
          ],
        ]),
        if (compact) ...[
          const SizedBox(height: 12),
          Wrap(spacing: 12, runSpacing: 8, crossAxisAlignment: WrapCrossAlignment.center,
            children: [_Status(event), action]),
        ],
      ]);
    }));
}

class _Meta extends StatelessWidget {
  const _Meta(this.icon, this.text);
  final IconData icon;
  final String text;
  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.only(bottom: 3),
    child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Icon(icon, size: 16, color: AppTheme.muted),
      const SizedBox(width: 7),
      Expanded(child: Text(text, style: Theme.of(context).textTheme.bodyMedium)),
    ]));
}

class _Status extends StatelessWidget {
  const _Status(this.event);
  final CampusEvent event;
  @override
  Widget build(BuildContext context) {
    final closed = event.status == EventStatus.closed;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
      decoration: BoxDecoration(
        color: closed ? const Color(0xFFFDE4E5) : const Color(0xFFE2F5EA),
        borderRadius: BorderRadius.circular(30)),
      child: Text(
        (event.status == EventStatus.registered ? '✓  ' : '') + event.statusLabel,
        style: TextStyle(fontSize: 10,
          color: closed ? const Color(0xFFB40016) : const Color(0xFF006343))));
  }
}
