Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AB49C433EF
	for <amd-gfx@archiver.kernel.org>; Thu,  3 Mar 2022 08:23:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DA4F210EF17;
	Thu,  3 Mar 2022 08:23:17 +0000 (UTC)
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com
 [IPv6:2a00:1450:4864:20::62d])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2E2DB10EF17
 for <amd-gfx@lists.freedesktop.org>; Thu,  3 Mar 2022 08:23:16 +0000 (UTC)
Received: by mail-ej1-x62d.google.com with SMTP id kt27so9036104ejb.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 03 Mar 2022 00:23:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ccRW1a1kRFTOkK1biut7fGZaP/v+P5rpcPZZo/IGcK8=;
 b=Sf1fqDtBQeokJ3JKJwjijRbFXn9+M9GY++CEooztR/302rftX6XtAFM8mrYNPvtEv3
 VlZ3PWu4GueZyceyrqCFKGKDLdmBwoKwjulybMGgUjaVa7A5uujYRVZLX1jKVgwavIdv
 2+/FxaFWVVCIwEypvFNcfKV2bRZ/HnC7TZ0HnEiyhGQKxW/YwBlCmuE1+qiHAXOutQbj
 ydJHS9f4vcRSBvhkUtYxmhwOm0kHR9AKIa5MYKLQ4NPRnaR48iCNLFGuIWZwxcP82O8L
 HhBgQM56bPWspzckr15AMHcqrjaRT6QT17fD6vDVVctn6xn4O7XakcZ9eioUxOzbuueC
 gpag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ccRW1a1kRFTOkK1biut7fGZaP/v+P5rpcPZZo/IGcK8=;
 b=MZUaMGsZGL1hF4yRFbiITN0DJg8wQVvPGD0aX+u+02C5hnfT/V5DgzA2je7r17K4E/
 3bt6qujb00bETKwc9Y/JsxmVuG9/7MBZk8rQjAUIrJKvQKxhe+PMPDOIv5IU3ls2bLyY
 FCI8jrrv9rKooxdUsET9J661YK17xu81qTTAS/uMwNNRVbiRaOR+YGVTzy/sRmXubwnM
 3pNioCUBSMzOwYrsZOuZs+QckGHw2Adyev8AyFnufZ3ENJlnl++pswjkXTOUAlCtrjed
 Xf4CLSqKxuzHaw+wp9xO/5QpG1mzTbdm8ewU+CY95EIkWcvaE94r6VPBx1yL6Z20amdH
 KBzA==
X-Gm-Message-State: AOAM531Iq2lZZVTU2XNAKepVt23wse+uSpTedWIAzw56sCcJAuUSM0t/
 kotfUOtR0MoUjNlq27Ymn+YliA0etyVKYQ==
X-Google-Smtp-Source: ABdhPJzLw5sMLX58/5WeXFa3jKBkUQ2r9hf5VT8kErT5HOpPtxmaOlI2M2S1GoGce4IZiJtadU8uYw==
X-Received: by 2002:a17:906:2991:b0:6cf:6b24:e92f with SMTP id
 x17-20020a170906299100b006cf6b24e92fmr25631443eje.748.1646295794124; 
 Thu, 03 Mar 2022 00:23:14 -0800 (PST)
Received: from able.fritz.box (p5b0eab60.dip0.t-ipconnect.de. [91.14.171.96])
 by smtp.gmail.com with ESMTPSA id
 n4-20020a056402060400b00415a1f9a4dasm548308edv.91.2022.03.03.00.23.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Mar 2022 00:23:13 -0800 (PST)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: amd-gfx@lists.freedesktop.org,
	Marek.Olsak@amd.com
Subject: [PATCH 03/10] drm/amdgpu: cleanup and reorder amdgpu_cs.c
Date: Thu,  3 Mar 2022 09:23:01 +0100
Message-Id: <20220303082308.38217-4-christian.koenig@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220303082308.38217-1-christian.koenig@amd.com>
References: <20220303082308.38217-1-christian.koenig@amd.com>
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
Cc: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Sort the functions in the order they are called and cleanup the coding
style and function names to represent the data they process.

Check the size of the IB chunk, initialize resulting entity and scheduler job
much earlier as well.

Signed-off-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c | 1374 ++++++++++++------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.h |    2 +-
 2 files changed, 683 insertions(+), 693 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
index 6b6a9d925994..58ddc4241f04 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
@@ -39,9 +39,61 @@
 #include "amdgpu_gem.h"
 #include "amdgpu_ras.h"
 
-static int amdgpu_cs_user_fence_chunk(struct amdgpu_cs_parser *p,
-				      struct drm_amdgpu_cs_chunk_fence *data,
-				      uint32_t *offset)
+static int amdgpu_cs_parser_init(struct amdgpu_cs_parser *p,
+				 struct amdgpu_device *adev,
+				 struct drm_file *filp,
+				 union drm_amdgpu_cs *cs)
+{
+	struct amdgpu_fpriv *fpriv = filp->driver_priv;
+
+	if (cs->in.num_chunks == 0)
+		return -EINVAL;
+
+	memset(p, 0, sizeof(*p));
+	p->adev = adev;
+	p->filp = filp;
+
+	p->ctx = amdgpu_ctx_get(fpriv, cs->in.ctx_id);
+	if (!p->ctx)
+		return -EINVAL;
+
+	if (atomic_read(&p->ctx->guilty)) {
+		amdgpu_ctx_put(p->ctx);
+		return -ECANCELED;
+	}
+	return 0;
+}
+
+static int amdgpu_cs_p1_ib(struct amdgpu_cs_parser *p,
+			   struct drm_amdgpu_cs_chunk_ib *chunk_ib,
+			   unsigned int *num_ibs)
+{
+	struct drm_sched_entity *entity;
+	int r;
+
+	r = amdgpu_ctx_get_entity(p->ctx, chunk_ib->ip_type,
+				  chunk_ib->ip_instance,
+				  chunk_ib->ring, &entity);
+	if (r)
+		return r;
+
+	/* Abort if there is no run queue associated with this entity.
+	 * Possibly because of disabled HW IP*/
+	if (entity->rq == NULL)
+		return -EINVAL;
+
+	/* Currently we don't support submitting to multiple entities */
+	if (p->entity && p->entity != entity)
+		return -EINVAL;
+
+	p->entity = entity;
+	++(*num_ibs);
+	return 0;
+}
+
+static int amdgpu_cs_p1_user_fence(struct amdgpu_cs_parser *p,
+				   struct drm_amdgpu_cs_chunk_fence *data,
+				   uint32_t *offset)
 {
 	struct drm_gem_object *gobj;
 	struct amdgpu_bo *bo;
@@ -80,11 +132,11 @@ static int amdgpu_cs_user_fence_chunk(struct amdgpu_cs_parser *p,
 	return r;
 }
 
-static int amdgpu_cs_bo_handles_chunk(struct amdgpu_cs_parser *p,
-				      struct drm_amdgpu_bo_list_in *data)
+static int amdgpu_cs_p1_bo_handles(struct amdgpu_cs_parser *p,
+				   struct drm_amdgpu_bo_list_in *data)
 {
+	struct drm_amdgpu_bo_list_entry *info;
 	int r;
-	struct drm_amdgpu_bo_list_entry *info = NULL;
 
 	r = amdgpu_bo_create_list_entry_array(data, &info);
 	if (r)
@@ -104,7 +156,9 @@ static int amdgpu_cs_bo_handles_chunk(struct amdgpu_cs_parser *p,
 	return r;
 }
 
-static int amdgpu_cs_parser_init(struct amdgpu_cs_parser *p, union drm_amdgpu_cs *cs)
+/* Copy the data from userspace and go over it the first time */
+static int amdgpu_cs_pass1(struct amdgpu_cs_parser *p,
+			   union drm_amdgpu_cs *cs)
 {
 	struct amdgpu_fpriv *fpriv = p->filp->driver_priv;
 	struct amdgpu_vm *vm = &fpriv->vm;
@@ -112,28 +166,14 @@ static int amdgpu_cs_parser_init(struct amdgpu_cs_parser *p, union drm_amdgpu_cs
 	uint64_t *chunk_array;
 	unsigned size, num_ibs = 0;
 	uint32_t uf_offset = 0;
-	int i;
 	int ret;
+	int i;
 
-	if (cs->in.num_chunks == 0)
-		return 0;
-
-	chunk_array = kvmalloc_array(cs->in.num_chunks, sizeof(uint64_t), GFP_KERNEL);
+	chunk_array = kvmalloc_array(cs->in.num_chunks, sizeof(uint64_t),
+				     GFP_KERNEL);
 	if (!chunk_array)
 		return -ENOMEM;
 
-	p->ctx = amdgpu_ctx_get(fpriv, cs->in.ctx_id);
-	if (!p->ctx) {
-		ret = -EINVAL;
-		goto free_chunk;
-	}
-
-	/* skip guilty context job */
-	if (atomic_read(&p->ctx->guilty) == 1) {
-		ret = -ECANCELED;
-		goto free_chunk;
-	}
-
 	/* get chunks */
 	chunk_array_user = u64_to_user_ptr(cs->in.chunks);
 	if (copy_from_user(chunk_array, chunk_array_user,
@@ -168,7 +208,8 @@ static int amdgpu_cs_parser_init(struct amdgpu_cs_parser *p, union drm_amdgpu_cs
 		size = p->chunks[i].length_dw;
 		cdata = u64_to_user_ptr(user_chunk.chunk_data);
 
-		p->chunks[i].kdata = kvmalloc_array(size, sizeof(uint32_t), GFP_KERNEL);
+		p->chunks[i].kdata = kvmalloc_array(size, sizeof(uint32_t),
+						    GFP_KERNEL);
 		if (p->chunks[i].kdata == NULL) {
 			ret = -ENOMEM;
 			i--;
@@ -180,36 +221,35 @@ static int amdgpu_cs_parser_init(struct amdgpu_cs_parser *p, union drm_amdgpu_cs
 			goto free_partial_kdata;
 		}
 
+		/* Assume the worst on the following checks */
+		ret = -EINVAL;
 		switch (p->chunks[i].chunk_id) {
 		case AMDGPU_CHUNK_ID_IB:
-			++num_ibs;
+			if (size < sizeof(struct drm_amdgpu_cs_chunk_ib))
+				goto free_partial_kdata;
+
+			ret = amdgpu_cs_p1_ib(p, p->chunks[i].kdata, &num_ibs);
+			if (ret)
+				goto free_partial_kdata;
 			break;
 
 		case AMDGPU_CHUNK_ID_FENCE:
-			size = sizeof(struct drm_amdgpu_cs_chunk_fence);
-			if (p->chunks[i].length_dw * sizeof(uint32_t) < size) {
-				ret = -EINVAL;
+			if (size < sizeof(struct drm_amdgpu_cs_chunk_fence))
 				goto free_partial_kdata;
-			}
 
-			ret = amdgpu_cs_user_fence_chunk(p, p->chunks[i].kdata,
-							 &uf_offset);
+			ret = amdgpu_cs_p1_user_fence(p, p->chunks[i].kdata,
+						      &uf_offset);
 			if (ret)
 				goto free_partial_kdata;
-
 			break;
 
 		case AMDGPU_CHUNK_ID_BO_HANDLES:
-			size = sizeof(struct drm_amdgpu_bo_list_in);
-			if (p->chunks[i].length_dw * sizeof(uint32_t) < size) {
-				ret = -EINVAL;
+			if (size < sizeof(struct drm_amdgpu_bo_list_in))
 				goto free_partial_kdata;
-			}
 
-			ret = amdgpu_cs_bo_handles_chunk(p, p->chunks[i].kdata);
+			ret = amdgpu_cs_p1_bo_handles(p, p->chunks[i].kdata);
 			if (ret)
 				goto free_partial_kdata;
-
 			break;
 
 		case AMDGPU_CHUNK_ID_DEPENDENCIES:
@@ -221,7 +261,6 @@ static int amdgpu_cs_parser_init(struct amdgpu_cs_parser *p, union drm_amdgpu_cs
 			break;
 
 		default:
-			ret = -EINVAL;
 			goto free_partial_kdata;
 		}
 	}
@@ -230,6 +269,10 @@ static int amdgpu_cs_parser_init(struct amdgpu_cs_parser *p, union drm_amdgpu_cs
 	if (ret)
 		goto free_all_kdata;
 
+	ret = drm_sched_job_init(&p->job->base, p->entity, &fpriv->vm);
+	if (ret)
+		goto free_all_kdata;
+
 	if (p->ctx->vram_lost_counter != p->job->vram_lost_counter) {
 		ret = -ECANCELED;
 		goto free_all_kdata;
@@ -258,166 +301,456 @@ static int amdgpu_cs_parser_init(struct amdgpu_cs_parser *p, union drm_amdgpu_cs
 	return ret;
 }
 
-/* Convert microseconds to bytes. */
-static u64 us_to_bytes(struct amdgpu_device *adev, s64 us)
+static int amdgpu_cs_p2_ib(struct amdgpu_cs_parser *p,
+			   struct amdgpu_cs_chunk *chunk,
+			   unsigned int *num_ibs,
+			   unsigned int *ce_preempt,
+			   unsigned int *de_preempt)
 {
-	if (us <= 0 || !adev->mm_stats.log2_max_MBps)
-		return 0;
+	struct amdgpu_ring *ring = to_amdgpu_ring(p->job->base.sched);
+	struct drm_amdgpu_cs_chunk_ib *chunk_ib = chunk->kdata;
+	struct amdgpu_fpriv *fpriv = p->filp->driver_priv;
+	struct amdgpu_ib *ib = &p->job->ibs[*num_ibs];
+	struct amdgpu_vm *vm = &fpriv->vm;
+	int r;
 
-	/* Since accum_us is incremented by a million per second, just
-	 * multiply it by the number of MB/s to get the number of bytes.
-	 */
-	return us << adev->mm_stats.log2_max_MBps;
-}
 
-static s64 bytes_to_us(struct amdgpu_device *adev, u64 bytes)
-{
-	if (!adev->mm_stats.log2_max_MBps)
-		return 0;
+	/* MM engine doesn't support user fences */
+	if (p->job->uf_addr && ring->funcs->no_user_fence)
+		return -EINVAL;
 
-	return bytes >> adev->mm_stats.log2_max_MBps;
-}
+	if (chunk_ib->ip_type == AMDGPU_HW_IP_GFX &&
+	    chunk_ib->flags & AMDGPU_IB_FLAG_PREEMPT &&
+	    (amdgpu_mcbp || amdgpu_sriov_vf(p->adev))) {
+		if (chunk_ib->flags & AMDGPU_IB_FLAG_CE)
+			(*ce_preempt)++;
+		else
+			(*de_preempt)++;
 
-/* Returns how many bytes TTM can move right now. If no bytes can be moved,
- * it returns 0. If it returns non-zero, it's OK to move at least one buffer,
- * which means it can go over the threshold once. If that happens, the driver
- * will be in debt and no other buffer migrations can be done until that debt
- * is repaid.
- *
- * This approach allows moving a buffer of any size (it's important to allow
- * that).
- *
- * The currency is simply time in microseconds and it increases as the clock
- * ticks. The accumulated microseconds (us) are converted to bytes and
- * returned.
- */
-static void amdgpu_cs_get_threshold_for_moves(struct amdgpu_device *adev,
-					      u64 *max_bytes,
-					      u64 *max_vis_bytes)
-{
-	s64 time_us, increment_us;
-	u64 free_vram, total_vram, used_vram;
-	/* Allow a maximum of 200 accumulated ms. This is basically per-IB
-	 * throttling.
-	 *
-	 * It means that in order to get full max MBps, at least 5 IBs per
-	 * second must be submitted and not more than 200ms apart from each
-	 * other.
-	 */
-	const s64 us_upper_bound = 200000;
+		/* Each GFX command submit allows only 1 IB max
+		 * preemptible for CE & DE */
+		if (*ce_preempt > 1 || *de_preempt > 1)
+			return -EINVAL;
+	}
 
-	if (!adev->mm_stats.log2_max_MBps) {
-		*max_bytes = 0;
-		*max_vis_bytes = 0;
-		return;
+	if (chunk_ib->flags & AMDGPU_IB_FLAG_PREAMBLE)
+		p->job->preamble_status |= AMDGPU_PREAMBLE_IB_PRESENT;
+
+	r =  amdgpu_ib_get(p->adev, vm, ring->funcs->parse_cs ?
+			   chunk_ib->ib_bytes : 0,
+			   AMDGPU_IB_POOL_DELAYED, ib);
+	if (r) {
+		DRM_ERROR("Failed to get ib !\n");
+		return r;
 	}
 
-	total_vram = adev->gmc.real_vram_size - atomic64_read(&adev->vram_pin_size);
-	used_vram = ttm_resource_manager_usage(&adev->mman.vram_mgr.manager);
-	free_vram = used_vram >= total_vram ? 0 : total_vram - used_vram;
+	ib->gpu_addr = chunk_ib->va_start;
+	ib->length_dw = chunk_ib->ib_bytes / 4;
+	ib->flags = chunk_ib->flags;
 
-	spin_lock(&adev->mm_stats.lock);
+	(*num_ibs)++;
+	return 0;
+}
 
-	/* Increase the amount of accumulated us. */
-	time_us = ktime_to_us(ktime_get());
-	increment_us = time_us - adev->mm_stats.last_update_us;
-	adev->mm_stats.last_update_us = time_us;
-	adev->mm_stats.accum_us = min(adev->mm_stats.accum_us + increment_us,
-				      us_upper_bound);
+static int amdgpu_cs_p2_dependencies(struct amdgpu_cs_parser *p,
+				     struct amdgpu_cs_chunk *chunk)
+{
+	struct drm_amdgpu_cs_chunk_dep *deps = chunk->kdata;
+	struct amdgpu_fpriv *fpriv = p->filp->driver_priv;
+	unsigned num_deps;
+	int i, r;
 
-	/* This prevents the short period of low performance when the VRAM
-	 * usage is low and the driver is in debt or doesn't have enough
-	 * accumulated us to fill VRAM quickly.
-	 *
-	 * The situation can occur in these cases:
-	 * - a lot of VRAM is freed by userspace
-	 * - the presence of a big buffer causes a lot of evictions
-	 *   (solution: split buffers into smaller ones)
-	 *
-	 * If 128 MB or 1/8th of VRAM is free, start filling it now by setting
-	 * accum_us to a positive number.
-	 */
-	if (free_vram >= 128 * 1024 * 1024 || free_vram >= total_vram / 8) {
-		s64 min_us;
+	num_deps = chunk->length_dw * 4 /
+		sizeof(struct drm_amdgpu_cs_chunk_dep);
 
-		/* Be more aggresive on dGPUs. Try to fill a portion of free
-		 * VRAM now.
-		 */
-		if (!(adev->flags & AMD_IS_APU))
-			min_us = bytes_to_us(adev, free_vram / 4);
-		else
-			min_us = 0; /* Reset accum_us on APUs. */
+	for (i = 0; i < num_deps; ++i) {
+		struct amdgpu_ctx *ctx;
+		struct drm_sched_entity *entity;
+		struct dma_fence *fence;
 
-		adev->mm_stats.accum_us = max(min_us, adev->mm_stats.accum_us);
-	}
+		ctx = amdgpu_ctx_get(fpriv, deps[i].ctx_id);
+		if (ctx == NULL)
+			return -EINVAL;
 
-	/* This is set to 0 if the driver is in debt to disallow (optional)
-	 * buffer moves.
-	 */
-	*max_bytes = us_to_bytes(adev, adev->mm_stats.accum_us);
+		r = amdgpu_ctx_get_entity(ctx, deps[i].ip_type,
+					  deps[i].ip_instance,
+					  deps[i].ring, &entity);
+		if (r) {
+			amdgpu_ctx_put(ctx);
+			return r;
+		}
 
-	/* Do the same for visible VRAM if half of it is free */
-	if (!amdgpu_gmc_vram_full_visible(&adev->gmc)) {
-		u64 total_vis_vram = adev->gmc.visible_vram_size;
-		u64 used_vis_vram =
-		  amdgpu_vram_mgr_vis_usage(&adev->mman.vram_mgr);
+		fence = amdgpu_ctx_get_fence(ctx, entity, deps[i].handle);
+		amdgpu_ctx_put(ctx);
 
-		if (used_vis_vram < total_vis_vram) {
-			u64 free_vis_vram = total_vis_vram - used_vis_vram;
-			adev->mm_stats.accum_us_vis = min(adev->mm_stats.accum_us_vis +
-							  increment_us, us_upper_bound);
+		if (IS_ERR(fence))
+			return PTR_ERR(fence);
+		else if (!fence)
+			continue;
 
-			if (free_vis_vram >= total_vis_vram / 2)
-				adev->mm_stats.accum_us_vis =
-					max(bytes_to_us(adev, free_vis_vram / 2),
-					    adev->mm_stats.accum_us_vis);
+		if (chunk->chunk_id == AMDGPU_CHUNK_ID_SCHEDULED_DEPENDENCIES) {
+			struct drm_sched_fence *s_fence;
+			struct dma_fence *old = fence;
+
+			s_fence = to_drm_sched_fence(fence);
+			fence = dma_fence_get(&s_fence->scheduled);
+			dma_fence_put(old);
 		}
 
-		*max_vis_bytes = us_to_bytes(adev, adev->mm_stats.accum_us_vis);
-	} else {
-		*max_vis_bytes = 0;
+		r = amdgpu_sync_fence(&p->job->sync, fence);
+		dma_fence_put(fence);
+		if (r)
+			return r;
 	}
-
-	spin_unlock(&adev->mm_stats.lock);
+	return 0;
 }
 
-/* Report how many bytes have really been moved for the last command
- * submission. This can result in a debt that can stop buffer migrations
- * temporarily.
- */
-void amdgpu_cs_report_moved_bytes(struct amdgpu_device *adev, u64 num_bytes,
-				  u64 num_vis_bytes)
+static int amdgpu_syncobj_lookup_and_add(struct amdgpu_cs_parser *p,
+					 uint32_t handle, u64 point,
+					 u64 flags)
 {
-	spin_lock(&adev->mm_stats.lock);
-	adev->mm_stats.accum_us -= bytes_to_us(adev, num_bytes);
-	adev->mm_stats.accum_us_vis -= bytes_to_us(adev, num_vis_bytes);
-	spin_unlock(&adev->mm_stats.lock);
+	struct dma_fence *fence;
+	int r;
+
+	r = drm_syncobj_find_fence(p->filp, handle, point, flags, &fence);
+	if (r) {
+		DRM_ERROR("syncobj %u failed to find fence @ %llu (%d)!\n",
+			  handle, point, r);
+		return r;
+	}
+
+	r = amdgpu_sync_fence(&p->job->sync, fence);
+	dma_fence_put(fence);
+
+	return r;
 }
 
-static int amdgpu_cs_bo_validate(void *param, struct amdgpu_bo *bo)
+static int amdgpu_cs_p2_syncobj_in(struct amdgpu_cs_parser *p,
+				   struct amdgpu_cs_chunk *chunk)
 {
-	struct amdgpu_device *adev = amdgpu_ttm_adev(bo->tbo.bdev);
-	struct amdgpu_cs_parser *p = param;
-	struct ttm_operation_ctx ctx = {
-		.interruptible = true,
-		.no_wait_gpu = false,
-		.resv = bo->tbo.base.resv
-	};
-	uint32_t domain;
-	int r;
+	struct drm_amdgpu_cs_chunk_sem *deps = chunk->kdata;
+	unsigned num_deps;
+	int i, r;
 
-	if (bo->tbo.pin_count)
-		return 0;
+	num_deps = chunk->length_dw * 4 /
+		sizeof(struct drm_amdgpu_cs_chunk_sem);
+	for (i = 0; i < num_deps; ++i) {
+		r = amdgpu_syncobj_lookup_and_add(p, deps[i].handle, 0, 0);
+		if (r)
+			return r;
+	}
 
-	/* Don't move this buffer if we have depleted our allowance
-	 * to move it. Don't move anything if the threshold is zero.
-	 */
-	if (p->bytes_moved < p->bytes_moved_threshold &&
-	    (!bo->tbo.base.dma_buf ||
-	    list_empty(&bo->tbo.base.dma_buf->attachments))) {
-		if (!amdgpu_gmc_vram_full_visible(&adev->gmc) &&
-		    (bo->flags & AMDGPU_GEM_CREATE_CPU_ACCESS_REQUIRED)) {
-			/* And don't move a CPU_ACCESS_REQUIRED BO to limited
+	return 0;
+}
+
+static int amdgpu_cs_p2_syncobj_timeline_wait(struct amdgpu_cs_parser *p,
+					      struct amdgpu_cs_chunk *chunk)
+{
+	struct drm_amdgpu_cs_chunk_syncobj *syncobj_deps = chunk->kdata;
+	unsigned num_deps;
+	int i, r;
+
+	num_deps = chunk->length_dw * 4 /
+		sizeof(struct drm_amdgpu_cs_chunk_syncobj);
+	for (i = 0; i < num_deps; ++i) {
+		r = amdgpu_syncobj_lookup_and_add(p, syncobj_deps[i].handle,
+						  syncobj_deps[i].point,
+						  syncobj_deps[i].flags);
+		if (r)
+			return r;
+	}
+
+	return 0;
+}
+
+static int amdgpu_cs_p2_syncobj_out(struct amdgpu_cs_parser *p,
+				    struct amdgpu_cs_chunk *chunk)
+{
+	struct drm_amdgpu_cs_chunk_sem *deps = chunk->kdata;
+	unsigned num_deps;
+	int i;
+
+	num_deps = chunk->length_dw * 4 /
+		sizeof(struct drm_amdgpu_cs_chunk_sem);
+
+	if (p->post_deps)
+		return -EINVAL;
+
+	p->post_deps = kmalloc_array(num_deps, sizeof(*p->post_deps),
+				     GFP_KERNEL);
+	p->num_post_deps = 0;
+
+	if (!p->post_deps)
+		return -ENOMEM;
+
+
+	for (i = 0; i < num_deps; ++i) {
+		p->post_deps[i].syncobj =
+			drm_syncobj_find(p->filp, deps[i].handle);
+		if (!p->post_deps[i].syncobj)
+			return -EINVAL;
+		p->post_deps[i].chain = NULL;
+		p->post_deps[i].point = 0;
+		p->num_post_deps++;
+	}
+
+	return 0;
+}
+
+static int amdgpu_cs_p2_syncobj_timeline_signal(struct amdgpu_cs_parser *p,
+						struct amdgpu_cs_chunk *chunk)
+{
+	struct drm_amdgpu_cs_chunk_syncobj *syncobj_deps = chunk->kdata;
+	unsigned num_deps;
+	int i;
+
+	num_deps = chunk->length_dw * 4 /
+		sizeof(struct drm_amdgpu_cs_chunk_syncobj);
+
+	if (p->post_deps)
+		return -EINVAL;
+
+	p->post_deps = kmalloc_array(num_deps, sizeof(*p->post_deps),
+				     GFP_KERNEL);
+	p->num_post_deps = 0;
+
+	if (!p->post_deps)
+		return -ENOMEM;
+
+	for (i = 0; i < num_deps; ++i) {
+		struct amdgpu_cs_post_dep *dep = &p->post_deps[i];
+
+		dep->chain = NULL;
+		if (syncobj_deps[i].point) {
+			dep->chain = dma_fence_chain_alloc();
+			if (!dep->chain)
+				return -ENOMEM;
+		}
+
+		dep->syncobj = drm_syncobj_find(p->filp,
+						syncobj_deps[i].handle);
+		if (!dep->syncobj) {
+			dma_fence_chain_free(dep->chain);
+			return -EINVAL;
+		}
+		dep->point = syncobj_deps[i].point;
+		p->num_post_deps++;
+	}
+
+	return 0;
+}
+
+static int amdgpu_cs_pass2(struct amdgpu_cs_parser *p)
+{
+	unsigned int num_ibs = 0, ce_preempt = 0, de_preempt = 0;
+	int i, r;
+
+	for (i = 0; i < p->nchunks; ++i) {
+		struct amdgpu_cs_chunk *chunk;
+
+		chunk = &p->chunks[i];
+
+		switch (chunk->chunk_id) {
+		case AMDGPU_CHUNK_ID_IB:
+			r = amdgpu_cs_p2_ib(p, chunk, &num_ibs,
+					    &ce_preempt, &de_preempt);
+			if (r)
+				return r;
+			break;
+		case AMDGPU_CHUNK_ID_DEPENDENCIES:
+		case AMDGPU_CHUNK_ID_SCHEDULED_DEPENDENCIES:
+			r = amdgpu_cs_p2_dependencies(p, chunk);
+			if (r)
+				return r;
+			break;
+		case AMDGPU_CHUNK_ID_SYNCOBJ_IN:
+			r = amdgpu_cs_p2_syncobj_in(p, chunk);
+			if (r)
+				return r;
+			break;
+		case AMDGPU_CHUNK_ID_SYNCOBJ_OUT:
+			r = amdgpu_cs_p2_syncobj_out(p, chunk);
+			if (r)
+				return r;
+			break;
+		case AMDGPU_CHUNK_ID_SYNCOBJ_TIMELINE_WAIT:
+			r = amdgpu_cs_p2_syncobj_timeline_wait(p, chunk);
+			if (r)
+				return r;
+			break;
+		case AMDGPU_CHUNK_ID_SYNCOBJ_TIMELINE_SIGNAL:
+			r = amdgpu_cs_p2_syncobj_timeline_signal(p, chunk);
+			if (r)
+				return r;
+			break;
+		}
+	}
+
+	return 0;
+}
+
+/* Convert microseconds to bytes. */
+static u64 us_to_bytes(struct amdgpu_device *adev, s64 us)
+{
+	if (us <= 0 || !adev->mm_stats.log2_max_MBps)
+		return 0;
+
+	/* Since accum_us is incremented by a million per second, just
+	 * multiply it by the number of MB/s to get the number of bytes.
+	 */
+	return us << adev->mm_stats.log2_max_MBps;
+}
+
+static s64 bytes_to_us(struct amdgpu_device *adev, u64 bytes)
+{
+	if (!adev->mm_stats.log2_max_MBps)
+		return 0;
+
+	return bytes >> adev->mm_stats.log2_max_MBps;
+}
+
+/* Returns how many bytes TTM can move right now. If no bytes can be moved,
+ * it returns 0. If it returns non-zero, it's OK to move at least one buffer,
+ * which means it can go over the threshold once. If that happens, the driver
+ * will be in debt and no other buffer migrations can be done until that debt
+ * is repaid.
+ *
+ * This approach allows moving a buffer of any size (it's important to allow
+ * that).
+ *
+ * The currency is simply time in microseconds and it increases as the clock
+ * ticks. The accumulated microseconds (us) are converted to bytes and
+ * returned.
+ */
+static void amdgpu_cs_get_threshold_for_moves(struct amdgpu_device *adev,
+					      u64 *max_bytes,
+					      u64 *max_vis_bytes)
+{
+	s64 time_us, increment_us;
+	u64 free_vram, total_vram, used_vram;
+	/* Allow a maximum of 200 accumulated ms. This is basically per-IB
+	 * throttling.
+	 *
+	 * It means that in order to get full max MBps, at least 5 IBs per
+	 * second must be submitted and not more than 200ms apart from each
+	 * other.
+	 */
+	const s64 us_upper_bound = 200000;
+
+	if (!adev->mm_stats.log2_max_MBps) {
+		*max_bytes = 0;
+		*max_vis_bytes = 0;
+		return;
+	}
+
+	total_vram = adev->gmc.real_vram_size -
+		atomic64_read(&adev->vram_pin_size);
+	used_vram = ttm_resource_manager_usage(&adev->mman.vram_mgr.manager);
+	free_vram = used_vram >= total_vram ? 0 : total_vram - used_vram;
+
+	spin_lock(&adev->mm_stats.lock);
+
+	/* Increase the amount of accumulated us. */
+	time_us = ktime_to_us(ktime_get());
+	increment_us = time_us - adev->mm_stats.last_update_us;
+	adev->mm_stats.last_update_us = time_us;
+	adev->mm_stats.accum_us = min(adev->mm_stats.accum_us + increment_us,
+				      us_upper_bound);
+
+	/* This prevents the short period of low performance when the VRAM
+	 * usage is low and the driver is in debt or doesn't have enough
+	 * accumulated us to fill VRAM quickly.
+	 *
+	 * The situation can occur in these cases:
+	 * - a lot of VRAM is freed by userspace
+	 * - the presence of a big buffer causes a lot of evictions
+	 *   (solution: split buffers into smaller ones)
+	 *
+	 * If 128 MB or 1/8th of VRAM is free, start filling it now by setting
+	 * accum_us to a positive number.
+	 */
+	if (free_vram >= 128 * 1024 * 1024 || free_vram >= total_vram / 8) {
+		s64 min_us;
+
+		/* Be more aggresive on dGPUs. Try to fill a portion of free
+		 * VRAM now.
+		 */
+		if (!(adev->flags & AMD_IS_APU))
+			min_us = bytes_to_us(adev, free_vram / 4);
+		else
+			min_us = 0; /* Reset accum_us on APUs. */
+
+		adev->mm_stats.accum_us = max(min_us, adev->mm_stats.accum_us);
+	}
+
+	/* This is set to 0 if the driver is in debt to disallow (optional)
+	 * buffer moves.
+	 */
+	*max_bytes = us_to_bytes(adev, adev->mm_stats.accum_us);
+
+	/* Do the same for visible VRAM if half of it is free */
+	if (!amdgpu_gmc_vram_full_visible(&adev->gmc)) {
+		u64 total_vis_vram = adev->gmc.visible_vram_size;
+		u64 used_vis_vram =
+		  amdgpu_vram_mgr_vis_usage(&adev->mman.vram_mgr);
+
+		if (used_vis_vram < total_vis_vram) {
+			u64 free_vis_vram = total_vis_vram - used_vis_vram;
+			adev->mm_stats.accum_us_vis =
+				min(adev->mm_stats.accum_us_vis +
+				    increment_us, us_upper_bound);
+
+			if (free_vis_vram >= total_vis_vram / 2)
+				adev->mm_stats.accum_us_vis =
+					max(bytes_to_us(adev, free_vis_vram / 2),
+					    adev->mm_stats.accum_us_vis);
+		}
+
+		*max_vis_bytes = us_to_bytes(adev, adev->mm_stats.accum_us_vis);
+	} else {
+		*max_vis_bytes = 0;
+	}
+
+	spin_unlock(&adev->mm_stats.lock);
+}
+
+/* Report how many bytes have really been moved for the last command
+ * submission. This can result in a debt that can stop buffer migrations
+ * temporarily.
+ */
+void amdgpu_cs_report_moved_bytes(struct amdgpu_device *adev, u64 num_bytes,
+				  u64 num_vis_bytes)
+{
+	spin_lock(&adev->mm_stats.lock);
+	adev->mm_stats.accum_us -= bytes_to_us(adev, num_bytes);
+	adev->mm_stats.accum_us_vis -= bytes_to_us(adev, num_vis_bytes);
+	spin_unlock(&adev->mm_stats.lock);
+}
+
+static int amdgpu_cs_bo_validate(void *param, struct amdgpu_bo *bo)
+{
+	struct amdgpu_device *adev = amdgpu_ttm_adev(bo->tbo.bdev);
+	struct amdgpu_cs_parser *p = param;
+	struct ttm_operation_ctx ctx = {
+		.interruptible = true,
+		.no_wait_gpu = false,
+		.resv = bo->tbo.base.resv
+	};
+	uint32_t domain;
+	int r;
+
+	if (bo->tbo.pin_count)
+		return 0;
+
+	/* Don't move this buffer if we have depleted our allowance
+	 * to move it. Don't move anything if the threshold is zero.
+	 */
+	if (p->bytes_moved < p->bytes_moved_threshold &&
+	    (!bo->tbo.base.dma_buf ||
+	    list_empty(&bo->tbo.base.dma_buf->attachments))) {
+		if (!amdgpu_gmc_vram_full_visible(&adev->gmc) &&
+		    (bo->flags & AMDGPU_GEM_CREATE_CPU_ACCESS_REQUIRED)) {
+			/* And don't move a CPU_ACCESS_REQUIRED BO to limited
 			 * visible VRAM if we've depleted our allowance to do
 			 * that.
 			 */
@@ -640,537 +973,173 @@ static int amdgpu_cs_parser_bos(struct amdgpu_cs_parser *p,
 	return r;
 }
 
-static int amdgpu_cs_sync_rings(struct amdgpu_cs_parser *p)
-{
-	struct amdgpu_fpriv *fpriv = p->filp->driver_priv;
-	struct amdgpu_bo_list_entry *e;
-	int r;
-
-	list_for_each_entry(e, &p->validated, tv.head) {
-		struct amdgpu_bo *bo = ttm_to_amdgpu_bo(e->tv.bo);
-		struct dma_resv *resv = bo->tbo.base.resv;
-		enum amdgpu_sync_mode sync_mode;
-
-		sync_mode = amdgpu_bo_explicit_sync(bo) ?
-			AMDGPU_SYNC_EXPLICIT : AMDGPU_SYNC_NE_OWNER;
-		r = amdgpu_sync_resv(p->adev, &p->job->sync, resv, sync_mode,
-				     &fpriv->vm);
-		if (r)
-			return r;
-	}
-	return 0;
-}
-
-/**
- * amdgpu_cs_parser_fini() - clean parser states
- * @parser:	parser structure holding parsing context.
- * @error:	error number
- * @backoff:	indicator to backoff the reservation
- *
- * If error is set then unvalidate buffer, otherwise just free memory
- * used by parsing context.
- **/
-static void amdgpu_cs_parser_fini(struct amdgpu_cs_parser *parser, int error,
-				  bool backoff)
-{
-	unsigned i;
-
-	if (error && backoff)
-		ttm_eu_backoff_reservation(&parser->ticket,
-					   &parser->validated);
-
-	for (i = 0; i < parser->num_post_deps; i++) {
-		drm_syncobj_put(parser->post_deps[i].syncobj);
-		kfree(parser->post_deps[i].chain);
-	}
-	kfree(parser->post_deps);
-
-	dma_fence_put(parser->fence);
-
-	if (parser->ctx) {
-		amdgpu_ctx_put(parser->ctx);
-	}
-	if (parser->bo_list)
-		amdgpu_bo_list_put(parser->bo_list);
-
-	for (i = 0; i < parser->nchunks; i++)
-		kvfree(parser->chunks[i].kdata);
-	kvfree(parser->chunks);
-	if (parser->job)
-		amdgpu_job_free(parser->job);
-	if (parser->uf_entry.tv.bo) {
-		struct amdgpu_bo *uf = ttm_to_amdgpu_bo(parser->uf_entry.tv.bo);
-
-		amdgpu_bo_unref(&uf);
-	}
-}
-
-static int amdgpu_cs_vm_handling(struct amdgpu_cs_parser *p)
-{
-	struct amdgpu_ring *ring = to_amdgpu_ring(p->entity->rq->sched);
-	struct amdgpu_fpriv *fpriv = p->filp->driver_priv;
-	struct amdgpu_device *adev = p->adev;
-	struct amdgpu_vm *vm = &fpriv->vm;
-	struct amdgpu_bo_list_entry *e;
-	struct amdgpu_bo_va *bo_va;
-	struct amdgpu_bo *bo;
-	int r;
-
-	/* Only for UVD/VCE VM emulation */
-	if (ring->funcs->parse_cs || ring->funcs->patch_cs_in_place) {
-		unsigned i, j;
-
-		for (i = 0, j = 0; i < p->nchunks && j < p->job->num_ibs; i++) {
-			struct drm_amdgpu_cs_chunk_ib *chunk_ib;
-			struct amdgpu_bo_va_mapping *m;
-			struct amdgpu_bo *aobj = NULL;
-			struct amdgpu_cs_chunk *chunk;
-			uint64_t offset, va_start;
-			struct amdgpu_ib *ib;
-			uint8_t *kptr;
-
-			chunk = &p->chunks[i];
-			ib = &p->job->ibs[j];
-			chunk_ib = chunk->kdata;
-
-			if (chunk->chunk_id != AMDGPU_CHUNK_ID_IB)
-				continue;
-
-			va_start = chunk_ib->va_start & AMDGPU_GMC_HOLE_MASK;
-			r = amdgpu_cs_find_mapping(p, va_start, &aobj, &m);
-			if (r) {
-				DRM_ERROR("IB va_start is invalid\n");
-				return r;
-			}
-
-			if ((va_start + chunk_ib->ib_bytes) >
-			    (m->last + 1) * AMDGPU_GPU_PAGE_SIZE) {
-				DRM_ERROR("IB va_start+ib_bytes is invalid\n");
-				return -EINVAL;
-			}
-
-			/* the IB should be reserved at this point */
-			r = amdgpu_bo_kmap(aobj, (void **)&kptr);
-			if (r) {
-				return r;
-			}
-
-			offset = m->start * AMDGPU_GPU_PAGE_SIZE;
-			kptr += va_start - offset;
-
-			if (ring->funcs->parse_cs) {
-				memcpy(ib->ptr, kptr, chunk_ib->ib_bytes);
-				amdgpu_bo_kunmap(aobj);
-
-				r = amdgpu_ring_parse_cs(ring, p, j);
-				if (r)
-					return r;
-			} else {
-				ib->ptr = (uint32_t *)kptr;
-				r = amdgpu_ring_patch_cs_in_place(ring, p, j);
-				amdgpu_bo_kunmap(aobj);
-				if (r)
-					return r;
-			}
-
-			j++;
-		}
-	}
-
-	if (!p->job->vm)
-		return amdgpu_cs_sync_rings(p);
-
-
-	r = amdgpu_vm_clear_freed(adev, vm, NULL);
-	if (r)
-		return r;
-
-	r = amdgpu_vm_bo_update(adev, fpriv->prt_va, false, NULL);
-	if (r)
-		return r;
-
-	r = amdgpu_sync_vm_fence(&p->job->sync, fpriv->prt_va->last_pt_update);
-	if (r)
-		return r;
-
-	if (amdgpu_mcbp || amdgpu_sriov_vf(adev)) {
-		bo_va = fpriv->csa_va;
-		BUG_ON(!bo_va);
-		r = amdgpu_vm_bo_update(adev, bo_va, false, NULL);
-		if (r)
-			return r;
-
-		r = amdgpu_sync_vm_fence(&p->job->sync, bo_va->last_pt_update);
-		if (r)
-			return r;
-	}
-
-	amdgpu_bo_list_for_each_entry(e, p->bo_list) {
-		/* ignore duplicates */
-		bo = ttm_to_amdgpu_bo(e->tv.bo);
-		if (!bo)
-			continue;
-
-		bo_va = e->bo_va;
-		if (bo_va == NULL)
-			continue;
-
-		r = amdgpu_vm_bo_update(adev, bo_va, false, NULL);
-		if (r)
-			return r;
-
-		r = amdgpu_sync_vm_fence(&p->job->sync, bo_va->last_pt_update);
-		if (r)
-			return r;
-	}
-
-	r = amdgpu_vm_handle_moved(adev, vm);
-	if (r)
-		return r;
-
-	r = amdgpu_vm_update_pdes(adev, vm, false);
-	if (r)
-		return r;
-
-	r = amdgpu_sync_vm_fence(&p->job->sync, vm->last_update);
-	if (r)
-		return r;
-
-	p->job->vm_pd_addr = amdgpu_gmc_pd_addr(vm->root.bo);
-
-	if (amdgpu_vm_debug) {
-		/* Invalidate all BOs to test for userspace bugs */
-		amdgpu_bo_list_for_each_entry(e, p->bo_list) {
-			struct amdgpu_bo *bo = ttm_to_amdgpu_bo(e->tv.bo);
-
-			/* ignore duplicates */
-			if (!bo)
-				continue;
-
-			amdgpu_vm_bo_invalidate(adev, bo, false);
-		}
-	}
-
-	return amdgpu_cs_sync_rings(p);
-}
-
-static int amdgpu_cs_ib_fill(struct amdgpu_device *adev,
-			     struct amdgpu_cs_parser *parser)
-{
-	struct amdgpu_fpriv *fpriv = parser->filp->driver_priv;
-	struct amdgpu_vm *vm = &fpriv->vm;
-	int r, ce_preempt = 0, de_preempt = 0;
-	struct amdgpu_ring *ring;
-	int i, j;
-
-	for (i = 0, j = 0; i < parser->nchunks && j < parser->job->num_ibs; i++) {
-		struct amdgpu_cs_chunk *chunk;
-		struct amdgpu_ib *ib;
-		struct drm_amdgpu_cs_chunk_ib *chunk_ib;
-		struct drm_sched_entity *entity;
-
-		chunk = &parser->chunks[i];
-		ib = &parser->job->ibs[j];
-		chunk_ib = (struct drm_amdgpu_cs_chunk_ib *)chunk->kdata;
-
-		if (chunk->chunk_id != AMDGPU_CHUNK_ID_IB)
-			continue;
-
-		if (chunk_ib->ip_type == AMDGPU_HW_IP_GFX &&
-		    (amdgpu_mcbp || amdgpu_sriov_vf(adev))) {
-			if (chunk_ib->flags & AMDGPU_IB_FLAG_PREEMPT) {
-				if (chunk_ib->flags & AMDGPU_IB_FLAG_CE)
-					ce_preempt++;
-				else
-					de_preempt++;
-			}
-
-			/* each GFX command submit allows 0 or 1 IB preemptible for CE & DE */
-			if (ce_preempt > 1 || de_preempt > 1)
-				return -EINVAL;
-		}
-
-		r = amdgpu_ctx_get_entity(parser->ctx, chunk_ib->ip_type,
-					  chunk_ib->ip_instance, chunk_ib->ring,
-					  &entity);
-		if (r)
-			return r;
-
-		if (chunk_ib->flags & AMDGPU_IB_FLAG_PREAMBLE)
-			parser->job->preamble_status |=
-				AMDGPU_PREAMBLE_IB_PRESENT;
-
-		if (parser->entity && parser->entity != entity)
-			return -EINVAL;
-
-		/* Return if there is no run queue associated with this entity.
-		 * Possibly because of disabled HW IP*/
-		if (entity->rq == NULL)
-			return -EINVAL;
-
-		parser->entity = entity;
-
-		ring = to_amdgpu_ring(entity->rq->sched);
-		r =  amdgpu_ib_get(adev, vm, ring->funcs->parse_cs ?
-				   chunk_ib->ib_bytes : 0,
-				   AMDGPU_IB_POOL_DELAYED, ib);
-		if (r) {
-			DRM_ERROR("Failed to get ib !\n");
-			return r;
-		}
-
-		ib->gpu_addr = chunk_ib->va_start;
-		ib->length_dw = chunk_ib->ib_bytes / 4;
-		ib->flags = chunk_ib->flags;
-
-		j++;
-	}
-
-	/* MM engine doesn't support user fences */
-	ring = to_amdgpu_ring(parser->entity->rq->sched);
-	if (parser->job->uf_addr && ring->funcs->no_user_fence)
-		return -EINVAL;
-
-	return 0;
-}
-
-static int amdgpu_cs_process_fence_dep(struct amdgpu_cs_parser *p,
-				       struct amdgpu_cs_chunk *chunk)
-{
-	struct amdgpu_fpriv *fpriv = p->filp->driver_priv;
-	unsigned num_deps;
-	int i, r;
-	struct drm_amdgpu_cs_chunk_dep *deps;
-
-	deps = (struct drm_amdgpu_cs_chunk_dep *)chunk->kdata;
-	num_deps = chunk->length_dw * 4 /
-		sizeof(struct drm_amdgpu_cs_chunk_dep);
-
-	for (i = 0; i < num_deps; ++i) {
-		struct amdgpu_ctx *ctx;
-		struct drm_sched_entity *entity;
-		struct dma_fence *fence;
-
-		ctx = amdgpu_ctx_get(fpriv, deps[i].ctx_id);
-		if (ctx == NULL)
-			return -EINVAL;
-
-		r = amdgpu_ctx_get_entity(ctx, deps[i].ip_type,
-					  deps[i].ip_instance,
-					  deps[i].ring, &entity);
-		if (r) {
-			amdgpu_ctx_put(ctx);
-			return r;
-		}
-
-		fence = amdgpu_ctx_get_fence(ctx, entity, deps[i].handle);
-		amdgpu_ctx_put(ctx);
-
-		if (IS_ERR(fence))
-			return PTR_ERR(fence);
-		else if (!fence)
-			continue;
-
-		if (chunk->chunk_id == AMDGPU_CHUNK_ID_SCHEDULED_DEPENDENCIES) {
-			struct drm_sched_fence *s_fence;
-			struct dma_fence *old = fence;
-
-			s_fence = to_drm_sched_fence(fence);
-			fence = dma_fence_get(&s_fence->scheduled);
-			dma_fence_put(old);
-		}
-
-		r = amdgpu_sync_fence(&p->job->sync, fence);
-		dma_fence_put(fence);
-		if (r)
-			return r;
-	}
-	return 0;
-}
-
-static int amdgpu_syncobj_lookup_and_add_to_sync(struct amdgpu_cs_parser *p,
-						 uint32_t handle, u64 point,
-						 u64 flags)
+static void trace_amdgpu_cs_ibs(struct amdgpu_cs_parser *parser)
 {
-	struct dma_fence *fence;
-	int r;
-
-	r = drm_syncobj_find_fence(p->filp, handle, point, flags, &fence);
-	if (r) {
-		DRM_ERROR("syncobj %u failed to find fence @ %llu (%d)!\n",
-			  handle, point, r);
-		return r;
-	}
+	int i;
 
-	r = amdgpu_sync_fence(&p->job->sync, fence);
-	dma_fence_put(fence);
+	if (!trace_amdgpu_cs_enabled())
+		return;
 
-	return r;
+	for (i = 0; i < parser->job->num_ibs; i++)
+		trace_amdgpu_cs(parser, i);
 }
 
-static int amdgpu_cs_process_syncobj_in_dep(struct amdgpu_cs_parser *p,
-					    struct amdgpu_cs_chunk *chunk)
+static int amdgpu_cs_patch_ibs(struct amdgpu_cs_parser *p)
 {
-	struct drm_amdgpu_cs_chunk_sem *deps;
-	unsigned num_deps;
-	int i, r;
+	struct amdgpu_job *job = p->job;
+	struct amdgpu_ring *ring = to_amdgpu_ring(job->base.sched);
+	unsigned int i;
+	int r;
 
-	deps = (struct drm_amdgpu_cs_chunk_sem *)chunk->kdata;
-	num_deps = chunk->length_dw * 4 /
-		sizeof(struct drm_amdgpu_cs_chunk_sem);
-	for (i = 0; i < num_deps; ++i) {
-		r = amdgpu_syncobj_lookup_and_add_to_sync(p, deps[i].handle,
-							  0, 0);
-		if (r)
-			return r;
-	}
+	/* Only for UVD/VCE VM emulation */
+	if (!ring->funcs->parse_cs && !ring->funcs->patch_cs_in_place)
+		return 0;
 
-	return 0;
-}
+	for (i = 0; i < job->num_ibs; ++i) {
+		struct amdgpu_bo_va_mapping *m;
+		struct amdgpu_bo *aobj;
+		struct amdgpu_ib *ib;
+		uint64_t va_start;
+		uint8_t *kptr;
 
+		va_start = job->ibs[i].gpu_addr;
+		r = amdgpu_cs_find_mapping(p, va_start, &aobj, &m);
+		if (r) {
+			DRM_ERROR("IB va_start is invalid\n");
+			return r;
+		}
 
-static int amdgpu_cs_process_syncobj_timeline_in_dep(struct amdgpu_cs_parser *p,
-						     struct amdgpu_cs_chunk *chunk)
-{
-	struct drm_amdgpu_cs_chunk_syncobj *syncobj_deps;
-	unsigned num_deps;
-	int i, r;
+		if ((va_start + job->ibs[i].length_dw * 4) >
+		    (m->last + 1) * AMDGPU_GPU_PAGE_SIZE) {
+			DRM_ERROR("IB va_start+ib_bytes is invalid\n");
+			return -EINVAL;
+		}
 
-	syncobj_deps = (struct drm_amdgpu_cs_chunk_syncobj *)chunk->kdata;
-	num_deps = chunk->length_dw * 4 /
-		sizeof(struct drm_amdgpu_cs_chunk_syncobj);
-	for (i = 0; i < num_deps; ++i) {
-		r = amdgpu_syncobj_lookup_and_add_to_sync(p,
-							  syncobj_deps[i].handle,
-							  syncobj_deps[i].point,
-							  syncobj_deps[i].flags);
+		/* the IB should be reserved at this point */
+		r = amdgpu_bo_kmap(aobj, (void **)&kptr);
 		if (r)
 			return r;
+
+		kptr += va_start - (m->start * AMDGPU_GPU_PAGE_SIZE);
+		if (ring->funcs->parse_cs) {
+			memcpy(ib->ptr, kptr, job->ibs[i].length_dw * 4);
+			amdgpu_bo_kunmap(aobj);
+
+			r = amdgpu_ring_parse_cs(ring, p, i);
+			if (r)
+				return r;
+		} else {
+			ib->ptr = (uint32_t *)kptr;
+			r = amdgpu_ring_patch_cs_in_place(ring, p, i);
+			amdgpu_bo_kunmap(aobj);
+			if (r)
+				return r;
+		}
 	}
 
 	return 0;
 }
 
-static int amdgpu_cs_process_syncobj_out_dep(struct amdgpu_cs_parser *p,
-					     struct amdgpu_cs_chunk *chunk)
+static int amdgpu_cs_vm_handling(struct amdgpu_cs_parser *p)
 {
-	struct drm_amdgpu_cs_chunk_sem *deps;
-	unsigned num_deps;
-	int i;
-
-	deps = (struct drm_amdgpu_cs_chunk_sem *)chunk->kdata;
-	num_deps = chunk->length_dw * 4 /
-		sizeof(struct drm_amdgpu_cs_chunk_sem);
+	struct amdgpu_fpriv *fpriv = p->filp->driver_priv;
+	struct amdgpu_device *adev = p->adev;
+	struct amdgpu_vm *vm = &fpriv->vm;
+	struct amdgpu_bo_list_entry *e;
+	struct amdgpu_bo_va *bo_va;
+	struct amdgpu_bo *bo;
+	int r;
 
-	if (p->post_deps)
-		return -EINVAL;
+	r = amdgpu_vm_clear_freed(adev, vm, NULL);
+	if (r)
+		return r;
 
-	p->post_deps = kmalloc_array(num_deps, sizeof(*p->post_deps),
-				     GFP_KERNEL);
-	p->num_post_deps = 0;
+	r = amdgpu_vm_bo_update(adev, fpriv->prt_va, false, NULL);
+	if (r)
+		return r;
 
-	if (!p->post_deps)
-		return -ENOMEM;
+	r = amdgpu_sync_vm_fence(&p->job->sync, fpriv->prt_va->last_pt_update);
+	if (r)
+		return r;
 
+	if (amdgpu_mcbp || amdgpu_sriov_vf(adev)) {
+		bo_va = fpriv->csa_va;
+		r = amdgpu_vm_bo_update(adev, bo_va, false, NULL);
+		if (r)
+			return r;
 
-	for (i = 0; i < num_deps; ++i) {
-		p->post_deps[i].syncobj =
-			drm_syncobj_find(p->filp, deps[i].handle);
-		if (!p->post_deps[i].syncobj)
-			return -EINVAL;
-		p->post_deps[i].chain = NULL;
-		p->post_deps[i].point = 0;
-		p->num_post_deps++;
+		r = amdgpu_sync_vm_fence(&p->job->sync, bo_va->last_pt_update);
+		if (r)
+			return r;
 	}
 
-	return 0;
-}
+	amdgpu_bo_list_for_each_entry(e, p->bo_list) {
+		/* ignore duplicates */
+		bo = ttm_to_amdgpu_bo(e->tv.bo);
+		if (!bo)
+			continue;
 
+		bo_va = e->bo_va;
+		if (bo_va == NULL)
+			continue;
 
-static int amdgpu_cs_process_syncobj_timeline_out_dep(struct amdgpu_cs_parser *p,
-						      struct amdgpu_cs_chunk *chunk)
-{
-	struct drm_amdgpu_cs_chunk_syncobj *syncobj_deps;
-	unsigned num_deps;
-	int i;
+		r = amdgpu_vm_bo_update(adev, bo_va, false, NULL);
+		if (r)
+			return r;
 
-	syncobj_deps = (struct drm_amdgpu_cs_chunk_syncobj *)chunk->kdata;
-	num_deps = chunk->length_dw * 4 /
-		sizeof(struct drm_amdgpu_cs_chunk_syncobj);
+		r = amdgpu_sync_vm_fence(&p->job->sync, bo_va->last_pt_update);
+		if (r)
+			return r;
+	}
 
-	if (p->post_deps)
-		return -EINVAL;
+	r = amdgpu_vm_handle_moved(adev, vm);
+	if (r)
+		return r;
 
-	p->post_deps = kmalloc_array(num_deps, sizeof(*p->post_deps),
-				     GFP_KERNEL);
-	p->num_post_deps = 0;
+	r = amdgpu_vm_update_pdes(adev, vm, false);
+	if (r)
+		return r;
 
-	if (!p->post_deps)
-		return -ENOMEM;
+	r = amdgpu_sync_vm_fence(&p->job->sync, vm->last_update);
+	if (r)
+		return r;
 
-	for (i = 0; i < num_deps; ++i) {
-		struct amdgpu_cs_post_dep *dep = &p->post_deps[i];
+	p->job->vm_pd_addr = amdgpu_gmc_pd_addr(vm->root.bo);
 
-		dep->chain = NULL;
-		if (syncobj_deps[i].point) {
-			dep->chain = dma_fence_chain_alloc();
-			if (!dep->chain)
-				return -ENOMEM;
-		}
+	if (amdgpu_vm_debug) {
+		/* Invalidate all BOs to test for userspace bugs */
+		amdgpu_bo_list_for_each_entry(e, p->bo_list) {
+			struct amdgpu_bo *bo = ttm_to_amdgpu_bo(e->tv.bo);
 
-		dep->syncobj = drm_syncobj_find(p->filp,
-						syncobj_deps[i].handle);
-		if (!dep->syncobj) {
-			dma_fence_chain_free(dep->chain);
-			return -EINVAL;
+			/* ignore duplicates */
+			if (!bo)
+				continue;
+
+			amdgpu_vm_bo_invalidate(adev, bo, false);
 		}
-		dep->point = syncobj_deps[i].point;
-		p->num_post_deps++;
 	}
 
 	return 0;
 }
 
-static int amdgpu_cs_dependencies(struct amdgpu_device *adev,
-				  struct amdgpu_cs_parser *p)
+static int amdgpu_cs_sync_rings(struct amdgpu_cs_parser *p)
 {
-	int i, r;
-
-	for (i = 0; i < p->nchunks; ++i) {
-		struct amdgpu_cs_chunk *chunk;
+	struct amdgpu_fpriv *fpriv = p->filp->driver_priv;
+	struct amdgpu_bo_list_entry *e;
+	int r;
 
-		chunk = &p->chunks[i];
+	list_for_each_entry(e, &p->validated, tv.head) {
+		struct amdgpu_bo *bo = ttm_to_amdgpu_bo(e->tv.bo);
+		struct dma_resv *resv = bo->tbo.base.resv;
+		enum amdgpu_sync_mode sync_mode;
 
-		switch (chunk->chunk_id) {
-		case AMDGPU_CHUNK_ID_DEPENDENCIES:
-		case AMDGPU_CHUNK_ID_SCHEDULED_DEPENDENCIES:
-			r = amdgpu_cs_process_fence_dep(p, chunk);
-			if (r)
-				return r;
-			break;
-		case AMDGPU_CHUNK_ID_SYNCOBJ_IN:
-			r = amdgpu_cs_process_syncobj_in_dep(p, chunk);
-			if (r)
-				return r;
-			break;
-		case AMDGPU_CHUNK_ID_SYNCOBJ_OUT:
-			r = amdgpu_cs_process_syncobj_out_dep(p, chunk);
-			if (r)
-				return r;
-			break;
-		case AMDGPU_CHUNK_ID_SYNCOBJ_TIMELINE_WAIT:
-			r = amdgpu_cs_process_syncobj_timeline_in_dep(p, chunk);
-			if (r)
-				return r;
-			break;
-		case AMDGPU_CHUNK_ID_SYNCOBJ_TIMELINE_SIGNAL:
-			r = amdgpu_cs_process_syncobj_timeline_out_dep(p, chunk);
-			if (r)
-				return r;
-			break;
-		}
+		sync_mode = amdgpu_bo_explicit_sync(bo) ?
+			AMDGPU_SYNC_EXPLICIT : AMDGPU_SYNC_NE_OWNER;
+		r = amdgpu_sync_resv(p->adev, &p->job->sync, resv, sync_mode,
+				     &fpriv->vm);
+		if (r)
+			return r;
 	}
-
 	return 0;
 }
 
@@ -1204,10 +1173,6 @@ static int amdgpu_cs_submit(struct amdgpu_cs_parser *p,
 	job = p->job;
 	p->job = NULL;
 
-	r = drm_sched_job_init(&job->base, entity, &fpriv->vm);
-	if (r)
-		goto error_unlock;
-
 	drm_sched_job_arm(&job->base);
 
 	/* No memory allocation is allowed while holding the notifier lock.
@@ -1263,29 +1228,45 @@ static int amdgpu_cs_submit(struct amdgpu_cs_parser *p,
 error_abort:
 	drm_sched_job_cleanup(&job->base);
 	mutex_unlock(&p->adev->notifier_lock);
-
-error_unlock:
 	amdgpu_job_free(job);
 	return r;
 }
 
-static void trace_amdgpu_cs_ibs(struct amdgpu_cs_parser *parser)
+/* Cleanup the parser structure */
+static void amdgpu_cs_parser_fini(struct amdgpu_cs_parser *parser)
 {
-	int i;
+	unsigned i;
 
-	if (!trace_amdgpu_cs_enabled())
-		return;
+	for (i = 0; i < parser->num_post_deps; i++) {
+		drm_syncobj_put(parser->post_deps[i].syncobj);
+		kfree(parser->post_deps[i].chain);
+	}
+	kfree(parser->post_deps);
 
-	for (i = 0; i < parser->job->num_ibs; i++)
-		trace_amdgpu_cs(parser, i);
+	dma_fence_put(parser->fence);
+
+	if (parser->ctx) {
+		amdgpu_ctx_put(parser->ctx);
+	}
+	if (parser->bo_list)
+		amdgpu_bo_list_put(parser->bo_list);
+
+	for (i = 0; i < parser->nchunks; i++)
+		kvfree(parser->chunks[i].kdata);
+	kvfree(parser->chunks);
+	if (parser->job)
+		amdgpu_job_free(parser->job);
+	if (parser->uf_entry.tv.bo) {
+		struct amdgpu_bo *uf = ttm_to_amdgpu_bo(parser->uf_entry.tv.bo);
+
+		amdgpu_bo_unref(&uf);
+	}
 }
 
 int amdgpu_cs_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
 {
 	struct amdgpu_device *adev = drm_to_adev(dev);
-	union drm_amdgpu_cs *cs = data;
-	struct amdgpu_cs_parser parser = {};
-	bool reserved_buffers = false;
+	struct amdgpu_cs_parser parser;
 	int r;
 
 	if (amdgpu_ras_intr_triggered())
@@ -1294,25 +1275,20 @@ int amdgpu_cs_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
 	if (!adev->accel_working)
 		return -EBUSY;
 
-	parser.adev = adev;
-	parser.filp = filp;
-
-	r = amdgpu_cs_parser_init(&parser, data);
+	r = amdgpu_cs_parser_init(&parser, adev, filp, data);
 	if (r) {
 		if (printk_ratelimit())
 			DRM_ERROR("Failed to initialize parser %d!\n", r);
-		goto out;
+		return r;
 	}
 
-	r = amdgpu_cs_ib_fill(adev, &parser);
+	r = amdgpu_cs_pass1(&parser, data);
 	if (r)
-		goto out;
+		goto error_fini;
 
-	r = amdgpu_cs_dependencies(adev, &parser);
-	if (r) {
-		DRM_ERROR("Failed in the dependencies handling %d!\n", r);
-		goto out;
-	}
+	r = amdgpu_cs_pass2(&parser);
+	if (r)
+		goto error_fini;
 
 	r = amdgpu_cs_parser_bos(&parser, data);
 	if (r) {
@@ -1320,21 +1296,35 @@ int amdgpu_cs_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
 			DRM_ERROR("Not enough memory for command submission!\n");
 		else if (r != -ERESTARTSYS && r != -EAGAIN)
 			DRM_ERROR("Failed to process the buffer list %d!\n", r);
-		goto out;
+		goto error_fini;
 	}
 
-	reserved_buffers = true;
+	r = amdgpu_cs_patch_ibs(&parser);
+	if (r)
+		goto error_backoff;
+
+	r = amdgpu_cs_vm_handling(&parser);
+	if (r)
+		goto error_backoff;
+
+	r = amdgpu_cs_sync_rings(&parser);
+	if (r)
+		goto error_backoff;
 
 	trace_amdgpu_cs_ibs(&parser);
 
-	r = amdgpu_cs_vm_handling(&parser);
+	r = amdgpu_cs_submit(&parser, data);
 	if (r)
-		goto out;
+		goto error_backoff;
 
-	r = amdgpu_cs_submit(&parser, cs);
-out:
-	amdgpu_cs_parser_fini(&parser, r, reserved_buffers);
+	amdgpu_cs_parser_fini(&parser);
+	return 0;
+
+error_backoff:
+	ttm_eu_backoff_reservation(&parser.ticket, &parser.validated);
 
+error_fini:
+	amdgpu_cs_parser_fini(&parser);
 	return r;
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.h
index 92d07816743e..30136eb50d2a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.h
@@ -51,8 +51,8 @@ struct amdgpu_cs_parser {
 	struct amdgpu_cs_chunk	*chunks;
 
 	/* scheduler job object */
-	struct amdgpu_job	*job;
 	struct drm_sched_entity	*entity;
+	struct amdgpu_job	*job;
 
 	/* buffer objects */
 	struct ww_acquire_ctx		ticket;
-- 
2.25.1

