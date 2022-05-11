
import UIKit
import SQLite
class studentAdmissionVC: UIViewController,UITextFieldDelegate {
    var textfiledCollect = [UITextField] ()
    var saveButton = UIButton()
    var db:Connection?
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray5
      
        db =  dBhelper.shared.database
        dBhelper.shared.DBPathCreation()
        dBhelper.shared.createTableAndColumnName()
        welcomeName()
        setUpLabelNames()
        setUpTextFileds()
        saveBtn()
        saveButton.addTarget(self, action: #selector(savingDataInTable), for: .touchUpInside)
        
        for i in textfiledCollect
        {
            i.delegate = self
        }
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        textField.autocorrectionType = UITextAutocorrectionType.no
        textField.autocapitalizationType = UITextAutocapitalizationType.none
        return true
    }

    //MARK:- Clear textfiled
    func textFIledClear()
    {
        for i in textfiledCollect
        {
            i.text = " "
        }
    }
    //MARK:- Saving Data into Table
  @objc func savingDataInTable()
    {

    // let query = "CREATE TABLE myschool (studentID INTEGER PRIMARY KEY,studentname TEXT,studentage TEXT,gender TEXT ,fee INTEGER,city TEXT);"

    let query = "INSERT INTO myschool (studentname,studentage,gender,fee,city) VALUES (?,?,?,?,?);"
    do {
        try db?.run(query,textfiledCollect[0].text!,textfiledCollect[1].text!,textfiledCollect[2].text!,textfiledCollect[3].text!,textfiledCollect[4].text!)
        textFIledClear()
    } catch  {
        print("Error in insert Data into myschool Table")
    }

}

}
extension studentAdmissionVC
{
    func welcomeName() {
        var welcomeLabl = UILabel(frame: CGRect(x: 20, y: 100, width: 300, height: 40))
        welcomeLabl.text = "Student Admission "
        welcomeLabl.numberOfLines = 3
        welcomeLabl.font = UIFont.systemFont(ofSize:22, weight: .heavy)
        welcomeLabl.textColor = .orange
        view.addSubview(welcomeLabl)
    }
    func setUpLabelNames() {
        var labelNames = ["StudentName","Age","gender","fee","city"]
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
    var labelNames = ["StudentName","Age","gender","fee","city"]
        var y = 200
        for i in labelNames
        {
            var textfiled = UITextField(frame: CGRect(x: 140, y: y, width: 230, height: 40))
            y = y + 50
            textfiled.placeholder = i
            textfiledCollect.append(textfiled)
            textfiled.borderStyle = .roundedRect
            textfiled.layer.cornerRadius = 10
            textfiled.layer.borderWidth = 1
            view.addSubview(textfiled)
        }
    }
    func  saveBtn()  {
         saveButton.frame = CGRect(x: 150, y: 450, width: 80, height: 35)
        saveButton.setTitle("Save", for: .normal)
        saveButton.setTitleColor(.blue, for: .normal)
        saveButton.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        saveButton.backgroundColor = .white
        saveButton.layer.borderWidth = 1
        saveButton.layer.cornerRadius = 10
            view.addSubview(saveButton)
        }
    
}
