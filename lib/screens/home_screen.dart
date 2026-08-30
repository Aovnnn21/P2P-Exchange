import 'package:flutter/material.dart';
import '../config/supabase_config.dart';
import '../services/auth_service.dart';
import '../widgets/exchange_rate_calculator.dart';
import 'login_screen.dart';
import 'search_screen.dart';
import 'referral_screen.dart';
import 'two_factor_setup_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final currentUser = SupabaseConfig.client.auth.currentUser;
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('P2P Exchange'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search), 
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (_) => const SearchScreen()));
            },
          ),
          IconButton(
            icon: const Icon(Icons.logout), 
            onPressed: () async {
              await AuthService().signOut();
              if (context.mounted) {
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const LoginScreen()));
              }
            },
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const ExchangeRateCalculator(),
          const SizedBox(height: 20),
          Card(
            child: Column(
              children: [
                ListTile(
                  leading: const Icon(Icons.card_giftcard, color: Colors.orange),
                  title: const Text('Referral Program'),
                  subtitle: const Text('Invite friends & earn bonus'),
                  trailing: const Icon(Icons.arrow_forward_ios),
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (_) => const ReferralScreen()));
                  },
                ),
                const Divider(height: 1),
                ListTile(
                  leading: const Icon(Icons.security, color: Colors.green),
                  title: const Text('Setup 2FA Security'),
                  subtitle: const Text('Protect your account'),
                  trailing: const Icon(Icons.arrow_forward_ios),
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (_) => const TwoFactorSetupScreen()));
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Center(
            child: Text(
              'Logged in as: ${currentUser?.email ?? 'User'}',
              style: const TextStyle(color: Colors.grey),
            ),
          ),
        ],
      ),
    );
  }
}
