//
//  ZLoadingView.h
//  ZAccountKit
//
//  Created by Gantulga on 4/13/16.
//  Copyright © 2016 Gantulga. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GSSpinerLayer.h"

@interface GSLoadingButton : UIButton
@property (nonatomic,retain) GSSpinerLayer *spiner;

-(void)startAnimation;
-(void)stopAnimation ;
@end
