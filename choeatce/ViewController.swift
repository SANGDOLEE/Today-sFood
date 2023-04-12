//
//  ViewController.swift
//  choeatce
//
//  Created by 이상도 on 2023/04/10.
//

import UIKit
import NMapsMap
import AVFoundation

class ViewController: UIViewController {

    
    var player : AVAudioPlayer!
    
    @IBOutlet weak var goNaverMapApp: UIButton!
    
    @IBOutlet weak var NaverMapsButton: UIButton!
    @IBOutlet weak var KaKaoMapsButton: UIButton!
    
    @IBOutlet weak var foodName: UILabel! // 음식 Text
    
    @IBOutlet weak var imageView: UIImageView! // 음식 변경 버튼
    
    
    var num = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // UI, 색상 지정
        self.view.backgroundColor = .systemOrange
        NaverMapsButton.backgroundColor = .systemYellow
        KaKaoMapsButton.backgroundColor = .systemYellow
        
        NaverMapsButton.layer.cornerRadius = 10
        KaKaoMapsButton.layer.cornerRadius = 10
        
        // imageView -> 터치이벤트
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(changeMenuButton))
        imageView.addGestureRecognizer(tapGesture)
        imageView.isUserInteractionEnabled = true
        
    }

    // 네이버 지도로 검색
    @IBAction func goNaver(_ sender: UIButton) {
        let searchFood = Food.FoodList[num]
        let result = searchFood.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) // 인코딩된 장소 URL
        
        let url = URL(string:"nmap://search?query=\(result!)&appname=com.sangdolee.choeatce")! // 장소 URL
        let appStoreURL = URL(string: "http://itunes.apple.com/app/id311867728?mt=8")! // 네이버지도 AppStore URL
        
        if UIApplication.shared.canOpenURL(url){
            UIApplication.shared.open(url)
        } else {
            UIApplication.shared.open(appStoreURL)
        }
    }
    
    // 카카오 지도로 검색
    @IBAction func goKakao(_ sender: Any) {
        
        
    }
    

    // 메뉴 변경
    @objc func changeMenuButton() -> Int {
        
         // foodName.text = Food.FoodList.randomElement()!
        num = Int.random(in: 1...Food.FoodList.count-1)
        foodName.text = Food.FoodList[num]
        return num
    }
    
    
    
}

