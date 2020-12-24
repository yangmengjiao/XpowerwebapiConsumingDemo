//
//  ViewController.swift
//  interview3
//
//  Created by mengjiao on 12/22/20.
//

import UIKit

class MainScreenViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    
    @IBAction func touchButton(_ sender: UIButton) {
        switch sender.tag {
        case 0:
            self.performSegue(withIdentifier: "createUser", sender: self)
        case 1:
            self.performSegue(withIdentifier: "showPointsTable", sender: self)
        case 2:
            self.performSegue(withIdentifier: "addDeed", sender: self)
        case 3:
            self.performSegue(withIdentifier: "searchDeeds", sender: self)
        default:
            return
        }
    }
    
    
}
