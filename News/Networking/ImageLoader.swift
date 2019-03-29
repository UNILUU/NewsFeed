//
//  ImageLoader.swift
//  News
//
//  Created by Xiaolu Tian on 3/27/19.
//

import Foundation
import UIKit

class ImageLoader {
    static let shared = ImageLoader()
    var dict = [String: URLSessionDataTask]()
    
    private let session = URLSession.shared
    private init(){
    }
    
    func downloadImage(_ urlString : String, _ completion : @escaping (Result<UIImage>) -> Void ){
        guard let url = URL(string:urlString) else {
            completion(Result.failure)
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { [weak self](data, _, error) in
            guard error == nil else {
                completion(Result.failure)
                self?.dict[urlString] = nil
                return
            }
            
            if let data = data, let image = UIImage(data: data){
                DispatchQueue.main.async {
                    completion(Result.success(image))
                }
                self?.dict[urlString] = nil
            }
        }
        task.resume()
        dict[urlString] = task
    }
    
    func cancelTask(imageURL : String){
        if let task = dict[imageURL]{
            task.cancel()
            print("cancel")
            dict[imageURL] = nil
        }
    }
}
