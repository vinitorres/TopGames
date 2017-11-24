//
//  Game.swift
//  TopGames
//
//  Created by Vinicius Torres on 11/22/17.
//  Copyright © 2017 Vinicius Torres. All rights reserved.
//

import Foundation
import SwiftyJSON

class Game {
    
    var imageBoxUrl: String?
    var imageLogoUrl: String?
    var name: String?
    var viewers: Int?
    var channels: Int?
    
    init() {
        
    }
    
    init(json: JSON) {
        
        let game:JSON = json["game"]
    
        let name = game["name"].string ?? ""
        let viewers = json["viewers"].int ?? 0
        let channels = json["channels"].int ?? 0
        
        let boxUrls:JSON = game["box"]
        let logoUrls:JSON = game["logo"]
    
        let imageBoxUrl = boxUrls["large"].string
        let imageLogoUrl = logoUrls["large"].string

        self.imageBoxUrl = imageBoxUrl
        self.imageLogoUrl = imageLogoUrl
        self.name = name
        self.viewers = viewers
        self.channels = channels
    }
}
