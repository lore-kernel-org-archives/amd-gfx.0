Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3FE8C433FE
	for <amd-gfx@archiver.kernel.org>; Thu,  3 Mar 2022 08:23:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C037610EF2D;
	Thu,  3 Mar 2022 08:23:20 +0000 (UTC)
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com
 [IPv6:2a00:1450:4864:20::62d])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 00AE210EF1C
 for <amd-gfx@lists.freedesktop.org>; Thu,  3 Mar 2022 08:23:17 +0000 (UTC)
Received: by mail-ej1-x62d.google.com with SMTP id yy13so84146ejb.2
 for <amd-gfx@lists.freedesktop.org>; Thu, 03 Mar 2022 00:23:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=z2X/ap6jY8AOc56gNIQ1X0ifQJf7rrTohpc13t6/RSM=;
 b=mixWF7m2+Y7aNDNvRopRT4RQKIl3cWkn9JuVuW/7tkWmefq3UG2e1GvGajuPrQuq3w
 tGmZbVun2FLHyROeWAkF3fY0Ji3MeGSmlZ9agJFyKl6Ot5Bb55oTPjGMX9MysvZKa9nT
 xRAh0x2ACgTVX8pyzrFkHcb+mVlkIak9SnVfN0cWiEnK8xbb/2C9lsjrlAONcWqx70FG
 XXDFLfUSO9/eYlFmwHjaBUtqXtnGA91izH2FejPC7xpTQX62Tl2dtB30npGeU9+2RVH0
 JzpGa8DA1XwC6Fz5ceEyPsMpstrWQbyg16qfSzAbmKGFTIyzQWLKwQKH9jbhkbuaLAD8
 +ZSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=z2X/ap6jY8AOc56gNIQ1X0ifQJf7rrTohpc13t6/RSM=;
 b=WtP8rWiLoNqaLiPZpOS07ioVO/xyhs8b4beokmZZg/cng8aJzxNIFMphmliaq1q8et
 auuMlSCnNmRhjc3vE/PelKmX4ub8LL3h1wqmodcH6Mb6VkGkYQ977iuDuG5gvS/fIvbY
 b70MM5ENvHH8WYoUsqQt9WjpAaniFAjf5bnzlrEy73n4Yo5D8aub6WoN/wGUw4knESNZ
 Ygka7vMVjb7yXP/5i5tBADzIY54cMRSCk+rpI/iC8Ucs48xoVNrnNxnwhfvdGZtn45cA
 J2MZhoVRlzimtsYte4rX5TRcMA6EHrP8lqwpQu9MAvBuofUzdPwzAHC8lgrE6XzHkwnP
 GEuA==
X-Gm-Message-State: AOAM531gsvZT+iU5amu6l9RxewXayhFLbUfcUXoT7YACbdKOstTT67Cz
 1j9qogkwkwK/rDpeX1jvEwcM1PobghTlhQ==
X-Google-Smtp-Source: ABdhPJx0g7o8DbU7kEllfsxtImOy6xEztUFM7sbKdJqiX7BfoxQPFwmHIN2FFf6MNObaYVH7aZ38LQ==
X-Received: by 2002:a17:906:a92:b0:6ce:6f8b:a1ba with SMTP id
 y18-20020a1709060a9200b006ce6f8ba1bamr26190575ejf.715.1646295796429; 
 Thu, 03 Mar 2022 00:23:16 -0800 (PST)
Received: from able.fritz.box (p5b0eab60.dip0.t-ipconnect.de. [91.14.171.96])
 by smtp.gmail.com with ESMTPSA id
 n4-20020a056402060400b00415a1f9a4dasm548308edv.91.2022.03.03.00.23.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Mar 2022 00:23:16 -0800 (PST)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: amd-gfx@lists.freedesktop.org,
	Marek.Olsak@amd.com
Subject: [PATCH 05/10] drm/amdgpu: use job and ib structures directly in CS
 parsers
Date: Thu,  3 Mar 2022 09:23:03 +0100
Message-Id: <20220303082308.38217-6-christian.koenig@amd.com>
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

Instead of providing the ib index provide the job and ib pointers directly to
the patch and parse functions for UVD and VCE.

Also move the set/get functions for IB values to the IB declerations.

Signed-off-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c   |   6 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.h   |  13 ---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h |  23 ++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c  |  36 ++++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.h  |   4 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c  | 116 ++++++++++++-----------
 drivers/gpu/drm/amd/amdgpu/amdgpu_vce.h  |   7 +-
 drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c    |  13 +--
 drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c    |  25 ++---
 9 files changed, 129 insertions(+), 114 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
index 20bf6134baca..dd9e708fe97f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
@@ -1024,12 +1024,14 @@ static int amdgpu_cs_patch_ibs(struct amdgpu_cs_parser *p)
 			memcpy(ib->ptr, kptr, job->ibs[i].length_dw * 4);
 			amdgpu_bo_kunmap(aobj);
 
-			r = amdgpu_ring_parse_cs(ring, p, i);
+			r = amdgpu_ring_parse_cs(ring, p, p->job,
+						 &p->job->ibs[i]);
 			if (r)
 				return r;
 		} else {
 			ib->ptr = (uint32_t *)kptr;
-			r = amdgpu_ring_patch_cs_in_place(ring, p, i);
+			r = amdgpu_ring_patch_cs_in_place(ring, p, p->job,
+							  &p->job->ibs[i]);
 			amdgpu_bo_kunmap(aobj);
 			if (r)
 				return r;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.h
index 30136eb50d2a..652b5593499f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.h
@@ -73,19 +73,6 @@ struct amdgpu_cs_parser {
 	struct amdgpu_cs_post_dep	*post_deps;
 };
 
-static inline u32 amdgpu_get_ib_value(struct amdgpu_cs_parser *p,
-				      uint32_t ib_idx, int idx)
-{
-	return p->job->ibs[ib_idx].ptr[idx];
-}
-
-static inline void amdgpu_set_ib_value(struct amdgpu_cs_parser *p,
-				       uint32_t ib_idx, int idx,
-				       uint32_t value)
-{
-	p->job->ibs[ib_idx].ptr[idx] = value;
-}
-
 int amdgpu_cs_find_mapping(struct amdgpu_cs_parser *parser,
 			   uint64_t addr, struct amdgpu_bo **bo,
 			   struct amdgpu_bo_va_mapping **mapping);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
index 05e789fc7a9e..a8bed1b47899 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
@@ -163,8 +163,12 @@ struct amdgpu_ring_funcs {
 	u64 (*get_wptr)(struct amdgpu_ring *ring);
 	void (*set_wptr)(struct amdgpu_ring *ring);
 	/* validating and patching of IBs */
-	int (*parse_cs)(struct amdgpu_cs_parser *p, uint32_t ib_idx);
-	int (*patch_cs_in_place)(struct amdgpu_cs_parser *p, uint32_t ib_idx);
+	int (*parse_cs)(struct amdgpu_cs_parser *p,
+			struct amdgpu_job *job,
+			struct amdgpu_ib *ib);
+	int (*patch_cs_in_place)(struct amdgpu_cs_parser *p,
+				 struct amdgpu_job *job,
+				 struct amdgpu_ib *ib);
 	/* constants to calculate how many DW are needed for an emit */
 	unsigned emit_frame_size;
 	unsigned emit_ib_size;
@@ -264,8 +268,8 @@ struct amdgpu_ring {
 	atomic_t		*sched_score;
 };
 
-#define amdgpu_ring_parse_cs(r, p, ib) ((r)->funcs->parse_cs((p), (ib)))
-#define amdgpu_ring_patch_cs_in_place(r, p, ib) ((r)->funcs->patch_cs_in_place((p), (ib)))
+#define amdgpu_ring_parse_cs(r, p, job, ib) ((r)->funcs->parse_cs((p), (job), (ib)))
+#define amdgpu_ring_patch_cs_in_place(r, p, job, ib) ((r)->funcs->patch_cs_in_place((p), (job), (ib)))
 #define amdgpu_ring_test_ring(r) (r)->funcs->test_ring((r))
 #define amdgpu_ring_test_ib(r, t) (r)->funcs->test_ib((r), (t))
 #define amdgpu_ring_get_rptr(r) (r)->funcs->get_rptr((r))
@@ -364,6 +368,17 @@ int amdgpu_ring_test_helper(struct amdgpu_ring *ring);
 void amdgpu_debugfs_ring_init(struct amdgpu_device *adev,
 			      struct amdgpu_ring *ring);
 
+static inline u32 amdgpu_ib_get_value(struct amdgpu_ib *ib, int idx)
+{
+	return ib->ptr[idx];
+}
+
+static inline void amdgpu_ib_set_value(struct amdgpu_ib *ib, int idx,
+				       uint32_t value)
+{
+	ib->ptr[idx] = value;
+}
+
 int amdgpu_ib_get(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 		  unsigned size,
 		  enum amdgpu_ib_pool_type pool,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
index 4927c10bdc80..2ebd133a5222 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
@@ -99,7 +99,7 @@ struct amdgpu_uvd_cs_ctx {
 	unsigned reg, count;
 	unsigned data0, data1;
 	unsigned idx;
-	unsigned ib_idx;
+	struct amdgpu_ib *ib;
 
 	/* does the IB has a msg command */
 	bool has_msg_cmd;
@@ -558,8 +558,8 @@ static u64 amdgpu_uvd_get_addr_from_ctx(struct amdgpu_uvd_cs_ctx *ctx)
 	uint32_t lo, hi;
 	uint64_t addr;
 
-	lo = amdgpu_get_ib_value(ctx->parser, ctx->ib_idx, ctx->data0);
-	hi = amdgpu_get_ib_value(ctx->parser, ctx->ib_idx, ctx->data1);
+	lo = amdgpu_ib_get_value(ctx->ib, ctx->data0);
+	hi = amdgpu_ib_get_value(ctx->ib, ctx->data1);
 	addr = ((uint64_t)lo) | (((uint64_t)hi) << 32);
 
 	return addr;
@@ -590,7 +590,7 @@ static int amdgpu_uvd_cs_pass1(struct amdgpu_uvd_cs_ctx *ctx)
 
 	if (!ctx->parser->adev->uvd.address_64_bit) {
 		/* check if it's a message or feedback command */
-		cmd = amdgpu_get_ib_value(ctx->parser, ctx->ib_idx, ctx->idx) >> 1;
+		cmd = amdgpu_ib_get_value(ctx->ib, ctx->idx) >> 1;
 		if (cmd == 0x0 || cmd == 0x3) {
 			/* yes, force it into VRAM */
 			uint32_t domain = AMDGPU_GEM_DOMAIN_VRAM;
@@ -926,12 +926,10 @@ static int amdgpu_uvd_cs_pass2(struct amdgpu_uvd_cs_ctx *ctx)
 	addr -= mapping->start * AMDGPU_GPU_PAGE_SIZE;
 	start += addr;
 
-	amdgpu_set_ib_value(ctx->parser, ctx->ib_idx, ctx->data0,
-			    lower_32_bits(start));
-	amdgpu_set_ib_value(ctx->parser, ctx->ib_idx, ctx->data1,
-			    upper_32_bits(start));
+	amdgpu_ib_set_value(ctx->ib, ctx->data0, lower_32_bits(start));
+	amdgpu_ib_set_value(ctx->ib, ctx->data1, upper_32_bits(start));
 
-	cmd = amdgpu_get_ib_value(ctx->parser, ctx->ib_idx, ctx->idx) >> 1;
+	cmd = amdgpu_ib_get_value(ctx->ib, ctx->idx) >> 1;
 	if (cmd < 0x4) {
 		if ((end - start) < ctx->buf_sizes[cmd]) {
 			DRM_ERROR("buffer (%d) to small (%d / %d)!\n", cmd,
@@ -991,14 +989,13 @@ static int amdgpu_uvd_cs_pass2(struct amdgpu_uvd_cs_ctx *ctx)
 static int amdgpu_uvd_cs_reg(struct amdgpu_uvd_cs_ctx *ctx,
 			     int (*cb)(struct amdgpu_uvd_cs_ctx *ctx))
 {
-	struct amdgpu_ib *ib = &ctx->parser->job->ibs[ctx->ib_idx];
 	int i, r;
 
 	ctx->idx++;
 	for (i = 0; i <= ctx->count; ++i) {
 		unsigned reg = ctx->reg + i;
 
-		if (ctx->idx >= ib->length_dw) {
+		if (ctx->idx >= ctx->ib->length_dw) {
 			DRM_ERROR("Register command after end of CS!\n");
 			return -EINVAL;
 		}
@@ -1038,11 +1035,10 @@ static int amdgpu_uvd_cs_reg(struct amdgpu_uvd_cs_ctx *ctx,
 static int amdgpu_uvd_cs_packets(struct amdgpu_uvd_cs_ctx *ctx,
 				 int (*cb)(struct amdgpu_uvd_cs_ctx *ctx))
 {
-	struct amdgpu_ib *ib = &ctx->parser->job->ibs[ctx->ib_idx];
 	int r;
 
-	for (ctx->idx = 0 ; ctx->idx < ib->length_dw; ) {
-		uint32_t cmd = amdgpu_get_ib_value(ctx->parser, ctx->ib_idx, ctx->idx);
+	for (ctx->idx = 0 ; ctx->idx < ctx->ib->length_dw; ) {
+		uint32_t cmd = amdgpu_ib_get_value(ctx->ib, ctx->idx);
 		unsigned type = CP_PACKET_GET_TYPE(cmd);
 		switch (type) {
 		case PACKET_TYPE0:
@@ -1067,11 +1063,14 @@ static int amdgpu_uvd_cs_packets(struct amdgpu_uvd_cs_ctx *ctx,
  * amdgpu_uvd_ring_parse_cs - UVD command submission parser
  *
  * @parser: Command submission parser context
- * @ib_idx: Which indirect buffer to use
+ * @job: the job to parse
+ * @ib: the IB to patch
  *
  * Parse the command stream, patch in addresses as necessary.
  */
-int amdgpu_uvd_ring_parse_cs(struct amdgpu_cs_parser *parser, uint32_t ib_idx)
+int amdgpu_uvd_ring_parse_cs(struct amdgpu_cs_parser *parser,
+			     struct amdgpu_job *job,
+			     struct amdgpu_ib *ib)
 {
 	struct amdgpu_uvd_cs_ctx ctx = {};
 	unsigned buf_sizes[] = {
@@ -1081,10 +1080,9 @@ int amdgpu_uvd_ring_parse_cs(struct amdgpu_cs_parser *parser, uint32_t ib_idx)
 		[0x00000003]	=	2048,
 		[0x00000004]	=	0xFFFFFFFF,
 	};
-	struct amdgpu_ib *ib = &parser->job->ibs[ib_idx];
 	int r;
 
-	parser->job->vm = NULL;
+	job->vm = NULL;
 	ib->gpu_addr = amdgpu_sa_bo_gpu_addr(ib->sa_bo);
 
 	if (ib->length_dw % 16) {
@@ -1095,7 +1093,7 @@ int amdgpu_uvd_ring_parse_cs(struct amdgpu_cs_parser *parser, uint32_t ib_idx)
 
 	ctx.parser = parser;
 	ctx.buf_sizes = buf_sizes;
-	ctx.ib_idx = ib_idx;
+	ctx.ib = ib;
 
 	/* first round only required on chips without UVD 64 bit address support */
 	if (!parser->adev->uvd.address_64_bit) {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.h
index 76ac9699885d..9f89bb7cd60b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.h
@@ -82,7 +82,9 @@ int amdgpu_uvd_get_destroy_msg(struct amdgpu_ring *ring, uint32_t handle,
 			       bool direct, struct dma_fence **fence);
 void amdgpu_uvd_free_handles(struct amdgpu_device *adev,
 			     struct drm_file *filp);
-int amdgpu_uvd_ring_parse_cs(struct amdgpu_cs_parser *parser, uint32_t ib_idx);
+int amdgpu_uvd_ring_parse_cs(struct amdgpu_cs_parser *parser,
+			     struct amdgpu_job *job,
+			     struct amdgpu_ib *ib);
 void amdgpu_uvd_ring_begin_use(struct amdgpu_ring *ring);
 void amdgpu_uvd_ring_end_use(struct amdgpu_ring *ring);
 int amdgpu_uvd_ring_test_ib(struct amdgpu_ring *ring, long timeout);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
index 6179230b6c6e..02cb3a12dd76 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
@@ -588,8 +588,7 @@ static int amdgpu_vce_get_destroy_msg(struct amdgpu_ring *ring, uint32_t handle,
 /**
  * amdgpu_vce_validate_bo - make sure not to cross 4GB boundary
  *
- * @p: parser context
- * @ib_idx: indirect buffer to use
+ * @ib: indirect buffer to use
  * @lo: address of lower dword
  * @hi: address of higher dword
  * @size: minimum size
@@ -597,8 +596,9 @@ static int amdgpu_vce_get_destroy_msg(struct amdgpu_ring *ring, uint32_t handle,
  *
  * Make sure that no BO cross a 4GB boundary.
  */
-static int amdgpu_vce_validate_bo(struct amdgpu_cs_parser *p, uint32_t ib_idx,
-				  int lo, int hi, unsigned size, int32_t index)
+static int amdgpu_vce_validate_bo(struct amdgpu_cs_parser *p,
+				  struct amdgpu_ib *ib, int lo, int hi,
+				  unsigned size, int32_t index)
 {
 	int64_t offset = ((uint64_t)size) * ((int64_t)index);
 	struct ttm_operation_ctx ctx = { false, false };
@@ -608,8 +608,8 @@ static int amdgpu_vce_validate_bo(struct amdgpu_cs_parser *p, uint32_t ib_idx,
 	uint64_t addr;
 	int r;
 
-	addr = ((uint64_t)amdgpu_get_ib_value(p, ib_idx, lo)) |
-	       ((uint64_t)amdgpu_get_ib_value(p, ib_idx, hi)) << 32;
+	addr = ((uint64_t)amdgpu_ib_get_value(ib, lo)) |
+	       ((uint64_t)amdgpu_ib_get_value(ib, hi)) << 32;
 	if (index >= 0) {
 		addr += offset;
 		fpfn = PAGE_ALIGN(offset) >> PAGE_SHIFT;
@@ -639,7 +639,7 @@ static int amdgpu_vce_validate_bo(struct amdgpu_cs_parser *p, uint32_t ib_idx,
  * amdgpu_vce_cs_reloc - command submission relocation
  *
  * @p: parser context
- * @ib_idx: indirect buffer to use
+ * @ib: indirect buffer to use
  * @lo: address of lower dword
  * @hi: address of higher dword
  * @size: minimum size
@@ -647,7 +647,7 @@ static int amdgpu_vce_validate_bo(struct amdgpu_cs_parser *p, uint32_t ib_idx,
  *
  * Patch relocation inside command stream with real buffer address
  */
-static int amdgpu_vce_cs_reloc(struct amdgpu_cs_parser *p, uint32_t ib_idx,
+static int amdgpu_vce_cs_reloc(struct amdgpu_cs_parser *p, struct amdgpu_ib *ib,
 			       int lo, int hi, unsigned size, uint32_t index)
 {
 	struct amdgpu_bo_va_mapping *mapping;
@@ -658,8 +658,8 @@ static int amdgpu_vce_cs_reloc(struct amdgpu_cs_parser *p, uint32_t ib_idx,
 	if (index == 0xffffffff)
 		index = 0;
 
-	addr = ((uint64_t)amdgpu_get_ib_value(p, ib_idx, lo)) |
-	       ((uint64_t)amdgpu_get_ib_value(p, ib_idx, hi)) << 32;
+	addr = ((uint64_t)amdgpu_ib_get_value(ib, lo)) |
+	       ((uint64_t)amdgpu_ib_get_value(ib, hi)) << 32;
 	addr += ((uint64_t)size) * ((uint64_t)index);
 
 	r = amdgpu_cs_find_mapping(p, addr, &bo, &mapping);
@@ -680,8 +680,8 @@ static int amdgpu_vce_cs_reloc(struct amdgpu_cs_parser *p, uint32_t ib_idx,
 	addr += amdgpu_bo_gpu_offset(bo);
 	addr -= ((uint64_t)size) * ((uint64_t)index);
 
-	amdgpu_set_ib_value(p, ib_idx, lo, lower_32_bits(addr));
-	amdgpu_set_ib_value(p, ib_idx, hi, upper_32_bits(addr));
+	amdgpu_ib_set_value(ib, lo, lower_32_bits(addr));
+	amdgpu_ib_set_value(ib, hi, upper_32_bits(addr));
 
 	return 0;
 }
@@ -730,11 +730,13 @@ static int amdgpu_vce_validate_handle(struct amdgpu_cs_parser *p,
  * amdgpu_vce_ring_parse_cs - parse and validate the command stream
  *
  * @p: parser context
- * @ib_idx: indirect buffer to use
+ * @job: the job to parse
+ * @ib: the IB to patch
  */
-int amdgpu_vce_ring_parse_cs(struct amdgpu_cs_parser *p, uint32_t ib_idx)
+int amdgpu_vce_ring_parse_cs(struct amdgpu_cs_parser *p,
+			     struct amdgpu_job *job,
+			     struct amdgpu_ib *ib)
 {
-	struct amdgpu_ib *ib = &p->job->ibs[ib_idx];
 	unsigned fb_idx = 0, bs_idx = 0;
 	int session_idx = -1;
 	uint32_t destroyed = 0;
@@ -745,12 +747,12 @@ int amdgpu_vce_ring_parse_cs(struct amdgpu_cs_parser *p, uint32_t ib_idx)
 	unsigned idx;
 	int i, r = 0;
 
-	p->job->vm = NULL;
+	job->vm = NULL;
 	ib->gpu_addr = amdgpu_sa_bo_gpu_addr(ib->sa_bo);
 
 	for (idx = 0; idx < ib->length_dw;) {
-		uint32_t len = amdgpu_get_ib_value(p, ib_idx, idx);
-		uint32_t cmd = amdgpu_get_ib_value(p, ib_idx, idx + 1);
+		uint32_t len = amdgpu_ib_get_value(ib, idx);
+		uint32_t cmd = amdgpu_ib_get_value(ib, idx + 1);
 
 		if ((len < 8) || (len & 3)) {
 			DRM_ERROR("invalid VCE command length (%d)!\n", len);
@@ -760,52 +762,52 @@ int amdgpu_vce_ring_parse_cs(struct amdgpu_cs_parser *p, uint32_t ib_idx)
 
 		switch (cmd) {
 		case 0x00000002: /* task info */
-			fb_idx = amdgpu_get_ib_value(p, ib_idx, idx + 6);
-			bs_idx = amdgpu_get_ib_value(p, ib_idx, idx + 7);
+			fb_idx = amdgpu_ib_get_value(ib, idx + 6);
+			bs_idx = amdgpu_ib_get_value(ib, idx + 7);
 			break;
 
 		case 0x03000001: /* encode */
-			r = amdgpu_vce_validate_bo(p, ib_idx, idx + 10,
-						   idx + 9, 0, 0);
+			r = amdgpu_vce_validate_bo(p, ib, idx + 10, idx + 9,
+						   0, 0);
 			if (r)
 				goto out;
 
-			r = amdgpu_vce_validate_bo(p, ib_idx, idx + 12,
-						   idx + 11, 0, 0);
+			r = amdgpu_vce_validate_bo(p, ib, idx + 12, idx + 11,
+						   0, 0);
 			if (r)
 				goto out;
 			break;
 
 		case 0x05000001: /* context buffer */
-			r = amdgpu_vce_validate_bo(p, ib_idx, idx + 3,
-						   idx + 2, 0, 0);
+			r = amdgpu_vce_validate_bo(p, ib, idx + 3, idx + 2,
+						   0, 0);
 			if (r)
 				goto out;
 			break;
 
 		case 0x05000004: /* video bitstream buffer */
-			tmp = amdgpu_get_ib_value(p, ib_idx, idx + 4);
-			r = amdgpu_vce_validate_bo(p, ib_idx, idx + 3, idx + 2,
+			tmp = amdgpu_ib_get_value(ib, idx + 4);
+			r = amdgpu_vce_validate_bo(p, ib, idx + 3, idx + 2,
 						   tmp, bs_idx);
 			if (r)
 				goto out;
 			break;
 
 		case 0x05000005: /* feedback buffer */
-			r = amdgpu_vce_validate_bo(p, ib_idx, idx + 3, idx + 2,
+			r = amdgpu_vce_validate_bo(p, ib, idx + 3, idx + 2,
 						   4096, fb_idx);
 			if (r)
 				goto out;
 			break;
 
 		case 0x0500000d: /* MV buffer */
-			r = amdgpu_vce_validate_bo(p, ib_idx, idx + 3,
-							idx + 2, 0, 0);
+			r = amdgpu_vce_validate_bo(p, ib, idx + 3, idx + 2,
+						   0, 0);
 			if (r)
 				goto out;
 
-			r = amdgpu_vce_validate_bo(p, ib_idx, idx + 8,
-							idx + 7, 0, 0);
+			r = amdgpu_vce_validate_bo(p, ib, idx + 8, idx + 7,
+						   0, 0);
 			if (r)
 				goto out;
 			break;
@@ -815,12 +817,12 @@ int amdgpu_vce_ring_parse_cs(struct amdgpu_cs_parser *p, uint32_t ib_idx)
 	}
 
 	for (idx = 0; idx < ib->length_dw;) {
-		uint32_t len = amdgpu_get_ib_value(p, ib_idx, idx);
-		uint32_t cmd = amdgpu_get_ib_value(p, ib_idx, idx + 1);
+		uint32_t len = amdgpu_ib_get_value(ib, idx);
+		uint32_t cmd = amdgpu_ib_get_value(ib, idx + 1);
 
 		switch (cmd) {
 		case 0x00000001: /* session */
-			handle = amdgpu_get_ib_value(p, ib_idx, idx + 2);
+			handle = amdgpu_ib_get_value(ib, idx + 2);
 			session_idx = amdgpu_vce_validate_handle(p, handle,
 								 &allocated);
 			if (session_idx < 0) {
@@ -831,8 +833,8 @@ int amdgpu_vce_ring_parse_cs(struct amdgpu_cs_parser *p, uint32_t ib_idx)
 			break;
 
 		case 0x00000002: /* task info */
-			fb_idx = amdgpu_get_ib_value(p, ib_idx, idx + 6);
-			bs_idx = amdgpu_get_ib_value(p, ib_idx, idx + 7);
+			fb_idx = amdgpu_ib_get_value(ib, idx + 6);
+			bs_idx = amdgpu_ib_get_value(ib, idx + 7);
 			break;
 
 		case 0x01000001: /* create */
@@ -847,8 +849,8 @@ int amdgpu_vce_ring_parse_cs(struct amdgpu_cs_parser *p, uint32_t ib_idx)
 				goto out;
 			}
 
-			*size = amdgpu_get_ib_value(p, ib_idx, idx + 8) *
-				amdgpu_get_ib_value(p, ib_idx, idx + 10) *
+			*size = amdgpu_ib_get_value(ib, idx + 8) *
+				amdgpu_ib_get_value(ib, idx + 10) *
 				8 * 3 / 2;
 			break;
 
@@ -877,12 +879,12 @@ int amdgpu_vce_ring_parse_cs(struct amdgpu_cs_parser *p, uint32_t ib_idx)
 			break;
 
 		case 0x03000001: /* encode */
-			r = amdgpu_vce_cs_reloc(p, ib_idx, idx + 10, idx + 9,
+			r = amdgpu_vce_cs_reloc(p, ib, idx + 10, idx + 9,
 						*size, 0);
 			if (r)
 				goto out;
 
-			r = amdgpu_vce_cs_reloc(p, ib_idx, idx + 12, idx + 11,
+			r = amdgpu_vce_cs_reloc(p, ib, idx + 12, idx + 11,
 						*size / 3, 0);
 			if (r)
 				goto out;
@@ -893,35 +895,35 @@ int amdgpu_vce_ring_parse_cs(struct amdgpu_cs_parser *p, uint32_t ib_idx)
 			break;
 
 		case 0x05000001: /* context buffer */
-			r = amdgpu_vce_cs_reloc(p, ib_idx, idx + 3, idx + 2,
+			r = amdgpu_vce_cs_reloc(p, ib, idx + 3, idx + 2,
 						*size * 2, 0);
 			if (r)
 				goto out;
 			break;
 
 		case 0x05000004: /* video bitstream buffer */
-			tmp = amdgpu_get_ib_value(p, ib_idx, idx + 4);
-			r = amdgpu_vce_cs_reloc(p, ib_idx, idx + 3, idx + 2,
+			tmp = amdgpu_ib_get_value(ib, idx + 4);
+			r = amdgpu_vce_cs_reloc(p, ib, idx + 3, idx + 2,
 						tmp, bs_idx);
 			if (r)
 				goto out;
 			break;
 
 		case 0x05000005: /* feedback buffer */
-			r = amdgpu_vce_cs_reloc(p, ib_idx, idx + 3, idx + 2,
+			r = amdgpu_vce_cs_reloc(p, ib, idx + 3, idx + 2,
 						4096, fb_idx);
 			if (r)
 				goto out;
 			break;
 
 		case 0x0500000d: /* MV buffer */
-			r = amdgpu_vce_cs_reloc(p, ib_idx, idx + 3,
-							idx + 2, *size, 0);
+			r = amdgpu_vce_cs_reloc(p, ib, idx + 3,
+						idx + 2, *size, 0);
 			if (r)
 				goto out;
 
-			r = amdgpu_vce_cs_reloc(p, ib_idx, idx + 8,
-							idx + 7, *size / 12, 0);
+			r = amdgpu_vce_cs_reloc(p, ib, idx + 8,
+						idx + 7, *size / 12, 0);
 			if (r)
 				goto out;
 			break;
@@ -966,11 +968,13 @@ int amdgpu_vce_ring_parse_cs(struct amdgpu_cs_parser *p, uint32_t ib_idx)
  * amdgpu_vce_ring_parse_cs_vm - parse the command stream in VM mode
  *
  * @p: parser context
- * @ib_idx: indirect buffer to use
+ * @job: the job to parse
+ * @ib: the IB to patch
  */
-int amdgpu_vce_ring_parse_cs_vm(struct amdgpu_cs_parser *p, uint32_t ib_idx)
+int amdgpu_vce_ring_parse_cs_vm(struct amdgpu_cs_parser *p,
+				struct amdgpu_job *job,
+				struct amdgpu_ib *ib)
 {
-	struct amdgpu_ib *ib = &p->job->ibs[ib_idx];
 	int session_idx = -1;
 	uint32_t destroyed = 0;
 	uint32_t created = 0;
@@ -979,8 +983,8 @@ int amdgpu_vce_ring_parse_cs_vm(struct amdgpu_cs_parser *p, uint32_t ib_idx)
 	int i, r = 0, idx = 0;
 
 	while (idx < ib->length_dw) {
-		uint32_t len = amdgpu_get_ib_value(p, ib_idx, idx);
-		uint32_t cmd = amdgpu_get_ib_value(p, ib_idx, idx + 1);
+		uint32_t len = amdgpu_ib_get_value(ib, idx);
+		uint32_t cmd = amdgpu_ib_get_value(ib, idx + 1);
 
 		if ((len < 8) || (len & 3)) {
 			DRM_ERROR("invalid VCE command length (%d)!\n", len);
@@ -990,7 +994,7 @@ int amdgpu_vce_ring_parse_cs_vm(struct amdgpu_cs_parser *p, uint32_t ib_idx)
 
 		switch (cmd) {
 		case 0x00000001: /* session */
-			handle = amdgpu_get_ib_value(p, ib_idx, idx + 2);
+			handle = amdgpu_ib_get_value(ib, idx + 2);
 			session_idx = amdgpu_vce_validate_handle(p, handle,
 								 &allocated);
 			if (session_idx < 0) {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.h
index be4a6e773c5b..ea680fc9a6c3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.h
@@ -59,8 +59,11 @@ int amdgpu_vce_entity_init(struct amdgpu_device *adev);
 int amdgpu_vce_suspend(struct amdgpu_device *adev);
 int amdgpu_vce_resume(struct amdgpu_device *adev);
 void amdgpu_vce_free_handles(struct amdgpu_device *adev, struct drm_file *filp);
-int amdgpu_vce_ring_parse_cs(struct amdgpu_cs_parser *p, uint32_t ib_idx);
-int amdgpu_vce_ring_parse_cs_vm(struct amdgpu_cs_parser *p, uint32_t ib_idx);
+int amdgpu_vce_ring_parse_cs(struct amdgpu_cs_parser *p, struct amdgpu_job *job,
+			     struct amdgpu_ib *ib);
+int amdgpu_vce_ring_parse_cs_vm(struct amdgpu_cs_parser *p,
+				struct amdgpu_job *job,
+				struct amdgpu_ib *ib);
 void amdgpu_vce_ring_emit_ib(struct amdgpu_ring *ring, struct amdgpu_job *job,
 				struct amdgpu_ib *ib, uint32_t flags);
 void amdgpu_vce_ring_emit_fence(struct amdgpu_ring *ring, u64 addr, u64 seq,
diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c b/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c
index 7afa660e341c..2f15b8e0f7d7 100644
--- a/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c
@@ -1276,14 +1276,15 @@ static int uvd_v7_0_ring_test_ring(struct amdgpu_ring *ring)
  * uvd_v7_0_ring_patch_cs_in_place - Patch the IB for command submission.
  *
  * @p: the CS parser with the IBs
- * @ib_idx: which IB to patch
+ * @job: which job this ib is in
+ * @ib: which IB to patch
  *
  */
 static int uvd_v7_0_ring_patch_cs_in_place(struct amdgpu_cs_parser *p,
-					   uint32_t ib_idx)
+					   struct amdgpu_job *job,
+					   struct amdgpu_ib *ib)
 {
-	struct amdgpu_ring *ring = to_amdgpu_ring(p->entity->rq->sched);
-	struct amdgpu_ib *ib = &p->job->ibs[ib_idx];
+	struct amdgpu_ring *ring = to_amdgpu_ring(job->base.sched);
 	unsigned i;
 
 	/* No patching necessary for the first instance */
@@ -1291,12 +1292,12 @@ static int uvd_v7_0_ring_patch_cs_in_place(struct amdgpu_cs_parser *p,
 		return 0;
 
 	for (i = 0; i < ib->length_dw; i += 2) {
-		uint32_t reg = amdgpu_get_ib_value(p, ib_idx, i);
+		uint32_t reg = amdgpu_ib_get_value(ib, i);
 
 		reg -= p->adev->reg_offset[UVD_HWIP][0][1];
 		reg += p->adev->reg_offset[UVD_HWIP][1][1];
 
-		amdgpu_set_ib_value(p, ib_idx, i, reg);
+		amdgpu_ib_set_value(ib, i, reg);
 	}
 	return 0;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
index 2bb75fdb9571..5f9ad129464f 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
@@ -1807,21 +1807,23 @@ static const struct amdgpu_ring_funcs vcn_v3_0_dec_sw_ring_vm_funcs = {
 	.emit_reg_write_reg_wait = amdgpu_ring_emit_reg_write_reg_wait_helper,
 };
 
-static int vcn_v3_0_limit_sched(struct amdgpu_cs_parser *p)
+static int vcn_v3_0_limit_sched(struct amdgpu_cs_parser *p,
+				struct amdgpu_job *job)
 {
 	struct drm_gpu_scheduler **scheds;
 
 	/* The create msg must be in the first IB submitted */
-	if (atomic_read(&p->entity->fence_seq))
+	if (atomic_read(&job->base.entity->fence_seq))
 		return -EINVAL;
 
 	scheds = p->adev->gpu_sched[AMDGPU_HW_IP_VCN_DEC]
 		[AMDGPU_RING_PRIO_DEFAULT].sched;
-	drm_sched_entity_modify_sched(p->entity, scheds, 1);
+	drm_sched_entity_modify_sched(job->base.entity, scheds, 1);
 	return 0;
 }
 
-static int vcn_v3_0_dec_msg(struct amdgpu_cs_parser *p, uint64_t addr)
+static int vcn_v3_0_dec_msg(struct amdgpu_cs_parser *p, struct amdgpu_job *job,
+			    uint64_t addr)
 {
 	struct ttm_operation_ctx ctx = { false, false };
 	struct amdgpu_bo_va_mapping *map;
@@ -1892,7 +1894,7 @@ static int vcn_v3_0_dec_msg(struct amdgpu_cs_parser *p, uint64_t addr)
 		if (create[0] == 0x7 || create[0] == 0x10 || create[0] == 0x11)
 			continue;
 
-		r = vcn_v3_0_limit_sched(p);
+		r = vcn_v3_0_limit_sched(p, job);
 		if (r)
 			goto out;
 	}
@@ -1903,10 +1905,10 @@ static int vcn_v3_0_dec_msg(struct amdgpu_cs_parser *p, uint64_t addr)
 }
 
 static int vcn_v3_0_ring_patch_cs_in_place(struct amdgpu_cs_parser *p,
-					   uint32_t ib_idx)
+					   struct amdgpu_job *job,
+					   struct amdgpu_ib *ib)
 {
-	struct amdgpu_ring *ring = to_amdgpu_ring(p->entity->rq->sched);
-	struct amdgpu_ib *ib = &p->job->ibs[ib_idx];
+	struct amdgpu_ring *ring = to_amdgpu_ring(job->base.sched);
 	uint32_t msg_lo = 0, msg_hi = 0;
 	unsigned i;
 	int r;
@@ -1916,8 +1918,8 @@ static int vcn_v3_0_ring_patch_cs_in_place(struct amdgpu_cs_parser *p,
 		return 0;
 
 	for (i = 0; i < ib->length_dw; i += 2) {
-		uint32_t reg = amdgpu_get_ib_value(p, ib_idx, i);
-		uint32_t val = amdgpu_get_ib_value(p, ib_idx, i + 1);
+		uint32_t reg = amdgpu_ib_get_value(ib, i);
+		uint32_t val = amdgpu_ib_get_value(ib, i + 1);
 
 		if (reg == PACKET0(p->adev->vcn.internal.data0, 0)) {
 			msg_lo = val;
@@ -1925,7 +1927,8 @@ static int vcn_v3_0_ring_patch_cs_in_place(struct amdgpu_cs_parser *p,
 			msg_hi = val;
 		} else if (reg == PACKET0(p->adev->vcn.internal.cmd, 0) &&
 			   val == 0) {
-			r = vcn_v3_0_dec_msg(p, ((u64)msg_hi) << 32 | msg_lo);
+			r = vcn_v3_0_dec_msg(p, job,
+					     ((u64)msg_hi) << 32 | msg_lo);
 			if (r)
 				return r;
 		}
-- 
2.25.1

