Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 354FAC77B7C
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Apr 2023 11:58:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AF17210EC1E;
	Thu, 20 Apr 2023 11:58:07 +0000 (UTC)
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com
 [IPv6:2a00:1450:4864:20::635])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3428E10EC15
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Apr 2023 11:58:03 +0000 (UTC)
Received: by mail-ej1-x635.google.com with SMTP id a5so5764731ejb.6
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Apr 2023 04:58:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1681991881; x=1684583881;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OxT3l6qMwzklKkFfJMBLzeFqBLJxVPEhqoI/d08g3Zs=;
 b=jFj6PLL5C2FQIrMm+mvTG8gjTBAn4emOvdzOQOJ0eRmyRJpEnrFJ9Paq1kuud7whks
 TtR/b9eP7Mg4/+QPZ6xzOdwIHyXmOK4j6qm3za+nDGXKNsTTWr3bn6xgp6QuZYRHPCN7
 4whRGV1/6LvO3XijZ3c9qwtekuraT8OyanopyesYEKhU0OOoi2TNwaC/fGUp6mKe/3DU
 KDw9OU1IAWi30XEPBT9eFRn6/xVc4hHSNpaMfO5IorDdRgwnxtZuBg8HKSc7/4qxr5Gr
 RzHH7fL3plsVhS1ttNczBHMO5gitUJN/p2NaAJx1H3dVrI/MFx/fdmXJXmOjUCb3PO15
 VOrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1681991881; x=1684583881;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OxT3l6qMwzklKkFfJMBLzeFqBLJxVPEhqoI/d08g3Zs=;
 b=QoFLivcF5VUvlbe9mwwUFs/B7LaAuMFsD7N2n9w2TBKybeeVCGXNsS+3xnuzBt6DVj
 ZCdTxOm9ONiXTscJfD+gS1VDXFwVoS4ieE3QQZFJhno3loIa4chxHF/r5pUmFCzp1nrq
 tk2ef3YKQztdoAJZCVwmj6eoyY/hDa+4I0NH/2Kmtm6Rm8DT6G9JKTU3p8o9nK2K2QPU
 4tZrMdOV8GeDBv7P9Gm2Rx49TpbcNPtkLKfM0NVB4OSIvh+aCm87/HF4Wss+MZpLPYag
 xDw9q2z2LPaI89Rp9A5vAW5V7d0Do93BIoTYk/FnPitG2XIL4kGyaZVdvZVRv3ZbskqV
 xZlQ==
X-Gm-Message-State: AAQBX9cx7MJrGXlHAqWZrc81pgYKaX9p/cJPID7WVjMIfBqEsjIILele
 Ee9ChUx/HbOTAsCol6QygM28TGptu2tCAA==
X-Google-Smtp-Source: AKy350aL/Ck7VhkjmiXLDObp6GIe6zIs52YIxJAvvTDS96HjzeKUKTNz5xObpDObDzazQnfOabhMvg==
X-Received: by 2002:a17:906:a402:b0:94f:29f0:edc0 with SMTP id
 l2-20020a170906a40200b0094f29f0edc0mr1333830ejz.44.1681991881091; 
 Thu, 20 Apr 2023 04:58:01 -0700 (PDT)
Received: from able.fritz.box (p4fc2092b.dip0.t-ipconnect.de. [79.194.9.43])
 by smtp.gmail.com with ESMTPSA id
 l20-20020a170906645400b0095342bfb701sm689385ejn.16.2023.04.20.04.58.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Apr 2023 04:58:00 -0700 (PDT)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 8/8] drm/amdgpu: add VM generation token
Date: Thu, 20 Apr 2023 13:57:52 +0200
Message-Id: <20230420115752.31470-8-christian.koenig@amd.com>
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

Instead of using the VRAM lost counter add a 64bit token which indicates
if a context or job is still valid to use.

Should the VRAM be lost or the page tables need re-creation the token will
change indicating that userspace needs to act and re-create the contexts
and re-submit the work.

Signed-off-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c  |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c |  5 +++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.c |  4 ++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.h |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c  | 26 +++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h  |  4 ++++
 7 files changed, 38 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
index 49db1d0c923a..4beec4220aed 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
@@ -306,7 +306,7 @@ static int amdgpu_cs_pass1(struct amdgpu_cs_parser *p,
 	}
 	p->gang_leader = p->jobs[p->gang_leader_idx];
 
-	if (p->ctx->vram_lost_counter != p->gang_leader->vram_lost_counter) {
+	if (p->ctx->generation != p->gang_leader->generation) {
 		ret = -ECANCELED;
 		goto free_all_kdata;
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
index d2139ac12159..24994c9e65ad 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
@@ -303,6 +303,7 @@ static int amdgpu_ctx_get_stable_pstate(struct amdgpu_ctx *ctx,
 static int amdgpu_ctx_init(struct amdgpu_ctx_mgr *mgr, int32_t priority,
 			   struct drm_file *filp, struct amdgpu_ctx *ctx)
 {
+	struct amdgpu_fpriv *fpriv = filp->driver_priv;
 	u32 current_stable_pstate;
 	int r;
 
@@ -318,7 +319,7 @@ static int amdgpu_ctx_init(struct amdgpu_ctx_mgr *mgr, int32_t priority,
 
 	ctx->reset_counter = atomic_read(&mgr->adev->gpu_reset_counter);
 	ctx->reset_counter_query = ctx->reset_counter;
-	ctx->vram_lost_counter = atomic_read(&mgr->adev->vram_lost_counter);
+	ctx->generation = amdgpu_vm_generation(mgr->adev, &fpriv->vm);
 	ctx->init_priority = priority;
 	ctx->override_priority = AMDGPU_CTX_PRIORITY_UNSET;
 
@@ -570,7 +571,7 @@ static int amdgpu_ctx_query2(struct amdgpu_device *adev,
 	if (ctx->reset_counter != atomic_read(&adev->gpu_reset_counter))
 		out->state.flags |= AMDGPU_CTX_QUERY2_FLAGS_RESET;
 
-	if (ctx->vram_lost_counter != atomic_read(&adev->vram_lost_counter))
+	if (ctx->generation != amdgpu_vm_generation(adev, &fpriv->vm))
 		out->state.flags |= AMDGPU_CTX_QUERY2_FLAGS_VRAMLOST;
 
 	if (atomic_read(&ctx->guilty))
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h
index 0fa0e56daf67..5fd79f94e2d0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h
@@ -47,7 +47,7 @@ struct amdgpu_ctx {
 	struct amdgpu_ctx_mgr		*mgr;
 	unsigned			reset_counter;
 	unsigned			reset_counter_query;
-	uint32_t			vram_lost_counter;
+	uint64_t			generation;
 	spinlock_t			ring_lock;
 	struct amdgpu_ctx_entity	*entities[AMDGPU_HW_IP_NUM][AMDGPU_MAX_ENTITY_NUM];
 	bool				preamble_presented;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
index 5462f0406b02..57f8f8b3cd8a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
@@ -107,7 +107,7 @@ int amdgpu_job_alloc(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 	(*job)->vm = vm;
 
 	amdgpu_sync_create(&(*job)->explicit_sync);
-	(*job)->vram_lost_counter = atomic_read(&adev->vram_lost_counter);
+	(*job)->generation = amdgpu_vm_generation(adev, vm);
 	(*job)->vm_pd_addr = AMDGPU_BO_INVALID_OFFSET;
 
 	if (!entity)
@@ -293,7 +293,7 @@ static struct dma_fence *amdgpu_job_run(struct drm_sched_job *sched_job)
 	trace_amdgpu_sched_run_job(job);
 
 	/* Skip job if VRAM is lost and never resubmit gangs */
-	if (job->vram_lost_counter != atomic_read(&adev->vram_lost_counter) ||
+	if (job->generation != amdgpu_vm_generation(adev, job->vm) ||
 	    (job->job_run_counter && job->gang_submit))
 		dma_fence_set_error(finished, -ECANCELED);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
index 52f2e313ea17..a2931ff08dad 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
@@ -61,7 +61,7 @@ struct amdgpu_job {
 	uint32_t		gds_base, gds_size;
 	uint32_t		gws_base, gws_size;
 	uint32_t		oa_base, oa_size;
-	uint32_t		vram_lost_counter;
+	uint64_t		generation;
 
 	/* user fence handling */
 	uint64_t		uf_addr;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 8082c9e006b1..158176b2f47e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -404,6 +404,30 @@ static void amdgpu_vm_fini_entities(struct amdgpu_vm *vm)
 	drm_sched_entity_destroy(&vm->delayed);
 }
 
+/**
+ * amdgpu_vm_generation - return the page table re-generation counter
+ * @adev: the amdgpu_device
+ * @vm: optional VM to check, might be NULL
+ *
+ * Returns a page table re-generation token to allow checking if submissions
+ * are still valid to use this VM. The VM parameter might be NULL in which case
+ * just the VRAM lost counter will be used.
+ */
+uint64_t amdgpu_vm_generation(struct amdgpu_device *adev, struct amdgpu_vm *vm)
+{
+	uint64_t result = (u64)atomic_read(&adev->vram_lost_counter) << 32;
+
+	if (!vm)
+		return result;
+
+	result += vm->generation;
+	/* Add one if the page tables will be re-generated on next CS */
+	if (drm_sched_entity_error(&vm->delayed))
+		++result;
+
+	return result;
+}
+
 /**
  * amdgpu_vm_validate_pt_bos - validate the page table BOs
  *
@@ -427,6 +451,7 @@ int amdgpu_vm_validate_pt_bos(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 	int r;
 
 	if (drm_sched_entity_error(&vm->delayed)) {
+		++vm->generation;
 		amdgpu_vm_bo_reset_state_machine(vm);
 		amdgpu_vm_fini_entities(vm);
 		r = amdgpu_vm_init_entities(adev, vm);
@@ -2122,6 +2147,7 @@ int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm)
 	vm->last_update = NULL;
 	vm->last_unlocked = dma_fence_get_stub();
 	vm->last_tlb_flush = dma_fence_get_stub();
+	vm->generation = 0;
 
 	mutex_init(&vm->eviction_lock);
 	vm->evicting = false;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
index 8ae45a0896cd..e8390d439895 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
@@ -292,6 +292,9 @@ struct amdgpu_vm {
 	atomic64_t		tlb_seq;
 	struct dma_fence	*last_tlb_flush;
 
+	/* How many times we had to re-generate the page tables */
+	uint64_t		generation;
+
 	/* Last unlocked submission to the scheduler entities */
 	struct dma_fence	*last_unlocked;
 
@@ -391,6 +394,7 @@ void amdgpu_vm_get_pd_bo(struct amdgpu_vm *vm,
 			 struct list_head *validated,
 			 struct amdgpu_bo_list_entry *entry);
 bool amdgpu_vm_ready(struct amdgpu_vm *vm);
+uint64_t amdgpu_vm_generation(struct amdgpu_device *adev, struct amdgpu_vm *vm);
 int amdgpu_vm_validate_pt_bos(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 			      int (*callback)(void *p, struct amdgpu_bo *bo),
 			      void *param);
-- 
2.34.1

