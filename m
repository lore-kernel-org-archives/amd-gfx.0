Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3702E7719A
	for <amd-gfx@archiver.kernel.org>; Sun,  5 Jan 2025 16:40:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3417010E094;
	Sun,  5 Jan 2025 16:40:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="QePT9gIM";
	dkim-atps=neutral
Received: from out30-119.freemail.mail.aliyun.com
 (out30-119.freemail.mail.aliyun.com [115.124.30.119])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A1CA110E4D1
 for <amd-gfx@lists.freedesktop.org>; Sun,  5 Jan 2025 02:45:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1736045140; h=From:To:Subject:Date:Message-ID:MIME-Version;
 bh=T6FhFhsIZH8to1O8Rx5GWYDRIVWsAma3R2qR/xRoyi8=;
 b=QePT9gIMVLMsWn0WkFuHXUb8d+gDPc6L6vzUIEI4mx2RZqXsJ8WGUHXDrBuVgflkVDsVpGVw4ELHTzZXAr2SHreQfjRMHKSomKWZprGgS+S9TAhd65SbbD0u17s8iQPw4Jg4K+mPPdfKe9BU3GrCbfAgREa+9UzKPcAnyPzi2Nw=
Received: from i32d02263.sqa.eu95.tbsite.net(mailfrom:gerry@linux.alibaba.com
 fp:SMTPD_---0WMx9YBK_1736045139 cluster:ay36) by smtp.aliyun-inc.com;
 Sun, 05 Jan 2025 10:45:39 +0800
From: Jiang Liu <gerry@linux.alibaba.com>
To: amd-gfx@lists.freedesktop.org, xiaogang.chen@amd.com, lijo.lazar@amd.com,
 Kent.Russell@amd.com, shuox.liu@linux.alibaba.com
Cc: Jiang Liu <gerry@linux.alibaba.com>
Subject: [PATCH v2 3/6] drm/amdxcp: introduce new API amdgpu_xcp_drm_dev_free()
Date: Sun,  5 Jan 2025 10:45:31 +0800
Message-ID: <0380e1585e7b29426e0c9ff49b84ea071d9c4610.1736044362.git.gerry@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <cover.1736044362.git.gerry@linux.alibaba.com>
References: <cover.1736044362.git.gerry@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sun, 05 Jan 2025 16:40:26 +0000
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Introduce new interface amdgpu_xcp_drm_dev_free() to free a specific
drm_device crreated by amdgpu_xcp_drm_dev_alloc(), which will be used
to do error recovery.

Signed-off-by: Jiang Liu <gerry@linux.alibaba.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c     | 11 +++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.h     |  1 +
 drivers/gpu/drm/amd/amdxcp/amdgpu_xcp_drv.c | 70 +++++++++++++++++----
 drivers/gpu/drm/amd/amdxcp/amdgpu_xcp_drv.h |  1 +
 4 files changed, 70 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
index e209b5e101df..401fbaa0b6b8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
@@ -359,6 +359,8 @@ int amdgpu_xcp_dev_register(struct amdgpu_device *adev,
 		ret = drm_dev_register(adev->xcp_mgr->xcp[i].ddev, ent->driver_data);
 		if (ret)
 			return ret;
+
+		adev->xcp_mgr->xcp[i].registered = true;
 	}
 
 	return 0;
@@ -376,12 +378,19 @@ void amdgpu_xcp_dev_unplug(struct amdgpu_device *adev)
 		if (!adev->xcp_mgr->xcp[i].ddev)
 			break;
 
+		// Restore and free the original drm_device.
 		p_ddev = adev->xcp_mgr->xcp[i].ddev;
-		drm_dev_unplug(p_ddev);
+		if (adev->xcp_mgr->xcp[i].registered) {
+			drm_dev_unplug(p_ddev);
+			adev->xcp_mgr->xcp[i].registered = false;
+		}
 		p_ddev->render->dev = adev->xcp_mgr->xcp[i].rdev;
 		p_ddev->primary->dev = adev->xcp_mgr->xcp[i].pdev;
 		p_ddev->driver =  adev->xcp_mgr->xcp[i].driver;
 		p_ddev->vma_offset_manager = adev->xcp_mgr->xcp[i].vma_offset_manager;
+		amdgpu_xcp_drm_dev_free(p_ddev);
+
+		adev->xcp_mgr->xcp[i].ddev = NULL;
 	}
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.h
index b63f53242c57..cd06a4a232be 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.h
@@ -101,6 +101,7 @@ struct amdgpu_xcp {
 	uint8_t id;
 	uint8_t mem_id;
 	bool valid;
+	bool registered;
 	atomic_t	ref_cnt;
 	struct drm_device *ddev;
 	struct drm_device *rdev;
diff --git a/drivers/gpu/drm/amd/amdxcp/amdgpu_xcp_drv.c b/drivers/gpu/drm/amd/amdxcp/amdgpu_xcp_drv.c
index faed84172dd4..9058d71b4756 100644
--- a/drivers/gpu/drm/amd/amdxcp/amdgpu_xcp_drv.c
+++ b/drivers/gpu/drm/amd/amdxcp/amdgpu_xcp_drv.c
@@ -45,18 +45,26 @@ static const struct drm_driver amdgpu_xcp_driver = {
 
 static int8_t pdev_num;
 static struct xcp_device *xcp_dev[MAX_XCP_PLATFORM_DEVICE];
+static struct mutex xcp_mutex;
 
 int amdgpu_xcp_drm_dev_alloc(struct drm_device **ddev)
 {
 	struct platform_device *pdev;
 	struct xcp_device *pxcp_dev;
 	char dev_name[20];
-	int ret;
+	int ret, index;
 
+	mutex_lock(&xcp_mutex);
+	ret = -ENODEV;
 	if (pdev_num >= MAX_XCP_PLATFORM_DEVICE)
-		return -ENODEV;
+		goto out_unlock;
 
-	snprintf(dev_name, sizeof(dev_name), "amdgpu_xcp_%d", pdev_num);
+	for (index = 0; index < MAX_XCP_PLATFORM_DEVICE; index++) {
+		if (!xcp_dev[index])
+			break;
+	}
+
+	snprintf(dev_name, sizeof(dev_name), "amdgpu_xcp_%d", index);
 	pdev = platform_device_register_simple(dev_name, -1, NULL, 0);
 	if (IS_ERR(pdev))
 		return PTR_ERR(pdev);
@@ -72,10 +80,11 @@ int amdgpu_xcp_drm_dev_alloc(struct drm_device **ddev)
 		goto out_devres;
 	}
 
-	xcp_dev[pdev_num] = pxcp_dev;
-	xcp_dev[pdev_num]->pdev = pdev;
+	xcp_dev[index] = pxcp_dev;
+	xcp_dev[index]->pdev = pdev;
 	*ddev = &pxcp_dev->drm;
 	pdev_num++;
+	mutex_unlock(&xcp_mutex);
 
 	return 0;
 
@@ -83,21 +92,58 @@ int amdgpu_xcp_drm_dev_alloc(struct drm_device **ddev)
 	devres_release_group(&pdev->dev, NULL);
 out_unregister:
 	platform_device_unregister(pdev);
+out_unlock:
+	mutex_unlock(&xcp_mutex);
 
 	return ret;
 }
 EXPORT_SYMBOL(amdgpu_xcp_drm_dev_alloc);
 
-void amdgpu_xcp_drv_release(void)
+static void amdgpu_xcp_drm_dev_destroy(int index)
+{
+	struct platform_device *pdev;
+
+	pdev = xcp_dev[index]->pdev;
+	devres_release_group(&pdev->dev, NULL);
+	platform_device_unregister(pdev);
+	xcp_dev[index] = NULL;
+	pdev_num--;
+}
+
+void amdgpu_xcp_drm_dev_free(struct drm_device *ddev)
 {
-	for (--pdev_num; pdev_num >= 0; --pdev_num) {
-		struct platform_device *pdev = xcp_dev[pdev_num]->pdev;
+	int index;
+	struct xcp_device *pxcp_dev;
+
+	if (ddev == NULL)
+		return;
 
-		devres_release_group(&pdev->dev, NULL);
-		platform_device_unregister(pdev);
-		xcp_dev[pdev_num] = NULL;
+	pxcp_dev = container_of(ddev, struct xcp_device, drm);
+
+	mutex_lock(&xcp_mutex);
+	for (index = 0; index < MAX_XCP_PLATFORM_DEVICE; index++) {
+		if (xcp_dev[index] == pxcp_dev) {
+			amdgpu_xcp_drm_dev_destroy(index);
+			break;
+		}
+	}
+	mutex_unlock(&xcp_mutex);
+}
+EXPORT_SYMBOL(amdgpu_xcp_drm_dev_free);
+
+void amdgpu_xcp_drv_release(void)
+{
+	int index;
+
+	mutex_lock(&xcp_mutex);
+	for (index = 0; index < MAX_XCP_PLATFORM_DEVICE; index++) {
+		if (xcp_dev[index]) {
+			WARN_ON(xcp_dev[index]);
+			amdgpu_xcp_drm_dev_destroy(index);
+		}
 	}
-	pdev_num = 0;
+	WARN_ON(pdev_num != 0);
+	mutex_unlock(&xcp_mutex);
 }
 EXPORT_SYMBOL(amdgpu_xcp_drv_release);
 
diff --git a/drivers/gpu/drm/amd/amdxcp/amdgpu_xcp_drv.h b/drivers/gpu/drm/amd/amdxcp/amdgpu_xcp_drv.h
index c1c4b679bf95..580a1602c8e3 100644
--- a/drivers/gpu/drm/amd/amdxcp/amdgpu_xcp_drv.h
+++ b/drivers/gpu/drm/amd/amdxcp/amdgpu_xcp_drv.h
@@ -25,5 +25,6 @@
 #define _AMDGPU_XCP_DRV_H_
 
 int amdgpu_xcp_drm_dev_alloc(struct drm_device **ddev);
+void amdgpu_xcp_drm_dev_free(struct drm_device *ddev);
 void amdgpu_xcp_drv_release(void);
 #endif /* _AMDGPU_XCP_DRV_H_ */
-- 
2.43.5

