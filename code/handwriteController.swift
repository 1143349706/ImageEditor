//
//  handwriteController.swift
//  BeautifyCamera-v1
//
//  Created by pro on 16/8/31.
//  Copyright © 2016年 MengXu. All rights reserved.
//

import UIKit
import Photos


class HangWriteView: UIView {
 
     var path = UIBezierPath()
    
     var points = [CGPoint](count: 5, repeatedValue: CGPoint())
    
     var ptc = 0

    var lineWidth: CGFloat = 1.0 {
        didSet {
            self.path.lineWidth = lineWidth
        }
    }
   //default colorblack
   var colorused: UIColor = UIColor.blackColor()
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
       
        self.path.lineWidth = self.lineWidth
    }
    
    required  init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    
        self.path.lineWidth = self.lineWidth
    }
    
    override  func drawRect(rect: CGRect) {
        self.colorused.setStroke()
        self.path.stroke()
    }
    
    
    
    
    override  func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
           let touch: AnyObject? = touches.first
            self.ptc = 0
            self.points[0] = touch!.locationInView(self)
       
    }
    override  func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        let touch: AnyObject? = touches.first
        let point = touch!.locationInView(self)
          ptc = ptc + 1
           points[ptc] = point
        
            if (self.ptc == 4) {
                self.points[3] = CGPointMake((self.points[2].x + self.points[4].x)/2.0,
                                          (self.points[2].y + self.points[4].y)/2.0)
                self.path.moveToPoint(self.points[0])
                self.path.addCurveToPoint(self.points[3], controlPoint1:self.points[1],
                                          controlPoint2:self.points[2])
                self.setNeedsDisplay()
                self.points[0] = self.points[3]
                self.points[1] = self.points[4]
                self.ptc = 1
            }
            self.setNeedsDisplay()
        
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if self.ptc == 0{
            let touchPoint = self.points[0]
            self.path.moveToPoint(CGPointMake(touchPoint.x-1.0,touchPoint.y))
            self.path.addLineToPoint(CGPointMake(touchPoint.x+1.0,touchPoint.y))
            self.setNeedsDisplay()
        } else {
            self.ptc = 0
        }
    }
    
    func clear() {
        self.path.removeAllPoints()
        self.setNeedsDisplay()
    }
    
    func save(w:CGFloat,h:CGFloat) ->UIImage {
        UIGraphicsBeginImageContext(CGSizeMake(w,h))
        self.layer.renderInContext(UIGraphicsGetCurrentContext()!)
        let imagesave: UIImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return imagesave
    }

}




class handwriteController: UIViewController {
    var imagehandwrite : UIImage!
    var handwriting : HangWriteView!
    
    @IBOutlet weak var showimage: UIImageView!
    
    @IBOutlet weak var sender: UIStepper!
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if imagehandwrite.size.width > imagehandwrite.size.height {
            let ratio = imagehandwrite.size.width / imagehandwrite.size.height
        
        showimage.frame = CGRectMake(0,(showimage.frame.height - showimage.frame.width/ratio)/2,showimage.frame.width, showimage.frame.width/ratio)
        
        }
        if imagehandwrite.size.width < imagehandwrite.size.height {
            let ratio = imagehandwrite.size.width / imagehandwrite.size.height
            
            showimage.frame = CGRectMake((showimage.frame.width - showimage.frame.height * ratio)/2,0,showimage.frame.height * ratio, showimage.frame.height)
            
        }
        let drawViewFrame = showimage.frame
    
        handwriting = HangWriteView(frame: drawViewFrame)
        
       
        UIGraphicsBeginImageContext(self.view.frame.size)
       imagehandwrite?.drawInRect(self.showimage.bounds)
        
        let image: UIImage = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndImageContext()

        
    handwriting.backgroundColor = UIColor(patternImage: image)
    
        self.view.addSubview(handwriting)
        
        // Do any additional setup after loading the view.
    }
    var color: UIColor! = UIColor.blackColor()
    
    
    @IBAction func color1(sender: AnyObject) {
        color = UIColor.redColor()
        handwriting.colorused = color
    }
    @IBAction func color2(sender: AnyObject) {
        color = UIColor.blueColor()
        handwriting.colorused = color

    }
    @IBAction func color3(sender: AnyObject) {
        color = UIColor.greenColor()
        handwriting.colorused = color

    }
    @IBAction func color4(sender: AnyObject) {
        color = UIColor.whiteColor()
        handwriting.colorused = color

    }
    @IBAction func color5(sender: AnyObject) {
        color = UIColor.purpleColor()
        handwriting.colorused = color

    }
    @IBAction func color6(sender: AnyObject) {
        color = UIColor.brownColor()
        handwriting.colorused = color

    }
    
    @IBAction func color7(sender: AnyObject) {
        color = UIColor.yellowColor()
        handwriting.colorused = color

    }
    
    @IBAction func color8(sender: AnyObject) {
        color = UIColor.cyanColor()
        handwriting.colorused = color

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func changelength(sender: UIStepper) {
        handwriting.lineWidth = CGFloat(sender.value)
        widthnumber.text = Int(sender.value).description
    }
    
    
    @IBOutlet weak var widthnumber: UILabel!
    
    
    
    @IBAction func clear(sender: AnyObject) {
     self.handwriting.clear()
    }
    
    
    @IBAction func save(sender: AnyObject) {
        
        let image = self.handwriting.save(showimage.frame.width,h: showimage.frame.height)
        
        
        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
    }
    
    
    }
