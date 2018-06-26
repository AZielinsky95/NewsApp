//
//  NewsItem.swift
//  NewsApp
//
//  Created by Alejandro Zielinsky on 2018-06-26.
//  Copyright © 2018 Alejandro Zielinsky. All rights reserved.
//

import UIKit

class NewsItem: NSObject {

    let title : String
    let imageURL : String?
    var image : UIImage?
    let timestamp : String
    let url : String
    
    init(title:String,imageURL:String?,timestamp:String,url:String) {
        self.title = title
        self.imageURL = imageURL
        self.timestamp = timestamp
        self.url = url

        super.init()
        
        if let imgURL = self.imageURL
        {
            NetworkManager.downloadImage(urlString: imgURL, completion: { [weak self](img) in
                DispatchQueue.main.async {
                    self?.image = img
                }
            })
        }
        else
        {
            self.image = #imageLiteral(resourceName: "default")
        }
    }
    
}
