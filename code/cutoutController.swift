//
//  cutoutController.swift
//  BeautifyCamera-v1
//
//  Created by pro on 16/8/21.
//  Copyright © 2016年 MengXu. All rights reserved.
//

import UIKit
import Photos



class cutoutController: UIViewController, UIImagePickerControllerDelegate,
UINavigationControllerDelegate {
    
    @IBOutlet weak var image1: UIImageView!

    @IBOutlet weak var blurview: UIView!
    @IBOutlet weak var greenview: UIView!
    
    var min : Float!
    var max : Float!
    var bkgimage : UIImage!
    var outputImage : CIImage!
    var myAsset1: PHAsset!
      var context: CIContext = {
        return CIContext(options: nil)
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        PHImageManager.defaultManager().requestImageDataForAsset(myAsset1, options: nil,
                                                                 resultHandler: {
                                                                    _, _, _, info in
                                                                    self.title = (info!["PHImageFileURLKey"] as! NSURL).lastPathComponent
        })
        
        PHImageManager.defaultManager().requestImageForAsset(myAsset1,
                                                             targetSize: PHImageManagerMaximumSize , contentMode: . Default,
                                                             options: nil, resultHandler: {
                                                                (image, _: [NSObject : AnyObject]?) in
                                                                self.image1.image = image
                                                                
        })
        
        
     
          }
    
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
  

    
    
    override func viewWillAppear(animated: Bool) {
        self.navigationController?.navigationBarHidden = true
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
  

    @IBAction func bluebkg(sender: AnyObject) {
        min = 180
        max = 240
        blurview.backgroundColor = UIColor.redColor()
         greenview.backgroundColor = UIColor.whiteColor()
    }

    @IBAction func greenbkg(sender: AnyObject) {
        min = 65
        max = 160
         greenview.backgroundColor = UIColor.redColor()
        blurview.backgroundColor = UIColor.whiteColor()

    }
 
 
    

    @IBAction func background(sender: AnyObject) {
        let cubeMap = createCubeMap(min,max)
        let data = NSData(bytesNoCopy: cubeMap.data, length: Int(cubeMap.length),
                          freeWhenDone: true)
        
        //clear blue
        let colorCubeFilter = CIFilter(name: "CIColorCube")!
        colorCubeFilter.setValue(cubeMap.dimension, forKey: "inputCubeDimension")
        colorCubeFilter.setValue(data, forKey: "inputCubeData")
        colorCubeFilter.setValue(CIImage(image: image1.image! ), forKey: kCIInputImageKey)
        outputImage = colorCubeFilter.outputImage
        
        //merge with bkg
        let sourceOverCompositingFilter = CIFilter(name: "CISourceOverCompositing")!
        sourceOverCompositingFilter.setValue(outputImage, forKey: kCIInputImageKey)
        
        UIGraphicsBeginImageContext(UIImage(CIImage: outputImage!).size)
        bkgimage?.drawInRect(CGRect(x: 0, y: 0, width: UIImage(CIImage: outputImage!).size.width, height: UIImage(CIImage: outputImage!).size.height))
        
        let imagel: UIImage = UIGraphicsGetImageFromCurrentImageContext()
        sourceOverCompositingFilter.setValue(CIImage(image: imagel),
                                             forKey: kCIInputBackgroundImageKey)
        let outputImage1 = sourceOverCompositingFilter.outputImage
        
        let cgImage = context.createCGImage(outputImage1!, fromRect: outputImage1!.extent)
        image1.image = UIImage(CGImage: cgImage)
        
    }
    
    @IBAction func bkg1(sender: AnyObject) {
        bkgimage = UIImage(named: "bk1.jpg")
        
    }
    
    @IBAction func bkg2(sender: AnyObject) {
         bkgimage = UIImage(named: "bkg2.jpg")
    }

    @IBAction func bkg3(sender: AnyObject) {
         bkgimage = UIImage(named: "bkg3.jpeg")
    }
    @IBAction func bkg4(sender: AnyObject) {
         bkgimage = UIImage(named: "bkg4.jpeg")
    }
    @IBAction func bkg5(sender: AnyObject) {
         bkgimage = UIImage(named: "bkg5.jpeg")
    }
    
    @IBAction func save(sender: AnyObject) {
        UIImageWriteToSavedPhotosAlbum(image1.image!, nil, nil, nil)
        dismissViewControllerAnimated(true, completion: nil)

    }
    
    @IBAction func clear(sender: AnyObject) {
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
    
    func imagePickerController(picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        
        
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        
        let fixOrientationImage = image.fixOrientation()
        bkgimage = fixOrientationImage
        
        picker.dismissViewControllerAnimated(true, completion: {
            () -> Void in
        })
    }
   



}
