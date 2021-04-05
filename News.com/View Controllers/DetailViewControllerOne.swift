//
//  DetailViewControllerOne.swift
//  News.com
//
//  Created by Justin Huang on 7/5/20.
//  Copyright © 2020 Justin Huang. All rights reserved.
//

import UIKit
import WebKit

class DetailViewControllerOne: UIViewController, WKNavigationDelegate {
    
    @IBOutlet weak var webView: WKWebView!
    
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    var articleUrl:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        webView.navigationDelegate = self
 
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        
        if articleUrl != nil {
            let url = URL(string: articleUrl!)
            
            guard url != nil else {
                print("could not create url object")
                return
            }
            
            let request = URLRequest(url: url!)
            
            webView.load(request)
            
            spinner.alpha = 1
            spinner.startAnimating()
        }
        
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        print("did finish loading URL")
        
        //done launching
        spinner.alpha = 0
        spinner.stopAnimating()
    }
    
}
