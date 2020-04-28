//
//  JobWebPageViewController.swift
//  Jober
//
//  Created by Denis Sychev on 26/04/2020.
//  Copyright © 2020 Denis Sychev. All rights reserved.
//

import UIKit
import WebKit

class JobWebPageViewController: UIViewController, WKNavigationDelegate {
    
    var link: String = ""
    @IBOutlet weak var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.webView.load(URLRequest(url: URL(string: link)!))
        guard let url = URL(string: link) else { return }
        let request = URLRequest(url: url)
        webView.navigationDelegate = self
        webView.load(request)
    }
}
