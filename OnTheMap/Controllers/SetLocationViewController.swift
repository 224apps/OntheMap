//
//  SetLocationViewController.swift
//  OnTheMap
//
//  Created by Abdoulaye Diallo on 4/24/20.
//  Copyright © 2020 supergenedy. All rights reserved.
//

import UIKit
import MapKit

class SetLocationViewController: UIViewController {
    
    @IBOutlet weak var mapView: MKMapView!
    
    var objectID: String = ""
    var userKey: String = ""
    var location: String = ""
    var url: String = ""
    
    var lat: Double? = nil
    var lng: Double? = nil
    
    var coordinates: CLLocationCoordinate2D? = CLLocationCoordinate2D()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        CLGeocoder().geocodeAddressString(location) {
            placemarks, error in
            
            if error != nil {
                AlertHelper.showMessage(view: self, title: "Oops", error: "Can't find your location")
                return
            }
            
            guard let placemark = placemarks?.first
                else {
                    return
            }
            
            self.lat = (placemark.location?.coordinate.latitude)!
            self.lng = (placemark.location?.coordinate.longitude)!
            
            let span = MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2)
            let region = MKCoordinateRegion(center: placemark.location!.coordinate, span: span)
            
            let annotation = MKPointAnnotation()
            annotation.coordinate = placemark.location!.coordinate
            annotation.title = self.location
            annotation.subtitle = self.url
            
            self.mapView.addAnnotation(annotation)
            self.mapView.setRegion(region, animated: true)

        }
        
    }

    @IBAction func finishButton(_ sender: Any) {
        if lat == nil || lng == nil {
            AlertHelper.showMessage(view: self, title: "Oops", error: "Couldn't find your location")
        }
        else {
            AuthClient().getUserPublicData(userID: userKey) {
                first,last,error in
                DispatchQueue.main.async {
                    StudentsClient().postUpdateStudentLocation(objectId: self.objectID , key: self.userKey, firstName: first ?? "Ahmed", lastName: last ?? "Sayed", mapString: self.location, url: self.url, lat: self.lat!, lng: self.lng!) {
                        isCompleted,error in
                        
                        DispatchQueue.main.async {
                            if error != nil {
                                AlertHelper.showMessage(view: self, title: "Error", error:  error!.localizedDescription)
                                return
                            }
                            self.navigationController?.dismiss(animated: true, completion: nil)
                        }
                    }
                    
                }
            }
            
        }
        
    }
    
}
