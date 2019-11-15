From: Colin King <colin.king@canonical.com>
Subject: [PATCH][next] drm/amdgpu/powerplay: fix dereference before null check of pointer hwmgr
Date: Fri, 15 Nov 2019 09:47:54 +0000
Message-ID: <20191115094754.40920-1-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rex Zhu <rex.zhu@amd.com>, Evan Quan <evan.quan@amd.com>, Alex Deucher <alexander.deucher@amd.com>, =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, David Zhou <David1.Zhou@amd.com>, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: amd-gfx.lists.freedesktop.org

From: Colin Ian King <colin.king@canonical.com>

The assignment of adev dereferences pointer hwmgr before hwmgr is null
checked, hence there is a potential null pointer deference issue. Fix
this by assigning adev after the null check.

Addresses-Coverity: ("Dereference before null check")
Fixes: 0896d2f7ba4d ("drm/amdgpu/powerplay: properly set PP_GFXOFF_MASK")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/gpu/drm/amd/powerplay/hwmgr/hwmgr.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/hwmgr.c b/drivers/gpu/drm/amd/powerplay/hwmgr/hwmgr.c
index 443625c83ec9..d2909c91d65b 100644
--- a/drivers/gpu/drm/amd/powerplay/hwmgr/hwmgr.c
+++ b/drivers/gpu/drm/amd/powerplay/hwmgr/hwmgr.c
@@ -81,7 +81,7 @@ static void hwmgr_init_workload_prority(struct pp_hwmgr *hwmgr)
 
 int hwmgr_early_init(struct pp_hwmgr *hwmgr)
 {
-	struct amdgpu_device *adev = hwmgr->adev;
+	struct amdgpu_device *adev;
 
 	if (!hwmgr)
 		return -EINVAL;
@@ -96,6 +96,8 @@ int hwmgr_early_init(struct pp_hwmgr *hwmgr)
 	hwmgr_init_workload_prority(hwmgr);
 	hwmgr->gfxoff_state_changed_by_workload = false;
 
+	adev = hwmgr->adev;
+
 	switch (hwmgr->chip_family) {
 	case AMDGPU_FAMILY_CI:
 		adev->pm.pp_feature &= ~PP_GFXOFF_MASK;
-- 
2.20.1
