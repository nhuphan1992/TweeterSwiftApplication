//
//  Helper.swift
//  TweeterApp
//
//  Created by Os on 10/7/17.
//  Copyright © 2017 nhuphan. All rights reserved.
//

import Foundation

class Helper {
    static let maximumLenghtOfMessage = 50
    
    static func splitMessage(message: String) -> [String]? {
        if (message.characters.count < maximumLenghtOfMessage) {
            return [message]
        }
        
        let words = message.split(separator: " ")
        
        for word in words {
            if word.characters.count > maximumLenghtOfMessage {
                return nil
            }
        }
        
        let guestNumberOfMessages = message.characters.count / maximumLenghtOfMessage + 1
        let strlenghtOfNumber = String(guestNumberOfMessages).characters.count * 2 + 1
        let realLenghtOfAll = message.characters.count + guestNumberOfMessages * (strlenghtOfNumber)
        let finalGuestNumberOfMessages = realLenghtOfAll / maximumLenghtOfMessage + 1
        let realLenghtNeedToSplit = message.characters.count / finalGuestNumberOfMessages + 1
        
        var results: [String] = []
        var sentence: String = ""
        for word in words {
            let futureSentence = sentence + " " + word
            if futureSentence.characters.count > realLenghtNeedToSplit {
                if (sentence.characters.count == 0)
                {
                    return nil
                }
                results.append(sentence)
                sentence = String(word)
            } else
            {
                sentence = sentence + " " + word
            }
        }
        
        if sentence.characters.count > 0 {
            results.append(sentence)
        }
        let count = results.count
        var index = 0
        return results.map({ (item) -> String in
            index = index + 1
            return "\(index)/\(count) \(item)"
        })
    }
}
