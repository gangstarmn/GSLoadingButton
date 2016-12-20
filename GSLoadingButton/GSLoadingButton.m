//
//  ZLoadingView.h
//  ZAccountKit
//
//  Created by Gantulga on 4/13/16.
//  Copyright © 2016 Gantulga. All rights reserved.
//

#import "GSLoadingButton.h"


@interface GSLoadingButton ()

@property (nonatomic,assign) CFTimeInterval shrinkDuration;
@property (nonatomic,retain) CAMediaTimingFunction *shrinkCurve;
@property (nonatomic,retain) CAMediaTimingFunction *expandCurve;
@property (nonatomic,retain) UIColor *color;

@end

@implementation GSLoadingButton

- (CAMediaTimingFunction *)shrinkCurve {
    if (!_shrinkCurve) {
        _shrinkCurve = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    }
    return _shrinkCurve;
}

- (CAMediaTimingFunction *)expandCurve {
    if (!_expandCurve) {
        _expandCurve = [CAMediaTimingFunction functionWithControlPoints:0.95 :0.02 :1 :0.05];
    }
    return _expandCurve;
}

- (GSSpinerLayer *)spiner {
    if (!_spiner) {
        _spiner = [[GSSpinerLayer alloc] initWithFrame:self.frame];
    }
    return _spiner;
}

- (CFTimeInterval)shrinkDuration {
    return 0.1;
}

-(instancetype) initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self.layer addSublayer:self.spiner];
        [self setup];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self.layer addSublayer:self.spiner];
    [self setup];
}

-(void)setup{
    self.layer.cornerRadius = CGRectGetHeight(self.bounds) / 2;
    self.clipsToBounds = true;
}

- (void)scaleToSmall
{
    typeof(self) __weak weak = self;
    
    self.transform = CGAffineTransformMakeScale(1, 1);
    [UIView animateWithDuration:0.3 delay:0 usingSpringWithDamping:0.5f initialSpringVelocity:0.0f options:UIViewAnimationOptionLayoutSubviews animations:^{
        weak.transform = CGAffineTransformMakeScale(0.9, 0.9);
    } completion:^(BOOL finished) {
            
    }];
}

- (void)scaleAnimation
{
    typeof(self) __weak weak = self;
    [UIView animateWithDuration:0.3 delay:0 usingSpringWithDamping:0.5f initialSpringVelocity:0.0f options:UIViewAnimationOptionLayoutSubviews animations:^{
        weak.transform = CGAffineTransformMakeScale(1, 1);
    } completion:^(BOOL finished) {
    }];
//    [self StartAnimation];
}

- (void)scaleToDefault
{
    typeof(self) __weak weak = self;
    [UIView animateWithDuration:0.3 delay:0 usingSpringWithDamping:0.5f initialSpringVelocity:0.4f options:UIViewAnimationOptionLayoutSubviews animations:^{
        weak.transform = CGAffineTransformMakeScale(1, 1);
    } completion:^(BOOL finished) {
        
    }];
}

-(void)startAnimation{
    
    [self performSelector:@selector(Revert) withObject:nil afterDelay:0.f];
    [self.layer addSublayer:self.spiner];
    CABasicAnimation *shrinkAnim = [CABasicAnimation animationWithKeyPath:@"bounds.size.width"];
    shrinkAnim.fromValue = @(CGRectGetWidth(self.bounds));
    shrinkAnim.toValue = @(CGRectGetHeight(self.bounds));
    shrinkAnim.duration = self.shrinkDuration;
    shrinkAnim.timingFunction = self.shrinkCurve;
    shrinkAnim.fillMode = kCAFillModeForwards;
    shrinkAnim.removedOnCompletion = false;
    [self.layer addAnimation:shrinkAnim forKey:shrinkAnim.keyPath];
    [self.spiner startAnimation];
    [self setUserInteractionEnabled:false];
}

-(void)ErrorRevertAnimationCompletion
{
//    self.block = completion;
    CABasicAnimation *shrinkAnim = [CABasicAnimation animationWithKeyPath:@"bounds.size.width"];
    shrinkAnim.fromValue = @(CGRectGetHeight(self.bounds));
    shrinkAnim.toValue = @(CGRectGetWidth(self.bounds));
    shrinkAnim.duration = self.shrinkDuration;
    shrinkAnim.timingFunction = self.shrinkCurve;
    shrinkAnim.fillMode = kCAFillModeForwards;
    shrinkAnim.removedOnCompletion = false;
    self.color = self.backgroundColor;
    
    CABasicAnimation *backgroundColor = [CABasicAnimation animationWithKeyPath:@"backgroundColor"];
    backgroundColor.toValue  = (__bridge id)[UIColor redColor].CGColor;
    backgroundColor.duration = 0.1f;
    backgroundColor.timingFunction = self.shrinkCurve;
    backgroundColor.fillMode = kCAFillModeForwards;
    backgroundColor.removedOnCompletion = false;
    
    CAKeyframeAnimation *keyFrame = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    CGPoint point = self.layer.position;
    keyFrame.values = @[[NSValue valueWithCGPoint:CGPointMake(point.x, point.y)],
                        
                        [NSValue valueWithCGPoint:CGPointMake(point.x - 10, point.y)],
                        
                        [NSValue valueWithCGPoint:CGPointMake(point.x + 10, point.y)],
                        
                        [NSValue valueWithCGPoint:CGPointMake(point.x - 10, point.y)],
                        
                        [NSValue valueWithCGPoint:CGPointMake(point.x + 10, point.y)],
                        
                        [NSValue valueWithCGPoint:CGPointMake(point.x - 10, point.y)],
                        
                        [NSValue valueWithCGPoint:CGPointMake(point.x + 10, point.y)],
                        
                        [NSValue valueWithCGPoint:point]];
    keyFrame.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    keyFrame.duration = 0.5f;
    keyFrame.delegate = self;
    self.layer.position = point;
    
    [self.layer addAnimation:backgroundColor forKey:backgroundColor.keyPath];
    [self.layer addAnimation:keyFrame forKey:keyFrame.keyPath];
    [self.layer addAnimation:shrinkAnim forKey:shrinkAnim.keyPath];
    [self.spiner stopAnimation];
    [self setUserInteractionEnabled:true];
}

-(void)ExitAnimationCompletion{

//    self.block = completion;
    CABasicAnimation *expandAnim = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    expandAnim.fromValue = @(1.0);
    expandAnim.toValue = @(33.0);
    expandAnim.timingFunction = self.expandCurve;
    expandAnim.duration = 0.3; 
    expandAnim.delegate = self;
    expandAnim.fillMode = kCAFillModeForwards;
    expandAnim.removedOnCompletion = false;
    [self.layer addAnimation:expandAnim forKey:expandAnim.keyPath];
    [self.spiner stopAnimation];
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{

    CABasicAnimation *cab = (CABasicAnimation *)anim;
    if ([cab.keyPath isEqualToString:@"transform.scale"]) {
        [self setUserInteractionEnabled:true];
//        if (self.block) {
//            self.block();
//        }
        [NSTimer scheduledTimerWithTimeInterval:0.5f target:self selector:@selector(stopAnimation) userInfo:nil repeats:NO];
    }
}

-(void)Revert{

    CABasicAnimation *backgroundColor = [CABasicAnimation animationWithKeyPath:@"backgroundColor"];
    backgroundColor.toValue  = (__bridge id)self.backgroundColor.CGColor;
    backgroundColor.duration = 0.1f;
    backgroundColor.timingFunction = self.shrinkCurve;
    backgroundColor.fillMode = kCAFillModeForwards;
    backgroundColor.removedOnCompletion = false;
    [self.layer addAnimation:backgroundColor forKey:@"backgroundColors"];
    
}

-(void)stopAnimation{
    [self.spiner stopAnimation];
    self.userInteractionEnabled = YES;
    [self.layer removeAllAnimations];
}

@end
