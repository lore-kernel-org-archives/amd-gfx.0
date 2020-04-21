Return-Path: <SRS0=PX0W=6F=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AE66C54FCC
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Apr 2020 13:28:30 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7BABD2087E
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Apr 2020 13:28:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7BABD2087E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivo.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6E46F6E95B;
	Tue, 21 Apr 2020 13:28:23 +0000 (UTC)
Received: from m176115.mail.qiye.163.com (m176115.mail.qiye.163.com
 [59.111.176.115])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F2E9A6E2DF
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Apr 2020 11:17:27 +0000 (UTC)
Received: from ubuntu.localdomain (unknown [157.0.31.122])
 by m176115.mail.qiye.163.com (Hmail) with ESMTPA id 78102664787;
 Tue, 21 Apr 2020 19:17:24 +0800 (CST)
From: Bernard Zhao <bernard@vivo.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
 David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
 Tom St Denis <tom.stdenis@amd.com>, Ori Messinger <Ori.Messinger@amd.com>,
 Sam Ravnborg <sam@ravnborg.org>, Bernard Zhao <bernard@vivo.com>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH] amdgpu: fixes memleak issue when init failed
Date: Tue, 21 Apr 2020 04:17:13 -0700
Message-Id: <20200421111715.1231-1-bernard@vivo.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZT1VJTklCQkJMQ0lOTUlJTVlXWShZQU
 hPN1dZLVlBSVdZCQ4XHghZQVk1NCk2OjckKS43PlkG
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Pio6HAw5KDg1PAMQTE43MSFK
 SSIaCgJVSlVKTkNMT01MQ09PQ0tOVTMWGhIXVRkeCRUaCR87DRINFFUYFBZFWVdZEgtZQVlKTkxV
 S1VISlVKSUlZV1kIAVlBSE1ISzcG
X-HM-Tid: 0a719c74fc629373kuws78102664787
X-Mailman-Approved-At: Tue, 21 Apr 2020 13:28:21 +0000
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

VRAM manager and DRM MM when init failed, there is no operaction
to free kzalloc memory & remove device file.
This will lead to memleak & cause stability issue.

Signed-off-by: Bernard Zhao <bernard@vivo.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c | 24 ++++++++++++++++----
 1 file changed, 19 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
index 82a3299e53c0..4c5fb153e6b4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
@@ -175,30 +175,44 @@ static int amdgpu_vram_mgr_init(struct ttm_mem_type_manager *man,
 	ret = device_create_file(adev->dev, &dev_attr_mem_info_vram_total);
 	if (ret) {
 		DRM_ERROR("Failed to create device file mem_info_vram_total\n");
-		return ret;
+		goto VRAM_TOTAL_FAIL;
 	}
 	ret = device_create_file(adev->dev, &dev_attr_mem_info_vis_vram_total);
 	if (ret) {
 		DRM_ERROR("Failed to create device file mem_info_vis_vram_total\n");
-		return ret;
+		goto VIS_VRAM_TOTA_FAIL;
 	}
 	ret = device_create_file(adev->dev, &dev_attr_mem_info_vram_used);
 	if (ret) {
 		DRM_ERROR("Failed to create device file mem_info_vram_used\n");
-		return ret;
+		goto VRAM_USED_FAIL;
 	}
 	ret = device_create_file(adev->dev, &dev_attr_mem_info_vis_vram_used);
 	if (ret) {
 		DRM_ERROR("Failed to create device file mem_info_vis_vram_used\n");
-		return ret;
+		goto VIS_VRAM_USED_FAIL;
 	}
 	ret = device_create_file(adev->dev, &dev_attr_mem_info_vram_vendor);
 	if (ret) {
 		DRM_ERROR("Failed to create device file mem_info_vram_vendor\n");
-		return ret;
+		goto VRAM_VERDOR_FAIL;
 	}
 
 	return 0;
+
+VRAM_VERDOR_FAIL:
+	device_remove_file(adev->dev, &dev_attr_mem_info_vis_vram_used);
+VIS_VRAM_USED_FAIL:
+	device_remove_file(adev->dev, &dev_attr_mem_info_vram_used);
+RVAM_USED_FAIL:
+	device_remove_file(adev->dev, &dev_attr_mem_info_vis_vram_total);
+VIS_VRAM_TOTA_FAIL:
+	device_remove_file(adev->dev, &dev_attr_mem_info_vram_total);
+VRAM_TOTAL_FAIL:
+	kfree(mgr);
+	man->priv = NULL;
+
+	return ret;
 }
 
 /**
-- 
2.26.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
