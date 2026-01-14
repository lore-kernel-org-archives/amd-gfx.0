Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE8B6D38FED
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Jan 2026 16:48:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4EC9110E65C;
	Wed, 14 Jan 2026 16:48:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="DZ6AQQh+";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012030.outbound.protection.outlook.com [40.107.209.30])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D9C7D10E668
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Jan 2026 16:48:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pv+Vu0ynkJQHDWOyKRRGsNHogLoFOp2crHc4oxdM3EM8kh3TG9cTvpp3TELQnGKlA9AOZ3o01/N3+sGQzE9guSUu9OKNWsrHV0BpX1wXh4ADVecDScgtJ0Rk6dQpEdsnTNIDj2+vQHRS+BtLAyR4MuNEv1lbAsKMvqtjiLv403Ung21QB5Z4OqF+R57EIPwVo7QsjVQ1bG44G3CGnM0I87wsILx4mSKWiQpfEt7CCHbX3E6562+VdDMW6bgpWX9zmCAb+OX513g5qAdmg7t2QD8e/JgLVpyvdaR9vC0YnkOBUSKcWY75Sb0SPc7dQ+h+sucgW0BeVyaNqYFD8dXGjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vRbwjY8lmE2As1qIEFhjEpD1Vg7hvBv/z2s1iZxB0eE=;
 b=FmJDpvIX7Cfex867qpr3ZrGsRuyzfuwrm2KuqHOTy2vulDtDuaPkPmlzg+uWHhkKD+cXgZNqS/OCwKLtH7XFJ/xPdJhExc50BtjJYErA6WqVmiR43rljVhF2Kfs+sLd6Qu1kNBgkucjb7sCyR5S9lyX5s4C6ytZWHkqDNDFsShxYRtJopu/j8H+zoQWxLqIjdL+B5HcWlb1b4OvgD3N04FvkGStP5L5Z3lqqjh6RJy0LxtSU4XfdR2k8FudCs0KoZ6BYV0q1Qvn0GstsQdNGJcyiQvwtkTOReIFgNalK1w9za1VsoDxNLlOPgkq21rm/8bo1NVpq+lIwiZGoyWtXYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vRbwjY8lmE2As1qIEFhjEpD1Vg7hvBv/z2s1iZxB0eE=;
 b=DZ6AQQh+0t6fnWNU4HNVDj+qS2V3Ttw2gpZnVZvqCN01CiinGd2qEWyg+8wPmdM3kendRdRA5n32KytaohpWKqAjJmaQtXj/hkrXBNIHQjPeD29uLMXF4B/N2vjy+VZZGYj+f/0dU2r6YkG4jr1O92CkuYuUeNyOTYM8bnos2oE=
Received: from PH8PR02CA0020.namprd02.prod.outlook.com (2603:10b6:510:2d0::9)
 by CY3PR12MB9555.namprd12.prod.outlook.com (2603:10b6:930:10a::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.5; Wed, 14 Jan
 2026 16:48:15 +0000
Received: from CY4PEPF0000E9D7.namprd05.prod.outlook.com
 (2603:10b6:510:2d0:cafe::e3) by PH8PR02CA0020.outlook.office365.com
 (2603:10b6:510:2d0::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.6 via Frontend Transport; Wed,
 14 Jan 2026 16:48:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000E9D7.mail.protection.outlook.com (10.167.241.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Wed, 14 Jan 2026 16:48:14 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 14 Jan
 2026 10:47:53 -0600
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Wed, 14 Jan 2026 10:47:53 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 37/42] drm/amdgpu: split ib schedule and ib emit logic
Date: Wed, 14 Jan 2026 11:47:22 -0500
Message-ID: <20260114164727.15367-38-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260114164727.15367-1-alexander.deucher@amd.com>
References: <20260114164727.15367-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D7:EE_|CY3PR12MB9555:EE_
X-MS-Office365-Filtering-Correlation-Id: 28a56c17-c300-4808-d600-08de538cb5f1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?sKdN8TZzFSTL+ihNKnYrhLnowB1mYpsX0Z27p4a+aK/cKWrA2HDFY/3ZUg+i?=
 =?us-ascii?Q?1zyWku/WHcgKd+nOseKjooK9bCXf6QPX2NSKAJwtaSmgrKExs1qYKIBPpT69?=
 =?us-ascii?Q?tHnKNqxdC1BgoHAzMWWuYtCuL3ZEpKVuYOta783GzvSlV973T90e3HFwtN0R?=
 =?us-ascii?Q?TzLQH6qizolH/DejvHW1j7XgD40hoBtqeREstuM5kZUzyLEO6NQAF59KxUb2?=
 =?us-ascii?Q?vDL3wOJSJlazv2050vTBswdp41kOR0hP9kB/EmfDS38Csm4Ax4Z6ulhSG7AX?=
 =?us-ascii?Q?/Pmj32Ke1gwUQ3LPQZTBvBMYDDRiQlD8P57/0OVQayqCy3CX+xV3c/poWrAr?=
 =?us-ascii?Q?5MTOrgtk1QoaidO9SiA3W4mDDHqkMu80yr55wV394Z+RZ6R6hVU3+xrjpSuB?=
 =?us-ascii?Q?f018eE9yg49NWId2GrvmjgMoTiA2W+VaN/SNeCEtNRwC5AdtFr75b956EF4u?=
 =?us-ascii?Q?UT2UGTaZ8BPo158uniZWz445fsfC0bXQzKx5vm4dqjo70uVIPt7IkLklPb4Q?=
 =?us-ascii?Q?laE69PJZ0EFIoPaO/Vw/o0wx3crA345AyprVfBEXt+wo4qnnbTEmaANhDSww?=
 =?us-ascii?Q?+1FsSfzQryCMWYEkBRhqJ/2hTZSdGjDCa2pNRNwIrbZu7Mvh8PmQtpF08op9?=
 =?us-ascii?Q?7oFT+lmOupzx2RFdE46t68nKX9lhgwed14uPBRNKvtoG9EbnS2mmviZ06urn?=
 =?us-ascii?Q?JXmHi48gZd68FwWvqK39fOH6ftYoLwlddEZ/nocZaekH/0g96YUnanNSb2gp?=
 =?us-ascii?Q?NoN1y4vrdRuaxtt7eqvavF1RQDxks9SMLurpqcFEYPF8zXW8MMrvGhhr4meh?=
 =?us-ascii?Q?AdOq8eJiGa6OW5QfByhfazf23VTqyWehdCjGwTthIJScllVhQ27eAQ8NYBDX?=
 =?us-ascii?Q?u7x14VPS5cLZgGGthAmjw7ye2PUurNh+vndVJPsm/Yh+R8y6xrqDLQ786HFm?=
 =?us-ascii?Q?HRpzuWpzexmV7gFS1Wc0CX8ss7H0tA9cTf+dgglSoz5++dva3hbQN7EdSJDA?=
 =?us-ascii?Q?DG1KBAFSfoejF3eyONsEfxGI4VVf5ZJcXozGtmDhusncR9x8IFiukqDwovp3?=
 =?us-ascii?Q?vv60VW/cWaE+j5BDDgcs0Wq9YXBei3n+kQOjqzgyyE97UfDE3K+uehd3/OIX?=
 =?us-ascii?Q?ZhWQv31jpGrlVeZRJp1CphXk7hzwk35M8g+JDYEF/4hQZMw4vdNuCVJz0cZY?=
 =?us-ascii?Q?bKpvygyoGQMShPZoNxzSg9FRLgmCkd+/ZQu5UqHIlibms4a/y+L96w1noXtU?=
 =?us-ascii?Q?NfGj7rA13c6jMh3pcOAwY6+3wB2YeDpalOd0dc6wtVUqiXIjhv/vCeZW/aSn?=
 =?us-ascii?Q?tkOHQKTIeJ3dDrMtv4tSvi9DM6NhqqipZeO+riaTYuzD4Fy5rGZmt5rbvce5?=
 =?us-ascii?Q?z3koL7Pd9Hug3q4O7Bvdn5a56lP7YuMhPtimiZd0KXWwcoSzLqaQlzZtjKDu?=
 =?us-ascii?Q?zftZjTnykvVJDZ2WEDj7BBzNAL54eyBkd69Hy4s6cX4hMUKx4Z34yoY5P+AO?=
 =?us-ascii?Q?/Iqw2P2GxBol9X/kd4H20Pm/qoaK9trayrZ9+/oLDD+R7d9/GFjzV1nc9A/p?=
 =?us-ascii?Q?cUH/mbfz4FSShsJZ2z3T9GUTP+yMK59LnRD6TrtIBGnRFm3Ddwt2JKOkL5UK?=
 =?us-ascii?Q?0QH6+3jxVsO60zVx2cOwzmUJ94Ne1f2RABCc6po4VwbDoLnxQEUA+9bCfCf1?=
 =?us-ascii?Q?n/ZiZg=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2026 16:48:14.5375 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 28a56c17-c300-4808-d600-08de538cb5f1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D7.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY3PR12MB9555
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

No intended functional change.  Split the logic into
two functions, one to set the state and one to use
the state to emit the ring contents.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c | 201 ++++++++++++++-----------
 1 file changed, 110 insertions(+), 91 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
index f2b95ad57d97f..4126be3ed3efd 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
@@ -99,40 +99,15 @@ void amdgpu_ib_free(struct amdgpu_ib *ib, struct dma_fence *f)
 	amdgpu_sa_bo_free(&ib->sa_bo, f);
 }
 
-/**
- * amdgpu_ib_schedule - schedule an IB (Indirect Buffer) on the ring
- *
- * @ring: ring index the IB is associated with
- * @job: job to schedule
- * @f: fence created during this submission
- *
- * Schedule an IB on the associated ring (all asics).
- * Returns 0 on success, error on failure.
- *
- * On SI, there are two parallel engines fed from the primary ring,
- * the CE (Constant Engine) and the DE (Drawing Engine).  Since
- * resource descriptors have moved to memory, the CE allows you to
- * prime the caches while the DE is updating register state so that
- * the resource descriptors will be already in cache when the draw is
- * processed.  To accomplish this, the userspace driver submits two
- * IBs, one for the CE and one for the DE.  If there is a CE IB (called
- * a CONST_IB), it will be put on the ring prior to the DE IB.  Prior
- * to SI there was just a DE IB.
- */
-int amdgpu_ib_schedule(struct amdgpu_ring *ring, struct amdgpu_job *job,
-		       struct dma_fence **f)
+static int amdgpu_ib_emit(struct amdgpu_ring *ring, struct amdgpu_job *job)
 {
 	struct amdgpu_device *adev = ring->adev;
+	int vmid = AMDGPU_JOB_GET_VMID(job);
 	struct amdgpu_ib *ib;
-	struct dma_fence *tmp = NULL;
-	struct amdgpu_fence *af;
-	struct amdgpu_vm *vm;
-	uint64_t fence_ctx;
 	uint32_t status = 0, alloc_size;
+	u64 shadow_va, csa_va, gds_va;
 	unsigned int fence_flags = 0;
 	bool secure, init_shadow;
-	u64 shadow_va, csa_va, gds_va;
-	int vmid = AMDGPU_JOB_GET_VMID(job);
 	unsigned int cond_exec;
 	unsigned int i;
 	int r = 0;
@@ -143,61 +118,23 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, struct amdgpu_job *job,
 		return -EINVAL;
 
 	ib = &job->ibs[0];
-	vm = job->vm;
-	fence_ctx = job->base.s_fence ?
-		job->base.s_fence->finished.context : 0;
 	shadow_va = job->shadow_va;
 	csa_va = job->csa_va;
 	gds_va = job->gds_va;
 	init_shadow = job->init_shadow;
-	af = job->hw_fence;
-	/* Save the context of the job for reset handling.
-	 * The driver needs this so it can skip the ring
-	 * contents for guilty contexts.
-	 */
-	af->context = fence_ctx;
-	/* the vm fence is also part of the job's context */
-	job->hw_vm_fence->context = fence_ctx;
-
-	if (!ring->sched.ready) {
-		dev_err(adev->dev, "couldn't schedule ib on ring <%s>\n", ring->name);
-		return -EINVAL;
-	}
 
-	if (vm && !job->vmid) {
-		dev_err(adev->dev, "VM IB without ID\n");
-		return -EINVAL;
-	}
-
-	if ((ib->flags & AMDGPU_IB_FLAGS_SECURE) &&
-	    (!ring->funcs->secure_submission_supported)) {
-		dev_err(adev->dev, "secure submissions not supported on ring <%s>\n", ring->name);
-		return -EINVAL;
-	}
+	if (ib->flags & AMDGPU_IB_FLAG_TC_WB_NOT_INVALIDATE)
+		fence_flags |= AMDGPU_FENCE_FLAG_TC_WB_ONLY;
 
 	alloc_size = ring->funcs->emit_frame_size + job->num_ibs *
 		ring->funcs->emit_ib_size;
 
 	r = amdgpu_ring_alloc(ring, alloc_size);
 	if (r) {
-		dev_err(adev->dev, "scheduling IB failed (%d).\n", r);
+		dev_err(adev->dev, "Ring allocation for IB failed (%d).\n", r);
 		return r;
 	}
 
-	job->need_ctx_switch = ring->current_ctx != fence_ctx;
-	if (ring->funcs->emit_pipeline_sync && job &&
-	    ((tmp = amdgpu_sync_get_fence(&job->explicit_sync)) ||
-	     job->need_ctx_switch || amdgpu_vm_need_pipeline_sync(ring, job))) {
-
-		job->need_pipe_sync = true;
-		job->pipe_sync_seq = ring->fence_drv.sync_seq;
-
-		if (tmp)
-			trace_amdgpu_ib_pipe_sync(job, tmp);
-
-		dma_fence_put(tmp);
-	}
-
 	if ((ib->flags & AMDGPU_IB_FLAG_EMIT_MEM_SYNC) && ring->funcs->emit_mem_sync)
 		ring->funcs->emit_mem_sync(ring);
 
@@ -208,11 +145,6 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, struct amdgpu_job *job,
 	if (ring->funcs->insert_start)
 		ring->funcs->insert_start(ring);
 
-	r = amdgpu_vm_flush(ring, job);
-	if (r) {
-		amdgpu_ring_undo(ring);
-		return r;
-	}
 	amdgpu_vm_emit_flush(ring, job);
 
 	amdgpu_ring_ib_begin(ring);
@@ -264,9 +196,6 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, struct amdgpu_job *job,
 
 	amdgpu_device_invalidate_hdp(adev, ring);
 
-	if (ib->flags & AMDGPU_IB_FLAG_TC_WB_NOT_INVALIDATE)
-		fence_flags |= AMDGPU_FENCE_FLAG_TC_WB_ONLY;
-
 	/* wrap the last IB with fence */
 	if (job->uf_addr) {
 		amdgpu_ring_emit_fence(ring, job->uf_addr, job->uf_sequence,
@@ -278,25 +207,13 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, struct amdgpu_job *job,
 		amdgpu_ring_init_cond_exec(ring, ring->cond_exe_gpu_addr);
 	}
 
-	r = amdgpu_fence_init(ring, af);
-	if (r) {
-		dev_err(adev->dev, "failed to emit fence (%d)\n", r);
-		if (job->vmid)
-			amdgpu_vmid_reset(adev, ring->vm_hub, job->vmid);
-		amdgpu_ring_undo(ring);
-		return r;
-	}
-	amdgpu_fence_emit(ring, af, fence_flags);
-	*f = &af->base;
-	/* get a ref for the job */
-	dma_fence_get(*f);
+	amdgpu_fence_emit(ring, job->hw_fence, fence_flags);
 
 	if (ring->funcs->insert_end)
 		ring->funcs->insert_end(ring);
 
 	amdgpu_ring_patch_cond_exec(ring, cond_exec);
 
-	ring->current_ctx = fence_ctx;
 	if (ring->funcs->emit_switch_buffer)
 		amdgpu_ring_emit_switch_buffer(ring);
 
@@ -310,7 +227,7 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, struct amdgpu_job *job,
 	 * fence so we know what rings contents to backup
 	 * after we reset the queue.
 	 */
-	amdgpu_fence_save_wptr(af);
+	amdgpu_fence_save_wptr(job->hw_fence);
 
 	amdgpu_ring_ib_end(ring);
 	amdgpu_ring_commit(ring);
@@ -318,6 +235,108 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, struct amdgpu_job *job,
 	return 0;
 }
 
+/**
+ * amdgpu_ib_schedule - schedule an IB (Indirect Buffer) on the ring
+ *
+ * @ring: ring index the IB is associated with
+ * @job: job to schedule
+ * @f: fence created during this submission
+ *
+ * Schedule an IB on the associated ring (all asics).
+ * Returns 0 on success, error on failure.
+ *
+ * On SI, there are two parallel engines fed from the primary ring,
+ * the CE (Constant Engine) and the DE (Drawing Engine).  Since
+ * resource descriptors have moved to memory, the CE allows you to
+ * prime the caches while the DE is updating register state so that
+ * the resource descriptors will be already in cache when the draw is
+ * processed.  To accomplish this, the userspace driver submits two
+ * IBs, one for the CE and one for the DE.  If there is a CE IB (called
+ * a CONST_IB), it will be put on the ring prior to the DE IB.  Prior
+ * to SI there was just a DE IB.
+ */
+int amdgpu_ib_schedule(struct amdgpu_ring *ring, struct amdgpu_job *job,
+		       struct dma_fence **f)
+{
+	struct amdgpu_device *adev = ring->adev;
+	struct dma_fence *tmp = NULL;
+	struct amdgpu_fence *af;
+	struct amdgpu_ib *ib;
+	struct amdgpu_vm *vm;
+	uint64_t fence_ctx;
+	int r = 0;
+
+	if (!job)
+		return -EINVAL;
+	if (job->num_ibs == 0)
+		return -EINVAL;
+
+	ib = &job->ibs[0];
+	vm = job->vm;
+	fence_ctx = job->base.s_fence ?
+		job->base.s_fence->finished.context : 0;
+	af = job->hw_fence;
+	/* Save the context of the job for reset handling.
+	 * The driver needs this so it can skip the ring
+	 * contents for guilty contexts.
+	 */
+	af->context = fence_ctx;
+	/* the vm fence is also part of the job's context */
+	job->hw_vm_fence->context = fence_ctx;
+
+	if (!ring->sched.ready) {
+		dev_err(adev->dev, "couldn't schedule ib on ring <%s>\n", ring->name);
+		return -EINVAL;
+	}
+
+	if (vm && !job->vmid) {
+		dev_err(adev->dev, "VM IB without ID\n");
+		return -EINVAL;
+	}
+
+	if ((ib->flags & AMDGPU_IB_FLAGS_SECURE) &&
+	    (!ring->funcs->secure_submission_supported)) {
+		dev_err(adev->dev, "secure submissions not supported on ring <%s>\n", ring->name);
+		return -EINVAL;
+	}
+
+	job->need_ctx_switch = ring->current_ctx != fence_ctx;
+	if (ring->funcs->emit_pipeline_sync && job &&
+	    ((tmp = amdgpu_sync_get_fence(&job->explicit_sync)) ||
+	     job->need_ctx_switch || amdgpu_vm_need_pipeline_sync(ring, job))) {
+
+		job->need_pipe_sync = true;
+		job->pipe_sync_seq = ring->fence_drv.sync_seq;
+
+		if (tmp)
+			trace_amdgpu_ib_pipe_sync(job, tmp);
+
+		dma_fence_put(tmp);
+	}
+
+	r = amdgpu_vm_flush(ring, job);
+	if (r)
+		return r;
+
+	r = amdgpu_fence_init(ring, af);
+	if (r) {
+		dev_err(adev->dev, "failed to emit fence (%d)\n", r);
+		if (job->vmid)
+			amdgpu_vmid_reset(adev, ring->vm_hub, job->vmid);
+		return r;
+	}
+	*f = &af->base;
+	/* get a ref for the job */
+	dma_fence_get(*f);
+
+	r = amdgpu_ib_emit(ring, job);
+	if (r)
+		return r;
+	ring->current_ctx = fence_ctx;
+
+	return 0;
+}
+
 /**
  * amdgpu_ib_pool_init - Init the IB (Indirect Buffer) pool
  *
-- 
2.52.0

