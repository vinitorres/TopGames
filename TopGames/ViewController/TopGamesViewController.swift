//
//  TopGamesViewController.swift
//  TopGames
//
//  Created by Vinicius Torres on 11/22/17.
//  Copyright © 2017 Vinicius Torres. All rights reserved.
//

import UIKit

class TopGamesViewController: UIViewController {
    
    @IBOutlet var collectionView: UICollectionView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var emptyLabel: UILabel!
    
    var listGames: [GameEntity] = []
    var selectedGame: GameEntity?
    var viewSize = CGSize()
    var refreshData = false
    
    var numberOfItems: Int = 0 {
        didSet {
            print("new value of numberOfItems: \(numberOfItems)")
            self.activityIndicator.stopAnimating()
            self.collectionView.reloadData()
        }
    }
    
    let manager = Reachability.init()
    
    private let refreshControl = UIRefreshControl()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.register(UINib(nibName: "TopGamesCollectionCell", bundle: nil), forCellWithReuseIdentifier: "gameCell")
                
        refreshControl.addTarget(self, action: #selector(refreshGameList(_:)), for: .valueChanged)
        collectionView.refreshControl = self.refreshControl

        activityIndicator.startAnimating()
        self.loadDataFromDB()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loadDataFromDB() {
        
        self.emptyLabel.isHidden = true
        self.activityIndicator.startAnimating()
        
        let tempListGames = DBManager.getGames(offset: listGames.count)
    
        if tempListGames.count > 0 {
            for game in tempListGames {
                listGames.append(game)
            }
            if numberOfItems < 100 {
                numberOfItems += tempListGames.count
            }
            activityIndicator.stopAnimating()
        }
        
        if listGames.count == 0 {
            self.loadDataFromURL()
        }
        
    }
    
    func loadDataFromURL() {
        if (manager?.isReachable)! {
            Service.getTopGames(refreshData: refreshData, offset: 0) { (gamesResult) in
                if gamesResult {
                    if self.refreshData {
                        self.refreshControl.endRefreshing()
                        self.numberOfItems = 0
                        self.listGames.removeAll()
                        self.refreshData = false
                    }
                    self.loadDataFromDB()
                }
            }
        } else {
            
            self.activityIndicator.stopAnimating()
            self.collectionView.refreshControl?.endRefreshing()
            
            if listGames.count == 0 {
                self.emptyLabel.isHidden = false
            }

            let alert = UIAlertController(title: "", message: "Você precisa estar conectado para atualizar a lista de games.", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default, handler: { (action) in
                alert.dismiss(animated: true, completion: nil)
            })
            
            alert.addAction(okAction)
            
            self.present(alert, animated: true, completion: nil)
        
        }
    }
    
    @objc func refreshGameList(_ sender: Any) {
        refreshData = true
        self.loadDataFromURL()
    }
    
    @objc func getMoreGames(_ sender: Any) {
        self.loadDataFromDB()
    }

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detailsSegue" {
            let detailsVC = segue.destination as! DetailsViewController
            detailsVC.navigationItem.backBarButtonItem?.title = ""
            detailsVC.game = selectedGame
            
        }
    }
}

extension TopGamesViewController: UICollectionViewDataSource, UICollectionViewDelegate {

    override func willRotate(to toInterfaceOrientation: UIInterfaceOrientation, duration: TimeInterval) {
        collectionView.collectionViewLayout.invalidateLayout()
    }
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return numberOfItems
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedGame = listGames[indexPath.row]
        self.performSegue(withIdentifier: "detailsSegue", sender: self)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "gameCell", for: indexPath) as! TopGamesCollectionViewCell
        cell.prepare(with: listGames[indexPath.row])
        return cell
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        if offsetY > contentHeight - scrollView.frame.size.height && listGames.count < 100 {
            print(listGames.count)
            self.loadDataFromDB()
        }
    }
    
}

