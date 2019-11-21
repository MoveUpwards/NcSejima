//
//  MUCardTransitioning.swift
//  NcSejima
//
//  Created by Damien Noël Dubuisson on 15/11/2018.
//  Copyright © 2018 Loïc GRIFFIE. All rights reserved.
//
// See: https://github.com/ColinEberhardt/VCTransitionsLibrary
// => ./AnimationControllers/CECardsAnimationController.m
//

import UIKit

open class MUCardTransitioning: MUAnimatedTransitioning {
    override open func animateTransition(using transitionContext: UIViewControllerContextTransitioning,
                                         from: UIViewController,
                                         to: UIViewController) {
        reverse ? reverseAnimation(using: transitionContext, from: from, to: to)
            : forwardAnimation(using: transitionContext, from: from, to: to)
    }

    private func forwardAnimation(using transitionContext: UIViewControllerContextTransitioning,
                                  from: UIViewController,
                                  to: UIViewController) {
        //
        let containerView = transitionContext.containerView

        // Add the to.view to the container off the bottom of the sceen
        let frame = transitionContext.initialFrame(for: from)
        to.view.frame = frame
        to.view.frame.origin.y = frame.size.height
        containerView.insertSubview(to.view, aboveSubview: from.view)

        //
        let t1 = firstTransform()
        let t2 = secondTransform(with: from.view)

        UIView.animateKeyframes(withDuration: duration, delay: 0.0, options: .calculationModeCubic, animations: {
            // Push the from.view to the back
            UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 0.4, animations: {
                from.view.layer.transform = t1
                from.view.alpha = 0.6
            })
            UIView.addKeyframe(withRelativeStartTime: 0.2, relativeDuration: 0.4, animations: {
                from.view.layer.transform = t2
            })

            // Slide the to.view upwards
            // In his original implementation Tope used a 'spring' animation, however this does not work with keyframes,
            // so we simulate it by overshooting the final location in the first keyframe
            UIView.addKeyframe(withRelativeStartTime: 0.6, relativeDuration: 0.2, animations: {
                to.view.frame = to.view.frame.offsetBy(dx: 0.0, dy: -30.0)
            })
            UIView.addKeyframe(withRelativeStartTime: 0.8, relativeDuration: 0.2, animations: {
                to.view.frame = frame
            })
        }, completion: { _ in
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        })
    }

    private func reverseAnimation(using transitionContext: UIViewControllerContextTransitioning,
                                  from: UIViewController,
                                  to: UIViewController) {
        //
        let containerView = transitionContext.containerView

        // Add the to.view to the container behind the from.view
        let frame = transitionContext.initialFrame(for: from)
        to.view.frame = frame
        to.view.layer.transform = CATransform3DScale(CATransform3DIdentity, 0.6, 0.6, 1.0)
        to.view.alpha = 0.6
        containerView.insertSubview(to.view, belowSubview: from.view)

        /*
         CGRect frameOffScreen = frame;
         frameOffScreen.origin.y = frame.size.height;
         */

        let t1 = firstTransform()

        UIView.animateKeyframes(withDuration: duration, delay: 0.0, options: .calculationModeCubic, animations: {
            // Push the from.view off the bottom of the screen
            UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 0.5, animations: {
                from.view.frame = frame
                from.view.frame.origin.y = frame.size.height
            })

            // Animate the to.view into place
            UIView.addKeyframe(withRelativeStartTime: 0.35, relativeDuration: 0.35, animations: {
                to.view.layer.transform = t1
                to.view.alpha = 1.0
            })
            UIView.addKeyframe(withRelativeStartTime: 0.75, relativeDuration: 0.25, animations: {
                to.view.layer.transform = CATransform3DIdentity
            })
        }, completion: { _ in
            if transitionContext.transitionWasCancelled {
                to.view.layer.transform = CATransform3DIdentity
                to.view.alpha = 1.0
            }
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        })
    }

    private func firstTransform() -> CATransform3D {
        var t1 = CATransform3DIdentity
        t1.m34 = 1.0 / -900.0
        t1 = CATransform3DScale(t1, 0.95, 0.95, 1.0)
        t1 = CATransform3DRotate(t1, 15.0 * CGFloat.pi / 180.0, 1.0, 0.0, 0.0)
        return t1
    }

    private func secondTransform(with view: UIView) -> CATransform3D {
        var t2 = CATransform3DIdentity
        t2.m34 = firstTransform().m34
        t2 = CATransform3DTranslate(t2, 0.0, view.bounds.size.height * -0.08, 0.0)
        t2 = CATransform3DScale(t2, 0.8, 0.8, 1.0)
        return t2
    }
}
