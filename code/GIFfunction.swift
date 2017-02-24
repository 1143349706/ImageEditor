//
//  GIFfunction.swift
//  BeautifyCamera-v1
//
//  Created by pro on 16/7/30.
//  Copyright © 2016年 MengXu. All rights reserved.
//

import UIKit
import Photos


class GIFfunction: UIViewController{
    var myAsset3: PHAsset!
    var myAsset2: PHAsset!
       var myAsset1: PHAsset!
    var myAsset4 : PHAsset!
    var myAsset5 : PHAsset!
    @IBOutlet weak var gif: UIButton!
    @IBOutlet weak var image1: UIImageView!
    @IBOutlet weak var image2: UIImageView!
    @IBOutlet weak var image3: UIImageView!
    @IBOutlet weak var image4: UIImageView!
    @IBOutlet weak var image5: UIImageView!
    
    @IBOutlet weak var gifimage: UIImageView!
  
    
    
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    override func viewWillAppear(animated: Bool) {
        self.navigationController?.navigationBarHidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        image1.layer.masksToBounds = true;
        image1.layer.cornerRadius = 10
        image2.layer.masksToBounds = true;
        image2.layer.cornerRadius = 10
        image3.layer.masksToBounds = true;
        image3.layer.cornerRadius = 10
        image4.layer.masksToBounds = true;
        image4.layer.cornerRadius = 10
        image5.layer.masksToBounds = true;
        image5.layer.cornerRadius = 10
        gifimage.layer.masksToBounds = true;
        gifimage.layer.cornerRadius = 10
        self.image1.layer.borderWidth = 3
        self.image1.layer.borderColor = UIColor.brownColor().CGColor
        self.image2.layer.borderWidth = 3
        self.image2.layer.borderColor = UIColor.redColor().CGColor
        self.image3.layer.borderWidth = 3
        self.image3.layer.borderColor = UIColor.cyanColor().CGColor
        self.image4.layer.borderWidth = 3
        self.image4.layer.borderColor = UIColor.greenColor().CGColor
        
        self.image5.layer.borderWidth = 3
        self.image5.layer.borderColor = UIColor.yellowColor().CGColor
      
        
        
        
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
        PHImageManager.defaultManager().requestImageDataForAsset(myAsset2, options: nil,
                                                                 resultHandler: {
                                                                    _, _, _, info in
                                                                    self.title = (info!["PHImageFileURLKey"] as! NSURL).lastPathComponent
        })
        
        PHImageManager.defaultManager().requestImageForAsset(myAsset2,
                                                             targetSize: PHImageManagerMaximumSize , contentMode: . Default,
                                                             options: nil, resultHandler: {
                                                                (image, _: [NSObject : AnyObject]?) in
                                                                self.image2.image = image
                                                                
        })
        PHImageManager.defaultManager().requestImageDataForAsset(myAsset3, options: nil,
                                                                 resultHandler: {
                                                                    _, _, _, info in
                                                                    self.title = (info!["PHImageFileURLKey"] as! NSURL).lastPathComponent
        })
        
        PHImageManager.defaultManager().requestImageForAsset(myAsset3,
                                                             targetSize: PHImageManagerMaximumSize , contentMode: . Default,
                                                             options: nil, resultHandler: {
                                                                (image, _: [NSObject : AnyObject]?) in
                                                                self.image3.image = image
                                                                
        })
        
        PHImageManager.defaultManager().requestImageDataForAsset(myAsset4, options: nil,
                                                                 resultHandler: {
                                                                    _, _, _, info in
                                                                    self.title = (info!["PHImageFileURLKey"] as! NSURL).lastPathComponent
        })
        
        PHImageManager.defaultManager().requestImageForAsset(myAsset4,
                                                             targetSize: PHImageManagerMaximumSize , contentMode: . Default,
                                                             options: nil, resultHandler: {
                                                                (image, _: [NSObject : AnyObject]?) in
                                                                self.image4.image = image
                                                                
        })

        
        PHImageManager.defaultManager().requestImageDataForAsset(myAsset5, options: nil,
                                                                 resultHandler: {
                                                                    _, _, _, info in
                                                                    self.title = (info!["PHImageFileURLKey"] as! NSURL).lastPathComponent
        })
        
        PHImageManager.defaultManager().requestImageForAsset(myAsset5,
                                                             targetSize: PHImageManagerMaximumSize , contentMode: . Default,
                                                             options: nil, resultHandler: {
                                                                (image, _: [NSObject : AnyObject]?) in
                                                                self.image5.image = image
                                                                
        })



    }
    
 
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


       
    
    @IBAction func createGIf(sender: AnyObject) {
        self.gifimage.animationImages=[image1.image!,image2.image!,image3.image!,image4.image!,image5.image!]
       
        
        
        self.gifimage.layer.borderWidth = 3
        self.gifimage.layer.borderColor = UIColor.purpleColor().CGColor
        self.gifimage.animationDuration=3.0
        self.gifimage.startAnimating()
    }
    
}
