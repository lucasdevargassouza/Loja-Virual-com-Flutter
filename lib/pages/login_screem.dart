import 'package:flutter/material.dart';
import 'package:loja_virtual/pages/signup_screen.dart';
import 'package:loja_virtual/share/models/user.dart';
import 'package:scoped_model/scoped_model.dart';

class LoginScreem extends StatefulWidget {
  @override
  _LoginScreemState createState() => _LoginScreemState();
}

class _LoginScreemState extends State<LoginScreem> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _senhaController = TextEditingController();

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  void _onSucess() {
    Navigator.pop(context);
  }

  void _onFail() {
    _scaffoldKey.currentState.showSnackBar(
      SnackBar(
        content: Text("Falha na tentativa de login!"),
        backgroundColor: Colors.red,
        duration: Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text("Entrar"),
        centerTitle: true,
        actions: <Widget>[
          FlatButton(
            onPressed: () {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => SignupScreen()));
            },
            child: Text(
              "CRIAR CONTA",
              style: TextStyle(
                fontSize: 15,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
      body: ScopedModelDescendant<User>(
        builder: (context, child, model) {
          if (model.isLoading)
            return Center(child: CircularProgressIndicator());
          return Form(
            key: _formKey,
            child: ListView(
              padding: EdgeInsets.all(16),
              children: <Widget>[
                TextFormField(
                  controller: _emailController,
                  validator: (text) {
                    if (text.isEmpty || !text.contains("@"))
                      return "Email inválido!";
                    return null;
                  },
                  decoration: InputDecoration(hintText: "Email"),
                  keyboardType: TextInputType.emailAddress,
                ),
                SizedBox(height: 10),
                TextFormField(
                  controller: _senhaController,
                  validator: (text) {
                    if (text.isEmpty || (text.length < 6))
                      return "Senha inválida!";
                    return null;
                  },
                  decoration: InputDecoration(hintText: "Senha"),
                  obscureText: true,
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: FlatButton(
                    padding: EdgeInsets.zero,
                    onPressed: () {
                      if (!_emailController.text.contains("@")) {
                        _scaffoldKey.currentState.showSnackBar(
                          SnackBar(
                            content:
                                Text("Preencha seu email para recuperação!"),
                            backgroundColor: Colors.red,
                            duration: Duration(seconds: 2),
                          ),
                        );
                      } else {
                        model.recoverPass(_emailController.text);
                        _scaffoldKey.currentState.showSnackBar(
                          SnackBar(
                            content:
                                Text("Confira seu email!"),
                            backgroundColor: Colors.green,
                            duration: Duration(seconds: 2),
                          ),
                        );
                      }
                    },
                    child: Text("Esqueci minha senha"),
                  ),
                ),
                SizedBox(height: 16),
                SizedBox(
                  height: 50,
                  child: RaisedButton(
                    onPressed: () {
                      if (_formKey.currentState.validate()) {
                        model.signIn(
                          email: _emailController.text,
                          pass: _senhaController.text,
                          onSucess: _onSucess,
                          onFail: _onFail,
                        );
                      }
                    },
                    child: Text("Entrar", style: TextStyle(fontSize: 18)),
                    textColor: Colors.white,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
