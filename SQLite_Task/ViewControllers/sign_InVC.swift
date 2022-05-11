
import UIKit

class sign_InVC: UIViewController,UITextFieldDelegate {
    var loginBtn = UIButton()
    var userBtn = UIButton()
    var textFieldArray = [UITextField]()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .cyan
        setUpWelcomeName()
        labelNames()
        setUpLoginBtn()
        textfiledSetUp()
        userUpLoginBtn()
        loginBtn.addTarget(self, action: #selector(clickOnLogin), for: .touchUpInside)
        userBtn.addTarget(self, action: #selector(clickOnAccountCreate), for: .touchUpInside)
        
        for text in textFieldArray
        {
            text.delegate = self
        }
        
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        
        return true
    }
    
    //Clear textfiled
    
    func clearTextFiled()
    {
        for textClear in textFieldArray
        {
            textClear.text = " "
        }
    }
    
    
    @objc func clickOnLogin()
    {

        do {
            let conversionDecodeData = UserDefaults.standard.value(forKey: "userData")
            let result =  try JSONDecoder().decode([userModels].self, from: conversionDecodeData as! Data)
            
            for resultData in result
            {
                if(resultData.username == textFieldArray[0].text!  && resultData.pass == textFieldArray[1].text!)
                {
                    clearTextFiled()
                    let vc =  ViewController()
                    let nav = UINavigationController(rootViewController: vc)
                    vc.modalTransitionStyle = .crossDissolve
                    vc.modalPresentationStyle = .fullScreen
                    present(nav, animated:true , completion: nil)
                }
                else
                {
                   
                    alertFunction.shared.alert(title: "Alert", msg: "userName and Password Error")
                }
                
            }
        } catch  {
            print("Error in Decoding")
        }
    }
  
   @objc func clickOnAccountCreate()
   {
        let vc = userRegisterFormVC()
        self.navigationController?.pushViewController(vc, animated: true)
        
   }
}

extension sign_InVC
{
    func setUpWelcomeName()  {
        var loginName = UILabel(frame: CGRect(x: 50, y: 100, width: 250, height: 50))
        loginName.text = "WelCome to School"
        loginName.font = UIFont.systemFont(ofSize: 25, weight: .bold)
        loginName.textColor = .blue
        loginName.textAlignment = .center
        view.addSubview(loginName)
    }
    
    //MARK:- Label Setup
    func labelNames() {
         var labelname = ["UserName","Password"]
        
        var y = 300
        
        for i in labelname
        {
            var lblName = UILabel(frame: CGRect(x:10, y: y, width: 150, height: 40))
            y = y + 50
            lblName.text = i
            lblName.font = UIFont.systemFont(ofSize: 20, weight: .bold)
            lblName.textColor = .link
            view.addSubview(lblName)
        }
    }
    
    //MARK:- Textfiled setUp
    func textfiledSetUp()  {
        var placeholder = ["UserName","Password"]
       var y = 300
       for i in placeholder
       {
           var txtFields = UITextField(frame: CGRect(x:130, y: y, width: 230, height: 30))
          y = y + 50
        txtFields.placeholder = i
        textFieldArray.append(txtFields)
        txtFields.borderStyle = .roundedRect
        txtFields.layer.cornerRadius = 10
        txtFields.layer.borderWidth = 1
        view.addSubview(txtFields)
       }
   }
    
//MARK:-Login Button
    func setUpLoginBtn() {
        loginBtn.frame = CGRect(x: 280, y: 430, width: 80, height: 35)
        loginBtn.setTitle("Login", for: .normal)
        loginBtn.setTitleColor(.blue, for: .normal)
        loginBtn.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        loginBtn.backgroundColor = .white
        loginBtn.layer.borderWidth = 1
        loginBtn.layer.cornerRadius = 10
        view.addSubview(loginBtn)
    }
    

    //MARK:- Create User Button
        func userUpLoginBtn() {
            userBtn.frame = CGRect(x: 20, y: 430, width: 150, height: 35)
            userBtn.setTitle("Create Account", for: .normal)
            userBtn.setTitleColor(.blue, for: .normal)
            userBtn.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .bold)
            userBtn.backgroundColor = .white
            userBtn.layer.borderWidth = 1
            userBtn.layer.cornerRadius = 10
            view.addSubview(userBtn)
        }
}

