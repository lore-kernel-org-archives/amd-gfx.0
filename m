From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH] drm/amd/powerplay: work around enum conversion warnings
Date: Mon,  8 Jul 2019 15:57:06 +0200
Message-ID: <20190708135725.844960-1-arnd@arndb.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rex Zhu <rex.zhu@amd.com>, Evan Quan <evan.quan@amd.com>, Alex Deucher <alexander.deucher@amd.com>, =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "David (ChunMing) Zhou" <David1.Zhou@amd.com>, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>
Cc: Arnd Bergmann <arnd@arndb.de>, Likun Gao <Likun.Gao@amd.com>, Huang Rui <ray.huang@amd.com>, Gui Chengming <Jack.Gui@amd.com>, Kevin Wang <kevin1.wang@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>, amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com
List-Id: amd-gfx.lists.freedesktop.org

A couple of calls to smu_get_current_clk_freq() and smu_force_clk_levels()
pass constants of the wrong type, leading to warnings with clang-8:

drivers/gpu/drm/amd/amdgpu/../powerplay/vega20_ppt.c:995:39: error: implicit conversion from enumeration type 'PPCLK_e' to different enumeration type 'enum smu_clk_type' [-Werror,-Wenum-conversion]
                ret = smu_get_current_clk_freq(smu, PPCLK_SOCCLK, &now);
                      ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~
drivers/gpu/drm/amd/amdgpu/../powerplay/inc/amdgpu_smu.h:775:82: note: expanded from macro 'smu_get_current_clk_freq'
        ((smu)->funcs->get_current_clk_freq? (smu)->funcs->get_current_clk_freq((smu), (clk_id), (value)) : 0)

I could not figure out what the purpose is of mixing the types
like this and if it is written like this intentionally.
Assuming this is all correct, adding an explict case is an
easy way to shut up the warnings.

Fixes: bc0fcffd36ba ("drm/amd/powerplay: Unify smu handle task function (v2)")
Fixes: 096761014227 ("drm/amd/powerplay: support sysfs to get socclk, fclk, dcefclk")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
Please check carefully if the warning is just a false positive
or we need a different patch.
---
 drivers/gpu/drm/amd/powerplay/amdgpu_smu.c | 4 ++--
 drivers/gpu/drm/amd/powerplay/vega20_ppt.c | 6 +++---
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
index 755c6c79f724..93732623b507 100644
--- a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
@@ -1386,8 +1386,8 @@ int smu_adjust_power_state_dynamic(struct smu_context *smu,
 							 &soc_mask);
 			if (ret)
 				return ret;
-			smu_force_clk_levels(smu, PP_SCLK, 1 << sclk_mask);
-			smu_force_clk_levels(smu, PP_MCLK, 1 << mclk_mask);
+			smu_force_clk_levels(smu, (enum smu_clk_type)PP_SCLK, 1 << sclk_mask);
+			smu_force_clk_levels(smu, (enum smu_clk_type)PP_MCLK, 1 << mclk_mask);
 			break;
 
 		case AMD_DPM_FORCED_LEVEL_MANUAL:
diff --git a/drivers/gpu/drm/amd/powerplay/vega20_ppt.c b/drivers/gpu/drm/amd/powerplay/vega20_ppt.c
index dba02fa0de01..20d477f8dc84 100644
--- a/drivers/gpu/drm/amd/powerplay/vega20_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/vega20_ppt.c
@@ -992,7 +992,7 @@ static int vega20_print_clk_levels(struct smu_context *smu,
 		break;
 
 	case SMU_SOCCLK:
-		ret = smu_get_current_clk_freq(smu, PPCLK_SOCCLK, &now);
+		ret = smu_get_current_clk_freq(smu, (enum smu_clk_type)PPCLK_SOCCLK, &now);
 		if (ret) {
 			pr_err("Attempt to get current socclk Failed!");
 			return ret;
@@ -1013,7 +1013,7 @@ static int vega20_print_clk_levels(struct smu_context *smu,
 		break;
 
 	case SMU_FCLK:
-		ret = smu_get_current_clk_freq(smu, PPCLK_FCLK, &now);
+		ret = smu_get_current_clk_freq(smu, (enum smu_clk_type)PPCLK_FCLK, &now);
 		if (ret) {
 			pr_err("Attempt to get current fclk Failed!");
 			return ret;
@@ -1028,7 +1028,7 @@ static int vega20_print_clk_levels(struct smu_context *smu,
 		break;
 
 	case SMU_DCEFCLK:
-		ret = smu_get_current_clk_freq(smu, PPCLK_DCEFCLK, &now);
+		ret = smu_get_current_clk_freq(smu, (enum smu_clk_type)PPCLK_DCEFCLK, &now);
 		if (ret) {
 			pr_err("Attempt to get current dcefclk Failed!");
 			return ret;
-- 
2.20.0
