//
//  HttpClient.swift
//  Spending
//
//  Created by Katerina on 24.01.18.
//  Copyright © 2018 Katerina. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireObjectMapper


class HttpClient{
    
    // Get spendings from API
    func getSpending(completion: @escaping ([Spending]) -> ()) {
        
        Alamofire.request(Constants.URLs.baseURL).responseArray(queue: Constants.Queues.queueUtility, completionHandler: { (response: DataResponse<[Spending]>) in
            if (response.result.isSuccess) {
                completion(response.result.value!)
            }
        })
    }
    
}
