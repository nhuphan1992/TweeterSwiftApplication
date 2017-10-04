//
//  HomeViewController.swift
//  TweeterApp
//
//  Created by Os on 10/4/17.
//  Copyright © 2017 nhuphan. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    let tableView = UITableView()
    let imputMessageView = InputMessageView(frame: CGRect.zero)
    var isAnimating: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupViews()
        self.setupTapGesture()
        self.setupKeyBoardListen()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        DefaultTheme.shareObject.setupNavigationBar(vc: self,
                                                    title: DefaultTheme.shareObject.text_App_Name(),
                                                    tintColor: DefaultTheme.shareObject.color_Text(),
                                                    leftText: nil,
                                                    leftImage: nil,
                                                    leftSelector: nil,
                                                    rightText: nil,
                                                    rightImage: nil,
                                                    rightSelector: nil,
                                                    isDarkBackground: false,
                                                    isTransparent: true)
    }
    
    // MARK: - Setup Views
    func setupViews() {
        self.view.backgroundColor = DefaultTheme.shareObject.color_App()
        self.automaticallyAdjustsScrollViewInsets = false
        self.view.addSubview(tableView)
        self.view.addSubview(imputMessageView)
        
        //tableView
        tableView.setProperties(backgroundColor: DefaultTheme.shareObject.color_Table_Background(),
                                allowsSelection: false,
                                delegate: self,
                                dataSource: self,
                                separatorStyle: .none,
                                bounces: true,
                                rowHeight: UITableViewAutomaticDimension)
        tableView.transform = CGAffineTransform(rotationAngle: -(CGFloat)(Double.pi));
        tableView.register(MessageCell.self, forCellReuseIdentifier: "MessageCell")
        
        let indicator = UIActivityIndicatorView(activityIndicatorStyle: .gray)
        indicator.tag = 1000 + tableView.tag
        indicator.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        indicator.backgroundColor = UIColor.clear
        tableView.tableFooterView = indicator
        
        //inputmessageview
        imputMessageView.delegate = self
        self.imputMessageView.textField.delegate = self
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        self.imputMessageView.snp.makeConstraints { (make) in
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.height.equalTo(60)
            make.bottom.equalToSuperview().offset(0)
        }
        self.tableView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(NAVIGATION_HEIGHT())
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalTo(self.imputMessageView.snp.top)
        }
    }
    
    func setupTapGesture() {
        let gesture = UITapGestureRecognizer(target: self, action: #selector(userTappedScreen(gesture:)))
        self.tableView.addGestureRecognizer(gesture)
    }
    
    func setupKeyBoardListen() {
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardNotification(notification:)), name: NSNotification.Name.UIKeyboardDidChangeFrame, object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    // MARK: -Handle Event
    @objc func userTappedScreen(gesture: UIGestureRecognizer) {
        self.view.endEditing(true)
    }
    
    @objc func keyboardNotification(notification: NSNotification) {
        if let userInfo = notification.userInfo {
            let endFrame = (userInfo[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue
            let duration:TimeInterval = (userInfo[UIKeyboardAnimationDurationUserInfoKey] as? NSNumber)?.doubleValue ?? 0
            let animationCurveRawNSN = userInfo[UIKeyboardAnimationCurveUserInfoKey] as? NSNumber
            let animationCurveRaw = animationCurveRawNSN?.uintValue ?? UIViewAnimationOptions.curveEaseInOut.rawValue
            let animationCurve:UIViewAnimationOptions = UIViewAnimationOptions(rawValue: animationCurveRaw)
            if (endFrame?.origin.y)! >= UIScreen.main.bounds.size.height {
                if isAnimating == true {
                    return
                }
                
                isAnimating = true
                UIView.animate(withDuration: duration/Double(4),
                               delay: TimeInterval(0),
                               options: animationCurve,
                               animations: {
                                self.imputMessageView.snp.remakeConstraints { (make) in
                                    make.bottom.equalToSuperview().offset(0)
                                }
                                
                                self.view.layoutIfNeeded()
                },
                               completion : { (completed) in
                                self.isAnimating = false
                })
                
            } else {
                self.imputMessageView.snp.remakeConstraints { (make) in
                    make.bottom.equalToSuperview().offset(-endFrame!.size.height)
                }
                
                self.view.layoutIfNeeded()
                
            }
        }
    }
}

extension HomeViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}

extension HomeViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
}

extension HomeViewController: InputMessageViewDelegate {
    func userFinishedInputingMessage(message: String) {
        
    }
}

extension HomeViewController: UITextFieldDelegate {
    
}
