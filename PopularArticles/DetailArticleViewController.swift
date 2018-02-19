//
//  DetailArticleViewController.swift
//  PopularArticles
//
//  Created by DEP on 15/02/18.
//  Copyright © 2018 DEP. All rights reserved.
//

import UIKit
import WebKit

class DetailArticleViewController: UIViewController, WKNavigationDelegate {
    @IBOutlet weak var controlToolBar: UIToolbar!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    var webView: WKWebView
    var article : Articles?
    required init(coder aDecoder: NSCoder) {
        self.webView = WKWebView(frame: CGRect.zero)
        super.init(coder: aDecoder)!
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        webView.navigationDelegate = self
        containerView.addSubview(webView)
        
        self.navigationController?.navigationBar.isTranslucent  =  false
        
        webView.translatesAutoresizingMaskIntoConstraints = false
        let height = NSLayoutConstraint(item: webView, attribute: .height, relatedBy: .equal, toItem: containerView, attribute: .height, multiplier: 1, constant: 0)
        let width = NSLayoutConstraint(item: webView, attribute: .width, relatedBy: .equal, toItem: containerView, attribute: .width, multiplier: 1, constant: 0)
        containerView.addConstraints([height, width])
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: self.activityIndicator)
        
        // load webview
        if let value = article?.urlString{
            showWebLoading()
            let url = URL(string: value)
            let request = URLRequest(url: url!)
            webView.load(request)
        }
        
    }
    
    func showWebLoading(){
        activityIndicator.isHidden = false
        activityIndicator.startAnimating();

    }
    
    func stopWebLoading(){
        activityIndicator.isHidden = true
        activityIndicator.stopAnimating();
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // wkwebview navigation delegate
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        showWebLoading()

    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        stopWebLoading()

    }

    
    @IBAction func backAction(_ sender: Any) {
        if self.webView.canGoBack {
            self.webView.goBack()
        }
    }
    
    
    @IBAction func forwardAction(_ sender: Any) {
        if self.webView.canGoForward {
            self.webView.goForward()

        }
    }
    
    

}
