From: =?UTF-8?Q?Nicolai_H=c3=a4hnle?= <nhaehnle-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Raciness with page table shadows being swapped out
Date: Mon, 12 Dec 2016 16:20:05 +0100
Message-ID: <9153dde6-9087-94b0-a062-dd223e5f381a@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------F457691D4A74B89C8FB55E36"
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
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
To: "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

This is a multi-part message in MIME format.
--------------F457691D4A74B89C8FB55E36
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi all,

I just sent out two patches that hopefully make the kernel module more 
robust in the face of page table shadows being swapped out.

However, even with those patches, I can still fairly reliably reproduce 
crashes with a backtrace of the shape

amdgpu_cs_ioctl
  -> amdgpu_vm_update_page_directory
  -> amdgpu_ttm_bind
  -> amdgpu_gtt_mgr_alloc

The plausible reason for these crashes is that nothing seems to prevent 
the shadow BOs from being moved between the calls to amdgpu_cs_validate 
in amdgpu_cs_parser_bos and the calls to amdgpu_ttm_bind.

The attached patch has fixed these crashes for me so far, but it's very 
heavy-handed: it collects all page table shadows and the page directory 
shadow and adds them all to the reservations for the callers of 
amdgpu_vm_update_page_directory.

I feel like there should be a better way. In part, I wonder why the 
shadows are needed in the first place. I vaguely recall the discussions 
about GPU reset and such, but I don't remember why the page tables can't 
just be rebuilt in some other way.

Cheers,
Nicolai

--------------F457691D4A74B89C8FB55E36
Content-Type: text/x-patch;
 name="0001-drm-amd-amdgpu-reserve-shadows-of-page-directory-and.patch"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment;
 filename*0="0001-drm-amd-amdgpu-reserve-shadows-of-page-directory-and.pa";
 filename*1="tch"

>From 70706d2283773f19b42312bc34e36c4717a9ce62 Mon Sep 17 00:00:00 2001
From: =?UTF-8?q?Nicolai=20H=C3=A4hnle?= <nicolai.haehnle-5C7GfCeVMHo@public.gmane.org>
Date: Mon, 12 Dec 2016 15:02:27 +0100
Subject: [PATCH] drm/amd/amdgpu: reserve shadows of page directory and tables
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Signed-off-by: Nicolai Hähnle <nicolai.haehnle-5C7GfCeVMHo@public.gmane.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h     |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c  |  9 +++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c | 10 +++++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c  | 45 +++++++++++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h  |  3 +++
 5 files changed, 67 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index f53e52f..7a84648 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -916,20 +916,21 @@ struct amdgpu_cs_parser {
 	unsigned		nchunks;
 	struct amdgpu_cs_chunk	*chunks;
 
 	/* scheduler job object */
 	struct amdgpu_job	*job;
 
 	/* buffer objects */
 	struct ww_acquire_ctx		ticket;
 	struct amdgpu_bo_list		*bo_list;
 	struct amdgpu_bo_list_entry	vm_pd;
+	struct amdgpu_bo_list_entry	*vm_pd_pt_shadows;
 	struct list_head		validated;
 	struct dma_fence		*fence;
 	uint64_t			bytes_moved_threshold;
 	uint64_t			bytes_moved;
 	struct amdgpu_bo_list_entry	*evictable;
 
 	/* user fence */
 	struct amdgpu_bo_list_entry	uf_entry;
 };
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
index 985f842..eecf2eb 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
@@ -510,20 +510,26 @@ static int amdgpu_cs_parser_bos(struct amdgpu_cs_parser *p,
 	p->bo_list = amdgpu_bo_list_get(fpriv, cs->in.bo_list_handle);
 	if (p->bo_list) {
 		need_mmap_lock = p->bo_list->first_userptr !=
 			p->bo_list->num_entries;
 		amdgpu_bo_list_get_list(p->bo_list, &p->validated);
 	}
 
 	INIT_LIST_HEAD(&duplicates);
 	amdgpu_vm_get_pd_bo(&fpriv->vm, &p->validated, &p->vm_pd);
 
+	r = amdgpu_vm_get_pd_pt_shadows(&fpriv->vm, &p->validated, &p->vm_pd_pt_shadows);
+	if (r) {
+		DRM_ERROR("amdgpu_vm_get_pd_pt_shadows failed.\n");
+		goto error_release_list;
+	}
+
 	if (p->uf_entry.robj)
 		list_add(&p->uf_entry.tv.head, &p->validated);
 
 	if (need_mmap_lock)
 		down_read(&current->mm->mmap_sem);
 
 	while (1) {
 		struct list_head need_pages;
 		unsigned i;
 
@@ -673,20 +679,21 @@ static int amdgpu_cs_parser_bos(struct amdgpu_cs_parser *p,
 	if (r) {
 		amdgpu_vm_move_pt_bos_in_lru(p->adev, &fpriv->vm);
 		ttm_eu_backoff_reservation(&p->ticket, &p->validated);
 	}
 
 error_free_pages:
 
 	if (need_mmap_lock)
 		up_read(&current->mm->mmap_sem);
 
+error_release_list:
 	if (p->bo_list) {
 		for (i = p->bo_list->first_userptr;
 		     i < p->bo_list->num_entries; ++i) {
 			e = &p->bo_list->array[i];
 
 			if (!e->user_pages)
 				continue;
 
 			release_pages(e->user_pages,
 				      e->robj->tbo.ttm->num_pages,
@@ -736,20 +743,22 @@ static void amdgpu_cs_parser_fini(struct amdgpu_cs_parser *parser, int error, bo
 		ttm_eu_backoff_reservation(&parser->ticket,
 					   &parser->validated);
 	}
 	dma_fence_put(parser->fence);
 
 	if (parser->ctx)
 		amdgpu_ctx_put(parser->ctx);
 	if (parser->bo_list)
 		amdgpu_bo_list_put(parser->bo_list);
 
+	drm_free_large(parser->vm_pd_pt_shadows);
+
 	for (i = 0; i < parser->nchunks; i++)
 		drm_free_large(parser->chunks[i].kdata);
 	kfree(parser->chunks);
 	if (parser->job)
 		amdgpu_job_free(parser->job);
 	amdgpu_bo_unref(&parser->uf_entry.robj);
 }
 
 static int amdgpu_bo_vm_update_pte(struct amdgpu_cs_parser *p,
 				   struct amdgpu_vm *vm)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
index ffb3e70..379ccde 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
@@ -495,39 +495,44 @@ static int amdgpu_gem_va_check(void *param, struct amdgpu_bo *bo)
  *
  * Update the bo_va directly after setting it's address. Errors are not
  * vital here, so they are not reported back to userspace.
  */
 static void amdgpu_gem_va_update_vm(struct amdgpu_device *adev,
 				    struct amdgpu_bo_va *bo_va,
 				    uint32_t operation)
 {
 	struct ttm_validate_buffer tv, *entry;
 	struct amdgpu_bo_list_entry vm_pd;
+	struct amdgpu_bo_list_entry *vm_pd_pt_shadows;
 	struct amdgpu_bo *pd_shadow;
 	struct ww_acquire_ctx ticket;
 	struct list_head list, duplicates;
 	unsigned domain;
 	int r;
 
 	INIT_LIST_HEAD(&list);
 	INIT_LIST_HEAD(&duplicates);
 
 	tv.bo = &bo_va->bo->tbo;
 	tv.shared = true;
 	list_add(&tv.head, &list);
 
 	amdgpu_vm_get_pd_bo(bo_va->vm, &list, &vm_pd);
 
+	r = amdgpu_vm_get_pd_pt_shadows(bo_va->vm, &list, &vm_pd_pt_shadows);
+	if (r)
+		goto error_print;
+
 	/* Provide duplicates to avoid -EALREADY */
 	r = ttm_eu_reserve_buffers(&ticket, &list, true, &duplicates);
 	if (r)
-		goto error_print;
+		goto error_reserve_failed;
 
 	list_for_each_entry(entry, &list, head) {
 		domain = amdgpu_mem_type_to_domain(entry->bo->mem.mem_type);
 		/* if anything is swapped out don't swap it in here,
 		   just abort and wait for the next CS */
 		if (domain == AMDGPU_GEM_DOMAIN_CPU)
 			goto error_unreserve;
 	}
 
 	/* Also abort if the page directory shadow has been swapped out. */
@@ -551,20 +556,23 @@ static void amdgpu_gem_va_update_vm(struct amdgpu_device *adev,
 	r = amdgpu_vm_clear_freed(adev, bo_va->vm);
 	if (r)
 		goto error_unreserve;
 
 	if (operation == AMDGPU_VA_OP_MAP)
 		r = amdgpu_vm_bo_update(adev, bo_va, false);
 
 error_unreserve:
 	ttm_eu_backoff_reservation(&ticket, &list);
 
+error_reserve_failed:
+	drm_free_large(vm_pd_pt_shadows);
+
 error_print:
 	if (r && r != -ERESTARTSYS)
 		DRM_ERROR("Couldn't update BO_VA (%d)\n", r);
 }
 
 int amdgpu_gem_va_ioctl(struct drm_device *dev, void *data,
 			  struct drm_file *filp)
 {
 	struct drm_amdgpu_gem_va *args = data;
 	struct drm_gem_object *gobj;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 1dda932..b63a9bf 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -109,20 +109,65 @@ void amdgpu_vm_get_pd_bo(struct amdgpu_vm *vm,
 {
 	entry->robj = vm->page_directory;
 	entry->priority = 0;
 	entry->tv.bo = &vm->page_directory->tbo;
 	entry->tv.shared = true;
 	entry->user_pages = NULL;
 	list_add(&entry->tv.head, validated);
 }
 
 /**
+ * TODO document
+ */
+int amdgpu_vm_get_pd_pt_shadows(struct amdgpu_vm *vm,
+				struct list_head *validated,
+				struct amdgpu_bo_list_entry **pentries)
+{
+	struct amdgpu_bo *shadow;
+	struct amdgpu_bo_list_entry *entry;
+	unsigned nentries;
+	unsigned i;
+
+	*pentries = drm_calloc_large(vm->max_pde_used + 2,
+				     sizeof(struct amdgpu_bo_list_entry));
+	if (!*pentries)
+		return -ENOMEM;
+
+	nentries = 0;
+
+	if (vm->page_directory->shadow) {
+		shadow = vm->page_directory->shadow;
+		entry = &(*pentries)[nentries++];
+		entry->robj = shadow;
+		entry->tv.bo = &shadow->tbo;
+		entry->tv.shared = true;
+		list_add(&entry->tv.head, validated);
+	}
+
+	for (i = 0; i <= vm->max_pde_used; ++i) {
+		struct amdgpu_bo *bo = vm->page_tables[i].bo;
+
+		if (!bo || !bo->shadow)
+			continue;
+
+		shadow = bo->shadow;
+		entry = &(*pentries)[nentries++];
+		entry->robj = shadow;
+		entry->tv.bo = &shadow->tbo;
+		entry->tv.shared = true;
+		list_add(&entry->tv.head, validated);
+	}
+
+	return 0;
+}
+
+/**
  * amdgpu_vm_validate_pt_bos - validate the page table BOs
  *
  * @adev: amdgpu device pointer
  * @vm: vm providing the BOs
  * @validate: callback to do the validation
  * @param: parameter for the validation callback
  *
  * Validate the page table BOs on command submission if neccessary.
  */
 int amdgpu_vm_validate_pt_bos(struct amdgpu_device *adev, struct amdgpu_vm *vm,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
index adbc2f5..ad0b87a6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
@@ -159,20 +159,23 @@ struct amdgpu_vm_manager {
 	atomic64_t				client_counter;
 };
 
 void amdgpu_vm_manager_init(struct amdgpu_device *adev);
 void amdgpu_vm_manager_fini(struct amdgpu_device *adev);
 int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm);
 void amdgpu_vm_fini(struct amdgpu_device *adev, struct amdgpu_vm *vm);
 void amdgpu_vm_get_pd_bo(struct amdgpu_vm *vm,
 			 struct list_head *validated,
 			 struct amdgpu_bo_list_entry *entry);
+int amdgpu_vm_get_pd_pt_shadows(struct amdgpu_vm *vm,
+				struct list_head *validated,
+				struct amdgpu_bo_list_entry **pentries);
 int amdgpu_vm_validate_pt_bos(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 			      int (*callback)(void *p, struct amdgpu_bo *bo),
 			      void *param);
 void amdgpu_vm_move_pt_bos_in_lru(struct amdgpu_device *adev,
 				  struct amdgpu_vm *vm);
 int amdgpu_vm_grab_id(struct amdgpu_vm *vm, struct amdgpu_ring *ring,
 		      struct amdgpu_sync *sync, struct dma_fence *fence,
 		      struct amdgpu_job *job);
 int amdgpu_vm_flush(struct amdgpu_ring *ring, struct amdgpu_job *job);
 void amdgpu_vm_reset_id(struct amdgpu_device *adev, unsigned vm_id);
-- 
2.7.4


--------------F457691D4A74B89C8FB55E36
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--------------F457691D4A74B89C8FB55E36--
