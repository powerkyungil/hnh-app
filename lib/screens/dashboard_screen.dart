import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';

import '../models/attendance_record.dart';
import '../models/member.dart';
import '../providers/app_state.dart';
import '../services/location_service.dart';
import '../widgets/company_map.dart';
import 'login_screen.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  static const routeName = '/dashboard';

  @override
  Widget build(BuildContext context) {
    final state = context.watch<AppState>();
    final member = state.currentMember;
    final company = state.currentCompany;

    if (member == null || company == null) {
      return const LoginScreen();
    }

    final locationService = LocationService(
      positionProvider: () async {
        final serviceEnabled = await Geolocator.isLocationServiceEnabled();
        if (!serviceEnabled) {
          throw LocationServiceDisabledException();
        }

        var permission = await Geolocator.checkPermission();
        if (permission == LocationPermission.denied) {
          permission = await Geolocator.requestPermission();
        }

        if (permission == LocationPermission.denied ||
            permission == LocationPermission.deniedForever) {
          throw PermissionDeniedException('위치 권한이 필요합니다.');
        }

        final position = await Geolocator.getCurrentPosition();
        return (latitude: position.latitude, longitude: position.longitude);
      },
    );

    return Scaffold(
      appBar: AppBar(
        title: Text('${company.name} 출퇴근 시스템'),
        actions: [
          IconButton(
            onPressed: () {
              context.read<AppState>().logout();
              Navigator.of(context)
                  .pushNamedAndRemoveUntil(LoginScreen.routeName, (_) => false);
            },
            icon: const Icon(Icons.logout),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            Text(
              '안녕하세요, ${member.name}님',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 8),
            Text(
              member.role == MemberRole.owner ? '오늘의 출퇴근 현황' : '오늘의 출퇴근 시간',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 16),
            CompanyMap(
              latitude: company.latitude,
              longitude: company.longitude,
            ),
            const SizedBox(height: 16),
            if (member.role == MemberRole.owner)
              _OwnerAttendanceOverview(companyId: company.id)
            else
              _EmployeeAttendanceCard(
                record: state.attendanceForToday(member.id),
              ),
            const SizedBox(height: 24),
            _AttendanceButtons(locationService: locationService)
          ],
        ),
      ),
    );
  }
}

class _OwnerAttendanceOverview extends StatelessWidget {
  const _OwnerAttendanceOverview({required this.companyId});

  final String companyId;

  @override
  Widget build(BuildContext context) {
    final state = context.watch<AppState>();
    final members = state.membersForCompany(companyId)
        .where((member) => member.role == MemberRole.employee)
        .toList();

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '직원 출퇴근 현황',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            if (members.isEmpty)
              const Text('등록된 직원이 없습니다.')
            else
              ...members.map((member) {
                final record = state.attendanceForToday(member.id);
                final checkIn = record?.checkInTime?.format(context) ?? '-';
                final checkOut = record?.checkOutTime?.format(context) ?? '-';
                return ListTile(
                  title: Text(member.name),
                  subtitle: Text('출근: $checkIn | 퇴근: $checkOut'),
                );
              })
          ],
        ),
      ),
    );
  }
}

class _EmployeeAttendanceCard extends StatelessWidget {
  const _EmployeeAttendanceCard({required this.record});

  final AttendanceRecord? record;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final checkIn = record?.checkInTime?.format(context) ?? '출근 기록 없음';
    final checkOut = record?.checkOutTime?.format(context) ?? '퇴근 기록 없음';
    final content = record == null
        ? '아직 출근하지 않았습니다.'
        : '출근: $checkIn\n퇴근: $checkOut';
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Text(
          content,
          style: theme.textTheme.bodyLarge,
        ),
      ),
    );
  }
}

class _AttendanceButtons extends StatefulWidget {
  const _AttendanceButtons({
    required this.locationService,
  });

  final LocationService locationService;

  @override
  State<_AttendanceButtons> createState() => _AttendanceButtonsState();
}

class _AttendanceButtonsState extends State<_AttendanceButtons> {
  bool _isProcessing = false;
  String? _statusMessage;

  @override
  Widget build(BuildContext context) {
    final state = context.watch<AppState>();
    final record = state.attendanceForToday(state.currentMember!.id);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        FilledButton.icon(
          onPressed: record?.hasCheckedIn == true || _isProcessing
              ? null
              : () => _handleAttendance(context, isCheckIn: true),
          icon: const Icon(Icons.login),
          label: const Text('출근'),
        ),
        const SizedBox(height: 12),
        FilledButton.icon(
          onPressed: record?.hasCheckedOut == true || _isProcessing
              ? null
              : () => _handleAttendance(context, isCheckIn: false),
          icon: const Icon(Icons.logout),
          label: const Text('퇴근'),
        ),
        if (_statusMessage != null) ...[
          const SizedBox(height: 12),
          Text(
            _statusMessage!,
            style: TextStyle(
              color: _statusMessage!.contains('성공')
                  ? Colors.green
                  : Colors.red,
            ),
          ),
        ]
      ],
    );
  }

  Future<void> _handleAttendance(BuildContext context,
      {required bool isCheckIn}) async {
    setState(() {
      _isProcessing = true;
      _statusMessage = null;
    });

    final appState = context.read<AppState>();
    try {
      final success = isCheckIn
          ? await appState.checkIn(locationService: widget.locationService)
          : await appState.checkOut(locationService: widget.locationService);

      setState(() {
        _isProcessing = false;
        _statusMessage = success
            ? (isCheckIn
                ? '출근 기록이 성공적으로 저장되었습니다.'
                : '퇴근 기록이 성공적으로 저장되었습니다.')
            : '회사 반경 300m 이내에서만 기록할 수 있습니다.';
      });
    } on PermissionDeniedException catch (error) {
      setState(() {
        _isProcessing = false;
        _statusMessage = error.message ?? '위치 권한이 필요합니다.';
      });
    } on LocationServiceDisabledException {
      setState(() {
        _isProcessing = false;
        _statusMessage = '기기의 위치 서비스가 비활성화되어 있습니다.';
      });
    } catch (_) {
      setState(() {
        _isProcessing = false;
        _statusMessage = '위치 정보를 확인하는 중 문제가 발생했습니다.';
      });
    }
  }
}
