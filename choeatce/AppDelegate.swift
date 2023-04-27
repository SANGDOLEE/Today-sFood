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
        let context = persistentContainer.viewContext
            
            // CoreData에 기본 음식 데이터가 있는지 확인
            let request: NSFetchRequest<FoodModel> = FoodModel.fetchRequest()
            do {
                let count = try context.count(for: request)
                // 기본 음식 데이터가 없으면 추가
                if count == 0 {
                    let foodNames = ["치킨","피자","햄버거","족발","보쌈","아구찜","김치찌개","국밥","낙곱새","갈비찜","찜닭","김치찜","감자탕","곱창전골","돈까스","육회","대창덮밥","연어덮밥","덮밥",
                                     "라멘","라면","규동","카레","회","초밥","피자","삼겹살","갈비","냉면","곱창","막창","닭발","닭갈비","등갈비","쭈꾸미","파스타","칼국수","수제비",
                                     "치킨","중국집","마라탕","햄버거","쌀국수","볶음밥","석갈비","김밥","비빔밥","삼계탕","떡볶이","샐러드","샌드위치","부리또","샤브샤브","와플","타코야끼",
                                     "불고기","순대국","한솥","베이커리","토스트","우동","낚지볶음","오돌뼈","생선구이","카페","분식","닭강정","밀면","국수","비빔국수","육사시미","수육",
                                     "게장","해물찜","파전","전골","양꼬치"]
                    
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
                }
            } catch {
                print("Failed to check default food data: \(error)")
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

