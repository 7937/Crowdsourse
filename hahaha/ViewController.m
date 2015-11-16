//
//  ViewController.m
//  hahaha
//
//  Created by waveknns on 15/10/21.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "ViewController.h"
#import "Constant.h"
#import "NavigationController.h"


@interface ViewController ()
{
    UIImageView * LoginImage;
    UITextField * CountText;
    UITextField * PasswordText;
    UIButton * LoginBtn;
    UIButton * ForgetPasswordBtn;
    UIButton * RegistBtn;
}

@end

@implementation ViewController
//
//-(void)loadView
//{
//    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
//    self.view = scrollView;
//}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self initLoginPage];
    [self initLoginTextFiled];
    [self initBtn];
    [self initRegistBtn];
    [self initForgetPassWordBtn];
    self.view.backgroundColor = [UIColor whiteColor];
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(backgroundTap:)];
    [self.view addGestureRecognizer:tap];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)backgroundTap:(id)sender
{
    [CountText resignFirstResponder];
    [PasswordText resignFirstResponder];
}

-(void)initLoginPage
{
    self.tabBarController.title=@"登陆账号";
    [self.tabBarController.navigationController.navigationBar setBarTintColor:MainColor];
    
    LoginImage = [[UIImageView alloc]initWithFrame:CGRectMake(self.view.frame.size.width/8.f, self.view.frame.size.height/8.f, self.view.frame.size.width*3/4.f, self.view.frame.size.height/3.f)];
    LoginImage.contentMode=UIViewContentModeScaleAspectFit;
    [LoginImage setImage:[UIImage imageNamed:@"资源_0001s_0000s_0000_留2.png"]];
    
    [self.view addSubview:LoginImage];
}

-(void)initLoginTextFiled
{
    CountText = [[UITextField alloc]initWithFrame:CGRectMake(self.view.frame.size.width/8.f, self.view.frame.size.height/8.f+self.view.frame.size.height/3.f+self.view.frame.size.height/20.f, self.view.frame.size.width*3/4.f, 40)];
    CountText.delegate=self;
    CountText.borderStyle=UITextBorderStyleRoundedRect;
    CountText.placeholder=@"账号";
    CountText.clearButtonMode=UITextFieldViewModeAlways;
    
    
    PasswordText =[[UITextField alloc]initWithFrame:CGRectMake(self.view.frame.size.width/8.f, self.view.frame.size.height/8.f+self.view.frame.size.height/3.f+self.view.frame.size.height/8.f, self.view.frame.size.width*3/4.f, 40)];
    PasswordText.delegate=self;
    PasswordText.borderStyle=UITextBorderStyleRoundedRect;
    PasswordText.placeholder=@"密码";
    PasswordText.secureTextEntry=YES;
    PasswordText.clearButtonMode=UITextFieldViewModeWhileEditing;
    [self.view addSubview:CountText];
    [self.view addSubview:PasswordText];
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
//    NSCharacterSet *characterset=[NSCharacterSet characterSetWithCharactersInString:@"0123456789\b"];
    NSString *text=[textField text];
    NSLog(@"%@",text);
    return YES;
}


-(void)initBtn
{
    LoginBtn =[UIButton buttonWithType:UIButtonTypeRoundedRect];
    LoginBtn.frame =CGRectMake(self.view.frame.size.width/3.f, self.view.frame.size.height/7.f+self.view.frame.size.height/3.f+self.view.frame.size.height/5.f, self.view.frame.size.width/3.f, 40);
    [LoginBtn setTitle:@"登陆" forState:UIControlStateNormal];
//    LoginBtn.backgroundColor=[UIColor grayColor];
    [LoginBtn addTarget:self action:@selector(Login) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:LoginBtn];
}

-(void)Login
{
    NavigationController *navi=[[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]]instantiateViewControllerWithIdentifier:@"Navi"];
    UIWindow*window=[UIApplication sharedApplication].windows.firstObject;
    window.rootViewController=navi;
}

-(void)initRegistBtn
{
    RegistBtn =[UIButton buttonWithType:UIButtonTypeRoundedRect];
    RegistBtn.frame=CGRectMake(self.view.frame.size.width-self.view.frame.size.width/12.f-self.view.frame.size.width/3.f, self.view.frame.size.height/3.f+self.view.frame.size.height/3.f+self.view.frame.size.height/5.f, self.view.frame.size.width/3.f, 40);
//    RegistBtn.backgroundColor=[UIColor grayColor];
//    RegistBtn.tintColor=MainColor;
    [RegistBtn setTitle:@"注册账号" forState:UIControlStateNormal];
    [RegistBtn addTarget:self action:@selector(regist) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:RegistBtn];
}

-(void)initForgetPassWordBtn
{
    ForgetPasswordBtn=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    ForgetPasswordBtn.frame=CGRectMake(self.view.frame.size.width/12.f, self.view.frame.size.height/3.f+self.view.frame.size.height/3.f+self.view.frame.size.height/5.f, self.view.frame.size.width/3.f, 40);
//    ForgetPasswordBtn.backgroundColor=[UIColor grayColor];
    [ForgetPasswordBtn setTitle:@"忘记密码" forState:UIControlStateNormal];
    [ForgetPasswordBtn respondsToSelector:@selector(forgetPassword)];
    [self.view addSubview:ForgetPasswordBtn];
}

-(void)regist
{
//    RegistViewController *vc=[[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"NaviVC"];
//    UIWindow*window=[UIApplication sharedApplication].windows.firstObject;
//    window.rootViewController=vc;
    RegistVC *vc =[[RegistVC alloc]init];
    [self.tabBarController.navigationController pushViewController:vc animated:YES];
}

-(void)forgetPassword
{
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
