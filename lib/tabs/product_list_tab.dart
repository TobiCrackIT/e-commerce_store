import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mistore/custom_widgets/product_row_item.dart';
import '../model/app_state_model.dart';

class ProductListTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<AppStateModel>(
        builder: (context,model,child){
          final products=model.getProducts();
          return CustomScrollView(
            semanticChildCount: products.length,
            slivers: <Widget>[
              CupertinoSliverNavigationBar(
                largeTitle: Text('Products'),
              ),
              SliverSafeArea(
                  top: false,
                  minimum: EdgeInsets.only(top: 8),
                  sliver: SliverList(
                      delegate: SliverChildBuilderDelegate(
                          (context,index){
                            if(index<products.length){
                              return ProductRowItem(
                                  index: index,
                                  lastItem: index==products.length-1,
                                  product: products[index]
                              );
                            }
                            return null;
                          }
                      )
                  )
              )
            ],
          );
        }
    );
  }
}
