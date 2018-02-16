//
//  Articles.swift
//  PopularArticles
//
//  Created by DEP on 16/02/18.
//  Copyright © 2018 DEP. All rights reserved.
//

import UIKit

class Articles: NSObject {
    let urlString: String?
    let titleString: String?
    let publishedDateString: String?
    let byString: String?
    
    init(_ dict: [String:AnyObject]) {
        urlString = dict["url"] as? String
        titleString = dict["title"] as? String
        publishedDateString = dict["published_date"] as? String
        byString = dict["byline"] as? String
        
    }

}


