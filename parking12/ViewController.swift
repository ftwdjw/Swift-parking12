//
//  ViewController.swift
//  parking12
//
//  Created by John Mac on 12/15/16.
//  Copyright © 2016 John Wetters. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class ViewController: UIViewController,CameraViewControllerProtocol, CLLocationManagerDelegate, MKMapViewDelegate{
    
    //this is for the camera alert
    var opQueue = OperationQueue()
    
    var photo = UIImage.init(named: "ParkingPhoto")
    
    var count = 0
    var dropPin=false
    let annotation = MKPointAnnotation()
    
    
    @IBOutlet var mapView: MKMapView!
    
    
    @IBOutlet weak var imageView: UIImageView!
    
    lazy var locationManager : CLLocationManager = {
        
        let loc = CLLocationManager()
        
        //Set up location manager with defaults
        loc.desiredAccuracy = kCLLocationAccuracyBest
        loc.distanceFilter = kCLDistanceFilterNone
        loc.delegate = self
        
        //Optimisation of battery
        loc.pausesLocationUpdatesAutomatically = true
        loc.activityType = CLActivityType.fitness
        loc.allowsBackgroundLocationUpdates = false
        print("set location manager")
        
        return loc
    }()
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        locationManager.requestAlwaysAuthorization()
        //Map
        mapView.showsUserLocation = true
        mapView.mapType = MKMapType.hybrid
        //mapView.userTrackingMode = .follow
        mapView.showsTraffic = true
        mapView.delegate = self
        self.locationManager.startUpdatingLocation()
        print("start location manager")
        
        
        imageView.image=photo

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func Pin(_ sender: Any) {
        print("add pin button hit")
        dropPin=true
        print("drop pin")
        //performSegueWithIdentifier("mySegueID", sender: nil)
        let tapAlert = UIAlertController(title: "Parking Location Picture" , message: "press Camera button if you want a picture of your parking location", preferredStyle: UIAlertControllerStyle.alert)
        tapAlert.addAction(UIAlertAction(title: "OK", style: .destructive, handler: nil))
        self.present(tapAlert, animated: true, completion: nil)
        
        
        
         //performSegue(withIdentifier: "goToCamera", sender: nil)
        
        
    }
    
    func goToSegue(){
        performSegue(withIdentifier: "goToCamera", sender: nil)

    }
    

    @IBAction func stop(_ sender: Any) {
         print("delete pin button hit")
        dropPin=false
        mapView.removeAnnotations([annotation])
        print("remove pin")
    }
    
    
    
    // MARK: - Location Delegate Methods
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation])
    {
        let location = locations.last
        count += 1
        
        print("update last location \(count)")
        
        let center = CLLocationCoordinate2D(latitude: location!.coordinate.latitude, longitude: location!.coordinate.longitude)
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
        
        self.mapView.setRegion(region, animated: true)
        
        //self.locationManager.stopUpdatingLocation()
        
        //add annotation
        if dropPin==true{
            annotation.title = "My Parking Location"
            annotation.coordinate = center
            mapView.addAnnotation(annotation)
            dropPin=false
            
        }
        
        
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error)
    {
        print("Error: " + error.localizedDescription)
    }
    
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        
        if status == CLAuthorizationStatus.authorizedAlways {
            mapView.showsUserLocation = true
            //mapView.userTrackingMode = MKUserTrackingMode.follow
        } else {
            print("Permission Refused")
        }
    }
    
    //MARK: - Segue
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "goToCamera" {
            
            if let vc = segue.destination as? CameraViewController {
                vc.delegate = self
                print("segue done")
            }
            
        }
        
    }


    
    func dismissWithImage(_ image: UIImage) {
        self.dismiss(animated: true) {
            self.imageView.image = image
            print("dismiss with image done")
        }
        
    }

}

