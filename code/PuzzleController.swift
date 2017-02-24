//
//  PuzzleController.swift
//  BeautifyCamera-v1
//
//  Created by pro on 16/8/13.
//  Copyright © 2016年 MengXu. All rights reserved.
//

import UIKit
import Photos


class PuzzleController: UIViewController{
    
    
    
    var myAsset2: PHAsset!
    var myAsset1: PHAsset!

  
    @IBOutlet weak var hide1: UIView!
    @IBOutlet weak var imageshow: UIView!

    @IBOutlet weak var beijing: UIImageView!
    @IBOutlet weak var view1: UIView!
    @IBOutlet weak var bkgImage: UIImageView!
    
    @IBOutlet weak var view2: UIView!
    @IBOutlet weak var showimage: UIImageView!
    @IBOutlet weak var scroll: UIScrollView!
    
   
    override func prefersStatusBarHidden() -> Bool {
        return true
    }


    
    override func viewDidLoad() {
        super.viewDidLoad()
               
        
        
        
        
        hide1.hidden = false
        scroll.hidden = true
       self.scroll.contentSize = CGSizeMake(self.scroll.frame.width*1.5,  self.scroll.frame.height)
    
   
        
        
        
        PHImageManager.defaultManager().requestImageDataForAsset(myAsset1, options: nil,
                                                                 resultHandler: {
                                                                    _, _, _, info in
                                                                    self.title = (info!["PHImageFileURLKey"] as! NSURL).lastPathComponent
        })
        
        PHImageManager.defaultManager().requestImageForAsset(myAsset1,
                                                             targetSize: PHImageManagerMaximumSize , contentMode: . Default,
                                                             options: nil, resultHandler: {
                                                                (image, _: [NSObject : AnyObject]?) in
                                                                self.bkgImage.image = image
                                                                
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
                                                                self.showimage.image = image
                                                                
        })

        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(animated: Bool) {
        self.navigationController?.navigationBarHidden = true
    }
    
    @IBAction func Template(sender: AnyObject) {
        hide1.hidden = false
        scroll.hidden = true
        
    }
    
    @IBAction func Template1(sender: AnyObject) {
        view1.frame = CGRectMake(5, 5, 365, 230)
       
        bkgImage.frame = CGRectMake(0, 0, 365, 230)
        
        view2.frame = CGRectMake(5, 240, 365, 230)
        showimage.frame = CGRectMake(0, 0, 365, 230)
        
        
        
    }
 
    @IBAction func Template2(sender: AnyObject) {
        view1.frame = CGRectMake(5, 5, 180, 465)
        bkgImage.frame = CGRectMake(0, 0, 180, 465)
        
        view2.frame = CGRectMake(190, 5, 180, 465)
        showimage.frame = CGRectMake(0, 0, 180, 465)
        
        
    }
    
    @IBAction func Template3(sender: AnyObject) {
        view1.frame = CGRectMake(5, 5, 182.5, 230)
        bkgImage.frame = CGRectMake(0, 0, 182.5, 230)
        
        view2.frame = CGRectMake(187.5, 240, 182.5, 230)
        showimage.frame = CGRectMake(0, 0, 182.5, 230)

    }
    
    @IBAction func Template4(sender: AnyObject) {
        
        view1.frame = CGRectMake(5, 5, 365, 465)
        bkgImage.frame = CGRectMake(0, 0, 365, 465)
        
        view2.frame = CGRectMake(220, 320, 150, 150)
        showimage.frame = CGRectMake(0, 0, 150, 150)
    }
    @IBAction func Template5(sender: AnyObject) {
        view1.frame = CGRectMake(187.5, 5, 182.5, 230)
        bkgImage.frame = CGRectMake(0, 0, 182.5, 230)
        
        view2.frame = CGRectMake(5, 240, 182.5, 230)
        showimage.frame = CGRectMake(0, 0, 182.5, 230)
        

        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func background(sender: AnyObject) {
        hide1.hidden = true
        scroll.hidden = false
        
    }
    @IBAction func f1(sender: AnyObject) {
        beijing.image = UIImage(named: "beijing1.jpg")
    }
    
    @IBAction func f2(sender: AnyObject) {
          beijing.image = UIImage(named: "f2.jpg")
    }
    

    @IBAction func f3(sender: AnyObject) {
          beijing.image = UIImage(named: "f3.jpg")
    }
    
    @IBAction func f4(sender: AnyObject) {
          beijing.image = UIImage(named: "f4.png")
    }
    
    @IBAction func f5(sender: AnyObject) {
          beijing.image = UIImage(named: "f5.png")
    }
    @IBAction func f6(sender: AnyObject) {
          beijing.image = UIImage(named: "f6.jpg")
    }
    
    @IBAction func f7(sender: AnyObject) {
          beijing.image = UIImage(named: "f7.jpg")
    }
    @IBAction func finish(sender: AnyObject) {
 
        let image1 = bkgImage.image
        let image2 = showimage.image
        let image3 = beijing.image
        
        let ratio1 = min((bkgImage.image?.size.width)! / bkgImage.frame.width , (showimage.image?.size.width)! / bkgImage.frame.width)
        let ratio2 = min((bkgImage.image?.size.height)! / bkgImage.frame.height , (showimage.image?.size.height)! / bkgImage.frame.height)
       
        
        let size = CGSizeMake(imageshow.frame.width * ratio1, imageshow.frame.height * ratio2)
        
        UIGraphicsBeginImageContext(size)
        image3!.drawInRect(CGRectMake(beijing.frame.minX * ratio1, beijing.frame.minY * ratio2, beijing.frame.width * ratio1, beijing.frame.height * ratio2))
        image1!.drawInRect(CGRectMake(view1.frame.minX * ratio1, view1.frame.minY * ratio2, view1.frame.width * ratio1, view1.frame.height * ratio2))
        image2!.drawInRect(CGRectMake(view2.frame.minX * ratio1, view2.frame.minY * ratio2, view2.frame.width * ratio1, view2.frame.height * ratio2))
      
        let finalImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
     
        UIImageWriteToSavedPhotosAlbum(finalImage!, nil, nil, nil)
        dismissViewControllerAnimated(true, completion: nil)
    }

    
   
       
    
   }
