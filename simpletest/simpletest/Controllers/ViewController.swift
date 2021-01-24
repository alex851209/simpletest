//
//  ViewController.swift
//  simpletest
//
//  Created by Michael Chang on 2021/1/15.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    @IBAction func orderSegmentedDidChoose(_ sender: UISegmentedControl) { configureOrder(sender) }
    
    let provider = ProductProvider()
    var elements = [SalePageListElement]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureTableView()
        fetchProducts()
    }

    private func configureTableView() {
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func fetchProducts() {
        
        provider.fetchElements { elements in
            self.elements = elements
            self.tableView.reloadData()
        }
    }
    
    private func configureOrder(_ sender: UISegmentedControl) {
        
        elements = elements.sorted {
            var isSorted = false
            
            guard let firstPrice = $0.price,
                  let secondPrice = $1.price,
                  let firstSellingDate = $0.sellingStartDateTime,
                  let secondSellingDate = $1.sellingStartDateTime
            else { return isSorted }
            
            switch sender.selectedSegmentIndex {
            case 0: isSorted = firstPrice > secondPrice
            case 1: isSorted = firstPrice < secondPrice
            case 2: isSorted = firstSellingDate > secondSellingDate
            case 3: isSorted = firstSellingDate < secondSellingDate
            default: break
            }
            return isSorted
        }
        tableView.reloadData()
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { return elements.count }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat { return 150 }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell()
        let reuseID = String(describing: ProductCell.self)
        
        if let productCell = tableView.dequeueReusableCell(withIdentifier: reuseID, for: indexPath) as? ProductCell {
            productCell.layoutCell(with: elements[indexPath.row])
            return productCell
        }
        return cell
    }
}

