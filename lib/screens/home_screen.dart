import 'package:flutter/material.dart';:**

```dart
import 'package:flutter/material.dart';
import '../config/supabase_config.dart';
import
import '../config/supabase_config.dart';
import '../services/auth_service.dart';
import '../widgets '../services/auth_service.dart';
import '../widgets/exchange_rate_calculator.dart';
import 'login/exchange_rate_calculator.dart';
import 'login_screen.dart';
import 'search_screen.dart';
import_screen.dart';
import 'search_screen.dart';
import 'referral_screen.dart';
import 'two_factor_setup 'referral_screen.dart';
import 'two_factor_setup_screen.dart';

class HomeScreen extends StatelessWidget {
 _screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
 const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final currentUser =  Widget build(BuildContext context) {
    final currentUser = SupabaseConfig.client.auth.currentUser;
    
 SupabaseConfig.client.auth.currentUser;
    
    return Scaffold(
      appBar: AppBar(
           return Scaffold(
      appBar: AppBar(
        title: const Text('P2P Exchange'),
        title: const Text('P2P Exchange'),
        actions: [
          IconButton(icon: const Icon(Icons actions: [
          IconButton(icon: const Icon(Icons.search), onPressed: () {
            Navigator.push.search), onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (_) => const SearchScreen()));
(context, MaterialPageRoute(builder: (_) => const SearchScreen()));
          }),
          IconButton(icon: const Icon(Icons.logout),          }),
          IconButton(icon: const Icon(Icons.logout), onPressed: () async {
            await AuthService().signOut onPressed: () async {
            await AuthService().signOut();
            if (context.mounted) Navigator.pushReplacement();
            if (context.mounted) Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const LoginScreen()));
(context, MaterialPageRoute(builder: (_) => const LoginScreen()));
          }),
        ],
      ),
      body:          }),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16 ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // ),
        children: [
          // 1. Exchange Rate Calculator Widget
          const ExchangeRateCalculator1. Exchange Rate Calculator Widget
          const ExchangeRateCalculator(),
          
          const SizedBox(height: 20),(),
          
          const SizedBox(height: 20),
          
          // 2. Feature Navigation Buttons
         
          
          // 2. Feature Navigation Buttons
          Card(
            child: Column(
              children Card(
            child: Column(
              children: [
                ListTile(
                  leading: const Icon: [
                ListTile(
                  leading: const Icon(Icons.card_giftcard, color: Colors.orange(Icons.card_giftcard, color: Colors.orange),
                  title: const Text('Referral),
                  title: const Text('Referral Program'),
                  subtitle: const Text('Invite friends Program'),
                  subtitle: const Text('Invite friends & earn bonus'),
                  trailing: const Icon(Icons & earn bonus'),
                  trailing: const Icon(Icons.arrow_forward_ios),
                  onTap: () {.arrow_forward_ios),
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (_) => const
                    Navigator.push(context, MaterialPageRoute(builder: (_) => const ReferralScreen()));
                  },
                ),
                ReferralScreen()));
                  },
                ),
                const Divider(height: 1),
                ListTile(
 const Divider(height: 1),
                ListTile(
                  leading: const Icon(Icons.security, color: Colors.green                  leading: const Icon(Icons.security, color: Colors.green),
                  title: const Text('Setup 2FA),
                  title: const Text('Setup 2FA Security'),
                  subtitle: const Text('Protect your account Security'),
                  subtitle: const Text('Protect your account'),
                  trailing: const Icon(Icons.arrow_forward_ios),'),
                  trailing: const Icon(Icons.arrow_forward_ios),
                  onTap: () {
                    Navigator.push(context,
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (_) => const TwoFactorSetupScreen()));
 MaterialPageRoute(builder: (_) => const TwoFactorSetupScreen()));
                  },
                ),
              ],
                             },
                ),
              ],
            ),
          ),

          const SizedBox(height ),
          ),

          const SizedBox(height: 20),
          Center(
            child: 20),
          Center(
            child: Text(
              'Logged in as: Text(
              'Logged in as: ${currentUser?.email ?? 'User'}: ${currentUser?.email ?? 'User'}',
              style: const TextStyle(color: Colors.grey),',
              style: const TextStyle(color: Colors.grey),
            ),
          ),
        ],
      ),
            ),
          ),
        ],
      ),
    );
  }
}
