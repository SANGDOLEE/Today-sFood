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
    @IBOutlet weak var mainImage: UIImageView! // 메인 사진
    @IBOutlet weak var imageView: UIImageView! // 음식 변경 버튼
    @IBOutlet weak var startImage: UIImageView!
    @IBOutlet weak var startTextLabel: UILabel!
    
    
    var num = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainImage.isHidden = true
        NaverMapsButton.isHidden = true
        KaKaoMapsButton.isHidden = true
        imageView.isHidden = true
        
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
        
        let tapGesture2 = UITapGestureRecognizer(target: self, action: #selector(startMenu))
        startImage.addGestureRecognizer(tapGesture2)
        startImage.isUserInteractionEnabled = true
        
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
    

    // 앱 시작 -> 메인 imageView 터치
    @objc func startMenu() -> Int {
        
        mainImage.isHidden = false
        NaverMapsButton.isHidden = false
        KaKaoMapsButton.isHidden = false
        imageView.isHidden = false
        startImage.isHidden = true
        startTextLabel.isHidden = true
        
        num = Int.random(in: 1...Food.FoodList.count-1)
        foodName.text = Food.FoodList[num]
        return num
    }
    
    // 메뉴 변경
    @objc func changeMenuButton() -> Int {
        
         // foodName.text = Food.FoodList.randomElement()!
        num = Int.random(in: 1...Food.FoodList.count-1)
        foodName.text = Food.FoodList[num]
        return num
    }
    
    
    
}

