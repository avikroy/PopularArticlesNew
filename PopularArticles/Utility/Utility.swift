//
//  Utility.swift
//  PopularArticles
//
//  Created by DEP on 16/02/18.
//  Copyright © 2018 DEP. All rights reserved.
//

import UIKit

class Utility: NSObject {
   
    class func getAtricleArrayFromResponseArray(_ arrResponse : [[String:AnyObject]]) -> [Articles]{
        var articleArray = [Articles]()
        for dict in arrResponse{
            let article : Articles? = Articles(dict)
            if let value = article{
                articleArray.append(value)
            }
        }
        
        return articleArray
    }

}
