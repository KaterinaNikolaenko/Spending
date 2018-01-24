//
//  Constants.swift
//  Spending
//
//  Created by Katerina on 24.01.18.
//  Copyright © 2018 Katerina. All rights reserved.
//

import Foundation

struct Constants {
    
    struct URLs {
        static let baseURL = "https://api.myjson.com/bins/107b4d"
    }
    
    struct Queues {
        static let queueUtility = DispatchQueue.global(qos: .utility)
    }
}
