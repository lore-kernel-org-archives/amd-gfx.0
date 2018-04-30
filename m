From: Joseph Salisbury <joseph.salisbury@canonical.com>
Subject: [REGRESSION] drm/amd/dc: Add dc display driver (v2)
Date: Mon, 30 Apr 2018 11:14:50 -0400
Message-ID: <fbb549e9-88a9-cc85-f8f3-e4bd0157b58c@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: harry.wentland@amd.com
Cc: alexander.deucher@amd.comalexander.deucher@amd.com, christian.koenig@amd.com, David1.Zhou@amd.com, airlied@linux.ie, amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "1761751@bugs.launchpad.net" <1761751@bugs.launchpad.net>
List-Id: amd-gfx.lists.freedesktop.org

Hi Harry,

A kernel bug report was opened against Ubuntu [0].  After a kernel
bisect, it was found the following commit introduced the bug:


commit 4562236b3bc0a28aeb6ee93b2d8a849a4c4e1c7c
Author: Harry Wentland <harry.wentland@amd.com>
Date:   Tue Sep 12 15:58:20 2017 -0400

    drm/amd/dc: Add dc display driver (v2)


The regression was introduced as of v4.15-rc1 and still exists in
current mainline.  The commit does not need to be reverted to resolve
the bug.  Disabling the CONFIG_DRM_AMD_DC_PRE_VEGA option makes the bug
go away.
   
I was hoping to get your feedback, since you are the patch author.  Do
you think gathering any additional data will help diagnose this issue?
   

Thanks,

Joe


[0] http://pad.lv/1761751
