//
//  AddMenuViewController.swift
//  choeatce
//
//  Created by 이상도 on 2023/04/14.
//

import UIKit

class AddMenuViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
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
