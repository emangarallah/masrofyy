import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/service/firabase_service.dart';
import '../models/expense_entry_model.dart';

class ExpenseRepository {


  final FirebaseFirestore _firestore;
  final FirebaseAuth _auth;

  const ExpenseRepository ({
  required FirebaseFirestore firestore,
  required FirebaseAuth auth,
  }) : _firestore = firestore,
  _auth = auth;

  CollectionReference<Map<String, dynamic>> get _expenseCollection {
  final uid = _auth.currentUser!.uid;
  return _firestore.collection('users').doc(uid).collection('expense_entries');
  }

  Future<List<ExpenseEntryModel>> getIncomeEntries() async {
  final snapshot = await _expenseCollection .get();
  return snapshot.docs
      .map((doc) => ExpenseEntryModel.fromMap(doc.id, doc.data()))
      .toList();
  }

  Future<void> addExpenseEntry(ExpenseEntryModel expense) async {
  await _expenseCollection .add(expense.toMap());
  }

  Future<void> updateExpenseEntry(ExpenseEntryModel expense) async {
  await _expenseCollection .doc(expense.id).update(expense.toMap());
  }

  Future<void> deleteExpenseEntry(String id) async {
  await _expenseCollection .doc(id).delete();
  }
  Future<List<ExpenseEntryModel>> getExpenseEntries()async{
    final snapshot = await _expenseCollection.orderBy('date',descending: true).get();
    return snapshot.docs.map((doc)=> ExpenseEntryModel.fromMap(doc.id,doc.data())).toList();


  }
  }

  final expenseRepositoryProvider = Provider<ExpenseRepository>((ref) {
  return ExpenseRepository(
  firestore: ref.watch(firestoreProvider),
  auth: ref.watch(firebaseAuthProvider),
  );
  });





