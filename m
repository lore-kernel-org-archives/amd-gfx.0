From: Yong Zhao <yong.zhao-5C7GfCeVMHo@public.gmane.org>
Subject: Changes for enabling ATS support from PTE
Date: Tue, 25 Jul 2017 18:48:24 -0400
Message-ID: <69a3e55f-a311-5827-10a2-1cac8b0a1ee3@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------AC42B35177288462415043A7"
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Content-Language: en-US
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
List-Help: <mailto:amd-gfx-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=subscribe>
Errors-To: amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Sender: "amd-gfx" <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
To: amd-gfx list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Cc: "Kuehling, Felix" <Felix.Kuehling-5C7GfCeVMHo@public.gmane.org>, "Kasiviswanathan,
 Harish" <Harish.Kasiviswanathan-5C7GfCeVMHo@public.gmane.org>

This is a multi-part message in MIME format.
--------------AC42B35177288462415043A7
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi there,

Attached are two patches made to amdgpu in order to support ATS on 
Raven. Please review them.

Regards,

Yong


--------------AC42B35177288462415043A7
Content-Type: text/x-patch;
 name="0001-drm-amdgpu-Add-support-for-filling-a-buffer-with-64-.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0001-drm-amdgpu-Add-support-for-filling-a-buffer-with-64-.pa";
 filename*1="tch"

>From 0657ddb14a16d1b809c419b51e805287fb6a9989 Mon Sep 17 00:00:00 2001
From: Yong Zhao <Yong.Zhao-5C7GfCeVMHo@public.gmane.org>
Date: Thu, 20 Jul 2017 18:44:10 -0400
Subject: [PATCH 1/2] drm/amdgpu: Add support for filling a buffer with 64 bit
 value

That function will be used later to support setting a page table
block with 64 bit value.

Change-Id: Ib142ebd4163d6e23670a3f0ceed536d59133b942
Signed-off-by: Yong Zhao <Yong.Zhao-5C7GfCeVMHo@public.gmane.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c    | 38 +++++++++++++++++++++++++-----
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h    |  2 +-
 3 files changed, 34 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
index 21e0814..4dfec57 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
@@ -416,7 +416,7 @@ int amdgpu_bo_create_restricted(struct amdgpu_device *adev,
 	    bo->tbo.mem.placement & TTM_PL_FLAG_VRAM) {
 		struct dma_fence *fence;
 
-		r = amdgpu_fill_buffer(bo, 0, bo->tbo.resv, &fence);
+		r = amdgpu_fill_buffer(bo, 0, 4, bo->tbo.resv, &fence);
 		if (unlikely(r))
 			goto fail_unreserve;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index 7820e81..99db4aa 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -1611,11 +1611,12 @@ int amdgpu_copy_buffer(struct amdgpu_ring *ring, uint64_t src_offset,
 }
 
 int amdgpu_fill_buffer(struct amdgpu_bo *bo,
-		       uint32_t src_data,
-		       struct reservation_object *resv,
-		       struct dma_fence **fence)
+			uint64_t src_data, unsigned int word_size,
+			struct reservation_object *resv,
+			struct dma_fence **fence)
 {
 	struct amdgpu_device *adev = amdgpu_ttm_adev(bo->tbo.bdev);
+	/* max_bytes applies to both SDMA_OP_CONST_FILL and SDMA_OP_PTEPDE */
 	uint32_t max_bytes = adev->mman.buffer_funcs->fill_max_bytes;
 	struct amdgpu_ring *ring = adev->mman.buffer_funcs_ring;
 
@@ -1647,7 +1648,17 @@ int amdgpu_fill_buffer(struct amdgpu_bo *bo,
 		num_pages -= mm_node->size;
 		++mm_node;
 	}
-	num_dw = num_loops * adev->mman.buffer_funcs->fill_num_dw;
+
+	switch (word_size) {
+	case 4:
+		num_dw = num_loops * adev->mman.buffer_funcs->fill_num_dw;
+		break;
+	case 8: /* 10 double words for each SDMA_OP_PTEPDE cmd */
+		num_dw = num_loops * 10;
+		break;
+	default:
+		return -EINVAL;
+	}
 
 	/* for IB padding */
 	num_dw += 64;
@@ -1676,8 +1687,23 @@ int amdgpu_fill_buffer(struct amdgpu_bo *bo,
 		while (byte_count) {
 			uint32_t cur_size_in_bytes = min(byte_count, max_bytes);
 
-			amdgpu_emit_fill_buffer(adev, &job->ibs[0], src_data,
-						dst_addr, cur_size_in_bytes);
+			switch (word_size) {
+			case 4: /* only take the lower 32 bits of src_data */
+				amdgpu_emit_fill_buffer(adev, &job->ibs[0],
+						(uint32_t)src_data, dst_addr,
+						cur_size_in_bytes);
+				break;
+			case 8:
+				WARN_ONCE(cur_size_in_bytes & 0x7,
+					"size should be a multiple of 8");
+				amdgpu_vm_set_pte_pde(adev, &job->ibs[0],
+						dst_addr, 0,
+						cur_size_in_bytes >> 3, 0,
+						src_data);
+				break;
+			}
+
+
 
 			dst_addr += cur_size_in_bytes;
 			byte_count -= cur_size_in_bytes;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
index a22e430..067e5e5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
@@ -73,7 +73,7 @@ int amdgpu_copy_buffer(struct amdgpu_ring *ring, uint64_t src_offset,
 		       struct dma_fence **fence, bool direct_submit,
 		       bool vm_needs_flush);
 int amdgpu_fill_buffer(struct amdgpu_bo *bo,
-			uint32_t src_data,
+			uint64_t src_data, unsigned int word_size,
 			struct reservation_object *resv,
 			struct dma_fence **fence);
 
-- 
2.7.4


--------------AC42B35177288462415043A7
Content-Type: text/x-patch;
 name="0002-drm-amdgpu-Support-IOMMU-on-Raven.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="0002-drm-amdgpu-Support-IOMMU-on-Raven.patch"

>From e0bb154b8ae014989e88a401111f19379eec9a8b Mon Sep 17 00:00:00 2001
From: Yong Zhao <Yong.Zhao-5C7GfCeVMHo@public.gmane.org>
Date: Thu, 20 Jul 2017 18:49:09 -0400
Subject: [PATCH 2/2] drm/amdgpu: Support IOMMU on Raven

We achieved that by setting the PTEs to 2 (the SYSTEM bit is set) when
the corresponding addresses are not occupied by gpu driver allocated
buffers.

Change-Id: I995c11c7a25bdaf7a16700d9e08a8fe287d49417
Signed-off-by: Yong Zhao <Yong.Zhao-5C7GfCeVMHo@public.gmane.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c    |  4 ++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 10 +++++++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c     | 30 ++++++++++++++++++++++--------
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h     |  8 ++++----
 include/uapi/drm/amdgpu_drm.h              |  2 ++
 5 files changed, 39 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
index 9182def..433a90e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -825,8 +825,8 @@ int amdgpu_driver_open_kms(struct drm_device *dev, struct drm_file *file_priv)
 		goto out_suspend;
 	}
 
-	r = amdgpu_vm_init(adev, &fpriv->vm,
-			   AMDGPU_VM_CONTEXT_GFX);
+	/* vm_context_flags set to 0, meaning a regular GFX vm context */
+	r = amdgpu_vm_init(adev, &fpriv->vm, 0);
 	if (r) {
 		kfree(fpriv);
 		goto out_suspend;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
index 4dfec57..addaf6b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
@@ -415,8 +415,16 @@ int amdgpu_bo_create_restricted(struct amdgpu_device *adev,
 	if (flags & AMDGPU_GEM_CREATE_VRAM_CLEARED &&
 	    bo->tbo.mem.placement & TTM_PL_FLAG_VRAM) {
 		struct dma_fence *fence;
+		uint64_t init_value = 0;
+		unsigned int word_size = 4;
 
-		r = amdgpu_fill_buffer(bo, 0, 4, bo->tbo.resv, &fence);
+		if (flags & AMDGPU_GEM_CLEAR_PTE_WITH_ATS_SUPPORT) {
+			init_value = AMDGPU_PTE_SYSTEM;
+			word_size = 8;
+		}
+
+		r = amdgpu_fill_buffer(bo, init_value, word_size, bo->tbo.resv,
+					&fence);
 		if (unlikely(r))
 			goto fail_unreserve;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index b6dd43b..bf402f2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -320,6 +320,9 @@ static int amdgpu_vm_alloc_levels(struct amdgpu_device *adev,
 		flags |= (AMDGPU_GEM_CREATE_NO_CPU_ACCESS |
 				AMDGPU_GEM_CREATE_SHADOW);
 
+	if (vm->vm_context_flags & AMDGPU_VM_CONTEXT_ATS)
+		flags |= AMDGPU_GEM_CLEAR_PTE_WITH_ATS_SUPPORT;
+
 	/* walk over the address space and allocate the page tables */
 	for (pt_idx = from; pt_idx <= to; ++pt_idx) {
 		struct reservation_object *resv = vm->root.bo->tbo.resv;
@@ -2007,15 +2010,19 @@ int amdgpu_vm_clear_freed(struct amdgpu_device *adev,
 	struct amdgpu_bo_va_mapping *mapping;
 	struct dma_fence *f = NULL;
 	int r;
+	uint64_t init_pte_value = 0;
 
 	while (!list_empty(&vm->freed)) {
 		mapping = list_first_entry(&vm->freed,
 			struct amdgpu_bo_va_mapping, list);
 		list_del(&mapping->list);
 
+		if (vm->vm_context_flags & AMDGPU_VM_CONTEXT_ATS)
+			init_pte_value = AMDGPU_PTE_SYSTEM;
+
 		r = amdgpu_vm_bo_update_mapping(adev, NULL, 0, NULL, vm,
 						mapping->start, mapping->last,
-						0, 0, &f);
+						init_pte_value, 0, &f);
 		amdgpu_vm_free_mapping(adev, vm, mapping, f);
 		if (r) {
 			dma_fence_put(f);
@@ -2492,12 +2499,12 @@ void amdgpu_vm_adjust_size(struct amdgpu_device *adev, uint64_t vm_size)
  *
  * @adev: amdgpu_device pointer
  * @vm: requested vm
- * @vm_context: Indicates if it GFX or Compute context
+ * @vm_context_flags: Indicates VM context properties
  *
  * Init @vm fields.
  */
 int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm,
-		   int vm_context)
+		   int vm_context_flags)
 {
 	const unsigned align = min(AMDGPU_VM_PTB_ALIGN_SIZE,
 		AMDGPU_VM_PTE_COUNT(adev) * 8);
@@ -2531,10 +2538,13 @@ int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 	if (r)
 		return r;
 
-	if (vm_context == AMDGPU_VM_CONTEXT_COMPUTE)
+	if (vm_context_flags & AMDGPU_VM_CONTEXT_COMPUTE) {
 		vm->use_cpu_for_update = !!(adev->vm_manager.vm_update_mode &
 						AMDGPU_VM_USE_CPU_FOR_COMPUTE);
-	else
+
+		if (adev->asic_type == CHIP_RAVEN)
+			vm_context_flags |= AMDGPU_VM_CONTEXT_ATS;
+	} else
 		vm->use_cpu_for_update = !!(adev->vm_manager.vm_update_mode &
 						AMDGPU_VM_USE_CPU_FOR_GFX);
 	DRM_DEBUG_DRIVER("VM update mode is %s\n",
@@ -2545,6 +2555,10 @@ int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 
 	flags = AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS |
 			AMDGPU_GEM_CREATE_VRAM_CLEARED;
+
+	if (vm_context_flags & AMDGPU_VM_CONTEXT_ATS)
+		flags |= AMDGPU_GEM_CLEAR_PTE_WITH_ATS_SUPPORT;
+
 	if (vm->use_cpu_for_update)
 		flags |= AMDGPU_GEM_CREATE_CPU_ACCESS_REQUIRED;
 	else
@@ -2572,8 +2586,8 @@ int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 
 	amdgpu_bo_unreserve(vm->root.bo);
 
-	vm->vm_context = vm_context;
-	if (vm_context == AMDGPU_VM_CONTEXT_COMPUTE) {
+	vm->vm_context_flags = vm_context_flags;
+	if (vm_context_flags & AMDGPU_VM_CONTEXT_COMPUTE) {
 		mutex_lock(&id_mgr->lock);
 
 		if ((adev->vm_manager.n_compute_vms++ == 0) &&
@@ -2640,7 +2654,7 @@ void amdgpu_vm_fini(struct amdgpu_device *adev, struct amdgpu_vm *vm)
 	bool prt_fini_needed = !!adev->gart.gart_funcs->set_prt;
 	int i;
 
-	if (vm->vm_context == AMDGPU_VM_CONTEXT_COMPUTE) {
+	if (vm->vm_context_flags & AMDGPU_VM_CONTEXT_COMPUTE) {
 		struct amdgpu_vm_id_manager *id_mgr =
 			&adev->vm_manager.id_mgr[AMDGPU_GFXHUB];
 		mutex_lock(&id_mgr->lock);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
index 5005690..c487d82 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
@@ -96,8 +96,8 @@ struct amdgpu_bo_list_entry;
 #define AMDGPU_VM_USE_CPU_FOR_GFX (1 << 0)
 #define AMDGPU_VM_USE_CPU_FOR_COMPUTE (1 << 1)
 
-#define AMDGPU_VM_CONTEXT_GFX 0
-#define AMDGPU_VM_CONTEXT_COMPUTE 1
+#define AMDGPU_VM_CONTEXT_COMPUTE	(1 << 0)
+#define AMDGPU_VM_CONTEXT_ATS		(1 << 1)
 
 
 struct amdgpu_vm_pt {
@@ -147,8 +147,8 @@ struct amdgpu_vm {
 	/* Flag to indicate if VM tables are updated by CPU or GPU (SDMA) */
 	bool                    use_cpu_for_update;
 
-	/* Whether this is a Compute or GFX Context */
-	int			vm_context;
+	/* flags indicating the properties of VM context */
+	int			vm_context_flags;
 };
 
 struct amdgpu_vm_id {
diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
index 2994831..3cbe6dc 100644
--- a/include/uapi/drm/amdgpu_drm.h
+++ b/include/uapi/drm/amdgpu_drm.h
@@ -89,6 +89,8 @@ extern "C" {
 #define AMDGPU_GEM_CREATE_SHADOW		(1 << 4)
 /* Flag that allocating the BO should use linear VRAM */
 #define AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS	(1 << 5)
+/* Flag that supports ATS through PTE on GFX9 */
+#define AMDGPU_GEM_CLEAR_PTE_WITH_ATS_SUPPORT	(1 << 6)
 
 struct drm_amdgpu_gem_create_in  {
 	/** the requested memory size */
-- 
2.7.4


--------------AC42B35177288462415043A7
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--------------AC42B35177288462415043A7--
