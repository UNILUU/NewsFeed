//
//  News.swift
//  News
//
//  Created by Xiaolu Tian on 3/27/19.
//

import Foundation

struct News : Decodable, Equatable{
    let uuid: String
    let title : String
    let main_image : Image
    let published_at : String
    let publisher : String

}


struct Image : Decodable, Equatable{
    let original_url : String
    let original_height : Int
    let original_width : Int
    let resolutions : [thumbNail]
}

struct thumbNail: Decodable, Equatable{
    let url : String
    let height : Int
    let width : Int
}

struct NewsListResponse : Decodable{
    let items : NewsResult
}

struct NewsResult : Decodable{
    let result : [News]
}




struct NewsViewModel: Comparable{
    let uuid : String
    let title : String
    let publicTime : String?
    let thumbNailURL : String
    let thumbNailH : Int
    let thumbNailW : Int
    let publisherName: String
    private let rowData : Double
    
    init(_ news: News) {
        uuid = news.uuid
        title = news.title
        thumbNailURL = news.main_image.resolutions[2].url
        thumbNailH = news.main_image.resolutions[2].height
        thumbNailW = news.main_image.resolutions[2].width
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
