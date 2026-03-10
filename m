Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFDBAFD4F30
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Mar 2026 19:13:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0BF3510E77A;
	Tue, 10 Mar 2026 19:13:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="GoMHaZ6Q";
	dkim-atps=neutral
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com
 [209.85.128.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 12E9B10E2D6
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Mar 2026 19:13:36 +0000 (UTC)
Received: by mail-wm1-f52.google.com with SMTP id
 5b1f17b1804b1-48534b59cf3so25298285e9.2
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Mar 2026 12:13:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773170014; x=1773774814; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=uTLdomELe4PSRSdauYzVhcfbG1awq323eDbpFvYymZg=;
 b=GoMHaZ6QR6C81ZRaCbcD9RKxqrp0DkejPIUnwLOeknHzcDiGqRDNzt6MqqcCMVm6/Z
 Y1yWZab7By8ipVFjJm9JAa9aQOQcSC4ZOGm6KJhE5xa3EVYxdNsSazHe23U3RghCoj0c
 jyEfoAD8onwkrJPL9ZwKrYhqOHiH2SHr/bjdIAJO3UPvtxq+ZA1nK6QqrLcMBcdp34og
 baH1MdS5xAEIMXo7MIVHZaFE6e32nrz3bOnEYifH6aBZWzVQiiqsshqZe/oD8T3NYfOA
 mBtbuO7e0DHN2oVr/x2myfigwDPtNHdIDZzz7RuY2Eawq4FH4pOWq3vVZ4uT9r0iZqsc
 +UdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773170014; x=1773774814;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=uTLdomELe4PSRSdauYzVhcfbG1awq323eDbpFvYymZg=;
 b=QOeerUYRSfkK+S/9svxzSHzxCToeqwU6bob7UggXPS6T9MzIwqIlNeLfqNI2KCWtLj
 KXa+Ea4FTL+VEXM1CA8e+p77xPJ++mAzjivSZAt+eL7mWa6R2WMG0e9mT20/GUgq2Ivi
 ajLIWcVAhD82mIn5XQtRkepMK2CXzip8XaAudq0PgBOgYd+UVAM7X3Vqd7ftP7j2u4tm
 QPpAkRLxnwxEo1JSYB/l22f+MJ/TwAietf4r7ibqR0nI2WuFwfK6L1O9VCojzmlh8uEV
 y9epMP+Wn3RqakpyM3IQ/6QNhIUn5KsjHlKDZXKsGirhpMlNRleo5SsoJQqZ+j/ACayg
 l6lA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWqg2wBbf/XUUoE6gAPbZ2KlbjAfHHnACUwDjvSRsEJN0wzKPTaSIsNoMruVT1ob4DPwZhyVaJG@lists.freedesktop.org
X-Gm-Message-State: AOJu0YweM1F90bjUnGShyn5dw2GPRzNMORoFi0Onug+utKBfUcMs0SSo
 2yvCCGj04yDZ6Fp+kYxnqlNp4Lf0XDSQ4hWApTO60IlgLhX8q2WBoBiH
X-Gm-Gg: ATEYQzwai2eih1W2a6mYUydHBM5smk4YIFRqoizt7d6V4F/skTaGI1WwStW/8pIgDZC
 r+/AziPEK0aDwtESbljgpDc+dV9SmLu5GJaOk+iFIQrACKx1lb60zWyi5AeKqwdPhZxkAcJff7F
 lnB+wVQRMocf/Y79BDqcEoSEXXrypNwQriDI1JyGu/7PbP8XqBnMkRile3daeVPiC7unsaZTmfT
 IYk1i/Yv4a2rTRNln3l9Ge9G+wol4jj6dBkwwaXuHcjAce8ENJVAaQLfSoKyKSVpO42dawGRGRA
 6zOvJ+zfRF1fAYmPOYjlxeil0QNMpDMpmn5wvrVvWkK4wBhfWVLKTK7NI6ZociV7XUHYKj990pl
 On716zu9pEUeRwjqX9n8WvLl5mZqakttVxk+LKzu0EkbunW4fSVAtfCmC4NYBdbHM/54fsGmMd9
 yIhrDFDpXk8MA4pLPchhO/NK38O8btf4sopiU=
X-Received: by 2002:a05:600c:4446:b0:485:34b3:8589 with SMTP id
 5b1f17b1804b1-48534b3882emr182609725e9.31.1773170014468; 
 Tue, 10 Mar 2026 12:13:34 -0700 (PDT)
Received: from able.fritz.box ([2a00:e180:15d0:d800:5198:df3e:59ca:cf4])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4854a3079efsm2601625e9.7.2026.03.10.12.13.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Mar 2026 12:13:34 -0700 (PDT)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: tursulin@ursulin.net, Alexander.Deucher@amd.com, Prike.Liang@amd.com,
 Yogesh.Mohanmarimuthu@amd.com, SRINIVASAN.SHANMUGAM@amd.com,
 Sunil.Khatri@amd.com, amd-gfx@lists.freedesktop.org
Subject: [PATCH 06/11] drm/amdgpu: fix adding eviction fence
Date: Tue, 10 Mar 2026 20:13:22 +0100
Message-ID: <20260310191327.2279-6-christian.koenig@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260310191327.2279-1-christian.koenig@amd.com>
References: <20260310191327.2279-1-christian.koenig@amd.com>
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

