//
//  DataCellTwo.swift
//  News.com
//
//  Created by Justin Huang on 6/30/20.
//  Copyright © 2020 Justin Huang. All rights reserved.
//

import UIKit

class DataCellTwo: UITableViewCell {
    
    
    @IBOutlet weak var newsImage: UIImageView!
    
    @IBOutlet weak var articleHeadline: UILabel!
    
    var articleToDisplay:Article?
    
    func displayArticle(_ article:Article){
        
        //Make the image of the article has rounded corners
        newsImage.layer.cornerRadius = 8
        newsImage.clipsToBounds = true
        
        articleHeadline.text = ""
        newsImage.image = nil
        
        articleToDisplay = article
        
        articleHeadline.text = articleToDisplay?.title
        
        guard articleToDisplay?.urlToImage != nil else {
            newsImage.image = UIImage(named: "noImage")
            print("there is no image found")
            return
        }
        
        //Start to set and load the image
        
        let urlToImageString = articleToDisplay!.urlToImage!
        
        if let imageData = CacheManager.retrieveData(urlToImageString) {
            
            newsImage.image = UIImage(data: imageData)
            return
        }
        
        let url = URL(string: urlToImageString)
        
        guard url != nil else {
            newsImage.image = UIImage(named: "noImage")
            print("could not create url object")
            return
        }
        
        let session = URLSession.shared
        
        let dataTask = session.dataTask(with: url!) { (data, response, error) in
            if error == nil && data != nil {
                
                CacheManager.saveData(urlToImageString, data!)
                
                DispatchQueue.main.async {
                    self.newsImage.image = UIImage(data: data!)
                }
            }
        }
        
        dataTask.resume()
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
