//
//  ViewController.h
//  CalculatorTask
//
//  Created by Pratibha on 03/01/19.
//  Copyright © 2019 Pratibha. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *lblCurrentTappedValue;
@property (weak, nonatomic) IBOutlet UITextView *lblTotalString;



- (IBAction)digitTapped:(UIButton *)sender;
- (IBAction)operationTapped:(UIButton *)sender;
- (IBAction)acTapped:(UIButton *)sender;
- (IBAction)bracketTapped:(UIButton *)sender;
- (IBAction)getResultTapped:(UIButton *)sender;
- (IBAction)getPercentTapped:(UIButton *)sender;




@end

