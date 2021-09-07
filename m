Return-Path: <SRS0=wMah=N5=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD440C433EF
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Sep 2021 08:14:54 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 91A2A60F21
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Sep 2021 08:14:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 91A2A60F21
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EC15189DA5;
	Tue,  7 Sep 2021 08:14:52 +0000 (UTC)
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com
 [IPv6:2a00:1450:4864:20::429])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9B73C89D6C
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 Sep 2021 08:14:51 +0000 (UTC)
Received: by mail-wr1-x429.google.com with SMTP id n5so13106735wro.12
 for <amd-gfx@lists.freedesktop.org>; Tue, 07 Sep 2021 01:14:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=/KLTZARY1bDCabo4TbOkP54eh1lcRTdFI6yraHiRo4s=;
 b=naKwMaiUmgryW5eENXHQZC0a5crblAadzbNPwvy06Kv9k0zlXUwETNwAd2i3ZBNDSv
 zuXrhaWo+wJQAtQTdrQEZiohQJ4lIf4Njk/aGAMT7pBwFGd2fooD2M2kNQ6LjryspxFI
 7UwUaPdJMnu8PXHsq3AnHqhiO9P8iPh2sdPZ+B8Lb4uD4kKOlobqrjJVsVeiCyO2iHVE
 y2/2urBMt5puhAS/Yfc/2tFA3sHWHxOjC4/8D9y4RaJ16qB+fN13Ek3/zwPQGgKYnugx
 +3WxwtCBSKzbYEmthZrOW5rnsKdBmZL0Jlq3Xf8XMN6LpK5gxnC8DF2/5e2RTmPDXcfE
 ECfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=/KLTZARY1bDCabo4TbOkP54eh1lcRTdFI6yraHiRo4s=;
 b=Sci0DPuDSnqkrxuTS6KxvaRo7xguhPz0/pm2M2uXxuXdGgdDt/61hyrxeFw0Wz7BnN
 apz0IA481MxgZhhE+1O4g/zVCmygik9SbYvdQtdzf0Ni7rcd2Fvsmi6CaUaJscCEqg2c
 vd7oDJLjqh5wJSV/nrtooRLGrJQKVASwJyi6a5jgANZ2Qz9ja80v1Bnh/q5j4ndXXBFC
 qjGmiFbIryrpEl/iS8RTvHiqgUGAwo13f6UUTdRlR6Ue1LUclEBsy9mthcvCXBB39SR/
 Qs4LYfwXzh9EYE2V0MvHOacZUHqNpswfn2decLSewbopZUKcuhyDbjiBaUiV5mly95uK
 VR9Q==
X-Gm-Message-State: AOAM532wEwsE8GDDA49X94LNd+0+TZf18iLt57VZNTixjAeMxOejxHwc
 l5lBazySiFSLtcD8jYOArfQ=
X-Google-Smtp-Source: ABdhPJwDioGi2Zb5Ac4WUcBDje23qSAS7QnbbhPUGtNcu1AbPMY3W9tiMc7gavC/zRA1aE9kxWedDw==
X-Received: by 2002:adf:fd88:: with SMTP id d8mr1117775wrr.13.1631002490193;
 Tue, 07 Sep 2021 01:14:50 -0700 (PDT)
Received: from abel.fritz.box (p5b0ea1b5.dip0.t-ipconnect.de. [91.14.161.181])
 by smtp.gmail.com with ESMTPSA id
 z19sm2012398wma.0.2021.09.07.01.14.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Sep 2021 01:14:49 -0700 (PDT)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: michel@daenzer.net,
	amd-gfx@lists.freedesktop.org
Subject: [PATCH 2/2] drm/amdgpu: remove unused amdgpu_bo_validate
Date: Tue,  7 Sep 2021 10:14:47 +0200
Message-Id: <20210907081447.182532-2-christian.koenig@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210907081447.182532-1-christian.koenig@amd.com>
References: <20210907081447.182532-1-christian.koenig@amd.com>
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Just drop some dead code.

Signed-off-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 34 ----------------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.h |  1 -
 2 files changed, 35 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
index 22a1344082d3..e2e8f0e1eda9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
@@ -694,40 +694,6 @@ int amdgpu_bo_create_vm(struct amdgpu_device *adev,
 	return r;
 }
 
-/**
- * amdgpu_bo_validate - validate an &amdgpu_bo buffer object
- * @bo: pointer to the buffer object
- *
- * Sets placement according to domain; and changes placement and caching
- * policy of the buffer object according to the placement.
- * This is used for validating shadow bos.  It calls ttm_bo_validate() to
- * make sure the buffer is resident where it needs to be.
- *
- * Returns:
- * 0 for success or a negative error code on failure.
- */
-int amdgpu_bo_validate(struct amdgpu_bo *bo)
-{
-	struct ttm_operation_ctx ctx = { false, false };
-	uint32_t domain;
-	int r;
-
-	if (bo->tbo.pin_count)
-		return 0;
-
-	domain = bo->preferred_domains;
-
-retry:
-	amdgpu_bo_placement_from_domain(bo, domain);
-	r = ttm_bo_validate(&bo->tbo, &bo->placement, &ctx);
-	if (unlikely(r == -ENOMEM) && domain != bo->allowed_domains) {
-		domain = bo->allowed_domains;
-		goto retry;
-	}
-
-	return r;
-}
-
 /**
  * amdgpu_bo_add_to_shadow_list - add a BO to the shadow list
  *
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
index 38c834d0f930..0d7771e274ff 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
@@ -328,7 +328,6 @@ int amdgpu_bo_sync_wait_resv(struct amdgpu_device *adev, struct dma_resv *resv,
 int amdgpu_bo_sync_wait(struct amdgpu_bo *bo, void *owner, bool intr);
 u64 amdgpu_bo_gpu_offset(struct amdgpu_bo *bo);
 u64 amdgpu_bo_gpu_offset_no_check(struct amdgpu_bo *bo);
-int amdgpu_bo_validate(struct amdgpu_bo *bo);
 void amdgpu_bo_get_memory(struct amdgpu_bo *bo, uint64_t *vram_mem,
 				uint64_t *gtt_mem, uint64_t *cpu_mem);
 void amdgpu_bo_add_to_shadow_list(struct amdgpu_bo_vm *vmbo);
-- 
2.25.1

