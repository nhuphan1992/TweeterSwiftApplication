//
//  UIExtentions.swift
//  TweeterApp
//
//  Created by Os on 10/4/17.
//  Copyright © 2017 nhuphan. All rights reserved.
//

import UIKit

extension UIView {
    func addGradientOverView(colors: [CGColor]) {
        let mGradient : CAGradientLayer = CAGradientLayer()
        mGradient.frame = self.bounds
        mGradient.frame.origin = CGPoint(x: 0.0, y: 0.0)
        mGradient.colors = colors
        mGradient.locations = [0.0 , 1.0]
        mGradient.startPoint = CGPoint(x: 0.1, y: 0)
        mGradient.endPoint = CGPoint(x: 0.9, y: 1)
        mGradient.frame = CGRect(x: 0.0, y: 0.0, width: self.frame.size.width, height: self.frame.size.height)
        
        self.layer.insertSublayer(mGradient, at: 0)
    }
}

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
    func setProperties(backgroundColor: UIColor = .white, allowsSelection: Bool = true, delegate: UITableViewDelegate? = nil, dataSource: UITableViewDataSource? = nil, separatorStyle: UITableViewCellSeparatorStyle = .none, bounces: Bool = true, rowHeight:CGFloat = 60, shouldShowScrollIndicator: Bool = false) {
        self.allowsSelection = allowsSelection
        self.delegate = delegate
        self.dataSource = dataSource
        self.backgroundColor = backgroundColor
        self.separatorStyle = separatorStyle
        self.bounces = bounces
        self.estimatedRowHeight = 200
        self.rowHeight = rowHeight
        self.showsVerticalScrollIndicator = shouldShowScrollIndicator
        self.showsHorizontalScrollIndicator = shouldShowScrollIndicator
    }
}

extension UILabel {
    func setProperty(textAlign: NSTextAlignment = .left, textColor: UIColor = UIColor.black, font: UIFont = UIFont.systemFont(ofSize: 12), numberLines: Int = 0, backgroundColor: UIColor = UIColor.clear) {
        self.textAlignment = textAlign
        self.textColor = textColor
        self.font = font
        self.numberOfLines = numberLines
        self.backgroundColor = backgroundColor
    }
}

extension Date {
    func earlierDate(_ date:Date) -> Date{
        return (self.timeIntervalSince1970 <= date.timeIntervalSince1970) ? self : date
    }
    
    func timeAgoSinceDate(numericDates:Bool) -> String {
        let date = self
        let calendar = Calendar.current
        let unitFlags: Set<Calendar.Component> = [.minute, .hour, .day, .weekOfYear, .month, .year, .second]
        let now = Date()
        let earliest = now.earlierDate(date as Date)
        let latest = (earliest == now as Date) ? date : now
        let components = calendar.dateComponents(unitFlags, from: earliest as Date,  to: latest as Date)
        
        if (components.year! >= 2) {
            return "\(components.year!) years ago"
        } else if (components.year! >= 1){
            if (numericDates){
                return "1 year ago"
            } else {
                return "Last year"
            }
        } else if (components.month! >= 2) {
            return "\(components.month!) months ago"
        } else if (components.month! >= 1){
            if (numericDates){
                return "1 month ago"
            } else {
                return "Last month"
            }
        } else if (components.weekOfYear! >= 2) {
            return "\(components.weekOfYear!) weeks ago"
        } else if (components.weekOfYear! >= 1){
            if (numericDates){
                return "1 week ago"
            } else {
                return "Last week"
            }
        } else if (components.day! >= 2) {
            return "\(components.day!) days ago"
        } else if (components.day! >= 1){
            if (numericDates){
                return "1 day ago"
            } else {
                return "Yesterday"
            }
        } else if (components.hour! >= 2) {
            return "\(components.hour!) hours ago"
        } else if (components.hour! >= 1){
            if (numericDates){
                return "1 hour ago"
            } else {
                return "An hour ago"
            }
        } else if (components.minute! >= 2) {
            return "\(components.minute!) minutes ago"
        } else if (components.minute! >= 1){
            if (numericDates){
                return "1 minute ago"
            } else {
                return "A minute ago"
            }
        } else if (components.second! >= 3) {
            return "\(components.second!) seconds ago"
        } else {
            return "Just now"
        }
        
    }
}

extension NSAttributedString {
    func height(for width: CGFloat) -> CGFloat {
        let maxSize = CGSize(width: width, height: CGFloat.greatestFiniteMagnitude)
        let actualSize = boundingRect(with: maxSize, options: [.usesLineFragmentOrigin], context: nil)
        return actualSize.height
    }
}

extension UILabel {
    func textWidth(for height: CGFloat) -> CGFloat {
        guard let text = text else {
            return 0
        }
        return text.width(for: height, font: font)
    }
    
    func textHeight(for width: CGFloat) -> CGFloat {
        guard let text = text else {
            return 0
        }
        return text.height(for: width, font: font)
    }
    
    func attributedTextHeight(for width: CGFloat) -> CGFloat {
        guard let attributedText = attributedText else {
            return 0
        }
        return attributedText.height(for: width)
    }
}

extension String {
    func width(for height: CGFloat, font: UIFont) -> CGFloat {
        let maxSize = CGSize(width:  CGFloat.greatestFiniteMagnitude, height: height)
        let actualSize = self.boundingRect(with: maxSize, options: [.usesLineFragmentOrigin], attributes: [NSAttributedStringKey.font: font], context: nil)
        return actualSize.width
    }
    
    func height(for width: CGFloat, font: UIFont) -> CGFloat {
        let maxSize = CGSize(width: width, height: CGFloat.greatestFiniteMagnitude)
        let actualSize = self.boundingRect(with: maxSize, options: [.usesLineFragmentOrigin], attributes: [NSAttributedStringKey.font: font], context: nil)
        return actualSize.height
    }
}






