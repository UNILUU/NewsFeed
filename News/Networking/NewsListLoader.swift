//
//  NewsListLoader.swift
//  News
//
//  Created by Xiaolu Tian on 3/28/19.
//

import Foundation

enum Result<T>{
    case failure
    case success(T)
}

class NewsListLoader {
    static let shared = NewsListLoader()
    
    private let session = URLSession.shared
    private init(){
    }

    func loadNewList(_ count : Int, _ completion : @escaping (Result<NewsListResponse>) -> Void ){
        let urlPath = "https://doubleplay-sports-yql.media.yahoo.com/v3/sports_news?leagues=sports&stream_type=headlines&count=\(count)&region=US&lang=en-US"
        guard let url = URL(string:urlPath) else {
            completion(Result.failure)
            return
        }

        let task = session.dataTask(with: url) { (data, _, error) in
            guard error == nil else {
                completion(Result.failure)
                return
            }
            if let data = data, let list = try? JSONDecoder().decode(NewsListResponse.self, from: data){
                completion(Result.success(list))
            }
        }
        task.resume()
    }
    
    
    func fetchMore(_ ids : [String], _ completion : @escaping (Result<InflationResponse>) -> Void ){
        let res  = ids.joined(separator: ",")
        let urlstr = "https://doubleplay-sports-yql.media.yahoo.com/v3/news_items?uuids=\(res)"
        guard let url = URL(string: urlstr) else {
             completion(Result.failure)
            return
        }
        
        let task = session.dataTask(with: url) { (data, _, error) in
            guard error == nil else {
                 completion(Result.failure)
                return
            }
            if let data = data , let res = try? JSONDecoder().decode(InflationResponse.self, from: data) {
                completion(Result.success(res))
            }
        }
        task.resume()
    }
}



