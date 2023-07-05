//
//  TreasureBox.swift
//  LocalPushNotificationDemo
//
//  Created by kimleak on 2023/06/21.
//

import Foundation
import UserNotifications

struct TreasureBox {
    let id:String //Unique identifier
    let name:String //Name of the treasure box
    let duration:Int //Total seconds before box opens (10 seconds)
    let reward:String //Reward of treasure box (200 Gold)
    
    ///Schedules UserNotification for treasure.
        func scheduleTreasureLocalNotification(){
            //First create notification content
            let notificationContent = UNMutableNotificationContent()
            notificationContent.title = self.name + " is opened"
            notificationContent.subtitle = "Launch app to collect \(self.reward)"
            notificationContent.sound = UNNotificationSound.default
            
            // show this notification treasurebox duration from now (in seconds)
            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: TimeInterval(self.duration), repeats: false)
            
            // Use treasurebox identifier as identifier
            let request = UNNotificationRequest(identifier: self.id, content: notificationContent, trigger: trigger)
            
            // add our notification request
            UNUserNotificationCenter.current().add(request)
        }
    
}

struct Player{
    let userName:String //Unique username to identify player
    var userHasAuthorizedNotification:Bool //User granted notification permission
    var availableTreasures:[TreasureBox] //Returns available treasures
}
