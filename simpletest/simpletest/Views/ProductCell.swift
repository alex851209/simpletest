//
//  ProductCell.swift
//  simpletest
//
//  Created by shuo on 2021/1/23.
//

import UIKit

class ProductCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var suggestedPriceLabel: UILabel!
    @IBOutlet weak var qtyLabel: UILabel!
    @IBOutlet weak var startDateTimeLabel: UILabel!
    
    func layoutCell(with element: SalePageListElement) {
        
        guard let title = element.title,
              let price = element.price,
              let suggestPrice = element.suggestPrice,
              let qty = element.sellingQty,
              let startDateTime = element.sellingStartDateTime
        else { return }
        
        let convertDate = Date().convertDate(dateValue: startDateTime)
        
        titleLabel.text = "名稱：\(title)"
        priceLabel.text = "售價：\(price)"
        suggestedPriceLabel.text = "建議售價：\(suggestPrice)"
        qtyLabel.text = "可售數：\(qty)"
        startDateTimeLabel.text = "銷售時間：\(convertDate)"
    }
}
