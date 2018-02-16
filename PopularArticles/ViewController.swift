//
//  ViewController.swift
//  PopularArticles
//
//  Created by DEP on 15/02/18.
//  Copyright © 2018 DEP. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import RappleProgressHUD

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableViewNews: UITableView!
    var articleArray = [Articles]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "NY Times Most Popular"
        
        tableViewNews.separatorStyle = .none
        tableViewNews.isHidden = true
        
        RappleActivityIndicatorView.startAnimatingWithLabel("Please Wait...", attributes: RappleAppleAttributes)

        getArticles { (result) in
            if result {
                self.tableViewNews.isHidden = false
                self.tableViewNews.separatorStyle = .singleLine
                self.tableViewNews.reloadData()
                RappleActivityIndicatorView.stopAnimation()

            }
        }
        
    }
    
    // request articles
    
    func getArticles(completion: @escaping (_ result: Bool)->()) {
        Alamofire.request(Constants.getApiUrl()).responseJSON { (responseData) -> Void in
            if((responseData.result.value) != nil) {
                let swiftyJsonVar = JSON(responseData.result.value!)
                print("\(swiftyJsonVar)")
                
                if let resData = swiftyJsonVar["results"].arrayObject {
                    let arrRes = resData as! [[String:AnyObject]]
                    self.articleArray = Utility.getAtricleArrayFromResponseArray(arrRes)
                    
                }
                if self.articleArray.count > 0 {
                    completion(true)
                }else{
                    completion(false)

                }
                
            }
        }
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // table view data source
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articleArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.CELL_REUSE_ID, for: indexPath) as! PATableViewCell
        cell.accessoryType = .disclosureIndicator
        if articleArray.count > 0 {
            let article = articleArray[(indexPath as NSIndexPath).row]
            cell.labelNewHeadings.text = article.titleString
            cell.labelBy.text = article.byString
            cell.labelDate.text = article.publishedDateString
        }
        
        return cell
    }
    
    //table view delegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: Constants.DETAIL_SEGUE_ID) as? DetailArticleViewController {
            if articleArray.count > 0{
                viewController.article = articleArray[(indexPath as NSIndexPath).row]

            }
            if let navigator = navigationController {
                navigator.pushViewController(viewController, animated: true)
            }
        }
    }

}




