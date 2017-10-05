//
//  InputMessageView.swift
//  TweeterApp
//
//  Created by Os on 10/4/17.
//  Copyright © 2017 nhuphan. All rights reserved.
//

import UIKit
import SnapKit
protocol InputMessageViewDelegate {
    func userFinishedInputingMessage(message:String)
}

class InputMessageView: UIView {
    let textField = UITextField()
    let btnSend = UIButton()
    var delegate: InputMessageViewDelegate? = nil
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: Setup UI
    func setupViews() {
        self.addSubview(textField)
        self.addSubview(btnSend)
        
        self.backgroundColor = DefaultTheme.shareObject.color_WhiteColor()
        self.setLayer(cornerRadius: 3,
                      borderWidth: 1,
                      borderColor: DefaultTheme.shareObject.color_App().cgColor,
                      masksToBounds: true)
        
        textField.setProperties(textAlignment: .left,
                                textColor: DefaultTheme.shareObject.color_Text(),
                                placeHolderText: DefaultTheme.shareObject.text_PlaceHolder_Input_Message(),
                                font: DefaultTheme.shareObject.font_primaryLight(size: .Small),
                                delegate: self)
        
        btnSend.addTarget(self, action: #selector(userTappedBtn(btn:)), for: .touchUpInside)
        btnSend.setImage(UIImage(named: "icon_send"), for: .normal)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.btnSend.snp.makeConstraints { (make) in
            make.width.equalTo(45)
            make.height.equalTo(45)
            make.trailing.equalToSuperview().offset(-DefaultTheme.shareObject.common_margin())
            make.centerY.equalToSuperview()
        }
        
        self.textField.snp.makeConstraints { (make) in
            make.leading.equalToSuperview().offset(DefaultTheme.shareObject.common_margin())
            make.centerY.equalToSuperview()
            make.height.equalTo(30)
            make.trailing.equalTo(btnSend.snp.leading).offset(DefaultTheme.shareObject.common_margin())
        }
    }
    
    
    // MARK: Handle Event
    @objc func userTappedBtn(btn: UIButton)
    {
        if btn == self.btnSend {
            self.delegate?.userFinishedInputingMessage(message: self.textField.text ?? "")
        }
    }
    
    
    // MARK: Methods
    func clear() {
        self.textField.text = ""
    }
}

extension InputMessageView: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.delegate?.userFinishedInputingMessage(message: self.textField.text ?? "")
        return true
    }
}
