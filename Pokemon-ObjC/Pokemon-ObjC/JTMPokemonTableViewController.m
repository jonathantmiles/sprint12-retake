//
//  JTMPokemonTableViewController.m
//  Pokemon-ObjC
//
//  Created by Jonathan T. Miles on 10/26/18.
//  Copyright © 2018 Jonathan T. Miles. All rights reserved.
//

#import "JTMPokemonTableViewController.h"
#import "Pokemon_ObjC-Swift.h"
#import "JTMPokemonObject.h"

@interface JTMPokemonTableViewController ()

@property PokemonAPI *pokemonAPI;
@property NSMutableArray<JTMPokemonObject *> *pokemonArray;

@end

@implementation JTMPokemonTableViewController

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        _pokemonAPI = [[PokemonAPI alloc] init];
    }
    return self;
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        _pokemonAPI = [[PokemonAPI alloc] init];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self updateViews];
}

- (void) updateViews
{
    [self.pokemonAPI fetchAllPokemonWithCompletion:^(NSArray<JTMPokemonObject *> * _Nullable pokemonArray, NSError * _Nullable error) {
        [self.pokemonArray setArray:pokemonArray];
    }];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.pokemonArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PokemonCell" forIndexPath:indexPath];
    
    JTMPokemonObject *pokemon = [self.pokemonArray objectAtIndex:indexPath.row];
    [cell.textLabel setText: pokemon.name];
    
    return cell;
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    PokemonDetailViewController *destVC = segue.destinationViewController;
    if ([destVC isKindOfClass: [PokemonDetailViewController class]]) {
        NSIndexPath *indexPath = self.tableView.indexPathForSelectedRow;
        JTMPokemonObject *pokemon = self.pokemonArray[indexPath.row];
        [destVC setPokemon:pokemon];
    }
    
}


@end
