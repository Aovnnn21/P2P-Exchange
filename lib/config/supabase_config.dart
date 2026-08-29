import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseConfig {
  static const String supabaseUrl = 'https://rngzfaabllcypfkmwzck.supabase.co';
  static const String supabaseAnonKey = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InJuZ3pmYWFibGxjeXBma213emNrIiwicm9sZSI6ImFub24iLCJpYXQiOjE3ODc5Njk4NDksImV4cCI6MjEwMzU0NTg0OX0.6jXEFr7Hktmp0iwnNtEIcY90v7FShwmpPOEjsHTxlBw';

  static Future<void> initialize() async {
    await Supabase.initialize(url: supabaseUrl, anonKey: supabaseAnonKey);
  }

  static SupabaseClient get client => Supabase.instance.client;
}
