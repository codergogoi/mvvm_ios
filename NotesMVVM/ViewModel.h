//
//  NoteViewModel.h
//  NotesMVVM
//
//  Created by MAC01 on 24/05/17.
//  Copyright © 2017 JayantaGogoi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "API_Data.h"

@interface ViewModel : NSObject

@property(nonatomic,strong) API_Data *model;

-(void)updateArray:(NSDictionary *)dict completion:(void(^)(void))handler;
-(void)handleAPI:(void(^)(void))handler;

-(NSInteger)numbersOfRowsInSection;
-(NSDictionary *)dataForRowAtIndexPath:(NSIndexPath *)indexPath;
 

@end
