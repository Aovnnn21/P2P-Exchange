import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import '../services/two_factor_service.dart';
import '../config/supabase_config.dart';

class TwoFactorSetupScreen extends StatefulWidget {
  const TwoFactorSetupScreen({super.key});

  @override
  State<TwoFactorSetupScreen> createState() => _TwoFactorSetupScreenState();
}

class _TwoFactorSetupScreenState extends State<TwoFactorSetupScreen> {
  final TwoFactorService _2faService = TwoFactorService();
  String? _secret;
  String? _qrData;
  final TextEditingController _otpController = TextEditingController();
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _generate2FA();
  }

  Future<void> _generate2FA() async {
    final userId = SupabaseConfig.client.auth.currentUser!.id;
    final email = SupabaseConfig.client.auth.currentUser!.email!;
    
    setState(() => _isLoading = true);
    
    final secret = _2faService.generateSecret();
    final qrData = _2faService.getQRCodeData(secret, email);
    
    setState(() {
      _secret = secret;
      _qrData = qrData;
      _isLoading = false;
    });
  }

  Future<void> _verifyAndEnable() async {
    if (_secret == null) return;
    
    final code = _otpController.text.trim();
    if (code.length != 6) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter 6-digit code')),
      );
      return;
    }

    setState(() => _isLoading = true);

    final isValid = _2faService.verifyOTP(_secret!, code);
    
    if (isValid) {
      final userId = SupabaseConfig.client.auth.currentUser!.id;
      await _2faService.enable2FA(userId, _secret!);
      
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('2FA Enabled Successfully!')),
        );
        Navigator.pop(context);
      }
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Invalid OTP code')),
        );
      }
    }
    
    setState(() => _isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Setup 2FA')),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text(
                    'Scan this QR code with Google Authenticator',
                    style: TextStyle(fontSize: 16),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 24),
                  if (_qrData != null)
                    Center(
                      child: QrImageView(
                        data: _qrData!,
                        version: QrVersions.auto,
                        size: 200.0,
                      ),
                    ),
                  const SizedBox(height: 16),
                  Text(
                    'Secret: $_secret',
                    style: const TextStyle(fontSize: 12, color: Colors.grey),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 24),
                  TextField(
                    controller: _otpController,
                    decoration: const InputDecoration(
                      labelText: 'Enter 6-digit OTP code',
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.number,
                    maxLength: 6,
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: _verifyAndEnable,
                    child: const Text('Verify & Enable 2FA'),
                  ),
                ],
              ),
            ),
    );
  }
}
