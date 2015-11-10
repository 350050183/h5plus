//
//  DetailViewController.h
//  h5plus
//
//  Created by zhugan on 15/11/9.
//  Copyright © 2015年 zhugan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PDRToolSystem.h"
#import "PDRToolSystemEx.h"
#import "PDRCoreAppFrame.h"
#import "PDRCoreAppManager.h"
#import "PDRCoreAppWindow.h"
#import "PDRCoreAppInfo.h"

@interface DetailViewController : UIViewController{

}

@property (strong, nonatomic) id detailItem;
@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;
//@property (nonatomic,weak)  PDRCoreAppFrame *appFrame;
@property (nonatomic,weak) NSString* URLString;

-(NSString*) currentDate;

@end

