import 'package:flutter/material.dart';
import 'package:flutter_form_validation_app/src/blocs/provider.dart';
import 'package:flutter_form_validation_app/src/pages/home_page.dart';

class LoginPage extends StatelessWidget {
  static final String routeName = 'login';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: new Stack(
      children: <Widget>[
        _crearFondo(context),
        _loginForm(context),
      ],
    ));
  }

  Widget _crearFondo(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final fondoMorado = new Container(
      height: size.height * 0.4,
      width: double.infinity,
      decoration: new BoxDecoration(
          gradient: new LinearGradient(colors: <Color>[
        Color.fromRGBO(63, 63, 156, 1.0),
        Color.fromRGBO(90, 70, 178, 1.0),
      ])),
    );
    final circulo = new Container(
      width: 100.0,
      height: 100.0,
      decoration: new BoxDecoration(
          borderRadius: BorderRadius.circular(100.0),
          color: Color.fromRGBO(255, 255, 255, 0.05)),
    );
    final iconoYnombre = new Container(
      padding: EdgeInsets.only(top: 80.0),
      child: new Column(
        children: <Widget>[
          new Icon(
            Icons.local_hospital,
            color: Colors.white,
            size: 100.0,
          ),
          new SizedBox(
            height: 10.0,
            width: double.infinity,
          ),
          new Text(
            'Hola Mundo',
            style: new TextStyle(color: Colors.white, fontSize: 25.0),
          )
        ],
      ),
    );
    return new Stack(
      children: <Widget>[
        fondoMorado,
        new Positioned(
          top: 90.0,
          left: 30.0,
          child: circulo,
        ),
        new Positioned(
          top: -40.0,
          right: -30.0,
          child: circulo,
        ),
        new Positioned(
          bottom: -50.0,
          right: -10.0,
          child: circulo,
        ),
        new Positioned(
          bottom: 120.0,
          right: 20.0,
          child: circulo,
        ),
        new Positioned(
          bottom: -50.0,
          left: -20.0,
          child: circulo,
        ),
        iconoYnombre
      ],
    );
  }

  Widget _loginForm(BuildContext context) {
    final bloc = Provider.of(context);
    final size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: new Column(
        children: <Widget>[
          new SafeArea(
            child: new Container(
              height: 180.0,
            ),
          ),
          new Container(
            width: size.width * 0.85,
            margin: EdgeInsets.symmetric(vertical: 30.0),
            padding: EdgeInsets.symmetric(vertical: 50.0),
            decoration: new BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5.0),
                boxShadow: <BoxShadow>[
                  new BoxShadow(
                      color: Colors.black26,
                      blurRadius: 3.0,
                      offset: new Offset(0.0, 0.5),
                      spreadRadius: 3.0)
                ]),
            child: new Column(
              children: <Widget>[
                new Text(
                  'Ingreso',
                  style: new TextStyle(fontSize: 20.0),
                ),
                new SizedBox(height: 60.0),
                _crearEmail(bloc),
                new SizedBox(height: 30.0),
                _crearPassword(bloc),
                new SizedBox(height: 30.0),
                _crearBoton(bloc),
              ],
            ),
          ),
          new Text('¿Olvido la contraseña?'),
          //new SizedBox(height: 100.0,)
        ],
      ),
    );
  }

  Widget _crearEmail(LoginBloc bloc) {
    return new StreamBuilder(
        stream: bloc.emailStream,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          return new Container(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: new TextField(
              keyboardType: TextInputType.emailAddress,
              decoration: new InputDecoration(
                  icon: new Icon(
                    Icons.alternate_email,
                    color: Colors.deepPurple,
                  ),
                  hintText: 'ejemplo@correo.com',
                  labelText: 'Correo electronico',
                  counterText: snapshot.data,
                  errorText: snapshot.error
              ),
              //El primer argumento del onChange sera trasladado  a mi primer argumento del changeEmail
              onChanged: bloc.changeEmail,
            ),
          );
        });
  }

  Widget _crearPassword(LoginBloc bloc) {

    return new StreamBuilder(
        stream: bloc.passwordStream ,
        builder: (BuildContext context, AsyncSnapshot snapshot){
          return new Container(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: new TextField(
              obscureText: true,
              keyboardType: TextInputType.emailAddress,
              decoration: new InputDecoration(
                icon: new Icon(
                  Icons.lock_outline,
                  color: Colors.deepPurple,
                ),
                labelText: 'Contraseña',
                counterText: snapshot.data,
                errorText: snapshot.error
              ),
              onChanged: bloc.changePassword,
            ),
          );
        }
    );

  }

  Widget _crearBoton(LoginBloc bloc) {
    return new StreamBuilder(
        stream: bloc.formValidStream,
        builder: (BuildContext context, AsyncSnapshot snapshot){
          return new RaisedButton(
            child: new Container(
              padding: EdgeInsets.symmetric(horizontal: 80.0, vertical: 15.0),
              child: new Text('Ingresar'),
            ),
            shape:
            new RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
            elevation: 0.0,
            color: Colors.deepPurple,
            textColor: Colors.white,
            onPressed: snapshot.hasData? ()=>_login(bloc,context):null
            ,
          );
        }
    );
  }

  _login(LoginBloc bloc, BuildContext context){

    print("=========");
    print('Email: ${bloc.email}');
    print('Password ${bloc.password}');
    print("=========");
    Navigator.pushReplacementNamed(context, HomePage.routeName);

  }
}
