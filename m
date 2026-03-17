Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54226FD7077
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Mar 2026 10:55:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E450B10E5CD;
	Tue, 17 Mar 2026 10:55:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="NvqRz+SX";
	dkim-atps=neutral
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com
 [209.85.128.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D114510E584
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Mar 2026 10:55:06 +0000 (UTC)
Received: by mail-wm1-f48.google.com with SMTP id
 5b1f17b1804b1-4852c9b4158so49392195e9.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Mar 2026 03:55:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773744905; x=1774349705; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nichylBWY65475TY8Sw5pr3WXxJfcp3YuPBsfSSA/TQ=;
 b=NvqRz+SXvvuO6nNN+q/WMWzJzyzsy/BRpJueu/BPUVJ6hC8hK/Q4gZEhPd+uoIPCUQ
 nw9+IyqGVicIKUdhh92C0Nghp25e36g/pVxUZqNTpzYQWWwkZPrcMq5MkP1QBaI4Oxw8
 UyOTCcOJkVL/D4uozNE/NifI1f9cP2SPKVrPgiZbE0p/lWTO92T2jLZR6yKSu0rtth2b
 iFeH0wAWXIwRZE9DgOVgVgJGh5U72KjiBXgYELC57VN7gdKxtexTmRlsPHVTxLScDkOv
 GWkCn77T/g0BrAkfxLD7mBHs2lD1aa2WfD7u04FkJEL4txurEiMdLmoq39g6uKoZ5FER
 xOSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773744905; x=1774349705;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=nichylBWY65475TY8Sw5pr3WXxJfcp3YuPBsfSSA/TQ=;
 b=Sxudr7g6IzLELk0aXYS9ljMQwaZB37EH/qLJwCgAe2xJfvfSM6SYhsfPzjZG7eIuOd
 NSWCG9tH93LJDRmTe/w0rnyafJkwBwX3nO+NEd2gZbfqJzCq8eE6TV/5MUM2sXokoojd
 C089TUeqB3db84MKJEC2mcVpDTj6So0VAVf2pUjMlgqWSIwzqjcEIzkJV2/QRJAjMzA/
 I9nZ6n6Jy1K9Z+2sql1a25G/lpapJpvOmo0uEJVvsl7+Wt0CsENnYWYppWouc+oZISpC
 o0vRXJOr8/aUdQ/yewjuslCWAIC2yDbCFnajOVDcvkoprRvXB7GYgEaIL8zgCMT8Lbmp
 taWA==
X-Gm-Message-State: AOJu0YyhYlJ6a/lA4jIRC1sjG3ShktfBrN7AbwyhCGg0HJ8xjo22vmzq
 us7PCvM68L8V323WECELeS8rLFPsHLK8DS0fno8YhFjk9DkNHhc2Oizk
X-Gm-Gg: ATEYQzxYGVsCOC4265wdgfpykWo8+onF9IvyCkT+A217kMPASU6tkXETQr2fOZIejeK
 HpMB0W6HpWNu6+TTX+KHJRSFco7Y8OyEDvvu//iVS1faw+cmplHWhCSyAJ25xpL9whl5FZbkCbv
 eDq6gx72a4dquDwX3EP/byZOBLBQMVCqd53MFRBCG9Kg1PFYbjZCrLjq1nqmyLq4naZCLGWi3yA
 VpJV9FK09d7JYB2c/o1/ArWXTbdmKtaHXLRsqMtESCBgPbewibk1WjqmWbOUp6ElHP9zSxmWJ63
 DaLi0BzxLfX/mKsybYORlLe7oEkWqM8u666xEGmjzuxO23cfkzIUoaXWude+wfS7eQgXAs0OI+B
 a9ec7fB82NuHl6m/+jPEiyM8u6mBce1WKZ8gXWWKDIbuswrH87DUJHEtxaU/XYSAffwsGLrrOp2
 VtxUDftqUVyZmzckTtYwDKVgDhZbcmD2wfQ/sp
X-Received: by 2002:a05:600c:3550:b0:483:709e:f238 with SMTP id
 5b1f17b1804b1-4855670c971mr296753815e9.29.1773744905182; 
 Tue, 17 Mar 2026 03:55:05 -0700 (PDT)
Received: from able.fritz.box ([2a00:e180:1570:2300:fbdd:8811:84b7:347c])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-439fe20bd9csm49852223f8f.21.2026.03.17.03.55.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Mar 2026 03:55:04 -0700 (PDT)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: sukhatri@amd.com, tursulin@ursulin.net, Alexander.Deucher@amd.com,
 Prike.Liang@amd.com, SRINIVASAN.SHANMUGAM@amd.com, christian.koenig@amd.com
Cc: amd-gfx@lists.freedesktop.org
Subject: [PATCH 03/10] drm/amdgpu: fix adding eviction fence
Date: Tue, 17 Mar 2026 11:54:53 +0100
Message-ID: <20260317105501.21479-3-christian.koenig@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260317105501.21479-1-christian.koenig@amd.com>
References: <20260317105501.21479-1-christian.koenig@amd.com>
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
Reviewed-by: Sunil Khatri <sunil.khatri@amd.com>
---
 .../drm/amd/amdgpu/amdgpu_eviction_fence.c    | 19 ++++++++++++++++---
 .../drm/amd/amdgpu/amdgpu_eviction_fence.h    |  4 ++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c       |  9 ++++++---
 3 files changed, 24 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c
index ccbdb3068b6f..ef7d07a134ce 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c
@@ -79,14 +79,27 @@ amdgpu_eviction_fence_suspend_worker(struct work_struct *work)
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

