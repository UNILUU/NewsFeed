//
//  YHNewsTableViewCell.swift
//  News
//
//  Created by Xiaolu Tian on 3/27/19.
//

import UIKit

class YHNewsTableViewCell: UITableViewCell {
    var imageH : NSLayoutConstraint?
    var imageW : NSLayoutConstraint?
    
    static let reuseIdentifier = "YHNewsTableViewCell"
    let layoutMargin : CGFloat = 8.0
   
    let newsImage : UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(named: "yahoo")
        return image
    }()
    
    let title : UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.textColor = UIColor(red: 114/255, green: 14/255, blue: 158/255, alpha: 1)
        label.numberOfLines = 5
        return label
    }()
    
    let publishLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 13)
        label.textColor = UIColor.gray
        return label
    }()
    let publisherLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 13)
        label.textColor = UIColor.gray
        label.numberOfLines = 2
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        let stackView = UIStackView(arrangedSubviews: [title,publisherLabel,publishLabel])
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.alignment = .fill
        stackView.spacing = 4
        stackView.distribution = .equalSpacing
        self.contentView.addSubview(stackView)
        self.contentView.addSubview(newsImage)
        
        NSLayoutConstraint.activate([
            self.contentView.leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: -layoutMargin),
            self.contentView.trailingAnchor.constraint(equalTo: newsImage.trailingAnchor, constant: layoutMargin),
      
            stackView.trailingAnchor.constraint(equalTo: newsImage.leadingAnchor, constant: -layoutMargin),
            stackView.centerYAnchor.constraint(equalTo: newsImage.centerYAnchor),
            self.contentView.bottomAnchor.constraint(equalTo: newsImage.bottomAnchor, constant: layoutMargin),
            self.contentView.topAnchor.constraint(equalTo: newsImage.topAnchor, constant: -layoutMargin),
            ])
        
        imageH = imageView?.heightAnchor.constraint(equalToConstant: 100)
        imageW = imageView?.widthAnchor.constraint(equalToConstant: 100)
        imageW?.isActive = true
        imageH?.isActive = true
    }
    
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setImageHW(_ width: Int, _ height: Int){
        imageH?.isActive = false
        imageW?.isActive = false
        newsImage.heightAnchor.constraint(equalToConstant: CGFloat(integerLiteral: width)).isActive = true
        newsImage.widthAnchor.constraint(equalToConstant: CGFloat(integerLiteral: height)).isActive = true
        setNeedsLayout()
    }
    
    
    func setData(_ news : NewsViewModel) {
        title.text = news.title
        publishLabel.text = news.publicTime
        publisherLabel.text = news.publisherName
        setImageHW(news.thumbNailW, news.thumbNailH)
    }

    override func prepareForReuse() {
        publishLabel.text = nil
        title.text = nil
        publisherLabel.text = nil
        newsImage.image = UIImage(named: "yahoo")
        imageW?.isActive = true
        imageH?.isActive = true
    }
}
