import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'reusable_widgets.dart';
//import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:restaurant_universitaire/models/student_model.dart';

class ProfileScreen extends StatefulWidget {
  final Student student;
  const ProfileScreen({super.key, required this.student});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  Map<String, dynamic>? data;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    data = widget.student.toFirestore();
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    final userName = data?['Name'] ?? "Not Available !";
    final userCin = data?['Cin'] ?? "Not Available";
    final userUniversity = data?['University'] ?? "Not Available";
    final userFaculty = data?['Faculty'] ?? "Not Available";
    final userNiveau = data?['Level'] ?? "Not Available";
    final specialite = data?['Specialite'] ?? "Not Available";
    final repas = data?['NbRepas'] ?? "Not Available";
    final membreDepuis = data?['MembreDepuis'] ?? "Not Available";
    final totalDepense = data?['TotalDepense'] ?? "Not Available";

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              decoration: const BoxDecoration(
                color: Color(0xFF0891B2),
                borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(24),
                    bottomLeft: Radius.circular(24)),
              ),
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          IconButton(
                            onPressed: () => Navigator.pop(context),
                            icon: const Icon(Icons.arrow_back,
                                color: Colors.white),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            'Mon Profil',
                            style: Theme.of(context)
                                .textTheme
                                .headlineMedium
                                ?.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 32),
                      Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.2),
                          borderRadius: BorderRadius.circular(50),
                          border: Border.all(
                            color: Colors.white.withValues(alpha: 0.3),
                            width: 3,
                          ),
                        ),
                        child: const Icon(Icons.person,
                            color: Colors.white, size: 50),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        userName,
                        style:
                            Theme.of(context).textTheme.headlineSmall?.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                      ),
                      Text(
                        'Étudiant en $specialite',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: Colors.white.withValues(alpha: 0.8),
                            ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                children: [
                  buildInfoSection(
                    context,
                    'Informations Personnelles',
                    [
                      buildInfoItem(context, 'CIN', userCin, Icons.credit_card),
                      buildInfoItem(
                          context, 'Université', userUniversity, Icons.school),
                      buildInfoItem(
                          context, 'Faculté', userFaculty, Icons.computer),
                      buildInfoItem(context, 'Niveau', userNiveau, Icons.grade),
                    ],
                  ),
                  const SizedBox(height: 32),
                  buildInfoSection(
                    context,
                    'Statistiques',
                    [
                      buildInfoItem(context, 'Repas ce mois', '$repas repas',
                          Icons.restaurant),
                      buildInfoItem(
                          context,
                          'Total dépensé',
                          '$totalDepense millimes',
                          Icons.account_balance_wallet),
                      buildInfoItem(context, 'Membre depuis', membreDepuis,
                          Icons.calendar_today),
                    ],
                  ),
                  const SizedBox(height: 32),
                  Container(
                    width: double.infinity,
                    height: 56,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: const Color(0xFFEC4899),
                        width: 2,
                      ),
                    ),
                    child: TextButton(
                      onPressed: () {
                        //  await supabase.auth.signOut();
                        FirebaseAuth.instance.signOut();
                        if (mounted) {
                          Navigator.pushReplacementNamed(context, '/login');
                        }
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.logout, color: Color(0xFFEC4899)),
                          const SizedBox(width: 8),
                          Text(
                            'Se déconnecter',
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(
                                  color: const Color(0xFFEC4899),
                                  fontWeight: FontWeight.w600,
                                ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
