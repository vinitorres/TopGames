//
//  DetailsViewController.swift
//  TopGames
//
//  Created by Vinicius Torres on 11/22/17.
//  Copyright © 2017 Vinicius Torres. All rights reserved.
//

import UIKit
import Kingfisher
import CoreData

class DetailsViewController: UIViewController {
    
    @IBOutlet var boxImageView: UIImageView!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var channelsCountLabel: UILabel!
    @IBOutlet var viewersCountLabel: UILabel!

    var game: GameEntity?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Game Detalhes"
        
        let resource = ImageResource(downloadURL: URL(string: (game?.imageBox!)!)!, cacheKey: game?.imageBox)

        boxImageView.kf.setImage(with: resource)
        nameLabel.text = game?.name
        channelsCountLabel.text = game?.channels.description
        viewersCountLabel.text = game?.viewers.description
        
    }

}
