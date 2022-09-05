Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CF6CECAAD5
	for <amd-gfx@archiver.kernel.org>; Mon,  5 Sep 2022 12:32:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B31E210E357;
	Mon,  5 Sep 2022 12:32:43 +0000 (UTC)
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com
 [IPv6:2a00:1450:4864:20::636])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BC32B10E369
 for <amd-gfx@lists.freedesktop.org>; Mon,  5 Sep 2022 12:32:38 +0000 (UTC)
Received: by mail-ej1-x636.google.com with SMTP id fy31so16797379ejc.6
 for <amd-gfx@lists.freedesktop.org>; Mon, 05 Sep 2022 05:32:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
 bh=Xb0HCbFiduCgbCnqPi5Z3FkjCxcPpWPR+lLUNT2LeAk=;
 b=mS1i2uKu/SwtzHW8an0fy8838Wo6p7AAwbMM3HfVzZmG47CwWadw0GLF7rLH/PazIU
 xitz8Cvf/pDOcbBOzW05IV1aNJggkFAjRQcf9T+qeEcpFjKu8gzKOFqG5UkOfPHQbbsQ
 ljzTf7obdTHed5bk+T2MiIDtEl+dtOs+Z3VKpYgfVjf0CJ+gpbCHZ7oWEKxhDLP7o62j
 U7z6s+Y0rMD0d61zSgmud3X5sdhLZ1oaOROjnRBdWZJVYYbfA+CUFds9M1An4zKQ6Exs
 qSfgkU2NGqTajfLpw454zbj9B64eKm/mIASmIyr7VOuHEv37o/O29rCqU3jZG+wYqzNH
 2u6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date;
 bh=Xb0HCbFiduCgbCnqPi5Z3FkjCxcPpWPR+lLUNT2LeAk=;
 b=gqCbR5nbX7/cZsahKpUaXt+ijV/hP0JH4VU7DtUXw20o2x8llCynSmJ5WkH8ykPp3Z
 Oqqo1RSOZmmxTqezB4qyBYbixUY4Gy2MA+k6x4YQaOKzYRdFhGiCJ5FJ79EAQFpd9uK5
 KepoT5ikcGFiggkCr4Ia7S3G3pgzkKf2EMoKmk/Co+euTv6/mhfIhsCt+v9G2uebVEZa
 H2FHFlJgw+XsvmgNjIQVE4k8zx+HZedlFsaaDvs6C/BGWbvSMlIlDJKUCM/OrJdCv9D/
 1X70kJagby9VKCuZz6r0f10kKFNF1ShHreZd+0Ye88xj8OeEPe5hDvnhW9obpAQ6V67R
 u1EA==
X-Gm-Message-State: ACgBeo3EzqVRtOls42eFgzmT84lVNGRR+f0gKBRP8Rf7sYlJHRPR9laX
 y0GUD+Z7DHYmrhFkS/HTX47gtQ2XPgubiw==
X-Google-Smtp-Source: AA6agR7VMRAfYGpnwuesUzjaACGtwsmKBsE3blMD9obUANzHkXjLHmaEFrb+W3M0aqXLpanhudx/ew==
X-Received: by 2002:a17:906:8a47:b0:741:5d6a:13e5 with SMTP id
 gx7-20020a1709068a4700b007415d6a13e5mr28257746ejc.60.1662381158369; 
 Mon, 05 Sep 2022 05:32:38 -0700 (PDT)
Received: from able.fritz.box (p4fc20f4e.dip0.t-ipconnect.de. [79.194.15.78])
 by smtp.gmail.com with ESMTPSA id
 k6-20020a17090632c600b0073c0b87ba34sm4970341ejk.198.2022.09.05.05.32.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Sep 2022 05:32:37 -0700 (PDT)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: amd-gfx@lists.freedesktop.org,
	Ruijing.Dong@amd.com
Subject: [PATCH 05/12] drm/amdgpu: use DMA_RESV_USAGE_BOOKKEEP v2
Date: Mon,  5 Sep 2022 14:32:25 +0200
Message-Id: <20220905123232.2809-5-christian.koenig@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220905123232.2809-1-christian.koenig@amd.com>
References: <20220905123232.2809-1-christian.koenig@amd.com>
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
index cbd593f7d553..f1604f5cd7c1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -297,7 +297,7 @@ static int amdgpu_amdkfd_remove_eviction_fence(struct amdgpu_bo *bo,
 	 */
 	replacement = dma_fence_get_stub();
 	dma_resv_replace_fences(bo->tbo.base.resv, ef->base.context,
-				replacement, DMA_RESV_USAGE_READ);
+				replacement, DMA_RESV_USAGE_BOOKKEEP);
 	dma_fence_put(replacement);
 	return 0;
 }
@@ -1390,8 +1390,9 @@ static int init_kfd_vm(struct amdgpu_vm *vm, void **process_info,
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
@@ -1987,9 +1988,9 @@ int amdgpu_amdkfd_gpuvm_map_memory_to_gpu(
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
@@ -2758,15 +2759,18 @@ int amdgpu_amdkfd_gpuvm_restore_process_bos(void *info, struct dma_fence **ef)
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
@@ -2820,7 +2824,9 @@ int amdgpu_amdkfd_add_gws_to_process(void *info, void *gws, struct kgd_mem **mem
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

