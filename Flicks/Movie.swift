//
//  Movie.swift
//  Flicks
//
//  Created by Xiang Yu on 9/14/17.
//  Copyright © 2017 Xiang Yu. All rights reserved.
//

import UIKit

private let params = ["api-key": "a07e22bc18f5cb106bfe4cc1f83ad8ed"]
private let resourceUrl = "https://api.themoviedb.org/3/movie/now_playing"

class Movie {
    var id: Int
    var title: String?
    var overview: String?
    var posterPath: String?
    var lowResPosterUrl: String? {
        guard let posterPathStr = posterPath else {
            print("invalid poster path")
            return posterPath
        }
        
        return "https://image.tmdb.org/t/p/w185" + posterPathStr
    }
    var highResPosterUrl: String? {
        guard let posterPathStr = posterPath else {
            print("invalid poster path")
            return posterPath
        }
        
        return "https://image.tmdb.org/t/p/w500" + posterPathStr
    }
    
    init(jsonResult: NSDictionary) {
        id = (jsonResult.value(forKeyPath: "id") as? Int) ?? -1
        
        title = jsonResult.value(forKeyPath: "title") as? String
        overview = jsonResult.value(forKeyPath: "overview") as? String
        posterPath = jsonResult.value(forKeyPath: "poster_path") as? String
        
    }
    
    class func fetchMovies(endpoint: String, successCallBack: @escaping (NSDictionary) -> (), errorCallBack: ((Error?) -> ())?) {
        let apiKey = "a07e22bc18f5cb106bfe4cc1f83ad8ed"
        let url = URL(string: "https://api.themoviedb.org/3/movie/\(endpoint)?api_key=\(apiKey)")!
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        let task: URLSessionDataTask = session.dataTask(with: request) { (data: Data?, response: URLResponse?, error: Error?) in
            if let error = error {
                errorCallBack?(error)
            } else if let data = data,
                let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as? NSDictionary {
                //print(dataDictionary)
                successCallBack(dataDictionary)
            }
        }
        task.resume()
    }
}
