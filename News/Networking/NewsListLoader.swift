//
//  NewsListLoader.swift
//  News
//
//  Created by Xiaolu Tian on 3/27/19.
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
                print(list)
                completion(Result.success(list))
            }
        }
        task.resume()
    }
}



