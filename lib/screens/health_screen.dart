import 'dart:math';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_theme.dart';
import '../widgets/header_bar.dart';

class HealthScreen extends StatelessWidget {
  const HealthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surface,
      body: SafeArea(
        child: Column(
          children: [
            const HeaderBar(title: 'Health'),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 8),
                    // Page title
                    Text(
                      'Health Insights',
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 28,
                        fontWeight: FontWeight.w700,
                        color: AppColors.onSurface,
                      ),
                    ),
                    const SizedBox(height: 6),
                    // Status line
                    Row(
                      children: [
                        Container(
                          width: 8,
                          height: 8,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColors.primaryContainer,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'Vitals stable • Last updated 2 min ago',
                          style: GoogleFonts.lexend(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: AppColors.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    // Device chip
                    const _DeviceChip(),
                    const SizedBox(height: 24),
                    // Vital cards
                    const _VitalCard(
                      title: 'HEART RATE',
                      value: '72',
                      unit: 'BPM',
                      badge: 'Normal',
                      badgeColor: AppColors.primaryContainer,
                      icon: Icons.favorite,
                      iconColor: Color(0xFFC62828),
                    ),
                    const SizedBox(height: 16),
                    const _VitalCard(
                      title: 'BLOOD OXYGEN',
                      value: '98',
                      unit: '%',
                      badge: 'Optimal',
                      badgeColor: AppColors.primaryContainer,
                      icon: Icons.air,
                      iconColor: AppColors.primaryContainer,
                    ),
                    const SizedBox(height: 16),
                    const _VitalCard(
                      title: 'TEMPERATURE',
                      value: '36.6',
                      unit: '°C',
                      badge: 'Stable',
                      badgeColor: Color(0xFF9E9E9E),
                      icon: Icons.thermostat,
                      iconColor: Color(0xFFFFA726),
                    ),
                    const SizedBox(height: 16),
                    const _VitalCard(
                      title: 'SLEEP QUALITY',
                      value: '86',
                      unit: '/100',
                      badge: 'Good',
                      badgeColor: AppColors.primaryContainer,
                      icon: Icons.nightlight_round,
                      iconColor: Color(0xFF1565C0),
                    ),
                    const SizedBox(height: 32),
                    // 24 Hour Trends section
                    Text(
                      '24 Hour Trends',
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                        color: AppColors.onSurface,
                      ),
                    ),
                    const SizedBox(height: 16),
                    const _TrendCard(
                      title: 'HEART RATE TREND',
                      values: [64, 68, 72, 85, 70, 66, 62, 72],
                      color: Color(0xFFC62828),
                      minLabel: '62',
                      maxLabel: '85',
                      avgLabel: '70 BPM avg',
                    ),
                    const SizedBox(height: 16),
                    const _TrendCard(
                      title: 'SPO2 TREND',
                      values: [96, 97, 98, 97, 99, 98, 97, 98],
                      color: AppColors.primaryContainer,
                      minLabel: '96',
                      maxLabel: '99',
                      avgLabel: '97.5% avg',
                    ),
                    const SizedBox(height: 32),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// --- Device Connection Chip ---
class _DeviceChip extends StatelessWidget {
  const _DeviceChip();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(9999),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
            Icons.watch,
            size: 20,
            color: AppColors.onSurfaceVariant,
          ),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Apple Watch',
                style: GoogleFonts.lexend(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: AppColors.onSurface,
                ),
              ),
              Text(
                'Connected',
                style: GoogleFonts.lexend(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: AppColors.onSurfaceVariant,
                ),
              ),
            ],
          ),
          const SizedBox(width: 10),
          const Icon(
            Icons.check_circle,
            size: 18,
            color: AppColors.primaryContainer,
          ),
        ],
      ),
    );
  }
}

// --- Vital Card ---
class _VitalCard extends StatelessWidget {
  final String title;
  final String value;
  final String unit;
  final String badge;
  final Color badgeColor;
  final IconData icon;
  final Color iconColor;

  const _VitalCard({
    required this.title,
    required this.value,
    required this.unit,
    required this.badge,
    required this.badgeColor,
    required this.icon,
    required this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 20,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(icon, size: 18, color: iconColor),
                  const SizedBox(width: 8),
                  Text(
                    title,
                    style: GoogleFonts.lexend(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: AppColors.onSurfaceVariant,
                      letterSpacing: 0.5,
                    ),
                  ),
                ],
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(
                  color: badgeColor.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(9999),
                ),
                child: Text(
                  badge,
                  style: GoogleFonts.lexend(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: badgeColor,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Text(
                value,
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 44,
                  fontWeight: FontWeight.w700,
                  color: AppColors.onSurface,
                  height: 1,
                ),
              ),
              const SizedBox(width: 6),
              Text(
                unit,
                style: GoogleFonts.lexend(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: AppColors.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// --- Trend Card with Bar Chart ---
class _TrendCard extends StatelessWidget {
  final String title;
  final List<double> values;
  final Color color;
  final String minLabel;
  final String maxLabel;
  final String avgLabel;

  const _TrendCard({
    required this.title,
    required this.values,
    required this.color,
    required this.minLabel,
    required this.maxLabel,
    required this.avgLabel,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 20,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: GoogleFonts.lexend(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: AppColors.onSurfaceVariant,
              letterSpacing: 0.5,
            ),
          ),
          const SizedBox(height: 20),
          SizedBox(
            height: 120,
            child: CustomPaint(
              size: Size.infinite,
              painter: _BarChartPainter(
                values: values,
                color: color,
              ),
            ),
          ),
          const SizedBox(height: 12),
          // Time labels
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '12 AM',
                style: GoogleFonts.lexend(
                  fontSize: 11,
                  color: AppColors.outline,
                ),
              ),
              Text(
                '6 AM',
                style: GoogleFonts.lexend(
                  fontSize: 11,
                  color: AppColors.outline,
                ),
              ),
              Text(
                '12 PM',
                style: GoogleFonts.lexend(
                  fontSize: 11,
                  color: AppColors.outline,
                ),
              ),
              Text(
                '6 PM',
                style: GoogleFonts.lexend(
                  fontSize: 11,
                  color: AppColors.outline,
                ),
              ),
              Text(
                'Now',
                style: GoogleFonts.lexend(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  color: AppColors.onSurfaceVariant,
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          // Stats row
          Row(
            children: [
              _StatChip(label: 'Min', value: minLabel),
              const SizedBox(width: 12),
              _StatChip(label: 'Max', value: maxLabel),
              const Spacer(),
              Text(
                avgLabel,
                style: GoogleFonts.lexend(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: AppColors.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _StatChip extends StatelessWidget {
  final String label;
  final String value;

  const _StatChip({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          '$label ',
          style: GoogleFonts.lexend(
            fontSize: 12,
            fontWeight: FontWeight.w400,
            color: AppColors.outline,
          ),
        ),
        Text(
          value,
          style: GoogleFonts.lexend(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: AppColors.onSurface,
          ),
        ),
      ],
    );
  }
}

// --- Bar Chart Painter ---
class _BarChartPainter extends CustomPainter {
  final List<double> values;
  final Color color;

  _BarChartPainter({required this.values, required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    if (values.isEmpty) return;

    final maxVal = values.reduce(max);
    final minVal = values.reduce(min);
    final range = maxVal - minVal;
    final barWidth = size.width / (values.length * 2);
    final spacing = size.width / values.length;

    // Draw subtle grid lines
    final gridPaint = Paint()
      ..color = AppColors.surfaceContainerHigh
      ..strokeWidth = 1;
    for (int i = 0; i < 4; i++) {
      final y = size.height * i / 3;
      canvas.drawLine(Offset(0, y), Offset(size.width, y), gridPaint);
    }

    for (int i = 0; i < values.length; i++) {
      final normalized = range == 0 ? 0.5 : (values[i] - minVal) / range;
      final barHeight = size.height * 0.2 + (size.height * 0.75 * normalized);
      final x = spacing * i + (spacing - barWidth) / 2;
      final y = size.height - barHeight;

      final rect = RRect.fromRectAndRadius(
        Rect.fromLTWH(x, y, barWidth, barHeight),
        const Radius.circular(6),
      );

      // Dimmer bars for older, brighter for recent
      final opacity = 0.25 + (0.75 * i / (values.length - 1));
      final paint = Paint()..color = color.withValues(alpha: opacity);
      canvas.drawRRect(rect, paint);
    }
  }

  @override
  bool shouldRepaint(covariant _BarChartPainter oldDelegate) =>
      oldDelegate.values != values || oldDelegate.color != color;
}
