//
//  Constants.swift
//  PopularArticles
//
//  Created by DEP on 15/02/18.
//  Copyright © 2018 DEP. All rights reserved.
//

import Foundation
import UIKit

class Constants {
    // API URL
    static let APP_URL = "http://api.nytimes.com/svc/mostpopular/v2/mostviewed/all-sections/7.json?api-key="
    static let API_KEY = "676dbd616328407e88eb58b120e09ddf"
    
    //tableview reuse identifiers
    static let CELL_REUSE_ID = "TableCellId"
    
    //segue identifiers
    static let LAUNCHING_SEGUE_ID = "viewController"
    static let DETAIL_SEGUE_ID = "detailArticle"
    
    // get api url
    class func getApiUrl() -> String {
        return APP_URL+API_KEY
    }
    
    
}
