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

class ViewController: UIViewController,CameraViewControllerProtocol {
    
    var photo = UIImage.init(named: "ParkingPhoto")
    
    
    @IBOutlet var mapView: MKMapView!
    
    
    @IBOutlet weak var imageView: UIImageView!
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func Pin(_ sender: Any) {
        print("add pin button hit")
    }
    

    @IBAction func stop(_ sender: Any) {
         print("delete pin button hit")
    }
    
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

