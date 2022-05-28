import 'package:flutter/material.dart';

class AuthForm extends StatefulWidget {
  //const AuthForm({ Key? key }) : super(key: key);
  AuthForm(this.submitfn, this.isLoading);
  final void Function(
    String username,
    String password,
    String email,
    bool isLogin,
    BuildContext ctx,
  ) submitfn;
  final bool isLoading;

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formKey = GlobalKey<FormState>();
  bool _isLogin = true;
  String _userEmail = '';
  String _username = '';
  String _userPassword = '';

  void _trySubmit() {
    final isValid = _formKey.currentState.validate();
    //to close softKeyboard
    FocusScope.of(context).unfocus();

    if (isValid) {
      _formKey.currentState.save();
      if (_isLogin) {
        _username = "";
        widget.submitfn(
            _username, _userPassword, _userEmail.trim(), _isLogin, context);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        margin: EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  CircleAvatar(radius: 45),
                  FlatButton.icon(
                    onPressed: () {},
                    icon: Icon(Icons.image),
                    label: Text("Add Image"),
                    textColor: Theme.of(context).primaryColor,
                  ),
                  TextFormField(
                    key: ValueKey("email"),
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value.isEmpty || !value.contains('@')) {
                        return 'Please enter a valid email address';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _userEmail = value;
                    },
                    decoration: InputDecoration(
                      labelText: 'Email Address',
                    ),
                  ),
                  if (!_isLogin)
                    TextFormField(
                      key: ValueKey("username"),
                      validator: (value) {
                        if (value.isEmpty || value.length < 4) {
                          return 'Invalid Username';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _username = value;
                      },
                      decoration: InputDecoration(labelText: "Username"),
                    ),
                  TextFormField(
                    //keys are added to help flutter differentiate between similar widgets which may be together
                    key: ValueKey("password"),
                    validator: (value) {
                      if (value.isEmpty || value.length < 7) {
                        return 'Invalid Password';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _userPassword = value;
                    },
                    decoration: InputDecoration(labelText: "Password"),
                    obscureText: true,
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  if (widget.isLoading) CircularProgressIndicator(),
                  if (!widget.isLoading)
                    RaisedButton(
                      onPressed: _trySubmit,
                      child: Text(_isLogin ? "Login" : "Sign Up"),
                    ),
                  FlatButton(
                    child: Text(_isLogin
                        ? "Create New Account"
                        : "I already have an account"),
                    onPressed: () {
                      setState(() {
                        _isLogin = !_isLogin;
                      });
                    },
                    textColor: Theme.of(context).primaryColor,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
