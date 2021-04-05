//
//  ViewController.swift
//  News.com
//
//  Created by Justin Huang on 6/30/20.
//  Copyright © 2020 Justin Huang. All rights reserved.
//

import UIKit

class ViewController: UIViewController, ArticleModelProtocol {
    
    @IBOutlet weak var tableView: UITableView!
    
    var articles = [Article]()
    
    var model = ArticleModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        self.tableView.tableHeaderView = nil
        
        model.delegate = self
        model.getArticles()
        
        addRefreshControl()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        //hide the tabbar
        self.tabBarController?.tabBar.isHidden = true
    }

    func articlesRetrieved(_ articles: [Article]) {
        self.articles = articles
        
        tableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let indexPath = tableView.indexPathForSelectedRow
        
        guard indexPath != nil else {
            print("index path selected is nil")
            return
        }
        
        let article = articles[indexPath!.row]
        if indexPath?.row == 0 {
            let detailVc = segue.destination as! DetailViewControllerOne
            
            detailVc.articleUrl = article.url
        }
            
        else {
            let detailVcTwo = segue.destination as! DetailViewControllerTwo
            
            detailVcTwo.articleUrl = article.url
            
       }
        
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return articles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 {
            
            let firstCell = tableView.dequeueReusableCell(withIdentifier: "DataCellOne", for: indexPath) as! DataCellOne
            
            let firstArticle = articles[indexPath.row]
            
            firstCell.displayArticle(firstArticle)
            
            return firstCell
        }
            
        else {
        
            let cell = tableView.dequeueReusableCell(withIdentifier: "DataCellTwo", for: indexPath) as! DataCellTwo
            
            let article = articles[indexPath.row]
            
            cell.displayArticle(article)
            
            return cell
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 236
        }
        return UITableView.automaticDimension
    }
    
    
}

//MARK: Creating the refresh when pulled
extension ViewController {
    
    func addRefreshControl() {
        let refresh = UIRefreshControl()
        
        refresh.addTarget(self, action: #selector(refreshFeed(refreshControl:)), for: .valueChanged)
        
        //add to the tableview
        self.tableView.addSubview(refresh)
    }
    
    @objc func refreshFeed(refreshControl: UIRefreshControl){
        
        model.getArticles()
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
            refreshControl.endRefreshing()
        }
    }
}

