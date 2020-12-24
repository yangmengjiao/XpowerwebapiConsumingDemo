//
//  AddDeedViewController.swift
//  interview3
//
//  Created by mengjiao on 12/24/20.
//

import UIKit

/// Add Deed
class AddDeedViewController: UIViewController {
    
    // input fields of user name
    @IBOutlet var name: UITextField!
    
    // input fields of deed
    @IBOutlet var deed: UITextField!
    
    // networking service for add deed
    var service = PostDataService(XpowerwebEndpoint.AddDeeds)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.topItem?.title = Constant.Title.addDeed
        
        service.delegate = self
    }
    
    //MARK：- Actions
    @IBAction func touchSave(_ sender: UIButton) {
        save()
    }
    
    //MARK：- Help Functions
    
    // save deeds
    func save() {
        let data = Deed(name.text ?? "",
                        deed.text ?? "")
        service.performPostJson(data)
    }
}

//MARK：- PostDataServiceDelegate
extension AddDeedViewController: PostDataServiceDelegate {
    func didPostEntity<T>(_ entity: T) where T : Decodable, T : Encodable {
        //dismiss view controller
        DispatchQueue.main.async {
            self.navigationController?.popViewController(animated: true)
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
