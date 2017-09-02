//
//  CustomCollectionViewLayout.swift
//  collection_scroll
//
//  Created by Vijay Adhikari on 02/09/2017.
//  Copyright © 2017 Vijay Adhikari. All rights reserved.
//

import UIKit

class CustomCollectionViewLayout: UICollectionViewLayout {
    
    let numberOfColumns = 8
    var itemAttributes : NSMutableArray!
    var itemsSize : NSMutableArray!
    var contentSize : CGSize!
    
    override func prepare() {
        if self.collectionView?.numberOfSections == 0 {
            return
        }
        
        if (self.itemAttributes != nil && self.itemAttributes.count > 0) {
            for section in 0..<self.collectionView!.numberOfSections {
                let numberOfItems : Int = self.collectionView!.numberOfItems(inSection: section)
                for index in 0..<numberOfItems {
                    if section != 0 && index != 0 {
                        continue
                    }
                    
              
                    
                        let attributes : UICollectionViewLayoutAttributes = self.layoutAttributesForItem(at: NSIndexPath(item: index, section: section) as IndexPath)!
                    
                    if section == 0 {
                        var frame = attributes.frame
                        frame.origin.y = self.collectionView!.contentOffset.y
                        attributes.frame = frame
                    }
                    
                    if index == 0 {
                        var frame = attributes.frame
                        frame.origin.x = self.collectionView!.contentOffset.x
                        attributes.frame = frame
                    }
                }
            }
            return
        }
        
        if (self.itemsSize == nil || self.itemsSize.count != numberOfColumns) {
            self.calculateItemsSize()
        }
        
        var column = 0
        var xOffset : CGFloat = 0
        var yOffset : CGFloat = 0
        var contentWidth : CGFloat = 0
        var contentHeight : CGFloat = 0
        
        for section in 0..<self.collectionView!.numberOfSections {
            var sectionAttributes = NSMutableArray()
            
            for index in 0..<numberOfColumns {
                var itemSize = (self.itemsSize[index] as AnyObject).cgSizeValue
               
                 var indexPath = NSIndexPath(item: index, section: section)
                
                
                
                  var attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath as IndexPath)
                
               // attributes.frame = CGRectIntegral(CGRectMake(xOffset, yOffset, itemSize.width, itemSize?.height))
                
                 attributes.frame = CGRect(x: xOffset, y: yOffset, width: (itemSize?.width)!, height: (itemSize?.height)!).integral
                
                
                
                if section == 0 && index == 0 {
                    attributes.zIndex = 1024;
                } else  if section == 0 || index == 0 {
                    attributes.zIndex = 1023
                }
                
                if section == 0 {
                    var frame = attributes.frame
                    frame.origin.y = self.collectionView!.contentOffset.y
                    attributes.frame = frame
                }
                if index == 0 {
                    var frame = attributes.frame
                    frame.origin.x = self.collectionView!.contentOffset.x
                    attributes.frame = frame
                }
                
                sectionAttributes.add(attributes)
                
                xOffset += (itemSize?.width)!
                column += 1
                
                if column == numberOfColumns {
                    if xOffset > contentWidth {
                        contentWidth = xOffset
                    }
                    
                    column = 0
                    xOffset = 0
                    yOffset += (itemSize?.height)!
                }
            }
            if (self.itemAttributes == nil) {
                self.itemAttributes = NSMutableArray(capacity: self.collectionView!.numberOfSections)
            }
            self.itemAttributes .add(sectionAttributes)
        }
        
        let attributes : UICollectionViewLayoutAttributes = (self.itemAttributes.lastObject as AnyObject).lastObject as! UICollectionViewLayoutAttributes
        contentHeight = attributes.frame.origin.y + attributes.frame.size.height
        self.contentSize = CGSize(width: contentWidth, height: contentHeight)
    }
    
    
    
    
    override var collectionViewContentSize: CGSize {
        return self.contentSize
    }
  /*
    override func layoutAttributesForItemAtIndexPath(indexPath: NSIndexPath) -> UICollectionViewLayoutAttributes! {
        return self.itemAttributes[indexPath.section][indexPath.row] as! UICollectionViewLayoutAttributes
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        var attributes = [UICollectionViewLayoutAttributes]()
        if self.itemAttributes != nil {
            for section in self.itemAttributes {
                
                let filteredArray  =  (section as AnyObject).filtered(
                    
                    NSPredicate(block: { (evaluatedObject, bindings) -> Bool in
                       // return rect.intersects(evaluatedObject.frame)

                       return rect.intersects(attributes.frame)
                    })
                    ) as! [UICollectionViewLayoutAttributes]?
                
                
                attributes.appendContentsOf(filteredArray)
                
            }
        }
        
        return attributes
    }
 */
    
    
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        //return self.itemAttributes[indexPath.section][indexPath.row] as! UICollectionViewLayoutAttributes
        let arr = self.itemAttributes[indexPath.section] as! NSMutableArray
        return arr[indexPath.row] as? UICollectionViewLayoutAttributes
    }
    
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        var attributes = [UICollectionViewLayoutAttributes]()
        if self.itemAttributes != nil {
            for section in self.itemAttributes {
                
                let filteredArray  =  (section as! NSMutableArray).filtered(
                    
                    using: NSPredicate(block: { (evaluatedObject , bindings) -> Bool in
                        let a = evaluatedObject as! UICollectionViewLayoutAttributes
                        return rect.intersects(a.frame)
                    })
                    ) as! [UICollectionViewLayoutAttributes]
                
                
                attributes.append(contentsOf: filteredArray)
                
            }
        }
        
        return attributes
    }
    
    
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
    
    func sizeForItemWithColumnIndex(columnIndex: Int) -> CGSize {
        var text : String = ""
        switch (columnIndex) {
        case 0:
            text = "Col 0"
        case 1:
            text = "Col 1"
        case 2:
            text = "Col 2"
        case 3:
            text = "Col 3"
        case 4:
            text = "Col 4"
        case 5:
            text = "Col 5"
        case 6:
            text = "Col 6"
        default:
            text = "Col 7"
        }
        
        let size : CGSize = (text as NSString).size(attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: 17.0)])
        let width : CGFloat = size.width + 25
        return CGSize(width: width, height: 30)
        
    }
    
    func calculateItemsSize() {
        self.itemsSize = NSMutableArray(capacity: numberOfColumns)
        for index in 0..<numberOfColumns {
            self.itemsSize.add(NSValue(cgSize: self.sizeForItemWithColumnIndex(columnIndex: index)))
    }
 }
}
