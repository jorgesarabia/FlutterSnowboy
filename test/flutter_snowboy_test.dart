/*
 * flutter_snowboy - Flutter package wrapper for Snowboy hotword detection.
 *
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

import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_snowboy/flutter_snowboy.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  // Tests
  test('Instantiation', () {
    var s = Snowboy();
    expect(s, s);
  });
}
