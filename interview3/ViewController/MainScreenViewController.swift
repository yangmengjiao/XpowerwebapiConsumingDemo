//
//  ViewController.swift
//  interview3
//
//  Created by mengjiao on 12/22/20.
//

import UIKit

/// main screen .
class MainScreenViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.topItem?.title = Constant.Title.mainScreen

    }
    
    @IBAction func touchButton(_ sender: UIButton) {
        let tag = Tag(rawValue: sender.tag)!
        
        tag.performSegue(vc: self)
        
    }
}

/// Enum of Button's tag
enum Tag: Int {
    case CreateUser
    case ShowPointsTable
    case AddDeed
    case SearchDeeds
    
    // Perform segue
    func performSegue(vc: UIViewController){
        vc.performSegue(withIdentifier: self.indentifier(), sender: self)
    }
    
   private func indentifier() -> String {
        switch self {
        case .CreateUser:
            return Constant.Identifier.createUser
        case .ShowPointsTable:
            return Constant.Identifier.showPointsTable
        case .AddDeed:
            return Constant.Identifier.addDeed
        case .SearchDeeds:
            return Constant.Identifier.searchDeeds
        }
    }
}
