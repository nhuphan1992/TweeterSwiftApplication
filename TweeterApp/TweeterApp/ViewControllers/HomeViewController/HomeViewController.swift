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
    let inputMessageView = InputMessageView(frame: CGRect.zero)
    var isAnimating: Bool = false
    var items:[MessageModel] = []
    var offsetData = 0
    let limitNumber = 3
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupViews()
        self.setupTapGesture()
        self.setupKeyBoardListen()
        self.fetchMoreDataAndReloadTable()
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
        self.view.addSubview(inputMessageView)
        
        //View
        let colors = [DefaultTheme.shareObject.color_Light_App().cgColor,
                      DefaultTheme.shareObject.color_App().cgColor]
        self.view.addGradientOverView(colors: colors)
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
        inputMessageView.delegate = self
    }
    
    func fetchMoreDataAndReloadTable() {
        if (self.tableView.tableFooterView as? UIActivityIndicatorView)!.isAnimating {
            return
        }
        self.tableView.tableFooterView?.isHidden = false
        (self.tableView.tableFooterView as? UIActivityIndicatorView)?.startAnimating()
        DispatchQueue.global().async {
            let newItems = MessageModel.fetchObjects(offset: self.offsetData, limit: self.limitNumber)
            DispatchQueue.main.async {
                self.items.append(contentsOf: newItems)
                self.offsetData = self.items.count - 1
                (self.tableView.tableFooterView as? UIActivityIndicatorView)?.stopAnimating()
                self.tableView.tableFooterView?.isHidden = true
                if newItems.count > 0 {
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        self.inputMessageView.snp.makeConstraints { (make) in
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.height.equalTo(60)
            make.bottom.equalToSuperview().offset(0)
        }
        self.tableView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(NAVIGATION_HEIGHT())
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview().offset(-60)
        }
    }
    
    func setupTapGesture() {
        let gesture = UITapGestureRecognizer(target: self, action: #selector(userTappedScreen(gesture:)))
        self.tableView.addGestureRecognizer(gesture)
    }
    
    func setupKeyBoardListen() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(self.keyboardNotification(notification:)),
                                               name: NSNotification.Name.UIKeyboardWillChangeFrame,
                                               object: nil)
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
                                self.inputMessageView.snp.remakeConstraints { (make) in
                                    make.bottom.equalToSuperview().offset(0)
                                }

                                self.view.layoutIfNeeded()
                },
                               completion : { (completed) in
                                self.isAnimating = false
                })
                
            } else {
                self.inputMessageView.snp.remakeConstraints { (make) in
                    make.bottom.equalToSuperview().offset(-endFrame!.size.height)
                }
                
                self.view.layoutIfNeeded()
                
            }
        }
    }
}


extension HomeViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MessageCell") as? MessageCell else {
            return UITableViewCell()
        }
        cell.reload(message: items[indexPath.row])
        cell.transform = CGAffineTransform(rotationAngle:(CGFloat)(Double.pi));
        
        if (indexPath.row == self.items.count - 1) {
            self.fetchMoreDataAndReloadTable()
        }
        return cell
    }
}


extension HomeViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
}


extension HomeViewController: InputMessageViewDelegate {
    func userFinishedInputingMessage(message: String) {
        self.view.endEditing(true)
        
        if message.isEmpty {
            return
        }
        
        self.inputMessageView.clear()
        
        if let msg = MessageModel.saveObject(message: message, time: Date()) {
            self.items.insert(msg, at: 0)
            self.offsetData = self.offsetData + 1
            self.tableView.reloadData()
            let firstIndex = IndexPath(item: 0, section: 0)
            self.tableView.scrollToRow(at: firstIndex, at: .middle, animated: true)
        }
    }
}
