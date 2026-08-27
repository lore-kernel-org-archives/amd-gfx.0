Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52E5CC61DB9
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Aug 2026 15:49:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B1BDE10F0E3;
	Thu, 27 Aug 2026 15:48:59 +0000 (UTC)
Received: from rtg-sunil-navi33.amd.com (unknown [165.204.217.251])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 674A910F0CF
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Aug 2026 15:48:58 +0000 (UTC)
Received: from rtg-sunil-navi33.amd.com (localhost [127.0.0.1])
 by rtg-sunil-navi33.amd.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTP id
 67RFmqs31021072; Thu, 27 Aug 2026 21:18:52 +0530
Received: (from sunil@localhost)
 by rtg-sunil-navi33.amd.com (8.15.2/8.15.2/Submit) id 67RFmqCo1021071;
 Thu, 27 Aug 2026 21:18:52 +0530
From: Sunil Khatri <sunil.khatri@amd.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Sunil Khatri <sunil.khatri@amd.com>
Subject: [PATCH v1 1/4] drm/amdgpu: make amdgpu_vm_bo_lookup_mapping() take a
 raw address
Date: Thu, 27 Aug 2026 21:18:46 +0530
Message-Id: <20260827154849.1021013-1-sunil.khatri@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
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

amdgpu_vm_bo_lookup_mapping() expected callers to pre-shift the
address to a page frame number before calling in, unlike its sibling
functions amdgpu_vm_bo_map() and amdgpu_vm_bo_replace_map(), which
accept a raw address and shift internally. This inconsistency meant
every caller had to duplicate the same shift to make it pfn and many
place the shift is not AMDGPU_GPU_PAGE_SHIFT but normal PAGE_SHIFT too.

Move the shift inside amdgpu_vm_bo_lookup_mapping() and update all
callers to stop pre-shifting, so the function's calling convention
matches its siblings.

Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c           |  2 --
 drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c |  8 +++-----
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c        |  9 +++------
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c  |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c           |  1 +
 drivers/gpu/drm/amd/amdgpu/mes_userqueue.c       |  2 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c            |  2 +-
 drivers/gpu/drm/amd/amdkfd/kfd_queue.c           | 10 +++++-----
 8 files changed, 15 insertions(+), 21 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
index e129ec46441e..87ccef153073 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
@@ -1809,8 +1809,6 @@ int amdgpu_cs_find_mapping(struct amdgpu_cs_parser *parser,
 	struct amdgpu_bo_va_mapping *mapping;
 	int i, r;
 
-	addr /= AMDGPU_GPU_PAGE_SIZE;
-
 	mapping = amdgpu_vm_bo_lookup_mapping(vm, addr);
 	if (!mapping || !mapping->bo_va || !mapping->bo_va->base.bo)
 		return -EINVAL;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c
index 87e15e39eb30..76771ad30c41 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c
@@ -256,10 +256,9 @@ amdgpu_devcoredump_print_ibs(struct drm_printer *p,
 			goto unlock;
 
 		for (int i = 0; i < coredump->num_ibs; i++) {
-			u64 pfn = (coredump->ibs[i].gpu_addr &
-				   AMDGPU_GMC_HOLE_MASK) / AMDGPU_GPU_PAGE_SIZE;
+			u64 addr = coredump->ibs[i].gpu_addr & AMDGPU_GMC_HOLE_MASK;
 
-			mapping = amdgpu_vm_bo_lookup_mapping(vm, pfn);
+			mapping = amdgpu_vm_bo_lookup_mapping(vm, addr);
 			if (!mapping)
 				continue;
 
@@ -280,8 +279,7 @@ amdgpu_devcoredump_print_ibs(struct drm_printer *p,
 			continue;
 
 		va_start = coredump->ibs[i].gpu_addr & AMDGPU_GMC_HOLE_MASK;
-		mapping = amdgpu_vm_bo_lookup_mapping(vm,
-						      va_start / AMDGPU_GPU_PAGE_SIZE);
+		mapping = amdgpu_vm_bo_lookup_mapping(vm, va_start);
 		if (!mapping)
 			goto output_ib_content;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index 0a816b3c5ff9..62bf6b78a534 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -241,7 +241,6 @@ int amdgpu_userq_input_va_validate(struct amdgpu_device *adev,
 	struct amdgpu_vm *vm = queue->vm;
 	u64 start_addr;
 	u64 end_addr;
-	u64 start_page;
 
 	/* Caller must hold vm->root.bo reservation */
 	dma_resv_assert_held(queue->vm->root.bo->tbo.base.resv);
@@ -253,16 +252,14 @@ int amdgpu_userq_input_va_validate(struct amdgpu_device *adev,
 	if (check_add_overflow(start_addr, expected_size - 1, &end_addr))
 		return -EINVAL;
 
-	start_page = start_addr >> AMDGPU_GPU_PAGE_SHIFT;
-
-	va_map = amdgpu_vm_bo_lookup_mapping(vm, start_page);
+	va_map = amdgpu_vm_bo_lookup_mapping(vm, start_addr);
 	if (!va_map)
 		return -EINVAL;
 
-	/* Lookup guarantees start_page is mapped; ensure full span is covered. */
+	/* Lookup guarantees start_addr is mapped; ensure full span is covered. */
 	if ((end_addr >> AMDGPU_GPU_PAGE_SHIFT) <= va_map->last) {
 		va_map->bo_va->userq_va_mapped = true;
-		*va_out = start_page;
+		*va_out = start_addr;
 		return 0;
 	}
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
index cee5b0241196..5b936d12c55b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
@@ -385,7 +385,7 @@ static int amdgpu_userq_fence_read_wptr(struct amdgpu_device *adev,
 		if (unlikely(ret))
 			goto lock_error;
 
-		mapping = amdgpu_vm_bo_lookup_mapping(queue->vm, addr >> PAGE_SHIFT);
+		mapping = amdgpu_vm_bo_lookup_mapping(queue->vm, addr);
 		if (!mapping) {
 			ret = -EINVAL;
 			goto lock_error;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 88249aa89ee3..c8d1f2624b1b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -2165,6 +2165,7 @@ int amdgpu_vm_bo_clear_mappings(struct amdgpu_device *adev,
 struct amdgpu_bo_va_mapping *amdgpu_vm_bo_lookup_mapping(struct amdgpu_vm *vm,
 							 uint64_t addr)
 {
+	addr /= AMDGPU_GPU_PAGE_SIZE;
 	return amdgpu_vm_it_iter_first(&vm->va, addr, addr);
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
index 7f334f718cd8..46ebc002548d 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
@@ -53,7 +53,7 @@ mes_userq_create_wptr_mapping(struct amdgpu_device *adev,
 		if (unlikely(ret))
 			goto fail_lock;
 
-		wptr_mapping = amdgpu_vm_bo_lookup_mapping(vm, wptr >> PAGE_SHIFT);
+		wptr_mapping = amdgpu_vm_bo_lookup_mapping(vm, wptr);
 		if (!wptr_mapping) {
 			ret = -EINVAL;
 			goto fail_lock;
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
index 69976c8be034..72fd3022b606 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
@@ -2064,7 +2064,7 @@ static int vcn_v1_0_validate_bo(struct amdgpu_cs_parser *parser,
 		return -EINVAL;
 	}
 
-	mapping = amdgpu_vm_bo_lookup_mapping(vm, addr/AMDGPU_GPU_PAGE_SIZE);
+	mapping = amdgpu_vm_bo_lookup_mapping(vm, addr);
 	if (!mapping || !mapping->bo_va || !mapping->bo_va->base.bo)
 		return -EINVAL;
 
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_queue.c b/drivers/gpu/drm/amd/amdkfd/kfd_queue.c
index 15eeaaebbbcd..ae3e7c54014a 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_queue.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_queue.c
@@ -197,18 +197,18 @@ int kfd_queue_buffer_get(struct amdgpu_vm *vm, void __user *addr, struct amdgpu_
 			 u64 expected_size)
 {
 	struct amdgpu_bo_va_mapping *mapping;
-	u64 user_addr;
+	u64 user_pfn;
 	u64 size;
 
-	user_addr = (u64)addr >> AMDGPU_GPU_PAGE_SHIFT;
 	size = expected_size >> AMDGPU_GPU_PAGE_SHIFT;
 
-	mapping = amdgpu_vm_bo_lookup_mapping(vm, user_addr);
+	mapping = amdgpu_vm_bo_lookup_mapping(vm, (u64)(uintptr_t)addr);
 	if (!mapping)
 		goto out_err;
 
-	if (user_addr != mapping->start ||
-	    (size != 0 && user_addr + size - 1 != mapping->last)) {
+	user_pfn = (u64)(uintptr_t)addr >> AMDGPU_GPU_PAGE_SHIFT;
+	if (user_pfn != mapping->start ||
+	    (size != 0 && user_pfn + size - 1 != mapping->last)) {
 		pr_debug("expected size 0x%llx not equal to mapping addr 0x%llx size 0x%llx\n",
 			expected_size, mapping->start << AMDGPU_GPU_PAGE_SHIFT,
 			(mapping->last - mapping->start + 1) << AMDGPU_GPU_PAGE_SHIFT);
-- 
2.34.1

