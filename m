Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7B47D61013
	for <amd-gfx@archiver.kernel.org>; Thu, 29 Jan 2026 12:53:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 788F410E85C;
	Thu, 29 Jan 2026 12:53:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="OQHt7wCu";
	dkim-atps=neutral
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com
 [209.85.128.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2A95D10E856
 for <amd-gfx@lists.freedesktop.org>; Thu, 29 Jan 2026 12:53:33 +0000 (UTC)
Received: by mail-wm1-f53.google.com with SMTP id
 5b1f17b1804b1-4801bc32725so7083755e9.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 29 Jan 2026 04:53:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1769691212; x=1770296012; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=OuzlKm8q1thb7rhM4LAihsKDukKXDcqN/d2yzyH88XM=;
 b=OQHt7wCujXIbK4dBFrl35WIDftfS+Qf7HnpgrT2nnLUiG7sBBMN0SwgT7zrloASc8A
 ZvFcmdndN3Doi+ItEtyA6z3rV38ENsxpw5j7UNbLOfQ0bf9IOsL9yphg4hFOX5pImZx1
 WAewmkdRA4a0QkSFxUdbnkrDIPmVCyPzPkAC4iD9qZ3m+LtZj+s6DzzEwp8VC10zm9ZO
 QEveOtFXJCOE+NHO7r68w6uTKDWDDJwUSxWg7YsTvjfmldFL+1iQ+lDyYVikqgu3H0OU
 rBsgJ8uAbcEWmlHrNmQyD+rtBvQXRpeRFoRrdGTs/2XA4A6JpOWstkXTh59rFPfabOqk
 ZcTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769691212; x=1770296012;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=OuzlKm8q1thb7rhM4LAihsKDukKXDcqN/d2yzyH88XM=;
 b=lG0GIgyPFqJkNefESUidEKugngqYQP9Ggs27jBMWV7HbSVMxNUgcrYAZ7f5CCw9o6M
 hCLce+ZAM78vopx79L1NQkAaIElIrIUcOqbL4m+u36ZKw7auxQTEMMAhhIB+6bAovpPe
 MnmPkOzJTpbbPDPEcm1CoSE99zqmavkNb/OjRixj5HPU+OfW+eW3c7/IRvuNxs1hU2A2
 c06dM2rfnjH0Alu/Ha4rmRmIy/5Dx8+pAF7Aun1WCywwDo6SqGYILxf4rNLjE9Rxro4g
 4om44RjU04u2c70jwxesXym7iswUk2QKZZTAqWQ3E+7SukdVo6uDbxZQnT+gnAPrZQaG
 nLUA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWX4XeKIt+A6XpsgC7KcLB/wZOz+xuCQCB3yEpNXddpRDgijLvU2thBBzQTZ5IVkWSbq0yMO/m0@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyD8C4OFLriI9EPIhcTnQ2+csub7UqU/1njZMjpx4IfvgEE4QpP
 iWUDqFkSj8QBQLK/tloVjHpieGMYXsUue926GpyubZoSpuslXb3oqY5v
X-Gm-Gg: AZuq6aLVRaJj6F7IGz+2S+8hJzchX1+xNmKIUR1G732RnmzAZFkl4zvTSm9N43kLD7f
 3DLPwI8nnh270GXkG9XauAyk7edm/P0MbY2n0+jEQK710eh89WpgDh9eYi6bqOcNWJ5k8x0rkfF
 9gZYS57uCGcKZ2IxRnd13kOGxnE0BDIF551Lu05YRBRmX7BjmtqugfdCeiAXfoJ3JH9Dc3HI4vK
 oSS8hm38k3VCVfAx2qt5jxIOvkD/KXxF0y5E4aUtdqDNehAM/Su1ouUkAeJN71z5Yui5xEgVMsy
 t5DiOvVVOzcx+1xm0v8Iy6c8wxsVgBjk6U5tTZjDHAqtZPHQAL0B6BPskQeZDbucaat6IwyI++0
 xqvU7wSJz+wNUlmzT68dcqDh8RhznOSTUD+An5a8v15p7psiwEyxSd4UNqHbCaSD5iTVd6sMtA6
 ETMOp/mT9neRe0urzla7ltIWDz
X-Received: by 2002:a05:6000:2906:b0:432:8537:85ca with SMTP id
 ffacd0b85a97d-435dd1ccab1mr12995570f8f.50.1769691211521; 
 Thu, 29 Jan 2026 04:53:31 -0800 (PST)
Received: from able.fritz.box ([2a00:e180:1522:e200:97e2:f9c5:ae8b:8e89])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435e1354114sm15442569f8f.42.2026.01.29.04.53.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Jan 2026 04:53:31 -0800 (PST)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: Alexander.Deucher@amd.com, Prike.Liang@amd.com,
 Yogesh.Mohanmarimuthu@amd.com, SRINIVASAN.SHANMUGAM@amd.com,
 Sunil.Khatri@amd.com, amd-gfx@lists.freedesktop.org
Subject: [PATCH 5/7] drm/amdgpu: fix adding eviction fence
Date: Thu, 29 Jan 2026 13:53:25 +0100
Message-ID: <20260129125327.11786-5-christian.koenig@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260129125327.11786-1-christian.koenig@amd.com>
References: <20260129125327.11786-1-christian.koenig@amd.com>
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
index 8fe9f91f9551..59eb68dc5480 100644
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
index 527de3a23583..ece20bd7e255 100644
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

