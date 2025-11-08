import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/app_state.dart';
import 'dashboard_screen.dart';

class RegisterCompanyScreen extends StatefulWidget {
  const RegisterCompanyScreen({super.key});

  static const routeName = '/register-company';

  @override
  State<RegisterCompanyScreen> createState() => _RegisterCompanyScreenState();
}

class _RegisterCompanyScreenState extends State<RegisterCompanyScreen> {
  final _formKey = GlobalKey<FormState>();
  final _ownerNameController = TextEditingController();
  final _ownerEmailController = TextEditingController();
  final _companyNameController = TextEditingController();
  final _latitudeController = TextEditingController();
  final _longitudeController = TextEditingController();
  String? _generatedCode;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('대표 회원가입')),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 480),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: ListView(
                shrinkWrap: true,
                children: [
                  TextFormField(
                    controller: _ownerNameController,
                    decoration: const InputDecoration(labelText: '대표 이름'),
                    validator: _requiredValidator,
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: _ownerEmailController,
                    decoration: const InputDecoration(labelText: '대표 이메일'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return '이메일을 입력해주세요';
                      }
                      if (!value.contains('@')) {
                        return '유효한 이메일을 입력해주세요';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: _companyNameController,
                    decoration: const InputDecoration(labelText: '회사명'),
                    validator: _requiredValidator,
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: _latitudeController,
                          decoration: const InputDecoration(labelText: '회사 위도'),
                          keyboardType:
                              const TextInputType.numberWithOptions(decimal: true),
                          validator: _requiredValidator,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: TextFormField(
                          controller: _longitudeController,
                          decoration: const InputDecoration(labelText: '회사 경도'),
                          keyboardType:
                              const TextInputType.numberWithOptions(decimal: true),
                          validator: _requiredValidator,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  FilledButton(
                    onPressed: () {
                      if (!_formKey.currentState!.validate()) {
                        return;
                      }
                      final code = context.read<AppState>().registerCompany(
                            ownerName: _ownerNameController.text.trim(),
                            ownerEmail: _ownerEmailController.text.trim(),
                            companyName: _companyNameController.text.trim(),
                            latitude:
                                double.parse(_latitudeController.text.trim()),
                            longitude:
                                double.parse(_longitudeController.text.trim()),
                          );
                      setState(() {
                        _generatedCode = code;
                      });
                      Navigator.of(context)
                          .pushReplacementNamed(DashboardScreen.routeName);
                    },
                    child: const Text('회사 등록'),
                  ),
                  if (_generatedCode != null) ...[
                    const SizedBox(height: 16),
                    Text(
                      '회사 코드: $_generatedCode',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ]
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  String? _requiredValidator(String? value) {
    if (value == null || value.isEmpty) {
      return '필수 입력 항목입니다';
    }
    return null;
  }
}
