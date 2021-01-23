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
    @IBOutlet weak var stockLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    func layoutCell() {
        
        titleLabel.text = "名稱："
        priceLabel.text = "售價："
        suggestedPriceLabel.text = "建議售價："
        stockLabel.text = "可售數："
        timeLabel.text = "銷售時間："
    }
}
