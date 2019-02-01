From: Colin King <colin.king@canonical.com>
Subject: [PATCH][drm-next] drm/amd/amdgpu: fix spelling mistake "matech" -> "match"
Date: Fri,  1 Feb 2019 10:41:59 +0000
Message-ID: <20190201104159.19215-1-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Alex Deucher <alexander.deucher@amd.com>, =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, David Zhou <David1.Zhou@amd.com>, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: amd-gfx.lists.freedesktop.org

From: Colin Ian King <colin.king@canonical.com>

There is a spelling mistake in a dev_err message. Fix it.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
index dac187454b33..2ae25095e501 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
@@ -129,7 +129,7 @@ int amdgpu_xgmi_add_device(struct amdgpu_device *adev)
 	if (!hive) {
 		ret = -EINVAL;
 		dev_err(adev->dev,
-			"XGMI: node 0x%llx, can not matech hive 0x%llx in the hive list.\n",
+			"XGMI: node 0x%llx, can not match hive 0x%llx in the hive list.\n",
 			adev->gmc.xgmi.node_id, adev->gmc.xgmi.hive_id);
 		goto exit;
 	}
-- 
2.20.1
