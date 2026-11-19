//
//  formatUtil.swift
//  markdown
//
//  Created by Kevin Carmona Serrano on 13/11/26.
//

import Foundation

func applyFormat(using text: String) -> String {

    let patronT1 = /T1(.*?)T1/
    let patronT2 = /T2(.*?)T2/
    let patronT3 = /T3(.*?)T3/

    let patronBold = /¡(.*?)!/
    let patronCross = /--(.*?)--/
    let patronTextUrl = /TX(.*?)LK([^\s]+)/
    let patronCommand = /CMD(.*?)CMD/
    let patronCode = /CD([a-zA-Z]+)\s*([\s\S]*?)CD/

    var result = text.replacing(patronT1) { match in
        return "# \(match.1) \n"
    }
    result = result.replacing(patronT2) { match in
        return "## \(match.1) \n"
    }
    result = result.replacing(patronT3) { match in
        return "### \(match.1) \n"
    }
    result = result.replacing(patronBold) { match in
        return "**\(match.1)** \n"
    }
    result = result.replacing(patronCross) { match in
        return "~~\(match.1)~~ \n"
    }
    result = result.replacing(patronTextUrl) { match in
        let text = match.1
        let url = match.2

        return "![\(text)](\(url)) \n"
    }
    result = result.replacing(patronCommand) { match in
        return "`\(match.1)` \n"
    }
    result = result.replacing(patronCode) { match in
        let language = match.1 
        let code = match.2
       
        return """
        ```\(language)
        \(code)
        ```
        \n
        """
    }

    return result
}
