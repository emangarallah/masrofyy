import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:masrofyy/features/expenses/models/expense_entry_model.dart';
import 'package:masrofyy/features/expenses/repository/expense_repo.dart';


class ExpenseController extends AsyncNotifier<List<ExpenseEntryModel>> {
  late final ExpenseRepository _repository;
  @override
  Future<List<ExpenseEntryModel>> build() {
    _repository = ref.read(expenseRepositoryProvider);
    return _getExpenses();
  }

  Future<List<ExpenseEntryModel>> _getExpenses() async{
    return _repository.getExpenseEntries();

  }
  Future<void> addExpense(ExpenseEntryModel expense) async{
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(()async{
      await _repository.addExpenseEntry(expense);
      return _getExpenses();
    });




}

  Future<void> updateEntry(ExpenseEntryModel expense) async {
    state = const AsyncValue.loading();

    state = await AsyncValue.guard(() async {
      await _repository.updateExpenseEntry(expense);

      return _getExpenses();
    });
  }

  Future<void> deleteEntry(String id) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      await _repository.deleteExpenseEntry(id);
      return _getExpenses();

    });



  }






}
final expenseControllerProvider = AsyncNotifierProvider<ExpenseController,List<ExpenseEntryModel>>(ExpenseController.new);