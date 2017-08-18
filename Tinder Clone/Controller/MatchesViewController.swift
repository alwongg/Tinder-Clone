//
//  MatchesViewController.swift
//  Tinder Clone
//
//  Created by Alex Wong on 8/18/17.
//  Copyright © 2017 Alex Wong. All rights reserved.
//

import UIKit
import Parse

class MatchesViewController: UIViewController {
    
    var images: [UIImage] = []
    var userIds: [String] = []
    var messages: [String] = []
    
    @IBAction func backTapped(_ sender: Any) {
        
        dismiss(animated: true, completion: nil)
    }
    
    @IBOutlet weak var tableView: UITableView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        if let query = PFUser.query(){
            
            query.whereKey("accepted", contains: PFUser.current()?.objectId)
            
            if let acceptedPeeps = PFUser.current()?["accepted"] as? [String]{
                query.whereKey("objectId", containedIn: acceptedPeeps)
                
                
                query.findObjectsInBackground(block: { (objects, error) in
                    if let users = objects {
                        
                        for user in users {
                            
                            if let theUser = user as? PFUser{
                                
                                if let imageFile = theUser["photo"] as? PFFile {
                                    
                                    imageFile.getDataInBackground(block: { (data, error) in
                                        if let imageData = data {
                                            
                                            if let image = UIImage(data: imageData){
                                                
                                                
                                                if let objectId = theUser.objectId{
                                                    
                                                    let messagesQuery = PFQuery(className: "Message")
                                                    
                                                    
                                                    
                                                    messagesQuery.whereKey("recipient", equalTo: PFUser.current()?.objectId as Any)
                                                    messagesQuery.whereKey("sender", equalTo: theUser.objectId as Any)
                                                    
                                                    messagesQuery.findObjectsInBackground(block: { (objects, error) in
                                                        var messageText = "No message from this user."
                                                        if let objects = objects {
                                                            
                                                            for message in objects {
                                                                
                                                                if let content = message["content"] as? String {
                                                                    
                                                                    messageText = content
                                                                    
                                                                }
                                                                
                                                                
                                                            }
                                                            
                                                        }
                                                        self.messages.append(messageText)
                                                        self.userIds.append(objectId)
                                                        self.images.append(image)
                                                        self.tableView.reloadData()
                                                        
                                                    })
                                                    
                                                }
                                            }
                                        }
                                    })
                                    
                                }
                                
                            }
                        }
                        
                        
                    }
                })
            }
        }
        
    }
    
    
}

extension MatchesViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return images.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "MatchCell", for: indexPath) as? MatchTableViewCell{
            cell.messageLabel.text = "You haven't received a message yet"
            cell.profileImageView.image = images[indexPath.row]
            cell.recipientObjectId = userIds[indexPath.row]
            cell.messageLabel.text = messages[indexPath.row]
            return cell
            
        }
        
        
        
        return UITableViewCell()
        
        
    }
    
}
