//
//  CreateUserViewController.swift
//  interview3
//
//  Created by mengjiao on 12/23/20.
//

import UIKit

class CreateUserViewController: UIViewController {
    
    // input field of user name
    @IBOutlet var name: UITextField!
    
    // input field of password
    @IBOutlet var pwd: UITextField!
    
    // input field of email
    @IBOutlet var email: UITextField!
    
    // networking service for create user
    var service = PostDataService(XpowerwebEndpoint.CreateUserAccount)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pwd.isSecureTextEntry = true
        
        service.delegate = self
        
        self.navigationController?.navigationBar.topItem?.title = Constant.Title.createUser
        
    }
    
    //MARK：- Actions
    @IBAction func touchSave(_ sender: UIButton) {
        save()
    }
    
    //MARK：- Help functions
    
    // save created user
    func save() {
        let user = User(Username: name.text ?? "",
                        Password: pwd.text ?? "",
                        Email: email.text ?? "",
                        SchoolName: Constant.defaultValue, // just for testing
                        Avatar: Constant.defaultValue, // just for testing
                        Avatarimageurl: "",
                        TouchIdOn: Constant.defaultValue) //just for testing
        
        service.performPostJson(user)
    }
    
}

//MARK：- NetWorkingServiceDelegate
extension CreateUserViewController: PostDataServiceDelegate {
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
