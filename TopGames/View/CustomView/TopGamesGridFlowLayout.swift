//
//  TopGamesGridFlowLayout.swift
//  TopGames
//
//  Created by Vinicius Torres on 11/23/17.
//  Copyright © 2017 Vinicius Torres. All rights reserved.
//

import UIKit

class TopGamesGridFlowLayout: UICollectionViewFlowLayout {
    
    var itemHeight: CGFloat = 180

    override init() {
        super.init()
        setupLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupLayout()
    }
    
    func setupLayout() {
        self.sectionInset = UIEdgeInsetsMake(8, 8, 8, 8)
        minimumInteritemSpacing = 2
        minimumLineSpacing = 8
        scrollDirection = .vertical
    }

    func itemWidth() -> CGFloat {
        return collectionView!.frame.width/2 - 12
    }
    
    override var itemSize: CGSize {
        set {
            self.itemSize = CGSize(width: itemWidth(), height: itemHeight)
        }
        get {
            return CGSize(width: itemWidth(), height: itemHeight)
        }
    }
    
    override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint) -> CGPoint {
        return collectionView!.contentOffset
    }
}
