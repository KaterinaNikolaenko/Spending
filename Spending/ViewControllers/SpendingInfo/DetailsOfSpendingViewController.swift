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
        
        titleLabel.text = item?.title
        categoryLabel.text = item?.category
        payerNameLabel.text = item!.payerName + " paid"
        houseNameLabel.text = item?.houseName
        amountPenceLabel.text = "£" + String(describing: item!.amountPence)
        
        let imageURL: URL = URL(string: item!.categoryIconURL)!
        Constants.Queues.queueUtility.async{
            if let data = try? Data(contentsOf: imageURL){
                DispatchQueue.main.async {
                    self.categoryIconImageView.image = UIImage(data: data)
                }
            }
        }
    }
}
