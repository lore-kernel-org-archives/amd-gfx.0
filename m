Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E5FDC43219
	for <amd-gfx@archiver.kernel.org>; Tue, 19 Apr 2022 14:19:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CFB5D10E071;
	Tue, 19 Apr 2022 14:19:19 +0000 (UTC)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7664710E071
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 Apr 2022 14:19:18 +0000 (UTC)
Received: by mail-wm1-x329.google.com with SMTP id
 c190-20020a1c35c7000000b0038e37907b5bso1696432wma.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 Apr 2022 07:19:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=F+pH2zT7W28iAkuqTPBk0WARhplrWx9IjhlHBs1/6Xw=;
 b=lHE2apoOthQ8W9CSE8lEHqH5xQhZKMb+Jy/EwZe0VNrhhc2pTBCpY84dvhKQzfu02P
 /WB72LflV7X6nglgG/EvsaZOWcCp7t/SY6uKyTa7FVzUrnZbMTC2xAgoHqsD6KEAoFN6
 iRvgagRcNVRdVqzvjkcEcPNoUm7BCzUmxGJHTRt59CVYb+oaxOV0Vj7Q/wCDHy9xHF7T
 /BNThcGsvY3nHgLN/MbeB+bbXDBcZLNnRyfTNtm73rI9+8LVvUta8DVVLv+udzp74zi+
 rgK5ZQlIC2jCQ66GkSnVZwlDGvxSSXmK2KLJNZFQwiJE4ev6VzF5n6/HHwg0pnLdJ4Eg
 KZjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=F+pH2zT7W28iAkuqTPBk0WARhplrWx9IjhlHBs1/6Xw=;
 b=FAU4kuoTLTeqlh4eROkqtJSANPCr1FNaQylfBnsye4194KdetxCFj2ienO49LBnhdM
 2WPCd2kOpAB/K37zQxIyVaEzyvHzpJ1K7FCOJtGczmhYUSJNpFVPHQJWEVfPS76eUN1f
 yMQLXTlAZqgsU1SbpHwRbyIfT5dTn90mVTUYIEDjERi403ehPl3irdP4/mM/5k7VE0cb
 EyN3TwPb16HQoZCmBfC7ZzZQ0LuVoiWyx3AN8bVVgMz6oyExUS67pLgJo4v+nbmlK8kS
 RnNMwxsqRD9cWQydOIw2Iz6UDHablcBIC63Ma0RAix6KrB92dCDtOPvi+o8MQ3Jfc356
 65Nw==
X-Gm-Message-State: AOAM530yMxhbdSprP2Xf3Qjzwc2wIUMIZ3bmdN3p7eyOvvCYASJrqO/y
 nNCzMpNzy+OoV+OT7KX0dJA=
X-Google-Smtp-Source: ABdhPJxpIReYSiSTIiGXLg4cyg/SfVFmpuCJmcTb9gxvKYv4lumpX2sT+FVNGMmeamAoxeXjT8hq1g==
X-Received: by 2002:a7b:cd97:0:b0:38f:f785:ff8 with SMTP id
 y23-20020a7bcd97000000b0038ff7850ff8mr19796000wmj.44.1650377956945; 
 Tue, 19 Apr 2022 07:19:16 -0700 (PDT)
Received: from able.fritz.box (p57b0b9e1.dip0.t-ipconnect.de. [87.176.185.225])
 by smtp.gmail.com with ESMTPSA id
 c18-20020a7bc852000000b0038ebf5f191esm22647443wml.45.2022.04.19.07.19.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Apr 2022 07:19:16 -0700 (PDT)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: Ryan.Taylor@amd.com,
	amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/2] drm/amdgpu: remove pointless ttm_eu usage from vkms
Date: Tue, 19 Apr 2022 16:19:14 +0200
Message-Id: <20220419141915.122157-1-christian.koenig@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
Cc: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

We just need to reserve the BO here, no need for using ttm_eu.

Signed-off-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c | 32 +++++++++++++-----------
 1 file changed, 17 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c
index 5224d9a39737..576849e95296 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c
@@ -302,9 +302,6 @@ static int amdgpu_vkms_prepare_fb(struct drm_plane *plane,
 	struct drm_gem_object *obj;
 	struct amdgpu_device *adev;
 	struct amdgpu_bo *rbo;
-	struct list_head list;
-	struct ttm_validate_buffer tv;
-	struct ww_acquire_ctx ticket;
 	uint32_t domain;
 	int r;
 
@@ -316,18 +313,19 @@ static int amdgpu_vkms_prepare_fb(struct drm_plane *plane,
 	obj = new_state->fb->obj[0];
 	rbo = gem_to_amdgpu_bo(obj);
 	adev = amdgpu_ttm_adev(rbo->tbo.bdev);
-	INIT_LIST_HEAD(&list);
 
-	tv.bo = &rbo->tbo;
-	tv.num_shared = 1;
-	list_add(&tv.head, &list);
-
-	r = ttm_eu_reserve_buffers(&ticket, &list, false, NULL);
+	r = amdgpu_bo_reserve(rbo, true);
 	if (r) {
 		dev_err(adev->dev, "fail to reserve bo (%d)\n", r);
 		return r;
 	}
 
+	r = dma_resv_reserve_fences(rbo->tbo.base.resv, 1);
+	if (r) {
+		dev_err(adev->dev, "allocating fence slot failed (%d)\n", r);
+		goto error_unlock;
+	}
+
 	if (plane->type != DRM_PLANE_TYPE_CURSOR)
 		domain = amdgpu_display_supported_domains(adev, rbo->flags);
 	else
@@ -337,25 +335,29 @@ static int amdgpu_vkms_prepare_fb(struct drm_plane *plane,
 	if (unlikely(r != 0)) {
 		if (r != -ERESTARTSYS)
 			DRM_ERROR("Failed to pin framebuffer with error %d\n", r);
-		ttm_eu_backoff_reservation(&ticket, &list);
-		return r;
+		goto error_unlock;
 	}
 
 	r = amdgpu_ttm_alloc_gart(&rbo->tbo);
 	if (unlikely(r != 0)) {
-		amdgpu_bo_unpin(rbo);
-		ttm_eu_backoff_reservation(&ticket, &list);
 		DRM_ERROR("%p bind failed\n", rbo);
-		return r;
+		goto error_unpin;
 	}
 
-	ttm_eu_backoff_reservation(&ticket, &list);
+	amdgpu_bo_unreserve(rbo);
 
 	afb->address = amdgpu_bo_gpu_offset(rbo);
 
 	amdgpu_bo_ref(rbo);
 
 	return 0;
+
+error_unpin:
+	amdgpu_bo_unpin(rbo);
+
+error_unlock:
+	amdgpu_bo_unreserve(rbo);
+	return r;
 }
 
 static void amdgpu_vkms_cleanup_fb(struct drm_plane *plane,
-- 
2.25.1

