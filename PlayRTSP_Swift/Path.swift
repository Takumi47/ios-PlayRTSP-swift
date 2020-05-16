//
//  Path.swift
//  PlayRTSP_Swift
//
//  Created by xander on 2020/5/16.
//  Copyright © 2020 xander. All rights reserved.
//

import Foundation

enum PathError: Error, LocalizedError {
    case notFound
    case containerrNotFound(String)
    
    var errorDescription: String? {
        switch self {
        case .notFound:
            return "Resource not found"
        case .containerrNotFound(let id):
            return "Shared container for group \(id) not found"
        }
    }
}

class Path {
    static func inLibrary(_ name: String) throws -> URL {
        return try FileManager.default.url(for: .libraryDirectory, in: .userDomainMask, appropriateFor: nil, create: false).appendingPathComponent(name)
    }
}
