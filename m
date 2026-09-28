Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50A0CCA5FA7
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Sep 2026 15:10:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 030D110EAB5;
	Mon, 28 Sep 2026 15:10:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="hGFvYzzk";
	dkim-atps=neutral
Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com
 [74.125.225.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1AE1510E8F3
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Sep 2026 15:10:48 +0000 (UTC)
Received: by mail-wr2-f12.google.com with SMTP id
 ffacd0b85a97d-4843c3ea1f6so1728796f8f.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Sep 2026 08:10:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790608246; x=1791213046; darn=lists.freedesktop.org;
 h=content-transfer-encoding:reply-to:content-type:mime-version
 :references:in-reply-to:message-id:date:subject:cc:to:from:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=KrI5RF4IWVKo+yDbZ/ZX0Ir+MqMgdkoJbnN1luSTnYA=;
 b=hGFvYzzk2xsncHSuJqe2gbi8bbZhHUeCj1u2pGan6pK5evX3vDQzBgHI2fgYmlZ2SH
 OzP+DRtFYDHVJ9WK03Lm7Gc/O+BeINdHn9E1V6fFZvVXb2sstK5Pqi2r9CbWW/WIlKCx
 1RRa2DYn9t9xDpJhzeEM8HDIdsIw4AEBDosJZEbchL4gbkNVwTVD7pn4KiSsjFYl7u+2
 KnD6m+mHJHjbGdzFIUSOYfVVtueJBUFSerogHdv7mJcE5A2miN1FKL6lyFx0NB6qR0Xn
 nlkhOkWdqZhj625h5P+rxSlEQ8zyPRbBvxwCmQinH0/+YUppxp+t91FBhWeiCmBdVy24
 Gstg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790608246; x=1791213046;
 h=content-transfer-encoding:reply-to:content-type:mime-version
 :references:in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=KrI5RF4IWVKo+yDbZ/ZX0Ir+MqMgdkoJbnN1luSTnYA=;
 b=SUFIQ08MqEb40y+W2I+c7gMJgHcAEWj+DIWoZ7Eysapr/NfH76AwKKNoBfGm7P+cdz
 vnK6KjRedPZTZAeLYTQE7yWLcU6wDerSTdYxQTGemrj7LSfh78T8ojMRtPKrzm32VYyJ
 DWHm9q38eb1hWk8dRNFTQkHOnK/tALMFgvlaqgtsjwkkSZMoUhfx+6xNii1Kui3wsuUV
 w52m992RJ6jcPQ2nGpVca1CJrHiYaFadnc/r5pzlZ77A0Sq2NedzBMlECEQjusYH6A+w
 6skYtFdvWlrnidwj6lYQM6lNM9N+7wxlpTCQcNwask20HS9dy/Fsq7bASMtazmt1zPDN
 04dw==
X-Gm-Message-State: AFq9FYLeWRawY3lebHm0WJVAeDRmdjFzSKKdbNcBntZDpLDJp3XJRi9x
 4CydEQzY6lU0seZF1UKQ6E7PYo/At+Y3ZmEhu9eRAGWza+qJN6ZKKkl/
X-Gm-Gg: AYBFou1zNjRjn5iqGI8Vxj+OQYqUZ1Q6B2bOFMNEMIApEKTZC+w6mmKspYAEKt4b0E2
 GZjNpWK9UQXvPKhwv3ynOOVWs+z9KS5RvsWCLsafx4vmmIdGL6jtjnOvaxChQev5jHHndA/TRpF
 vjst7ORy6OPvME7B2zwWMqUHZSlYBSwxXUCgKxSWd7qMdFfWKBI1Y9J3fNih9Hcy3aB7huw5S02
 1iJG8LsEPrRJdFG3ZwhX3K3590hO6Gcmc290RoPNb/4iifSwNWfpbJi3aWfiUt1MrPcoM/oJCot
 t4KhwrPqm+rXtmA1LiEuEO0415BtOehwOqX3DWSwtdFpBCuyUhVIRpSJoOin7fwAft/RVQX3XUp
 2SlIbOl6QQSd3p8ad/xBVctozEeUmT8Yx0Dgb7Vg07oK8ZRXX5IRXLpwxHwJJJVEGxMIuEtz3pO
 ZwseeTExjzhJiEM49qWeraGAmJAUz+yMea7qLFCLN3/Y2Lr8qYO15tPaJIhDStZJY+gVwyHNL2X
 PtRjrh+OWg=
X-Received: by 2002:a05:6000:3c8:b0:488:89a6:b38f with SMTP id
 ffacd0b85a97d-48889a6b5c8mr10872222f8f.15.1790608246285; 
 Mon, 28 Sep 2026 08:10:46 -0700 (PDT)
Received: from able.fritz.box ([2a00:e180:152b:4800:8072:ed4c:898d:d82d])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4887a35fb05sm31513965f8f.20.2026.09.28.08.10.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Sep 2026 08:10:45 -0700 (PDT)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: natalie.vock@gmx.de, honghuan@amd.com, Alexander.Deucher@amd.com,
 Felix.Kuehling@amd.com, Philip.Yang@amd.com, timur.kristof@gmail.com,
 cascardo@igalia.com, tvrtko.ursulin@igalia.com
Cc: amd-gfx@lists.freedesktop.org
Subject: [PATCH 4/9] drm/amdgpu: add amdgpu_vm_pt_leaves() v2
Date: Mon, 28 Sep 2026 17:10:36 +0200
Message-ID: <20260928151041.1857-4-christian.koenig@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260928151041.1857-1-christian.koenig@amd.com>
References: <20260928151041.1857-1-christian.koenig@amd.com>
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

Signed-off-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c        | 54 ++++++++++----
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h        |  5 +-
 .../gpu/drm/amd/amdgpu/amdgpu_vm_internal.h   |  3 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c     | 74 +++++++++++++++++++
 4 files changed, 119 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index f02a99b753c22..d6358cbfcc9b1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -3078,10 +3078,12 @@ bool amdgpu_vm_handle_fault(struct amdgpu_device *adev, u32 pasid,
 			    u32 vmid, u32 node_id, uint64_t addr,
 			    uint64_t ts, bool write_fault)
 {
+	struct amdgpu_vm_update_params params;
 	bool is_compute_context = false;
-	struct drm_exec exec;
-	uint64_t value, flags;
+	uint64_t *dst, flags[AMDGPU_VM_MAX_LEVEL];
 	struct amdgpu_vm *vm;
+	struct drm_exec exec;
+	unsigned int idx;
 	int r;
 
 	drm_exec_init(&exec, 0, 1);
@@ -3125,24 +3127,24 @@ bool amdgpu_vm_handle_fault(struct amdgpu_device *adev, u32 pasid,
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
+		for (int i = 0; i < AMDGPU_VM_MAX_LEVEL; ++i)
+			flags[i] = AMDGPU_VM_NORETRY_FLAGS;
+		dst = NULL;
 	} else if (amdgpu_vm_fault_stop == AMDGPU_VM_FAULT_STOP_NEVER) {
 		/* Redirect the access to the dummy page */
-		value = adev->dummy_page_addr;
-		flags |= AMDGPU_PTE_EXECUTABLE | AMDGPU_PTE_READABLE |
-			 AMDGPU_PTE_WRITEABLE;
+		for (int i = 0; i < AMDGPU_VM_MAX_LEVEL; ++i)
+			flags[i] = 0;
+		dst = adev->vm_manager.dummy_dst;
 	} else {
 		/* Let the hw retry silently on the PTE */
-		value = 0;
+		for (int i = 0; i < AMDGPU_VM_MAX_LEVEL; ++i)
+			flags[i] = AMDGPU_PTE_VALID | AMDGPU_PTE_SNOOPED |
+				AMDGPU_PTE_SYSTEM;
+		dst = NULL;
 	}
 
 	r = dma_resv_reserve_fences(vm->root.bo->tbo.base.resv, 1);
@@ -3151,12 +3153,32 @@ bool amdgpu_vm_handle_fault(struct amdgpu_device *adev, u32 pasid,
 		goto error_unlock;
 	}
 
-	r = amdgpu_vm_update_range(adev, vm, true, false, false, false,
-				   NULL, addr, addr, flags, value, 0, NULL, NULL, NULL);
-	if (r)
+	if (!drm_dev_enter(adev_to_drm(adev), &idx)) {
+		r = -ENODEV;
 		goto error_unlock;
+	}
+
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
 
-	r = amdgpu_vm_update_pdes(adev, vm, true);
+	amdgpu_vm_pt_leaves(&params, addr, addr + 1, dst, flags);
+
+	r = vm->update_funcs->commit(&params, &vm->last_update);
+
+error_end_critical:
+	amdgpu_vm_end_critical(&params);
+	drm_dev_exit(idx);
 
 error_unlock:
 	drm_exec_fini(&exec);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
index c59647554b416..ec5cd38fe4e34 100644
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
+	AMDGPU_VM_MAX_LEVEL
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
index 285f17c7705b4..27003b03b5fdb 100644
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

