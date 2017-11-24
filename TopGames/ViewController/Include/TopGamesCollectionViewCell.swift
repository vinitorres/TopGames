//
//  TopGamesCollectionViewCell.swift
//  TopGames
//
//  Created by Vinicius Torres on 11/22/17.
//  Copyright © 2017 Vinicius Torres. All rights reserved.
//

import UIKit
import Foundation
import Kingfisher

class TopGamesCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var logoImageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        self.contentView.layer.cornerRadius = 4
        self.clipsToBounds = true
       // self.contentView.layer.masksToBounds = true
        self.contentView.layer.borderWidth = 0.5
        self.contentView.layer.borderColor = UIColor.black.cgColor
        
//        self.layer.shadowColor = UIColor.gray.cgColor
//        self.layer.shadowOffset = CGSize(width: 0, height: 2.0)
//        self.layer.shadowRadius = 2.0
//        self.layer.shadowOpacity = 1.0
//        self.layer.masksToBounds = false
//        self.layer.shadowPath = UIBezierPath(roundedRect:self.bounds, cornerRadius:self.contentView.layer.cornerRadius).cgPath
        
    }
    
    func prepare(with gameForRow: GameEntity) {
        
        let resource = ImageResource(downloadURL: URL(string: gameForRow.imageLogo!)!, cacheKey: gameForRow.imageLogo)
        logoImageView.kf.setImage(with: resource)
        nameLabel.text = gameForRow.name
        
    }
    
}
