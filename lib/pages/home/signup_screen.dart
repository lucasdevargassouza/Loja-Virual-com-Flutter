import 'package:flutter/material.dart';
import 'package:loja_virtual/pages/home/login_screem.dart';
import 'package:loja_virtual/share/models/user.dart';
import 'package:scoped_model/scoped_model.dart';

class SignupScreen extends StatefulWidget {
  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _senhaController = TextEditingController();
  final TextEditingController _enderecoController = TextEditingController();

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    void _onSucess() {
      _scaffoldKey.currentState.showSnackBar(
        SnackBar(
          content: Text("Usuário criado com sucesso!"),
          backgroundColor: Theme.of(context).primaryColor,
          duration: Duration(seconds: 2),
        ),
      );
      Future.delayed(Duration(seconds: 2)).then((_){
        Navigator.pop(context);
      });
    }
    void _onFail() {
      _scaffoldKey.currentState.showSnackBar(
        SnackBar(
          content: Text("Falha ao criar o usuário!"),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 2),
        ),
      );
    }

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text("Criar conta"),
        centerTitle: true,
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
                  controller: _nameController,
                  validator: (text) {
                    if (text.isEmpty) return "Nome inválido!";
                    return null;
                  },
                  decoration: InputDecoration(hintText: "Nome completo"),
                ),
                SizedBox(height: 10),
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
                SizedBox(height: 16),
                TextFormField(
                  controller: _enderecoController,
                  validator: (text) {
                    if (text.isEmpty) return "Endereço inválido!";
                    return null;
                  },
                  decoration: InputDecoration(hintText: "Endereço completo"),
                ),
                SizedBox(height: 10),
                SizedBox(
                  height: 50,
                  child: RaisedButton(
                    onPressed: () {
                      if (_formKey.currentState.validate()) {
                        Map<String, dynamic> userData = {
                          "name": _nameController.text,
                          "email": _emailController.text,
                          "address": _enderecoController.text,
                        };

                        model.signUp(
                          userData: userData,
                          pass: _senhaController.text,
                          onSucess: _onSucess,
                          onFail: _onFail,
                        );
                      }
                    },
                    child: Text("Criar conta", style: TextStyle(fontSize: 18)),
                    textColor: Colors.white,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                SizedBox(height: 10),
                SizedBox(
                  height: 50,
                  child: FlatButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => LoginScreem()));
                    },
                    child: Text("Fazer login", style: TextStyle(fontSize: 18)),
                    textColor: Theme.of(context).primaryColor,
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
