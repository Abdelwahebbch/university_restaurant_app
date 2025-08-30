import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class PaymentModal extends StatefulWidget {
  final int tickets;
  final VoidCallback onClose;
  final VoidCallback onSuccess;
  final VoidCallback onFailure;
  const PaymentModal({
    super.key,
    required this.tickets,
    required this.onClose,
    required this.onSuccess,
    required this.onFailure,
  });

  @override
  State<PaymentModal> createState() => _PaymentModalState();
}

class _PaymentModalState extends State<PaymentModal> {
  final expDateFormatter = MaskTextInputFormatter(mask: '##/##');
  final cardNumFormatter = MaskTextInputFormatter(mask: '#### #### #### ####');
  final cvvFormatter = MaskTextInputFormatter(mask: '###');
  final _formKey = GlobalKey<FormState>();
  final _cardNumberController = TextEditingController();
  final _expiryController = TextEditingController();
  final _cvvController = TextEditingController();
  final _nameController = TextEditingController();
  bool _isProcessing = false;

  void _processPayment() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isProcessing = true;
      });

      await Future.delayed(Duration(seconds: 2));
      //Api Call ClicToPay
      if (mounted) {
        setState(() {
          _isProcessing = false;
        });
        widget.onSuccess();
        //  widget.onFailure();

        //TODO : tester le code retourner depuis l'API
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black.withValues(alpha: 0.5),
      child: Center(
        child: Container(
          margin: EdgeInsets.all(24),
          padding: EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Paiement sécurisé',
                        style:
                            Theme.of(context).textTheme.headlineSmall?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF4B5563),
                                ),
                      ),
                      IconButton(
                        onPressed: widget.onClose,
                        icon: Icon(Icons.close),
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Color(0xFFF9FAFB),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '${widget.tickets} ticket(s)',
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                        Text(
                          '${widget.tickets * 200} millimes',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: Color(0xFF0891B2),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 24),
                  TextFormField(
                    inputFormatters: [cardNumFormatter],
                    controller: _cardNumberController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: 'Numéro de carte',
                      hintText: '1234 0000 1111 1111',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      prefixIcon: Icon(Icons.credit_card),
                    ),
                    validator: (numCarte) {
                      if (numCarte == null || numCarte.isEmpty) {
                        return 'Veuillez saisir le numéro de carte';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          inputFormatters: [expDateFormatter],
                          controller: _expiryController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            labelText: 'MM/AA',
                            hintText: '12/25',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          validator: (expDate) {
                            if (expDate == null || expDate.isEmpty) {
                              return 'Date requise';
                            }
                            return null;
                          },
                        ),
                      ),
                      SizedBox(width: 12),
                      Expanded(
                        child: TextFormField(
                          inputFormatters: [cvvFormatter],
                          controller: _cvvController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            labelText: 'CVV',
                            hintText: '123',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          validator: (cvv) {
                            if (cvv == null || cvv.isEmpty) {
                              return 'CVV requis';
                            }
                            return null;
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  TextFormField(
                    controller: _nameController,
                    decoration: InputDecoration(
                      labelText: 'Nom sur la carte',
                      hintText: 'Foulen Ben Foulen',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      prefixIcon: Icon(Icons.person),
                    ),
                    validator: (nom) {
                      if (nom == null || nom.isEmpty) {
                        return 'Veuillez saisir le nom';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 25),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _isProcessing ? null : _processPayment,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF0891B2),
                        foregroundColor: Colors.white,
                        padding: EdgeInsets.symmetric(vertical: 16),
                      ),
                      child: _isProcessing
                          ? const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                    strokeWidth: 2,
                                  ),
                                ),
                                SizedBox(width: 12),
                                Text('Traitement en cours...'),
                              ],
                            )
                          : Text(
                              'Payer ${widget.tickets * 200} millimes',
                              style: TextStyle(fontWeight: FontWeight.w600),
                            ),
                    ),
                  ),
                  SizedBox(height: 16),
                  Row(
                    children: [
                      Icon(
                        Icons.lock,
                        size: 16,
                        color: Color(0xFF9CA3AF),
                      ),
                      SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          'Paiement sécurisé',
                          style:
                              Theme.of(context).textTheme.bodySmall?.copyWith(
                                    color: Color(0xFF9CA3AF),
                                  ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
