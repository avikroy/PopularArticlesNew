//
//  PAListViewController.swift
//  PopularArticles
//
//  Created by DEP on 15/02/18.
//  Copyright © 2018 DEP. All rights reserved.
//  This class is used to list all articles
//

import UIKit
import Alamofire
import SwiftyJSON
import RappleProgressHUD

class PAListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableViewNews: UITableView!
    var arrRes = [[String :  AnyObject]]()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "NY Times Most Popular"
        
        tableViewNews.separatorStyle = .none
        tableViewNews.isHidden = true
        
        self.navigationController?.navigationBar.isTranslucent  =  false
        
        if Utility.isInternetAvailable(){
            RappleActivityIndicatorView.startAnimatingWithLabel("Please Wait...", attributes: RappleAppleAttributes)

            getArticles { (result) in
                if result {
                    self.tableViewNews.isHidden = false
                    self.tableViewNews.separatorStyle = .singleLine
                    self.tableViewNews.reloadData()
                    RappleActivityIndicatorView.stopAnimation()
                    
                }
            }
        }else{
            // if no network - ask user to rechek network connection and retry
            resetAndRetry()
        }
        
        
    }
    
    // reset connection and retry
    func resetAndRetry(){
        Utility.showAlert(self, alertTitle: "No Network", alertMessage: "Please cehck you network connection and try again", completion: { (action) in
            if action {
                if Utility.isInternetAvailable(){
                    RappleActivityIndicatorView.startAnimatingWithLabel("Please Wait...", attributes: RappleAppleAttributes)
                    self.getArticles { (result) in
                        if result {
                            self.tableViewNews.isHidden = false
                            self.tableViewNews.separatorStyle = .singleLine
                            self.tableViewNews.reloadData()
                            RappleActivityIndicatorView.stopAnimation()
                            
                        }
                    }
                }else{
                   self.resetAndRetry()
                }
            }
        })
    }
    
    // request articles
    func getArticles(completion: @escaping (_ result: Bool)->()) {
        Alamofire.request(Constants.getApiUrl()).responseJSON { (responseData) -> Void in
            if((responseData.result.value) != nil) {
                let swiftyJsonVar = JSON(responseData.result.value!)
                print("\(swiftyJsonVar)")
                
                if let resData = swiftyJsonVar["results"].arrayObject {
                   self.arrRes = resData as! [[String:AnyObject]]
                }
                
                if self.arrRes.count > 0 {
                    completion(true)
                }else{
                    completion(false)

                }
                
            }
        }
    }
    

    // table view data source
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrRes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.CELL_REUSE_ID, for: indexPath) as! PATableViewCell
        cell.accessoryType = .disclosureIndicator
        if arrRes.count > 0 {
            let dict = arrRes[(indexPath as NSIndexPath).row]
            cell.labelNewHeadings.text = dict["title"] as? String
            cell.labelBy.text = dict["byline"] as? String
            cell.labelDate.text = dict["published_date"] as? String
        }
        
        return cell
    }
    
    //table view delegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: Constants.DETAIL_SEGUE_ID) as? PADetailViewController {
            if arrRes.count > 0{
                let dict = arrRes[(indexPath as NSIndexPath).row]
                viewController.urlString = dict["url"] as? String

            }
            if let navigator = navigationController {
                navigator.pushViewController(viewController, animated: true)
            }
        }
    }

}




