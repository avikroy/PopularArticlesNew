//
//  PADetailViewController.swift
//  PopularArticles
//
//  Created by DEP on 15/02/18.
//  Copyright © 2018 DEP. All rights reserved.
//  This class is used show details of the selected article
//

import UIKit
import WebKit

class PADetailViewController: UIViewController, WKNavigationDelegate {
    @IBOutlet weak var controlToolBar: UIToolbar!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    var webView: WKWebView
    var urlString : String?
    required init(coder aDecoder: NSCoder) {
        self.webView = WKWebView(frame: CGRect.zero)
        super.init(coder: aDecoder)!
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        webView.navigationDelegate = self
        containerView.addSubview(webView)
        
        self.navigationController?.navigationBar.isTranslucent  =  false
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: self.activityIndicator)
        
        setupWebVeiw()
        
        // load webview
        if let value = urlString{
            showWebLoading()
            let url = URL(string: value)
            let request = URLRequest(url: url!)
            webView.load(request)
        }
        
    }
    
    // setup webview
    func setupWebVeiw(){
        webView.translatesAutoresizingMaskIntoConstraints = false
        let height = NSLayoutConstraint(item: webView, attribute: .height, relatedBy: .equal, toItem: containerView, attribute: .height, multiplier: 1, constant: 0)
        let width = NSLayoutConstraint(item: webView, attribute: .width, relatedBy: .equal, toItem: containerView, attribute: .width, multiplier: 1, constant: 0)
        containerView.addConstraints([height, width])
    }
    
    // show and hide loading
    func showWebLoading(){
        activityIndicator.isHidden = false
        activityIndicator.startAnimating();

    }
    
    func stopWebLoading(){
        activityIndicator.isHidden = true
        activityIndicator.stopAnimating();
    }

    // wkwebview navigation delegate
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        showWebLoading()

    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        stopWebLoading()

    }

    // action selectors
    
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
