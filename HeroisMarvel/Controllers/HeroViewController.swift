//
//  HeroViewController.swift
//  HeroisMarvel
//
//  Created by Lucas Santana Brito on 11/01/20.
//  Copyright © 2020 lsb.br. All rights reserved.
//

import UIKit
import WebKit

class HeroViewController: UIViewController {
    
    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var loading: UIActivityIndicatorView!
    
    var hero: MarvelHero!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTitle()
        setupWebView()
    }
    
    private func setupWebView() {
        guard let firstUrl = hero.urls.first?.url else { return }
        guard let url = URL(string: firstUrl) else { return }
        let request = URLRequest(url: url)
        
        webView.allowsBackForwardNavigationGestures = true
        webView.navigationDelegate = self
        webView.load(request)
        webView.backgroundColor = .black
    }
    
    private func setupTitle() {
        title = hero.name
    }

}

extension HeroViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        loading.stopAnimating()
    }
}
