#!/sbin/sh

# Copyright (C) 2015 The CyanogenMod Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

DEVICE="/dev/block/platform/msm_sdcc.1/by-name/system"
SOURCE="/system/vendor/firmware/keymaster"
TARGET="/firmware/image"

if [ ! -d $TARGET ]; then
  mount -o rw "/firmware"
  mkdir -p $TARGET
  MOUNT=1
fi

if mount | grep -qv "/system"; then
  mount -o rw $DEVICE "/system"
fi

for FILE in $(ls $SOURCE); do
  cp -f $SOURCE/$FILE $TARGET/keymaste.${FILE##*.}
done

umount "/system"

if [ -z "${MOUNT}" ]; then
  umount "/firmware"
fi
