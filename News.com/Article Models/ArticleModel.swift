//
//  ArticleModel.swift
//  News.com
//
//  Created by Justin Huang on 7/1/20.
//  Copyright © 2020 Justin Huang. All rights reserved.
//

import Foundation

protocol ArticleModelProtocol {
    func articlesRetrieved(_ articles:[Article])
}

class ArticleModel {
    
    var delegate:ArticleModelProtocol?
    
    func getArticles() {
        let stringUrl = "https://newsapi.org/v2/top-headlines?country=us&apiKey=75607a4252374a94bb75f209b91db074"
        
        let url = URL(string: stringUrl)
        
        guard url != nil else {
            print("url is nil")
            return
        }
        
        let session = URLSession.shared
        
        let dataTask = session.dataTask(with: url!) { (data, response, error) in
            if error == nil && data != nil {
                
                let decoder = JSONDecoder()
                
                do {
                    //parse the JSON into articles
                    let articleService = try decoder.decode(ArticleService.self, from: data!)
                    
                    //put the article from articleService into article
                    let article = articleService.articles
                    
                    DispatchQueue.main.async {
                        self.delegate?.articlesRetrieved(article!)
                    }
                    
                } catch {
                    print("failed to parse JSON")
                    return
                }
            }
        }
        dataTask.resume()
    }
    
}
