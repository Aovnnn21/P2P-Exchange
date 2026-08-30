import 'package:flutter/material.dart';

class ExchangeRateCalculator extends StatefulWidget {
  const ExchangeRateCalculator({Key? key}) : super(key: key);

  @override
  State<ExchangeRateCalculator> createState() => _ExchangeRateCalculatorState();
}

class _ExchangeRateCalculatorState extends State<ExchangeRateCalculator> {
  // သင့်ရဲ့ Variable များကို ဤနေရာတွင် ကြေညာပါ
  String? _fromWallet;
  String? _toWallet;
  final List<String> wallets = ['MMK', 'USD', 'THB']; // ဥပမာ Wallet List

  @override
  void initState() {
    super.initState(); // အမှားပြင်: Class အတွင်းသို့ ရောက်ရှိသွားပါပြီ
    // လိုအပ်သော initialization များကို ဤနေရာတွင် ထားရှိပါ
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Exchange Rate Calculator')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // From Wallet Dropdown
            DropdownButtonFormField<String>(
              initialValue: _fromWallet, // ပြင်ဆင်ထားသည်: 'initialvalue' မှ 'initialValue' (V အကြီး) သို့ ပြောင်းသည်
              decoration: const InputDecoration(labelText: 'From Wallet'),
              items: wallets.map((wallet) {
                return DropdownMenuItem<String>(
                  value: wallet, // ပြင်ဆင်ထားသည်: 'initialvalue' မှ 'value' သို့ ပြောင်းသည်
                  child: Text(wallet),
                );
              }).toList(),
              onChanged: (value) {
                setState(() => _fromWallet = value!); // အမှားပြင်: Class အတွင်းရောက်သွား၍ setState ကို သိရှိပါပြီ
              },
            ),
            const SizedBox(height: 20),
            
            // To Wallet Dropdown
            DropdownButtonFormField<String>(
              initialValue: _toWallet, // ပြင်ဆင်ထားသည်: 'initialvalue' မှ 'initialValue' (V အကြီး) သို့ ပြောင်းသည်
              decoration: const InputDecoration(labelText: 'To Wallet'),
              items: wallets.map((wallet) {
                return DropdownMenuItem<String>(
                  value: wallet, // ပြင်ဆင်ထားသည်: 'initialvalue' မှ 'value' သို့ ပြောင်းသည်
                  child: Text(wallet),
                );
              }).toList(),
              onChanged: (value) {
                setState(() => _toWallet = value!); // အမှားပြင်: Class အတွင်းရောက်သွား၍ setState ကို သိရှိပါပြီ
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose(); // အမှားပြင်: Class အတွင်းသို့ ရောက်ရှိသွားပါပြီ
  }
} // ဤနေရာသည် Class အဆုံးသတ်ဖြစ်ပါသည်။ ဤအောက်တွင် '}' အပိုများ လုံးဝ မရှိစေရပါ။
