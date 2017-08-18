//
//  UpdateViewController.swift
//  Tinder Clone
//
//  Created by Alex Wong on 8/17/17.
//  Copyright © 2017 Alex Wong. All rights reserved.
//

import UIKit
import Parse

class UpdateViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var userGenderSwitch: UISwitch!
    @IBOutlet weak var interestedGenderSwitch: UISwitch!
    @IBOutlet weak var errorLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        errorLabel.isHidden = true
        
        if let isFemale = PFUser.current()?["isFemale"] as? Bool {
            
            userGenderSwitch.setOn(isFemale, animated: false)
            
            
        }
        
        if let isInterestedInWomen = PFUser.current()?["isInterestedInWomen"] as? Bool {
            
            interestedGenderSwitch.setOn(isInterestedInWomen, animated: false)
            
            
        }
        
        if let photo = PFUser.current()?["photo"] as? PFFile{
            
            photo.getDataInBackground(block: { (data, error) in
                if let imageData = data{
                    
                    if let image = UIImage(data: imageData){
                        
                        self.profileImageView.image = image
                        
                        
                    }
                    
                }
            })
            
            
        }
        
        
    }


    @IBAction func updateProfileImage(_ sender: Any) {
        
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = false
        
        present(imagePicker, animated: true, completion: nil)
        
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage{
            
            profileImageView.image = image
     
        }
        dismiss(animated: true, completion: nil)
        
    }

    
    
    @IBAction func updateAll(_ sender: Any) {
        
        // time to save all the information to the parse server
        
        PFUser.current()?["isFemale"] = userGenderSwitch.isOn
        PFUser.current()?["isInterestedInWomen"] = interestedGenderSwitch.isOn
        
        if let image = profileImageView.image {
            
            
            if let imageData = UIImagePNGRepresentation(image){
                
                PFUser.current()?["photo"] = PFFile(name: "profile.png", data: imageData)
                
                PFUser.current()?.saveInBackground(block: { (success, error) in
                    if error != nil {
                        
                        var errorMessage = "Update failed - Try Again"
                        
                        if let newError = error as? NSError {
                            
                            if let detailError = newError.userInfo["error"] as? String{
                                
                                errorMessage = detailError
                                
                                
                            }
                            
                        }
                        
                        self.errorLabel.isHidden = false
                        self.errorLabel.text = errorMessage
                    } else {
                        
                        print("Update successful")
                        
                        self.performSegue(withIdentifier: "updateToSwipeSegue", sender: nil)
                        
                        
                    }
                })
                
            }
            
            
        }
        
        
        
        
        
    }
}
