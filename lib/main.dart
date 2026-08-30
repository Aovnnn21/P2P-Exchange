import 'package:flutter/material.dart';
import 'widgets/exchange_rate_calculator.dart'; // သင့် import များ

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'P2P Exchange App',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const ExchangeRateCalculator(),
    );
  }
} // <--- ဖိုင်အဆုံးသတ်သည် ဤနေရာတွင် ပြီးဆုံးရပါမည်။

// ⚠️ သတိပြုရန်: ဤအောက်တွင် '}' သို့မဟုတ် '}' အပိုများ လုံးဝ မရှိစေရပါ။ 
// ရှိနေပါက ဖျက်ထုတ်လိုက်ပါ။
