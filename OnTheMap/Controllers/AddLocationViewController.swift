//
//  AddLocationViewController.swift
//  OnTheMap
//
//  Created by Abdoulaye Diallo on 4/24/20.
//  Copyright © 2020 supergenedy. All rights reserved.
//

import UIKit

class AddLocationViewController: UIViewController, UITextFieldDelegate{

    @IBOutlet weak var locationTextFiled: UITextField!
    @IBOutlet weak var linkTextField: UITextField!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var objectID: String = ""
    var userKey: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicator.isHidden = true
        locationTextFiled.delegate = self
        linkTextField.delegate = self
        
        userKey = UserDefaults.standard.string(forKey: "user_key")!
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        StudentsClient().getStudentsLocations(studentKey: userKey) { locationList, error  in
            DispatchQueue.main.async {
                if error != nil {
                    return
                } else {
                    if locationList != nil && locationList!.count > 0 {
                        self.objectID = locationList![0].objectId
                    }
                }
            }
        }
    }

    @IBAction func finLocationButton(_ sender: Any) {
        if locationTextFiled.text!.isEmpty {
            AlertHelper.showMessage(view: self, title: "Oops", error: "Please enter location")
        } else if linkTextField.text!.isEmpty {
            AlertHelper.showMessage(view: self, title: "Oops", error: "Please enter your link")
        } else {
            self.activityIndicator.isHidden = false
            self.activityIndicator.startAnimating()
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            let next = self.storyboard?.instantiateViewController(withIdentifier: "LocationPostingView") as! SetLocationViewController
                next.objectID = self.objectID
                next.userKey = self.userKey
                next.location = self.locationTextFiled.text!
                next.url = self.linkTextField.text!
            self.navigationController?.pushViewController(next, animated: true)
            }
        }
    }
    
    @IBAction func cancelButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool{
        textField.resignFirstResponder()
        return true
    }
    
}
