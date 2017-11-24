//
//  Constants.swift
//  TopGames
//
//  Created by Vinicius Torres on 11/22/17.
//  Copyright © 2017 Vinicius Torres. All rights reserved.
//

import Foundation

class Constants {
    
    struct Colors {
        static let THEME = "#4B377C"
    }
    

    struct HttpRequestURL {
        static let BASE: String = "https://api.twitch.tv/kraken/"
        static let TOP_GAMES: String = "games/top"
    }
    
    struct Headers {
        static let CLIENT_ID = "Client-ID"
    }
    
    struct HeadersValues {
        static let CLIENT_ID_VALUE = "uv7o83w0jb3gm2batum6iqlif3fi7r"
    }
    
}
