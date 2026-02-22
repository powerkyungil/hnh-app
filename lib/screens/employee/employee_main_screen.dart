import 'package:flutter/material.dart';
import '../../widgets/clock_widget.dart';

class EmployeeMainScreen extends StatefulWidget {
  const EmployeeMainScreen({super.key});

  @override
  State<EmployeeMainScreen> createState() => _EmployeeMainScreenState();
}

class _EmployeeMainScreenState extends State<EmployeeMainScreen> {
  int _selectedIndex = 0;

  static const List<Widget> _widgetOptions = <Widget>[
    _EmployeeHomeView(),
    _EmployeeHistoryView(),
    _EmployeeNoticeView(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _showProfileBottomSheet(BuildContext context) {
    bool isEditing = false;
    String name = '홍길동';
    String role = '사원';
    String joinDate = '2023.01.01';
    String phone = '010-1234-5678';
    String email = 'hong@hnhtech.com';

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
                          color: const Color(0xFFF2F4F6),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Icon(Icons.person_rounded, color: Color(0xFF4E5968)),
                      ),
                      const SizedBox(width: 12),
                      const Text(
                        '홍길동님', // Replace with actual logged-in user name
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

class _EmployeeHomeView extends StatefulWidget {
  const _EmployeeHomeView();

  @override
  State<_EmployeeHomeView> createState() => _EmployeeHomeViewState();
}

class _EmployeeHomeViewState extends State<_EmployeeHomeView> {
  String? _expandedNoticeId;

  final List<Map<String, String>> _recentNotices = [
    {
      'id': 'home_notice_0',
      'title': '이번주 금요일 단축근무 안내',
      'date': '2023-10-27',
      'content': '이번주 금요일은 회사 창립기념일로 인해 단축근무가 실시됩니다. 오후 3시 이후 자유롭게 퇴근하시면 됩니다.',
    },
    {
      'id': 'home_notice_1',
      'title': '11월 워크샵 일정 안내',
      'date': '2023-10-25',
      'content': '11월 10일~11일 양일간 팀 워크샵이 진행될 예정입니다. 장소 및 세부일정은 추후 공지드리겠습니다.',
    },
    {
      'id': 'home_notice_2',
      'title': '사내 주차장 이용 안내',
      'date': '2023-10-23',
      'content': '지하 2층 주차장 공사로 인해 11월 한 달간 지하 1층만 이용 가능합니다. 외부 주차장 이용 시 주차비를 지원합니다.',
    },
  ];


  void _showCheckInBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (BuildContext context) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  '지금 출근할까요?',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800, color: Color(0xFF191F28)),
                ),
                const SizedBox(height: 24),
                // Map Placeholder
                Container(
                  width: double.infinity,
                  height: 200,
                  decoration: BoxDecoration(
                    color: const Color(0xFFF2F4F6),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: const Color(0xFFE5E8EB), width: 1.5),
                  ),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Icon(Icons.map_rounded, size: 64, color: const Color(0xFFB0B8C1).withValues(alpha: 0.5)),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const SizedBox(height: 48), // push text below icon
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                            decoration: BoxDecoration(
                              color: Colors.white.withValues(alpha: 0.9),
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withValues(alpha: 0.05),
                                  blurRadius: 4,
                                  offset: const Offset(0, 2),
                                )
                              ]
                            ),
                            child: const Text('카카오맵 영역 (추후 연동)', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: Color(0xFF4E5968))),
                          ),
                        ],
                      ),
                      // Mock Location pin
                      const Positioned(
                        top: 70,
                        child: Icon(Icons.location_on, size: 40, color: Color(0xFFF04452)),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                Row(
                  children: [
                    Expanded(
                      child: TextButton(
                        onPressed: () => Navigator.pop(context),
                        style: TextButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          backgroundColor: const Color(0xFFF2F4F6),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                        ),
                        child: const Text('취소', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: Color(0xFF4E5968))),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('출근 처리가 완료되었어요 🎉'),
                              behavior: SnackBarBehavior.floating,
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          backgroundColor: const Color(0xFF34C759),
                          elevation: 0,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                        ),
                        child: const Text('출근하기', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: Colors.white)),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ListView(
          padding: const EdgeInsets.all(24.0),
          children: [
            const ClockWidget(
              textStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: Color(0xFF191F28)),
            ),
            const SizedBox(height: 24),
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
              ),
              child: Row(
                children: [
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFF4F4),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: const Icon(Icons.warning_rounded, color: Color(0xFFF04452)),
                  ),
                  const SizedBox(width: 16),
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('오늘 출근상태', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Color(0xFF8B95A1))),
                        SizedBox(height: 4),
                        Text('미출근', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800, color: Color(0xFF191F28))),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),
            const Text('최근 공지사항', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: Color(0xFF191F28))),
            const SizedBox(height: 16),
            ...List.generate(_recentNotices.length, (index) {
              final notice = _recentNotices[index];
              final isExpanded = _expandedNoticeId == notice['id'];
              return Padding(
                padding: EdgeInsets.only(bottom: index < _recentNotices.length - 1 ? 12 : 0),
                child: GestureDetector(
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
                      border: isExpanded
                          ? Border.all(color: const Color(0xFF34C759), width: 1.5)
                          : Border.all(color: Colors.transparent, width: 1.5),
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
                              child: const Icon(Icons.campaign_rounded, color: Color(0xFF4E5968), size: 20),
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
                            Icon(isExpanded ? Icons.expand_less_rounded : Icons.chevron_right_rounded, color: const Color(0xFFB0B8C1)),
                          ],
                        ),
                        if (isExpanded) ...[
                          const Divider(height: 32, color: Color(0xFFE5E8EB)),
                          Text(
                            notice['content']!,
                            style: const TextStyle(fontSize: 14, color: Color(0xFF4E5968), height: 1.6),
                          ),
                          const SizedBox(height: 12),
                          Align(
                            alignment: Alignment.centerRight,
                            child: TextButton(
                              onPressed: () {
                                setState(() {
                                  _expandedNoticeId = null;
                                });
                              },
                              child: const Text('닫기', style: TextStyle(color: Color(0xFF8B95A1), fontWeight: FontWeight.w600)),
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                ),
              );
            }),
            const SizedBox(height: 100), // padding for bottom button
          ],
        ),
        Positioned(
          left: 24,
          right: 24,
          bottom: 24,
          child: SizedBox(
            height: 56,
            child: ElevatedButton(
              onPressed: () => _showCheckInBottomSheet(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF34C759),
                elevation: 0,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              ),
              child: const Text('출근하기', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: Colors.white)),
            ),
          ),
        ),
      ],
    );
  }
}

class _EmployeeHistoryView extends StatefulWidget {
  const _EmployeeHistoryView();

  @override
  State<_EmployeeHistoryView> createState() => _EmployeeHistoryViewState();
}

class _EmployeeHistoryViewState extends State<_EmployeeHistoryView> {
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
              primary: Color(0xFF34C759),
              onPrimary: Colors.white,
              onSurface: Color(0xFF191F28),
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: const Color(0xFF34C759),
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
            itemCount: 1, // Only showing for selected date
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
                      child: const Icon(Icons.check_rounded, color: Color(0xFF34C759)),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('${_selectedDate.month}월 ${_selectedDate.day}일 출근기록', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: Color(0xFF191F28))),
                          const SizedBox(height: 4),
                          const Text('08:50 - 18:00', style: TextStyle(fontSize: 14, color: Color(0xFF8B95A1))),
                        ],
                      ),
                    ),
                    const Text('8H 10M', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: Color(0xFF34C759))),
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

class _EmployeeNoticeView extends StatefulWidget {
  const _EmployeeNoticeView();

  @override
  State<_EmployeeNoticeView> createState() => _EmployeeNoticeViewState();
}

class _EmployeeNoticeViewState extends State<_EmployeeNoticeView> {
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

  @override
  Widget build(BuildContext context) {
    return notices.isEmpty
        ? const Center(child: CircularProgressIndicator(color: Color(0xFF34C759)))
        : ListView.separated(
            controller: _scrollController,
            padding: const EdgeInsets.all(24.0),
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
    );
  }
}
