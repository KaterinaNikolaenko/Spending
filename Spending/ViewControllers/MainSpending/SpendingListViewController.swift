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
    fileprivate var httpClient:HttpClient = HttpClient()
    var refreshControl: UIRefreshControl!
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupSpending()
        
        //Refresh table
        refreshControl = UIRefreshControl()
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh...")
        refreshControl.addTarget(self, action: #selector(refreshTable), for: .valueChanged)
        spendingTable.addSubview(refreshControl)
    }
    
    @objc func refreshTable(sender:AnyObject) {
        setupSpending()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetails"{
            let spending = sender as! Spending
            let detailsVC = segue.destination as? DetailsOfSpendingViewController
            detailsVC!.item = spending
        }
    }
}

// MARK: - Private

extension SpendingListViewController {
    
    // Setup sections/rows for table
    fileprivate func setupSpending()  {
        
        httpClient.getSpending(completion: { (itemsFromAPI) -> Void in
            let spendingDict = Dictionary(grouping: itemsFromAPI, by: { $0.dueDate })
            
            for (key,value) in spendingDict {
                var items  = [Spending]()
                for spending in value {
                    items.append(spending)
                }
                self.sections.append(Section(dueDate: Date.convertStringToDate(from: key), items: items))
            }
            self.sections = self.sections.sorted(by: {$0.dueDate < $1.dueDate})
            DispatchQueue.main.async {
                self.spendingTable.reloadData()
                if self.refreshControl != nil {
                    self.refreshControl.endRefreshing()
                }
            }
        })
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
        cell.payerNameLabel.text = item.payerName + " paid"
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
        return Date.convertDateToString(from: sections[section].dueDate)
    }
}

// MARK: - UITableViewDelegate

extension SpendingListViewController: UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        let header = view as! UITableViewHeaderFooterView
        header.textLabel?.font = UIFont(name: "Helvetica Neue", size: 15)!
        header.textLabel?.textColor = UIColor.lightGray
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showDetails", sender: sections[indexPath.section].items[indexPath.row])
    }
}
