//
//  FullscreenViewController.swift
//  BeautifyCamera-v1
//
//  Created by pro on 16/8/16.
//  Copyright © 2016年 MengXu. All rights reserved.
//

import UIKit
import Photos

class FullscreenViewController: UIViewController{
    
    
    var myAsset1: PHAsset!
    var myAsset2: PHAsset!
    var myAsset3: PHAsset!
    
    @IBOutlet weak var image11: UIImageView!
    
    @IBOutlet weak var image22: UIImageView!

    @IBOutlet weak var image33: UIImageView!
    
    @IBOutlet weak var image55: UIImageView!
    
   
 
    override func prefersStatusBarHidden() -> Bool {
        return true
        
    }
    
    override func viewWillAppear(animated: Bool) {
        self.navigationController?.navigationBarHidden = true
    }
    
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
                                                                self.image11.image = image
                                                                
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
                                                                self.image22.image = image
                                                                
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
                                                                self.image33.image = image
                                                                
        })
        

           }
    
    

    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
    
    
    
    @IBAction func finish(sender: AnyObject) {
        
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) {
            let image1 = self.image11.image
            let image2 = self.image22.image
            let image3 = self.image33.image
            
            
            let imageArray:[UIImage!] = [image1,image2,image3]
            
            let stitchedImage:UIImage = CVWrapper.processWithArray(imageArray) as UIImage
            
            dispatch_async(dispatch_get_main_queue(), {
                self.image55.image = stitchedImage
                
            })
            
        }
    }
    
    @IBAction func save(sender: AnyObject) {
        UIImageWriteToSavedPhotosAlbum(image55.image!, nil, nil, nil)
        dismissViewControllerAnimated(true, completion: nil)

    }
}
