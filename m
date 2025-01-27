Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49C82C02191
	for <amd-gfx@archiver.kernel.org>; Mon, 27 Jan 2025 15:32:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 820DC10E56A;
	Mon, 27 Jan 2025 15:32:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="SdpkT3Vk";
	dkim-atps=neutral
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com
 [209.85.128.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C565210E569
 for <amd-gfx@lists.freedesktop.org>; Mon, 27 Jan 2025 15:32:13 +0000 (UTC)
Received: by mail-wm1-f46.google.com with SMTP id
 5b1f17b1804b1-436ce2ab251so30019955e9.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 27 Jan 2025 07:32:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1737991932; x=1738596732; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=g2RVUIy/Y6d5uhj8X4mPDrIym1RpYeBC8d1zNwGwpN0=;
 b=SdpkT3VkR0BwpmYvII9yDI8cxwPatABJRLU27kgs4D8unmra64mTqSB4t3itzmkoGy
 nYuJR6yXBMgUmR6IxU5h2Rsq6caINJ7b9K0BzSajjcUaHvQCOc/M8mj2sxn/6K170rID
 NOOnM0nCYhZC67sBgoALodS41UVCEOIABBwCKN2t8qcujBPCQ8jhTFNvFXKZYPhYJYZB
 5uF8iiHcErYFbreiAjfTpM67kTpVthJDCDu7Xev5UGW6LUEORn9FfTNsbm3qF12gw06Q
 awgITt2Y0CDHuPvT54pNlVEwPwxiS3SbP801WUn0faKIiSx3+0ESSPRx1mwFxkq6EmA/
 HLNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737991932; x=1738596732;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=g2RVUIy/Y6d5uhj8X4mPDrIym1RpYeBC8d1zNwGwpN0=;
 b=vMpou+YnECDJ1xumRC03Skq0og4yrvBjAfMQw3vXmSWtRMZkaLXzNlYLm+jrBfMbZv
 PescdWBMk0vxrSsVgreC1jUGLmsWDoI8WPA0bABadDI9KU7VuVcVHyM5ZelFcirH7FGF
 lO3CbWmguT/46YddvqdnxzHP3H+h2YnLTxoanx9kGtI/rjbjSxJTPRiRQ5xB1MGc/ox2
 rzUWOt28d2sCF+tusEzrVLjEKUTxk4a2XwVIGdQAKOqKv+TCPY2QTPc9whIDx4dLpn/C
 Do2p3uNMCYQ8iBTciZyLkZE3irEL/sSfOH/GmkWPL+x1dh7IdXjunbemM0l0n+Yr893O
 b9QQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUBgiCENuv7aAtg2kNhr6Jqi2ku1+56Cv921m6HdDy01e/YU13ws+oN9cRl1xpPZUeJNvJJcpUo@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxcU6TB6cpiEZg82qnO+n4I5WUdCdBlxXunB8EttEi4rS1ERI/o
 XRvongYO4J98N2ggTHPHwgZNOK4/76u5j53fH/xaSHetnwfh/1GX
X-Gm-Gg: ASbGnct2vqoK1e9IVqc09LDlX5wLQKheZJT5Xljpnukm6FkdyZjHQOOmNnvWXGY7XDv
 odAM13mJKd3lCNao+WB9Osih9Y34jN62+77TG/WLCWvOxqWltGvIxv2D8hlpWavJ+fOC9QtVirH
 kKag1wymiUdWoiwOfwZuMkbRatIC0V0nwox/LTEb9zlN2YevpXgrktZOy9/2b/wZneketTTKhF4
 5mFcYjPbScD+xUc+w9DIk0HJgJ8apkC0oNhg9F/ixVvQbymrOxCK7K9kZ4g2p59ikhE4VLFoD/2
 Fh09K2rfDK7MfXv7kA==
X-Google-Smtp-Source: AGHT+IFwM/xIUuBgdk88O1U9MCilKqUCFqEvxyu2ZZzKoXgyNNRZLQ4eRGQcWDItVFlmJs0+0LHh+Q==
X-Received: by 2002:a05:600c:4e89:b0:434:f739:7ce3 with SMTP id
 5b1f17b1804b1-438913cb518mr370259005e9.8.1737991932024; 
 Mon, 27 Jan 2025 07:32:12 -0800 (PST)
Received: from able.fritz.box ([2a00:e180:153d:dd00:1202:d6cf:5d6d:56cb])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438bd575468sm133904325e9.39.2025.01.27.07.32.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jan 2025 07:32:11 -0800 (PST)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: Alexander.Deucher@amd.com, srinivasan.shanmugam@amd.com,
 amd-gfx@lists.freedesktop.org
Subject: [PATCH 5/6] drm/amdgpu: rework how the cleaner shader is emitted
Date: Mon, 27 Jan 2025 16:32:06 +0100
Message-Id: <20250127153207.5717-5-christian.koenig@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250127153207.5717-1-christian.koenig@amd.com>
References: <20250127153207.5717-1-christian.koenig@amd.com>
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

Signed-off-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 25 ++++++++++++++++++++-----
 1 file changed, 20 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index c9c48b782ec1..9d94479532fb 100644
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
+		ring->funcs->emit_cleaner_shader &&
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

