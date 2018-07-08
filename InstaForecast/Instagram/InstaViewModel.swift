//
//  InstaViewModel.swift
//  InstaForecast
//
//  Created by Sihoon Oh on 2018. 7. 8..
//  Copyright © 2018년 Sihoon Oh. All rights reserved.
//

import Foundation

protocol InstaImageDelegate {
    func searchImageDidChaged()
}

protocol InstaImageViewModelType {
    var delegate: InstaImageDelegate? { get set }
    var edges: [Edges]? { get set }
    var isHashtag: Bool { get }
    var word: String { get set }
    var index: Int { get set }
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
            DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(200)) {
                self.delegate?.searchImageDidChaged()
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
