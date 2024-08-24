//
//  examples.swift
//  Test_1
//
//  Created by Andrey Doroshko on 8/23/24.
//

import Foundation

class Veachle {
    var title: String
    
    init(title: String) {
        self.title = title
    }
}

extension Veachle {
    func upgradeTitle(newTitle: String) {
        self.title = newTitle
    }
}

class Car: Veachle {
    var engine: String
    var brand: String
    
    init(engine: String, brand: String, title: String) {
        self.engine = engine
        self.brand = brand
        super.init(title: title)
    }
    
    func upgradeEngine(newEngine: String) {
        self.engine = newEngine
    }
}
