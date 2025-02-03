Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0BE9C02198
	for <amd-gfx@archiver.kernel.org>; Mon,  3 Feb 2025 11:58:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2820E10E49F;
	Mon,  3 Feb 2025 11:58:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="OJqDxZLr";
	dkim-atps=neutral
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com
 [209.85.221.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2F60910E49E
 for <amd-gfx@lists.freedesktop.org>; Mon,  3 Feb 2025 11:58:52 +0000 (UTC)
Received: by mail-wr1-f53.google.com with SMTP id
 ffacd0b85a97d-386329da1d9so2033501f8f.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 03 Feb 2025 03:58:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1738583930; x=1739188730; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MEGgTXBUl5WxTQqaA6GXwbdr+2TTVpJOF1c/JAGdwKs=;
 b=OJqDxZLryoIxFPKlXgVc0cCYpr6g9eyTIj+mHqRkzrodUtEdWMOavef5DuwC2FfLdw
 cw+cTTR1FY2wD+vaFPk+cmt3diwcJRanhy4qYKjSmJJ2F6LcmhD15Cr2/NBAAZ7Z1h0z
 42RdYth4TjYseiXuMzSiB2pKqWJ2j4ToNLup2YA/RS3Naz7cyukZF4Iwix9u2o0zlcTa
 7bIT5Xqy0Hw9rKr/UqW/SkNoqqx0W1YFAIGuoFqfnFt8eJ0E39p5iBZzYvLmyTZF5XyK
 PiLf5cfVZcjfvRFxQGnKCj+8/g57rVHHRRS1/Z4L4YI9GUV2JS54UB4aJSGcOJZwPzx/
 i3xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738583930; x=1739188730;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MEGgTXBUl5WxTQqaA6GXwbdr+2TTVpJOF1c/JAGdwKs=;
 b=Vpp7sNsximb7THdbLa0PRjRBe+IM5X9GLmJl17W2FUgS2DKcxT/nlT+BJvoCXiqgtz
 86DYSKBrOchn+kxGqCS5h0SENcVwU7xp4L+px6U8gjD02VBmCvXtGfvYMD/agxDYNdLZ
 oMPFfAI2UQt8cvjraCBLWNvoLjePqcla+2jGf0CPTgFLOUZivvPIKJ4bwbhzEzaUCZNH
 tbumBHzCp5R7S4Z+/kDhZEu7p84pN9fG3cJs0XJ2DYzeGYwVl/w8SNpePp05zruTx7KO
 UJR3nSa9YBOfN87U/O8s9f3yFNaNLA3WtA8LZGVhjM1rjcORFeS3BPU2S4GBHSerQlN/
 cNPw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXfXwNzhM8x7kbPPlRls9Ntj6IyYzCaLgAFtCTvPAFbg+PD2zD/W8Kxh0MblQhVdm+muLBY+spT@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwAQMV5eTjsa4Q2Y9xYN5XKwmnOt7E8kx6VaZomMls6AhcCbxp5
 UpZFxaDjpQmD9MtQovRq1dwCpdKSTJoN+xz6UwJhYX41oc0lDTae
X-Gm-Gg: ASbGnctP8tlYQUpFM7Bq2Vdnxb2L/IV3WRf1BrMXxf6EAVRE8t04ybVQ02ezoUU3EqO
 pa7JK2lEUXs6UUS7y3cSND6AavFrrlOJXI+JunvGqS4MXnRkjtZ1K9p9KQlgaI+iCHF8x3CkdSU
 IcF+CGPFnMQToaSfA+TDKJ7AwIMXFBlbyaWb06il2ZegDRGfWUrm/lZLH9PHnzY0mPXw7zH2cW/
 Hi4EbYnERnMjaIenHbiocGFqFiYd6Y5lGz1/uK3M0uA+S8MEmpIb11pG/vrPSHZM5iQ2OhK2IGJ
 ip6ISCMYKFv+r8Hnn6ZdHA4eVDs=
X-Google-Smtp-Source: AGHT+IGMJA0Qb6g2SMtqDgZP0VDNAD5JKpiQZ9QxA3bw5qni2mzOJQgFfp2yy7XLI17Ll9SFcmFqGg==
X-Received: by 2002:a5d:47a3:0:b0:38c:4a05:c25f with SMTP id
 ffacd0b85a97d-38c5209605dmr17138491f8f.42.1738583930473; 
 Mon, 03 Feb 2025 03:58:50 -0800 (PST)
Received: from able.fritz.box ([2a00:e180:15c2:700:903a:ba89:5ce0:8312])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38c5c1017besm12298928f8f.26.2025.02.03.03.58.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Feb 2025 03:58:50 -0800 (PST)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: srinivasan.shanmugam@amd.com,
	amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com
Subject: [PATCH 5/6] drm/amdgpu: rework how the cleaner shader is emitted v2
Date: Mon,  3 Feb 2025 12:58:45 +0100
Message-Id: <20250203115846.13142-5-christian.koenig@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250203115846.13142-1-christian.koenig@amd.com>
References: <20250203115846.13142-1-christian.koenig@amd.com>
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

Signed-off-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 25 ++++++++++++++++++++-----
 1 file changed, 20 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index c9c48b782ec1..68836a7e2125 100644
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

