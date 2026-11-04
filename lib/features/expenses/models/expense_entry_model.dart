class ExpenseEntryModel {
  final String id;
  final String title;
  final String description;
  final double amount;
  final int month;
  final int year;
  final String category;

  const ExpenseEntryModel({
    required this.id,
    required this.title,
    required this.description,
    required this.amount,
    required this.month,
    required this.year,
    required this.category,
  });

  /// Getter for date derived from year and month
  DateTime get date => DateTime(year, month);

  /// Key for month-year filtering (e.g. "2026-07")
  String get monthYear => '$year-${month.toString().padLeft(2, '0')}';

  factory ExpenseEntryModel.fromMap(String id, Map<String, dynamic> json) {
    return ExpenseEntryModel(
      id: id,
      title: json['title'] as String? ?? '',
      description: json['description'] as String? ?? '',
      amount: (json['amount'] as num?)?.toDouble() ?? 0,
      month: json['month'] as int? ?? DateTime.now().month,
      year: json['year'] as int? ?? DateTime.now().year,
      category: json['category'] as String? ?? 'other',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
      'amount': amount,
      'month': month,
      'year': year,
      'category': category,
    };
  }

  ExpenseEntryModel copyWith({
    String? id,
    String? title,
    String? description,
    double? amount,
    int? month,
    int? year,
    String? category,
  }) {
    return ExpenseEntryModel(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      amount: amount ?? this.amount,
      month: month ?? this.month,
      year: year ?? this.year,
      category: category ?? this.category,
    );
  }
}