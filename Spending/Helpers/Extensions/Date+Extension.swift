//
//  Date+Extension.swift
//  Spending
//
//  Created by Katerina on 24.01.18.
//  Copyright © 2018 Katerina. All rights reserved.
//

import Foundation

extension Date {
    
    static func convertDate(from dateString: String) -> String {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        let date = dateFormatter.date(from: dateString)
        
        dateFormatter.dateFormat = "EEEE, dd MMMM"
        let dateStringEnd = dateFormatter.string(from:date!)
        
        return dateStringEnd
    }
}
