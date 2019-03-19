//
//  MUNavigationController.swift
//  MUComponent
//
//  Created by Damien Noël Dubuisson on 12/11/2018.
//  Copyright © 2018 Loïc GRIFFIE. All rights reserved.
//

import UIKit

public enum MUTransitionStyle {
    case `default`
    case crossdisolve
    case flip(isHorizontal: Bool)
    case card
    case scroll(_ direction: MUScrollingTransitioningDirection)
}

private var currentStyle = [MUTransitionStyle.default]

extension UINavigationController: UINavigationControllerDelegate {
    public func setRoot(_ vc: UIViewController, style: MUTransitionStyle = .default) {
        delegate = self
        currentStyle = [style]

        setViewControllers([vc], animated: true)
    }

    public func push(_ vc: UIViewController, style: MUTransitionStyle = .default) {
        delegate = self
        currentStyle.append(style)

        pushViewController(vc, animated: true)
    }

    public func present(_ vc: UIViewController, style: MUTransitionStyle = .default, completion: (() -> Void)? = nil) {
        delegate = self
        currentStyle.append(style)

        present(vc, animated: true, completion: completion)
    }

    public func removeLast(_ length: UInt = 1, push vc: UIViewController? = nil) {
        guard length > 0, viewControllers.count > length, currentStyle.count > length else {
            return
        }

        var vcs = viewControllers
        vcs = Array(vcs.dropLast(Int(length)))
        let lastStyle = currentStyle.last ?? .default
        currentStyle = Array(currentStyle.dropLast(Int(length)))

        guard let vc = vc else {
            return
        }

        vcs.append(vc)
        currentStyle.append(lastStyle)
        setViewControllers(vcs, animated: true)
    }

    public func navigationController(_ navigationController: UINavigationController,
                                     animationControllerFor operation: UINavigationController.Operation,
                                     from fromVC: UIViewController,
                                     to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        let reverse = operation == .pop
        guard let style = currentStyle.last else {
            return nil
        }

        if let idx = viewControllers.firstIndex(of: toVC), reverse {
             currentStyle = Array(currentStyle[...idx])
        }

        switch style {
        case .default:
            return nil
        case .crossdisolve:
            return MUCrossdisolveTransitioning(reverse: reverse)
        case .flip(let isHorizontal):
            return MUFlipTransitioning(reverse: reverse, isHorizontal: isHorizontal)
        case .card:
            return MUCardTransitioning(reverse: reverse)
        case .scroll(let direction):
            return MUScrollingTransitioning(reverse: reverse, direction: direction)
        }
    }
}
