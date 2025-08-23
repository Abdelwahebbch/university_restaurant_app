import 'package:flutter/material.dart';

class RechargeModal extends StatefulWidget {
  final VoidCallback onClose;
  final Function(int) onRecharge;

  const RechargeModal({
    super.key,
    required this.onClose,
    required this.onRecharge,
  });

  @override
  State<RechargeModal> createState() => _RechargeModalState();
}

class _RechargeModalState extends State<RechargeModal> {
  int selectedTickets = 1;
  String errorLabel = "Nombre personnalisé";
  final TextEditingController customController = TextEditingController();

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
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Recharger ma carte',
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
                SizedBox(height: 25),
                Text(
                  'Choisissez le nombre de tickets',
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: Color(0xFF4B5563),
                      ),
                ),
                SizedBox(height: 15),
                Row(
                  children: [
                    Expanded(
                      child: _buildTicketOption(1),
                    ),
                    SizedBox(width: 12),
                    Expanded(
                      child: _buildTicketOption(5),
                    ),
                  ],
                ),
                SizedBox(height: 16),
                TextField(
                  controller: customController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: errorLabel,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    suffixText: 'tickets',
                  ),
                  onChanged: (x) {
                    final nombreTic = int.tryParse(x);
                    if (nombreTic != null &&
                        nombreTic > 0 &&
                        nombreTic <= 100) {
                      setState(() {
                        selectedTickets = nombreTic;
                        errorLabel = "Nombre personnalisé";
                      });
                    } else {
                      setState(() {
                        errorLabel = "Saisie un nb <= 100 ";
                      });
                    }
                  },
                ),
                SizedBox(height: 24),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Color(0xFFF9FAFB),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Résumé',
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF4B5563),
                            ),
                      ),
                      SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('$selectedTickets ticket(s)'),
                          Text(
                            '${selectedTickets * 200} millimes',
                            style: TextStyle(fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () => widget.onRecharge(selectedTickets),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF0891B2),
                      foregroundColor: Colors.white,
                      padding: EdgeInsets.symmetric(vertical: 16),
                    ),
                    child: Text(
                      'Continuer vers le paiement',
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTicketOption(int nbTickets) {
    final isSelected =
        selectedTickets == nbTickets && customController.text.isEmpty;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedTickets = nbTickets;
          customController.clear();
        });
      },
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected
              ? Color(0xFF0891B2).withValues(alpha: 0.1)
              : Colors.white,
          border: Border.all(
            color: isSelected ? Color(0xFF0891B2) : Color(0xFFE5E7EB),
            width: isSelected ? 2 : 1,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            Text(
              '$nbTickets',
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: isSelected ? Color(0xFF0891B2) : Color(0xFF4B5563),
                  ),
            ),
            Text(
              nbTickets == 1 ? 'ticket' : 'tickets',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Color(0xFF9CA3AF),
                  ),
            ),
            SizedBox(height: 5),
            Text(
              '${nbTickets * 200} millimes',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: isSelected ? Color(0xFF0891B2) : Color(0xFF4B5563),
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
