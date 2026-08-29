import 'package:otp/otp.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../config/supabase_config.dart';

class TwoFactorService {
  final SupabaseClient _client = SupabaseConfig.client;

  // Generate 2FA Secret
  String generateSecret() {
    return OTP.randomSecret();
  }

  // Generate OTP URI for QR Code
  String generateOTPUri(String secret, String email) {
    return OTP.generateTOTPCodeString(
      secret,
      DateTime.now().millisecondsSinceEpoch,
      algorithm: Algorithm.SHA1,
      isGoogle: true,
    );
  }

  // Get QR Code Data
  String getQRCodeData(String secret, String email) {
    return 'otpauth://totp/P2PExchange:$email?secret=$secret&issuer=P2PExchange';
  }

  // Verify OTP Code
  bool verifyOTP(String secret, String code) {
    return OTP.verifyTOTP(
      secret,
      DateTime.now().millisecondsSinceEpoch,
      userCode: code,
      algorithm: Algorithm.SHA1,
    );
  }

  // Enable 2FA
  Future<void> enable2FA(String userId, String secret) async {
    await _client.from('two_factor_auth').upsert({
      'user_id': userId,
      'secret_key': secret,
      'is_enabled': true,
      'updated_at': DateTime.now().toIso8601String(),
    });
  }

  // Disable 2FA
  Future<void> disable2FA(String userId) async {
    await _client.from('two_factor_auth').update({
      'is_enabled': false,
      'updated_at': DateTime.now().toIso8601String(),
    }).eq('user_id', userId);
  }

  // Check if 2FA is enabled
  Future<bool> is2FAEnabled(String userId) async {
    final response = await _client
        .from('two_factor_auth')
        .select('is_enabled')
        .eq('user_id', userId)
        .maybeSingle();
    
    return response?['is_enabled'] ?? false;
  }

  // Verify during login
  Future<bool> verify2FADuringLogin(String userId, String code) async {
    final response = await _client
        .from('two_factor_auth')
        .select('secret_key, is_enabled')
        .eq('user_id', userId)
        .maybeSingle();

    if (response == null || response['is_enabled'] == false) {
      return true; // 2FA not enabled, allow login
    }

    return verifyOTP(response['secret_key'], code);
  }
}
