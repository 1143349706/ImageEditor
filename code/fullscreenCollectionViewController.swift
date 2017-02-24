//
//  fullscreenCollectionViewController.swift
//  BeautifyCamera-v1
//
//  Created by pro on 16/9/8.
//  Copyright © 2016年 MengXu. All rights reserved.
//

import UIKit
import Photos


class fullscreenCollectionViewController: UICollectionViewController {
    
    var myAsset1 : PHAsset!
    var myAsset2 : PHAsset!
    var myAsset3 : PHAsset!
  
    
    var emptyArray : [Int] = []
    
    var assetsFetchResults:PHFetchResult!
    
    var thumbnailSize:CGSize!
    
    
    var manager:PHCachingImageManager!
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBarHidden = false
        let scale = UIScreen.mainScreen().scale
        let cellSize = (self.collectionViewLayout as! UICollectionViewFlowLayout).itemSize
        thumbnailSize = CGSizeMake( cellSize.width*scale , cellSize.height*scale)
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        
        let allPhotosOptions = PHFetchOptions()
        
        allPhotosOptions.sortDescriptors = [NSSortDescriptor(key: "creationDate",
            ascending: false)]
        
        allPhotosOptions.predicate = NSPredicate(format: "mediaType = %d",
                                                 PHAssetMediaType.Image.rawValue)
        assetsFetchResults = PHAsset.fetchAssetsWithMediaType(PHAssetMediaType.Image,
                                                              options: allPhotosOptions)
        
        
        self.manager = PHCachingImageManager()
        self.resetCachedAssets()
    }
    
    
    func resetCachedAssets(){
        self.manager.stopCachingImagesForAllAssets()
    }
    
    
    override func collectionView(collectionView: UICollectionView,
                                 numberOfItemsInSection section: Int) -> Int {
        
        return self.assetsFetchResults.count
        
    }
    
    
    override func collectionView(collectionView: UICollectionView,
                                 cellForItemAtIndexPath indexPath: NSIndexPath)
        -> UICollectionViewCell {
            
            
            let identify:String = "DesignViewCell"
            
            let cell = (self.collectionView?.dequeueReusableCellWithReuseIdentifier(
                identify, forIndexPath: indexPath))! as UICollectionViewCell
            
            
            let asset = self.assetsFetchResults[indexPath.row] as! PHAsset
            
            self.manager.requestImageForAsset(asset, targetSize: thumbnailSize,
                                                   contentMode: PHImageContentMode.AspectFill,
                                                   options: nil) { (image, nfo) in
                                                    (cell.contentView.viewWithTag(1) as! UIImageView).image = image
                                                    print(image)
            }
            return cell
    }
    
    
    
    override func collectionView(collectionView: UICollectionView,
                                 didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        
        emptyArray.append(indexPath.row)
        
        print(emptyArray)
        
        
        
        collectionView.allowsMultipleSelection = true
        
        let cell = collectionView.cellForItemAtIndexPath(indexPath)
        
        if cell?.selected == true{
            cell?.backgroundColor = UIColor.orangeColor()
            
        }
        else{
            cell?.backgroundColor = UIColor.clearColor()}
        
        
        
        
        
    }
    
    
    
    
    override func collectionView(collectionView: UICollectionView, didDeselectItemAtIndexPath indexPath: NSIndexPath) {
        let cell = collectionView.cellForItemAtIndexPath(indexPath)
        
        if cell?.selected == true {
            cell?.backgroundColor = UIColor.orangeColor()}
        else {
            cell?.backgroundColor = UIColor.whiteColor()}
        
    }
    
  
        
    @IBAction func selectfinish(sender: AnyObject) {
   
        myAsset1 = self.assetsFetchResults[emptyArray[0]] as! PHAsset
        myAsset2 = self.assetsFetchResults[emptyArray[1]] as! PHAsset
        myAsset3 = self.assetsFetchResults[emptyArray[2]] as! PHAsset
        
        let detailViewController = UIStoryboard(name: "Main", bundle: nil)
            .instantiateViewControllerWithIdentifier("fscreen")
            as! FullscreenViewController
        detailViewController.myAsset1 = myAsset1
        detailViewController.myAsset2 = myAsset2
        detailViewController.myAsset3 = myAsset3
        
        self.navigationController!.pushViewController(detailViewController,
                                                      animated:true)
    }
    
   
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

    }
