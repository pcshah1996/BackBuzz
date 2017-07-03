//
//  NotificationQueue.swift
//  BackBuzz
//
//  Created by Prateek Shah on 7/2/17.
//  Copyright © 2017 Prateek Shah. All rights reserved.
//

import Foundation
import UIKit

class NotificationQueue {
    class var sharedInstance : NotificationQueue {
        struct Static {
            static let instance: NotificationQueue = NotificationQueue()
        }
        return Static.instance
    }
    
    fileprivate let APP_KEY = "notificationItems"
    
    func allItems() -> [NotificationItem] {
        let notifDictionary = UserDefaults.standard.dictionary(forKey: APP_KEY) ?? [:]
        let items = Array(notifDictionary.values)
        
        return items.map({
                let item = $0 as! [String:AnyObject]
            return NotificationItem(deadline: item["deadline"] as! Date, title: item["title"] as! String, UUID: item["UUID"] as! String!)
            }).sorted(by: {(left: NotificationItem, right: NotificationItem) -> Bool in
                (left.deadline.compare(right.deadline) == .orderedAscending)
        })
        
    }
    
    func addItem(_ item: NotificationItem) {
        var notifDictionary = UserDefaults.standard.dictionary(forKey: APP_KEY) ?? Dictionary()
        notifDictionary[item.UUID] = ["deadline": item.deadline, "title": item.title, "UUID": item.UUID]
        UserDefaults.standard.set(notifDictionary, forKey: APP_KEY)
        
        let notif = UILocalNotification()
        notif.alertBody = item.title
        notif.alertAction = "open"
        notif.fireDate = item.deadline
        notif.soundName = UILocalNotificationDefaultSoundName
        notif.userInfo = ["UUID": item.UUID]
        
        UIApplication.shared.scheduleLocalNotification(notif)
    }
    
    func removeItem(_ item: NotificationItem) {
        let scheduledNotifications: [UILocalNotification]? = UIApplication.shared.scheduledLocalNotifications
        guard scheduledNotifications != nil else {return}
        
        for notification in scheduledNotifications! {
            if (notification.userInfo!["UUID"] as! String == item.UUID) {
                UIApplication.shared.cancelLocalNotification(notification)
                break
            }
        }
        
        if var notificationItems = UserDefaults.standard.dictionary(forKey: APP_KEY) {
            notificationItems.removeValue(forKey: item.UUID)
            UserDefaults.standard.set(notificationItems, forKey: APP_KEY)
        }

    }
    
    @discardableResult func clear() -> Bool {        
        UIApplication.shared.cancelAllLocalNotifications()

        if var notificationItems = UserDefaults.standard.dictionary(forKey: APP_KEY) {
            notificationItems = [:]
        }
        return true
    }
    
}
