//
//  ViewController.swift
//  News
//
//  Created by Xiaolu Tian on 3/28/19.
//

import UIKit

class ViewController: UIViewController {
    let viewModel : NewsViewModel
    init(_ viewModel : NewsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}
