Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65AE5C77B72
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Apr 2023 11:58:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 764E810E28A;
	Thu, 20 Apr 2023 11:58:06 +0000 (UTC)
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com
 [IPv6:2a00:1450:4864:20::62f])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E9DE010E28A
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Apr 2023 11:58:01 +0000 (UTC)
Received: by mail-ej1-x62f.google.com with SMTP id z6so5788807ejc.5
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Apr 2023 04:58:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1681991880; x=1684583880;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PqunmpeFUFiL5sqDH1LYXN6ERqCLPXdAnXaKcp1j8Js=;
 b=BHR5jxCt1z5247KJ6wTaXGDAF9/9QmdnMg+gAsFaiPs/pBxn2XvDikQPrXfgs4dCh4
 sildHhwQtz6+fAuyNYBIW4IQG0CE19abUSZQi9TZIxsMl3O+zu7anhgyxy02qOeRL9qh
 5M/COxwVRD+KM35TWiyuQIG33eZbkqXHMFfg9SZ1QWitJu9dwLVOfeo2NFLm6rvvLI9g
 gLCyW0bOT1KOkNTk8SxtOs1DyqLCj6T+StFYztMllKyt3IVYRZA/i/4gKc2+sgw7p/dE
 RBgIoHnfb/kXeLDTKCap3YEgR4/D4F8jJTHUGz3GMaSOawM8jz7XXyArnbffuZyKo1ze
 JJOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1681991880; x=1684583880;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PqunmpeFUFiL5sqDH1LYXN6ERqCLPXdAnXaKcp1j8Js=;
 b=M1z1rdiFaxyO2weM66Fcab4U8BvTtWi3K9kQ9QBv161UazOMGpg2sjKP7yc6pOoSu4
 bxKTGKgBQQQGX3sMdawIkaCKkUjmz6HG7jBV/yl6FswMD6O4QEIJ/JWo367UDAdzi4Dr
 C2qVXbr+NGZiHTsyRJoHb4UYAMWGTtVPmO8SxS8cF2a6CpmdBLkKFvz6ExvVrrvBRkBY
 StkNztrSkgvKgGRoD0CHEKc338mKqJtdxnRx4aGwOKf5K9kQKegRwH9GEs+SFeoG3glN
 wU37hZEs5qTfVjms4ki7/tmKHGeXeYbuJ67EAWEHu7P6hDazS/zQE85v6E98NNXPhLEK
 ZFYQ==
X-Gm-Message-State: AAQBX9cgHxR8xhGR/XVMsHoevgf7pw1Zisr41hGRIxyx+m6DYj6e/cNm
 utDwMSgydPAGfPqvUTmiqrF78AXEfmnOdg==
X-Google-Smtp-Source: AKy350av9DrDB0uDuTfjdCFTZlDrSymHQdUIqEpBf5HHL12MsdhAcQ6Ax3vk/mHQptxLPmlIDuUDhw==
X-Received: by 2002:a17:906:3a95:b0:94a:698a:c263 with SMTP id
 y21-20020a1709063a9500b0094a698ac263mr1033331ejd.71.1681991880179; 
 Thu, 20 Apr 2023 04:58:00 -0700 (PDT)
Received: from able.fritz.box (p4fc2092b.dip0.t-ipconnect.de. [79.194.9.43])
 by smtp.gmail.com with ESMTPSA id
 l20-20020a170906645400b0095342bfb701sm689385ejn.16.2023.04.20.04.57.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Apr 2023 04:57:59 -0700 (PDT)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 7/8] drm/amdgpu: reset VM when an error is detected
Date: Thu, 20 Apr 2023 13:57:51 +0200
Message-Id: <20230420115752.31470-7-christian.koenig@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230420115752.31470-1-christian.koenig@amd.com>
References: <20230420115752.31470-1-christian.koenig@amd.com>
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
Cc: luben.tuikov@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

When some problem with the updates of page tables is detected reset the
state machine of the VM and re-create all page tables from scratch.

Signed-off-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 81 +++++++++++++++++++++-----
 1 file changed, 65 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index fa8f48a0fa84..8082c9e006b1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -265,6 +265,32 @@ static void amdgpu_vm_bo_done(struct amdgpu_vm_bo_base *vm_bo)
 	spin_unlock(&vm_bo->vm->status_lock);
 }
 
+/**
+ * amdgpu_vm_bo_reset_state_machine - reset the vm_bo state machine
+ * @vm: the VM which state machine to reset
+ *
+ * Move all vm_bo object in the VM into a state where they will be updated
+ * again during validation.
+ */
+static void amdgpu_vm_bo_reset_state_machine(struct amdgpu_vm *vm)
+{
+	struct amdgpu_vm_bo_base *vm_bo, *tmp;
+
+	spin_lock(&vm->status_lock);
+	list_splice_init(&vm->done, &vm->invalidated);
+	list_for_each_entry(vm_bo, &vm->invalidated, vm_status)
+		vm_bo->moved = true;
+	list_for_each_entry_safe(vm_bo, tmp, &vm->idle, vm_status) {
+		struct amdgpu_bo *bo = vm_bo->bo;
+
+		if (!bo || bo->tbo.type != ttm_bo_type_kernel)
+			list_move(&vm_bo->vm_status, &vm_bo->vm->moved);
+		else if (bo->parent)
+			list_move(&vm_bo->vm_status, &vm_bo->vm->relocated);
+	}
+	spin_unlock(&vm->status_lock);
+}
+
 /**
  * amdgpu_vm_bo_base_init - Adds bo to the list of bos associated with the vm
  *
@@ -350,6 +376,34 @@ void amdgpu_vm_move_to_lru_tail(struct amdgpu_device *adev,
 	spin_unlock(&adev->mman.bdev.lru_lock);
 }
 
+/* Create scheduler entities for page table updates */
+static int amdgpu_vm_init_entities(struct amdgpu_device *adev,
+				   struct amdgpu_vm *vm)
+{
+	int r;
+
+	r = drm_sched_entity_init(&vm->immediate, DRM_SCHED_PRIORITY_NORMAL,
+				  adev->vm_manager.vm_pte_scheds,
+				  adev->vm_manager.vm_pte_num_scheds, NULL);
+	if (r)
+		goto error;
+
+	return drm_sched_entity_init(&vm->delayed, DRM_SCHED_PRIORITY_NORMAL,
+				     adev->vm_manager.vm_pte_scheds,
+				     adev->vm_manager.vm_pte_num_scheds, NULL);
+
+error:
+	drm_sched_entity_destroy(&vm->immediate);
+	return r;
+}
+
+/* Destroy the entities for page table updates again */
+static void amdgpu_vm_fini_entities(struct amdgpu_vm *vm)
+{
+	drm_sched_entity_destroy(&vm->immediate);
+	drm_sched_entity_destroy(&vm->delayed);
+}
+
 /**
  * amdgpu_vm_validate_pt_bos - validate the page table BOs
  *
@@ -372,6 +426,14 @@ int amdgpu_vm_validate_pt_bos(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 	struct amdgpu_bo *bo;
 	int r;
 
+	if (drm_sched_entity_error(&vm->delayed)) {
+		amdgpu_vm_bo_reset_state_machine(vm);
+		amdgpu_vm_fini_entities(vm);
+		r = amdgpu_vm_init_entities(adev, vm);
+		if (r)
+			return r;
+	}
+
 	spin_lock(&vm->status_lock);
 	while (!list_empty(&vm->evicted)) {
 		bo_base = list_first_entry(&vm->evicted,
@@ -2037,19 +2099,10 @@ int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm)
 	INIT_LIST_HEAD(&vm->pt_freed);
 	INIT_WORK(&vm->pt_free_work, amdgpu_vm_pt_free_work);
 
-	/* create scheduler entities for page table updates */
-	r = drm_sched_entity_init(&vm->immediate, DRM_SCHED_PRIORITY_NORMAL,
-				  adev->vm_manager.vm_pte_scheds,
-				  adev->vm_manager.vm_pte_num_scheds, NULL);
+	r = amdgpu_vm_init_entities(adev, vm);
 	if (r)
 		return r;
 
-	r = drm_sched_entity_init(&vm->delayed, DRM_SCHED_PRIORITY_NORMAL,
-				  adev->vm_manager.vm_pte_scheds,
-				  adev->vm_manager.vm_pte_num_scheds, NULL);
-	if (r)
-		goto error_free_immediate;
-
 	vm->pte_support_ats = false;
 	vm->is_compute_context = false;
 
@@ -2109,10 +2162,7 @@ int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm)
 error_free_delayed:
 	dma_fence_put(vm->last_tlb_flush);
 	dma_fence_put(vm->last_unlocked);
-	drm_sched_entity_destroy(&vm->delayed);
-
-error_free_immediate:
-	drm_sched_entity_destroy(&vm->immediate);
+	amdgpu_vm_fini_entities(vm);
 
 	return r;
 }
@@ -2265,8 +2315,7 @@ void amdgpu_vm_fini(struct amdgpu_device *adev, struct amdgpu_vm *vm)
 	amdgpu_bo_unref(&root);
 	WARN_ON(vm->root.bo);
 
-	drm_sched_entity_destroy(&vm->immediate);
-	drm_sched_entity_destroy(&vm->delayed);
+	amdgpu_vm_fini_entities(vm);
 
 	if (!RB_EMPTY_ROOT(&vm->va.rb_root)) {
 		dev_err(adev->dev, "still active bo inside vm\n");
-- 
2.34.1

