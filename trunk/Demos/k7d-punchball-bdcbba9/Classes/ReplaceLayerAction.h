/*
 Copyright 2009 Kaspars Dancis

 Licensed under the Apache License, Version 2.0 (the "License");
 you may not use this file except in compliance with the License.
 You may obtain a copy of the License at

     http://www.apache.org/licenses/LICENSE-2.0

 Unless required by applicable law or agreed to in writing, software
 distributed under the License is distributed on an "AS IS" BASIS,
 WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 See the License for the specific language governing permissions and
 limitations under the License.
*/
 
#import "cocos2d.h"
#import "chipmunk.h"


@protocol ReplaceLayerActionDelegate

- (void)layerReplaced;

@end



@interface ReplaceLayerAction : IntervalAction {
	Scene *scene;
	Layer<ReplaceLayerActionDelegate> *layer;
	Layer *replaceLayer;
	bool reverse;
}

@property (nonatomic) bool reverse;

-(id) initWithScene:(Scene*)_scene layer:(Layer<ReplaceLayerActionDelegate>*)_layer replaceLayer:(Layer*)_replaceLayer;

@end