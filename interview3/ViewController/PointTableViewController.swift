//
//  PointTableViewController.swift
//  interview3
//
//  Created by mengjiao on 12/23/20.
//

import UIKit
/// Show the table of points
class PointTableViewController: UITableViewController {
    
    // pointstable list
    var points = [PointsTable]()
    
    // networking service for fetch data
    var service = FetchDataService<[PointsTable]>(XpowerwebEndpoint.GetPointsTable)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.topItem?.title = Constant.Title.pointsTable
        
        service.delegate = self
        service.performFetchData()
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return points.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constant.pointCell, for: indexPath)
        
        cell.textLabel?.text = points[indexPath.row].welcomeDescription
        
        return cell
        
    }
    
}

//MARK：- FetchDataServiceDelegate
extension PointTableViewController: FetchDataServiceDelegate {
    func didFetchData<T>(_ entity: T) where T : Decodable, T : Encodable {
        self.points = entity as! [PointsTable]
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func didFailWithError(error: Error) {
        
    }
}
