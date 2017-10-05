//
//  Theme.swift
//  TweeterApp
//
//  Created by Os on 10/4/17.
//  Copyright © 2017 nhuphan. All rights reserved.
//

import Foundation
import UIKit

func SCREEN_WIDTH() -> CGFloat {
    return UIScreen.main.bounds.size.width;
}

func SCREEN_HEIGHT() -> CGFloat {
    return UIScreen.main.bounds.size.height;
}

func NAVIGATION_HEIGHT() -> CGFloat {
    return 64
}

enum FontSize : CGFloat {
    case ExtraExtraLarge = 78.0
    case ExtraLarge = 54.0
    case VeryVeryLarge = 42.0
    case VeryLarge = 30.0
    case Larger = 24.0
    case Large = 20.0
    case Medium = 18.0
    case Small = 16.0
    case Smaller = 14.0
    case Tiny = 12.0
}

class Theme {
    fileprivate init() {
        
    }
    
    //MARK:- Font
    func font_primaryRegularCondensed(size: FontSize) -> UIFont {
        return UIFont.systemFont(ofSize: size.rawValue)
    }
    
    func font_primaryLight(size: FontSize) -> UIFont {
        return UIFont.systemFont(ofSize: size.rawValue)
    }
    
    func font_primaryRegular(size: FontSize) -> UIFont {
        return UIFont.systemFont(ofSize: size.rawValue)
    }
    
    func font_primaryBold(size: FontSize) -> UIFont {
        return UIFont.boldSystemFont(ofSize: size.rawValue)
    }
    
    func font_primaryItalic(size: FontSize) -> UIFont {
        return UIFont.italicSystemFont(ofSize: size.rawValue)
    }
    
    func font_primaryRegularCondensed(rawSize: CGFloat) -> UIFont {
        return UIFont.systemFont(ofSize: rawSize)
    }
    
    func font_primaryItalic(rawSize: CGFloat) -> UIFont {
        return UIFont.italicSystemFont(ofSize: rawSize)
    }
    
    func font_primaryLight(rawSize: CGFloat) -> UIFont {
        return UIFont.systemFont(ofSize: rawSize)
    }
    
    func font_primaryRegular(rawSize: CGFloat) -> UIFont {
        return UIFont.systemFont(ofSize: rawSize)
    }
    
    func font_primaryBold(rawSize: CGFloat) -> UIFont {
        return UIFont.boldSystemFont(ofSize: rawSize)
    }
    
    //MARK:- Color
    
    func color_App() -> UIColor {
        return UIColor(netHex: 0x9CCC65)
    }
    
    func color_Dark_App() -> UIColor {
        return UIColor(netHex: 0x558B2F)
    }
    
    func color_Light_App() -> UIColor {
        return UIColor(netHex: 0xDCEDC8)
    }
    
    func color_Table_Background() -> UIColor {
        return UIColor.clear
        //return UIColor(netHex: 0xF1F8E9)
    }
    
    func color_Text() -> UIColor {
        return UIColor(netHex: 0x004D40)
    }
    
    func color_Text_Selected() -> UIColor {
        return UIColor(netHex: 0x212121)
    }
    
    func color_App_Blur_Text() -> UIColor {
        return UIColor(hexString: "ACB3BA", alpha: 1.0)
    }
    
    func color_App_Black_Text() -> UIColor {
        return UIColor(hexString: "4A6273", alpha: 1.0)
    }
    
    func color_AccentOrangeColor() -> UIColor {
        return UIColor(hexString: "FF4611", alpha: 1.0)
    }
    
    /* Highlight color for use when in cases where the orange color is not appropriate (e.g. when button is on an orange background) */
    func color_AlternateHighlightColor() -> UIColor {
        return UIColor(hexString: "4B4843", alpha: 1.0)
    }
    
    /* Fossil Q Black: Used for all instances of dark type and CTAs */
    func color_BlackColor() -> UIColor {
        return UIColor(hexString: "3D3934", alpha: 1.0)
    }
    
    /* Fossil Q White: Used as light type and background color for most screens */
    func color_WhiteColor() -> UIColor {
        return UIColor(hexString: "F8F6F3", alpha: 1.0)
    }
    
    /* Medium gray color used for deactivated states (e.g. deactivated cell text in Notifications, no color/haptics icons) */
    func color_GrayDeactivatedColor() -> UIColor {
        return UIColor(hexString: "B3B2B1", alpha: 1.0)
    }
    
    /* Faded black color used as hit state for navigation items */
    func color_BlackHitStateColor() -> UIColor {
        return UIColor(hexString: "3D3934", alpha: 0.4)
    }
    
    /* Red color used for error messages, etc (e.g. invalid email address) */
    func color_Red() -> UIColor {
        return UIColor(hexString: "FF0000", alpha: 1.0)
    }
    
    /* Alt medium beige color (e.g. tableview section header background) */
    func color_MediumBeige() -> UIColor {
        return UIColor(hexString: "efece8", alpha: 1.0)
    }
    
    
    //Gray
    func color_LightGray() -> UIColor {
        return UIColor(hexString: "e0ddda", alpha: 1.0)
    }
    
    /* Gray colors used in debug screens, etc */
    func color_MediumGray() -> UIColor {
        return UIColor(hexString: "adadac", alpha: 1.0)
    }
    
    func color_DarkGray() -> UIColor {
        return UIColor(hexString: "151515", alpha: 1.0)
    }
    
    
    /* Colors used in Q Notifications */
    func color_Blue() -> UIColor {
        return UIColor(hexString: "5BB6FC", alpha: 1.0)
    }
    func color_Yellow() -> UIColor {
        return UIColor(hexString: "F2C400", alpha: 1.0)
    }
    func color_Orange() -> UIColor {
        return UIColor(hexString: "F29007", alpha: 1.0)
    }
    func color_Purple() -> UIColor {
        return UIColor(hexString: "9C6CCD", alpha: 1.0)
    }
    func color_Green() -> UIColor {
        return UIColor(hexString: "45BD78", alpha: 1.0)
    }
    func color_Pink() -> UIColor {
        return UIColor(hexString: "ff86dc", alpha: 1.0)
    }
    
    /* Curiosity punchcard */
    func color_CuriosityRed() -> UIColor {
        return UIColor(hexString: "d01920", alpha: 1.0)
    }
    
    /* Facebook */
    func color_DarkBlue() -> UIColor {
        return UIColor(hexString: "3b5998", alpha: 1.0)
    }
    
    func setupNavigationBar(
        vc: UIViewController,
        title: String? = nil,
        tintColor: UIColor? = nil,
        leftText: String? = nil,
        leftImage: UIImage? = nil,
        leftSelector: Selector? = nil,
        rightText: String? = nil,
        rightImage: UIImage? = nil,
        rightSelector: Selector? = nil,
        isDarkBackground: Bool? = false,
        isTransparent: Bool? = false) -> Void
    {
        vc.navigationItem.hidesBackButton = true
        if title != nil {
            vc.navigationItem.title = title
            vc.navigationController?.isNavigationBarHidden = false
        } else {
            //            vc.navigationController?.isNavigationBarHidden = true
        }
        let defaultTextColor = (isDarkBackground! ? UIColor.white : UIColor.black)
        let textColor = tintColor != nil ? tintColor! : defaultTextColor
        
        let textAttributes
            = [NSAttributedStringKey.foregroundColor : textColor,
               NSAttributedStringKey.font : self.font_primaryBold(size: .Medium)]
        
        vc.navigationController?.navigationBar.tintColor = textColor
        vc.navigationController?.navigationBar.titleTextAttributes = textAttributes
        //   vc.navigationController?.navigationBar.mfl_turnStatusBarLight(isDarkBackground == false)
        
        if leftImage != nil && leftSelector != nil {
            vc.navigationItem.leftBarButtonItem = UIBarButtonItem(image: leftImage, style: UIBarButtonItemStyle.plain, target: vc, action: leftSelector!)
        } else if leftText != nil && leftSelector != nil {
            vc.navigationItem.leftBarButtonItem = UIBarButtonItem(title: leftText, style: UIBarButtonItemStyle.plain, target: vc, action: leftSelector!)
            vc.navigationItem.leftBarButtonItem?.tintColor = UIColor.black
            
            vc.navigationItem.leftBarButtonItem?.setTitleTextAttributes(textAttributes, for: UIControlState.normal)
        }
        
        // Right
        if rightImage != nil && rightSelector != nil {
            vc.navigationItem.rightBarButtonItem = UIBarButtonItem(image: rightImage, style: UIBarButtonItemStyle.plain, target: vc, action: rightSelector!)
        }
        else if rightText != nil && rightSelector != nil {
            vc.navigationItem.rightBarButtonItem = UIBarButtonItem(title: rightText, style: UIBarButtonItemStyle.plain, target: vc, action: rightSelector!)
            vc.navigationItem.rightBarButtonItem?.tintColor = UIColor.black
            
            vc.navigationItem.rightBarButtonItem?.setTitleTextAttributes(textAttributes, for: UIControlState.normal)
        }
        
        if (isTransparent != nil) && isTransparent == true {
            vc.navigationController?.navigationBar.isTranslucent = true
            vc.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
            vc.navigationController?.navigationBar.shadowImage = UIImage()
        } else {
            vc.navigationController?.navigationBar.isTranslucent = false
            vc.navigationController?.navigationBar.setBackgroundImage(nil, for: UIBarMetrics.default)
            vc.navigationController?.navigationBar.shadowImage = nil
        }
    }
    
    // MARK: Text
    func text_App_Name() -> String {
        return ""
    }
    
    // MARk: Size
    func common_margin() -> CGFloat {
        return CGFloat(15)
    }
}

class DefaultTheme: Theme {
    static let shareObject = DefaultTheme()

    override func text_App_Name() -> String {
        return "Tweeter"
    }
    
    func text_PlaceHolder_Input_Message() -> String {
        return "Enter your message here."
    }
}

