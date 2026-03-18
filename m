Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80EA31077603
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Mar 2026 18:36:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 277ED10E373;
	Wed, 18 Mar 2026 18:36:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="N1EQHeRH";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011038.outbound.protection.outlook.com [52.101.62.38])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 73B6910E373
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Mar 2026 18:36:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uhJjCZBVnldJ1GhACOnZxbopdeofixZMqpFGpfNfZX4ooawHqugRSEdD7OlEfmX324KwB6VaAFQNS94doFoBZguQyi7wRx6yhv3wKqMQhQ2Dx+Q2TgLid//iUtG3H5lNzqwCYhksgbgs6zNrBiO8v4EI3h6oz3Nh7RfP4/Qvd5k4r1n279Msmm+ZAfNj1JyFdNdHOp0aOYSfwAgleLiS7cnTP9tOOApsejNUhwB7n+oSy+ewQAjsq2v9lXEA8BRFShgm3k3pFD1mtM+B8Vltl6qK0hk5fSzRNVjqASFVAly21UUxQ3R6AuS/kNHVa5191yiVa3auXymOVnabN5WrQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k1/u97oH/zWd+BOicTxV5sQTt67q6mQi/T6CbySqyYQ=;
 b=HTyhTqMPEd4eqNIVNyKU/EUEVLhz7A3JI5ex8FTkcHmi2fdZMKsOVn2aE2Rgjlfby2yMxpMXK7C0iHTxUdsaX6V44ejEAaloY6EP5EDxtvhn6tiocbDVhMm9UPsvDE7fII96Wj6fPSbgxhxN8nRwvMBe5OSoUcpWy8V+UXf9mnppdYbb3DfWf8F4VldBRg01cvUKxalSQF4kirDZywzp2ZFe+S4LFR9Nz78GoGmiPiGZSOagPRqPMvq10jSpFsdhg8VRt9TNwlvwGQZ5vxt77Nf06rY/xFdtfOnpcOk1beICCYYLMtjHc7Bs2XQ+1drcc74Gb6n9jhI6uLS5UyNhzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k1/u97oH/zWd+BOicTxV5sQTt67q6mQi/T6CbySqyYQ=;
 b=N1EQHeRHmnRVJQpboQRhuucr7Tcw2iDfxOD7CeJTNr+vB0i28xRpELmWsnQi7TvwB8HVI91uGiOwvVvab7aGgoLwrIE1K0UbztjFcp/kt2VlcWKrX8SClKPswgrLrbsiB1Iten7vUKPR0cOO+c/Z0OCNIU227Cv2M8UC9WHbMDI=
Received: from BN1PR13CA0015.namprd13.prod.outlook.com (2603:10b6:408:e2::20)
 by MN2PR12MB4320.namprd12.prod.outlook.com (2603:10b6:208:15f::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.9; Wed, 18 Mar
 2026 18:36:18 +0000
Received: from MN1PEPF0000F0E2.namprd04.prod.outlook.com
 (2603:10b6:408:e2:cafe::50) by BN1PR13CA0015.outlook.office365.com
 (2603:10b6:408:e2::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.19 via Frontend Transport; Wed,
 18 Mar 2026 18:36:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 MN1PEPF0000F0E2.mail.protection.outlook.com (10.167.242.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19 via Frontend Transport; Wed, 18 Mar 2026 18:36:18 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 18 Mar
 2026 13:36:13 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Wed, 18 Mar 2026 13:36:13 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>, Jesse Zhang <jesse.zhang@amd.com>
Subject: [PATCH 3/7] drm/amdgpu: require a job to schedule an IB
Date: Wed, 18 Mar 2026 14:36:00 -0400
Message-ID: <20260318183604.16505-3-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260318183604.16505-1-alexander.deucher@amd.com>
References: <20260318183604.16505-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E2:EE_|MN2PR12MB4320:EE_
X-MS-Office365-Filtering-Correlation-Id: b129a53a-c819-47e5-3cfb-08de851d3eaa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|1800799024|376014|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: SaE+P8zgT5hQTgf5jRYMucJ5hQvlMeb1nX/77OLH6J8SqC60QqOa0ZQ/wlMMZta5zVQAFPlYUxyNPsnboWNwML+jWCr+qiTGH9zL3nc0XviMLsqnjlAH+Z9aN5HzTqci9JSl/MD2hLVJet5Ap1XwGTUaRyOg/mfpkHutWTRK1JrDEaxyOc0ORb7ZWN7XoYR6DpGcphVtrz+ZRX5QPrlX1WlaqLluA84v8L+QkmSU4SVpg/Z6lZN0VE/cQjP39J3Mbifn/kYJfGxz+Ls43TJ6dp6YvaK0EoHRTHXJ9/Xq2C+kZsWNIlZi2cbF6zzMd/eEZW7wViVsdhh39D/k9N/LhB8PRFs4F/tXw9oq29Usm4Trqs9nykVjyYste+bPAbDAc/Oh/DoYxC9pa8Vdeo8UlmznaPlfzDlhAfVfWa4fSv2fDIKz88Xjjtw1Rpr3cxCpy3TPv6o7EQ4qxlFSGcHOvag1C8ArvSV2uq1aRzG+Rlc4AZl89FSiCOf2w1S2Pj/dVTzmvENMQXZ0J0OQCn3MSR3CRmyn/dJS6IxU79CbfPBB1ClbtDO2P8LACgtAftbPdJWmjYGkfnvBx9Am47zDZj1MnOZRY+c0tcjdbXuD4JkjQxnCgseAD2lKMk03uFUdvSn/s9U0+9A0OjhtfS8Zk+yAMLO+LTFeWZFImE9ozcq4M4GRDgRAwDWeQEkkgvVWlsG+p5tSHZ7zpTAjDgMNrkUdZ8avCVcfTtKgMGxg1wIgmZOtyRaDu4q41coFtm3Pd4IRqMsgVj5WrF8K+pPKwQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(1800799024)(376014)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ES8hNnWDXKsIj2/fU8MbEBUm521tnxbVR2ADtiuVhe5l+PWT9dE76Uqp/I3wCEhdqCrmssPYx4LKJRGhssxpQMu2Ts/TUJS3EYEF5Ydl993+mDLFcENh6/FKSgb42dyGFqWvzacUB+2W0US1dwkjLqXeg6z9SIxC0tTNeGzPLKak5Y9yNSYKB3VVg9kUrvkAyPXYaN+6/8I4bfz/JVOgqKnCfH5QtiFkyl8U8mgmE41wUqqLa9+fHcV67Nm3otzs4HX9DFLo5j2yCagyhOUe8ZtR3tsLtqoqtTc1rF+RtQYv51sOzkr1ZAr2EpaHBba8jRx7aydKHeuXzLNq5C/sZwae99gfw2mr7UVgpE/8y308pHQj18DD6i7p0cTUjvKcyWLHTyuOGITVkRlBPC4+8HMq5+2qyns992DZdvdqwH7ffHRgz5iZ/S6UUqfaQZ66
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2026 18:36:18.4636 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b129a53a-c819-47e5-3cfb-08de851d3eaa
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000F0E2.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4320
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

Remove the old direct submit path.  This simplifies
the code.

v2: remove more local variables

Reviewed-by: Jesse Zhang <jesse.zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c     | 113 ++++++++-------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.c    |   5 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h   |   3 +-
 4 files changed, 45 insertions(+), 78 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
index 823b92005689a..4ec1058b7cdfa 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
@@ -685,7 +685,7 @@ int amdgpu_amdkfd_submit_ib(struct amdgpu_device *adev,
 	job->vmid = vmid;
 	job->num_ibs = 1;
 
-	ret = amdgpu_ib_schedule(ring, 1, ib, job, &f);
+	ret = amdgpu_ib_schedule(ring, job, &f);
 
 	if (ret) {
 		drm_err(adev_to_drm(adev), "failed to schedule IB.\n");
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
index 80565c4a31bdf..55a9670f1dd90 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
@@ -103,8 +103,6 @@ void amdgpu_ib_free(struct amdgpu_ib *ib, struct dma_fence *f)
  * amdgpu_ib_schedule - schedule an IB (Indirect Buffer) on the ring
  *
  * @ring: ring index the IB is associated with
- * @num_ibs: number of IBs to schedule
- * @ibs: IB objects to schedule
  * @job: job to schedule
  * @f: fence created during this submission
  *
@@ -121,90 +119,70 @@ void amdgpu_ib_free(struct amdgpu_ib *ib, struct dma_fence *f)
  * a CONST_IB), it will be put on the ring prior to the DE IB.  Prior
  * to SI there was just a DE IB.
  */
-int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned int num_ibs,
-		       struct amdgpu_ib *ibs, struct amdgpu_job *job,
+int amdgpu_ib_schedule(struct amdgpu_ring *ring, struct amdgpu_job *job,
 		       struct dma_fence **f)
 {
 	struct amdgpu_device *adev = ring->adev;
-	struct amdgpu_ib *ib = &ibs[0];
+	struct amdgpu_ib *ib;
 	struct dma_fence *tmp = NULL;
 	struct amdgpu_fence *af;
 	struct amdgpu_fence *vm_af;
 	bool need_ctx_switch;
-	struct amdgpu_vm *vm;
 	uint64_t fence_ctx;
 	uint32_t status = 0, alloc_size;
 	unsigned int fence_flags = 0;
-	bool secure, init_shadow;
-	u64 shadow_va, csa_va, gds_va;
+	bool secure;
 	int vmid = AMDGPU_JOB_GET_VMID(job);
 	bool need_pipe_sync = false;
 	unsigned int cond_exec;
 	unsigned int i;
 	int r = 0;
 
-	if (num_ibs == 0)
+	if (!job)
+		return -EINVAL;
+	if (job->num_ibs == 0)
 		return -EINVAL;
 
-	/* ring tests don't use a job */
-	if (job) {
-		vm = job->vm;
-		fence_ctx = job->base.s_fence ?
-			job->base.s_fence->finished.context : 0;
-		shadow_va = job->shadow_va;
-		csa_va = job->csa_va;
-		gds_va = job->gds_va;
-		init_shadow = job->init_shadow;
-		af = job->hw_fence;
-		/* Save the context of the job for reset handling.
-		 * The driver needs this so it can skip the ring
-		 * contents for guilty contexts.
-		 */
-		af->context = fence_ctx;
-		/* the vm fence is also part of the job's context */
-		job->hw_vm_fence->context = fence_ctx;
-	} else {
-		vm = NULL;
-		fence_ctx = 0;
-		shadow_va = 0;
-		csa_va = 0;
-		gds_va = 0;
-		init_shadow = false;
-		af = kzalloc(sizeof(*af), GFP_ATOMIC);
-		if (!af)
-			return -ENOMEM;
-	}
+	ib = &job->ibs[0];
+	fence_ctx = job->base.s_fence ?
+		job->base.s_fence->finished.context : 0;
+	af = job->hw_fence;
+	vm_af = job->hw_vm_fence;
+	/* Save the context of the job for reset handling.
+	 * The driver needs this so it can skip the ring
+	 * contents for guilty contexts.
+	 */
+	af->context = fence_ctx;
+	/* the vm fence is also part of the job's context */
+	vm_af->context = fence_ctx;
 
 	if (!ring->sched.ready) {
 		dev_err(adev->dev, "couldn't schedule ib on ring <%s>\n", ring->name);
-		r = -EINVAL;
-		goto free_fence;
+		return -EINVAL;
 	}
 
-	if (vm && !job->vmid) {
+	if (job->vm && !job->vmid) {
 		dev_err(adev->dev, "VM IB without ID\n");
-		r = -EINVAL;
-		goto free_fence;
+		return -EINVAL;
 	}
 
 	if ((ib->flags & AMDGPU_IB_FLAGS_SECURE) &&
 	    (!ring->funcs->secure_submission_supported)) {
 		dev_err(adev->dev, "secure submissions not supported on ring <%s>\n", ring->name);
-		r = -EINVAL;
-		goto free_fence;
+		return -EINVAL;
 	}
 
-	alloc_size = ring->funcs->emit_frame_size + num_ibs *
+	alloc_size = ring->funcs->emit_frame_size + job->num_ibs *
 		ring->funcs->emit_ib_size;
 
 	r = amdgpu_ring_alloc(ring, alloc_size);
 	if (r) {
 		dev_err(adev->dev, "scheduling IB failed (%d).\n", r);
-		goto free_fence;
+		return r;
 	}
 
 	need_ctx_switch = ring->current_ctx != fence_ctx;
-	if (ring->funcs->emit_pipeline_sync && job &&
+	if (ring->funcs->emit_pipeline_sync &&
 	    ((tmp = amdgpu_sync_get_fence(&job->explicit_sync)) ||
 	     need_ctx_switch || amdgpu_vm_need_pipeline_sync(ring, job))) {
 
@@ -216,14 +194,11 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned int num_ibs,
 		dma_fence_put(tmp);
 	}
 
-	if (job) {
-		vm_af = job->hw_vm_fence;
-		/* VM sequence */
-		vm_af->ib_wptr = ring->wptr;
-		amdgpu_vm_flush(ring, job, need_pipe_sync);
-		vm_af->ib_dw_size =
-			amdgpu_ring_get_dw_distance(ring, vm_af->ib_wptr, ring->wptr);
-	}
+	/* VM sequence */
+	vm_af->ib_wptr = ring->wptr;
+	amdgpu_vm_flush(ring, job, need_pipe_sync);
+	vm_af->ib_dw_size =
+		amdgpu_ring_get_dw_distance(ring, vm_af->ib_wptr, ring->wptr);
 
 	/* IB sequence */
 	af->ib_wptr = ring->wptr;
@@ -240,8 +215,8 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned int num_ibs,
 		ring->funcs->emit_wave_limit(ring, true);
 
 	if (ring->funcs->emit_gfx_shadow && adev->gfx.cp_gfx_shadow)
-		amdgpu_ring_emit_gfx_shadow(ring, shadow_va, csa_va, gds_va,
-					    init_shadow, vmid);
+		amdgpu_ring_emit_gfx_shadow(ring, job->shadow_va, job->csa_va, job->gds_va,
+					    job->init_shadow, vmid);
 
 	if (ring->funcs->init_cond_exec)
 		cond_exec = amdgpu_ring_init_cond_exec(ring,
@@ -255,7 +230,7 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned int num_ibs,
 	if (need_ctx_switch)
 		status |= AMDGPU_HAVE_CTX_SWITCH;
 
-	if (job && ring->funcs->emit_cntxcntl) {
+	if (ring->funcs->emit_cntxcntl) {
 		status |= job->preamble_status;
 		status |= job->preemption_status;
 		amdgpu_ring_emit_cntxcntl(ring, status);
@@ -264,15 +239,15 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned int num_ibs,
 	/* Setup initial TMZiness and send it off.
 	 */
 	secure = false;
-	if (job && ring->funcs->emit_frame_cntl) {
+	if (ring->funcs->emit_frame_cntl) {
 		secure = ib->flags & AMDGPU_IB_FLAGS_SECURE;
 		amdgpu_ring_emit_frame_cntl(ring, true, secure);
 	}
 
-	for (i = 0; i < num_ibs; ++i) {
-		ib = &ibs[i];
+	for (i = 0; i < job->num_ibs; ++i) {
+		ib = &job->ibs[i];
 
-		if (job && ring->funcs->emit_frame_cntl) {
+		if (ring->funcs->emit_frame_cntl) {
 			if (secure != !!(ib->flags & AMDGPU_IB_FLAGS_SECURE)) {
 				amdgpu_ring_emit_frame_cntl(ring, false, secure);
 				secure = !secure;
@@ -284,7 +259,7 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned int num_ibs,
 		status &= ~AMDGPU_HAVE_CTX_SWITCH;
 	}
 
-	if (job && ring->funcs->emit_frame_cntl)
+	if (ring->funcs->emit_frame_cntl)
 		amdgpu_ring_emit_frame_cntl(ring, false, secure);
 
 	amdgpu_device_invalidate_hdp(adev, ring);
@@ -296,7 +271,7 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned int num_ibs,
 		fence_flags |= AMDGPU_FENCE_FLAG_TC_WB_ONLY;
 
 	/* wrap the last IB with fence */
-	if (job && job->uf_addr) {
+	if (job->uf_addr) {
 		amdgpu_ring_emit_fence(ring, job->uf_addr, job->uf_sequence,
 				       fence_flags | AMDGPU_FENCE_FLAG_64BIT);
 	}
@@ -310,8 +285,7 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned int num_ibs,
 	amdgpu_fence_emit(ring, af, fence_flags);
 	*f = &af->base;
 	/* get a ref for the job */
-	if (job)
-		dma_fence_get(*f);
+	dma_fence_get(*f);
 
 	if (ring->funcs->insert_end)
 		ring->funcs->insert_end(ring);
@@ -319,7 +293,7 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned int num_ibs,
 	amdgpu_ring_patch_cond_exec(ring, cond_exec);
 
 	ring->current_ctx = fence_ctx;
-	if (job && ring->funcs->emit_switch_buffer)
+	if (ring->funcs->emit_switch_buffer)
 		amdgpu_ring_emit_switch_buffer(ring);
 
 	if (ring->funcs->emit_wave_limit &&
@@ -333,11 +307,6 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned int num_ibs,
 	amdgpu_ring_commit(ring);
 
 	return 0;
-
-free_fence:
-	if (!job)
-		kfree(af);
-	return r;
 }
 
 /**
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
index 95aa87b4406eb..cd0707737a29b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
@@ -377,7 +377,7 @@ int amdgpu_job_submit_direct(struct amdgpu_job *job, struct amdgpu_ring *ring,
 	int r;
 
 	job->base.sched = &ring->sched;
-	r = amdgpu_ib_schedule(ring, job->num_ibs, job->ibs, job, fence);
+	r = amdgpu_ib_schedule(ring, job, fence);
 
 	if (r)
 		return r;
@@ -447,8 +447,7 @@ static struct dma_fence *amdgpu_job_run(struct drm_sched_job *sched_job)
 		dev_dbg(adev->dev, "Skip scheduling IBs in ring(%s)",
 			ring->name);
 	} else {
-		r = amdgpu_ib_schedule(ring, job->num_ibs, job->ibs, job,
-				       &fence);
+		r = amdgpu_ib_schedule(ring, job, &fence);
 		if (r)
 			dev_err(adev->dev,
 				"Error scheduling IBs (%d) in ring(%s)", r,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
index ce5af137ee400..fafb876d73da1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
@@ -575,8 +575,7 @@ int amdgpu_ib_get(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 		  enum amdgpu_ib_pool_type pool,
 		  struct amdgpu_ib *ib);
 void amdgpu_ib_free(struct amdgpu_ib *ib, struct dma_fence *f);
-int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned num_ibs,
-		       struct amdgpu_ib *ibs, struct amdgpu_job *job,
+int amdgpu_ib_schedule(struct amdgpu_ring *ring, struct amdgpu_job *job,
 		       struct dma_fence **f);
 int amdgpu_ib_pool_init(struct amdgpu_device *adev);
 void amdgpu_ib_pool_fini(struct amdgpu_device *adev);
-- 
2.53.0

