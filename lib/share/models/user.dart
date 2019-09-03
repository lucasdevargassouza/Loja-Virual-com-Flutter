import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:scoped_model/scoped_model.dart';
import 'dart:async';

class User extends Model {
  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseUser firabaseUser;

  Map<String, dynamic> userData = Map();

  bool isLoading = false;

  static User of(BuildContext context) =>  ScopedModel.of<User>(context);

  @override
  void addListener(VoidCallback listener) {
    super.addListener(listener);
    _loadUserData();
  }

  // Cadastra um novo user no firabase.
  void signUp({
    @required Map<String, dynamic> userData,
    @required String pass,
    @required VoidCallback onSucess,
    @required VoidCallback onFail,
  }) {
    isLoading = true;
    notifyListeners();

    // Cria o usuário no firabase.
    _auth
        .createUserWithEmailAndPassword(
            email: userData["email"], password: pass)
        .then((user) async {
      firabaseUser = user;

      // Salva os dados do usuário no firebase.
      await _saveUserData(userData);
      _loadUserData();

      isLoading = false;
      notifyListeners();
      onSucess();
    }).catchError((e) {
      isLoading = false;
      notifyListeners();
      onFail();
    });
  }

  void signIn({
    @required String email,
    @required String pass,
    @required VoidCallback onSucess,
    @required VoidCallback onFail,
  }) async {
    isLoading = true;
    notifyListeners();

    _auth.signInWithEmailAndPassword(email: email, password: pass).then((user) {
      firabaseUser = user;
      isLoading = false;
      _loadUserData();
      notifyListeners();
      onSucess();
    }).catchError((e) {
      isLoading = false;
      notifyListeners();
      onFail();
    });
  }

  void signOut() async {
    await _auth.signOut();

    userData = Map();
    firabaseUser = null;

    notifyListeners();
  }

  void recoverPass(String email) {
    _auth.sendPasswordResetEmail(email: email);
  }

  bool isLoggedIn() {
    return firabaseUser != null;
  }

  // Salva os dados do usuário no firebase.
  Future<Null> _saveUserData(Map<String, dynamic> userData) async {
    this.userData = userData;
    await Firestore.instance
        .collection("users")
        .document(firabaseUser.uid)
        .setData(userData);
  }

  Future<Null> _loadUserData() async {
    if (firabaseUser == null) {
      firabaseUser = await _auth.currentUser();
    }
    if (firabaseUser != null) {
      if(userData["name"] == null) {
        DocumentSnapshot docUser = await Firestore.instance.collection("users").document(firabaseUser.uid).get();
        userData = docUser.data;
      }
    }
    notifyListeners();
  }
}
