// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/product.dart';
import '../models/product_list.dart';

class ProductFormPage extends StatefulWidget {
  const ProductFormPage({super.key});

  @override
  State<ProductFormPage> createState() => _ProductFormPageState();
}

class _ProductFormPageState extends State<ProductFormPage> {
  final _priceFocus = FocusNode();
  final _descriptionFocus = FocusNode();
  final _imageUrlFocus = FocusNode();

  final _imageUrlController = TextEditingController();
  final _globalKey = GlobalKey<FormState>();
  final _formData = <String, Object>{};

  var _isLoading = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_formData.isEmpty) {
      final arg = ModalRoute.of(context)?.settings.arguments;

      if (arg != null) {
        final product = arg as Product;
        _formData['id'] = product.id;
        _formData['name'] = product.name;
        _formData['price'] = product.price;
        _formData['description'] = product.description;
        _formData['imageUrl'] = product.imageUrl;
        _imageUrlController.text = product.imageUrl;
      }
    }
  }

  @override
  void dispose() {
    super.dispose();
    _priceFocus.dispose();
    _descriptionFocus.dispose();
    _imageUrlFocus.dispose();
    _imageUrlFocus.removeListener(updateImage);
  }

  @override
  void initState() {
    super.initState();
    _imageUrlFocus.addListener(updateImage);
  }

  void updateImage() {
    setState(() {});
  }

  bool isValidImageUrl(String url) {
    bool isValidUrl = Uri.tryParse(url)?.hasAbsolutePath ?? false;
    final lowerCaseUrl = url.toLowerCase();
    bool endsWithFile = lowerCaseUrl.endsWith('.png') ||
        lowerCaseUrl.endsWith('.jpg') ||
        lowerCaseUrl.endsWith('.jpeg');
    return isValidUrl && endsWithFile;
  }

  void _submitForm() {
    final isValid = _globalKey.currentState?.validate() ?? false;

    if (!isValid) {
      return;
    }

    setState(() {
      _isLoading = true;
    });

    _globalKey.currentState?.save();
    // print(_formData.values);
    Provider.of<ProductList>(context, listen: false)
        .saveProduct(_formData)
        .catchError((error){
          return showDialog<void>(context: context, builder: (context) {
            return AlertDialog(
              title: Text('Ocorreu um erro!'),
              content: Text(error.toString()),
              actions: [
                TextButton(onPressed: () => Navigator.of(context).pop(), child: Text('Ok!')),
              ],
            );
          },);

         })
        .then((value) {
      setState(() => _isLoading = false);
      Navigator.of(context).pop();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Formulário de Produto'),
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            onPressed: _submitForm,
            icon: Icon(Icons.save),
          )
        ],
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : Form(
              key: _globalKey,
              child: ListView(
                children: [
                  TextFormField(
                    initialValue: _formData['name']?.toString(),
                    decoration: InputDecoration(labelText: 'Nome'),
                    // textInputAction: TextInputAction.next,
                    onFieldSubmitted: (value) =>
                        FocusScope.of(context).requestFocus(_priceFocus),
                    onSaved: (name) => _formData['name'] = name ?? '',
                    validator: (name) {
                      if (name == null) {
                        return 'Nao pode ser vazio';
                      }
                      if (name.trim().isEmpty) {
                        return 'Nome é obrigatório!';
                      }
                      if (name.trim().length < 3) {
                        return 'Nome Precisa de no mínimo 3 letras!';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                      initialValue: _formData['price']?.toString(),
                      focusNode: _priceFocus,
                      keyboardType:
                          TextInputType.numberWithOptions(decimal: true),
                      //initialValue: '0',
                      decoration: InputDecoration(
                        labelText: 'Preço',
                      ),
                      onFieldSubmitted: (value) => FocusScope.of(context)
                          .requestFocus(_descriptionFocus),
                      onSaved: (price) {
                        if (price!.isEmpty) {
                          price = '0';
                        }
                        _formData['price'] = double.parse(price);
                      }),
                  TextFormField(
                    initialValue: _formData['description']?.toString(),
                    focusNode: _descriptionFocus,
                    decoration: InputDecoration(labelText: 'Descrição'),
                    keyboardType: TextInputType.multiline,
                    maxLines: 3,
                    onSaved: (description) =>
                        _formData['description'] = description ?? '',
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Expanded(
                        child: TextFormField(
                          decoration:
                              InputDecoration(labelText: 'Url da Imagem'),
                          keyboardType: TextInputType.url,
                          focusNode: _imageUrlFocus,
                          textInputAction: TextInputAction.done,
                          controller: _imageUrlController,
                          onFieldSubmitted: (_) => _submitForm(),
                          onSaved: (imageUrl) =>
                              _formData['imageUrl'] = imageUrl ?? '',
                          validator: (value) {
                            final imageUrl = value ?? '';
                            if (!isValidImageUrl(imageUrl)) {
                              return 'Informe uma Url Válida';
                            }
                            return null;
                          },
                        ),
                      ),
                      Container(
                        height: 100,
                        width: 100,
                        margin: EdgeInsets.only(top: 10, left: 10),
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey, width: 1)),
                        alignment: Alignment.center,
                        child: _imageUrlController.text.isEmpty
                            ? Text('Informe a URL a ser designada')
                            : Image.network(_imageUrlController.text),
                      )
                    ],
                  ),
                ],
              ),
            ),
    );
  }
}
