//
//  RegistVC.m
//  hahaha
//
//  Created by waveknns on 15/11/3.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "RegistVC.h"
#import "Constant.h"
#import "ViewController.h"
#import "DataViewController.h"

@interface RegistVC ()
{
    UIImageView * LoginImage;
    UITextField * PhoneNumber;
    UITextField * Verfication;
    UIButton * BacktoLogin;
    UIButton * Submit;
    UIButton * VerficationBtn;
    NSString * UserName;
    NSString * InputVer;
    NSTimer *  counterDownTimer;
    int freezeCounter;
}
@end

@implementation RegistVC

-(void)viewDidLoad
{
    self.view.backgroundColor=[UIColor whiteColor];
    self.title=@"注册账号";
    [self initLoginPage];
    [self initPhoneNumber];
    [self initVerfication];
    [self initSubmitBtn];
    [self initVerficationBtn];
    UserName = [[NSString alloc]init];
    InputVer = [[NSString alloc]init];
    UIGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(backgroundTap:)];
    [self.view addGestureRecognizer:tapRecognizer];
}

#pragma mark init

-(void)backgroundTap:(id)sender
{
    [PhoneNumber resignFirstResponder];
    [Verfication resignFirstResponder];
    
}

-(void)initLoginPage
{
    
    LoginImage = [[UIImageView alloc]initWithFrame:CGRectMake(self.view.frame.size.width/8.f, self.view.frame.size.height/8.f, self.view.frame.size.width*3/4.f, self.view.frame.size.height/3.f)];
    LoginImage.contentMode=UIViewContentModeScaleAspectFit;
    [LoginImage setImage:[UIImage imageNamed:@"资源_0001s_0000s_0000_留2.png"]];
    [self.view addSubview:LoginImage];
    
    BacktoLogin = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    BacktoLogin.frame=CGRectMake(10, 24, self.view.frame.size.width/6, 44);
    [BacktoLogin setTitle:@"返回" forState:UIControlStateNormal];
    [BacktoLogin addTarget:self action:@selector(BacktoLoginBtn) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:BacktoLogin];

}

-(void)initPhoneNumber
{
    PhoneNumber=[[UITextField alloc]initWithFrame:CGRectMake(self.view.frame.size.width/8.f, self.view.frame.size.height/8.f+self.view.frame.size.height/3.f+self.view.frame.size.height/20.f, self.view.frame.size.width*3/4.f, 40)];
    PhoneNumber.delegate=self;
    PhoneNumber.placeholder=@"输入手机号";
    PhoneNumber.tag=0;
    PhoneNumber.borderStyle=UITextBorderStyleRoundedRect;
    PhoneNumber.clearButtonMode=UITextFieldViewModeWhileEditing;
    PhoneNumber.keyboardType=UIKeyboardTypeNumberPad;
    [self.view addSubview:PhoneNumber];
}

-(void)initVerfication
{
    Verfication=[[UITextField alloc]initWithFrame:CGRectMake(self.view.frame.size.width/8.f, self.view.frame.size.height/8.f+self.view.frame.size.height/3.f+self.view.frame.size.height/8.f, self.view.frame.size.width*2/4.f, 40)];
    Verfication.delegate=self;
    Verfication.tag=1;
    Verfication.placeholder=@"获取验证码";
    Verfication.borderStyle=UITextBorderStyleRoundedRect;
    Verfication.keyboardType=UIKeyboardTypeNumberPad;
    [self.view addSubview:Verfication];
}

-(void)initSubmitBtn
{
    Submit =[UIButton buttonWithType:UIButtonTypeRoundedRect];
    Submit.frame=CGRectMake(self.view.frame.size.width/3.f, self.view.frame.size.height/7.f+self.view.frame.size.height/3.f+self.view.frame.size.height/5.f, self.view.frame.size.width/3.f, 40);
    [Submit setTitle:@"提交" forState:UIControlStateNormal];
    [Submit addTarget:self action:@selector(Submit) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:Submit];
}

-(void)initVerficationBtn
{
    VerficationBtn=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    VerficationBtn.frame=CGRectMake(self.view.frame.size.width/8.f+self.view.frame.size.width*2/4.f, self.view.frame.size.height/8.f+self.view.frame.size.height/3.f+self.view.frame.size.height/8.f, self.view.frame.size.width/3.f, 40);
    [VerficationBtn addTarget:self action:@selector(getVerfication) forControlEvents:UIControlEventTouchUpInside];
    [VerficationBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    [self.view addSubview:VerficationBtn];
}



#pragma mark UITextFiledDelegate

-(BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    if (textField.tag==0) {
        UserName = textField.text;
    }
    if (textField.tag==1) {
        InputVer = textField.text;
    }
    return YES;
}



#pragma mark actions

-(void)BacktoLoginBtn
{
    ViewController *vc=[[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]]instantiateViewControllerWithIdentifier:@"VC"];
    UIWindow *window =[UIApplication sharedApplication].windows.firstObject;
    window.rootViewController=vc;
}

-(void)displayError:(NSError *)error andMessage:(NSString *)message{
    UIAlertController *alert=[UIAlertController alertControllerWithTitle:@"警告!" message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action =[UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDefault handler:nil];
    [alert addAction:action];
    [self presentViewController:alert animated:YES completion:nil];
}


-(void)getVerfication
{
    NSLog(@"%d",(int)UserName.length);
    if ((int)UserName.length!=11) {
        NSMutableDictionary* details = [NSMutableDictionary dictionary];
        [details setValue:@"手机号码无效。" forKey:NSLocalizedDescriptionKey];
        NSError *error = [NSError errorWithDomain:@"LeanSMSDemo" code:1024 userInfo:details];
        [self displayError:error andMessage:@"手机号无效"];
        return;
    }
    [self countDownRequestTimer];
    [self freezeMoreRequest];
    [AVOSCloud requestSmsCodeWithPhoneNumber:UserName
                                     appName:@"校园众包"
                                   operation:@"账号注册"
                                  timeToLive:10
                                    callback:^(BOOL succeeded, NSError *error) {
                                        if (succeeded) {
                                            // 发送成功
                                            //短信格式类似于：
                                            //您正在{某应用}中进行{具体操作名称}，您的验证码是:{123456}，请输入完整验证，有效期为:{10}分钟
                                        }
                                    }];
   
}



-(void)Submit
{
    if (InputVer.length < 6) {
        NSMutableDictionary* details = [NSMutableDictionary dictionary];
        [details setValue:@"验证码无效。" forKey:NSLocalizedDescriptionKey];
        NSError *error = [NSError errorWithDomain:@"LeanSMSDemo" code:1024 userInfo:details];
        [self displayError:error andMessage:@"验证码无效"];
        return;
    }

    [AVOSCloud verifySmsCode:InputVer mobilePhoneNumber:UserName callback:^(BOOL succeeded, NSError *error) {
        if(succeeded){
            DataViewController *vc=[[DataViewController alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
        
        }
        else{
            NSMutableDictionary* details = [NSMutableDictionary dictionary];
            [details setValue:@"验证码无效。" forKey:NSLocalizedDescriptionKey];
            NSError *error = [NSError errorWithDomain:@"LeanSMSDemo" code:1024 userInfo:details];
            [self displayError:error andMessage:@"验证码无效。"];

        }
    }];
}


- (void)freezeMoreRequest {
    // 一分钟内禁止再次发送
    [VerficationBtn setEnabled:NO];
    freezeCounter = 60;
    counterDownTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(countDownRequestTimer) userInfo:nil repeats:YES];
    [counterDownTimer fire];
    
    UIAlertController *alert =[UIAlertController alertControllerWithTitle:@"验证码已发送" message:@"验证码已发送到你请求的手机号码。如果没有收到，可以在一分钟后尝试重新发送。" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action=[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
    [alert addAction:action];
    [self presentViewController:alert animated:YES completion:nil];
    
    
//    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"验证码已发送" message:@"验证码已发送到你请求的手机号码。如果没有收到，可以在一分钟后尝试重新发送。"
//                                                       delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
//    [alertView show];
}

-(void)countDownRequestTimer
{
    static NSString *counterFormat = @"%d 秒后再获取";
    --freezeCounter;
    if (freezeCounter<= 0) {
        [counterDownTimer invalidate];
        counterDownTimer = nil;
        [VerficationBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
        [VerficationBtn setEnabled:YES];
    } else {
        [VerficationBtn setTitle:[NSString stringWithFormat:counterFormat, freezeCounter] forState:UIControlStateNormal];
    }

}



@end
