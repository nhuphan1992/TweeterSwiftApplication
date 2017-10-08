//
//  MessageCell.swift
//  TweeterApp
//
//  Created by Os on 10/4/17.
//  Copyright © 2017 nhuphan. All rights reserved.
//

import UIKit

class MessageCell: UITableViewCell {
    let labelText = UILabel()
    let labelTime = UILabel()
    let viewcontainter = UIView()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.contentView.addSubview(viewcontainter)
        self.viewcontainter.addSubview(labelText)
        self.viewcontainter.addSubview(labelTime)
        self.viewcontainter.backgroundColor = DefaultTheme.shareObject.color_WhiteColor()
        
        self.viewcontainter.setShadow(shadowColor : DefaultTheme.shareObject.color_Dark_App(),
                                      shadowRadius: 8,
                                      shadowOpacity: 0.5,
                                      shadowOffset: CGSize(width: 0, height: 0.5))
        self.viewcontainter.setLayer(cornerRadius: 5, borderWidth: 0, masksToBounds: true)
        
        self.viewcontainter.backgroundColor = DefaultTheme.shareObject.color_WhiteColor()
        self.backgroundColor = UIColor.clear
        
        labelText.setProperty(textAlign: .left,
                              textColor: DefaultTheme.shareObject.color_Text(),
                              font: DefaultTheme.shareObject.font_primaryLight(size: .Small),
                              numberLines: 0,
                              backgroundColor: DefaultTheme.shareObject.color_WhiteColor())
        
        labelTime.setProperty(textAlign: .right,
                              textColor: DefaultTheme.shareObject.color_App_Blur_Text(),
                              font: DefaultTheme.shareObject.font_primaryLight(size: .Smaller),
                              numberLines: 0,
                              backgroundColor: DefaultTheme.shareObject.color_WhiteColor())
        
        self.setUpLayoutSubviews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpLayoutSubviews() {
        viewcontainter.snp.makeConstraints { (make) in
            make.trailing.equalToSuperview().offset(-DefaultTheme.shareObject.common_margin())
            make.leading.equalToSuperview().offset(DefaultTheme.shareObject.common_margin())
            make.top.equalToSuperview().offset(DefaultTheme.shareObject.common_margin())
            make.bottom.equalToSuperview().offset(-DefaultTheme.shareObject.common_margin())
        }
        
        labelText.snp.makeConstraints { (make) in
            make.trailing.equalToSuperview().offset(-DefaultTheme.shareObject.common_margin())
            make.leading.equalToSuperview().offset(DefaultTheme.shareObject.common_margin())
            make.top.equalToSuperview().offset(DefaultTheme.shareObject.common_margin())
            make.bottom.equalTo(labelTime.snp.top)
        }
        
        labelTime.snp.makeConstraints { (make) in
            make.trailing.equalToSuperview().offset(-DefaultTheme.shareObject.common_margin())
            make.leading.equalToSuperview().offset(DefaultTheme.shareObject.common_margin())
            make.height.equalTo(30)
            make.bottom.equalToSuperview()
        }
    }
    
    func reload(message: MessageModel) {
        self.labelText.text = message.message
        self.labelTime.text = message.date.timeAgoSinceDate(numericDates: true)
        self.layoutIfNeeded()
    }
}
