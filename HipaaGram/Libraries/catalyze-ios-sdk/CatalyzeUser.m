/*
 * Copyright (C) 2013 catalyze.io, Inc.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 *    you may not use this file except in compliance with the License.
 *    You may obtain a copy of the License at
 *
 *        http://www.apache.org/licenses/LICENSE-2.0
 *
 *    Unless required by applicable law or agreed to in writing, software
 *    distributed under the License is distributed on an "AS IS" BASIS,
 *    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 *    See the License for the specific language governing permissions and
 *    limitations under the License.
 */

#import "CatalyzeUser.h"
#import "CatalyzeHTTPManager.h"
#import "Catalyze.h"

#define kEncodeKeyUsersId @"users_id"
#define kEncodeKeyActive @"active"
#define kEncodeKeyCreatedAt @"created_at"
#define kEncodeKeyUpdatedAt @"updated_at"
#define kEncodeKeyUsername @"username"
#define kEncodeKeyEmail @"email"
#define kEncodeKeyName @"name"
#define kEncodeKeyDob @"dob"
#define kEncodeKeyAge @"age"
#define kEncodeKeyPhoneNumber @"phone_number"
#define kEncodeKeyAddresses @"addresses"
#define kEncodeKeyGender @"gender"
#define kEncodeKeyMaritalStatus @"marital_status"
#define kEncodeKeyReligion @"religion"
#define kEncodeKeyRace @"race"
#define kEncodeKeyEthnicity @"ethnicity_"
#define kEncodeKeyGuardians @"guardians"
#define kEncodeKeyConfCode @"conf_code"
#define kEncodeKeyLanguages @"languages"
#define kEncodeKeySocialIds @"social_ids"
#define kEncodeKeyMrns @"mrns"
#define kEncodeKeyHealthPlans @"health_plans"
#define kEncodeKeyAvatar @"avatar"
#define kEncodeKeySsn @"ssn"
#define kEncodeKeyProfilePhoto @"profile_photo"
#define kEncodeKeyType @"type"
#define kEncodeKeyExtras @"extras"

@interface CatalyzeUser() {
    BOOL dirty;
    NSMutableArray *dirtyFields;
}

@end

@implementation CatalyzeUser
@synthesize usersId = _usersId;
@synthesize active = _active;
@synthesize createdAt = _createdAt;
@synthesize updatedAt = _updatedAt;
@synthesize username = _username;
@synthesize email = _email;
@synthesize name = _name;
@synthesize dob = _dob;
@synthesize age = _age;
@synthesize phoneNumber = _phoneNumber;
@synthesize addresses = _addresses;
@synthesize gender = _gender;
@synthesize maritalStatus = _maritalStatus;
@synthesize religion = _religion;
@synthesize race = _race;
@synthesize ethnicity = _ethnicity;
@synthesize guardians = _guardians;
@synthesize confCode = _confCode;
@synthesize languages = _languages;
@synthesize socialIds = _socialIds;
@synthesize mrns = _mrns;
@synthesize healthPlans  = _healthPlans;
@synthesize avatar = _avatar;
@synthesize ssn = _ssn;
@synthesize profilePhoto = _profilePhoto;
@synthesize type = _type;
@synthesize extras = _extras;

static CatalyzeUser *currentUser;

- (id)init {
    self = [super init];
    if (self) {
        _email = [[Email alloc] init];
        _name = [[Name alloc] init];
        _phoneNumber = [[PhoneNumber alloc] init];
        _addresses = [NSMutableArray array];
        _guardians = [NSMutableArray array];
        _languages = [NSMutableArray array];
        _socialIds = [NSMutableArray array];
        _mrns = [NSMutableArray array];
        _healthPlans = [NSMutableArray array];
        _extras = [NSMutableDictionary dictionary];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:_usersId forKey:kEncodeKeyUsersId];
    [aCoder encodeObject:_active forKey:kEncodeKeyActive];
    [aCoder encodeObject:_createdAt forKey:kEncodeKeyCreatedAt];
    [aCoder encodeObject:_updatedAt forKey:kEncodeKeyUpdatedAt];
    [aCoder encodeObject:_username forKey:kEncodeKeyUsername];
    [aCoder encodeObject:_email forKey:kEncodeKeyEmail];
    [aCoder encodeObject:_name forKey:kEncodeKeyName];
    [aCoder encodeObject:_dob forKey:kEncodeKeyDob];
    [aCoder encodeObject:_age forKey:kEncodeKeyAge];
    [aCoder encodeObject:_phoneNumber forKey:kEncodeKeyPhoneNumber];
    [aCoder encodeObject:_addresses forKey:kEncodeKeyAddresses];
    [aCoder encodeObject:_gender forKey:kEncodeKeyGender];
    [aCoder encodeObject:_maritalStatus forKey:kEncodeKeyMaritalStatus];
    [aCoder encodeObject:_religion forKey:kEncodeKeyReligion];
    [aCoder encodeObject:_race forKey:kEncodeKeyRace];
    [aCoder encodeObject:_ethnicity forKey:kEncodeKeyEthnicity];
    [aCoder encodeObject:_guardians forKey:kEncodeKeyGuardians];
    [aCoder encodeObject:_confCode forKey:kEncodeKeyConfCode];
    [aCoder encodeObject:_languages forKey:kEncodeKeyLanguages];
    [aCoder encodeObject:_socialIds forKey:kEncodeKeySocialIds];
    [aCoder encodeObject:_mrns forKey:kEncodeKeyMrns];
    [aCoder encodeObject:_healthPlans forKey:kEncodeKeyHealthPlans];
    [aCoder encodeObject:_avatar forKey:kEncodeKeyAvatar];
    [aCoder encodeObject:_ssn forKey:kEncodeKeySsn];
    [aCoder encodeObject:_profilePhoto forKey:kEncodeKeyProfilePhoto];
    [aCoder encodeObject:_type forKey:kEncodeKeyType];
    [aCoder encodeObject:_extras forKey:kEncodeKeyExtras];
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [self init];
    if (self) {;
        [self setUsersId:[aDecoder decodeObjectForKey:kEncodeKeyUsersId]];
        [self setActive:[aDecoder decodeObjectForKey:kEncodeKeyActive]];
        [self setCreatedAt:[aDecoder decodeObjectForKey:kEncodeKeyCreatedAt]];
        [self setUpdatedAt:[aDecoder decodeObjectForKey:kEncodeKeyUpdatedAt]];
        [self setUsername:[aDecoder decodeObjectForKey:kEncodeKeyUsername]];
        [self setEmail:[aDecoder decodeObjectForKey:kEncodeKeyEmail]];
        [self setName:[aDecoder decodeObjectForKey:kEncodeKeyName]];
        [self setDob:[aDecoder decodeObjectForKey:kEncodeKeyDob]];
        [self setAge:[aDecoder decodeObjectForKey:kEncodeKeyAge]];
        [self setPhoneNumber:[aDecoder decodeObjectForKey:kEncodeKeyPhoneNumber]];
        [self setAddresses:[aDecoder decodeObjectForKey:kEncodeKeyAddresses]];
        [self setGender:[aDecoder decodeObjectForKey:kEncodeKeyGender]];
        [self setMaritalStatus:[aDecoder decodeObjectForKey:kEncodeKeyMaritalStatus]];
        [self setReligion:[aDecoder decodeObjectForKey:kEncodeKeyReligion]];
        [self setRace:[aDecoder decodeObjectForKey:kEncodeKeyRace]];
        [self setEthnicity:[aDecoder decodeObjectForKey:kEncodeKeyEthnicity]];
        [self setGuardians:[aDecoder decodeObjectForKey:kEncodeKeyGuardians]];
        [self setConfCode:[aDecoder decodeObjectForKey:kEncodeKeyConfCode]];
        [self setLanguages:[aDecoder decodeObjectForKey:kEncodeKeyLanguages]];
        [self setSocialIds:[aDecoder decodeObjectForKey:kEncodeKeySocialIds]];
        [self setMrns:[aDecoder decodeObjectForKey:kEncodeKeyMrns]];
        [self setHealthPlans:[aDecoder decodeObjectForKey:kEncodeKeyHealthPlans]];
        [self setAvatar:[aDecoder decodeObjectForKey:kEncodeKeyAvatar]];
        [self setSsn:[aDecoder decodeObjectForKey:kEncodeKeySsn]];
        [self setProfilePhoto:[aDecoder decodeObjectForKey:kEncodeKeyProfilePhoto]];
        [self setType:[aDecoder decodeObjectForKey:kEncodeKeyType]];
        [self setExtras:[aDecoder decodeObjectForKey:kEncodeKeyExtras]];
    }
    return self;
}

- (void)logout {
    [self logoutWithBlock:nil];
}

- (void)logoutWithBlock:(CatalyzeHTTPResponseBlock)block {
    [CatalyzeHTTPManager doGet:@"/auth/signout" block:^(int status, NSString *response, NSError *error) {
        if (!error) {
            currentUser = nil;
            
            NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
            NSString *documentsDirectory = [paths objectAtIndex:0];
            NSString *archivePath = [documentsDirectory stringByAppendingPathComponent:@"currentuser.archive"];
            
            NSFileManager *fileManager = [NSFileManager defaultManager];
            [fileManager removeItemAtPath:archivePath error:nil];
        }
        if (block) {
            block(status, response, error);
        }
    }];
}

- (BOOL)isAuthenticated {
    return ([[NSUserDefaults standardUserDefaults] valueForKey:@"Authorization"] && ![[[NSUserDefaults standardUserDefaults] valueForKey:@"Authorization"] isEqualToString:@""]);
}

+ (CatalyzeUser *)user {
    return [[CatalyzeUser alloc] init];
}

#pragma mark - Current User

+ (CatalyzeUser *)currentUser {
    return currentUser;
}

#pragma mark - Login

+ (void)logInWithUsernameInBackground:(NSString *)username password:(NSString *)password block:(CatalyzeHTTPResponseBlock)block {
    NSDictionary *body = @{@"username" : username, @"password": password};
    [CatalyzeHTTPManager doPost:@"/auth/signin" withParams:body block:^(int status, NSString *response, NSError *error) {
        if (!error) {
            currentUser = [CatalyzeUser user];
            NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithDictionary:[NSJSONSerialization JSONObjectWithData:[response dataUsingEncoding:NSUTF8StringEncoding] options:0 error:nil]];
            NSString *sessionToken = [dict objectForKey:@"sessionToken"];
            [dict removeObjectForKey:@"sessionToken"];
            
            dict = [CatalyzeUser modifyDict:dict];
            
            [currentUser setValuesForKeysWithDictionary:dict];
            
            if (sessionToken) {
                [[NSUserDefaults standardUserDefaults] setValue:sessionToken forKey:@"Authorization"];
            }
            [[NSUserDefaults standardUserDefaults] synchronize];
        }
        block(status, response, error);
    }];
}

#pragma mark - Signup

+ (void)signUpWithUsernameInBackground:(NSString *)username email:(Email *)email name:(Name *)name  password:(NSString *)password block:(CatalyzeHTTPResponseBlock)block {
    [CatalyzeUser signUpWithUsernameInBackground:username email:email name:name password:password inviteCode:@"" block:block];
}

+ (void)signUpWithUsernameInBackground:(NSString *)username email:(Email *)email name:(Name *)name  password:(NSString *)password inviteCode:(NSString *)inviteCode block:(CatalyzeHTTPResponseBlock)block {
    NSDictionary *body = @{@"username" : username, @"email" : [email JSON:[Email class]], @"name" : [name JSON:[Name class]], @"password": password, @"inviteCode" : inviteCode};
    [CatalyzeHTTPManager doPost:@"/users" withParams:body block:^(int status, NSString *response, NSError *error) {
        if (!error) {
            currentUser = [CatalyzeUser user];
            NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithDictionary:[NSJSONSerialization JSONObjectWithData:[response dataUsingEncoding:NSUTF8StringEncoding] options:0 error:nil]];
            NSString *sessionToken = [dict objectForKey:@"sessionToken"];
            [dict removeObjectForKey:@"sessionToken"];
            
            dict = [CatalyzeUser modifyDict:dict];
            
            [currentUser setValuesForKeysWithDictionary:dict];
            
            if (sessionToken) {
                [[NSUserDefaults standardUserDefaults] setValue:sessionToken forKey:@"Authorization"];
            }
            [[NSUserDefaults standardUserDefaults] synchronize];
        }
        block(status, response, error);
    }];
}

#pragma mark - Extras

- (id)extraForKey:(NSString *)key {
    if (!_extras) {
        _extras = [NSMutableDictionary dictionary];
    }
    return [_extras objectForKey:key];
}

- (void)setExtra:(id)extra forKey:(NSString *)key {
    if (!_extras) {
        _extras = [NSMutableDictionary dictionary];
    }
    [_extras setObject:extra forKey:key];
}

- (void)removeExtraForKey:(NSString *)key {
    if (!_extras) {
        _extras = [NSMutableDictionary dictionary];
    }
    [_extras removeObjectForKey:key];
}

#pragma mark - CatalyzeObject

- (void)resetDirty {
    dirty = NO;
    dirtyFields = [[NSMutableArray alloc] init];
}

- (void)saveInBackground {
    [self saveInBackgroundWithBlock:nil];
}

- (void)saveInBackgroundWithBlock:(CatalyzeBooleanResultBlock)block {
    [CatalyzeHTTPManager doPut:[NSString stringWithFormat:@"/users/%@", _usersId] withParams:[self JSON:[CatalyzeUser class]] block:^(int status, NSString *response, NSError *error) {
        if (!error) {
            dirty = NO;
            [dirtyFields removeAllObjects];
            
            NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithDictionary:[NSJSONSerialization JSONObjectWithData:[response dataUsingEncoding:NSUTF8StringEncoding] options:0 error:nil]];
            
            dict = [CatalyzeUser modifyDict:dict];
            
            [self setValuesForKeysWithDictionary:dict];
        }
        if (block) {
            block(error == nil, status, error);
        }
    }];
}

- (void)saveInBackgroundWithTarget:(id)target selector:(SEL)selector {
    [self saveInBackgroundWithBlock:^(BOOL succeeded, int status, NSError *error) {
        [target performSelector:selector onThread:[NSThread mainThread] withObject:error waitUntilDone:NO];
    }];
}

- (void)retrieveInBackground {
    [self retrieveInBackgroundWithBlock:nil];
}

- (void)retrieveInBackgroundWithBlock:(CatalyzeBooleanResultBlock)block {
    [CatalyzeHTTPManager doGet:[NSString stringWithFormat:@"/users/%@", _usersId] block:^(int status, NSString *response, NSError *error) {
        if (!error) {
            dirty = NO;
            [dirtyFields removeAllObjects];
            
            NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithDictionary:[NSJSONSerialization JSONObjectWithData:[response dataUsingEncoding:NSUTF8StringEncoding] options:0 error:nil]];
            
            dict = [CatalyzeUser modifyDict:dict];
            
            [self setValuesForKeysWithDictionary:dict];
        }
        if (block) {
            block(error == nil, status, error);
        }
    }];
}

- (void)retrieveInBackgroundWithTarget:(id)target selector:(SEL)selector {
    [self retrieveInBackgroundWithBlock:^(BOOL succeeded, int status, NSError *error) {
        [target performSelector:selector onThread:[NSThread mainThread] withObject:error waitUntilDone:NO];
    }];
}

- (void)deleteInBackground {
    [self deleteInBackgroundWithBlock:nil];
}

- (void)deleteInBackgroundWithBlock:(CatalyzeBooleanResultBlock)block {
    [CatalyzeHTTPManager doDelete:[NSString stringWithFormat:@"/users/%@", _usersId] block:^(int status, NSString *response, NSError *error) {
        if (!error) {
            currentUser = nil;
            
            NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
            NSString *documentsDirectory = [paths objectAtIndex:0];
            NSString *archivePath = [documentsDirectory stringByAppendingPathComponent:@"currentuser.archive"];
            
            NSFileManager *fileManager = [NSFileManager defaultManager];
            [fileManager removeItemAtPath:archivePath error:nil];
        }
        if (block) {
            block(error == nil, status, error);
        }
    }];
}

- (void)deleteInBackgroundWithTarget:(id)target selector:(SEL)selector {
    [self deleteInBackgroundWithBlock:^(BOOL succeeded, int status, NSError *error) {
        [target performSelector:selector onThread:[NSThread mainThread] withObject:error waitUntilDone:NO];
    }];
}

#pragma mark - JSONObject

- (id)JSON:(Class)aClass {
    NSMutableDictionary *dict = [super JSON:aClass];
    
    [dict removeObjectForKey:@"email"];
    if (_email) {
        [dict setObject:[_email JSON:[Email class]] forKey:@"email"];
    }
    
    [dict removeObjectForKey:@"name"];
    if (_name) {
        [dict setObject:[_name JSON:[Name class]] forKey:@"name"];
    }
    
    [dict removeObjectForKey:@"phoneNumber"];
    if (_phoneNumber) {
        [dict setObject:[_phoneNumber JSON:[PhoneNumber class]] forKey:@"phoneNumber"];
    }
    
    [dict removeObjectForKey:@"addresses"];
    if (_addresses && _addresses.count > 0) {
        NSMutableArray *addresses = [NSMutableArray array];
        for (Address *a in _addresses) {
            [addresses addObject:[a JSON:[Address class]]];
        }
        [dict setObject:addresses forKey:@"addresses"];
    }
    
    [dict removeObjectForKey:@"guardians"];
    if (_guardians && _guardians.count > 0) {
        NSMutableArray *guardians = [NSMutableArray array];
        for (Guardian *g in _guardians) {
            [guardians addObject:[g JSON:[Guardian class]]];
        }
        [dict setObject:guardians forKey:@"guardians"];
    }
    
    [dict removeObjectForKey:@"languages"];
    if (_languages && _languages.count > 0) {
        NSMutableArray *languages = [NSMutableArray array];
        for (Language *l in _languages) {
            [languages addObject:[l JSON:[Language class]]];
        }
        [dict setObject:languages forKey:@"languages"];
    }
    
    [dict removeObjectForKey:@"socialIds"];
    if (_socialIds && _socialIds.count > 0) {
        NSMutableArray *socialIds = [NSMutableArray array];
        for (SocialId *si in _socialIds) {
            [socialIds addObject:[si JSON:[SocialId class]]];
        }
        [dict setObject:socialIds forKey:@"socialIds"];
    }
    
    [dict removeObjectForKey:@"mrns"];
    if (_mrns && _mrns.count > 0) {
        NSMutableArray *mrns = [NSMutableArray array];
        for (Mrn *m in _languages) {
            [mrns addObject:[m JSON:[Mrn class]]];
        }
        [dict setObject:mrns forKey:@"mrns"];
    }
    
    [dict removeObjectForKey:@"healthPlans"];
    if (_healthPlans && _healthPlans.count > 0) {
        NSMutableArray *healthPlans = [NSMutableArray array];
        for (HealthPlan *hp in _languages) {
            [healthPlans addObject:[hp JSON:[HealthPlan class]]];
        }
        [dict setObject:healthPlans forKey:@"healthPlans"];
    }
    
    [dict removeObjectForKey:@"extras"];
    if (_extras) {
        [dict setObject:_extras forKey:@"extras"];
    }
    return dict;
}

+ (NSMutableDictionary *)modifyDict:(NSMutableDictionary *)dict {
    Email *email = [[Email alloc] init];
    Name *name = [[Name alloc] init];
    PhoneNumber *phoneNumber = [[PhoneNumber alloc] init];
    NSMutableArray *addresses = [NSMutableArray array];
    NSMutableArray *guardians = [NSMutableArray array];
    NSMutableArray *languages = [NSMutableArray array];
    NSMutableArray *socialIds = [NSMutableArray array];
    NSMutableArray *mrns = [NSMutableArray array];
    NSMutableArray *healthPlans = [NSMutableArray array];
    
    if ([dict objectForKey:@"email"] && [dict objectForKey:@"email"] != [NSNull null]) {
        [email setValuesForKeysWithDictionary:[dict objectForKey:@"email"]];
    }
    [dict setObject:email forKey:@"email"];
    
    if ([dict objectForKey:@"name"] && [dict objectForKey:@"name"] != [NSNull null]) {
        [name setValuesForKeysWithDictionary:[dict objectForKey:@"name"]];
    }
    [dict setObject:name forKey:@"name"];
    
    if ([dict objectForKey:@"phoneNumber"] && [dict objectForKey:@"phoneNumber"] != [NSNull null]) {
        [phoneNumber setValuesForKeysWithDictionary:[dict objectForKey:@"phoneNumber"]];
    }
    [dict setObject:phoneNumber forKey:@"phoneNumber"];
    
    if ([dict objectForKey:@"addresses"] && [dict objectForKey:@"addresses"] != [NSNull null]) {
        for (NSDictionary *ad in [dict objectForKey:@"addresses"]) {
            Address *a = [[Address alloc] init];
            [a setValuesForKeysWithDictionary:ad];
            Geocode *geo = [[Geocode alloc] init];
            [geo setValuesForKeysWithDictionary:[ad objectForKey:@"geocode"]];
            [a setGeocode:geo];
            [addresses addObject:a];
        }
    }
    [dict setObject:addresses forKey:@"addresses"];
    
    if ([dict objectForKey:@"guardians"] && [dict objectForKey:@"guardians"] != [NSNull null]) {
        for (NSDictionary *gd in [dict objectForKey:@"guardians"]) {
            Guardian *g = [[Guardian alloc] init];
            [g setValuesForKeysWithDictionary:gd];
            [guardians addObject:g];
        }
    }
    [dict setObject:guardians forKey:@"guardians"];
    
    if ([dict objectForKey:@"languages"] && [dict objectForKey:@"languages"] != [NSNull null]) {
        for (NSDictionary *ld in [dict objectForKey:@"languages"]) {
            Language *l = [[Language alloc] init];
            [l setValuesForKeysWithDictionary:ld];
            [languages addObject:l];
        }
    }
    [dict setObject:languages forKey:@"languages"];
    
    if ([dict objectForKey:@"socialIds"] && [dict objectForKey:@"socialIds"] != [NSNull null]) {
        for (NSDictionary *sd in [dict objectForKey:@"socialIds"]) {
            SocialId *s = [[SocialId alloc] init];
            [s setValuesForKeysWithDictionary:sd];
            [socialIds addObject:s];
        }
    }
    [dict setObject:socialIds forKey:@"socialIds"];
    
    if ([dict objectForKey:@"mrns"] && [dict objectForKey:@"mrns"] != [NSNull null]) {
        for (NSDictionary *mrnd in [dict objectForKey:@"mrns"]) {
            Mrn *mrn = [[Mrn alloc] init];
            [mrn setValuesForKeysWithDictionary:mrnd];
            [mrns addObject:mrn];
        }
    }
    [dict setObject:mrns forKey:@"mrns"];
    
    if ([dict objectForKey:@"healthPlans"] && [dict objectForKey:@"healthPlans"] != [NSNull null]) {
        for (NSDictionary *hpd in [dict objectForKey:@"healthPlans"]) {
            HealthPlan *hp = [[HealthPlan alloc] init];
            [hp setValuesForKeysWithDictionary:hpd];
            [healthPlans addObject:hp];
        }
    }
    [dict setObject:healthPlans forKey:@"healthPlans"];
    
    if ([dict objectForKey:@"extras"] && [dict objectForKey:@"extras"] != [NSNull null]) {
        [dict setObject:[NSMutableDictionary dictionaryWithDictionary:[dict objectForKey:@"extras"]] forKey:@"extras"];
    }
    return dict;
}

@end
