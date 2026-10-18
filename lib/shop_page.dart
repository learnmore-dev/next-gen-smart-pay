
import 'package:flutter/material.dart';

class ShopPage extends StatefulWidget {
  const ShopPage({super.key});

  @override
  State<ShopPage> createState() => _ShopPageState();
}

class _ShopPageState extends State<ShopPage> {
  String category = 'All';
  String search = '';
  final Set<String> favorites = {};
  final Map<String, int> cart = {};

  final List<Map<String, dynamic>> products = [
    {
      'name': 'Wireless Earbuds Pro',
      'category': 'Electronics',
      'price': 1499,
      'old': 2999,
      'rating': 4.5,
      'image': '🎧',
      'discount': '50% OFF',
    },
    {
      'name': 'Smart Watch Series 7',
      'category': 'Electronics',
      'price': 2199,
      'old': 3999,
      'rating': 4.4,
      'image': '⌚',
      'discount': '45% OFF',
    },
    {
      'name': 'Bluetooth Speaker 20W',
      'category': 'Electronics',
      'price': 1299,
      'old': 2499,
      'rating': 4.3,
      'image': '🔊',
      'discount': '48% OFF',
    },
    {
      'name': 'Fast Charger 65W',
      'category': 'Electronics',
      'price': 899,
      'old': 1799,
      'rating': 4.6,
      'image': '🔌',
      'discount': '50% OFF',
    },
    {
      'name': 'Power Bank 20000mAh',
      'category': 'Electronics',
      'price': 1399,
      'old': 2499,
      'rating': 4.2,
      'image': '🔋',
      'discount': '44% OFF',
    },
    {
      'name': 'Classic Casual T-Shirt',
      'category': 'Fashion',
      'price': 499,
      'old': 999,
      'rating': 4.2,
      'image': '👕',
      'discount': '50% OFF',
    },
    {
      'name': 'Everyday Sneakers',
      'category': 'Fashion',
      'price': 1199,
      'old': 1999,
      'rating': 4.4,
      'image': '👟',
      'discount': '40% OFF',
    },
    {
      'name': 'Organic Grocery Pack',
      'category': 'Grocery',
      'price': 399,
      'old': 599,
      'rating': 4.1,
      'image': '🥗',
      'discount': '33% OFF',
    },
    {
      'name': 'Home Decor Lamp',
      'category': 'Home',
      'price': 799,
      'old': 1299,
      'rating': 4.3,
      'image': '💡',
      'discount': '38% OFF',
    },
    {
      'name': 'Beauty Care Kit',
      'category': 'Beauty',
      'price': 699,
      'old': 1199,
      'rating': 4.4,
      'image': '🧴',
      'discount': '42% OFF',
    },
    {
      'name': 'Sports Water Bottle',
      'category': 'Sports',
      'price': 299,
      'old': 499,
      'rating': 4.0,
      'image': '🥤',
      'discount': '40% OFF',
    },
    {
      'name': 'Learning Books Bundle',
      'category': 'Books',
      'price': 599,
      'old': 899,
      'rating': 4.5,
      'image': '📚',
      'discount': '33% OFF',
    },
  ];

  final List<String> categories = [
    'All',
    'Electronics',
    'Fashion',
    'Grocery',
    'Home',
    'Beauty',
    'Sports',
    'Books',
  ];

  @override
  Widget build(BuildContext context) {
    final filtered = products.where((p) {
      final matchesCategory =
          category == 'All' || p['category'] == category;
      final matchesSearch = p['name']
          .toString()
          .toLowerCase()
          .contains(search.toLowerCase());
      return matchesCategory && matchesSearch;
    }).toList();

    final cartCount =
        cart.values.fold<int>(0, (sum, quantity) => sum + quantity);

    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FB),
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: const Color(0xFF172554),
        elevation: 0,
        title: const Text(
          'Shopping Center',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          Stack(
            alignment: Alignment.topRight,
            children: [
              IconButton(
                icon: const Icon(Icons.shopping_cart_outlined),
                onPressed: _showCart,
              ),
              if (cartCount > 0)
                CircleAvatar(
                  radius: 9,
                  backgroundColor: Colors.red,
                  child: Text(
                    '$cartCount',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: TextField(
                  onChanged: (value) => setState(() => search = value),
                  decoration: InputDecoration(
                    hintText: 'Search products, brands...',
                    prefixIcon: const Icon(Icons.search),
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [
                        Color(0xFF172554),
                        Color(0xFF2563EB),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'MEGA SHOPPING FEST',
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Up to 70% OFF',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 6),
                      Text(
                        'Extra 5% cashback on wallet pay',
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: SizedBox(
                height: 62,
                child: ListView.separated(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  scrollDirection: Axis.horizontal,
                  itemCount: categories.length,
                  separatorBuilder: (_, __) =>
                      const SizedBox(width: 8),
                  itemBuilder: (context, index) {
                    final item = categories[index];
                    final selected = category == item;

                    return ChoiceChip(
                      label: Text(item),
                      selected: selected,
                      onSelected: (_) {
                        setState(() => category = item);
                      },
                      selectedColor: const Color(0xFF2563EB),
                      labelStyle: TextStyle(
                        color: selected ? Colors.white : Colors.black87,
                        fontWeight: FontWeight.w600,
                      ),
                      backgroundColor: Colors.white,
                      side: BorderSide.none,
                    );
                  },
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
                child: Row(
                  children: [
                    const Expanded(
                      child: Text(
                        'Featured Products',
                        style: TextStyle(
                          fontSize: 19,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Text(
                      '${filtered.length} items',
                      style: const TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
              ),
            ),
            if (filtered.isEmpty)
              const SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.all(32),
                  child: Center(child: Text('No products found')),
                ),
              )
            else
              SliverPadding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
                sliver: SliverLayoutBuilder(
                  builder: (context, constraints) {
                    final width = constraints.crossAxisExtent;
                    final columns = width >= 900
                        ? 4
                        : width >= 550
                            ? 3
                            : 2;

                    return SliverGrid(
                      gridDelegate:
                          SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: columns,
                        crossAxisSpacing: 12,
                        mainAxisSpacing: 12,
                        mainAxisExtent: 270,
                      ),
                      delegate: SliverChildBuilderDelegate(
                        (context, index) {
                          final p = filtered[index];
                          final name = p['name'] as String;
                          final favorite = favorites.contains(name);

                          return Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(16),
                            ),
                            clipBehavior: Clip.antiAlias,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Stack(
                                    children: [
                                      Container(
                                        width: double.infinity,
                                        color: const Color(0xFFF0F4FA),
                                        child: Center(
                                          child: Text(
                                            p['image'] as String,
                                            style: const TextStyle(
                                              fontSize: 55,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        top: 8,
                                        left: 8,
                                        child: Container(
                                          padding:
                                              const EdgeInsets.symmetric(
                                            horizontal: 7,
                                            vertical: 5,
                                          ),
                                          decoration: BoxDecoration(
                                            color: const Color(0xFFDCFCE7),
                                            borderRadius:
                                                BorderRadius.circular(6),
                                          ),
                                          child: Text(
                                            p['discount'] as String,
                                            style: const TextStyle(
                                              color: Color(0xFF166534),
                                              fontSize: 10,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        top: 2,
                                        right: 2,
                                        child: IconButton(
                                          visualDensity:
                                              VisualDensity.compact,
                                          onPressed: () {
                                            setState(() {
                                              if (favorite) {
                                                favorites.remove(name);
                                              } else {
                                                favorites.add(name);
                                              }
                                            });
                                          },
                                          icon: Icon(
                                            favorite
                                                ? Icons.favorite
                                                : Icons.favorite_border,
                                            color: favorite
                                                ? Colors.red
                                                : Colors.grey,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(
                                      10, 9, 10, 8),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        name,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 13,
                                        ),
                                      ),
                                      const SizedBox(height: 5),
                                      Row(
                                        children: [
                                          const Icon(
                                            Icons.star,
                                            size: 14,
                                            color: Colors.orange,
                                          ),
                                          const SizedBox(width: 3),
                                          Text(
                                            '${p['rating']}',
                                            style: const TextStyle(
                                                fontSize: 11),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 5),
                                      Row(
                                        children: [
                                          Flexible(
                                            child: Text(
                                              '₹${p['price']}',
                                              style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 15,
                                                color: Color(0xFF172554),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(width: 5),
                                          Flexible(
                                            child: Text(
                                              '₹${p['old']}',
                                              overflow: TextOverflow.ellipsis,
                                              style: const TextStyle(
                                                color: Colors.grey,
                                                fontSize: 11,
                                                decoration:
                                                    TextDecoration.lineThrough,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 8),
                                      SizedBox(
                                        width: double.infinity,
                                        height: 34,
                                        child: ElevatedButton(
                                          onPressed: () {
                                            setState(() {
                                              cart[name] =
                                                  (cart[name] ?? 0) + 1;
                                            });
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              SnackBar(
                                                content: Text(
                                                    '$name added to cart'),
                                                duration: const Duration(
                                                    seconds: 1),
                                              ),
                                            );
                                          },
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor:
                                                const Color(0xFF2563EB),
                                            foregroundColor: Colors.white,
                                            padding: EdgeInsets.zero,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                          ),
                                          child: const Text(
                                            'Add to Cart',
                                            style:
                                                TextStyle(fontSize: 12),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                        childCount: filtered.length,
                      ),
                    );
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }

  void _showCart() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        if (cart.isEmpty) {
          return const Padding(
            padding: EdgeInsets.all(32),
            child: Text('Your cart is empty'),
          );
        }

        final entries = cart.entries.toList();
        final total = entries.fold<int>(0, (sum, entry) {
          final product =
              products.firstWhere((p) => p['name'] == entry.key);
          return sum +
              (product['price'] as int) * entry.value;
        });

        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Your Cart',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 12),
                ...entries.map((entry) {
                  final product = products.firstWhere(
                    (p) => p['name'] == entry.key,
                  );
                  return ListTile(
                    title: Text(entry.key),
                    subtitle: Text(
                      '₹${product['price']} × ${entry.value}',
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.remove_circle_outline),
                      onPressed: () {
                        setState(() {
                          if (entry.value > 1) {
                            cart[entry.key] = entry.value - 1;
                          } else {
                            cart.remove(entry.key);
                          }
                        });
                        Navigator.pop(context);
                        _showCart();
                      },
                    ),
                  );
                }),
                const Divider(),
                Text(
                  'Total: ₹$total',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 12),
                const Text(
                  'Demo cart only. Checkout will be connected later.',
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

