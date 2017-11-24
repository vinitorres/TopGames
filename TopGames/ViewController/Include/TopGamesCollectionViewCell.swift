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
    @IBOutlet var positionLabel: UILabel!


    override func awakeFromNib() {
        super.awakeFromNib()
        self.contentView.layer.cornerRadius = 4
        self.clipsToBounds = true
        self.contentView.layer.borderWidth = 1
        self.contentView.layer.borderColor = UIColor.clear.cgColor
    }
    
    func prepare(with gameForRow: GameEntity, position: Int) {
        
        let resource = ImageResource(downloadURL: URL(string: gameForRow.imageLogo!)!, cacheKey: gameForRow.imageLogo)
        logoImageView.kf.setImage(with: resource)
        nameLabel.text = gameForRow.name
        positionLabel.text = "\(position)º"
        
    }
    
}
