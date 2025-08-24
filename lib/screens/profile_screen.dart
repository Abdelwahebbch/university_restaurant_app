import 'package:flutter/material.dart';
//import 'package:restaurant_universitaire/main.dart';
//import 'package:supabase_flutter/supabase_flutter.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  Map<String, dynamic>? data;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    getData();
  }

  Future<void> getData() async {
    try {
      // final response = await Supabase.instance.client
      //     .from('profiles')
      //     .select()
      //     .eq('id', supabase.auth.currentUser?.id as Object)
      //     .single();

      if (mounted) {
        setState(() {
          // data = response;
          isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    final userName = data?['name'] ?? "Not Available";
    final userCin = data?['cin'] ?? "Not Available";
    final userUniversity = data?['university'] ?? "Not Available";
    final userFaculty = data?['faculty'] ?? "Not Available";
    final userNiveau = data?['niveau'] ?? "Not Available";

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          // ===== Header =====
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
                      children: [
                        IconButton(
                          onPressed: () => Navigator.pop(context),
                          icon:
                              const Icon(Icons.arrow_back, color: Colors.white),
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

                    // Avatar
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

                    // User name
                    Text(
                      userName,
                      style:
                          Theme.of(context).textTheme.headlineSmall?.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                    ),
                    Text(
                      'Étudiant en Informatique',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: Colors.white.withValues(alpha: 0.8),
                          ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // ===== Content =====
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                children: [
                  _buildInfoSection(
                    context,
                    'Informations Personnelles',
                    [
                      _buildInfoItem(
                          context, 'CIN', userCin, Icons.credit_card),
                      _buildInfoItem(
                          context, 'Université', userUniversity, Icons.school),
                      _buildInfoItem(
                          context, 'Faculté', userFaculty, Icons.computer),
                      _buildInfoItem(
                          context, 'Niveau', userNiveau, Icons.grade),
                    ],
                  ),
                  const SizedBox(height: 32),

                  _buildInfoSection(
                    context,
                    'Statistiques',
                    [
                      _buildInfoItem(context, 'Repas ce mois', '23 repas',
                          Icons.restaurant),
                      _buildInfoItem(context, 'Total dépensé', '4600 millimes',
                          Icons.account_balance_wallet),
                      _buildInfoItem(context, 'Membre depuis', 'Septembre 2023',
                          Icons.calendar_today),
                    ],
                  ),
                  const SizedBox(height: 32),

                  // Logout button
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
          ),
        ],
      ),
    );
  }

  // === Reusable UI Widgets ===
  Widget _buildInfoSection(
      BuildContext context, String title, List<Widget> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
                color: const Color(0xFF1F2937),
              ),
        ),
        const SizedBox(height: 16),
        Container(
          decoration: BoxDecoration(
            color: const Color(0xFFF8FAFC),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: const Color(0xFFE2E8F0),
              width: 1,
            ),
          ),
          child: Column(
            children: items.asMap().entries.map((entry) {
              final index = entry.key;
              final item = entry.value;
              return Column(
                children: [
                  item,
                  if (index < items.length - 1)
                    const Divider(height: 1, color: Color(0xFFE2E8F0)),
                ],
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildInfoItem(
      BuildContext context, String label, String value, IconData icon) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: const Color(0xFF0891B2).withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Icon(icon, color: const Color(0xFF0891B2), size: 20),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: const Color(0xFF64748B),
                          fontWeight: FontWeight.w500,
                        )),
                const SizedBox(height: 2),
                Text(value,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: const Color(0xFF1F2937),
                          fontWeight: FontWeight.w600,
                        )),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
