From: Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH] drm/amd/display: Use memset to initialize variable in wait_for_training_aux_rd_interval
Date: Fri,  1 Feb 2019 13:15:41 -0700
Message-ID: <20190201201541.13680-1-natechancellor@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "David (ChunMing) Zhou" <David1.Zhou@amd.com>, amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, John Barberiz <John.Barberiz@amd.com>, Wenjing Liu <Wenjing.Liu@amd.com>, Nick Desaulniers <ndesaulniers@google.com>, Nathan Chancellor <natechancellor@gmail.com>
List-Id: amd-gfx.lists.freedesktop.org

Clang warns:

drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc_link_dp.c:50:57:
warning: suggest braces around initialization of subobject
[-Wmissing-braces]
        union training_aux_rd_interval training_rd_interval = {0};
                                                               ^
                                                               {}
1 warning generated.

Previous efforts to fix this type of warning by adding or removing
braces have been met with some pushback in favor of using memset [1][2].
Do that here, mirroring commit 05794eff1aa6 ("drm/amdgpu/gmc: fix
compiler errors [-Werror,-Wmissing-braces] (V2)") in this tree.

[1]: https://lore.kernel.org/lkml/022e41c0-8465-dc7a-a45c-64187ecd9684@amd.com/
[2]: https://lore.kernel.org/lkml/20181128.215241.702406654469517539.davem@davemloft.net/

Fixes: 3cec41769d21 ("drm/amd/display: Fix use of uninitialized union")
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
index 92f565ca1260..5ee36d6e0512 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
@@ -47,7 +47,9 @@ static void wait_for_training_aux_rd_interval(
 	struct dc_link *link,
 	uint32_t default_wait_in_micro_secs)
 {
-	union training_aux_rd_interval training_rd_interval = {0};
+	union training_aux_rd_interval training_rd_interval;
+
+	memset(&training_rd_interval, 0, sizeof(training_rd_interval));
 
 	/* overwrite the delay if rev > 1.1*/
 	if (link->dpcd_caps.dpcd_rev.raw >= DPCD_REV_12) {
-- 
2.20.1
