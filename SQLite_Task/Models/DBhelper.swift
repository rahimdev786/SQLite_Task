
import Foundation
import SQLite

class dBhelper: NSObject {
    var database:Connection?
    static var shared = dBhelper()
    private override init() {
       
    }
    
    func DBPathCreation(){
        do {
            let filePath = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false).appendingPathComponent("schoolDb").appendingPathExtension("sqlite")
            
            database = try Connection(filePath.path)
            print(filePath)
        } catch  {
            print("error in DB Create")
        }
    }
    
   func createTableAndColumnName()  {
        let query = "CREATE TABLE myschool (studentID INTEGER PRIMARY KEY,studentname TEXT,studentage TEXT,gender TEXT ,fee INTEGER,city TEXT);"
        do {
            try database?.run(query)
        } catch  {
            print("error in Create Table")
        }
    }
}
