import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mistore/model/app_state_model.dart';
import 'package:mistore/custom_widgets/searchbar.dart';
import 'package:mistore/custom_widgets/product_row_item.dart';
import 'package:mistore/styles.dart';

class SearchTab extends StatefulWidget {
  @override
  _SearchTabState createState() => _SearchTabState();
}

class _SearchTabState extends State<SearchTab> {

  TextEditingController _controller;
  FocusNode _focusNode;
  String _terms = 'none';

  @override
  void initState() {
    // TODO: implement initState
    _controller=TextEditingController()..addListener(onTextChanged);
    super.initState();
  }

  @override
  void dispose() {
    if(_controller.text.isNotEmpty){
      _controller.dispose();
      _focusNode.dispose();
    }

    super.dispose();
  }

  void onTextChanged(){
    setState(() {
      _terms=_controller.text;
    });
  }



  @override
  Widget build(BuildContext context) {

    final model=Provider.of<AppStateModel>(context);
    final results=model.search(_terms);

    return DecoratedBox(
      decoration: BoxDecoration(
        color: Styles.scaffoldBackground
      ),
      child: SafeArea(
          child:Column(
            children: <Widget>[
              buildSearchBox(),
              Expanded(
                  child: ListView.builder(
                      itemBuilder: (context,index)=>ProductRowItem(
                          index: index, lastItem: index==results.length-1, product: results[index]
                      ),
                      itemCount: results.length,
                  )
              )
            ],
          )

      ),
    );

  }

  Widget buildSearchBox(){
    return Padding(
      padding: const EdgeInsets.all(8),
      child: SearchBar(
        textEditingController: _controller,
        focusNode: _focusNode,
      ),
    );
  }
}
