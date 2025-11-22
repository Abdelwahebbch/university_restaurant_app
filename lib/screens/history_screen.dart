import 'package:flutter/material.dart';
import 'package:restaurant_universitaire/screens/reusable_widgets.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                  decoration: BoxDecoration(
                      color: Color(0xFF0891B2),
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(20),
                          bottomRight: Radius.circular(20))),
                  child: Padding(
                    padding: EdgeInsets.all(24),
                    child: Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white.withValues(alpha: 0.2)),
                          child: IconButton(
                              onPressed: () => Navigator.pop(context),
                              icon: Icon(
                                Icons.arrow_back,
                                color: Colors.white,
                              )),
                        ),
                        SizedBox(
                          width: 16,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Historique",
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineMedium
                                  ?.copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                            Text(
                              "Mes Historiques",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(
                                    color: Colors.white.withValues(alpha: 0.8),
                                  ),
                            )
                          ],
                        )
                      ],
                    ),
                  )),
              Padding(
                padding: const EdgeInsets.all(24),
                child: Row(
                  children: [
                    Expanded(
                        child: informationWidget(
                      context,
                      'Ce mois',
                      '12 tickets',
                      'rechargés',
                      Color(0xFFEC4899),
                      Icons.add_circle_outline,
                    )),
                    SizedBox(width: 16),
                    Expanded(
                      child: informationWidget(
                        context,
                        'Ce mois',
                        '12 tickets',
                        'rechargés',
                        Color(0xFFEC4899),
                        Icons.add_circle_outline,
                      ),
                    )
                  ],
                ),
              ),
              emptyState(context)
            ],
          ),
        ));
  }
}
