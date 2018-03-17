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
    
    private var weatherInfo: WeatherInfo?
    
    private var index = 0 {
        didSet {
            do {

                guard edges?.isEmpty == false, 
                    let node = edges?[index].node,
                    let url = URL(string: node.displayURL) else {
                        return
                }
                
                let data = try Data(contentsOf: url)
                let image = UIImage(data: data)
                instaImageView.image = image
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    private var instaInfo: InstaInfo?
    private var edges: [Edges]? {
        didSet {
            index = 0
        }
    }
    private var word: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = .clear
        searchButtonClick()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension MainViewController {
    func requestForecastInfo() {
        var cityName = "Seoul"
        
        ForecastProvider.downloadForecast(cityName: cityName,
                                          completion: { [unowned self] forecast in
                                            self.weatherInfo = forecast
                                            print(forecast.city?.name)
                                            print(Double((forecast.list?.first?.listMain?.temp)!) - 273.15)
    }
}

extension MainViewController {
    func searchButtonClick() {
        guard var word = "#한강" as? String else {
            return
        }
        var isHashtag = false
        if word.hasPrefix("#") {
            word = word.trimmingCharacters(in: ["#"])
            isHashtag = true
        }
        parserInstaInfoFromHTML(word, isHashtag: isHashtag)
    }
    
    func parserInstaInfoFromHTML(_ word: String, isHashtag: Bool) {
        do {
            let hashTagURL = "https://www.instagram.com/tags/"
            let userURL = "https://www.instagram.com/"
            let instaURL = isHashtag ? hashTagURL : userURL
            
            guard let encodingWord = word.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed),
                let url = URL(string: "\(instaURL)\(encodingWord)") else {
                    return
            }
            
            let html = try String(contentsOf: url)
            let doc = try SwiftSoup.parseBodyFragment(html)
            let body = try doc.getElementsByTag("script")
            var str: String?
            for element in body {
                str = element.dataNodes().filter { $0.getWholeData().hasPrefix("window._sharedData =") }.first?.getWholeData()
                if str != nil {
                    break
                }
            }
            
            guard let data = str else {
                return
            }
            let deprecatedString = "window._sharedData = "
            var jsonString = String(data[deprecatedString.endIndex...])
            jsonString = jsonString.trimmingCharacters(in: [";"])
            guard let jsonData = jsonString.data(using: .utf8),
                let json = try JSONSerialization.jsonObject(with: jsonData, options: .mutableContainers) as? [String: Any]else {
                    return
            }
            
            instaInfo = Mapper<InstaInfo>().map(JSON: json)
            if isHashtag {
                edges = instaInfo?.entryData?.tagPage?.first?.graphQL?.hashtag?.edgeHashtagToMedia?.edges
            } else {
                edges = instaInfo?.entryData?.profilePage?.first?.graphQL?.user?.edgeOwnerToTimelineMedia?.edges
            }
        } catch {
            // handle error
            print(error)
        }
    }
    
    @IBAction func clickPrevButton(_ sender: Any) {
        guard let edgesCount = edges?.count else {
            return
        }
        if index <= 0 {
            index = edgesCount - 1
        } else {
            index -= 1
        }
    }
    
    @IBAction func clickNextButton(_ sender: Any) {
        guard let edgesCount = edges?.count else {
            return
        }
        if edgesCount - 1 <= index {
            index = 0
        } else {
            index += 1
        }
    }
}

