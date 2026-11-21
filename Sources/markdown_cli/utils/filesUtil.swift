//
//  filesUtil.swift
//  markdown
//
//  Created by Kevin Carmona Serrano on 12/11/26.
//

import Foundation
import Markdown

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
func printFilesThreeFormat() {
    let homePath = getHome()
    let markdownPath = homePath?.appending(path: "markdown")
    let exists = existsDirectory(using: (markdownPath!))
    if !exists {
        print("The directory does not exists")
        return
    }
    //Get all files from directory
    do {
        let green = "\u{001B}[32m"
        let reset = "\u{001B}[0m"
        let fileManager = FileManager()
        let files = try fileManager.contentsOfDirectory(
            at: markdownPath!,
            includingPropertiesForKeys: nil
        )
        for file in files {
            print("\(green)[-------------------- \(file.lastPathComponent) --------------------]\(reset)")
            let filePath = markdownPath?.appending(path: file.lastPathComponent)
            let contentOfFile = try String(
                contentsOf: filePath!, 
                encoding: .utf8
            )
            let document = Document(parsing: contentOfFile)
            print(document.debugDescription())
        }
    } catch {
        
    }
}

func printFilesTextFormat() {
    let homePath = getHome()
    let markdownPath = homePath?.appending(path: "markdown")
    let exists = existsDirectory(using: (markdownPath!))
    if !exists {
        print("The directory does not exists")
        return
    }
    //Get all files from directory
    do {
        let green = "\u{001B}[32m"
        let reset = "\u{001B}[0m"
        let fileManager = FileManager()
        let files = try fileManager.contentsOfDirectory(
            at: markdownPath!,
            includingPropertiesForKeys: nil
        )
        for file in files {
            print("\(green)[-------------------- \(file.lastPathComponent) --------------------]\(reset)")
            let filePath = markdownPath?.appending(path: file.lastPathComponent)
            let contentOfFile = try String(
                contentsOf: filePath!, 
                encoding: .utf8
            )
            print(contentOfFile)
        }
    } catch {
        
    }
}
