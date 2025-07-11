Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21668C8303C
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Jul 2025 12:23:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B65CB10EA33;
	Fri, 11 Jul 2025 12:23:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="FmKHMt0Y";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0142010EA33
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Jul 2025 12:23:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:Content-Description:
 Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
 In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=qAy99HjeGiboNyLHlxpXxNlHbik903/zryF/xI41LOw=; b=FmKHMt0YJLB0FfnPXV/XpthjUY
 LzgTqODfrvdkDxlmmtO2Cv8/QOy1Y0jI3PKapyuft+YNbOz/Xh1B1K7+tOWvp9CkbgIaRrxVaqM05
 oAN05UKx+LG8oBrSVtr/g+9lVbJktP77yCwIhmBrtT1jPO8cLFy0abS9QBgIgjWkTuiimY90th3zy
 XPDI2iMwLW6XEg3OvIDfmrh8anhKLN7pxvAhCXO+2L0QcgX4AGjam5UAAfrxVFbXqWMadXd4dFpxZ
 bA2Kdw2KibHEAMktpFZpoD8kuFfnlSuahFouzkvOJsijQ7Xw2H+VMRMclchpaK/FYeGTU4IbYwu0e
 58fggK8Q==;
Received: from [84.65.48.237] (helo=localhost)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1uaCn1-00FMvM-0o; Fri, 11 Jul 2025 14:23:43 +0200
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
To: amd-gfx@lists.freedesktop.org
Cc: kernel-dev@igalia.com, Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Subject: [RFC] drm/amdgpu/sdma5.2: Avoid latencies caused by the powergating
 workaround
Date: Fri, 11 Jul 2025 13:23:38 +0100
Message-ID: <20250711122338.44831-1-tvrtko.ursulin@igalia.com>
X-Mailer: git-send-email 2.48.0
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

Commit
94b1e028e15c ("drm/amdgpu/sdma5.2: add begin/end_use ring callbacks")
added a workaround which disables GFXOFF for the duration of the job
submit stage (with a 100ms trailing hysteresis).

Empirically the GFXOFF disable/enable request can suffer from significant
latencies (2ms is easily seen) which are then inserted onto the
amdgpu_job_run() path, which slows down the CPU submission of ready jobs.

1)
If the premise of the GFXOFF workaround is to keep it disabled while the
SDMA engine is active, the current workaround achieves that only
partially, for submissions and jobs which take less than 100ms (the GFXOFF
re-enable hysteresis), counting from the ring write phase, up to
completion.

2)
If disabling GFXOFF affects the GFX engine too, basing the workaround
solely on the SDMA activity creates, at minimum, a needless "chatter" on
the SMU communication channel.

If 1) and 2) hold true, we can improve on the workaround by; a) only
re-enabling GFXOFF once the job had actually completed*, and b) apply the
same workaround on other rings which share the same GFXOFF powergating
domain.

With these two applied, the GFXOFF re-enable requests are avoided
altogether during persistent activity on the GFX ring and simultaneous
sporadic activity on the SDMA ring.

This has a positive effect of drastically reducing SDMA submission
latencies. For example during the Cyberpunk 2077 benchmark, they are
reduced from an average of 64us (stdev 60) to 9us (stdev 6). Or more
importantly the worst case latency, averaged to a one second window, is
reduced from 305us to 30us**.

*) For ease of implementation we put the re-enable at the job free stage,
since doing it on actual completion is problematic in terms of locking.

**) Submission latency ewma averaged (DECLARE_EWMA(latency, 6, 4)) -
Approximately 30 SDMA submissions per second, ewma average logged once
per second therefore significantly hides the worst case latency. Eg.
the real improvement in max submission latency is severely understated by
these numbers.

Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
References: 94b1e028e15c ("drm/amdgpu/sdma5.2: add begin/end_use ring callbacks")
Cc: Mario Limonciello <mario.limonciello@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h  | 1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c   | 8 ++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.c  | 7 +++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.h  | 2 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c | 3 +++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h | 1 +
 drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c   | 1 +
 7 files changed, 23 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
index 08f268dab8f5..eee40f385793 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
@@ -475,6 +475,7 @@ struct amdgpu_gfx {
 	uint32_t 			compute_supported_reset;
 
 	/* gfx off */
+	bool				gfx_off_held;	    /* true: rings hold gfx_off */
 	bool                            gfx_off_state;      /* true: enabled, false: disabled */
 	struct mutex                    gfx_off_mutex;      /* mutex to change gfxoff state */
 	uint32_t                        gfx_off_req_count;  /* default 1, enable gfx off: dec 1, disable gfx off: add 1 */
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
index 206b70acb29a..bf9bffe40235 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
@@ -191,6 +191,14 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned int num_ibs,
 		return r;
 	}
 
+	if (job && adev->gfx.gfx_off_held &&
+	    (ring->funcs->type == AMDGPU_RING_TYPE_GFX ||
+	     ring->funcs->type == AMDGPU_RING_TYPE_COMPUTE ||
+	     ring->funcs->type == AMDGPU_RING_TYPE_SDMA)) {
+		amdgpu_gfx_off_ctrl(adev, false);
+		job->gfx_off_held = true;
+	}
+
 	need_ctx_switch = ring->current_ctx != fence_ctx;
 	if (ring->funcs->emit_pipeline_sync && job &&
 	    ((tmp = amdgpu_sync_get_fence(&job->explicit_sync)) ||
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
index 2b58e353cca1..4cfd175ac6df 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
@@ -191,6 +191,7 @@ int amdgpu_job_alloc(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 	if (!*job)
 		return -ENOMEM;
 
+	(*job)->adev = adev;
 	(*job)->vm = vm;
 
 	amdgpu_sync_create(&(*job)->explicit_sync);
@@ -268,6 +269,9 @@ static void amdgpu_job_free_cb(struct drm_sched_job *s_job)
 
 	amdgpu_sync_free(&job->explicit_sync);
 
+	if (job->gfx_off_held)
+		amdgpu_gfx_off_ctrl(job->adev, true);
+
 	/* only put the hw fence if has embedded fence */
 	if (!job->hw_fence.base.ops)
 		kfree(job);
@@ -301,6 +305,9 @@ void amdgpu_job_free(struct amdgpu_job *job)
 	if (job->gang_submit != &job->base.s_fence->scheduled)
 		dma_fence_put(job->gang_submit);
 
+	if (job->gfx_off_held)
+		amdgpu_gfx_off_ctrl(job->adev, true);
+
 	if (!job->hw_fence.base.ops)
 		kfree(job);
 	else
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
index 2f302266662b..d4ab832ac193 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
@@ -46,6 +46,7 @@ enum amdgpu_ib_pool_type;
 
 struct amdgpu_job {
 	struct drm_sched_job    base;
+	struct amdgpu_device	*adev;
 	struct amdgpu_vm	*vm;
 	struct amdgpu_sync	explicit_sync;
 	struct amdgpu_fence	hw_fence;
@@ -55,6 +56,7 @@ struct amdgpu_job {
 	bool                    vm_needs_flush;
 	bool			gds_switch_needed;
 	bool			spm_update_needed;
+	bool			gfx_off_held;
 	uint64_t		vm_pd_addr;
 	unsigned		vmid;
 	unsigned		pasid;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
index 426834806fbf..22cac94e2f2a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
@@ -350,6 +350,9 @@ int amdgpu_ring_init(struct amdgpu_device *adev, struct amdgpu_ring *ring,
 	ring->max_dw = max_dw;
 	ring->hw_prio = hw_prio;
 
+	if (ring->funcs->gfx_off_held)
+		adev->gfx.gfx_off_held = true;
+
 	if (!ring->no_scheduler && ring->funcs->type < AMDGPU_HW_IP_NUM) {
 		hw_ip = ring->funcs->type;
 		num_sched = &adev->gpu_sched[hw_ip][hw_prio].num_scheds;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
index 784ba2ec354c..afaf951b0b78 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
@@ -202,6 +202,7 @@ struct amdgpu_ring_funcs {
 	bool			support_64bit_ptrs;
 	bool			no_user_fence;
 	bool			secure_submission_supported;
+	bool			gfx_off_held;
 	unsigned		extra_dw;
 
 	/* ring read/write ptr handling */
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
index 42a25150f83a..c88de65e82bc 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
@@ -1944,6 +1944,7 @@ static const struct amdgpu_ring_funcs sdma_v5_2_ring_funcs = {
 	.nop = SDMA_PKT_NOP_HEADER_OP(SDMA_OP_NOP),
 	.support_64bit_ptrs = true,
 	.secure_submission_supported = true,
+	.gfx_off_held = true,
 	.get_rptr = sdma_v5_2_ring_get_rptr,
 	.get_wptr = sdma_v5_2_ring_get_wptr,
 	.set_wptr = sdma_v5_2_ring_set_wptr,
-- 
2.48.0

