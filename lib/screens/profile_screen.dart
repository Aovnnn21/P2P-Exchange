import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool _darkMode = false;
  String _language = 'English';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black87,
        elevation: 1,
        title: const Text('Profile', style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Profile Header
          Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  Stack(
                    children: [
                      const CircleAvatar(
                        radius: 50,
                        backgroundColor: Colors.blue,
                        child: Icon(Icons.person, size: 50, color: Colors.white),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: CircleAvatar(
                          radius: 16,
                          backgroundColor: Colors.blue,
                          child: const Icon(Icons.camera_alt, size: 16, color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  const Text('John Doe', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 4),
                  const Text('john.doe@email.com', style: TextStyle(color: Colors.grey)),
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: Colors.orange.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.verified, color: Colors.orange.shade700, size: 18),
                        const SizedBox(width: 6),
                        Text('KYC Level 1', style: TextStyle(color: Colors.orange.shade700, fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          
          const SizedBox(height: 20),
          
          // Stats
          Row(
            children: [
              _buildStatCard('125', 'Trades', Colors.blue),
              const SizedBox(width: 12),
              _buildStatCard('98.5%', 'Completion', Colors.green),
              const SizedBox(width: 12),
              _buildStatCard('4.9', 'Rating', Colors.orange),
            ],
          ),
          
          const SizedBox(height: 20),
          
          // KYC Verification Section
          Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: Column(
              children: [
                ListTile(
                  leading: const Icon(Icons.security, color: Colors.blue),
                  title: const Text('KYC Verification', style: TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: const Text('Verify your identity to increase limits'),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                  onTap: () => _showKYCDialog(context),
                ),
                const Divider(height: 1),
                ListTile(
                  leading: const Icon(Icons.credit_card, color: Colors.purple),
                  title: const Text('Payment Methods'),
                  subtitle: const Text('3 methods linked'),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                  onTap: () {},
                ),
                const Divider(height: 1),
                ListTile(
                  leading: const Icon(Icons.history, color: Colors.green),
                  title: const Text('Trade History'),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                  onTap: () {},
                ),
              ],
            ),
          ),
          
          const SizedBox(height: 20),
          
          // Settings
          Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: Column(
              children: [
                SwitchListTile(
                  secondary: const Icon(Icons.dark_mode, color: Colors.indigo),
                  title: const Text('Dark Mode'),
                  value: _darkMode,
                  onChanged: (value) => setState(() => _darkMode = value),
                ),
                const Divider(height: 1),
                ListTile(
                  leading: const Icon(Icons.language, color: Colors.teal),
                  title: const Text('Language'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(_language, style: const TextStyle(color: Colors.grey)),
                      const SizedBox(width: 8),
                      const Icon(Icons.arrow_forward_ios, size: 16),
                    ],
                  ),
                  onTap: () => _showLanguageDialog(context),
                ),
                const Divider(height: 1),
                ListTile(
                  leading: const Icon(Icons.notifications, color: Colors.orange),
                  title: const Text('Notifications'),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                  onTap: () {},
                ),
                const Divider(height: 1),
                ListTile(
                  leading: const Icon(Icons.help, color: Colors.blue),
                  title: const Text('Help & Support'),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                  onTap: () {},
                ),
              ],
            ),
          ),
          
          const SizedBox(height: 20),
          
          // Logout Button
          SizedBox(
            width: double.infinity,
            height: 56,
            child: OutlinedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.logout, color: Colors.red),
              label: const Text('Logout', style: TextStyle(color: Colors.red, fontSize: 16, fontWeight: FontWeight.bold)),
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: Colors.red),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
          ),
          
          const SizedBox(height: 20),
          const Center(child: Text('Version 1.0.0', style: TextStyle(color: Colors.grey, fontSize: 12))),
        ],
      ),
    );
  }

  Widget _buildStatCard(String value, String label, Color color) {
    return Expanded(
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Text(value, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: color)),
              const SizedBox(height: 4),
              Text(label, style: const TextStyle(color: Colors.grey, fontSize: 12)),
            ],
          ),
        ),
      ),
    );
  }

  void _showKYCDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('KYC Verification'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildKYCStep('NRC Front', true),
            const SizedBox(height: 12),
            _buildKYCStep('NRC Back', true),
            const SizedBox(height: 12),
            _buildKYCStep('Selfie Photo', false),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Close')),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Documents uploaded successfully!')),
              );
            },
            child: const Text('Upload'),
          ),
        ],
      ),
    );
  }

  Widget _buildKYCStep(String title, bool isDone) {
    return Row(
      children: [
        Icon(isDone ? Icons.check_circle : Icons.radio_button_unchecked, color: isDone ? Colors.green : Colors.grey),
        const SizedBox(width: 12),
        Text(title, style: TextStyle(fontWeight: isDone ? FontWeight.bold : FontWeight.normal)),
      ],
    );
  }

  void _showLanguageDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => SimpleDialog(
        title: const Text('Select Language'),
        children: [
          SimpleDialogOption(
            onPressed: () {
              setState(() => _language = 'English');
              Navigator.pop(context);
            },
            child: const Text('English'),
          ),
          SimpleDialogOption(
            onPressed: () {
              setState(() => _language = 'မြန်မာ');
              Navigator.pop(context);
            },
            child: const Text('မြန်မာ'),
          ),
        ],
      ),
    );
  }
}
