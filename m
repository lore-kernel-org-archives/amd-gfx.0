Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9AE4C433F5
	for <amd-gfx@archiver.kernel.org>; Mon, 31 Jan 2022 13:52:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6DCAB10E3ED;
	Mon, 31 Jan 2022 13:52:58 +0000 (UTC)
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com
 [IPv6:2a00:1450:4864:20::536])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 02E8B10E3ED
 for <amd-gfx@lists.freedesktop.org>; Mon, 31 Jan 2022 13:52:52 +0000 (UTC)
Received: by mail-ed1-x536.google.com with SMTP id w25so26054800edt.7
 for <amd-gfx@lists.freedesktop.org>; Mon, 31 Jan 2022 05:52:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=JIcjjIb56VCn5nvU/IufBWmDcKji89DqoorZsouPZT4=;
 b=IP6+tQVUJTTHc+YUi2BpX2rfLdLJgbBky3/aZD79pCp7zlgJOYWyA9GtdzEEwstKhR
 tpfYTz5QSFfvx4bOhRaPM8DUXy3QyiE2nV9RfLdM5kT65FHLVN3MqG35ZYvgO8wOLNOc
 NljOK99s56ZciwAAAPkVbVVsamN0pTUW7w0jB0tYI8tEP6nZM5Ic6Hvcg8r1xa9SaCk7
 AweJjr1Dn1C9nW6dVo1oHZau4heHxUokBQ+PuRHl5bev2180wXZswlUv1mXU5uHW8noV
 md0ZtMRbb744wfOiXZWy9y54OtsfrSvOucJ6KYqwMw5Mub0pCLUw+TJSkWzb6GUymwpX
 PneQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=JIcjjIb56VCn5nvU/IufBWmDcKji89DqoorZsouPZT4=;
 b=lIJlMEt4hoXLBclPCi0wE3hZLwMDo2HN4pRIKIi2XbWZXQN4s1uQZN6gSgfqX4Luh6
 nJqrkfv7OVY0koCNAkJi96CZFAAeMXtAROAhHrqKxdd6eMWE7by/vsgtK0+IH7Dn24xT
 1fifTDWLPqX3iwnjSGnDceB21+iLZEPABIDkm1CzwmC7pEjACHp9j+dukUGG7iAm6ooO
 seWTy0Az0CWAjNFhfDL6b89JnFVtrpp6sLVqKJARjrtD653VGGuHwYrf6rVLgFb8oBrz
 szKtcW2p0yyUQcg8qqdBicyjj4wGLhe4iLEbzQC4JN6vTRSrc0OTzBW0ZIlDWrMpniO7
 jsIQ==
X-Gm-Message-State: AOAM5310DqwHBqEwsp5b5bns6aCoFvtXo88kUZuFAw5GkYCuUCJSYWJf
 aLSSRh71ZE9AODyxTv+6p50=
X-Google-Smtp-Source: ABdhPJzSAmP9yN1U9QjzEa2ORSMlwBCPMJiElMvrGjzv01Dy1MrA3kNLVhiYXH7dwxkLSUsoh6BMJg==
X-Received: by 2002:a05:6402:3511:: with SMTP id
 b17mr20965505edd.244.1643637171563; 
 Mon, 31 Jan 2022 05:52:51 -0800 (PST)
Received: from baker.fritz.box (p57b0bff8.dip0.t-ipconnect.de.
 [87.176.191.248])
 by smtp.gmail.com with ESMTPSA id co19sm17893557edb.7.2022.01.31.05.52.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 Jan 2022 05:52:51 -0800 (PST)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: harish.kasiviswanathan@amd.com, benjaminadam.price@amd.com,
 felix.kuehling@amd.com
Subject: [PATCH 4/4] drm/amdgpu: restructure amdgpu_fill_buffer v2
Date: Mon, 31 Jan 2022 14:52:46 +0100
Message-Id: <20220131135246.1521-4-christian.koenig@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220131135246.1521-1-christian.koenig@amd.com>
References: <20220131135246.1521-1-christian.koenig@amd.com>
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
Cc: amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

We ran into the problem that clearing really larger buffer (60GiB) caused an
SDMA timeout.

Restructure the function to use the dst window instead of mapping the whole
buffer into the GART and then fill only 2MiB/256MiB chunks at a time.

v2: rebase on restructured window map.

Signed-off-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 187 +++++++++++++-----------
 1 file changed, 105 insertions(+), 82 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index 26c521cd1092..b9637d1cf147 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -396,8 +396,7 @@ static int amdgpu_move_blit(struct ttm_buffer_object *bo,
 	    (abo->flags & AMDGPU_GEM_CREATE_VRAM_WIPE_ON_RELEASE)) {
 		struct dma_fence *wipe_fence = NULL;
 
-		r = amdgpu_fill_buffer(ttm_to_amdgpu_bo(bo), AMDGPU_POISON,
-				       NULL, &wipe_fence);
+		r = amdgpu_fill_buffer(abo, AMDGPU_POISON, NULL, &wipe_fence);
 		if (r) {
 			goto error;
 		} else if (wipe_fence) {
@@ -1923,19 +1922,51 @@ void amdgpu_ttm_set_buffer_funcs_status(struct amdgpu_device *adev, bool enable)
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
 
@@ -1947,26 +1978,11 @@ int amdgpu_copy_buffer(struct amdgpu_ring *ring, uint64_t src_offset,
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
 
@@ -1996,77 +2012,35 @@ int amdgpu_copy_buffer(struct amdgpu_ring *ring, uint64_t src_offset,
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
@@ -2083,6 +2057,55 @@ int amdgpu_fill_buffer(struct amdgpu_bo *bo,
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
+		uint64_t cur_size, to;
+
+		/* Never fill more than 256MiB at once to avoid timeouts */
+		cur_size = min(dst.size, 256ULL << 20);
+
+		r = amdgpu_ttm_map_buffer(&bo->tbo, bo->tbo.resource, &dst,
+					  1, ring, false, &cur_size, &to);
+		if (r)
+			goto error;
+
+		r = amdgpu_ttm_fill_mem(ring, src_data, to, cur_size, resv,
+					&next, true);
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
-- 
2.25.1

