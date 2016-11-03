From: Alex Deucher <alexdeucher@gmail.com>
Subject: [PATCH] drm/amdgpu: fix crash in acp_hw_init
Date: Thu,  3 Nov 2016 17:50:15 -0400
Message-ID: <1478209815-15695-1-git-send-email-alexander.deucher@amd.com>
Return-path: <stable-owner@vger.kernel.org>
Sender: stable-owner@vger.kernel.org
To: amd-gfx@lists.freedesktop.org
Cc: Alex Deucher <alexander.deucher@amd.com>, stable@vger.kernel.org
List-Id: amd-gfx.lists.freedesktop.org

On CZ/ST systems with AZ rather than ACP audio, we need to bail
early in hw_fini since there is nothing to do.

bug: https://bugs.freedesktop.org/show_bug.cgi?id=98276

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c
index 176c3d7..1130f9d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c
@@ -395,9 +395,12 @@ static int acp_hw_fini(void *handle)
 {
 	int i, ret;
 	struct device *dev;
-
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 
+	/* return early if no ACP */
+	if (!adev->acp.acp_genpd)
+		return 0;
+
 	for (i = 0; i < ACP_DEVS ; i++) {
 		dev = get_mfd_cell_dev(adev->acp.acp_cell[i].name, i);
 		ret = pm_genpd_remove_device(&adev->acp.acp_genpd->gpd, dev);
-- 
2.5.5
