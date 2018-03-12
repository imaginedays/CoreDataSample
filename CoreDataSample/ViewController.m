//
//  ViewController.m
//  CoreDataSample
// 写的比较全的博客地址
//https://www.imooc.com/article/details/id/22213
//  Created by imaginedays on 2018/3/12.
//  Copyright © 2018年 imaginedays. All rights reserved.
//

#import "ViewController.h"
#import "AppDelegate.h"
#import "Person+CoreDataClass.h"

#define PersonEntityName @"Person"

@interface ViewController ()

@property (nonatomic,retain) AppDelegate *appDelegate;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    ///创建增删改查按钮
    ///拿到appDelegate
    _appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [self createBtns];
}

-(void)createBtns
{
    NSArray *butsNameArray = @[@"增",@"删",@"改",@"查"];
    int butW = 50;
    for (int i = 0; i < butsNameArray.count; i++) {
        ///btn name
        NSString * btnName = butsNameArray[i];
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(i * butW + 10 * i, 200, butW, butW);
        button.backgroundColor = [UIColor blueColor];
        button.layer.cornerRadius = 5;
        button.layer.masksToBounds = YES;
        [button setTitle:btnName forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button addTarget:self
                   action:@selector(clickBtnAction:)
         forControlEvents:UIControlEventTouchUpInside];
        button.tag = 1000 + i;
        [self.view addSubview:button];
    }
}

-(void)clickBtnAction:(UIButton *)btn
{
    NSInteger tag = btn.tag - 1000;
    switch (tag) {
        case 0:
            [self addAction];       ///增
            break;
        case 1:
            [self deleteAction];    ///删
            break;
        case 2:
            [self updateAction];    ///改
            break;
        case 3:
            [self selectAtion];     ///查
            
        default:
            break;
    }
    
}

///改
-(void)updateAction
{
    NSEntityDescription *entity =  [NSEntityDescription entityForName:PersonEntityName inManagedObjectContext:_appDelegate.persistentContainer.viewContext];
    NSFetchRequest *request = [[NSFetchRequest alloc]init];
    [request setEntity:entity];
    
    ///创建条件 年龄 < 10 的学生
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"age<10"];
    [request setPredicate:predicate];
    
    ///获取符合条件的结果
    NSArray *resultArray = [_appDelegate.persistentContainer.viewContext executeFetchRequest:request
                                                                                      error:nil];
    if (resultArray.count>0) {
        for (Person *per in resultArray) {
            ///把年龄 + 10岁
            per.age = per.age + 10;
            ///并且把名字添加一个修
            per.name = [NSString stringWithFormat:@"%@修",per.name];
        }
        ///保存结果并且打印
        [_appDelegate saveContext];
        NSLog(@"修改人的年龄信息完成");
    }else{
        NSLog(@"没有符合条件的结果");
    }
}

///删 先查询再删除
-(void)deleteAction
{
    // 创建请求对象，并指明操作Employee表
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:PersonEntityName];
    
    ///创建条件 年龄 = 11 的学生
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"age=11"];
    [fetchRequest setPredicate:predicate];
    
    // 创建异步请求对象，并通过一个block进行回调，返回结果是一个NSAsynchronousFetchResult类型参数
    NSAsynchronousFetchRequest *asycFetchRequest = [[NSAsynchronousFetchRequest alloc] initWithFetchRequest:fetchRequest completionBlock:^(NSAsynchronousFetchResult * _Nonnull result) {
        [result.finalResult enumerateObjectsUsingBlock:^(Person * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            NSLog(@"fetch request result Person.count = %ld, Person.name = %@ Person.age = %hd", result.finalResult.count, obj.name,obj.age);
             [_appDelegate.persistentContainer.viewContext deleteObject:obj];
             [_appDelegate saveContext];
             NSLog(@"删除年龄为11的人完成");
        }];
        
    }];
    // 执行异步请求，和批量处理执行同一个请求方法
    NSError *error = nil;
    [_appDelegate.persistentContainer.viewContext executeRequest:asycFetchRequest error:&error];
    // 错误处理
    if (error) {
        NSLog(@"fetch request result error : %@", error);
        
    }
}

///查  异步查询
-(void)selectAtion
{

    // 创建请求对象，并指明操作Employee表
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:PersonEntityName];
    // 创建异步请求对象，并通过一个block进行回调，返回结果是一个NSAsynchronousFetchResult类型参数
    NSAsynchronousFetchRequest *asycFetchRequest = [[NSAsynchronousFetchRequest alloc] initWithFetchRequest:fetchRequest completionBlock:^(NSAsynchronousFetchResult * _Nonnull result) {
        [result.finalResult enumerateObjectsUsingBlock:^(Person * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            NSLog(@"fetch request result Person.count = %ld, Person.name = %@ Person.age = %hd", result.finalResult.count, obj.name,obj.age);
        
    }];
        
    }];
    // 执行异步请求，和批量处理执行同一个请求方法
    NSError *error = nil;
    [_appDelegate.persistentContainer.viewContext executeRequest:asycFetchRequest error:&error];
    // 错误处理
    if (error) {
        NSLog(@"fetch request result error : %@", error);
        
    }

}

//增
-(void)addAction
{
    Person *per = [NSEntityDescription insertNewObjectForEntityForName:PersonEntityName inManagedObjectContext:_appDelegate.persistentContainer.viewContext];

    per.name = [NSString stringWithFormat:@"我是编号%d",arc4random()%10];
    per.age = arc4random()%15;
    
    [_appDelegate saveContext];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
