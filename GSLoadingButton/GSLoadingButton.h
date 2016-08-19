//
//  ZLoadingView.h
//  ZAccountKit
//
//  Created by Gantulga on 4/13/16.
//  Copyright © 2016 Gantulga. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GSSpinerLayer.h"

typedef void(^Completion)();

@interface GSLoadingButton : UIButton
@property (nonatomic,retain) GSSpinerLayer *spiner;

-(void)setCompletion:(Completion)completion;

-(void)StartAnimation;

-(void)ErrorRevertAnimationCompletion:(Completion)completion;

-(void)ExitAnimationCompletion:(Completion)completion;
-(void)DidStopAnimation ;
@end
