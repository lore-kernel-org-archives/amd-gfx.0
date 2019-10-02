From: Navid Emamdoost <navid.emamdoost@gmail.com>
Subject: [PATCH v4] drm/amdgpu: fix multiple memory leaks in acp_hw_init
Date: Tue,  1 Oct 2019 22:46:07 -0500
Message-ID: <20191002034612.26607-1-navid.emamdoost@gmail.com>
References: <3a00a4c9-af4c-3505-1bef-b119435da5d7@amd.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <3a00a4c9-af4c-3505-1bef-b119435da5d7@amd.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Christian.Koenig@amd.com
Cc: emamd001@umn.edu, smccaman@umn.edu, kjlu@umn.edu, Navid Emamdoost <navid.emamdoost@gmail.com>, Alex Deucher <alexander.deucher@amd.com>, =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "David (ChunMing) Zhou" <David1.Zhou@amd.com>, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, Sam Ravnborg <sam@ravnborg.org>, Rex Zhu <Rex.Zhu@amd.com>, amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
List-Id: amd-gfx.lists.freedesktop.org

In acp_hw_init there are some allocations that needs to be released in
case of failure:

1- adev->acp.acp_genpd should be released if any allocation attemp for
adev->acp.acp_cell, adev->acp.acp_res or i2s_pdata fails.
2- all of those allocations should be released if
mfd_add_hotplug_devices or pm_genpd_add_device fail.
3- Release is needed in case of time out values expire.

Signed-off-by: Navid Emamdoost <navid.emamdoost@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c | 34 ++++++++++++++++---------
 1 file changed, 22 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c
index eba42c752bca..82155ac3288a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c
@@ -189,7 +189,7 @@ static int acp_hw_init(void *handle)
 	u32 val = 0;
 	u32 count = 0;
 	struct device *dev;
-	struct i2s_platform_data *i2s_pdata;
+	struct i2s_platform_data *i2s_pdata = NULL;
 
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 
@@ -231,20 +231,21 @@ static int acp_hw_init(void *handle)
 	adev->acp.acp_cell = kcalloc(ACP_DEVS, sizeof(struct mfd_cell),
 							GFP_KERNEL);
 
-	if (adev->acp.acp_cell == NULL)
-		return -ENOMEM;
+	if (adev->acp.acp_cell == NULL) {
+		r = -ENOMEM;
+		goto failure;
+	}
 
 	adev->acp.acp_res = kcalloc(5, sizeof(struct resource), GFP_KERNEL);
 	if (adev->acp.acp_res == NULL) {
-		kfree(adev->acp.acp_cell);
-		return -ENOMEM;
+		r = -ENOMEM;
+		goto failure;
 	}
 
 	i2s_pdata = kcalloc(3, sizeof(struct i2s_platform_data), GFP_KERNEL);
 	if (i2s_pdata == NULL) {
-		kfree(adev->acp.acp_res);
-		kfree(adev->acp.acp_cell);
-		return -ENOMEM;
+		r = -ENOMEM;
+		goto failure;
 	}
 
 	switch (adev->asic_type) {
@@ -341,14 +342,14 @@ static int acp_hw_init(void *handle)
 	r = mfd_add_hotplug_devices(adev->acp.parent, adev->acp.acp_cell,
 								ACP_DEVS);
 	if (r)
-		return r;
+		goto failure;
 
 	for (i = 0; i < ACP_DEVS ; i++) {
 		dev = get_mfd_cell_dev(adev->acp.acp_cell[i].name, i);
 		r = pm_genpd_add_device(&adev->acp.acp_genpd->gpd, dev);
 		if (r) {
 			dev_err(dev, "Failed to add dev to genpd\n");
-			return r;
+			goto failure;
 		}
 	}
 
@@ -367,7 +368,8 @@ static int acp_hw_init(void *handle)
 			break;
 		if (--count == 0) {
 			dev_err(&adev->pdev->dev, "Failed to reset ACP\n");
-			return -ETIMEDOUT;
+			r = -ETIMEDOUT;
+			goto failure;
 		}
 		udelay(100);
 	}
@@ -384,7 +386,8 @@ static int acp_hw_init(void *handle)
 			break;
 		if (--count == 0) {
 			dev_err(&adev->pdev->dev, "Failed to reset ACP\n");
-			return -ETIMEDOUT;
+			r = -ETIMEDOUT;
+			goto failure;
 		}
 		udelay(100);
 	}
@@ -393,6 +396,13 @@ static int acp_hw_init(void *handle)
 	val &= ~ACP_SOFT_RESET__SoftResetAud_MASK;
 	cgs_write_register(adev->acp.cgs_device, mmACP_SOFT_RESET, val);
 	return 0;
+
+failure:
+	kfree(i2s_pdata);
+	kfree(adev->acp.acp_res);
+	kfree(adev->acp.acp_cell);
+	kfree(adev->acp.acp_genpd);
+	return r;
 }
 
 /**
-- 
2.17.1
