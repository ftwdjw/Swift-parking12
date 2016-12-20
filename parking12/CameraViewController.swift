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


class CameraViewController: UIViewController,UIImagePickerControllerDelegate,
UINavigationControllerDelegate{
    
    
    //this is for the camera alert
    var opQueue = OperationQueue()
    
    //initialize the alert Class
    //let alertSend = AlertClass()
    
    
    
    
    @IBOutlet weak var imageView: UIImageView!
    
    
    var photo = UIImage.init(named: "picasso1")
    
     let picker = UIImagePickerController()
    
         weak var delegate : CameraViewControllerProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        picker.delegate = self
        
        imageView.image=photo
        
        //alert for camera
        
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            print("camera available")
            picker.allowsEditing = false
            picker.sourceType = UIImagePickerControllerSourceType.camera
            picker.cameraCaptureMode = .photo
            picker.modalPresentationStyle = .fullScreen
            present(picker,animated: true,completion: nil)
            
            self.opQueue.addOperation {//start1
                // Put queue to the main thread which will update the UI
                OperationQueue.main.addOperation({//start
                    self.present(self.picker, animated: true, completion: nil)
                })//end
            }//end1

            
        } else {
            
            print("no camera")
            let alert = UIAlertController(title: "No Camera", message: "Sorry, this device has no camera", preferredStyle: UIAlertControllerStyle.alert)
            // add an action (button, we can add more than 1 buttons)
            
            
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            // show the alert
            self.opQueue.addOperation {//start1
                // Put queue to the main thread which will update the UI
                OperationQueue.main.addOperation({//start
                    self.present(alert, animated: true, completion: nil)
                })//end
            }//end1


        }
        
    
        
            }//end view did load

    

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
        print("camera button hit")
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            picker.allowsEditing = false
            picker.sourceType = UIImagePickerControllerSourceType.camera
            picker.cameraCaptureMode = .photo
            picker.modalPresentationStyle = .fullScreen
            present(picker,animated: true,completion: nil)
        } else {
            print("no camera")
        
        }

    }
    
    
    @IBAction func Library(_ sender: Any) {
        print("Library button hit")
        print("library button hit")
        
        picker.allowsEditing = false
        picker.sourceType = .photoLibrary
        picker.mediaTypes = UIImagePickerController.availableMediaTypes(for: .photoLibrary)!
        picker.modalPresentationStyle = .popover
        present(picker, animated: true, completion: nil)
        //picker.popoverPresentationController?.barButtonItem = sender
    }
    
    
    @IBAction func Save(_ sender: Any) {
        print("Save button hit")
        print("save button hit")
        
        let imageData = UIImageJPEGRepresentation(imageView.image!, 0.6)
        let compressedJPGImage = UIImage(data: imageData!)
        UIImageWriteToSavedPhotosAlbum(compressedJPGImage!, nil, nil, nil)
        
        //        let alert = UIAlertView(title: "Wow",
        //                                message: "Your image has been saved to Photo Library!",
        //                                delegate: nil,
        //                                cancelButtonTitle: "Ok")
        //                                alert.show()
        
        let tapAlert = UIAlertController(title: "Wow", message: "Your image has been saved to Photo Library!", preferredStyle: UIAlertControllerStyle.alert)
        tapAlert.addAction(UIAlertAction(title: "OK", style: .destructive, handler: nil))
        self.present(tapAlert, animated: true, completion: nil)

    }
    
    @IBAction func doDismiss(_ sender: AnyObject) {
        
        print("back button hit")
        
        //count += 1
        //delegate?.dismissWithStringData("Message from DEMO 1 count=\(count)")
        delegate?.dismissWithImage(imageView.image!)
    }
    
    //MARK: - No Camera
    
    
    //MARK: - Delegates
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        //        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject])
        //        {
        var  chosenImage = UIImage()
        chosenImage = info[UIImagePickerControllerOriginalImage] as! UIImage //2
        imageView.contentMode = .scaleAspectFit //3
        imageView.image = chosenImage //4
        dismiss(animated:true, completion: nil) //5
    }
    
    
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }



    

}
