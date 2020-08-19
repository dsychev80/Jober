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
        guard let url = URL(string: link) else { return }
        let request = URLRequest(url: url)
        webView.load(request)
    }
}
