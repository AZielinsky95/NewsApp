//
//  ViewController.swift
//  NewsApp
//
//  Created by Alejandro Zielinsky on 2018-06-26.
//  Copyright © 2018 Alejandro Zielinsky. All rights reserved.
//

import UIKit
import SafariServices

class NewsViewController: UIViewController {

    private var isCompactView = false
    
    var topHeadlines = [NewsItem]()
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
       // self.collectionView.la
        self.navigationController?.navigationBar.barTintColor = UIColor.init(red: (255/255), green: (105/255), blue: (120/255), alpha: 1)
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white,NSAttributedStringKey.font:UIFont(name: "Helvetica Neue", size: 22)!]
        
        NetworkManager.getTopHeadlines() { (newsitems) in
            DispatchQueue.main.async {
                self.topHeadlines = newsitems
                self.collectionView.reloadData()
            }
        }
    }
    
    @IBAction func compactViewTapped(_ sender: UIBarButtonItem)
    {
        isCompactView = !isCompactView
        collectionView.reloadData()
    }
    
}

extension NewsViewController: UICollectionViewDataSource
{
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        var cell = NewsCell()
        
        if(isCompactView)
        {
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: "compactCell", for: indexPath) as! NewsCell
        }
        else
        {
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! NewsCell
        }
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

extension NewsViewController: UICollectionViewDelegate,UICollectionViewDelegateFlowLayout
{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        guard let url = URL(string: topHeadlines[indexPath.row].url) else { return }
        let sfVC = SFSafariViewController(url: url)
        present(sfVC, animated: true, completion: nil)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if(isCompactView)
        {
            return CGSize(width: view.frame.width - 16, height: 100)
        }
        else
        {
            return CGSize(width: view.frame.width - 16, height: 325)
        }
    }
    
    
}

