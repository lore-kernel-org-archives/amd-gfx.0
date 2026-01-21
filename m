Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C533D262BD
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Jan 2026 03:01:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1391D10E6A0;
	Wed, 21 Jan 2026 03:01:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ckpjoo5R";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010014.outbound.protection.outlook.com [52.101.201.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E4A0610E68F
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Jan 2026 03:01:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VsOSeVnu9lXm4eRDt4YU6WJkEGGAllTDrsrf7GYygHwm6zx4Pv3sRCfaFZo/EvG+PKGwpQZHMqPpU9wV4y3rSYUAklw7IH4l7Z6QjzGZla3MmtJ0VMdsccsX4j8OzTBL1U4A7F7XB3Az5AUCM49BwmgGg/JACTT0aYh1mLMYp0Dls8wnmVAajSivASYsJm4LuWfb2DroAh+R6U07dOrh+gJ2BtXkSi5fx0qzfsGPdV20wk5i+abpbUYrLzH5XSB5FCxEHUchrAOu9u5k9dgpr23yug67XOVoKr00OzserW8x6xq8roVjdupUffrIiZBptJ2N07fyy6uoY7pZzdeqDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=914gm5dPrwI3n/jnlpvgy4jW+ombMkUg9fyga2CawFU=;
 b=fqHGHkuMwCClQVUldVvCeMqlmHs8fK6yOshCW8HgvrRELMbRULyatifPI/OMVgX9Cu49Y6l/zO9teCgXDvjZilkvHqq/JQEzLbWX8s2xup66C1Q++NP8fch9j2ALC9f1NEL8IJfxTGEae+t5dZ4Nfb8VcAa3z1pMXB9drmJ/1rH36y8+uMoz6hK4mw1ZjoKPEjWdDT+SOoXDIC6mtEgI/h5etGw2jp7zxPN7MQDQBFGOvvWzk8tRhfgiEZh6DoqZaWZ85GTwjalCTGblrDYmaq46IaWa6imehNcFFjvXE/f/JpMa6RCBMwz28lVtnv6ExKWR3M2mXnaAVKi8jWGc0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=914gm5dPrwI3n/jnlpvgy4jW+ombMkUg9fyga2CawFU=;
 b=ckpjoo5REjMhhybYa6KWFV6NgkqN5BZR4AMN3J03QQPsR7hgccN/e6uQapO2wKYKCj+AeJtzYM/5U7JWj09RltjL6a6ahxyxm6eFQ8nhO0FS1GAoVY1FAlGEDrXUe14vxcJFHroB/RA7XJL8+IGUylS5+bnAlyjLRWqV2NEeQ+g=
Received: from SA1P222CA0164.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:3c3::29)
 by PH7PR12MB6611.namprd12.prod.outlook.com (2603:10b6:510:211::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.12; Wed, 21 Jan
 2026 03:01:29 +0000
Received: from SA2PEPF00003F61.namprd04.prod.outlook.com
 (2603:10b6:806:3c3:cafe::89) by SA1P222CA0164.outlook.office365.com
 (2603:10b6:806:3c3::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.9 via Frontend Transport; Wed,
 21 Jan 2026 03:01:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SA2PEPF00003F61.mail.protection.outlook.com (10.167.248.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.4 via Frontend Transport; Wed, 21 Jan 2026 03:01:28 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 20 Jan
 2026 21:01:27 -0600
Received: from p8.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Tue, 20 Jan 2026 19:01:27 -0800
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>, Jesse Zhang <jesse.zhang@amd.com>
Subject: [PATCH 04/10] drm/amdgpu: require a job to schedule an IB
Date: Tue, 20 Jan 2026 22:00:51 -0500
Message-ID: <20260121030057.1683102-5-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260121030057.1683102-1-alexander.deucher@amd.com>
References: <20260121030057.1683102-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F61:EE_|PH7PR12MB6611:EE_
X-MS-Office365-Filtering-Correlation-Id: 46182e40-854e-469f-ce84-08de58995f86
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?+G70GvZ8NWRGreNAjO9Q9rOfOjO7+RGoODY6GrGmSNQ9Dia2uoi1ghJGkdtn?=
 =?us-ascii?Q?OCRw/E1vD9aAihnJmHnXvDDJHXwlRWDP/sWCe4DcninC6f5OAMGwix4YOBR7?=
 =?us-ascii?Q?ewmyIp9xcXe9ZVtR5T9y/NJds2lmGvrbPNDi5zNA5n+kn57q9SX/pbaIt749?=
 =?us-ascii?Q?zZXo7hionIORv9vnlbMdg9JdBH+DO7OqbT3JoG3Rv+HLkVktPewkyv4tle82?=
 =?us-ascii?Q?qRLfoPPNp5O7jaEsu+2FtoU/5jX84IIFj7jYFhJhZIrFVAQjpk1z3SRCNc3Y?=
 =?us-ascii?Q?kxXa4lfE0G01uvry20m/rFiF/3bXlWcauEP1ivx6lmT/RFXWBttx8UcI0cMY?=
 =?us-ascii?Q?ZUL/k5Ckq+j1iJ6I0b9pETWwLWK31C6Z88dXblnOdyiLHB6R4zkq33katZQF?=
 =?us-ascii?Q?O1UxW+sF7e7EGZ/nV/e/wI4LqydIh1vByaAj44r92ikk6dIi3eEzZqfV7kJy?=
 =?us-ascii?Q?rXXbLkzDrQ4P3ywUv5lfPPByfDW7Mx+q2X+1GwgkyR5U2afMoFcjhju+YOtD?=
 =?us-ascii?Q?RZ47IPvRmjl5elkKEiY64H6+X7V1ijRgbVBvfNaBN0jCJV5WaQ56MGrNkF9e?=
 =?us-ascii?Q?3oUAvqsLZLMkPoGlxqQA04TXO/c1cnQUEeOny+n1rk6I2TysIFXAhVp/qC2M?=
 =?us-ascii?Q?Fn7UgxOB5JtKeMEXzuVtsRoFFipNlD5SFdk4jTmkW211vIftyLT1/BJ07Bsh?=
 =?us-ascii?Q?H/TiEAo7Fy4Eb0z3uAxALwu3IQfmsi1r7oOLW4RzxwUUSa7RxOPOyd28s8Zu?=
 =?us-ascii?Q?WbCbacRvnSFLnIR9uljyYjHLK/4CB2ywtkXtZdSP/I9mN72vu3adOeeyAhfu?=
 =?us-ascii?Q?9nSMcn9JLqQ3+fV/9pxltZPgdXgE+7vSMtlsD89dBMupCs8IodQHMZAc1FcY?=
 =?us-ascii?Q?Piqz0V0iVpENFW/JD467jF4B70Y7uovRk34uA9awjeiqT39j0LCCMUJSCjC6?=
 =?us-ascii?Q?y4EuX95pzCeTnisx5fx0iIBKm7c84bo+kRY6JL9gtbL2yZK2I7HOg4Fiex5H?=
 =?us-ascii?Q?sbkr1sCUQt73btX8rL+le8yA0bjuFjIYiIuNqeO4s1VaxxdHuo2l18CanGkg?=
 =?us-ascii?Q?NSyZ3EjAfUqhfWSfTsB9GLZcu2aWCqa3Xw1y2eQi13AJXYksZYQS+EatqlGT?=
 =?us-ascii?Q?9s01i2RGcAxLEsIKi1Uk7xDCnvaEdJmtbx+n9F8y4epT6+Go0Kq+q6UXaOKz?=
 =?us-ascii?Q?BhMVdABbGrNp4041EUzlRj1snFH9PR05q4XGbEBWH8PxyKZkj0T3Rh75R+UN?=
 =?us-ascii?Q?GfRVTz8s0xVLRCcqrTSN6dDhsEYuOAisUvtFXIQgT18cY3lOBguiSvrEaZtN?=
 =?us-ascii?Q?5fkxX2E6C7QDCqaFkUEdEem3edoNvajGLT6GCWgmQOW9qTfqf/Ypx8549fTt?=
 =?us-ascii?Q?kPHRd4eBG5ItNhiLU1SDVwc6HOog6aLshKO0yVFg1ivyvPN3iGqdjEOlTvNu?=
 =?us-ascii?Q?WGxi9/wha5UOwoemdCwF8HyFu5Tyxy04GaE2B6Rf4CcMIdDbu4LpL6bViVhi?=
 =?us-ascii?Q?ScA3CIJMhc4F/Ri0NOEtLE8GsQ13aKlYcwy+XOwNHK4DO/S+4+hulknwXgUb?=
 =?us-ascii?Q?qOXULM9BIF/Vru6HOflADslox5UMzgGbJ/1HvlMj6nFjLOB59qA0B8cRePhh?=
 =?us-ascii?Q?miDrpS/McFX+YOtzvHhLq6f/C2wIVw9tuHLalinAXcS/wnlem/9vLtNJ7YVp?=
 =?us-ascii?Q?60uW0w=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2026 03:01:28.8454 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 46182e40-854e-469f-ce84-08de58995f86
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003F61.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6611
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
 drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c     | 111 ++++++++-------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.c    |   5 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h   |   3 +-
 4 files changed, 44 insertions(+), 77 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
index 89df26dd5ada7..f69eafb898540 100644
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
index d90966daf52fc..78987ecdfe03a 100644
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
@@ -121,85 +119,64 @@ void amdgpu_ib_free(struct amdgpu_ib *ib, struct dma_fence *f)
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
@@ -225,19 +202,17 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned int num_ibs,
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
 
 	if (ring->funcs->emit_gfx_shadow)
-		amdgpu_ring_emit_gfx_shadow(ring, shadow_va, csa_va, gds_va,
-					    init_shadow, vmid);
+		amdgpu_ring_emit_gfx_shadow(ring, job->shadow_va, job->csa_va, job->gds_va,
+					    job->init_shadow, vmid);
 
 	if (ring->funcs->init_cond_exec)
 		cond_exec = amdgpu_ring_init_cond_exec(ring,
@@ -248,7 +223,7 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned int num_ibs,
 	if (need_ctx_switch)
 		status |= AMDGPU_HAVE_CTX_SWITCH;
 
-	if (job && ring->funcs->emit_cntxcntl) {
+	if (ring->funcs->emit_cntxcntl) {
 		status |= job->preamble_status;
 		status |= job->preemption_status;
 		amdgpu_ring_emit_cntxcntl(ring, status);
@@ -257,15 +232,15 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned int num_ibs,
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
@@ -277,7 +252,7 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned int num_ibs,
 		status &= ~AMDGPU_HAVE_CTX_SWITCH;
 	}
 
-	if (job && ring->funcs->emit_frame_cntl)
+	if (ring->funcs->emit_frame_cntl)
 		amdgpu_ring_emit_frame_cntl(ring, false, secure);
 
 	amdgpu_device_invalidate_hdp(adev, ring);
@@ -286,7 +261,7 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned int num_ibs,
 		fence_flags |= AMDGPU_FENCE_FLAG_TC_WB_ONLY;
 
 	/* wrap the last IB with fence */
-	if (job && job->uf_addr) {
+	if (job->uf_addr) {
 		amdgpu_ring_emit_fence(ring, job->uf_addr, job->uf_sequence,
 				       fence_flags | AMDGPU_FENCE_FLAG_64BIT);
 	}
@@ -299,15 +274,14 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned int num_ibs,
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
@@ -315,7 +289,7 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned int num_ibs,
 	amdgpu_ring_patch_cond_exec(ring, cond_exec);
 
 	ring->current_ctx = fence_ctx;
-	if (job && ring->funcs->emit_switch_buffer)
+	if (ring->funcs->emit_switch_buffer)
 		amdgpu_ring_emit_switch_buffer(ring);
 
 	if (ring->funcs->emit_wave_limit &&
@@ -334,11 +308,6 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned int num_ibs,
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
index 8660e3d1c3088..a323071762822 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
@@ -379,7 +379,7 @@ int amdgpu_job_submit_direct(struct amdgpu_job *job, struct amdgpu_ring *ring,
 	int r;
 
 	job->base.sched = &ring->sched;
-	r = amdgpu_ib_schedule(ring, job->num_ibs, job->ibs, job, fence);
+	r = amdgpu_ib_schedule(ring, job, fence);
 
 	if (r)
 		return r;
@@ -449,8 +449,7 @@ static struct dma_fence *amdgpu_job_run(struct drm_sched_job *sched_job)
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

