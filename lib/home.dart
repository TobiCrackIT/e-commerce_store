import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mistore/tabs/product_list_tab.dart';
import 'package:mistore/tabs/search_tab.dart';
import 'package:mistore/tabs/shopping_cart_tab.dart';


class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin{


  int currentIndex=0;
  TabController tabController;
  List<Widget> tabs=[
    ProductListTab(),
    SearchTab(),
    ShoppingCartTab()
  ];

  void incrementTab(int index){
    setState(() {
      currentIndex=index;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tabController=TabController(length: 3, vsync: this);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: tabs[currentIndex],
      ),


      bottomNavigationBar: BottomNavigationBar(
          onTap: incrementTab,
          currentIndex: currentIndex,
          type: BottomNavigationBarType.shifting,
          items: [
            BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.home,color: Colors.deepPurple,),
                title: Padding(
                  padding: const EdgeInsets.only(top:8.0,bottom: 2),
                  child: Text('Products',style: TextStyle(color: Colors.deepPurple,fontSize: 10,fontWeight: FontWeight.w700),),
                )
            ),
            BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.search,color: Colors.deepPurple,),
                title: Padding(
                  padding: const EdgeInsets.only(top:8.0,bottom: 2),
                  child: Text('Search',style: TextStyle(color: Colors.deepPurple,fontSize: 10,fontWeight: FontWeight.w700),),
                )
            ),
            BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.shopping_cart,color: Colors.deepPurple,),
                title: Padding(
                  padding: const EdgeInsets.only(top:8.0,bottom: 2),
                  child: Text('Cart',style: TextStyle(color: Colors.deepPurple,fontSize: 10,fontWeight: FontWeight.w700),),
                )
            ),

          ]
      ),
    );
  }
}
