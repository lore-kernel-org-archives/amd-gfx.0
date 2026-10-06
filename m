Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4A71CA5FFC
	for <amd-gfx@archiver.kernel.org>; Tue,  6 Oct 2026 22:03:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3CC3810E0A5;
	Tue,  6 Oct 2026 22:03:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ZjYxdSrp";
	dkim-atps=neutral
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com
 [209.85.208.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B33FD10E0A5
 for <amd-gfx@lists.freedesktop.org>; Tue,  6 Oct 2026 22:02:59 +0000 (UTC)
Received: by mail-ed1-f54.google.com with SMTP id
 4fb4d7f45d1cf-6aaebeadf3cso2102810a12.3
 for <amd-gfx@lists.freedesktop.org>; Tue, 06 Oct 2026 15:02:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791324178; x=1791928978; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=KAQI7r+LczypcgMXaVAf9sEszhHeSLW02FqBj4GPDWU=;
 b=ZjYxdSrpo7aWSTK7H72LusuvWf6XegCWypZc5HgD6HlUZ/S7m82SalzsTMaHZHne8e
 zqi7V5JrnkHK3CcEItXCKyPveHDaRDOqOuyxN76WXoV+KE7lfpmvSzCKzU836GeBKaoh
 qczKTifyZvP3n4NbexZWWuyWF4R+0lzTJw0v1TDwyZ3htk6mYwTWObmKb4xinKuQqD25
 HiN0PUZ5nUAWWv4dgu43A0HuOsoSiIWOB3AI9oXcJJO+zEGNKvFwwhCiIL4agHEiIGGS
 4JYsbpokekoQ1N8dGA0WwMTAw7BJipoo2AcxJa9+PPnI5mNzGCPqrUyQ7TPuG/SGWjnp
 eVTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791324178; x=1791928978;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=KAQI7r+LczypcgMXaVAf9sEszhHeSLW02FqBj4GPDWU=;
 b=jp64FnAQ/yg59sYhz+Ljg/1DFLqXOY+n/ZkJ3wDTmP+kjeqeCpW7IY7N6XgSjOZinG
 lgm/jHIZ/Bye8nReKzAfwDZG00b7LGpELqT8nYn4Y1sFZU+kPxdyfXnTLKcQhQhvwAWH
 MC1Mb3LMabX4Y+LkbMaCvpAapa0uV4tbkJ+GG2r9lT5ZaY1RAtdqfpEfOnXRCmt9CORQ
 68qNco+R7jvIm4w9OEyKP09rOHbJU0KXubvLpSVs/bCGN9zh79ST3EB/bFk/m08+O6bX
 3+hptT9vO8wYeGb8EdYCm6y2kPWIXtRuserhK+c+DPsRMySb+kw1zQ3hTtDPKcxu9k2o
 GN/w==
X-Gm-Message-State: AFq9FYLAkVz+Zl1ge/DtIljxsrwC38hwLjjfeyn7ddKLyEzD7YDNHzMb
 aNvovfTskhQPZmtnVtwZGWmuIFp7WeIP8Yvxw85kFbxyO9S5V3rqh+0rr72AMw==
X-Gm-Gg: AYBFou157rzF7yE4viQqsey3148YM6Vjg2GuFpGRio8JrUGMwXM3hEJqBBdPQcmMvzu
 hxqb66Q8pPuM3X5JNB2C3nJ9yxRRHfn6Ud0YcUiC9S5kAHzoMOgNQH5HRtgIMHdBSJcD8qeUjmk
 nOP3t7ac78W5Z1Djdq1QHDcb73zIAdKkgeS4qNDEyjCEg68Li7gZ2PSw2R3cvVJxJ0zrfDHIkSW
 XjSMbvD/+/+FEGu8Wc+LFaOJvB69tF6FbQYANSWY5SmaajQ7BU6XeFCb3v2URZb2KhGCrIX3wvZ
 +3gPfzv/zjQAEx5Dw7hz1McoxuWvwIj8P6cLbS+PfwX07a1kAsT7fOERwlI1OmmVxD/feJLEuqb
 aq+Rj6hld+bMadbgR0dDtqEzpPxjx4S2RlvD2dpcG4384ulAvjhZSHiYf0soHP9/e4ie7UJc7mt
 1qekgyQI+aO4GBlvAOTYoYIJ0zszDi+pR92cKLqWtE0G95rAairQA9DnD8mRw2ll/S6YnLDNLFK
 nvjZHYGhr9VifhSE6j5XEX7IzuZqaWNWwU0k95WyuU=
X-Received: by 2002:a05:6402:2115:b0:6a9:bc61:7f80 with SMTP id
 4fb4d7f45d1cf-6aff4594ef5mr335948a12.27.1791324177622; 
 Tue, 06 Oct 2026 15:02:57 -0700 (PDT)
Received: from Timur-Hyperion.home (86FF63C5.dsl.pool.telekom.hu.
 [134.255.99.197]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6aff2e1eb69sm151670a12.20.2026.10.06.15.02.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Oct 2026 15:02:56 -0700 (PDT)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com,
 Natalie Vock <natalie.vock@gmx.de>,
 Mario Limonciello <mario.limonciello@amd.com>,
 David Rosca <david.rosca@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Lijo Lazar <lijo.lazar@amd.com>, Tvrtko Ursulin <tursulin@ursulin.net>
Cc: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH] drm/amdgpu/sdma3: Work around POLL_REGMEM / FENCE hang
Date: Wed,  7 Oct 2026 00:02:52 +0200
Message-ID: <20261006220253.102403-1-timur.kristof@gmail.com>
X-Mailer: git-send-email 2.55.0
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

SDMA can randomly hang on Polaris 10. Hard to reproduce,
but has been occurring sporadically in the Mesa CI
on the RADV Polaris 10 job even when Mesa isn't using
the SDMA engine.

When Mesa actually uses the SDMA on Polaris, the hang
becomes more frequent and the reproduction rate goes up
significantly in the CI system.

We don't know why the hangs occur, but it seems
that inserting a single NOP packet before each
POLL_REGMEM and FENCE packet works around it.
At the moment it's unclear which GPUs are affected,
so let's apply this to SDMA 3.x for now.

Note that this issue is not documented or acknowledged by AMD.

Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c | 25 +++++++++++++++++++++----
 1 file changed, 21 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
index 6f7243370acb..81f804c9d092 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
@@ -458,6 +458,9 @@ static void sdma_v3_0_ring_emit_hdp_flush(struct amdgpu_ring *ring)
 	else
 		ref_and_mask = REG_SET_FIELD(ref_and_mask, GPU_HDP_FLUSH_DONE, SDMA1, 1);
 
+	/* Hang workaround */
+	amdgpu_ring_write(ring, SDMA_PKT_NOP_HEADER_OP(SDMA_OP_NOP));
+
 	amdgpu_ring_write(ring, SDMA_PKT_HEADER_OP(SDMA_OP_POLL_REGMEM) |
 			  SDMA_PKT_POLL_REGMEM_HEADER_HDP_FLUSH(1) |
 			  SDMA_PKT_POLL_REGMEM_HEADER_FUNC(3)); /* == */
@@ -485,6 +488,10 @@ static void sdma_v3_0_ring_emit_fence(struct amdgpu_ring *ring, u64 addr, u64 se
 				      unsigned flags)
 {
 	bool write64bit = flags & AMDGPU_FENCE_FLAG_64BIT;
+
+	/* Hang workaround */
+	amdgpu_ring_write(ring, SDMA_PKT_NOP_HEADER_OP(SDMA_OP_NOP));
+
 	/* write the fence */
 	amdgpu_ring_write(ring, SDMA_PKT_HEADER_OP(SDMA_OP_FENCE));
 	amdgpu_ring_write(ring, lower_32_bits(addr));
@@ -493,7 +500,11 @@ static void sdma_v3_0_ring_emit_fence(struct amdgpu_ring *ring, u64 addr, u64 se
 
 	/* optionally write high bits as well */
 	if (write64bit) {
+		/* Hang workaround */
+		amdgpu_ring_write(ring, SDMA_PKT_NOP_HEADER_OP(SDMA_OP_NOP));
+
 		addr += 4;
+
 		amdgpu_ring_write(ring, SDMA_PKT_HEADER_OP(SDMA_OP_FENCE));
 		amdgpu_ring_write(ring, lower_32_bits(addr));
 		amdgpu_ring_write(ring, upper_32_bits(addr));
@@ -1010,6 +1021,9 @@ static void sdma_v3_0_ring_emit_pipeline_sync(struct amdgpu_ring *ring)
 	uint32_t seq = ring->fence_drv.sync_seq;
 	uint64_t addr = ring->fence_drv.gpu_addr;
 
+	/* Hang workaround */
+	amdgpu_ring_write(ring, SDMA_PKT_NOP_HEADER_OP(SDMA_OP_NOP));
+
 	/* wait for idle */
 	amdgpu_ring_write(ring, SDMA_PKT_HEADER_OP(SDMA_OP_POLL_REGMEM) |
 			  SDMA_PKT_POLL_REGMEM_HEADER_HDP_FLUSH(0) |
@@ -1038,6 +1052,9 @@ static void sdma_v3_0_ring_emit_vm_flush(struct amdgpu_ring *ring,
 {
 	amdgpu_gmc_emit_flush_gpu_tlb(ring, vmid, pd_addr);
 
+	/* Hang workaround */
+	amdgpu_ring_write(ring, SDMA_PKT_NOP_HEADER_OP(SDMA_OP_NOP));
+
 	/* wait for flush */
 	amdgpu_ring_write(ring, SDMA_PKT_HEADER_OP(SDMA_OP_POLL_REGMEM) |
 			  SDMA_PKT_POLL_REGMEM_HEADER_HDP_FLUSH(0) |
@@ -1467,11 +1484,11 @@ static const struct amdgpu_ring_funcs sdma_v3_0_ring_funcs = {
 	.get_wptr = sdma_v3_0_ring_get_wptr,
 	.set_wptr = sdma_v3_0_ring_set_wptr,
 	.emit_frame_size =
-		6 + /* sdma_v3_0_ring_emit_hdp_flush */
+		6 + 1 + /* sdma_v3_0_ring_emit_hdp_flush */
 		3 + /* hdp invalidate */
-		6 + /* sdma_v3_0_ring_emit_pipeline_sync */
-		VI_FLUSH_GPU_TLB_NUM_WREG * 3 + 6 + /* sdma_v3_0_ring_emit_vm_flush */
-		10 + 10 + 10, /* sdma_v3_0_ring_emit_fence x3 for user fence, vm fence */
+		6 + 1 + /* sdma_v3_0_ring_emit_pipeline_sync */
+		VI_FLUSH_GPU_TLB_NUM_WREG * 3 + 6 + 1 + /* sdma_v3_0_ring_emit_vm_flush */
+		(10 + 1) * 3, /* sdma_v3_0_ring_emit_fence x3 for user fence, vm fence */
 	.emit_ib_size = 7 + 6, /* sdma_v3_0_ring_emit_ib */
 	.emit_ib = sdma_v3_0_ring_emit_ib,
 	.emit_fence = sdma_v3_0_ring_emit_fence,
-- 
2.55.0

