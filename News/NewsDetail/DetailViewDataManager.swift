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
        if let imageURL = viewModel.imageURL{
            if let image = largeImageCache.object(forKey: imageURL as NSString){
                completion(Result.success(image))
                return
            }
            imageloader.downloadImage(imageURL){[weak self](res) in
                if case .success( let pic) = res {
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
