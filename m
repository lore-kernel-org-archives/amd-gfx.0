From: Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH 3/7] drm/amd/powerplay: Use proper enums in smu_adjust_power_state_dynamic
Date: Wed,  3 Jul 2019 22:52:14 -0700
Message-ID: <20190704055217.45860-4-natechancellor@gmail.com>
References: <20190704055217.45860-1-natechancellor@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190704055217.45860-1-natechancellor@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Alex Deucher <alexander.deucher@amd.com>, =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "David (ChunMing) Zhou" <David1.Zhou@amd.com>, Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>, Rex Zhu <rex.zhu@amd.com>, Evan Quan <evan.quan@amd.com>
Cc: David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com, Nathan Chancellor <natechancellor@gmail.com>
List-Id: amd-gfx.lists.freedesktop.org

clang warns:

drivers/gpu/drm/amd/amdgpu/../powerplay/amdgpu_smu.c:1374:30: warning:
implicit conversion from enumeration type 'enum pp_clock_type' to
different enumeration type 'enum smu_clk_type' [-Wenum-conversion]
                        smu_force_clk_levels(smu, PP_SCLK, 1 << sclk_mask);
                        ~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~
drivers/gpu/drm/amd/amdgpu/../powerplay/amdgpu_smu.c:1375:30: warning:
implicit conversion from enumeration type 'enum pp_clock_type' to
different enumeration type 'enum smu_clk_type' [-Wenum-conversion]
                        smu_force_clk_levels(smu, PP_MCLK, 1 << mclk_mask);
                        ~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~

This appears to be a copy and paste fail from when this was a call to
vega20_force_clk_levels.

Fixes: bc0fcffd36ba ("drm/amd/powerplay: Unify smu handle task function (v2)")
Link: https://github.com/ClangBuiltLinux/linux/issues/584
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---
 drivers/gpu/drm/amd/powerplay/amdgpu_smu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
index 31152d495f69..e897469f7431 100644
--- a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
@@ -1371,8 +1371,8 @@ int smu_adjust_power_state_dynamic(struct smu_context *smu,
 							 &soc_mask);
 			if (ret)
 				return ret;
-			smu_force_clk_levels(smu, PP_SCLK, 1 << sclk_mask);
-			smu_force_clk_levels(smu, PP_MCLK, 1 << mclk_mask);
+			smu_force_clk_levels(smu, SMU_SCLK, 1 << sclk_mask);
+			smu_force_clk_levels(smu, SMU_MCLK, 1 << mclk_mask);
 			break;
 
 		case AMD_DPM_FORCED_LEVEL_MANUAL:
-- 
2.22.0
