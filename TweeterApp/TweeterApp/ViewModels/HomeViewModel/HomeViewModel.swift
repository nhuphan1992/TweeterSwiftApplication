//
//  HomeModelView.swift
//  TweeterApp
//
//  Created by Os on 10/7/17.
//  Copyright © 2017 nhuphan. All rights reserved.
//

import Foundation
import UIKit

protocol HomeViewModelDelegate {
    func didChangeMessages(isAddingNewMessage: Bool)
    func willChangeMessages(isAddingNewMessage: Bool)
}
class HomeViewModel{
    private var offsetData = 0
    private let limitNumber = 200
    var items = [MessageModel]()
    var delegate: HomeViewModelDelegate? = nil
    var isLoadingData = false
    
    func getMessagesCount() -> Int {
        return items.count
    }
    
    func getMessageModel(index: Int) -> MessageModel {
        return items[index]
    }
    
    func save(messages: [String]) {
        self.delegate?.willChangeMessages(isAddingNewMessage: true)
        for message in messages {
            if let msg = MessageModel.saveObject(message: message, time: Date()) {
                self.items.insert(msg, at: 0)
                self.offsetData = self.offsetData + 1
                self.delegate?.didChangeMessages(isAddingNewMessage: true)
            }
        }
    }
    
    func fetchMoreData() {
        if isLoadingData == true {
            return
        }
        
        isLoadingData = true
        self.delegate?.willChangeMessages(isAddingNewMessage: false)
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.newBackgroundContext()
        
        DispatchQueue.global().async {
            
            let newItems = MessageModel.fetchObjects(context: context, offset: self.offsetData, limit: self.limitNumber)
            self.isLoadingData = false
            DispatchQueue.main.async {
                                
                if newItems.count == 0 {
                    // do nothing
                } else {
                    self.items.append(contentsOf: newItems)
                    self.offsetData = self.items.count - 1
                }
                self.delegate?.didChangeMessages(isAddingNewMessage: false)
            }
        }
    }
}
