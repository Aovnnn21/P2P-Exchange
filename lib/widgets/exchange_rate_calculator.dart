import 'package:flutter/material.dart';

class ExchangeRateCalculator extends StatefulWidget {
  const ExchangeRateCalculator({super.key});

  @override
  State<ExchangeRateCalculator> createState() => _ExchangeRateCalculatorState();
}

  final TextEditingController _amountController = TextEditingController();
  String _fromWallet = 'Kpay';
  String _toWallet = 'Uab Pay';
  double _currentRate = 2.1;
  double _calculatedAmount = 0;

  @override
  void initState() {
    super.initState();
    _amountController.addListener(_calculate);
  }

  void _calculate() {
    final amount = double.tryParse(_amountController.text) ?? 0;
    setState(() {
      _calculatedAmount = amount / _currentRate;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Exchange Rate Calculator',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: DropdownButtonFormField<String>(
                    initialvalue: _fromWallet,
                    decoration: const InputDecoration(labelText: 'From'),
                    items: ['Kpay', 'Wave Pay', 'CB Pay', 'Uab Pay']
                        .map((wallet) => DropdownMenuItem(
                              initialvalue: wallet,
                              child: Text(wallet),
                            ))
                        .toList(),
                    onChanged: (value) {
                      setState(() => _fromWallet = value!);
                    },
                  ),
                ),
                const Icon(Icons.arrow_forward),
                Expanded(
                  child: DropdownButtonFormField<String>(
                    initialvalue: _toWallet,
                    decoration: const InputDecoration(labelText: 'To'),
                    items: ['Kpay', 'Wave Pay', 'CB Pay', 'Uab Pay']
                        .map((wallet) => DropdownMenuItem(
                              initialvalue: wallet,
                              child: Text(wallet),
                            ))
                        .toList(),
                    onChanged: (value) {
                      setState(() => _toWallet = value!);
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _amountController,
              decoration: const InputDecoration(
                labelText: 'Amount (MMK)',
                prefixIcon: Icon(Icons.attach_money),
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('You Receive:', style: TextStyle(fontSize: 16)),
                  Text(
                    '${_calculatedAmount.toStringAsFixed(2)} MMK',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Current Rate: 1 USD = $_currentRate MMK',
              style: const TextStyle(color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _amountController.dispose();
    super.dispose();
  }
}
