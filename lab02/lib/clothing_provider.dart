import 'package:flutter/material.dart';
import 'clothing_item.dart';

class ClothingProvider extends ChangeNotifier{
  List<ClothingItem> clothingItems = [];

  List<ClothingItem> getClothingItems(){
    return clothingItems;
  }

  void addClothingItem(ClothingItem item){
    clothingItems.add(item);
    notifyListeners();
  }

  void editClothingItem(int index, ClothingItem item){
    clothingItems[index] = item;
    notifyListeners();
  }

  void removeClothingItem(int index){
    clothingItems.removeAt(index);
    notifyListeners();
  }
}