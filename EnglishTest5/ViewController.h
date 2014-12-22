//
//  ViewController.h
//  EnglishTest5
//
//  Created by 中山　貴仁 on 2014/12/22.
//  Copyright (c) 2014年 Nakayama Takahito. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<UITableViewDataSource, UITableViewDelegate ,UIAlertViewDelegate>{
    
    IBOutlet UITableView *table;
    
    NSMutableArray *cells;
    
    NSString *title;
}


@end

