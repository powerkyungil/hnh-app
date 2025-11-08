import 'dart:math';

import 'package:flutter/material.dart';

import '../models/attendance_record.dart';
import '../models/company.dart';
import '../models/member.dart';
import '../services/location_service.dart';

class AppState extends ChangeNotifier {
  AppState();

  final List<Company> _companies = [];
  final Map<String, AttendanceRecord> _records = {};
  Member? _currentMember;

  Member? get currentMember => _currentMember;

  Company? get currentCompany {
    if (_currentMember == null) {
      return null;
    }
    return _companies.firstWhere(
      (company) => company.id == _currentMember!.companyId,
      orElse: () => throw StateError('Company not found'),
    );
  }

  List<Member> membersForCompany(String companyId) {
    return _companies
        .firstWhere((company) => company.id == companyId)
        .members;
  }

  AttendanceRecord? attendanceForToday(String memberId) {
    final todayKey = _recordKey(memberId, DateTime.now());
    return _records[todayKey];
  }

  String registerCompany({
    required String ownerName,
    required String ownerEmail,
    required String companyName,
    required double latitude,
    required double longitude,
  }) {
    final code = _generateCompanyCode();
    final companyId = UniqueKey().toString();
    final ownerId = UniqueKey().toString();

    final owner = Member(
      id: ownerId,
      name: ownerName,
      email: ownerEmail,
      role: MemberRole.owner,
      companyId: companyId,
    );

    final company = Company(
      id: companyId,
      name: companyName,
      code: code,
      latitude: latitude,
      longitude: longitude,
      ownerId: ownerId,
      members: [owner],
    );

    _companies.add(company);
    _currentMember = owner;
    notifyListeners();
    return code;
  }

  bool registerEmployee({
    required String name,
    required String email,
    required String companyCode,
  }) {
    try {
      final company = _companies.firstWhere(
        (company) => company.code.toLowerCase() == companyCode.toLowerCase(),
      );

      final member = Member(
        id: UniqueKey().toString(),
        name: name,
        email: email,
        role: MemberRole.employee,
        companyId: company.id,
      );

      company.members.add(member);
      _currentMember = member;
      notifyListeners();
      return true;
    } catch (_) {
      return false;
    }
  }

  bool login(String email, MemberRole role) {
    for (final company in _companies) {
      try {
        final member = company.members.firstWhere(
          (member) => member.email == email && member.role == role,
        );
        _currentMember = member;
        notifyListeners();
        return true;
      } catch (_) {
        continue;
      }
    }
    return false;
  }

  void logout() {
    _currentMember = null;
    notifyListeners();
  }

  Future<bool> checkIn({
    required LocationService locationService,
  }) async {
    final member = _currentMember;
    final company = currentCompany;
    if (member == null || company == null) {
      return false;
    }

    final isWithinRange = await locationService.isWithinRange(
      company.latitude,
      company.longitude,
      radiusInMeters: 300,
    );

    if (!isWithinRange) {
      return false;
    }

    final now = DateTime.now();
    final recordKey = _recordKey(member.id, now);
    final existing = _records[recordKey];
    final record = (existing ?? AttendanceRecord(memberId: member.id, date: now))
        .copyWith(checkInTime: TimeOfDay.fromDateTime(now));
    _records[recordKey] = record;
    notifyListeners();
    return true;
  }

  Future<bool> checkOut({
    required LocationService locationService,
  }) async {
    final member = _currentMember;
    final company = currentCompany;
    if (member == null || company == null) {
      return false;
    }

    final isWithinRange = await locationService.isWithinRange(
      company.latitude,
      company.longitude,
      radiusInMeters: 300,
    );

    if (!isWithinRange) {
      return false;
    }

    final now = DateTime.now();
    final recordKey = _recordKey(member.id, now);
    final existing = _records[recordKey] ??
        AttendanceRecord(memberId: member.id, date: now);
    _records[recordKey] =
        existing.copyWith(checkOutTime: TimeOfDay.fromDateTime(now));
    notifyListeners();
    return true;
  }

  String _generateCompanyCode() {
    final rng = Random.secure();
    const letters = 'ABCDEFGHJKLMNPQRSTUVWXYZ23456789';
    return List.generate(6, (_) => letters[rng.nextInt(letters.length)]).join();
  }

  String _recordKey(String memberId, DateTime date) {
    final normalized = DateTime(date.year, date.month, date.day);
    return '$memberId-${normalized.toIso8601String()}';
  }
}
