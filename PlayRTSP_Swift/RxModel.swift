//
//  RxModel.swift
//  PlayRTSP_Swift
//
//  Created by xander on 2020/5/16.
//  Copyright © 2020 xander. All rights reserved.
//

import Foundation
import RealmSwift

protocol RxModel {}

extension RxModel {
    typealias DeletedIndex = Int
    typealias InsertedIndex = Int
    typealias UpdatedIndex = Int
    typealias ChangesCallback = ([DeletedIndex], [InsertedIndex], [UpdatedIndex]) -> Void
}

