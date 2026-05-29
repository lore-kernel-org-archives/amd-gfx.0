Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10A21CD6E52
	for <amd-gfx@archiver.kernel.org>; Fri, 29 May 2026 11:40:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2930810FDC8;
	Fri, 29 May 2026 11:40:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="E2pjIMgy";
	dkim-atps=neutral
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com
 [209.85.128.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E08C410FDC7
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 May 2026 11:40:39 +0000 (UTC)
Received: by mail-wm1-f44.google.com with SMTP id
 5b1f17b1804b1-4891e86fabeso48671595e9.1
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 May 2026 04:40:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780054838; x=1780659638; darn=lists.freedesktop.org;
 h=content-transfer-encoding:reply-to:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to;
 bh=u51rCw9P/iWXzfd1iRSACSjk0qhVvxf62TtyXQFDXUY=;
 b=E2pjIMgyqBt4LcSzLs72uWnawKIkkRCAfa3dmLZy8ITpeCqXMsqTtqW2hOg3kjOLX5
 0hYBONOP/07eQQjx8mu1GpAOhpK7M++5Q2NZMh14cz0ULltH/oFCKHJ8iYkarUZOD2wL
 u/ycEZnspSuVlMcrwJQD8FOauXG2txpOIpFzCbGNhKkGdbjak1f4NAYH3Z+/iU7lF/cu
 1aHB1YZlUdp/FxwquTCs6XA6+kOeXIFc6SSFDXDNdlix/lEgrK5HPq1oqKxPg5d+eqeo
 ELPSuI9iPXSL+npla4SZJljH8TnlXp/22NtOgwIldcyi0GtuqFDDPd9CDcdQfDsEhRWF
 F1/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780054838; x=1780659638;
 h=content-transfer-encoding:reply-to:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=u51rCw9P/iWXzfd1iRSACSjk0qhVvxf62TtyXQFDXUY=;
 b=Tu5tqSYcnq4huLl1NzUYLvkUF6VUwq7+tX9nop8WN7Pga97vYTEINPcIv8R+n5YWlc
 BcIhvIOaO5YRAMAuJIbkf8SgyhWu4w5+miUH00XbqEdrE+SQITQNw2/nGs1ZnjWzlb05
 HxOLz9Dhqv799Ur1p/uqXlbrfo1qppFscDvVpW87I6CJ4g0Vy45gDtc2JLQ5Ndy89HPw
 658yTQGCjclybJeuKWAxqovmUgY4tds8OHQ+gZ5zy0KJirC5jxrS3RrYzBEanXoeNk7S
 sjZNTihBz4ZtqZ2z1FO5ekmqDTn0+Eq9mlFlrBPq5JLcKwHboD0MWWe1Gs6jjL37t4xg
 O0OA==
X-Gm-Message-State: AOJu0Yz+N+hqBFg/aqIrXfr1Zi+z35oZixdf79S/AdpRG/N/7w4dnoeC
 Dqn9tPS4nAltFr757gkSClq58RXmLKER77owTxGudieRblekWxDmv51l
X-Gm-Gg: Acq92OFx0Ax5/05SOT68mqry69ZL3BJzsNfGiHZXXZYZQ/LZWNMV9F/vD4MhROwc9nU
 7ZY1X3wB0MapJtr4B+SMTe8hQXHu5eV7r21V3UrbV7ErxNeDRN32nahToRIVwpBRV3fsteOl/dm
 Ck+r9xhUMlihQCPyKE/5WrogQZTmux/MERCoobetsomzArQAGSGdMD/6lqbFTBw/ZPeZlFtSoYP
 RJwHhU+44Y9bPU+KrTatJdLOHmNcdam8q1wy3DtMRVikWX97SXfmmNWNiBUcpXwCPGzU0ccqfsB
 XSnomAvBaeTlmS3kE8jmOtvKbWz3GV7Adgu3aGb+AofpAE6S5+THFk7uBzi2iqrX9fyE9AY7SJb
 UFoJkayo29jK4nmXvbTUY1PApBTLG3erQy90y1dtkk7PstbewfxZoXFhFoMru9sq19CtG9KbVhK
 csHxAU31t0w9hlPFIMtxfYtVIxkH64aVz6SqoxUuyr2CCi/QXWCw8LFg==
X-Received: by 2002:a05:600c:83c6:b0:490:9588:bdae with SMTP id
 5b1f17b1804b1-4909c0b3149mr55571355e9.18.1780054838340; 
 Fri, 29 May 2026 04:40:38 -0700 (PDT)
Received: from able.fritz.box ([2a00:e180:1544:8100:da55:fa26:bd:a26])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45ef354cf0dsm2993109f8f.17.2026.05.29.04.40.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 May 2026 04:40:37 -0700 (PDT)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: natalie.vock@gmx.de, honghuan@amd.com, Alexander.Deucher@amd.com,
 Felix.Kuehling@amd.com, Philip.Yang@amd.com, timur.kristof@gmail.com
Cc: amd-gfx@lists.freedesktop.org
Subject: [PATCH 04/13] drm/amdgpu: move job parameter to the end in
 amdgpu_job_alloc() and *_with_ib()
Date: Fri, 29 May 2026 13:24:06 +0200
Message-ID: <20260529114031.3714-5-christian.koenig@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260529114031.3714-1-christian.koenig@amd.com>
References: <20260529114031.3714-1-christian.koenig@amd.com>
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

Move the job output parameter to be the last parameter in the
amdgpu_job_alloc() and amdgpu_job_alloc_with_ib() function signature. This
aligns with the common kernel coding convention where output parameters
typically come last.

Co-developed by Claude Sonnet 4.

Signed-off-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c  |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c      |  4 ++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c     |  5 +++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c     |  3 ++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.c     | 10 +++++-----
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.h     |  8 ++++----
 drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c    |  5 +++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c     | 11 ++++++-----
 drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c     |  5 +++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c     |  8 +++++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c     | 12 ++++++++----
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c |  2 +-
 drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c       | 10 ++++++----
 drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c       | 10 ++++++----
 drivers/gpu/drm/amd/amdkfd/kfd_migrate.c    |  4 ++--
 15 files changed, 57 insertions(+), 42 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
index 0017d502d169..44751d71b741 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
@@ -696,7 +696,7 @@ int amdgpu_amdkfd_submit_ib(struct amdgpu_device *adev,
 		goto err;
 	}
 
-	ret = amdgpu_job_alloc(adev, NULL, NULL, NULL, 1, &job, 0);
+	ret = amdgpu_job_alloc(adev, NULL, NULL, NULL, 1, 0, &job);
 	if (ret)
 		goto err;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
index 10d8dcc3a972..fdf01d824d66 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
@@ -274,8 +274,8 @@ static int amdgpu_cs_pass1(struct amdgpu_cs_parser *p,
 
 	for (i = 0; i < p->gang_size; ++i) {
 		ret = amdgpu_job_alloc(p->adev, vm, p->entities[i], vm,
-				       num_ibs[i], &p->jobs[i],
-				       p->filp->client_id);
+				       num_ibs[i], p->filp->client_id,
+				       &p->jobs[i]);
 		if (ret)
 			goto free_all_kdata;
 		switch (p->adev->enforce_isolation[fpriv->xcp_id]) {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
index 515cc4a2aeb4..54450ac49834 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -1669,8 +1669,9 @@ static int amdgpu_gfx_run_cleaner_shader_job(struct amdgpu_ring *ring)
 	owner = (void *)(unsigned long)atomic_inc_return(&counter);
 
 	r = amdgpu_job_alloc_with_ib(ring->adev, &entity, owner,
-				     64, 0, &job,
-				     AMDGPU_KERNEL_JOB_ID_CLEANER_SHADER);
+				     64, 0,
+				     AMDGPU_KERNEL_JOB_ID_CLEANER_SHADER,
+				     &job);
 	if (r)
 		goto err;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
index 13bec8461cde..181d69770c40 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
@@ -761,7 +761,8 @@ void amdgpu_gmc_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
 	r = amdgpu_job_alloc_with_ib(ring->adev, &adev->mman.default_entity.base,
 				     AMDGPU_FENCE_OWNER_UNDEFINED,
 				     16 * 4, AMDGPU_IB_POOL_IMMEDIATE,
-				     &job, AMDGPU_KERNEL_JOB_ID_FLUSH_GPU_TLB);
+				     AMDGPU_KERNEL_JOB_ID_FLUSH_GPU_TLB,
+				     &job);
 	if (r)
 		goto error_alloc;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
index 55172c2dcc35..71c1ba735a6b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
@@ -187,8 +187,8 @@ static enum drm_gpu_sched_stat amdgpu_job_timedout(struct drm_sched_job *s_job)
 
 int amdgpu_job_alloc(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 		     struct drm_sched_entity *entity, void *owner,
-		     unsigned int num_ibs, struct amdgpu_job **job,
-		     u64 drm_client_id)
+		     unsigned int num_ibs, u64 drm_client_id,
+		     struct amdgpu_job **job)
 {
 	struct amdgpu_fence *af;
 	int r;
@@ -241,12 +241,12 @@ int amdgpu_job_alloc(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 int amdgpu_job_alloc_with_ib(struct amdgpu_device *adev,
 			     struct drm_sched_entity *entity, void *owner,
 			     size_t size, enum amdgpu_ib_pool_type pool_type,
-			     struct amdgpu_job **job, u64 k_job_id)
+			     u64 k_job_id, struct amdgpu_job **job)
 {
 	int r;
 
-	r = amdgpu_job_alloc(adev, NULL, entity, owner, 1, job,
-			     k_job_id);
+	r = amdgpu_job_alloc(adev, NULL, entity, owner, 1, k_job_id,
+			     job);
 	if (r)
 		return r;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
index 56a88e14a044..6b7cf594714c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
@@ -112,13 +112,13 @@ static inline struct amdgpu_ring *amdgpu_job_ring(struct amdgpu_job *job)
 
 int amdgpu_job_alloc(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 		     struct drm_sched_entity *entity, void *owner,
-		     unsigned int num_ibs, struct amdgpu_job **job,
-		     u64 drm_client_id);
+		     unsigned int num_ibs, u64 drm_client_id,
+		     struct amdgpu_job **job);
 int amdgpu_job_alloc_with_ib(struct amdgpu_device *adev,
 			     struct drm_sched_entity *entity, void *owner,
 			     size_t size, enum amdgpu_ib_pool_type pool_type,
-			     struct amdgpu_job **job,
-			     u64 k_job_id);
+			     u64 k_job_id,
+			     struct amdgpu_job **job);
 void amdgpu_job_set_resources(struct amdgpu_job *job, struct amdgpu_bo *gds,
 			      struct amdgpu_bo *gws, struct amdgpu_bo *oa);
 void amdgpu_job_free_resources(struct amdgpu_job *job);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c
index 63ee6ba6a931..988ad86971a8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c
@@ -196,8 +196,9 @@ static int amdgpu_jpeg_dec_set_reg(struct amdgpu_ring *ring, uint32_t handle,
 	int i, r;
 
 	r = amdgpu_job_alloc_with_ib(ring->adev, NULL, NULL, ib_size_dw * 4,
-				     AMDGPU_IB_POOL_DIRECT, &job,
-				     AMDGPU_KERNEL_JOB_ID_VCN_RING_TEST);
+				     AMDGPU_IB_POOL_DIRECT,
+				     AMDGPU_KERNEL_JOB_ID_VCN_RING_TEST,
+				     &job);
 	if (r)
 		return r;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index 6c6ab4dd6ea9..cf78d7020494 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -243,8 +243,9 @@ static int amdgpu_ttm_map_buffer(struct amdgpu_ttm_buffer_entity *entity,
 	r = amdgpu_job_alloc_with_ib(adev, &entity->base,
 				     AMDGPU_FENCE_OWNER_UNDEFINED,
 				     num_dw * 4 + num_bytes,
-				     AMDGPU_IB_POOL_DELAYED, &job,
-				     AMDGPU_KERNEL_JOB_ID_TTM_MAP_BUFFER);
+				     AMDGPU_IB_POOL_DELAYED,
+				     AMDGPU_KERNEL_JOB_ID_TTM_MAP_BUFFER,
+				     &job);
 	if (r)
 		return r;
 
@@ -1573,8 +1574,8 @@ static int amdgpu_ttm_access_memory_sdma(struct ttm_buffer_object *bo,
 	r = amdgpu_job_alloc_with_ib(adev, &adev->mman.default_entity.base,
 				     AMDGPU_FENCE_OWNER_UNDEFINED,
 				     num_dw * 4, AMDGPU_IB_POOL_DELAYED,
-				     &job,
-				     AMDGPU_KERNEL_JOB_ID_TTM_ACCESS_MEMORY_SDMA);
+				     AMDGPU_KERNEL_JOB_ID_TTM_ACCESS_MEMORY_SDMA,
+				     &job);
 	if (r)
 		goto out;
 
@@ -2428,7 +2429,7 @@ static int amdgpu_ttm_prepare_job(struct amdgpu_device *adev,
 	int r;
 	r = amdgpu_job_alloc_with_ib(adev, &entity->base,
 				     AMDGPU_FENCE_OWNER_UNDEFINED,
-				     num_dw * 4, pool, job, k_job_id);
+				     num_dw * 4, pool, k_job_id, job);
 	if (r)
 		return r;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
index 3a3bc0d370fa..7df839634098 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
@@ -1137,8 +1137,9 @@ static int amdgpu_uvd_send_msg(struct amdgpu_ring *ring, struct amdgpu_bo *bo,
 	r = amdgpu_job_alloc_with_ib(ring->adev, &adev->uvd.entity,
 				     AMDGPU_FENCE_OWNER_UNDEFINED,
 				     64, direct ? AMDGPU_IB_POOL_DIRECT :
-				     AMDGPU_IB_POOL_DELAYED, &job,
-				     AMDGPU_KERNEL_JOB_ID_VCN_RING_TEST);
+				     AMDGPU_IB_POOL_DELAYED,
+				     AMDGPU_KERNEL_JOB_ID_VCN_RING_TEST,
+				     &job);
 	if (r)
 		return r;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
index efdebd9c0a1f..344a703d03be 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
@@ -473,7 +473,8 @@ static int amdgpu_vce_get_create_msg(struct amdgpu_ring *ring, uint32_t handle,
 	r = amdgpu_job_alloc_with_ib(ring->adev, &ring->adev->vce.entity,
 				     AMDGPU_FENCE_OWNER_UNDEFINED,
 				     ib_size_dw * 4, AMDGPU_IB_POOL_DIRECT,
-				     &job, AMDGPU_KERNEL_JOB_ID_VCN_RING_TEST);
+				     AMDGPU_KERNEL_JOB_ID_VCN_RING_TEST,
+				     &job);
 	if (r)
 		return r;
 
@@ -564,8 +565,9 @@ static int amdgpu_vce_get_destroy_msg(struct amdgpu_ring *ring, uint32_t handle,
 				     AMDGPU_FENCE_OWNER_UNDEFINED,
 				     ib_size_dw * 4,
 				     direct ? AMDGPU_IB_POOL_DIRECT :
-				     AMDGPU_IB_POOL_DELAYED, &job,
-				     AMDGPU_KERNEL_JOB_ID_VCN_RING_TEST);
+				     AMDGPU_IB_POOL_DELAYED,
+				     AMDGPU_KERNEL_JOB_ID_VCN_RING_TEST,
+				     &job);
 	if (r)
 		return r;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
index 616967519869..6b15415f989c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
@@ -631,7 +631,8 @@ static int amdgpu_vcn_dec_send_msg(struct amdgpu_ring *ring,
 
 	r = amdgpu_job_alloc_with_ib(ring->adev, NULL, NULL,
 				     64, AMDGPU_IB_POOL_DIRECT,
-				     &job, AMDGPU_KERNEL_JOB_ID_VCN_RING_TEST);
+				     AMDGPU_KERNEL_JOB_ID_VCN_RING_TEST,
+				     &job);
 	if (r)
 		goto err;
 
@@ -811,7 +812,8 @@ static int amdgpu_vcn_dec_sw_send_msg(struct amdgpu_ring *ring,
 
 	r = amdgpu_job_alloc_with_ib(ring->adev, NULL, NULL,
 				     ib_size_dw * 4, AMDGPU_IB_POOL_DIRECT,
-				     &job, AMDGPU_KERNEL_JOB_ID_VCN_RING_TEST);
+				     AMDGPU_KERNEL_JOB_ID_VCN_RING_TEST,
+				     &job);
 	if (r)
 		goto err;
 
@@ -941,7 +943,8 @@ static int amdgpu_vcn_enc_get_create_msg(struct amdgpu_ring *ring, uint32_t hand
 
 	r = amdgpu_job_alloc_with_ib(ring->adev, NULL, NULL,
 				     ib_size_dw * 4, AMDGPU_IB_POOL_DIRECT,
-				     &job, AMDGPU_KERNEL_JOB_ID_VCN_RING_TEST);
+				     AMDGPU_KERNEL_JOB_ID_VCN_RING_TEST,
+				     &job);
 	if (r)
 		return r;
 
@@ -1008,7 +1011,8 @@ static int amdgpu_vcn_enc_get_destroy_msg(struct amdgpu_ring *ring, uint32_t han
 
 	r = amdgpu_job_alloc_with_ib(ring->adev, NULL, NULL,
 				     ib_size_dw * 4, AMDGPU_IB_POOL_DIRECT,
-				     &job, AMDGPU_KERNEL_JOB_ID_VCN_RING_TEST);
+				     AMDGPU_KERNEL_JOB_ID_VCN_RING_TEST,
+				     &job);
 	if (r)
 		return r;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c
index 2eb64df6daa9..50cc0779c340 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c
@@ -56,7 +56,7 @@ static int amdgpu_vm_sdma_alloc_job(struct amdgpu_vm_update_params *p,
 	ndw = min(ndw, AMDGPU_VM_SDMA_MAX_NUM_DW);
 
 	r = amdgpu_job_alloc_with_ib(p->adev, entity, AMDGPU_FENCE_OWNER_VM,
-				     ndw * 4, pool, &p->job, k_job_id);
+				     ndw * 4, pool, k_job_id, &p->job);
 	if (r)
 		return r;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c b/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c
index ecd7ead7a60b..16137829fe84 100644
--- a/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c
@@ -217,8 +217,9 @@ static int uvd_v6_0_enc_get_create_msg(struct amdgpu_ring *ring, uint32_t handle
 	int i, r;
 
 	r = amdgpu_job_alloc_with_ib(ring->adev, NULL, NULL, ib_size_dw * 4,
-				     AMDGPU_IB_POOL_DIRECT, &job,
-				     AMDGPU_KERNEL_JOB_ID_VCN_RING_TEST);
+				     AMDGPU_IB_POOL_DIRECT,
+				     AMDGPU_KERNEL_JOB_ID_VCN_RING_TEST,
+				     &job);
 	if (r)
 		return r;
 
@@ -282,8 +283,9 @@ static int uvd_v6_0_enc_get_destroy_msg(struct amdgpu_ring *ring,
 	int i, r;
 
 	r = amdgpu_job_alloc_with_ib(ring->adev, NULL, NULL, ib_size_dw * 4,
-				     AMDGPU_IB_POOL_DIRECT, &job,
-				     AMDGPU_KERNEL_JOB_ID_VCN_RING_TEST);
+				     AMDGPU_IB_POOL_DIRECT,
+				     AMDGPU_KERNEL_JOB_ID_VCN_RING_TEST,
+				     &job);
 	if (r)
 		return r;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c b/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c
index df2c83348315..46222fc30be6 100644
--- a/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c
@@ -225,8 +225,9 @@ static int uvd_v7_0_enc_get_create_msg(struct amdgpu_ring *ring, u32 handle,
 	int i, r;
 
 	r = amdgpu_job_alloc_with_ib(ring->adev, NULL, NULL, ib_size_dw * 4,
-				     AMDGPU_IB_POOL_DIRECT, &job,
-				     AMDGPU_KERNEL_JOB_ID_VCN_RING_TEST);
+				     AMDGPU_IB_POOL_DIRECT,
+				     AMDGPU_KERNEL_JOB_ID_VCN_RING_TEST,
+				     &job);
 	if (r)
 		return r;
 
@@ -289,8 +290,9 @@ static int uvd_v7_0_enc_get_destroy_msg(struct amdgpu_ring *ring, u32 handle,
 	int i, r;
 
 	r = amdgpu_job_alloc_with_ib(ring->adev, NULL, NULL, ib_size_dw * 4,
-				     AMDGPU_IB_POOL_DIRECT, &job,
-				     AMDGPU_KERNEL_JOB_ID_VCN_RING_TEST);
+				     AMDGPU_IB_POOL_DIRECT,
+				     AMDGPU_KERNEL_JOB_ID_VCN_RING_TEST,
+				     &job);
 	if (r)
 		return r;
 
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
index 28dc6886c1ff..51ad46c25c5a 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
@@ -68,8 +68,8 @@ svm_migrate_gart_map(struct amdgpu_ring *ring,
 				     AMDGPU_FENCE_OWNER_UNDEFINED,
 				     num_dw * 4 + num_bytes,
 				     AMDGPU_IB_POOL_DELAYED,
-				     &job,
-				     AMDGPU_KERNEL_JOB_ID_KFD_GART_MAP);
+				     AMDGPU_KERNEL_JOB_ID_KFD_GART_MAP,
+				     &job);
 	if (r)
 		return r;
 
-- 
2.43.0

