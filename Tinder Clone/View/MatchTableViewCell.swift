//
//  MatchTableViewCell.swift
//  Tinder Clone
//
//  Created by Alex Wong on 8/18/17.
//  Copyright © 2017 Alex Wong. All rights reserved.
//

import UIKit
import Parse

class MatchTableViewCell: UITableViewCell {

    // MARK: - Properties
    
    var recipientObjectId = ""
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var messageTextField: UITextField!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var messageLabel: UILabel!
    
    // MARK: - View Lifecycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    // MARK: - IBActions

    @IBAction func sendTapped(_ sender: Any) {
        
        let message = PFObject(className: "Message")
        
        message["sender"] = PFUser.current()?.objectId
        message["recipient"] = recipientObjectId
        message["content"] = messageTextField.text
        message.saveInBackground()
    }
}
