import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mistore/model/product.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:mistore/styles.dart';
import '../model/app_state_model.dart';

const double _dateTimePickerHeight = 220;

class ShoppingCartTab extends StatefulWidget {
  @override
  _ShoppingCartTabState createState() => _ShoppingCartTabState();
}

class _ShoppingCartTabState extends State<ShoppingCartTab> {

  String name;      // ADD FROM HERE
  String email;
  String location;
  String pin;
  DateTime dateTime = DateTime.now();
  final _currencyFormat=NumberFormat.currency(symbol: 'NGN ');



  @override
  Widget build(BuildContext context) {


    return Consumer<AppStateModel>(
        builder: (context,model,child){
          return CustomScrollView(
            slivers: <Widget>[
              CupertinoSliverNavigationBar(
                largeTitle: Text('Your Cart'),
              ),
              SliverSafeArea(
                  top: false,
                  minimum: EdgeInsets.only(top: 4),
                  sliver: SliverList(delegate: _sliverChildBuilderDelegate(model))
              )
            ],
          );
        }
    );
  }

  Widget nameField(){
    return CupertinoTextField(
      prefix: Icon(CupertinoIcons.person_solid,size: 28,color: CupertinoColors.lightBackgroundGray,),
      padding: EdgeInsets.symmetric(horizontal: 6,vertical: 12),
      clearButtonMode: OverlayVisibilityMode.editing,
      textCapitalization: TextCapitalization.words,
      autocorrect: false,
      placeholder: 'Name',
      onChanged: (newName){
        setState(() {
          name=newName;
        });
      },
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: CupertinoColors.inactiveGray,
            width: 0
          )
        )
      ),
    );
  }

  Widget emailField(){
    return CupertinoTextField(
      prefix: Icon(CupertinoIcons.mail_solid,size: 28,color: CupertinoColors.lightBackgroundGray,),
      padding: EdgeInsets.symmetric(horizontal: 6,vertical: 12),
      keyboardType: TextInputType.emailAddress,
      clearButtonMode: OverlayVisibilityMode.editing,
      textCapitalization: TextCapitalization.words,
      autocorrect: false,
      placeholder: 'E-mail address',
      onChanged: (newEmail){
        setState(() {
          email=newEmail;
        });
      },
      decoration: BoxDecoration(
          border: Border(
              bottom: BorderSide(
                  color: CupertinoColors.inactiveGray,
                  width: 0
              )
          )
      ),
    );
  }

  Widget locationField(){
    return CupertinoTextField(
      prefix: Icon(CupertinoIcons.location_solid,size: 28,color: CupertinoColors.lightBackgroundGray,),
      padding: EdgeInsets.symmetric(horizontal: 6,vertical: 12),
      clearButtonMode: OverlayVisibilityMode.editing,
      textCapitalization: TextCapitalization.words,
      autocorrect: false,
      placeholder: 'Location',
      onChanged: (userLocation){
        setState(() {
          location=userLocation;
        });
      },
      decoration: BoxDecoration(
          border: Border(
              bottom: BorderSide(
                  color: CupertinoColors.inactiveGray,
                  width: 0
              )
          )
      ),
    );
  }

  SliverChildBuilderDelegate _sliverChildBuilderDelegate(AppStateModel model){
    return SliverChildBuilderDelegate(
        (context,index){
          final productIndex=index-4;
          switch(index){
            case 0:
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: nameField(),
              );
            case 1:
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: emailField(),
              );
            case 2:
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: locationField(),
              );
            case 3:                // ADD FROM HERE
              return Padding(
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
                child: buildDateAndTimePicker(context),
              );
            default:
              if(model.productsInCart.length>productIndex){
                return ShoppingCartItem(
                    index: index,
                  lastItem: productIndex==model.productsInCart.length-1,
                  product: model.getProductByID(model.productsInCart.keys.toList()[productIndex]),
                  formatter: _currencyFormat,quantity: model.productsInCart.values.toList()[productIndex],
                );
              }else if(model.productsInCart.keys.length==productIndex && model.productsInCart.isNotEmpty){
                return Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              Text('Shipping ${_currencyFormat.format(model.shippingCost)}',
                                style: Styles.productRowItemPrice,textAlign: TextAlign.right,
                              ),
                              SizedBox(height: 6,),
                              Text('Tax ${_currencyFormat.format(model.tax)}',
                                style: Styles.productRowItemPrice,textAlign: TextAlign.right,
                              ),
                              SizedBox(height: 6,),
                              Text('Total ${_currencyFormat.format(model.totalCost)}',
                                style: Styles.productRowTotal,textAlign: TextAlign.right,
                                //
                                //
                              ),


                            ],
                          )
                        ],
                      ),
                    ),

                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                      padding: EdgeInsets.symmetric(vertical: 16),
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.circular(6),
                        color: Colors.deepPurple
                      ),
                      child: Center(
                        child: Text("ORDER NOW >>>",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w500
                          ),
                        ),
                      ),
                    )
                  ],
                );
              }
          }
          return null;
        }
    );
  }

  Widget buildDateAndTimePicker(BuildContext context){
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Icon(
                  CupertinoIcons.clock,
                  color: CupertinoColors.lightBackgroundGray,
                  size: 28,
                ),
                SizedBox(width: 6),
                Text(
                  'Delivery time',
                  style: Styles.deliveryTimeLabel,
                ),
              ],
            ),
            Text(
              DateFormat.yMMMd().add_jm().format(dateTime),
              style: Styles.deliveryTime,
            )
          ],

        ),
        SizedBox(height: 5,),
        Container(
          height: _dateTimePickerHeight,
          child: CupertinoDatePicker(
              mode: CupertinoDatePickerMode.dateAndTime,
              initialDateTime: dateTime,
              onDateTimeChanged: (newDate){
                setState(() {
                  dateTime=newDate;
                });

              }
          ),
        )
      ],
    );
  }

}

class ShoppingCartItem extends StatelessWidget {

  final Product product;
  final int index;
  final NumberFormat formatter;
  final int quantity;
  final bool lastItem;

  ShoppingCartItem({
    @required this.product,
    @required this.index,
    @required this.formatter,
    @required this.quantity,
    @required this.lastItem,

  });


  @override
  Widget build(BuildContext context) {

    return SafeArea(
        top: false,
        bottom: false,
        child: Padding(
          padding: EdgeInsets.only(left: 16,top: 8,right: 8,bottom: 8),
          child: Row(
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: Image.asset(
                  product.assetName,
                  package: product.assetPackage,
                  fit: BoxFit.cover,
                  width: 40,
                  height: 40,
                ),
              ),

              Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              product.productName,
                              style: Styles.productRowItemName,
                            ),
                            Text(
                              '${formatter.format(quantity * product.price)}',
                              style: Styles.productRowItemName,
                            ),
                          ],
                        ),

                        const SizedBox(
                          height: 4,
                        ),
                        Text(
                          '${quantity > 1 ? '$quantity x ' : ''}'
                              '${formatter.format(product.price)}',
                          style: Styles.productRowItemPrice,
                        )
                      ],
                    ),
                  )
              )
            ],
          ),
        )
    );
  }
}

