//
//  ProductProvider.swift
//  simpletest
//
//  Created by shuo on 2021/1/23.
//

import Foundation

class ProductProvider {
    
    let group = DispatchGroup()
    var ids = [Int]()
    var elements = [SalePageListElement]()
    
    func fetchElements(completion: @escaping (([SalePageListElement]) -> Void)) {
        
        fetchID()
        group.wait()
        fetchInfo()
        group.wait()
        fetchStatus()
        group.notify(queue: .main) { completion(self.elements) }
    }
    
    private func fetchID() {
     
        guard let url = URL(string: ElementRequest.id.path) else {
            print(ErrorMessage.invalidURL.rawValue)
            return
        }
        
        group.enter()
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error { print(error.localizedDescription) }
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                print(ErrorMessage.invalidHTTP.rawValue)
                return
            }
            guard let data = data else {
                print(ErrorMessage.invalidData.rawValue)
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let listData = try decoder.decode(CategoryListData.self, from: data)
                
                for list in listData.data.shopCategoryList.categoryList {
                    self.ids.append(list.id)
                }
                self.group.leave()
            } catch {
                print(error.localizedDescription)
            }
        }
        task.resume()
    }
    
    private func fetchInfo() {
        
        for id in ids {
            guard let url = URL(string: ElementRequest.info(id: id).path) else {
                print(ErrorMessage.invalidURL.rawValue)
                return
            }
            
            group.enter()
            
            let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
                if let error = error { print(error.localizedDescription) }
                guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                    print(ErrorMessage.invalidHTTP.rawValue)
                    return
                }
                guard let data = data else {
                    print(ErrorMessage.invalidData.rawValue)
                    return
                }
                
                do {
                    let decoder = JSONDecoder()
                    let pageListData = try decoder.decode(SalePageListData.self, from: data)
                    
                    for element in pageListData.data.shopCategory.salePageList.salePageList {
                        self.elements.append(element)
                    }
                    self.group.leave()
                } catch {
                    print(error.localizedDescription)
                }
            }
            task.resume()
        }
    }
    
    private func fetchStatus() {
        
        for id in ids {
            guard let url = URL(string: ElementRequest.status(id: id).path) else {
                print(ErrorMessage.invalidURL.rawValue)
                return
            }
            
            group.enter()
            
            let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
                if let error = error { print(error.localizedDescription) }
                guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                    print(ErrorMessage.invalidHTTP.rawValue)
                    return
                }
                guard let data = data else {
                    print(ErrorMessage.invalidData.rawValue)
                    return
                }
                
                do {
                    let decoder = JSONDecoder()
                    let pageListData = try decoder.decode(SalePageListData.self, from: data)
                    
                    for element in pageListData.data.shopCategory.salePageList.salePageList {
                        if let index = self.elements.firstIndex(where: { $0.salePageID == element.salePageID }) {
                            self.elements[index].sellingQty = element.sellingQty
                            self.elements[index].isSoldOut = element.isSoldOut
                            self.elements[index].isComingSoon = element.isComingSoon
                            self.elements[index].sellingStartDateTime = element.sellingStartDateTime
                        }
                    }
                    self.group.leave()
                } catch {
                    print(error.localizedDescription)
                }
            }
            task.resume()
        }
    }
}
