//
//  MUAnimatedTransitioning.swift
//  NcSejima
//
//  Created by Damien Noël Dubuisson on 12/11/2018.
//  Copyright © 2018 Loïc GRIFFIE. All rights reserved.
//

import UIKit

open class MUAnimatedTransitioning: NSObject, UIViewControllerAnimatedTransitioning {
    public let duration: TimeInterval
    public let reverse: Bool

    public init(duration: TimeInterval, reverse: Bool) {
        self.duration = duration
        self.reverse = reverse
        super.init()
    }

    open func animateTransition(using transitionContext: UIViewControllerContextTransitioning,
                                from: UIViewController,
                                to: UIViewController) {
        assert(true, "animateTransition should be overridden")
    }

    // MARK: - UIViewControllerAnimatedTransitioning functions

    public func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration
    }

    public func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let from = transitionContext.viewController(forKey: .from),
            let to = transitionContext.viewController(forKey: .to) else {
            return
        }

        animateTransition(using: transitionContext, from: from, to: to)
    }
}
