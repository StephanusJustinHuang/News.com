//
//  DataCellOne.swift
//  News.com
//
//  Created by Justin Huang on 6/30/20.
//  Copyright © 2020 Justin Huang. All rights reserved.
//

import UIKit

class DataCellOne: UITableViewCell {
    
    
    @IBOutlet weak var view: UIView!
    
    @IBOutlet weak var articleHeadline: UILabel!
    
    @IBOutlet weak var firstArticleImage: UIImageView!
    
    var articleToDisplay:Article?
    
    func displayArticle(_ article:Article){
        
        articleHeadline.text = ""
        articleHeadline.alpha = 0
        firstArticleImage.image = nil
        firstArticleImage.alpha = 0
        
        articleToDisplay = article
        
        articleHeadline.text = articleToDisplay?.title
        articleHeadline.alpha = 1
        
        guard articleToDisplay?.urlToImage != nil else{
            print("no url image")
            return
        }
        
        let urlImageString = articleToDisplay!.urlToImage!
        
        //check the cachemanager so they don't have to reload if there is already image
        if let imageData = CacheManager.retrieveData(urlImageString) {
            
            firstArticleImage.image = UIImage(data: imageData)
            firstArticleImage.alpha = 1
            return
        }
        
        
        let url = URL(string: urlImageString)
            
        let session = URLSession.shared
        
        let dataTask = session.dataTask(with: url!) { (data, response, error) in
            if error == nil && data != nil {
                
                CacheManager.saveData(urlImageString, data!)
                
                if self.articleToDisplay?.urlToImage == urlImageString {
                    DispatchQueue.main.async {
                        self.firstArticleImage.image = UIImage(data: data!)
                        self.firstArticleImage.alpha = 1
                    }
                }
            }
        }
        
        //kick in the data task
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
