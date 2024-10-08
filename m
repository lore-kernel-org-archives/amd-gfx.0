Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A152FCEFC24
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Oct 2024 15:05:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4EB8110E577;
	Tue,  8 Oct 2024 15:05:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="LHF5xy2F";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D22B610E577
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Oct 2024 15:05:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=ELTM2LPEuUFnPHoRY5La+wEt7tkPqKZmB4VycCqVKTY=; b=LHF5xy2FH313yKKu3vq8YmNWGT
 6q8/KzYP03DQMqNqev2l/SfpI8VMfrjzM5lgTl8s8UsO5h1FeuJMlsS16kHJ8gd1j20WTDzrx8LoC
 FnjSPS4tlvlFvqTrwAqGmZbUMOsa8NC/BSTQ3GgIDnMInKhXx6pbK/WTj3RU/l2tHjVhhwpptYB0d
 q5ZJ+tmbYfPlJuwTF3g7lC98smFPAUoxrsAGnqZEQY+wijuDQdAUNJnuucB5ApSpJTA2lnpIMt1y2
 hiPHKMU/RjNyre/z6L6dCJAVvDbk8qK+oBCREkt9W83mhOtv/XpSh5Zzp3y5gzryC7dCKcqg1N3J8
 UdHYCbdw==;
Received: from [90.241.98.187] (helo=localhost)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1syBmV-006bkn-2Y; Tue, 08 Oct 2024 17:05:47 +0200
From: Tvrtko Ursulin <tursulin@igalia.com>
To: amd-gfx@lists.freedesktop.org
Cc: kernel-dev@igalia.com, Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 Sunil Khatri <sunil.khatri@amd.com>
Subject: [PATCH 1/4] drm/amdgpu: More efficient ring padding
Date: Tue,  8 Oct 2024 16:05:29 +0100
Message-ID: <20241008150532.23661-2-tursulin@igalia.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20241008150532.23661-1-tursulin@igalia.com>
References: <20241008150532.23661-1-tursulin@igalia.com>
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

From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>

Having noticed that typically 200+ nops per submission are written into
the ring, using a rather verbose one-nop-at-a-time-plus-ring-buffer-
arithmetic as done in amdgpu_ring_write(), the obvious idea was to
improve it by filling those nops in blocks.

This patch therefore adds the amdgpu_ring_fill() helper which can do the
business in at most two memset32 calls.

The performance gains are not that amazing for normal workloads though.
For instance a game which results in two submissions per frame, each pads
with 222 nops, submission worker thread profile changes from:

+   90.78%     0.67%  kworker/u32:3-e  [kernel.kallsyms]  [k] process_one_work
+   48.92%     0.12%  kworker/u32:3-e  [kernel.kallsyms]  [k] commit_tail
+   41.18%     1.73%  kworker/u32:3-e  [kernel.kallsyms]  [k] amdgpu_dm_atomic_commit_tail
-   30.31%     0.67%  kworker/u32:3-e  [kernel.kallsyms]  [k] drm_sched_run_job_work
   - 29.63% drm_sched_run_job_work
      + 8.55% dma_fence_add_callback
      - 7.50% amdgpu_job_run
         - 7.43% amdgpu_ib_schedule
            - 2.46% amdgpu_ring_commit
                 1.44% amdgpu_ring_insert_nop

To:

+   88.28%     0.21%  kworker/u32:4-e  [kernel.kallsyms]  [k] process_one_work
+   45.22%     0.12%  kworker/u32:4-e  [kernel.kallsyms]  [k] commit_tail
+   37.93%     1.86%  kworker/u32:4-e  [kernel.kallsyms]  [k] amdgpu_dm_atomic_commit_tail
-   29.28%     1.11%  kworker/u32:4-e  [kernel.kallsyms]  [k] drm_sched_run_job_work
   - 28.16% drm_sched_run_job_work
      + 9.93% dma_fence_add_callback
      - 6.84% amdgpu_job_run
         - 6.27% amdgpu_ib_schedule
              1.23% gfx_v10_0_ring_emit_fence
              1.20% amdgpu_ring_commit

But if we run a more "spammy" workload, which does several orders of
magnitude more submissions second we go from:

+   79.38%     1.66%  kworker/u32:1+e  [kernel.kallsyms]  [k] process_one_work
-   63.13%     6.66%  kworker/u32:1+e  [kernel.kallsyms]  [k] drm_sched_run_job_work
   - 56.47% drm_sched_run_job_work
      - 25.67% amdgpu_job_run
         - 24.40% amdgpu_ib_schedule
            - 15.29% amdgpu_ring_commit
                 12.06% amdgpu_ring_insert_nop

To:

+   77.83%     2.07%  kworker/u32:2-e  [kernel.kallsyms]  [k] process_one_work
-   61.03%     7.75%  kworker/u32:2-e  [kernel.kallsyms]  [k] drm_sched_run_job_work
   - 53.27% drm_sched_run_job_work
      - 17.31% amdgpu_job_run
         - 16.34% amdgpu_ib_schedule
            - 7.17% amdgpu_ring_commit
                 1.67% amdgpu_ring_insert_nop

Which is a noticeable improvement in time spent by amdgpu_ring_commit
inserting nops.

v2:
 * Use a much more sensible "fill" approach.

v3:
 * Forgot to git add.

v4:
 * Fix amdgpu_ring_generic_pad_ib.

v5:
 * Rebase after HW ring padding optimisation landed.

Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Cc: Christian König <ckoenig.leichtzumerken@gmail.com>
Cc: Sunil Khatri <sunil.khatri@amd.com>

squash

Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c | 19 +++++++++++++----
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h | 27 ++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c  | 13 ++++++------
 drivers/gpu/drm/amd/amdgpu/cik_sdma.c    | 15 +++++++------
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c   |  7 +++---
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c   |  7 +++---
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c   |  7 +++---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c    |  7 +++---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c  |  7 +++---
 drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c   | 16 ++++++++------
 drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c   | 16 ++++++++------
 drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c   | 16 ++++++++------
 drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c | 16 ++++++++------
 drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c   | 16 ++++++++------
 drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c   | 16 ++++++++------
 drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c   | 16 ++++++++------
 drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c   | 16 ++++++++------
 17 files changed, 143 insertions(+), 94 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
index 690976665cf6..7b6590009ac8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
@@ -108,9 +108,12 @@ int amdgpu_ring_alloc(struct amdgpu_ring *ring, unsigned int ndw)
  */
 void amdgpu_ring_insert_nop(struct amdgpu_ring *ring, uint32_t count)
 {
-	int i;
+	if (count == 0)
+		return;
 
-	for (i = 0; i < count; i++)
+	if (count > 1)
+		amdgpu_ring_fill(ring, ring->funcs->nop, count);
+	else
 		amdgpu_ring_write(ring, ring->funcs->nop);
 }
 
@@ -124,8 +127,16 @@ void amdgpu_ring_insert_nop(struct amdgpu_ring *ring, uint32_t count)
  */
 void amdgpu_ring_generic_pad_ib(struct amdgpu_ring *ring, struct amdgpu_ib *ib)
 {
-	while (ib->length_dw & ring->funcs->align_mask)
-		ib->ptr[ib->length_dw++] = ring->funcs->nop;
+	u32 align_mask = ring->funcs->align_mask;
+	u32 count = ib->length_dw & align_mask;
+
+	if (count) {
+		count = align_mask + 1 - count;
+
+		memset32(&ib->ptr[ib->length_dw], ring->funcs->nop, count);
+
+		ib->length_dw += count;
+	}
 }
 
 /**
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
index f93f51002201..36c4bae448e0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
@@ -415,6 +415,33 @@ static inline void amdgpu_ring_write_multiple(struct amdgpu_ring *ring,
 	ring->count_dw -= count_dw;
 }
 
+static inline void amdgpu_ring_fill(struct amdgpu_ring *ring, u32 v,
+				    unsigned int count_dw)
+{
+	unsigned int occupied, chunk1, chunk2;
+
+	if (!count_dw)
+		return;
+
+	if (unlikely(ring->count_dw < count_dw))
+		DRM_ERROR("amdgpu: writing more dwords to the ring than expected!\n");
+
+	occupied = ring->wptr & ring->buf_mask;
+	chunk1 = ring->buf_mask + 1 - occupied;
+	chunk1 = (chunk1 >= count_dw) ? count_dw : chunk1;
+	chunk2 = count_dw - chunk1;
+
+	if (chunk1)
+		memset32((u32 *)&ring->ring[occupied], v, chunk1);
+
+	if (chunk2)
+		memset32((u32 *)&ring->ring[0], v, chunk2);
+
+	ring->wptr += count_dw;
+	ring->wptr &= ring->ptr_mask;
+	ring->count_dw -= count_dw;
+}
+
 /**
  * amdgpu_ring_patch_cond_exec - patch dw count of conditional execute
  * @ring: amdgpu_ring structure
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c
index 5acd20ff5979..01be9036fb91 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c
@@ -452,14 +452,13 @@ static int vpe_resume(void *handle)
 
 static void vpe_ring_insert_nop(struct amdgpu_ring *ring, uint32_t count)
 {
-	int i;
+	const u32 nop = ring->funcs->nop;
 
-	for (i = 0; i < count; i++)
-		if (i == 0)
-			amdgpu_ring_write(ring, ring->funcs->nop |
-				VPE_CMD_NOP_HEADER_COUNT(count - 1));
-		else
-			amdgpu_ring_write(ring, ring->funcs->nop);
+	if (!count)
+		return;
+
+	amdgpu_ring_write(ring, nop | VPE_CMD_NOP_HEADER_COUNT(--count));
+	amdgpu_ring_fill(ring, nop, count);
 }
 
 static uint64_t vpe_get_csa_mc_addr(struct amdgpu_ring *ring, uint32_t vmid)
diff --git a/drivers/gpu/drm/amd/amdgpu/cik_sdma.c b/drivers/gpu/drm/amd/amdgpu/cik_sdma.c
index 952737de9411..1056a35fb19c 100644
--- a/drivers/gpu/drm/amd/amdgpu/cik_sdma.c
+++ b/drivers/gpu/drm/amd/amdgpu/cik_sdma.c
@@ -198,14 +198,15 @@ static void cik_sdma_ring_set_wptr(struct amdgpu_ring *ring)
 static void cik_sdma_ring_insert_nop(struct amdgpu_ring *ring, uint32_t count)
 {
 	struct amdgpu_sdma_instance *sdma = amdgpu_sdma_get_instance_from_ring(ring);
-	int i;
+	const u32 nop = ring->funcs->nop;
 
-	for (i = 0; i < count; i++)
-		if (sdma && sdma->burst_nop && (i == 0))
-			amdgpu_ring_write(ring, ring->funcs->nop |
-					  SDMA_NOP_COUNT(count - 1));
-		else
-			amdgpu_ring_write(ring, ring->funcs->nop);
+	if (!count)
+		return;
+
+	if (sdma && sdma->burst_nop)
+		amdgpu_ring_write(ring, nop | SDMA_NOP_COUNT(--count));
+
+	amdgpu_ring_fill(ring, nop, count);
 }
 
 /**
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index 45ed97038df0..e37a2ac1f03c 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -9402,11 +9402,11 @@ static void gfx_v10_0_emit_mem_sync(struct amdgpu_ring *ring)
 
 static void gfx_v10_ring_insert_nop(struct amdgpu_ring *ring, uint32_t num_nop)
 {
-	int i;
+	const u32 nop = ring->funcs->nop;
 
 	/* Header itself is a NOP packet */
 	if (num_nop == 1) {
-		amdgpu_ring_write(ring, ring->funcs->nop);
+		amdgpu_ring_write(ring, nop);
 		return;
 	}
 
@@ -9414,8 +9414,7 @@ static void gfx_v10_ring_insert_nop(struct amdgpu_ring *ring, uint32_t num_nop)
 	amdgpu_ring_write(ring, PACKET3(PACKET3_NOP, min(num_nop - 2, 0x3ffe)));
 
 	/* Header is at index 0, followed by num_nops - 1 NOP packet's */
-	for (i = 1; i < num_nop; i++)
-		amdgpu_ring_write(ring, ring->funcs->nop);
+	amdgpu_ring_fill(ring, nop, num_nop - 1);
 }
 
 static int gfx_v10_0_reset_kgq(struct amdgpu_ring *ring, unsigned int vmid)
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index d3e8be82a172..d67f2a2bcc81 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -483,11 +483,11 @@ static void gfx_v11_0_wait_reg_mem(struct amdgpu_ring *ring, int eng_sel,
 
 static void gfx_v11_ring_insert_nop(struct amdgpu_ring *ring, uint32_t num_nop)
 {
-	int i;
+	const u32 nop = ring->funcs->nop;
 
 	/* Header itself is a NOP packet */
 	if (num_nop == 1) {
-		amdgpu_ring_write(ring, ring->funcs->nop);
+		amdgpu_ring_write(ring, nop);
 		return;
 	}
 
@@ -495,8 +495,7 @@ static void gfx_v11_ring_insert_nop(struct amdgpu_ring *ring, uint32_t num_nop)
 	amdgpu_ring_write(ring, PACKET3(PACKET3_NOP, min(num_nop - 2, 0x3ffe)));
 
 	/* Header is at index 0, followed by num_nops - 1 NOP packet's */
-	for (i = 1; i < num_nop; i++)
-		amdgpu_ring_write(ring, ring->funcs->nop);
+	amdgpu_ring_fill(ring, nop, num_nop - 1);
 }
 
 static int gfx_v11_0_ring_test_ring(struct amdgpu_ring *ring)
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
index 47b47d21f464..8ce6b89315b1 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
@@ -5022,11 +5022,11 @@ static void gfx_v12_0_emit_mem_sync(struct amdgpu_ring *ring)
 
 static void gfx_v12_ring_insert_nop(struct amdgpu_ring *ring, uint32_t num_nop)
 {
-	int i;
+	const u32 nop = ring->funcs->nop;
 
 	/* Header itself is a NOP packet */
 	if (num_nop == 1) {
-		amdgpu_ring_write(ring, ring->funcs->nop);
+		amdgpu_ring_write(ring, nop);
 		return;
 	}
 
@@ -5034,8 +5034,7 @@ static void gfx_v12_ring_insert_nop(struct amdgpu_ring *ring, uint32_t num_nop)
 	amdgpu_ring_write(ring, PACKET3(PACKET3_NOP, min(num_nop - 2, 0x3ffe)));
 
 	/* Header is at index 0, followed by num_nops - 1 NOP packet's */
-	for (i = 1; i < num_nop; i++)
-		amdgpu_ring_write(ring, ring->funcs->nop);
+	amdgpu_ring_fill(ring, nop, num_nop - 1);
 }
 
 static void gfx_v12_ip_print(void *handle, struct drm_printer *p)
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index 23f0573ae47b..e2c2c9f54a9e 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -7167,11 +7167,11 @@ static void gfx_v9_0_emit_wave_limit(struct amdgpu_ring *ring, bool enable)
 
 static void gfx_v9_ring_insert_nop(struct amdgpu_ring *ring, uint32_t num_nop)
 {
-	int i;
+	const u32 nop = ring->funcs->nop;
 
 	/* Header itself is a NOP packet */
 	if (num_nop == 1) {
-		amdgpu_ring_write(ring, ring->funcs->nop);
+		amdgpu_ring_write(ring, nop);
 		return;
 	}
 
@@ -7179,8 +7179,7 @@ static void gfx_v9_ring_insert_nop(struct amdgpu_ring *ring, uint32_t num_nop)
 	amdgpu_ring_write(ring, PACKET3(PACKET3_NOP, min(num_nop - 2, 0x3ffe)));
 
 	/* Header is at index 0, followed by num_nops - 1 NOP packet's */
-	for (i = 1; i < num_nop; i++)
-		amdgpu_ring_write(ring, ring->funcs->nop);
+	amdgpu_ring_fill(ring, nop, num_nop - 1);
 }
 
 static int gfx_v9_0_reset_kgq(struct amdgpu_ring *ring, unsigned int vmid)
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
index c100845409f7..793828ac0eee 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
@@ -4567,11 +4567,11 @@ static void gfx_v9_4_3_enable_watchdog_timer(struct amdgpu_device *adev)
 
 static void gfx_v9_4_3_ring_insert_nop(struct amdgpu_ring *ring, uint32_t num_nop)
 {
-	int i;
+	const u32 nop = ring->funcs->nop;
 
 	/* Header itself is a NOP packet */
 	if (num_nop == 1) {
-		amdgpu_ring_write(ring, ring->funcs->nop);
+		amdgpu_ring_write(ring, nop);
 		return;
 	}
 
@@ -4579,8 +4579,7 @@ static void gfx_v9_4_3_ring_insert_nop(struct amdgpu_ring *ring, uint32_t num_no
 	amdgpu_ring_write(ring, PACKET3(PACKET3_NOP, min(num_nop - 2, 0x3ffe)));
 
 	/* Header is at index 0, followed by num_nops - 1 NOP packet's */
-	for (i = 1; i < num_nop; i++)
-		amdgpu_ring_write(ring, ring->funcs->nop);
+	amdgpu_ring_fill(ring, nop, num_nop - 1);
 }
 
 static void gfx_v9_4_3_ip_print(void *handle, struct drm_printer *p)
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c b/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c
index 725392522267..dedd2d88b3cb 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c
@@ -222,14 +222,16 @@ static void sdma_v2_4_ring_set_wptr(struct amdgpu_ring *ring)
 static void sdma_v2_4_ring_insert_nop(struct amdgpu_ring *ring, uint32_t count)
 {
 	struct amdgpu_sdma_instance *sdma = amdgpu_sdma_get_instance_from_ring(ring);
-	int i;
+	const u32 nop = ring->funcs->nop;
 
-	for (i = 0; i < count; i++)
-		if (sdma && sdma->burst_nop && (i == 0))
-			amdgpu_ring_write(ring, ring->funcs->nop |
-				SDMA_PKT_NOP_HEADER_COUNT(count - 1));
-		else
-			amdgpu_ring_write(ring, ring->funcs->nop);
+	if (!count)
+		return;
+
+	if (sdma && sdma->burst_nop)
+		amdgpu_ring_write(ring,
+				  nop | SDMA_PKT_NOP_HEADER_COUNT(--count));
+
+	amdgpu_ring_fill(ring, nop, count);
 }
 
 /**
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
index e65194fe94af..04d4135ab6a4 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
@@ -398,14 +398,16 @@ static void sdma_v3_0_ring_set_wptr(struct amdgpu_ring *ring)
 static void sdma_v3_0_ring_insert_nop(struct amdgpu_ring *ring, uint32_t count)
 {
 	struct amdgpu_sdma_instance *sdma = amdgpu_sdma_get_instance_from_ring(ring);
-	int i;
+	const u32 nop = ring->funcs->nop;
 
-	for (i = 0; i < count; i++)
-		if (sdma && sdma->burst_nop && (i == 0))
-			amdgpu_ring_write(ring, ring->funcs->nop |
-				SDMA_PKT_NOP_HEADER_COUNT(count - 1));
-		else
-			amdgpu_ring_write(ring, ring->funcs->nop);
+	if (!count)
+		return;
+
+	if (sdma && sdma->burst_nop)
+		amdgpu_ring_write(ring,
+				  nop | SDMA_PKT_NOP_HEADER_COUNT(--count));
+
+	amdgpu_ring_fill(ring, nop, count);
 }
 
 /**
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
index 23ef4eb36b40..638a00e22c44 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
@@ -784,14 +784,16 @@ static void sdma_v4_0_page_ring_set_wptr(struct amdgpu_ring *ring)
 static void sdma_v4_0_ring_insert_nop(struct amdgpu_ring *ring, uint32_t count)
 {
 	struct amdgpu_sdma_instance *sdma = amdgpu_sdma_get_instance_from_ring(ring);
-	int i;
+	const u32 nop = ring->funcs->nop;
 
-	for (i = 0; i < count; i++)
-		if (sdma && sdma->burst_nop && (i == 0))
-			amdgpu_ring_write(ring, ring->funcs->nop |
-				SDMA_PKT_NOP_HEADER_COUNT(count - 1));
-		else
-			amdgpu_ring_write(ring, ring->funcs->nop);
+	if (!count)
+		return;
+
+	if (sdma && sdma->burst_nop)
+		amdgpu_ring_write(ring,
+				  nop | SDMA_PKT_NOP_HEADER_COUNT(--count));
+
+	amdgpu_ring_fill(ring, nop, count);
 }
 
 /**
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
index c77889040760..1346db44485f 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
@@ -343,14 +343,16 @@ static void sdma_v4_4_2_page_ring_set_wptr(struct amdgpu_ring *ring)
 static void sdma_v4_4_2_ring_insert_nop(struct amdgpu_ring *ring, uint32_t count)
 {
 	struct amdgpu_sdma_instance *sdma = amdgpu_sdma_get_instance_from_ring(ring);
-	int i;
+	const u32 nop = ring->funcs->nop;
 
-	for (i = 0; i < count; i++)
-		if (sdma && sdma->burst_nop && (i == 0))
-			amdgpu_ring_write(ring, ring->funcs->nop |
-				SDMA_PKT_NOP_HEADER_COUNT(count - 1));
-		else
-			amdgpu_ring_write(ring, ring->funcs->nop);
+	if (!count)
+		return;
+
+	if (sdma && sdma->burst_nop)
+		amdgpu_ring_write(ring,
+				  nop | SDMA_PKT_NOP_HEADER_COUNT(--count));
+
+	amdgpu_ring_fill(ring, nop, count);
 }
 
 /**
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
index 3e48ea38385d..5521f0bc1b2a 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
@@ -436,14 +436,16 @@ static void sdma_v5_0_ring_set_wptr(struct amdgpu_ring *ring)
 static void sdma_v5_0_ring_insert_nop(struct amdgpu_ring *ring, uint32_t count)
 {
 	struct amdgpu_sdma_instance *sdma = amdgpu_sdma_get_instance_from_ring(ring);
-	int i;
+	const u32 nop = ring->funcs->nop;
 
-	for (i = 0; i < count; i++)
-		if (sdma && sdma->burst_nop && (i == 0))
-			amdgpu_ring_write(ring, ring->funcs->nop |
-				SDMA_PKT_NOP_HEADER_COUNT(count - 1));
-		else
-			amdgpu_ring_write(ring, ring->funcs->nop);
+	if (!count)
+		return;
+
+	if (sdma && sdma->burst_nop)
+		amdgpu_ring_write(ring,
+				  nop | SDMA_PKT_NOP_HEADER_COUNT(--count));
+
+	amdgpu_ring_fill(ring, nop, count);
 }
 
 /**
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
index bc9b240a3488..e298478522ed 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
@@ -253,14 +253,16 @@ static void sdma_v5_2_ring_set_wptr(struct amdgpu_ring *ring)
 static void sdma_v5_2_ring_insert_nop(struct amdgpu_ring *ring, uint32_t count)
 {
 	struct amdgpu_sdma_instance *sdma = amdgpu_sdma_get_instance_from_ring(ring);
-	int i;
+	const u32 nop = ring->funcs->nop;
 
-	for (i = 0; i < count; i++)
-		if (sdma && sdma->burst_nop && (i == 0))
-			amdgpu_ring_write(ring, ring->funcs->nop |
-				SDMA_PKT_NOP_HEADER_COUNT(count - 1));
-		else
-			amdgpu_ring_write(ring, ring->funcs->nop);
+	if (!count)
+		return;
+
+	if (sdma && sdma->burst_nop)
+		amdgpu_ring_write(ring,
+				  nop | SDMA_PKT_NOP_HEADER_COUNT(--count));
+
+	amdgpu_ring_fill(ring, nop, count);
 }
 
 /**
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
index 208a1fa9d4e7..37cb05f8e8a4 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
@@ -238,14 +238,16 @@ static void sdma_v6_0_ring_set_wptr(struct amdgpu_ring *ring)
 static void sdma_v6_0_ring_insert_nop(struct amdgpu_ring *ring, uint32_t count)
 {
 	struct amdgpu_sdma_instance *sdma = amdgpu_sdma_get_instance_from_ring(ring);
-	int i;
+	const u32 nop = ring->funcs->nop;
 
-	for (i = 0; i < count; i++)
-		if (sdma && sdma->burst_nop && (i == 0))
-			amdgpu_ring_write(ring, ring->funcs->nop |
-				SDMA_PKT_NOP_HEADER_COUNT(count - 1));
-		else
-			amdgpu_ring_write(ring, ring->funcs->nop);
+	if (!count)
+		return;
+
+	if (sdma && sdma->burst_nop)
+		amdgpu_ring_write(ring,
+				  nop | SDMA_PKT_NOP_HEADER_COUNT(--count));
+
+	amdgpu_ring_fill(ring, nop, count);
 }
 
 /*
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
index a8763496aed3..09608a0b0612 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
@@ -264,14 +264,16 @@ static void sdma_v7_0_ring_set_wptr(struct amdgpu_ring *ring)
 static void sdma_v7_0_ring_insert_nop(struct amdgpu_ring *ring, uint32_t count)
 {
 	struct amdgpu_sdma_instance *sdma = amdgpu_sdma_get_instance_from_ring(ring);
-	int i;
+	const u32 nop = ring->funcs->nop;
 
-	for (i = 0; i < count; i++)
-		if (sdma && sdma->burst_nop && (i == 0))
-			amdgpu_ring_write(ring, ring->funcs->nop |
-				SDMA_PKT_NOP_HEADER_COUNT(count - 1));
-		else
-			amdgpu_ring_write(ring, ring->funcs->nop);
+	if (!count)
+		return;
+
+	if (sdma && sdma->burst_nop)
+		amdgpu_ring_write(ring,
+				  nop | SDMA_PKT_NOP_HEADER_COUNT(--count));
+
+	amdgpu_ring_fill(ring, nop, count);
 }
 
 /**
-- 
2.46.0

