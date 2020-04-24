//
//  AlertHelper.swift
//  OnTheMap
//
//  Created by Abdoulaye Diallo on 4/24/20.
//  Copyright © 2020 supergenedy. All rights reserved.
//

import Foundation
import UIKit

class AlertHelper {
    
    static func showMessage(view: UIViewController,title: String , error: String){
        let alert = UIAlertController(title: title, message: error, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        view.present(alert,animated: true, completion: nil)
    }
    
}
