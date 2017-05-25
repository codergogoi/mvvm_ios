//
//  API_Data.h
//  NotesMVVM
//
//  Created by MAC01 on 24/05/17.
//  Copyright © 2017 JayantaGogoi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface API_Data : NSObject

@property(nonatomic,strong) NSMutableArray *dataArray;

-(instancetype)initWithArrayData:(NSMutableArray *)arr;
-(void)updateArray:(NSDictionary *)dict;

@end
