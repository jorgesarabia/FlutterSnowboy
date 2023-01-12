/*
 * Copyright (C) 2016-2020 KITT.AI
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

package ai.kitt.snowboy;

public enum MsgEnum {
  MSG_VAD_END,
  MSG_VAD_NOSPEECH,
  MSG_VAD_SPEECH,
  MSG_VOLUME_NOTIFY,
  MSG_WAV_DATAINFO,
  MSG_RECORD_START,
  MSG_RECORD_STOP,
  MSG_ACTIVE,
  MSG_ERROR,
  MSG_INFO;

  public static MsgEnum getMsgEnum(int i) { return MsgEnum.values()[i]; }
}
