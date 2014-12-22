//
//  TextViewController.m
//  EnglishTest5
//
//  Created by 中山　貴仁 on 2014/12/22.
//  Copyright (c) 2014年 Nakayama Takahito. All rights reserved.
//

#import "TextViewController.h"

@interface TextViewController ()

@end

@implementation TextViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    tv1.delegate = self;
    //tv2.delegate = self;
    
    UIBarButtonItem *close = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone
                                                                           target:self
                                                                           action:@selector(closeKeyboard:)];
    [self.navigationItem setRightBarButtonItem:close];
    
    [self text];
    
    //    UIToolbar *toolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
    //    toolBar.barStyle = UIBarStyleBlackOpaque; // スタイルを設定
    //    [toolBar sizeToFit];
    //
    //    // フレキシブルスペースの作成（Doneボタンを右端に配置したいため）
    //    UIBarButtonItem *spacer = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil] ;
    //
    //    // Doneボタンの作成
    //    UIBarButtonItem *done = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(closeKeyboard:)];
    //
    //    // ボタンをToolbarに設定
    //    NSArray *items = [NSArray arrayWithObjects:spacer, done, nil];
    //    [toolBar setItems:items animated:YES];
    //
    //    // ToolbarをUITextFieldのinputAccessoryViewに設定
    //    tv1.inputAccessoryView = toolBar;


}

-(void)text{
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *title = [defaults stringForKey:@"titleName"];
    NSString *str1 = [defaults stringForKey:title];
 // NSString *str2 = [defaults stringForKey:title];
    
    tv1.text = str1;
  //tv2.text = str2;
    
}

-(void)closeKeyboard:(id)sender{
    
    [tv1 resignFirstResponder];
 // [tv2 resignFirstResponder];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *title = [defaults stringForKey:@"titleName"];
    [defaults setObject:tv1.text forKey:title];
  //[defaults setObject:tv2.text forKey:title];
    
    }


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
