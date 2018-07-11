//
//  String+Emojis.swift
//  SwiftyExtensions
//
//  Created by Tam Huynh on 7/10/18.
//  Copyright © 2018 TH. All rights reserved.
//

import Foundation
import UIKit

//** This Extension will manage what emoji in String
//** For Detail please check at: http://stackoverflow.com/questions/30757193/find-out-if-character-in-string-is-emoji
//** Example **
/**************************************
 "👌🏿".isSingleEmoji // true
 "🙎🏼‍♂️".isSingleEmoji // true
 "👨‍👩‍👧‍👧".isSingleEmoji // true
 "👨‍👩‍👧‍👧".containsOnlyEmoji // true
 "Hello 👨‍👩‍👧‍👧".containsOnlyEmoji // false
 "Hello 👨‍👩‍👧‍👧".containsEmoji // true
 "👫 Héllo 👨‍👩‍👧‍👧".emojiString // "👫👨‍👩‍👧‍👧"
 "👨‍👩‍👧‍👧".glyphCount // 1
 "👨‍👩‍👧‍👧".characters.count // 4
 
 "👫 Héllœ 👨‍👩‍👧‍👧".emojiScalars // [128107, 128104, 8205, 128105, 8205, 128103, 8205, 128103]
 "👫 Héllœ 👨‍👩‍👧‍👧".emojis // ["👫", "👨‍👩‍👧‍👧"]
 
 "👫👨‍👩‍👧‍👧👨‍👨‍👦".isSingleEmoji // false
 "👫👨‍👩‍👧‍👧👨‍👨‍👦".containsOnlyEmoji // true
 "👫👨‍👩‍👧‍👧👨‍👨‍👦".glyphCount // 3
 "👫👨‍👩‍👧‍👧👨‍👨‍👦".characters.count // 8
 ***************************************/

// MARK: - Emoji Management
public extension UnicodeScalar {
    var isEmoji: Bool {
        switch value {
        case 0x1F600...0x1F64F, // Emoticons
        0x1F300...0x1F5FF, // Misc Symbols and Pictographs
        0x1F680...0x1F6FF, // Transport and Map
        0x1F1E6...0x1F1FF, // Regional country flags
        0x2600...0x26FF,   // Misc symbols
        0x2700...0x27BF,   // Dingbats
        0xFE00...0xFE0F,   // Variation Selectors
        0x1F900...0x1F9FF,  // Supplemental Symbols and Pictographs
        65024...65039, // Variation selector
        8400...8447: // Combining Diacritical Marks for Symbols
            return true
        default: return false
        }
    }
    
    var isZeroWidthJoiner: Bool {
        return value == 8205
    }
}

public extension String {
    var glyphCount: Int {
        let richText = NSAttributedString(string: self)
        let line = CTLineCreateWithAttributedString(richText)
        return CTLineGetGlyphCount(line)
    }
    
    var isSingleEmoji: Bool {
        return glyphCount == 1 && containsEmoji
    }
    
    var containsEmoji: Bool {
        return unicodeScalars.contains { $0.isEmoji }
    }
    
    var containsOnlyEmoji: Bool {
        return !isEmpty
            && !unicodeScalars.contains(where: {
                !$0.isEmoji
                    && !$0.isZeroWidthJoiner
            })
    }
    
    // The next tricks are mostly to demonstrate how tricky it can be to determine emoji's
    // If anyone has suggestions how to improve this, please let me know
    var emojiString: String {
        return emojiScalars.map { String($0) }.reduce("", +)
    }
    
    var emojis: [String] {
        var scalars: [[UnicodeScalar]] = []
        var currentScalarSet: [UnicodeScalar] = []
        var previousScalar: UnicodeScalar?
        
        for scalar in emojiScalars {
            if let prev = previousScalar, !prev.isZeroWidthJoiner && !scalar.isZeroWidthJoiner {
                scalars.append(currentScalarSet)
                currentScalarSet = []
            }
            currentScalarSet.append(scalar)
            previousScalar = scalar
        }
        
        scalars.append(currentScalarSet)
        return scalars.map { $0.map({ String($0) }).reduce("", +) }
    }
    
    var exceptEmojiString: String {
        let characters = Array(self)
        let emojiCharacters = Array(emojiString)
        return String.init(characters.filter({ !emojiCharacters.contains($0) }))
    }
    
    fileprivate var emojiScalars: [UnicodeScalar] {
        var chars: [UnicodeScalar] = []
        var previous: UnicodeScalar?
        for cur in unicodeScalars {
            if let previous = previous, previous.isZeroWidthJoiner && cur.isEmoji {
                chars.append(previous)
                chars.append(cur)
            } else if cur.isEmoji {
                chars.append(cur)
            }
            previous = cur
        }
        return chars
    }
}
