From: Himanshu Jha <himanshujha199640@gmail.com>
Subject: [PATCH] drm/amd: Remove null check before kfree
Date: Tue, 29 Aug 2017 18:51:27 +0530
Message-ID: <1504012887-15147-1-git-send-email-himanshujha199640@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: airlied@linux.ie
Cc: alexander.deucher@amd.com, christian.koenig@amd.com, amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, Himanshu Jha <himanshujha199640@gmail.com>
List-Id: amd-gfx.lists.freedesktop.org

Kfree on NULL pointer is a no-op and therefore checking is redundant.

Signed-off-by: Himanshu Jha <himanshujha199640@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c     | 6 ++----
 drivers/gpu/drm/amd/powerplay/smumgr/smu7_smumgr.c | 6 ++----
 2 files changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c
index 8d1cf2d..f51b41f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c
@@ -346,10 +346,8 @@ static void amdgpu_connector_free_edid(struct drm_connector *connector)
 {
 	struct amdgpu_connector *amdgpu_connector = to_amdgpu_connector(connector);
 
-	if (amdgpu_connector->edid) {
-		kfree(amdgpu_connector->edid);
-		amdgpu_connector->edid = NULL;
-	}
+	kfree(amdgpu_connector->edid);
+	amdgpu_connector->edid = NULL;
 }
 
 static int amdgpu_connector_ddc_get_modes(struct drm_connector *connector)
diff --git a/drivers/gpu/drm/amd/powerplay/smumgr/smu7_smumgr.c b/drivers/gpu/drm/amd/powerplay/smumgr/smu7_smumgr.c
index 76347ff..00075c2 100644
--- a/drivers/gpu/drm/amd/powerplay/smumgr/smu7_smumgr.c
+++ b/drivers/gpu/drm/amd/powerplay/smumgr/smu7_smumgr.c
@@ -606,10 +606,8 @@ int smu7_init(struct pp_smumgr *smumgr)
 
 int smu7_smu_fini(struct pp_smumgr *smumgr)
 {
-	if (smumgr->backend) {
-		kfree(smumgr->backend);
-		smumgr->backend = NULL;
-	}
+	kfree(smumgr->backend);
+	smumgr->backend = NULL;
 	cgs_rel_firmware(smumgr->device, CGS_UCODE_ID_SMU);
 	return 0;
 }
-- 
2.7.4
