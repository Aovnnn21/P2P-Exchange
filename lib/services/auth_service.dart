import 'package:supabase_flutter/supabase_flutter.dart';
import '../config/supabase_config.dart';
import 'device_service.dart';

class AuthService {
  final SupabaseClient _client = SupabaseConfig.client;

  Future<AuthResponse> signUp({required String email, required String password, required String username}) async {
    final response = await _client.auth.signUp(email: email, password: password);
    if (response.user != null) {
      await _client.from('profiles').insert({
        'id': response.user!.id, 
        'username': username, 
        'created_at': DateTime.now().toIso8601String()
      });
    }
    return response;
  }

  Future<AuthResponse> signIn({required String email, required String password}) async {
    final response = await _client.auth.signInWithPassword(email: email, password: password);
    
    // Register device session upon successful login
    if (response.user != null) {
      try {
        await DeviceService().registerSession();
      } catch (e) {
        print('Device registration failed: $e');
      }
    }
    return response;
  }

  Future<void> signOut() async { 
    await _client.auth.signOut(); 
  }
}
