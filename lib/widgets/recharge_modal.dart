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
  final TextEditingController customController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black.withValues(alpha: 0.5),
      child: Center(
        child: Container(
          margin: const EdgeInsets.all(24),
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Recharger ma carte',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFF4B5563),
                        ),
                  ),
                  IconButton(
                    onPressed: widget.onClose,
                    icon: const Icon(Icons.close),
                  ),
                ],
              ),

              const SizedBox(height: 24),

              Text(
                'Choisissez le nombre de tickets',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: const Color(0xFF4B5563),
                    ),
              ),

              const SizedBox(height: 16),

              // Options prédéfinies
              Row(
                children: [
                  Expanded(
                    child: _buildTicketOption(1),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _buildTicketOption(5),
                  ),
                ],
              ),

              const SizedBox(height: 16),

              // Option personnalisée
              TextField(
                controller: customController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Nombre personnalisé',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  suffixText: 'tickets',
                ),
                onChanged: (value) {
                  final tickets = int.tryParse(value);
                  if (tickets != null && tickets > 0) {
                    setState(() {
                      selectedTickets = tickets;
                    });
                  }
                },
              ),

              const SizedBox(height: 24),

              // Résumé
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFFF9FAFB),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Résumé',
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFF4B5563),
                          ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('$selectedTickets ticket(s)'),
                        Text(
                          '${selectedTickets * 200} millimes',
                          style: const TextStyle(fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // Bouton de confirmation
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => widget.onRecharge(selectedTickets),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF0891B2),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: const Text(
                    'Continuer vers le paiement',
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTicketOption(int tickets) {
    final isSelected =
        selectedTickets == tickets && customController.text.isEmpty;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedTickets = tickets;
          customController.clear();
        });
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected
              ? const Color(0xFF0891B2).withValues(alpha: 0.1)
              : Colors.white,
          border: Border.all(
            color:
                isSelected ? const Color(0xFF0891B2) : const Color(0xFFE5E7EB),
            width: isSelected ? 2 : 1,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            Text(
              '$tickets',
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: isSelected
                        ? const Color(0xFF0891B2)
                        : const Color(0xFF4B5563),
                  ),
            ),
            Text(
              tickets == 1 ? 'ticket' : 'tickets',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: const Color(0xFF9CA3AF),
                  ),
            ),
            const SizedBox(height: 4),
            Text(
              '${tickets * 200} millimes',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: isSelected
                        ? const Color(0xFF0891B2)
                        : const Color(0xFF4B5563),
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
