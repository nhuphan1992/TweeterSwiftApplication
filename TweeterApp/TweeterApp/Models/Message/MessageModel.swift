//
//  MessageModel.swift
//  TweeterApp
//
//  Created by Os on 10/4/17.
//  Copyright © 2017 nhuphan. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class MessageModel {
    static private let tableName = "Message"
    static private let keyMessage = "message"
    static private let keyTime = "time"
    
    var message: String = ""
    var date: Date = Date()
    
    convenience init(message:String, date:Date) {
        self.init()
        self.message = message
        self.date = date
    }
    
    static func saveObject(message: String, time: Date) -> MessageModel? {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let newMessage = NSEntityDescription.insertNewObject(forEntityName: tableName, into: context)
        newMessage.setValue(message, forKey: keyMessage)
        newMessage.setValue(time, forKey: keyTime)
        do {
            try context.save()
            return MessageModel(message: message, date: time)
        }
        catch
        {
            return nil
        }
    }
    
    static func fetchObjects(context: NSManagedObjectContext, offset:Int, limit: Int) -> [MessageModel] {
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: tableName)
        fetchRequest.fetchOffset = offset
        fetchRequest.fetchLimit = limit
        let sortedTime = NSSortDescriptor(key: keyTime, ascending: false)
        fetchRequest.sortDescriptors = [sortedTime]
        fetchRequest.returnsObjectsAsFaults = false
        
        do
        {
            let items = try context.fetch(fetchRequest)
            var results:[MessageModel] = []
            for item in items as! [NSManagedObject]
            {
                guard let message = item.value(forKey: keyMessage) as? String else {
                    continue
                }
                
                guard let time = item.value(forKey: keyTime) as? Date else {
                    continue
                }
                
                results.append(MessageModel(message: message, date: time))
            }
            
            return results
        } catch  {
            return []
        }
    }
}
