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
    case crossdisolve
    case flip(isHorizontal: Bool)
    case card
    case scroll(_ direction: MUScrollingTransitioningDirection)
}
