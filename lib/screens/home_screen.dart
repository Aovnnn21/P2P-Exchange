import 'package:flutter/material.dart';
import '../config/supabase_config.dart';
import '../services/auth_service.dart';
import 'login_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final currentUser = SupabaseConfig.client.auth.currentUser;
    return Scaffold(
      appBar: AppBar(
        title: const Text('P2P Exchange'),
        actions: [IconButton(icon: const Icon(Icons.logout), onPressed: () async {
          await AuthService().signOut();
          if (context.mounted) Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const LoginScreen()));
        })],
      ),
      body: Center(child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.check_circle, color: Colors.green, size: 64),
          const SizedBox(height: 20),
          const Text('Connected to Supabase!', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          Text('User ID: \${currentUser?.id.substring(0, 8)}...', style: const TextStyle(color: Colors.grey)),
        ],
      )),
    );
  }
}
