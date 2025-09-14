import 'package:flutter/material.dart';
import 'package:restaurant_universitaire/screens/reusable_widgets.dart';

import '../theme/app_theme.dart';

class TransfereScreen extends StatefulWidget {
  const TransfereScreen({super.key});

  @override
  State<TransfereScreen> createState() => _TransfereScreenState();
}

class _TransfereScreenState extends State<TransfereScreen> {
  final _amounController = TextEditingController();
  final _CINController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              decoration: BoxDecoration(
                  color: Color(0xFF0891B2),
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(25),
                      bottomRight: Radius.circular(25))),
              child: Column(
                children: [
                  Row(
                    children: [
                      IconButton(
                          onPressed: () => Navigator.pop(context),
                          icon: Icon(Icons.arrow_back, color: Colors.white)),
                      Text(
                        "Transfert de tickets",
                        style: Theme.of(context)
                            .textTheme
                            .headlineMedium
                            ?.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  )
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(24),
              child: Text(
                  textAlign: TextAlign.center,
                  "Pour transférer des tickets, veuillez saisir le numéro CIN du destinataire et le nombre de tickets  maxTicket = 10 par transaction   "),
            ),
            Padding(
              padding: EdgeInsets.all(25),
              child: Column(
                children: [
                  buildInputField(
                    controller: _CINController,
                    label: "Numéro CIN",
                    hint: "11223344",
                    icon: Icons.credit_card,
                    keyboardType: TextInputType.number,
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          color: AppTheme.textColor,
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  buildInputField(
                    keyboardType: TextInputType.number,
                    controller: _amounController,
                    label: "Nombre Des Tickets",
                    hint: "Saisie un nombre < 10",
                    icon: Icons.receipt,
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          color: AppTheme.textColor,
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFF0891B2),
                          foregroundColor: Colors.white),
                      onPressed: () {},
                      child: Text(
                        "Envoyer",
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                      ))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
