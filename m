From: Nicolas Iooss <nicolas.iooss_linux@m4x.org>
Subject: [PATCH 1/1] drm/amd/powerplay: initialize a variable before using it
Date: Sun,  3 Sep 2017 14:00:57 +0200
Message-ID: <20170903120057.19735-1-nicolas.iooss_linux@m4x.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Alex Deucher <alexander.deucher@amd.com>, =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, David Airlie <airlied@linux.ie>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, Nicolas Iooss <nicolas.iooss_linux@m4x.org>
List-Id: amd-gfx.lists.freedesktop.org

Function vega10_apply_state_adjust_rules() only initializes
stable_pstate_sclk_dpm_percentage when
data->registry_data.stable_pstate_sclk_dpm_percentage is not between 1
and 100. The variable is then used to compute stable_pstate_sclk, which
therefore uses an uninitialized value.

Fix this by initializing stable_pstate_sclk_dpm_percentage to
data->registry_data.stable_pstate_sclk_dpm_percentage.

This issue has been found while building the kernel with clang. The
compiler reported a -Wsometimes-uninitialized warning.

Fixes: f83a9991648b ("drm/amd/powerplay: add Vega10 powerplay support (v5)")
Signed-off-by: Nicolas Iooss <nicolas.iooss_linux@m4x.org>
---
 drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c b/drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c
index 197174e562d2..c8d28f78cd47 100644
--- a/drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c
+++ b/drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c
@@ -3043,6 +3043,8 @@ static int vega10_apply_state_adjust_rules(struct pp_hwmgr *hwmgr,
 
 	if (phm_cap_enabled(hwmgr->platform_descriptor.platformCaps,
 			PHM_PlatformCaps_StablePState)) {
+		stable_pstate_sclk_dpm_percentage =
+			data->registry_data.stable_pstate_sclk_dpm_percentage;
 		PP_ASSERT_WITH_CODE(
 			data->registry_data.stable_pstate_sclk_dpm_percentage >= 1 &&
 			data->registry_data.stable_pstate_sclk_dpm_percentage <= 100,
-- 
2.14.1
