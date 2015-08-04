//
//  ViewController.swift
//  Where am I
//
//  Created by Bojie Jiang on 8/4/15.
//  Copyright © 2015 Bojie Jiang. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {
    
    var manager:CLLocationManager!
    
    @IBOutlet weak var latitudeLabel: UILabel!
    
    @IBOutlet weak var longitudeLabel: UILabel!
    
    
    @IBOutlet weak var speedLabel: UILabel!
    
    @IBOutlet weak var altitudeLabel: UILabel!
    
    @IBOutlet weak var courseLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        manager = CLLocationManager()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print(locations)
        
        let userLocation = locations[0]
        
        self.latitudeLabel.text =  "\(userLocation.coordinate.latitude)"
        self.longitudeLabel.text =  "\(userLocation.coordinate.longitude)"
        self.courseLabel.text = "\(userLocation.course)"
        self.speedLabel.text = "\(userLocation.speed)"
        self.altitudeLabel.text = "\(userLocation.altitude)"
        
        CLGeocoder().reverseGeocodeLocation(userLocation) { (placemarks, error) -> Void in
            if (error != nil) {
                print(error)
            } else {
                if let placeMarks = placemarks as [CLPlacemark]!{
                    let p:CLPlacemark = placeMarks[0]
                    
                    var subThoroughfare:String = ""
                    var subLocality:String = ""
                    var thoroughfare:String = ""
                    var subAdministrativeArea:String = ""
                    var postalCode:String = ""
                    var country:String = ""
                    
                    if p.subThoroughfare != nil{
                        subThoroughfare = p.subThoroughfare!
                    }
                    
                    if p.subLocality != nil{
                        subLocality = p.subLocality!
                    }
                    if p.thoroughfare != nil{
                        thoroughfare = p.thoroughfare!
                    }
                    if p.subAdministrativeArea != nil{
                        subAdministrativeArea = p.subAdministrativeArea!
                    }
                    if p.postalCode != nil{
                        postalCode = p.postalCode!
                    }
                    if p.country != nil{
                        country = p.country!
                    }
                    self.addressLabel.text = "\(subThoroughfare) \(thoroughfare) \n \(subLocality)\(subAdministrativeArea)\n\(postalCode)\n\(country)"
                }
                
                
            }
        }
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

