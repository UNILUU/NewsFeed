//
//  YHDetailViewController.swift
//  News
//
//  Created by Xiaolu Tian on 3/28/19.
//

import UIKit

class YHDetailViewController: UIViewController {
    var imageH : NSLayoutConstraint?
    var imageW : NSLayoutConstraint?
    
    let scrollView : UIScrollView = {
        let view = UIScrollView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.alwaysBounceVertical = true
        return view
    }()
    let summary : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18)
        label.textColor = UIColor.darkGray
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()
    
    let publisher :UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let titleLebel :UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.boldSystemFont(ofSize: 25)
        label.textAlignment = .center
        label.textColor = UIColor.purple
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let date :UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 13)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let image : UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        view.image = UIImage(named: "yahoo")
        return view
    }()
    
    let viewModel : NewsViewModel
    
    let layoutmargin : CGFloat = 8
    init(_ viewModel : NewsViewModel) {
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
        view.backgroundColor = UIColor.white
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        let stackView = UIStackView(arrangedSubviews: [image,titleLebel,publisher, date,summary])
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.alignment = .fill
        stackView.spacing = 15
        stackView.distribution = .equalSpacing
        let safe = self.view.safeAreaLayoutGuide
        self.view.addSubview(scrollView)
        scrollView.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            
            stackView.leadingAnchor.constraint(equalTo: safe.leadingAnchor, constant: layoutmargin),
            stackView.trailingAnchor.constraint(equalTo: safe.trailingAnchor, constant: -layoutmargin),
            
            safe.topAnchor.constraint(equalTo: scrollView.topAnchor, constant:-layoutmargin),
            safe.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: layoutmargin),
            safe.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            safe.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            
        ])
        titleLebel.text = viewModel.title
        summary.text = viewModel.summary
        date.text = viewModel.publicTime
        publisher.text = viewModel.publisherName
        DetailViewDataManager.shared.getImagefor(viewModel) { [weak self ](res) in
            if case .success( let pic) = res {
                DispatchQueue.main.async {
                    self?.image.image = pic
                }
            }
        }
        
        super.viewDidLoad()
    }
 
}
