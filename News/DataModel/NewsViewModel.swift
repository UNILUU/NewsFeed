//
//  NewsViewModel.swift
//  News
//
//  Created by Xiaolu Tian on 3/28/19.
//

import Foundation

struct NewsViewModel: Comparable{
    let uuid : String
    let title : String
    let publicTime : String?
    var thumbnailURL : String?
    var thumbnailH : Int?
    var thumbnailW : Int?
    var imageURL : String?
    var imageH : Int?
    var imageW : Int?
    
    let publisherName: String
    let summary : String
    private let rowData : Double
    
    init(_ news: News) {
        uuid = news.uuid
        title = news.title
        summary = news.summary
        if news.main_image.resolutions.count > 2{
            thumbnailURL = news.main_image.resolutions[2].url
            thumbnailH = news.main_image.resolutions[2].height
            thumbnailW = news.main_image.resolutions[2].width
        }
        if news.main_image.resolutions.count > 1{
            imageURL = news.main_image.resolutions[1].url
            imageH = news.main_image.resolutions[1].height
            imageW = news.main_image.resolutions[1].width
        }
        
        publicTime = NewsViewModel.convertDate(news.published_at)
        rowData = Double(news.published_at)!
        publisherName = news.publisher
    }
    
    static func convertDate(_ date : String) -> String{
        let date = Date(timeIntervalSince1970: Double(date)!)
        let dayTimePeriodFormatter = DateFormatter()
        dayTimePeriodFormatter.dateFormat = "MMM dd YYYY hh:mm"
        return dayTimePeriodFormatter.string(from: date)
    }
    
    static func < (ls: NewsViewModel, rs: NewsViewModel) -> Bool{
        return ls.rowData < rs.rowData
    }
    
}
