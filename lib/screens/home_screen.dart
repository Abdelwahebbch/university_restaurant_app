import 'package:flutter/material.dart';
import 'package:restaurant_universitaire/widgets/balance_card.dart';
import 'package:restaurant_universitaire/widgets/informations_modal.dart';
import 'package:restaurant_universitaire/widgets/quick_actions.dart';
import 'package:restaurant_universitaire/widgets/recharge_modal.dart';
import 'package:restaurant_universitaire/widgets/payment_modal.dart';
import 'package:restaurant_universitaire/widgets/success_message.dart';
import 'history_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int balance = 0;
  bool showRecharge = false;
  bool showHistory = false;
  bool showPayment = false;
  int selectedTickets = 1;
  bool paymentSuccess = false;

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
                              Container(
                                width: 48,
                                height: 48,
                                decoration: BoxDecoration(
                                  color: Colors.white.withValues(alpha: 0.2),
                                  borderRadius: BorderRadius.circular(24),
                                ),
                                child: const Icon(
                                  Icons.account_balance_wallet,
                                  color: Colors.white,
                                  size: 24,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 24),
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
                          onHistoryPressed: () {
                            setState(() {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const HistoryScreen()),
                              );
                            });
                          },
                          onRechargePressed: () {
                            setState(() {
                              showRecharge = true;
                            });
                          },
                        ),
                        const SizedBox(height: 32),
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
