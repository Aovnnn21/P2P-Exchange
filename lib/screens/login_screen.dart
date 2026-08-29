import 'package:flutter/material.dart';
import '../services/auth_service.dart';
import '../services/two_factor_service.dart';
import '../config/supabase_config.dart';
import 'home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final AuthService _authService = AuthService();
  final TwoFactorService _2faService = TwoFactorService();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _otpController = TextEditingController();
  bool _isLoading = false;
  bool _isLogin = true;
  String? _currentUserId;

  Future<void> _submit() async {
    setState(() => _isLoading = true);
    try {
      if (_isLogin) {
        final response = await _authService.signIn(
          email: _emailController.text.trim(), 
          password: _passwordController.text.trim()
        );
        
        // Check if 2FA is enabled
        if (response.user != null) {
          final is2FAEnabled = await _2faService.is2FAEnabled(response.user!.id);
          if (is2FAEnabled) {
            _currentUserId = response.user!.id;
            if (mounted) _show2FADialog();
            return; // Stop here, wait for OTP
          }
        }
        
        if (mounted) _navigateToHome();
      } else {
        await _authService.signUp(
          email: _emailController.text.trim(), 
          password: _passwordController.text.trim(), 
          username: 'User_${DateTime.now().millisecondsSinceEpoch}'
        );
        if (mounted) _navigateToHome();
      }
    } on AuthException catch (e) {
      if (mounted) ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.message)));
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  void _show2FADialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: const Text('Enter 2FA Code'),
        content: TextField(
          controller: _otpController,
          keyboardType: TextInputType.number,
          maxLength: 6,
          decoration: const InputDecoration(labelText: '6-digit OTP'),
        ),
        actions: [
          TextButton(
            onPressed: () async {
              final isValid = await _2faService.verify2FADuringLogin(_currentUserId!, _otpController.text.trim());
              if (isValid) {
                Navigator.pop(context); // Close dialog
                _navigateToHome();
              } else {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Invalid OTP')));
              }
            },
            child: const Text('Verify'),
          )
        ],
      ),
    );
  }

  void _navigateToHome() {
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const HomeScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(_isLogin ? 'Login' : 'Register')),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(controller: _emailController, decoration: const InputDecoration(labelText: 'Email'), keyboardType: TextInputType.emailAddress),
            const SizedBox(height: 16),
            TextField(controller: _passwordController, decoration: const InputDecoration(labelText: 'Password'), obscureText: true),
            const SizedBox(height: 24),
            SizedBox(width: double.infinity, child: ElevatedButton(onPressed: _isLoading ? null : _submit, child: _isLoading ? const CircularProgressIndicator() : Text(_isLogin ? 'Login' : 'Register'))),
            TextButton(onPressed: () => setState(() => _isLogin = !_Pressed: () => setState(() => _isLogin = !_isLogin), child: Text(_isLogin ? "DonisLogin), child: Text(_isLogin ? "Don't have an account? Register" : "Already have an't have an account? Register" : "Already have an account? Login")),
          ],
        ),
 account? Login")),
          ],
        ),
      ),
    );
  }
}
```      ),
    );
  }
}
