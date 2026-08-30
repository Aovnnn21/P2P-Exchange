import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';
import '../config/supabase_config.dart';

class DeviceService {
  final SupabaseClient _client = SupabaseConfig.client;
  final DeviceInfoPlugin _deviceInfo = DeviceInfoPlugin();

  Future<String> getDeviceId() async {
    if (defaultTargetPlatform == TargetPlatform.iOS) {
      final iosInfo = await _deviceInfo.iosInfo;
      return iosInfo.identifierForVendor ?? 'unknown';
    } else {
      final androidInfo = await _deviceInfo.androidInfo;
      return androidInfo.id ?? 'unknown';
    }
  }

  Future<String> getDeviceName() async {
    if (defaultTargetPlatform == TargetPlatform.iOS) {
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
    final deviceType = defaultTargetPlatform == TargetPlatform.iOS ? 'ios' : 'android';

    await _client.from('device_sessions').insert({
      'user_id': userId,
      'device_id': deviceId,
      'device_name': deviceName,
      'device_type': deviceType,
      'last_active': DateTime.now().toIso8601String(),
      'is_active': true,
    });
  }
}
