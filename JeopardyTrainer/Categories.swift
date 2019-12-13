//
//  Categories.swift
//  JeopardyTrainer
//
//  Created by Kim-An Quinn on 12/13/19.
//  Copyright © 2019 Kim-An Quinn. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class Categories{
    var apiURL = "http://jservice.io/api/categories/"
    var categoryCount = 5
    var categoryArray: [Category] = []
    
    func getData(completed: @escaping () -> ()) {
        let updatedURL = apiURL + "?count=\(categoryCount)"
        Alamofire.request(updatedURL).responseJSON { (response) in
            switch response.result{
            case .success(let value):
                let json = JSON(value)
                print("*** json = \(json)")
                let numberOfCategories = json.count
                for index in 0..<numberOfCategories{
                    let id = json[index]["id"].intValue
                    let title = json[index]["title"].stringValue
                    let cluesCount = json[index]["clues_count"].intValue
                    self.categoryArray.append(Category(id: id, title: title, cluesCount: cluesCount))
                }
                
            case .failure(let error):
                print("error: failed to get data from url, error: \(error.localizedDescription)")
            }
            completed()
        }
    }
}
