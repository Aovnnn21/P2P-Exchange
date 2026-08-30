import 'package:supabase_flutter/supabase_flutter.dart'; // သို့မဟုတ် သင့် package အမည်

class SearchService {
  final SupabaseClient _supabase = Supabase.instance.client;

  // ဥပမာ Function တစ်ခု
  Future<List<Map<String, dynamic>>> getSearchResults({
    String? sortBy,
    bool ascending = true,
  }) async {
    try {
      // ပြင်ဆင်ထားသည်: 'PostgrestFilterBuilder' ဟု Strict Type မသတ်မှတ်ဘဲ 'var' ကို သုံးပါ။
      // ထိုသို့သုံးမှ .filter() နှင့် .order() ရလဒ်များကို ပြဿနာမရှိဘဲ လက်ခံနိုင်မည်ဖြစ်သည်။
      var queryBuilder = _supabase.from('your_table_name').select();

      // ... သင့်ရဲ့ Filter များကို ဤနေရာတွင် ထည့်သွင်းပါ ...
      // ဥပမာ: queryBuilder = queryBuilder.eq('status', 'active');

      // Order ထည့်သွင်းခြင်း
      if (sortBy != null && sortBy.isNotEmpty) {
        queryBuilder = queryBuilder.order(sortBy, ascending: ascending);
      } else {
        queryBuilder = queryBuilder.order('created_at', ascending: false);
      }

      // Data ကို ဆွဲယူခြင်း
      final response = await queryBuilder;
      return List<Map<String, dynamic>>.from(response);
      
    } catch (e) {
      print('Search Error: $e');
      return [];
    }
  }
}
