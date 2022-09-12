Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D82FBECAAD5
	for <amd-gfx@archiver.kernel.org>; Mon, 12 Sep 2022 12:37:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 84EB110E449;
	Mon, 12 Sep 2022 12:37:12 +0000 (UTC)
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com
 [IPv6:2a00:1450:4864:20::634])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8D3B910E455
 for <amd-gfx@lists.freedesktop.org>; Mon, 12 Sep 2022 12:36:49 +0000 (UTC)
Received: by mail-ej1-x634.google.com with SMTP id dv25so19799511ejb.12
 for <amd-gfx@lists.freedesktop.org>; Mon, 12 Sep 2022 05:36:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
 bh=hfnzsNwptVMdV8BSAjQvPCVwkqlHFMKdmNZG/26re1E=;
 b=QjKCBn/eDkPmrlGNzi3B4Q4Ig28EbR5ROny2v+7XmN5+/FrSwCwFUtfP2cpWdV4GwA
 eyMDhYxYsfmSa+YLMfAoekKAyKyYbmESgq6I148tbJQ+F1vgFV8vXlMJ9VsrFdle0rH2
 v3XzbLyO4vi7FgM9kTBsY6lSIirO3CZ2CAHqcmarfwM43Mkwbr3dwjk4iJDFMxOXOqZq
 BDLcO7JdV8vBSS0Isx1SnGI5wS6S747aAJodaEFhrkjO8swT5so6Era0XSZw5JGA5tkV
 Hoy41qphQgppq1XcDd+2xnZO0zyErdQPqWKSGMTYKuI2RwkZSgvYwjqU49owkwtgV7Md
 lFqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date;
 bh=hfnzsNwptVMdV8BSAjQvPCVwkqlHFMKdmNZG/26re1E=;
 b=YgyY3JKcFnhZVNglAVW+NwDf7D1gE0ccnpruHpnevLdvvTIGd2iO7Jwh4jd6nMQtis
 Hz1psP3xL49wC+IvsUTOVbz0Q+QI5IHt4xFgc5Iml3H7FBCM5V7JC0Ht/ry4uA2D0//5
 pqzUINxCvuxtON0S2wxaTRSYMI8hRwCiPjEHQEw0nhJPioTx9DIhkl7aJVsWtSQ6MOqJ
 pkDIO80QUseTtXSk3IWqQKnSvI6O6DGjbH3CsYAmCA5/9n3tPd1E3VtIh1rhPuf6v1MV
 gsiseuC+Bl08JXHHYPfhXuWCkfhq41R4x3zAuxu9owPb+YjMXvDBTmvNPCF0fOr/v1dF
 3pmQ==
X-Gm-Message-State: ACgBeo35k4wBe2Y40NOdtQyHtAEEKuT4+7Ud3JTHgXAewtmK8wSqwuCo
 DD60i/PWOrp6g1E2HcwzRTw=
X-Google-Smtp-Source: AA6agR7zFY9bc//X9vD3PILOTDXY8NK/woyQVewkHqcHTEUOx0oGN4NL/54XcRE5Jlq2pBNjoi5nNA==
X-Received: by 2002:a17:907:a427:b0:761:2bd0:3e72 with SMTP id
 sg39-20020a170907a42700b007612bd03e72mr18290324ejc.346.1662986207468; 
 Mon, 12 Sep 2022 05:36:47 -0700 (PDT)
Received: from able.fritz.box (p4fc20f4e.dip0.t-ipconnect.de. [79.194.15.78])
 by smtp.gmail.com with ESMTPSA id
 au6-20020a170907092600b00770c8e157ccsm4335639ejc.136.2022.09.12.05.36.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Sep 2022 05:36:47 -0700 (PDT)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: alexander.deucher@amd.com,
	amd-gfx@lists.freedesktop.org
Subject: [PATCH 5/7] drm/amdgpu: use DMA_RESV_USAGE_BOOKKEEP v2
Date: Mon, 12 Sep 2022 14:36:38 +0200
Message-Id: <20220912123640.20058-6-christian.koenig@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220912123640.20058-1-christian.koenig@amd.com>
References: <20220912123640.20058-1-christian.koenig@amd.com>
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

Use DMA_RESV_USAGE_BOOKKEEP for VM page table updates and KFD preemption fence.

v2: actually update all usages for KFD

Signed-off-by: Christian König <christian.koenig@amd.com>
---
 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c  | 26 ++++++++++++-------
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c   |  3 ++-
 2 files changed, 18 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index f4c49537d837..978d3970b5cc 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -298,7 +298,7 @@ static int amdgpu_amdkfd_remove_eviction_fence(struct amdgpu_bo *bo,
 	 */
 	replacement = dma_fence_get_stub();
 	dma_resv_replace_fences(bo->tbo.base.resv, ef->base.context,
-				replacement, DMA_RESV_USAGE_READ);
+				replacement, DMA_RESV_USAGE_BOOKKEEP);
 	dma_fence_put(replacement);
 	return 0;
 }
@@ -1391,8 +1391,9 @@ static int init_kfd_vm(struct amdgpu_vm *vm, void **process_info,
 	ret = dma_resv_reserve_fences(vm->root.bo->tbo.base.resv, 1);
 	if (ret)
 		goto reserve_shared_fail;
-	amdgpu_bo_fence(vm->root.bo,
-			&vm->process_info->eviction_fence->base, true);
+	dma_resv_add_fence(vm->root.bo->tbo.base.resv,
+			   &vm->process_info->eviction_fence->base,
+			   DMA_RESV_USAGE_BOOKKEEP);
 	amdgpu_bo_unreserve(vm->root.bo);
 
 	/* Update process info */
@@ -1989,9 +1990,9 @@ int amdgpu_amdkfd_gpuvm_map_memory_to_gpu(
 	}
 
 	if (!amdgpu_ttm_tt_get_usermm(bo->tbo.ttm) && !bo->tbo.pin_count)
-		amdgpu_bo_fence(bo,
-				&avm->process_info->eviction_fence->base,
-				true);
+		dma_resv_add_fence(bo->tbo.base.resv,
+				   &avm->process_info->eviction_fence->base,
+				   DMA_RESV_USAGE_BOOKKEEP);
 	ret = unreserve_bo_and_vms(&ctx, false, false);
 
 	goto out;
@@ -2760,15 +2761,18 @@ int amdgpu_amdkfd_gpuvm_restore_process_bos(void *info, struct dma_fence **ef)
 		if (mem->bo->tbo.pin_count)
 			continue;
 
-		amdgpu_bo_fence(mem->bo,
-			&process_info->eviction_fence->base, true);
+		dma_resv_add_fence(mem->bo->tbo.base.resv,
+				   &process_info->eviction_fence->base,
+				   DMA_RESV_USAGE_BOOKKEEP);
 	}
 	/* Attach eviction fence to PD / PT BOs */
 	list_for_each_entry(peer_vm, &process_info->vm_list_head,
 			    vm_list_node) {
 		struct amdgpu_bo *bo = peer_vm->root.bo;
 
-		amdgpu_bo_fence(bo, &process_info->eviction_fence->base, true);
+		dma_resv_add_fence(bo->tbo.base.resv,
+				   &process_info->eviction_fence->base,
+				   DMA_RESV_USAGE_BOOKKEEP);
 	}
 
 validate_map_fail:
@@ -2822,7 +2826,9 @@ int amdgpu_amdkfd_add_gws_to_process(void *info, void *gws, struct kgd_mem **mem
 	ret = dma_resv_reserve_fences(gws_bo->tbo.base.resv, 1);
 	if (ret)
 		goto reserve_shared_fail;
-	amdgpu_bo_fence(gws_bo, &process_info->eviction_fence->base, true);
+	dma_resv_add_fence(gws_bo->tbo.base.resv,
+			   &process_info->eviction_fence->base,
+			   DMA_RESV_USAGE_BOOKKEEP);
 	amdgpu_bo_unreserve(gws_bo);
 	mutex_unlock(&(*mem)->process_info->lock);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c
index 1fd3cbca20a2..03ec099d64e0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c
@@ -112,7 +112,8 @@ static int amdgpu_vm_sdma_commit(struct amdgpu_vm_update_params *p,
 		swap(p->vm->last_unlocked, tmp);
 		dma_fence_put(tmp);
 	} else {
-		amdgpu_bo_fence(p->vm->root.bo, f, true);
+		dma_resv_add_fence(p->vm->root.bo->tbo.base.resv, f,
+				   DMA_RESV_USAGE_BOOKKEEP);
 	}
 
 	if (fence && !p->immediate)
-- 
2.25.1

