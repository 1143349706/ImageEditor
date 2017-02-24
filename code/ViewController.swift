//
//  ViewController.swift
//  BeautifyCamera-v1
//
//  Created by pro on 16/6/19.
//  Copyright © 2016年 MengXu. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate,
UINavigationControllerDelegate{
    var img : UIImage!
 
    @IBOutlet weak var camera: UIButton!
    @IBOutlet weak var puzzle: UIButton!
    @IBOutlet weak var gif: UIButton!
    @IBOutlet weak var fullscreen: UIButton!
    @IBOutlet weak var merge: UIButton!
    @IBOutlet weak var photo: UIButton!
    
    
    
    
    @IBOutlet weak var hide: UIView!
    @IBOutlet weak var toolbar: UIToolbar!

    @IBOutlet weak var button7: UIButton!
    @IBOutlet weak var button8: UIButton!
  
    
    @IBOutlet weak var showImage: UIImageView!
    /*
    @IBAction func cameraBT(sender: AnyObject) {
        
        hide.hidden = false
        button7.hidden = false
        button8.hidden = false
        
        toolbar.hidden = false
      
        
        if UIImagePickerController.isSourceTypeAvailable(.Camera){
            
             let cameraPicker = UIImagePickerController()
        
             cameraPicker.delegate = self
           
             cameraPicker.sourceType = UIImagePickerControllerSourceType.Camera
      // front camera or back, default back
            if UIImagePickerController.isCameraDeviceAvailable(UIImagePickerControllerCameraDevice.Front){
                cameraPicker.cameraDevice = UIImagePickerControllerCameraDevice.Rear
                
            }
     // flash mode , default off
            cameraPicker.cameraFlashMode = UIImagePickerControllerCameraFlashMode.Off
            
            
            self.presentViewController(cameraPicker, animated: true, completion: { () -> Void in
                
            })
        }
        
         else{
            print("no camera, error!")
        }

    }
    */

    // get image from the photo gallery(default)
    @IBAction func imageBT(sender: AnyObject) {
         hide.hidden = false
        button7.hidden = false
        button8.hidden = false
        camera.hidden = true
        puzzle.hidden = true
        gif.hidden = true
        fullscreen.hidden = true
        photo.hidden = true
        merge.hidden = true
        
        toolbar.hidden = false
        if UIImagePickerController.isSourceTypeAvailable(.PhotoLibrary){
           
            let imagePicker = UIImagePickerController()
            
            imagePicker.delegate = self
          
            imagePicker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
           
            self.presentViewController(imagePicker, animated: true, completion: {
                () -> Void in
            })
        }else{
            print("error!")
        }
        

            }

    // present controller, whether it come from the camera or the photo gallery
    func imagePickerController(picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        
        
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        
         let fixOrientationImage = image.fixOrientation()
        showImage.image = fixOrientationImage
        
        picker.dismissViewControllerAnimated(true, completion: {
            () -> Void in
        })
    }
  
   
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
       
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hide.hidden = true
        
        button7.hidden = true
        button8.hidden = true
        
       
        
         toolbar.hidden = true
         self.navigationController?.navigationBarHidden = true
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    override func viewWillAppear(animated: Bool) {
        self.navigationController?.navigationBarHidden = true
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "showImage" {
            
            let controller = segue.destinationViewController as! imageController
            
            controller.image = showImage.image
            controller.showori = showImage.image
            
        }
        
        
       
    }
    
    
    @IBAction func back(sender: AnyObject) {
        hide.hidden = true
        button7.hidden = true
        button8.hidden = true
        toolbar.hidden = true
        camera.hidden = false
        puzzle.hidden = false
        gif.hidden = false
        fullscreen.hidden = false
        photo.hidden = false
        merge.hidden = false
      
    }
    
    
        
   

        
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
}

