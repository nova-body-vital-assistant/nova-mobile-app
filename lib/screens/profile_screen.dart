import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_theme.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surface,
      body: SafeArea(
        child: Column(
          children: [
            // Top bar with back button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: const Icon(Icons.arrow_back_rounded),
                    color: AppColors.onSurface,
                  ),
                  Text(
                    'Patient Profile',
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: AppColors.onSurface,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    const SizedBox(height: 8),
                    // Profile header card
                    const _ProfileHeader(),
                    const SizedBox(height: 16),
                    // Basic info
                    const _InfoCard(
                      title: 'Basic Information',
                      icon: Icons.person_outline,
                      items: [
                        _InfoRow(label: 'Full Name', value: 'Henry Mitchell'),
                        _InfoRow(label: 'Age', value: '78 years old'),
                        _InfoRow(label: 'Date of Birth', value: 'Mar 12, 1948'),
                        _InfoRow(label: 'Gender', value: 'Male'),
                        _InfoRow(label: 'Blood Type', value: 'A+'),
                        _InfoRow(label: 'Weight', value: '74 kg'),
                      ],
                    ),
                    const SizedBox(height: 16),
                    // Medications
                    const _InfoCard(
                      title: 'Current Medications',
                      icon: Icons.medication_outlined,
                      items: [
                        _MedicationRow(
                          name: 'Lisinopril 10mg',
                          schedule: 'Once daily • Morning',
                        ),
                        _MedicationRow(
                          name: 'Metformin 500mg',
                          schedule: 'Twice daily • Morning & Evening',
                        ),
                        _MedicationRow(
                          name: 'Aspirin 81mg',
                          schedule: 'Once daily • Morning',
                        ),
                        _MedicationRow(
                          name: 'Atorvastatin 20mg',
                          schedule: 'Once daily • Bedtime',
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    // Medical history
                    const _InfoCard(
                      title: 'History of Illness',
                      icon: Icons.medical_information_outlined,
                      items: [
                        _ConditionRow(
                          name: 'Type 2 Diabetes',
                          since: 'Diagnosed 2012',
                          status: 'Managed',
                          statusColor: AppColors.primaryContainer,
                        ),
                        _ConditionRow(
                          name: 'Hypertension',
                          since: 'Diagnosed 2009',
                          status: 'Controlled',
                          statusColor: AppColors.primaryContainer,
                        ),
                        _ConditionRow(
                          name: 'Hip Replacement (Left)',
                          since: 'Surgery 2021',
                          status: 'Recovered',
                          statusColor: Color(0xFF9E9E9E),
                        ),
                        _ConditionRow(
                          name: 'Mild Cognitive Impairment',
                          since: 'Diagnosed 2023',
                          status: 'Monitoring',
                          statusColor: Color(0xFFFFA726),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    // Emergency contacts
                    const _InfoCard(
                      title: 'Emergency Contacts',
                      icon: Icons.emergency_outlined,
                      items: [
                        _ContactRow(
                          name: 'Sarah Mitchell',
                          relation: 'Daughter',
                          phone: '+1 (555) 234-5678',
                          isPrimary: true,
                        ),
                        _ContactRow(
                          name: 'Dr. Robert Chen',
                          relation: 'Primary Physician',
                          phone: '+1 (555) 876-5432',
                          isPrimary: false,
                        ),
                        _ContactRow(
                          name: 'James Mitchell',
                          relation: 'Son',
                          phone: '+1 (555) 345-6789',
                          isPrimary: false,
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    // Monitored routines
                    const _InfoCard(
                      title: 'Monitored Routines',
                      icon: Icons.schedule_outlined,
                      items: [
                        _RoutineRow(
                          name: 'Morning Medication',
                          time: '8:00 AM',
                          icon: Icons.medication,
                          alert: 'Alert if missed by 30 min',
                        ),
                        _RoutineRow(
                          name: 'Morning Walk',
                          time: '9:30 AM',
                          icon: Icons.directions_walk,
                          alert: 'Alert if no activity by 10:30 AM',
                        ),
                        _RoutineRow(
                          name: 'Lunch',
                          time: '12:00 PM',
                          icon: Icons.restaurant,
                          alert: 'Alert if no kitchen activity by 1 PM',
                        ),
                        _RoutineRow(
                          name: 'Afternoon Rest',
                          time: '2:00 PM',
                          icon: Icons.chair,
                          alert: 'Alert if inactive > 3 hours',
                        ),
                        _RoutineRow(
                          name: 'Evening Medication',
                          time: '7:00 PM',
                          icon: Icons.medication,
                          alert: 'Alert if missed by 30 min',
                        ),
                        _RoutineRow(
                          name: 'Bedtime',
                          time: '10:00 PM',
                          icon: Icons.bedtime,
                          alert: 'Alert if no bedroom activity by 11 PM',
                        ),
                      ],
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

// --- Profile Header ---
class _ProfileHeader extends StatelessWidget {
  const _ProfileHeader();

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
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.surfaceContainerHigh,
              border: Border.all(color: AppColors.primaryContainer, width: 3),
            ),
            child: const Icon(
              Icons.person,
              size: 44,
              color: AppColors.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 14),
          Text(
            'Henry Mitchell',
            style: GoogleFonts.plusJakartaSans(
              fontSize: 22,
              fontWeight: FontWeight.w700,
              color: AppColors.onSurface,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            '78 years old • Male',
            style: GoogleFonts.lexend(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: AppColors.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
            decoration: BoxDecoration(
              color: AppColors.primaryContainer.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(9999),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
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
                  'Device Connected • Vitals Stable',
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
    );
  }
}

// --- Reusable Section Card ---
class _InfoCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final List<Widget> items;

  const _InfoCard({
    required this.title,
    required this.icon,
    required this.items,
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
            children: [
              Icon(icon, size: 20, color: AppColors.primaryContainer),
              const SizedBox(width: 8),
              Text(
                title,
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
                  color: AppColors.onSurface,
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),
          ...List.generate(items.length * 2 - 1, (index) {
            if (index.isOdd) {
              return Divider(
                color: AppColors.outlineVariant.withValues(alpha: 0.5),
                height: 1,
              );
            }
            return items[index ~/ 2];
          }),
        ],
      ),
    );
  }
}

// --- Row Widgets ---

class _InfoRow extends StatelessWidget {
  final String label;
  final String value;

  const _InfoRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: GoogleFonts.lexend(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: AppColors.onSurfaceVariant,
            ),
          ),
          Text(
            value,
            style: GoogleFonts.lexend(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: AppColors.onSurface,
            ),
          ),
        ],
      ),
    );
  }
}

class _MedicationRow extends StatelessWidget {
  final String name;
  final String schedule;

  const _MedicationRow({required this.name, required this.schedule});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.primaryContainer.withValues(alpha: 0.12),
            ),
            child: const Icon(
              Icons.medication,
              size: 18,
              color: AppColors.primaryContainer,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: GoogleFonts.lexend(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: AppColors.onSurface,
                  ),
                ),
                Text(
                  schedule,
                  style: GoogleFonts.lexend(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: AppColors.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ConditionRow extends StatelessWidget {
  final String name;
  final String since;
  final String status;
  final Color statusColor;

  const _ConditionRow({
    required this.name,
    required this.since,
    required this.status,
    required this.statusColor,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: GoogleFonts.lexend(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: AppColors.onSurface,
                  ),
                ),
                Text(
                  since,
                  style: GoogleFonts.lexend(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: AppColors.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: statusColor.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(9999),
            ),
            child: Text(
              status,
              style: GoogleFonts.lexend(
                fontSize: 11,
                fontWeight: FontWeight.w600,
                color: statusColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ContactRow extends StatelessWidget {
  final String name;
  final String relation;
  final String phone;
  final bool isPrimary;

  const _ContactRow({
    required this.name,
    required this.relation,
    required this.phone,
    required this.isPrimary,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isPrimary
                  ? AppColors.primaryContainer.withValues(alpha: 0.12)
                  : AppColors.surfaceContainerHigh,
            ),
            child: Icon(
              isPrimary ? Icons.star_rounded : Icons.person_outline,
              size: 20,
              color: isPrimary
                  ? AppColors.primaryContainer
                  : AppColors.onSurfaceVariant,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      name,
                      style: GoogleFonts.lexend(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: AppColors.onSurface,
                      ),
                    ),
                    if (isPrimary) ...[
                      const SizedBox(width: 6),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 6,
                          vertical: 1,
                        ),
                        decoration: BoxDecoration(
                          color:
                              AppColors.primaryContainer.withValues(alpha: 0.12),
                          borderRadius: BorderRadius.circular(9999),
                        ),
                        child: Text(
                          'PRIMARY',
                          style: GoogleFonts.lexend(
                            fontSize: 9,
                            fontWeight: FontWeight.w700,
                            color: AppColors.primaryContainer,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
                Text(
                  '$relation • $phone',
                  style: GoogleFonts.lexend(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: AppColors.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
          const Icon(
            Icons.phone_outlined,
            size: 20,
            color: AppColors.primaryContainer,
          ),
        ],
      ),
    );
  }
}

class _RoutineRow extends StatelessWidget {
  final String name;
  final String time;
  final IconData icon;
  final String alert;

  const _RoutineRow({
    required this.name,
    required this.time,
    required this.icon,
    required this.alert,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.surfaceContainerHigh,
            ),
            child: Icon(icon, size: 18, color: AppColors.onSurfaceVariant),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      name,
                      style: GoogleFonts.lexend(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: AppColors.onSurface,
                      ),
                    ),
                    Text(
                      time,
                      style: GoogleFonts.lexend(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                        color: AppColors.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFA726).withValues(alpha: 0.10),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.notifications_active_outlined,
                        size: 13,
                        color: Color(0xFFFFA726),
                      ),
                      const SizedBox(width: 5),
                      Flexible(
                        child: Text(
                          alert,
                          style: GoogleFonts.lexend(
                            fontSize: 11,
                            fontWeight: FontWeight.w500,
                            color: const Color(0xFFFFA726),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
