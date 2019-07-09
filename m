From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 5/7] drm/amd/display: Use proper enum conversion functions
Date: Tue, 9 Jul 2019 20:51:33 +0200
Message-ID: <CAK8P3a1vEtrS7SbhCPVxoYBcroT+Hr3Q4LFs6AJJ8G8GVw5SVA@mail.gmail.com>
References: <20190704055217.45860-1-natechancellor@gmail.com> <20190704055217.45860-6-natechancellor@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190704055217.45860-6-natechancellor@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Nathan Chancellor <natechancellor@gmail.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, "David (ChunMing) Zhou" <David1.Zhou@amd.com>, Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>, Rex Zhu <rex.zhu@amd.com>, Evan Quan <evan.quan@amd.com>, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, amd-gfx list <amd-gfx@lists.freedesktop.org>, dri-devel <dri-devel@lists.freedesktop.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, clang-built-linux <clang-built-linux@googlegroups.com>
List-Id: amd-gfx.lists.freedesktop.org

On Thu, Jul 4, 2019 at 7:52 AM Nathan Chancellor
<natechancellor@gmail.com> wrote:
>
> clang warns:
>
> drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm_pp_smu.c:336:8:
> warning: implicit conversion from enumeration type 'enum smu_clk_type'
> to different enumeration type 'enum amd_pp_clock_type'
> [-Wenum-conversion]
>                                         dc_to_smu_clock_type(clk_type),
>                                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm_pp_smu.c:421:14:
> warning: implicit conversion from enumeration type 'enum
> amd_pp_clock_type' to different enumeration type 'enum smu_clk_type'
> [-Wenum-conversion]
>                                         dc_to_pp_clock_type(clk_type),
>                                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>
> There are functions to properly convert between all of these types, use
> them so there are no longer any warnings.

I had a different solution for this one as well. The difference is that your
patch keeps the types and assumes that the functions do the right thing
(i.e. the warning was correct), while my version assumes that the code
works correctly, but the types are wrong (a false positive warning).

One of the two patches is correct, the other one is broken, but I have
no idea which one.

      Arnd

>From 61316b80c852d103bb61e1ce9904002414600125 Mon Sep 17 00:00:00 2001
From: Arnd Bergmann <arnd@arndb.de>
Date: Mon, 8 Jul 2019 17:44:05 +0200
Subject: [PATCH] drm/amd/powerplay: fix one more incorrect enum conversion

Similar to a previous patch, this one converts the type from a
function argument of a different enum type:

drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm_pp_smu.c:336:8:
error: implicit conversion from enumeration type 'enum smu_clk_type'
to different enumeration type 'enum amd_pp_clock_type'
[-Werror,-Wenum-conversion]
                                          dc_to_smu_clock_type(clk_type),
                                          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/gpu/drm/amd/amdgpu/../powerplay/inc/amdgpu_smu.h:868:77: note:
expanded from macro 'smu_get_clock_by_type'
        ((smu)->funcs->get_clock_by_type ?
(smu)->funcs->get_clock_by_type((smu), (type), (clocks)) : 0)
                                           ~
            ^~~~
drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm_pp_smu.c:421:14:
error: implicit conversion from enumeration type 'enum
amd_pp_clock_type' to different enumeration type 'enum smu_clk_type'
[-Werror,-Wenum-conversion]

dc_to_pp_clock_type(clk_type),

^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/gpu/drm/amd/amdgpu/../powerplay/inc/amdgpu_smu.h:872:111:
note: expanded from macro 'smu_get_clock_by_type_with_latency'

Add another type cast.

Fixes: e5e4e22391c2 ("drm/amd/powerplay: add interface to get clock by
type with latency for display (v2)")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_pp_smu.c
b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_pp_smu.c
index eac09bfe3be2..88e3f8456b1c 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_pp_smu.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_pp_smu.c
@@ -333,7 +333,7 @@ bool dm_pp_get_clock_levels_by_type(
                }
        } else if (adev->smu.funcs && adev->smu.funcs->get_clock_by_type) {
                if (smu_get_clock_by_type(&adev->smu,
-                                         dc_to_smu_clock_type(clk_type),
+                                         (enum
amd_pp_clock_type)dc_to_smu_clock_type(clk_type),
                                          &pp_clks)) {
                        get_default_clock_levels(clk_type, dc_clks);
                        return true;
@@ -418,7 +418,7 @@ bool dm_pp_get_clock_levels_by_type_with_latency(
                        return false;
        } else if (adev->smu.ppt_funcs &&
adev->smu.ppt_funcs->get_clock_by_type_with_latency) {
                if (smu_get_clock_by_type_with_latency(&adev->smu,
-
dc_to_pp_clock_type(clk_type),
+                                                      (enum
smu_clk_type)dc_to_pp_clock_type(clk_type),
                                                       &pp_clks))
                        return false;
        }
