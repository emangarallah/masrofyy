import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:masrofyy/features/goals/models/goal_model.dart';

class GoalRepository {

  final FirebaseFirestore _firestore;
  final FirebaseAuth _auth;
  GoalRepository({ required FirebaseFirestore firestore,
    required  FirebaseAuth auth}):_firestore = firestore,
  _auth = auth;


  CollectionReference<Map<String,dynamic>> get _goalsCollection{
    final uid = _auth.currentUser!.uid;
    return _firestore.collection("users").doc(uid).collection("goals");
  }
  //add goals
Future<void> addGoal(GoalModal goal)async{
    await _goalsCollection.add(goal.toMap());

}//update
Future<void> updateGoal(GoalModal goal)async{
    await _goalsCollection.doc(goal.id).update(goal.toMap());


}
//delete
Future<void> deleteGoal(GoalModal goal)async{
    await _goalsCollection.doc(goal.id).delete();

}
Future<List<GoalModal>> getModel ()async{
    final snapshot = await _goalsCollection.get();
    return snapshot.docs.map((doc) => GoalModal.fromMap(doc.id,doc.data())).toList();

}



}