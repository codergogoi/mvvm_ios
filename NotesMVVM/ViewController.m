//
//  ViewController.m
//  NotesMVVM
//
//  Created by MAC01 on 24/05/17.
//  Copyright © 2017 JayantaGogoi. All rights reserved.
//

#import "ViewController.h"
#import "API_Data.h"
#import "ViewModel.h"
#import "CustomCell.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource, UITextFieldDelegate>

@property(nonatomic) ViewModel *dataModel;
@property(nonatomic,weak) IBOutlet UITableView *customerTableView;

@property(nonatomic,weak) IBOutlet UITextField *name;
@property(nonatomic,weak) IBOutlet UITextField *address;



@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self.name setDelegate:self];
    [self.address setDelegate:self];
    
    self.dataModel = [[ViewModel alloc] init];
    
    //Add observer
    [self.dataModel addObserver:self forKeyPath:@"model" options:(NSKeyValueObservingOptionInitial | NSKeyValueObservingOptionNew) context:nil];
    
    [self.dataModel handleAPI:^{
        
        [self refreshDataModel];
        
    }];
    
}


-(IBAction)updateArray:(id)sender{
  
    NSDictionary *dict = [[NSDictionary alloc] initWithObjectsAndKeys:self.name.text,@"name",self.address.text,@"address", nil];
    
    [self.dataModel updateArray:dict completion:^{
        
        [self refreshDataModel];
        
    }];
    
     
}

//observe object if there is any changes happen reload View
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{

    
    if(object == self.dataModel && [keyPath isEqualToString:@"model"]){
    
        if([[object model] isKindOfClass:[API_Data class]]){
             [self refreshDataModel];
  
        }
     }
    
}


-(void)viewWillDisappear:(BOOL)animated{

    [super viewWillDisappear: animated];
    // Safly remove observer
    [self.dataModel removeObserver:self forKeyPath:@"model"];
    
}


-(void)refreshDataModel{

    dispatch_async(dispatch_get_main_queue(), ^{
        
        [self.customerTableView reloadData];
     });
}


#pragma mark - TableView Methods

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return [self.dataModel numbersOfRowsInSection];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{


    CustomCell *cell = (CustomCell *)[self.customerTableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    
    NSDictionary *dict = [self.dataModel dataForRowAtIndexPath:indexPath];
    
    cell.txtUserName.text = [dict objectForKey:@"name"];
    cell.txtAddress.text = [dict objectForKey:@"address"];
 
    return cell;
    
}



#pragma mark -TextFieldMethods
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{

    [self.name resignFirstResponder];
    [self.address resignFirstResponder];
}
 
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}


@end
