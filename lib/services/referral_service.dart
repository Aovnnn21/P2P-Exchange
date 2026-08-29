import 'package:supabase_flutter/supabase_flutter.dart';
import '../config/supabase_config.dart';
import 'package:uuid/uuid.dart';

class ReferralService {
  final SupabaseClient _client = SupabaseConfig.client;

  // Generate unique referral code
  String generateReferralCode() {
    const uuid = Uuid();
    return uuid.v4().substring(0, 8).toUpperCase();
  }

  // Create referral code for user
  Future<void> createReferralCode(String userId) async {
    final code = generateReferralCode();
    
    await _client
        .from('profiles')
        .update({'referral_code': code})
        .eq('id', userId);
  }

  // Get user's referral code
  Future<String?> getReferralCode(String userId) async {
    final response = await _client
        .from('profiles')
        .select('referral_code')
        .eq('id', userId)
        .maybeSingle();
    
    return response?['referral_code'];
  }

  // Apply referral code
  Future<void> applyReferralCode({
    required String referrerCode,
    required String refereeId,
  }) async {
    // Find referrer
    final referrer = await _client
        .from('profiles')
        .select('id')
        .eq('referral_code', referrerCode)
        .maybeSingle();

    if (referrer == null) {
      throw Exception('Invalid referral code');
    }

    // Check if already used
    final existing = await _client
        .from('referrals')
        .select()
        .eq('referee_id', refereeId)
        .maybeSingle();

    if (existing != null) {
      throw Exception('Referral code already used');
    }

    // Create referral record
    await _client.from('referrals').insert({
      'referrer_id': referrer['id'],
      'referee_id': refereeId,
      'referral_code': referrerCode,
      'bonus_amount': 5000, // 5000 MMK bonus
    });

    // Update referrer stats
    await _client.rpc('increment_referral_count', params: {
      'user_id': referrer['id'],
    });
  }

  // Get referral stats
  Future<Map<String, dynamic>> getReferralStats(String userId) async {
    final response = await _client
        .from('profiles')
        .select('total_referrals, total_referral_bonus')
        .eq('id', userId)
        .maybeSingle();

    return response ?? {'total_referrals': 0, 'total_referral_bonus': 0};
  }
}
