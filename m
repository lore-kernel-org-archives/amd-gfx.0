Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4CEBC83F03
	for <amd-gfx@archiver.kernel.org>; Wed,  9 Jul 2025 12:51:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2D62910E7DC;
	Wed,  9 Jul 2025 12:51:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="lYz+r86L";
	dkim-atps=neutral
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com
 [209.85.128.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2D2F210E7D6
 for <amd-gfx@lists.freedesktop.org>; Wed,  9 Jul 2025 12:51:23 +0000 (UTC)
Received: by mail-wm1-f52.google.com with SMTP id
 5b1f17b1804b1-451d54214adso39641345e9.3
 for <amd-gfx@lists.freedesktop.org>; Wed, 09 Jul 2025 05:51:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1752065482; x=1752670282; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Wj29CJ+AqV4p2Qh5kaP5OJIkyK+y/aVubFNThxh2CbE=;
 b=lYz+r86L25S6iDXM76CFXP1yzxO+mMHeB71RWE+Lf36XsGUXYxgXtIYvXbBIdXeu6F
 CXsBCIK23ITbX1CYlp+Y2cyIkRnQ9se7FdgIXkXoKMCXivmeMxF9uaMQzwy5bjLObBmL
 BEZz0VDHkKJuqjuUuBhIXSxWTTFgziWWD0VGZ+N1AmHCFDGvjfrdlPaV6hr/RHJxM764
 CLw7pHYJCA42sXmCSAw/IfRmSCGG8ewEWwvHAPEc+8X1ZyiWTUJCOhHUO1ovSr44vknP
 dt99INKv5Yu/nrWtG1NBhyC+OnzX1uQAbW5zndmDOw3vLlj/42ZaXVwaBIco7S4qQZgJ
 2Jmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752065482; x=1752670282;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Wj29CJ+AqV4p2Qh5kaP5OJIkyK+y/aVubFNThxh2CbE=;
 b=h22iSIYtbaXPGkLGL1mBRL354JQ0i6R1FZyeipN0f52Ogy0cdWDDijel2/6gVFYYxy
 dr5AbLoaO2WnbW3eONTHardNDVySr8pVPMpaJzHyptzB5nou7CTC/gAeysBi6XzlM3ar
 KX/6kpDhobcJ2qhgbRe7mNoZQ/+H9gnoibKSzZ5Qx4QOncuW1gW8fdQGeo/8BVBJP0Qq
 frlBWFVd9sfmy9+79cTGjXdGc84c1Wtpd1tepBxlCGG8IgQdcYRkUDN5G/9a/XiTav6Q
 ufKiJYultC6PTgTSzXWXkTjR4GJaxNEsHCXFlZOEqNcSGjX/dsttqTrnSVUAuoyruSE+
 g8GA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXLjbpYJ3v8M8/jQ4JTf+b5L1PEzxNtpw4GPWPwumAt512zDq3jgkE3w5i9T/Vr1x+iM5E5M+XY@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyZA2qXmV16A+M5r145I9o1DAr2YvFGBwoPJq7qrNGas11ysDRY
 tfk4kRhZtNQ5CRSWFX6pdp4vpD2WNRAoN0no24ttQ+uMqkZzr6WBrRB7AHKE9A==
X-Gm-Gg: ASbGncs46ZRBaVNo3kEq3QNP19HtJ9sXIsAS84BXOnbnHyZ1j3lrp0jEvHjKEeNP02S
 u2M8aMQXDRbrBFHsSXq7DQ9xhL5QDmy0XWruOeJFODEIzIzMgANZwQJ+LZ4kmYeSEYYXqeeoOw8
 IMwf+D36ZfNx2yn3UbNlP+jvXURim+UyPb406KkF2KzoTqvTQVBXr/tKnToxX4K3eOTTbcFFB62
 ASJLRbdI5ZudrTm0PnzL9TMk+l8NRtKn5LrNktbuBBX3BfWCHBA3AzIj5MW3kz7CgoRmEU/3BFg
 ceSdxDCJGkxFfd6op8RX4AmqxdZSe/sE7IiFTfdLgmuEjVwV1caNYZFo1TRn8Ef7Aaa5YjSuIOM
 =
X-Google-Smtp-Source: AGHT+IEcEosy7RHx/TODywzYhYfb7qUPs35iQnXlujA7PJrKFkFF1PnME2MwUkn5ZNyRJws0j6Dd0g==
X-Received: by 2002:a05:600c:c4a3:b0:442:f956:53f9 with SMTP id
 5b1f17b1804b1-454d53a63dbmr23051785e9.18.1752065480975; 
 Wed, 09 Jul 2025 05:51:20 -0700 (PDT)
Received: from able.fritz.box ([2a00:e180:151c:7900:7436:f040:34aa:3634])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b47225a491sm15728798f8f.76.2025.07.09.05.51.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Jul 2025 05:51:20 -0700 (PDT)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: felix.kuehling@amd.com, david.francis@amd.com,
 amd-gfx@lists.freedesktop.org
Subject: [PATCH 2/2] drm/amdgpu: rework how PTE flags are generated v2
Date: Wed,  9 Jul 2025 14:51:19 +0200
Message-Id: <20250709125119.1606-2-christian.koenig@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250709125119.1606-1-christian.koenig@amd.com>
References: <20250709125119.1606-1-christian.koenig@amd.com>
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

v2: fix KFD and SVN handling

Signed-off-by: Christian König <christian.koenig@amd.com>
---
 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c  |  7 ++-
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
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c          |  9 ++-
 16 files changed, 160 insertions(+), 189 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index 260165bbe373..37d8a7034a7e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -494,7 +494,8 @@ static int vm_update_pds(struct amdgpu_vm *vm, struct amdgpu_sync *sync)
 	return amdgpu_sync_fence(sync, vm->last_update, GFP_KERNEL);
 }
 
-static uint64_t get_pte_flags(struct amdgpu_device *adev, struct kgd_mem *mem)
+static uint64_t get_pte_flags(struct amdgpu_device *adev, struct amdgpu_vm *vm,
+			      struct kgd_mem *mem)
 {
 	uint32_t mapping_flags = AMDGPU_VM_PAGE_READABLE |
 				 AMDGPU_VM_MTYPE_DEFAULT;
@@ -504,7 +505,7 @@ static uint64_t get_pte_flags(struct amdgpu_device *adev, struct kgd_mem *mem)
 	if (mem->alloc_flags & KFD_IOC_ALLOC_MEM_FLAGS_EXECUTABLE)
 		mapping_flags |= AMDGPU_VM_PAGE_EXECUTABLE;
 
-	return amdgpu_gem_va_map_flags(adev, mapping_flags);
+	return mapping_flags;
 }
 
 /**
@@ -961,7 +962,7 @@ static int kfd_mem_attach(struct amdgpu_device *adev, struct kgd_mem *mem,
 			goto unwind;
 		}
 		attachment[i]->va = va;
-		attachment[i]->pte_flags = get_pte_flags(adev, mem);
+		attachment[i]->pte_flags = get_pte_flags(adev, vm, mem);
 		attachment[i]->adev = adev;
 		list_add(&attachment[i]->list, &mem->attachments);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
index b4cea08f4886..e3f65977eeee 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
@@ -790,36 +790,6 @@ amdgpu_gem_va_update_vm(struct amdgpu_device *adev,
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
@@ -840,7 +810,6 @@ int amdgpu_gem_va_ioctl(struct drm_device *dev, void *data,
 	struct dma_fence_chain *timeline_chain = NULL;
 	struct dma_fence *fence;
 	struct drm_exec exec;
-	uint64_t va_flags;
 	uint64_t vm_size;
 	int r = 0;
 
@@ -944,10 +913,9 @@ int amdgpu_gem_va_ioctl(struct drm_device *dev, void *data,
 
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
@@ -959,10 +927,9 @@ int amdgpu_gem_va_ioctl(struct drm_device *dev, void *data,
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
index 397c6ccdb903..57ad7a9e3747 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
@@ -154,15 +154,15 @@ struct amdgpu_gmc_funcs {
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
@@ -356,9 +356,10 @@ struct amdgpu_gmc {
 
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
index f042372d9f2e..e1c9f34bbcb7 100644
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
@@ -2731,7 +2732,7 @@ void amdgpu_vm_fini(struct amdgpu_device *adev, struct amdgpu_vm *vm)
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
index 71f134d54fe1..6663ae830651 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -1076,27 +1076,6 @@ static void gmc_v9_0_emit_pasid_mapping(struct amdgpu_ring *ring, unsigned int v
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
@@ -1126,6 +1105,7 @@ static void gmc_v9_0_get_vm_pde(struct amdgpu_device *adev, int level,
 static void gmc_v9_0_get_coherence_flags(struct amdgpu_device *adev,
 					 struct amdgpu_vm *vm,
 					 struct amdgpu_bo *bo,
+					 uint32_t vm_flags,
 					 uint64_t *flags)
 {
 	struct amdgpu_device *bo_adev = amdgpu_ttm_adev(bo->tbo.bdev);
@@ -1239,25 +1219,43 @@ static void gmc_v9_0_get_coherence_flags(struct amdgpu_device *adev,
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
@@ -1394,7 +1392,6 @@ static const struct amdgpu_gmc_funcs gmc_v9_0_gmc_funcs = {
 	.flush_gpu_tlb_pasid = gmc_v9_0_flush_gpu_tlb_pasid,
 	.emit_flush_gpu_tlb = gmc_v9_0_emit_flush_gpu_tlb,
 	.emit_pasid_mapping = gmc_v9_0_emit_pasid_mapping,
-	.map_mtype = gmc_v9_0_map_mtype,
 	.get_vm_pde = gmc_v9_0_get_vm_pde,
 	.get_vm_pte = gmc_v9_0_get_vm_pte,
 	.override_vm_pte_flags = gmc_v9_0_override_vm_pte_flags,
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index a0f22ea6d15a..bfafcf804cec 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -1189,7 +1189,7 @@ svm_nodes_in_same_hive(struct kfd_node *node_a, struct kfd_node *node_b)
 }
 
 static uint64_t
-svm_range_get_pte_flags(struct kfd_node *node,
+svm_range_get_pte_flags(struct kfd_node *node, struct amdgpu_vm *vm,
 			struct svm_range *prange, int domain)
 {
 	struct kfd_node *bo_node;
@@ -1292,8 +1292,6 @@ svm_range_get_pte_flags(struct kfd_node *node,
 			AMDGPU_VM_MTYPE_UC : AMDGPU_VM_MTYPE_NC;
 	}
 
-	mapping_flags |= AMDGPU_VM_PAGE_READABLE | AMDGPU_VM_PAGE_WRITEABLE;
-
 	if (flags & KFD_IOCTL_SVM_FLAG_GPU_RO)
 		mapping_flags &= ~AMDGPU_VM_PAGE_WRITEABLE;
 	if (flags & KFD_IOCTL_SVM_FLAG_GPU_EXEC)
@@ -1305,7 +1303,8 @@ svm_range_get_pte_flags(struct kfd_node *node,
 	if (gc_ip_version >= IP_VERSION(12, 0, 0))
 		pte_flags |= AMDGPU_PTE_IS_PTE;
 
-	pte_flags |= amdgpu_gem_va_map_flags(node->adev, mapping_flags);
+	amdgpu_gmc_get_vm_pte(node->adev, vm, NULL, mapping_flags, &pte_flags);
+	pte_flags |= AMDGPU_PTE_READABLE | AMDGPU_PTE_WRITEABLE;
 	return pte_flags;
 }
 
@@ -1412,7 +1411,7 @@ svm_range_map_to_gpu(struct kfd_process_device *pdd, struct svm_range *prange,
 		pr_debug("Mapping range [0x%lx 0x%llx] on domain: %s\n",
 			 last_start, prange->start + i, last_domain ? "GPU" : "CPU");
 
-		pte_flags = svm_range_get_pte_flags(pdd->dev, prange, last_domain);
+		pte_flags = svm_range_get_pte_flags(pdd->dev, vm, prange, last_domain);
 		if (readonly)
 			pte_flags &= ~AMDGPU_PTE_WRITEABLE;
 
-- 
2.34.1

