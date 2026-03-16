Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0A81F53D85
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Mar 2026 18:17:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6BF8C10E35D;
	Mon, 16 Mar 2026 18:17:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="GvivJjT7";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010063.outbound.protection.outlook.com
 [52.101.193.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9395F10E35D
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Mar 2026 18:17:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eQXfpZri7YqO2NHldH1HDbkvcIK/4YD6KthjNM0DOfEOjgachjJu7/p1mUW0N+q8fjjTf9j7CD2iY2WSW3vGVqtZF6Z8DkvpvESxLzGuxR+B0OVDWSjMQxawfnAqfnMkHZ+LSCzG6Vd0uoSno0mCZowmt1JXi7qO7BfYTy05OiXnWoxqQcCNxaO4NKREX0rODXOsZs9Dddht9lsN9dbdV+Jm7V1islVGqzelweZ8hmKGNEX8gAAmlh0IxKh+MkY0ensVuLEucyZJt5Y0RpY3HfY50bYCEyum+c/AgFB/USk221jkadGIAUFYaMJoANsDO26OpB7AF79htz4+woqFJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k1/u97oH/zWd+BOicTxV5sQTt67q6mQi/T6CbySqyYQ=;
 b=CW0Tad3yqc28rh4PGFJZWd6GrJhQ9LIVMAb2LLHDH4wQh9uVoTCFZ74Y5CDyd3P8zLWkWWvTMlcUgSBm5zotRuec123abw9qetbG8wpHybXNuEciaaGA4frZtTT0VDgiWsMyBqW0BP+GhIygUoWyysgR90T0Mdff69XecFjhzMgujcl4SIk/xeQOAH0h7eaaHphX83OVoYtLCt7IxCGAgddpx5O5oZJKkbsDQiySFL9+WC0wQ4YlPXqjkP1jPAG1SMd3NMASXHKBbRWynVjmftAawfPpal0bz38GJ5GwF+9+6cR7eBOG9ATm4c7gKdjg7gSrRUPM/U23rqY4WA6PBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k1/u97oH/zWd+BOicTxV5sQTt67q6mQi/T6CbySqyYQ=;
 b=GvivJjT7kV2KHT77SNa8/WBgU69vmIDSIeInjkcbMuRu0XpPVHjR2Hz7xOTioNr6tyh5YN1pv82Gvl0J0uN91HeLeDgvus2JF9bwfeaO2fr76G/sgYsXSMf/b0zTH+vOvS4UNeohC+erlvyBtShe8thsz2RUWgdvUzBgnjK3pnA=
Received: from CYXPR02CA0037.namprd02.prod.outlook.com (2603:10b6:930:cc::15)
 by MN6PR12MB8469.namprd12.prod.outlook.com (2603:10b6:208:46e::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.17; Mon, 16 Mar
 2026 18:16:58 +0000
Received: from CY4PEPF0000EE36.namprd05.prod.outlook.com
 (2603:10b6:930:cc:cafe::39) by CYXPR02CA0037.outlook.office365.com
 (2603:10b6:930:cc::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9700.25 via Frontend Transport; Mon,
 16 Mar 2026 18:16:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CY4PEPF0000EE36.mail.protection.outlook.com (10.167.242.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9700.17 via Frontend Transport; Mon, 16 Mar 2026 18:16:58 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 16 Mar
 2026 13:16:57 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Mon, 16 Mar 2026 13:16:56 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>, Jesse Zhang <jesse.zhang@amd.com>
Subject: [PATCH 3/7] drm/amdgpu: require a job to schedule an IB
Date: Mon, 16 Mar 2026 14:16:44 -0400
Message-ID: <20260316181648.2005897-3-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260316181648.2005897-1-alexander.deucher@amd.com>
References: <20260316181648.2005897-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE36:EE_|MN6PR12MB8469:EE_
X-MS-Office365-Filtering-Correlation-Id: 92a0070b-8fd4-4025-2bda-08de8388364d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|376014|1800799024|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: lYmd5HaT7Gzn2YKdIIt9efi7PndtuG5nIRJh+lhh8MB+jguGenfDK1I+yDPZ9XzirwilOP/E7pFEP6c1gPKcnAtkK2cPIKHutzklmdBzgJXoHZovQTfuxmg964H2RGpA8+6lEy5PUGCgoP96t7fmcp7KmxPPzejCMdlpkD4x4GoDUcuioBxrucwRwgPHxz4DdWsYuFNTBDPKs/9juNt+0J6mYcLmDsyeGOy6+dBRk3PPE3R+a/kNF2tlV+GDInPZ0/n6DGdcgWJu+3+wrAijlqr1DdzrXXmsYy6Cw3wqsKrAZwRXCaccQw0z8Yxa8roQPYhlKZti9XtmVClR6aoHRvu/9bJvBO0FFWg3M96vxwU1eIHcRpcHSYyN565uCLm5zon8YmmpnLFFhDuEFTjjiosp9aVFj5L/S7Js0wJBiuR35k2PXH2BY9hB1cFRD/Ja/8dhotaZgqcETm20mvsCKGhlIWP4+uDaJmV4iVvd5rTWTJhZUBOsVmu7D12zloCEfGLCcm/WHsnyJP6R3bwijrhLfx5vTmQ3ZUwngj6j+XBSsCyDniwYgSBquWX82EhK4Bco14jpXtblhSmdBWPnbLg3ZqJKpkT/TdN8OQ+MKdAAjnvMbPc3iKU0AEkqPOnuz8xfxvYaslJ2Ehw0hJ4+W+i1KVm99R9JbeuV831I3xon6wmM6lp1vBkVBxx+xFqF9ipq9rNUUI2wnkrMUoWctLtbzDv2xby8/CAPUSxOskYTGxtPpAh69B82NYYDMTkLbdNhGRyfZ3tEGIZyiSBQNQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(376014)(1800799024)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 7kfvQJLWf1QCUneK1vyFbHutjjJ3b0TAnDdpT3EbX65UBf/ohEoBxKtuKeXXiggVIcqEDGYX4DnBKVtuQM13Lvf+wlbM8jVh9tOhed+wYE5+qCwI2J8+ILgNznyVX/RQfyWZCvELmKU4gi2mWXvk62cV9TJQf36nBi9yoqnT18rzEY23gJjG9KH3fOXMIZGvuqpL/6CGprSZD9b/4GWXAwfQMgCTpGosfEuS8wSG2qfeVPiQJst1hH2W8WO913cCh6AA5xQm3LzPw7ZhaMS4X6FsjZLLBSl8KgDWBnvgoaFW4qdpltCxKm0eTOLRAsmg2mg99bgnaGKZ9tp3ounGAvMwy7VTtwhplq7KBdIAHJoGcE0LlUxyo7FX9mjtyvDo1xBgZXA2yW5Wbj8uAUcZTfeQkhvbzw5mv71VW7ySlY/EFutLK8tDlyrCWy1Co7c2
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2026 18:16:58.2140 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 92a0070b-8fd4-4025-2bda-08de8388364d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE36.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8469
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

