//
//  ViewController.swift
//  InstaForecast
//
//  Created by Sihoon Oh on 2018. 3. 3..
//  Copyright © 2018년 Sihoon Oh. All rights reserved.
//

import UIKit
import SwiftSoup
import SwiftyJSON
import ObjectMapper

class MainViewController: UIViewController {

    @IBOutlet weak var instaImageView: UIImageView!
    @IBOutlet weak var prevButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var collectionView: UICollectionView!
    
    // TODO: test code, input word that you want
    private var word = "#한강"
    
    private var instaViewModel: InstaImageViewModelType!
    
    private var weatherInfo: WeatherInfo?
    private var weatherList: [List]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let nibName = UINib(nibName: "TempCollectionViewCell", bundle:nil)
        self.collectionView.register(nibName, forCellWithReuseIdentifier: "TempCollectionViewCell")
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = .clear
        
        instaViewModel = InstaViewModel(service: InstaImageService())
        instaViewModel.delegate = self
        
        initGesture()
        searchButtonClick()
        requestForecastInfo()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension MainViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TempCollectionViewCell", for: indexPath) as! TempCollectionViewCell
        if let info = weatherList?.first {
            cell.configure(info)
        }
        
        return cell
    }
}

extension MainViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return TempCollectionViewCell.cellSize()
    }
}

extension MainViewController: InstaImageDelegate {
    func searchImageDidChanged() {
        guard let data = instaViewModel.imageData else {
            return
        }
        let image = UIImage(data: data)
        instaImageView.image = image
    }
    
    func searchButtonClick() {
        instaViewModel.word = self.word
    }
    
    func requestForecastInfo() {
        var cityName = "Seoul"
        
        ForecastProvider.downloadForecast(cityName: cityName,
                                          completion: { [unowned self] forecast in
                                            self.weatherInfo = forecast
                                            self.weatherList = self.weatherInfo?.list
                                            self.collectionView.reloadData()
        })
    }
}

// MARK: setup UISwipeGestureRecognizer
extension MainViewController {
    func initGesture() {
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(self.handleSwipeRightGesture(recognizer:)))
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(self.handleSwipeLeftGesture(recognizer:)))
        
        swipeRight.direction = .right
        swipeLeft.direction = .left
        
        collectionView.gestureRecognizers?.append(swipeRight)
        collectionView.gestureRecognizers?.append(swipeLeft)
    }
    
    @IBAction func handleSwipeRightGesture(recognizer: UISwipeGestureRecognizer) {
        guard let edgesCount = instaViewModel.edges?.count else {
            return
        }
        
        if edgesCount - 1 <= instaViewModel.index {
            instaViewModel.index = 0
        } else {
            instaViewModel.index += 1
        }
    }
    @IBAction func handleSwipeLeftGesture(recognizer: UISwipeGestureRecognizer) {
        guard let edgesCount = instaViewModel.edges?.count else {
            return
        }
        
        if instaViewModel.index <= 0 {
            instaViewModel.index = edgesCount - 1
        } else {
            instaViewModel.index -= 1
        }
    }
}
