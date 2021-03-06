//
//  ViewController.swift
//  collection_scroll
//
//  Created by Vijay Adhikari on 02/09/2017.
//  Copyright © 2017 Vijay Adhikari. All rights reserved.
//

import UIKit

class ViewController: UIViewController , UICollectionViewDataSource, UICollectionViewDelegate {
    let dateCellIdentifier = "DateCellIdentifier"
    let contentCellIdentifier = "ContentCellIdentifier"
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if #available(iOS 10.0, *) {
            collectionView!.isPrefetchingEnabled = false
        }
        
        self.collectionView .register(UINib(nibName: "DateCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: dateCellIdentifier)
        self.collectionView .register(UINib(nibName: "ContentCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: contentCellIdentifier)
    }
    
    
    // MARK - UICollectionViewDataSource
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 50
    }
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 50
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 8
    }
    
    
    internal func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.section == 0 {
            if indexPath.row == 0 {
                let dateCell : DateCollectionViewCell = collectionView .dequeueReusableCell(withReuseIdentifier: dateCellIdentifier, for: indexPath as IndexPath) as! DateCollectionViewCell
                dateCell.backgroundColor = UIColor.white
                dateCell.dateLabel.font = UIFont.systemFont(ofSize: 13)
                dateCell.dateLabel.textColor = UIColor.black
                dateCell.dateLabel.text = "Date"
                
                return dateCell
            } else {
                let contentCell : ContentCollectionViewCell = collectionView .dequeueReusableCell(withReuseIdentifier: contentCellIdentifier, for: indexPath as IndexPath) as! ContentCollectionViewCell
                contentCell.contentLabel.font = UIFont.systemFont(ofSize: 13)
                contentCell.contentLabel.textColor = UIColor.black
                contentCell.contentLabel.text = "Section"
                
                if indexPath.section % 2 != 0 {
                    contentCell.backgroundColor = UIColor(white: 242/255.0, alpha: 1.0)
                } else {
                    contentCell.backgroundColor = UIColor.white
                }
                
                return contentCell
            }
        } else {
            if indexPath.row == 0 {
                let dateCell : DateCollectionViewCell = collectionView .dequeueReusableCell(withReuseIdentifier: dateCellIdentifier, for: indexPath as IndexPath) as! DateCollectionViewCell
                dateCell.dateLabel.font = UIFont.systemFont(ofSize: 13)
                dateCell.dateLabel.textColor = UIColor.black
                dateCell.dateLabel.text = String(indexPath.section)
                if indexPath.section % 2 != 0 {
                    dateCell.backgroundColor = UIColor(white: 242/255.0, alpha: 1.0)
                } else {
                    dateCell.backgroundColor = UIColor.white
                }
                
                return dateCell
            } else {
                let contentCell : ContentCollectionViewCell = collectionView .dequeueReusableCell(withReuseIdentifier: contentCellIdentifier, for: indexPath as IndexPath) as! ContentCollectionViewCell
                contentCell.contentLabel.font = UIFont.systemFont(ofSize: 13)
                contentCell.contentLabel.textColor = UIColor.black
                contentCell.contentLabel.text = "Content"
                if indexPath.section % 2 != 0 {
                    contentCell.backgroundColor = UIColor(white: 242/255.0, alpha: 1.0)
                } else {
                    contentCell.backgroundColor = UIColor.white
                }
                
                return contentCell
            }
        }
    }
}

