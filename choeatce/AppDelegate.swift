//
//  AppDelegate.swift
//  choeatce
//
//  Created by 이상도 on 2023/04/10.
//

import UIKit
import CoreData

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "DataModel")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    func applicationDidEnterBackground(_ application: UIApplication) {
        saveContext()
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        saveContext()
    }
    
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        /*
         // 이전에 저장된 데이터를 로드하는 코드
         let context = persistentContainer.viewContext
         let request = NSFetchRequest<FoodModel>(entityName: "FoodModel")
         do {
         // CoreData에서 저장된 EntityName의 데이터를 불러옴
         let result = try context.fetch(request)
         for data in result {
         // 불러온 데이터를 사용
         print(data.value(forKey: "name"))
         }
         } catch {
         print("Failed")
         }
         */
        
        let context = persistentContainer.viewContext
        
        // 기본 음식 데이터 생성
        let foodNames = ["치킨", "피자", "햄버거"]
        
        // CoreData에 기본 음식 데이터 저장
        for foodName in foodNames {
            let food = FoodModel(context: context)
            food.name = foodName
        }
        
        // CoreData에 저장
        do {
            try context.save()
        } catch {
            print("Failed to save default food data: \(error)")
        }
        
        Thread.sleep(forTimeInterval: 2.0)
        return true
    }
    
    // MARK: UISceneSession Lifecycle
    
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
    
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    
    
    
}

