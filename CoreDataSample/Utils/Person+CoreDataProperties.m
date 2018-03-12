//
//  Person+CoreDataProperties.m
//  CoreDataSample
//
//  Created by imaginedays on 2018/3/12.
//  Copyright © 2018年 imaginedays. All rights reserved.
//
//

#import "Person+CoreDataProperties.h"

@implementation Person (CoreDataProperties)

+ (NSFetchRequest<Person *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"Person"];
}

@dynamic name;
@dynamic age;

@end
