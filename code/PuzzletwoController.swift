//
//  PuzzletwoController.swift
//  BeautifyCamera-v1
//
//  Created by pro on 16/9/11.
//  Copyright © 2016年 MengXu. All rights reserved.
//

import UIKit
import Photos

class PuzzletwoController: UIViewController {

    @IBOutlet weak var imageshow: UIView!
    @IBOutlet weak var image1: UIImageView!
    @IBOutlet weak var image2: UIImageView!
    @IBOutlet weak var image3: UIImageView!
    var myAsset3: PHAsset!
    var myAsset2: PHAsset!
    var myAsset1: PHAsset!
    
    @IBOutlet weak var beijing: UIImageView!
    @IBOutlet weak var view1: UIView!
    
    @IBOutlet weak var view2: UIView!
    @IBOutlet weak var view3: UIView!
    
    @IBOutlet weak var scroll: UIScrollView!
    @IBOutlet weak var hide1: UIView!
    
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    override func viewWillAppear(animated: Bool) {
        self.navigationController?.navigationBarHidden = true
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


        // Do any additional setup after loading the view.
    }
    
   
    @IBAction func template(sender: AnyObject) {
        hide1.hidden = false
        scroll.hidden = true
    }
    
    @IBAction func template1(sender: AnyObject) {
        view1.frame = CGRectMake(5, 5, 118, 490)
        
        image1.frame = CGRectMake(0, 0, 118, 490)
        
        view3.frame = CGRectMake(128, 5, 118, 490)
        image2.frame = CGRectMake(0, 0, 118, 490)
        
        view2.frame = CGRectMake(251, 5, 118, 490)
        image3.frame = CGRectMake(0, 0, 118, 490)

    }
    
    @IBAction func template2(sender: AnyObject) {
        view1.frame = CGRectMake(5, 5, 180, 242.5)
        
        image1.frame = CGRectMake(0, 0, 180, 242.5)
        
        view3.frame = CGRectMake(5, 252.5, 180, 242.5)
        image2.frame = CGRectMake(0, 0, 180, 242.5)
        
        view2.frame = CGRectMake(190, 5, 180, 490)
        image3.frame = CGRectMake(0, 0, 180, 490)
        
        
    }
    
    @IBAction func template3(sender: AnyObject) {
        view1.frame = CGRectMake(5, 5, 180, 242.5)
        
        image1.frame = CGRectMake(0, 0, 180, 242.5)
        
        view3.frame = CGRectMake(190, 5, 180, 242.5)
        image2.frame = CGRectMake(0, 0, 180, 242.5)
        
        view2.frame = CGRectMake(5, 252.5, 360, 242.5)
        image3.frame = CGRectMake(0, 0, 360, 242.5)

        
        
    }
    @IBAction func template4(sender: AnyObject) {
        view1.frame = CGRectMake(5, 5, 365, 160)
        
        image1.frame = CGRectMake(0, 0, 365, 160)
        
        view3.frame = CGRectMake(5, 170, 365, 160)
        image2.frame = CGRectMake(0, 0, 365, 160)
        
        view2.frame = CGRectMake(5, 335, 365, 160)
        image3.frame = CGRectMake(0, 0, 365, 160)

    }
    
    @IBAction func template5(sender: AnyObject) {
        view1.frame = CGRectMake(5, 5, 365, 490)
        
        image1.frame = CGRectMake(0, 0, 365, 490)
        
        view3.frame = CGRectMake(10, 305, 175, 190)
        image2.frame = CGRectMake(0, 0, 175, 190)
        
        view2.frame = CGRectMake(190, 305, 175, 190)
        image3.frame = CGRectMake(0, 0, 175, 190)
    }
    
    

    
    @IBAction func frame(sender: AnyObject) {
        hide1.hidden = true
        scroll.hidden = false
    }
    
    @IBAction func frame1(sender: AnyObject) {
          beijing.image = UIImage(named: "f7.jpg")
    }
    
    @IBAction func frame2(sender: AnyObject) {
        beijing.image = UIImage(named: "f6.jpg")
    }
    
    @IBAction func frame3(sender: AnyObject) {
        beijing.image = UIImage(named: "f5.png")

    }
    
    @IBAction func frame4(sender: AnyObject) {
         beijing.image = UIImage(named: "f3.jpg")
    }

    @IBAction func frame5(sender: AnyObject) {
         beijing.image = UIImage(named: "f2.jpg")
    }
    
    @IBAction func frame6(sender: AnyObject) {
         beijing.image = UIImage(named: "beijing1.jpg")
    }
    
    @IBAction func frane7(sender: AnyObject) {
        beijing.image = UIImage(named: "f4.png")

    }
    
    
    @IBAction func save(sender: AnyObject) {
        let image11 = image1.image
        let image22 = image2.image
        let image33 = image3.image
        let image4 = beijing.image
        
        let ratio1 = min((image1.image?.size.width)! / image1.frame.width , (image2.image?.size.width)! / image2.frame.width ,(image3.image?.size.width)! / image3.frame.width )
        let ratio2 = min((image1.image?.size.height)! / image1.frame.height , (image2.image?.size.height)! / image2.frame.height , (image3.image?.size.height)! / image3.frame.height)
        
        
        let size = CGSizeMake(imageshow.frame.width * ratio1, imageshow.frame.height * ratio2)
        
        UIGraphicsBeginImageContext(size)
        image4!.drawInRect(CGRectMake(beijing.frame.minX * ratio1, beijing.frame.minY * ratio2, beijing.frame.width * ratio1, beijing.frame.height * ratio2))
        image11!.drawInRect(CGRectMake(view1.frame.minX * ratio1, view1.frame.minY * ratio2, view1.frame.width * ratio1, view1.frame.height * ratio2))
        image22!.drawInRect(CGRectMake(view2.frame.minX * ratio1, view2.frame.minY * ratio2, view2.frame.width * ratio1, view2.frame.height * ratio2))
        image33!.drawInRect(CGRectMake(view3.frame.minX * ratio1, view3.frame.minY * ratio2, view3.frame.width * ratio1, view3.frame.height * ratio2))
        
        let finalImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        UIImageWriteToSavedPhotosAlbum(finalImage!, nil, nil, nil)
        dismissViewControllerAnimated(true, completion: nil)

    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
