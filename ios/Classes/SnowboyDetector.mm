/*
 * Copyright (C) 2021-2023 Miðeind ehf.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 * https://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 *
 */

// This is an Objective-C++ wrapper around the Snowboy C++ detector.

#import "SnowboyDetector.h"
#import <Flutter/Flutter.h>
#import <Snowboy/Snowboy.h>

@interface SnowboyDetector () {
  snowboy::SnowboyDetect *_snowboyDetect;
}
@end

@implementation SnowboyDetector

// Singleton instance
+ (instancetype)sharedInstance {
  static SnowboyDetector *instance = nil;
  if (!instance) {
    instance = [self new];
  }
  return instance;
}

// Initialize the Snowboy detector with the given model
// file and other configuration parameters.
- (BOOL)prepare:(NSString *)modelPath
      sensitivity:(double)sensitivity
        audioGain:(double)audioGain
    applyFrontend:(BOOL)applyFrontend {

  _snowboyDetect = NULL;

  NSString *commonPath = [[NSBundle mainBundle] pathForResource:@"common"
                                                         ofType:@"res"];
  if (![[NSFileManager defaultManager] fileExistsAtPath:commonPath]) {
    NSLog(
        @"Unable to init Snowboy, required bundled file 'common.res' missing");
    return FALSE;
  }
  if (![[NSFileManager defaultManager] fileExistsAtPath:modelPath]) {
    NSLog(@"Unable to init Snowboy, no file at model path %@", modelPath);
    return FALSE;
  }

  // Create and configure Snowboy C++ detector object
  _snowboyDetect =
      new snowboy::SnowboyDetect(std::string([commonPath UTF8String]),
                                 std::string([modelPath UTF8String]));
  NSString *ssString = [NSString stringWithFormat:@"%f", sensitivity];
  _snowboyDetect->SetSensitivity(
      [ssString cStringUsingEncoding:NSUTF8StringEncoding]);
  _snowboyDetect->SetAudioGain(audioGain);
  _snowboyDetect->ApplyFrontend(applyFrontend);

  return TRUE;
}

// Run the Snowboy detector on the given audio data
- (void)detect:(NSData *)audioData channel:(FlutterMethodChannel *)channel {
  const int16_t *bytes = (int16_t *)[audioData bytes];
  const int len = (int)[audioData length] / 2; // 16-bit audio
  int result = _snowboyDetect->RunDetection((const int16_t *)bytes, len);
  dispatch_async(dispatch_get_main_queue(), ^{
    if (result == 1) {
      [channel invokeMethod:@"hotword" arguments:nil];
    }
  });
}

// Release the Snowboy detector
- (void)purge {
  if (_snowboyDetect != NULL) {
    delete _snowboyDetect;
    _snowboyDetect = NULL;
  }
}

// Returns true if the Snowboy detector has been initialized
- (BOOL)inited {
  return (_snowboyDetect != NULL);
}

@end
