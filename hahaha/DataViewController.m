//
//  DataViewController.m
//  hahaha
//
//  Created by waveknns on 15/11/12.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "DataViewController.h"
#import "Constant.h"

@interface DataViewController ()
{
    UITextField * Nickname;
    UITextField * Province;
    UITextField * University;
    UITextField * StuNumber;
    UITextField * Password;
    UIButton * ConfirmBtn;
}
@end

@implementation DataViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title=@"完善资料";
    [self initTextFiled];
    [self initConfirmBtn];
    // Do any additional setup after loading the view.
}

-(void)initTextFiled
{
    Nickname=[[UITextField alloc]initWithFrame:CGRectMake(self.view.frame.size.width/4.f, self.view.frame.size.height/4.f, self.view.frame.size.width*2.5/4.f, 40)];
    Province=[[UITextField alloc]initWithFrame:CGRectMake(self.view.frame.size.width/4.f, self.view.frame.size.height/4.f+50, self.view.frame.size.width*2.5/4.f, 40)];
    University=[[UITextField alloc]initWithFrame:CGRectMake(self.view.frame.size.width/4.f, self.view.frame.size.height/4.f+100, self.view.frame.size.width*2.5/4.f, 40)];
    StuNumber=[[UITextField alloc]initWithFrame:CGRectMake(self.view.frame.size.width/4.f, self.view.frame.size.height/4.f+150, self.view.frame.size.width*2.5/4.f, 40)];
    Password=[[UITextField alloc]initWithFrame:CGRectMake(self.view.frame.size.width/4.f, self.view.frame.size.height/4.f+200, self.view.frame.size.width*2.5/4.f, 40)];
    
    Nickname.placeholder=@"昵称";
    Province.placeholder=@"所在地";
    University.placeholder=@"院校";
    StuNumber.placeholder=@"学号";
    Password.placeholder=@"学号密码";
    
    Nickname.borderStyle=UITextBorderStyleRoundedRect;
    Province.borderStyle=UITextBorderStyleRoundedRect;
    University.borderStyle=UITextBorderStyleRoundedRect;
    StuNumber.borderStyle=UITextBorderStyleRoundedRect;
    Password.borderStyle=UITextBorderStyleRoundedRect;
    
//    Nickname.leftView
    
    
    [self.view addSubview:Nickname];
    [self.view addSubview:Province];
    [self.view addSubview:University];
    [self.view addSubview:StuNumber];
    [self.view addSubview:Password];

    
}

-(void)initConfirmBtn
{
    ConfirmBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    ConfirmBtn.frame=CGRectMake(self.view.frame.size.width/4.f, self.view.frame.size.height/4.f+250, self.view.frame.size.width*2.5/4.f, 50);
    [ConfirmBtn setTitle:@"提交" forState:UIControlStateNormal];
    [self.view addSubview:ConfirmBtn];
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
