//
//  SearchViewController.swift
//  NewsApp
//
//  Created by Alejandro Zielinsky on 2018-06-28.
//  Copyright © 2018 Alejandro Zielinsky. All rights reserved.
//

import UIKit

protocol SearchViewControllerDelegate
{
    func searchForTopic(topic:String)
}

class SearchViewController: UITableViewController {

    var delegate : SearchViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        switch indexPath.row
        {
        case 0:
            //Tech
            delegate?.searchForTopic(topic: "Technology")
           self.navigationController?.popViewController(animated: true)
            break;
        case 1:
            //Sports
            delegate?.searchForTopic(topic: "Sports")
        self.navigationController?.popViewController(animated: true)
            break;
        case 2:
            //Politics
             delegate?.searchForTopic(topic: "Politics")
        self.navigationController?.popViewController(animated: true)
            break;
        case 3:
            //Politics
            delegate?.searchForTopic(topic: "Canada")
            self.navigationController?.popViewController(animated: true)
            break;
        case 4:
            //Politics
            delegate?.searchForTopic(topic: "Business")
            self.navigationController?.popViewController(animated: true)
            break;
        case 5:
            //Politics
            delegate?.searchForTopic(topic: "Health")
            self.navigationController?.popViewController(animated: true)
            break;
        case 6:
            //Politics
            delegate?.searchForTopic(topic: "Entertainment")
            self.navigationController?.popViewController(animated: true)
            break;
        case 7:
            //Politics
            delegate?.searchForTopic(topic: "World")
            self.navigationController?.popViewController(animated: true)
            break;
        default :
            break;
        }
    }

}

