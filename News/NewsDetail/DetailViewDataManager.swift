//
//  DetailViewDataManager.swift
//  News
//
//  Created by Xiaolu Tian on 3/28/19.
//

import Foundation
import UIKit
class DetailViewDataManager {
    let imageloader = ImageLoader.shared
    static let shared = DetailViewDataManager()
    private var largeImageCache = NSCache<NSString, UIImage>()
    private init() {}
    
    
    
    func getImagefor(_ viewModel: NewsViewModel, _ completion: @escaping (Result<UIImage>) -> Void){
        if let imageURL = viewModel.imageURL, let url = URL(string: imageURL){
            
            let filename = String(url.lastPathComponent.split(separator: ".")[0])
            
            //Check cache
            if let image = largeImageCache.object(forKey: imageURL as NSString){
                completion(Result.success(image))
                return
            }
            
            //Check disk
            if let image = UIImage.getImageFrom(directory: .cachesDirectory, name: filename){
                largeImageCache.setObject(image, forKey: imageURL as NSString)
                print("got image from disk \(filename)")
                DispatchQueue.main.async {
                    completion(Result.success(image))
                }
                return
            }
            //download
            imageloader.downloadImage(url){[weak self](res) in
                if case .success( let pic) = res {
                    //save to disk
                    try? pic.save(directory: .cachesDirectory, name: filename)
                    self?.largeImageCache.setObject(pic, forKey: imageURL as NSString)
                    DispatchQueue.main.async {
                        completion(Result.success(pic))
                    }
                }
            }
            return
        }
        completion(Result.failure)
    }
}
