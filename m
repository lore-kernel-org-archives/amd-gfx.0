Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43D00CA5FCA
	for <amd-gfx@archiver.kernel.org>; Wed, 30 Sep 2026 13:33:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D4FE010F3F5;
	Wed, 30 Sep 2026 13:33:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="H2apOMsU";
	dkim-atps=neutral
Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com
 [74.125.225.141])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B1DE510F3F5
 for <amd-gfx@lists.freedesktop.org>; Wed, 30 Sep 2026 13:33:20 +0000 (UTC)
Received: by mail-wm2-f13.google.com with SMTP id
 5b1f17b1804b1-4a00d8bec5aso12698165e9.2
 for <amd-gfx@lists.freedesktop.org>; Wed, 30 Sep 2026 06:33:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790775199; x=1791379999; darn=lists.freedesktop.org;
 h=content-transfer-encoding:reply-to:content-type:mime-version
 :references:in-reply-to:message-id:date:subject:cc:to:from:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=mZXgG7LNCLJctuba28KYlbW9BwxpeiXtQwJGE4OSkY4=;
 b=H2apOMsUOAPt87dVWXRsc1a7SNgCymOKmFMpAG0GvySsKsxTNqRexSF+uJ4hRvK/Y7
 Pn3RuZVf1iVCYFhutZAgCPUK9+ruMORW7q75SsPqpbXOJDPVGh3K4JUQhbbO9KB4843s
 BoXnIOc7gjycifMEepxYvaVO8A85kHsi7Asdf32YvA/yiAN87ciBsmVIxryZlpwYUilP
 O/vpImARlOiA+kqB+UCU6a+eu1CqnSg2BZLTgtgkD3uZoxo3qQzMchSLlSEww2FZ0HQ1
 rjbOovpHr8RGfqYp+C1i5K+HXhXBWojx17F+6eTjDB8YueDNF0yd36ZgYbH9H8kVxoxB
 UlTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790775199; x=1791379999;
 h=content-transfer-encoding:reply-to:content-type:mime-version
 :references:in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=mZXgG7LNCLJctuba28KYlbW9BwxpeiXtQwJGE4OSkY4=;
 b=lq4t/PEmIle00soPolessbXm/u3Px+72F6cCm+5VrBBGI7ptVYO+QCFPJUQKEYHMCk
 vTjgEzXne9BlMkuylNN16CWXSBDQEzOKZ8676CFH9ZMSpyYRxDvYSpKe51kWHU4/FvE1
 niadyZ6SF8jhZW0NvpvYzFUyhiN5gBeyVXfhX/HvAHA8gPSewoEVRM5PQ0TZTshJhHls
 xuAi53skYXJM8FF7+lJgpGVm29XsRrgiEKq3IJ6aOT8fp4OV6BlmLGN2sKXp9EOBoA5V
 yOep482ximeK2Si111O/xv8w+pL0T6BrWW3jkPmYxOMKF0gtxeO4MvWYjgW/D6vO+f4y
 tAZw==
X-Gm-Message-State: AFuF++nHKz95Envpgk9J2bRNImZhPl9/Qw1DqCdjDdSs/nYv1A2EnobU
 wDZxmBB0DxIQSpKZCaIDxyW68OqVOvDtXmsE+jnoRYD7I5P67b8rcTad
X-Gm-Gg: AYBFou37Szwzhd3R5/SpSFjSpajTarREQN6o5LLf6QmUESu1m72ZWPTTVAMLCTL+ciB
 MeeNTgRhtbEzFwXZmvyVa/ajk5AsFhRVahWYfovYzGOg6mNMCsvIUnJdwjvgzfs2j/rvU1OEErf
 9+kgeL3AVO61jII0GtoyG6iUmvG1pr3fqQ4b/GHGwXI5yS/qfrDpIWFZoJOwa/vHR5/cZytQECF
 3BpdlCoPfc1t6WZckYATg5WACWqRrZNulabiblfhFxCcWe+bXAyjwImRbGX2jX53eem6lTJaVKA
 ej/OFvh7byZW3RJgiOYfATbTdqEt/HOwgxKFaIZgh5g1kYYOCudGEdS+XcJ2mNR5s7O8uyhYijP
 REssues/thu0/Z/VCWVOh05gsWzsOj8qKUrJCSbqLCaCYLAMWpA0FYSzlBFPuLCNpPpa6UzXHRO
 yLonLZbbd/2Vv8X/hfdMtmafbRrQtWYv2IVWaqtHpkUkkhrztkiGlk8H7PXzkptH4igE3ptuOGw
 L6AokHsvmU=
X-Received: by 2002:a05:600c:45d3:b0:49f:cac3:c68a with SMTP id
 5b1f17b1804b1-4a01affeca0mr21811475e9.31.1790775198955; 
 Wed, 30 Sep 2026 06:33:18 -0700 (PDT)
Received: from able.fritz.box ([2a00:e180:155e:6500:f261:39ca:dadd:d0c6])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a01771cf9fsm60407975e9.14.2026.09.30.06.33.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Sep 2026 06:33:18 -0700 (PDT)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: natalie.vock@gmx.de, honghuan@amd.com, Alexander.Deucher@amd.com,
 Felix.Kuehling@amd.com, Philip.Yang@amd.com, timur.kristof@gmail.com,
 cascardo@igalia.com, tvrtko.ursulin@igalia.com, olivier.kaloudoff@gmail.com
Cc: amd-gfx@lists.freedesktop.org
Subject: [PATCH 3/8] drm/amdgpu: add amdgpu_vm_pt_leaves() v3
Date: Wed, 30 Sep 2026 15:33:09 +0200
Message-ID: <20260930133315.12270-3-christian.koenig@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260930133315.12270-1-christian.koenig@amd.com>
References: <20260930133315.12270-1-christian.koenig@amd.com>
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

The idea is to only update the leave PDEs/PTEs to let them point to the
dummy page.

v2: fix of by one, rework the function to work correctly on PTB as well.
v3: use NUM_LEVELS, don't overwrite vm->last_update

Signed-off-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c        | 54 ++++++++++----
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h        |  5 +-
 .../gpu/drm/amd/amdgpu/amdgpu_vm_internal.h   |  3 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c     | 74 +++++++++++++++++++
 4 files changed, 119 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index c0cf10d030c36..eb704d07dce61 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -3072,10 +3072,12 @@ bool amdgpu_vm_handle_fault(struct amdgpu_device *adev, u32 pasid,
 			    u32 vmid, u32 node_id, uint64_t addr,
 			    uint64_t ts, bool write_fault)
 {
+	struct amdgpu_vm_update_params params;
 	bool is_compute_context = false;
-	struct drm_exec exec;
-	uint64_t value, flags;
+	uint64_t *dst, flags[AMDGPU_VM_NUM_LEVELS];
 	struct amdgpu_vm *vm;
+	struct drm_exec exec;
+	unsigned int idx;
 	int r;
 
 	drm_exec_init(&exec, 0, 1);
@@ -3119,24 +3121,24 @@ bool amdgpu_vm_handle_fault(struct amdgpu_device *adev, u32 pasid,
 	}
 
 	addr /= AMDGPU_GPU_PAGE_SIZE;
-	flags = adev->gmc.init_pte_flags |
-		AMDGPU_PTE_VALID | AMDGPU_PTE_SNOOPED |
-		AMDGPU_PTE_SYSTEM;
-
 	if (is_compute_context) {
 		/* Intentionally setting invalid PTE flag
 		 * combination to force a no-retry-fault
 		 */
-		flags = AMDGPU_VM_NORETRY_FLAGS;
-		value = 0;
+		for (int i = 0; i < AMDGPU_VM_NUM_LEVELS; ++i)
+			flags[i] = AMDGPU_VM_NORETRY_FLAGS;
+		dst = NULL;
 	} else if (amdgpu_vm_fault_stop == AMDGPU_VM_FAULT_STOP_NEVER) {
 		/* Redirect the access to the dummy page */
-		value = adev->dummy_page_addr;
-		flags |= AMDGPU_PTE_EXECUTABLE | AMDGPU_PTE_READABLE |
-			 AMDGPU_PTE_WRITEABLE;
+		for (int i = 0; i < AMDGPU_VM_NUM_LEVELS; ++i)
+			flags[i] = 0;
+		dst = adev->vm_manager.dummy_dst;
 	} else {
 		/* Let the hw retry silently on the PTE */
-		value = 0;
+		for (int i = 0; i < AMDGPU_VM_NUM_LEVELS; ++i)
+			flags[i] = AMDGPU_PTE_VALID | AMDGPU_PTE_SNOOPED |
+				AMDGPU_PTE_SYSTEM;
+		dst = NULL;
 	}
 
 	r = dma_resv_reserve_fences(vm->root.bo->tbo.base.resv, 1);
@@ -3145,12 +3147,32 @@ bool amdgpu_vm_handle_fault(struct amdgpu_device *adev, u32 pasid,
 		goto error_unlock;
 	}
 
-	r = amdgpu_vm_update_range(adev, vm, true, false, false, false,
-				   NULL, addr, addr, flags, value, 0, NULL, NULL, NULL);
-	if (r)
+	if (!drm_dev_enter(adev_to_drm(adev), &idx)) {
+		r = -ENODEV;
 		goto error_unlock;
+	}
 
-	r = amdgpu_vm_update_pdes(adev, vm, true);
+	memset(&params, 0, sizeof(params));
+	params.adev = adev;
+	params.vm = vm;
+	params.immediate = true;
+
+	r = amdgpu_vm_begin_critical(&params);
+	if (r)
+		goto error_end_critical;
+
+	r = vm->update_funcs->prepare(&params, NULL,
+				      AMDGPU_KERNEL_JOB_ID_VM_UPDATE_PDES);
+	if (r)
+		goto error_end_critical;
+
+	amdgpu_vm_pt_leaves(&params, addr, addr + 1, dst, flags);
+
+	r = vm->update_funcs->commit(&params, NULL);
+
+error_end_critical:
+	amdgpu_vm_end_critical(&params);
+	drm_dev_exit(idx);
 
 error_unlock:
 	drm_exec_fini(&exec);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
index c59647554b416..4ba49fe045df9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
@@ -195,7 +195,10 @@ enum amdgpu_vm_level {
 	AMDGPU_VM_PDB2,
 	AMDGPU_VM_PDB1,
 	AMDGPU_VM_PDB0,
-	AMDGPU_VM_PTB
+	AMDGPU_VM_PTB,
+
+	/* Not HW level, but for array sizing */
+	AMDGPU_VM_NUM_LEVELS
 };
 
 /* base structure for tracking BO usage in a VM */
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_internal.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_internal.h
index 3c48a3401e2a4..dafdb3a001b8e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_internal.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_internal.h
@@ -126,6 +126,9 @@ int amdgpu_vm_pde_update(struct amdgpu_vm_update_params *params,
 int amdgpu_vm_ptes_update(struct amdgpu_vm_update_params *params,
 			  uint64_t start, uint64_t end,
 			  uint64_t dst, uint64_t flags);
+void amdgpu_vm_pt_leaves(struct amdgpu_vm_update_params *params,
+			 uint64_t start, uint64_t end,
+			 int64_t *dst, uint64_t *flags);
 void amdgpu_vm_pt_free_work(struct work_struct *work);
 void amdgpu_vm_pt_free_list(struct amdgpu_device *adev,
 			    struct amdgpu_vm_update_params *params);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
index 710c813c3a045..ab39122f19b68 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
@@ -963,6 +963,80 @@ int amdgpu_vm_ptes_update(struct amdgpu_vm_update_params *params,
 	return 0;
 }
 
+/**
+ * amdgpu_vm_pt_leaves - update leaf PDEs/PTEs
+ *
+ * @params: see amdgpu_vm_update_params definition
+ * @start: start of GPU address range
+ * @end: end of GPU address range
+ * @dst: optional array with one dst addr per layer
+ * @flags: array of mapping flags per layer
+ *
+ * Update the leaf PDEs/PTEs in the range @start - @end without allocating or
+ * freeing page tables.
+ *
+ * Returns:
+ * 0 for success, negative error code for failure.
+ */
+void amdgpu_vm_pt_leaves(struct amdgpu_vm_update_params *params,
+			 uint64_t start, uint64_t end,
+			 int64_t *dst, uint64_t *flags)
+{
+	struct amdgpu_device *adev = params->adev;
+	struct amdgpu_vm_pt_cursor cursor;
+
+	amdgpu_vm_pt_start(adev, params->vm, start, &cursor);
+	while (cursor.pfn < end) {
+		unsigned int level, shift, mask, nptes;
+		uint64_t pe_start, entry_start, entry_end, d, f;
+		struct amdgpu_bo *pt;
+
+		/* Walk to the leave entries */
+		if (amdgpu_vm_pt_descendant(adev, &cursor))
+			continue;
+
+		if (cursor.entry->bo) {
+			level = cursor.level;
+			pt = cursor.entry->bo;
+		} else {
+			level = cursor.level - 1;
+			pt = cursor.parent->bo;
+		}
+
+		shift = amdgpu_vm_pt_level_shift(adev, level);
+		mask = amdgpu_vm_pt_entries_mask(adev, level);
+
+		/* Looks good so far, calculate parameters for the update */
+		pe_start = ((cursor.pfn >> shift) & mask) * 8;
+
+		entry_start = cursor.pfn;
+		if (cursor.entry->bo) {
+			entry_end = ((uint64_t)mask + 1) << shift;
+			entry_end += cursor.pfn & ~(entry_end - 1);
+			entry_end = min(entry_end, end);
+
+			nptes = (entry_end - cursor.pfn) >> shift;
+			amdgpu_vm_pt_next(adev, &cursor);
+		} else {
+			nptes = 0;
+			entry_end = cursor.pfn;
+			do {
+				nptes += 1;
+				entry_end += 1 << shift;
+				amdgpu_vm_pt_next(adev, &cursor);
+			} while (cursor.parent && cursor.parent->bo == pt &&
+				 cursor.pfn < end && !cursor.entry->bo);
+		}
+
+		d = dst ? dst[level] : 0;
+		f = flags[level];
+		trace_amdgpu_vm_update_ptes(params, entry_start, entry_end,
+					    min(nptes, 32u), d, 0, f);
+		params->vm->update_funcs->update(params, to_amdgpu_bo_vm(pt),
+						 pe_start, d, nptes, 0, f);
+	}
+}
+
 /**
  * amdgpu_vm_pt_map_tables - have bo of root PD cpu accessible
  * @adev: amdgpu device structure
-- 
2.43.0

