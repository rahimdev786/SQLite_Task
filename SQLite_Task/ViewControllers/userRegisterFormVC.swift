//
//  userRegisterFormVC.swift
//  SQLite_Task
//
//  Created by shaik Arshad on 07/08/2021.
//

import UIKit

class userRegisterFormVC: UIViewController,UITextFieldDelegate {

var textarratUserForm = [UITextField] ()
var saveButton = UIButton()
var userDataArray = [userModels]()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray5
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "xmark.octagon.fill"), style: .plain, target: self, action: #selector(backToLogin))
        self.navigationItem.hidesBackButton = true
        setUpLabelNames()
        setUpTextFileds()
        saveBtn()
        welcomeName()
      
        saveButton.addTarget(self, action:#selector(saveUserData), for: .touchUpInside)
        for text in  textarratUserForm
        {
            text.delegate = self
        }
    }

func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        textField.autocorrectionType = UITextAutocorrectionType.no
        textField.autocapitalizationType = UITextAutocapitalizationType.none
        return true
    }
    @objc func saveUserData()
    {
        userDataArray.append(userModels(username: textarratUserForm[0].text!, pass: textarratUserForm[1].text!, repass: textarratUserForm[2].text!))
        
        do {
            let userConvertData = try JSONEncoder().encode(userDataArray)
            
            UserDefaults.standard.setValue(userConvertData, forKey: "userData")
            UserDefaults.standard.synchronize()
            cleartextfiled()
        } catch  {
            print("error in ENcoding conversion ")
        }
         
        
    }
    @objc func backToLogin()
    {
        self.navigationController?.popViewController(animated: true)
    }
}

extension userRegisterFormVC
{
    func welcomeName() {
        var welcomeLabl = UILabel(frame: CGRect(x: 20, y: 100, width: 300, height: 40))
        welcomeLabl.text = "User Account Creation "
        welcomeLabl.font = UIFont.systemFont(ofSize:25, weight: .heavy)
        welcomeLabl.textColor = .orange
        view.addSubview(welcomeLabl)
    }
    func setUpLabelNames() {
        var labelNames = ["Username","Password","repassword"]
        var y = 200
        for i in labelNames
        {
            var lbl = UILabel(frame: CGRect(x: 10, y: y, width: 150, height: 50))
            y = y + 50
            lbl.text = i
            lbl.textColor = .systemOrange
            lbl.font = UIFont.systemFont(ofSize: 18, weight: .bold)
            view.addSubview(lbl)
        }
    }
    func setUpTextFileds()  {
    var labelNames = ["Username","Password","repassword"]
        var y = 200
        for i in labelNames
        {
            var textfiled = UITextField(frame: CGRect(x: 120, y: y, width: 230, height: 40))
            y = y + 50
            textfiled.placeholder = i
            textarratUserForm.append(textfiled)
            textfiled.borderStyle = .roundedRect
            textfiled.layer.cornerRadius = 10
            textfiled.layer.borderWidth = 1
            view.addSubview(textfiled)
        }
    }
    func  saveBtn()  {
         saveButton.frame = CGRect(x: 150, y: 400, width: 80, height: 35)
        saveButton.setTitle("Save", for: .normal)
        saveButton.setTitleColor(.blue, for: .normal)
        saveButton.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        saveButton.backgroundColor = .white
        saveButton.layer.borderWidth = 1
        saveButton.layer.cornerRadius = 10
            view.addSubview(saveButton)
        }
    
    func cleartextfiled()
    {
        
        for text in textarratUserForm
        {
            text.text = " "
        }
    }
}
