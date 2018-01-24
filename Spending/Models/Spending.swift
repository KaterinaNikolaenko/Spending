//
//  Spending.swift
//  Spending
//
//  Created by Katerina on 24.01.18.
//  Copyright © 2018 Katerina. All rights reserved.
//

import Foundation
import ObjectMapper

class Spending: Mappable {
    
    var id: Int!
    var title: String!
    var category: String!
    var createdAt: String!
    var isDisabled: Bool!
    var isUpcoming: Bool!
    var recurFreqDays: Int!
    var recurFreqMonths: Int!
    var recurDayNum: Int!
    var amountPence: Int!
    var dueDate: String!
    var houseName: String!
    var payerName: String!
    var categoryIconURL: String!
    var userShareAmountPence: Int!
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        title <- map["title"]
        category <- map["category"]
        createdAt <- map["created_at"]
        isDisabled <- map["disabled"]
        isUpcoming <- map["upcoming"]
        recurFreqDays <- map["recur_freq_days"]
        recurFreqMonths <- map["recur_freq_months"]
        recurDayNum <- map["recur_day_num"]
        amountPence <- map["amount_pence"]
        dueDate <- map["due_date"]
        houseName <- map["house_name"]
        payerName <- map["payer_name"]
        categoryIconURL <- map["category_icon"]
        userShareAmountPence <- map["user_share_amount_pence"]
    }
}
