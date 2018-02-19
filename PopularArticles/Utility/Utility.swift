//
//  Utility.swift
//  PopularArticles
//
//  Created by DEP on 16/02/18.
//  Copyright © 2018 DEP. All rights reserved.
//

import UIKit
import SystemConfiguration

class Utility: NSObject {
    // convert JSon array to Article Object aray
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
    
    class func showAlert(_ viewcontroller: UIViewController, alertTitle: String, alertMessage: String, completion: @escaping (_ action: Bool)->()){
        let alertController = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: .alert)
        let yesAction = UIAlertAction(title: "Continue", style: .default) { (action) -> Void in
            completion(true)
        }
        
        let noAction = UIAlertAction(title: "Cancel", style: .cancel) { (action) -> Void in
            completion(false)
        }
        
        // Add Actions
        alertController.addAction(yesAction)
        alertController.addAction(noAction)
        
        // Present Alert Controller
        viewcontroller.present(alertController, animated: true, completion: nil)
    }
    
    // check for network connectivity
    class func isInternetAvailable() -> Bool
    {
        var zeroAddress = sockaddr_in()
        zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)
        
        let defaultRouteReachability = withUnsafePointer(to: &zeroAddress) {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {zeroSockAddress in
                SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
            }
        }
        
        var flags = SCNetworkReachabilityFlags()
        if !SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) {
            return false
        }
        let isReachable = flags.contains(.reachable)
        let needsConnection = flags.contains(.connectionRequired)
        return (isReachable && !needsConnection)
    }


}
