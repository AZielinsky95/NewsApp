//
//  NetworkManager.swift
//  NewsApp
//
//  Created by Alejandro Zielinsky on 2018-06-26.
//  Copyright © 2018 Alejandro Zielinsky. All rights reserved.
//

import Foundation
import UIKit

class NetworkManager
{
    static func downloadImage(urlString:String,completion: @escaping (UIImage) -> ()) {

            let configuration = URLSessionConfiguration.default
            let session: URLSession = URLSession(configuration: configuration)
            guard let imageURL = URL(string: urlString) else { return }
            
            let downloadTask: URLSessionDownloadTask = session.downloadTask(with: imageURL) { (url, response, error)  in
                guard let urlContent = url else { return; }
                let data = NSData(contentsOf: urlContent)
                guard let image = UIImage(data: data! as Data) else { completion(#imageLiteral(resourceName: "default")); return }
                completion(image)
            }
            
            downloadTask.resume()
    }
    
    static func getTopHeadlines(completion: @escaping ([NewsItem]) -> Void)
    {
        let sessionConfig = URLSessionConfiguration.default
        
        let session = URLSession(configuration: sessionConfig, delegate: nil, delegateQueue: nil)
        
        guard let url = URL(string: "https://newsapi.org/v2/top-headlines?sources=cbc-news&apiKey=0c6e14c6bfa049c28838aa3138761d4c") else {return}
        
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        /* Start a new Task */
        let task = session.dataTask(with: request, completionHandler: { (data: Data?, response: URLResponse?, error: Error?) -> Void in
            if (error == nil) {
                // Success
                let statusCode = (response as! HTTPURLResponse).statusCode
                print("URL Session Task Succeeded: HTTP \(statusCode)")
            }
            else {
                // Failure
                print("URL Session Task Failed: %@", error!.localizedDescription);
            }
            
            guard let json = try? JSONSerialization.jsonObject(with: data!) as? [String: Any] else { return }
            
            guard let jsonDictionary = json!["articles"]  as? [Dictionary<String, Any>] else { return }
            
            print(jsonDictionary)
            
            var newsItems = [NewsItem]()
            
            for dict in jsonDictionary
            {
                let title = dict["title"] as! String
                let imageURL = dict["urlToImage"] as? String
                let timestamp = dict["publishedAt"] as! String
                let newsURL = dict["url"] as! String
                let item = NewsItem(title: title, imageURL: imageURL, timestamp: timestamp, url: newsURL)
                newsItems.append(item)
            }
            
            completion(newsItems);
        })
        task.resume()
        session.finishTasksAndInvalidate()
    }
    
}
