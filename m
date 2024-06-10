Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BD4AC27C5E
	for <amd-gfx@archiver.kernel.org>; Mon, 10 Jun 2024 09:26:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E0B3C10E3E1;
	Mon, 10 Jun 2024 09:26:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="B6kopnja";
	dkim-atps=neutral
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com
 [209.85.221.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5A80010E3CB
 for <amd-gfx@lists.freedesktop.org>; Mon, 10 Jun 2024 09:26:17 +0000 (UTC)
Received: by mail-wr1-f43.google.com with SMTP id
 ffacd0b85a97d-354b722fe81so3601900f8f.3
 for <amd-gfx@lists.freedesktop.org>; Mon, 10 Jun 2024 02:26:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1718011575; x=1718616375; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aiSvxPjDJ8vNmON8NAHTtEJghQmURYOrY++H0ZY/JeM=;
 b=B6kopnjaVlrYhIdRH6ZGJ8ej8xJXXYrFQND21TQxg7fnWzFhqSdQ+QYqR9BMiIu0E2
 WQWdz7wufU5weMNmGo850B5ojNtHuJduVQJwJjPJnPSU52ht8CG9ZZQuAI4ZWuvOLYNv
 5M2RJhNRdTMWqdj+ai1aYxA/wRZiGhhsvW2G4X/55hrBxapds/CRxrQouyJ1l6jnUP03
 VUSLzoKAYQjppinQAFI7hDc9Ur5q6fHh2GZregspg43OPn73pHN9UwHmNwfN2Fp+JQ06
 SqBXypGjSAdGqTp7/jXzKwf/VzB1wrqm8zcpzpgJfoSdq2okU4hC0TfobNf9FsNdfCpE
 nxBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718011575; x=1718616375;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aiSvxPjDJ8vNmON8NAHTtEJghQmURYOrY++H0ZY/JeM=;
 b=J27hURZtSXBl+gc+Ljb9YzKort6MKZxCWdJySonhBiY0D9baOW1KdDuYFUk4pIjO6D
 RiyEsXUxgCwCqTJLyZaYnFzCe+RSV6e6YXt0xS7yvEzYxNCVGzXjQ60DiTC002m3jd1F
 LdzTIe2DJbwMmJaE3cmNwNuxkfXVmMENgSo7faXdSTsgtG86LOAdwYQxO68ChcHAiGz+
 D9UjRTFiYunF1bdN7Wn/XpohKWs1T/K3PqT4Dxspde8FVKUgHkOU2WojH6mFzo4Sz+DS
 AiR7odve8ATVMPxpj2mtLD7n2GMdHinyjnij2EGiDRz8zNRfrRywuI1SjvhBQPd70p+r
 2TKA==
X-Gm-Message-State: AOJu0Yw1K9dg3L0IVWgOid/hlk0dwG3Lcfmxzggs/xlSe/aBE3Bu6/ZU
 O9gMThPFQXRPRA8yxY4Luqb7azQLyYQskMIwglSzzJ3ahlr+7Kb7G6p8Fr+Ny8Y=
X-Google-Smtp-Source: AGHT+IFUVZ7oU3iwlshi2bXKulmrLm0vbMRjbDMBajdBEOS+4UWBr+YO6O95FXqV3Pv7FSJqkz/PGw==
X-Received: by 2002:a05:6000:1f81:b0:35f:2239:c543 with SMTP id
 ffacd0b85a97d-35f2239c64emr2064146f8f.66.1718011575563; 
 Mon, 10 Jun 2024 02:26:15 -0700 (PDT)
Received: from able.fritz.box ([2a00:e180:15f9:7000:4916:a8ec:dd12:5894])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-35f2169fc45sm3075827f8f.10.2024.06.10.02.26.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Jun 2024 02:26:15 -0700 (PDT)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: pierre-eric.pelloux-prayer@amd.com
Cc: amd-gfx@lists.freedesktop.org
Subject: [PATCH 5/9] drm/amdgpu: delay VM root PD allocation to first use
Date: Mon, 10 Jun 2024 11:26:07 +0200
Message-Id: <20240610092611.2894-5-christian.koenig@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240610092611.2894-1-christian.koenig@amd.com>
References: <20240610092611.2894-1-christian.koenig@amd.com>
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

Try to not allocate the backing store for the root PD before it is used for
the first time. This avoids talking to the GPU while initializing the VM.

Signed-off-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c    | 29 +++++++++---------
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c | 37 ++++++++++++++---------
 2 files changed, 37 insertions(+), 29 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index b497b345e44a..65d42a405476 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -344,7 +344,7 @@ void amdgpu_vm_bo_base_init(struct amdgpu_vm_bo_base *base,
 	else
 		amdgpu_vm_bo_idle(base);
 
-	if (bo->preferred_domains &
+	if (bo->tbo.resource && bo->preferred_domains &
 	    amdgpu_mem_type_to_domain(bo->tbo.resource->mem_type))
 		return;
 
@@ -478,19 +478,32 @@ int amdgpu_vm_validate(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 
 	spin_lock(&vm->status_lock);
 	while (!list_empty(&vm->evicted)) {
+		bool clear;
+
 		bo_base = list_first_entry(&vm->evicted,
 					   struct amdgpu_vm_bo_base,
 					   vm_status);
 		spin_unlock(&vm->status_lock);
 
 		bo = bo_base->bo;
-
+		clear = !bo->tbo.resource;
 		r = validate(param, bo);
 		if (r)
 			return r;
 
 		if (bo->tbo.type != ttm_bo_type_kernel) {
 			amdgpu_vm_bo_moved(bo_base);
+
+		} else if (clear) {
+			/* Delayed clear for the root PD */
+			struct amdgpu_bo_vm *bo_vm;
+
+			bo_vm = container_of(bo, struct amdgpu_bo_vm, bo);
+			r = amdgpu_vm_pt_clear(adev, vm, bo_vm, false);
+			if (r)
+				return r;
+			amdgpu_vm_bo_relocated(bo_base);
+
 		} else {
 			vm->update_funcs->map_table(to_amdgpu_bo_vm(bo));
 			amdgpu_vm_bo_relocated(bo_base);
@@ -2447,13 +2460,6 @@ int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 	}
 
 	amdgpu_vm_bo_base_init(&vm->root, vm, root_bo);
-	r = dma_resv_reserve_fences(root_bo->tbo.base.resv, 1);
-	if (r)
-		goto error_free_root;
-
-	r = amdgpu_vm_pt_clear(adev, vm, root, false);
-	if (r)
-		goto error_free_root;
 
 	r = amdgpu_vm_create_task_info(vm);
 	if (r)
@@ -2464,11 +2470,6 @@ int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 
 	return 0;
 
-error_free_root:
-	amdgpu_vm_pt_free_root(adev, vm);
-	amdgpu_bo_unreserve(vm->root.bo);
-	amdgpu_bo_unref(&root_bo);
-
 error_free_delayed:
 	dma_fence_put(vm->last_tlb_flush);
 	dma_fence_put(vm->last_unlocked);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
index c8e0b8cfd336..984be7080b52 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
@@ -360,7 +360,6 @@ int amdgpu_vm_pt_clear(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 		       struct amdgpu_bo_vm *vmbo, bool immediate)
 {
 	unsigned int level = adev->vm_manager.root_level;
-	struct ttm_operation_ctx ctx = { true, false };
 	struct amdgpu_vm_update_params params;
 	struct amdgpu_bo *ancestor = &vmbo->bo;
 	unsigned int entries;
@@ -379,10 +378,6 @@ int amdgpu_vm_pt_clear(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 
 	entries = amdgpu_bo_size(bo) / 8;
 
-	r = ttm_bo_validate(&bo->tbo, &bo->placement, &ctx);
-	if (r)
-		return r;
-
 	if (!drm_dev_enter(adev_to_drm(adev), &idx))
 		return -ENODEV;
 
@@ -441,6 +436,8 @@ int amdgpu_vm_pt_create(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 {
 	struct amdgpu_bo_param bp;
 	unsigned int num_entries;
+	unsigned int domains;
+	int r;
 
 	memset(&bp, 0, sizeof(bp));
 
@@ -448,32 +445,42 @@ int amdgpu_vm_pt_create(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 	bp.byte_align = AMDGPU_GPU_PAGE_SIZE;
 
 	if (!adev->gmc.is_app_apu)
-		bp.domain = AMDGPU_GEM_DOMAIN_VRAM;
+		domains = AMDGPU_GEM_DOMAIN_VRAM;
 	else
-		bp.domain = AMDGPU_GEM_DOMAIN_GTT;
+		domains = AMDGPU_GEM_DOMAIN_GTT;
+
+	domains = amdgpu_bo_get_preferred_domain(adev, domains);
+
+	if (vm->root.bo) {
+		bp.resv = vm->root.bo->tbo.base.resv;
+		bp.domain = domains;
+	} else {
+		bp.domain = 0;
+	}
 
-	bp.domain = amdgpu_bo_get_preferred_domain(adev, bp.domain);
 	bp.flags = AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS |
 		AMDGPU_GEM_CREATE_CPU_GTT_USWC;
 
+	if (vm->use_cpu_for_update)
+		bp.flags |= AMDGPU_GEM_CREATE_CPU_ACCESS_REQUIRED;
+
 	if (level < AMDGPU_VM_PTB)
 		num_entries = amdgpu_vm_pt_num_entries(adev, level);
 	else
 		num_entries = 0;
 
 	bp.bo_ptr_size = struct_size((*vmbo), entries, num_entries);
-
-	if (vm->use_cpu_for_update)
-		bp.flags |= AMDGPU_GEM_CREATE_CPU_ACCESS_REQUIRED;
-
 	bp.type = ttm_bo_type_kernel;
 	bp.no_wait_gpu = immediate;
 	bp.xcp_id_plus1 = xcp_id + 1;
 
-	if (vm->root.bo)
-		bp.resv = vm->root.bo->tbo.base.resv;
+	r = amdgpu_bo_create_vm(adev, &bp, vmbo);
+	if (r)
+		return r;
 
-	return amdgpu_bo_create_vm(adev, &bp, vmbo);
+	(*vmbo)->bo.allowed_domains = domains;
+	(*vmbo)->bo.preferred_domains = domains;
+	return 0;
 }
 
 /**
-- 
2.34.1

