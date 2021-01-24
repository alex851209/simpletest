//
//  ViewController.swift
//  simpletest
//
//  Created by Michael Chang on 2021/1/15.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    @IBAction func sortSegmentedDidChoose(_ sender: UISegmentedControl) { toggleElementsSort(sender) }
    @IBAction func soldOutSwitchDidTap(_ sender: UISwitch) {
        
        isSoldOut = sender.isOn
        toggleElementsFilter()
    }
    @IBAction func comingSoonSwitchDidTap(_ sender: UISwitch) {
        
        isComingSoon = sender.isOn
        toggleElementsFilter()
    }
    
    let provider = ProductProvider()
    var elements = [SalePageListElement]()
    var filteredElements = [SalePageListElement]()
    var isSoldOut = false
    var isComingSoon = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureTableView()
        fetchElements()
    }

    private func configureTableView() {
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func fetchElements() {
        
        activityIndicator.startAnimating()
        provider.fetchElements { elements in
            self.elements = elements
            self.tableView.reloadData()
            self.activityIndicator.stopAnimating()
        }
    }
    
    private func toggleElementsSort(_ sender: UISegmentedControl) {
        
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
    
    private func toggleElementsFilter() {
        
        filteredElements = elements.filter {
            $0.isSoldOut == isSoldOut && $0.isComingSoon == isComingSoon
        }
        tableView.reloadData()
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        let isFiltered = isSoldOut == true || isComingSoon == true
        return isFiltered ? filteredElements.count : elements.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat { return 150 }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell()
        let reuseID = String(describing: ProductCell.self)
        
        if let productCell = tableView.dequeueReusableCell(withIdentifier: reuseID, for: indexPath) as? ProductCell {
            let isFiltered = isSoldOut == true || isComingSoon == true
            let layoutElements = isFiltered ? filteredElements[indexPath.row] : elements[indexPath.row]
            
            productCell.layoutCell(with: layoutElements)
            return productCell
        }
        return cell
    }
}

