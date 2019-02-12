//
//  ViewController.swift
//  HelloNotification
//
//  Created by Yuuki Nishiyama on 2019/02/10.
//  Copyright © 2019 Yuuki Nishiyama. All rights reserved.
//

import UIKit
import UserNotifications

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let sampleValue = 1234
        let sampleKey   = "sampleKey"
        
        let userDefaults = UserDefaults.standard
        
        // set value
        userDefaults.set(sampleValue, forKey: sampleKey)
        
        // get value
        let value = userDefaults.integer(forKey: sampleKey)
        print(value)
        
    }

    @IBAction func authorize(_ sender: Any) {
        
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.alert, .sound, .badge]) { (granted, error) in
            if granted {
                print("Authorized")
            }else{
                print("Not Authorized")
            }
        }
        
    }
    
    
    @IBAction func sendOneTimeNotification(_ sender: Any) {
        let content = UNMutableNotificationContent()
        content.title = "One Time Notification"
        content.body  = "Hello World!"
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5,
                                                        repeats: false)
        
        let uuidString = UUID().uuidString
        let request = UNNotificationRequest(identifier: uuidString,
                                            content: content,
                                            trigger: trigger)
        
        let notificationCenter = UNUserNotificationCenter.current()
        notificationCenter.add(request) { (error) in
            
        }
    }
    
    
    @IBAction func sendRepeatNotification(_ sender: Any) {
        let content = UNMutableNotificationContent()
        content.title = "Repeat Notification"
        content.body  = "Hello World!"
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 60,
                                                        repeats: true)
        
        let uuidString = UUID().uuidString
        let request = UNNotificationRequest(identifier: uuidString,
                                            content: content,
                                            trigger: trigger)
        
        let notificationCenter = UNUserNotificationCenter.current()
        notificationCenter.add(request) { (error) in
            
        }
    }
    
    
    @IBAction func setScheduledNotification(_ sender: Any) {
        
        let content = UNMutableNotificationContent()
        content.title = "This is title"
        content.body  = "This is body"
        
        var dateComponents = DateComponents()
        dateComponents.calendar = Calendar.current
        dateComponents.hour = 13
        dateComponents.minute = 0
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents,
                                                    repeats: true)

        let uuidString = UUID().uuidString
        let request = UNNotificationRequest(identifier: uuidString,
                                            content: content,
                                            trigger: trigger)
        
        let notificationCenter = UNUserNotificationCenter.current()
        notificationCenter.add(request) { (error) in
            
        }
    }
    
    
    
    @IBAction func showAllPendingNotifications(_ sender: Any) {
        
        let notificationCenter = UNUserNotificationCenter.current()
        notificationCenter.getPendingNotificationRequests { (notificationRequests) in
            for notificationRequest in notificationRequests {
                print(notificationRequest.identifier)
            }
        }
        
    }
    
    @IBAction func showAllDeliveredNotifications(_ sender: Any) {
        
        let notificationCenter = UNUserNotificationCenter.current()
        notificationCenter.getDeliveredNotifications { (notifications) in
            for notification in notifications {
                print(notification)
            }
        }
        
    }
    
    @IBAction func removeAllPendingNotifications(_ sender: Any) {
        
        let notificationCenter = UNUserNotificationCenter.current()
        notificationCenter.removeAllPendingNotificationRequests()
    }

    
    @IBAction func removeAllDeliveredNotifications(_ sender: Any) {
        
        let notificationCenter = UNUserNotificationCenter.current()
        notificationCenter.removeAllDeliveredNotifications()
        
    }
    
}

