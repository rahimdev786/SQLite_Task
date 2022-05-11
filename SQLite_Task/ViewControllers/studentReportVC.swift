
import UIKit
import SQLite
class studentReportVC: UIViewController {
    var db:Connection?
var deleteBtn = UIButton()
var textData = [UITextField]()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray5
       db = dBhelper.shared.database
        setUpWelcomeName()
        textfiledSetUp()
        labelNames()
        Deletebtn()
        deleteBtn.addTarget(self, action: #selector(DeleteData), for: .touchUpInside)
    }
    
    @objc func DeleteData()
    {
          //let query = "CREATE TABLE myschool (studentID INTEGER PRIMARY KEY,studentname TEXT,studentage TEXT,gender TEXT ,fee INTEGER,city TEXT);"
        
//        let query = "UPDATE  myschool SET studentname = (?) where studentID = (?);"
  
        let query = "DELETE FROM myschool WHERE studentID = (?);"
        
        do {
                try db?.run(query,textData[0].text!)
           }
        catch
        {
             print("error in update")
         }
        
        textData[0].text = " "
    }
}
    extension studentReportVC
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
         var labelname = ["id"]
        
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
        var placeholder = ["Id"]
       var y = 300
       for i in placeholder
       {
           var txtFields = UITextField(frame: CGRect(x:130, y: y, width: 230, height: 30))
          y = y + 50
        txtFields.placeholder = i
        textData.append(txtFields)
        txtFields.borderStyle = .roundedRect
        txtFields.layer.cornerRadius = 10
        txtFields.layer.borderWidth = 1
        view.addSubview(txtFields)
       }
   }
    
//MARK:-Login Button
    func Deletebtn() {
        deleteBtn.frame = CGRect(x: 280, y: 430, width: 80, height: 35)
        deleteBtn.setTitle("Delete", for: .normal)
        deleteBtn.setTitleColor(.blue, for: .normal)
        deleteBtn.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        deleteBtn.backgroundColor = .white
        deleteBtn.layer.borderWidth = 1
        deleteBtn.layer.cornerRadius = 10
        view.addSubview(deleteBtn)
    }

}
