Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0FAAC54E41
	for <amd-gfx@archiver.kernel.org>; Thu, 29 Feb 2024 14:49:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1C5BB10E3B9;
	Thu, 29 Feb 2024 14:49:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="HALzbYYx";
	dkim-atps=neutral
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com
 [209.85.218.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 38C5810E3B9
 for <amd-gfx@lists.freedesktop.org>; Thu, 29 Feb 2024 14:49:29 +0000 (UTC)
Received: by mail-ej1-f49.google.com with SMTP id
 a640c23a62f3a-a3f829cde6dso166592666b.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 29 Feb 2024 06:49:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1709218167; x=1709822967; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=S94B7xAa/xAYptwLhEse1W2bq7IhDwhBnsYGME/INPg=;
 b=HALzbYYxedwWJ10oOC6eG9pEdL2W7xjXXZ7L/EUjf0FS2gJshu937VTuQ2ht360vcD
 Rdn3K4dTWRri85/Yt4EWESeY89x68Y2FCfIlzNk9DHE2Tw+dNdxiHebZrZ0D13NdLZNx
 gha99hdVCLbCwjpyClWSLNhFftsdR/IKtm2HKMtQ33xFzOeinMUBOy5P9KWtu1MaRwDd
 SWTrNxyXMOYp+u3f0XWSAbknWuLWmkpC+VB9iBVc1tFxaO87n9jRdFOnKns2fRQOhZix
 36gQNXTWaU9hKBdfC8bV62L6IyT4wKoGXpzIvj4d/sy5bQGS5DqHsVjTF8g9mr/CZnJ+
 HdEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709218167; x=1709822967;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=S94B7xAa/xAYptwLhEse1W2bq7IhDwhBnsYGME/INPg=;
 b=OL9yC3AdhkuNFjIOjf8CSHzd4wEIh2qcQd43QbKqDQtWpmfIDoKTr2mgyOVi+u5HrY
 yCN65aryOI8s8aidijfaBPmnquIGPLkVYPHebMPuAR39QB+miGIQ0hbQyu5mM1EE6hhk
 8sQSTHke8jCcPDWYoJPH/y1/YNlhlGFlSK87Nh+1qGAGPcxycgiA9rKdTxuUA5UsykGz
 aP+r94Lr17w+RmAzl2GL9kUi8q63UaXaoZk/pIW8ynPGhoPwMtik/5gCbtEE159m7uB1
 it1LPFf8GnYG6gHiV9tsBG0loVDTmXLRxI9/lLzKO4LEERaDn/i6wGRxh+mIdOWp09gC
 Ej6w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWT//Alj+JsTVirZs1iykRhU2JYlKzk4MPKEljkUSlEtZdtd2gF9VIZroHqDI+XxNcu5eAAq3aNTFeOQGcq8pBd9mbKjMHHca+NkDsTsg==
X-Gm-Message-State: AOJu0YyYbSyh58jygVxxr2UzZrcaCVk3iiINU6+Lcn7ok2fgv/LdME28
 WTiLwurA5UYsBwKoOGhK5JhpsOh73fCZsooVJovzqrYbVheKeJT5
X-Google-Smtp-Source: AGHT+IGblVtnMWsSRN+X1G66O5XSu6EKE/sgCVgC1qM6wy/ugGOMf15Dfak8aM3IpUTFfnAS036kTQ==
X-Received: by 2002:a17:906:1c82:b0:a44:55e8:5413 with SMTP id
 g2-20020a1709061c8200b00a4455e85413mr910928ejh.8.1709218166863; 
 Thu, 29 Feb 2024 06:49:26 -0800 (PST)
Received: from able.fritz.box ([2a00:e180:15dd:1300:6947:88a8:d838:c55])
 by smtp.gmail.com with ESMTPSA id
 jg29-20020a170907971d00b00a4412406741sm749167ejc.131.2024.02.29.06.49.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Feb 2024 06:49:26 -0800 (PST)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: Alexander.Deucher@amd.com,
	amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/2] drm/amdgpu: cleanup conditional execution
Date: Thu, 29 Feb 2024 15:49:24 +0100
Message-Id: <20240229144925.97165-1-christian.koenig@amd.com>
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

First of all calculating the number of dw to patch into a
conditional execution is not something HW generation specific.
This is just standard ring buffer calculations. While at it also
reduce the BUG_ON() into WARN_ON().

Then instead of a random bit pattern use 0 as default value for
the number of dw skipped, this way it's not mandatory any more
to patch the conditional execution.

And last make the address to check a parameter of the
conditional execution instead of getting this from the ring.

Signed-off-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c   | 21 ++++++-----------
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h | 30 ++++++++++++++++++++----
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c   |  8 +++----
 drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c  | 26 +++++---------------
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c   | 28 +++++++---------------
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c   | 27 +++++++--------------
 drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c    | 28 +++++++---------------
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c    | 28 +++++++---------------
 drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c   | 29 +++++++----------------
 drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c   | 29 +++++++----------------
 drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c   | 29 +++++++----------------
 11 files changed, 99 insertions(+), 184 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
index 6aa3b1d845ab..8b512dc28df8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
@@ -131,7 +131,6 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned int num_ibs,
 	struct amdgpu_ib *ib = &ibs[0];
 	struct dma_fence *tmp = NULL;
 	bool need_ctx_switch;
-	unsigned int patch_offset = ~0;
 	struct amdgpu_vm *vm;
 	uint64_t fence_ctx;
 	uint32_t status = 0, alloc_size;
@@ -139,10 +138,11 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned int num_ibs,
 	bool secure, init_shadow;
 	u64 shadow_va, csa_va, gds_va;
 	int vmid = AMDGPU_JOB_GET_VMID(job);
+	bool need_pipe_sync = false;
+	unsigned int cond_exec;
 
 	unsigned int i;
 	int r = 0;
-	bool need_pipe_sync = false;
 
 	if (num_ibs == 0)
 		return -EINVAL;
@@ -228,7 +228,8 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned int num_ibs,
 					    init_shadow, vmid);
 
 	if (ring->funcs->init_cond_exec)
-		patch_offset = amdgpu_ring_init_cond_exec(ring);
+		cond_exec = amdgpu_ring_init_cond_exec(ring,
+						       ring->cond_exe_gpu_addr);
 
 	amdgpu_device_flush_hdp(adev, ring);
 
@@ -278,16 +279,9 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned int num_ibs,
 				       fence_flags | AMDGPU_FENCE_FLAG_64BIT);
 	}
 
-	if (ring->funcs->emit_gfx_shadow) {
+	if (ring->funcs->emit_gfx_shadow && ring->funcs->init_cond_exec) {
 		amdgpu_ring_emit_gfx_shadow(ring, 0, 0, 0, false, 0);
-
-		if (ring->funcs->init_cond_exec) {
-			unsigned int ce_offset = ~0;
-
-			ce_offset = amdgpu_ring_init_cond_exec(ring);
-			if (ce_offset != ~0 && ring->funcs->patch_cond_exec)
-				amdgpu_ring_patch_cond_exec(ring, ce_offset);
-		}
+		amdgpu_ring_init_cond_exec(ring, ring->cond_exe_gpu_addr);
 	}
 
 	r = amdgpu_fence_emit(ring, f, job, fence_flags);
@@ -302,8 +296,7 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned int num_ibs,
 	if (ring->funcs->insert_end)
 		ring->funcs->insert_end(ring);
 
-	if (patch_offset != ~0 && ring->funcs->patch_cond_exec)
-		amdgpu_ring_patch_cond_exec(ring, patch_offset);
+	amdgpu_ring_patch_cond_exec(ring, cond_exec);
 
 	ring->current_ctx = fence_ctx;
 	if (vm && ring->funcs->emit_switch_buffer)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
index fe1a61eb6e4c..756330767909 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
@@ -209,8 +209,7 @@ struct amdgpu_ring_funcs {
 	void (*insert_end)(struct amdgpu_ring *ring);
 	/* pad the indirect buffer to the necessary number of dw */
 	void (*pad_ib)(struct amdgpu_ring *ring, struct amdgpu_ib *ib);
-	unsigned (*init_cond_exec)(struct amdgpu_ring *ring);
-	void (*patch_cond_exec)(struct amdgpu_ring *ring, unsigned offset);
+	unsigned (*init_cond_exec)(struct amdgpu_ring *ring, uint64_t addr);
 	/* note usage for clock and power gating */
 	void (*begin_use)(struct amdgpu_ring *ring);
 	void (*end_use)(struct amdgpu_ring *ring);
@@ -327,8 +326,7 @@ struct amdgpu_ring {
 #define amdgpu_ring_emit_reg_write_reg_wait(r, d0, d1, v, m) (r)->funcs->emit_reg_write_reg_wait((r), (d0), (d1), (v), (m))
 #define amdgpu_ring_emit_frame_cntl(r, b, s) (r)->funcs->emit_frame_cntl((r), (b), (s))
 #define amdgpu_ring_pad_ib(r, ib) ((r)->funcs->pad_ib((r), (ib)))
-#define amdgpu_ring_init_cond_exec(r) (r)->funcs->init_cond_exec((r))
-#define amdgpu_ring_patch_cond_exec(r,o) (r)->funcs->patch_cond_exec((r),(o))
+#define amdgpu_ring_init_cond_exec(r, a) (r)->funcs->init_cond_exec((r), (a))
 #define amdgpu_ring_preempt_ib(r) (r)->funcs->preempt_ib(r)
 #define amdgpu_ring_patch_cntl(r, o) ((r)->funcs->patch_cntl((r), (o)))
 #define amdgpu_ring_patch_ce(r, o) ((r)->funcs->patch_ce((r), (o)))
@@ -411,6 +409,30 @@ static inline void amdgpu_ring_write_multiple(struct amdgpu_ring *ring,
 	ring->count_dw -= count_dw;
 }
 
+/**
+ * amdgpu_ring_patch_cond_exec - patch dw count of conditional execute
+ * @ring: amdgpu_ring structure
+ * @offset: offset returned by amdgpu_ring_init_cond_exec
+ *
+ * Calculate the dw count and patch it into a cond_exec command.
+ */
+static inline void amdgpu_ring_patch_cond_exec(struct amdgpu_ring *ring,
+					       unsigned int offset)
+{
+	unsigned cur;
+
+	if (!ring->funcs->init_cond_exec)
+		return;
+
+	WARN_ON(offset > ring->buf_mask);
+	WARN_ON(ring->ring[offset] != 0);
+
+	cur = (ring->wptr - 1) & ring->buf_mask;
+	if (cur < offset)
+		cur += ring->ring_size >> 2;
+	ring->ring[offset] = cur - offset;
+}
+
 #define amdgpu_mes_ctx_get_offs_gpu_addr(ring, offset)			\
 	(ring->is_mes_queue && ring->mes_ctx ?				\
 	 (ring->mes_ctx->meta_data_gpu_addr + offset) : 0)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index ed4a8c5d26d7..2d7870c8f7ff 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -652,7 +652,7 @@ int amdgpu_vm_flush(struct amdgpu_ring *ring, struct amdgpu_job *job,
 	bool vm_flush_needed = job->vm_needs_flush;
 	struct dma_fence *fence = NULL;
 	bool pasid_mapping_needed = false;
-	unsigned patch_offset = 0;
+	unsigned int patch;
 	int r;
 
 	if (amdgpu_vmid_had_gpu_reset(adev, id)) {
@@ -679,7 +679,8 @@ int amdgpu_vm_flush(struct amdgpu_ring *ring, struct amdgpu_job *job,
 
 	amdgpu_ring_ib_begin(ring);
 	if (ring->funcs->init_cond_exec)
-		patch_offset = amdgpu_ring_init_cond_exec(ring);
+		patch = amdgpu_ring_init_cond_exec(ring,
+						   ring->cond_exe_gpu_addr);
 
 	if (need_pipe_sync)
 		amdgpu_ring_emit_pipeline_sync(ring);
@@ -727,8 +728,7 @@ int amdgpu_vm_flush(struct amdgpu_ring *ring, struct amdgpu_job *job,
 	}
 	dma_fence_put(fence);
 
-	if (ring->funcs->patch_cond_exec)
-		amdgpu_ring_patch_cond_exec(ring, patch_offset);
+	amdgpu_ring_patch_cond_exec(ring, patch);
 
 	/* the double SWITCH_BUFFER here *cannot* be skipped by COND_EXEC */
 	if (ring->funcs->emit_switch_buffer) {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c
index b9a15d51eb5c..8cedee059c8a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c
@@ -546,34 +546,21 @@ static void vpe_ring_emit_vm_flush(struct amdgpu_ring *ring, unsigned int vmid,
 	amdgpu_gmc_emit_flush_gpu_tlb(ring, vmid, pd_addr);
 }
 
-static unsigned int vpe_ring_init_cond_exec(struct amdgpu_ring *ring)
+static unsigned int vpe_ring_init_cond_exec(struct amdgpu_ring *ring,
+					    uint64_t addr)
 {
 	unsigned int ret;
 
 	amdgpu_ring_write(ring, VPE_CMD_HEADER(VPE_CMD_OPCODE_COND_EXE, 0));
-	amdgpu_ring_write(ring, lower_32_bits(ring->cond_exe_gpu_addr));
-	amdgpu_ring_write(ring, upper_32_bits(ring->cond_exe_gpu_addr));
+	amdgpu_ring_write(ring, lower_32_bits(addr));
+	amdgpu_ring_write(ring, upper_32_bits(addr));
 	amdgpu_ring_write(ring, 1);
-	ret = ring->wptr & ring->buf_mask;/* this is the offset we need patch later */
-	amdgpu_ring_write(ring, 0x55aa55aa);/* insert dummy here and patch it later */
+	ret = ring->wptr & ring->buf_mask;
+	amdgpu_ring_write(ring, 0);
 
 	return ret;
 }
 
-static void vpe_ring_patch_cond_exec(struct amdgpu_ring *ring, unsigned int offset)
-{
-	unsigned int cur;
-
-	WARN_ON_ONCE(offset > ring->buf_mask);
-	WARN_ON_ONCE(ring->ring[offset] != 0x55aa55aa);
-
-	cur = (ring->wptr - 1) & ring->buf_mask;
-	if (cur > offset)
-		ring->ring[offset] = cur - offset;
-	else
-		ring->ring[offset] = (ring->buf_mask + 1) - offset + cur;
-}
-
 static int vpe_ring_preempt_ib(struct amdgpu_ring *ring)
 {
 	struct amdgpu_device *adev = ring->adev;
@@ -864,7 +851,6 @@ static const struct amdgpu_ring_funcs vpe_ring_funcs = {
 	.test_ring = vpe_ring_test_ring,
 	.test_ib = vpe_ring_test_ib,
 	.init_cond_exec = vpe_ring_init_cond_exec,
-	.patch_cond_exec = vpe_ring_patch_cond_exec,
 	.preempt_ib = vpe_ring_preempt_ib,
 	.begin_use = vpe_ring_begin_use,
 	.end_use = vpe_ring_end_use,
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index 691fa40e4e01..904b9ff5ead2 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -8542,34 +8542,23 @@ static void gfx_v10_0_ring_emit_cntxcntl(struct amdgpu_ring *ring,
 	amdgpu_ring_write(ring, 0);
 }
 
-static unsigned int gfx_v10_0_ring_emit_init_cond_exec(struct amdgpu_ring *ring)
+static unsigned int gfx_v10_0_ring_emit_init_cond_exec(struct amdgpu_ring *ring,
+						       uint64_t addr)
 {
 	unsigned int ret;
 
 	amdgpu_ring_write(ring, PACKET3(PACKET3_COND_EXEC, 3));
-	amdgpu_ring_write(ring, lower_32_bits(ring->cond_exe_gpu_addr));
-	amdgpu_ring_write(ring, upper_32_bits(ring->cond_exe_gpu_addr));
-	amdgpu_ring_write(ring, 0); /* discard following DWs if *cond_exec_gpu_addr==0 */
+	amdgpu_ring_write(ring, lower_32_bits(addr));
+	amdgpu_ring_write(ring, upper_32_bits(addr));
+	/* discard following DWs if *cond_exec_gpu_addr==0 */
+	amdgpu_ring_write(ring, 0);
 	ret = ring->wptr & ring->buf_mask;
-	amdgpu_ring_write(ring, 0x55aa55aa); /* patch dummy value later */
+	/* patch dummy value later */
+	amdgpu_ring_write(ring, 0);
 
 	return ret;
 }
 
-static void gfx_v10_0_ring_emit_patch_cond_exec(struct amdgpu_ring *ring, unsigned int offset)
-{
-	unsigned int cur;
-
-	BUG_ON(offset > ring->buf_mask);
-	BUG_ON(ring->ring[offset] != 0x55aa55aa);
-
-	cur = (ring->wptr - 1) & ring->buf_mask;
-	if (likely(cur > offset))
-		ring->ring[offset] = cur - offset;
-	else
-		ring->ring[offset] = (ring->buf_mask + 1) - offset + cur;
-}
-
 static int gfx_v10_0_ring_preempt_ib(struct amdgpu_ring *ring)
 {
 	int i, r = 0;
@@ -9224,7 +9213,6 @@ static const struct amdgpu_ring_funcs gfx_v10_0_ring_funcs_gfx = {
 	.emit_switch_buffer = gfx_v10_0_ring_emit_sb,
 	.emit_cntxcntl = gfx_v10_0_ring_emit_cntxcntl,
 	.init_cond_exec = gfx_v10_0_ring_emit_init_cond_exec,
-	.patch_cond_exec = gfx_v10_0_ring_emit_patch_cond_exec,
 	.preempt_ib = gfx_v10_0_ring_preempt_ib,
 	.emit_frame_cntl = gfx_v10_0_ring_emit_frame_cntl,
 	.emit_wreg = gfx_v10_0_ring_emit_wreg,
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index 0d90d60a21d6..2ccbdee570cf 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -5533,33 +5533,23 @@ static void gfx_v11_0_ring_emit_gfx_shadow(struct amdgpu_ring *ring,
 			  PACKET3_SET_Q_PREEMPTION_MODE_INIT_SHADOW_MEM : 0);
 }
 
-static unsigned gfx_v11_0_ring_emit_init_cond_exec(struct amdgpu_ring *ring)
+static unsigned gfx_v11_0_ring_emit_init_cond_exec(struct amdgpu_ring *ring,
+						   uint64_t addr)
 {
 	unsigned ret;
 
 	amdgpu_ring_write(ring, PACKET3(PACKET3_COND_EXEC, 3));
-	amdgpu_ring_write(ring, lower_32_bits(ring->cond_exe_gpu_addr));
-	amdgpu_ring_write(ring, upper_32_bits(ring->cond_exe_gpu_addr));
-	amdgpu_ring_write(ring, 0); /* discard following DWs if *cond_exec_gpu_addr==0 */
+	amdgpu_ring_write(ring, lower_32_bits(addr));
+	amdgpu_ring_write(ring, upper_32_bits(addr));
+	/* discard following DWs if *cond_exec_gpu_addr==0 */
+	amdgpu_ring_write(ring, 0);
 	ret = ring->wptr & ring->buf_mask;
-	amdgpu_ring_write(ring, 0x55aa55aa); /* patch dummy value later */
+	/* patch dummy value later */
+	amdgpu_ring_write(ring, 0);
 
 	return ret;
 }
 
-static void gfx_v11_0_ring_emit_patch_cond_exec(struct amdgpu_ring *ring, unsigned offset)
-{
-	unsigned cur;
-	BUG_ON(offset > ring->buf_mask);
-	BUG_ON(ring->ring[offset] != 0x55aa55aa);
-
-	cur = (ring->wptr - 1) & ring->buf_mask;
-	if (likely(cur > offset))
-		ring->ring[offset] = cur - offset;
-	else
-		ring->ring[offset] = (ring->buf_mask + 1) - offset + cur;
-}
-
 static int gfx_v11_0_ring_preempt_ib(struct amdgpu_ring *ring)
 {
 	int i, r = 0;
@@ -6153,7 +6143,6 @@ static const struct amdgpu_ring_funcs gfx_v11_0_ring_funcs_gfx = {
 	.emit_cntxcntl = gfx_v11_0_ring_emit_cntxcntl,
 	.emit_gfx_shadow = gfx_v11_0_ring_emit_gfx_shadow,
 	.init_cond_exec = gfx_v11_0_ring_emit_init_cond_exec,
-	.patch_cond_exec = gfx_v11_0_ring_emit_patch_cond_exec,
 	.preempt_ib = gfx_v11_0_ring_preempt_ib,
 	.emit_frame_cntl = gfx_v11_0_ring_emit_frame_cntl,
 	.emit_wreg = gfx_v11_0_ring_emit_wreg,
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
index b97ea62212b6..202ddda57f98 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
@@ -6326,33 +6326,22 @@ static void gfx_v8_ring_emit_cntxcntl(struct amdgpu_ring *ring, uint32_t flags)
 	amdgpu_ring_write(ring, 0);
 }
 
-static unsigned gfx_v8_0_ring_emit_init_cond_exec(struct amdgpu_ring *ring)
+static unsigned gfx_v8_0_ring_emit_init_cond_exec(struct amdgpu_ring *ring,
+						  uint64_t addr)
 {
 	unsigned ret;
 
 	amdgpu_ring_write(ring, PACKET3(PACKET3_COND_EXEC, 3));
-	amdgpu_ring_write(ring, lower_32_bits(ring->cond_exe_gpu_addr));
-	amdgpu_ring_write(ring, upper_32_bits(ring->cond_exe_gpu_addr));
-	amdgpu_ring_write(ring, 0); /* discard following DWs if *cond_exec_gpu_addr==0 */
+	amdgpu_ring_write(ring, lower_32_bits(addr));
+	amdgpu_ring_write(ring, upper_32_bits(addr));
+	/* discard following DWs if *cond_exec_gpu_addr==0 */
+	amdgpu_ring_write(ring, 0);
 	ret = ring->wptr & ring->buf_mask;
-	amdgpu_ring_write(ring, 0x55aa55aa); /* patch dummy value later */
+	/* patch dummy value later */
+	amdgpu_ring_write(ring, 0);
 	return ret;
 }
 
-static void gfx_v8_0_ring_emit_patch_cond_exec(struct amdgpu_ring *ring, unsigned offset)
-{
-	unsigned cur;
-
-	BUG_ON(offset > ring->buf_mask);
-	BUG_ON(ring->ring[offset] != 0x55aa55aa);
-
-	cur = (ring->wptr & ring->buf_mask) - 1;
-	if (likely(cur > offset))
-		ring->ring[offset] = cur - offset;
-	else
-		ring->ring[offset] = (ring->ring_size >> 2) - offset + cur;
-}
-
 static void gfx_v8_0_ring_emit_rreg(struct amdgpu_ring *ring, uint32_t reg,
 				    uint32_t reg_val_offs)
 {
@@ -6932,7 +6921,6 @@ static const struct amdgpu_ring_funcs gfx_v8_0_ring_funcs_gfx = {
 	.emit_switch_buffer = gfx_v8_ring_emit_sb,
 	.emit_cntxcntl = gfx_v8_ring_emit_cntxcntl,
 	.init_cond_exec = gfx_v8_0_ring_emit_init_cond_exec,
-	.patch_cond_exec = gfx_v8_0_ring_emit_patch_cond_exec,
 	.emit_wreg = gfx_v8_0_ring_emit_wreg,
 	.soft_recovery = gfx_v8_0_ring_soft_recovery,
 	.emit_mem_sync = gfx_v8_0_emit_mem_sync,
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index 7669f82aa1da..1753b903ad8a 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -5610,31 +5610,21 @@ static void gfx_v9_ring_emit_cntxcntl(struct amdgpu_ring *ring, uint32_t flags)
 	amdgpu_ring_write(ring, 0);
 }
 
-static unsigned gfx_v9_0_ring_emit_init_cond_exec(struct amdgpu_ring *ring)
+static unsigned gfx_v9_0_ring_emit_init_cond_exec(struct amdgpu_ring *ring,
+						  uint64_t addr)
 {
 	unsigned ret;
 	amdgpu_ring_write(ring, PACKET3(PACKET3_COND_EXEC, 3));
-	amdgpu_ring_write(ring, lower_32_bits(ring->cond_exe_gpu_addr));
-	amdgpu_ring_write(ring, upper_32_bits(ring->cond_exe_gpu_addr));
-	amdgpu_ring_write(ring, 0); /* discard following DWs if *cond_exec_gpu_addr==0 */
+	amdgpu_ring_write(ring, lower_32_bits(addr));
+	amdgpu_ring_write(ring, upper_32_bits(addr));
+	/* discard following DWs if *cond_exec_gpu_addr==0 */
+	amdgpu_ring_write(ring, 0);
 	ret = ring->wptr & ring->buf_mask;
-	amdgpu_ring_write(ring, 0x55aa55aa); /* patch dummy value later */
+	/* patch dummy value later */
+	amdgpu_ring_write(ring, 0);
 	return ret;
 }
 
-static void gfx_v9_0_ring_emit_patch_cond_exec(struct amdgpu_ring *ring, unsigned offset)
-{
-	unsigned cur;
-	BUG_ON(offset > ring->buf_mask);
-	BUG_ON(ring->ring[offset] != 0x55aa55aa);
-
-	cur = (ring->wptr - 1) & ring->buf_mask;
-	if (likely(cur > offset))
-		ring->ring[offset] = cur - offset;
-	else
-		ring->ring[offset] = (ring->ring_size>>2) - offset + cur;
-}
-
 static void gfx_v9_0_ring_emit_rreg(struct amdgpu_ring *ring, uint32_t reg,
 				    uint32_t reg_val_offs)
 {
@@ -6908,7 +6898,6 @@ static const struct amdgpu_ring_funcs gfx_v9_0_ring_funcs_gfx = {
 	.emit_switch_buffer = gfx_v9_ring_emit_sb,
 	.emit_cntxcntl = gfx_v9_ring_emit_cntxcntl,
 	.init_cond_exec = gfx_v9_0_ring_emit_init_cond_exec,
-	.patch_cond_exec = gfx_v9_0_ring_emit_patch_cond_exec,
 	.preempt_ib = gfx_v9_0_ring_preempt_ib,
 	.emit_frame_cntl = gfx_v9_0_ring_emit_frame_cntl,
 	.emit_wreg = gfx_v9_0_ring_emit_wreg,
@@ -6963,7 +6952,6 @@ static const struct amdgpu_ring_funcs gfx_v9_0_sw_ring_funcs_gfx = {
 	.emit_switch_buffer = gfx_v9_ring_emit_sb,
 	.emit_cntxcntl = gfx_v9_ring_emit_cntxcntl,
 	.init_cond_exec = gfx_v9_0_ring_emit_init_cond_exec,
-	.patch_cond_exec = gfx_v9_0_ring_emit_patch_cond_exec,
 	.emit_frame_cntl = gfx_v9_0_ring_emit_frame_cntl,
 	.emit_wreg = gfx_v9_0_ring_emit_wreg,
 	.emit_reg_wait = gfx_v9_0_ring_emit_reg_wait,
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
index 3c485e5a531a..883e8a1b8a40 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
@@ -249,35 +249,23 @@ static int sdma_v5_0_init_microcode(struct amdgpu_device *adev)
 	return ret;
 }
 
-static unsigned sdma_v5_0_ring_init_cond_exec(struct amdgpu_ring *ring)
+static unsigned sdma_v5_0_ring_init_cond_exec(struct amdgpu_ring *ring,
+					      uint64_t addr)
 {
 	unsigned ret;
 
 	amdgpu_ring_write(ring, SDMA_PKT_HEADER_OP(SDMA_OP_COND_EXE));
-	amdgpu_ring_write(ring, lower_32_bits(ring->cond_exe_gpu_addr));
-	amdgpu_ring_write(ring, upper_32_bits(ring->cond_exe_gpu_addr));
+	amdgpu_ring_write(ring, lower_32_bits(addr));
+	amdgpu_ring_write(ring, upper_32_bits(addr));
 	amdgpu_ring_write(ring, 1);
-	ret = ring->wptr & ring->buf_mask;/* this is the offset we need patch later */
-	amdgpu_ring_write(ring, 0x55aa55aa);/* insert dummy here and patch it later */
+	/* this is the offset we need patch later */
+	ret = ring->wptr & ring->buf_mask;
+	/* insert dummy here and patch it later */
+	amdgpu_ring_write(ring, 0);
 
 	return ret;
 }
 
-static void sdma_v5_0_ring_patch_cond_exec(struct amdgpu_ring *ring,
-					   unsigned offset)
-{
-	unsigned cur;
-
-	BUG_ON(offset > ring->buf_mask);
-	BUG_ON(ring->ring[offset] != 0x55aa55aa);
-
-	cur = (ring->wptr - 1) & ring->buf_mask;
-	if (cur > offset)
-		ring->ring[offset] = cur - offset;
-	else
-		ring->ring[offset] = (ring->buf_mask + 1) - offset + cur;
-}
-
 /**
  * sdma_v5_0_ring_get_rptr - get the current read pointer
  *
@@ -1780,7 +1768,6 @@ static const struct amdgpu_ring_funcs sdma_v5_0_ring_funcs = {
 	.emit_reg_wait = sdma_v5_0_ring_emit_reg_wait,
 	.emit_reg_write_reg_wait = sdma_v5_0_ring_emit_reg_write_reg_wait,
 	.init_cond_exec = sdma_v5_0_ring_init_cond_exec,
-	.patch_cond_exec = sdma_v5_0_ring_patch_cond_exec,
 	.preempt_ib = sdma_v5_0_ring_preempt_ib,
 };
 
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
index 0058f3f7cf6e..42f4bd250def 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
@@ -89,35 +89,23 @@ static u32 sdma_v5_2_get_reg_offset(struct amdgpu_device *adev, u32 instance, u3
 	return base + internal_offset;
 }
 
-static unsigned sdma_v5_2_ring_init_cond_exec(struct amdgpu_ring *ring)
+static unsigned sdma_v5_2_ring_init_cond_exec(struct amdgpu_ring *ring,
+					      uint64_t addr)
 {
 	unsigned ret;
 
 	amdgpu_ring_write(ring, SDMA_PKT_HEADER_OP(SDMA_OP_COND_EXE));
-	amdgpu_ring_write(ring, lower_32_bits(ring->cond_exe_gpu_addr));
-	amdgpu_ring_write(ring, upper_32_bits(ring->cond_exe_gpu_addr));
+	amdgpu_ring_write(ring, lower_32_bits(addr));
+	amdgpu_ring_write(ring, upper_32_bits(addr));
 	amdgpu_ring_write(ring, 1);
-	ret = ring->wptr & ring->buf_mask;/* this is the offset we need patch later */
-	amdgpu_ring_write(ring, 0x55aa55aa);/* insert dummy here and patch it later */
+	/* this is the offset we need patch later */
+	ret = ring->wptr & ring->buf_mask;
+	/* insert dummy here and patch it later */
+	amdgpu_ring_write(ring, 0);
 
 	return ret;
 }
 
-static void sdma_v5_2_ring_patch_cond_exec(struct amdgpu_ring *ring,
-					   unsigned offset)
-{
-	unsigned cur;
-
-	BUG_ON(offset > ring->buf_mask);
-	BUG_ON(ring->ring[offset] != 0x55aa55aa);
-
-	cur = (ring->wptr - 1) & ring->buf_mask;
-	if (cur > offset)
-		ring->ring[offset] = cur - offset;
-	else
-		ring->ring[offset] = (ring->buf_mask + 1) - offset + cur;
-}
-
 /**
  * sdma_v5_2_ring_get_rptr - get the current read pointer
  *
@@ -1722,7 +1710,6 @@ static const struct amdgpu_ring_funcs sdma_v5_2_ring_funcs = {
 	.emit_reg_wait = sdma_v5_2_ring_emit_reg_wait,
 	.emit_reg_write_reg_wait = sdma_v5_2_ring_emit_reg_write_reg_wait,
 	.init_cond_exec = sdma_v5_2_ring_init_cond_exec,
-	.patch_cond_exec = sdma_v5_2_ring_patch_cond_exec,
 	.preempt_ib = sdma_v5_2_ring_preempt_ib,
 };
 
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
index 4874ded45653..361835a61f2e 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
@@ -80,35 +80,23 @@ static u32 sdma_v6_0_get_reg_offset(struct amdgpu_device *adev, u32 instance, u3
 	return base + internal_offset;
 }
 
-static unsigned sdma_v6_0_ring_init_cond_exec(struct amdgpu_ring *ring)
+static unsigned sdma_v6_0_ring_init_cond_exec(struct amdgpu_ring *ring,
+					      uint64_t addr)
 {
 	unsigned ret;
 
 	amdgpu_ring_write(ring, SDMA_PKT_COPY_LINEAR_HEADER_OP(SDMA_OP_COND_EXE));
-	amdgpu_ring_write(ring, lower_32_bits(ring->cond_exe_gpu_addr));
-	amdgpu_ring_write(ring, upper_32_bits(ring->cond_exe_gpu_addr));
+	amdgpu_ring_write(ring, lower_32_bits(addr));
+	amdgpu_ring_write(ring, upper_32_bits(addr));
 	amdgpu_ring_write(ring, 1);
-	ret = ring->wptr & ring->buf_mask;/* this is the offset we need patch later */
-	amdgpu_ring_write(ring, 0x55aa55aa);/* insert dummy here and patch it later */
+	/* this is the offset we need patch later */
+	ret = ring->wptr & ring->buf_mask;
+	/* insert dummy here and patch it later */
+	amdgpu_ring_write(ring, 0);
 
 	return ret;
 }
 
-static void sdma_v6_0_ring_patch_cond_exec(struct amdgpu_ring *ring,
-					   unsigned offset)
-{
-	unsigned cur;
-
-	BUG_ON(offset > ring->buf_mask);
-	BUG_ON(ring->ring[offset] != 0x55aa55aa);
-
-	cur = (ring->wptr - 1) & ring->buf_mask;
-	if (cur > offset)
-		ring->ring[offset] = cur - offset;
-	else
-		ring->ring[offset] = (ring->buf_mask + 1) - offset + cur;
-}
-
 /**
  * sdma_v6_0_ring_get_rptr - get the current read pointer
  *
@@ -1542,7 +1530,6 @@ static const struct amdgpu_ring_funcs sdma_v6_0_ring_funcs = {
 	.emit_reg_wait = sdma_v6_0_ring_emit_reg_wait,
 	.emit_reg_write_reg_wait = sdma_v6_0_ring_emit_reg_write_reg_wait,
 	.init_cond_exec = sdma_v6_0_ring_init_cond_exec,
-	.patch_cond_exec = sdma_v6_0_ring_patch_cond_exec,
 	.preempt_ib = sdma_v6_0_ring_preempt_ib,
 };
 
-- 
2.34.1

