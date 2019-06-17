From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH] drm/amdgpu: fix error handling in df_v3_6_pmc_start
Date: Mon, 17 Jun 2019 14:51:45 +0200
Message-ID: <20190617125216.1439481-1-arnd@arndb.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Alex Deucher <alexander.deucher@amd.com>, =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "David (ChunMing) Zhou" <David1.Zhou@amd.com>, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>
Cc: Arnd Bergmann <arnd@arndb.de>, Jonathan Kim <jonathan.kim@amd.com>, Evan Quan <evan.quan@amd.com>, Colin Ian King <colin.king@canonical.com>, amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
List-Id: amd-gfx.lists.freedesktop.org

When df_v3_6_pmc_get_ctrl_settings() fails for some reason, we
store uninitialized data in a register, as gcc points out:

drivers/gpu/drm/amd/amdgpu/df_v3_6.c: In function 'df_v3_6_pmc_start':
drivers/gpu/drm/amd/amdgpu/amdgpu.h:1012:29: error: 'lo_val' may be used uninitialized in this function [-Werror=maybe-uninitialized]
 #define WREG32_PCIE(reg, v) adev->pcie_wreg(adev, (reg), (v))
                             ^~~~
drivers/gpu/drm/amd/amdgpu/df_v3_6.c:334:39: note: 'lo_val' was declared here
  uint32_t lo_base_addr, hi_base_addr, lo_val, hi_val;
                                       ^~~~~~

Make it return a proper error code that we can catch in the caller.

Fixes: 992af942a6cf ("drm/amdgpu: add df perfmon regs and funcs for xgmi")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/gpu/drm/amd/amdgpu/df_v3_6.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/df_v3_6.c b/drivers/gpu/drm/amd/amdgpu/df_v3_6.c
index 8c09bf994acd..e079ee066d87 100644
--- a/drivers/gpu/drm/amd/amdgpu/df_v3_6.c
+++ b/drivers/gpu/drm/amd/amdgpu/df_v3_6.c
@@ -177,7 +177,7 @@ static void df_v3_6_pmc_get_read_settings(struct amdgpu_device *adev,
 }
 
 /* get control counter settings i.e. address and values to set */
-static void df_v3_6_pmc_get_ctrl_settings(struct amdgpu_device *adev,
+static int df_v3_6_pmc_get_ctrl_settings(struct amdgpu_device *adev,
 					  uint64_t config,
 					  uint32_t *lo_base_addr,
 					  uint32_t *hi_base_addr,
@@ -191,12 +191,12 @@ static void df_v3_6_pmc_get_ctrl_settings(struct amdgpu_device *adev,
 	df_v3_6_pmc_get_addr(adev, config, 1, lo_base_addr, hi_base_addr);
 
 	if (lo_val == NULL || hi_val == NULL)
-		return;
+		return -EINVAL;
 
 	if ((*lo_base_addr == 0) || (*hi_base_addr == 0)) {
 		DRM_ERROR("DF PMC addressing not retrieved! Lo: %x, Hi: %x",
 				*lo_base_addr, *hi_base_addr);
-		return;
+		return -ENXIO;
 	}
 
 	eventsel = GET_EVENT(config);
@@ -211,6 +211,8 @@ static void df_v3_6_pmc_get_ctrl_settings(struct amdgpu_device *adev,
 	es_7_0 = es_13_0 & 0x0FFUL;
 	*lo_val = (es_7_0 & 0xFFUL) | ((unitmask & 0x0FUL) << 8);
 	*hi_val = (es_11_8 | ((es_13_12)<<(29)));
+
+	return 0;
 }
 
 /* assign df performance counters for read */
@@ -345,13 +347,16 @@ static int df_v3_6_add_xgmi_link_cntr(struct amdgpu_device *adev,
 	if (ret || is_assigned)
 		return ret;
 
-	df_v3_6_pmc_get_ctrl_settings(adev,
+	ret = df_v3_6_pmc_get_ctrl_settings(adev,
 			config,
 			&lo_base_addr,
 			&hi_base_addr,
 			&lo_val,
 			&hi_val);
 
+	if (ret)
+		return ret;
+
 	WREG32_PCIE(lo_base_addr, lo_val);
 	WREG32_PCIE(hi_base_addr, hi_val);
 
-- 
2.20.0
