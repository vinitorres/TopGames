//
//  Service.swift
//  TopGames
//
//  Created by Vinicius Torres on 11/22/17.
//  Copyright © 2017 Vinicius Torres. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class Service {
    
    static func getTopGames(refreshData:Bool, offset: Int, onComplete: @escaping (_ success: Bool)->()) {

        let headers = [Constants.Headers.CLIENT_ID:Constants.HeadersValues.CLIENT_ID_VALUE]
        var url = Constants.HttpRequestURL.BASE + Constants.HttpRequestURL.TOP_GAMES
        url = url + "?offset=\(offset)&limit=\(100)"
        
        Alamofire.request(url, method: .get, parameters: nil , encoding: JSONEncoding.default ,headers: headers).responseJSON(completionHandler: { response in
            
            if response.response?.statusCode == 200 {
                
                let data = response.data!
                let json =  JSON(data: data)
                let items = json["top"].array
                var games: [Game] = []
                
                for item in items! {
                    let game = Game(json: item)
                    games.append(game)
                }
                
                if refreshData && games.count > 0 {
                    print("entity clear on")
                    DBManager.refreshGameEntity(onComplete: { (sucess) in
                        if sucess {
                            DBManager.addGames(games: games, onComplete: { (sucess) in
                                if sucess {
                                    onComplete(true)
                                } else {
                                    onComplete(false)
                                }
                            })
                        }
                    })
                } else {
                    DBManager.addGames(games: games, onComplete: { (sucess) in
                        if sucess {
                            onComplete(true)
                        } else {
                            onComplete(false)
                        }
                    })
                }
                
                
            } else { onComplete(false) }
        })
        
    }
}
