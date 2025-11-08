import 'member.dart';

class Company {
  Company({
    required this.id,
    required this.name,
    required this.code,
    required this.latitude,
    required this.longitude,
    required this.ownerId,
    List<Member>? members,
  }) : members = members ?? [];

  final String id;
  final String name;
  final String code;
  final double latitude;
  final double longitude;
  final String ownerId;
  final List<Member> members;

  Company copyWith({
    String? name,
    double? latitude,
    double? longitude,
    List<Member>? members,
  }) {
    return Company(
      id: id,
      name: name ?? this.name,
      code: code,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      ownerId: ownerId,
      members: members ?? this.members,
    );
  }
}
