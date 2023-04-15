//
//  AddMenuViewController.swift
//  choeatce
//
//  Created by 이상도 on 2023/04/14.
//

import UIKit
import CoreData

class AddMenuViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var dataTextField: UITextField!
    
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.contentInset = UIEdgeInsets(top: 20, left: 0, bottom: 0, right: 0)
        tableView.scrollIndicatorInsets = UIEdgeInsets(top: 20, left: 0, bottom: 0, right: 0)
        
        dataTextField.delegate = self
        dataTextField.placeholder = "새로운 메뉴를 입력하세요."
    }
    
    
    // 사용자 메뉴 추가
    @IBAction func addMenu(_ sender: Any) {
        guard let text = dataTextField.text, !text.isEmpty else {
                return
            }
            Food.FoodList.append(text)
            tableView.reloadData()
            dataTextField.text = nil
            dataTextField.resignFirstResponder() // 키보드 내려가게

       
    }
    

}

extension AddMenuViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Food.FoodList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "mycell", for: indexPath)
        
        // 폰트 글자 크기 변경
        if let customFont = UIFont(name:"Product Sans Regular", size:14){
            cell.textLabel?.font = customFont
        } else {
            cell.textLabel?.font = UIFont.systemFont(ofSize: 14)
        }
        
        cell.textLabel?.text = Food.FoodList[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "My Menu"
    }
    
}


extension AddMenuViewController: UITextFieldDelegate {
    

    
}
