//
//  GSSpinerLayer.h
//  ZAccountKit
//
//  Created by Gantulga on 4/13/16.
//  Copyright © 2016 Gantulga. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

@interface GSSpinerLayer : CAShapeLayer

-(instancetype) initWithFrame:(CGRect)frame;

-(void)startAnimation;

-(void)stopAnimation;

@end
