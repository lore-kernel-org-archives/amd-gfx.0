Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EC09C982D4
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Jan 2026 16:21:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A181B10E8DB;
	Fri, 16 Jan 2026 16:21:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="yzOVHi0/";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012056.outbound.protection.outlook.com
 [40.107.200.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 005BD10E8DD
 for <amd-gfx@lists.freedesktop.org>; Fri, 16 Jan 2026 16:21:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M9De6gJ3WT1W86idcpgZSUa2+LPEoaBDPiJrYLeJewH3QtiyK7uRIbB/CpWfMhZMwlVeWlKQ8CkJXBNqjyNjO7O0VQroDQgftcA5/MZo/kaRjSIITPAHDbmjQ4TBo+DjhO/WC+vqpiIg58fUi08xzuHhcBy1f/aRAm8CQIGTdh7VAdUAqsNiQdLTzkLOzZBPtMyXwjpbbG1AP0rSG9NYMR4EsaKAMOsUWZITHajEMFMmmRehD1AnzEng19s3oYc+qaw6QONUwgR+qK5woesv++cyvkKvYRjEpcI/AXJatmVek9zmReyou4rfHML85BIYKPvxmhgXX7gkRiW8XmSX3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rgST917YXbytKvu9MOcMq1z+KwvJQOxoc0twz2ZxW3U=;
 b=NWGVAEGMcYy88L7P6U9EwNzaGFYYPnBjPNcfUOqdz+Dn5aoG/rXsjp9Bcca/X/Pcjw+30u7VmGpGh9NrNjqr8h5p7BH5Hye0+FU0VZq/92THZ3kUtgkPcs6tvd4oSs1uoAM2V7TnFpMN4AWqWHuXuJsRV7vEZJyVTpg0Kaes0vQlVsER8gg2wNklLOjFyDNTNgTR2LW87aXDj4xuTpHFxE1CvjeqjU9meZl5X7+p8y07/t3SlV+VByqj++jcQtegN6cmCjQCsec/c05cQXBGThYx2lOrGKqVGCUaS/MSwUCeGof1UjTc9yNwJuxRjpvpobLKRqzlwLZm9U4ACXDBdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rgST917YXbytKvu9MOcMq1z+KwvJQOxoc0twz2ZxW3U=;
 b=yzOVHi0/nPmcwWN+O1j3nyVVRKtR2eO5lx51HqDPbwckJrify1vNhqaCc2YeN/laouta0qlEfMkdcbHCCPoj94K4aqoJhgpQsuXfKieuObTth0oS9kntTsbtSb8poIq5PNBi/FSfzQLy/SJ75S5wJORrE+XcTyU/YCRNKC/vBDI=
Received: from CH0PR08CA0030.namprd08.prod.outlook.com (2603:10b6:610:33::35)
 by DS0PR12MB7770.namprd12.prod.outlook.com (2603:10b6:8:138::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.5; Fri, 16 Jan
 2026 16:20:44 +0000
Received: from CH3PEPF00000015.namprd21.prod.outlook.com
 (2603:10b6:610:33:cafe::24) by CH0PR08CA0030.outlook.office365.com
 (2603:10b6:610:33::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.8 via Frontend Transport; Fri,
 16 Jan 2026 16:20:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CH3PEPF00000015.mail.protection.outlook.com (10.167.244.120) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.0 via Frontend Transport; Fri, 16 Jan 2026 16:20:44 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 16 Jan
 2026 10:20:43 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 16 Jan
 2026 10:20:42 -0600
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Fri, 16 Jan 2026 10:20:42 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 05/10] drm/amdgpu: require a job to schedule an IB
Date: Fri, 16 Jan 2026 11:20:22 -0500
Message-ID: <20260116162027.21550-6-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260116162027.21550-1-alexander.deucher@amd.com>
References: <20260116162027.21550-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000015:EE_|DS0PR12MB7770:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d3d4210-7994-4083-79b6-08de551b32fe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?73aV9N315D/Ub1K0O03jJFFrossRXSEXt07X75gaXiUkQOVF2Zs1B2iZ6gdS?=
 =?us-ascii?Q?dLZSdQwkfUL+yCZjj10PkiCdS6ySxJeGwd1BnWXavqx2LeVIFQppC+Qd6gCz?=
 =?us-ascii?Q?KgY2jq1m5i0LtFN6AGVwzpn6om4YAKpUhd1+T0Lc07shDGhxJzLMRNqAglBB?=
 =?us-ascii?Q?A27vAw/aPgSp1FkqDR7462cf+10yEJvCBG0WAlwpmbnsqEOVjf16WlqU0Tna?=
 =?us-ascii?Q?R0RrSyghNE8RSCjhZkx3fILxhUO8CHRC5JRDLZ4p78rersAUker3kTweNU3y?=
 =?us-ascii?Q?KbSsKL89pVDfwRxopEMswLipRrwv9vCXSWe1NF70MqNnZHJ2JHScVrJHJkKE?=
 =?us-ascii?Q?OhCMrM6WYlQ1cortAD9Gad1a8h4FE5VLCDiUUIpeX8cu0rnWEZiRaTgr+Q/n?=
 =?us-ascii?Q?f5NEFpo8yEiw91F/DS5z6mPam5iLq5F4eRd3QIV1Zs5rsYmJKjvXz5k36n6m?=
 =?us-ascii?Q?hXJ3BmBF6qJ+RnXDu4YbuMii/v9LSDxk4yeRIb9u1KmPrQJ4uG0UbFa/I+Fe?=
 =?us-ascii?Q?6qo4HsY5ClREslls4uiGHj5hwLXSspTdsR92pm3Zzapsco1rvrJsf2lCfpm3?=
 =?us-ascii?Q?AL3KhNZfH9RtzW5advVyQfIjUAyJ2kb2urDyK3Ck8pxVIHR+usQF3M/5dGmG?=
 =?us-ascii?Q?HVzyeW+OaVW+QNr4prxpJG6wkfFjtoktCq+1MY6QPa8fYxkV4p3gzRMzTfOA?=
 =?us-ascii?Q?Y1wxYLSSdEWjA8AINFQiSM7i0356HchCcD/HLgACeNMlMoPInDUOSDe5SdT0?=
 =?us-ascii?Q?Rj7Rh4qV3V/io8j8RPxp4trq9Lqbc5hb6dNOKObJRBjVD/jiTlnNeQaZVLOC?=
 =?us-ascii?Q?6MuRjOdkXEnAkpC5HGiXGIKb2kwqhpTuho7750sLMctONl8Xp5BlSgK++dRV?=
 =?us-ascii?Q?gzz3LRcQPA8H5iq8ij2TND6Yf+XqUKkirx4o0KUeZvd8ofuqbb22RaDgW42Y?=
 =?us-ascii?Q?C7HpBEHvFAAUfEwOU8RU5wbhfwpajlT6VgPg4AA6exGbo41cv3DFeVH9RL7T?=
 =?us-ascii?Q?CJ5/Aj5ZY0zVMkipuw1Wpfm3/AA7xJSJi5cJ0Pb7kxEzRagTxaDughJtesKy?=
 =?us-ascii?Q?OFrw2fTduMrcJKkagRa0yvK0xRyNcduo9xgsxXzwGPUxXPrzYONNbYiC/ZH7?=
 =?us-ascii?Q?WkoDeW7QnqziwQ7xFE8EyMKph8U1YHdEQ2W9pUDTV6TlzOOC4BrK25qFR6fi?=
 =?us-ascii?Q?/Sga7uH5lHDb52nOJ9v1GuElTenJ6lgENhPGg/ItvRgI1wmnynMbtTRik9kz?=
 =?us-ascii?Q?DN5pRQldhUSLi3E+nydqEkHx2AeKiqFMhRxnv5sxPXekwwY0Ry3WEPPbGSLy?=
 =?us-ascii?Q?6fI+LnJqkTH2Xin5qTmVH/rR/hPPfI/Uapw3C0vvWNtogVUedVRtOEszIJ2F?=
 =?us-ascii?Q?kP6lEO6TORgnmo53k6bKRB5BqrsQhc3Efx3mgk3+yb2gLmSck5ArerF7Rday?=
 =?us-ascii?Q?e+Txx7coA9QEAz5t3KUh5gKzVb/zyenZnMtlw3VCyndm9tTl8w945Uiy5yVL?=
 =?us-ascii?Q?+sm5LSxgOo6IW2FZkSsa3eguSiJSE9kVdqYSpBGgg2fgH7uTvszmMvLxcByQ?=
 =?us-ascii?Q?DKMQtq8y4m2a7xY2nbzcexJMhnmRzSDA6AamnWjkbdFF/rBLPgFa9HlJaXoI?=
 =?us-ascii?Q?AzUfUcwFp4TndWzEEyOGUFAKqnDdFpDW5LC1KQB2MED54gnWxXfYr8kyulsZ?=
 =?us-ascii?Q?B8FTww=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2026 16:20:44.0655 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d3d4210-7994-4083-79b6-08de551b32fe
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF00000015.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7770
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

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c     | 106 ++++++++-------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.c    |   5 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h   |   3 +-
 4 files changed, 45 insertions(+), 71 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
index 877d0df50376a..399a59bf907dd 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
@@ -686,7 +686,7 @@ int amdgpu_amdkfd_submit_ib(struct amdgpu_device *adev,
 	job->vmid = vmid;
 	job->num_ibs = 1;
 
-	ret = amdgpu_ib_schedule(ring, 1, ib, job, &f);
+	ret = amdgpu_ib_schedule(ring, job, &f);
 
 	if (ret) {
 		drm_err(adev_to_drm(adev), "failed to schedule IB.\n");
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
index 136e50de712a0..fb58637ed1507 100644
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
@@ -121,12 +119,11 @@ void amdgpu_ib_free(struct amdgpu_ib *ib, struct dma_fence *f)
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
 	bool need_ctx_switch;
@@ -142,64 +139,51 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned int num_ibs,
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
+	vm = job->vm;
+	fence_ctx = job->base.s_fence ?
+		job->base.s_fence->finished.context : 0;
+	shadow_va = job->shadow_va;
+	csa_va = job->csa_va;
+	gds_va = job->gds_va;
+	init_shadow = job->init_shadow;
+	af = job->hw_fence;
+	/* Save the context of the job for reset handling.
+	 * The driver needs this so it can skip the ring
+	 * contents for guilty contexts.
+	 */
+	af->context = fence_ctx;
+	/* the vm fence is also part of the job's context */
+	job->hw_vm_fence->context = fence_ctx;
 
 	if (!ring->sched.ready) {
 		dev_err(adev->dev, "couldn't schedule ib on ring <%s>\n", ring->name);
-		r = -EINVAL;
-		goto free_fence;
+		return -EINVAL;
 	}
 
 	if (vm && !job->vmid) {
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
@@ -225,12 +209,10 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned int num_ibs,
 	if (ring->funcs->insert_start)
 		ring->funcs->insert_start(ring);
 
-	if (job) {
-		r = amdgpu_vm_flush(ring, job, need_pipe_sync);
-		if (r) {
-			amdgpu_ring_undo(ring);
-			return r;
-		}
+	r = amdgpu_vm_flush(ring, job, need_pipe_sync);
+	if (r) {
+		amdgpu_ring_undo(ring);
+		return r;
 	}
 
 	amdgpu_ring_ib_begin(ring);
@@ -248,7 +230,7 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned int num_ibs,
 	if (need_ctx_switch)
 		status |= AMDGPU_HAVE_CTX_SWITCH;
 
-	if (job && ring->funcs->emit_cntxcntl) {
+	if (ring->funcs->emit_cntxcntl) {
 		status |= job->preamble_status;
 		status |= job->preemption_status;
 		amdgpu_ring_emit_cntxcntl(ring, status);
@@ -257,15 +239,15 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned int num_ibs,
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
@@ -277,7 +259,7 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned int num_ibs,
 		status &= ~AMDGPU_HAVE_CTX_SWITCH;
 	}
 
-	if (job && ring->funcs->emit_frame_cntl)
+	if (ring->funcs->emit_frame_cntl)
 		amdgpu_ring_emit_frame_cntl(ring, false, secure);
 
 	amdgpu_device_invalidate_hdp(adev, ring);
@@ -286,7 +268,7 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned int num_ibs,
 		fence_flags |= AMDGPU_FENCE_FLAG_TC_WB_ONLY;
 
 	/* wrap the last IB with fence */
-	if (job && job->uf_addr) {
+	if (job->uf_addr) {
 		amdgpu_ring_emit_fence(ring, job->uf_addr, job->uf_sequence,
 				       fence_flags | AMDGPU_FENCE_FLAG_64BIT);
 	}
@@ -299,15 +281,14 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned int num_ibs,
 	r = amdgpu_fence_emit(ring, af, fence_flags);
 	if (r) {
 		dev_err(adev->dev, "failed to emit fence (%d)\n", r);
-		if (job && job->vmid)
+		if (job->vmid)
 			amdgpu_vmid_reset(adev, ring->vm_hub, job->vmid);
 		amdgpu_ring_undo(ring);
-		goto free_fence;
+		return r;
 	}
 	*f = &af->base;
 	/* get a ref for the job */
-	if (job)
-		dma_fence_get(*f);
+	dma_fence_get(*f);
 
 	if (ring->funcs->insert_end)
 		ring->funcs->insert_end(ring);
@@ -315,7 +296,7 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned int num_ibs,
 	amdgpu_ring_patch_cond_exec(ring, cond_exec);
 
 	ring->current_ctx = fence_ctx;
-	if (job && ring->funcs->emit_switch_buffer)
+	if (ring->funcs->emit_switch_buffer)
 		amdgpu_ring_emit_switch_buffer(ring);
 
 	if (ring->funcs->emit_wave_limit &&
@@ -334,11 +315,6 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned int num_ibs,
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
index c7e4d79b9f61d..b09ac3dda17a4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
@@ -373,7 +373,7 @@ int amdgpu_job_submit_direct(struct amdgpu_job *job, struct amdgpu_ring *ring,
 	int r;
 
 	job->base.sched = &ring->sched;
-	r = amdgpu_ib_schedule(ring, job->num_ibs, job->ibs, job, fence);
+	r = amdgpu_ib_schedule(ring, job, fence);
 
 	if (r)
 		return r;
@@ -443,8 +443,7 @@ static struct dma_fence *amdgpu_job_run(struct drm_sched_job *sched_job)
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
index cb0fb1a989d2f..86a788d476957 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
@@ -569,8 +569,7 @@ int amdgpu_ib_get(struct amdgpu_device *adev, struct amdgpu_vm *vm,
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
2.52.0

