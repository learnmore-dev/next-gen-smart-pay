
import 'package:flutter/material.dart';
import 'shop_page.dart';
import 'features/profile/profile_page.dart';

void main() {
  runApp(const SmartPayApp());
}

const Color purple = Color(0xFF7353F5);
const Color pageBg = Color(0xFFF7F7FC);

class SmartPayApp extends StatelessWidget {
  const SmartPayApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SmartPay247',
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: pageBg,
        colorScheme: ColorScheme.fromSeed(seedColor: purple),
        fontFamily: 'Roboto',
      ),
      home: const MainNavigation(),
    );
  }
}

// --------------------------------------------------
// MAIN BOTTOM NAVIGATION
// --------------------------------------------------

class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int selectedIndex = 0;
  bool hideBalance = false;
  double balance = 0;
  final List<String> transactions = [];

  void openPage(String title, IconData icon, Color color) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => FeaturePage(
          title: title,
          icon: icon,
          color: color,
        ),
      ),
    );
  }

  void showMoneyDialog() {
    final controller = TextEditingController();

    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Add Money'),
        content: TextField(
          controller: controller,
          keyboardType:
              const TextInputType.numberWithOptions(decimal: true),
          decoration: const InputDecoration(
            labelText: 'Amount in ₹',
            prefixText: '₹ ',
            border: OutlineInputBorder(),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () {
              final amount =
                  double.tryParse(controller.text.trim());

              if (amount == null ||
                  !amount.isFinite ||
                  amount <= 0) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Enter a valid amount'),
                  ),
                );
                return;
              }

              setState(() {
                balance += amount;
                transactions.insert(
                  0,
                  'Demo wallet credit: +₹${amount.toStringAsFixed(2)}',
                );
              });

              Navigator.pop(dialogContext);

              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text(
                    'Demo balance updated. No real money was transferred.',
                  ),
                ),
              );
            },
            child: const Text('Add'),
          ),
        ],
      ),
    ).then((_) => controller.dispose());
  }

  @override
  Widget build(BuildContext context) {
    // Updated: ProfilePage comes from profile_page.dart.
    final pages = [
      HomeScreen(
        balance: balance,
        hideBalance: hideBalance,
        transactions: transactions,
        onToggleBalance: () {
          setState(() => hideBalance = !hideBalance);
        },
        onAddMoney: showMoneyDialog,
        onOpen: openPage,
      ),
      const ShopPage(),
      const FeaturePage(
        title: 'Scan & Pay',
        icon: Icons.qr_code_scanner,
        color: purple,
      ),
      HistoryScreen(transactions: transactions),
      const ProfilePage(),
    ];

    return Scaffold(
      body: SafeArea(child: pages[selectedIndex]),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex,
        onTap: (index) {
          setState(() => selectedIndex = index);
        },
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        selectedItemColor: purple,
        unselectedItemColor: Colors.blueGrey.shade300,
        selectedFontSize: 10,
        unselectedFontSize: 10,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_rounded),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_bag_outlined),
            label: 'Shop',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.qr_code_scanner, size: 25),
            label: 'Scan',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: 'History',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}

// --------------------------------------------------
// HOME SCREEN
// --------------------------------------------------

class HomeScreen extends StatelessWidget {
  final double balance;
  final bool hideBalance;
  final List<String> transactions;
  final VoidCallback onToggleBalance;
  final VoidCallback onAddMoney;
  final Function(String, IconData, Color) onOpen;

  const HomeScreen({
    super.key,
    required this.balance,
    required this.hideBalance,
    required this.transactions,
    required this.onToggleBalance,
    required this.onAddMoney,
    required this.onOpen,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 650),
        child: ListView(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 20),
          children: [
            const Center(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.bolt, color: purple, size: 25),
                  SizedBox(width: 5),
                  Text(
                    'SmartPay247',
                    style: TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 17,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 18),

            // Wallet card
            Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [
                    Color(0xFFE941A7),
                    Color(0xFF9569BD),
                    Color(0xFF12B5D0),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(23),
                boxShadow: [
                  BoxShadow(
                    color: purple.withValues(alpha: 0.22),
                    blurRadius: 22,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Good Morning',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                    ),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    'Guest',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                    ),
                  ),
                  const SizedBox(height: 15),
                  const Text(
                    'DEMO WALLET',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 7),
                  Text(
                    hideBalance
                        ? '₹ ••••••'
                        : '₹ ${balance.toStringAsFixed(2)}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w900,
                      fontSize: 29,
                    ),
                  ),
                  const SizedBox(height: 7),
                  TextButton.icon(
                    onPressed: () => onOpen(
                      'Login',
                      Icons.lock_outline,
                      purple,
                    ),
                    icon: const Icon(
                      Icons.lock_outline,
                      size: 13,
                    ),
                    label: const Text('Login to see'),
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor:
                          Colors.white.withValues(alpha: 0.20),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: walletInfo(
                          'CASHBACK',
                          '₹0',
                          'Pending 30 days',
                          Icons.card_giftcard,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: walletInfo(
                          'PENDING',
                          '₹0',
                          'Awaiting admin',
                          Icons.schedule,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                        child: walletButton(
                          '+ Add Money',
                          Icons.add,
                          onAddMoney,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: walletButton(
                          hideBalance ? 'Show' : 'Hide',
                          hideBalance
                              ? Icons.visibility
                              : Icons.visibility_off,
                          onToggleBalance,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Main actions
            Row(
              children: [
                actionItem(
                  'Send',
                  Icons.send_rounded,
                  purple,
                  () => onOpen('Send Money', Icons.send, purple),
                ),
                actionItem(
                  'Scan & Pay',
                  Icons.qr_code,
                  Colors.blue,
                  () => onOpen(
                    'Scan & Pay',
                    Icons.qr_code_scanner,
                    Colors.blue,
                  ),
                ),
                actionItem(
                  'Receive',
                  Icons.south_west,
                  Colors.green,
                  () => onOpen(
                    'Receive Money',
                    Icons.south_west,
                    Colors.green,
                  ),
                ),
                actionItem(
                  'Withdraw',
                  Icons.north_east,
                  Colors.orange,
                  () => onOpen(
                    'Withdraw',
                    Icons.north_east,
                    Colors.orange,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 23),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Pay Bills & Recharge',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                TextButton(
                  onPressed: () =>
                      onOpen('All Services', Icons.apps, purple),
                  child: const Text('View All >'),
                ),
              ],
            ),

            Row(
              children: [
                actionItem(
                  'Bill Pay',
                  Icons.receipt_long,
                  Colors.orange,
                  () => onOpen(
                    'Bill Pay',
                    Icons.receipt_long,
                    Colors.orange,
                  ),
                ),
                actionItem(
                  'Recharge',
                  Icons.phone_android,
                  Colors.green,
                  () => onOpen(
                    'Recharge',
                    Icons.phone_android,
                    Colors.green,
                  ),
                ),
                actionItem(
                  'Gas',
                  Icons.local_fire_department,
                  Colors.deepOrange,
                  () => onOpen(
                    'Gas Bill',
                    Icons.local_fire_department,
                    Colors.deepOrange,
                  ),
                ),
                actionItem(
                  'DTH',
                  Icons.tv,
                  Colors.purple,
                  () => onOpen(
                    'DTH Recharge',
                    Icons.tv,
                    purple,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 22),

            banner(
              'Bill Payments',
              'Electricity • Water • Gas • Mobile & more',
              Colors.orange,
              Colors.redAccent,
              Icons.receipt_long,
              () => onOpen(
                'Bill Payments',
                Icons.receipt_long,
                Colors.orange,
              ),
            ),
            banner(
              'Shopping Center',
              'Electronics • Fashion • Grocery & more',
              Colors.pink,
              purple,
              Icons.shopping_bag,
              () => onOpen(
                'Shopping Center',
                Icons.shopping_bag,
                purple,
              ),
            ),
            banner(
              'Offline Store Center',
              'Find nearby shops • Address, photo, timings & contact',
              Colors.lightBlue,
              purple,
              Icons.store,
              () => onOpen(
                'Offline Store Center',
                Icons.store,
                Colors.blue,
              ),
            ),
            banner(
              'Become a Vendor',
              'Sell your products on SmartPay247',
              Colors.green,
              Colors.teal,
              Icons.storefront,
              () => onOpen(
                'Become a Vendor',
                Icons.storefront,
                Colors.green,
              ),
            ),

            const SizedBox(height: 12),
            const Text(
              'Recent Transactions',
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),

            if (transactions.isEmpty)
              const Card(
                child: Padding(
                  padding: EdgeInsets.all(22),
                  child: Center(
                    child: Text('No transactions yet'),
                  ),
                ),
              )
            else
              ...transactions.take(3).map(
                (item) => Card(
                  child: ListTile(
                    leading: const CircleAvatar(
                      child: Icon(Icons.account_balance_wallet),
                    ),
                    title: Text(item),
                    subtitle: const Text('Demo transaction'),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

// --------------------------------------------------
// REUSABLE HOME WIDGETS
// --------------------------------------------------

Widget walletInfo(
  String title,
  String amount,
  String subtitle,
  IconData icon,
) {
  return Container(
    padding: const EdgeInsets.all(11),
    decoration: BoxDecoration(
      color: Colors.white.withValues(alpha: 0.20),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(
        color: Colors.white.withValues(alpha: 0.25),
      ),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, color: Colors.white, size: 13),
            const SizedBox(width: 4),
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 7),
        Text(
          amount,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 3),
        Text(
          subtitle,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 9,
          ),
        ),
      ],
    ),
  );
}

Widget walletButton(
  String text,
  IconData icon,
  VoidCallback onTap,
) {
  return OutlinedButton.icon(
    onPressed: onTap,
    icon: Icon(icon, size: 15),
    label: Text(text),
    style: OutlinedButton.styleFrom(
      foregroundColor: Colors.white,
      backgroundColor: Colors.white.withValues(alpha: 0.17),
      side: BorderSide(
        color: Colors.white.withValues(alpha: 0.35),
      ),
      textStyle: const TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 11,
      ),
      padding: const EdgeInsets.symmetric(vertical: 11),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
    ),
  );
}

Widget actionItem(
  String title,
  IconData icon,
  Color color,
  VoidCallback onTap,
) {
  return Expanded(
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 3),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(15),
        child: Container(
          constraints: const BoxConstraints(minHeight: 82),
          padding: const EdgeInsets.symmetric(
            horizontal: 3,
            vertical: 10,
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: const Color(0xFFE5E6EF)),
            borderRadius: BorderRadius.circular(15),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, color: Colors.white, size: 21),
              ),
              const SizedBox(height: 8),
              FittedBox(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

Widget banner(
  String title,
  String subtitle,
  Color start,
  Color end,
  IconData icon,
  VoidCallback onTap,
) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 12),
    child: Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(14),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(14),
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 14,
            vertical: 15,
          ),
          decoration: BoxDecoration(
            gradient: LinearGradient(colors: [start, end]),
            borderRadius: BorderRadius.circular(14),
          ),
          child: Row(
            children: [
              Icon(icon, color: Colors.white, size: 17),
              const SizedBox(width: 9),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: 38,
                height: 38,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.25),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.arrow_forward,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

// --------------------------------------------------
// GENERIC FEATURE PAGE
// --------------------------------------------------

class FeaturePage extends StatefulWidget {
  final String title;
  final IconData icon;
  final Color color;

  const FeaturePage({
    super.key,
    required this.title,
    required this.icon,
    required this.color,
  });

  @override
  State<FeaturePage> createState() => _FeaturePageState();
}

class _FeaturePageState extends State<FeaturePage> {
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final amountController = TextEditingController();

  bool get isFormFeature => const [
        'Send Money',
        'Receive Money',
        'Withdraw',
        'Bill Pay',
        'Bill Payments',
        'Recharge',
        'Gas Bill',
        'DTH Recharge',
        'Login',
        'Become a Vendor',
      ].contains(widget.title);

  String get firstLabel {
    switch (widget.title) {
      case 'Login':
        return 'Email or phone number';
      case 'Become a Vendor':
        return 'Business name';
      case 'Bill Pay':
      case 'Bill Payments':
        return 'Consumer number';
      case 'Gas Bill':
        return 'Gas consumer number';
      case 'DTH Recharge':
        return 'Customer ID';
      case 'Recharge':
        return 'Mobile number';
      case 'Receive Money':
        return 'Your name';
      case 'Withdraw':
        return 'Bank account / UPI ID';
      default:
        return 'Receiver phone number or UPI ID';
    }
  }

  String get secondLabel {
    if (widget.title == 'Login') return 'Password';
    if (widget.title == 'Become a Vendor') return 'Contact number';
    if (widget.title == 'Recharge') return 'Recharge amount (₹)';
    return 'Amount (₹)';
  }

  @override
  void dispose() {
    nameController.dispose();
    amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: Colors.white,
      ),
      body: ListView(
        padding: const EdgeInsets.all(22),
        children: [
          const SizedBox(height: 24),
          CircleAvatar(
            radius: 36,
            backgroundColor: widget.color.withValues(alpha: 0.12),
            child: Icon(widget.icon, color: widget.color, size: 35),
          ),
          const SizedBox(height: 20),
          Text(
            widget.title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            _description(),
            textAlign: TextAlign.center,
            style: const TextStyle(color: Colors.blueGrey),
          ),
          const SizedBox(height: 30),

          if (isFormFeature)
            Form(
              key: formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: nameController,
                    keyboardType: widget.title == 'Login'
                        ? TextInputType.emailAddress
                        : TextInputType.text,
                    decoration: InputDecoration(
                      labelText: firstLabel,
                      border: const OutlineInputBorder(),
                      prefixIcon:
                          const Icon(Icons.person_outline),
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Please enter $firstLabel';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: amountController,
                    obscureText: widget.title == 'Login',
                    keyboardType: widget.title == 'Login' ||
                            widget.title == 'Become a Vendor'
                        ? TextInputType.text
                        : const TextInputType.numberWithOptions(
                            decimal: true,
                          ),
                    decoration: InputDecoration(
                      labelText: secondLabel,
                      border: const OutlineInputBorder(),
                      prefixIcon: const Icon(Icons.edit_outlined),
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Please enter $secondLabel';
                      }

                      if (widget.title != 'Login' &&
                          widget.title != 'Become a Vendor') {
                        final amount =
                            double.tryParse(value.trim());

                        if (amount == null ||
                            !amount.isFinite ||
                            amount <= 0) {
                          return 'Enter a valid amount';
                        }
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 22),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: FilledButton(
                      onPressed: _submitForm,
                      child: const Text('Continue'),
                    ),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'Demo only: this form does not send money or make a real payment.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.blueGrey,
                    ),
                  ),
                ],
              ),
            )
          else
            Column(
              children: [
                if (widget.title == 'Scan & Pay') ...[
                  const Icon(
                    Icons.qr_code_2,
                    size: 100,
                    color: purple,
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'QR scanning is not connected yet. A QR scanner and camera permission are needed.',
                    textAlign: TextAlign.center,
                  ),
                ] else if (widget.title == 'Shopping Center' ||
                    widget.title == 'Shop') ...[
                  const Icon(
                    Icons.shopping_bag_outlined,
                    size: 75,
                    color: purple,
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'Products will appear here after a product catalogue is connected.',
                    textAlign: TextAlign.center,
                  ),
                ] else if (widget.title == 'All Services') ...[
                  _serviceButton(
                    context,
                    'Bill Payments',
                    Icons.receipt_long,
                    Colors.orange,
                  ),
                  _serviceButton(
                    context,
                    'Recharge',
                    Icons.phone_android,
                    Colors.green,
                  ),
                  _serviceButton(
                    context,
                    'Gas Bill',
                    Icons.local_fire_department,
                    Colors.deepOrange,
                  ),
                  _serviceButton(
                    context,
                    'DTH Recharge',
                    Icons.tv,
                    purple,
                  ),
                  _serviceButton(
                    context,
                    'Shopping Center',
                    Icons.shopping_bag,
                    purple,
                  ),
                ] else if (widget.title == 'Offline Store Center') ...[
                  const Icon(Icons.store, size: 75, color: purple),
                  const SizedBox(height: 12),
                  const Text(
                    'Store search and location services are not connected yet.',
                    textAlign: TextAlign.center,
                  ),
                ] else ...[
                  
                  const Text(
                    'This feature is a demo placeholder and is not connected to a live service.',
                    textAlign: TextAlign.center,
                  ),
                ],
                const SizedBox(height: 20),
                OutlinedButton.icon(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.arrow_back),
                  label: const Text('Back'),
                ),
              ],
            ),
        ],
      ),
    );
  }

  void _submitForm() {
    if (!formKey.currentState!.validate()) return;

    String message;

    switch (widget.title) {
      case 'Login':
        message =
            'Details validated. Firebase Authentication is not connected yet.';
        break;
      case 'Send Money':
        message =
            'Transfer details validated. No money has been sent.';
        break;
      case 'Receive Money':
        message =
            'Details validated. Receiving payments is not connected yet.';
        break;
      case 'Withdraw':
        message =
            'Withdrawal details validated. No money has been withdrawn.';
        break;
      case 'Become a Vendor':
        message =
            'Business details validated. Vendor registration is not connected yet.';
        break;
      default:
        message =
            'Payment details validated. No real payment has been made.';
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  Widget _serviceButton(
    BuildContext context,
    String title,
    IconData icon,
    Color color,
  ) {
    return Card(
      color: Colors.white,
      child: ListTile(
        leading: Icon(icon, color: color),
        title: Text(title),
        trailing: const Icon(Icons.chevron_right),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => FeaturePage(
                title: title,
                icon: icon,
                color: color,
              ),
            ),
          );
        },
      ),
    );
  }

  String _description() {
    switch (widget.title) {
      case 'Send Money':
        return 'Enter recipient details and an amount to validate a demo transfer.';
      case 'Receive Money':
        return 'Prepare your receiving details.';
      case 'Withdraw':
        return 'Enter your withdrawal details.';
      case 'Scan & Pay':
        return 'Scan a merchant QR code to start a payment.';
      case 'Login':
        return 'Sign in after authentication has been configured.';
      case 'Become a Vendor':
        return 'Register your business details.';
      case 'Shop':
      case 'Shopping Center':
        return 'Explore products after the catalogue is connected.';
      default:
        return 'Enter the details to continue.';
    }
  }
}

// --------------------------------------------------
// TRANSACTION HISTORY
// --------------------------------------------------

class HistoryScreen extends StatelessWidget {
  final List<String> transactions;

  const HistoryScreen({
    super.key,
    required this.transactions,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Transaction History'),
      ),
      body: transactions.isEmpty
          ? const Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.history, size: 65, color: Colors.grey),
                  SizedBox(height: 12),
                  Text(
                    'No transactions yet',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text('Your demo activity will appear here.'),
                  Text('Your demo activity will appear here.'),

                ],
              ),
            )
          : ListView.builder(
              itemCount: transactions.length,
              itemBuilder: (context, index) => ListTile(
                leading: const CircleAvatar(
                  child: Icon(Icons.account_balance_wallet),
                ),
                title: Text(transactions[index]),
                subtitle: const Text('Demo activity only'),
              ),      
              
            ),
    );
  }
}
