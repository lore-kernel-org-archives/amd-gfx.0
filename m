Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87BB8C28B26
	for <amd-gfx@archiver.kernel.org>; Fri,  7 Mar 2025 13:48:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ECB5610EB61;
	Fri,  7 Mar 2025 13:48:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Pn6qoQNf";
	dkim-atps=neutral
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com
 [209.85.128.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8401F10EB60
 for <amd-gfx@lists.freedesktop.org>; Fri,  7 Mar 2025 13:48:21 +0000 (UTC)
Received: by mail-wm1-f42.google.com with SMTP id
 5b1f17b1804b1-43bd732fd27so15990145e9.0
 for <amd-gfx@lists.freedesktop.org>; Fri, 07 Mar 2025 05:48:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741355300; x=1741960100; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=6HoI1MD6qqLF9bLjt9AxED7J2H00L5PVTExEzO21AGA=;
 b=Pn6qoQNfuZpuJR4a7sTGw8bEVX2sdeGo3s2O45naKg4jVpH4Uzm6shDZ6YIjz+mm9w
 MwEa/e7aoNdewah+yG9wpww7iozfhqLG9N0vNY6qLzEcnbpxOkNvZB/7tUBi42Bex4Vx
 I2l3FMMvO6z7tmgLmA5GbIs6TcYOmwed3PtiIEIMm4zbuYIJqH7J4BlD6gw3bNTPREUD
 e5LPmzZAF0V9XrEFD4zyPZn9go8MNldPeZd9/v4UzHIUsZOeeSnz9BEMuQobv50M+mBp
 IlctxOZrnQ5agMNo7gOFV61n/EVcOg4ftCRzcIvd+8HN9brTfdO7vsCWTeLtjHcjDdLF
 9QEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741355300; x=1741960100;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6HoI1MD6qqLF9bLjt9AxED7J2H00L5PVTExEzO21AGA=;
 b=qsbbejPXiVl7qOGSawzxrewCuLOnHyHVbsmOXWDAbm1MHz/JnzUIo9DehWPPHO/N3R
 UAZSkF2VfttsdL4ILqiObiILVXIIiEK+8d0ow0Ep58yAJf9xBlUa4HUDsNwzlK/JlWKM
 5dL0g2zWHfJhAlpO1fM7axt5NcGC9yRqouGG94Ep29LgD8bm5tJikb4EoA2S2TIt2ipI
 aMf47uFsJ44IsYD26n+++zaHr9moZaqqcNNBHztPsCKscO9A+T61TntsA5eC+CzRRi4H
 N3ASXsDaPdD53pZCuEklpqSMYZDnNozCtnv2/GZKstFSRX8OQoDbpYnm66Ev2JmBSYQO
 i6dg==
X-Forwarded-Encrypted: i=1;
 AJvYcCW03Z9p647uL/2VOxk2W9hnE5n7WfNRcCG5pl1wTVC+QUxqXfGkP482bACTK9c3roF2O0CPR5lp@lists.freedesktop.org
X-Gm-Message-State: AOJu0Ywc/62pOpqPcM2zTlF+LvxkHTL4uMQEIAfa8HOBO48MK8ZZYBUJ
 rSccJkLfKc1u8+xeCN5pMhslOE0Aw4a5/XErIMgZtxDRiu0MZzyrCfPGUxYIciM=
X-Gm-Gg: ASbGncsVJyXSt6bL2JY7KDhuRq3W9YGShZPixfLwEljq52jC7KDeKn4UCys3PovdfOm
 BJQD/aAUaaKZXuHBoLYN3NM1iEMz0h42BU6fYrODVDd3hg6jBNphvYENr56GpSH/s5HVa8MxoBP
 BWy+Y7DiN0YYqCn7ToIrqInrT6F9XQ90WYDkrgE8DcRHCDk+vxPqfWfjIV070SJqI/SZgZJKrFG
 3HvN30nI0ZkFpPTgDWXW1TVErBtmIGdFxh0a2aCdEDrVDqIeJn/Yfd/cPG1e8SnsWzR/fz0v44g
 3DTeiRooaJn6Hhca2KYCjqg1cExWiJy9GsKI26vnl1tm3eXoDPO32dZcew==
X-Google-Smtp-Source: AGHT+IFvlC3kR5aXt++cxN1BKxFDVFzd8oKB1ksAWJ6ZO6AOIPM0QlNYNU9un7vRLMNGWoLFYznLWA==
X-Received: by 2002:a05:600c:3553:b0:439:8bc3:a698 with SMTP id
 5b1f17b1804b1-43c601cdc45mr24264485e9.6.1741355299796; 
 Fri, 07 Mar 2025 05:48:19 -0800 (PST)
Received: from able.fritz.box ([2a00:e180:14d3:5e00:ab55:e6a0:3a3d:9571])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43bd91338cesm70613345e9.7.2025.03.07.05.48.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Mar 2025 05:48:19 -0800 (PST)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: srinivasan.shanmugam@amd.com, amd-gfx@lists.freedesktop.org,
 alexander.deucher@amd.com
Subject: [PATCH 5/8] drm/amdgpu: rework how the cleaner shader is emitted v3
Date: Fri,  7 Mar 2025 14:48:13 +0100
Message-Id: <20250307134816.1422-5-christian.koenig@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250307134816.1422-1-christian.koenig@amd.com>
References: <20250307134816.1422-1-christian.koenig@amd.com>
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

Instead of emitting the cleaner shader for every job which has the
enforce_isolation flag set only emit it for the first submission from
every client.

v2: add missing NULL check
v3: fix another NULL pointer deref

Signed-off-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 27 ++++++++++++++++++++------
 1 file changed, 21 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index ef4fe2df8398..dc10bea836db 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -643,6 +643,7 @@ int amdgpu_vm_flush(struct amdgpu_ring *ring, struct amdgpu_job *job,
 		    bool need_pipe_sync)
 {
 	struct amdgpu_device *adev = ring->adev;
+	struct amdgpu_isolation *isolation = &adev->isolation[ring->xcp_id];
 	unsigned vmhub = ring->vm_hub;
 	struct amdgpu_vmid_mgr *id_mgr = &adev->vm_manager.id_mgr[vmhub];
 	struct amdgpu_vmid *id = &id_mgr->ids[job->vmid];
@@ -650,8 +651,9 @@ int amdgpu_vm_flush(struct amdgpu_ring *ring, struct amdgpu_job *job,
 	bool gds_switch_needed = ring->funcs->emit_gds_switch &&
 		job->gds_switch_needed;
 	bool vm_flush_needed = job->vm_needs_flush;
-	struct dma_fence *fence = NULL;
+	bool cleaner_shader_needed = false;
 	bool pasid_mapping_needed = false;
+	struct dma_fence *fence = NULL;
 	unsigned int patch;
 	int r;
 
@@ -674,8 +676,12 @@ int amdgpu_vm_flush(struct amdgpu_ring *ring, struct amdgpu_job *job,
 	pasid_mapping_needed &= adev->gmc.gmc_funcs->emit_pasid_mapping &&
 		ring->funcs->emit_wreg;
 
+	cleaner_shader_needed = adev->gfx.enable_cleaner_shader &&
+		ring->funcs->emit_cleaner_shader && job->base.s_fence &&
+		&job->base.s_fence->scheduled == isolation->spearhead;
+
 	if (!vm_flush_needed && !gds_switch_needed && !need_pipe_sync &&
-	    !(job->enforce_isolation && !job->vmid))
+	    !cleaner_shader_needed)
 		return 0;
 
 	amdgpu_ring_ib_begin(ring);
@@ -686,9 +692,7 @@ int amdgpu_vm_flush(struct amdgpu_ring *ring, struct amdgpu_job *job,
 	if (need_pipe_sync)
 		amdgpu_ring_emit_pipeline_sync(ring);
 
-	if (adev->gfx.enable_cleaner_shader &&
-	    ring->funcs->emit_cleaner_shader &&
-	    job->enforce_isolation)
+	if (cleaner_shader_needed)
 		ring->funcs->emit_cleaner_shader(ring);
 
 	if (vm_flush_needed) {
@@ -710,7 +714,7 @@ int amdgpu_vm_flush(struct amdgpu_ring *ring, struct amdgpu_job *job,
 					    job->oa_size);
 	}
 
-	if (vm_flush_needed || pasid_mapping_needed) {
+	if (vm_flush_needed || pasid_mapping_needed || cleaner_shader_needed) {
 		r = amdgpu_fence_emit(ring, &fence, NULL, 0);
 		if (r)
 			return r;
@@ -732,6 +736,17 @@ int amdgpu_vm_flush(struct amdgpu_ring *ring, struct amdgpu_job *job,
 		id->pasid_mapping = dma_fence_get(fence);
 		mutex_unlock(&id_mgr->lock);
 	}
+
+	/*
+	 * Make sure that all other submissions wait for the cleaner shader to
+	 * finish before we push them to the HW.
+	 */
+	if (cleaner_shader_needed) {
+		mutex_lock(&adev->enforce_isolation_mutex);
+		dma_fence_put(isolation->spearhead);
+		isolation->spearhead = dma_fence_get(fence);
+		mutex_unlock(&adev->enforce_isolation_mutex);
+	}
 	dma_fence_put(fence);
 
 	amdgpu_ring_patch_cond_exec(ring, patch);
-- 
2.34.1

