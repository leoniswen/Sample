//
//  LEOViewController.m
//  TextViewSample
//
//  Created by roger on 13-4-21.
//
//

#import "LEOViewController.h"



@interface LEOViewController ()

@end

@implementation LEOViewController

@synthesize labelView;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    // 通过代码创建TextView
    CGRect textViewFrame = CGRectMake(20.0f, 20.0f, 280.0f, 124.0f);
    UITextView *textView = [[UITextView alloc] initWithFrame:textViewFrame];
    
    // 使return键改变为Done键
    textView.returnKeyType = UIReturnKeyDone;
    
    // 将ViewController对象设置为UITextView
    textView.delegate = self;
    
    // 加入一个labelView
    CGRect labelViewFrame = CGRectMake(20.0f, 145.0f, 280.0f, 30.0f);
    labelView = [[UILabel alloc] initWithFrame:labelViewFrame];
    labelView.textAlignment = NSTextAlignmentRight;
    labelView.text = [NSString stringWithFormat:@"还可以输入140个字符"];
    
    [self.view addSubview:textView];
    [self.view addSubview:labelView];
}

#pragma mark - HideKeyboard

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSLog(@"touchesBegan:withEvent:");
    [self.view endEditing:YES];
    [super touchesBegan:touches withEvent:event];
}

#pragma mark - UITextViewDelegate

// 当UITextView获得焦点前会调用textViewShouldBeginEditing方法
// 当UITextView获得了焦点并且已经是第一响应者，那么就调用textViewDidBeginEditing方法
// 在这里，我们使UITextView获得焦点后背景变为绿色

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    NSLog(@"textViewShouldBeginEditing:");
    return YES;
}

- (void)textViewDidBeginEditing:(UITextView *)textView
{
    NSLog(@"textViewDidBeginEditing:");
    textView.backgroundColor = [UIColor greenColor];
}

// 当UITextView失去焦点前会调用textViewShouldEndEditing方法
// 当UITextView失去焦点后会调用textViewDidEndEditing方法
// 在这里，我们使UITextView失去焦点后背景变为原来的颜色

- (BOOL)textViewShouldEndEditing:(UITextView *)textView
{
    NSLog(@"textViewShouldEndEditing:");
    textView.backgroundColor = [UIColor whiteColor];
    return YES;
}

- (void)textViewDidEndEditing:(UITextView *)textView
{
    NSLog(@"textViewDidEndEditing:");
}

// 当用户输入文字前会调用shouldChangeTextInRange方法
// 这个方法可以方便定位测试用户输入的字符，并且限制用户的输入
// 在这里，当用户输入的字符中包含newlineCharacterSet时，不予换行
// 另外，当用户输入的字符超过140个时，不予输入
// 同时，当用户修改字符时，我们提示用户还可以输入多少个字符

- (BOOL)textView:(UITextView *)textView
    shouldChangeTextInRange:(NSRange)range
    replacementText:(NSString *)text
{
    NSCharacterSet *doneButtonCharacterSet = [NSCharacterSet newlineCharacterSet];
    NSRange replacementTextRange = [text rangeOfCharacterFromSet:doneButtonCharacterSet];
    NSUInteger location = replacementTextRange.location;
    if (textView.text.length + text.length > 140) {
        if (location != NSNotFound) {
            [textView resignFirstResponder];
        }
        return NO;
    }else if (location != NSNotFound){
        [textView resignFirstResponder];
        return NO;
    }
    
    // 当用户每次输入时显示还能输入多少个字符
    NSUInteger howLongCharacterSet = 140 - textView.text.length;
    NSLog(@"%d Less", howLongCharacterSet);
    
    labelView.text = [NSString stringWithFormat:@"还可以输入%d个字符", howLongCharacterSet];
    
    return YES;
}

// 当用户修改文字时才会调用textViewDidChangeSelection方法

- (void)textViewDidChangeSelection:(UITextView *)textView
{
    NSLog(@"textViewDidChangeSelection:");
}

#pragma mark -

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

















































