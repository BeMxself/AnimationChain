//
//  AnimationChain.swift
//  AnimationChain_Example
//
//  Created by SongMingxu on 2018/9/1.
//  Copyright © 2018年 Gengxin. All rights reserved.
//

import Foundation
import UIKit

typealias AnimFunc = () -> ()
typealias InterruptionFun = () -> ()
typealias CompletionFun = (Bool) -> ()
protocol Chainable {
    func next(_ segment: AnimationChain) -> AnimationChain
    func with(_ segment: AnimationChain) -> AnimationChain
    func interrupted(_ fun: @escaping InterruptionFun) -> AnimationChain
    func completed(_ completeFun: @escaping CompletionFun) -> AnimationChain
    func end(_ completeFun: CompletionFun?)
    func doRun()
}
internal protocol ChainCallProtocol{
    func applyAnimations()
    func applyCompletions(_ completed: Bool)
}

class AnimationChain: Chainable, ChainCallProtocol{
    private var _next: AnimationChain?
    private var _with = [AnimationChain]()
    private var _interrupt = [InterruptionFun]()
    private var _complete = [CompletionFun]()
    var animation: AnimFunc!
    internal init() {
        _complete.append{
            if $0 {
                self._next?.doRun()
            } else {
                self._interrupt.forEach{ $0() }
                self._next?.applyCompletions(false)
            }
        }
    }
    func doRun() {
        
    }
    func applyAnimations(){
        self.animation()
        self._with.forEach{ $0.doRun() }
    }
    func applyCompletions(_ completed: Bool){
        _complete.forEach{ $0(completed) }
    }
    func next(_ animationChain: AnimationChain) -> AnimationChain{
        _next = animationChain
        return animationChain
    }
    func with(_ animationChain: AnimationChain) -> AnimationChain{
        _with.append(animationChain)
        return self
    }
    func interrupted(_ fun: @escaping InterruptionFun) -> AnimationChain{
        _interrupt.append(fun)
        return self
    }
    func completed(_ completeFun: @escaping CompletionFun) -> AnimationChain{
        _complete.append(completeFun)
        return self
    }
    func end(_ completeFun: CompletionFun? = nil){
        if let completeFun = completeFun{
            _complete.append(completeFun)
        }
    }
}

class NormalAnimation: AnimationChain{
    private var duration: TimeInterval!
    private var delay: TimeInterval!
    private var options: UIViewAnimationOptions!
    init(duartion: TimeInterval, delay: TimeInterval, options: UIViewAnimationOptions, animation: @escaping AnimFunc) {
        super.init()
        self.duration = duartion
        self.delay = delay
        self.animation = animation
        self.options = options
    }
    override func doRun(){
        UIView.animate(withDuration: duration, delay: delay, options: options, animations: applyAnimations, completion: applyCompletions)
    }
}

extension AnimationChain{
    static func start(duration: TimeInterval, delay: TimeInterval = 0, options: UIViewAnimationOptions = [], animation: @escaping AnimFunc) -> AnimationChain{
        let anim = NormalAnimation(duartion: duration, delay: delay, options: options, animation: animation)
        DispatchQueue.main.async {
            anim.doRun()
        }
        return anim
    }
    func next(duration: TimeInterval, delay: TimeInterval = 0, options: UIViewAnimationOptions = [], animation: @escaping AnimFunc) -> AnimationChain{
        let anim = NormalAnimation(duartion: duration, delay: delay, options: options, animation: animation)
        return self.next(anim)
    }
    func with(duration: TimeInterval, delay: TimeInterval = 0, options: UIViewAnimationOptions = [], animation: @escaping AnimFunc) -> AnimationChain{
        let anim = NormalAnimation(duartion: duration, delay: delay, options: options, animation: animation)
        return self.with(anim)
    }
}

class SpringAnimation: AnimationChain{
    private var duration: TimeInterval!
    private var delay: TimeInterval!
    private var options: UIViewAnimationOptions!
    private var damping: CGFloat!
    private var velocity: CGFloat!
    init(duartion: TimeInterval, delay: TimeInterval, usingSpringWithDamping: CGFloat, initialSpringVelocity: CGFloat, options: UIViewAnimationOptions, animation: @escaping AnimFunc) {
        super.init()
        self.duration = duartion
        self.delay = delay
        self.animation = animation
        self.options = options
    }
    override func doRun(){
        UIView.animate(withDuration: duration, delay: delay, usingSpringWithDamping: damping, initialSpringVelocity: velocity, options: options, animations: applyAnimations, completion: applyCompletions)
    }
}

extension AnimationChain{
    static func start(duration: TimeInterval, delay: TimeInterval = 0, usingSpringWithDamping: CGFloat, initialSpringVelocity: CGFloat, options: UIViewAnimationOptions = [], animation: @escaping AnimFunc) -> AnimationChain{
        let anim = SpringAnimation(duartion: duration, delay: delay, usingSpringWithDamping: usingSpringWithDamping, initialSpringVelocity: initialSpringVelocity, options: options, animation: animation)
        DispatchQueue.main.async {
            anim.doRun()
        }
        return anim
    }
    func next(duration: TimeInterval, delay: TimeInterval = 0, usingSpringWithDamping: CGFloat, initialSpringVelocity: CGFloat, options: UIViewAnimationOptions = [], animation: @escaping AnimFunc) -> AnimationChain{
        let anim = SpringAnimation(duartion: duration, delay: delay, usingSpringWithDamping: usingSpringWithDamping, initialSpringVelocity: initialSpringVelocity, options: options, animation: animation)
        return self.next(anim)
    }
    func with(duration: TimeInterval, delay: TimeInterval = 0, usingSpringWithDamping: CGFloat, initialSpringVelocity: CGFloat, options: UIViewAnimationOptions = [], animation: @escaping AnimFunc) -> AnimationChain{
        let anim = SpringAnimation(duartion: duration, delay: delay, usingSpringWithDamping: usingSpringWithDamping, initialSpringVelocity: initialSpringVelocity, options: options, animation: animation)
        return self.with(anim)
    }
}

