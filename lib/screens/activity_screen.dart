import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_theme.dart';
import '../widgets/header_bar.dart';

class ActivityScreen extends StatelessWidget {
  const ActivityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surface,
      body: SafeArea(
        child: Column(
          children: [
            const HeaderBar(title: 'Activity Log'),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 8),
                    // Camera card
                    const _CameraCard(),
                    const SizedBox(height: 24),
                    // Timeline
                    const _TimelineSection(),
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

// --- Camera Card ---
class _CameraCard extends StatelessWidget {
  const _CameraCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
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
          // Camera header
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 18, 20, 12),
            child: Row(
              children: [
                const Icon(
                  Icons.videocam_outlined,
                  size: 20,
                  color: AppColors.onSurfaceVariant,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'Living Room Camera',
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: AppColors.onSurface,
                    ),
                  ),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: AppColors.primaryContainer.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(9999),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 7,
                        height: 7,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.primaryContainer,
                        ),
                      ),
                      const SizedBox(width: 5),
                      Text(
                        'Live',
                        style: GoogleFonts.lexend(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: AppColors.primaryContainer,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // Camera feed placeholder
          Container(
            width: double.infinity,
            height: 180,
            color: const Color(0xFF2A322B),
            child: Stack(
              alignment: Alignment.center,
              children: [
                // Simulated feed overlay
                Positioned.fill(
                  child: Container(
                    color: Colors.black.withValues(alpha: 0.4),
                  ),
                ),
                // Play button
                Container(
                  width: 56,
                  height: 56,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white.withValues(alpha: 0.25),
                  ),
                  child: const Icon(
                    Icons.play_arrow_rounded,
                    color: Colors.white,
                    size: 36,
                  ),
                ),
                // Timestamp
                Positioned(
                  bottom: 10,
                  right: 14,
                  child: Text(
                    '14:05:22',
                    style: GoogleFonts.lexend(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      color: Colors.white.withValues(alpha: 0.8),
                    ),
                  ),
                ),
              ],
            ),
          ),
          // View Full History link
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 14),
            child: Text(
              'View Full History',
              style: GoogleFonts.lexend(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: AppColors.primaryContainer,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// --- Timeline Section ---
class _TimelineSection extends StatelessWidget {
  const _TimelineSection();

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
          // Section header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Timeline',
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                  color: AppColors.onSurface,
                ),
              ),
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.surfaceContainerHigh,
                ),
                child: const Icon(
                  Icons.filter_list,
                  size: 18,
                  color: AppColors.onSurfaceVariant,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          // Timeline items
          const _TimelineItem(
            icon: Icons.chair,
            iconBgColor: Color(0xFFE8F5E9),
            iconColor: AppColors.primaryContainer,
            title: 'Sat Down',
            time: '2:15 PM',
            detail: 'Living Room Couch',
          ),
          const _TimelineItem(
            icon: Icons.warning_rounded,
            iconBgColor: Color(0xFFFFEBEE),
            iconColor: Color(0xFFE53935),
            title: 'Motion Anomaly',
            time: '2:00 PM',
            detail: 'Gait instability detected.\nProlonged pause in hallway.',
            badge: 'Critical',
            badgeColor: Color(0xFFE53935),
            actionLabel: 'Acknowledge',
          ),
          const _TimelineItem(
            icon: Icons.directions_walk,
            iconBgColor: Color(0xFFE8F5E9),
            iconColor: AppColors.primaryContainer,
            title: 'Walking',
            time: '1:45 PM',
            detail: 'Kitchen to Hallway',
          ),
          const _TimelineItem(
            icon: Icons.restaurant,
            iconBgColor: Color(0xFFF3E5F5),
            iconColor: Color(0xFF8E24AA),
            title: 'Meal Time',
            time: '12:30 PM',
            detail: 'Kitchen',
            isLast: true,
          ),
        ],
      ),
    );
  }
}

class _TimelineItem extends StatefulWidget {
  final IconData icon;
  final Color iconBgColor;
  final Color iconColor;
  final String title;
  final String time;
  final String detail;
  final String? badge;
  final Color? badgeColor;
  final String? actionLabel;
  final bool isLast;

  const _TimelineItem({
    required this.icon,
    required this.iconBgColor,
    required this.iconColor,
    required this.title,
    required this.time,
    required this.detail,
    this.badge,
    this.badgeColor,
    this.actionLabel,
    this.isLast = false,
  });

  @override
  State<_TimelineItem> createState() => _TimelineItemState();
}

class _TimelineItemState extends State<_TimelineItem> {
  bool _acknowledged = false;

  @override
  Widget build(BuildContext context) {
    final showAction = widget.actionLabel != null && !_acknowledged;

    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Dot + line
          Column(
            children: [
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _acknowledged
                      ? AppColors.surfaceContainerHigh
                      : widget.iconBgColor,
                ),
                child: _acknowledged
                    ? const Icon(
                        Icons.check_circle_outline,
                        size: 18,
                        color: AppColors.primaryContainer,
                      )
                    : Icon(widget.icon, size: 18, color: widget.iconColor),
              ),
              if (!widget.isLast)
                Expanded(
                  child: Container(
                    width: 2,
                    margin: const EdgeInsets.symmetric(vertical: 4),
                    color: AppColors.outlineVariant,
                  ),
                ),
            ],
          ),
          const SizedBox(width: 14),
          // Content
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(bottom: widget.isLast ? 0 : 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title row
                  Row(
                    children: [
                      Text(
                        widget.title,
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                          color: _acknowledged
                              ? AppColors.outline
                              : AppColors.onSurface,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        widget.time,
                        style: GoogleFonts.lexend(
                          fontSize: 13,
                          fontWeight: FontWeight.w400,
                          color: AppColors.outline,
                        ),
                      ),
                      if (_acknowledged && widget.badge != null) ...[
                        const Spacer(),
                        const Icon(
                          Icons.check_circle_outline,
                          size: 18,
                          color: AppColors.primaryContainer,
                        ),
                      ] else if (widget.badge != null) ...[
                        const Spacer(),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: widget.badgeColor!.withValues(alpha: 0.12),
                            borderRadius: BorderRadius.circular(9999),
                          ),
                          child: Text(
                            widget.badge!,
                            style: GoogleFonts.lexend(
                              fontSize: 10,
                              fontWeight: FontWeight.w700,
                              color: widget.badgeColor,
                              letterSpacing: 0.5,
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                  const SizedBox(height: 8),
                  // Detail bubble
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 10,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.surfaceContainerLow,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Text(
                      _acknowledged
                          ? 'Acknowledged • Just now'
                          : widget.detail,
                      style: GoogleFonts.lexend(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: AppColors.onSurfaceVariant,
                        height: 1.5,
                      ),
                    ),
                  ),
                  if (showAction) ...[
                    const SizedBox(height: 10),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () =>
                            setState(() => _acknowledged = true),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.onSurface,
                          foregroundColor: Colors.white,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(9999),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 12),
                        ),
                        child: Text(
                          widget.actionLabel!,
                          style: GoogleFonts.lexend(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
