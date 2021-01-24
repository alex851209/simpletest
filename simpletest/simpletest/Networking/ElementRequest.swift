//
//  ElementRequest.swift
//  simpletest
//
//  Created by shuo on 2021/1/24.
//

import Foundation

enum ElementRequest {
    
    case id
    case info(id: Int)
    case status(id: Int)
    
    var baseURL: String { return "https://blooming-oasis-01056.herokuapp.com" }
    
    var path: String {
        switch self {
        case .id: return "\(baseURL)/category"
        case .info(id: let id): return "\(baseURL)/product?id=\(id)"
        case .status(id: let id): return "\(baseURL)/sale?id=\(id)"
        }
    }
}
