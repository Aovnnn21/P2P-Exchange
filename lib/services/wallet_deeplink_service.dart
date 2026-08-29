import 'package:url_launcher/url_launcher.dart';

class WalletDeepLinkService {
  // Kpay Deep Link
  Future<void> openKpay({
    required String phoneNumber,
    required double amount,
  }) async {
    // Kpay URL Scheme
    final uri = Uri.parse(
      'kbzpay://transfer?phone=$phoneNumber&amount=$amount'
    );
    
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      // Fallback to Kpay website
      await launchUrl(Uri.parse('https://www.kbzpay.com'));
    }
  }

  // WavePay Deep Link
  Future<void> openWavePay({
    required String phoneNumber,
    required double amount,
  }) async {
    final uri = Uri.parse(
      'wavepay://send?phone=$phoneNumber&amount=$amount'
    );
    
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      await launchUrl(Uri.parse('https://www.wavepay.com.mm'));
    }
  }

  // UabPay Deep Link
  Future<void> openUabPay({
    required String phoneNumber,
    required double amount,
  }) async {
    final uri = Uri.parse(
      'uabpay://transfer?phone=$phoneNumber&amount=$amount'
    );
    
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      await launchUrl(Uri.parse('https://www.uab.com.mm'));
    }
  }

  // Generic Wallet Opener
  Future<void> openWallet({
    required String walletType,
    required String phoneNumber,
    required double amount,
  }) async {
    switch (walletType.toLowerCase()) {
      case 'kpay':
        await openKpay(phoneNumber: phoneNumber, amount: amount);
        break;
      case 'wavepay':
        await openWavePay(phoneNumber: phoneNumber, amount: amount);
        break;
      case 'uabpay':
        await openUabPay(phoneNumber: phoneNumber, amount: amount);
        break;
      default:
        throw Exception('Unsupported wallet type');
    }
  }
}
