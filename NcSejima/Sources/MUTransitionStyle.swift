//
//  MUTransitionStyle.swift
//  NcSejima
//
//  Created by Loïc GRIFFIE on 19/03/2019.
//  Copyright © 2019 Loïc GRIFFIE. All rights reserved.
//

import Foundation

public enum MUTransitionStyle {
    case `default`
    case crossdisolve(duration: TimeInterval = 0.5)
    case flip(isHorizontal: Bool, duration: TimeInterval = 0.5)
    case card(duration: TimeInterval = 0.5)
    case scroll(_ direction: MUScrollingTransitioningDirection, duration: TimeInterval = 0.5)
}
