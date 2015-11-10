//
//  DetailViewController.m
//  h5plus
//
//  Created by zhugan on 15/11/9.
//  Copyright © 2015年 zhugan. All rights reserved.
//

#import "DetailViewController.h"
#import "AppDelegate.h"


@interface DetailViewController ()

@end

@implementation DetailViewController

#pragma mark - Managing the detail item

- (void)setDetailItem:(id)newDetailItem {
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
            
        // Update the view.
        [self configureView];
    }
}

- (void)configureView {
    // Update the user interface for the detail item.
    if (self.detailItem) {
        self.detailDescriptionLabel.text = [self.detailItem description];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self configureView];
    
//    stand alone runtime 独立集成方式
    PDRCore* pCoreHandle = [PDRCore Instance];
    [pCoreHandle setContainerView:self.view];
    [pCoreHandle start];

    //    widget runtime widget集成方式
//    PDRCore* pCoreHandle = [PDRCore Instance];
//    [pCoreHandle setContainerView:self.view];
//    [pCoreHandle setAutoStartAppid:@"h5plus"];
//    [pCoreHandle start];

    //webview runtime webview集成方式
//    _URLString=@"webview_id_1";
//    [self ShowWebViewPageOne:nil];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(back:) name:@"notfiy_of_back" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(somethingelse:) name:@"notfiy_of_somethingelse" object:nil];
}

-(void)back:(NSNotification*)notify{
    UISplitViewController* sv = ((AppDelegate*)[[UIApplication sharedApplication] delegate]).splitViewController;
    
    UINavigationController *masterNavVC = (UINavigationController *)sv.viewControllers.firstObject;
//    UINavigationController *detailNavVC = (UINavigationController *)sv.viewControllers.lastObject;
    
    //Now you have the master and detail navigation controllers, get your VC you need to manipulate
    NSArray *masterVCs = masterNavVC.viewControllers;
//    NSArray *detailVCs = detailNavVC.viewControllers;
    
    //Remove the ones you need to - this example is arbitrary. Put your logic here
    if(masterVCs.count > 0 && [[[[masterVCs lastObject] viewControllers] lastObject] isKindOfClass:[DetailViewController class]])
    {
        //Remove or add
        dispatch_async(dispatch_get_main_queue(), ^{
            [masterNavVC popViewControllerAnimated:YES];
        });
        
    }
}

-(void)somethingelse:(NSNotification*)notify{
    NSDictionary* userInfo = notify.object;
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"somethingelse called."
                                                                       message:[NSString stringWithFormat:@"参数列表：%@,%@",[userInfo objectForKey:@"arg1"],[userInfo objectForKey:@"arg2"]]
                                                                preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                              handler:^(UIAlertAction * action) {}];
        
        [alert addAction:defaultAction];
        [self presentViewController:alert animated:YES completion:nil];
    });
}

-(void)viewDidAppear:(BOOL)animated{

}

-(void)viewWillDisappear:(BOOL)animated{
//    pCoreHandle = nil;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)ShowWebViewPageOne:(id)sender
{
    // 获取PDRCore句柄
    PDRCore* pCoreHandle = [PDRCore Instance];
//    if (pCoreHandle != nil)
//    {
        // 设置Core启动方式
        [pCoreHandle startAsWebClient];
        
        // 设置拼写Webview将要打开文件的url
        
        NSString* pFilePath = [NSString stringWithFormat:@"http://frontend.t.csq.im/h5plus.html?%@", [self currentDate] ] ;
        
        CGRect StRect = CGRectMake(0, 20, self.view.frame.size.width, self.view.frame.size.height - 20);
        
        PDRCoreAppFrame *appFrame = [[PDRCoreAppFrame alloc] initWithName:_URLString loadURL:pFilePath frame:StRect];
  
        // 设置webview的Appframe
        [pCoreHandle.appManager.activeApp.appWindow registerFrame:appFrame];
        
        // 将AppFrame设置为当前View的Subview
        [self.view addSubview:appFrame];
//    }
}

-(NSString*) currentDate{
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:[NSDate date]];
    
    NSInteger day = [components day];
    NSInteger week = [components month];
    NSInteger year = [components year];
    NSInteger second = [components second];
    
    NSString *string = [NSString stringWithFormat:@"%ld.%ld.%ld.%ld", (long)day, (long)week, (long)year,(long)second];
    return string;
}
@end
