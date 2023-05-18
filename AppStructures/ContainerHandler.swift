//
//  ContainerHandler.swift
//  chefflyApp
//
//  Created by Lil Uzi on 5/13/23.
//

import Foundation

class Item {
    private var _item_name: String
    private var _product_brand: String
    private var _bought_date: Date
    private var _expiration_time: Int
    private var _quantity: Int
    private var _image: String
    private var _description: String
    
    init(item_name: String, product_brand: String, bought_date: Date, expiration_time: Int, quantity: Int, image: String, description: String) {
        self._item_name = item_name
        self._product_brand = product_brand
        self._bought_date = bought_date
        self._expiration_time = expiration_time
        self._quantity = quantity
        self._image = image
        self._description = description
    }
    
    var item_name: String {
        get { return _item_name }
        set { _item_name = newValue }
    }
    
    var product_brand: String {
        get { return _product_brand }
        set { _product_brand = newValue }
    }
    
    var bought_date: Date {
        get { return _bought_date }
        set { _bought_date = newValue }
    }
    
    var expiration_time: Int {
        get { return _expiration_time }
        set { _expiration_time = newValue }
    }
    
    var quantity: Int {
        get { return _quantity }
        set { _quantity = newValue }
    }
    
    var image: String {
        get { return _image }
        set { _image = newValue }
    }
    
    var description: String {
        get { return _description }
        set { _description = newValue }
    }
    
    
}

struct Container{
    var containerName: String
    var containerLogo: String
    var contents: [Item]
}

class handleContainer{
    var _containerArr: [Container]
    var _containerArrSize: Int
    
    init(){
        self._containerArrSize = 3
        self._containerArr = [Container]()
        self._containerArr.append(Container(containerName: "Refrigerator", containerLogo: "containerLogo", contents: []))
        self._containerArr.append(Container(containerName: "Aromatics", containerLogo: "containerLogo", contents: []))
        self._containerArr.append(Container(containerName: "Cupboard", containerLogo: "containerLogo", contents: []))
    }
    
    func append_item_to(desiredContainer: String, what_to_add: Item){
        _containerArr[find_container_index(desiredContainer: desiredContainer)].contents.append(what_to_add)
    }
    
    func remove_item_from(desiredContainer: String, what_to_rem: Item){
        _containerArr[find_container_index(desiredContainer: desiredContainer)].contents.remove(at: find_item_index(desiredItem: what_to_rem, passContainer: desiredContainer))
    }
    
    func compare(item1: Item, item2: Item) -> Bool{
        if item1.item_name == item2.item_name && item1.bought_date == item2.bought_date{
            return true
        }else{
            return false
        }
    }
    
    func find_container_index(desiredContainer: String) -> Int{
        var index = 0
        
        while _containerArr[index].containerName != desiredContainer{
            if index > _containerArrSize{
                print("Error inside class handleContainer - inFunction find_container_index  - inFile ContainerHandler.swift\nArray Index over flow, returning 0\n")
                return 0
            }
            index += 1
        }
        return index
    }
    
    func find_item_index(desiredItem: Item, passContainer: String) -> Int{
        var index = 0
        
        let containerIndex = find_container_index(desiredContainer: passContainer) //FP
        
        while compare(item1: desiredItem, item2: _containerArr[containerIndex].contents[index]) != true{
            if index > _containerArr[find_container_index(desiredContainer: passContainer)].contents.count{
                print("Error inside class handleContainer - inFunction find_item_index  - inFile ContainerHandler.swift\nArray Index over flow, returning 0\n")
                return 0
            }
            index += 1
        }
        
        return index
    }
}
