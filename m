Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD8FFD1D469
	for <amd-gfx@archiver.kernel.org>; Thu,  8 Jan 2026 14:49:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6D71710E778;
	Thu,  8 Jan 2026 14:49:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="s86EyYpl";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012042.outbound.protection.outlook.com
 [40.107.200.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B299B10E77B
 for <amd-gfx@lists.freedesktop.org>; Thu,  8 Jan 2026 14:49:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Hp8rkz983YdHhRMjGrSvPngnFs0AmM0RJ6c8H7B2DXDeaybh1Rp6WNJaX31O3jULWmMCKn09WXOaJpmSaobS5D3ZEc8JWJke8fKp9vRsMu+dupLQk9BSpErhIqFLv1ydZqVnfwcPN3f+vpjLKc0tckW6aq3emOu0GuEyka85G6FwW4rO/v6+1W9Xd6g/TnYCAgTGS0gsF4ySdHl24HPH4eooVIbbw5Dy4ilHWgZmBfzWJ4WqnwhjTK8yNI0FWBE2ftqi5w4Sy3Xmq/EtmDyXGlACwTD8c7vtDnzXMgaCoJ0gq2Y3pHXuwqXDtbWT5hh0CjcMgB7aaAOAD48Ny1glvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9TDGKa0xtcNcLqV32/Bnk7cEusUL8c37EgdNmybn1wE=;
 b=sTmPp79O4MSOTMTA1GinBBROMECH2CUev1NtujJDjFiChrqSi21BbC8VA27ZCKsxrvbhH1aUBFX0A8WZG128KrBnlDM9JV3aIfOzcOBXRfLuhbIiXZ0iSj+nBtpUonXpdLy+O1pLjkt3fyvgVP7Nume/4UJWFj3LZdJMR8syY4HPHVU92pxf8KScIi5p81ZWJREesJajbelrdemnP2MRzdc8pswyAjuj6FSLNty1YoGyoQcVfUI8sT/sY+1EzF8KBTglWBfwmrb6BTAH6UOEq/gJYcIdOgtQXQXnOrAWTwTMPuX8WTYvCrKc9Iie8e19m/pgCrt+JoTIxJNCRwhVXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9TDGKa0xtcNcLqV32/Bnk7cEusUL8c37EgdNmybn1wE=;
 b=s86EyYplak1pQyORCuDgwm2JSc71sWsF7aALWt3QagSMjVXuCj+E+K2wxootCjTKDShHiZSwep2X02dBbXnpLKI5wkCAwtOWP1oBKhb/qV6crkO7VZb+cq4WQ+GQvEAVseNoweL6gDEpIOBHyoiYGD30xgaSgeP0Fdp/ljX6Ekk=
Received: from BL0PR02CA0112.namprd02.prod.outlook.com (2603:10b6:208:35::17)
 by SJ1PR12MB6169.namprd12.prod.outlook.com (2603:10b6:a03:45c::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.3; Thu, 8 Jan
 2026 14:49:16 +0000
Received: from MN1PEPF0000ECDA.namprd02.prod.outlook.com
 (2603:10b6:208:35:cafe::7e) by BL0PR02CA0112.outlook.office365.com
 (2603:10b6:208:35::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9499.4 via Frontend Transport; Thu, 8
 Jan 2026 14:49:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MN1PEPF0000ECDA.mail.protection.outlook.com (10.167.242.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Thu, 8 Jan 2026 14:49:16 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 8 Jan
 2026 08:49:07 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 8 Jan
 2026 06:49:07 -0800
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Thu, 8 Jan 2026 08:49:07 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 38/42] drm/amdgpu: split ib schedule and ib emit logic
Date: Thu, 8 Jan 2026 09:48:39 -0500
Message-ID: <20260108144843.493816-39-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260108144843.493816-1-alexander.deucher@amd.com>
References: <20260108144843.493816-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECDA:EE_|SJ1PR12MB6169:EE_
X-MS-Office365-Filtering-Correlation-Id: 5adcc436-a3cc-4a1f-827a-08de4ec518a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?xlgSwHlobV6mgveM66UtpQgrbUGDjYfEQz0b/L+6yfYYtfwB0x+jKt+EHsIT?=
 =?us-ascii?Q?TUrUjEmuok0g+3gMnNJ1/KnTg6UogZtzw9p2zm9CFP0vbeVLBNm4rn1VFU7a?=
 =?us-ascii?Q?F3zRiBL87ukOezK/+IOg9R2w4XI1PuVdR21/8az3f40SS0jZRgD70Wh26ENY?=
 =?us-ascii?Q?IyFikpEjhqV6rKQCv6Fa3VaD87eEHK7gjCErT99EnQECEv9jaAAVk6RriyqF?=
 =?us-ascii?Q?xWPPzhjQNgvBo6VpCIHZ/y6npdUTg/sLoHQ0ku+utXRlPmV96EMCtN8V1rnJ?=
 =?us-ascii?Q?uNlldQeuO9r6cH9jOpAA8uTB2QiQESJHzk9V5YzF/FBvzGgA83aCaTCKU9nR?=
 =?us-ascii?Q?V1YlKbbQ9qFE8N4SPxIBn13XwpFFJ4pOc28ZDsW2hQl0/5p8YhVjANFQfZ1O?=
 =?us-ascii?Q?cItd9jjyJdEyR/eU5q3Jwz9h+GST9CYQdCLoeMl4S/Ru+0lxceZNw6gq66B0?=
 =?us-ascii?Q?rdFMCheshysxrZZR5bTitMoub4ZJlpBPZpZEdyq7S4Ze+TM49WqadZFOW9Sm?=
 =?us-ascii?Q?yau6aNgFaYiMvTWEoNKIy/OZSleF2EIcDmRR7zp2qIGgnbktHoetbhqok4eo?=
 =?us-ascii?Q?FKJ8vtfJ/EcLc0QIF27+8M1iUw4N457Mk7Jo1FQPAVXFYIWnwsECF8DsIDqe?=
 =?us-ascii?Q?eTyyvqJEyKZwWoj4QMNOeZZxesJzHGo1KAytkY8kpLtPJuIn+ogYwlb17j35?=
 =?us-ascii?Q?dWO7636vu6mtivGBWxbtobWAqxabQid3t9RaM7cWlhjrU2/K8nT0hiicBH7x?=
 =?us-ascii?Q?9/qgEribvIr3ushqGzxTwFv+LSGM+1DLNcXYn6V/6CEhOu0oAkRlyiGYPeDF?=
 =?us-ascii?Q?LQWcFZ5AdSq+SG0K/ILO9CECeXncrKeUUCIbKlG3aBFdRdwpBtHH12Ub30yM?=
 =?us-ascii?Q?giV3C31TLZFLhGd9rm7RD9BPSuy5H1ZLxDQJn+4w08c9wiJr2SWYSI9KzDJO?=
 =?us-ascii?Q?ICnr1sFRKbgpYwjUivxZjdSZytP8YUAeH8LV4F0wJnBbaAmgqnZZNbyHQOEx?=
 =?us-ascii?Q?fnsd12gQSQ8C9nhWuk20c43XrTbC3fHU76Z1QblU1Xq2cEh0/3sj7ftETUaQ?=
 =?us-ascii?Q?Gu6h/btNeF7l4UTqk73ai/jri/nKskN/9Rxlm9VARxf7PQ+sTkq6WCGY0poY?=
 =?us-ascii?Q?QuxLmUPO+la/9SsCPy0DQHhN1Aex8y25S5QYbXhyYIH6+wdrIvczfHyVyfgb?=
 =?us-ascii?Q?/86KQUPl7LtqSFJSRn5GAvD2QdBjPSD2WpX7hSBcnAZjoUfyymp2/eaiOWwf?=
 =?us-ascii?Q?8raG4RDhH0JlCICoPJNWPJ0MwX64nxP/UV0nScbt6sqLsYT8tanQmx51aY5b?=
 =?us-ascii?Q?q3kgIg/w4Wre2X/uG2fIpcydmtpgyQ9xUH+aZFfyG4gWj76YVOHD7CGy5ndE?=
 =?us-ascii?Q?f2dJPqF69RguRWXs/VnIisO9C9+yGVlTLRb2DVzf5rdOsES0Ev1Dqo5+g4Ed?=
 =?us-ascii?Q?UqYWUkO8ee1IbA14gi649DB1k0IftE98/S+ieObtx3o0jM4gPMXLz7BTYDyQ?=
 =?us-ascii?Q?ALW6Mdp8zaGlsAa5tzsa74tl5owNMaq7rvc/vwzyX+1qdy8A0c8gQXUvHO3l?=
 =?us-ascii?Q?QYe0w83q3Xf/yG0v6cY=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2026 14:49:16.1517 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5adcc436-a3cc-4a1f-827a-08de4ec518a1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECDA.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6169
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
index 54d7a975a74c0..0e648fbe0980f 100644
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

