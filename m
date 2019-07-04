From: Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH 6/7] drm/amd/powerplay: Use proper enums in vega20_print_clk_levels
Date: Wed,  3 Jul 2019 22:52:17 -0700
Message-ID: <20190704055217.45860-7-natechancellor@gmail.com>
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

drivers/gpu/drm/amd/amdgpu/../powerplay/vega20_ppt.c:995:39: warning:
implicit conversion from enumeration type 'PPCLK_e' to different
enumeration type 'enum smu_clk_type' [-Wenum-conversion]
                ret = smu_get_current_clk_freq(smu, PPCLK_SOCCLK, &now);
                      ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~
drivers/gpu/drm/amd/amdgpu/../powerplay/vega20_ppt.c:1016:39: warning:
implicit conversion from enumeration type 'PPCLK_e' to different
enumeration type 'enum smu_clk_type' [-Wenum-conversion]
                ret = smu_get_current_clk_freq(smu, PPCLK_FCLK, &now);
                      ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~
drivers/gpu/drm/amd/amdgpu/../powerplay/vega20_ppt.c:1031:39: warning:
implicit conversion from enumeration type 'PPCLK_e' to different
enumeration type 'enum smu_clk_type' [-Wenum-conversion]
                ret = smu_get_current_clk_freq(smu, PPCLK_DCEFCLK, &now);
                      ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~

The values are mapped one to one in vega20_get_smu_clk_index so just use
the proper enums here.

Fixes: 096761014227 ("drm/amd/powerplay: support sysfs to get socclk, fclk, dcefclk")
Link: https://github.com/ClangBuiltLinux/linux/issues/587
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---
 drivers/gpu/drm/amd/powerplay/vega20_ppt.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/vega20_ppt.c b/drivers/gpu/drm/amd/powerplay/vega20_ppt.c
index 0f14fe14ecd8..e62dd6919b24 100644
--- a/drivers/gpu/drm/amd/powerplay/vega20_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/vega20_ppt.c
@@ -992,7 +992,7 @@ static int vega20_print_clk_levels(struct smu_context *smu,
 		break;
 
 	case SMU_SOCCLK:
-		ret = smu_get_current_clk_freq(smu, PPCLK_SOCCLK, &now);
+		ret = smu_get_current_clk_freq(smu, SMU_SOCCLK, &now);
 		if (ret) {
 			pr_err("Attempt to get current socclk Failed!");
 			return ret;
@@ -1013,7 +1013,7 @@ static int vega20_print_clk_levels(struct smu_context *smu,
 		break;
 
 	case SMU_FCLK:
-		ret = smu_get_current_clk_freq(smu, PPCLK_FCLK, &now);
+		ret = smu_get_current_clk_freq(smu, SMU_FCLK, &now);
 		if (ret) {
 			pr_err("Attempt to get current fclk Failed!");
 			return ret;
@@ -1028,7 +1028,7 @@ static int vega20_print_clk_levels(struct smu_context *smu,
 		break;
 
 	case SMU_DCEFCLK:
-		ret = smu_get_current_clk_freq(smu, PPCLK_DCEFCLK, &now);
+		ret = smu_get_current_clk_freq(smu, SMU_DCEFCLK, &now);
 		if (ret) {
 			pr_err("Attempt to get current dcefclk Failed!");
 			return ret;
-- 
2.22.0
