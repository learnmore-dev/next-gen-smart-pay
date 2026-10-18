
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  static const Color purple = Color(0xFF7052F5);
  static const Color background = Color(0xFFF6F6FC);

  bool darkMode = false;

  void showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      appBar: AppBar(
        backgroundColor: background,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Profile',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Color(0xFF101044),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: IconButton(
              onPressed: () {
                setState(() {
                  darkMode = !darkMode;
                });
                showMessage(
                  darkMode ? 'Dark mode selected' : 'Light mode selected',
                );
              },
              icon: const Icon(
                Icons.brightness_6_outlined,
                color: Color(0xFF101044),
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(8, 8, 8, 20),
          child: Column(
            children: [
              // Profile avatar
              Container(
                width: 76,
                height: 76,
                decoration: const BoxDecoration(
                  color: purple,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Color(0x337052F5),
                      blurRadius: 14,
                      offset: Offset(0, 5),
                    ),
                  ],
                ),
                child: const Center(
                  child: Text(
                    '?',
                    style: TextStyle(
                      fontSize: 32,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Transform.translate(
                offset: const Offset(27, -20),
                child: Container(
                  width: 22,
                  height: 22,
                  decoration: const BoxDecoration(
                    color: Colors.green,
                    shape: BoxShape.circle,
                    border: Border.fromBorderSide(
                      BorderSide(color: Colors.white, width: 2),
                    ),
                  ),
                  child: const Icon(
                    Icons.check,
                    color: Colors.white,
                    size: 13,
                  ),
                ),
              ),
              const Text(
                'Guest',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF151545),
                ),
              ),
              const SizedBox(height: 3),
              const Text(
                'Not logged in',
                style: TextStyle(fontSize: 12, color: Colors.grey),
              ),
              const SizedBox(height: 10),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 5,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFFD9F5EA),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Text(
                  '✓ KYC Verified',
                  style: TextStyle(
                    color: Color(0xFF15966C),
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // Statistics cards
              Row(
                children: const [
                  Expanded(
                    child: _StatCard(
                      value: '0',
                      label: 'PAYMENTS',
                    ),
                  ),
                  SizedBox(width: 6),
                  Expanded(
                    child: _StatCard(
                      value: '₹0',
                      label: 'BALANCE',
                    ),
                  ),
                  SizedBox(width: 6),
                  Expanded(
                    child: _StatCard(
                      value: '0',
                      label: 'REFERRALS',
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 14),

              // Referral banner
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: const Color(0xFF101522),
                  border: Border.all(
                    color: const Color(0xFFFFC400),
                    width: 1.5,
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Row(
                      children: [
                        Icon(
                          Icons.card_giftcard,
                          color: Color(0xFFFFC400),
                          size: 17,
                        ),
                        SizedBox(width: 5),
                        Text(
                          'Refer & Earn ₹25',
                          style: TextStyle(
                            color: Color(0xFFFFC400),
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 7),
                    const Text(
                      'Share your code. When your friend loads ₹200+, '
                      'you get ₹25 in your wallet.',
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 10,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: const Color(0xFF080D18),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        children: [
                          const Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'YOUR REFERRAL CODE',
                                  style: TextStyle(
                                    color: Colors.white60,
                                    fontSize: 9,
                                  ),
                                ),
                                SizedBox(height: 7),
                                Text(
                                  '------',
                                  style: TextStyle(
                                    color: Color(0xFFFFC400),
                                    letterSpacing: 3,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          TextButton.icon(
                            onPressed: () => showMessage(
                              'Log in to get your referral code.',
                            ),
                            style: TextButton.styleFrom(
                              backgroundColor: const Color(0xFFFFC400),
                              foregroundColor: Colors.black,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 5,
                              ),
                            ),
                            icon: const Icon(Icons.copy, size: 13),
                            label: const Text(
                              'Copy',
                              style: TextStyle(fontSize: 11),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 8),
                    SizedBox(
                      width: double.infinity,
                      child: OutlinedButton.icon(
                        onPressed: () => showMessage(
                          'Log in to share your referral link.',
                        ),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: Colors.white,
                          side: const BorderSide(color: Color(0xFF30384A)),
                          backgroundColor: const Color(0xFF20283A),
                        ),
                        icon: const Icon(Icons.share, size: 14),
                        label: const Text(
                          'Share Referral Link',
                          style: TextStyle(fontSize: 12),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),

              // Profile menu
              _ProfileMenuItem(
                icon: Icons.alternate_email,
                iconColor: const Color(0xFF7052F5),
                iconBackground: const Color(0xFFEAE5FF),
                title: 'Not logged in',
                subtitle: 'Your UPI ID',
                trailing: Icons.copy,
                onTap: () => showMessage('Please log in first.'),
              ),
              _ProfileMenuItem(
                icon: Icons.account_balance,
                iconColor: const Color(0xFF7052F5),
                iconBackground: const Color(0xFFEAE5FF),
                title: 'Linked Bank',
                subtitle: 'HDFC Bank •••• 4587',
                onTap: () => showMessage('Bank linking will be available soon.'),
              ),
              _ProfileMenuItem(
                icon: Icons.receipt_long,
                iconColor: Colors.orange,
                iconBackground: const Color(0xFFFFF0DA),
                title: 'Bill Payments',
                subtitle: 'Pay electricity, gas, DTH & more',
                onTap: () => showMessage('Bill Payments selected.'),
              ),
              _ProfileMenuItem(
                icon: Icons.shopping_bag,
                iconColor: Colors.pink,
                iconBackground: const Color(0xFFFFE4F0),
                title: 'Shopping Center',
                subtitle: 'Browse products across categories',
                onTap: () => showMessage('Shopping Center selected.'),
              ),
              _ProfileMenuItem(
                icon: Icons.store,
                iconColor: Colors.lightBlue,
                iconBackground: const Color(0xFFDDF4FF),
                title: 'Offline Store Center',
                subtitle: 'Find nearby physical stores',
                onTap: () => showMessage('Offline Store Center selected.'),
              ),
              _ProfileMenuItem(
                icon: Icons.storefront,
                iconColor: Colors.teal,
                iconBackground: const Color(0xFFDDF8F0),
                title: 'Become a Vendor',
                subtitle: 'Sell your products on SmartPay247',
                onTap: () => showMessage('Vendor registration selected.'),
              ),
              _ProfileMenuItem(
                icon: Icons.shield_outlined,
                iconColor: const Color(0xFF7052F5),
                iconBackground: const Color(0xFFEAE5FF),
                title: 'Security & Privacy',
                subtitle: 'PIN, biometrics, themes',
                onTap: () => showMessage('Security & Privacy selected.'),
              ),
              _ProfileMenuItem(
                icon: Icons.help_outline,
                iconColor: const Color(0xFF7052F5),
                iconBackground: const Color(0xFFEAE5FF),
                title: 'Help & Support',
                subtitle: 'Get help from our admin team',
                onTap: () => showMessage('Help & Support selected.'),
              ),
              const SizedBox(height: 10),

              // Logout
              _ProfileMenuItem(
                icon: Icons.logout,
                iconColor: Colors.red,
                iconBackground: const Color(0xFFFFE3E3),
                title: 'Log Out',
                titleColor: Colors.red,
                showArrow: false,
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (dialogContext) => AlertDialog(
                      title: const Text('Log Out'),
                      content: const Text(
                        'You are currently using guest mode.',
                      ),
                      actions: [
                        TextButton(
                          onPressed: () =>
                              Navigator.pop(dialogContext),
                          child: const Text('Cancel'),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pop(dialogContext);
                            showMessage('You are using guest mode.');
                          },
                          child: const Text('OK'),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final String value;
  final String label;

  const _StatCard({
    required this.value,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 58,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: const Color(0xFFE2E5EF)),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            value,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: Color(0xFF151545),
            ),
          ),
          const SizedBox(height: 3),
          Text(
            label,
            style: const TextStyle(
              fontSize: 9,
              color: Colors.blueGrey,
            ),
          ),
        ],
      ),
    );
  }
}

class _ProfileMenuItem extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final Color iconBackground;
  final String title;
  final String subtitle;
  final IconData? trailing;
  final Color titleColor;
  final bool showArrow;
  final VoidCallback onTap;

  const _ProfileMenuItem({
    required this.icon,
    required this.iconColor,
    required this.iconBackground,
    required this.title,
    this.subtitle = '',
    this.trailing,
    this.titleColor = const Color(0xFF151545),
    this.showArrow = true,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 4),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: const Color(0xFFE3E6EF)),
        borderRadius: BorderRadius.circular(10),
      ),
      child: ListTile(
        dense: true,
        minVerticalPadding: 5,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 1,
        ),
        leading: Container(
          width: 38,
          height: 38,
          decoration: BoxDecoration(
            color: iconBackground,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, color: iconColor, size: 19),
        ),
        title: Text(
          title,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: titleColor,
          ),
        ),
        subtitle: subtitle.isEmpty
            ? null
            : Text(
                subtitle,
                style: const TextStyle(
                  fontSize: 10,
                  color: Colors.blueGrey,
                ),
              ),
        trailing: trailing != null
            ? Icon(trailing, size: 15, color: Colors.blueGrey)
            : showArrow
                ? const Icon(
                    Icons.chevron_right,
                    size: 18,
                    color: Colors.blueGrey,
                  )
                : null,
        onTap: onTap,
      ),
    );
  }
}
