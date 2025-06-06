Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62A4AC5AD49
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Jun 2025 12:57:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CCAC910EA90;
	Fri,  6 Jun 2025 12:57:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="hwOTQM4a";
	dkim-atps=neutral
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com
 [209.85.221.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3743210EA90
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Jun 2025 12:57:28 +0000 (UTC)
Received: by mail-wr1-f47.google.com with SMTP id
 ffacd0b85a97d-3a5096158dcso1794985f8f.1
 for <amd-gfx@lists.freedesktop.org>; Fri, 06 Jun 2025 05:57:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1749214647; x=1749819447; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=9/09N2D8+gzLkjbknhMMJN/UqhyE+TWdg3E+hVs/Tyo=;
 b=hwOTQM4a1m3l5F2Ghx2q+FfyBRpL1GCiB69QrQokiCopht6kaiOJpR0qaBa2qW+2Z6
 s2HWwILOLcRVnYS4itgrL+lt7ciHOL13GsW53vN1uDZqaPBZ6scsV0uL3JXmK0W1HJ0T
 HitYKlRmqBInhj0HBwIqNvmv8Ya5ei9Peq8hjjqT0lByfG2kZfTKUEykxz555wndocpw
 ZbLNWbMCsO9PLdtyKKZJuH6Po4xUjRb23Hic7PlZDbPUPCEUxJUrBYQ468EkLr6rU4SC
 QNFv5Uh54wludgLLMUhXuCyPhRuU76293KZHnZHmQ0WnTI4YxWmaUP+QEkSk+t1xedCU
 hHew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749214647; x=1749819447;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9/09N2D8+gzLkjbknhMMJN/UqhyE+TWdg3E+hVs/Tyo=;
 b=PZsENpL71F3Xs+W2sRjayard3+rWbkGmxUVmEfouou8oRJYNgy4t7bZpLksbA2+vfq
 q3HZ0dNGL5oRMUpwG+SBoO40sedh4KKQa11OE7Zz3fOJI1U1+vpfq9Pw0piv33hHTdHG
 gS1AccGot6rF/t2KY8vvmVCEn4Ftq2dnkEIM9Dgb7mNiIdSz+NISm5MMRkY8qLsqw+ZX
 hC3MF7vuuKvJBO0wzWDp0smbdZdPirCsl1Z9dqGpGYhZH783fgRMOMOh4Qce80bOq1G3
 AKf0cNArCMa8t/LC0AoqtZ8OKOCRV/vJbLjp5VEaC2Hvf7B36X3/B/YOxHtg4qwRs33X
 MgNA==
X-Gm-Message-State: AOJu0Yw4viJ3HJPdjayhyC8vK6WresO7rs/r7ZnW7v6IxFzUEr8Wx/HR
 FcoDv0GGzJQ8eZaZItRvSaF3wYhL9zFAmXU2CGxBimvaomwLbXn4ltR9pxDZRdjEIlg=
X-Gm-Gg: ASbGncvyc/0fIAg3cK88dTLKePqV5ul3s8Xt+orZkT7qA3D6YIPCYcLiCzN/Lzu5BQB
 kpkfHN3qwkCimpp9ZEWt9tqXs6du6TZ2MSACCeMyAO7+oVmzFyfUQLLbeTcB+4CklvZFbNy/mie
 D9KxsKDKQ1wdSl+BKrJW5IPdUGQyvQ2nc0W89IJMRTsPF/vj2//rtGTJcYPm2SBnFUbspymsN7C
 h0wuPr+JmMWbOGK4Oxpbv2alzr/1+9AS+H0NdQmiOoMyxgh+GiDfyZo4gT65jcXrOgxL3OMWj8e
 Aw/g0SgQUn7YjNYTZRaI4W5Cv4KWPy5wWH7kSef8lombhDrJs/wKVz5IWoAS8xu2
X-Google-Smtp-Source: AGHT+IEHwfifD7dZwQ7eGky4I0EudvI8vSL9kwkiWRRhx9enposs+yweUkIeWOQqm42pTp39VKC+3Q==
X-Received: by 2002:a05:6000:288f:b0:3a4:ef00:a78c with SMTP id
 ffacd0b85a97d-3a531ceb99emr3234716f8f.55.1749214646330; 
 Fri, 06 Jun 2025 05:57:26 -0700 (PDT)
Received: from able.fritz.box ([2a00:e180:1565:ad00:26a5:e8c7:a8d0:1cac])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45209bc6d6dsm23539075e9.3.2025.06.06.05.57.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Jun 2025 05:57:25 -0700 (PDT)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: amd-gfx@lists.freedesktop.org, rajneesh.bhardwaj@amd.com,
 felix.kuehling@amd.com, david.francis@amd.com
Subject: [PATCH 2/3] drm/amdgpu: rework how PTE flags are generated
Date: Fri,  6 Jun 2025 14:57:22 +0200
Message-Id: <20250606125723.7822-2-christian.koenig@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250606125723.7822-1-christian.koenig@amd.com>
References: <20250606125723.7822-1-christian.koenig@amd.com>
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

Previously we tried to keep the HW specific PTE flags in each mapping,
but for CRIU that isn't sufficient any more since the original value is
needed for the checkpoint procedure.

So rework the whole handling, nuke the early mapping function, keep the
UAPI flags in each mapping instead of the HW flags and translate them to
the HW flags while filling in the PTEs.

Only tested on Navi 23 for now, so probably needs quite a bit of more
work.

Signed-off-by: Christian König <christian.koenig@amd.com>
---
 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c  |  9 ++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c       | 37 +----------
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.h       |  1 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h       | 15 ++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.h    |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_seq64.c     |  8 +--
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c        | 17 +++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h        |  4 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c        | 57 +++++++++--------
 drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c        | 57 +++++++++--------
 drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c        | 56 ++++++++---------
 drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c         |  4 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c         |  4 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c         | 10 ++-
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c         | 61 +++++++++----------
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c          |  6 +-
 16 files changed, 161 insertions(+), 187 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index 260165bbe373..9e66d6108a9e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -494,17 +494,20 @@ static int vm_update_pds(struct amdgpu_vm *vm, struct amdgpu_sync *sync)
 	return amdgpu_sync_fence(sync, vm->last_update, GFP_KERNEL);
 }
 
-static uint64_t get_pte_flags(struct amdgpu_device *adev, struct kgd_mem *mem)
+static uint64_t get_pte_flags(struct amdgpu_device *adev, struct amdgpu_vm *vm,
+			      struct kgd_mem *mem)
 {
 	uint32_t mapping_flags = AMDGPU_VM_PAGE_READABLE |
 				 AMDGPU_VM_MTYPE_DEFAULT;
+	uint64_t pte_flags = 0;
 
 	if (mem->alloc_flags & KFD_IOC_ALLOC_MEM_FLAGS_WRITABLE)
 		mapping_flags |= AMDGPU_VM_PAGE_WRITEABLE;
 	if (mem->alloc_flags & KFD_IOC_ALLOC_MEM_FLAGS_EXECUTABLE)
 		mapping_flags |= AMDGPU_VM_PAGE_EXECUTABLE;
 
-	return amdgpu_gem_va_map_flags(adev, mapping_flags);
+	amdgpu_gmc_get_vm_pte(adev, vm, NULL, mapping_flags, &pte_flags);
+	return pte_flags;
 }
 
 /**
@@ -961,7 +964,7 @@ static int kfd_mem_attach(struct amdgpu_device *adev, struct kgd_mem *mem,
 			goto unwind;
 		}
 		attachment[i]->va = va;
-		attachment[i]->pte_flags = get_pte_flags(adev, mem);
+		attachment[i]->pte_flags = get_pte_flags(adev, vm, mem);
 		attachment[i]->adev = adev;
 		list_add(&attachment[i]->list, &mem->attachments);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
index 0ecc88df7208..1e335ffbf2df 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
@@ -791,36 +791,6 @@ amdgpu_gem_va_update_vm(struct amdgpu_device *adev,
 	return fence;
 }
 
-/**
- * amdgpu_gem_va_map_flags - map GEM UAPI flags into hardware flags
- *
- * @adev: amdgpu_device pointer
- * @flags: GEM UAPI flags
- *
- * Returns the GEM UAPI flags mapped into hardware for the ASIC.
- */
-uint64_t amdgpu_gem_va_map_flags(struct amdgpu_device *adev, uint32_t flags)
-{
-	uint64_t pte_flag = 0;
-
-	if (flags & AMDGPU_VM_PAGE_EXECUTABLE)
-		pte_flag |= AMDGPU_PTE_EXECUTABLE;
-	if (flags & AMDGPU_VM_PAGE_READABLE)
-		pte_flag |= AMDGPU_PTE_READABLE;
-	if (flags & AMDGPU_VM_PAGE_WRITEABLE)
-		pte_flag |= AMDGPU_PTE_WRITEABLE;
-	if (flags & AMDGPU_VM_PAGE_PRT)
-		pte_flag |= AMDGPU_PTE_PRT_FLAG(adev);
-	if (flags & AMDGPU_VM_PAGE_NOALLOC)
-		pte_flag |= AMDGPU_PTE_NOALLOC;
-
-	if (adev->gmc.gmc_funcs->map_mtype)
-		pte_flag |= amdgpu_gmc_map_mtype(adev,
-						 flags & AMDGPU_VM_MTYPE_MASK);
-
-	return pte_flag;
-}
-
 int amdgpu_gem_va_ioctl(struct drm_device *dev, void *data,
 			  struct drm_file *filp)
 {
@@ -841,7 +811,6 @@ int amdgpu_gem_va_ioctl(struct drm_device *dev, void *data,
 	struct dma_fence_chain *timeline_chain = NULL;
 	struct dma_fence *fence;
 	struct drm_exec exec;
-	uint64_t va_flags;
 	uint64_t vm_size;
 	int r = 0;
 
@@ -945,10 +914,9 @@ int amdgpu_gem_va_ioctl(struct drm_device *dev, void *data,
 
 	switch (args->operation) {
 	case AMDGPU_VA_OP_MAP:
-		va_flags = amdgpu_gem_va_map_flags(adev, args->flags);
 		r = amdgpu_vm_bo_map(adev, bo_va, args->va_address,
 				     args->offset_in_bo, args->map_size,
-				     va_flags);
+				     args->flags);
 		break;
 	case AMDGPU_VA_OP_UNMAP:
 		r = amdgpu_vm_bo_unmap(adev, bo_va, args->va_address);
@@ -960,10 +928,9 @@ int amdgpu_gem_va_ioctl(struct drm_device *dev, void *data,
 						args->map_size);
 		break;
 	case AMDGPU_VA_OP_REPLACE:
-		va_flags = amdgpu_gem_va_map_flags(adev, args->flags);
 		r = amdgpu_vm_bo_replace_map(adev, bo_va, args->va_address,
 					     args->offset_in_bo, args->map_size,
-					     va_flags);
+					     args->flags);
 		break;
 	default:
 		break;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.h
index 3a8f57900a3a..b51e8f95ee86 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.h
@@ -63,7 +63,6 @@ int amdgpu_gem_mmap_ioctl(struct drm_device *dev, void *data,
 			  struct drm_file *filp);
 int amdgpu_gem_wait_idle_ioctl(struct drm_device *dev, void *data,
 			      struct drm_file *filp);
-uint64_t amdgpu_gem_va_map_flags(struct amdgpu_device *adev, uint32_t flags);
 int amdgpu_gem_va_ioctl(struct drm_device *dev, void *data,
 			  struct drm_file *filp);
 int amdgpu_gem_op_ioctl(struct drm_device *dev, void *data,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
index 46b2bcbd5025..c69317804071 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
@@ -152,15 +152,15 @@ struct amdgpu_gmc_funcs {
 				   unsigned pasid);
 	/* enable/disable PRT support */
 	void (*set_prt)(struct amdgpu_device *adev, bool enable);
-	/* map mtype to hardware flags */
-	uint64_t (*map_mtype)(struct amdgpu_device *adev, uint32_t flags);
 	/* get the pde for a given mc addr */
 	void (*get_vm_pde)(struct amdgpu_device *adev, int level,
 			   u64 *dst, u64 *flags);
-	/* get the pte flags to use for a BO VA mapping */
+	/* get the pte flags to use for PTEs */
 	void (*get_vm_pte)(struct amdgpu_device *adev,
-			   struct amdgpu_bo_va_mapping *mapping,
-			   uint64_t *flags);
+			   struct amdgpu_vm *vm,
+			   struct amdgpu_bo *bo,
+			   uint32_t vm_flags,
+			   uint64_t *pte_flags);
 	/* override per-page pte flags */
 	void (*override_vm_pte_flags)(struct amdgpu_device *dev,
 				      struct amdgpu_vm *vm,
@@ -354,9 +354,10 @@ struct amdgpu_gmc {
 
 #define amdgpu_gmc_emit_flush_gpu_tlb(r, vmid, addr) (r)->adev->gmc.gmc_funcs->emit_flush_gpu_tlb((r), (vmid), (addr))
 #define amdgpu_gmc_emit_pasid_mapping(r, vmid, pasid) (r)->adev->gmc.gmc_funcs->emit_pasid_mapping((r), (vmid), (pasid))
-#define amdgpu_gmc_map_mtype(adev, flags) (adev)->gmc.gmc_funcs->map_mtype((adev),(flags))
 #define amdgpu_gmc_get_vm_pde(adev, level, dst, flags) (adev)->gmc.gmc_funcs->get_vm_pde((adev), (level), (dst), (flags))
-#define amdgpu_gmc_get_vm_pte(adev, mapping, flags) (adev)->gmc.gmc_funcs->get_vm_pte((adev), (mapping), (flags))
+#define amdgpu_gmc_get_vm_pte(adev, vm, bo, vm_flags, pte_flags) \
+	(adev)->gmc.gmc_funcs->get_vm_pte((adev), (vm), (bo), (vm_flags), \
+					  (pte_flags))
 #define amdgpu_gmc_override_vm_pte_flags(adev, vm, addr, pte_flags)	\
 	(adev)->gmc.gmc_funcs->override_vm_pte_flags			\
 		((adev), (vm), (addr), (pte_flags))
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
index c316920f3450..87523fcd4386 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
@@ -69,7 +69,7 @@ struct amdgpu_bo_va_mapping {
 	uint64_t			last;
 	uint64_t			__subtree_last;
 	uint64_t			offset;
-	uint64_t			flags;
+	uint32_t			flags;
 };
 
 /* User space allocated BO in a VM */
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_seq64.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_seq64.c
index d45ebfb642ca..a0b479d5fff1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_seq64.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_seq64.c
@@ -67,9 +67,9 @@ static inline u64 amdgpu_seq64_get_va_base(struct amdgpu_device *adev)
 int amdgpu_seq64_map(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 		     struct amdgpu_bo_va **bo_va)
 {
-	u64 seq64_addr, va_flags;
 	struct amdgpu_bo *bo;
 	struct drm_exec exec;
+	u64 seq64_addr;
 	int r;
 
 	bo = adev->seq64.sbo;
@@ -94,9 +94,9 @@ int amdgpu_seq64_map(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 
 	seq64_addr = amdgpu_seq64_get_va_base(adev) & AMDGPU_GMC_HOLE_MASK;
 
-	va_flags = amdgpu_gem_va_map_flags(adev, AMDGPU_VM_PAGE_READABLE | AMDGPU_VM_MTYPE_UC);
-	r = amdgpu_vm_bo_map(adev, *bo_va, seq64_addr, 0, AMDGPU_VA_RESERVED_SEQ64_SIZE,
-			     va_flags);
+	r = amdgpu_vm_bo_map(adev, *bo_va, seq64_addr, 0,
+			     AMDGPU_VA_RESERVED_SEQ64_SIZE,
+			     AMDGPU_VM_PAGE_READABLE | AMDGPU_VM_MTYPE_UC);
 	if (r) {
 		DRM_ERROR("failed to do bo_map on userq sem, err=%d\n", r);
 		amdgpu_vm_bo_del(adev, *bo_va);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 3911c78f8282..10d135e71088 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -1328,13 +1328,14 @@ int amdgpu_vm_bo_update(struct amdgpu_device *adev, struct amdgpu_bo_va *bo_va,
 		/* normally,bo_va->flags only contians READABLE and WIRTEABLE bit go here
 		 * but in case of something, we filter the flags in first place
 		 */
-		if (!(mapping->flags & AMDGPU_PTE_READABLE))
+		if (!(mapping->flags & AMDGPU_VM_PAGE_READABLE))
 			update_flags &= ~AMDGPU_PTE_READABLE;
-		if (!(mapping->flags & AMDGPU_PTE_WRITEABLE))
+		if (!(mapping->flags & AMDGPU_VM_PAGE_WRITEABLE))
 			update_flags &= ~AMDGPU_PTE_WRITEABLE;
 
 		/* Apply ASIC specific mapping flags */
-		amdgpu_gmc_get_vm_pte(adev, mapping, &update_flags);
+		amdgpu_gmc_get_vm_pte(adev, vm, bo, mapping->flags,
+				      &update_flags);
 
 		trace_amdgpu_vm_bo_update(mapping);
 
@@ -1475,7 +1476,7 @@ static void amdgpu_vm_free_mapping(struct amdgpu_device *adev,
 				   struct amdgpu_bo_va_mapping *mapping,
 				   struct dma_fence *fence)
 {
-	if (mapping->flags & AMDGPU_PTE_PRT_FLAG(adev))
+	if (mapping->flags & AMDGPU_VM_PAGE_PRT)
 		amdgpu_vm_add_prt_cb(adev, fence);
 	kfree(mapping);
 }
@@ -1754,7 +1755,7 @@ static void amdgpu_vm_bo_insert_map(struct amdgpu_device *adev,
 	list_add(&mapping->list, &bo_va->invalids);
 	amdgpu_vm_it_insert(mapping, &vm->va);
 
-	if (mapping->flags & AMDGPU_PTE_PRT_FLAG(adev))
+	if (mapping->flags & AMDGPU_VM_PAGE_PRT)
 		amdgpu_vm_prt_get(adev);
 
 	if (amdgpu_vm_is_bo_always_valid(vm, bo) && !bo_va->base.moved)
@@ -1814,7 +1815,7 @@ static int amdgpu_vm_verify_parameters(struct amdgpu_device *adev,
 int amdgpu_vm_bo_map(struct amdgpu_device *adev,
 		     struct amdgpu_bo_va *bo_va,
 		     uint64_t saddr, uint64_t offset,
-		     uint64_t size, uint64_t flags)
+		     uint64_t size, uint32_t flags)
 {
 	struct amdgpu_bo_va_mapping *mapping, *tmp;
 	struct amdgpu_bo *bo = bo_va->base.bo;
@@ -1873,7 +1874,7 @@ int amdgpu_vm_bo_map(struct amdgpu_device *adev,
 int amdgpu_vm_bo_replace_map(struct amdgpu_device *adev,
 			     struct amdgpu_bo_va *bo_va,
 			     uint64_t saddr, uint64_t offset,
-			     uint64_t size, uint64_t flags)
+			     uint64_t size, uint32_t flags)
 {
 	struct amdgpu_bo_va_mapping *mapping;
 	struct amdgpu_bo *bo = bo_va->base.bo;
@@ -2730,7 +2731,7 @@ void amdgpu_vm_fini(struct amdgpu_device *adev, struct amdgpu_vm *vm)
 	dma_fence_put(vm->last_tlb_flush);
 
 	list_for_each_entry_safe(mapping, tmp, &vm->freed, list) {
-		if (mapping->flags & AMDGPU_PTE_PRT_FLAG(adev) && prt_fini_needed) {
+		if (mapping->flags & AMDGPU_VM_PAGE_PRT && prt_fini_needed) {
 			amdgpu_vm_prt_fini(adev, vm);
 			prt_fini_needed = false;
 		}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
index f3ad687125ad..f9549f6b3d1f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
@@ -539,11 +539,11 @@ struct amdgpu_bo_va *amdgpu_vm_bo_add(struct amdgpu_device *adev,
 int amdgpu_vm_bo_map(struct amdgpu_device *adev,
 		     struct amdgpu_bo_va *bo_va,
 		     uint64_t addr, uint64_t offset,
-		     uint64_t size, uint64_t flags);
+		     uint64_t size, uint32_t flags);
 int amdgpu_vm_bo_replace_map(struct amdgpu_device *adev,
 			     struct amdgpu_bo_va *bo_va,
 			     uint64_t addr, uint64_t offset,
-			     uint64_t size, uint64_t flags);
+			     uint64_t size, uint32_t flags);
 int amdgpu_vm_bo_unmap(struct amdgpu_device *adev,
 		       struct amdgpu_bo_va *bo_va,
 		       uint64_t addr);
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
index a3e2787501f1..846b67d52dfc 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
@@ -469,24 +469,6 @@ static void gmc_v10_0_emit_pasid_mapping(struct amdgpu_ring *ring, unsigned int
  * 0 valid
  */
 
-static uint64_t gmc_v10_0_map_mtype(struct amdgpu_device *adev, uint32_t flags)
-{
-	switch (flags) {
-	case AMDGPU_VM_MTYPE_DEFAULT:
-		return AMDGPU_PTE_MTYPE_NV10(0ULL, MTYPE_NC);
-	case AMDGPU_VM_MTYPE_NC:
-		return AMDGPU_PTE_MTYPE_NV10(0ULL, MTYPE_NC);
-	case AMDGPU_VM_MTYPE_WC:
-		return AMDGPU_PTE_MTYPE_NV10(0ULL, MTYPE_WC);
-	case AMDGPU_VM_MTYPE_CC:
-		return AMDGPU_PTE_MTYPE_NV10(0ULL, MTYPE_CC);
-	case AMDGPU_VM_MTYPE_UC:
-		return AMDGPU_PTE_MTYPE_NV10(0ULL, MTYPE_UC);
-	default:
-		return AMDGPU_PTE_MTYPE_NV10(0ULL, MTYPE_NC);
-	}
-}
-
 static void gmc_v10_0_get_vm_pde(struct amdgpu_device *adev, int level,
 				 uint64_t *addr, uint64_t *flags)
 {
@@ -511,21 +493,39 @@ static void gmc_v10_0_get_vm_pde(struct amdgpu_device *adev, int level,
 }
 
 static void gmc_v10_0_get_vm_pte(struct amdgpu_device *adev,
-				 struct amdgpu_bo_va_mapping *mapping,
+				 struct amdgpu_vm *vm,
+				 struct amdgpu_bo *bo,
+				 uint32_t vm_flags,
 				 uint64_t *flags)
 {
-	struct amdgpu_bo *bo = mapping->bo_va->base.bo;
-
-	*flags &= ~AMDGPU_PTE_EXECUTABLE;
-	*flags |= mapping->flags & AMDGPU_PTE_EXECUTABLE;
+	if (vm_flags & AMDGPU_VM_PAGE_EXECUTABLE)
+		*flags |= AMDGPU_PTE_EXECUTABLE;
+	else
+		*flags &= ~AMDGPU_PTE_EXECUTABLE;
 
-	*flags &= ~AMDGPU_PTE_MTYPE_NV10_MASK;
-	*flags |= (mapping->flags & AMDGPU_PTE_MTYPE_NV10_MASK);
+	switch (vm_flags & AMDGPU_VM_MTYPE_MASK) {
+	case AMDGPU_VM_MTYPE_DEFAULT:
+	case AMDGPU_VM_MTYPE_NC:
+	default:
+		*flags = AMDGPU_PTE_MTYPE_NV10(*flags, MTYPE_NC);
+		break;
+	case AMDGPU_VM_MTYPE_WC:
+		*flags = AMDGPU_PTE_MTYPE_NV10(*flags, MTYPE_WC);
+		break;
+	case AMDGPU_VM_MTYPE_CC:
+		*flags = AMDGPU_PTE_MTYPE_NV10(*flags, MTYPE_CC);
+		break;
+	case AMDGPU_VM_MTYPE_UC:
+		*flags = AMDGPU_PTE_MTYPE_NV10(*flags, MTYPE_UC);
+		break;
+	}
 
-	*flags &= ~AMDGPU_PTE_NOALLOC;
-	*flags |= (mapping->flags & AMDGPU_PTE_NOALLOC);
+	if (vm_flags & AMDGPU_VM_PAGE_NOALLOC)
+		*flags |= AMDGPU_PTE_NOALLOC;
+	else
+		*flags &= ~AMDGPU_PTE_NOALLOC;
 
-	if (mapping->flags & AMDGPU_PTE_PRT) {
+	if (vm_flags & AMDGPU_VM_PAGE_PRT) {
 		*flags |= AMDGPU_PTE_PRT;
 		*flags |= AMDGPU_PTE_SNOOPED;
 		*flags |= AMDGPU_PTE_LOG;
@@ -566,7 +566,6 @@ static const struct amdgpu_gmc_funcs gmc_v10_0_gmc_funcs = {
 	.flush_gpu_tlb_pasid = gmc_v10_0_flush_gpu_tlb_pasid,
 	.emit_flush_gpu_tlb = gmc_v10_0_emit_flush_gpu_tlb,
 	.emit_pasid_mapping = gmc_v10_0_emit_pasid_mapping,
-	.map_mtype = gmc_v10_0_map_mtype,
 	.get_vm_pde = gmc_v10_0_get_vm_pde,
 	.get_vm_pte = gmc_v10_0_get_vm_pte,
 	.get_vbios_fb_size = gmc_v10_0_get_vbios_fb_size,
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
index 72211409227b..36720d1c07a0 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
@@ -433,24 +433,6 @@ static void gmc_v11_0_emit_pasid_mapping(struct amdgpu_ring *ring, unsigned int
  * 0 valid
  */
 
-static uint64_t gmc_v11_0_map_mtype(struct amdgpu_device *adev, uint32_t flags)
-{
-	switch (flags) {
-	case AMDGPU_VM_MTYPE_DEFAULT:
-		return AMDGPU_PTE_MTYPE_NV10(0ULL, MTYPE_NC);
-	case AMDGPU_VM_MTYPE_NC:
-		return AMDGPU_PTE_MTYPE_NV10(0ULL, MTYPE_NC);
-	case AMDGPU_VM_MTYPE_WC:
-		return AMDGPU_PTE_MTYPE_NV10(0ULL, MTYPE_WC);
-	case AMDGPU_VM_MTYPE_CC:
-		return AMDGPU_PTE_MTYPE_NV10(0ULL, MTYPE_CC);
-	case AMDGPU_VM_MTYPE_UC:
-		return AMDGPU_PTE_MTYPE_NV10(0ULL, MTYPE_UC);
-	default:
-		return AMDGPU_PTE_MTYPE_NV10(0ULL, MTYPE_NC);
-	}
-}
-
 static void gmc_v11_0_get_vm_pde(struct amdgpu_device *adev, int level,
 				 uint64_t *addr, uint64_t *flags)
 {
@@ -475,21 +457,39 @@ static void gmc_v11_0_get_vm_pde(struct amdgpu_device *adev, int level,
 }
 
 static void gmc_v11_0_get_vm_pte(struct amdgpu_device *adev,
-				 struct amdgpu_bo_va_mapping *mapping,
+				 struct amdgpu_vm *vm,
+				 struct amdgpu_bo *bo,
+				 uint32_t vm_flags,
 				 uint64_t *flags)
 {
-	struct amdgpu_bo *bo = mapping->bo_va->base.bo;
-
-	*flags &= ~AMDGPU_PTE_EXECUTABLE;
-	*flags |= mapping->flags & AMDGPU_PTE_EXECUTABLE;
+	if (vm_flags & AMDGPU_VM_PAGE_EXECUTABLE)
+		*flags |= AMDGPU_PTE_EXECUTABLE;
+	else
+		*flags &= ~AMDGPU_PTE_EXECUTABLE;
 
-	*flags &= ~AMDGPU_PTE_MTYPE_NV10_MASK;
-	*flags |= (mapping->flags & AMDGPU_PTE_MTYPE_NV10_MASK);
+	switch (vm_flags & AMDGPU_VM_MTYPE_MASK) {
+	case AMDGPU_VM_MTYPE_DEFAULT:
+	case AMDGPU_VM_MTYPE_NC:
+	default:
+		*flags = AMDGPU_PTE_MTYPE_NV10(*flags, MTYPE_NC);
+		break;
+	case AMDGPU_VM_MTYPE_WC:
+		*flags = AMDGPU_PTE_MTYPE_NV10(*flags, MTYPE_WC);
+		break;
+	case AMDGPU_VM_MTYPE_CC:
+		*flags = AMDGPU_PTE_MTYPE_NV10(*flags, MTYPE_CC);
+		break;
+	case AMDGPU_VM_MTYPE_UC:
+		*flags = AMDGPU_PTE_MTYPE_NV10(*flags, MTYPE_UC);
+		break;
+	}
 
-	*flags &= ~AMDGPU_PTE_NOALLOC;
-	*flags |= (mapping->flags & AMDGPU_PTE_NOALLOC);
+	if (vm_flags & AMDGPU_VM_PAGE_NOALLOC)
+		*flags |= AMDGPU_PTE_NOALLOC;
+	else
+		*flags &= ~AMDGPU_PTE_NOALLOC;
 
-	if (mapping->flags & AMDGPU_PTE_PRT) {
+	if (vm_flags & AMDGPU_VM_PAGE_PRT) {
 		*flags |= AMDGPU_PTE_PRT;
 		*flags |= AMDGPU_PTE_SNOOPED;
 		*flags |= AMDGPU_PTE_LOG;
@@ -530,7 +530,6 @@ static const struct amdgpu_gmc_funcs gmc_v11_0_gmc_funcs = {
 	.flush_gpu_tlb_pasid = gmc_v11_0_flush_gpu_tlb_pasid,
 	.emit_flush_gpu_tlb = gmc_v11_0_emit_flush_gpu_tlb,
 	.emit_pasid_mapping = gmc_v11_0_emit_pasid_mapping,
-	.map_mtype = gmc_v11_0_map_mtype,
 	.get_vm_pde = gmc_v11_0_get_vm_pde,
 	.get_vm_pte = gmc_v11_0_get_vm_pte,
 	.get_vbios_fb_size = gmc_v11_0_get_vbios_fb_size,
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
index b645d3e6a6c8..fb3fb31724a8 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
@@ -456,20 +456,6 @@ static void gmc_v12_0_emit_pasid_mapping(struct amdgpu_ring *ring, unsigned vmid
  * 0 valid
  */
 
-static uint64_t gmc_v12_0_map_mtype(struct amdgpu_device *adev, uint32_t flags)
-{
-	switch (flags) {
-	case AMDGPU_VM_MTYPE_DEFAULT:
-		return AMDGPU_PTE_MTYPE_GFX12(0ULL, MTYPE_NC);
-	case AMDGPU_VM_MTYPE_NC:
-		return AMDGPU_PTE_MTYPE_GFX12(0ULL, MTYPE_NC);
-	case AMDGPU_VM_MTYPE_UC:
-		return AMDGPU_PTE_MTYPE_GFX12(0ULL, MTYPE_UC);
-	default:
-		return AMDGPU_PTE_MTYPE_GFX12(0ULL, MTYPE_NC);
-	}
-}
-
 static void gmc_v12_0_get_vm_pde(struct amdgpu_device *adev, int level,
 				 uint64_t *addr, uint64_t *flags)
 {
@@ -493,30 +479,45 @@ static void gmc_v12_0_get_vm_pde(struct amdgpu_device *adev, int level,
 }
 
 static void gmc_v12_0_get_vm_pte(struct amdgpu_device *adev,
-				 struct amdgpu_bo_va_mapping *mapping,
+				 struct amdgpu_vm *vm,
+				 struct amdgpu_bo *bo,
+				 uint32_t vm_flags,
 				 uint64_t *flags)
 {
-	struct amdgpu_bo *bo = mapping->bo_va->base.bo;
+	if (vm_flags & AMDGPU_VM_PAGE_EXECUTABLE)
+		*flags |= AMDGPU_PTE_EXECUTABLE;
+	else
+		*flags &= ~AMDGPU_PTE_EXECUTABLE;
 
-	*flags &= ~AMDGPU_PTE_EXECUTABLE;
-	*flags |= mapping->flags & AMDGPU_PTE_EXECUTABLE;
+	switch (vm_flags & AMDGPU_VM_MTYPE_MASK) {
+	case AMDGPU_VM_MTYPE_DEFAULT:
+		*flags = AMDGPU_PTE_MTYPE_GFX12(*flags, MTYPE_NC);
+		break;
+	case AMDGPU_VM_MTYPE_NC:
+	default:
+		*flags = AMDGPU_PTE_MTYPE_GFX12(*flags, MTYPE_NC);
+		break;
+	case AMDGPU_VM_MTYPE_UC:
+		*flags = AMDGPU_PTE_MTYPE_GFX12(*flags, MTYPE_UC);
+		break;
+	}
 
-	*flags &= ~AMDGPU_PTE_MTYPE_GFX12_MASK;
-	*flags |= (mapping->flags & AMDGPU_PTE_MTYPE_GFX12_MASK);
+	if (vm_flags & AMDGPU_VM_PAGE_NOALLOC)
+		*flags |= AMDGPU_PTE_NOALLOC;
+	else
+		*flags &= ~AMDGPU_PTE_NOALLOC;
 
-	if (mapping->flags & AMDGPU_PTE_PRT_GFX12) {
-		*flags |= AMDGPU_PTE_PRT_GFX12;
+	if (vm_flags & AMDGPU_VM_PAGE_PRT) {
 		*flags |= AMDGPU_PTE_SNOOPED;
 		*flags |= AMDGPU_PTE_SYSTEM;
 		*flags |= AMDGPU_PTE_IS_PTE;
 		*flags &= ~AMDGPU_PTE_VALID;
 	}
 
-	if (bo && bo->flags & AMDGPU_GEM_CREATE_GFX12_DCC)
-		*flags |= AMDGPU_PTE_DCC;
-
-	if (bo && bo->flags & AMDGPU_GEM_CREATE_UNCACHED)
-		*flags = AMDGPU_PTE_MTYPE_GFX12(*flags, MTYPE_UC);
+	if (bo && bo->flags & (AMDGPU_GEM_CREATE_COHERENT |
+			       AMDGPU_GEM_CREATE_EXT_COHERENT |
+			       AMDGPU_GEM_CREATE_UNCACHED))
+		*flags = AMDGPU_PTE_MTYPE_NV10(*flags, MTYPE_UC);
 }
 
 static unsigned gmc_v12_0_get_vbios_fb_size(struct amdgpu_device *adev)
@@ -546,7 +547,6 @@ static const struct amdgpu_gmc_funcs gmc_v12_0_gmc_funcs = {
 	.flush_gpu_tlb_pasid = gmc_v12_0_flush_gpu_tlb_pasid,
 	.emit_flush_gpu_tlb = gmc_v12_0_emit_flush_gpu_tlb,
 	.emit_pasid_mapping = gmc_v12_0_emit_pasid_mapping,
-	.map_mtype = gmc_v12_0_map_mtype,
 	.get_vm_pde = gmc_v12_0_get_vm_pde,
 	.get_vm_pte = gmc_v12_0_get_vm_pte,
 	.get_vbios_fb_size = gmc_v12_0_get_vbios_fb_size,
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
index 8030fcd64210..f6ad7911f1e6 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
@@ -382,7 +382,9 @@ static void gmc_v6_0_get_vm_pde(struct amdgpu_device *adev, int level,
 }
 
 static void gmc_v6_0_get_vm_pte(struct amdgpu_device *adev,
-				struct amdgpu_bo_va_mapping *mapping,
+				struct amdgpu_vm *vm,
+				struct amdgpu_bo *bo,
+				uint32_t vm_flags,
 				uint64_t *flags)
 {
 	*flags &= ~AMDGPU_PTE_EXECUTABLE;
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
index a8d5795084fc..93d7ccb7d013 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
@@ -504,7 +504,9 @@ static void gmc_v7_0_get_vm_pde(struct amdgpu_device *adev, int level,
 }
 
 static void gmc_v7_0_get_vm_pte(struct amdgpu_device *adev,
-				struct amdgpu_bo_va_mapping *mapping,
+				struct amdgpu_vm *vm,
+				struct amdgpu_bo *bo,
+				uint32_t vm_flags,
 				uint64_t *flags)
 {
 	*flags &= ~AMDGPU_PTE_EXECUTABLE;
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
index 99ca08e9bdb5..1ea198fcb51f 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
@@ -716,11 +716,15 @@ static void gmc_v8_0_get_vm_pde(struct amdgpu_device *adev, int level,
 }
 
 static void gmc_v8_0_get_vm_pte(struct amdgpu_device *adev,
-				struct amdgpu_bo_va_mapping *mapping,
+				struct amdgpu_vm *vm,
+				struct amdgpu_bo *bo,
+				uint32_t vm_flags,
 				uint64_t *flags)
 {
-	*flags &= ~AMDGPU_PTE_EXECUTABLE;
-	*flags |= mapping->flags & AMDGPU_PTE_EXECUTABLE;
+	if (vm_flags & AMDGPU_VM_PAGE_EXECUTABLE)
+		*flags |= AMDGPU_PTE_EXECUTABLE;
+	else
+		*flags &= ~AMDGPU_PTE_EXECUTABLE;
 	*flags &= ~AMDGPU_PTE_PRT;
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index cad014c3bbf7..aa2ea1078cb8 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -1084,27 +1084,6 @@ static void gmc_v9_0_emit_pasid_mapping(struct amdgpu_ring *ring, unsigned int v
  * 0 valid
  */
 
-static uint64_t gmc_v9_0_map_mtype(struct amdgpu_device *adev, uint32_t flags)
-
-{
-	switch (flags) {
-	case AMDGPU_VM_MTYPE_DEFAULT:
-		return AMDGPU_PTE_MTYPE_VG10(0ULL, MTYPE_NC);
-	case AMDGPU_VM_MTYPE_NC:
-		return AMDGPU_PTE_MTYPE_VG10(0ULL, MTYPE_NC);
-	case AMDGPU_VM_MTYPE_WC:
-		return AMDGPU_PTE_MTYPE_VG10(0ULL, MTYPE_WC);
-	case AMDGPU_VM_MTYPE_RW:
-		return AMDGPU_PTE_MTYPE_VG10(0ULL, MTYPE_RW);
-	case AMDGPU_VM_MTYPE_CC:
-		return AMDGPU_PTE_MTYPE_VG10(0ULL, MTYPE_CC);
-	case AMDGPU_VM_MTYPE_UC:
-		return AMDGPU_PTE_MTYPE_VG10(0ULL, MTYPE_UC);
-	default:
-		return AMDGPU_PTE_MTYPE_VG10(0ULL, MTYPE_NC);
-	}
-}
-
 static void gmc_v9_0_get_vm_pde(struct amdgpu_device *adev, int level,
 				uint64_t *addr, uint64_t *flags)
 {
@@ -1134,6 +1113,7 @@ static void gmc_v9_0_get_vm_pde(struct amdgpu_device *adev, int level,
 static void gmc_v9_0_get_coherence_flags(struct amdgpu_device *adev,
 					 struct amdgpu_vm *vm,
 					 struct amdgpu_bo *bo,
+					 uint32_t vm_flags,
 					 uint64_t *flags)
 {
 	struct amdgpu_device *bo_adev = amdgpu_ttm_adev(bo->tbo.bdev);
@@ -1247,25 +1227,43 @@ static void gmc_v9_0_get_coherence_flags(struct amdgpu_device *adev,
 }
 
 static void gmc_v9_0_get_vm_pte(struct amdgpu_device *adev,
-				struct amdgpu_bo_va_mapping *mapping,
+				struct amdgpu_vm *vm,
+				struct amdgpu_bo *bo,
+				uint32_t vm_flags,
 				uint64_t *flags)
 {
-	struct amdgpu_bo *bo = mapping->bo_va->base.bo;
-
-	*flags &= ~AMDGPU_PTE_EXECUTABLE;
-	*flags |= mapping->flags & AMDGPU_PTE_EXECUTABLE;
+	if (vm_flags & AMDGPU_VM_PAGE_EXECUTABLE)
+		*flags |= AMDGPU_PTE_EXECUTABLE;
+	else
+		*flags &= ~AMDGPU_PTE_EXECUTABLE;
 
-	*flags &= ~AMDGPU_PTE_MTYPE_VG10_MASK;
-	*flags |= mapping->flags & AMDGPU_PTE_MTYPE_VG10_MASK;
+	switch (vm_flags & AMDGPU_VM_MTYPE_MASK) {
+	case AMDGPU_VM_MTYPE_DEFAULT:
+	case AMDGPU_VM_MTYPE_NC:
+	default:
+		*flags = AMDGPU_PTE_MTYPE_VG10(*flags, MTYPE_NC);
+		break;
+	case AMDGPU_VM_MTYPE_WC:
+		*flags |= AMDGPU_PTE_MTYPE_VG10(*flags, MTYPE_WC);
+		break;
+	case AMDGPU_VM_MTYPE_RW:
+		*flags |= AMDGPU_PTE_MTYPE_VG10(*flags, MTYPE_RW);
+		break;
+	case AMDGPU_VM_MTYPE_CC:
+		*flags |= AMDGPU_PTE_MTYPE_VG10(*flags, MTYPE_CC);
+		break;
+	case AMDGPU_VM_MTYPE_UC:
+		*flags |= AMDGPU_PTE_MTYPE_VG10(*flags, MTYPE_UC);
+		break;
+	}
 
-	if (mapping->flags & AMDGPU_PTE_PRT) {
+	if (vm_flags & AMDGPU_VM_PAGE_PRT) {
 		*flags |= AMDGPU_PTE_PRT;
 		*flags &= ~AMDGPU_PTE_VALID;
 	}
 
 	if ((*flags & AMDGPU_PTE_VALID) && bo)
-		gmc_v9_0_get_coherence_flags(adev, mapping->bo_va->base.vm, bo,
-					     flags);
+		gmc_v9_0_get_coherence_flags(adev, vm, bo, vm_flags, flags);
 }
 
 static void gmc_v9_0_override_vm_pte_flags(struct amdgpu_device *adev,
@@ -1442,7 +1440,6 @@ static const struct amdgpu_gmc_funcs gmc_v9_0_gmc_funcs = {
 	.flush_gpu_tlb_pasid = gmc_v9_0_flush_gpu_tlb_pasid,
 	.emit_flush_gpu_tlb = gmc_v9_0_emit_flush_gpu_tlb,
 	.emit_pasid_mapping = gmc_v9_0_emit_pasid_mapping,
-	.map_mtype = gmc_v9_0_map_mtype,
 	.get_vm_pde = gmc_v9_0_get_vm_pde,
 	.get_vm_pte = gmc_v9_0_get_vm_pte,
 	.override_vm_pte_flags = gmc_v9_0_override_vm_pte_flags,
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index 865dca2547de..4cdd585de0be 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -1190,7 +1190,7 @@ svm_nodes_in_same_hive(struct kfd_node *node_a, struct kfd_node *node_b)
 }
 
 static uint64_t
-svm_range_get_pte_flags(struct kfd_node *node,
+svm_range_get_pte_flags(struct kfd_node *node, struct amdgpu_vm *vm,
 			struct svm_range *prange, int domain)
 {
 	struct kfd_node *bo_node;
@@ -1306,7 +1306,7 @@ svm_range_get_pte_flags(struct kfd_node *node,
 	if (gc_ip_version >= IP_VERSION(12, 0, 0))
 		pte_flags |= AMDGPU_PTE_IS_PTE;
 
-	pte_flags |= amdgpu_gem_va_map_flags(node->adev, mapping_flags);
+	amdgpu_gmc_get_vm_pte(node->adev, vm, NULL, mapping_flags, &pte_flags);
 	return pte_flags;
 }
 
@@ -1413,7 +1413,7 @@ svm_range_map_to_gpu(struct kfd_process_device *pdd, struct svm_range *prange,
 		pr_debug("Mapping range [0x%lx 0x%llx] on domain: %s\n",
 			 last_start, prange->start + i, last_domain ? "GPU" : "CPU");
 
-		pte_flags = svm_range_get_pte_flags(pdd->dev, prange, last_domain);
+		pte_flags = svm_range_get_pte_flags(pdd->dev, vm, prange, last_domain);
 		if (readonly)
 			pte_flags &= ~AMDGPU_PTE_WRITEABLE;
 
-- 
2.34.1

