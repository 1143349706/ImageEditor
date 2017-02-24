//
//  keyboardController.swift
//  BeautifyCamera-v1
//
//  Created by pro on 16/8/31.
//  Copyright © 2016年 MengXu. All rights reserved.
//

import UIKit
import CoreImage
import Photos

class keyboardController: UIViewController,  UIPickerViewDelegate
{
    var font : String! = "TimesNewRomanPS-BoldMT"
    let pickerData = ["TimesNewRomanPS-BoldMT","SnellRoundhand-Bold","AmericanTypewriter-Bold","Zapfino","PingFangTC-Thin","Superclarendon-Black","HoeflerText-BlackItalic"]

    var imagekeyboard: UIImage!
    var color: UIColor! = UIColor.blackColor()
    @IBOutlet weak var showarea: UIImageView!
    
    @IBOutlet weak var textinput: UITextField!
    
    @IBOutlet weak var sizesender: UISlider!
    
    @IBOutlet weak var showimage: UIImageView!
    
    @IBOutlet weak var fontstyle: UIPickerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    showimage.image = imagekeyboard
        
        if imagekeyboard.size.width > imagekeyboard.size.height {
            let ratio = imagekeyboard.size.width / imagekeyboard.size.height
            
            showimage.frame = CGRectMake(0,(showimage.frame.height - showimage.frame.width/ratio)/2,showimage.frame.width, showimage.frame.width/ratio)
            
        }
        if imagekeyboard.size.width < imagekeyboard.size.height {
            let ratio = imagekeyboard.size.width / imagekeyboard.size.height
            
            showimage.frame = CGRectMake((showimage.frame.width - showimage.frame.height * ratio)/2,0,showimage.frame.height * ratio, showimage.frame.height)
            
        }

        fontstyle.delegate = self
        
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    
    //Delegates
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        font = pickerData[row]
    }

    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func inputfinish(sender: AnyObject) {
        let ratio1 = CGFloat(imagekeyboard.size.width) / showimage.frame.width
        let ratio2 = CGFloat(imagekeyboard.size.height) / showimage.frame.height
        
        showimage.image = imagekeyboard.watermark(textinput.text!,
                                         x: (showarea.frame.minX - showimage.frame.minX)*ratio1, y :(showarea.frame.minY - showimage.frame.minY)*ratio2,
                                         color:  color,
                                         font: UIFont(name: font, size: CGFloat(sizesender.value))!,
                                         
                                         backgroundColor: UIColor.clearColor())
    }

    
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
       textinput.resignFirstResponder()
        
    }
    @IBAction func color1(sender: AnyObject) {
        color = UIColor.redColor()
    }
    @IBAction func color2(sender: AnyObject) {
        color = UIColor.blueColor()
    }
    @IBAction func color3(sender: AnyObject) {
        color = UIColor.greenColor()
    }
    @IBAction func color4(sender: AnyObject) {
        color = UIColor.whiteColor()
    }
    @IBAction func color5(sender: AnyObject) {
        color = UIColor.purpleColor()
    }
    @IBAction func color6(sender: AnyObject) {
        color = UIColor.brownColor()
    }
    
    @IBAction func color7(sender: AnyObject) {
        color = UIColor.yellowColor()
    }
    
    @IBAction func color8(sender: AnyObject) {
        color = UIColor.cyanColor()
    }
    
    @IBAction func handlePanwatertext(recognizer:UIPanGestureRecognizer) {
        let translation = recognizer.translationInView(self.view)
        if let view = recognizer.view {
            view.center = CGPoint(x:view.center.x + translation.x,
                                  y:view.center.y + translation.y)
            
        }
        recognizer.setTranslation(CGPointZero, inView: self.view)
        
        
    }
    @IBAction func save(sender: AnyObject) {
        
        PHPhotoLibrary.sharedPhotoLibrary().performChanges({
            PHAssetChangeRequest.creationRequestForAssetFromImage(self.showimage.image!)
            }, completionHandler: { (isSuccess: Bool, error: NSError?) in
                if isSuccess {
                    print("success!")
                } else{
                    print("fail：", error!.localizedDescription)
                }
        })

    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }

}
