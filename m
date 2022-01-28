Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE423C433FE
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Jan 2022 15:16:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5313810F4B9;
	Fri, 28 Jan 2022 15:16:52 +0000 (UTC)
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com
 [IPv6:2a00:1450:4864:20::535])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 829FB10F4B7
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Jan 2022 15:16:49 +0000 (UTC)
Received: by mail-ed1-x535.google.com with SMTP id w25so9624430edt.7
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Jan 2022 07:16:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=drzIDe9WPg2oFSv1xriQJUWsj3uynxTRJgNGQU261+s=;
 b=BI6fegvSwMD7MXVYYZFh0iZKW2sbcO54u1RPveZ2heBflksCSEXpVq8UHIuT2YD+6P
 GPp5vGPw6r1sjkPnVbnmT5HDGtMD3l3HjzGzQyrn1jTjCpJQ4VG91HaB5e1pZA40P2yi
 Q1wJSgsirkTdEz06BvDBSzzHxrDLO7h231mpDn54ixwo9eCyGWkiPaWwlEHKYBoQO15E
 q/F5lt7K11X+6AAV4RE5TheeQWDFC0I+h/ubXTOcuKYdOf5t4ckmFVZOhZ8pRd2bqHBd
 Mhk7kCaHObst+8eONmGq7ClRXb1RkPYs5+F/GX1kmnhKZ08w+B3SFxgCp+ZeDccCQFEl
 m4UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=drzIDe9WPg2oFSv1xriQJUWsj3uynxTRJgNGQU261+s=;
 b=AAu8dhHIgKXgzHHae9UMi3BYnPIp6UhuH/IAek7CYfi6V2mDVOzhhkitNaPgDhMCZW
 B7rd+762ewJH1Bb+UTZgaBTmmNH6IdqvYU6f7ECbJolSoNxVDubkV6lxbwu3MGhYUbqx
 IX6XtD3hxPnvUb+sz2dk0mEjvjufBRCACgNfbgOv099mYyO7SS29CFRqChkd/s7KDdB1
 JaZRzpXuvEtnG2CXQS4FgJ9Z/pbygj14pf0EzliWKtUXBQDTVWQ0zzOvQfch9GbYScQo
 90YjVHY2w+txFOJO1JAdLiw8A0GKK4Snsjh3B27+N00BxuvRjd+HoC6xIZy0f/AdqEkV
 IZrA==
X-Gm-Message-State: AOAM530tBmXSTG9BuObf9eRWlDVV76J3BtbonKUx62jPCzoVEjCkn77K
 NIPyN8ATv/b0STP748435ag=
X-Google-Smtp-Source: ABdhPJwrLKHJetXT6jP4je/Iv3z6524X0tnSyg9my1szc+Avhn/Taq4Ay//jHPDXTSdUC2NASFU5fA==
X-Received: by 2002:a05:6402:3585:: with SMTP id
 y5mr8698570edc.104.1643383007866; 
 Fri, 28 Jan 2022 07:16:47 -0800 (PST)
Received: from baker.fritz.box (p57b0bff8.dip0.t-ipconnect.de.
 [87.176.191.248])
 by smtp.gmail.com with ESMTPSA id dv14sm2653220ejb.91.2022.01.28.07.16.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Jan 2022 07:16:47 -0800 (PST)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: harish.kasiviswanathan@amd.com, benjaminadam.price@amd.com,
 felix.kuehling@amd.com, amd-gfx@lists.freedesktop.org
Subject: [PATCH 2/2] drm/amdgpu: restructure amdgpu_fill_buffer
Date: Fri, 28 Jan 2022 16:16:37 +0100
Message-Id: <20220128151637.1403-2-christian.koenig@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220128151637.1403-1-christian.koenig@amd.com>
References: <20220128151637.1403-1-christian.koenig@amd.com>
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

We ran into the problem that clearing really larger buffer (60GiB) caused an
SDMA timeout.

Restructure the function to use the dst window instead of mapping the whole
buffer into the GART and then fill only 2MiB chunks at a time.

Signed-off-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 200 +++++++++++++-----------
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h |   2 +
 2 files changed, 114 insertions(+), 88 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index 2b0e83e9fa8a..8671ba32fb52 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -296,9 +296,6 @@ int amdgpu_ttm_copy_mem_to_mem(struct amdgpu_device *adev,
 			       struct dma_resv *resv,
 			       struct dma_fence **f)
 {
-	const uint32_t GTT_MAX_BYTES = (AMDGPU_GTT_MAX_TRANSFER_SIZE *
-					AMDGPU_GPU_PAGE_SIZE);
-
 	struct amdgpu_ring *ring = adev->mman.buffer_funcs_ring;
 	struct amdgpu_res_cursor src_mm, dst_mm;
 	struct dma_fence *fence = NULL;
@@ -320,12 +317,15 @@ int amdgpu_ttm_copy_mem_to_mem(struct amdgpu_device *adev,
 		uint32_t cur_size;
 		uint64_t from, to;
 
-		/* Copy size cannot exceed GTT_MAX_BYTES. So if src or dst
-		 * begins at an offset, then adjust the size accordingly
+		/*
+		 * Copy size cannot exceed AMDGPU_GTT_MAX_TRANSFER_BYTES. So if
+		 * src or dst begins at an offset, then adjust the size
+		 * accordingly
 		 */
 		cur_size = max(src_page_offset, dst_page_offset);
 		cur_size = min(min3(src_mm.size, dst_mm.size, size),
-			       (uint64_t)(GTT_MAX_BYTES - cur_size));
+			       (uint64_t)(AMDGPU_GTT_MAX_TRANSFER_BYTES -
+					  cur_size));
 
 		/* Map src to window 0 and dst to window 1. */
 		r = amdgpu_ttm_map_buffer(src->bo, src->mem, &src_mm,
@@ -395,8 +395,7 @@ static int amdgpu_move_blit(struct ttm_buffer_object *bo,
 	    (abo->flags & AMDGPU_GEM_CREATE_VRAM_WIPE_ON_RELEASE)) {
 		struct dma_fence *wipe_fence = NULL;
 
-		r = amdgpu_fill_buffer(ttm_to_amdgpu_bo(bo), AMDGPU_POISON,
-				       NULL, &wipe_fence);
+		r = amdgpu_fill_buffer(abo, AMDGPU_POISON, NULL, &wipe_fence);
 		if (r) {
 			goto error;
 		} else if (wipe_fence) {
@@ -1922,19 +1921,51 @@ void amdgpu_ttm_set_buffer_funcs_status(struct amdgpu_device *adev, bool enable)
 	adev->mman.buffer_funcs_enabled = enable;
 }
 
+static int amdgpu_ttm_prepare_job(struct amdgpu_device *adev,
+				  bool direct_submit,
+				  unsigned int num_dw,
+				  struct dma_resv *resv,
+				  bool vm_needs_flush,
+				  struct amdgpu_job **job)
+{
+	enum amdgpu_ib_pool_type pool = direct_submit ?
+		AMDGPU_IB_POOL_DIRECT :
+		AMDGPU_IB_POOL_DELAYED;
+	int r;
+
+	r = amdgpu_job_alloc_with_ib(adev, num_dw * 4, pool, job);
+	if (r)
+		return r;
+
+	if (vm_needs_flush) {
+		(*job)->vm_pd_addr = amdgpu_gmc_pd_addr(adev->gmc.pdb0_bo ?
+							adev->gmc.pdb0_bo :
+							adev->gart.bo);
+		(*job)->vm_needs_flush = true;
+	}
+	if (resv) {
+		r = amdgpu_sync_resv(adev, &(*job)->sync, resv,
+				     AMDGPU_SYNC_ALWAYS,
+				     AMDGPU_FENCE_OWNER_UNDEFINED);
+		if (r) {
+			DRM_ERROR("sync failed (%d).\n", r);
+			amdgpu_job_free(*job);
+			return r;
+		}
+	}
+	return 0;
+}
+
 int amdgpu_copy_buffer(struct amdgpu_ring *ring, uint64_t src_offset,
 		       uint64_t dst_offset, uint32_t byte_count,
 		       struct dma_resv *resv,
 		       struct dma_fence **fence, bool direct_submit,
 		       bool vm_needs_flush, bool tmz)
 {
-	enum amdgpu_ib_pool_type pool = direct_submit ? AMDGPU_IB_POOL_DIRECT :
-		AMDGPU_IB_POOL_DELAYED;
 	struct amdgpu_device *adev = ring->adev;
+	unsigned num_loops, num_dw;
 	struct amdgpu_job *job;
-
 	uint32_t max_bytes;
-	unsigned num_loops, num_dw;
 	unsigned i;
 	int r;
 
@@ -1946,26 +1977,11 @@ int amdgpu_copy_buffer(struct amdgpu_ring *ring, uint64_t src_offset,
 	max_bytes = adev->mman.buffer_funcs->copy_max_bytes;
 	num_loops = DIV_ROUND_UP(byte_count, max_bytes);
 	num_dw = ALIGN(num_loops * adev->mman.buffer_funcs->copy_num_dw, 8);
-
-	r = amdgpu_job_alloc_with_ib(adev, num_dw * 4, pool, &job);
+	r = amdgpu_ttm_prepare_job(adev, direct_submit, num_dw,
+				   resv, vm_needs_flush, &job);
 	if (r)
 		return r;
 
-	if (vm_needs_flush) {
-		job->vm_pd_addr = amdgpu_gmc_pd_addr(adev->gmc.pdb0_bo ?
-					adev->gmc.pdb0_bo : adev->gart.bo);
-		job->vm_needs_flush = true;
-	}
-	if (resv) {
-		r = amdgpu_sync_resv(adev, &job->sync, resv,
-				     AMDGPU_SYNC_ALWAYS,
-				     AMDGPU_FENCE_OWNER_UNDEFINED);
-		if (r) {
-			DRM_ERROR("sync failed (%d).\n", r);
-			goto error_free;
-		}
-	}
-
 	for (i = 0; i < num_loops; i++) {
 		uint32_t cur_size_in_bytes = min(byte_count, max_bytes);
 
@@ -1995,77 +2011,35 @@ int amdgpu_copy_buffer(struct amdgpu_ring *ring, uint64_t src_offset,
 	return r;
 }
 
-int amdgpu_fill_buffer(struct amdgpu_bo *bo,
-		       uint32_t src_data,
-		       struct dma_resv *resv,
-		       struct dma_fence **fence)
+static int amdgpu_ttm_fill_mem(struct amdgpu_ring *ring, uint32_t src_data,
+			       uint64_t dst_addr, uint32_t byte_count,
+			       struct dma_resv *resv,
+			       struct dma_fence **fence,
+			       bool vm_needs_flush)
 {
-	struct amdgpu_device *adev = amdgpu_ttm_adev(bo->tbo.bdev);
-	uint32_t max_bytes = adev->mman.buffer_funcs->fill_max_bytes;
-	struct amdgpu_ring *ring = adev->mman.buffer_funcs_ring;
-
-	struct amdgpu_res_cursor cursor;
+	struct amdgpu_device *adev = ring->adev;
 	unsigned int num_loops, num_dw;
-	uint64_t num_bytes;
-
 	struct amdgpu_job *job;
+	uint32_t max_bytes;
+	unsigned int i;
 	int r;
 
-	if (!adev->mman.buffer_funcs_enabled) {
-		DRM_ERROR("Trying to clear memory with ring turned off.\n");
-		return -EINVAL;
-	}
-
-	if (bo->tbo.resource->mem_type == AMDGPU_PL_PREEMPT) {
-		DRM_ERROR("Trying to clear preemptible memory.\n");
-		return -EINVAL;
-	}
-
-	if (bo->tbo.resource->mem_type == TTM_PL_TT) {
-		r = amdgpu_ttm_alloc_gart(&bo->tbo);
-		if (r)
-			return r;
-	}
-
-	num_bytes = bo->tbo.resource->num_pages << PAGE_SHIFT;
-	num_loops = 0;
-
-	amdgpu_res_first(bo->tbo.resource, 0, num_bytes, &cursor);
-	while (cursor.remaining) {
-		num_loops += DIV_ROUND_UP_ULL(cursor.size, max_bytes);
-		amdgpu_res_next(&cursor, cursor.size);
-	}
-	num_dw = num_loops * adev->mman.buffer_funcs->fill_num_dw;
-
-	/* for IB padding */
-	num_dw += 64;
-
-	r = amdgpu_job_alloc_with_ib(adev, num_dw * 4, AMDGPU_IB_POOL_DELAYED,
-				     &job);
+	max_bytes = adev->mman.buffer_funcs->fill_max_bytes;
+	num_loops = DIV_ROUND_UP_ULL(byte_count, max_bytes);
+	num_dw = ALIGN(num_loops * adev->mman.buffer_funcs->fill_num_dw, 8);
+	r = amdgpu_ttm_prepare_job(adev, false, num_dw, resv, vm_needs_flush,
+				   &job);
 	if (r)
 		return r;
 
-	if (resv) {
-		r = amdgpu_sync_resv(adev, &job->sync, resv,
-				     AMDGPU_SYNC_ALWAYS,
-				     AMDGPU_FENCE_OWNER_UNDEFINED);
-		if (r) {
-			DRM_ERROR("sync failed (%d).\n", r);
-			goto error_free;
-		}
-	}
-
-	amdgpu_res_first(bo->tbo.resource, 0, num_bytes, &cursor);
-	while (cursor.remaining) {
-		uint32_t cur_size = min_t(uint64_t, cursor.size, max_bytes);
-		uint64_t dst_addr = cursor.start;
+	for (i = 0; i < num_loops; i++) {
+		uint32_t cur_size = min(byte_count, max_bytes);
 
-		dst_addr += amdgpu_ttm_domain_start(adev,
-						    bo->tbo.resource->mem_type);
 		amdgpu_emit_fill_buffer(adev, &job->ibs[0], src_data, dst_addr,
 					cur_size);
 
-		amdgpu_res_next(&cursor, cur_size);
+		dst_addr += cur_size;
+		byte_count -= cur_size;
 	}
 
 	amdgpu_ring_pad_ib(ring, &job->ibs[0]);
@@ -2082,6 +2056,56 @@ int amdgpu_fill_buffer(struct amdgpu_bo *bo,
 	return r;
 }
 
+int amdgpu_fill_buffer(struct amdgpu_bo *bo,
+			uint32_t src_data,
+			struct dma_resv *resv,
+			struct dma_fence **f)
+{
+	struct amdgpu_device *adev = amdgpu_ttm_adev(bo->tbo.bdev);
+	struct amdgpu_ring *ring = adev->mman.buffer_funcs_ring;
+	struct dma_fence *fence = NULL;
+	struct amdgpu_res_cursor dst;
+	int r;
+
+	if (!adev->mman.buffer_funcs_enabled) {
+		DRM_ERROR("Trying to clear memory with ring turned off.\n");
+		return -EINVAL;
+	}
+
+	amdgpu_res_first(bo->tbo.resource, 0, amdgpu_bo_size(bo), &dst);
+
+	mutex_lock(&adev->mman.gtt_window_lock);
+	while (dst.remaining) {
+		struct dma_fence *next;
+		uint32_t cur_size;
+		uint64_t to;
+
+		cur_size = min_t(u64, dst.size, AMDGPU_GTT_MAX_TRANSFER_BYTES);
+
+		r = amdgpu_ttm_map_buffer(&bo->tbo, bo->tbo.resource, &dst,
+					  PFN_UP(cur_size), 1, ring, false,
+					  &to);
+		if (r)
+			goto error;
+
+		r = amdgpu_ttm_fill_mem(ring, src_data, to, cur_size, resv,
+					&next, false);
+		if (r)
+			goto error;
+
+		dma_fence_put(fence);
+		fence = next;
+
+		amdgpu_res_next(&dst, cur_size);
+	}
+error:
+	mutex_unlock(&adev->mman.gtt_window_lock);
+	if (f)
+		*f = dma_fence_get(fence);
+	dma_fence_put(fence);
+	return r;
+}
+
 /**
  * amdgpu_ttm_evict_resources - evict memory buffers
  * @adev: amdgpu device object
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
index d9691f262f16..bcd34592e45d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
@@ -35,6 +35,8 @@
 
 #define AMDGPU_GTT_MAX_TRANSFER_SIZE	512
 #define AMDGPU_GTT_NUM_TRANSFER_WINDOWS	2
+#define AMDGPU_GTT_MAX_TRANSFER_BYTES	(AMDGPU_GTT_MAX_TRANSFER_SIZE * \
+					 AMDGPU_GPU_PAGE_SIZE)
 
 #define AMDGPU_POISON	0xd0bed0be
 
-- 
2.25.1

