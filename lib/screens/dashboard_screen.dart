import 'dart:math';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_theme.dart';
import '../widgets/header_bar.dart';
enum HealthStatus { safe, atRisk, fall }

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _StatusData {
  final String label;
  final String message;
  final IconData icon;
  final Color color;
  final double ringProgress;
  final String hr;
  final double hrProgress;
  final String sleep;
  final double sleepProgress;
  final String spo2;
  final double spo2Progress;
  final String location;
  final String locationDetail;

  const _StatusData({
    required this.label,
    required this.message,
    required this.icon,
    required this.color,
    required this.ringProgress,
    required this.hr,
    required this.hrProgress,
    required this.sleep,
    required this.sleepProgress,
    required this.spo2,
    required this.spo2Progress,
    required this.location,
    required this.locationDetail,
  });
}

const _statusPresets = {
  HealthStatus.safe: _StatusData(
    label: 'Safe',
    message: 'All vitals are within normal ranges.',
    icon: Icons.verified,
    color: AppColors.primaryContainer,
    ringProgress: 0.78,
    hr: '72',
    hrProgress: 0.65,
    sleep: '82',
    sleepProgress: 0.75,
    spo2: '98%',
    spo2Progress: 0.88,
    location: 'At Home',
    locationDetail: 'Living Room • 5m ago',
  ),
  HealthStatus.atRisk: _StatusData(
    label: 'At Risk',
    message: 'Some vitals need attention.',
    icon: Icons.warning_rounded,
    color: Color(0xFFFFA726),
    ringProgress: 0.45,
    hr: '104',
    hrProgress: 0.85,
    sleep: '51',
    sleepProgress: 0.42,
    spo2: '93%',
    spo2Progress: 0.62,
    location: 'At Home',
    locationDetail: 'Bedroom • 2m ago',
  ),
  HealthStatus.fall: _StatusData(
    label: 'Fall',
    message: 'Fall detected! Immediate attention needed.',
    icon: Icons.error,
    color: Color(0xFFE53935),
    ringProgress: 0.15,
    hr: '120',
    hrProgress: 0.95,
    sleep: '34',
    sleepProgress: 0.28,
    spo2: '89%',
    spo2Progress: 0.40,
    location: 'At Home',
    locationDetail: 'Bathroom • Just now',
  ),
};

class _DashboardScreenState extends State<DashboardScreen> {
  HealthStatus _status = HealthStatus.safe;

  void _cycleStatus() {
    setState(() {
      switch (_status) {
        case HealthStatus.safe:
          _status = HealthStatus.atRisk;
        case HealthStatus.atRisk:
          _status = HealthStatus.fall;
        case HealthStatus.fall:
          _status = HealthStatus.safe;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final data = _statusPresets[_status]!;

    return Scaffold(
      backgroundColor: AppColors.surface,
      body: SafeArea(
        child: Column(
          children: [
            const HeaderBar(
              title: 'Caregiver Portal',
              subtitle: 'Watching over Henry',
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    const SizedBox(height: 32),
                    GestureDetector(
                      onTap: _cycleStatus,
                      child: _StatusRing(
                        label: data.label,
                        icon: data.icon,
                        color: data.color,
                        progress: data.ringProgress,
                      ),
                    ),
                    const SizedBox(height: 24),
                    Text(
                      data.message,
                      style: GoogleFonts.lexend(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: _status == HealthStatus.fall
                            ? const Color(0xFFE53935)
                            : AppColors.onSurfaceVariant,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 32),
                    _VitalMetrics(
                      hr: data.hr,
                      hrProgress: data.hrProgress,
                      sleep: data.sleep,
                      sleepProgress: data.sleepProgress,
                      spo2: data.spo2,
                      spo2Progress: data.spo2Progress,
                      status: _status,
                    ),
                    const SizedBox(height: 24),
                    _LocationCard(
                      location: data.location,
                      detail: data.locationDetail,
                    ),
                    const SizedBox(height: 24),
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

// --- Status Ring ---
class _StatusRing extends StatelessWidget {
  final String label;
  final IconData icon;
  final Color color;
  final double progress;

  const _StatusRing({
    required this.label,
    required this.icon,
    required this.color,
    required this.progress,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 220,
      height: 220,
      child: Stack(
        alignment: Alignment.center,
        children: [
          CustomPaint(
            size: const Size(220, 220),
            painter: _RingPainter(
              progress: 1.0,
              color: AppColors.surfaceContainerHigh,
              strokeWidth: 16,
            ),
          ),
          CustomPaint(
            size: const Size(220, 220),
            painter: _RingPainter(
              progress: progress,
              color: color,
              strokeWidth: 16,
            ),
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: color.withValues(alpha: 0.15),
                ),
                child: Icon(icon, color: color, size: 30),
              ),
              const SizedBox(height: 8),
              Text(
                label,
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 32,
                  fontWeight: FontWeight.w700,
                  color: AppColors.onSurface,
                ),
              ),
              Text(
                'Status',
                style: GoogleFonts.lexend(
                  fontSize: 14,
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

class _RingPainter extends CustomPainter {
  final double progress;
  final Color color;
  final double strokeWidth;

  _RingPainter({
    required this.progress,
    required this.color,
    required this.strokeWidth,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Rect.fromLTWH(
      strokeWidth / 2,
      strokeWidth / 2,
      size.width - strokeWidth,
      size.height - strokeWidth,
    );
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    // Start from top (−90°) and sweep clockwise
    canvas.drawArc(
      rect,
      -pi / 2,
      2 * pi * progress,
      false,
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant _RingPainter oldDelegate) =>
      oldDelegate.progress != progress || oldDelegate.color != color;
}

// --- Vital Metrics Row ---
class _VitalMetrics extends StatelessWidget {
  final String hr;
  final double hrProgress;
  final String sleep;
  final double sleepProgress;
  final String spo2;
  final double spo2Progress;
  final HealthStatus status;

  const _VitalMetrics({
    required this.hr,
    required this.hrProgress,
    required this.sleep,
    required this.sleepProgress,
    required this.spo2,
    required this.spo2Progress,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    final hrColor = status == HealthStatus.safe
        ? const Color(0xFFC62828)
        : status == HealthStatus.atRisk
            ? const Color(0xFFFFA726)
            : const Color(0xFFE53935);
    final sleepColor = status == HealthStatus.safe
        ? const Color(0xFF1565C0)
        : status == HealthStatus.atRisk
            ? const Color(0xFFFFA726)
            : const Color(0xFFE53935);
    final spo2Color = status == HealthStatus.safe
        ? AppColors.primaryContainer
        : status == HealthStatus.atRisk
            ? const Color(0xFFFFA726)
            : const Color(0xFFE53935);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _MetricCircle(
          value: hr,
          label: 'Heart Rate',
          progress: hrProgress,
          color: hrColor,
          icon: Icons.favorite,
        ),
        _MetricCircle(
          value: sleep,
          label: 'Sleep Score',
          progress: sleepProgress,
          color: sleepColor,
          icon: Icons.nightlight_round,
        ),
        _MetricCircle(
          value: spo2,
          label: 'SpO2',
          progress: spo2Progress,
          color: spo2Color,
          icon: Icons.air,
        ),
      ],
    );
  }
}

class _MetricCircle extends StatelessWidget {
  final String value;
  final String label;
  final double progress;
  final Color color;
  final IconData icon;

  const _MetricCircle({
    required this.value,
    required this.label,
    required this.progress,
    required this.color,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: 88,
          height: 88,
          child: Stack(
            alignment: Alignment.center,
            children: [
              // Background track
              CustomPaint(
                size: const Size(88, 88),
                painter: _RingPainter(
                  progress: 1.0,
                  color: AppColors.surfaceContainerHigh,
                  strokeWidth: 8,
                ),
              ),
              // Progress
              CustomPaint(
                size: const Size(88, 88),
                painter: _RingPainter(
                  progress: progress,
                  color: color,
                  strokeWidth: 8,
                ),
              ),
              Icon(icon, color: color, size: 24),
            ],
          ),
        ),
        const SizedBox(height: 10),
        Text(
          value,
          style: GoogleFonts.plusJakartaSans(
            fontSize: 24,
            fontWeight: FontWeight.w700,
            color: AppColors.onSurface,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          label,
          style: GoogleFonts.lexend(
            fontSize: 13,
            fontWeight: FontWeight.w400,
            color: AppColors.onSurfaceVariant,
          ),
        ),
      ],
    );
  }
}

// --- Location Card ---
class _LocationCard extends StatelessWidget {
  final String location;
  final String detail;

  const _LocationCard({
    required this.location,
    required this.detail,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
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
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.surfaceContainerHigh,
            ),
            child: const Icon(
              Icons.location_on,
              color: AppColors.primary,
              size: 22,
            ),
          ),
          const SizedBox(width: 14),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                location,
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: AppColors.onSurface,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                detail,
                style: GoogleFonts.lexend(
                  fontSize: 14,
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

