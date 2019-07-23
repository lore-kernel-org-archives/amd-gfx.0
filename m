From: Chuhong Yuan <hslester96@gmail.com>
Subject: [PATCH] drm/amd/display: Use dev_get_drvdata
Date: Tue, 23 Jul 2019 17:04:22 +0800
Message-ID: <20190723090421.27532-1-hslester96@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Cc: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>, Alex Deucher <alexander.deucher@amd.com>, =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, David Zhou <David1.Zhou@amd.com>, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, Chuhong Yuan <hslester96@gmail.com>
List-Id: amd-gfx.lists.freedesktop.org

Instead of using to_pci_dev + pci_get_drvdata,
use dev_get_drvdata to make code simpler.

Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 4a29f72334d0..524e1e19017e 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -2428,8 +2428,7 @@ static ssize_t s3_debug_store(struct device *device,
 {
 	int ret;
 	int s3_state;
-	struct pci_dev *pdev = to_pci_dev(device);
-	struct drm_device *drm_dev = pci_get_drvdata(pdev);
+	struct drm_device *drm_dev = dev_get_drvdata(device);
 	struct amdgpu_device *adev = drm_dev->dev_private;
 
 	ret = kstrtoint(buf, 0, &s3_state);
-- 
2.20.1
