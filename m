From: Felix Kuehling <felix.kuehling-5C7GfCeVMHo@public.gmane.org>
Subject: Changes to let KFD use render node VMs
Date: Thu, 1 Mar 2018 17:58:47 -0500
Message-ID: <22204b36-3974-2853-f3f8-2fbd30b05418@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------410EB74F8B5DC0B387D1B15E"
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Content-Language: en-CA
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
To: amd-gfx-CC+yJ3UmIYqDUpFQwHEjaQ@public.gmane.org, =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig-5C7GfCeVMHo@public.gmane.org>

This is a multi-part message in MIME format.
--------------410EB74F8B5DC0B387D1B15E
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Hi Christian,

I have a working patch series against amd-kfg-staging that lets KFD use
VMs from render node FDs, as we discussed. There are two patches in that
series that touch amdgpu_vm.[ch] that I'd like your feedback on before I
commit the changes to amd-kfd-staging and include them in my upstream
patch series for KFD GPUVM support. See attached.

Thanks,
  Felix

-- 
F e l i x   K u e h l i n g
PMTS Software Development Engineer | Vertical Workstation/Compute
1 Commerce Valley Dr. East, Markham, ON L3T 7X6 Canada
(O) +1(289)695-1597
   _     _   _   _____   _____
  / \   | \ / | |  _  \  \ _  |
 / A \  | \M/ | | |D) )  /|_| |
/_/ \_\ |_| |_| |_____/ |__/ \|   facebook.com/AMD | amd.com


--------------410EB74F8B5DC0B387D1B15E
Content-Type: text/x-patch;
 name="0003-drm-amdgpu-Move-KFD-specific-fields-into-struct-amdg.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0003-drm-amdgpu-Move-KFD-specific-fields-into-struct-amdg.pa";
 filename*1="tch"

>From 45efed055bcd186bcc92035433457fc39c6227dd Mon Sep 17 00:00:00 2001
From: Felix Kuehling <Felix.Kuehling-5C7GfCeVMHo@public.gmane.org>
Date: Fri, 23 Feb 2018 19:51:28 -0500
Subject: [PATCH 3/7] drm/amdgpu: Move KFD-specific fields into struct
 amdgpu_vm

Remove struct amdkfd_vm and move the fields into struct amdgpu_vm.
This will allow turning a VM created by a DRM render node into a
KFD VM.

Change-Id: I34112b358e29cdebc8c6af6ce1ffb62d3f22c884
Signed-off-by: Felix Kuehling <Felix.Kuehling-5C7GfCeVMHo@public.gmane.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h       |  20 ----
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 116 +++++++++++------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h           |   9 ++
 3 files changed, 64 insertions(+), 81 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
index 4b64899..d5f6c48 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
@@ -102,26 +102,6 @@ struct amdkfd_process_info {
 	struct pid *pid;
 };
 
-/* struct amdkfd_vm -
- * For Memory Eviction KGD requires a mechanism to keep track of all KFD BOs
- * belonging to a KFD process. All the VMs belonging to the same process point
- * to the same amdkfd_process_info.
- */
-struct amdkfd_vm {
-	/* Keep base as the first parameter for pointer compatibility between
-	 * amdkfd_vm and amdgpu_vm.
-	 */
-	struct amdgpu_vm base;
-
-	/* List node in amdkfd_process_info.vm_list_head*/
-	struct list_head vm_list_node;
-
-	/* Points to the KFD process VM info*/
-	struct amdkfd_process_info *process_info;
-
-	uint64_t pd_phys_addr;
-};
-
 int amdgpu_amdkfd_init(void);
 void amdgpu_amdkfd_fini(void);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index 08b19ca..1df7beb 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -356,21 +356,20 @@ static int amdgpu_amdkfd_validate(void *param, struct amdgpu_bo *bo)
 	return amdgpu_amdkfd_bo_validate(bo, p->domain, p->wait);
 }
 
-static u64 get_vm_pd_gpu_offset(struct amdkfd_vm *kvm, bool reserve)
+static u64 get_vm_pd_gpu_offset(struct amdgpu_vm *vm, bool reserve)
 {
-	struct amdgpu_vm *avm = &kvm->base;
 	struct amdgpu_device *adev =
-		amdgpu_ttm_adev(avm->root.base.bo->tbo.bdev);
+		amdgpu_ttm_adev(vm->root.base.bo->tbo.bdev);
 	u64 offset;
 	uint64_t flags = AMDGPU_PTE_VALID;
 
 	if (reserve)
-		amdgpu_bo_reserve(avm->root.base.bo, false);
+		amdgpu_bo_reserve(vm->root.base.bo, false);
 
-	offset = amdgpu_bo_gpu_offset(avm->root.base.bo);
+	offset = amdgpu_bo_gpu_offset(vm->root.base.bo);
 
 	if (reserve)
-		amdgpu_bo_unreserve(avm->root.base.bo);
+		amdgpu_bo_unreserve(vm->root.base.bo);
 
 	/* On some ASICs the FB doesn't start at 0. Adjust FB offset
 	 * to an actual MC address.
@@ -387,9 +386,9 @@ static u64 get_vm_pd_gpu_offset(struct amdkfd_vm *kvm, bool reserve)
  * again. Page directories are only updated after updating page
  * tables.
  */
-static int vm_validate_pt_pd_bos(struct amdkfd_vm *vm)
+static int vm_validate_pt_pd_bos(struct amdgpu_vm *vm)
 {
-	struct amdgpu_bo *pd = vm->base.root.base.bo;
+	struct amdgpu_bo *pd = vm->root.base.bo;
 	struct amdgpu_device *adev = amdgpu_ttm_adev(pd->tbo.bdev);
 	struct amdgpu_vm_parser param;
 	int ret;
@@ -397,7 +396,7 @@ static int vm_validate_pt_pd_bos(struct amdkfd_vm *vm)
 	param.domain = AMDGPU_GEM_DOMAIN_VRAM;
 	param.wait = false;
 
-	ret = amdgpu_vm_validate_pt_bos(adev, &vm->base, amdgpu_amdkfd_validate,
+	ret = amdgpu_vm_validate_pt_bos(adev, vm, amdgpu_amdkfd_validate,
 					&param);
 	if (ret) {
 		pr_err("amdgpu: failed to validate PT BOs\n");
@@ -412,7 +411,7 @@ static int vm_validate_pt_pd_bos(struct amdkfd_vm *vm)
 
 	vm->pd_phys_addr = get_vm_pd_gpu_offset(vm, false);
 
-	if (vm->base.use_cpu_for_update) {
+	if (vm->use_cpu_for_update) {
 		ret = amdgpu_bo_kmap(pd, NULL);
 		if (ret) {
 			pr_err("amdgpu: failed to kmap PD, ret=%d\n", ret);
@@ -466,14 +465,12 @@ static int vm_update_pds(struct amdgpu_vm *vm, struct amdgpu_sync *sync)
  * 4a.  Validate new page tables and directories
  */
 static int add_bo_to_vm(struct amdgpu_device *adev, struct kgd_mem *mem,
-		struct amdgpu_vm *avm, bool is_aql,
+		struct amdgpu_vm *vm, bool is_aql,
 		struct kfd_bo_va_list **p_bo_va_entry)
 {
 	int ret;
 	struct kfd_bo_va_list *bo_va_entry;
-	struct amdkfd_vm *kvm = container_of(avm,
-					     struct amdkfd_vm, base);
-	struct amdgpu_bo *pd = avm->root.base.bo;
+	struct amdgpu_bo *pd = vm->root.base.bo;
 	struct amdgpu_bo *bo = mem->bo;
 	uint64_t va = mem->va;
 	struct list_head *list_bo_va = &mem->bo_va_list;
@@ -492,10 +489,10 @@ static int add_bo_to_vm(struct amdgpu_device *adev, struct kgd_mem *mem,
 		return -ENOMEM;
 
 	pr_debug("\t add VA 0x%llx - 0x%llx to vm %p\n", va,
-			va + bo_size, avm);
+			va + bo_size, vm);
 
 	/* Add BO to VM internal data structures*/
-	bo_va_entry->bo_va = amdgpu_vm_bo_add(adev, avm, bo);
+	bo_va_entry->bo_va = amdgpu_vm_bo_add(adev, vm, bo);
 	if (!bo_va_entry->bo_va) {
 		ret = -EINVAL;
 		pr_err("Failed to add BO object to VM. ret == %d\n",
@@ -518,28 +515,28 @@ static int add_bo_to_vm(struct amdgpu_device *adev, struct kgd_mem *mem,
 	 * fence, so remove it temporarily.
 	 */
 	amdgpu_amdkfd_remove_eviction_fence(pd,
-					kvm->process_info->eviction_fence,
+					vm->process_info->eviction_fence,
 					NULL, NULL);
 
-	ret = amdgpu_vm_alloc_pts(adev, avm, va, amdgpu_bo_size(bo));
+	ret = amdgpu_vm_alloc_pts(adev, vm, va, amdgpu_bo_size(bo));
 	if (ret) {
 		pr_err("Failed to allocate pts, err=%d\n", ret);
 		goto err_alloc_pts;
 	}
 
-	ret = vm_validate_pt_pd_bos(kvm);
+	ret = vm_validate_pt_pd_bos(vm);
 	if (ret) {
 		pr_err("validate_pt_pd_bos() failed\n");
 		goto err_alloc_pts;
 	}
 
 	/* Add the eviction fence back */
-	amdgpu_bo_fence(pd, &kvm->process_info->eviction_fence->base, true);
+	amdgpu_bo_fence(pd, &vm->process_info->eviction_fence->base, true);
 
 	return 0;
 
 err_alloc_pts:
-	amdgpu_bo_fence(pd, &kvm->process_info->eviction_fence->base, true);
+	amdgpu_bo_fence(pd, &vm->process_info->eviction_fence->base, true);
 	amdgpu_vm_bo_rmv(adev, bo_va_entry->bo_va);
 	list_del(&bo_va_entry->bo_list);
 err_vmadd:
@@ -840,7 +837,6 @@ static int unmap_bo_from_gpuvm(struct amdgpu_device *adev,
 {
 	struct amdgpu_bo_va *bo_va = entry->bo_va;
 	struct amdgpu_vm *vm = bo_va->base.vm;
-	struct amdkfd_vm *kvm = container_of(vm, struct amdkfd_vm, base);
 	struct amdgpu_bo *pd = vm->root.base.bo;
 
 	/* Remove eviction fence from PD (and thereby from PTs too as
@@ -850,14 +846,14 @@ static int unmap_bo_from_gpuvm(struct amdgpu_device *adev,
 	 * trigger the eviction fence.
 	 */
 	amdgpu_amdkfd_remove_eviction_fence(pd,
-					    kvm->process_info->eviction_fence,
+					    vm->process_info->eviction_fence,
 					    NULL, NULL);
 	amdgpu_vm_bo_unmap(adev, bo_va, entry->va);
 
 	amdgpu_vm_clear_freed(adev, vm, &bo_va->last_pt_update);
 
 	/* Add the eviction fence back */
-	amdgpu_bo_fence(pd, &kvm->process_info->eviction_fence->base, true);
+	amdgpu_bo_fence(pd, &vm->process_info->eviction_fence->base, true);
 
 	sync_vm_fence(adev, sync, bo_va->last_pt_update);
 
@@ -939,7 +935,7 @@ static struct sg_table *create_doorbell_sg(uint64_t addr, uint32_t size)
 
 static int process_validate_vms(struct amdkfd_process_info *process_info)
 {
-	struct amdkfd_vm *peer_vm;
+	struct amdgpu_vm *peer_vm;
 	int ret;
 
 	list_for_each_entry(peer_vm, &process_info->vm_list_head,
@@ -955,12 +951,12 @@ static int process_validate_vms(struct amdkfd_process_info *process_info)
 static int process_sync_pds_resv(struct amdkfd_process_info *process_info,
 				 struct amdgpu_sync *sync)
 {
-	struct amdkfd_vm *peer_vm;
+	struct amdgpu_vm *peer_vm;
 	int ret;
 
 	list_for_each_entry(peer_vm, &process_info->vm_list_head,
 			    vm_list_node) {
-		struct amdgpu_bo *pd = peer_vm->base.root.base.bo;
+		struct amdgpu_bo *pd = peer_vm->root.base.bo;
 
 		ret = amdgpu_sync_resv(amdgpu_ttm_adev(pd->tbo.bdev),
 					sync, pd->tbo.resv,
@@ -975,12 +971,12 @@ static int process_sync_pds_resv(struct amdkfd_process_info *process_info,
 static int process_update_pds(struct amdkfd_process_info *process_info,
 			      struct amdgpu_sync *sync)
 {
-	struct amdkfd_vm *peer_vm;
+	struct amdgpu_vm *peer_vm;
 	int ret;
 
 	list_for_each_entry(peer_vm, &process_info->vm_list_head,
 			    vm_list_node) {
-		ret = vm_update_pds(&peer_vm->base, sync);
+		ret = vm_update_pds(peer_vm, sync);
 		if (ret)
 			return ret;
 	}
@@ -993,7 +989,7 @@ int amdgpu_amdkfd_gpuvm_create_process_vm(struct kgd_dev *kgd, void **vm,
 					  struct dma_fence **ef)
 {
 	int ret;
-	struct amdkfd_vm *new_vm;
+	struct amdgpu_vm *new_vm;
 	struct amdkfd_process_info *info;
 	struct amdgpu_device *adev = get_amdgpu_device(kgd);
 
@@ -1002,7 +998,7 @@ int amdgpu_amdkfd_gpuvm_create_process_vm(struct kgd_dev *kgd, void **vm,
 		return -ENOMEM;
 
 	/* Initialize the VM context, allocate the page directory and zero it */
-	ret = amdgpu_vm_init(adev, &new_vm->base, AMDGPU_VM_CONTEXT_COMPUTE, 0);
+	ret = amdgpu_vm_init(adev, new_vm, AMDGPU_VM_CONTEXT_COMPUTE, 0);
 	if (ret) {
 		pr_err("Failed init vm ret %d\n", ret);
 		goto vm_init_fail;
@@ -1057,7 +1053,7 @@ int amdgpu_amdkfd_gpuvm_create_process_vm(struct kgd_dev *kgd, void **vm,
 create_evict_fence_fail:
 	kfree(info);
 alloc_process_info_fail:
-	amdgpu_vm_fini(adev, &new_vm->base);
+	amdgpu_vm_fini(adev, new_vm);
 vm_init_fail:
 	kfree(new_vm);
 	return ret;
@@ -1067,8 +1063,7 @@ int amdgpu_amdkfd_gpuvm_create_process_vm(struct kgd_dev *kgd, void **vm,
 void amdgpu_amdkfd_gpuvm_destroy_process_vm(struct kgd_dev *kgd, void *vm)
 {
 	struct amdgpu_device *adev = get_amdgpu_device(kgd);
-	struct amdkfd_vm *kfd_vm = (struct amdkfd_vm *) vm;
-	struct amdgpu_vm *avm = &kfd_vm->base;
+	struct amdgpu_vm *avm = (struct amdgpu_vm *)vm;
 	struct amdgpu_bo *pd;
 	struct amdkfd_process_info *process_info;
 
@@ -1082,11 +1077,11 @@ void amdgpu_amdkfd_gpuvm_destroy_process_vm(struct kgd_dev *kgd, void *vm)
 	amdgpu_bo_fence(pd, NULL, false);
 	amdgpu_bo_unreserve(pd);
 
-	process_info = kfd_vm->process_info;
+	process_info = avm->process_info;
 
 	mutex_lock(&process_info->lock);
 	process_info->n_vms--;
-	list_del(&kfd_vm->vm_list_node);
+	list_del(&avm->vm_list_node);
 	mutex_unlock(&process_info->lock);
 
 	/* Release per-process resources */
@@ -1108,7 +1103,7 @@ void amdgpu_amdkfd_gpuvm_destroy_process_vm(struct kgd_dev *kgd, void *vm)
 
 uint32_t amdgpu_amdkfd_gpuvm_get_process_page_dir(void *vm)
 {
-	struct amdkfd_vm *avm = (struct amdkfd_vm *)vm;
+	struct amdgpu_vm *avm = (struct amdgpu_vm *)vm;
 
 	return avm->pd_phys_addr >> AMDGPU_GPU_PAGE_SHIFT;
 }
@@ -1119,7 +1114,7 @@ int amdgpu_amdkfd_gpuvm_alloc_memory_of_gpu(
 		uint64_t *offset, uint32_t flags)
 {
 	struct amdgpu_device *adev = get_amdgpu_device(kgd);
-	struct amdkfd_vm *kfd_vm = (struct amdkfd_vm *)vm;
+	struct amdgpu_vm *avm = (struct amdgpu_vm *)vm;
 	uint64_t user_addr = 0;
 	struct sg_table *sg = NULL;
 	struct amdgpu_bo *bo;
@@ -1223,15 +1218,15 @@ int amdgpu_amdkfd_gpuvm_alloc_memory_of_gpu(
 	(*mem)->va = va;
 	(*mem)->domain = domain;
 	(*mem)->mapped_to_gpu_memory = 0;
-	(*mem)->process_info = kfd_vm->process_info;
-	add_kgd_mem_to_kfd_bo_list(*mem, kfd_vm->process_info, user_addr);
+	(*mem)->process_info = avm->process_info;
+	add_kgd_mem_to_kfd_bo_list(*mem, avm->process_info, user_addr);
 
 	if (user_addr) {
 		ret = init_user_pages(*mem, current->mm, user_addr);
 		if (ret) {
-			mutex_lock(&kfd_vm->process_info->lock);
+			mutex_lock(&avm->process_info->lock);
 			list_del(&(*mem)->validate_list.head);
-			mutex_unlock(&kfd_vm->process_info->lock);
+			mutex_unlock(&avm->process_info->lock);
 			goto allocate_init_user_pages_failed;
 		}
 	}
@@ -1340,7 +1335,7 @@ int amdgpu_amdkfd_gpuvm_map_memory_to_gpu(
 		struct kgd_dev *kgd, struct kgd_mem *mem, void *vm)
 {
 	struct amdgpu_device *adev = get_amdgpu_device(kgd);
-	struct amdkfd_vm *kfd_vm = (struct amdkfd_vm *)vm;
+	struct amdgpu_vm *avm = (struct amdgpu_vm *)vm;
 	int ret;
 	struct amdgpu_bo *bo;
 	uint32_t domain;
@@ -1395,19 +1390,19 @@ int amdgpu_amdkfd_gpuvm_map_memory_to_gpu(
 	if (bo->tbo.mem.mem_type == TTM_PL_SYSTEM)
 		is_invalid_userptr = true;
 
-	if (check_if_add_bo_to_vm((struct amdgpu_vm *)vm, mem)) {
-		ret = add_bo_to_vm(adev, mem, (struct amdgpu_vm *)vm, false,
+	if (check_if_add_bo_to_vm(avm, mem)) {
+		ret = add_bo_to_vm(adev, mem, avm, false,
 				&bo_va_entry);
 		if (ret)
 			goto add_bo_to_vm_failed;
 		if (mem->aql_queue) {
-			ret = add_bo_to_vm(adev, mem, (struct amdgpu_vm *)vm,
+			ret = add_bo_to_vm(adev, mem, avm,
 					true, &bo_va_entry_aql);
 			if (ret)
 				goto add_bo_to_vm_failed_aql;
 		}
 	} else {
-		ret = vm_validate_pt_pd_bos((struct amdkfd_vm *)vm);
+		ret = vm_validate_pt_pd_bos(avm);
 		if (unlikely(ret))
 			goto add_bo_to_vm_failed;
 	}
@@ -1453,7 +1448,7 @@ int amdgpu_amdkfd_gpuvm_map_memory_to_gpu(
 
 	if (!amdgpu_ttm_tt_get_usermm(bo->tbo.ttm) && !bo->pin_count)
 		amdgpu_bo_fence(bo,
-				&kfd_vm->process_info->eviction_fence->base,
+				&avm->process_info->eviction_fence->base,
 				true);
 	ret = unreserve_bo_and_vms(&ctx, false, false);
 
@@ -1479,7 +1474,7 @@ int amdgpu_amdkfd_gpuvm_unmap_memory_from_gpu(
 {
 	struct amdgpu_device *adev = get_amdgpu_device(kgd);
 	struct amdkfd_process_info *process_info =
-		((struct amdkfd_vm *)vm)->process_info;
+		((struct amdgpu_vm *)vm)->process_info;
 	unsigned long bo_size = mem->bo->tbo.mem.size;
 	struct kfd_bo_va_list *entry;
 	struct bo_vm_reservation_context ctx;
@@ -1496,7 +1491,7 @@ int amdgpu_amdkfd_gpuvm_unmap_memory_from_gpu(
 		goto unreserve_out;
 	}
 
-	ret = vm_validate_pt_pd_bos((struct amdkfd_vm *)vm);
+	ret = vm_validate_pt_pd_bos((struct amdgpu_vm *)vm);
 	if (unlikely(ret))
 		goto unreserve_out;
 
@@ -1781,7 +1776,7 @@ int amdgpu_amdkfd_gpuvm_import_dmabuf(struct kgd_dev *kgd,
 	struct amdgpu_device *adev = (struct amdgpu_device *)kgd;
 	struct drm_gem_object *obj;
 	struct amdgpu_bo *bo;
-	struct amdkfd_vm *kfd_vm = (struct amdkfd_vm *)vm;
+	struct amdgpu_vm *avm = (struct amdgpu_vm *)vm;
 
 	if (dma_buf->ops != &amdgpu_dmabuf_ops)
 		/* Can't handle non-graphics buffers */
@@ -1819,8 +1814,8 @@ int amdgpu_amdkfd_gpuvm_import_dmabuf(struct kgd_dev *kgd,
 	(*mem)->domain = (bo->preferred_domains & AMDGPU_GEM_DOMAIN_VRAM) ?
 		AMDGPU_GEM_DOMAIN_VRAM : AMDGPU_GEM_DOMAIN_GTT;
 	(*mem)->mapped_to_gpu_memory = 0;
-	(*mem)->process_info = kfd_vm->process_info;
-	add_kgd_mem_to_kfd_bo_list(*mem, kfd_vm->process_info, false);
+	(*mem)->process_info = avm->process_info;
+	add_kgd_mem_to_kfd_bo_list(*mem, avm->process_info, false);
 	amdgpu_sync_create(&(*mem)->sync);
 
 	return 0;
@@ -1978,7 +1973,7 @@ static int validate_invalid_user_pages(struct amdkfd_process_info *process_info)
 	struct ww_acquire_ctx ticket;
 	struct amdgpu_sync sync;
 
-	struct amdkfd_vm *peer_vm;
+	struct amdgpu_vm *peer_vm;
 	struct kgd_mem *mem, *tmp_mem;
 	struct amdgpu_bo *bo;
 	struct ttm_operation_ctx ctx = { false, false };
@@ -1999,7 +1994,7 @@ static int validate_invalid_user_pages(struct amdkfd_process_info *process_info)
 	i = 0;
 	list_for_each_entry(peer_vm, &process_info->vm_list_head,
 			    vm_list_node)
-		amdgpu_vm_get_pd_bo(&peer_vm->base, &resv_list,
+		amdgpu_vm_get_pd_bo(peer_vm, &resv_list,
 				    &pd_bo_list_entries[i++]);
 	/* Add the userptr_inval_list entries to resv_list */
 	list_for_each_entry(mem, &process_info->userptr_inval_list,
@@ -2023,7 +2018,7 @@ static int validate_invalid_user_pages(struct amdkfd_process_info *process_info)
 	 */
 	list_for_each_entry(peer_vm, &process_info->vm_list_head,
 			    vm_list_node)
-		amdgpu_amdkfd_remove_eviction_fence(peer_vm->base.root.base.bo,
+		amdgpu_amdkfd_remove_eviction_fence(peer_vm->root.base.bo,
 						process_info->eviction_fence,
 						NULL, NULL);
 
@@ -2089,7 +2084,7 @@ static int validate_invalid_user_pages(struct amdkfd_process_info *process_info)
 unreserve_out:
 	list_for_each_entry(peer_vm, &process_info->vm_list_head,
 			    vm_list_node)
-		amdgpu_bo_fence(peer_vm->base.root.base.bo,
+		amdgpu_bo_fence(peer_vm->root.base.bo,
 				&process_info->eviction_fence->base, true);
 	ttm_eu_backoff_reservation(&ticket, &resv_list);
 	amdgpu_sync_wait(&sync, false);
@@ -2192,7 +2187,7 @@ int amdgpu_amdkfd_gpuvm_restore_process_bos(void *info, struct dma_fence **ef)
 {
 	struct amdgpu_bo_list_entry *pd_bo_list;
 	struct amdkfd_process_info *process_info = info;
-	struct amdkfd_vm *peer_vm;
+	struct amdgpu_vm *peer_vm;
 	struct kgd_mem *mem;
 	struct bo_vm_reservation_context ctx;
 	struct amdgpu_amdkfd_fence *new_fence;
@@ -2214,8 +2209,7 @@ int amdgpu_amdkfd_gpuvm_restore_process_bos(void *info, struct dma_fence **ef)
 	mutex_lock(&process_info->lock);
 	list_for_each_entry(peer_vm, &process_info->vm_list_head,
 			vm_list_node)
-		amdgpu_vm_get_pd_bo(&peer_vm->base, &ctx.list,
-				    &pd_bo_list[i++]);
+		amdgpu_vm_get_pd_bo(peer_vm, &ctx.list, &pd_bo_list[i++]);
 
 	/* Reserve all BOs and page tables/directory. Add all BOs from
 	 * kfd_bo_list to ctx.list
@@ -2315,7 +2309,7 @@ int amdgpu_amdkfd_gpuvm_restore_process_bos(void *info, struct dma_fence **ef)
 	/* Attach eviction fence to PD / PT BOs */
 	list_for_each_entry(peer_vm, &process_info->vm_list_head,
 			    vm_list_node) {
-		struct amdgpu_bo *bo = peer_vm->base.root.base.bo;
+		struct amdgpu_bo *bo = peer_vm->root.base.bo;
 
 		amdgpu_bo_fence(bo, &process_info->eviction_fence->base, true);
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
index 5a87bfd..9f4bdef 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
@@ -209,6 +209,15 @@ struct amdgpu_vm {
 
 	/* Whether this is a Compute or GFX Context */
 	int			vm_context;
+
+	/* Points to the KFD process VM info */
+	struct amdkfd_process_info *process_info;
+
+	/* List node in amdkfd_process_info.vm_list_head */
+	struct list_head	vm_list_node;
+
+	/* Valid while the PD is reserved or fenced */
+	uint64_t		pd_phys_addr;
 };
 
 struct amdgpu_vm_manager {
-- 
2.7.4


--------------410EB74F8B5DC0B387D1B15E
Content-Type: text/x-patch;
 name="0005-drm-amdgpu-Add-helper-to-turn-an-existing-VM-into-a-.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0005-drm-amdgpu-Add-helper-to-turn-an-existing-VM-into-a-.pa";
 filename*1="tch"

>From 23f814d1723e14c89ede73ebf8013277465d06a0 Mon Sep 17 00:00:00 2001
From: Felix Kuehling <Felix.Kuehling-5C7GfCeVMHo@public.gmane.org>
Date: Sat, 24 Feb 2018 18:26:47 -0500
Subject: [PATCH 5/7] drm/amdgpu: Add helper to turn an existing VM into a
 compute VM

Change-Id: Ie7d1fe63c2d612765a62e9c4d57e361f21cf0d10
Signed-off-by: Felix Kuehling <Felix.Kuehling-5C7GfCeVMHo@public.gmane.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 109 ++++++++++++++++++++++++++++-----
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h |   1 +
 2 files changed, 94 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 93914a4..0347d2a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -2351,6 +2351,23 @@ void amdgpu_vm_adjust_size(struct amdgpu_device *adev, uint32_t vm_size,
 		 adev->vm_manager.fragment_size);
 }
 
+static void amdgpu_inc_compute_vms(struct amdgpu_device *adev)
+{
+	/* Temporary use only the first VM manager */
+	unsigned int vmhub = 0; /*ring->funcs->vmhub;*/
+	struct amdgpu_vmid_mgr *id_mgr = &adev->vm_manager.id_mgr[vmhub];
+
+	mutex_lock(&id_mgr->lock);
+	if ((adev->vm_manager.n_compute_vms++ == 0) &&
+	    (!amdgpu_sriov_vf(adev))) {
+		/* First Compute VM: enable compute power profile */
+		if (adev->powerplay.pp_funcs->switch_power_profile)
+			amdgpu_dpm_switch_power_profile(adev,
+							AMD_PP_COMPUTE_PROFILE);
+	}
+	mutex_unlock(&id_mgr->lock);
+}
+
 /**
  * amdgpu_vm_init - initialize a vm instance
  *
@@ -2372,10 +2389,6 @@ int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 	uint64_t flags;
 	int r, i;
 
-	/* Temporary use only the first VM manager */
-	unsigned vmhub = 0; /*ring->funcs->vmhub;*/
-	struct amdgpu_vmid_mgr *id_mgr = &adev->vm_manager.id_mgr[vmhub];
-
 	vm->va = RB_ROOT_CACHED;
 	for (i = 0; i < AMDGPU_MAX_VMHUBS; i++)
 		vm->reserved_vmid[i] = NULL;
@@ -2459,18 +2472,8 @@ int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 	vm->fault_credit = 16;
 
 	vm->vm_context = vm_context;
-	if (vm_context == AMDGPU_VM_CONTEXT_COMPUTE) {
-		mutex_lock(&id_mgr->lock);
-
-		if ((adev->vm_manager.n_compute_vms++ == 0) &&
-			(!amdgpu_sriov_vf(adev))) {
-			/* First Compute VM: enable compute power profile */
-			if (adev->powerplay.pp_funcs->switch_power_profile)
-				amdgpu_dpm_switch_power_profile(adev,
-						AMD_PP_COMPUTE_PROFILE);
-		}
-		mutex_unlock(&id_mgr->lock);
-	}
+	if (vm_context == AMDGPU_VM_CONTEXT_COMPUTE)
+		amdgpu_inc_compute_vms(adev);
 
 	return 0;
 
@@ -2489,6 +2492,80 @@ int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 }
 
 /**
+ * amdgpu_vm_make_compute - Turn a GFX VM into a compute VM
+ *
+ * This only works on GFX VMs that don't have any BOs added and no
+ * page tables allocated yet.
+ *
+ * Changes the following VM parameters:
+ * - vm_context
+ * - use_cpu_for_update
+ * - pte_supports_ats
+ * - pasid (old PASID is released, because compute manages its own PASIDs)
+ *
+ * Reinitializes the page directory to reflect the changed ATS
+ * setting. May also switch to the compute power profile if this is
+ * the first compute VM. May leave behind an unused shadow BO for the
+ * page directory when switching from SDMA updates to CPU updates.
+ *
+ * Returns 0 for success, -errno for errors.
+ */
+int amdgpu_vm_make_compute(struct amdgpu_device *adev, struct amdgpu_vm *vm)
+{
+	bool pte_support_ats = (adev->asic_type == CHIP_RAVEN);
+	int r;
+
+	r = amdgpu_bo_reserve(vm->root.base.bo, true);
+	if (r)
+		return r;
+
+	/* Sanity checks */
+	if (vm->vm_context == AMDGPU_VM_CONTEXT_COMPUTE ||
+	    !RB_EMPTY_ROOT(&vm->va.rb_root) || vm->root.entries) {
+		r = -EINVAL;
+		goto error;
+	}
+
+	/* Check if PD needs to be reinitialized and do it before
+	 * changing any other state, in case it fails.
+	 */
+	if (pte_support_ats != vm->pte_support_ats) {
+		r = amdgpu_vm_clear_bo(adev, vm, vm->root.base.bo,
+			       adev->vm_manager.root_level,
+			       pte_support_ats);
+		if (r)
+			goto error;
+	}
+
+	/* Update VM state */
+	vm->vm_context = AMDGPU_VM_CONTEXT_COMPUTE;
+	vm->use_cpu_for_update = !!(adev->vm_manager.vm_update_mode &
+				    AMDGPU_VM_USE_CPU_FOR_COMPUTE);
+	vm->pte_support_ats = pte_support_ats;
+	DRM_DEBUG_DRIVER("VM update mode is %s\n",
+			 vm->use_cpu_for_update ? "CPU" : "SDMA");
+	WARN_ONCE((vm->use_cpu_for_update & !amdgpu_vm_is_large_bar(adev)),
+		  "CPU update of VM recommended only for large BAR system\n");
+
+	if (vm->pasid) {
+		unsigned long flags;
+
+		spin_lock_irqsave(&adev->vm_manager.pasid_lock, flags);
+		idr_remove(&adev->vm_manager.pasid_idr, vm->pasid);
+		spin_unlock_irqrestore(&adev->vm_manager.pasid_lock, flags);
+
+		vm->pasid = 0;
+	}
+
+	/* Count the new compute VM */
+	amdgpu_inc_compute_vms(adev);
+
+error:
+	amdgpu_bo_unreserve(vm->root.base.bo);
+	return r;
+}
+
+/**
  * amdgpu_vm_free_levels - free PD/PT levels
  *
  * @adev: amdgpu device structure
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
index 9f4bdef..cfd6867 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
@@ -265,6 +265,7 @@ void amdgpu_vm_manager_init(struct amdgpu_device *adev);
 void amdgpu_vm_manager_fini(struct amdgpu_device *adev);
 int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 		   int vm_context, unsigned int pasid);
+int amdgpu_vm_make_compute(struct amdgpu_device *adev, struct amdgpu_vm *vm);
 void amdgpu_vm_fini(struct amdgpu_device *adev, struct amdgpu_vm *vm);
 bool amdgpu_vm_pasid_fault_credit(struct amdgpu_device *adev,
 				  unsigned int pasid);
-- 
2.7.4


--------------410EB74F8B5DC0B387D1B15E
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--------------410EB74F8B5DC0B387D1B15E--
