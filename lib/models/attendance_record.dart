import 'package:flutter/material.dart';

class AttendanceRecord {
  AttendanceRecord({
    required this.memberId,
    required this.date,
    this.checkInTime,
    this.checkOutTime,
  });

  final String memberId;
  final DateTime date;
  final TimeOfDay? checkInTime;
  final TimeOfDay? checkOutTime;

  bool get hasCheckedIn => checkInTime != null;

  bool get hasCheckedOut => checkOutTime != null;

  AttendanceRecord copyWith({
    TimeOfDay? checkInTime,
    TimeOfDay? checkOutTime,
  }) {
    return AttendanceRecord(
      memberId: memberId,
      date: date,
      checkInTime: checkInTime ?? this.checkInTime,
      checkOutTime: checkOutTime ?? this.checkOutTime,
    );
  }
}
