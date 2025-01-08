Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B89DE7719A
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Jan 2025 08:56:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 880C710E810;
	Wed,  8 Jan 2025 08:56:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="uCyxqd2J";
	dkim-atps=neutral
Received: from out30-132.freemail.mail.aliyun.com
 (out30-132.freemail.mail.aliyun.com [115.124.30.132])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6339B10E810
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Jan 2025 08:56:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1736326577; h=From:To:Subject:Date:Message-ID:MIME-Version;
 bh=zGxdda6aqVm0VWOH8XkHMWmB67lECVRnBof9u95pJQU=;
 b=uCyxqd2J8oy/Tb3aGprQXHPdkjdP2RMSVcit5WVMe735WAsvJ1Q+EZ3McjXcD+Q6LZO4O0LA+zOuQgFMEMa7nxbZVaMt8W5fROPxhbuoyVNe8y/SfAwbQbsW/AvQYpSTcCwXrXx43cnbw+6bhiQnu6ON/NDe0TE+xp1Y1Cme+DU=
Received: from i32d02263.sqa.eu95.tbsite.net(mailfrom:gerry@linux.alibaba.com
 fp:SMTPD_---0WNDU-wm_1736326575 cluster:ay36) by smtp.aliyun-inc.com;
 Wed, 08 Jan 2025 16:56:16 +0800
From: Jiang Liu <gerry@linux.alibaba.com>
To: alexander.deucher@amd.com, christian.koenig@amd.com, Xinhui.Pan@amd.com,
 airlied@gmail.com, simona@ffwll.ch, sunil.khatri@amd.com,
 lijo.lazar@amd.com, Hawking.Zhang@amd.com, mario.limonciello@amd.com,
 Jun.Ma2@amd.com, xiaogang.chen@amd.com, Kent.Russell@amd.com,
 shuox.liu@linux.alibaba.com, amd-gfx@lists.freedesktop.org
Cc: Jiang Liu <gerry@linux.alibaba.com>
Subject: [v3 2/6] drm/amdxcp: introduce new API amdgpu_xcp_drm_dev_free()
Date: Wed,  8 Jan 2025 16:56:00 +0800
Message-ID: <c46d4c3bead7f62439eca5110de8afe4783a7418.1736325561.git.gerry@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <cover.1736325561.git.gerry@linux.alibaba.com>
References: <cover.1736325561.git.gerry@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
 drivers/gpu/drm/amd/amdxcp/amdgpu_xcp_drv.c | 76 +++++++++++++++++----
 drivers/gpu/drm/amd/amdxcp/amdgpu_xcp_drv.h |  1 +
 2 files changed, 63 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdxcp/amdgpu_xcp_drv.c b/drivers/gpu/drm/amd/amdxcp/amdgpu_xcp_drv.c
index faed84172dd4..fc92b5fe1040 100644
--- a/drivers/gpu/drm/amd/amdxcp/amdgpu_xcp_drv.c
+++ b/drivers/gpu/drm/amd/amdxcp/amdgpu_xcp_drv.c
@@ -45,21 +45,32 @@ static const struct drm_driver amdgpu_xcp_driver = {
 
 static int8_t pdev_num;
 static struct xcp_device *xcp_dev[MAX_XCP_PLATFORM_DEVICE];
+static DEFINE_MUTEX(xcp_mutex);
 
 int amdgpu_xcp_drm_dev_alloc(struct drm_device **ddev)
 {
 	struct platform_device *pdev;
 	struct xcp_device *pxcp_dev;
 	char dev_name[20];
-	int ret;
+	int ret, index;
 
-	if (pdev_num >= MAX_XCP_PLATFORM_DEVICE)
-		return -ENODEV;
+	mutex_lock(&xcp_mutex);
+	if (pdev_num >= MAX_XCP_PLATFORM_DEVICE) {
+		ret = -ENODEV;
+		goto out_unlock;
+	}
+
+	for (index = 0; index < MAX_XCP_PLATFORM_DEVICE; index++) {
+		if (!xcp_dev[index])
+			break;
+	}
 
-	snprintf(dev_name, sizeof(dev_name), "amdgpu_xcp_%d", pdev_num);
+	snprintf(dev_name, sizeof(dev_name), "amdgpu_xcp_%d", index);
 	pdev = platform_device_register_simple(dev_name, -1, NULL, 0);
-	if (IS_ERR(pdev))
-		return PTR_ERR(pdev);
+	if (IS_ERR(pdev)) {
+		ret = PTR_ERR(pdev);
+		goto out_unregister;
+	}
 
 	if (!devres_open_group(&pdev->dev, NULL, GFP_KERNEL)) {
 		ret = -ENOMEM;
@@ -72,10 +83,11 @@ int amdgpu_xcp_drm_dev_alloc(struct drm_device **ddev)
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
 
@@ -83,21 +95,57 @@ int amdgpu_xcp_drm_dev_alloc(struct drm_device **ddev)
 	devres_release_group(&pdev->dev, NULL);
 out_unregister:
 	platform_device_unregister(pdev);
+out_unlock:
+	mutex_unlock(&xcp_mutex);
 
 	return ret;
 }
 EXPORT_SYMBOL(amdgpu_xcp_drm_dev_alloc);
 
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
+{
+	int index;
+	struct xcp_device *pxcp_dev;
+
+	if (ddev == NULL)
+		return;
+
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
 void amdgpu_xcp_drv_release(void)
 {
-	for (--pdev_num; pdev_num >= 0; --pdev_num) {
-		struct platform_device *pdev = xcp_dev[pdev_num]->pdev;
+	int index;
 
-		devres_release_group(&pdev->dev, NULL);
-		platform_device_unregister(pdev);
-		xcp_dev[pdev_num] = NULL;
+	mutex_lock(&xcp_mutex);
+	for (index = 0; index < MAX_XCP_PLATFORM_DEVICE; index++) {
+		if (xcp_dev[index]) {
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

