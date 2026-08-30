import 'package:flutter/material.dart';

class P2PMarketScreen extends StatefulWidget {
  const P2PMarketScreen({super.key});

  @override
  State<P2PMarketScreen> createState() => _P2PMarketScreenState();
}

class _P2PMarketScreenState extends State<P2PMarketScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  bool isBuy = true;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() {
      setState(() {
        isBuy = _tabController.index == 0;
      });
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'P2P Trading',
          style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(icon: const Icon(Icons.headset_mic, color: Colors.black87), onPressed: () {}),
          IconButton(icon: const Icon(Icons.more_vert, color: Colors.black87), onPressed: () {}),
        ],
        bottom: TabBar(
          controller: _tabController,
          labelColor: Colors.blue,
          unselectedLabelColor: Colors.grey,
          indicatorColor: Colors.blue,
          indicatorWeight: 3,
          tabs: const [
            Tab(text: 'Buy'),
            Tab(text: 'Sell'),
          ],
        ),
      ),
      body: Column(
        children: [
          // Search and Filter Bar
          Container(
            padding: const EdgeInsets.all(16),
            color: Colors.white,
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Row(
                      children: [
                        Icon(Icons.search, color: Colors.grey, size: 20),
                        SizedBox(width: 8),
                        Text('Search merchant', style: TextStyle(color: Colors.grey)),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(Icons.tune, color: Colors.black87, size: 20),
                ),
              ],
            ),
          ),
          
          // Merchant List
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: 5, // Dummy data
              itemBuilder: (context, index) {
                return _buildMerchantCard(index);
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.blue,
        onPressed: () {
          // Navigate to Create Ad screen
        },
        icon: const Icon(Icons.add),
        label: const Text('Post an Ad'),
      ),
    );
  }

  Widget _buildMerchantCard(int index) {
    // Dummy data for demonstration
    final merchants = [
      {'name': 'CryptoKing_MM', 'trades': 1245, 'rate': '98.5%', 'price': '3,850', 'limit': '50,000 - 5,000,000', 'methods': ['Kpay', 'Wave Pay']},
      {'name': 'YangonTrader', 'trades': 890, 'rate': '99.1%', 'price': '3,855', 'limit': '100,000 - 10,000,000', 'methods': ['KBZ Pay', 'CB Pay']},
      {'name': 'MandalayEx', 'trades': 2100, 'rate': '97.8%', 'price': '3,845', 'limit': '20,000 - 2,000,000', 'methods': ['Wave Pay', 'Uab Pay']},
    ];
    
    final merchant = merchants[index % merchants.length];

    return Card(
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Merchant Info
            Row(
              children: [
                CircleAvatar(
                  backgroundColor: Colors.blue[50],
                  child: Text(merchant['name']![0], style: const TextStyle(color: Colors.blue, fontWeight: FontWeight.bold)),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(merchant['name']!, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                          const SizedBox(width: 6),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                            decoration: BoxDecoration(color: Colors.blue, borderRadius: BorderRadius.circular(4)),
                            child: const Text('Verified', style: TextStyle(color: Colors.white, fontSize: 10)),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text('${merchant['trades']} trades | ${merchant['rate']} completion', style: const TextStyle(color: Colors.grey, fontSize: 12)),
                    ],
                  ),
                ),
              ],
            ),
            const Divider(height: 24),
            
            // Price and Limits
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Price', style: TextStyle(color: Colors.grey, fontSize: 12)),
                    const SizedBox(height: 4),
                    Text('${merchant['price']} MMK', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.blue)),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const Text('Limits', style: TextStyle(color: Colors.grey, fontSize: 12)),
                    const SizedBox(height: 4),
                    Text('${merchant['limit']} MMK', style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 16),
            
            // Payment Methods and Trade Button
            Row(
              children: [
                Expanded(
                  child: Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: (merchant['methods'] as List).map((method) {
                      return Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                        decoration: BoxDecoration(
                          color: Colors.grey[100],
                          borderRadius: BorderRadius.circular(6),
                          border: Border.all(color: Colors.grey[300]!),
                        ),
                        child: Text(method, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500)),
                      );
                    }).toList(),
                  ),
                ),
                const SizedBox(width: 16),
                ElevatedButton(
                  onPressed: () {
                    // Navigate to Trade/Chat Screen
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Trading with ${merchant['name']}')),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: isBuy ? Colors.green : Colors.red,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                  child: Text(isBuy ? 'Buy' : 'Sell', style: const TextStyle(fontWeight: FontWeight.bold)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
