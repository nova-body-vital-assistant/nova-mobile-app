import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_theme.dart';
import '../widgets/header_bar.dart';

class HealthScreen extends StatefulWidget {
  const HealthScreen({super.key});

  @override
  State<HealthScreen> createState() => _HealthScreenState();
}

class _HealthScreenState extends State<HealthScreen> {
  late DateTime _selectedDate;
  late DateTime _weekStart;

  @override
  void initState() {
    super.initState();
    final now = DateTime.now();
    _selectedDate = DateTime(now.year, now.month, now.day);
    _weekStart = _selectedDate.subtract(
      Duration(days: _selectedDate.weekday % 7),
    );
  }

  void _shiftWeek(int delta) {
    setState(() {
      _weekStart = _weekStart.add(Duration(days: 7 * delta));
      // Keep selected date within the visible week
      if (_selectedDate.isBefore(_weekStart) ||
          _selectedDate.isAfter(_weekStart.add(const Duration(days: 6)))) {
        _selectedDate = _weekStart;
      }
    });
  }

  void _selectDate(DateTime date) {
    setState(() => _selectedDate = date);
  }

  // Simulated prediction data keyed by weekday (0=Sun ... 6=Sat)
  static const _predictions = <int, List<_SlotData>>{
    0: [
      _SlotData('8:00 – 9:00 AM', 'Morning Routine', _RiskLevel.moderate,
          'Slower reflexes after rest day'),
      _SlotData('3:00 – 4:00 PM', 'Afternoon Nap', _RiskLevel.low,
          'Stable vitals, light activity'),
    ],
    1: [
      _SlotData('6:00 – 7:00 AM', 'Morning Wake-up', _RiskLevel.high,
          'Dizziness after sleep, low blood pressure'),
      _SlotData('12:00 – 1:00 PM', 'After Lunch', _RiskLevel.moderate,
          'Post-meal drowsiness, medication side effects'),
      _SlotData('9:00 – 10:00 PM', 'Bedtime', _RiskLevel.high,
          'Poor lighting, drowsiness, bathroom visits'),
    ],
    2: [
      _SlotData('6:30 – 7:30 AM', 'Morning Wake-up', _RiskLevel.high,
          'Low blood pressure, groggy state'),
      _SlotData('2:00 – 3:00 PM', 'Afternoon', _RiskLevel.low,
          'Stable vitals, normal activity'),
      _SlotData('6:00 – 7:00 PM', 'Evening Routine', _RiskLevel.moderate,
          'Fatigue build-up, reduced alertness'),
    ],
    3: [
      _SlotData('6:00 – 7:00 AM', 'Morning Wake-up', _RiskLevel.moderate,
          'Slightly low blood pressure'),
      _SlotData('12:30 – 1:30 PM', 'Post-Lunch', _RiskLevel.moderate,
          'Medication window, drowsiness expected'),
      _SlotData('9:00 – 10:00 PM', 'Bedtime', _RiskLevel.high,
          'Dim lighting, fatigue peak'),
    ],
    4: [
      _SlotData('6:00 – 7:00 AM', 'Morning Wake-up', _RiskLevel.high,
          'Dizziness after sleep, low blood pressure'),
      _SlotData('11:00 AM – 12:00 PM', 'Late Morning', _RiskLevel.low,
          'Active period, stable gait'),
      _SlotData('7:00 – 8:00 PM', 'Evening', _RiskLevel.moderate,
          'End-of-day fatigue'),
    ],
    5: [
      _SlotData('7:00 – 8:00 AM', 'Morning', _RiskLevel.moderate,
          'Slower wake-up pattern on Fridays'),
      _SlotData('1:00 – 2:00 PM', 'After Lunch', _RiskLevel.low,
          'Stable vitals, light movement'),
      _SlotData('9:30 – 10:30 PM', 'Late Evening', _RiskLevel.high,
          'Drowsiness, bathroom visit pattern'),
    ],
    6: [
      _SlotData('8:00 – 9:30 AM', 'Late Morning', _RiskLevel.moderate,
          'Weekend routine change, slower start'),
      _SlotData('4:00 – 5:00 PM', 'Afternoon', _RiskLevel.low,
          'Relaxed activity, stable readings'),
    ],
  };

  List<_SlotData> get _slotsForSelectedDate {
    return _predictions[_selectedDate.weekday % 7] ?? [];
  }

  bool get _isToday {
    final now = DateTime.now();
    return _selectedDate.year == now.year &&
        _selectedDate.month == now.month &&
        _selectedDate.day == now.day;
  }

  bool get _isFuture => _selectedDate.isAfter(DateTime.now());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surface,
      body: SafeArea(
        child: Column(
          children: [
            const HeaderBar(title: 'Predictions'),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 8),
                    Text(
                      'Fall Risk Forecast',
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 28,
                        fontWeight: FontWeight.w700,
                        color: AppColors.onSurface,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'NOVA predicts critical times that need caregiver attention.',
                      style: GoogleFonts.lexend(
                        fontSize: 13,
                        fontWeight: FontWeight.w400,
                        color: AppColors.onSurfaceVariant,
                      ),
                    ),
                    const SizedBox(height: 20),
                    // Week strip with navigation
                    _WeekStrip(
                      weekStart: _weekStart,
                      selectedDate: _selectedDate,
                      onDateTap: _selectDate,
                      onPrevWeek: () => _shiftWeek(-1),
                      onNextWeek: () => _shiftWeek(1),
                    ),
                    const SizedBox(height: 20),
                    // Day summary chip
                    _DaySummaryChip(
                      isToday: _isToday,
                      isFuture: _isFuture,
                      slotCount: _slotsForSelectedDate.length,
                      highCount: _slotsForSelectedDate
                          .where((s) => s.risk == _RiskLevel.high)
                          .length,
                    ),
                    const SizedBox(height: 20),
                    // Time slots
                    ..._slotsForSelectedDate.expand(
                      (slot) => [
                        _RiskTimeSlot(
                          time: slot.time,
                          label: slot.label,
                          risk: slot.risk,
                          reason: slot.reason,
                        ),
                        const SizedBox(height: 10),
                      ],
                    ),
                    if (_slotsForSelectedDate.isEmpty)
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(vertical: 48),
                        child: Column(
                          children: [
                            Icon(
                              Icons.check_circle_outline,
                              size: 48,
                              color: AppColors.primaryContainer,
                            ),
                            const SizedBox(height: 12),
                            Text(
                              'No high-risk windows predicted',
                              style: GoogleFonts.lexend(
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                                color: AppColors.onSurfaceVariant,
                              ),
                            ),
                          ],
                        ),
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

// --- Slot data model ---
class _SlotData {
  final String time;
  final String label;
  final _RiskLevel risk;
  final String reason;

  const _SlotData(this.time, this.label, this.risk, this.reason);
}

// --- Day Summary Chip ---
class _DaySummaryChip extends StatelessWidget {
  final bool isToday;
  final bool isFuture;
  final int slotCount;
  final int highCount;

  const _DaySummaryChip({
    required this.isToday,
    required this.isFuture,
    required this.slotCount,
    required this.highCount,
  });

  @override
  Widget build(BuildContext context) {
    final tagLabel = isToday
        ? 'Today'
        : isFuture
            ? 'Upcoming'
            : 'Past';
    final summaryColor = highCount > 0
        ? const Color(0xFFE53935)
        : slotCount > 0
            ? const Color(0xFFFFA726)
            : AppColors.primaryContainer;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: summaryColor.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: summaryColor.withValues(alpha: 0.2)),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: summaryColor.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(9999),
            ),
            child: Text(
              tagLabel,
              style: GoogleFonts.lexend(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: summaryColor,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              highCount > 0
                  ? '$highCount high-risk window${highCount > 1 ? 's' : ''} · $slotCount total'
                  : slotCount > 0
                      ? '$slotCount predicted window${slotCount > 1 ? 's' : ''} · No high risk'
                      : 'Clear day — no risk windows',
              style: GoogleFonts.lexend(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: AppColors.onSurface,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// --- Week Date Strip ---
class _WeekStrip extends StatelessWidget {
  final DateTime weekStart;
  final DateTime selectedDate;
  final ValueChanged<DateTime> onDateTap;
  final VoidCallback onPrevWeek;
  final VoidCallback onNextWeek;

  const _WeekStrip({
    required this.weekStart,
    required this.selectedDate,
    required this.onDateTap,
    required this.onPrevWeek,
    required this.onNextWeek,
  });

  static const _dayLabels = ['S', 'M', 'T', 'W', 'T', 'F', 'S'];
  static const _monthNames = [
    'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
    'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec',
  ];

  @override
  Widget build(BuildContext context) {
    final weekEnd = weekStart.add(const Duration(days: 6));
    final monthLabel = weekStart.month == weekEnd.month
        ? '${_monthNames[weekStart.month - 1]} ${weekStart.year}'
        : '${_monthNames[weekStart.month - 1]} – ${_monthNames[weekEnd.month - 1]} ${weekEnd.year}';

    return Container(
      padding: const EdgeInsets.all(16),
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
        children: [
          // Month header with arrows
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                onPressed: onPrevWeek,
                icon: const Icon(Icons.chevron_left, color: AppColors.onSurfaceVariant),
                visualDensity: VisualDensity.compact,
              ),
              Text(
                monthLabel,
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: AppColors.onSurface,
                ),
              ),
              IconButton(
                onPressed: onNextWeek,
                icon: const Icon(Icons.chevron_right, color: AppColors.onSurfaceVariant),
                visualDensity: VisualDensity.compact,
              ),
            ],
          ),
          const SizedBox(height: 8),
          // Day circles
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(7, (i) {
              final date = weekStart.add(Duration(days: i));
              final isSelected = date.year == selectedDate.year &&
                  date.month == selectedDate.month &&
                  date.day == selectedDate.day;
              final now = DateTime.now();
              final isToday = date.year == now.year &&
                  date.month == now.month &&
                  date.day == now.day;

              return GestureDetector(
                onTap: () => onDateTap(date),
                child: Column(
                  children: [
                    Text(
                      _dayLabels[i],
                      style: GoogleFonts.lexend(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: AppColors.onSurfaceVariant,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: isSelected
                            ? AppColors.onSurface
                            : isToday
                                ? AppColors.onSurface.withValues(alpha: 0.08)
                                : Colors.transparent,
                      ),
                      child: Center(
                        child: Text(
                          '${date.day}',
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 15,
                            fontWeight:
                                isSelected ? FontWeight.w700 : FontWeight.w500,
                            color: isSelected
                                ? AppColors.surfaceContainerLowest
                                : AppColors.onSurface,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}

// --- Risk Level Enum ---
enum _RiskLevel { low, moderate, high }

// --- Risk Time Slot Card ---
class _RiskTimeSlot extends StatelessWidget {
  final String time;
  final String label;
  final _RiskLevel risk;
  final String reason;

  const _RiskTimeSlot({
    required this.time,
    required this.label,
    required this.risk,
    required this.reason,
  });

  Color get _riskColor => switch (risk) {
        _RiskLevel.high => const Color(0xFFE53935),
        _RiskLevel.moderate => const Color(0xFFFFA726),
        _RiskLevel.low => AppColors.primaryContainer,
      };

  String get _riskLabel => switch (risk) {
        _RiskLevel.high => 'HIGH',
        _RiskLevel.moderate => 'MODERATE',
        _RiskLevel.low => 'LOW',
      };

  IconData get _riskIcon => switch (risk) {
        _RiskLevel.high => Icons.warning_rounded,
        _RiskLevel.moderate => Icons.info_outline,
        _RiskLevel.low => Icons.check_circle_outline,
      };

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: _riskColor.withValues(alpha: 0.3),
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 12,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 4,
            height: 56,
            decoration: BoxDecoration(
              color: _riskColor,
              borderRadius: BorderRadius.circular(4),
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        time,
                        style: GoogleFonts.lexend(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: AppColors.onSurface,
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 3,
                      ),
                      decoration: BoxDecoration(
                        color: _riskColor.withValues(alpha: 0.12),
                        borderRadius: BorderRadius.circular(9999),
                      ),
                      child: Text(
                        _riskLabel,
                        style: GoogleFonts.lexend(
                          fontSize: 10,
                          fontWeight: FontWeight.w700,
                          color: _riskColor,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 2),
                Text(
                  label,
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: AppColors.onSurfaceVariant,
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Icon(_riskIcon, size: 14, color: _riskColor),
                    const SizedBox(width: 6),
                    Expanded(
                      child: Text(
                        reason,
                        style: GoogleFonts.lexend(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: AppColors.outline,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
