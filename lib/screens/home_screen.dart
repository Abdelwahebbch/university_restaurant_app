import 'package:flutter/material.dart';
import 'package:restaurant_universitaire/widgets/balance_card.dart';
import 'package:restaurant_universitaire/widgets/informations_modal.dart';
import 'package:restaurant_universitaire/widgets/quick_actions.dart';
import 'package:restaurant_universitaire/widgets/recharge_modal.dart';
import 'package:restaurant_universitaire/widgets/payment_modal.dart';
import 'package:restaurant_universitaire/widgets/success_message.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int balance = 0;
  bool showRecharge = false;
  bool showPayment = false;
  int selectedTickets = 1;
  bool paymentSuccess = false;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  void handleRecharge(int t) {
    setState(() {
      selectedTickets = t;
      showRecharge = false;
      showPayment = true;
    });
  }

  void handlePaymentSuccess() {
    setState(() {
      balance += selectedTickets;
      showPayment = false;
      paymentSuccess = true;
    });

    Future.delayed(Duration(seconds: 3), () {
      if (mounted) {
        setState(() {
          paymentSuccess = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: _scaffoldKey,
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              ListTile(
                leading:
                    const Icon(Icons.home_outlined, color: Color(0xFF0891B2)),
                title: const Text('Accueil'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading:
                    const Icon(Icons.person_outline, color: Color(0xFF0891B2)),
                title: const Text('Mon Profil'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, '/profile');
                },
              ),
              ListTile(
                leading: const Icon(Icons.history, color: Color(0xFF0891B2)),
                title: const Text('Historique'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, '/history');
                },
              ),
              const Divider(),
              ListTile(
                leading:
                    const Icon(Icons.info_outline, color: Color(0xFF0891B2)),
                title: const Text('À propos'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, '/about');
                },
              ),
              ListTile(
                leading: const Icon(Icons.logout, color: Colors.red),
                title: const Text('Déconnexion'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushReplacementNamed(context, '/login');
                },
              ),
            ],
          ),
        ),
        body: Stack(
          children: [
            Column(
              children: [
                Container(
                  decoration: const BoxDecoration(
                    color: Color(0xFF0891B2),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(24),
                      bottomRight: Radius.circular(24),
                    ),
                  ),
                  child: SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  _scaffoldKey.currentState?.openDrawer();
                                },
                                child: Container(
                                  width: 48,
                                  height: 48,
                                  decoration: BoxDecoration(
                                    color: Colors.white.withValues(alpha: 0.2),
                                    borderRadius: BorderRadius.circular(24),
                                  ),
                                  child: const Icon(
                                    Icons.menu,
                                    color: Colors.white,
                                    size: 24,
                                  ),
                                ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(right: 5),
                                    child: Text(
                                      'AL Wahat - الواحات',
                                      style: Theme.of(context)
                                          .textTheme
                                          .headlineMedium
                                          ?.copyWith(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                          ),
                                    ),
                                  ),
                                  Text(
                                    'Restaurant Universitaire',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium
                                        ?.copyWith(
                                          color: Colors.white
                                              .withValues(alpha: 0.8),
                                        ),
                                  ),
                                ],
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.pushNamed(context, '/profile');
                                },
                                child: Container(
                                  width: 48,
                                  height: 48,
                                  decoration: BoxDecoration(
                                    color: Colors.white.withValues(alpha: 0.2),
                                    borderRadius: BorderRadius.circular(24),
                                  ),
                                  child: const Icon(
                                    Icons.person,
                                    color: Colors.white,
                                    size: 24,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 24),
                          BalanceCard(balance: balance),
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Column(
                      children: [
                        QuickActions(
                          /*  onHistoryPressed: () {
                            setState(() {
                              Navigator.pushNamed(context, '/history');
                            });
                          },*/
                          onRechargePressed: () {
                            setState(() {
                              showRecharge = true;
                            });
                          },
                        ),
                        // SizedBox(height: 32),
                      ],
                    ),
                  ),
                ),
                Expanded(child: InformationsWidget())
              ],
            ),
            if (paymentSuccess) SuccessMessage(tickets: selectedTickets),
            if (showRecharge)
              RechargeModal(
                  onClose: () {
                    setState(() {
                      showRecharge = false;
                    });
                  },
                  onRecharge: handleRecharge),
            if (showPayment)
              PaymentModal(
                  tickets: selectedTickets,
                  onClose: () {
                    setState(() {
                      showPayment = false;
                    });
                  },
                  onSuccess: handlePaymentSuccess),
          ],
        ),
      ),
    );
  }
}
