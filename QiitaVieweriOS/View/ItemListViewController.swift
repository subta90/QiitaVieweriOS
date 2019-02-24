//
//  ArticleListViewController.swift
//  QiitaVieweriOS
//
//  Created by subta on 2019/02/23.
//  Copyright © 2019 subta90. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class ItemListViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
    
        
    }
}

extension ItemListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
        cell.textLabel?.text = "test"
        return cell
    }
    
    
}

