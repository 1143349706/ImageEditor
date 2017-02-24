//
//  livefilter.swift
//  BeautifyCamera-v1
//
//  Created by pro on 16/8/24.
//  Copyright © 2016年 MengXu. All rights reserved.
//
import UIKit
import AVFoundation
import CoreMedia
import Photos



class livefilter: UIViewController,AVCaptureVideoDataOutputSampleBufferDelegate{
    
    @IBOutlet weak var hide: UIView!
    var img : UIImage!
   
    @IBOutlet weak var imageshow: UIImageView!
   
    @IBOutlet weak var stickershow: UIImageView!
    @IBOutlet weak var scroll: UIScrollView!
    @IBOutlet weak var scroll1: UIScrollView!
 
    var backFacingCamera:AVCaptureDevice?
    var frontFacingCamera:AVCaptureDevice?
    var currentDevice:AVCaptureDevice?
    
    var stillImageOutput:AVCaptureStillImageOutput?
    var stillImage:UIImage?
    var context: CIContext = {
        return CIContext(options: nil)
    }()
    
    
    var filters: CIFilter!
    let session = AVCaptureSession()
    
    let camera = AVCaptureDevice.devicesWithMediaType(AVMediaTypeVideo) as! [AVCaptureDevice]
    
    let videoOutput = AVCaptureVideoDataOutput()
    
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    
    
 
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scroll1.hidden = true
        scroll.hidden = false
        stickershow.hidden = true
        
        self.scroll.frame = CGRectMake(0, 0, self.hide.frame.width, self.hide.frame.height)
        
        self.scroll.contentSize = CGSizeMake(self.hide.frame.width*1.2,  self.hide.frame.height)
        self.scroll1.frame = CGRectMake(0, 0, self.hide.frame.width, self.hide.frame.height)
        
        self.scroll1.contentSize = CGSizeMake(self.hide.frame.width*1.6,  self.hide.frame.height)

       stillImageOutput = AVCaptureStillImageOutput()
       stillImageOutput?.outputSettings = [AVVideoCodecKey: AVVideoCodecJPEG]
      
        
        session.sessionPreset = AVCaptureSessionPresetPhoto
        
     
        
        for device in camera {
            if device.position == AVCaptureDevicePosition.Back {
                backFacingCamera = device
            } else if device.position == AVCaptureDevicePosition.Front {
                frontFacingCamera = device
            }
        }
        currentDevice = backFacingCamera
        
        do
        {
            let imageinput = try AVCaptureDeviceInput(device: currentDevice)
            
            session.addInput(imageinput)
            session.addOutput(stillImageOutput)
        }
        catch
        {
            print("error!")
            return
        }
        

        videoOutput.setSampleBufferDelegate(self, queue: dispatch_queue_create("buffer delegate", DISPATCH_QUEUE_SERIAL))
        
        if session.canAddOutput(videoOutput)
        {
            session.addOutput(videoOutput)
        }
        
        session.startRunning()

      
        
    }
    
    func captureOutput(captureOutput: AVCaptureOutput!, didOutputSampleBuffer sampleBuffer: CMSampleBuffer!, fromConnection connection: AVCaptureConnection!)
    {
      
        
        let buffer = CMSampleBufferGetImageBuffer(sampleBuffer)
        let cameraImage = CIImage(CVPixelBuffer: buffer!)
        
                
        
        
        if filters == nil {
            let oriimage = UIImage(CIImage: cameraImage)
            
            dispatch_async(dispatch_get_main_queue())
            {
                self.imageshow.image = oriimage
                var r = CGAffineTransformIdentity
                
                r = CGAffineTransformRotate(r, CGFloat(M_PI_2))
                
                
                self.imageshow.transform = r
                
     
                
                
            }

        
        }
            
        else{
        
        filters.setValue(cameraImage, forKey: kCIInputImageKey)
        
        let filteredImage = UIImage(CIImage: filters.valueForKey(kCIOutputImageKey) as! CIImage!)
        
        dispatch_async(dispatch_get_main_queue())
        {
            self.imageshow.image = filteredImage
            var r = CGAffineTransformIdentity
            
            r = CGAffineTransformRotate(r, CGFloat(M_PI_2))
            
           
            self.imageshow.transform = r
      
            }}
        
    }

 
    @IBAction func stop(sender: AnyObject) {
     
        let videoConnection = stillImageOutput?.connectionWithMediaType(AVMediaTypeVideo)
        stillImageOutput?.captureStillImageAsynchronouslyFromConnection(videoConnection, completionHandler:
            { (buff, error) -> Void in
                let imageData = AVCaptureStillImageOutput.jpegStillImageNSDataRepresentation(buff)
                self.stillImage = UIImage(data: imageData)
                self.session.stopRunning()
            
               
                
        })
       
    


    }
    
   
    
    @IBAction func effecthide(sender: AnyObject) {
        scroll.hidden = false
        scroll1.hidden = true
        stickershow.hidden = true
        
    }
    
    
    @IBAction func stickerhide(sender: AnyObject) {
        scroll.hidden = true
        scroll1.hidden = false
        stickershow.hidden = false
    }
    
    @IBAction func sticker1(sender: AnyObject) {
         stickershow.image = UIImage(named:"tag1.png")
    }
    
    @IBAction func sticker2(sender: AnyObject) {
         stickershow.image = UIImage(named:"tag2.png")
    }
    
    @IBAction func sticker3(sender: AnyObject) {
         stickershow.image = UIImage(named:"tag3.png")
    }
    
    @IBAction func sticker4(sender: AnyObject) {
         stickershow.image = UIImage(named:"tag4.png")
    }
    
    @IBAction func sticker5(sender: AnyObject) {
         stickershow.image = UIImage(named:"tag5.png")
    }
    
    @IBAction func sticker6(sender: AnyObject) {
         stickershow.image = UIImage(named:"tags6.png")
    }
    
    @IBAction func sticker7(sender: AnyObject) {
         stickershow.image = UIImage(named:"tag6.png")
    }
    @IBAction func sticker8(sender: AnyObject) {
         stickershow.image = UIImage(named:"tags8.png")
    }
    
    @IBAction func sticker9(sender: AnyObject) {
         stickershow.image = UIImage(named:"tags1.png")
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
  
    @IBAction func saveimage(sender: AnyObject) {
     
        
        let ratio1 = CGFloat(stillImage!.size.width) / imageshow.frame.width
        let ratio2 =  CGFloat(stillImage!.size.height) / imageshow.frame.height
        
        
        
       
        
        let bottomImage = stillImage
        let topImage =  stickershow.image
        
        let size = CGSize(width: stillImage!.size.width, height: stillImage!.size.height)
        UIGraphicsBeginImageContext(size)
        
        let areaSize = CGRect(x: 0, y: 0, width: stillImage!.size.width, height: stillImage!.size.height)
        bottomImage!.drawInRect(areaSize)
        
        let areaSize1 = CGRect(x:(stickershow.frame.minX - imageshow.frame.minX)*ratio1, y: (stickershow.frame.minY - imageshow.frame.minY)*ratio2, width: CGFloat(stickershow.frame.width*ratio1), height: CGFloat(stickershow.frame.height*ratio2))
        
        topImage!.drawInRect(areaSize1, blendMode: .Normal, alpha: 1)
     
        let newImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndImageContext()

        var imagefilter1 = CIImage(image: newImage)

        
          if filters == nil {
            
            
            UIImageWriteToSavedPhotosAlbum(newImage, nil, nil, nil)
            dismissViewControllerAnimated(true, completion: nil)
          
        
        }
        
          else {
      
     
     
        filters.setValue(imagefilter1, forKey: kCIInputImageKey)
        imagefilter1 = filters.outputImage
        
        
        let lastimage = context.createCGImage(imagefilter1!, fromRect: imagefilter1!.extent)
       
       let flipImage =  UIImage(CGImage:lastimage)
        
   
        
        UIImageWriteToSavedPhotosAlbum(flipImage, nil, nil, nil)
            dismissViewControllerAnimated(true, completion: nil)    }
    
  
        
        
        self.session.startRunning()
    
    
    }
    
 
    override func viewWillAppear(animated: Bool) {
        self.navigationController?.navigationBarHidden = true
    }
    
    
    
    
    let PhotoEffectInstantFilter = CIFilter(name: "CIPhotoEffectInstant")
    let FadeEffectFilter = CIFilter(name: "CIPhotoEffectFade")
    let PhotoEffectTonalFilter = CIFilter(name: "CIPhotoEffectTonal")
    let PhotoEffectProcessFilter = CIFilter(name: "CIPhotoEffectProcess")
    let TransferFilter = CIFilter(name: "CIPhotoEffectTransfer")
    
    
    let CmykhalFilter = CIFilter(name: "CICMYKHalftone")
    
    @IBAction func effect1(sender: AnyObject) {
        filters = PhotoEffectInstantFilter
        
        
        
    }
    @IBAction func effect2(sender: AnyObject) {
       filters = TransferFilter
    }

    @IBAction func effect3(sender: AnyObject) {
        filters = PhotoEffectTonalFilter
    }
        
    @IBAction func effect4(sender: AnyObject) {
        filters = PhotoEffectProcessFilter
    }
        
    @IBAction func effect5(sender: AnyObject) {
        
        filters = FadeEffectFilter
      
       
    }
  
    
    
    @IBAction func handlePan1(recognizer:UIPanGestureRecognizer) {
        let translation = recognizer.translationInView(self.view)
        if let view = recognizer.view {
            view.center = CGPoint(x:view.center.x + translation.x,
                                  y:view.center.y + translation.y)
            
            
            
            if view.center.x < imageshow.frame.minX  {
                view.center.x = imageshow.frame.minX
                
            }
            if view.center.x > imageshow.frame.maxX {
                view.center.x = imageshow.frame.maxX
            }
            
            if view.center.y < imageshow.frame.minY {
                view.center.y =  imageshow.frame.minY
                
            }
            if view.center.y > imageshow.frame.maxY  {
                view.center.y = imageshow.frame.maxY
                
            }
            
            
        }
        recognizer.setTranslation(CGPointZero, inView: self.view)
        
    }
    
 

    
    @IBAction func handlePinch1(recognizer : UIPinchGestureRecognizer) {
        if let view = recognizer.view {
            view.transform = CGAffineTransformScale(view.transform,
                                                    recognizer.scale, recognizer.scale)
            recognizer.scale = 1
        }
    }
    

    
    
    
    
    
    
    
    
    
    
    
   
    @IBAction func effect7(sender: AnyObject) {
        //filters = CmykhalFilter
    }
    
    @IBAction func showori(sender: AnyObject) {
        filters = nil
    }
   
 

    @IBAction func changecamera(sender: AnyObject) {
        session.beginConfiguration()
    
        
        let newcamera = (currentDevice?.position == AVCaptureDevicePosition.Back) ? frontFacingCamera : backFacingCamera

        for input in session.inputs {
            session.removeInput(input as! AVCaptureDeviceInput)
        }
     
        do
        {
            let imageinput = try AVCaptureDeviceInput(device: newcamera)
            
            session.addInput(imageinput)
        }
        catch
        {
            print("error!")
            return
        }
        

        currentDevice = newcamera
        session.commitConfiguration()
    }
   
    @IBAction func flash(sender: AnyObject) {
        
        let device = AVCaptureDevice.defaultDeviceWithMediaType(AVMediaTypeVideo)
        
        if (device.hasTorch) {
            do {
                try device.lockForConfiguration()
                if (device.torchMode == AVCaptureTorchMode.On) {
                    device.torchMode = AVCaptureTorchMode.Off
                } else {
                    do {
                        try device.setTorchModeOnWithLevel(1.0)
                    } catch {
                        print(error)
                    }
                }
                device.unlockForConfiguration()
            } catch {
                print(error)
            }
        }
        
    }
    /*
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        let screenSize = imageshow.bounds.size
        if let touchPoint = touches.first {
            let y = 1.0 - touchPoint.locationInView(imageshow).y / screenSize.height
            let x = touchPoint.locationInView(imageshow).x / screenSize.width
            let focusPoint = CGPoint(x: x, y: y)
            
            if let device = currentDevice {
                do {
                    try device.lockForConfiguration()
                    
                    device.focusPointOfInterest = focusPoint
                   
                    device.focusMode = .AutoFocus
                   
                    device.exposurePointOfInterest = focusPoint
                    device.exposureMode = AVCaptureExposureMode.ContinuousAutoExposure
                    device.unlockForConfiguration()
                }
                catch {
                  
                }
            }
        }
    }
    
    */
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}
