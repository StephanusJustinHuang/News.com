//
//  CacheManager.swift
//  News.com
//
//  Created by Justin Huang on 7/5/20.
//  Copyright © 2020 Justin Huang. All rights reserved.
//

import Foundation

class CacheManager{
    static var imageDictionary = [String:Data]()
    
    static func saveData(_ url:String, _ imageData:Data){
        //save the image data with the url
        imageDictionary[url] = imageData
    }
    
    static func retrieveData(_ url:String) -> Data? {
        return imageDictionary[url]
    }
}
