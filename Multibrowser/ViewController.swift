//
//  ViewController.swift
//  Multibrowser
//
//  Created by Yohannes Wijaya on 10/31/15.
//  Copyright © 2015 Yohannes Wijaya. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIWebViewDelegate, UITextFieldDelegate, UIGestureRecognizerDelegate {
    
    // MARK: - Stored Properties
    
    weak var activeWebView: UIWebView?

    // MARK: - IBOutlet Properties
    
    @IBOutlet weak var addressBar: UITextField!
    @IBOutlet weak var stackView: UIStackView!
    
    // MARK: - Methods Override
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setDefaultTitle()
        
        let addWebViewBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: "addWebView")
        let deleteWebViewBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Trash, target: self, action: "deleteWebView")
        self.navigationItem.rightBarButtonItems = [addWebViewBarButtonItem, deleteWebViewBarButtonItem]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Delegate Methods
    
    func gestureRecognizer(gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWithGestureRecognizer otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        guard let webView = self.activeWebView, address = self.addressBar.text else { return false }
        guard let url = NSURL(string: address) else { return false }
        webView.loadRequest(NSURLRequest(URL: url))
        
        textField.resignFirstResponder()
        return true
    }

    // MARK: - Local Methods
    
    func addWebView() {
        let webView = UIWebView()
        webView.delegate = self
        
        self.stackView.addArrangedSubview(webView)
        
        let url = NSURL(string: "https://www.apple.com")!
        webView.loadRequest(NSURLRequest(URL: url))
        
        webView.layer.borderColor = UIColor.blueColor().CGColor
        self.selectWebView(webView)
        
        let tapGR = UITapGestureRecognizer(target: self, action: "webViewTapped:")
        tapGR.delegate = self
    }
    
    func selectWebView(webView: UIWebView) {
        for view in self.stackView.arrangedSubviews {
            view.layer.borderWidth = 0
        }
        
        self.activeWebView = webView
        webView.layer.borderWidth = 3
    }
    
    func setDefaultTitle() {
        self.title = "Multibrowser"
    }
    
    func webViewTapped(recognizer: UITapGestureRecognizer) {
        if let selectedWebView = recognizer.view as? UIWebView {
            self.selectWebView(selectedWebView)
        }
    }
}

