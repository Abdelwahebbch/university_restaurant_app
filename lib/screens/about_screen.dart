import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'À propos',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: const Color(0xFF0891B2),
        iconTheme: const IconThemeData(color: Colors.white),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Logo et titre de l'app
            Center(
              child: Column(
                children: [
                  Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      color: const Color(0xFF0891B2),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Icon(
                      Icons.restaurant,
                      color: Colors.white,
                      size: 40,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Wahat - واحات',
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                          color: const Color(0xFF0891B2),
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  Text(
                    'Version 1.0.0',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Colors.grey[600],
                        ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 32),

            // Description
            _buildSection(
              context,
              'Description',
              'Wahat App est l\'application officielle de restaurant universitaire Al Wahat Gabes. Elle permet aux étudiants de gérer facilement leur carte de restauration électroniques, consulter leur solde et recharger leurs tickets en ligne.',
              Icons.info_outline,
            ),

            const SizedBox(height: 24),

            _buildSection(
              context,
              'Fonctionnalités',
              '• Consultation du solde en temps réel\n• Recharge de tickets sécurisée\n• Historique des transactions\n• Interface moderne et intuitive\n• Compatible Android et iOS',
              Icons.star_outline,
            ),

            const SizedBox(height: 24),

            _buildSection(
              context,
              'Contact',
              'Pour toute question ou assistance technique, contactez le support étudiant de votre université.',
              Icons.contact_support_outlined,
            ),

            const SizedBox(height: 24),

            _buildSection(
              context,
              'Développement',
              "Wahat App est une application développée par Abdelwaheb Bouchahwa dans le cadre d’un projet de fin d’études pour l’année universitaire 2025/2026. ",
              Icons.code_outlined,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(
      BuildContext context, String title, String content, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                icon,
                color: const Color(0xFF0891B2),
                size: 24,
              ),
              const SizedBox(width: 12),
              Text(
                title,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF0891B2),
                    ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            content,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Colors.grey[700],
                  height: 1.5,
                ),
          ),
        ],
      ),
    );
  }
}
