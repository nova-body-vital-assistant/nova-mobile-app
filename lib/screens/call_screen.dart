import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_theme.dart';

class CallScreen extends StatefulWidget {
  final String contactName;
  final String contactRelation;
  final String phoneNumber;

  const CallScreen({
    super.key,
    required this.contactName,
    required this.contactRelation,
    required this.phoneNumber,
  });

  @override
  State<CallScreen> createState() => _CallScreenState();
}

enum _CallState { calling, connected, ended }

class _CallScreenState extends State<CallScreen>
    with SingleTickerProviderStateMixin {
  _CallState _state = _CallState.calling;
  int _seconds = 0;
  Timer? _timer;
  late final AnimationController _pulseController;
  late final Animation<double> _pulseAnimation;
  bool _isMuted = false;
  bool _isSpeaker = false;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat(reverse: true);
    _pulseAnimation = Tween<double>(begin: 1.0, end: 1.15).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );

    // Simulate connection after 3 seconds
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted && _state == _CallState.calling) {
        setState(() => _state = _CallState.connected);
        _pulseController.stop();
        _pulseController.value = 0;
        _startTimer();
      }
    });
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (mounted) setState(() => _seconds++);
    });
  }

  String get _formattedTime {
    final m = (_seconds ~/ 60).toString().padLeft(2, '0');
    final s = (_seconds % 60).toString().padLeft(2, '0');
    return '$m:$s';
  }

  void _endCall() {
    _timer?.cancel();
    setState(() => _state = _CallState.ended);
    Future.delayed(const Duration(milliseconds: 800), () {
      if (mounted) Navigator.of(context).pop();
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1A1A1A),
      body: SafeArea(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Spacer(flex: 2),
            // SOS badge
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
              decoration: BoxDecoration(
                color: const Color(0xFFE53935).withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(9999),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.emergency, color: Color(0xFFE53935), size: 16),
                  const SizedBox(width: 6),
                  Text(
                    'SOS EMERGENCY CALL',
                    style: GoogleFonts.lexend(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFFE53935),
                      letterSpacing: 1,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),
            // Avatar with pulse
            ScaleTransition(
              scale: _state == _CallState.calling
                  ? _pulseAnimation
                  : const AlwaysStoppedAnimation(1.0),
              child: Container(
                width: 110,
                height: 110,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.surfaceContainerHigh,
                  border: Border.all(
                    color: _state == _CallState.connected
                        ? AppColors.primaryContainer
                        : const Color(0xFFE53935),
                    width: 3,
                  ),
                ),
                child: const Icon(
                  Icons.person,
                  size: 56,
                  color: AppColors.onSurfaceVariant,
                ),
              ),
            ),
            const SizedBox(height: 24),
            // Contact name
            Text(
              widget.contactName,
              style: GoogleFonts.plusJakartaSans(
                fontSize: 28,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              '${widget.contactRelation} • ${widget.phoneNumber}',
              style: GoogleFonts.lexend(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: Colors.white.withValues(alpha: 0.6),
              ),
            ),
            const SizedBox(height: 16),
            // Call status
            Text(
              switch (_state) {
                _CallState.calling => 'Calling...',
                _CallState.connected => _formattedTime,
                _CallState.ended => 'Call Ended',
              },
              style: GoogleFonts.lexend(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: _state == _CallState.connected
                    ? AppColors.primaryContainer
                    : Colors.white.withValues(alpha: 0.7),
              ),
            ),
            if (_state == _CallState.ended)
              const Spacer(flex: 2)
            else ...[
              const Spacer(flex: 3),
              // Action buttons
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _CallAction(
                      icon: _isMuted ? Icons.mic_off : Icons.mic,
                      label: _isMuted ? 'Unmute' : 'Mute',
                      onTap: () => setState(() => _isMuted = !_isMuted),
                      isActive: _isMuted,
                    ),
                    _CallAction(
                      icon: _isSpeaker ? Icons.volume_up : Icons.volume_down,
                      label: 'Speaker',
                      onTap: () => setState(() => _isSpeaker = !_isSpeaker),
                      isActive: _isSpeaker,
                    ),
                    _CallAction(
                      icon: Icons.dialpad,
                      label: 'Keypad',
                      onTap: () {},
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 40),
              // End call button
              GestureDetector(
                onTap: _endCall,
                child: Container(
                  width: 72,
                  height: 72,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xFFE53935),
                  ),
                  child: const Icon(
                    Icons.call_end,
                    color: Colors.white,
                    size: 32,
                  ),
                ),
              ),
              const Spacer(),
            ],
          ],
        ),
        ),
      ),
    );
  }
}

class _CallAction extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final bool isActive;

  const _CallAction({
    required this.icon,
    required this.label,
    required this.onTap,
    this.isActive = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isActive
                  ? Colors.white.withValues(alpha: 0.2)
                  : Colors.white.withValues(alpha: 0.1),
            ),
            child: Icon(
              icon,
              color: Colors.white,
              size: 24,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: GoogleFonts.lexend(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: Colors.white.withValues(alpha: 0.7),
            ),
          ),
        ],
      ),
    );
  }
}
