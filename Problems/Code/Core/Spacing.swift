//
//  Spacing.swift
//  Problems
//
//  Created on 2019-04-29.
//  Copyright © 2019 MetaLab Design. All rights reserved.
//

import Foundation
import CoreGraphics

public enum Spacing {
    public static let spacing1: CGFloat = 4
    public static let spacing2: CGFloat = 8
    public static let spacing3: CGFloat = 12
    public static let spacing4: CGFloat = 16
    public static let spacing5: CGFloat = 24
    public static let spacing6: CGFloat = 32
    public static let spacing7: CGFloat = 48
    public static let spacing8: CGFloat = 64
}

extension CGFloat {
    public static let spacing1 = Spacing.spacing1
    public static let spacing2 = Spacing.spacing2
    public static let spacing3 = Spacing.spacing3
    public static let spacing4 = Spacing.spacing4
    public static let spacing5 = Spacing.spacing5
    public static let spacing6 = Spacing.spacing6
    public static let spacing7 = Spacing.spacing7
    public static let spacing8 = Spacing.spacing8
}
