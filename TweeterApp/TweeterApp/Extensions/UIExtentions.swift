//
//  UIExtentions.swift
//  TweeterApp
//
//  Created by Os on 10/4/17.
//  Copyright © 2017 nhuphan. All rights reserved.
//

import UIKit

extension UIColor {
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    convenience init(netHex:Int) {
        self.init(red:(netHex >> 16) & 0xff, green:(netHex >> 8) & 0xff, blue:netHex & 0xff)
    }
    
    convenience init(hexString:String) {
        var cString:String = hexString.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        
        if ((cString.characters.count) != 6) {
            self.init(
                red: CGFloat(1.0),
                green: CGFloat(1.0),
                blue: CGFloat(1.0),
                alpha: CGFloat(1.0)
            )
            return
        }
        
        var rgbValue:UInt32 = 0
        Scanner(string: cString).scanHexInt32(&rgbValue)
        
        self.init(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
    convenience init(hexString:String, alpha: CGFloat) {
        var cString:String = hexString.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        
        if ((cString.characters.count) != 6) {
            self.init(
                red: CGFloat(1.0),
                green: CGFloat(1.0),
                blue: CGFloat(1.0),
                alpha: alpha
            )
            return
        }
        
        var rgbValue:UInt32 = 0
        Scanner(string: cString).scanHexInt32(&rgbValue)
        
        self.init(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: alpha
        )
    }
}

extension UIView {
    func setLayer(cornerRadius: CGFloat = 0, borderWidth: CGFloat = 0, borderColor: CGColor = UIColor.white.cgColor, masksToBounds: Bool = false) {
        self.layer.cornerRadius = cornerRadius
        self.layer.borderWidth = borderWidth
        self.layer.borderColor = borderColor
        self.layer.masksToBounds = masksToBounds
    }
    
    func setShadow(shadowColor : UIColor, shadowRadius: CGFloat, shadowOpacity: Float, shadowOffset: CGSize)
    {
        self.layer.shadowColor = shadowColor.cgColor
        self.layer.shadowRadius = shadowRadius
        self.layer.shadowOpacity = shadowOpacity
        self.layer.shadowOffset = shadowOffset
    }
}

extension UITextField{
    @IBInspectable var placeHolderColor: UIColor? {
        get {
            return self.placeHolderColor
        }
        set {
            self.attributedPlaceholder = NSAttributedString(string:self.placeholder != nil ? self.placeholder! : "", attributes:[NSAttributedStringKey.foregroundColor: newValue!])
        }
    }
    
    func addLeftView(margin: CGFloat) {
        let leftView = UIView(frame: CGRect(x: 0, y: 0, width: margin, height: 30))
        self.leftView = leftView
        self.leftViewMode = .always
    }
    
    func addRightView(margin: CGFloat) {
        let rightView = UIView(frame: CGRect(x: 0, y: 0, width: margin, height: 30))
        self.rightView = rightView
        self.rightViewMode = .always
    }
    
    func setProperties(textAlignment: NSTextAlignment = .left, textColor: UIColor = .black, placeHolderText: String = "", font: UIFont = UIFont.systemFont(ofSize: 14), delegate: UITextFieldDelegate? = nil) {
        self.textAlignment = textAlignment
        self.placeholder = placeHolderText
        self.textColor = textColor
        self.font = font
        self.delegate = delegate
    }
}

extension UITableView {
    func setProperties(backgroundColor: UIColor = .white, allowsSelection: Bool = true, delegate: UITableViewDelegate? = nil, dataSource: UITableViewDataSource? = nil, separatorStyle: UITableViewCellSeparatorStyle = .none, bounces: Bool = true, rowHeight:CGFloat = 60) {
        self.allowsSelection = allowsSelection
        self.delegate = delegate
        self.dataSource = dataSource
        self.backgroundColor = backgroundColor
        self.separatorStyle = separatorStyle
        self.bounces = bounces
        self.estimatedRowHeight = 200
        self.rowHeight = rowHeight
    }
}


