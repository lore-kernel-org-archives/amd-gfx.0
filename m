Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CD83C021AF
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Feb 2025 16:14:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 75ED410E715;
	Tue, 18 Feb 2025 16:14:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="j9GDnO2J";
	dkim-atps=neutral
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com
 [209.85.221.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6D17B10E468
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Feb 2025 16:14:07 +0000 (UTC)
Received: by mail-wr1-f53.google.com with SMTP id
 ffacd0b85a97d-38f22fe889aso4517303f8f.3
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Feb 2025 08:14:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1739895246; x=1740500046; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=FhMeWEakkO9ox8/nEwdsqzaytpCnVkpRk9eEI5HKv2M=;
 b=j9GDnO2J3nv2owXgHQlCnLTCfMup6EZqVETxgB+3dXS66bDdYcD0EON93q0vrrtzMd
 rSBP39/u3QBv7noZeoAMSfmsujDoJz/KjqUXivvKn6OjBA9P6VS5bMPhYjC0i73DaMeW
 E51vgEKKy5/BMjRuVN7ytL8OPss1LkOSMGHhJSo9CMoD9iFY67bRiHenYaAzQ2u/GwTR
 tr0vnnCQSjJGQZOphSWYOqyyz2LvmQutXp9y8H10p9hw/JW2F4yDGmnNh/fQ4ce71oYT
 BeWQ2aAebQy3iYxYXz51zRD6dAaSz0DuL/9+9fStX9AqfvveEjn+2ZLKLP9mr8qTASLg
 graw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739895246; x=1740500046;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FhMeWEakkO9ox8/nEwdsqzaytpCnVkpRk9eEI5HKv2M=;
 b=oEDW5OtfITHv8T88SiBBDrekx2MXDxsyH29Py+ioHF9B765/9Qcjx+EKrM8LvF+prJ
 uoAYVWhXQiPxwuT7WUwZItBXY5zBkAjikmr6ymN64qLAwmYKQI9Xv6os7yS7+UVqOkpm
 vvzfg0x2ysWah51WVYiZgRjcev1/WRBR3dt6aoioJEp7Fqkz1NqgWII8zLZfAHIMoCnq
 JGb0qU6oZLao3bEs5gKji/Hk7z0OY2YXO1nvMmHvqPA6lUsLQJzRyAYT2aNCEiVIo4Z9
 qgSVzGhQYR8KAAYbDTt3MsbBe+odrihbDwNKUF3ikiY4DxquDdGp3vGiW5seOFtfNc3Q
 HjMA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXnHLX9gm/IDz7ycxkjR8TGlpcQy6rWZH6TpdO2tFpDJDCDVsh4PYucBtfbMMlDClfaxLgoQEw2@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyOP9DDV0CzlIL0ls1hy553WEczUxCm567cyA72Nv26oNYPI9uZ
 zF3fIr+L8SqMdX37XmItGdY59DCA3ng5vKXlEAKrS/V0T5F9yRUY
X-Gm-Gg: ASbGncvmYa/tzn0nIwQzExFzeG8RSFePM7PcuC7VLEWxg3330tj932sDYtaLeRMaCxl
 /VGprQqSk8CnqPTiNwVQpVliafRU3JCVimhD57DyvdX2Q/KSqmyAChPsngn+f/yIJyMFE4YBGtE
 hF/KlUQi/zaK7c9mbxo4A1Q/QEemw93JZeK4iP46hNj8mkDsSUO9u6aqwtb0DN6lBtwGe7bN2Dr
 ZSpt8hlzVchFNzqYFK+QGMCOM1IebSlEq16XnXZB4AZzpC/UzZrPftRHvsFC/jUHWQkUOhM+AeG
 AfcgH3F3FfRhTX1iXVC8ChJxpF3Y
X-Google-Smtp-Source: AGHT+IGCJGAdyAFwwExhuhqRqFzEoaQXcZFQOYhchoVF5u0CiKOY64lyrFA3HB4IfcCe9uPD98tFQw==
X-Received: by 2002:adf:e3c4:0:b0:38d:e3d4:4468 with SMTP id
 ffacd0b85a97d-38f33f565ccmr11331732f8f.51.1739895245813; 
 Tue, 18 Feb 2025 08:14:05 -0800 (PST)
Received: from able.fritz.box ([2a00:e180:15cb:ef00:7a4e:6292:55ba:b835])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-abba7848676sm306762466b.144.2025.02.18.08.14.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Feb 2025 08:14:05 -0800 (PST)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: srinivasan.shanmugam@amd.com,
	amd-gfx@lists.freedesktop.org
Subject: [PATCH 5/8] drm/amdgpu: rework how the cleaner shader is emitted v3
Date: Tue, 18 Feb 2025 17:13:58 +0100
Message-Id: <20250218161401.2155-5-christian.koenig@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250218161401.2155-1-christian.koenig@amd.com>
References: <20250218161401.2155-1-christian.koenig@amd.com>
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
index c9c48b782ec1..5323dba2d688 100644
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

