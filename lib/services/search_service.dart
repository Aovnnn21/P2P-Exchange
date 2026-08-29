import 'package:supabase_flutter/supabase_flutter.dart';
import '../config/supabase_config.dart';

class SearchService {
  final SupabaseClient _client = SupabaseConfig.client;

  Future<List<Map<String, dynamic>>> searchExchangers({
    String? query,
    String? walletType,
    double? minRate,
    double? maxRate,
    double? minCompletionRate,
    String? sortBy,
    bool ascending = false,
  }) async {
    var queryBuilder = _client
        .from('exchange_listings')
        .select('''
          *,
          seller:profiles!seller_id(username, full_name, avatar_url, completion_rate, total_trades)
        ''')
        .eq('is_active', true);

    // Search by username
    if (query != null && query.isNotEmpty) {
      queryBuilder = queryBuilder.ilike('seller.username', '%$query%');
    }

    // Filter by wallet type
    if (walletType != null) {
      queryBuilder = queryBuilder
          .or('from_wallet.eq.$walletType,to_wallet.eq.$walletType');
    }

    // Filter by rate range
    if (minRate != null) {
      queryBuilder = queryBuilder.gte('rate', minRate);
    }
    if (maxRate != null) {
      queryBuilder = queryBuilder.lte('rate', maxRate);
    }

    // Filter by completion rate
    if (minCompletionRate != null) {
      queryBuilder = queryBuilder.gte('seller.completion_rate', minCompletionRate);
    }

    // Sort
    if (sortBy != null) {
      queryBuilder = queryBuilder.order(sortBy, ascending: ascending);
    } else {
      queryBuilder = queryBuilder.order('created_at', ascending: false);
    }

    final response = await queryBuilder;
    return response;
  }
}
