//
//  HomeViewController.swift
//  TweeterApp
//
//  Created by Os on 10/4/17.
//  Copyright © 2017 nhuphan. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
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
        self.view.backgroundColor = DefaultTheme.shareObject.color_App()
    }
}
