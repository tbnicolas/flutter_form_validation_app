import 'package:flutter/material.dart';
import 'package:flutter_form_validation_app/src/models/producto_model.dart';
import 'package:flutter_form_validation_app/src/providers/productos_provider.dart';
import 'package:flutter_form_validation_app/src/utils/utils.dart' as utils;

class ProductoPage extends StatefulWidget {
  static final routeName = 'producto';

  @override
  _ProductoPageState createState() => _ProductoPageState();
}

class _ProductoPageState extends State<ProductoPage> {
  final formKey = new GlobalKey<FormState>();
  final scaffoldKey = new GlobalKey<ScaffoldState>();
  ProductModel producto = new ProductModel();
  final productoProvider = new ProductoProvider();
  bool _guardando = false;
  @override
  Widget build(BuildContext context) {
    final ProductModel proArgument = ModalRoute.of(context).settings.arguments;

    if(proArgument != null){
       producto = proArgument;
    }

    return new Scaffold(
      key: scaffoldKey,
      appBar: new AppBar(
        title: new Text('Producto'),
        actions: <Widget>[
            new IconButton(
              icon: new Icon(Icons.photo_size_select_actual),
              onPressed: (){},
            ),
          new IconButton(
              icon: new Icon(Icons.camera_alt),
              onPressed: (){},
            )
        ],
      ),
      body: new SingleChildScrollView(
        child: new Container(
          padding: EdgeInsets.all(15.0),
          child: new Form(
              key: formKey,
              child: new Column(
                children: <Widget>[
                  _crearNombre(),
                  _crearPrecio(),
                  _crearDisponible(),
                  _crearBoton(context),
                ],
              )
          ),
        ),
      ) ,
    );
  }

  Widget _crearNombre() {
    return new TextFormField(
      initialValue: producto.titulo,
      textCapitalization: TextCapitalization.sentences,
      decoration: new InputDecoration(
        labelText: 'Producto'
      ),
      onSaved: (value)=>producto.titulo = value,
      validator: (value){
        if(value.length < 3){
          return 'Ingrese el nombre del producto';
        }else{
          return null;
        }
      },
    );
  }

  Widget _crearPrecio() {
    return new TextFormField(
      initialValue: producto.valor.toString(),
      keyboardType: TextInputType.numberWithOptions(decimal: true),
      textCapitalization: TextCapitalization.sentences,
      decoration: new InputDecoration(
          labelText: 'Precio'
      ),
      onSaved: (value)=>producto.valor = double.parse(value),
      validator: (value){
          if(utils.isNumeric(value)){
            return null;
          }else{
            return 'Soló números';
          }
      },
    );
  }

  Widget _crearBoton(BuildContext context) {
    return new RaisedButton.icon(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
        color: Theme.of(context).primaryColor,
        textColor: Colors.white,
        onPressed: (_guardando)? null :_submit,
        icon: new Icon(Icons.save),
        label: new Text('Guardar')
    );
  }

  void _submit(){
    if(!formKey.currentState.validate()) return;
    formKey.currentState.save();
   // print('Todo Ok!');
   // print(producto.titulo);
    //print(producto.valor);
   // print(producto.disponible);

    setState(() {
      _guardando = true;
    });

    if(producto.id == null){
      productoProvider.crearProducto(producto);
    }else{
      productoProvider.editarProducto(producto);
    }


    mostrarSnackbar('Registro guardado');
    Navigator.pop(context);

  }

  Widget _crearDisponible() {
    return new SwitchListTile(
      value: producto.disponible,
      title: new Text('Disponible'),
      activeColor: Colors.deepPurple,
      onChanged: (value) => setState((){
        producto.disponible = value;
      })
    );
  }
  void mostrarSnackbar(String mensaje){
    final snackbar = new SnackBar(
      content: new Text(mensaje),
      duration: new Duration(seconds: 2),
    );
    scaffoldKey.currentState.showSnackBar(snackbar);
  }
}
