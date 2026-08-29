import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../services/referral_service.dart';
import '../config/supabase_config.dart';

class ReferralScreen extends StatefulWidget {
  const ReferralScreen({super.key});

  @override
  State<ReferralScreen> createState() => _ReferralScreenState();
}

class _ReferralScreenState extends State<ReferralScreen> {
  final ReferralService _referralService = ReferralService();
  String? _referralCode;
  Map<String, dynamic>? _stats;

  @override
  void initState() {
    super.initState();
    _loadReferralData();
  }

  Future<void> _loadReferralData() async {
    final userId = SupabaseConfig.client.auth.currentUser!.id;
    
    final code = await _referralService.getReferralCode(userId);
    final stats = await _referralService.getReferralStats(userId);
    
    setState(() {
      _referralCode = code;
      _stats = stats;
    });
  }

  Future<void> _copyReferralCode() async {
    if (_referralCode != null) {
      await Clipboard.setData(ClipboardData(text: _referralCode!));
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Referral code copied!')),
      );
    }
  }

  Future<void> _shareReferralCode() async {
    if (_referralCode != null) {
      // Use share_plus package
      // Share.share('Join P2P Exchange using my referral code: $_referralCode');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Referral Program')),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    const Icon(Icons.card_giftcard, size: 64, color: Colors.blue),
                    const SizedBox(height: 16),
                    const Text(
                      'Invite Friends & Earn',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Get 5,000 MMK for each friend who joins',
                      style: TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            if (_referralCode != null) ...[
              Text(
                'Your Referral Code:',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.blue.shade50,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.blue),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      _referralCode!,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 2,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.copy),
                      onPressed: _copyReferralCode,
                    ),
                  ],
                ),
              ),
            ],
            const SizedBox(height: 24),
            if (_stats != null) ...[
              Row(
                children: [
                  Expanded(
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          children: [
                            Text(
                              '${_stats!['total_referrals']}',
                              style: const TextStyle(
                                fontSize: 32,
                                fontWeight: FontWeight.bold,
                                color: Colors.blue,
                              ),
                            ),
                            const Text('Friends Invited'),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          children: [
                            Text(
                              '${_stats!['total_referral_bonus']} MMK',
                              style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Colors.green,
                              ),
                            ),
                            const Text('Total Bonus'),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
            const Spacer(),
            ElevatedButton.icon(
              onPressed: _shareReferralCode,
              icon: const Icon(Icons.share),
              label: const Text('Share Referral Code'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
