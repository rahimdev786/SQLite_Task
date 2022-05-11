
import UIKit
import SQLite
import SideMenu
class ViewController: UITableViewController,dataToPassInMenuVC {
    //Creating sidemenu instance of object
    var menu:SideMenuNavigationController?
    //Creating instance for uitableViewcontrollers
    var sidemenuVC = sideTableMenu()
    var studentAdmis = studentAdmissionVC()
    var studentExam = studentExamEntryVC()
    var studentReport = studentReportVC()
    var studentHis  = studentHistory()
    var db:Connection?
   var tableDataAppend = [tableModel]()

    override func viewDidLoad() {
        super.viewDidLoad()
        navbarSetup()
        makeMenuBar()
        view.backgroundColor = .systemGray6
        setUpsideMenuNavigation()
        sidemenuVC.sidemenuVCDelegate = self
        self.title = "Home"
        addChildVC()
        //Calling DB Files of schollDB
        db  = dBhelper.shared.database
        readDataFromTable()

        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cellData")
        tableView.reloadData()
        
    }
    //MARK:- side menu Navigation Setup
  func setUpsideMenuNavigation()  {
     
    //Here assign sidemenuNavigation for uitableView controller
    menu = SideMenuNavigationController(rootViewController: sidemenuVC)
    
    //hidden sideNavbar
    menu?.setNavigationBarHidden(true, animated: false)
    
    //here we assign sidemenu Data will be leftside of VC
    SideMenuManager.default.leftMenuNavigationController = menu
    
    //Below method is use to assgin a side menu view inside of VC view and use for swipe
    SideMenuManager.default.addPanGestureToPresent(toView: self.view)
    
    }
//MARK:- Menu Bar Create
    func  makeMenuBar(){
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Menu", style: .plain, target: self, action: #selector(sideMenuBarDetails))
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(logout))
        
        self.navigationController?.navigationBar.isTranslucent = false
    }
    
    @objc func sideMenuBarDetails()
    {
        self.present(menu!, animated: true, completion: nil)
    }
    
    @objc func logout()
    {
        self.dismiss(animated: true, completion: nil)
    }
    

//MARK:-
    func navbarSetup()  {
        self.navigationController?.navigationBar.barTintColor = .systemBlue
        self.navigationController?.navigationBar.tintColor = .white
        
    }

    //MARK:- user selected VC navigation
    func didUserSelectSideMenu(named: String) {
        self.dismiss(animated: true) { [self] in
            switch named
            {
            case menuData.home.rawValue:
                break
            case menuData.studentAdmission.rawValue:
                 let vc = studentAdmissionVC()
                navigationController?.pushViewController(vc, animated: true)
            case menuData.studentExamEntry.rawValue:
                let vc = studentExamEntryVC()
                navigationController?.pushViewController(vc, animated: true)
            case menuData.studentHistory.rawValue:
                let vc = studentHistory()
                navigationController?.pushViewController(vc, animated: true)
            case menuData.studentReport.rawValue:
                let vc = studentReportVC()
                navigationController?.pushViewController(vc, animated: true)
            default:
                break
            }
        }
    }
    //MARK:- adding Child VC in Main VC (container VC )
    func addChildVC() {
        //Here all studentAdmission View will added into main view(VC)
        view.addSubview(studentAdmis.view)
        //studentadmission View will same as main view
        studentAdmis.view.frame = view.bounds
        //add child for studentAdmin
        addChild(studentAdmis)
        //didmove Into Paresnt View
        studentAdmis.didMove(toParent: self)
    
        
        studentReport.view.frame = view.bounds
        studentReport.didMove(toParent: self)
        view.addSubview(studentReport.view)
        addChild(studentReport)

        studentHis.view.frame = view.bounds
        studentHis.didMove(toParent: self)
        view.addSubview(studentHis.view)
        addChild(studentHis)

        studentExam.view.frame = view.bounds
        studentExam.didMove(toParent: self)
        view.addSubview(studentExam.view)
        addChild(studentExam)
    
        studentAdmis.view.isHidden = true
        studentReport.view.isHidden = true
        studentHis.view.isHidden = true
        studentExam.view.isHidden = true
    
    }
}

extension ViewController
{
    //MARK:- display table data
    func readDataFromTable()
    {
        // let query = "CREATE TABLE myschool (studentID INTEGER PRIMARY KEY,studentname TEXT,studentage TEXT,gender TEXT ,fee INTEGER,city TEXT);"
let query = "SELECT studentID,studentname,studentage,gender,fee,city FROM myschool;"
        do {
           let dataRead = try db?.prepare(query)
            
            for row in dataRead!
            {
               var model =  tableModel()
             
                for (value,nameOfentity) in dataRead!.columnNames.enumerated()
                {
                
                    switch nameOfentity {
                    case "studentID":
                        model.studentID = Int(row[value]! as! Int64)
                    case "studentname":
                        model.studentname = row[value]! as! String
                    case "studentage":
                        model.studentage = row[value]! as! String
                    case "gender":
                        model.gender = row[value]! as! String
                    case "fee":
                        model.fee  = Int(row[value]! as! Int64)
                    case "city":
                        model.city = row[value]! as! String
                    default:
                        break
                    }
                }
               tableDataAppend.append(model)
            }
        } catch {
            print("error in Read data from Myschool table")
        }
         
    }

override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableDataAppend.count
    }
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let tableCell = tableView.dequeueReusableCell(withIdentifier: "cellData", for: indexPath)
        tableCell.textLabel?.text = "student ID :  \(tableDataAppend[indexPath.row].studentID!) and name : \(tableDataAppend[indexPath.row].studentname!)"
        tableCell.textLabel?.textColor = .blue
        tableCell.backgroundColor = .systemGray6
        return tableCell
    }
}

//MARK:- UITableViewController
class sideTableMenu: UITableViewController {

    var sidemenuVCDelegate:dataToPassInMenuVC?
override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    tableView.backgroundColor = .cyan
        tableView.separatorStyle = .none
    }
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  menuData.allCases.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = menuData.allCases[indexPath.row].rawValue
        cell.textLabel?.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        cell.imageView?.image = UIImage(systemName: menuDataImages.allCases[indexPath.row].rawValue)
        cell.textLabel?.textColor = .black
        cell.backgroundColor = .cyan
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let userSeleted = menuData.allCases[indexPath.row].rawValue
        sidemenuVCDelegate?.didUserSelectSideMenu(named: userSeleted)
    }
}

