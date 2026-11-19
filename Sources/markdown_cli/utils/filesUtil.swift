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
func getHome() -> URL? {
    let home = FileManager.default.homeDirectoryForCurrentUser
    #if os(macOS)
        if #available(macOS 13.0, *) {
            return home.appending(path: "Documents")
        } else {
            return home.appendingPathComponent("Documents")
        }
    #elseif os(Linux)
        return home.appendingPathComponent("Documents")
    #elseif os(Windows)
        return home.appending(path: "Documents")
    #else
        fatalError("Platform no found")
    #endif
}
