import 'package:flutter/material.dart';
import 'package:flutter_form_validation_app/src/blocs/provider.dart';
import 'package:flutter_form_validation_app/src/models/producto_model.dart';
import 'package:flutter_form_validation_app/src/pages/product_page.dart';
import 'package:flutter_form_validation_app/src/providers/productos_provider.dart';

class HomePage extends StatelessWidget {
  static final String routeName = 'home';
  final productosProvider = new ProductoProvider();

  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of(context);
    return Scaffold(
      appBar: new AppBar(
       title: new Text('Home')
      ),
      body: _crearListado(),
      floatingActionButton: _crearBoton(context),
    );
  }

  Widget _crearBoton(BuildContext context) {
    return new FloatingActionButton(
        child: new Icon(Icons.add),
        backgroundColor: Theme.of(context).primaryColor,
        onPressed: ()=> Navigator.pushNamed(context, ProductoPage.routeName)
    );

  }

  Widget _crearListado() {
    return new FutureBuilder(
        future: productosProvider.cargaProductos(),
        builder: (BuildContext context, AsyncSnapshot<List<ProductModel>> snapshot) {
              if(snapshot.hasData){
                  final productos = snapshot.data;
                  return new ListView.builder(
                    itemCount: productos.length,
                    itemBuilder: (BuildContext context, i)=>_crearItem(context,productos[i]),
                    
                  );
              }else{
                return new Center(
                  child: new CircularProgressIndicator(),
                );
              }
        }
    );
  }

  Widget _crearItem(BuildContext context, ProductModel producto) {
    return new Dismissible(
      key: UniqueKey(),
      background: new Container(
        color: Colors.red,
        child: new Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            new Icon(Icons.delete, color: Colors.white,),
            new SizedBox(width: 25.0,)
          ],
        ),
      ),
      onDismissed: (direccion){
        //TODO: Borrar producto
        productosProvider.borrarProducto(producto.id);
      },
      child: new ListTile(
        title: new Text('${producto.titulo} - ${producto.valor}'),
        subtitle: new Text(producto.id),
        onTap: ()=>Navigator.pushNamed(context, ProductoPage.routeName, arguments: producto),
      ),
    );
  }
}
