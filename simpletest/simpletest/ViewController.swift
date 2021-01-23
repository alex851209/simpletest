//
//  ViewController.swift
//  simpletest
//
//  Created by Michael Chang on 2021/1/15.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureTableView()
    }

    private func configureTableView() {
        
        tableView.delegate = self
        tableView.dataSource = self
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { return 2 }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat { return 150 }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell()
        let reuseID = String(describing: ProductCell.self)
        
        if let productCell = tableView.dequeueReusableCell(withIdentifier: reuseID, for: indexPath) as? ProductCell {
            productCell.layoutCell()
            return productCell
        }
        return cell
    }
}

