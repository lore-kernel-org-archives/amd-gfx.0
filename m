Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11CC1CD6E51
	for <amd-gfx@archiver.kernel.org>; Fri, 29 May 2026 11:40:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0D09B10FDCF;
	Fri, 29 May 2026 11:40:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="rvfmiMye";
	dkim-atps=neutral
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com
 [209.85.128.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EFC0910FDCC
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 May 2026 11:40:41 +0000 (UTC)
Received: by mail-wm1-f54.google.com with SMTP id
 5b1f17b1804b1-49050ff7cbdso64088275e9.2
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 May 2026 04:40:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780054840; x=1780659640; darn=lists.freedesktop.org;
 h=content-transfer-encoding:reply-to:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to;
 bh=cvfz8ujyA2xkHPxajFMCd0JlBWKDJOBIkdLN3eGnLfI=;
 b=rvfmiMye45wBWliwZatLu4M2+dl2dtJfX12K1FP1ThO6F+hOagdExce7GU+THKh4bW
 kf9SL/YRJdJw2e05n57MP+9u0Rgpmust2hIZtZootsO/U0Yvcy7Ij/go0mkpE1AMOcKS
 T0QxMKto0WjVkWGLSLA6lHm9oaeLoDdxtdM8OQcyBKr3sonvMkCvv0QEiUGXqncd+hob
 w+X5PTPlbQq6s+YTRs5h92KPa5HDi/bZRPQBk2n9brjlVnxgzWl7E5OVhwYjBoqt4KGi
 cNruMchtU5Or2Qn+cqlhKXeePp0e/xQLa/DB/oHMjvQB0ATsfbZFrEmSnOkplq6567p+
 MBPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780054840; x=1780659640;
 h=content-transfer-encoding:reply-to:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=cvfz8ujyA2xkHPxajFMCd0JlBWKDJOBIkdLN3eGnLfI=;
 b=tHmocf9nuVWp5NQ+Q95Y/9Cgb93/+kyZSbhhc/s/bNRghTQ7sRuqJBCphpJO6SnLfC
 urjUSvYp773Nzz9L4mrnFzAlq24VJnQkN/PnFRfNvtBoCNur1EyXtm9yg/ifDF2P6toq
 ziwKAONNiUFocLRxWZ+TK3JoJ6gHoGQvL3LFciVNupO0Q+S47Qhg2yX36BuCB1r9aJvi
 1zYkRaiz0mDk/FBKADoW4ETH0V/I9sBkU/K6YzqCF4uhPCexP4OCujrPL9avm6nKQ5Gc
 xlgAI8J8s9arCuBufrOQAXDJyJdOVSAwtU6PuEo0eI9kV+bQUWCvu2ia2iERnX5LZLne
 hfSQ==
X-Gm-Message-State: AOJu0YzsMBHuaQamIfU+FvA6m0XlA/zYTafuPKHN2Y3DLFKyUi/DwpDM
 WRJweLp0mCCYsgnzKZ/Jl10lRUGWMDMj5yCHkI+rdj9JDfSS69qpYCXX
X-Gm-Gg: Acq92OG6hpcnCL3vmV1io8+7bBCEkZzpoZPpA48z3Rc4K3J/9X9QPDVdX7hh9GFAe99
 wR9bAuoMn+xyDIKy+Jf/lDLUUe7ZXlpV5h0CZXYf9BHZuWqZoD5YCSHbjfNaSn7L3Sp/Ru0WSMg
 TmXohwkEGrd9IkJn4mE+XtAuk274Kj1hmDQpvbgK5KMRaE+CtrHa7u8akQij4bVgfnhd5VIAZ24
 Hg8YbjqP3aHqc2VkN6OrNfPs2S9L3NX/JzjLuRJ5JFmExAEfaWX+nuYxtUByPQp6DeCNthAJLKA
 ii93zWBgECBkv9b4N1A/9b4NSTf3xJ0F6biuydD+h1UHhu88g6xtRW5Q39ys7lasB95nZ06YE6F
 M9VVQPjswq/sH9cQwOwRIraDXKVjUjEBOFw7FQN5nU+eTgrdg4hSBACcbhdFxp0dZiTUVeVBnR0
 UGDxZobj0CDVzzoSeragwv0D6UeZfhibyENya/X6qzNLU=
X-Received: by 2002:a05:600c:6287:b0:488:a882:c7 with SMTP id
 5b1f17b1804b1-4909c0bce7bmr48357325e9.25.1780054840408; 
 Fri, 29 May 2026 04:40:40 -0700 (PDT)
Received: from able.fritz.box ([2a00:e180:1544:8100:da55:fa26:bd:a26])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45ef354cf0dsm2993109f8f.17.2026.05.29.04.40.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 May 2026 04:40:39 -0700 (PDT)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: natalie.vock@gmx.de, honghuan@amd.com, Alexander.Deucher@amd.com,
 Felix.Kuehling@amd.com, Philip.Yang@amd.com, timur.kristof@gmail.com
Cc: amd-gfx@lists.freedesktop.org
Subject: [PATCH 06/13] drm/amdgpu: add amdgpu_vm_update_leaves()
Date: Fri, 29 May 2026 13:24:08 +0200
Message-ID: <20260529114031.3714-7-christian.koenig@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260529114031.3714-1-christian.koenig@amd.com>
References: <20260529114031.3714-1-christian.koenig@amd.com>
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
Reply-To: christian.koenig@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Add a new function amdgpu_vm_update_leaves() to avoid memory allocation
on page faults.

The idea is to only update the leave PTEs to insert a dummy PRT PTE.

TODO: HW older than GMC v9 needs a different solution.

Signed-off-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c    | 40 ++++++++++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h    |  3 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c | 71 ++++++++++++++++++++++-
 3 files changed, 103 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index e5588346a03f..94632a660b79 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -2984,10 +2984,12 @@ bool amdgpu_vm_handle_fault(struct amdgpu_device *adev, u32 pasid,
 			    u32 vmid, u32 node_id, uint64_t addr,
 			    uint64_t ts, bool write_fault)
 {
-	bool is_compute_context = false;
+	struct amdgpu_vm_update_params params;
+	bool is_compute_context;
 	struct amdgpu_bo *root;
 	uint64_t value, flags;
 	struct amdgpu_vm *vm;
+	unsigned int idx;
 	int r;
 
 	vm = amdgpu_vm_lock_by_pasid(adev, &root, pasid);
@@ -3029,24 +3031,46 @@ bool amdgpu_vm_handle_fault(struct amdgpu_device *adev, u32 pasid,
 		value = adev->dummy_page_addr;
 		flags |= AMDGPU_PTE_EXECUTABLE | AMDGPU_PTE_READABLE |
 			AMDGPU_PTE_WRITEABLE;
-
+		/* On +gfx9 we can use the PRT functionality instead */
+		if (!adev->gmc.gmc_funcs->set_prt) {
+			flags &= ~AMDGPU_PTE_VALID;
+			flags |= AMDGPU_PTE_PRT;
+		}
 	} else {
 		/* Let the hw retry silently on the PTE */
 		value = 0;
 	}
 
+	if (!drm_dev_enter(adev_to_drm(adev), &idx)) {
+		r = -ENODEV;
+		goto error_unlock;
+	}
+
+	amdgpu_vm_eviction_lock(vm);
+	if (vm->evicting) {
+		r = -EBUSY;
+		goto error_dev_exit;
+	}
+
+	memset(&params, 0, sizeof(params));
+	params.adev = adev;
+	params.vm = vm;
+	params.immediate = true;
+	params.pages_addr = NULL;
+
 	r = dma_resv_reserve_fences(root->tbo.base.resv, 1);
 	if (r) {
 		pr_debug("failed %d to reserve fence slot\n", r);
-		goto error_unlock;
+		goto error_eviction_lock;
 	}
 
-	r = amdgpu_vm_update_range(adev, vm, true, false, false, false,
-				   NULL, addr, addr, flags, value, 0, NULL, NULL, NULL);
-	if (r)
-		goto error_unlock;
+	amdgpu_vm_update_leaves(&params, addr, addr, value, flags);
 
-	r = amdgpu_vm_update_pdes(adev, vm, true);
+error_eviction_lock:
+	amdgpu_vm_eviction_unlock(vm);
+
+error_dev_exit:
+	drm_dev_exit(idx);
 
 error_unlock:
 	amdgpu_bo_unreserve(root);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
index cc096c005e34..04b32accfa3f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
@@ -613,6 +613,9 @@ int amdgpu_vm_pde_update(struct amdgpu_vm_update_params *params,
 int amdgpu_vm_ptes_update(struct amdgpu_vm_update_params *params,
 			  uint64_t start, uint64_t end,
 			  uint64_t dst, uint64_t flags);
+void amdgpu_vm_update_leaves(struct amdgpu_vm_update_params *params,
+			     uint64_t start, uint64_t end,
+			     int64_t dst, uint64_t flags);
 void amdgpu_vm_pt_free_work(struct work_struct *work);
 void amdgpu_vm_pt_free_list(struct amdgpu_device *adev,
 			    struct amdgpu_vm_update_params *params);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
index e43a60d09808..9766b6b9aecc 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
@@ -790,6 +790,8 @@ int amdgpu_vm_ptes_update(struct amdgpu_vm_update_params *params,
 			  uint64_t dst, uint64_t flags)
 {
 	struct amdgpu_device *adev = params->adev;
+	struct amdgpu_vm *vm = params->vm;
+	pid_t tgid = vm->task_info ? vm->task_info->tgid : 0;
 	struct amdgpu_vm_pt_cursor cursor;
 	uint64_t frag_start = start, frag_end;
 	unsigned int frag;
@@ -881,7 +883,6 @@ int amdgpu_vm_ptes_update(struct amdgpu_vm_update_params *params,
 		entry_end = min(entry_end, end);
 
 		do {
-			struct amdgpu_vm *vm = params->vm;
 			uint64_t upd_end = min(entry_end, frag_end);
 			unsigned int nptes = (upd_end - frag_start) >> shift;
 			uint64_t upd_flags = flags | AMDGPU_PTE_FRAG(frag);
@@ -893,8 +894,7 @@ int amdgpu_vm_ptes_update(struct amdgpu_vm_update_params *params,
 
 			trace_amdgpu_vm_update_ptes(params, frag_start, upd_end,
 						    min(nptes, 32u), dst, incr,
-						    upd_flags,
-						    vm->task_info ? vm->task_info->tgid : 0,
+						    upd_flags, tgid,
 						    vm->immediate.fence_context);
 			amdgpu_vm_pte_update_flags(params, to_amdgpu_bo_vm(pt),
 						   cursor.level, pe_start, dst,
@@ -938,6 +938,71 @@ int amdgpu_vm_ptes_update(struct amdgpu_vm_update_params *params,
 	return 0;
 }
 
+/**
+ * amdgpu_vm_update_leaves - update leave PDEs/PTEs
+ *
+ * @params: see amdgpu_vm_update_params definition
+ * @start: start of GPU address range
+ * @end: end of GPU address range
+ * @dst: destination address to insert into the leave PDEs/PTEs
+ * @flags: mapping flags
+ *
+ * Update the leave PDEs/PTEs in the range @start - @end without allocating or
+ * freeing page tables.
+ *
+ * Returns:
+ * 0 for success, negative error code for failure.
+ */
+void amdgpu_vm_update_leaves(struct amdgpu_vm_update_params *params,
+			     uint64_t start, uint64_t end,
+			     int64_t dst, uint64_t flags)
+{
+	struct amdgpu_device *adev = params->adev;
+	struct amdgpu_vm *vm = params->vm;
+	pid_t tgid = vm->task_info ? vm->task_info->tgid : 0;
+	struct amdgpu_vm_pt_cursor cursor;
+
+	amdgpu_vm_pt_start(adev, params->vm, start, &cursor);
+	while (cursor.pfn < end) {
+		unsigned int shift, mask;
+		uint64_t entry_end, pe_start;
+		struct amdgpu_bo *pt;
+		unsigned int nptes;
+
+		/* Walk to the leave entries */
+		if (amdgpu_vm_pt_descendant(adev, &cursor))
+			continue;
+
+		pt = cursor.parent->bo;
+		shift = amdgpu_vm_pt_level_shift(adev, cursor.level - 1);
+		mask = amdgpu_vm_pt_entries_mask(adev, cursor.level - 1);
+
+		/* Looks good so far, calculate parameters for the update */
+		pe_start = ((cursor.pfn >> shift) & mask) * 8;
+
+		entry_end = ((uint64_t)mask + 1) << shift;
+		entry_end += cursor.pfn & ~(entry_end - 1);
+		entry_end = min(entry_end, end);
+
+		nptes = (entry_end - cursor.pfn) >> shift;
+		/*
+		 * This can happen when we set higher level PDEs to unmap and/or
+		 * silent to stop fault floods.
+		 */
+		nptes = max(nptes, 1u);
+
+		trace_amdgpu_vm_update_ptes(params, cursor.pfn, entry_end,
+					    min(nptes, 32u), dst, 0, flags,
+					    tgid,
+					    vm->immediate.fence_context);
+		amdgpu_vm_pte_update_flags(params, to_amdgpu_bo_vm(pt),
+					   cursor.level - 1, pe_start, dst,
+					   nptes, 0, flags);
+
+		amdgpu_vm_pt_next(adev, &cursor);
+	}
+}
+
 /**
  * amdgpu_vm_pt_map_tables - have bo of root PD cpu accessible
  * @adev: amdgpu device structure
-- 
2.43.0

