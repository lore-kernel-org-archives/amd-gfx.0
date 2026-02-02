Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17582E7315F
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Feb 2026 12:51:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5BB3010E4C1;
	Mon,  2 Feb 2026 12:51:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="iDlOlHeI";
	dkim-atps=neutral
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com
 [209.85.128.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2BB8D10E4B8
 for <amd-gfx@lists.freedesktop.org>; Mon,  2 Feb 2026 12:51:56 +0000 (UTC)
Received: by mail-wm1-f53.google.com with SMTP id
 5b1f17b1804b1-4801d7c72a5so34876515e9.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 02 Feb 2026 04:51:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1770036715; x=1770641515; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=uTLdomELe4PSRSdauYzVhcfbG1awq323eDbpFvYymZg=;
 b=iDlOlHeIHq0lKnJ9xhAlUjx2iBOObPyI2Szwr1Mjv1nCf1f70mA18HMb3jFDJPWrJq
 lhfC2jybeYpSY9wqzfGPCtJ5N1JGu3uMM1wVWH+0RENd6Dx2seT16tEOE5PfBiTflVeB
 JWi/+53PZnnkYnLKG5n7gDzf1ibhCyEZupPHWPwIeYBKzNmRq/wHrKMgLqxbHP2BUo4l
 AtGMPkfR/MytjKeGPuJBRyqS3Rsl6rrhi4m5/qITIdXK8xgx/oumvkssjQyTp1/oHhgy
 oZVqG0pJAOBPPWdIoyGXTqqVFstFaDs3n161PubZjspEdnUga1V10VdkVAPxqw91Q7DZ
 8eLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770036715; x=1770641515;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=uTLdomELe4PSRSdauYzVhcfbG1awq323eDbpFvYymZg=;
 b=nDA6fp60ozNhq8J1oPix6BiZ8TW14b/a+3CKAVMamkL3oSBBfIDXvC5uqtURh50982
 aSb5tmiKAMnmqefluRCGLRKD6dsQtU19XQ0ycvXc8m0ULUbKRhORv/UvTe1kDQczCFnd
 rJCn/XhMTDhC9MBwXKsHkGo2j94rMjX6U8hCaaxSjQ8LFuGyZ+IzzaC3/1lZSOYWl0b/
 PMJphh3d7J1YiQVsojYygJm+s/4ZzZPNgmpR4DBFn4lQ6k6hEcLvucR66E6c2w6Q0C7T
 zO1XFH1un7fbD/cZIbYFbG9aAOtcZjGGuKkPxRBno9+jAhVawBfp4H0Id2FLwg6AdZhD
 77sA==
X-Forwarded-Encrypted: i=1;
 AJvYcCU4tHCsyoD18a3XbApserzLHwWs7P9SBu4tP/uUCRYDxCSC2n1z8/jP1U4dBTBUW7W+R+gKu+CW@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxJKDASNQnqoTnH0ynyQre0rAp+haBWRsm+ba25P0VseYMd4XHz
 E1qtrN/uSGxsFQ3qtxuGBealAVQh6tPIG+WNvn81ekq3sk+nvkVG64KymqgeK9r0
X-Gm-Gg: AZuq6aIlVowoR97SSbDMABDSDq3egtYhXTxU6I2nCCZHSDXaouYHgmBXsdLRdqH4SAB
 QLT1+Dklo47Ux6eRg3FgYWcqz4M28d5YeA+HgixgQsFs/h31TdcgheLNiWyFz6PGlQ10RXeCUzd
 tEPrMw/ybQlHU/5xfZDxK9BEdNSrl6olEqPNd5WyltxHqnUGUZtXojcBJb5mmtTy7pJcKgcCqhM
 VeELaf262wzyj7mlyNHtUHE8L7JF+cGZ4YDV6XPsRFANqgdvB0fS0EakQYlhrm1D+xJrWLLUxHn
 7EOlA7HEWd88GO/HU01Nf169lfIXIVi6LZ2hg8nsOftGdzcutsq+DS/8OPDgqhl7CvP4N5zkKZK
 CInHG6/lf2mhsQcNyUk6P2GItCmZlgFdmfaf8QIJKeAIdA4jN9j83yswA8PL1/JpUEbNhxH3lFM
 v0IC7LJWug6aLyMTGzLanebwQ=
X-Received: by 2002:a05:600c:620f:b0:47a:81b7:9a20 with SMTP id
 5b1f17b1804b1-482db49ac11mr141658255e9.9.1770036714545; 
 Mon, 02 Feb 2026 04:51:54 -0800 (PST)
Received: from able.fritz.box ([2a00:e180:1570:8200:7824:9bef:268:2d37])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-482da6a042csm126165535e9.0.2026.02.02.04.51.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Feb 2026 04:51:54 -0800 (PST)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: tursulin@ursulin.net, Alexander.Deucher@amd.com, Prike.Liang@amd.com,
 Yogesh.Mohanmarimuthu@amd.com, SRINIVASAN.SHANMUGAM@amd.com,
 Sunil.Khatri@amd.com, amd-gfx@lists.freedesktop.org
Subject: [PATCH 6/9] drm/amdgpu: fix adding eviction fence
Date: Mon,  2 Feb 2026 13:51:46 +0100
Message-ID: <20260202125149.2067-6-christian.koenig@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260202125149.2067-1-christian.koenig@amd.com>
References: <20260202125149.2067-1-christian.koenig@amd.com>
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

We can't add the eviction fence without validating the BO.

Signed-off-by: Christian König <christian.koenig@amd.com>
---
 .../drm/amd/amdgpu/amdgpu_eviction_fence.c    | 19 ++++++++++++++++---
 .../drm/amd/amdgpu/amdgpu_eviction_fence.h    |  4 ++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c       |  9 ++++++---
 3 files changed, 24 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c
index ef4da6f2e2a3..6598823ec619 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c
@@ -82,14 +82,27 @@ amdgpu_eviction_fence_suspend_worker(struct work_struct *work)
 	mutex_unlock(&uq_mgr->userq_mutex);
 }
 
-void amdgpu_evf_mgr_attach_fence(struct amdgpu_eviction_fence_mgr *evf_mgr,
-				 struct amdgpu_bo *bo)
+int amdgpu_evf_mgr_attach_fence(struct amdgpu_eviction_fence_mgr *evf_mgr,
+				struct amdgpu_bo *bo)
 {
 	struct dma_fence *ev_fence = amdgpu_evf_mgr_get_fence(evf_mgr);
+	struct ttm_operation_ctx ctx = { false, false };
 	struct dma_resv *resv = bo->tbo.base.resv;
+	int ret;
+
+	if (!dma_fence_is_signaled(ev_fence)) {
+
+		amdgpu_bo_placement_from_domain(bo, bo->allowed_domains);
+		ret = ttm_bo_validate(&bo->tbo, &bo->placement, &ctx);
+		if (!ret)
+			dma_resv_add_fence(resv, ev_fence,
+					   DMA_RESV_USAGE_BOOKKEEP);
+	} else {
+		ret = 0;
+	}
 
-	dma_resv_add_fence(resv, ev_fence, DMA_RESV_USAGE_BOOKKEEP);
 	dma_fence_put(ev_fence);
+	return ret;
 }
 
 int amdgpu_evf_mgr_rearm(struct amdgpu_eviction_fence_mgr *evf_mgr,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.h
index 132a13a5dc1c..2a750add4e7b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.h
@@ -58,8 +58,8 @@ amdgpu_evf_mgr_get_fence(struct amdgpu_eviction_fence_mgr *evf_mgr)
 	return ev_fence;
 }
 
-void amdgpu_evf_mgr_attach_fence(struct amdgpu_eviction_fence_mgr *evf_mgr,
-				 struct amdgpu_bo *bo);
+int amdgpu_evf_mgr_attach_fence(struct amdgpu_eviction_fence_mgr *evf_mgr,
+				struct amdgpu_bo *bo);
 int amdgpu_evf_mgr_rearm(struct amdgpu_eviction_fence_mgr *evf_mgr,
 			 struct drm_exec *exec);
 void amdgpu_evf_mgr_detach_fence(struct amdgpu_eviction_fence_mgr *evf_mgr,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
index e28abfd04867..88a21400ae09 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
@@ -258,12 +258,15 @@ static int amdgpu_gem_object_open(struct drm_gem_object *obj,
 
 	amdgpu_vm_bo_update_shared(abo);
 	bo_va = amdgpu_vm_bo_find(vm, abo);
-	if (!bo_va)
+	if (!bo_va) {
 		bo_va = amdgpu_vm_bo_add(adev, vm, abo);
-	else
+		r = amdgpu_evf_mgr_attach_fence(&fpriv->evf_mgr, abo);
+		if (r)
+			goto out_unlock;
+	} else {
 		++bo_va->ref_count;
+	}
 
-	amdgpu_evf_mgr_attach_fence(&fpriv->evf_mgr, abo);
 	drm_exec_fini(&exec);
 
 	/* Validate and add eviction fence to DMABuf imports with dynamic
-- 
2.43.0

