//
//  studentHistory.swift
//  SQLite_Task
//
//  Created by shaik Arshad on 07/08/2021.
//

import UIKit

class studentHistory: UIViewController {
    var names = [UILabel]()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .purple
      welcomeName()
     setUpLabelNames()
        setUpoutPut()
    }
}
extension studentHistory {
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
    func setUpoutPut() {
        var labelNames = ["StudentName","Age","gender","fee","city"]
        var y = 200
        for i in labelNames
        {
            var lbl = UILabel(frame: CGRect(x: 180, y: y, width: 150, height: 50))
            y = y + 50
            lbl.textColor = .systemOrange
            names.append(lbl)
            lbl.font = UIFont.systemFont(ofSize: 18, weight: .bold)
            view.addSubview(lbl)
        }
     }
}
