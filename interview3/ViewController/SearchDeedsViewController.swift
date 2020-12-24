//
//  SearchDeedsViewController.swift
//  interview3
//
//  Created by mengjiao on 12/24/20.
//

import UIKit

class SearchDeedsViewController: UIViewController {
    // search text : user name
    var searchText = ""
    
    // networking service for fetch data
    var service: FetchDataService<DailyPoint>?
    
    // searching name text field
    @IBOutlet var name: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.topItem?.title = Constant.Title.searchDeeds
        
    }
    
    //MARK：- Actions
    @IBAction func touchSearch(_ sender: UIButton) {
        search()
    }
    
    //MARK：- Help Functions
    
    // search deeds by name
    func search() {
        searchText = name.text ?? ""
        
        service = FetchDataService(XpowerwebEndpoint.GetTotalPoints(name: searchText))
        service?.delegate = self
        
        service?.performFetchData()
    }
}

extension SearchDeedsViewController: FetchDataServiceDelegate {
    func didFetchData<T>(_ entity: T) where T : Decodable, T : Encodable {
        DispatchQueue.main.async {
            //show deeds points using alert
            let points = entity as! DailyPoint
            
            let ac = UIAlertController(title: "deeds points", message: "deeds points is :  \(points.dailypoints).", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            self.present(ac, animated: true)
            
        }
    }
    
    func didFailWithError(error: Error) {
        // show error alert
        DispatchQueue.main.async {
            let ac = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            self.present(ac, animated: true)
        }
    }
}
