//
//  CameraViewController.swift
//  parking12
//
//  Created by John Mac on 12/15/16.
//  Copyright © 2016 John Wetters. All rights reserved.
//

import UIKit

protocol CameraViewControllerProtocol : class {
    //func dismissWithStringData(_ str : String)
    func dismissWithImage(_ image : UIImage)
}


class CameraViewController: UIViewController {
    
    var photo = UIImage.init(named: "ParkingPhoto")
    
         weak var delegate : CameraViewControllerProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    
    @IBAction func Camera(_ sender: Any) {
        print("camera button hit")
    }
    
    
    @IBAction func Library(_ sender: Any) {
        print("Library button hit")
    }
    
    
    @IBAction func Save(_ sender: Any) {
        print("Save button hit")
    }
    
    @IBAction func doDismiss(_ sender: AnyObject) {
        
        print("back button hit")
        
        //count += 1
        //delegate?.dismissWithStringData("Message from DEMO 1 count=\(count)")
        delegate?.dismissWithImage(photo!)
    }

    

}
