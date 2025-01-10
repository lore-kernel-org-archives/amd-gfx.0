Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF194E7719D
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Jan 2025 02:08:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9D46E10E4C5;
	Fri, 10 Jan 2025 02:08:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="jD4W3Om8";
	dkim-atps=neutral
Received: from out30-97.freemail.mail.aliyun.com
 (out30-97.freemail.mail.aliyun.com [115.124.30.97])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 77FC910EF65
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Jan 2025 02:08:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1736474932; h=From:To:Subject:Date:Message-ID:MIME-Version;
 bh=phBsxFG4ruvg7vzKjxQama6irk3aOMNOnQZCDS5Co5w=;
 b=jD4W3Om8AlDz4XOCRDgqkKCR12mIXY5ZyyDPoTFVRrNtDlZKHGZAjUxSpmh1N/9LTR4YL5qvGw0wuBucDgyxIvJxqhAbAtrhMy4tapwiCSRkFTCnZ16rPgTOpxGPIMga/BoWPNumWO305xPfilpEAIb5xBwVD8JAKe5HycZpYvU=
Received: from i32d02263.sqa.eu95.tbsite.net(mailfrom:gerry@linux.alibaba.com
 fp:SMTPD_---0WNJ5WA8_1736474931 cluster:ay36) by smtp.aliyun-inc.com;
 Fri, 10 Jan 2025 10:08:51 +0800
From: Jiang Liu <gerry@linux.alibaba.com>
To: alexander.deucher@amd.com, christian.koenig@amd.com, Xinhui.Pan@amd.com,
 airlied@gmail.com, simona@ffwll.ch, sunil.khatri@amd.com,
 lijo.lazar@amd.com, Hawking.Zhang@amd.com, mario.limonciello@amd.com,
 xiaogang.chen@amd.com, Kent.Russell@amd.com, shuox.liu@linux.alibaba.com,
 amd-gfx@lists.freedesktop.org
Cc: Jiang Liu <gerry@linux.alibaba.com>
Subject: [v4 2/5] drm/amdxcp: introduce new API amdgpu_xcp_drm_dev_free()
Date: Fri, 10 Jan 2025 10:08:44 +0800
Message-ID: <79267ddb1b1b8d83e2ec170f4b0b578c705de4dd.1736474822.git.gerry@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <cover.1736474822.git.gerry@linux.alibaba.com>
References: <cover.1736474822.git.gerry@linux.alibaba.com>
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
 drivers/gpu/drm/amd/amdxcp/amdgpu_xcp_drv.c | 65 +++++++++++++++++----
 drivers/gpu/drm/amd/amdxcp/amdgpu_xcp_drv.h |  1 +
 2 files changed, 56 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdxcp/amdgpu_xcp_drv.c b/drivers/gpu/drm/amd/amdxcp/amdgpu_xcp_drv.c
index faed84172dd4..0473fe0479d9 100644
--- a/drivers/gpu/drm/amd/amdxcp/amdgpu_xcp_drv.c
+++ b/drivers/gpu/drm/amd/amdxcp/amdgpu_xcp_drv.c
@@ -45,18 +45,26 @@ static const struct drm_driver amdgpu_xcp_driver = {
 
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
+
+	guard(mutex)(&xcp_mutex);
 
 	if (pdev_num >= MAX_XCP_PLATFORM_DEVICE)
 		return -ENODEV;
 
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
@@ -72,8 +80,8 @@ int amdgpu_xcp_drm_dev_alloc(struct drm_device **ddev)
 		goto out_devres;
 	}
 
-	xcp_dev[pdev_num] = pxcp_dev;
-	xcp_dev[pdev_num]->pdev = pdev;
+	xcp_dev[index] = pxcp_dev;
+	xcp_dev[index]->pdev = pdev;
 	*ddev = &pxcp_dev->drm;
 	pdev_num++;
 
@@ -88,16 +96,53 @@ int amdgpu_xcp_drm_dev_alloc(struct drm_device **ddev)
 }
 EXPORT_SYMBOL(amdgpu_xcp_drm_dev_alloc);
 
+static void __amdgpu_xcp_drm_dev_free(int index)
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
+	guard(mutex)(&xcp_mutex);
+	WARN_ON(!pdev_num);
+
+	pxcp_dev = container_of(ddev, struct xcp_device, drm);
+	for (index = 0; index < MAX_XCP_PLATFORM_DEVICE; index++) {
+		if (xcp_dev[index] == pxcp_dev) {
+			__amdgpu_xcp_drm_dev_free(index);
+			break;
+		}
+	}
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
+	guard(mutex)(&xcp_mutex);
+
+	for (index = 0; index < MAX_XCP_PLATFORM_DEVICE; index++) {
+		if (xcp_dev[index]) {
+			__amdgpu_xcp_drm_dev_free(index);
+			if (!pdev_num)
+				break;
+		}
 	}
-	pdev_num = 0;
+
+	WARN_ON(pdev_num != 0);
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

