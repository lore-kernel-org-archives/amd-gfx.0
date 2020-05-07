Return-Path: <SRS0=+Cdj=6V=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A761C38A24
	for <amd-gfx@archiver.kernel.org>; Thu,  7 May 2020 13:35:25 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1EC0A20643
	for <amd-gfx@archiver.kernel.org>; Thu,  7 May 2020 13:35:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1EC0A20643
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivo.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 60CDC6E991;
	Thu,  7 May 2020 13:35:21 +0000 (UTC)
Received: from mail-m17613.qiye.163.com (mail-m17613.qiye.163.com
 [59.111.176.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 316666E0B6
 for <amd-gfx@lists.freedesktop.org>; Thu,  7 May 2020 09:13:27 +0000 (UTC)
Received: from ubuntu.localdomain (unknown [157.0.31.122])
 by mail-m17613.qiye.163.com (Hmail) with ESMTPA id EC5C5482B05;
 Thu,  7 May 2020 17:13:20 +0800 (CST)
From: Bernard Zhao <bernard@vivo.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
 David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
 Tom St Denis <tom.stdenis@amd.com>, Sam Ravnborg <sam@ravnborg.org>,
 Ori Messinger <Ori.Messinger@amd.com>, Bernard Zhao <bernard@vivo.com>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH v2] drm/amd/amdgpu: cleanup coding style a bit
Date: Thu,  7 May 2020 02:13:05 -0700
Message-Id: <20200507091311.10898-1-bernard@vivo.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZT1VPTklLS0tKT0pKT0hDWVdZKFlBSE
 83V1ktWUFJV1kJDhceCFlBWTU0KTY6NyQpLjc#WQY+
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Ojo6HQw*KDg9Pz88Pws#KgEC
 NT4KCjFVSlVKTkNDQ09JQ0tPSUJDVTMWGhIXVRkeCRUaCR87DRINFFUYFBZFWVdZEgtZQVlKTkxV
 S1VISlVKSUlZV1kIAVlBT05ITDcG
X-HM-Tid: 0a71ee69284893bakuwsec5c5482b05
X-Mailman-Approved-At: Thu, 07 May 2020 13:35:20 +0000
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
Cc: opensource.kernel@vivo.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

There is DEVICE_ATTR mechanism in separate attribute define.
So this change is to use attr array, also use
sysfs_create_files in init function & sysfs_remove_files in
fini function.
This maybe make the code a bit readable.

Signed-off-by: Bernard Zhao <bernard@vivo.com>

Changes since V1:
*Use DEVICE_ATTR mechanism

Link for V1:
*https://lore.kernel.org/patchwork/patch/1228076/
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c | 43 ++++++--------------
 1 file changed, 13 insertions(+), 30 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
index 82a3299e53c0..57bbc70662ff 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
@@ -148,6 +148,15 @@ static DEVICE_ATTR(mem_info_vis_vram_used, S_IRUGO,
 static DEVICE_ATTR(mem_info_vram_vendor, S_IRUGO,
 		   amdgpu_mem_info_vram_vendor, NULL);
 
+static struct attribute *amdgpu_vram_mgr_attributes[] = {
+	&dev_attr_mem_info_vram_total.attr,
+	&dev_attr_mem_info_vis_vram_total.attr,
+	&dev_attr_mem_info_vram_used.attr,
+	&dev_attr_mem_info_vis_vram_used.attr,
+	&dev_attr_mem_info_vram_vendor.attr,
+	NULL
+};
+
 /**
  * amdgpu_vram_mgr_init - init VRAM manager and DRM MM
  *
@@ -172,31 +181,9 @@ static int amdgpu_vram_mgr_init(struct ttm_mem_type_manager *man,
 	man->priv = mgr;
 
 	/* Add the two VRAM-related sysfs files */
-	ret = device_create_file(adev->dev, &dev_attr_mem_info_vram_total);
-	if (ret) {
-		DRM_ERROR("Failed to create device file mem_info_vram_total\n");
-		return ret;
-	}
-	ret = device_create_file(adev->dev, &dev_attr_mem_info_vis_vram_total);
-	if (ret) {
-		DRM_ERROR("Failed to create device file mem_info_vis_vram_total\n");
-		return ret;
-	}
-	ret = device_create_file(adev->dev, &dev_attr_mem_info_vram_used);
-	if (ret) {
-		DRM_ERROR("Failed to create device file mem_info_vram_used\n");
-		return ret;
-	}
-	ret = device_create_file(adev->dev, &dev_attr_mem_info_vis_vram_used);
-	if (ret) {
-		DRM_ERROR("Failed to create device file mem_info_vis_vram_used\n");
-		return ret;
-	}
-	ret = device_create_file(adev->dev, &dev_attr_mem_info_vram_vendor);
-	if (ret) {
-		DRM_ERROR("Failed to create device file mem_info_vram_vendor\n");
-		return ret;
-	}
+	ret = sysfs_create_files(&adev->dev->kobj, amdgpu_vram_mgr_attributes);
+	if (ret)
+		DRM_ERROR("Failed to register sysfs\n");
 
 	return 0;
 }
@@ -219,11 +206,7 @@ static int amdgpu_vram_mgr_fini(struct ttm_mem_type_manager *man)
 	spin_unlock(&mgr->lock);
 	kfree(mgr);
 	man->priv = NULL;
-	device_remove_file(adev->dev, &dev_attr_mem_info_vram_total);
-	device_remove_file(adev->dev, &dev_attr_mem_info_vis_vram_total);
-	device_remove_file(adev->dev, &dev_attr_mem_info_vram_used);
-	device_remove_file(adev->dev, &dev_attr_mem_info_vis_vram_used);
-	device_remove_file(adev->dev, &dev_attr_mem_info_vram_vendor);
+	sysfs_remove_files(&adev->dev->kobj, amdgpu_vram_mgr_attributes);
 	return 0;
 }
 
-- 
2.26.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
