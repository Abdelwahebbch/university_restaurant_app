import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:restaurant_universitaire/screens/home_screen.dart';
import 'package:restaurant_universitaire/screens/reusable_widgets.dart';
import 'package:restaurant_universitaire/theme/app_theme.dart';
import 'package:restaurant_universitaire/widgets/failure_message.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:restaurant_universitaire/models/student_model.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _cinController = TextEditingController();
  final _specialCodeController = TextEditingController();
  final _auth = FirebaseAuth.instance;

  bool _connectIssue = false;
  bool _isLoading = false;

  Student? student;

  @override
  void dispose() {
    _cinController.dispose();
    _specialCodeController.dispose();
    super.dispose();
  }

  Future<Student?> fetchStudent() async {
    final uid = FirebaseAuth.instance.currentUser?.email;
    if (uid == null) return null;

    final doc = await FirebaseFirestore.instance
        .collection('userProfile')
        .doc(uid)
        .get();

    if (!doc.exists) return Student.emptyStudent();
    var data = doc.data();
    return Student.fromFireStore(data!);
  }

  Future<void> _handleLogin() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
        _connectIssue = false;
      });

      try {
        await _auth.signInWithEmailAndPassword(
            email: "${_cinController.text}@gmail.com",
            password: _specialCodeController.text);

        student = await fetchStudent();

        if (mounted && _auth.currentUser != null) {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) {
            return HomeScreen(student: student!);
          }));
        }
      } catch (e) {
        if (mounted) {
          setState(() {
            _connectIssue = true;
            _isLoading = false;
          });
        }
        Future.delayed(const Duration(seconds: 3), () {
          if (mounted) {
            setState(() {
              _connectIssue = false;
            });
          }
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      body: Stack(children: [
        SingleChildScrollView(
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 60),
                  Column(
                    children: [
                      Container(
                          width: 120,
                          height: 120,
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [
                                AppTheme.primaryColor,
                                AppTheme.secondaryColor
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Image.asset(
                            "images/logo.png",
                          )),
                      const SizedBox(height: 24),
                      Text(
                        'Wahat - واحات',
                        style:
                            Theme.of(context).textTheme.headlineLarge?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: AppTheme.textColor,
                                ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Connectez-vous à votre compte étudiant',
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                              color: AppTheme.textColor.withValues(alpha: 0.7),
                            ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                  const SizedBox(height: 50),
                  Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        // Champ CIN
                        buildInputField(
                          controller: _cinController,
                          label: 'Numéro CIN',
                          hint: 'Entrez votre numéro CIN',
                          icon: Icons.credit_card,
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                            LengthLimitingTextInputFormatter(8)
                          ],
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Veuillez entrer votre numéro CIN';
                            }
                            if (value.length != 8) {
                              return 'Le numéro CIN doit contenir 8 chiffres';
                            }
                            return null;
                          },
                          style:
                              Theme.of(context).textTheme.titleSmall?.copyWith(
                                    color: AppTheme.textColor,
                                    fontWeight: FontWeight.w600,
                                  ),
                        ),
                        const SizedBox(height: 20),
                        buildInputField(
                          controller: _specialCodeController,
                          label: 'Code spécial',
                          hint: 'Entrez votre code spécial',
                          icon: Icons.security,
                          keyboardType: TextInputType.text,
                          textCapitalization: TextCapitalization.characters,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Veuillez entrer votre code spécial';
                            }
                            if (value.length < 4) {
                              return 'Le code spécial doit contenir au moins 4 caractères';
                            }
                            return null;
                          },
                          style:
                              Theme.of(context).textTheme.titleSmall?.copyWith(
                                    color: AppTheme.textColor,
                                    fontWeight: FontWeight.w600,
                                  ),
                        ),

                        const SizedBox(height: 32),

                        ElevatedButton(
                          onPressed: _isLoading ? null : _handleLogin,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppTheme.primaryColor,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),
                          child: _isLoading
                              ? const SizedBox(
                                  height: 20,
                                  width: 20,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                        Colors.white),
                                  ),
                                )
                              : Text(
                                  'Se connecter',
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium
                                      ?.copyWith(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600,
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
          ),
        ),
        if (_connectIssue)
          FailureMessage(
            message: "You Dont have an Account !",
          ),
      ]),
    );
  }
}
