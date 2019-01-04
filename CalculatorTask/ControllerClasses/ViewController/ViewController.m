//
//  ViewController.m
//  CalculatorTask
//
//  Created by Pratibha on 03/01/19.
//  Copyright © 2019 Pratibha. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () {
    
    NSString                 *totalString;
    NSString                 *MainExpresionString;
    NSMutableArray           *allPreviousNumber;
    NSMutableArray           *allExpression;
    BOOL                     isPercentTapped;
    int                      firstValue;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    allPreviousNumber = [[NSMutableArray alloc] init];
    allExpression = [[NSMutableArray alloc] init];
    totalString = @"";
    MainExpresionString = @"";
}


/////////////////////////////************************ Digit Tapped ****************************////////////////////////////////////////////////
- (IBAction)digitTapped:(UIButton *)sender {
    
    NSString *strDigitNumber = sender.currentTitle;
    [allPreviousNumber addObject:strDigitNumber];
    _lblCurrentTappedValue.text = strDigitNumber;
    totalString = [totalString stringByAppendingString:[NSString stringWithFormat:@"%@",strDigitNumber]];
    MainExpresionString = [MainExpresionString stringByAppendingString:[NSString stringWithFormat:@"%@",strDigitNumber]];

    if (isPercentTapped) {

        int secondDigit = [strDigitNumber intValue];
        float precentage = (100 * secondDigit)/firstValue;
        NSLog(@"percentage %f", precentage);
        MainExpresionString = [MainExpresionString stringByReplacingCharactersInRange:NSMakeRange(MainExpresionString.length - 1, 1) withString:@""];
        MainExpresionString = [MainExpresionString stringByAppendingString:[NSString stringWithFormat:@"%f",precentage]];
    }
    _lblTotalString.text = totalString;
}


/////////////////////////////************************ Opertaion Tapped ****************************////////////////////////////////////////////////
- (IBAction)operationTapped:(UIButton *)sender {
    
    NSString *strOperation = sender.currentTitle;
    [allExpression addObject:strOperation];
    _lblCurrentTappedValue.text = strOperation;
    totalString = [totalString stringByAppendingString:[NSString stringWithFormat:@" %@ ",strOperation]];
    _lblTotalString.text = totalString;
    if (allExpression.count != 1 && [[allExpression lastObject] isEqual:@"√"]) {
        MainExpresionString = [MainExpresionString stringByAppendingString:@")"];
    }
    
    ///////For Modulus////////
    if ([strOperation  isEqual: @"%"]) {
        NSUInteger lengthi = [MainExpresionString length];
        NSLog(@"%lu",(unsigned long)lengthi);
        for(NSInteger i = MainExpresionString.length - 1; i >= 0; i--) {
            
            NSString *theCharacter = [NSString stringWithFormat:@"%c", [MainExpresionString characterAtIndex:i]];
            if ([theCharacter  isEqual: @" "] || [theCharacter  isEqual: @"("] || [theCharacter  isEqual: @")"]) {
                NSLog(@"%@",theCharacter);
        
                NSRange range = NSMakeRange(i,MainExpresionString.length - i);
                NSString *code = [MainExpresionString substringWithRange:NSMakeRange(i,MainExpresionString.length - i)];
                NSLog(@"%@",code);
                if ([code containsString:@"("]) {
                    MainExpresionString = [MainExpresionString stringByReplacingCharactersInRange:range withString:[NSString stringWithFormat:@"modulus:by:%@,",code]];
                }
                else {
                    MainExpresionString = [MainExpresionString stringByReplacingCharactersInRange:range withString:[NSString stringWithFormat:@"modulus:by:(%@,",code]];
                }
                
                NSLog(@"%@",MainExpresionString);
                break;
            }
            else if ([[allExpression firstObject]  isEqual: @"%"]) {
                
                NSRange range = NSMakeRange(0,MainExpresionString.length);
                NSString *code = [MainExpresionString substringWithRange:NSMakeRange(0,MainExpresionString.length)];
                NSLog(@"%@",code);
                if ([code containsString:@"("]) {
                    MainExpresionString = [MainExpresionString stringByReplacingCharactersInRange:range withString:[NSString stringWithFormat:@"modulus:by:%@,",code]];
                }
                else {
                    MainExpresionString = [MainExpresionString stringByReplacingCharactersInRange:range withString:[NSString stringWithFormat:@"modulus:by:(%@,",code]];
                }
                NSLog(@"%@",MainExpresionString);
                break;
            }
        }
    }
    ///////For Square Root////////
    else if ([strOperation  isEqual: @"√"]) {
        NSUInteger lengthi = [MainExpresionString length];
        NSLog(@"%lu",(unsigned long)lengthi);
        
        for(NSInteger i = MainExpresionString.length - 1; i >= 0; i--) {
            NSString *theCharacter = [NSString stringWithFormat:@"%c", [MainExpresionString characterAtIndex:i]];
            if ([theCharacter  isEqual: @" "] || [theCharacter  isEqual: @"("] || [theCharacter  isEqual: @")"]) {
                NSLog(@"%@",theCharacter);
                
                NSRange range = NSMakeRange(i,MainExpresionString.length - i);
                NSString *code = [MainExpresionString substringWithRange:NSMakeRange(i,MainExpresionString.length - i)];
                NSLog(@"%@",code);
                MainExpresionString = [MainExpresionString stringByReplacingCharactersInRange:range withString:[NSString stringWithFormat:@"sqrt:("]];
                NSLog(@"%@",MainExpresionString);
                break;
            }
            else if ([[allExpression firstObject]  isEqual: @"√"]) {
                
                NSRange range = NSMakeRange(0,MainExpresionString.length);
                NSString *code = [MainExpresionString substringWithRange:NSMakeRange(0,MainExpresionString.length)];
                NSLog(@"%@",code);
                MainExpresionString = [MainExpresionString stringByReplacingCharactersInRange:range withString:[NSString stringWithFormat:@"sqrt:("]];
                NSLog(@"%@",MainExpresionString);
                break;
            }
        }
    }
    else {
        MainExpresionString = [MainExpresionString stringByAppendingString:[NSString stringWithFormat:@" %@ ",strOperation]];
    }
}


///////For Manage Brackets////////
- (IBAction)bracketTapped:(UIButton *)sender {
    NSString *strBracket = sender.currentTitle;
    _lblCurrentTappedValue.text = strBracket;
    totalString = [totalString stringByAppendingString:[NSString stringWithFormat:@"%@",strBracket]];
    _lblTotalString.text = totalString;
    if (allExpression.count != 1 && [[allExpression lastObject] isEqual:@"√"]) {
        MainExpresionString = [MainExpresionString stringByAppendingString:@")"];
    }
    MainExpresionString = [MainExpresionString stringByAppendingString:[NSString stringWithFormat:@"%@",strBracket]];
}


///////For Result////////
- (IBAction)getResultTapped:(UIButton *)sender {
    char lastChar = [MainExpresionString characterAtIndex:MainExpresionString.length - 1];
    if (allExpression.count != 1 && [[allExpression lastObject] isEqual:@"√"] && lastChar != ')') {
        MainExpresionString = [MainExpresionString stringByAppendingString:@")"];
    } else if (allExpression.count != 1 && [[allExpression lastObject] isEqual:@"%"] && lastChar != ')') {
        MainExpresionString = [MainExpresionString stringByAppendingString:@")"];
    }
    
    if (allExpression.count == 1 && [[allExpression firstObject] isEqual:@"%"]) {
        if (lastChar != ')') {
            MainExpresionString = [MainExpresionString stringByAppendingString:@")"];
        }
        NSLog(@"%@", MainExpresionString);
        NSExpression *expression = [NSExpression expressionWithFormat:[NSString stringWithFormat:@"%@",MainExpresionString]];
        id result = [expression expressionValueWithObject:nil context:nil];
        NSLog(@"%@", result);
        _lblCurrentTappedValue.text = [NSString stringWithFormat:@"%@",result];
    }
    else if (allExpression.count == 1 && [[allExpression firstObject] isEqual:@"√"]) {
        NSString *lastDigit = [totalString substringWithRange:NSMakeRange(2, totalString.length - 2)];
        MainExpresionString = [NSString stringWithFormat:@"sqrt:(%@)",lastDigit];
        NSLog(@"%@", MainExpresionString);
        NSExpression *expression = [NSExpression expressionWithFormat:[NSString stringWithFormat:@"%@",MainExpresionString]];
        id result = [expression expressionValueWithObject:nil context:nil];
        NSLog(@"%@", result);
        _lblCurrentTappedValue.text = [NSString stringWithFormat:@"%@",result];
    }
    else {
        NSLog(@"%@", MainExpresionString);
        NSExpression *expression = [NSExpression expressionWithFormat:[NSString stringWithFormat:@"%@",MainExpresionString]];
        id result = [expression expressionValueWithObject:nil context:nil];
        NSLog(@"%@", result);
        _lblCurrentTappedValue.text = [NSString stringWithFormat:@"%@",result];
    }
}


///////For Percentage////////
- (IBAction)getPercentTapped:(UIButton *)sender {
    
    isPercentTapped = true;
    totalString = [totalString stringByAppendingString:[NSString stringWithFormat:@"Percent"]];
    _lblTotalString.text = totalString;
    [allExpression addObject:@"Percent"];
    
    if (allExpression.count != 1 && [[allExpression lastObject] isEqual:@"√"]) {
        MainExpresionString = [MainExpresionString stringByAppendingString:@")"];
    }
    if ([[allExpression firstObject]  isEqual: @"Percent"]) {
        NSString *code = [MainExpresionString substringWithRange:NSMakeRange(0,MainExpresionString.length)];
        firstValue = [code intValue];
        NSLog(@"%d",firstValue);
        MainExpresionString = [MainExpresionString stringByReplacingCharactersInRange:NSMakeRange(0,MainExpresionString.length) withString:@""];
    }
    else {
        for(NSInteger i = MainExpresionString.length - 1; i >= 0; i--) {
            NSString *theCharacter = [NSString stringWithFormat:@"%c", [MainExpresionString characterAtIndex:i]];
            if ([theCharacter  isEqual: @" "] || [theCharacter  isEqual: @"("] || [theCharacter  isEqual: @")"]) {
                NSString *code = [MainExpresionString substringWithRange:NSMakeRange(i,MainExpresionString.length - i)];
                firstValue = [code intValue];
                NSLog(@"%d",firstValue);
                MainExpresionString = [MainExpresionString stringByReplacingCharactersInRange:NSMakeRange(i,MainExpresionString.length - i) withString:@""];
                break;
            }
        }
    }
}


///////For All Clear////////
- (IBAction)acTapped:(UIButton *)sender {
    _lblTotalString.text = @"";
    _lblCurrentTappedValue.text = @"";
    totalString = @"";
    MainExpresionString = @"";
    [allExpression removeAllObjects];
    [allPreviousNumber removeAllObjects];
}
@end
