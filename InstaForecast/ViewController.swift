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

class ViewController: UIViewController {

    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var instaImageView: UIImageView!
    @IBOutlet weak var prevButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    
    private var index = 0 {
        didSet {
            do {
                guard let node = edges?[index].node,
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
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func searchButtonClick(_ sender: Any) {
        word = searchTextField.text
        parserInstaInfoFromHTML(word)
    }
    
    func parserInstaInfoFromHTML(_ word: String?) {
        do {
            let hashTagURL = "https://www.instagram.com/tag/"
            let userURL = "https://www.instagram.com/"
            guard let url = URL(string: "\(userURL)\(word!)") else {
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
//            edges = instaInfo?.entryData?.tagPage?.first?.graphQL?.hashtag?.edgeHashtagToMedia?.edges
            edges = instaInfo?.entryData?.profilePage?.first?.graphQL?.user?.edgeOwnerToTimelineMedia?.edges
            
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

