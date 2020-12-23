//
//  ViewController.swift
//  SimpleBrowser
//
//  Created by Sanatzhan Aimukambetov on 22.12.2020.
//

import UIKit
import WebKit
import SnapKit

class WebViewController: UIViewController, UITextFieldDelegate, WKNavigationDelegate {
    
    //MARK: Interface
    let topView: UIView = {
       let topView = UIView()
        topView.backgroundColor = Constants.bgColor
        return topView
    }()
    
    let progressView: UIProgressView = {
        let progressView = UIProgressView(progressViewStyle: .bar)
        progressView.trackTintColor = Constants.bgColor
        progressView.progressTintColor = Constants.greenColor
        return progressView
    }()
    
    let mainWebView: WKWebView = {
        let webView = WKWebView()
        return webView
    }()
    
    let bottomView: UIView = {
       let bottomView = UIView()
        bottomView.backgroundColor = Constants.bgColor
        return bottomView
    }()
    
    let webTextField: UITextField = {
       let webTF = UITextField()
        webTF.attributedPlaceholder = NSAttributedString(string: "Веб-поиск или имя сайта", attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
        webTF.setLeftPaddingPoints(10)
        webTF.backgroundColor = Constants.grayColor
        webTF.textColor = .white
        webTF.layer.cornerRadius = 10
        webTF.keyboardType = .URL
        webTF.autocapitalizationType = .none
        return webTF
    }()
    
    let backButton: UIButton = {
       let backButton = UIButton()
        backButton.setImage(#imageLiteral(resourceName: "backButton"), for: .normal)
        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        return backButton
    }()
    
    let historyButton: UIButton = {
       let historyButton = UIButton()
        historyButton.setImage(#imageLiteral(resourceName: "historyButton"), for: .normal)
        historyButton.addTarget(self, action: #selector(historyButtonTapped), for: .touchUpInside)
        return historyButton
    }()
    
    let forwardButton: UIButton = {
       let forwardButton = UIButton()
        forwardButton.setImage(#imageLiteral(resourceName: "forwardButton"), for: .normal)
        forwardButton.addTarget(self, action: #selector(forwardButtonTapped), for: .touchUpInside)
        return forwardButton
    }()
    
    //MARK: VC lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setupConstraints()
        
        webTextField.delegate = self
        mainWebView.navigationDelegate = self
        
        mainWebView.addObserver(self, forKeyPath: #keyPath(WKWebView.estimatedProgress), options: .new, context: nil)
    }
    
    //MARK: TextField actions
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if let urlString = webTextField.text{
            if urlString.starts(with: "http://") || urlString.starts(with: "https://") {
                guard let url = URL(string: urlString) else {
                    searchTextOnGoogle(text: urlString)
                    return true
                }
                mainWebView.load(URLRequest(url: url))
            } else if let url = URL(string: "https://\(urlString)") {
                mainWebView.load(URLRequest(url: url))
            } else {
                searchTextOnGoogle(text: urlString)
            }
        }
        
        textField.resignFirstResponder()
        progressView.isHidden = false
        
        return true
    }
    
    private func searchTextOnGoogle(text: String){
        let textComponent = text.components(separatedBy: " ")
        let searchString = textComponent.joined(separator: "+")
        guard let url = URL(string: "https://www.google.com/search?q=" + searchString) else { return }
        let urlRequest = URLRequest(url: url)
        mainWebView.load(urlRequest)
    }
    
    //MARK: Button actions
    @objc private func historyButtonTapped(_ sender: Any) {
        let vc = HistoryViewController()
//        navigationController?.pushViewController(vc, animated: true)
        self.present(vc, animated: true, completion: nil)
    }
    
    @objc private func backButtonTapped(_ sender: Any) {
        if mainWebView.canGoBack {
            mainWebView.goBack()
        }
    }
    
    @objc private func forwardButtonTapped(_ sender: Any) {
        if mainWebView.canGoForward {
            mainWebView.goForward()
        }
    }
    
    //MARK: WebView and ProgressView actions
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        
        backButton.isEnabled = webView.canGoBack
        forwardButton.isEnabled = webView.canGoForward
        webTextField.text = webView.url?.absoluteString
        progressView.isHidden = true
        
        //Cохранение страницы в истории
        var newHistoryItem = HistoryItem()
        newHistoryItem.title = webView.title!
        newHistoryItem.url = webView.url!.absoluteString
        StorageManager.saveObject(newHistoryItem)
    }
    
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        guard let urlString = webTextField.text else { return }
        searchTextOnGoogle(text: urlString)
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "estimatedProgress" {
            progressView.progress = Float(mainWebView.estimatedProgress)
        }
    }
    
    //MARK: Setup views
    private func setupViews() {
        
        mainWebView.isOpaque = false
        view.addSubview(topView)
        view.addSubview(progressView)
        view.addSubview(mainWebView)
        view.addSubview(bottomView)
        
        topView.addSubview(webTextField)
        
        bottomView.addSubview(backButton)
        bottomView.addSubview(historyButton)
        bottomView.addSubview(forwardButton)
    }
    
    private func setupConstraints() {
        
        //Основные элементы
        topView.snp.makeConstraints { (make) in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(100)
        }
        
        progressView.snp.makeConstraints { (make) in
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(topView.snp.bottom)
            make.height.equalTo(3)
        }
        
        mainWebView.snp.makeConstraints { (make) in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(topView.snp.bottom)
            make.bottom.equalTo(bottomView.snp.top)
        }
        
        bottomView.snp.makeConstraints { (make) in
            make.leading.trailing.bottom.equalToSuperview()
            make.height.equalTo(80)
        }
            
        //Второстепенные элементы
        webTextField.snp.makeConstraints { (make) in
            make.leading.trailing.equalToSuperview().inset(20)
            make.bottom.equalToSuperview().inset(15)
            make.height.equalTo(40)
        }
        
        backButton.snp.makeConstraints { (make) in
            make.leading.equalToSuperview().inset(30)
            make.top.equalToSuperview().inset(10)
            make.height.width.equalTo(40)
        }
        
        historyButton.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().inset(10)
            make.height.width.equalTo(40)
        }
        
        forwardButton.snp.makeConstraints { (make) in
            make.trailing.equalToSuperview().inset(30)
            make.top.equalToSuperview().inset(10)
            make.height.width.equalTo(40)
        }
        
    }

}

extension UITextField {
    func setLeftPaddingPoints(_ amount:CGFloat){
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
}

