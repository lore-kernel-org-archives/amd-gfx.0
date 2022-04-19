Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5EE8C4332F
	for <amd-gfx@archiver.kernel.org>; Tue, 19 Apr 2022 14:19:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 52E8810EEA4;
	Tue, 19 Apr 2022 14:19:20 +0000 (UTC)
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com
 [IPv6:2a00:1450:4864:20::42e])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5EF0510E071
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 Apr 2022 14:19:19 +0000 (UTC)
Received: by mail-wr1-x42e.google.com with SMTP id k22so22653119wrd.2
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 Apr 2022 07:19:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=u1mrF0K5dd6Mm66iwdOr8SmZjFp46VqRoyOurNzP+aA=;
 b=QGby3jBfaMFpqV1k/6Zxyo52s43xnuRql4EwRTufJ87lFHs1gNodkmYqAG91xLQ8EH
 IjctD3HwmNN3r7LmCGzgJsLRE7ERPyEHsWG+8qtKwxhW4hUD8lj/Pv7MNeKeAtWivGkV
 GHmmHb49bdba5wAK+8EjOJFXCVa+l0wIu06D0ghR/x8WCmRLkMGsLCYQnTAedVr9Ba/3
 Hww7X1mZJMBMQkb7uAg4fgaOMM9bXjH/o9JeuaDWplsLTeB64Z4QQy9V/C0jYcJ2qUZ4
 Esv10oa64Ic81eMd5m6bDPsILSb+hSSCE2zXTIfTUgmzpUsnTonJYJWaAtLPtF33OTxY
 8A0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=u1mrF0K5dd6Mm66iwdOr8SmZjFp46VqRoyOurNzP+aA=;
 b=YolzWSLKLFQzN4L/SIOnPqnsc8AfI0S3tBnslQKBAPtj4HpGBogVjC512FRBjMP6v0
 h7gBRwXpSNVqUnwaANIYKet/F9eZ6HlUwh0wjWPD5mOQ8NhYKpV9UTcglyGoaHkrW21n
 LDnGA6MxUfhmapkzM3MvBiLjvvKeamLap+rlsyhlTXZTNKBBDWUlIHSTLqrPCcgkGz4R
 l0Y+pWAAQJxKAiw5YjYNPQ/ZZao9JsSV3w9BrV4lR4FjbvCT+gO+G9fPqM+TB5B8zLQy
 fJIW6BP85Gam6eVNgZnkehlBV3nAsUpdFmnlXLFWbmjPF+9xm1Zrdv81/31xEkZTk3ub
 dWAQ==
X-Gm-Message-State: AOAM533rLOEeEIiUKcgbIKhhdJrmV+Fk4TWH8/G34x80bg1jIJIEGO4D
 Zx5wz5gFvNPW+1yd6FW9GSQ=
X-Google-Smtp-Source: ABdhPJxepslenEFS68t0/MVre/2u+xb/XoJpfje81hg6C6aFU3YAiUDV9IcMoCxyY4v2aH3e2CdD6g==
X-Received: by 2002:a5d:60cb:0:b0:20a:a7fd:3a81 with SMTP id
 x11-20020a5d60cb000000b0020aa7fd3a81mr2131538wrt.681.1650377957959; 
 Tue, 19 Apr 2022 07:19:17 -0700 (PDT)
Received: from able.fritz.box (p57b0b9e1.dip0.t-ipconnect.de. [87.176.185.225])
 by smtp.gmail.com with ESMTPSA id
 c18-20020a7bc852000000b0038ebf5f191esm22647443wml.45.2022.04.19.07.19.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Apr 2022 07:19:17 -0700 (PDT)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: Ryan.Taylor@amd.com,
	amd-gfx@lists.freedesktop.org
Subject: [PATCH 2/2] drm/amdgpu: remove pointless ttm_eu usage from DM
Date: Tue, 19 Apr 2022 16:19:15 +0200
Message-Id: <20220419141915.122157-2-christian.koenig@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220419141915.122157-1-christian.koenig@amd.com>
References: <20220419141915.122157-1-christian.koenig@amd.com>
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
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 32 ++++++++++---------
 1 file changed, 17 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 73423b805b54..91e9922b95b3 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -7583,9 +7583,6 @@ static int dm_plane_helper_prepare_fb(struct drm_plane *plane,
 	struct amdgpu_device *adev;
 	struct amdgpu_bo *rbo;
 	struct dm_plane_state *dm_plane_state_new, *dm_plane_state_old;
-	struct list_head list;
-	struct ttm_validate_buffer tv;
-	struct ww_acquire_ctx ticket;
 	uint32_t domain;
 	int r;
 
@@ -7598,18 +7595,19 @@ static int dm_plane_helper_prepare_fb(struct drm_plane *plane,
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
+		dev_err(adev->dev, "reserving fence slot failed (%d)\n", r);
+		goto error_unlock;
+	}
+
 	if (plane->type != DRM_PLANE_TYPE_CURSOR)
 		domain = amdgpu_display_supported_domains(adev, rbo->flags);
 	else
@@ -7619,19 +7617,16 @@ static int dm_plane_helper_prepare_fb(struct drm_plane *plane,
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
 
@@ -7663,6 +7658,13 @@ static int dm_plane_helper_prepare_fb(struct drm_plane *plane,
 	}
 
 	return 0;
+
+error_unpin:
+	amdgpu_bo_unpin(rbo);
+
+error_unlock:
+	amdgpu_bo_unreserve(rbo);
+	return r;
 }
 
 static void dm_plane_helper_cleanup_fb(struct drm_plane *plane,
-- 
2.25.1

