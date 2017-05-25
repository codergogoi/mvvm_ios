//
//  API_Data.m
//  NotesMVVM
//
//  Created by MAC01 on 24/05/17.
//  Copyright © 2017 JayantaGogoi. All rights reserved.
//

#import "API_Data.h"

@implementation API_Data

@synthesize dataArray;

-(instancetype)initWithArrayData:(NSMutableArray *)arr{

    self = [super init];
    
    if(self == nil)
        return nil;
    
    self.dataArray = [[NSMutableArray alloc] initWithArray:arr];
    
    return self;

}

-(void)updateArray:(NSDictionary *)dict{

    [self.dataArray addObject:dict];
}




@end
