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
    
    var result = text.replacing(patronT1) { match in
        return "#\(match.1)#"
    }
    result = result.replacing(patronT2) { match in
        return "##\(match.1)##"
    }
    result = result.replacing(patronT3) { match in
        return "###\(match.1)###"
    }

    return result
}
