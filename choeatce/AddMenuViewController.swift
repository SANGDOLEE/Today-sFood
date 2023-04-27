//
//  AddMenuViewController.swift
//  choeatce
//
//  Created by 이상도 on 2023/04/14.
//

import UIKit
import Foundation
import CoreData

class AddMenuViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var dataTextField: UITextField!
    
    var foodList: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.contentInset = UIEdgeInsets(top: 20, left: 0, bottom: 0, right: 0)
        tableView.scrollIndicatorInsets = UIEdgeInsets(top: 20, left: 0, bottom: 0, right: 0)
        
        dataTextField.delegate = self
        dataTextField.placeholder = "새로운 메뉴를 입력하세요."
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "mycell")
        
        //foodList = Food.FoodList
        
        print(tableView)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchFoodList() // CoreData에서 데이터를 가져와서 foodList를 업데이트합니다.
        tableView.reloadData() // 데이터 반영을 위한 메소드 호출
    }
    
    // 사용자 메뉴 추가
    @IBAction func addMenu(_ sender: Any) {
        guard let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext,
              let text = dataTextField.text, !text.isEmpty else { return }
        
        let entity = NSEntityDescription.entity(forEntityName: "FoodModel", in: context)!
        let newFood = NSManagedObject(entity: entity, insertInto: context)
        
        newFood.setValue(text, forKey: "name")
        
        do {
            try context.save()
            print("Data saved: \(text)")
            fetchFoodList() // CoreData에서 데이터를 가져와서 foodList를 업데이트합니다.
            tableView.reloadData() // 데이터 반영을 위한 메소드 호출
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
            return // 에러 발생 시, 함수를 빠져나갑니다.
        }
        dataTextField.text = ""
        dataTextField.resignFirstResponder() // 키보드 내려가게
    }
    
    func fetchFoodList() {
        guard let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext else { return }
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "FoodModel")
        do {
            let result = try context.fetch(fetchRequest)
            if let foods = result as? [NSManagedObject] {
                foodList.removeAll() // 초기화
                //foodList.append(contentsOf: Food.FoodList) // Food.FoodList의 값들 추가
                foodList.append(contentsOf: foods.compactMap { $0.value(forKey: "name") as? String }) // CoreData에서 가져온 값들 추가
            }
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
    }
}

extension AddMenuViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // CoreData에서 데이터를 가져와서 셀의 개수를 반환
            guard let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext else { return 0 }
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "FoodModel")
            do {
                let count = try context.count(for: fetchRequest)
                return count
            } catch {
                print("Error fetching food count from CoreData: \(error)")
                return 0
            }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "mycell", for: indexPath)
        let food = foodList[indexPath.row]
        
        // 폰트 글자 크기 변경
        if let customFont = UIFont(name:"Product Sans Regular", size:14){
            cell.textLabel?.font = customFont
        } else {
            cell.textLabel?.font = UIFont.systemFont(ofSize: 14)
        }
        
        cell.textLabel?.text = food
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "My Menu"
    }
    
    func deleteFood(at index: Int) {
        guard let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext else { return }
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "FoodModel")
        let predicate = NSPredicate(format: "name = %@", foodList[index])
        fetchRequest.predicate = predicate
        
        do {
            let result = try context.fetch(fetchRequest)
            guard let foodToDelete = result.first as? NSManagedObject else {
                return
            }
            
            context.delete(foodToDelete)
            try context.save()
            
            foodList.remove(at: index)
            tableView.deleteRows(at: [IndexPath(row: index, section: 0)], with: .fade)
        } catch let error as NSError {
            print("Could not delete. \(error), \(error.userInfo)")
        }
    }
    
    
    func removeFoodFromList(_ food: String) {
        // 사용자가 추가한 메뉴인 경우 CoreData에서 삭제
        if !Food.FoodList.contains(food) {
            guard let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext else { return }
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "FoodModel")
            fetchRequest.predicate = NSPredicate(format: "name = %@", food)
            
            do {
                let result = try context.fetch(fetchRequest)
                let food = result[0] as! NSManagedObject
                context.delete(food)
                try context.save()
            } catch {
                print("Error deleting food from CoreData: \(error)")
            }
        }
    }
    
    
    
    // 사용자 메뉴 삭제
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let deletedFood = foodList[indexPath.row]
            
            // CoreData에서 해당 데이터 삭제
            guard let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext else { return }
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "FoodModel")
            fetchRequest.predicate = NSPredicate(format: "name = %@", deletedFood)
            
            do {
                let result = try context.fetch(fetchRequest)
                let food = result[0] as! NSManagedObject
                context.delete(food)
                try context.save()
            } catch {
                print("Error deleting food from CoreData: \(error)")
            }
            
            // 배열에서 해당 데이터 삭제
            if let index = foodList.firstIndex(of: deletedFood) {
                foodList.remove(at: index)
            }
            
            // 테이블뷰에서 해당 row 삭제
            tableView.deleteRows(at: [indexPath], with: .fade)
            
            // 배열에서 데이터를 삭제한 이후에 남은 데이터가 1개인 경우 편집 모드를 종료합니다.
            if foodList.count == 1 {
                tableView.setEditing(false, animated: true)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
}

extension AddMenuViewController: UITextFieldDelegate {
    
}
