import 'package:flutter/foundation.dart' as foundation;
import 'product.dart';
import 'products_repository.dart';

double _salesTaxRate = 0.05;
double _shippingCostPerItem = 500;

class AppStateModel extends foundation.ChangeNotifier{
  List<Product> availableProducts;
  Category _selectedCategory=Category.all;
  final _productsInCart=<int,int>{};

  Map<int,int> get productsInCart{
    return Map.from(_productsInCart);
  }

  Category get selectedCategory=>_selectedCategory;

  int get totalCartQuantity{
    return _productsInCart.values.fold(0, (accumulator,value){
      return accumulator+value;
    });
  }

  double get subTotalCost{
    double totalValue=0;

    _productsInCart.keys.map((id){
      return availableProducts[id].price * _productsInCart[id];
    }).fold(0, (accumulator, extendedPrice){
      totalValue+=extendedPrice;
    });

    return totalValue;

  }

  double get shippingCost{
    return _shippingCostPerItem*totalCartQuantity;
  }

  double get tax{
    return _salesTaxRate*subTotalCost;
  }

  double get totalCost{
    return subTotalCost+shippingCost+tax;
  }

  List<Product> getProducts(){
    if(availableProducts==null){
      return [];
    }

    if(_selectedCategory==Category.all){
      return List.from(availableProducts);
    }else{
      return availableProducts.where((p){
        return p.category==_selectedCategory;
      }).toList();
    }
  }

  List<Product> search(String searchTerms){
    return getProducts().where((p){
      return p.productName.toLowerCase().contains(searchTerms.toLowerCase());
    }).toList();
  }

  void addProductToCart(int productID){
    if(_productsInCart.containsKey(productID)){
      _productsInCart[productID]++;
    }else{
      _productsInCart[productID]=1;
    }

    notifyListeners();
  }

  void removeProductFromCart(int productID){
    if(_productsInCart.containsKey(productID)){
      if(_productsInCart[productID]==1){
        _productsInCart.remove(productID);
      }else{
        _productsInCart[productID]--;
      }
    }

    notifyListeners();
  }

  Product getProductByID(int id){
    return availableProducts.firstWhere((p)=>p.id==id);
  }

  void clearCart(){
    _productsInCart.clear();
    notifyListeners();
  }

  void loadProducts() {
    availableProducts = ProductsRepository.loadProducts(Category.all);
    notifyListeners();
  }

  void setCategory(Category newCategory) {
    _selectedCategory = newCategory;
    notifyListeners();
  }
}