From: Gabriel C <nix.or.die@gmail.com>
Subject: [amdgpu] backlight mismatch
Date: Mon, 23 Sep 2019 22:34:46 +0200
Message-ID: <CAEJqkggb9ozmLtqkdm40NTXw=YAo-VZwrxPk+43YC-zkV__=Vw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: amd-gfx@lists.freedesktop.org
Cc: Alex Deucher <alexander.deucher@amd.com>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, LKML <linux-kernel@vger.kernel.org>
List-Id: amd-gfx.lists.freedesktop.org

Hello,

on my new Acer Nitro 5 (AN515-43-R8BF) backlight and actual_backlight value
in sysfs mismatch. When backlight is 0 actual_backlight is still 5140.

root@nitro5:/sys/class/backlight/amdgpu_bl1# cat brightness
255
root@nitro5:/sys/class/backlight/amdgpu_bl1# cat actual_brightness
65535
root@nitro5:/sys/class/backlight/amdgpu_bl1# echo 0 >brightness
root@nitro5:/sys/class/backlight/amdgpu_bl1# cat actual_brightness
5140

The laptop has a hybrid setup Picasso+Polaris11.

01:00.0 Display controller [0380]: Advanced Micro Devices, Inc.
[AMD/ATI] Baffin [Radeon RX 460/560D / Pro
450/455/460/555/555X/560/560X] [1002:67ef] (rev c0)
05:00.0 VGA compatible controller [0300]: Advanced Micro Devices, Inc.
[AMD/ATI] Picasso [1002:15d8] (rev c1)

[    4.594694] [drm] initializing kernel modesetting (POLARIS11
0x1002:0x67EF 0x1025:0x1367 0xC0).
[    4.866696] [drm] initializing kernel modesetting (RAVEN
0x1002:0x15D8 0x1025:0x1366 0xC1).

Please let me know what other informations you may need.

Best Regards,

Gabriel C.
