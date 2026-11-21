// The Swift Programming Language
// https://docs.swift.org/swift-book

import ArgumentParser

import Foundation

@main
struct markdown_cli: ParsableCommand {

    static let configuration: CommandConfiguration = CommandConfiguration(
        abstract: "Read multiline text"
    )

    @Flag(help: "List all your notes")
    var list: Bool = false

    @Flag(help: "Print the notes in a three format")
    var three: Bool = false

    func run() throws {
        if list {
            if three {
                printFilesThreeFormat()
            } else {
                printFilesTextFormat()
            }
            return
        }

        var lines: [String] = []

        while let line = readLine(strippingNewline: true) {
            lines.append(line)
        }
        let text = lines.joined(separator: "\n")
        let result = applyFormat(using: text)

        let homePath = getHome()
        let markdownPath = homePath?.appending(path: "markdown")
        let exists = existsDirectory(using: (markdownPath!))
        if !exists {
            let fileManager = FileManager()
            do {
                try fileManager.createDirectory(
                    atPath: markdownPath!.relativePath,
                    withIntermediateDirectories: true)
            } catch {
                print("Error during creating /Documents/markdown directory: \(error)")
            }
        }

        let date = getDateFormat()
        let markdownFile = markdownPath?.appending(path: "\(date).md")
        do {
            try result.write(
                to: markdownFile!,
                atomically: true,
                encoding: .utf8
            )
        }
    }
}
