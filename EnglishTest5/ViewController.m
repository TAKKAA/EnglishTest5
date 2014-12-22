//
//  ViewController.m
//  EnglishTest5
//
//  Created by 中山　貴仁 on 2014/12/22.
//  Copyright (c) 2014年 Nakayama Takahito. All rights reserved.
//

#import "ViewController.h"
#import "TextViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    table.dataSource = self;
    table.delegate = self;
    
    self.title = @"English Test";
    
    cells = [[NSMutableArray alloc] init];

}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    UIBarButtonItem *rightButton =  [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemEdit
                                                                                  target:self
                                                                                  action:@selector(goText)];
    [self.navigationItem setRightBarButtonItem:rightButton];
    
    // UIBarButtonItemに表示文字列を渡して、インスタンス化します。
    UIBarButtonItem *btn = [[UIBarButtonItem alloc]
                            initWithTitle:@"戻る"
                            style:UIBarButtonItemStylePlain
                            target:self
                            action:@selector(back:)];
    
    // ナビゲーションバーの左側に追加する。
    self.navigationItem.leftBarButtonItem = btn;
    
    // なお右側に追加する時は、以下のようにする。
    // self.navigationItem.rightBarButtonItem = btn;
}

-(void)back:(id)sender{
    
    TextViewController *ViewController2 = [self.storyboard instantiateViewControllerWithIdentifier:@"First"];
    [self presentViewController:ViewController2 animated:YES completion:nil];
    
}

- (void)goText
{
    [self setEditing:YES animated:NO];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return  1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
       return cells.count;
    
}
-(void)setEditing:(BOOL)editing animated:(BOOL)animated{
    
    [super setEditing:editing animated:animated];
    [table setEditing:editing animated:YES];
    
    if (editing) {
        
        UIBarButtonItem *BarButton = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
                                                                                  target:self
                                                                                  action:@selector(addRow:)];
        
        [self.navigationItem setLeftBarButtonItem:BarButton animated:YES];
        
        UIBarButtonItem *rightButton =  [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone
                                                                                      target:self
                                                                                      action:@selector(done)];
        [self.navigationItem setRightBarButtonItem:rightButton];
        
     // j  [self.navigationItem setLeftBarButtonItem:nil animated:YES];
    
    }else{
        
        [self.navigationItem setLeftBarButtonItem:nil animated:YES];
        
        
        UIBarButtonItem *rightButton =  [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemEdit
                                                                                      target:self
                                                                                      action:@selector(goText)];
        [self.navigationItem setRightBarButtonItem:rightButton];

    }
    
}

- (void)done
{
    [self setEditing:NO animated:YES];
    
    UIBarButtonItem *btn = [[UIBarButtonItem alloc]
                            initWithTitle:@"戻る"
                            style:UIBarButtonItemStylePlain
                            target:self
                            action:@selector(back:)];
    
    // ナビゲーションバーの左側に追加する。
    self.navigationItem.leftBarButtonItem = btn;
    
    // なお右側に追加する時は、以下のようにする。
    // self.navigationItem.rightBarButtonItem = btn;

    
    
}

-(void)addRow:(id)sender{
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"タイトル"
                                                    message:nil
                                                   delegate:self
                                          cancelButtonTitle:@"キャンセル"
                                          otherButtonTitles:@"OK", nil];
    
    [alert setAlertViewStyle:UIAlertViewStylePlainTextInput];
    
    [alert show];
    
    
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if (buttonIndex == 1) {
        
        
        title = [[alertView textFieldAtIndex:0] text];
        
        
        //アイテムの挿入位置を配列の最後尾に指定
        NSInteger row = [cells count];
        [cells insertObject:title atIndex:row];
        
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:row inSection:0];
        
        //テーブルの最後の行にアイテムを追加
        [table insertRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
        //追加した行へスクロール
        [table scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:row inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:YES];
        
    }
    
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIStoryboard *storyboard =  [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    TextViewController *tVC =  (TextViewController *)[storyboard instantiateViewControllerWithIdentifier:@"Text"];
    [self.navigationController pushViewController:tVC animated:YES];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *key = [cells objectAtIndex:indexPath.row];
    [defaults setObject:key forKey:@"titleName"];
    [defaults synchronize];
    [table reloadData];
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    //セルに入れるテキストを配列から取得
    cell.textLabel.text = [cells objectAtIndex:indexPath.row];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle
forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [cells removeObjectAtIndex:indexPath.row]; // 削除ボタンが押された行のデータを配列から削除します。
        [table deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // ここは空のままでOKです。
    }
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
