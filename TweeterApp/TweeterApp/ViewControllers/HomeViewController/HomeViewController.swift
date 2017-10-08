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
    let labelNoMessage = UILabel()
    
    let viewModel = HomeViewModel()
    var isAnimatingKeyboard: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupViews()
        self.setupTapGesture()
        self.setupKeyBoardListen()

        viewModel.delegate = self
        viewModel.fetchMoreData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        DefaultTheme.shareObject
            .setupNavigationBar(vc: self,
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
        self.view.addSubview(tableView)
        self.view.addSubview(labelNoMessage)
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
                                bounces: true)
        tableView.transform = CGAffineTransform(rotationAngle: -(CGFloat)(Double.pi));
        tableView.register(MessageCell.self, forCellReuseIdentifier: "MessageCell")
        let indicator = UIActivityIndicatorView(activityIndicatorStyle: .gray)
        indicator.tag = 1000 + tableView.tag
        indicator.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        indicator.backgroundColor = UIColor.clear
        tableView.tableFooterView = indicator
        
        //inputmessageview
        inputMessageView.delegate = self
        
        //labelNoMessage
        labelNoMessage.setProperty(textAlign: .center,
                                  textColor: DefaultTheme.shareObject.color_Text(),
                                  font: DefaultTheme.shareObject.font_primaryLight(size: .Small),
                                  numberLines: 2,
                                  backgroundColor: UIColor.clear)
        labelNoMessage.text = DefaultTheme.shareObject.text_No_Message()
        labelNoMessage.isHidden = true
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
        self.labelNoMessage.snp.makeConstraints { (make) in
            make.leading.equalToSuperview().offset(DefaultTheme.shareObject.common_margin())
            make.trailing.equalToSuperview().offset(-DefaultTheme.shareObject.common_margin())
            make.height.equalTo(60)
            make.centerY.equalToSuperview()
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
                if isAnimatingKeyboard == true {
                    return
                }
                
                isAnimatingKeyboard = true
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
                                self.isAnimatingKeyboard = false
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
        return viewModel.getMessagesCount()
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MessageCell") as? MessageCell else {
            return UITableViewCell()
        }
        cell.reload(message: viewModel.getMessageModel(index: indexPath.row))
        cell.transform = CGAffineTransform(rotationAngle:(CGFloat)(Double.pi));

        if indexPath.row == viewModel.getMessagesCount() - 1 && viewModel.isFetchedAllMessages() == false {
            viewModel.fetchMoreData()
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let message = viewModel.getMessageModel(index: indexPath.row)
        
        return message.message.height(for: SCREEN_WIDTH() - 4 * DefaultTheme.shareObject.common_margin(), font: DefaultTheme.shareObject.font_primaryLight(size: .Small)) + 4 * DefaultTheme.shareObject.common_margin() + 30
    }
}


extension HomeViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
}

extension HomeViewController: HomeViewModelDelegate {
    func didChangeMessages(isAddingNewMessage: Bool) {
        self.tableView.reloadData()
        if isAddingNewMessage {
            let firstIndex = IndexPath(item: 0, section: 0)
            self.tableView.scrollToRow(at: firstIndex, at: .middle, animated: true)
            self.inputMessageView.clear()
        } else {
            self.tableView.tableFooterView?.isHidden = true
            (self.tableView.tableFooterView as? UIActivityIndicatorView)?.stopAnimating()
        }
        labelNoMessage.isHidden = !(self.viewModel.getMessagesCount() == 0)
    }
    
    func willChangeMessages(isAddingNewMessage: Bool) {
        if isAddingNewMessage {
            // Do nothing
        } else {
            self.tableView.tableFooterView?.isHidden = false
            (self.tableView.tableFooterView as? UIActivityIndicatorView)?.startAnimating()
        }
    }
}

extension HomeViewController: InputMessageViewDelegate {
    func userFinishedInputingMessage(message: String) {
        self.view.endEditing(true)
        
        if message.isEmpty {
            return
        }
        
        if let subMessages = Helper.splitMessage(message: message) {

            viewModel.save(messages: subMessages)

        } else {

            let alertViewController = UIAlertController(title: "",
                                                        message: "The message contains a span of non-whitespace characters longer than \(Helper.maximumLenghtOfMessage), please check your message", preferredStyle: .actionSheet)
            let alertAction = UIAlertAction(title: "OK", style: .default, handler: {[weak self] (action) in
                self?.dismiss(animated: true, completion: nil)
            })
            alertViewController.addAction(alertAction)
            self.present(alertViewController, animated: true, completion: nil)
            
        }
    }
}
