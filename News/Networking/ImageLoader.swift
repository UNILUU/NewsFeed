//
//  ImageLoader.swift
//  News
//
//  Created by Xiaolu Tian on 3/28/19.
//

import Foundation
import UIKit

class ImageLoader {
    static let shared = ImageLoader()
    var dict = [String: URLSessionDataTask]()
    
    private let session = URLSession.shared
    private init(){
    }
    
    func downloadImage(_ url : URL, _ completion : @escaping (Result<UIImage>) -> Void ){
        let task = URLSession.shared.dataTask(with: url) { [weak self](data, _, error) in
            guard error == nil else {
                completion(Result.failure)
                self?.dict[url.absoluteString] = nil
                return
            }
            
            if let data = data, let image = UIImage(data: data){
                DispatchQueue.main.async {
                    completion(Result.success(image))
                }
                self?.dict[url.absoluteString] = nil
            }
        }
        task.resume()
        dict[url.absoluteString] = task
    }
    
    func cancelTask(imageURL : String){
        if let task = dict[imageURL]{
            task.cancel()
            dict[imageURL] = nil
        }
    }
}
