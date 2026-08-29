import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:device_info_plus/device_info_plus.dart';
import '../config/supabase_config.dart';

class DeviceService {
  final SupabaseClient _client = SupabaseConfig.client;
  final DeviceInfoPlugin _deviceInfo = DeviceInfoPlugin();

  Future<String> getDeviceId() async {
    if (Theme.of(context).platform == TargetPlatform.iOS) {
      final iosInfo = await _deviceInfo.iosInfo;
      return iosInfo.identifierForVendor ?? 'unknown';
    } else {
      final androidInfo = await _deviceInfo.androidInfo;
      return androidInfo.id ?? 'unknown';
    }
  }

  Future<String> getDeviceName() async {
    if (Theme.of(context).platform == TargetPlatform.iOS) {
      final iosInfo = await _deviceInfo.iosInfo;
      return iosInfo.name ?? 'iOS Device';
    } else {
      final androidInfo = await _deviceInfo.androidInfo;
      return '${androidInfo.brand} ${androidInfo.model}';
    }
  }

  Future<void> registerSession() async {
    final userId = _client.auth.currentUser!.id;
    final deviceId = await getDeviceId();
    final deviceName = await getDeviceName();
    final deviceType = Theme.of(context).platform == TargetPlatform.iOS ? 'ios' : 'android';

    await _client.from('device_sessions').insert({
      'user_id': userId,
      'device_id': deviceId,
      'device_name': deviceName,
      'device_type': deviceType,
      'last_active': DateTime.now().toIso8601String(),
      'is_active': true,
    });
  }

  Future<List<Map<String, dynamic>>> getActiveSessions() async {
    final userId = _client.auth.currentUser!.id;
    
    final response = await _client
        .from('device_sessions')
        .select()
        .eq('user_id', userId)
        .eq('is_active', true)
        .order('last_active', ascending: false);

    return response;
  }

  Future<void> revokeSession(String sessionId) async {
    await _client
        .from('device_sessions')
        .update({'is_active': false})
        .eq('id', sessionId);
  }

  Future<void> revokeAllOtherSessions() async {
    final userId = _client.auth.currentUser!.id;
    final currentDeviceId = await getDeviceId();

    await _client
        .from('device_sessions')
        .update({'is_active': false})
        .eq('user_id', userId)
        .neq('device_id', currentDeviceId);
  }
}
