//
//  SalePageList.swift
//  simpletest
//
//  Created by shuo on 2021/1/23.
//

import Foundation

struct SalePageListData: Codable {
    
    let data: SalePageList
}

struct SalePageList: Codable {
    
    let shopCategory: ShopCategory
}

struct ShopCategory: Codable {
    
    let salePageList: ShopCategorySalePageList
}

struct ShopCategorySalePageList: Codable {
    
    let salePageList: [SalePageListElement]
}

struct SalePageListElement: Codable {
    
    var salePageID: Int?
    var title: String?
    var price, suggestPrice: Int?
    var sellingQty: Int?
    var isSoldOut, isComingSoon: Bool?
    var sellingStartDateTime: Int?

    enum CodingKeys: String, CodingKey {
        case salePageID = "salePageId"
        case title, price, suggestPrice, sellingQty, isSoldOut, isComingSoon, sellingStartDateTime
    }
}
