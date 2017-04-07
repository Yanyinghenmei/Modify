//
//  ArtworkViewController.swift
//  Modify
//
//  Created by Daniel on 2017/3/28.
//  Copyright © 2017年 Daniel. All rights reserved.
//

import Cocoa

class ArtworkViewController: ContentViewController {
    @IBOutlet weak var topView: NSView!
 
    @IBOutlet weak var collectionView: NSCollectionView!
    @IBOutlet weak var tipImgView: NSImageView!
    var modelArray:NSMutableArray = NSMutableArray.init()
    
    override var urlArray: Array<URL>? {
        didSet{
            if (urlArray != nil) {
                
                for sourceUrl in urlArray! {
                    let model = ResourcesManager.creatArtworkImageModel(sourceUrl: sourceUrl)
                    modelArray.add(model)
                }
                
                tipImgView.isHidden = true
            } else {
                modelArray.removeAllObjects()
                tipImgView.isHidden = false
            }
            collectionView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        tipImgView.image = ResourcesManager.imageWithName(name: "DropArtwork")
    }
    
    override func viewDidLayout() {
        topView.layer?.backgroundColor = NSColor.white.cgColor
        collectionView.layer?.backgroundColor = NSColor.init(srgbRed: 249/255.00, green: 249/255.00, blue: 249/255.00, alpha: 1).cgColor

        collectionView.register(ArtworkCollectionItem.self, forItemWithIdentifier: "Artwork")
    }
    
    @IBAction func exportClick(_ sender: NSButton) {
        print("export")
    }
}

extension ArtworkViewController: NSCollectionViewDataSource {
    func collectionView(_ collectionView: NSCollectionView, numberOfItemsInSection section: Int) -> Int {
        return modelArray.count
    }
    func collectionView(_ collectionView: NSCollectionView, itemForRepresentedObjectAt indexPath: IndexPath) -> NSCollectionViewItem {
        
        let model = modelArray.object(at: indexPath.item) as! ArtworkImageModel
        
        let item = collectionView.makeItem(withIdentifier: "ArtworkCollectionItem", for: indexPath) as! ArtworkCollectionItem
        item.imgView?.image = model.minImage
        item.nameLabel.stringValue = model.name
        item.sizeLabel.stringValue = "\(Int(model.width))x\(Int(model.height))"
        item.originalLabel.stringValue = "Original: @\(model.original)x"
        return item
    }
}

extension ArtworkViewController: NSCollectionViewDelegate {
    func collectionView(_ collectionView: NSCollectionView, didSelectItemsAt indexPaths: Set<IndexPath>) {
        for indexPath in indexPaths {
            let item = collectionView.item(at: indexPath)
            item?.isSelected = true
        }
    }
}



