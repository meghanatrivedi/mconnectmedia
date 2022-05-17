//
//  RegistationVC.swift
//  mconnectmedia
//
//  Created by Meghna on 17/05/22.
//

import UIKit

class RegistationVC: UIViewController {

    @IBOutlet weak var lblHeader: UILabel!
    @IBOutlet weak var headerBackView: UIView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblEmail: UILabel!
    @IBOutlet weak var lblPin: UILabel!
    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPin: UITextField!
    @IBOutlet weak var btnRegistation: UIButton!
    @IBOutlet weak var btnLogin: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prePareUI()
    }
}
extension RegistationVC{
    func prePareUI(){
        headerBackView.backgroundColor = .clear
        lblHeader.text = "Registration"
        lblHeader.textColor = .black
        lblHeader.font = lblHeader.font.withSize(24)
        
        lblName.text = "Full Name"
        lblName.textColor = .black
        lblName.font = lblName.font.withSize(20)
        
        
        lblEmail.text = "Email"
        lblEmail.textColor = .black
        lblEmail.font = lblHeader.font.withSize(20)
       

        
        lblPin.text = "Pin"
        lblPin.textColor = .black
        lblPin.font = lblHeader.font.withSize(20)
        
        
        
        btnRegistation.backgroundColor = .clear
        btnRegistation.layer.cornerRadius = 20
        btnRegistation.layer.borderWidth = 1
        btnRegistation.layer.borderColor = UIColor.black.cgColor
        btnRegistation.setTitleColor(.black, for: .normal)
        btnRegistation.setTitle("Register", for: .normal)


        btnLogin.setTitle("Already have an account?", for: .normal)
        btnLogin.setTitleColor(.blue, for: .normal)
        btnLogin.backgroundColor = .clear
       
    }
}
extension RegistationVC{
    @IBAction func btnRegistationAction(_ sender: UIButton) {
        
        if !(txtEmail.text?.isValidEmail())!{
            self.showToast(message: "Please Enter Valid Email!")
        }else if (txtName.text == "" && txtEmail.text == "" && txtPin.text == ""){
            self.showToast(message: "Please Enter Data!")
        }
        else{
            let defaultsEmail = UserDefaults.standard
            defaultsEmail.set(txtEmail.text, forKey: "emailid")
            defaultsEmail.synchronize()
            
            let defaultsPin = UserDefaults.standard
            defaultsPin.set(txtPin.text, forKey: "pin")
            defaultsPin.synchronize()
            
            
            self.showToast(message: "Registaion Successfully!")
            let story = UIStoryboard(name: "Main", bundle:nil)
            let vc = story.instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
            UIApplication.shared.windows.first?.rootViewController = vc
            UIApplication.shared.windows.first?.makeKeyAndVisible()
            
//        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
//         let vc = storyBoard.instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
//         self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    @IBAction func btnLoginAction(_ sender: UIButton) {
        
        let story = UIStoryboard(name: "Main", bundle:nil)
        let vc = story.instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
        UIApplication.shared.windows.first?.rootViewController = vc
        UIApplication.shared.windows.first?.makeKeyAndVisible()
//        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
//         let vc = storyBoard.instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
//         self.navigationController?.pushViewController(vc, animated: true)
    }

}
