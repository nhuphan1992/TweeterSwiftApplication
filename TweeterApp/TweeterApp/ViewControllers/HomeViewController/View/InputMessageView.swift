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
    let btnDelete = UIButton()
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
        self.addSubview(btnDelete)
        
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
        btnDelete.addTarget(self, action: #selector(userTappedBtn(btn:)), for: .touchUpInside)
        btnDelete.setImage(UIImage(named: "icon_delete"), for: .normal)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.btnSend.snp.makeConstraints { (make) in
            make.width.equalTo(45)
            make.height.equalTo(45)
            make.trailing.equalToSuperview().offset(-DefaultTheme.shareObject.common_margin())
            make.centerY.equalToSuperview()
        }

        self.btnDelete.snp.makeConstraints { (make) in
            make.width.equalTo(45)
            make.height.equalTo(45)
            make.trailing.equalTo(self.btnSend.snp.leading)
            make.centerY.equalToSuperview()
        }

        self.textField.snp.makeConstraints { (make) in
            make.leading.equalToSuperview().offset(DefaultTheme.shareObject.common_margin())
            make.centerY.equalToSuperview()
            make.height.equalTo(30)
            make.trailing.equalTo(btnDelete.snp.leading).offset(0)
        }
    }
    
    
    // MARK: Handle Event
    @objc func userTappedBtn(btn: UIButton)
    {
        //self.textField.text = "Gần 20 năm lăn lộn trên internet, hàng trăm nghìn giờ thao thức cùng anh em trong công ty để tinh chỉnh từng pixel, inspect từng dòng code để tạo ra những sản phẩm, dù lớn dù nhỏ đều phải hoàn hảo. Đấy cũng là cách mà chúng tôi trưởng thành và trở thành 1 công ty có uy tín về các sản phẩm trên nền tảng Web.Joomla! Wordpress, Magento đều đang phải trải qua những thăng trầm nhất định trong sự biến đổi vũ bão của các công nghệ. Nhưng các bạn nên nhớ rằng những nền tảng này vẫn đang chiếm đến gần 40% thị phần hảng tỉ web site trên toàn cầu.Với những bước đi táo bạo, dũng cảm gần đây của chúng tôi, thâu tóm hầu hết các đối thủ cạnh tranh trên thị trường và trở thành công ty số 1 trên thế giới về mã nguồn mở, đặc biệt là Joomla! Và để chuẩn bị cho những bước phát triển nóng hơn trong thời gian tới, anh em chúng tôi rất mong muốn có điều kiện hợp tác với tất cả các công ty làm về Joomla, Wordpress, Magento, Shopify, Page Builder system ở Việt nam. Nếu các anh em đang có những sản phẩm tương tự, hoặc là những Engineer tài ba đang có ước mơ xây dựng những sản phẩm tầm cỡ cho hàng triệu người dùng thì cho Hung Dinh này xin một buổi cafe để trò chuyện nhé. Tớ tin là chúng ta sẽ có nhiều cơ hội, câu chuyện thú vị để share notes cùng nhau. Rất mong nhận được những lời hẹn đầu tiên. Anh chị em cứ comment, inbox luôn vào thread này nhé Gần 20 năm lăn lộn trên internet, hàng trăm nghìn giờ thao thức cùng anh em trong công ty để tinh chỉnh từng pixel, inspect từng dòng code để tạo ra những sản phẩm, dù lớn dù nhỏ đều phải hoàn hảo. Đấy cũng là cách mà chúng tôi trưởng thành và trở thành 1 công ty có uy tín về các sản phẩm trên nền tảng Web.Joomla! Wordpress, Magento đều đang phải trải qua những thăng trầm nhất định trong sự biến đổi vũ bão của các công nghệ. Nhưng các bạn nên nhớ rằng những nền tảng này vẫn đang chiếm đến gần 40% thị phần hảng tỉ web site trên toàn cầu.Với những bước đi táo bạo, dũng cảm gần đây của chúng tôi, thâu tóm hầu hết các đối thủ cạnh tranh trên thị trường và trở thành công ty số 1 trên thế giới về mã nguồn mở, đặc biệt là Joomla! Và để chuẩn bị cho những bước phát triển nóng hơn trong thời gian tới, anh em chúng tôi rất mong muốn có điều kiện hợp tác với tất cả các công ty làm về Joomla, Wordpress, Magento, Shopify, Page Builder system ở Việt nam. Nếu các anh em đang có những sản phẩm tương tự, hoặc là những Engineer tài ba đang có ước mơ xây dựng những sản phẩm tầm cỡ cho hàng triệu người dùng thì cho Hung Dinh này xin một buổi cafe để trò chuyện nhé. Tớ tin là chúng ta sẽ có nhiều cơ hội, câu chuyện thú vị để share notes cùng nhau. Rất mong nhận được những lời hẹn đầu tiên. Anh chị em cứ comment, inbox luôn vào thread này nhé Gần 20 năm lăn lộn trên internet, hàng trăm nghìn giờ thao thức cùng anh em trong công ty để tinh chỉnh từng pixel, inspect từng dòng code để tạo ra những sản phẩm, dù lớn dù nhỏ đều phải hoàn hảo. Đấy cũng là cách mà chúng tôi trưởng thành và trở thành 1 công ty có uy tín về các sản phẩm trên nền tảng Web.Joomla! Wordpress, Magento đều đang phải trải qua những thăng trầm nhất định trong sự biến đổi vũ bão của các công nghệ. Nhưng các bạn nên nhớ rằng những nền tảng này vẫn đang chiếm đến gần 40% thị phần hảng tỉ web site trên toàn cầu.Với những bước đi táo bạo, dũng cảm gần đây của chúng tôi, thâu tóm hầu hết các đối thủ cạnh tranh trên thị trường và trở thành công ty số 1 trên thế giới về mã nguồn mở, đặc biệt là Joomla! Và để chuẩn bị cho những bước phát triển nóng hơn trong thời gian tới, anh em chúng tôi rất mong muốn có điều kiện hợp tác với tất cả các công ty làm về Joomla, Wordpress, Magento, Shopify, Page Builder system ở Việt nam. Nếu các anh em đang có những sản phẩm tương tự, hoặc là những Engineer tài ba đang có ước mơ xây dựng những sản phẩm tầm cỡ cho hàng triệu người dùng thì cho Hung Dinh này xin một buổi cafe để trò chuyện nhé. Tớ tin là chúng ta sẽ có nhiều cơ hội, câu chuyện thú vị để share notes cùng nhau. Rất mong nhận được những lời hẹn đầu tiên. Anh chị em cứ comment, inbox luôn vào thread này nhé Gần 20 năm lăn lộn trên internet, hàng trăm nghìn giờ thao thức cùng anh em trong công ty để tinh chỉnh từng pixel, inspect từng dòng code để tạo ra những sản phẩm, dù lớn dù nhỏ đều phải hoàn hảo. Đấy cũng là cách mà chúng tôi trưởng thành và trở thành 1 công ty có uy tín về các sản phẩm trên nền tảng Web.Joomla! Wordpress, Magento đều đang phải trải qua những thăng trầm nhất định trong sự biến đổi vũ bão của các công nghệ. Nhưng các bạn nên nhớ rằng những nền tảng này vẫn đang chiếm đến gần 40% thị phần hảng tỉ web site trên toàn cầu.Với những bước đi táo bạo, dũng cảm gần đây của chúng tôi, thâu tóm hầu hết các đối thủ cạnh tranh trên thị trường và trở thành công ty số 1 trên thế giới về mã nguồn mở, đặc biệt là Joomla! Và để chuẩn bị cho những bước phát triển nóng hơn trong thời gian tới, anh em chúng tôi rất mong muốn có điều kiện hợp tác với tất cả các công ty làm về Joomla, Wordpress, Magento, Shopify, Page Builder system ở Việt nam. Nếu các anh em đang có những sản phẩm tương tự, hoặc là những Engineer tài ba đang có ước mơ xây dựng những sản phẩm tầm cỡ cho hàng triệu người dùng thì cho Hung Dinh này xin một buổi cafe để trò chuyện nhé. Tớ tin là chúng ta sẽ có nhiều cơ hội, câu chuyện thú vị để share notes cùng nhau. Rất mong nhận được những lời hẹn đầu tiên. Anh chị em cứ comment, inbox luôn vào thread này nhé Gần 20 năm lăn lộn trên internet, hàng trăm nghìn giờ thao thức cùng anh em trong công ty để tinh chỉnh từng pixel, inspect từng dòng code để tạo ra những sản phẩm, dù lớn dù nhỏ đều phải hoàn hảo. Đấy cũng là cách mà chúng tôi trưởng thành và trở thành 1 công ty có uy tín về các sản phẩm trên nền tảng Web.Joomla! Wordpress, Magento đều đang phải trải qua những thăng trầm nhất định trong sự biến đổi vũ bão của các công nghệ. Nhưng các bạn nên nhớ rằng những nền tảng này vẫn đang chiếm đến gần 40% thị phần hảng tỉ web site trên toàn cầu.Với những bước đi táo bạo, dũng cảm gần đây của chúng tôi, thâu tóm hầu hết các đối thủ cạnh tranh trên thị trường và trở thành công ty số 1 trên thế giới về mã nguồn mở, đặc biệt là Joomla! Và để chuẩn bị cho những bước phát triển nóng hơn trong thời gian tới, anh em chúng tôi rất mong muốn có điều kiện hợp tác với tất cả các công ty làm về Joomla, Wordpress, Magento, Shopify, Page Builder system ở Việt nam. Nếu các anh em đang có những sản phẩm tương tự, hoặc là những Engineer tài ba đang có ước mơ xây dựng những sản phẩm tầm cỡ cho hàng triệu người dùng thì cho Hung Dinh này xin một buổi cafe để trò chuyện nhé. Tớ tin là chúng ta sẽ có nhiều cơ hội, câu chuyện thú vị để share notes cùng nhau. Rất mong nhận được những lời hẹn đầu tiên. Anh chị em cứ comment, inbox luôn vào thread này nhé Gần 20 năm lăn lộn trên internet, hàng trăm nghìn giờ thao thức cùng anh em trong công ty để tinh chỉnh từng pixel, inspect từng dòng code để tạo ra những sản phẩm, dù lớn dù nhỏ đều phải hoàn hảo. Đấy cũng là cách mà chúng tôi trưởng thành và trở thành 1 công ty có uy tín về các sản phẩm trên nền tảng Web.Joomla! Wordpress, Magento đều đang phải trải qua những thăng trầm nhất định trong sự biến đổi vũ bão của các công nghệ. Nhưng các bạn nên nhớ rằng những nền tảng này vẫn đang chiếm đến gần 40% thị phần hảng tỉ web site trên toàn cầu.Với những bước đi táo bạo, dũng cảm gần đây của chúng tôi, thâu tóm hầu hết các đối thủ cạnh tranh trên thị trường và trở thành công ty số 1 trên thế giới về mã nguồn mở, đặc biệt là Joomla! Và để chuẩn bị cho những bước phát triển nóng hơn trong thời gian tới, anh em chúng tôi rất mong muốn có điều kiện hợp tác với tất cả các công ty làm về Joomla, Wordpress, Magento, Shopify, Page Builder system ở Việt nam. Nếu các anh em đang có những sản phẩm tương tự, hoặc là những Engineer tài ba đang có ước mơ xây dựng những sản phẩm tầm cỡ cho hàng triệu người dùng thì cho Hung Dinh này xin một buổi cafe để trò chuyện nhé. Tớ tin là chúng ta sẽ có nhiều cơ hội, câu chuyện thú vị để share notes cùng nhau. Rất mong nhận được những lời hẹn đầu tiên. Anh chị em cứ comment, inbox luôn vào thread này nhé Gần 20 năm lăn lộn trên internet, hàng trăm nghìn giờ thao thức cùng anh em trong công ty để tinh chỉnh từng pixel, inspect từng dòng code để tạo ra những sản phẩm, dù lớn dù nhỏ đều phải hoàn hảo. Đấy cũng là cách mà chúng tôi trưởng thành và trở thành 1 công ty có uy tín về các sản phẩm trên nền tảng Web.Joomla! Wordpress, Magento đều đang phải trải qua những thăng trầm nhất định trong sự biến đổi vũ bão của các công nghệ. Nhưng các bạn nên nhớ rằng những nền tảng này vẫn đang chiếm đến gần 40% thị phần hảng tỉ web site trên toàn cầu.Với những bước đi táo bạo, dũng cảm gần đây của chúng tôi, thâu tóm hầu hết các đối thủ cạnh tranh trên thị trường và trở thành công ty số 1 trên thế giới về mã nguồn mở, đặc biệt là Joomla! Và để chuẩn bị cho những bước phát triển nóng hơn trong thời gian tới, anh em chúng tôi rất mong muốn có điều kiện hợp tác với tất cả các công ty làm về Joomla, Wordpress, Magento, Shopify, Page Builder system ở Việt nam. Nếu các anh em đang có những sản phẩm tương tự, hoặc là những Engineer tài ba đang có ước mơ xây dựng những sản phẩm tầm cỡ cho hàng triệu người dùng thì cho Hung Dinh này xin một buổi cafe để trò chuyện nhé. Tớ tin là chúng ta sẽ có nhiều cơ hội, câu chuyện thú vị để share notes cùng nhau. Rất mong nhận được những lời hẹn đầu tiên. Anh chị em cứ comment, inbox luôn vào thread này nhé Gần 20 năm lăn lộn trên internet, hàng trăm nghìn giờ thao thức cùng anh em trong công ty để tinh chỉnh từng pixel, inspect từng dòng code để tạo ra những sản phẩm, dù lớn dù nhỏ đều phải hoàn hảo. Đấy cũng là cách mà chúng tôi trưởng thành và trở thành 1 công ty có uy tín về các sản phẩm trên nền tảng Web.Joomla! Wordpress, Magento đều đang phải trải qua những thăng trầm nhất định trong sự biến đổi vũ bão của các công nghệ. Nhưng các bạn nên nhớ rằng những nền tảng này vẫn đang chiếm đến gần 40% thị phần hảng tỉ web site trên toàn cầu.Với những bước đi táo bạo, dũng cảm gần đây của chúng tôi, thâu tóm hầu hết các đối thủ cạnh tranh trên thị trường và trở thành công ty số 1 trên thế giới về mã nguồn mở, đặc biệt là Joomla! Và để chuẩn bị cho những bước phát triển nóng hơn trong thời gian tới, anh em chúng tôi rất mong muốn có điều kiện hợp tác với tất cả các công ty làm về Joomla, Wordpress, Magento, Shopify, Page Builder system ở Việt nam. Nếu các anh em đang có những sản phẩm tương tự, hoặc là những Engineer tài ba đang có ước mơ xây dựng những sản phẩm tầm cỡ cho hàng triệu người dùng thì cho Hung Dinh này xin một buổi cafe để trò chuyện nhé. Tớ tin là chúng ta sẽ có nhiều cơ hội, câu chuyện thú vị để share notes cùng nhau. Rất mong nhận được những lời hẹn đầu tiên. Anh chị em cứ comment, inbox luôn vào thread này nhé"
        if btn == self.btnSend {
            self.delegate?.userFinishedInputingMessage(message: self.textField.text ?? "")
            return
        }
        
        if btn == self.btnDelete {
            self.textField.text = ""
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
