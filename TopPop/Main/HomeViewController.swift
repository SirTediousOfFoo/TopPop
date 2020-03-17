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
    @IBOutlet private weak var menuViewWidth: NSLayoutConstraint!
    
    @IBOutlet private weak var menuButton: UIButton!
    @IBOutlet weak var sortAscendingButton: UIButton!
    @IBOutlet weak var sortNormalButton: UIButton!
    @IBOutlet weak var sortDescendingButton: UIButton!
    
    //MARK: - Lifecycle functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        initialSetup()
        setupTableView()
        getData()
    }
    
    func initialSetup(){
        
        menuViewWidth.constant = 0
        sortNormalButton.isSelected = true
       
        let refresher = UIRefreshControl()
        refresher.addTarget(self,
                            action: #selector(refreshWrapper),
                            for: .valueChanged)
        tableView.refreshControl = refresher
    }
    
    //MARK: - objc functions
    
    @objc private func refreshWrapper() {
            getData()
            sortNormalButton.isSelected = true
            sortDescendingButton.isSelected = false
            sortAscendingButton.isSelected = false
       }
    
    //MARK: - Menu functions
    
    @IBAction func menuButtonSelected(_ sender: Any) {
        if !menuButton.isSelected {
            menuViewWidth.constant = 180
            UIView.animate(withDuration: 0.5) {
                self.view.layoutIfNeeded()
            }
            menuButton.isSelected.toggle()
            tableView.isUserInteractionEnabled.toggle()
        }
        else {
            menuViewWidth.constant = 0
            UIView.animate(withDuration: 0.5) {
                self.view.layoutIfNeeded()
            }
            menuButton.isSelected.toggle()
            tableView.isUserInteractionEnabled.toggle()
        }
    }
    
    @IBAction func ascSortSelected(_ sender: Any) {
        if !sortAscendingButton.isSelected {
            sortAscendingButton.isSelected = true
            sortNormalButton.isSelected = false
            sortDescendingButton.isSelected = false
            
            chart.sort()
            tableView.reloadData()
        }
    }
    
    @IBAction func normalSortSelected(_ sender: Any) {
        if !sortNormalButton.isSelected {
            sortNormalButton.isSelected = true
            sortDescendingButton.isSelected = false
            sortAscendingButton.isSelected = false
            
            chart.sort(by: { $0.position < $1.position })
            tableView.reloadData()
        }
    }
    
    @IBAction func descSortSelected(_ sender: Any) {
        if !sortDescendingButton.isSelected {
            sortDescendingButton.isSelected = true
            sortAscendingButton.isSelected = false
            sortNormalButton.isSelected = false
            
            chart.sort(by: { $0.duration > $1.duration })
            tableView.reloadData()
        }
    }
    
    //MARK: - Navigation
    
    func navigateToAlbum(selectedTrack track: Track) {
        
        let albumViewController = storyboard?.instantiateViewController(withIdentifier: "AlbumViewController") as! SongDetailsViewController
        albumViewController.track = track

        self.present(albumViewController, animated: true)
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
        navigateToAlbum(selectedTrack: item)
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

