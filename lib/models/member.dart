enum MemberRole { owner, employee }

class Member {
  Member({
    required this.id,
    required this.name,
    required this.email,
    required this.role,
    required this.companyId,
  });

  final String id;
  final String name;
  final String email;
  final MemberRole role;
  final String companyId;
}
