import 'package:hive_flutter/hive_flutter.dart';

class OfflineCacheService {
  static const String _transactionsBox = 'transactions';
  static const String _messagesBox = 'messages';
  static const String _profilesBox = 'profiles';

  static Future<void> initialize() async {
    await Hive.initFlutter();
    await Hive.openBox(_transactionsBox);
    await Hive.openBox(_messagesBox);
    await Hive.openBox(_profilesBox);
  }

  // Cache Transactions
  static Future<void> cacheTransactions(List<Map<String, dynamic>> transactions) async {
    final box = Hive.box(_transactionsBox);
    await box.put('recent_transactions', transactions);
  }

  static List<Map<String, dynamic>> getCachedTransactions() {
    final box = Hive.box(_transactionsBox);
    return List<Map<String, dynamic>>.from(box.get('recent_transactions') ?? []);
  }

  // Cache Messages
  static Future<void> cacheMessages(String conversationId, List<Map<String, dynamic>> messages) async {
    final box = Hive.box(_messagesBox);
    await box.put(conversationId, messages);
  }

  static List<Map<String, dynamic>> getCachedMessages(String conversationId) {
    final box = Hive.box(_messagesBox);
    return List<Map<String, dynamic>>.from(box.get(conversationId) ?? []);
  }

  // Cache Profiles
  static Future<void> cacheProfile(String userId, Map<String, dynamic> profile) async {
    final box = Hive.box(_profilesBox);
    await box.put(userId, profile);
  }

  static Map<String, dynamic>? getCachedProfile(String userId) {
    final box = Hive.box(_profilesBox);
    return Map<String, dynamic>.from(box.get(userId) ?? {});
  }

  // Clear Cache
  static Future<void> clearCache() async {
    await Hive.box(_transactionsBox).clear();
    await Hive.box(_messagesBox).clear();
    await Hive.box(_profilesBox).clear();
  }
}
