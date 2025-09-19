Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B153ECAC592
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Sep 2025 12:21:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 56B3410E236;
	Fri, 19 Sep 2025 12:21:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="DAOXmLtA";
	dkim-atps=neutral
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com
 [209.85.128.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B45FA10E162
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 Sep 2025 12:21:51 +0000 (UTC)
Received: by mail-wm1-f46.google.com with SMTP id
 5b1f17b1804b1-45f2c5ef00fso16364065e9.1
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 Sep 2025 05:21:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1758284510; x=1758889310; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=81DRH9GeoqIWnlxTCf6c66Jehxl8bVnfL0mUyzBusCI=;
 b=DAOXmLtAGBRc5LUlTWF+VkqgE5fwEOFZZ2aOT3vpn8XxM7MSDVftoA4iRCstAjqc6D
 iDDO2JfwpHlXOLWAK77GwJ5JFHzN4SG5BmOwri7CEwkuxBObQRQMYGPRNvf/mSHQrgIh
 B/ZuCSWm8cxS6s3Xiog37DaZUcF/jS64L5WNlzBSex3CAH95syBVL242d5rJ9tFALLiy
 uCKqv2fGAH1KSveYRTD/9U+GftRMwlzB06pqPX89oHsMA2mTVUjrCII1H1JGxwJtYlqR
 5RiJ2bykjSEfkHLLxc2DEa7sWr8v5vqkd0hCwVocRrmOSAyl8vlw0VTdUusV2SGoqIMv
 YibA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758284510; x=1758889310;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=81DRH9GeoqIWnlxTCf6c66Jehxl8bVnfL0mUyzBusCI=;
 b=rIlhEYA0wcgWljhIi8sVAUUazVI5obMh1GLxXRktLThzFT8p5iZ4YT/hiCjmTqA1fV
 ChSBVXBPOEEGl1oNy8VCg1LNKv9LuVKrIGKEhOPfodrYOulIdA0JaevcaDjAwFlFFBn4
 8nTAkd6eRX7GfOA9ysvUJWaJpOm3a8sr6EPvWH7jXFzfVJ0JGNZOVgimrEX9FKa/vsaj
 Ioa2YJf94sj4DPV+sl6loh4kPJWvmK/GYMn2sRQkmB3P1ddiWGOgk6h3KTQ1vh8mqCjC
 CBFVVOPcDtm3MVRk4gA5thn+X6kzHc4+y/AoCMF3AdOi0iao0AY46r28js01T9MKKK1I
 /Gcw==
X-Gm-Message-State: AOJu0YxeOkXNPuGFw73IsSNak6qRZPIqOfHTQc1lu57PzpQD1f1EWvpX
 NZUVLVPTY8pMAiJHnH99SpI/jsYbHE7TvFLwyBVn0jNkTgdz0kiXKfrN
X-Gm-Gg: ASbGncs9xagzEZMczD5xswRQ0jScceAoljcEr4CBOtZ5bEENBUqZr5EzCpD0mqDUFue
 GDdz50A7aeUU2oPHfdg4qkUbICi+PhYqkqJWNLMmoI6f+xJmZkO9Y8sQjbHcaTr5VvNZ+vpyIcb
 xbeyt+gPyL5bRXJ3rrjm41NZmRiQLWTzl06ep0VpvhnpUfeikoPrRLroj8mToIsM9y2lj0Tkgtd
 tewcVbpRd9kE8/gEh+cRLq8AXH/w7nZdv8Dhzxo+zkXzCH5AISKdbBF+l1lP+g9gqOKb83QuUdt
 H53i5Vfs9lLjc4RCQ7JFSqd/q1pRgJ5hGNIch7pfzNIQ45q6cyBGxNl4vpLIBMqwVQBNvwhMGey
 B9S9/HcZciNpoSo9hqTDBDVyhkgSXlk+leA==
X-Google-Smtp-Source: AGHT+IFXUgj5edjsiuYkcY4AX9P2RywtzG+GXiTWPyrEuQZkTWsCOe76FD7r7t4b5dcNPUcMivFxgQ==
X-Received: by 2002:a05:600c:3509:b0:45c:b5e0:2cf5 with SMTP id
 5b1f17b1804b1-467eeba4867mr27728605e9.24.1758284509737; 
 Fri, 19 Sep 2025 05:21:49 -0700 (PDT)
Received: from able.fritz.box ([2a00:e180:15f6:c100:27:890e:2d7e:79e2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45f3211e8c7sm78241075e9.3.2025.09.19.05.21.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 Sep 2025 05:21:49 -0700 (PDT)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: Alexander.Deucher@amd.com, James.Zhu@amd.com, srinivasan.shanmugam@amd.com
Cc: amd-gfx@lists.freedesktop.org
Subject: [PATCH 2/2] drm/amdgpu: revert "rework reserved VMID handling"
Date: Fri, 19 Sep 2025 14:21:47 +0200
Message-ID: <20250919122147.2538-2-christian.koenig@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250919122147.2538-1-christian.koenig@amd.com>
References: <20250919122147.2538-1-christian.koenig@amd.com>
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

This reverts commit e44a0fe630c58b0a87d8281f5c1077a3479e5fce.

Initially we used VMID reservation to enforce isolation between
processes. That has now been replaced by proper fence handling.

Both OpenGL, RADV and ROCm developers requested a way to reserve a VMID
for SPM, so restore that approach by reverting back to only allowing a
single process to use the reserved VMID.

Only compile tested for now.

Signed-off-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c | 61 ++++++++++++++++---------
 drivers/gpu/drm/amd/amdgpu/amdgpu_ids.h | 11 ++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c  | 17 ++-----
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h  |  2 +-
 4 files changed, 50 insertions(+), 41 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
index cbdf108612d2..e35f7525fbff 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
@@ -275,13 +275,12 @@ static int amdgpu_vmid_grab_reserved(struct amdgpu_vm *vm,
 {
 	struct amdgpu_device *adev = ring->adev;
 	unsigned vmhub = ring->vm_hub;
-	struct amdgpu_vmid_mgr *id_mgr = &adev->vm_manager.id_mgr[vmhub];
 	uint64_t fence_context = adev->fence_context + ring->idx;
 	bool needs_flush = vm->use_cpu_for_update;
 	uint64_t updates = amdgpu_vm_tlb_seq(vm);
 	int r;
 
-	*id = id_mgr->reserved;
+	*id = vm->reserved_vmid[vmhub];
 	if ((*id)->owner != vm->immediate.fence_context ||
 	    !amdgpu_vmid_compatible(*id, job) ||
 	    (*id)->flushed_updates < updates ||
@@ -474,40 +473,61 @@ bool amdgpu_vmid_uses_reserved(struct amdgpu_vm *vm, unsigned int vmhub)
 	return vm->reserved_vmid[vmhub];
 }
 
-int amdgpu_vmid_alloc_reserved(struct amdgpu_device *adev,
+/*
+ * amdgpu_vmid_alloc_reserved - reserve a specific VMID for this vm
+ * @adev: amdgpu device structure
+ * @vm: the VM to reserve an ID for
+ * @vmhub: the VMHUB which should be used
+ *
+ * Mostly used to have a reserved VMID for debugging and SPM.
+ *
+ * Returns: 0 for success, -EINVAL if an ID is already reserved.
+ */
+int amdgpu_vmid_alloc_reserved(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 			       unsigned vmhub)
 {
 	struct amdgpu_vmid_mgr *id_mgr = &adev->vm_manager.id_mgr[vmhub];
+	struct amdgpu_vmid *id;
+	int r = 0;
 
 	mutex_lock(&id_mgr->lock);
-
-	++id_mgr->reserved_use_count;
-	if (!id_mgr->reserved) {
-		struct amdgpu_vmid *id;
-
-		id = list_first_entry(&id_mgr->ids_lru, struct amdgpu_vmid,
-				      list);
-		/* Remove from normal round robin handling */
-		list_del_init(&id->list);
-		id_mgr->reserved = id;
+	if (vm->reserved_vmid[vmhub])
+		goto unlock;
+	if (id_mgr->reserved_vmid) {
+		r = -EINVAL;
+		goto unlock;
 	}
-
+	/* Remove from normal round robin handling */
+	id = list_first_entry(&id_mgr->ids_lru, struct amdgpu_vmid, list);
+	list_del_init(&id->list);
+	vm->reserved_vmid[vmhub] = id;
+	id_mgr->reserved_vmid = true;
 	mutex_unlock(&id_mgr->lock);
+
 	return 0;
+unlock:
+	mutex_unlock(&id_mgr->lock);
+	return r;
 }
 
-void amdgpu_vmid_free_reserved(struct amdgpu_device *adev,
+/*
+ * amdgpu_vmid_free_reserved - free up a reserved VMID again
+ * @adev: amdgpu device structure
+ * @vm: the VM with the reserved ID
+ * @vmhub: the VMHUB which should be used
+ */
+void amdgpu_vmid_free_reserved(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 			       unsigned vmhub)
 {
 	struct amdgpu_vmid_mgr *id_mgr = &adev->vm_manager.id_mgr[vmhub];
 
 	mutex_lock(&id_mgr->lock);
-	if (!--id_mgr->reserved_use_count) {
-		/* give the reserved ID back to normal round robin */
-		list_add(&id_mgr->reserved->list, &id_mgr->ids_lru);
-		id_mgr->reserved = NULL;
+	if (vm->reserved_vmid[vmhub]) {
+		list_add(&vm->reserved_vmid[vmhub]->list,
+			&id_mgr->ids_lru);
+		vm->reserved_vmid[vmhub] = NULL;
+		id_mgr->reserved_vmid = false;
 	}
-
 	mutex_unlock(&id_mgr->lock);
 }
 
@@ -574,7 +594,6 @@ void amdgpu_vmid_mgr_init(struct amdgpu_device *adev)
 
 		mutex_init(&id_mgr->lock);
 		INIT_LIST_HEAD(&id_mgr->ids_lru);
-		id_mgr->reserved_use_count = 0;
 
 		/* for GC <10, SDMA uses MMHUB so use first_kfd_vmid for both GC and MM */
 		if (amdgpu_ip_version(adev, GC_HWIP, 0) < IP_VERSION(10, 0, 0))
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.h
index 240fa6751260..b3649cd3af56 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.h
@@ -67,8 +67,7 @@ struct amdgpu_vmid_mgr {
 	unsigned		num_ids;
 	struct list_head	ids_lru;
 	struct amdgpu_vmid	ids[AMDGPU_NUM_VMID];
-	struct amdgpu_vmid	*reserved;
-	unsigned int		reserved_use_count;
+	bool			reserved_vmid;
 };
 
 int amdgpu_pasid_alloc(unsigned int bits);
@@ -79,10 +78,10 @@ void amdgpu_pasid_free_delayed(struct dma_resv *resv,
 bool amdgpu_vmid_had_gpu_reset(struct amdgpu_device *adev,
 			       struct amdgpu_vmid *id);
 bool amdgpu_vmid_uses_reserved(struct amdgpu_vm *vm, unsigned int vmhub);
-int amdgpu_vmid_alloc_reserved(struct amdgpu_device *adev,
-				unsigned vmhub);
-void amdgpu_vmid_free_reserved(struct amdgpu_device *adev,
-				unsigned vmhub);
+int amdgpu_vmid_alloc_reserved(struct amdgpu_device *adev, struct amdgpu_vm *vm,
+			       unsigned vmhub);
+void amdgpu_vmid_free_reserved(struct amdgpu_device *adev, struct amdgpu_vm *vm,
+			       unsigned vmhub);
 int amdgpu_vmid_grab(struct amdgpu_vm *vm, struct amdgpu_ring *ring,
 		     struct amdgpu_job *job, struct dma_fence **fence);
 void amdgpu_vmid_reset(struct amdgpu_device *adev, unsigned vmhub,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 1f8b43253eea..108d2a838ef0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -2788,10 +2788,7 @@ void amdgpu_vm_fini(struct amdgpu_device *adev, struct amdgpu_vm *vm)
 	dma_fence_put(vm->last_update);
 
 	for (i = 0; i < AMDGPU_MAX_VMHUBS; i++) {
-		if (vm->reserved_vmid[i]) {
-			amdgpu_vmid_free_reserved(adev, i);
-			vm->reserved_vmid[i] = false;
-		}
+		amdgpu_vmid_free_reserved(adev, vm, i);
 	}
 
 	ttm_lru_bulk_move_fini(&adev->mman.bdev, &vm->lru_bulk_move);
@@ -2887,6 +2884,7 @@ int amdgpu_vm_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
 	union drm_amdgpu_vm *args = data;
 	struct amdgpu_device *adev = drm_to_adev(dev);
 	struct amdgpu_fpriv *fpriv = filp->driver_priv;
+	struct amdgpu_vm *vm = &fpriv->vm;
 
 	/* No valid flags defined yet */
 	if (args->in.flags)
@@ -2895,17 +2893,10 @@ int amdgpu_vm_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
 	switch (args->in.op) {
 	case AMDGPU_VM_OP_RESERVE_VMID:
 		/* We only have requirement to reserve vmid from gfxhub */
-		if (!fpriv->vm.reserved_vmid[AMDGPU_GFXHUB(0)]) {
-			amdgpu_vmid_alloc_reserved(adev, AMDGPU_GFXHUB(0));
-			fpriv->vm.reserved_vmid[AMDGPU_GFXHUB(0)] = true;
-		}
-
+		amdgpu_vmid_alloc_reserved(adev, vm, AMDGPU_GFXHUB(0));
 		break;
 	case AMDGPU_VM_OP_UNRESERVE_VMID:
-		if (fpriv->vm.reserved_vmid[AMDGPU_GFXHUB(0)]) {
-			amdgpu_vmid_free_reserved(adev, AMDGPU_GFXHUB(0));
-			fpriv->vm.reserved_vmid[AMDGPU_GFXHUB(0)] = false;
-		}
+		amdgpu_vmid_free_reserved(adev, vm, AMDGPU_GFXHUB(0));
 		break;
 	default:
 		return -EINVAL;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
index 829b400cb8c0..3b9d583358b0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
@@ -415,7 +415,7 @@ struct amdgpu_vm {
 	struct dma_fence	*last_unlocked;
 
 	unsigned int		pasid;
-	bool			reserved_vmid[AMDGPU_MAX_VMHUBS];
+	struct amdgpu_vmid	*reserved_vmid[AMDGPU_MAX_VMHUBS];
 
 	/* Flag to indicate if VM tables are updated by CPU or GPU (SDMA) */
 	bool					use_cpu_for_update;
-- 
2.43.0

