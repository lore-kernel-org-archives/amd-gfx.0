From: Kai-Heng Feng <kai.heng.feng@canonical.com>
Subject: [Regression] "drm/amdgpu: enable gfxoff again on raven series (v2)"
Date: Wed, 7 Aug 2019 20:50:17 +0800
Message-ID: <3EB0E920-31D7-4C91-A360-DBFB4417AC2F@canonical.com>
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Content-Type: text/plain;
        charset=utf-8;
        delsp=yes;
        format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Huang Rui <ray.huang@amd.com>
Cc: "Deucher, Alexander" <alexander.deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, Chunming Zhou <David1.Zhou@amd.com>, amd-gfx list <amd-gfx@lists.freedesktop.org>, dri-devel@lists.freedesktop.org, LKML <linux-kernel@vger.kernel.org>, Anthony Wong <anthony.wong@canonical.com>
List-Id: amd-gfx.lists.freedesktop.org

Hi,

After commit 005440066f92 ("drm/amdgpu: enable gfxoff again on raven series  
(v2)”), browsers on Raven Ridge systems cause serious corruption like this:
https://launchpadlibrarian.net/436319772/Screenshot%20from%202019-08-07%2004-20-34.png

Firmwares for Raven Ridge is up-to-date.

Kai-Heng
