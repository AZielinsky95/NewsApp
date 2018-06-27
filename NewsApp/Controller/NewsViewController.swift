//
//  ViewController.swift
//  NewsApp
//
//  Created by Alejandro Zielinsky on 2018-06-26.
//  Copyright © 2018 Alejandro Zielinsky. All rights reserved.
//

import UIKit

class NewsViewController: UIViewController {

    var topHeadlines = [NewsItem]()
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.barTintColor = UIColor.red
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
        
        NetworkManager.getTopHeadlines() { (newsitems) in
            DispatchQueue.main.async {
                self.topHeadlines = newsitems
                self.collectionView.reloadData()
            }
        }
    }
}

extension NewsViewController: UICollectionViewDataSource
{
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! NewsCell
        cell.imageView.image = topHeadlines[indexPath.row].image
        cell.title.text = topHeadlines[indexPath.row].title
        cell.timestamp.text = topHeadlines[indexPath.row].timestamp
        
        if(topHeadlines[indexPath.row].image == nil)
        {
            if let url = topHeadlines[indexPath.row].imageURL
            {
                NetworkManager.downloadImage(urlString: url, completion: { (img) in
                    DispatchQueue.main.async {
                        self.topHeadlines[indexPath.row].image = img
                        collectionView.reloadData()
                    }
                })
            }
        }
        
        cell.layer.shadowColor = UIColor.black.cgColor
        cell.layer.shadowOpacity = 0.5
        cell.layer.shadowOffset = CGSize.zero
        cell.layer.shadowRadius = 5
        cell.clipsToBounds = false
        cell.layer.masksToBounds = false
        return cell
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.topHeadlines.count
    }
    
}

