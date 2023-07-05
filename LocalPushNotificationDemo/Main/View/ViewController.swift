//
//  ViewController.swift
//  LocalPushNotificationDemo
//
//  Created by kimleak on 2023/06/21.
//

import UIKit

class ViewCotroller : UIViewController {
    
    var player:Player!{
           didSet{
               //Control if player is Authorized
               if player.userHasAuthorizedNotification == true{
                   //Schedule players treasures notifications available
                   for treasure in player.availableTreasures{
                       //Trigger
                       treasure.scheduleTreasureLocalNotification()
                   }
               }
           }
       }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        ///Lets create our player (Pre defined fields entered static)
        //Initially user has no available treasure
        self.player = Player(userName: "TreasureHunter", userHasAuthorizedNotification: false, availableTreasures: [])
        
        //Lets ask for notification permission
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.registerForRemoteNotification(completion: { (permissionGranted) in
            //Manipulate our player "userHasAuthorizedNotification variable with using @escaping result
            self.player.userHasAuthorizedNotification = permissionGranted
        })
        
        //Then create our Treasures
        let goldTreasureBox = createDummyTreasureBox(name: "Gold Treasure Box", duration: 2, reward: "20 Gold")
        let expTreasureBox = createDummyTreasureBox(name: "Exp Treasure Box",duration: 20, reward:"100 Exp")
        
        //User gathers treasures
        player.availableTreasures.append(goldTreasureBox)
        player.availableTreasures.append(expTreasureBox)
    }
    ///Creates TreasureBox by given values and returns
    func createDummyTreasureBox(name:String,duration:Int,reward:String) -> TreasureBox{
        let uuid = UUID().uuidString // Create unique UUID for id
        return TreasureBox(id: uuid, name: name, duration: duration, reward: reward)
    }
    
 

}


