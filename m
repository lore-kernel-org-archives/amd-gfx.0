From: YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] drm/amd/display: remove set but not used variable 'core_freesync'
Date: Sun, 6 Oct 2019 18:57:35 +0800
Message-ID: <20191006105735.60708-1-yuehaibing@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: harry.wentland@amd.com, sunpeng.li@amd.com, alexander.deucher@amd.com, christian.koenig@amd.com, David1.Zhou@amd.com, airlied@linux.ie, daniel@ffwll.ch, Bhawanpreet.Lakha@amd.com, Anthony.Koo@amd.com, aric.cyr@amd.com, Harmanprit.Tatla@amd.com, bayan.zabihiyan@amd.com, ahmad.othman@amd.com, Reza.Amini@amd.com
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, YueHaibing <yuehaibing@huawei.com>
List-Id: amd-gfx.lists.freedesktop.org

Fixes gcc '-Wunused-but-set-variable' warning:

rivers/gpu/drm/amd/amdgpu/../display/modules/freesync/freesync.c:
 In function mod_freesync_get_settings:
drivers/gpu/drm/amd/amdgpu/../display/modules/freesync/freesync.c:984:24:
 warning: variable core_freesync set but not used [-Wunused-but-set-variable]

It is not used since commit 98e6436d3af5 ("drm/amd/display: Refactor FreeSync module")

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/gpu/drm/amd/display/modules/freesync/freesync.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/modules/freesync/freesync.c b/drivers/gpu/drm/amd/display/modules/freesync/freesync.c
index 9ce56a8..237dda7 100644
--- a/drivers/gpu/drm/amd/display/modules/freesync/freesync.c
+++ b/drivers/gpu/drm/amd/display/modules/freesync/freesync.c
@@ -981,13 +981,9 @@ void mod_freesync_get_settings(struct mod_freesync *mod_freesync,
 		unsigned int *inserted_frames,
 		unsigned int *inserted_duration_in_us)
 {
-	struct core_freesync *core_freesync = NULL;
-
 	if (mod_freesync == NULL)
 		return;
 
-	core_freesync = MOD_FREESYNC_TO_CORE(mod_freesync);
-
 	if (vrr->supported) {
 		*v_total_min = vrr->adjust.v_total_min;
 		*v_total_max = vrr->adjust.v_total_max;
-- 
2.7.4
