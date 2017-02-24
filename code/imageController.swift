//
//  imageController.swift
//  BeautifyCamera-v1
//
//  Created by pro on 16/6/21.
//  Copyright © 2016年 MengXu. All rights reserved.
//

import UIKit
import CoreImage
import Photos

class imageController: UIViewController {

   
 
  
    @IBOutlet weak var cropbt: UIButton!
    
    @IBOutlet weak var stretchbt: UIButton!
    
    @IBOutlet weak var scroll1: UIScrollView!
    @IBOutlet weak var scroll2: UIScrollView!
    @IBOutlet weak var scroll3: UIScrollView!
    
    @IBOutlet weak var fm: UIImageView!
    @IBOutlet weak var showsize: UILabel!
    
    @IBOutlet weak var lengthframe: UIImageView!
    @IBOutlet weak var bigImage: UIImageView!
    
    @IBOutlet weak var blurarea: UIImageView!
    @IBOutlet weak var frameshow: UIView!
    @IBOutlet weak var tag: UIImageView!
    @IBOutlet weak var hide1: UIView!
    @IBOutlet weak var hide2: UIView!
    @IBOutlet weak var hide3: UIView!
    
    @IBOutlet weak var menu: UIView!
  
    
    @IBOutlet weak var hide5: UIView!
    
  
    @IBOutlet weak var hide7: UIView!
    
    @IBOutlet weak var hide8: UIView!
    @IBOutlet weak var bhide: UIView!
    
    @IBOutlet weak var brightness: UISlider!
    @IBOutlet weak var shide: UIView!
    @IBOutlet weak var chide: UIView!
    @IBOutlet weak var hhide: UIView!
    
    @IBOutlet weak var ehide: UIView!
    
    @IBOutlet weak var done: UIButton!
    @IBOutlet weak var contrast: UISlider!
    
    @IBOutlet weak var saturation: UISlider!
    
    
    
    
    
    
    var effectfilters: String!
    var bcshefilters : String!
    var bsshekey : String!
    var slidervalue : Float!
    var image1 = CIImage()
    
    var bcshefilter: CIFilter!

    
    var showori : UIImage!
    var image : UIImage!
    
    var context: CIContext = {
        return CIContext(options: nil)
    }()

    var filter: CIFilter!
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        hide1.hidden = true
        hide2.hidden = true
        hide3.hidden = true
        hide5.hidden = true
        hide7.hidden = true
        hide8.hidden = true
        chide.hidden = true
        shide.hidden = true
        bhide.hidden = true
        ehide.hidden = true
        hhide.hidden = true
        fm.hidden = true
        lengthframe.hidden = true
        blurarea.hidden = true
        
        done.hidden = true
        cropbt.hidden = true
        stretchbt.hidden = true
        
        
        
        bigImage.image = image
        
        let uimage = bigImage.image;
        let cimage = uimage?.CGImage;
        image1 = CIImage(CGImage: cimage!)
        
       
       showsize.text = String(Int(image.size.width)) + " x " + String(Int(image.size.height))
     
        
        self.scroll1.frame = CGRectMake(0, 0, self.hide7.frame.width, self.hide7.frame.height)
        
        self.scroll1.contentSize = CGSizeMake(self.hide7.frame.width*3,  self.hide7.frame.height)
        
       
        
        self.scroll2.contentSize = CGSizeMake(430,  self.menu.frame.height)
        self.scroll3.contentSize = CGSizeMake(hide1.frame.width*2.5,  self.hide1.frame.height)
        
        
        self.lengthframe.frame = CGRectMake(0, 100, frameshow.frame.width, frameshow.frame.height/4)
    
        if image.size.width > image.size.height {
            let ratio = image.size.width / image.size.height
            
            bigImage.frame = CGRectMake(0,(bigImage.frame.height - bigImage.frame.width/ratio)/2,bigImage.frame.width, bigImage.frame.width/ratio)
            
        }
        if image.size.width < image.size.height {
            let ratio = image.size.width / image.size.height
            
            bigImage.frame = CGRectMake((bigImage.frame.width - bigImage.frame.height * ratio)/2,0,bigImage.frame.height * ratio, bigImage.frame.height)
            
        }

        
    }
    
 
    
    
    override func viewWillAppear(animated: Bool) {
        self.navigationController?.navigationBarHidden = true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
           }
    
 
    
    @IBAction func showOriginal(sender: AnyObject) {
        bigImage.image = image
        showori = image
        
    }
    
    

    
   // auto effect using autoadjustment filter
    @IBAction func auto(sender: AnyObject) {
        hide2.hidden = true
        hide1.hidden = true
        hide3.hidden = true
        blurarea.hidden = true
        hide5.hidden = true
        hide7.hidden = true
        hide8.hidden = true
        chide.hidden = true
        shide.hidden = true
        bhide.hidden = true
        ehide.hidden = true
        hhide.hidden = true
        fm.hidden = true
       lengthframe.hidden = true
        
        
        done.hidden = true
        cropbt.hidden = true
        stretchbt.hidden = true
        
        var imageauto = CIImage(image: image)
        //direction of image
        let autofilters = imageauto!.autoAdjustmentFiltersWithOptions([CIDetectorImageOrientation:1])
       // use all the filters in the autoadjustmentfilters
        for filters: CIFilter in autofilters {
            filters.setValue(imageauto, forKey: kCIInputImageKey)
            imageauto = filters.outputImage
        }
        let lastimage = context.createCGImage(imageauto!, fromRect: imageauto!.extent)
        
        bigImage.image = UIImage(CGImage: lastimage)
        
      
        
    }
   
    //auto end
 
    
  
 
        
        
    
    // 8 different effects:using four filters
    
    @IBAction func effect(sender: UIButton) {
        
        self.hide2.hidden = true
        self.hide3.hidden = true
        self.hide1.hidden = false
      
        hide5.hidden = true
      
        hide7.hidden = true
          hide8.hidden = true
        chide.hidden = true
        shide.hidden = true
        bhide.hidden = true
        ehide.hidden = true
        hhide.hidden = true
        fm.hidden = true
         lengthframe.hidden = true
        blurarea.hidden = true
        done.hidden = true
        cropbt.hidden = true
        stretchbt.hidden = true
        
    }
    
    
    func effect1() {
      
        let inputImage = CIImage(image: image)
        let context = CIContext(options:nil)
        let filter = CIFilter(name:effectfilters)
        filter!.setValue(inputImage, forKey: kCIInputImageKey)
        if let outputImage = filter!.outputImage {
            let outImage = context.createCGImage(outputImage, fromRect: outputImage.extent)
            bigImage.image = UIImage(CGImage: outImage)}
    }
    

    @IBAction func nostalgic(sender: AnyObject) {
         effectfilters = "CIPhotoEffectInstant"
         effect1()
      
    }
    
    @IBAction func monochrome(sender: AnyObject) {
        effectfilters = "CIPhotoEffectNoir"
        effect1()
    }
    
    @IBAction func comic(sender: AnyObject) {
        effectfilters = "CIComicEffect"
        effect1()
    }
    
    @IBAction func timeslip(sender: AnyObject) {
        effectfilters = "CIPhotoEffectTransfer"
        effect1()
    }
    
    @IBAction func mono(sender: AnyObject) {
        effectfilters = "CIPhotoEffectMono"
        effect1()
    }
    
    @IBAction func fade(sender: AnyObject) {
        effectfilters = "CIPhotoEffectFade"
        effect1()
    }
    
    @IBAction func process(sender: AnyObject) {
        effectfilters = "CIPhotoEffectProcess"
        effect1()
    }
    
    @IBAction func chrome(sender: AnyObject) {
        effectfilters = "CIPhotoEffectChrome"
        effect1()
    }
    
    @IBAction func overlay(sender: AnyObject) {
        effectfilters = "CILineOverlay"
        effect1()

    }
    @IBAction func CICMYKHalftone(sender: AnyObject) {
        effectfilters = "CICMYKHalftone"
        effect1()
    }
    
    
    
    
    //10 effects end
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    // slider change the brightness, saturation, contrast
    
    @IBAction func brightnessshow(sender: AnyObject) {
        chide.hidden = true
        shide.hidden = true
        bhide.hidden = false
        ehide.hidden = true
        hhide.hidden = true
    }
    @IBAction func contrastshow(sender: AnyObject) {
        chide.hidden = false
        shide.hidden = true
        bhide.hidden = true
        ehide.hidden = true
        hhide.hidden = true
    }
    @IBAction func saturationshow(sender: AnyObject) {
        chide.hidden = true
        shide.hidden = false
        bhide.hidden = true
        ehide.hidden = true
        hhide.hidden = true
    }
    @IBAction func hueshow(sender: AnyObject) {
        chide.hidden = true
        shide.hidden = true
        bhide.hidden = true
        ehide.hidden = true
        hhide.hidden = false
    }
    @IBAction func exposureshow(sender: AnyObject) {
        chide.hidden = true
        shide.hidden = true
        bhide.hidden = true
        ehide.hidden = false
        hhide.hidden = true
    }
    
   
    
    
    
    @IBAction func sliderFunc(sender: UIButton) {
        
        hide2.hidden = false
        hide1.hidden = true
         hide3.hidden = true
         hide8.hidden = true
         hide5.hidden = true
      
        hide7.hidden = true
        fm.hidden = true
         lengthframe.hidden = true
          blurarea.hidden = true
        done.hidden = true
        cropbt.hidden = true
        stretchbt.hidden = true
        
        
    }
  

    func adjustbcshe(){
    
        bcshefilter = CIFilter(name: bcshefilters);
        bcshefilter.setValue(image1, forKey: "inputImage")
        bcshefilter.setValue(slidervalue, forKey: bsshekey);
        let outputImage1 = bcshefilter.outputImage!;
        let bcsheimage = context.createCGImage(outputImage1, fromRect: outputImage1.extent)
        let newUIImage = UIImage(CGImage: bcsheimage)
        bigImage.image = newUIImage;
    
    
    }
    
    
    
    
    @IBAction func brightness(sender: UISlider) {
        bcshefilters = "CIColorControls"
        slidervalue = Float(sender.value)
        bsshekey = "inputBrightness"
        adjustbcshe()
        
           }
    
    @IBAction func contrast(sender: UISlider) {
        bcshefilters = "CIColorControls"
        slidervalue = Float(sender.value)
        bsshekey = "inputContrast"
        adjustbcshe()
        
     

    }
  
    @IBAction func saturation(sender: UISlider) {
        bcshefilters = "CIColorControls"
        slidervalue = Float(sender.value)
        bsshekey = "inputSaturation"
        adjustbcshe()
        

    }
    
    @IBAction func hue(sender: UISlider) {
        bcshefilters = "CIHueAdjust"
        slidervalue = Float(sender.value)
        bsshekey = kCIInputAngleKey
        adjustbcshe()
       

    }
    
    @IBAction func exposure(sender: UISlider) {
        bcshefilters = "CIExposureAdjust"
        slidervalue = Float(sender.value)
        bsshekey = kCIInputEVKey
        adjustbcshe()


    }
  
    
    //slider lightness.. end
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    // rotation
    
    @IBAction func rotation(sender: UIButton) {
        self.hide2.hidden = true
        self.hide1.hidden = true
        self.hide3.hidden = false
         hide8.hidden = true
        hide5.hidden = true
     
        hide7.hidden = true
        chide.hidden = true
        shide.hidden = true
        bhide.hidden = true
        ehide.hidden = true
        hhide.hidden = true
        fm.hidden = false
       lengthframe.hidden = true
          blurarea.hidden = true
        
        done.hidden = true
        cropbt.hidden = false
        stretchbt.hidden = true
        
       
           // let alertView = UIAlertView(title: "Tips", message: "Become scale to fill due to some functions", delegate: self, cancelButtonTitle: "cancel")
        
        
     
        
    }
    
 
    
    
    
    @IBAction func leftright(sender: AnyObject) {
        
        
        let flipImage =  UIImage(CGImage:image.CGImage!,
                                 scale:1,
                                 orientation:UIImageOrientation.UpMirrored)
        
     
        bigImage.image = flipImage
        

    }
    
    @IBAction func topdown(sender: AnyObject) {
        
        let flipImage =  UIImage(CGImage:image.CGImage!,
                                 scale:1,
                                 orientation:UIImageOrientation.DownMirrored)
        
        bigImage.image = flipImage

    }
    
    
    func cropImage(img:UIImage , x:CGFloat , y:CGFloat , width:CGFloat, height:CGFloat) -> UIImage?
    {
        let crop = CGRectMake(x,y,width,height)
        
        let cgImage = CGImageCreateWithImageInRect(img.CGImage, crop)
        let imagea:UIImage = UIImage(CGImage:cgImage!)
        return imagea
    }

 
    @IBAction func resize1(sender: AnyObject) {
        
        
        let ratio1 = CGFloat(image.size.width) / bigImage.frame.width
        let ratio2 = CGFloat(image.size.height) / bigImage.frame.height
        var xvalue : CGFloat!
        var yvalue : CGFloat!
        
     
            xvalue = (fm.frame.minX - bigImage.frame.minX)*ratio1
            yvalue = (fm.frame.minY - bigImage.frame.minY)*ratio2
            
   

        
        
        let widthvalue = fm.frame.width*ratio1
        let heightvalue = fm.frame.height*ratio2

        
        
        
       let croppedImage = self.cropImage(image,x: xvalue,y:yvalue,width: widthvalue,height: heightvalue)
        
       
       self.bigImage.image = croppedImage
      
       
                  }
    
    

    
    
    @IBAction func aspect1(sender: AnyObject) {
        fm.image = UIImage(named: "crop.png")
        fm.frame.size = (fm.image?.size)!
    }
    
    @IBAction func aspect2(sender: AnyObject) {
        fm.image = UIImage(named: "crop2.png")
         fm.frame.size = (fm.image?.size)!
    }
    
    @IBAction func aspect3(sender: AnyObject) {
          fm.image = UIImage(named: "crop3.png")
        fm.frame.size = (fm.image?.size)!
    }
    
    
    
    
    
    
    
    
    

    @IBAction func Rotate90(sender: AnyObject) {
  
        let flipImage =  UIImage(CGImage:image.CGImage!,
                                 scale:1,
                                 orientation:UIImageOrientation.Right)
        
        
        bigImage.image = flipImage    }
    
    
    @IBAction func Rotate180(sender: AnyObject) {
        let flipImage =  UIImage(CGImage:image.CGImage!,
                                 scale:1,
                                 orientation:UIImageOrientation.Down)
        
        
        bigImage.image = flipImage
        
    }
    
  
    @IBAction func Rotate270(sender: AnyObject) {
        let flipImage =  UIImage(CGImage:image.CGImage!,
                                 scale:1,
                                 orientation:UIImageOrientation.Left)
        
        
        bigImage.image = flipImage

    }
    
    @IBAction func rotate360(sender: AnyObject) {
        let flipImage =  UIImage(CGImage:image.CGImage!,
                                 scale:1,
                                 orientation:UIImageOrientation.Up)
        
        
        bigImage.image = flipImage
    }
    
    
    
    
    @IBAction func handlePan2(recognizer:UIPanGestureRecognizer) {
        let translation = recognizer.translationInView(self.view)
         if let view = recognizer.view {
            
          
            view.center = CGPoint(x:view.center.x + translation.x,
                                  y:view.center.y + translation.y)
            
            
            
            if view.center.x < bigImage.frame.minX + fm.frame.width/2 {
            view.center.x = bigImage.frame.minX + fm.frame.width/2
            
            }
            if view.center.x > bigImage.frame.maxX - fm.frame.width/2 {
                view.center.x = bigImage.frame.maxX - fm.frame.width/2
                
            }
            
            if view.center.y < bigImage.frame.minY + fm.frame.height/2 {
                view.center.y =  bigImage.frame.minY + fm.frame.height/2
                
            }
            if view.center.y > bigImage.frame.maxY - fm.frame.height/2 {
                view.center.y = bigImage.frame.maxY - fm.frame.height/2
                
            }

            
          
        }
       
    
        recognizer.setTranslation(CGPointZero, inView: self.view)
        
    
        
    }
    
    @IBAction func handlePinch2(recognizer : UIPinchGestureRecognizer) {
        if let view = recognizer.view {
            view.transform = CGAffineTransformScale(view.transform,
                                                    recognizer.scale, recognizer.scale)
            recognizer.scale = 1
        }
    }

    
    
    
    
    
    
    
    
 //end resize
    
    
    
    

    
    
    //watermark function
    @IBAction func watermark(sender: UIButton) {
        self.hide2.hidden = true
        self.hide1.hidden = true
        self.hide3.hidden = true
         hide8.hidden = true
        hide5.hidden = false
       
        hide7.hidden = true
        chide.hidden = true
        shide.hidden = true
        bhide.hidden = true
        ehide.hidden = true
        hhide.hidden = true
        fm.hidden = true
        lengthframe.hidden = true
          blurarea.hidden = true
        done.hidden = true
        cropbt.hidden = true
        stretchbt.hidden = true
        
    }
    
  
    
    
    
    
  
    
    
    
    
    
    
    
    //end watermark
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
       
    
    
        
    }
    

    
    @IBAction func handlePinch(recognizer : UIPinchGestureRecognizer) {
        if let view = recognizer.view {
            view.transform = CGAffineTransformScale(view.transform,
                                                    recognizer.scale, recognizer.scale)
            recognizer.scale = 1
        }
    }
    
    
    // tags function..........
    @IBAction func tags(sender: UIButton) {
        self.hide2.hidden = true
        self.hide1.hidden = true
        self.hide3.hidden = true
         hide8.hidden = true
        hide5.hidden = true
     
        hide7.hidden = false
        chide.hidden = true
        shide.hidden = true
        bhide.hidden = true
        ehide.hidden = true
        hhide.hidden = true
        fm.hidden = true
        tag.hidden = false
        lengthframe.hidden = true
          blurarea.hidden = true
        done.hidden = false
        cropbt.hidden = true
        stretchbt.hidden = true
        
    }
    
    @IBAction func tag1(sender: AnyObject) {
        tag.image = UIImage(named:"tag1.png")
        
        
    }
    
    @IBAction func tag2(sender: AnyObject) {
        tag.image = UIImage(named:"tag2.png")

    }
    
 
    @IBAction func tag3(sender: AnyObject) {
        tag.image = UIImage(named:"tag3.png")

    }
    
    
    @IBAction func tag4(sender: AnyObject) {
        tag.image = UIImage(named:"tag4.png")

    }
    
    @IBAction func tag5(sender: AnyObject) {
        tag.image = UIImage(named:"tag5.png")
    }
    
    @IBAction func tag6(sender: AnyObject) {
        tag.image = UIImage(named:"tag6.png")
    }
    
    
    @IBAction func tag7(sender: AnyObject) {
        tag.image = UIImage(named:"tag7.png")
    }
    
    
    @IBAction func tag8(sender: AnyObject) {
        tag.image = UIImage(named:"tag8.png")
    }
    
    @IBAction func tag9(sender: AnyObject) {
        tag.image = UIImage(named:"tag9.png")
        
        
    }
    
    @IBAction func tag10(sender: AnyObject) {
        tag.image = UIImage(named:"tag10.png")
        
    }
    
    
    @IBAction func tag11(sender: AnyObject) {
        tag.image = UIImage(named:"tag11.png")
        
    }
    
    
    @IBAction func tag12(sender: AnyObject) {
        tag.image = UIImage(named:"tag12.png")
        
    }
    
    @IBAction func tag13(sender: AnyObject) {
        tag.image = UIImage(named:"tag13.png")
    }
    
    @IBAction func tag14(sender: AnyObject) {
        tag.image = UIImage(named:"tag14.png")
    }
    
    
    @IBAction func tag15(sender: AnyObject) {
        tag.image = UIImage(named:"tag15.png")
    }
    
    
    @IBAction func tag16(sender: AnyObject) {
        tag.image = UIImage(named:"tag16.png")
    }

    
    @IBAction func tag17(sender: AnyObject) {
        tag.image = UIImage(named:"tag17.png")
        
        
    }
    
    @IBAction func tag18(sender: AnyObject) {
        tag.image = UIImage(named:"tag18.png")
        
    }
    
    
    @IBAction func tag19(sender: AnyObject) {
        tag.image = UIImage(named:"tag19.png")
        
    }
    
    
    @IBAction func tag20(sender: AnyObject) {
        tag.image = UIImage(named:"tag20.png")
        
    }
    

    @IBAction func done(sender: AnyObject) {
        var ratio1:CGFloat!
        var ratio2:CGFloat!
        hide7.hidden = true
        ratio1 = CGFloat(image.size.width) / bigImage.frame.width
        ratio2 =  CGFloat(image.size.height) / bigImage.frame.height

        
       
        
       tag.hidden = true
        
        let bottomImage = image
        let topImage =  tag.image
        
        let size = CGSize(width: image.size.width, height: image.size.height)
        UIGraphicsBeginImageContext(size)
        
        let areaSize = CGRect(x: 0, y: 0, width: image.size.width, height: image.size.height)
        bottomImage!.drawInRect(areaSize)
        
        let areaSize1 = CGRect(x:(tag.frame.minX - bigImage.frame.minX)*ratio1, y: (tag.frame.minY - bigImage.frame.minY)*ratio2, width: CGFloat(tag.frame.width*ratio1), height: CGFloat(tag.frame.height*ratio2))
        
        topImage!.drawInRect(areaSize1, blendMode: .Normal, alpha: 1)
        /*
        let bitmap: CGContextRef = UIGraphicsGetCurrentContext()!
         CGContextRotateCTM(bitmap, rotate.rotation)
        CGContextDrawImage(bitmap, areaSize1, topImage?.cg)
 */
        let newImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()
      
        UIGraphicsEndImageContext()
        bigImage.image = newImage
    }

    
    
    @IBAction func handlePan1(recognizer:UIPanGestureRecognizer) {
        let translation = recognizer.translationInView(self.view)
        if let view = recognizer.view {
            view.center = CGPoint(x:view.center.x + translation.x,
                                  y:view.center.y + translation.y)
            
            
            
            if view.center.x < bigImage.frame.minX  {
                view.center.x = bigImage.frame.minX
                
            }
            if view.center.x > bigImage.frame.maxX {
                view.center.x = bigImage.frame.maxX
            }
            
            if view.center.y < bigImage.frame.minY {
                view.center.y =  bigImage.frame.minY
                
            }
            if view.center.y > bigImage.frame.maxY  {
                view.center.y = bigImage.frame.maxY
                
            }

            
        }
        recognizer.setTranslation(CGPointZero, inView: self.view)
        
          }

    
    var angle: CGFloat!
   
    @IBOutlet var rotate: UIRotationGestureRecognizer!
    
    @IBAction func handleRotate(recognizer : UIRotationGestureRecognizer) {
        if let view = recognizer.view {
            view.transform = CGAffineTransformRotate(view.transform, recognizer.rotation)
            recognizer.rotation = 0
           
            
        
        }
    
    
    }
    
    
  
    
    
    
    
    
    
    
    
    @IBAction func blur(sender: AnyObject) {
        
        self.hide2.hidden = true
        self.hide1.hidden = true
        self.hide3.hidden = true
          hide8.hidden = false
        hide5.hidden = true
              hide7.hidden = true
        chide.hidden = true
        shide.hidden = true
        bhide.hidden = true
        ehide.hidden = true
        hhide.hidden = true
        fm.hidden = true
        tag.hidden = true
        lengthframe.hidden = true
          blurarea.hidden = false
        done.hidden = true
        cropbt.hidden = true
        stretchbt.hidden = true
        
    
    
    }
    
    
    @IBAction func handlePanblur(recognizer:UIPanGestureRecognizer) {
        let translation = recognizer.translationInView(self.view)
        if let view = recognizer.view {
            view.center = CGPoint(x:view.center.x + translation.x,
                                  y:view.center.y + translation.y)
            
            
            
            if view.center.x < bigImage.frame.minX + blurarea.frame.width/2 {
                view.center.x = bigImage.frame.minX + blurarea.frame.width/2
                
            }
            if view.center.x > bigImage.frame.maxX - blurarea.frame.width/2 {
                view.center.x = bigImage.frame.maxX - blurarea.frame.width/2
                
            }
            
            if view.center.y < bigImage.frame.minY + blurarea.frame.height/2 {
                view.center.y =  bigImage.frame.minY + blurarea.frame.height/2
                
            }
            if view.center.y > bigImage.frame.maxY - blurarea.frame.height/2 {
                view.center.y = bigImage.frame.maxY - blurarea.frame.height/2
                
            }
            

            
        }
        recognizer.setTranslation(CGPointZero, inView: self.view)
        
        
    }
    
    
    @IBOutlet weak var rangeslider: UISlider!
    @IBOutlet weak var levelsider: UISlider!
    @IBAction func adjustrange(sender: UISlider) {
        blurarea.frame = CGRectMake(
            blurarea.frame.origin.x,
            blurarea.frame.origin.y, CGFloat(sender.value), CGFloat(sender.value));
     
    }
   

    
    
    
    
    @IBAction func blurface(sender: AnyObject) {
       

       
        var ratio1:CGFloat!
        var ratio2:CGFloat!
        
        ratio1 = CGFloat(image.size.width) / bigImage.frame.width
        ratio2 =  CGFloat(image.size.height) / bigImage.frame.height
        
         //xy.text = String(Int(blurarea.frame.midX*ratio1)) + ","+String(Int(blurarea.frame.midY*ratio2))
        
        let filter = CIFilter(name: "CIGaussianBlur")!
        
        let inputImage = CIImage(image: showori)!
        filter.setValue(inputImage, forKey: kCIInputImageKey)
        filter.setValue(levelsider.value, forKey: kCIInputRadiusKey)
       
        let filterareaimage = filter.outputImage
        
        var maskImage : CIImage!
     
        let centerY = showori.size.height - (blurarea.frame.midY - bigImage.frame.minY)*ratio2
       
      
        let centerX = (blurarea.frame.midX - bigImage.frame.minX)*ratio1
       
        let radius = blurarea.frame.width 
        
        
        let temp = createMaskImage(inputImage.extent, centerX: centerX, centerY: centerY,
                               radius: radius)
         maskImage = temp
        

        let lastimage = CIFilter(name: "CIBlendWithMask")!
        lastimage.setValue(filterareaimage, forKey: kCIInputImageKey)
        lastimage.setValue(inputImage, forKey: kCIInputBackgroundImageKey)
        lastimage.setValue(maskImage, forKey: kCIInputMaskImageKey)
        
        let blendOutputImage = lastimage.outputImage
        let blendCGImage = context.createCGImage(blendOutputImage!,
                                                 fromRect: blendOutputImage!.extent)
         showori = UIImage(CGImage: blendCGImage)
         bigImage.image = showori
        
        
        

    }
    
    
    
    func createMaskImage(rect: CGRect ,centerX: CGFloat, centerY: CGFloat, radius:CGFloat)
        -> CIImage{
            let radiusfilter = CIFilter(name: "CIRadialGradient",
                                          withInputParameters: [
                                            "inputRadius0" : radius,
                                           
                                            "inputColor0" : CIColor(red: 0, green: 1, blue: 0, alpha: 1),
                                           
                                            kCIInputCenterKey : CIVector(x: centerX, y: centerY)
                ])
            let radiusoutimage = radiusfilter!.outputImage!.imageByCroppingToRect(rect)
            return radiusoutimage
    }

    
    
    @IBAction func stretch(sender: AnyObject) {
        
        
        
        
        let ratio1 = CGFloat(image.size.width) / bigImage.frame.width
        let ratio2 = CGFloat(image.size.height) / bigImage.frame.height
        let ratio = min(ratio1, ratio2)
        
        let filter1 = CIFilter(name: "CIBumpDistortion")
        let inputimage = CIImage(image: showori)
        filter1?.setValue(inputimage, forKey: kCIInputImageKey)
        filter1?.setValue(blurarea.frame.height*ratio, forKey: kCIInputRadiusKey)
        filter1?.setValue(CIVector(x: (blurarea.frame.midX - bigImage.frame.minX) * ratio1, y: image.size.height - (blurarea.frame.midY - bigImage.frame.minY)*ratio2), forKey: kCIInputCenterKey)
        filter1?.setValue(-0.2, forKey: kCIInputScaleKey)
        
        
        
        
        let imageout1 = filter1!.outputImage
        
        let image2 = context.createCGImage(imageout1!, fromRect: (imageout1?.extent)!)
        showori = UIImage(CGImage:image2)
        

       bigImage.image = showori
    }
    
    
    @IBAction func IncreaseHeight(sender: AnyObject) {
        self.hide2.hidden = true
        self.hide1.hidden = true
        self.hide3.hidden = true
        hide8.hidden = true
        hide5.hidden = true
     
        hide7.hidden = true
        chide.hidden = true
        shide.hidden = true
        bhide.hidden = true
        ehide.hidden = true
        hhide.hidden = true
        fm.hidden = true
        tag.hidden = true
        lengthframe.hidden = false
        blurarea.hidden = true
        done.hidden = true
        cropbt.hidden = true
        stretchbt.hidden = false
        
        
    }
    
    
    @IBAction func increase(sender: AnyObject) {
        
        
        
        let ratio2 = CGFloat(image.size.height) / bigImage.frame.height
        
        
        let yvalue = image.size.height - CGFloat((lengthframe.frame.midY - bigImage.frame.minY)*ratio2)
    
        let heightvalue = Int(lengthframe.frame.height*ratio2)
        

        
        
        let filter1 = CIFilter(name: "CIBumpDistortionLinear")
        let inputimage = CIImage(image: image)!
        filter1?.setValue(inputimage, forKey: kCIInputImageKey)
        filter1?.setValue(heightvalue, forKey: kCIInputRadiusKey)
        filter1?.setValue(CIVector(x: 0, y: yvalue), forKey: kCIInputCenterKey)
        filter1?.setValue(0.85, forKey: kCIInputScaleKey)
        
        
        
        
        
        
        let imageout = filter1!.outputImage
        let image2 = context.createCGImage(imageout!, fromRect: (imageout?.extent)!)
        bigImage.image = UIImage(CGImage:image2)
        

    }
    
    
    
    @IBAction func handlelength1(recognizer:UIPanGestureRecognizer) {
        let translation = recognizer.translationInView(self.view)
        if let view = recognizer.view {
            view.center = CGPoint(x:view.center.x,
                                  y:view.center.y + translation.y)
            
            
            
     
     
            

            if view.center.y < lengthframe.frame.height/2 + bigImage.frame.minY {
                view.center.y = lengthframe.frame.height/2 + bigImage.frame.minY
                
            }
            if view.center.y > bigImage.frame.maxY - lengthframe.frame.height/2 {
                view.center.y = bigImage.frame.maxY - lengthframe.frame.height/2
                
            }
  
        }
        recognizer.setTranslation(CGPointZero, inView: self.view)
        
        
    }

    @IBAction func handlelength2(recognizer : UIPinchGestureRecognizer) {
        if let view = recognizer.view {
            view.transform = CGAffineTransformScale(view.transform,
                                                    1, recognizer.scale)
            recognizer.scale = 1
        }
    }
    

    
    
    
    
    
    @IBAction func save(sender: AnyObject) {
       
        PHPhotoLibrary.sharedPhotoLibrary().performChanges({
            PHAssetChangeRequest.creationRequestForAssetFromImage(self.bigImage.image!)
            }, completionHandler: { (isSuccess: Bool, error: NSError?) in
                if isSuccess {
                    print("success!")
                } else{
                    print("fail：", error!.localizedDescription)
                }
        })
    }
 
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "input" {
            
            let controller = segue.destinationViewController as! keyboardController
            
            controller.imagekeyboard = bigImage.image
            
            
        }
        
        if segue.identifier == "handwrite" {
            
            let controller = segue.destinationViewController as! handwriteController
            
            controller.imagehandwrite = bigImage.image
            
            
        }

        
    }
    

    
    
    
    
    
   }
