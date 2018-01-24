//
//  ViewController.swift
//  Spending
//
//  Created by Katerina on 24.01.18.
//  Copyright © 2018 Katerina. All rights reserved.
//

import UIKit

class SpendingListViewController: UIViewController {

    //UI
    @IBOutlet weak var spendingTable: UITableView!
    
    //dataSource
    private var sections = [Section]()
    
    // private
    private var httpClient:HttpClient = HttpClient()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

// MARK: - UITableViewDataSource

extension SpendingListViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let section = sections[section]
        return section.items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let section = sections[indexPath.section]
        let item = section.items[indexPath.item]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! SpendingTableViewCell
        cell.titleLabel.text = item.title
        cell.payerNameLabel.text = item.payerName
        cell.amountPenceLabel.text = "£" + String(item.amountPence)
        
        let imageURL: URL = URL(string: item.categoryIconURL)!
        Constants.Queues.queueUtility.async{
            if let data = try? Data(contentsOf: imageURL){
                DispatchQueue.main.async {
                    cell.categoryIconImageView.image = UIImage(data: data)
                }
            }
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return Date.convertDate(from: sections[section].dueDate)
    }
}
