import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mistore/model/app_state_model.dart';
import 'package:mistore/model/product.dart';
import 'package:mistore/styles.dart';

class ProductRowItem extends StatelessWidget {

  final Product product;
  final int index;
  final bool lastItem;

  ProductRowItem({@required this.index,@required this.lastItem,@required this.product});

  @override
  Widget build(BuildContext context) {

    if(lastItem)
      return productItem(context);


    return Column(
      children: <Widget>[
        productItem(context),
        Padding(
          padding: const EdgeInsets.only(
            left: 100,
            right: 16,
          ),
          child: Container(
            height: 1,
            color: Styles.productRowDivider,
          ),
        ),
      ],
    );
  }

  Widget productItem(BuildContext context){
    return SafeArea(
        top: false,
        bottom: false,
        minimum: EdgeInsets.only(left: 16,top: 8,right: 8,bottom: 8),
        child: Row(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: Image.asset(
                product.assetName,
                package: product.assetPackage,
                fit: BoxFit.cover,
                width: 76,
                height: 76,
              ),
            ),

            Expanded(
                child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          product.productName,
                          style: Styles.productRowItemName,
                        ),
                        const Padding(padding: EdgeInsets.only(top: 8)),
                        Text(
                          'NGN ${product.price}',
                          style: Styles.productRowItemPrice,
                        )
                      ],
                    ),
                )
            ),
            
            CupertinoButton(
                padding: EdgeInsets.zero,
                child: Icon(CupertinoIcons.plus_circled,semanticLabel: 'Add',color: Colors.deepPurple,),
                onPressed: (){
                  final model=Provider.of<AppStateModel>(context);
                  model.addProductToCart(product.id);
                }
            )
          ],
        ),
    );
  }
}


