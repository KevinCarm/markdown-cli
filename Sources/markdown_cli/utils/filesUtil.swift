//
//  filesUtil.swift
//  markdown
//
//  Created by Kevin Carmona Serrano on 12/11/26.
//

import Foundation

func existsDirectory(using url: URL) -> Bool {
    var isDirectory: ObjCBool = false
    let exists = FileManager.default.fileExists(
        atPath: url.path(),
        isDirectory: &isDirectory
    )
    return exists && isDirectory.boolValue
}
