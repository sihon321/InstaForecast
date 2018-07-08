//
//  InstaViewModel.swift
//  InstaForecast
//
//  Created by Sihoon Oh on 2018. 7. 8..
//  Copyright © 2018년 Sihoon Oh. All rights reserved.
//

import Foundation

protocol InstaImageDelegate {
    func searchImageDidChanged()
}

protocol InstaImageViewModelType {
    var delegate: InstaImageDelegate? { get set }
    var edges: [Edges]? { get }
    var isHashtag: Bool { get }
    var word: String { get set }
    var index: Int { get set }
    var imageData: Data? { get }
}

class InstaViewModel: InstaImageViewModelType {
    var delegate: InstaImageDelegate?
    
    var edges: [Edges]? {
        didSet {
            index = 0
        }
    }
    var isHashtag: Bool {
        get {
            if word.hasPrefix("#") {
                word = word.trimmingCharacters(in: ["#"])
                return true
            } else {
                return false
            }
        }
    }
    var word: String = "" {
        didSet {
            performSearch(isHashtag)
        }
    }
    var index = 0 {
        didSet {
            guard edges?.isEmpty == false,
                let edges = edges,
                let node = edges[index].node,
                let url = URL(string: node.displayURL) else {
                    return
            }
            
            do {
                imageData = try Data(contentsOf: url)
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    var imageData: Data? {
        didSet {
            DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(200)) {
                self.delegate?.searchImageDidChanged()
            }
        }
    }
    
    var service: InstaImageService
    
    init(service: InstaImageService) {
        self.service = service
    }
    
    func performSearch(_ isHashtag: Bool) {
        service.parseInstaInfoFromHTML(InstaRouter.search(word: word, isHashtag: isHashtag)) { [weak self] edges in
            self?.edges = edges
        }
    }
}
