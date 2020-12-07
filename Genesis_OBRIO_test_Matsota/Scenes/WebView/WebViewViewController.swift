//
//  WebViewViewController.swift
//  Genesis_OBRIO_test_Matsota
//
//  Created by Andrew Matsota on 07.12.2020.
//

import WebKit

class WebViewViewController: UIViewController, Storyboarding {

    //MARK: - Implementation
    public var url: URL!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let webView = WKWebView()
        webView.frame = CGRect(x: 0, y: 0,
                               width: UIScreen.main.bounds.width,
                               height: UIScreen.main.bounds.height)
        
        let request = URLRequest(url: url)
        DispatchQueue.main.async {
            webView.load(request)
            self.view.insertSubview(webView, at: 0)
        }        
    }

}
