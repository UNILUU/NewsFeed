//
//  DataManager.swift
//  News
//
//  Created by Xiaolu Tian on 3/27/19.
//

import Foundation
import UIKit


protocol NewsListDataManagerDelegate : class{
    func dataHasUpdated(needRefresh: Bool)
}

class NewsListDataManager {
    static let shared = NewsListDataManager()
    let listLoader = NewsListLoader.shared
    let imageLoader = ImageLoader.shared
    private var newsMap : [String: News]
    private var newsViewModel : [String: NewsViewModel]
    private var moreNews : [NewsID]
    
    var sortedList : [NewsViewModel]{
        didSet{
            delegate?.dataHasUpdated(needRefresh: true)
        }
    }
    private var imageCache = NSCache<NSString, UIImage>()
    
    
    
    weak var delegate : NewsListDataManagerDelegate?
    private init(){
        newsMap = [String: News]()
        newsViewModel = [String: NewsViewModel]()
        sortedList = [NewsViewModel]()
        moreNews = [NewsID]()
    }
    
    
    func fetchNewList(){
        listLoader.loadNewList(10) { (result) in
            if case .success(let res) = result{
                self.mergeNewList(res.items.result)
                self.mergeMore(res.more.result)
            }
        }
    }
    
    func fetchMoreData(){
        var i = 0
        var ids = [String]()
        while i < moreNews.count && i < 10{
            ids.append(moreNews.removeFirst().uuid)
            i += 1
        }
        listLoader.fetchMore(ids) { (result) in
            if case .success(let res) = result {
                self.mergeNewList(res.items.result)
            }
        }
    }

    
    
    func getNewViewModelFor(_ index: IndexPath) -> NewsViewModel {
        return sortedList[index.row]
    }
    
    
    func getImageFor(_ index : IndexPath, completion: @escaping (UIImage? ) -> Void){
        guard let urlString = sortedList[index.row].thumbnailURL else {
            completion(nil)
            return
        }
        
        //find in cache
        if let image = imageCache.object(forKey: urlString as NSString){
            DispatchQueue.main.async {
                completion(image)
            }
            return
        }

        //download
        print("download")
        imageLoader.downloadImage(urlString) { [weak self] (result) in
            if case .success(let image) = result {
                DispatchQueue.main.async {
                    completion(image)
                }
                self?.imageCache.setObject(image, forKey: urlString as NSString)
            }else {
                completion(nil)
            }
        }
    }
    
    private func mergeNewList(_ responselist : [News]) {
        var hasChange = false
        for news in responselist{
            if let _ = newsMap[news.uuid]{
                if news != newsMap[news.uuid]! {   //data updated from server
                    newsMap[news.uuid] = news
                    newsViewModel[news.uuid] = NewsViewModel(news)
                    hasChange = true
                }
            }else{
                // new data
                newsMap[news.uuid] = news
                newsViewModel[news.uuid] = NewsViewModel(news)
                hasChange = true
            }
        }
        if hasChange{
            sortedList = newsViewModel.values.sorted(by: >)
        }else{
            delegate?.dataHasUpdated(needRefresh: false)
        }
    }
    
    private func mergeMore(_ response : [NewsID]){
        for id in response{
            if !moreNews.contains(id) && newsMap[id.uuid] == nil{
                moreNews.append(id)
            }
        }
    }
}

