//
//  Product.swift
//  simpletest
//
//  Created by shuo on 2021/1/23.
//

import Foundation

struct CategoryListData: Codable {
    
    let data: ListData
}

struct ListData: Codable {
    
    let shopCategoryList: ShopCategoryList
}

struct ShopCategoryList: Codable {
    
    let count: Int
    let categoryList: [CategoryList]
}

struct CategoryList: Codable {
    
    let id: Int
    let name: String
}
