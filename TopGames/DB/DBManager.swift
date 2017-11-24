//
//  DBManager.swift
//  TopGames
//
//  Created by Vinicius Torres on 11/22/17.
//  Copyright © 2017 Vinicius Torres. All rights reserved.
//

import UIKit
import CoreData

class DBManager {
    
    static func getContext () -> NSManagedObjectContext {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
        
    }
    
    static func addGames(games: [Game], onComplete: @escaping (_ success: Bool)->()) {
        
        let context = self.getContext()
        
        for game in games {
            
            let entity =  NSEntityDescription.entity(forEntityName: "GameEntity", in: context)

            let gameEntity = NSManagedObject(entity: entity!, insertInto: context)
            
            gameEntity.setValue(game.imageLogoUrl, forKey: "imageLogo")
            gameEntity.setValue(game.imageBoxUrl, forKey: "imageBox")
            gameEntity.setValue(game.name, forKey: "name")
            gameEntity.setValue(game.channels, forKey: "channels")
            gameEntity.setValue(game.viewers, forKey: "viewers")
         
        }
        
        do {
            try context.save()
            print("games salvos! \(games.count)")
            onComplete(true)
        } catch let error as NSError  {
            print("Could not save \(error), \(error.userInfo)")
            onComplete(false)
        }
    }
    
    static func getGames(offset: Int) -> [GameEntity] {
        
        var games: [GameEntity] = []
        
        do {
            
            let fetchRequest: NSFetchRequest<GameEntity> = GameEntity.fetchRequest()
            fetchRequest.fetchOffset = offset
            fetchRequest.fetchLimit = 10
            let searchResults = try self.getContext().fetch(fetchRequest)
            
            for game in searchResults as [NSManagedObject] {
                games.append(game as! GameEntity)
            }
            
        } catch {
            print("Error with request: \(error)")
        }
        
        return games
    }

    static func refreshGameEntity(onComplete: @escaping (_ success: Bool)->()){
        
        let context = self.getContext()
        let fetchRequest: NSFetchRequest<GameEntity> = GameEntity.fetchRequest()

        let searchResults = try! self.getContext().fetch(fetchRequest)
        
        for result in searchResults as [NSManagedObject] {
            context.delete(result)
            print("game excluido")
        }
        
        do {
            try context.save()
            onComplete(true)
        } catch {
            print(error.localizedDescription)
            print ("There was an error")
            onComplete(false)
        }
    }
    
}
