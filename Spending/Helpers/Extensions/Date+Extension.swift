//
//  Date+Extension.swift
//  Spending
//
//  Created by Katerina on 24.01.18.
//  Copyright © 2018 Katerina. All rights reserved.
//

import Foundation

extension Date {
    
    //Convert date -> "EEEE, dd MMMM"
    static func convertDateToString(from date: Date) -> String {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE, dd MMMM"
        let dateStringEnd = dateFormatter.string(from:date)
        
        return dateStringEnd
    }
    
    //Convert "yyyy-MM-dd" -> date
    static func convertStringToDate(from dateString: String) -> Date {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let dateEnd = dateFormatter.date(from: dateString)
        
        return dateEnd!
    }
}
