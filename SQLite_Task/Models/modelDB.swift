import Foundation
import UIKit
enum menuData:String,CaseIterable {
    case home = "Home"
    case studentAdmission = "Student Admission"
    case studentExamEntry = "Student Update"
    case studentReport = "Student Delete"
    case studentHistory = "Student History"
}
enum menuDataImages:String,CaseIterable
{
    case homeimg = "house"
    case studentAdmissionimg = "plus.circle.fill"
    case studentExamEntryimg = "doc.badge.plus"
    case studentReportimg = "folder.circle.fill"
    case studentHistoryimg = "doc.fill.badge.plus"
}

//MARK:- Protocal for Data Passing in sideMenu VC

protocol dataToPassInMenuVC {
    func didUserSelectSideMenu(named:String)
}

//MARK:- Model for userRegistration
struct userModels:Codable {
    var username:String
    var pass:String
    var repass:String
}

class alertFunction {

   static var shared = alertFunction()
    func alert(title:String,msg:String)
    {
        let alertView = UIAlertController(title:title, message: msg, preferredStyle: .alert)
        alertView.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
    }
}


//MARK: Myscholl Table Struct

let query = "CREATE TABLE myschool (studentID INTEGER PRIMARY KEY,studentname TEXT,studentage TEXT,gender TEXT ,fee INTEGER,city TEXT);"

struct tableModel {
    var studentID:Int!
    var studentname:String!
    var studentage:String!
    var gender:String!
    var fee:Int!
    var city:String!
}
