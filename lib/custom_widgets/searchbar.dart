import 'package:flutter/material.dart';
import 'package:mistore/styles.dart';
import 'package:flutter/cupertino.dart';

class SearchBar extends StatelessWidget {

  final TextEditingController textEditingController;
  final FocusNode focusNode;

  SearchBar({@required this.textEditingController,@required this.focusNode});

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: Styles.searchBackground,
        borderRadius: BorderRadius.circular(10)
      ),
      child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 8,vertical: 8),
          child: Row(
            children: <Widget>[
              Icon(CupertinoIcons.search,color: Styles.searchIconColor,),
              Expanded(
                  child: CupertinoTextField(
                    controller: textEditingController,focusNode: focusNode,
                    style: Styles.searchText,cursorColor: Styles.searchCursorColor,
                  )
              ),
              GestureDetector(
                onTap: ()=>textEditingController.clear(),
                child: Icon(CupertinoIcons.clear_thick_circled,color: Styles.searchIconColor,),
              )
            ],
          ),
      ),
    );
  }
}
