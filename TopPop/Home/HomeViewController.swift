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

    private var chart: Chart = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        getData()
    }
    
    private func getData(){
        firstly{
            APIManager.request(
                [Track].self,
                path: "https://api.deezer.com/chart/0/tracks",
                keyPath: "data")
        }.done { [weak self] chart in
            self?.chart = chart
            print(self?.chart ?? "prazno")

        }.catch{ error in
            print(error.localizedDescription)
        }
    }
}

