//
//  Design.swift
//  MOBINT
//
//  Created by Денис Ледовский on 14.04.2023.
//

import UIKit

enum Design {
    enum Image {
        static let eye = UIImage(named: "eye")
        static let logo = UIImage(named: "logo")
        static let trash = UIImage(named: "trash")
    }

    enum Color {
        static let cardBackgroundColor = UIColor(named: "white")!
        static let highlightTextColor = UIColor(named: "black")!
        static let accentColor = UIColor(named: "red")!
        static let mainColor = UIColor(named: "blue")!
        static let textColor = UIColor(named: "darkGray")!
        static let backgroundColor = UIColor(named: "lightGray")!

        static let black = UIColor.black
        static let white = UIColor.white
    }

    enum Font {
        static let h1 = UIFont.systemFont(ofSize: 20, weight: .medium)
        static let h2 = UIFont.systemFont(ofSize: 16, weight: .regular)
        static let h3 = UIFont.systemFont(ofSize: 12, weight: .regular)
    }

    enum Indent {
        static let redIndent = 14
        static let yellowIndent = 8
        static let blueIndent = 30
    }
}
