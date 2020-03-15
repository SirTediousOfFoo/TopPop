//
//  ViewController.swift
//  TopPop
//
//  Created by five on 14/03/2020.
//  Copyright © 2020 Pero. All rights reserved.
//

import UIKit
import PromiseKit

class HomeViewController: UIViewController {

    //MARK: - Properties
    
    private var chart: Chart = []
    
    //MARK: - Outlets
    
    @IBOutlet private weak var tableView: UITableView!
    
    //MARK: - Lifecycle functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupTableView()
        getData()
        let refresher = UIRefreshControl()
        refresher.addTarget(self,
                            action: #selector(refreshWrapper),
                            for: .valueChanged)
        tableView.refreshControl = refresher
    }
    
    @objc private func refreshWrapper() {
           getData()
       }
    
    //MARK: - Data fetching
    
    private func getData(){
     
        firstly{
            APIManager.request(
                [Track].self,
                path: "https://api.deezer.com/chart/0/tracks",
                keyPath: "data")
        }.ensure { [weak self] in
            if self?.tableView.refreshControl?.isRefreshing ?? false
            {
                self?.tableView.refreshControl?.endRefreshing()
            }
        }.done { [weak self] chart in
            self?.chart = chart
            self?.tableView.reloadData()
        }.catch{ error in
            print(error.localizedDescription)
        }
    }
}

//MARK: - TableView functions

extension HomeViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return chart.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let tableViewCell = tableView.dequeueReusableCell(
            withIdentifier: String(describing: TrackCell.self),
            for: indexPath) as! TrackCell
        
        tableViewCell.configure(with: chart[indexPath.row])
        
        return tableViewCell
    }
}

extension HomeViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let item = chart[indexPath.row]
       //TODO: - Navigate next
    }
}

private extension HomeViewController {
    
    private func setupTableView() {
        
        tableView.estimatedRowHeight = 110
        tableView.rowHeight = UITableView.automaticDimension
        
        tableView.tableFooterView = UIView()

        tableView.delegate = self
        tableView.dataSource = self
    }
}

