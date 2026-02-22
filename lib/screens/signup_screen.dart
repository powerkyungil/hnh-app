import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  bool _isCeo = true; // Toggle between CEO (true) and Employee (false)
  
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _codeController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _codeController.dispose();
    super.dispose();
  }

  void _signup() {
    if (!_isCeo && _codeController.text.trim().isEmpty) {
      _showError('회사 코드를 입력해주세요.');
      return;
    }
    if (_nameController.text.trim().isEmpty) {
      _showError('이름을 입력해주세요.');
      return;
    }
    if (_phoneController.text.trim().isEmpty) {
      _showError('연락처를 입력해주세요.');
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('가입이 완료되었습니다.'), behavior: SnackBarBehavior.floating),
    );
    Navigator.pop(context);
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), behavior: SnackBarBehavior.floating),
    );
  }

  Widget _buildTextField({
    required String hintText,
    required TextEditingController controller,
    List<TextInputFormatter>? inputFormatters,
    TextInputType? keyboardType,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: TextField(
        controller: controller,
        inputFormatters: inputFormatters,
        keyboardType: keyboardType,
        style: const TextStyle(fontSize: 16, color: Color(0xFF191F28), fontWeight: FontWeight.w500),
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: const TextStyle(color: Color(0xFF8B95A1), fontSize: 16),
          contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          border: InputBorder.none,
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: const BorderSide(color: Color(0xFF34C759), width: 2),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('회원가입'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                '환영합니다!\n역할을 선택하고 가입을 진행해주세요.',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF191F28),
                  height: 1.4,
                ),
              ),
              const SizedBox(height: 32),
              
              // Role Selection
              Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () => setState(() => _isCeo = true),
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        decoration: BoxDecoration(
                          color: _isCeo ? const Color(0xFF34C759) : Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: _isCeo ? const Color(0xFF34C759) : const Color(0xFFD1D6DB), width: 1.5),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          '사장님',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: _isCeo ? FontWeight.w700 : FontWeight.w600,
                            color: _isCeo ? Colors.white : const Color(0xFF8B95A1),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: GestureDetector(
                      onTap: () => setState(() => _isCeo = false),
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        decoration: BoxDecoration(
                          color: !_isCeo ? const Color(0xFF34C759) : Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: !_isCeo ? const Color(0xFF34C759) : const Color(0xFFD1D6DB), width: 1.5),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          '직원',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: !_isCeo ? FontWeight.w700 : FontWeight.w600,
                            color: !_isCeo ? Colors.white : const Color(0xFF8B95A1),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 32),
              
              const Text('기본 정보', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Color(0xFF4E5968))),
              const SizedBox(height: 12),

              if (!_isCeo) ...[
                _buildTextField(hintText: '회사 코드', controller: _codeController),
                const SizedBox(height: 12),
              ],
              
              _buildTextField(hintText: '이름', controller: _nameController),
              const SizedBox(height: 12),
              _buildTextField(
                hintText: '연락처 (숫자만 입력)',
                controller: _phoneController,
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              ),
              const SizedBox(height: 12),
              _buildTextField(
                hintText: '이메일 주소',
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
              ),
              
              const SizedBox(height: 48),
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: _signup,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF34C759),
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: const Text(
                    '가입 완료하기',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
