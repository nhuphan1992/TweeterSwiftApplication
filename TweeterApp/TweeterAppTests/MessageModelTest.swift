//
//  MessageModelTest.swift
//  TweeterAppTests
//
//  Created by Os on 10/5/17.
//  Copyright © 2017 nhuphan. All rights reserved.
//

import XCTest
@testable import TweeterApp

class MessageModelTest: XCTestCase {
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
//    func testSplitMessage() {
//        
//    }
    
    func testMessageHaveWordMoreThan50Characters()
    {
        let message = "I think it's is too longggggggggggggggggggggggggggggggggggggggggggggggggggggg. The function will return nil"
        let subMessages = MessageModel.splitMessage(message: message)
        //Test expected result is nil
        XCTAssertNil(subMessages)
    }
    
    func testMessageShorterThan50Character() {
        let message = "I think this test will pass"
        let subMessages = MessageModel.splitMessage(message: message)
        
        //Test expected result is as same as the original message
        XCTAssertNotNil(subMessages)
        XCTAssertEqual(subMessages!.count, 1)
        XCTAssertEqual(subMessages?[0], message)
    }
    
    func testMessageIsOverThan50() {
        let message = "I can't believe Tweeter now supports chunking my messages, so I don't have to do it myself."
        let subMessages = MessageModel.splitMessage(message: message)
        
        //Test the general result
        XCTAssertNotNil(subMessages)
        XCTAssertEqual(subMessages!.count, 2)
        
        //Test length of sub-message
        var prefixStrings: [String] = []
        subMessages?.forEach({ (item) in
            XCTAssertLessThanOrEqual(item.characters.count, MessageModel.maximumLenghtOfMessage)
            let prefixString = String(item.split(separator: " ").first!)
            prefixStrings.append(prefixString)
        })
        
        //Test Prefix Of sub-message
        XCTAssertEqual("1/2", prefixStrings[0])
        XCTAssertEqual("2/2", prefixStrings[1])
    }
    
    func testMessageIsLong() {
        let message = "When Elon Musk first started SpaceX, everybody thought he was insane. Not only is space exploration an industry dominated by governments, but for someone without any background in space technology to go in with the belief that they could help drive meaningful progress was audacious to say the least. Over the years, however, much of that initial doubt about what was then seen as Musk’s pet project has subsided. SpaceX has indeed done the seemingly impossible, and that doubt has largely turned into curiosity.Given how involved Musk is in the engineering side of things, a question that he commonly gets asked is how on Earth he learned so much about rockets.His answer? It’s an answer that almost makes you want to laugh. Picking up rocket science as a hobby through reading isn’t what normal people do. Yet, it’s not completely unbelievable. We’ve all heard the stories about how many of the people we admire attribute much of their success to their thirst for knowledge and their love of books. Even in our own lives, we’ve all had experiences that hit home the impact of reading. A favorite childhood story. An inspiring writer. That one novel. Still, I don’t think most of internalize quite how much, and sometimes how subtly, what we read determines who we become."
        
        //Test the general result
        let subMessages = MessageModel.splitMessage(message: message)
        XCTAssertNotNil(subMessages)
        XCTAssertGreaterThanOrEqual(subMessages!.count, (message.characters.count/MessageModel.maximumLenghtOfMessage))
        
        //Test length of sub-message
        var prefixStrings: [String] = []
        subMessages?.forEach({ (item) in
            XCTAssertLessThanOrEqual(item.characters.count, MessageModel.maximumLenghtOfMessage)
            let prefixString = String(item.split(separator: " ").first!)
            prefixStrings.append(prefixString)
        })
        
        //Test Prefix Of sub-message
        var index = 0
        for prefixString in prefixStrings {
            XCTAssertEqual("\(index)/\(prefixStrings.count)", prefixStrings[0])
            index = index + 1
        }
    }
}
