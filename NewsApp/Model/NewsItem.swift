//
//  NewsItem.swift
//  NewsApp
//
//  Created by Alejandro Zielinsky on 2018-06-26.
//  Copyright © 2018 Alejandro Zielinsky. All rights reserved.
//

import UIKit
import Foundation

class NewsItem: NSObject {

    let title : String
    let imageURL : String?
    var image : UIImage?
    let timestamp : String
    let url : String
    
    init(title:String,imageURL:String?,timestamp:String,url:String) {
        self.title = title
        self.imageURL = imageURL
        self.url = url
        
        //
        let dateComponents = timestamp.components(separatedBy: "T")
       // let timeComponents = dateComponents[1].components(separatedBy: ".")
       // let result = dateComponents[0] + " " + timeComponents[0]
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd" //HH:mm:ss"
        formatter.timeZone = TimeZone.current
        let date = formatter.date(from: dateComponents[0])
        formatter.dateFormat = "MMM dd"
        self.timestamp  = formatter.string(from: date!)
        
        super.init()
//
//        if let imgURL = self.imageURL
//        {
//            NetworkManager.downloadImage(urlString: imgURL, completion: { [weak self](img) in
//                DispatchQueue.main.async {
//                    self?.image = img
//                }
//            })
//        }
//        else
//        {
//            self.image = #imageLiteral(resourceName: "default")
//        }
    }
    
    func formatTimestamp(time:String) -> String
    {
        let dateComponents = time.components(separatedBy: "T")
        let timeComponents = dateComponents[1].components(separatedBy: ".")
        
        let result = dateComponents[0] + " " + timeComponents[0]
//
       let formatter = DateFormatter()
      // formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        formatter.dateFormat = "MMM dd"
        
       let date = formatter.date(from: result)
        // let now = Date()


        return formatter.string(from: date!)
     //   date?.timeIntervalSinceNow
        
        //let t = DateComponents(hour:)
//        if(Calendar.current.isDateInToday(date!))
//        {
//           print(date?.timeIntervalSinceNow)
////            let timeInterval = date?.timeIntervalSinceNow
////            let hoursAgo = timeInterval as! Double / 60
////            print(hoursAgo)
//        }
//
       // print(j);
    }
    
}
