Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88FB0C433FE
	for <amd-gfx@archiver.kernel.org>; Thu, 31 Mar 2022 09:47:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 49A1D10F296;
	Thu, 31 Mar 2022 09:47:35 +0000 (UTC)
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com
 [IPv6:2a00:1450:4864:20::536])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B1F5110F293
 for <amd-gfx@lists.freedesktop.org>; Thu, 31 Mar 2022 09:47:33 +0000 (UTC)
Received: by mail-ed1-x536.google.com with SMTP id b24so27473410edu.10
 for <amd-gfx@lists.freedesktop.org>; Thu, 31 Mar 2022 02:47:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Sin2Hs/9udp5hthZMNVkLocfUrzcu6bN7F9EZ1lZ7t0=;
 b=dTwj6nKCMXARY+z33g/hv8cZRAKOJVA2+bMCORP/U5jko8GVivfkaWV53K3Z/65SI6
 QsYJaoRloeeCFx23M+EHDWBjLariPREX8ejH6oPfUqnbNT46iEjoPNFN+T3bV8aaZZyY
 1NLvC5icd6/yDdi5P28Vvj+QvdFN8zPnQrBnY4NFxJvzA9GRDw5ScrK3EDow+ltp11zL
 esIykv7oPOemlkUka/dF+9PrxElJi14L01Vin7kT5SQZVkXfkYbzRqPbCjZTjFit5+Qu
 P1N5JHpxmgEorMLjjb1gKVLDBlJ2xiEpSJY3Mh17/RDK6Zx6rTycBFFJ0imA/RC64R6S
 AtRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Sin2Hs/9udp5hthZMNVkLocfUrzcu6bN7F9EZ1lZ7t0=;
 b=y5rmRRYz0gEZsP3JLI6uY743bd8qiPfOzPMaI+92CouLO2LH1d3UWda4JjhWt45fWA
 fiVK9FkRxWOfiyuDdDYDxu2YIYVcpnnN5nfZr3+VRjcnk8xdfowCnqpgLssrYfbyOuN/
 R+pI+uQQfDF6OEWFp8oDxSc1mhX5Qv2wVwDZEQC7HU9yPei367IcZAoWFiEtzW2Di6v6
 gVdlJ2Sw7YXb6o8NtQWIYYclWvXcokgH6zlvjaXGYPInLR79tpXX29Du1aZjVa2W7l4Z
 wuapgGRsWEFludf0ftIDkoYnOR4tnmfOAvC+Ma9RM/MXeZ+zOsG+KVs+qNHgYVFTuvAC
 NSgg==
X-Gm-Message-State: AOAM533S41IkuI/eytxCoWQvCtJiplD2n+23hj1zM98EC0SmXRPk1v/2
 2I6uHZ3aI2/aW1WF7LkSmv4=
X-Google-Smtp-Source: ABdhPJwMv3zc3Vv71l+oygdQkHFRZWamNXnFqhT+14Df/wD+hdYi7SoU+87cYH0TTJHytrTyudNkjA==
X-Received: by 2002:a05:6402:1255:b0:419:3808:3d98 with SMTP id
 l21-20020a056402125500b0041938083d98mr15750634edw.134.1648720052152; 
 Thu, 31 Mar 2022 02:47:32 -0700 (PDT)
Received: from able.fritz.box (p5b0eab60.dip0.t-ipconnect.de. [91.14.171.96])
 by smtp.gmail.com with ESMTPSA id
 qk30-20020a1709077f9e00b006dfae33d969sm9249202ejc.216.2022.03.31.02.47.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 31 Mar 2022 02:47:31 -0700 (PDT)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: bas@basnieuwenhuizen.nl, alexander.deucher@amd.com,
 amd-gfx@lists.freedesktop.org
Subject: [PATCH 3/5] drm/amdgpu: add last update fence to amdgpu_vm_bo_update
Date: Thu, 31 Mar 2022 11:47:25 +0200
Message-Id: <20220331094727.27153-3-christian.koenig@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220331094727.27153-1-christian.koenig@amd.com>
References: <20220331094727.27153-1-christian.koenig@amd.com>
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

Allows separate tracking of VM updates.

Signed-off-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c           |  6 +++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c          |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c           | 14 ++++++++------
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h           |  5 ++---
 5 files changed, 15 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index 8b14c55a0793..57b521bb1eec 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -1104,7 +1104,7 @@ static int update_gpuvm_pte(struct kgd_mem *mem,
 		return ret;
 
 	/* Update the page tables  */
-	ret = amdgpu_vm_bo_update(adev, bo_va, false);
+	ret = amdgpu_vm_bo_update(adev, bo_va, false, NULL);
 	if (ret) {
 		pr_err("amdgpu_vm_bo_update failed\n");
 		return ret;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
index ea28942b0ede..50fddd6715db 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
@@ -806,7 +806,7 @@ static int amdgpu_cs_vm_handling(struct amdgpu_cs_parser *p)
 	if (r)
 		return r;
 
-	r = amdgpu_vm_bo_update(adev, fpriv->prt_va, false);
+	r = amdgpu_vm_bo_update(adev, fpriv->prt_va, false, NULL);
 	if (r)
 		return r;
 
@@ -817,7 +817,7 @@ static int amdgpu_cs_vm_handling(struct amdgpu_cs_parser *p)
 	if (amdgpu_mcbp || amdgpu_sriov_vf(adev)) {
 		bo_va = fpriv->csa_va;
 		BUG_ON(!bo_va);
-		r = amdgpu_vm_bo_update(adev, bo_va, false);
+		r = amdgpu_vm_bo_update(adev, bo_va, false, NULL);
 		if (r)
 			return r;
 
@@ -836,7 +836,7 @@ static int amdgpu_cs_vm_handling(struct amdgpu_cs_parser *p)
 		if (bo_va == NULL)
 			continue;
 
-		r = amdgpu_vm_bo_update(adev, bo_va, false);
+		r = amdgpu_vm_bo_update(adev, bo_va, false, NULL);
 		if (r)
 			return r;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
index 4509a59d499a..3f84eedb4d96 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
@@ -618,7 +618,7 @@ static void amdgpu_gem_va_update_vm(struct amdgpu_device *adev,
 
 	if (operation == AMDGPU_VA_OP_MAP ||
 	    operation == AMDGPU_VA_OP_REPLACE) {
-		r = amdgpu_vm_bo_update(adev, bo_va, false);
+		r = amdgpu_vm_bo_update(adev, bo_va, false, NULL);
 		if (r)
 			goto error;
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 3f73e6097e6c..05024999556b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -992,6 +992,7 @@ void amdgpu_vm_get_memory(struct amdgpu_vm *vm, uint64_t *vram_mem,
  * @adev: amdgpu_device pointer
  * @bo_va: requested BO and VM object
  * @clear: if true clear the entries
+ * @last_update: the last update operation
  *
  * Fill in the page table entries for @bo_va.
  *
@@ -999,14 +1000,13 @@ void amdgpu_vm_get_memory(struct amdgpu_vm *vm, uint64_t *vram_mem,
  * 0 for success, -EINVAL for failure.
  */
 int amdgpu_vm_bo_update(struct amdgpu_device *adev, struct amdgpu_bo_va *bo_va,
-			bool clear)
+			bool clear, struct dma_fence **last_update)
 {
 	struct amdgpu_bo *bo = bo_va->base.bo;
 	struct amdgpu_vm *vm = bo_va->base.vm;
 	struct amdgpu_bo_va_mapping *mapping;
 	dma_addr_t *pages_addr = NULL;
 	struct ttm_resource *mem;
-	struct dma_fence **last_update;
 	bool flush_tlb = clear;
 	struct dma_resv *resv;
 	uint64_t vram_base;
@@ -1049,8 +1049,10 @@ int amdgpu_vm_bo_update(struct amdgpu_device *adev, struct amdgpu_bo_va *bo_va,
 		vram_base = 0;
 	}
 
-	if (clear || (bo && bo->tbo.base.resv ==
-		      vm->root.bo->tbo.base.resv))
+	if (last_update)
+		dma_resv_assert_held(bo->tbo.base.resv);
+	else if (clear || (bo && bo->tbo.base.resv ==
+			   vm->root.bo->tbo.base.resv))
 		last_update = &vm->last_update;
 	else
 		last_update = &bo_va->last_pt_update;
@@ -1322,7 +1324,7 @@ int amdgpu_vm_handle_moved(struct amdgpu_device *adev,
 
 	list_for_each_entry_safe(bo_va, tmp, &vm->moved, base.vm_status) {
 		/* Per VM BOs never need to bo cleared in the page tables */
-		r = amdgpu_vm_bo_update(adev, bo_va, false);
+		r = amdgpu_vm_bo_update(adev, bo_va, false, NULL);
 		if (r)
 			return r;
 	}
@@ -1341,7 +1343,7 @@ int amdgpu_vm_handle_moved(struct amdgpu_device *adev,
 		else
 			clear = true;
 
-		r = amdgpu_vm_bo_update(adev, bo_va, clear);
+		r = amdgpu_vm_bo_update(adev, bo_va, clear, NULL);
 		if (r)
 			return r;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
index be82ef170926..3c7df1b8e3c9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
@@ -409,9 +409,8 @@ int amdgpu_vm_update_range(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 			   uint64_t flags, uint64_t offset, uint64_t vram_base,
 			   struct ttm_resource *res, dma_addr_t *pages_addr,
 			   struct dma_fence **fence);
-int amdgpu_vm_bo_update(struct amdgpu_device *adev,
-			struct amdgpu_bo_va *bo_va,
-			bool clear);
+int amdgpu_vm_bo_update(struct amdgpu_device *adev, struct amdgpu_bo_va *bo_va,
+			bool clear, struct dma_fence **last_update);
 bool amdgpu_vm_evictable(struct amdgpu_bo *bo);
 void amdgpu_vm_bo_invalidate(struct amdgpu_device *adev,
 			     struct amdgpu_bo *bo, bool evicted);
-- 
2.25.1

