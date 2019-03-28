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
    
    private let session = URLSession.shared
    private init(){
    }
    
    func downloadImage(_ urlString : String, _ completion : @escaping (Result<UIImage>) -> Void ){
        guard let url = URL(string:urlString) else {
            completion(Result.failure)
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { (data, _, error) in
            guard error == nil else {
                completion(Result.failure)
                return
            }
            
            if let data = data, let image = UIImage(data: data){
                DispatchQueue.main.async {
                    completion(Result.success(image))
                }
            }
        }
        task.resume()
    }
}
