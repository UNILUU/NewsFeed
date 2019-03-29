//
//  YHNewsTableViewController.swift
//  News
//
//  Created by Xiaolu Tian on 3/27/19.
//

import UIKit

class YHNewsTableViewController: UITableViewController{
    let dataManager : ListDataManager
    let refresher : UIRefreshControl = {
        let refresh = UIRefreshControl()
        refresh.addTarget(self, action: #selector(refreshView), for: UIControl.Event.valueChanged)
        return refresh
    }()
    
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        dataManager = ListDataManager.shared
        super.init(nibName: nil, bundle: nil)
        dataManager.delegate = self
        tableView.refreshControl = refresher
        tableView.register(YHNewsTableViewCell.self, forCellReuseIdentifier: YHNewsTableViewCell.reuseIdentifier)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    @objc func refreshView(){
        dataManager.fetchNewList()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if dataManager.sortedList.count == 0 {
            dataManager.fetchNewList()
        }
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataManager.sortedList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier:  YHNewsTableViewCell.reuseIdentifier, for: indexPath)
        assert(cell is YHNewsTableViewCell, "cell not valid")
        let dequeCell = cell as! YHNewsTableViewCell
        dequeCell.setData(dataManager.getNewViewModelFor(indexPath))
        return dequeCell
    }
    
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        assert(cell is YHNewsTableViewCell, "cell not valid")
        dataManager.getImageFor(indexPath) { [weak tableView] (image) in
            if let image = image, let tableCell = tableView?.cellForRow(at: indexPath) as? YHNewsTableViewCell{
                tableCell.newsImage.image = image
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
         dataManager.cancelTask(indexPath)
    }
    
    
    
    // MARK:  Incremental loading
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offseY = scrollView.contentOffset.y
        let contentH = scrollView.contentSize.height
        if offseY + scrollView.frame.height + 10 > contentH{
            dataManager.fetchMoreData()
        }
    }
    
    // MARK:  Nevigation
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailVC = YHDetailViewController(dataManager.getNewViewModelFor(indexPath))
        navigationController?.pushViewController(detailVC, animated: true)
    }
    
}


// MARK: ListDataManagerDelegate
extension YHNewsTableViewController : ListDataManagerDelegate{
    func dataHasUpdated(needRefresh: Bool){
        DispatchQueue.main.async {
            if needRefresh{
                self.tableView.reloadData()
            }
            self.refresher.endRefreshing()
        }
    }
}

