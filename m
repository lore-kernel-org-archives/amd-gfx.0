Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2588C4321E
	for <amd-gfx@archiver.kernel.org>; Mon,  5 Dec 2022 10:43:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 062D910E0E7;
	Mon,  5 Dec 2022 10:43:45 +0000 (UTC)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com
 [IPv6:2a00:1450:4864:20::632])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0836A10E081
 for <amd-gfx@lists.freedesktop.org>; Mon,  5 Dec 2022 10:43:39 +0000 (UTC)
Received: by mail-ej1-x632.google.com with SMTP id vv4so26665217ejc.2
 for <amd-gfx@lists.freedesktop.org>; Mon, 05 Dec 2022 02:43:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=79DAysQ6XWBZti5hOdKNrvbDakDcDwCDaL3SmcCP7wM=;
 b=dh1TupdK3zfeCSXQ7e/vO5Kh669kHPhX4+mRQ6bQe/l6aJ9FZdjJ3nAetEK7omaEOT
 Ww7DzrL5kPJIFK85YFvMnLumHzoPjxSzKpb2Hn09xw2yv1IywH6tpYp+aClCLT6jy92Z
 bqxpr9nBJnuEkg/Iy10zYncRj70sThV204NT1kqBKT+ahodiu7ofRqmLJqDBVG0mQkd5
 YX9aRlH6t2GUdFRYJ5RyVv3e+ECyb68KkrSgpUOjHzRrKlL/BXxss6RmfZfCk5WVYAX0
 pAMjDbKYSmaGrk0b5siX7bLit8xHHxwIpamuCwxYQR0Nwk9PxcYAM7Kw/Cd32qxeW9RB
 HPJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=79DAysQ6XWBZti5hOdKNrvbDakDcDwCDaL3SmcCP7wM=;
 b=RbUbQBN2Ia+j0+XVspshSdooyYCNLbacVp94uXTql+BS+PR31tGcYZe7VdHSiv35a9
 ONw2spwS5elKuRANvRI5wLnp/BeG2d8VIbGg6yOxmEvG8aibRUPgcWYKZ3BfoKIB+CyY
 pyhW1btuDEVe6bvox+/IFw9cc+FTCfWzGazEyjqXhLRy0ZSZRydVXrrQLY1u/2qSu84q
 8mbGqjD9+ayi9R2ME9EEI7FXTR5TlD7YX9RHYvkKSpsUY9gbMyAn+1iQZoC0ymk5qVhP
 XD9ADQFQnA4uwGfFI6dEgvO4bNaPgxOtCPa/RTTi9K1eHwJDvnlUmfl3v9gn1Gf/NvKD
 vhuQ==
X-Gm-Message-State: ANoB5pnwZVSkceZn8wvjy4Dn+KFrevFhhstXGpBHnqIO5i1NZPrLmmfs
 pupMEo6ula3KtCIYHNGhrrkHjuU5fjQ=
X-Google-Smtp-Source: AA0mqf6TWKRvReBxX2c1NOTum4Mw/9p71fT33f23ywOGgvw2Hq4KC+ntKHRXmNjhyW/KBWskJ3OMqg==
X-Received: by 2002:a17:906:9488:b0:7c0:f908:eafe with SMTP id
 t8-20020a170906948800b007c0f908eafemr2698059ejx.547.1670237018333; 
 Mon, 05 Dec 2022 02:43:38 -0800 (PST)
Received: from able.fritz.box (p5b0ea229.dip0.t-ipconnect.de. [91.14.162.41])
 by smtp.gmail.com with ESMTPSA id
 o7-20020a056402444700b0044dbecdcd29sm4609432edb.12.2022.12.05.02.43.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Dec 2022 02:43:37 -0800 (PST)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 4/4] drm/amdgpu: rework reserved VMID handling
Date: Mon,  5 Dec 2022 11:43:33 +0100
Message-Id: <20221205104333.12536-4-christian.koenig@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221205104333.12536-1-christian.koenig@amd.com>
References: <20221205104333.12536-1-christian.koenig@amd.com>
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
Cc: Alexander.Deucher@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Instead of reserving a VMID for a single process allow that many
processes use the reserved ID. This allows for proper isolation
between the processes.

Signed-off-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c | 45 ++++++++++++-------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_ids.h |  3 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h  |  6 +---
 3 files changed, 24 insertions(+), 30 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
index 7e5aad241295..6481b43ffe25 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
@@ -279,12 +279,13 @@ static int amdgpu_vmid_grab_reserved(struct amdgpu_vm *vm,
 {
 	struct amdgpu_device *adev = ring->adev;
 	unsigned vmhub = ring->funcs->vmhub;
+	struct amdgpu_vmid_mgr *id_mgr = &adev->vm_manager.id_mgr[vmhub];
 	uint64_t fence_context = adev->fence_context + ring->idx;
 	bool needs_flush = vm->use_cpu_for_update;
 	uint64_t updates = amdgpu_vm_tlb_seq(vm);
 	int r;
 
-	*id = vm->reserved_vmid[vmhub];
+	*id = id_mgr->reserved;
 	if ((*id)->owner != vm->immediate.fence_context ||
 	    !amdgpu_vmid_compatible(*id, job) ||
 	    (*id)->flushed_updates < updates ||
@@ -464,31 +465,27 @@ int amdgpu_vmid_alloc_reserved(struct amdgpu_device *adev,
 			       struct amdgpu_vm *vm,
 			       unsigned vmhub)
 {
-	struct amdgpu_vmid_mgr *id_mgr;
-	struct amdgpu_vmid *idle;
-	int r = 0;
+	struct amdgpu_vmid_mgr *id_mgr = &adev->vm_manager.id_mgr[vmhub];
 
-	id_mgr = &adev->vm_manager.id_mgr[vmhub];
 	mutex_lock(&id_mgr->lock);
 	if (vm->reserved_vmid[vmhub])
 		goto unlock;
-	if (atomic_inc_return(&id_mgr->reserved_vmid_num) >
-	    AMDGPU_VM_MAX_RESERVED_VMID) {
-		DRM_ERROR("Over limitation of reserved vmid\n");
-		atomic_dec(&id_mgr->reserved_vmid_num);
-		r = -EINVAL;
-		goto unlock;
+
+	++id_mgr->reserved_use_count;
+	if (!id_mgr->reserved) {
+		struct amdgpu_vmid *id;
+
+		id = list_first_entry(&id_mgr->ids_lru, struct amdgpu_vmid,
+				      list);
+		/* Remove from normal round robin handling */
+		list_del_init(&id->list);
+		id_mgr->reserved = id;
 	}
-	/* Select the first entry VMID */
-	idle = list_first_entry(&id_mgr->ids_lru, struct amdgpu_vmid, list);
-	list_del_init(&idle->list);
-	vm->reserved_vmid[vmhub] = idle;
-	mutex_unlock(&id_mgr->lock);
+	vm->reserved_vmid[vmhub] = true;
 
-	return 0;
 unlock:
 	mutex_unlock(&id_mgr->lock);
-	return r;
+	return 0;
 }
 
 void amdgpu_vmid_free_reserved(struct amdgpu_device *adev,
@@ -498,12 +495,12 @@ void amdgpu_vmid_free_reserved(struct amdgpu_device *adev,
 	struct amdgpu_vmid_mgr *id_mgr = &adev->vm_manager.id_mgr[vmhub];
 
 	mutex_lock(&id_mgr->lock);
-	if (vm->reserved_vmid[vmhub]) {
-		list_add(&vm->reserved_vmid[vmhub]->list,
-			&id_mgr->ids_lru);
-		vm->reserved_vmid[vmhub] = NULL;
-		atomic_dec(&id_mgr->reserved_vmid_num);
+	if (vm->reserved_vmid[vmhub] &&
+	    !--id_mgr->reserved_use_count) {
+		/* give the reserved ID back to normal round robin */
+		list_add(&id_mgr->reserved->list, &id_mgr->ids_lru);
 	}
+	vm->reserved_vmid[vmhub] = false;
 	mutex_unlock(&id_mgr->lock);
 }
 
@@ -570,7 +567,7 @@ void amdgpu_vmid_mgr_init(struct amdgpu_device *adev)
 
 		mutex_init(&id_mgr->lock);
 		INIT_LIST_HEAD(&id_mgr->ids_lru);
-		atomic_set(&id_mgr->reserved_vmid_num, 0);
+		id_mgr->reserved_use_count = 0;
 
 		/* manage only VMIDs not used by KFD */
 		id_mgr->num_ids = adev->vm_manager.first_kfd_vmid;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.h
index 06c8a0034fa5..c573a8ffff47 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.h
@@ -67,7 +67,8 @@ struct amdgpu_vmid_mgr {
 	unsigned		num_ids;
 	struct list_head	ids_lru;
 	struct amdgpu_vmid	ids[AMDGPU_NUM_VMID];
-	atomic_t		reserved_vmid_num;
+	struct amdgpu_vmid	*reserved;
+	unsigned int		reserved_use_count;
 };
 
 int amdgpu_pasid_alloc(unsigned int bits);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
index 6546e786bf00..094bb4807303 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
@@ -119,9 +119,6 @@ struct amdgpu_bo_vm;
 /* Reserve 2MB at top/bottom of address space for kernel use */
 #define AMDGPU_VA_RESERVED_SIZE			(2ULL << 20)
 
-/* max vmids dedicated for process */
-#define AMDGPU_VM_MAX_RESERVED_VMID	1
-
 /* See vm_update_mode */
 #define AMDGPU_VM_USE_CPU_FOR_GFX (1 << 0)
 #define AMDGPU_VM_USE_CPU_FOR_COMPUTE (1 << 1)
@@ -298,8 +295,7 @@ struct amdgpu_vm {
 	struct dma_fence	*last_unlocked;
 
 	unsigned int		pasid;
-	/* dedicated to vm */
-	struct amdgpu_vmid	*reserved_vmid[AMDGPU_MAX_VMHUBS];
+	bool			reserved_vmid[AMDGPU_MAX_VMHUBS];
 
 	/* Flag to indicate if VM tables are updated by CPU or GPU (SDMA) */
 	bool					use_cpu_for_update;
-- 
2.34.1

