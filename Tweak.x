#import <Foundation/Foundation.h>

%hook NSURLSession

- (NSURLSessionDataTask *)dataTaskWithRequest:(NSMutableURLRequest *)request {
    NSString *url = request.URL.absoluteString;
    if (![url hasPrefix:@"https://www.avanza.se/_mobile/system/check-version/iphone"]) {
        return %orig;
    }

    // Replace current iOS and app version query parameters.
    NSMutableString *modifiedURL = [url mutableCopy];
    NSRegularExpression *iOSRegex = [NSRegularExpression regularExpressionWithPattern:@"(currentOSVersion=)([^&]*)" options:0 error:nil];
    NSRegularExpression *appRegex = [NSRegularExpression regularExpressionWithPattern:@"(currentVersion=)([^&]*)" options:0 error:nil];
    // Spoof iOS 17.4.
    [iOSRegex replaceMatchesInString:modifiedURL options:0 range:NSMakeRange(0, modifiedURL.length) withTemplate:@"$117.4"];
    // Spoof v5.9.0.
    [appRegex replaceMatchesInString:modifiedURL options:0 range:NSMakeRange(0, modifiedURL.length) withTemplate:@"$15.9.0"];

    [request setURL:[NSURL URLWithString:modifiedURL]];
    return %orig;
}

%end
