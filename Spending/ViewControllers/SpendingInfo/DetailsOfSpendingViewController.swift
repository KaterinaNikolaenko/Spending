//
//  DetailsOfSpendingViewController.swift
//  Spending
//
//  Created by Katerina on 24.01.18.
//  Copyright © 2018 Katerina. All rights reserved.
//

import UIKit

class DetailsOfSpendingViewController: UIViewController {

    //UI
    @IBOutlet weak var categoryIconImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var payerNameLabel: UILabel!
    @IBOutlet weak var houseNameLabel: UILabel!
    @IBOutlet weak var amountPenceLabel: UILabel!
    
    var item = Spending()
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

// MARK: - Private

extension DetailsOfSpendingViewController {
    
    fileprivate func setupUI() {
        
        if let title = item?.title {
            titleLabel.text = title
        }
        if let category = item?.category {
            categoryLabel.text = category
        }
        if let payerName = item?.payerName {
            payerNameLabel.text = payerName + " paid"
        }
        if let houseName = item?.houseName {
            houseNameLabel.text = houseName
        }
        if let amountPence = item?.amountPence {
            amountPenceLabel.text = "£" + String(describing: amountPence)
        }
        if let categoryIconURL = item?.categoryIconURL {
            let imageURL: URL = URL(string: categoryIconURL)!
            Constants.Queues.queueUtility.async{
                if let data = try? Data(contentsOf: imageURL){
                    DispatchQueue.main.async {
                        self.categoryIconImageView.image = UIImage(data: data)
                    }
                }
            }
        }
    }
}
