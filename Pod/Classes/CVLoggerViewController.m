//
//  CVLoggerViewController.m
//  Pods
//
//  Created by Cristian Villaseca on 12/3/16.
//
//

#import "CVLoggerViewController.h"

#import "CVLoggerCell.h"
#import "CVLogManager.h"

#define kMaxLength 15000

static NSString *CellIdentifier = @"CustomTableCell";

@interface CVLoggerViewController () <UITableViewDataSource, UITableViewDelegate, UISearchDisplayDelegate, UISearchBarDelegate>

@property (nonatomic, strong) UISearchDisplayController *searchController;
@property (nonatomic, strong) UISearchBar *searchBar;

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSArray *logs;
@property (nonatomic, strong) NSArray *searchLogs;

@property (nonatomic) NSInteger selectedCell;

@end

@implementation CVLoggerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.selectedCell = -1;
    
    NSString *bundlePath = [[NSBundle bundleForClass:[self class]] pathForResource:@"CVLogger" ofType:@"bundle"];
    NSBundle *bundle = [NSBundle bundleWithPath:bundlePath];
    
    UIImage *close = [UIImage imageNamed:@"close" inBundle:bundle compatibleWithTraitCollection:nil];
    UIImage *share = [UIImage imageNamed:@"share" inBundle:bundle compatibleWithTraitCollection:nil];
    UIImage *delete = [UIImage imageNamed:@"delete" inBundle:bundle compatibleWithTraitCollection:nil];
    
    UIBarButtonItem *shareButton = [[UIBarButtonItem alloc] initWithImage:share style:UIBarButtonItemStylePlain target:self action:@selector(share:)];
    
    UIBarButtonItem *closeButton = [[UIBarButtonItem alloc] initWithImage:close style:UIBarButtonItemStylePlain target:self action:@selector(close:)];
    
    UIBarButtonItem *deleteButton = [[UIBarButtonItem alloc] initWithImage:delete style:UIBarButtonItemStylePlain target:self action:@selector(delete:)];
    
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationItem.rightBarButtonItems = @[closeButton,shareButton];
    self.navigationItem.leftBarButtonItem = deleteButton;    
    
    [self configureView];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    dispatch_async( dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        self.logs = [[[[CVLogManager sharedManager] getLogs] reverseObjectEnumerator] allObjects];
        dispatch_async( dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
    });
}


#pragma mark - UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == self.searchController.searchResultsTableView) {
        return self.searchLogs.count;
    } else {
        return self.logs.count;
    }
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *text = nil;
    if (tableView == self.searchController.searchResultsTableView) {
        text = self.searchLogs[indexPath.row];
    } else {
        text = self.logs[indexPath.row];
    }
    
    if (indexPath.row == self.selectedCell) {
        return [self heightForText:text];
    }else {
        return MIN(self.collapseHeight, [self heightForText:text]);
    }
    
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    CVLoggerCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (!cell) {
        cell = [[CVLoggerCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    cell.backgroundColor = (indexPath.row % 2 == 1)?[[[UINavigationBar appearance] barTintColor] colorWithAlphaComponent:0.5]:[UIColor colorWithWhite:1 alpha:1];
    
    NSString  *recipe = nil;
    if (tableView == self.searchController.searchResultsTableView) {
        recipe = [self.searchLogs objectAtIndex:indexPath.row];
        
        NSRange range = [[recipe lowercaseString] rangeOfString:[self.searchBar.text lowercaseString]];
        
        NSMutableAttributedString *attributedRecipe = [[NSMutableAttributedString alloc] initWithString:recipe];
        NSDictionary *attributes =@{NSBackgroundColorAttributeName:[UIColor colorWithRed:245.0/255.0 green:228.0/255.0 blue:55.0/255.0 alpha:1]};
        [attributedRecipe addAttributes:attributes range:range];

        
        cell.logLabel.attributedText = attributedRecipe;
        
        return cell;
        
    } else {
        recipe = [self.logs objectAtIndex:indexPath.row];
    }
    
    
    
    if( [recipe length] > kMaxLength ){
        recipe = [recipe substringToIndex:kMaxLength];
    }
    
    
    cell.logLabel.text = recipe;
    
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    self.selectedCell = indexPath.row;
    [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
}


-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    
    if ([cell respondsToSelector:@selector(setPreservesSuperviewLayoutMargins:)]) {
        [cell setPreservesSuperviewLayoutMargins:NO];
    }
    
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}

#pragma mark - SearchDisplayController

- (void)filterContentForSearchText:(NSString*)searchText scope:(NSString*)scope
{
    NSPredicate *pred =[NSPredicate predicateWithFormat: @"description CONTAINS[c] %@", searchText];
    __block NSArray *auxLog;
    dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        auxLog = [self.logs filteredArrayUsingPredicate:pred];
        dispatch_async(dispatch_get_main_queue(), ^{
            self.searchLogs = auxLog;
            [self.searchController.searchResultsTableView reloadData];
            
        });
    });
}

-(BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString
{
    
    [self filterContentForSearchText:searchString
                               scope:[[controller.searchBar scopeButtonTitles]
                                      objectAtIndex:[controller.searchBar
                                                     selectedScopeButtonIndex]]];
    
    return NO;
}


#pragma mark - Private methods

-(void) configureView {
    self.tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    [self.tableView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.view addSubview:self.tableView];
    
    NSDictionary *views = @{@"tableView":self.tableView};
    NSArray *constraints = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|[tableView]|"
                                                                   options: 0
                                                                   metrics:nil
                                                                     views:views];
    [self.view addConstraints:constraints];
    constraints = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|[tableView]|"
                                                          options: 0
                                                          metrics:nil
                                                            views:views];
    [self.view addConstraints:constraints];
    
    self.searchBar = [[UISearchBar alloc]initWithFrame:CGRectMake(0.0f, 0.0f, 0.0f, 38.0f)];
    self.searchBar.barTintColor = [UINavigationBar appearance].barTintColor;
    self.searchBar.delegate = self;
    self.tableView.tableHeaderView = self.searchBar;
    
    
    self.searchController = [[UISearchDisplayController alloc]initWithSearchBar:self.searchBar contentsController:self];
    self.searchController.searchResultsDataSource = self;
    self.searchController.searchResultsDelegate = self;
    self.searchController.delegate = self;
    
    self.searchController.searchBar.tintColor = [[UINavigationBar appearance] tintColor];
    self.searchController.searchResultsTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    self.edgesForExtendedLayout = UIRectEdgeNone;
}


-(CGFloat) heightForText:(NSString *) text {
    
    NSString *str = nil;
    
    if( [text length] > kMaxLength ){
        str = [text substringToIndex:kMaxLength ];
    }else {
        str = text;
    }
    
    CGFloat margin = 4.f;
    
    UIFont *aLabelFont = [UIFont systemFontOfSize:14.0];
    
    CGFloat aLabelSizeWidth = self.view.bounds.size.width;
    
    CGFloat textHeight = [str boundingRectWithSize:CGSizeMake(aLabelSizeWidth, MAXFLOAT)
                                           options:NSStringDrawingUsesLineFragmentOrigin
                                        attributes:@{
                                                     NSFontAttributeName : aLabelFont
                                                     }
                                           context:nil].size.height;
    
    textHeight += (2*margin);
    
    return  textHeight;
    
}



#pragma mark - Action senders

-(void) close:(id) sender {
    [self dismissViewControllerAnimated:YES completion:^{
        if([self.delegate respondsToSelector:@selector(CVLoggerDidClosed)]) {
            [self.delegate CVLoggerDidClosed];
        }
    }];
}

-(void) share:(id) sender {
    
    NSMutableString *logs = [[NSMutableString alloc] init];
    for (NSString *log in self.logs) {
        [logs appendString:log];
    }
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0]; // Get documents directory
    
    NSError *error;
    NSString *path = [documentsDirectory stringByAppendingPathComponent:@"logs.txt"];
    BOOL succeed = [logs writeToFile: path
                          atomically:YES encoding:NSUTF8StringEncoding error:&error];
    if (succeed){
        NSURL *fileURL = [[NSURL alloc] initFileURLWithPath:path];
        UIActivityViewController *activityVC = [[UIActivityViewController alloc] initWithActivityItems:@[fileURL] applicationActivities:nil];
        [self presentViewController:activityVC animated:YES completion:nil];
    }
    
    
}

-(void) delete:(id) sender {
    [[CVLogManager sharedManager] removeLogs];
    self.logs = nil;
    [self.tableView reloadData];
}



@end
