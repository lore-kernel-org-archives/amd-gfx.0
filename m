Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5793C3DA45
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Jul 2024 18:17:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5874A10E16C;
	Thu, 11 Jul 2024 18:17:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="Aj2wDtD5";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7521710E16C
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 Jul 2024 18:17:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
 Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
 Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
 In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=N+LETS1WfckbktpPGI6ajUp+pOmH49nt0NF0OZW/50w=; b=Aj2wDtD58+3DtFvbhRDbu3fN7Z
 C6k5BVy8fw94EuUbIr0Jva6DSYAwLGKrmy6roRaOjDSs03QJFX4o7ERS4jjgLdfyOFn5pbkDRs47t
 F7b7gj5c+5BPpSszQQqrHzftJcsyflKOL8NlYVi7bulw+GDsleJytRMTBNiW9CCSI6URpaZbthe4o
 CJcOpRLpEfVj4Y2+ObT5oSS07HdtUyap4ubsZO+ugg45D/QQSdpkbd2kV/jUXSYj77ehKAXDi0dU4
 s0j9SuXSbiHlHSb+ZubqBCt8XaGXy5fv5lAfVkT5XLWBgMme0q/3A6695+lGU9jWxjamiZ3QS9XLL
 bjSzYivw==;
Received: from [84.69.19.168] (helo=localhost)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1sRyMW-00Dqgy-Om; Thu, 11 Jul 2024 20:17:48 +0200
From: Tvrtko Ursulin <tursulin@igalia.com>
To: amd-gfx@lists.freedesktop.org
Cc: kernel-dev@igalia.com,
	Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Subject: [RFC] drm/amdgpu: More efficient ring padding
Date: Thu, 11 Jul 2024 19:17:46 +0100
Message-ID: <20240711181746.86311-1-tursulin@igalia.com>
X-Mailer: git-send-email 2.44.0
MIME-Version: 1.0
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

From the department of questionable optimisations today we have a minor
improvement to how padding / filling the rings with nops is done.

Having noticed that typically 200+ nops per submission are filled into the
ring, using a rather verbose one-nop-at-a-time-plus-ring-buffer-arithmetic
as done in amdgpu_ring_write(), while right next to it there is
amdgpu_ring_write_multiple(), I thought why not pre-cache a block of nops
and write them out more efficiently.

The patch is rather quick and dirty, does not deal with all insert_nops
vfuncs, and the cache should probably go one level up so it is not
replicated per amdgpu_ring instance.

And performance gains are not that amazing for normal workloads. For
instance a game which results in two submissions per frame, each pads
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

+   89.83%     0.51%  kworker/u32:6-g  [kernel.kallsyms]  [k] process_one_work
+   47.65%     0.30%  kworker/u32:6-g  [kernel.kallsyms]  [k] commit_tail
+   39.42%     1.97%  kworker/u32:6-g  [kernel.kallsyms]  [k] amdgpu_dm_atomic_commit_tail
-   29.57%     1.10%  kworker/u32:6-g  [kernel.kallsyms]  [k] drm_sched_run_job_work
   - 28.47% drm_sched_run_job_work
      + 8.52% dma_fence_add_callback
      - 6.33% amdgpu_job_run
         - 6.19% amdgpu_ib_schedule
            - 1.85% amdgpu_ring_commit
                 0.53% amdgpu_ring_insert_nop

Or if we run a more "spammy" workload, which does several orders of
magnitude more submissions second we go from:

+   79.38%     1.66%  kworker/u32:1+e  [kernel.kallsyms]  [k] process_one_work
-   63.13%     6.66%  kworker/u32:1+e  [kernel.kallsyms]  [k] drm_sched_run_job_work
   - 56.47% drm_sched_run_job_work
      - 25.67% amdgpu_job_run
         - 24.40% amdgpu_ib_schedule
            - 15.29% amdgpu_ring_commit
                 12.06% amdgpu_ring_insert_nop

To:

+   77.76%     1.97%  kworker/u32:6-f  [kernel.kallsyms]  [k] process_one_work
-   60.15%     7.04%  kworker/u32:6-f  [kernel.kallsyms]  [k] drm_sched_run_job_work
   - 53.11% drm_sched_run_job_work
      - 19.35% amdgpu_job_run
         - 17.85% amdgpu_ib_schedule
            - 7.75% amdgpu_ring_commit
                 3.27% amdgpu_ring_insert_nop

Not bad and "every little helps", or flame-throwers at ready?

Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c | 20 +++++++++++++++-----
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h |  1 +
 2 files changed, 16 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
index ad49cecb20b8..22ec9de62b06 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
@@ -108,10 +108,14 @@ int amdgpu_ring_alloc(struct amdgpu_ring *ring, unsigned int ndw)
  */
 void amdgpu_ring_insert_nop(struct amdgpu_ring *ring, uint32_t count)
 {
-	int i;
+	if (count > 1 && count <= ARRAY_SIZE(ring->nop_cache)) {
+		amdgpu_ring_write_multiple(ring, ring->nop_cache, count);
+	} else {
+		int i;
 
-	for (i = 0; i < count; i++)
-		amdgpu_ring_write(ring, ring->funcs->nop);
+		for (i = 0; i < count; i++)
+			amdgpu_ring_write(ring, ring->funcs->nop);
+	}
 }
 
 /**
@@ -124,8 +128,11 @@ void amdgpu_ring_insert_nop(struct amdgpu_ring *ring, uint32_t count)
  */
 void amdgpu_ring_generic_pad_ib(struct amdgpu_ring *ring, struct amdgpu_ib *ib)
 {
-	while (ib->length_dw & ring->funcs->align_mask)
-		ib->ptr[ib->length_dw++] = ring->funcs->nop;
+	u32 count = ib->length_dw & ring->funcs->align_mask;
+
+	memcpy(&ib->ptr[ib->length_dw], ring->nop_cache, count * sizeof(u32));
+
+	ib->length_dw += count;
 }
 
 /**
@@ -359,6 +366,9 @@ int amdgpu_ring_init(struct amdgpu_device *adev, struct amdgpu_ring *ring,
 			&ring->sched;
 	}
 
+	for (r = 0; r < ARRAY_SIZE(ring->nop_cache); r++)
+		ring->nop_cache[r] = ring->funcs->nop;
+
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
index 582053f1cd56..74ce95b4666a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
@@ -246,6 +246,7 @@ struct amdgpu_ring {
 	struct amdgpu_bo	*ring_obj;
 	volatile uint32_t	*ring;
 	unsigned		rptr_offs;
+	u32			nop_cache[256];
 	u64			rptr_gpu_addr;
 	volatile u32		*rptr_cpu_addr;
 	u64			wptr;
-- 
2.44.0

