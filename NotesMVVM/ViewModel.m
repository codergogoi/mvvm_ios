//
//  ViewModel.m
//  NotesMVVM
//
//  Created by MAC01 on 24/05/17.
//  Copyright © 2017 JayantaGogoi. All rights reserved.
//

#import "ViewModel.h"

@implementation ViewModel


-(instancetype)init{

    self = [super init];
    
    if(self == nil)
        return nil;
    
    return self;
    
}

-(void)handleAPI:(void (^)(void))handler{

    
    NSURL *url = [NSURL URLWithString:@"v2" relativeToURL:[NSURL URLWithString:@"http://jayantagogoi.com/dev/"]];
    
    NSURLSessionConfiguration *sessConfig =  [NSURLSessionConfiguration defaultSessionConfiguration];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    
    [request setHTTPMethod:@"GET"];
    
    
    NSURLSession *session = [NSURLSession sessionWithConfiguration:sessConfig];
    
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
       
        NSString *strResponse  = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        
        NSLog(@"Str %@", strResponse);
        
        if(!error){
        
            NSError *err;
            
            NSMutableArray  *arrData = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&err];
            
            if(!err){
            
                NSLog(@"Data %@", arrData);
                
                self.model = [[API_Data alloc] initWithArrayData:arrData];
                
                handler();
            }

        }
        
    }];
    
    [task resume];
     
}



-(NSInteger)numbersOfRowsInSection{

    return  [self.model.dataArray count];
}

-(NSDictionary *)dataForRowAtIndexPath:(NSIndexPath *)indexPath{

    NSDictionary *dict = [self.model.dataArray objectAtIndex:indexPath.row];
    
    return dict;
    
}

-(void)updateArray:(NSDictionary *)dict completion:(void (^)(void))handler{

    [self.model updateArray:dict];
    
    handler();
    
    NSLog(@"Model Data array count %ld", [self.model.dataArray count]);
}


@end
