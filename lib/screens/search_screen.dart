import 'package:flutter/material.dart';
import '../services/search_service.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final SearchService _searchService = SearchService();
  final TextEditingController _searchController = TextEditingController();
  List<Map<String, dynamic>> _results = [];
  bool _isLoading = false;

  String? _selectedWallet;
  double? _minRate;
  double? _maxRate;

  Future<void> _performSearch() async {
    setState(() => _isLoading = true);

    final results = await _searchService.searchExchangers(
      query: _searchController.text,
      walletType: _selectedWallet,
      minRate: _minRate,
      maxRate: _maxRate,
    );

    setState(() {
      _results = results;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search Exchangers'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search by username...',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.filter_list),
                  onPressed: _showFilterDialog,
                ),
              ),
              onSubmitted: (_) => _performSearch(),
            ),
          ),
          if (_isLoading)
            const Expanded(child: Center(child: CircularProgressIndicator()))
          else
            Expanded(
              child: ListView.builder(
                itemCount: _results.length,
                itemBuilder: (context, index) {
                  final exchanger = _results[index];
                  final seller = exchanger['seller'];
                  
                  return Card(
                    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundImage: seller['avatar_url'] != null
                            ? NetworkImage(seller['avatar_url'])
                            : null,
                        child: seller['avatar_url'] == null
                            ? const Icon(Icons.person)
                            : null,
                      ),
                      title: Text(seller['username'] ?? 'Unknown'),
                      subtitle: Text(
                        '${seller['completion_rate']}% | ${seller['total_trades']} trades',
                      ),
                      trailing: Text(
                        '${exchanger['rate']} MMK',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                        ),
                      ),
                      onTap: () {
                        // Navigate to exchanger profile
                      },
                    ),
                  );
                },
              ),
            ),
        ],
      ),
    );
  }

  void _showFilterDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Filter Options'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            DropdownButtonFormField<String>(
              value: _selectedWallet,
              decoration: const InputDecoration(labelText: 'Wallet Type'),
              items: [null, 'Kpay', 'Wave Pay', 'CB Pay', 'Uab Pay']
                  .map((wallet) => DropdownMenuItem(
                        value: wallet,
                        child: Text(wallet ?? 'All'),
                      ))
                  .toList(),
              onChanged: (value) => setState(() => _selectedWallet = value),
            ),
            TextField(
              decoration: const InputDecoration(labelText: 'Min Rate'),
              keyboardType: TextInputType.number,
              onChanged: (value) => _minRate = double.tryParse(value),
            ),
            TextField(
              decoration: const InputDecoration(labelText: 'Max Rate'),
              keyboardType: TextInputType.number,
              onChanged: (value) => _maxRate = double.tryParse(value),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              _performSearch();
            },
            child: const Text('Apply'),
          ),
        ],
      ),
    );
  }
}
