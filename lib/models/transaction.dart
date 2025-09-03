class Transaction {
  final String id;
  final TransactionType type;
  final int amount; // En tickets
  final DateTime date;
  final String description;
  final TransactionStatus status;

  Transaction({
    required this.id,
    required this.type,
    required this.amount,
    required this.date,
    required this.description,
    required this.status,
  });
}

enum TransactionType {
  recharge,
  usage,
}

enum TransactionStatus {
  completed,
  pending,
  failed,
}
