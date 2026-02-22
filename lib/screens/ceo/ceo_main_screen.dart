import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../widgets/clock_widget.dart';
import 'notice_create_screen.dart';

class CeoMainScreen extends StatefulWidget {
  const CeoMainScreen({super.key});

  @override
  State<CeoMainScreen> createState() => _CeoMainScreenState();
}

class _CeoMainScreenState extends State<CeoMainScreen> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  List<Widget> get _widgetOptions => <Widget>[
    _CeoHomeView(onNavigate: _onItemTapped),
    const _CeoHistoryView(),
    const _CeoEmployeeManageView(),
    const _CeoNoticeView(),
  ];

  void _showProfileBottomSheet(BuildContext context) {
    bool isEditing = false;
    String name = '김대표';
    String role = '대표이사';
    String joinDate = '2020.01.01';
    String phone = '010-9999-9999';
    String email = 'ceo@hnhtech.com';

    final roleController = TextEditingController(text: role);
    final phoneController = TextEditingController(text: phone);
    final emailController = TextEditingController(text: email);

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setModalState) {
            return SafeArea(
              child: Padding(
                padding: EdgeInsets.only(
                  left: 24.0, right: 24.0, top: 24.0,
                  bottom: MediaQuery.of(context).viewInsets.bottom + 24.0,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          '내 정보',
                          style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800, color: Color(0xFF191F28)),
                        ),
                        if (!isEditing)
                          TextButton(
                            onPressed: () {
                              setModalState(() {
                                isEditing = true;
                              });
                            },
                            child: const Text('수정', style: TextStyle(color: Color(0xFF34C759), fontWeight: FontWeight.w700, fontSize: 16)),
                          ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    _buildProfileItem('이름', name),
                    if (isEditing) ...[
                      _buildEditItem('직급', roleController),
                      _buildProfileItem('입사일', joinDate),
                      _buildEditItem('연락처', phoneController),
                      _buildEditItem('이메일', emailController),
                    ] else ...[
                      _buildProfileItem('직급', role),
                      _buildProfileItem('입사일', joinDate),
                      _buildProfileItem('연락처', phone),
                      _buildProfileItem('이메일', email),
                    ],
                    const SizedBox(height: 24),
                    if (isEditing)
                      SizedBox(
                        width: double.infinity,
                        height: 56,
                        child: ElevatedButton(
                          onPressed: () {
                            setModalState(() {
                              role = roleController.text;
                              phone = phoneController.text;
                              email = emailController.text;
                              isEditing = false;
                            });
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF34C759),
                            foregroundColor: Colors.white,
                            elevation: 0,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                          ),
                          child: const Text('저장하기', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
                        ),
                      )
                    else
                      SizedBox(
                        width: double.infinity,
                        height: 56,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                            Navigator.pushReplacementNamed(context, '/login');
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFF2F4F6),
                            foregroundColor: const Color(0xFFF04452),
                            elevation: 0,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                          ),
                          child: const Text('로그아웃', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
                        ),
                      ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildEditItem(String title, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: 80,
            child: Text(title, style: const TextStyle(fontSize: 15, color: Color(0xFF8B95A1), fontWeight: FontWeight.w500)),
          ),
          Expanded(
            child: Container(
              height: 48,
              decoration: BoxDecoration(
                color: const Color(0xFFF2F4F6),
                borderRadius: BorderRadius.circular(12),
              ),
              child: TextField(
                controller: controller,
                style: const TextStyle(fontSize: 15, color: Color(0xFF333D4B), fontWeight: FontWeight.w600),
                decoration: const InputDecoration(
                  contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileItem(String title, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: const TextStyle(fontSize: 15, color: Color(0xFF8B95A1), fontWeight: FontWeight.w500)),
          Text(value, style: const TextStyle(fontSize: 15, color: Color(0xFF333D4B), fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: const Color(0xFFE8F8EE),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Icon(Icons.business_rounded, color: Color(0xFF34C759)),
                      ),
                      const SizedBox(width: 12),
                      const Text(
                        '(주) HNH Tech', // Replace with dynamic company name later if needed
                        style: TextStyle(fontSize: 24, fontWeight: FontWeight.w800, color: Color(0xFF191F28)),
                      ),
                    ],
                  ),
                  IconButton(
                    icon: const Icon(Icons.settings_rounded, color: Color(0xFF8B95A1)),
                    onPressed: () => _showProfileBottomSheet(context),
                  )
                ],
              ),
            ),
            Expanded(
              child: _widgetOptions.elementAt(_selectedIndex),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.03),
              offset: const Offset(0, -5),
              blurRadius: 10,
            ),
          ],
        ),
        child: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Padding(padding: EdgeInsets.only(bottom: 4), child: Icon(Icons.home_rounded)),
              label: '홈',
            ),
            BottomNavigationBarItem(
              icon: Padding(padding: EdgeInsets.only(bottom: 4), child: Icon(Icons.history_rounded)),
              label: '히스토리',
            ),
            BottomNavigationBarItem(
              icon: Padding(padding: EdgeInsets.only(bottom: 4), child: Icon(Icons.people_rounded)),
              label: '직원관리',
            ),
            BottomNavigationBarItem(
              icon: Padding(padding: EdgeInsets.only(bottom: 4), child: Icon(Icons.campaign_rounded)),
              label: '공지사항',
            ),
          ],
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          selectedLabelStyle: const TextStyle(fontWeight: FontWeight.w700, fontSize: 12),
          unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.w500, fontSize: 12),
        ),
      ),
    );
  }
}

class _CeoHomeView extends StatelessWidget {
  final Function(int) onNavigate;

  const _CeoHomeView({required this.onNavigate});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(24.0),
      children: [
        const Text(
          '사장님,\n오늘도 화이팅하세요!',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.w800, color: Color(0xFF191F28), height: 1.4),
        ),
        const SizedBox(height: 12),
        const ClockWidget(
          textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Color(0xFF8B95A1)),
        ),
        const SizedBox(height: 32),
        
        // Current Work Status Section
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('현재 직원 근무 현황', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: Color(0xFF191F28))),
            TextButton(
              onPressed: () => onNavigate(2), // Navigate to Employee Manage
              child: const Text('전체보기', style: TextStyle(color: Color(0xFF8B95A1), fontWeight: FontWeight.w600)),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 28),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: const Color(0xFFF2F4F6), width: 1.5),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.02),
                blurRadius: 10,
                offset: const Offset(0, 4),
              )
            ]
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildStatItem('출근자', '12', const Color(0xFF34C759)),
              Container(width: 1, height: 50, color: const Color(0xFFF2F4F6)),
              _buildStatItem('미출근', '3', const Color(0xFFF04452)),
              Container(width: 1, height: 50, color: const Color(0xFFF2F4F6)),
              _buildStatItem('휴가', '2', const Color(0xFFF9A825)),
            ],
          ),
        ),
        const SizedBox(height: 16),
        SizedBox(
          width: double.infinity,
          height: 56,
          child: ElevatedButton.icon(
            onPressed: () {
              showDialog(
                context: context,
                builder: (ctx) => AlertDialog(
                  backgroundColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
                  title: const Text('직원 초대', style: TextStyle(fontWeight: FontWeight.w800, color: Color(0xFF191F28))),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text('아래 회사 코드를 직원에게 공유하여\n회원가입 시 입력하도록 안내해주세요.', textAlign: TextAlign.center, style: TextStyle(color: Color(0xFF4E5968), height: 1.5)),
                      const SizedBox(height: 24),
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF2F4F6),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Flexible(
                              child: Text(
                                'HNH-2026-CEO',
                                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800, color: Color(0xFF34C759), letterSpacing: 1.0),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            const SizedBox(width: 12),
                            InkWell(
                              onTap: () {
                                Clipboard.setData(const ClipboardData(text: 'HNH-2026-CEO'));
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text('회사 코드가 복사되었습니다.'), behavior: SnackBarBehavior.floating),
                                );
                              },
                              borderRadius: BorderRadius.circular(8),
                              child: Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(color: const Color(0xFFE5E8EB)),
                                ),
                                child: const Icon(Icons.copy_rounded, color: Color(0xFF8B95A1), size: 20),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(ctx),
                      child: const Text('확인', style: TextStyle(color: Color(0xFF34C759), fontWeight: FontWeight.w700, fontSize: 16)),
                    ),
                  ],
                ),
              );
            },
            icon: const Icon(Icons.person_add_rounded, size: 20),
            label: const Text('직원 초대하기', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFE8F8EE),
              foregroundColor: const Color(0xFF34C759),
              elevation: 0,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            ),
          ),
        ),
        const SizedBox(height: 40),

        // Navigation Cards
        const Text('바로가기', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: Color(0xFF191F28))),
        const SizedBox(height: 16),
        Column(
          children: [
            _buildNavCard(
              title: '히스토리',
              subtitle: '직원들의 출퇴근 기록을 확인하세요',
              icon: Icons.history_rounded,
              color: const Color(0xFF3182F6),
              onTap: () => onNavigate(1),
            ),
            const SizedBox(height: 12),
            _buildNavCard(
              title: '직원관리',
              subtitle: '직원 정보를 관리하고 확인하세요',
              icon: Icons.people_rounded,
              color: const Color(0xFF34C759),
              onTap: () => onNavigate(2),
            ),
            const SizedBox(height: 12),
            _buildNavCard(
              title: '공지사항',
              subtitle: '새로운 공지를 등록하거나 확인하세요',
              icon: Icons.campaign_rounded,
              color: const Color(0xFFF9A825),
              onTap: () => onNavigate(3),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildStatItem(String title, String count, Color color) {
    return Column(
      children: [
        Text(title, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Color(0xFF8B95A1))),
        const SizedBox(height: 12),
        Text(
          count,
          style: TextStyle(fontSize: 32, fontWeight: FontWeight.w800, color: color),
        ),
      ],
    );
  }

  Widget _buildNavCard({required String title, required String subtitle, required IconData icon, required Color color, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: const Color(0xFFF2F4F6), width: 1.5),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Icon(icon, color: color, size: 28),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: Color(0xFF191F28))),
                  const SizedBox(height: 4),
                  Text(subtitle, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500, color: Color(0xFF8B95A1))),
                ],
              ),
            ),
            const Icon(Icons.chevron_right_rounded, color: Color(0xFFB0B8C1)),
          ],
        ),
      ),
    );
  }
}

class _CeoHistoryView extends StatefulWidget {
  const _CeoHistoryView();

  @override
  State<_CeoHistoryView> createState() => _CeoHistoryViewState();
}

class _CeoHistoryViewState extends State<_CeoHistoryView> {
  DateTime _selectedDate = DateTime.now();

  void _onPreviousDay() {
    setState(() {
      _selectedDate = _selectedDate.subtract(const Duration(days: 1));
    });
  }

  void _onNextDay() {
    setState(() {
      _selectedDate = _selectedDate.add(const Duration(days: 1));
    });
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2101),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: Color(0xFF34C759), // header background color
              onPrimary: Colors.white, // header text color
              onSurface: Color(0xFF191F28), // body text color
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: const Color(0xFF34C759), // button text color
              ),
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    String formattedDate = '${_selectedDate.year}년 ${_selectedDate.month}월 ${_selectedDate.day}일';

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: const Icon(Icons.chevron_left_rounded, color: Color(0xFF8B95A1), size: 32),
                onPressed: _onPreviousDay,
              ),
              GestureDetector(
                onTap: () => _selectDate(context),
                child: Row(
                  children: [
                    Text(
                      formattedDate,
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: Color(0xFF191F28)),
                    ),
                    const SizedBox(width: 4),
                    const Icon(Icons.calendar_today_rounded, size: 16, color: Color(0xFF8B95A1)),
                  ],
                ),
              ),
              IconButton(
                icon: const Icon(Icons.chevron_right_rounded, color: Color(0xFF8B95A1), size: 32),
                onPressed: _onNextDay,
              ),
            ],
          ),
        ),
        Expanded(
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0),
            itemCount: 15,
            separatorBuilder: (context, index) => const SizedBox(height: 12),
            itemBuilder: (context, index) {
              return Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        color: const Color(0xFFE8F8EE),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: const Icon(Icons.person, color: Color(0xFF34C759)),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('직원 ${index + 1}', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: Color(0xFF191F28))),
                          const SizedBox(height: 4),
                          const Text('08:50 - 18:00', style: TextStyle(fontSize: 14, color: Color(0xFF8B95A1))),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF2F4F6),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Text('정상출근', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: Color(0xFF333D4B))),
                    )
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

class _CeoEmployeeManageView extends StatefulWidget {
  const _CeoEmployeeManageView();

  @override
  State<_CeoEmployeeManageView> createState() => _CeoEmployeeManageViewState();
}

class _CeoEmployeeManageViewState extends State<_CeoEmployeeManageView> {
  final TextEditingController _searchController = TextEditingController();
  
  String? _expandedEmployeeId;

  // Dummy data represents employees
  List<Map<String, String>> employees = List.generate(
    10,
    (index) => {
      'id': 'emp_${index + 1}',
      'name': '직원 ${index + 1}',
      'position': index % 3 == 0 ? '기획팀' : (index % 2 == 0 ? '디자인팀' : '개발팀'),
      'rank': index == 0 ? '팀장' : '사원',
      'joinDate': '2023.01.${(index + 1).toString().padLeft(2, '0')}',
      'phone': '010-1234-567$index',
      'email': 'emp${index + 1}@hnhtech.com',
    },
  );
  
  List<Map<String, String>> filteredEmployees = [];

  @override
  void initState() {
    super.initState();
    filteredEmployees = employees;
  }

  void _filterEmployees(String query) {
    setState(() {
      if (query.isEmpty) {
        filteredEmployees = employees;
      } else {
        filteredEmployees = employees
            .where((emp) => emp['name']!.toLowerCase().contains(query.toLowerCase()))
            .toList();
      }
    });
  }

  void _deleteEmployee(String id) {
    // Show confirmation dialog before deleting
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text('직원 삭제', style: TextStyle(fontWeight: FontWeight.w800)),
        content: const Text('해당 직원을 정말 삭제하시겠습니까?\n삭제 후에는 복구할 수 없습니다.', style: TextStyle(color: Color(0xFF4E5968))),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('취소', style: TextStyle(color: Color(0xFF8B95A1), fontWeight: FontWeight.w600)),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                employees.removeWhere((emp) => emp['id'] == id);
                _filterEmployees(_searchController.text);
              });
              Navigator.pop(ctx);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('삭제되었습니다.'), behavior: SnackBarBehavior.floating),
              );
            },
            child: const Text('삭제', style: TextStyle(color: Color(0xFFF04452), fontWeight: FontWeight.w600)),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(24.0),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
            ),
            child: TextField(
              controller: _searchController,
              onChanged: _filterEmployees,
              style: const TextStyle(fontSize: 16, color: Color(0xFF191F28), fontWeight: FontWeight.w500),
              decoration: InputDecoration(
                hintText: '직원명(닉네임) 검색',
                hintStyle: const TextStyle(color: Color(0xFF8B95A1), fontSize: 16),
                prefixIcon: const Icon(Icons.search, color: Color(0xFF8B95A1)),
                contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                border: InputBorder.none,
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: const BorderSide(color: Color(0xFF34C759), width: 2),
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: filteredEmployees.isEmpty
              ? const Center(
                  child: Text('검색 결과가 없습니다.', style: TextStyle(color: Color(0xFF8B95A1), fontSize: 16)),
                )
              : ListView.separated(
                  padding: const EdgeInsets.only(left: 24, right: 24, bottom: 24),
                  itemCount: filteredEmployees.length,
                  separatorBuilder: (context, index) => const SizedBox(height: 12),
                  itemBuilder: (context, index) {
                    final emp = filteredEmployees[index];
                    final isExpanded = _expandedEmployeeId == emp['id'];

                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          if (isExpanded) {
                            _expandedEmployeeId = null;
                          } else {
                            _expandedEmployeeId = emp['id'];
                          }
                        });
                      },
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          border: isExpanded ? Border.all(color: const Color(0xFF34C759), width: 1.5) : Border.all(color: Colors.transparent, width: 1.5),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Container(
                                  width: 48,
                                  height: 48,
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFF2F4F6),
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  child: const Icon(Icons.person, color: Color(0xFF8B95A1)),
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(emp['name']!, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: Color(0xFF191F28))),
                                      const SizedBox(height: 4),
                                      Text(emp['position']!, style: const TextStyle(fontSize: 14, color: Color(0xFF8B95A1))),
                                    ],
                                  ),
                                ),
                                IconButton(
                                  icon: const Icon(Icons.delete_outline, color: Color(0xFFF04452)),
                                  onPressed: () => _deleteEmployee(emp['id']!),
                                ),
                                Icon(
                                  isExpanded ? Icons.expand_less_rounded : Icons.expand_more_rounded,
                                  color: const Color(0xFFB0B8C1),
                                ),
                              ],
                            ),
                            if (isExpanded) ...[
                              const Padding(
                                padding: EdgeInsets.symmetric(vertical: 16),
                                child: Divider(height: 1, color: Color(0xFFF2F4F6)),
                              ),
                              _buildEmployeeDetailRow('이름', emp['name']!),
                              const SizedBox(height: 12),
                              _buildEmployeeDetailRow('부서(포지션)', emp['position']!),
                              const SizedBox(height: 12),
                              _buildEmployeeDetailRow('직급', emp['rank']!),
                              const SizedBox(height: 12),
                              _buildEmployeeDetailRow('입사일', emp['joinDate']!),
                              const SizedBox(height: 12),
                              _buildEmployeeDetailRow('연락처', emp['phone']!),
                              const SizedBox(height: 12),
                              _buildEmployeeDetailRow('이메일', emp['email']!),
                              const SizedBox(height: 16),
                              Align(
                                alignment: Alignment.centerRight,
                                child: TextButton(
                                  onPressed: () {
                                    setState(() {
                                      _expandedEmployeeId = null;
                                    });
                                  },
                                  style: TextButton.styleFrom(
                                    backgroundColor: const Color(0xFFF2F4F6),
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                                  ),
                                  child: const Text('닫기', style: TextStyle(color: Color(0xFF4E5968), fontWeight: FontWeight.w600)),
                                ),
                              ),
                            ]
                          ],
                        ),
                      ),
                    );
                  },
                ),
        ),
      ],
    );
  }

  Widget _buildEmployeeDetailRow(String title, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: const TextStyle(fontSize: 14, color: Color(0xFF8B95A1), fontWeight: FontWeight.w500)),
        Text(value, style: const TextStyle(fontSize: 14, color: Color(0xFF333D4B), fontWeight: FontWeight.w600)),
      ],
    );
  }
}

class _CeoNoticeView extends StatefulWidget {
  const _CeoNoticeView();

  @override
  State<_CeoNoticeView> createState() => _CeoNoticeViewState();
}

class _CeoNoticeViewState extends State<_CeoNoticeView> {
  String? _expandedNoticeId;
  final ScrollController _scrollController = ScrollController();
  bool _isLoading = false;
  final int _itemsPerPage = 15;

  // Dummy data for notices
  List<Map<String, String>> notices = [];

  @override
  void initState() {
    super.initState();
    _loadMoreData();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent - 200 && !_isLoading) {
        _loadMoreData();
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _loadMoreData() async {
    if (_isLoading) return;
    setState(() {
      _isLoading = true;
    });

    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 800));

    // Generate more dummy data
    List<Map<String, String>> newNotices = List.generate(
      _itemsPerPage,
      (index) {
        int noticeIndex = notices.length + index;
        return {
          'id': 'notice_$noticeIndex',
          'title': '공지사항 제목 ${noticeIndex + 1}',
          'date': '2023-10-${(31 - (noticeIndex % 31)).toString().padLeft(2, '0')}',
          'content': '아래는 공지사항의 상세 내용입니다. 이 영역이 확장되어 보이게 되며, 닫기 버튼을 누르면 이 영역이 사라집니다. 여러 줄의 내용이 들어갈 수 있습니다.',
        };
      }
    );

    if (mounted) {
      setState(() {
        notices.addAll(newNotices);
        _isLoading = false;
      });
    }
  }

  void _deleteNotice(String id) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text('공지 삭제', style: TextStyle(fontWeight: FontWeight.w800)),
        content: const Text('이 공지사항을 정말 삭제하시겠습니까?\n삭제 후에는 복구할 수 없습니다.', style: TextStyle(color: Color(0xFF4E5968))),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('취소', style: TextStyle(color: Color(0xFF8B95A1), fontWeight: FontWeight.w600)),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                notices.removeWhere((notice) => notice['id'] == id);
              });
              Navigator.pop(ctx);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('공지가 삭제되었습니다.'), behavior: SnackBarBehavior.floating),
              );
            },
            child: const Text('삭제', style: TextStyle(color: Color(0xFFF04452), fontWeight: FontWeight.w600)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 24, right: 24, top: 16, bottom: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton.icon(
                onPressed: () async {
                  final newNotice = await Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const NoticeCreateScreen()),
                  );
                  if (newNotice != null && newNotice is Map<String, String>) {
                    setState(() {
                      notices.insert(0, {
                        'id': 'notice_${DateTime.now().millisecondsSinceEpoch}',
                        'title': newNotice['title']!,
                        'date': newNotice['date']!,
                        'content': newNotice['content']!,
                      });
                    });
                    if (context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('새 공지가 등록되었습니다.'), behavior: SnackBarBehavior.floating),
                      );
                    }
                  }
                },
                icon: const Icon(Icons.add, color: Color(0xFF34C759)),
                label: const Text('공지 등록', style: TextStyle(color: Color(0xFF34C759), fontWeight: FontWeight.w700)),
              )
            ],
          ),
        ),
        Expanded(
          child: notices.isEmpty
              ? const Center(
                  child: Text('등록된 공지사항이 없습니다.', style: TextStyle(color: Color(0xFF8B95A1), fontSize: 16)),
                )
              : ListView.separated(
                  controller: _scrollController,
                  padding: const EdgeInsets.only(left: 24, right: 24, bottom: 24),
                  itemCount: notices.length + (_isLoading ? 1 : 0),
                  separatorBuilder: (context, index) => const SizedBox(height: 12),
                  itemBuilder: (context, index) {
                    if (index == notices.length) {
                      return const Padding(
                        padding: EdgeInsets.symmetric(vertical: 20),
                        child: Center(child: CircularProgressIndicator(color: Color(0xFF34C759))),
                      );
                    }
                    final notice = notices[index];
                    final isExpanded = _expandedNoticeId == notice['id'];

                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          if (isExpanded) {
                            _expandedNoticeId = null;
                          } else {
                            _expandedNoticeId = notice['id'];
                          }
                        });
                      },
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          border: isExpanded ? Border.all(color: const Color(0xFF34C759), width: 1.5) : Border.all(color: Colors.transparent, width: 1.5),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(12),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFF2F4F6),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: const Icon(Icons.campaign_rounded, color: Color(0xFF4E5968)),
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(notice['title']!, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Color(0xFF191F28))),
                                      const SizedBox(height: 4),
                                      Text(notice['date']!, style: const TextStyle(fontSize: 14, color: Color(0xFF8B95A1))),
                                    ],
                                  ),
                                ),
                                IconButton(
                                  icon: const Icon(Icons.delete_outline, color: Color(0xFFF04452)),
                                  onPressed: () => _deleteNotice(notice['id']!),
                                ),
                                Icon(
                                  isExpanded ? Icons.expand_less_rounded : Icons.expand_more_rounded,
                                  color: const Color(0xFFB0B8C1),
                                ),
                              ],
                            ),
                            if (isExpanded) ...[
                              const Padding(
                                padding: EdgeInsets.symmetric(vertical: 16),
                                child: Divider(height: 1, color: Color(0xFFF2F4F6)),
                              ),
                              Text(
                                notice['content']!,
                                style: const TextStyle(fontSize: 15, color: Color(0xFF4E5968), height: 1.6),
                              ),
                              const SizedBox(height: 16),
                              Align(
                                alignment: Alignment.centerRight,
                                child: TextButton(
                                  onPressed: () {
                                    setState(() {
                                      _expandedNoticeId = null;
                                    });
                                  },
                                  style: TextButton.styleFrom(
                                    backgroundColor: const Color(0xFFF2F4F6),
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                                  ),
                                  child: const Text('닫기', style: TextStyle(color: Color(0xFF4E5968), fontWeight: FontWeight.w600)),
                                ),
                              ),
                            ]
                          ],
                        ),
                      ),
                    );
                  },
                ),
        ),
      ],
    );
  }
}
