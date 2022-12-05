Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0ADDDC4321E
	for <amd-gfx@archiver.kernel.org>; Mon,  5 Dec 2022 10:43:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 095E210E099;
	Mon,  5 Dec 2022 10:43:40 +0000 (UTC)
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com
 [IPv6:2a00:1450:4864:20::534])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3F18710E081
 for <amd-gfx@lists.freedesktop.org>; Mon,  5 Dec 2022 10:43:37 +0000 (UTC)
Received: by mail-ed1-x534.google.com with SMTP id v8so15178320edi.3
 for <amd-gfx@lists.freedesktop.org>; Mon, 05 Dec 2022 02:43:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Jh4bPke6xHQXDpYtYR1IxFDfT81j1qptxacVkkmuTrY=;
 b=MHoBb5lz0PNe/IJGJA1LtN3WiY5TUnGNNy0RUFcj5x4fTQwSnT+l8eHrn9uJCO91Kt
 4fs5+brUNoh5sgvkZwMXTyEOg9jbn9YLeTkvVofFsrxqZX97PanuGY1O3MRMk/OyJuSj
 jQp+fxwGsWh2M7yzDKii0yN1D2t0W8W/huLLUBcAm7T6AADJAI7/7VcGC1mwia2EYQ63
 HqGNZI9E+f6eGuE6iF7Wya9t0P8iIGxUzT4faEArDsafG1Cu22CDDlk8wn9IqTJxquQS
 sSyD2Bl8g4AA9ua8HA8mvh9bKUIoWpRx6RSwk4wGBBeBx2cgTYFdT0jmJZAEx199b5SA
 k/ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Jh4bPke6xHQXDpYtYR1IxFDfT81j1qptxacVkkmuTrY=;
 b=duqB7OWzpZGZFz/Vrjcsrv4kMsDFwdSgyurIwB3pwD3I0Heg4U7+P8vVS6BYhfrrQw
 N2lQZwgTPfJ2Qn4GNBjqv0R12T5A+go1g8zHn+agrPf4FHLWzwKpyURjKClwJ3f5vo2p
 /wBdSJX9EShpHtQoHfrhQonY0707r8CiJ8ZMEU8pNyfd8kiPdsgc24nnqi1n+q5iRihN
 ykAEOFBO1gpRb4p5BHCpJf7ExwugIvXTVwcEdm5uApkQlP8msWdZwvFpYD3HIj6jEY+6
 Bfn2CTQUAyeIGO25ey7QTTrnz7gUogiqiKOJ5e+OdVT+4maA6djgMhkXxb4QkfKyfSz9
 amUg==
X-Gm-Message-State: ANoB5pn9Umu3WkxNuTgne+vFaFsvHuTdNU22D3uTiTHQUaIHH/CdMTvQ
 svt/UN/VhSg6kX5YFuEfneST2fid57Q=
X-Google-Smtp-Source: AA0mqf7gtRlIl+gl3ST6D0rSfvdturanTOMw1ALItnYHNaQR2WT7F8WC4FFqi4AmUSBV8OqSHwZC7g==
X-Received: by 2002:a05:6402:149:b0:458:cc1b:a273 with SMTP id
 s9-20020a056402014900b00458cc1ba273mr61199949edu.92.1670237015614; 
 Mon, 05 Dec 2022 02:43:35 -0800 (PST)
Received: from able.fritz.box (p5b0ea229.dip0.t-ipconnect.de. [91.14.162.41])
 by smtp.gmail.com with ESMTPSA id
 o7-20020a056402444700b0044dbecdcd29sm4609432edb.12.2022.12.05.02.43.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Dec 2022 02:43:35 -0800 (PST)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/4] drm/amdgpu: fix GDS/GWS/OA switch handling
Date: Mon,  5 Dec 2022 11:43:30 +0100
Message-Id: <20221205104333.12536-1-christian.koenig@amd.com>
X-Mailer: git-send-email 2.34.1
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

Bas pointed out that this isn't working as expected and could cause
crashes. Fix the handling by storing the marker that a switch is needed
inside the job instead.

Reported-by: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
Signed-off-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c | 42 +++++++++++++++----
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.h |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c  | 54 +++++++++----------------
 3 files changed, 54 insertions(+), 43 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
index 03d115d2b5ed..16bd12ddba85 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
@@ -165,6 +165,26 @@ bool amdgpu_vmid_had_gpu_reset(struct amdgpu_device *adev,
 		atomic_read(&adev->gpu_reset_counter);
 }
 
+/* Check if we need to switch to another set of resources */
+static bool amdgpu_vmid_gds_switch_needed(struct amdgpu_vmid *id,
+					  struct amdgpu_job *job)
+{
+	return id->gds_base != job->gds_base ||
+		id->gds_size != job->gds_size ||
+		id->gws_base != job->gws_base ||
+		id->gws_size != job->gws_size ||
+		id->oa_base != job->oa_base ||
+		id->oa_size != job->oa_size;
+}
+
+/* Check if the id is compatible with the job */
+static bool amdgpu_vmid_compatible(struct amdgpu_vmid *id,
+				   struct amdgpu_job *job)
+{
+	return  id->pd_gpu_addr == job->vm_pd_addr &&
+		!amdgpu_vmid_gds_switch_needed(id, job);
+}
+
 /**
  * amdgpu_vmid_grab_idle - grab idle VMID
  *
@@ -266,7 +286,7 @@ static int amdgpu_vmid_grab_reserved(struct amdgpu_vm *vm,
 
 	*id = vm->reserved_vmid[vmhub];
 	if ((*id)->owner != vm->immediate.fence_context ||
-	    (*id)->pd_gpu_addr != job->vm_pd_addr ||
+	    !amdgpu_vmid_compatible(*id, job) ||
 	    (*id)->flushed_updates < updates ||
 	    !(*id)->last_flush ||
 	    ((*id)->last_flush->context != fence_context &&
@@ -294,7 +314,6 @@ static int amdgpu_vmid_grab_reserved(struct amdgpu_vm *vm,
 	if (r)
 		return r;
 
-	(*id)->flushed_updates = updates;
 	job->vm_needs_flush = needs_flush;
 	return 0;
 }
@@ -335,7 +354,7 @@ static int amdgpu_vmid_grab_used(struct amdgpu_vm *vm,
 		if ((*id)->owner != vm->immediate.fence_context)
 			continue;
 
-		if ((*id)->pd_gpu_addr != job->vm_pd_addr)
+		if (!amdgpu_vmid_compatible(*id, job))
 			continue;
 
 		if (!(*id)->last_flush ||
@@ -356,7 +375,6 @@ static int amdgpu_vmid_grab_used(struct amdgpu_vm *vm,
 		if (r)
 			return r;
 
-		(*id)->flushed_updates = updates;
 		job->vm_needs_flush |= needs_flush;
 		return 0;
 	}
@@ -410,22 +428,30 @@ int amdgpu_vmid_grab(struct amdgpu_vm *vm, struct amdgpu_ring *ring,
 			if (r)
 				goto error;
 
-			id->flushed_updates = amdgpu_vm_tlb_seq(vm);
 			job->vm_needs_flush = true;
 		}
 
 		list_move_tail(&id->list, &id_mgr->ids_lru);
 	}
 
-	id->pd_gpu_addr = job->vm_pd_addr;
-	id->owner = vm->immediate.fence_context;
-
+	job->gds_switch_needed = amdgpu_vmid_gds_switch_needed(id, job);
 	if (job->vm_needs_flush) {
+		id->flushed_updates = amdgpu_vm_tlb_seq(vm);
 		dma_fence_put(id->last_flush);
 		id->last_flush = NULL;
 	}
 	job->vmid = id - id_mgr->ids;
 	job->pasid = vm->pasid;
+
+	id->gds_base = job->gds_base;
+	id->gds_size = job->gds_size;
+	id->gws_base = job->gws_base;
+	id->gws_size = job->gws_size;
+	id->oa_base = job->oa_base;
+	id->oa_size = job->oa_size;
+	id->pd_gpu_addr = job->vm_pd_addr;
+	id->owner = vm->immediate.fence_context;
+
 	trace_amdgpu_vm_grab_id(vm, ring, job);
 
 error:
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
index ab7b150e5d50..64ff833cc95e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
@@ -54,6 +54,7 @@ struct amdgpu_job {
 	uint32_t		preamble_status;
 	uint32_t                preemption_status;
 	bool                    vm_needs_flush;
+	bool			gds_switch_needed;
 	uint64_t		vm_pd_addr;
 	unsigned		vmid;
 	unsigned		pasid;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 003aa9e47085..c2ee2e86286d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -463,25 +463,20 @@ bool amdgpu_vm_need_pipeline_sync(struct amdgpu_ring *ring,
 	struct amdgpu_device *adev = ring->adev;
 	unsigned vmhub = ring->funcs->vmhub;
 	struct amdgpu_vmid_mgr *id_mgr = &adev->vm_manager.id_mgr[vmhub];
-	struct amdgpu_vmid *id;
-	bool gds_switch_needed;
-	bool vm_flush_needed = job->vm_needs_flush || ring->has_compute_vm_bug;
 
 	if (job->vmid == 0)
 		return false;
-	id = &id_mgr->ids[job->vmid];
-	gds_switch_needed = ring->funcs->emit_gds_switch && (
-		id->gds_base != job->gds_base ||
-		id->gds_size != job->gds_size ||
-		id->gws_base != job->gws_base ||
-		id->gws_size != job->gws_size ||
-		id->oa_base != job->oa_base ||
-		id->oa_size != job->oa_size);
-
-	if (amdgpu_vmid_had_gpu_reset(adev, id))
+
+	if (job->vm_needs_flush || ring->has_compute_vm_bug)
+		return true;
+
+	if (ring->funcs->emit_gds_switch && job->gds_switch_needed)
 		return true;
 
-	return vm_flush_needed || gds_switch_needed;
+	if (amdgpu_vmid_had_gpu_reset(adev, &id_mgr->ids[job->vmid]))
+		return true;
+
+	return false;
 }
 
 /**
@@ -503,13 +498,8 @@ int amdgpu_vm_flush(struct amdgpu_ring *ring, struct amdgpu_job *job,
 	unsigned vmhub = ring->funcs->vmhub;
 	struct amdgpu_vmid_mgr *id_mgr = &adev->vm_manager.id_mgr[vmhub];
 	struct amdgpu_vmid *id = &id_mgr->ids[job->vmid];
-	bool gds_switch_needed = ring->funcs->emit_gds_switch && (
-		id->gds_base != job->gds_base ||
-		id->gds_size != job->gds_size ||
-		id->gws_base != job->gws_base ||
-		id->gws_size != job->gws_size ||
-		id->oa_base != job->oa_base ||
-		id->oa_size != job->oa_size);
+	bool gds_switch_needed = ring->funcs->emit_gds_switch &&
+		job->gds_switch_needed;
 	bool vm_flush_needed = job->vm_needs_flush;
 	struct dma_fence *fence = NULL;
 	bool pasid_mapping_needed = false;
@@ -555,6 +545,14 @@ int amdgpu_vm_flush(struct amdgpu_ring *ring, struct amdgpu_job *job,
 	if (pasid_mapping_needed)
 		amdgpu_gmc_emit_pasid_mapping(ring, job->vmid, job->pasid);
 
+	if (!ring->is_mes_queue && ring->funcs->emit_gds_switch &&
+	    gds_switch_needed) {
+		amdgpu_ring_emit_gds_switch(ring, job->vmid, job->gds_base,
+					    job->gds_size, job->gws_base,
+					    job->gws_size, job->oa_base,
+					    job->oa_size);
+	}
+
 	if (vm_flush_needed || pasid_mapping_needed) {
 		r = amdgpu_fence_emit(ring, &fence, NULL, 0);
 		if (r)
@@ -579,20 +577,6 @@ int amdgpu_vm_flush(struct amdgpu_ring *ring, struct amdgpu_job *job,
 	}
 	dma_fence_put(fence);
 
-	if (!ring->is_mes_queue && ring->funcs->emit_gds_switch &&
-	    gds_switch_needed) {
-		id->gds_base = job->gds_base;
-		id->gds_size = job->gds_size;
-		id->gws_base = job->gws_base;
-		id->gws_size = job->gws_size;
-		id->oa_base = job->oa_base;
-		id->oa_size = job->oa_size;
-		amdgpu_ring_emit_gds_switch(ring, job->vmid, job->gds_base,
-					    job->gds_size, job->gws_base,
-					    job->gws_size, job->oa_base,
-					    job->oa_size);
-	}
-
 	if (ring->funcs->patch_cond_exec)
 		amdgpu_ring_patch_cond_exec(ring, patch_offset);
 
-- 
2.34.1

