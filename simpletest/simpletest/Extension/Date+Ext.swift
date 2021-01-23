//
//  Date+Ext.swift
//  simpletest
//
//  Created by shuo on 2021/1/23.
//

import Foundation

extension Date {
    
    func convertDate(dateValue: Int) -> String {
        
        let truncatedTime = Int(dateValue / 1000)
        let date = Date(timeIntervalSince1970: TimeInterval(truncatedTime))
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone(abbreviation: "Asia/Taipei")
        formatter.dateFormat = "YYYY年 M月 d日"
        return formatter.string(from: date)
    }
}
