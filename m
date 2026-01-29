Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F61ED73E88
	for <amd-gfx@archiver.kernel.org>; Thu, 29 Jan 2026 20:38:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AB03510E2A4;
	Thu, 29 Jan 2026 20:38:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Hgz19fB+";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010015.outbound.protection.outlook.com [52.101.46.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7807410E2A4
 for <amd-gfx@lists.freedesktop.org>; Thu, 29 Jan 2026 20:37:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g0i1HlXDPO8/cNdDEljNzTaL5y7o1QslWlLDHN/LrHaXXgHlw5QKg+akxrA63KDRQi+HT7Ibe7UmIpaidISXkc0BCiF+hNYngpOnGFeRmgWnPY5rCoUVrujG8oT3sPlQ7M/7Pmm+T/dp0dsF0euY/hkM4CSdSVW2enqodMoAcWknao7fmLbOFfyNyb9Q+3LJCFCvXGlXdfMqqW7JT/DIKSaIvDxEzpUQ1BYFTDBi3pkCF3nymU3gcovYBITSSxh1m1p0FckKCg7DSZBECmhz9ZzxF7n0I7Gs3Me8bpkf+Baj10AkboNMgDdcqu1sYQOtPJIPOaAKzyklx1k3PtQy8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z/djU7HvPp6twBsk9NSSbmFAgo/TcJq+NWj7ZBZqk/U=;
 b=py2r0GoSk29NyOxvS4fQho6zNHrUC2NAURCx9W2kgabT58JNY5QPfdN/SJQ0buFkmsMr5Sfgm44fklgKzB6wTLv2ugQ7CQn8Ms1R2BpXGdq6UkQjjFgLZdZPV+gkXSQKOxQLYaCUh0rP4g1HircEhkE3tGDXClRjEOvDOVDQ4U++WrYf+zOrv4u/OtMSup5EBY/Sr1DenQ+fO79/Mu04NOknP6+ocKa6QSbR+R9a7jCBpDvuXvFTMcKqjUEwFIsfe+0S40d9TOSApVceWn/1NOI+8nKiuSTylrYDrgy8D0pNMkq+mxk3FdihMYeDA0Fa1z4ZP6rIaWbPI/S6eoX2FQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z/djU7HvPp6twBsk9NSSbmFAgo/TcJq+NWj7ZBZqk/U=;
 b=Hgz19fB+fYnFgWzWLIw2RXg5gxLjHJnxnDzGvZygGrzMrYozrPC5trcyuWc5aZynioEKVQoUynilvcyzBFipmAkBJdZ8eBfbszGuj8+5s8/naqMUWm+lv6bB2kEuiJ9T8aW0CHY5tcqaUoQL+Ge02WFUu87CIVNBZ6yWrcHFjHc=
Received: from CH3P220CA0012.NAMP220.PROD.OUTLOOK.COM (2603:10b6:610:1e8::32)
 by LV2PR12MB5847.namprd12.prod.outlook.com (2603:10b6:408:174::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.10; Thu, 29 Jan
 2026 20:37:52 +0000
Received: from CH3PEPF00000017.namprd21.prod.outlook.com
 (2603:10b6:610:1e8:cafe::fc) by CH3P220CA0012.outlook.office365.com
 (2603:10b6:610:1e8::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.10 via Frontend Transport; Thu,
 29 Jan 2026 20:37:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH3PEPF00000017.mail.protection.outlook.com (10.167.244.122) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.0 via Frontend Transport; Thu, 29 Jan 2026 20:37:52 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 29 Jan
 2026 14:37:52 -0600
Received: from p8.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Thu, 29 Jan 2026 12:37:52 -0800
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>, Jesse Zhang <jesse.zhang@amd.com>
Subject: [PATCH 04/12] drm/amdgpu: require a job to schedule an IB
Date: Thu, 29 Jan 2026 15:37:23 -0500
Message-ID: <20260129203731.21506-5-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260129203731.21506-1-alexander.deucher@amd.com>
References: <20260129203731.21506-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000017:EE_|LV2PR12MB5847:EE_
X-MS-Office365-Filtering-Correlation-Id: e34b4684-6a22-4e40-3487-08de5f764699
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?dXWH5yaM7ocZclVlGfB+fdG0EOFRm8wD+aO6BIC5Yf99DGTHuwcEaKQKxhgD?=
 =?us-ascii?Q?9PWZ6Q7rK2GY+i0wYTQgiZXKEQN0v4scEKFCuAWAzIUsXLhxsgmPwX6mRcZy?=
 =?us-ascii?Q?hkGmeUZyVDZYbBNMKph2jAIwbRneffN1xhCxbmS2Sf0ALEcTc7ox5gI3dpHv?=
 =?us-ascii?Q?6gb6K37O10WcMsoyCP+tsj8xKyFaPY4O9823UFZpeBIfV7QnaeiegDV72GjC?=
 =?us-ascii?Q?4RQvl52tlkXntd/DDL1SMI02NA7p884WGCGQqlxGFDKmlQmkcB2Rl6wyPHK6?=
 =?us-ascii?Q?sZXq1jVGEWWHsAVAYlmy6vvte9Qf1H+PeOpNfqBb5WY+Rl55IgNCl1yximm5?=
 =?us-ascii?Q?oULlmsJ2UrVBWyudKSFcOMph+Ei9sSynexJw62VxQdtQLpKD0B2ZI4P0XZOC?=
 =?us-ascii?Q?kPnhNdpQY97TGyYoA1Ss+tNlxG250bfFx3TI1khzWC+n7pUkm9LCggdhrErr?=
 =?us-ascii?Q?AFzC9ScoU+chx+LptLozPbadNX+rCT1lXHiB8fU5h9+klPuOzKnwlm20j7gJ?=
 =?us-ascii?Q?556pqWHkRU7kFyg4aZsmHsarSPfPl+1N7zYcSLJjMRAYKaqgUb9YP6H24Wzv?=
 =?us-ascii?Q?Jc0nUp0IZhC2KPJul+ID3d5CPrc3bW9sWTPGayq4bz1GrN6CHScllN8M6EL0?=
 =?us-ascii?Q?ZqCOxi17XgeL2iTqTTwRMktI7C4+AiZJy8Ekfsk5GX6Y1MnA84GSh5fNw5gQ?=
 =?us-ascii?Q?6YC1S4s1sTNczuKj1cFJc6MqL7unCSzwr0rQGZ5CBIVXqNpoyg5FPigt8i92?=
 =?us-ascii?Q?yUuHMU0TQcAWZTPOrg78Qn+RbWvZ5DYeZyyYeoUqw1LGe3uKmiaj3nUhrYC4?=
 =?us-ascii?Q?KirOLnTMIlYTvC2R8fdZu3Kdh79Jnuw6yEhuL1Iyr2H8oOtncZua7L48D500?=
 =?us-ascii?Q?xhGPdSathKg509saR4lWZ2wdz3+g2vVdVY8PROuAV+eiKBmCqJvj1FFdlHYs?=
 =?us-ascii?Q?VT4WPAEK/lehhkWYkprbng288BA40bqii61bD67qp2WiwN0v+ZZshL+vVa0x?=
 =?us-ascii?Q?HCWt1n7EZqsdEOKfs3hA9fdOE/ffm8Z2VuTcc4+WGEGx5jIaFp0hf5t4y/KW?=
 =?us-ascii?Q?UlafSn2Bda9hu4X3uF5I1361HsFsXPS4c7okkPcHAMnQYq2nq//iGHb8JeVQ?=
 =?us-ascii?Q?Teot3GjcFLjnmekFAbOP1a5BF/PwslKJCcHKg+TGG+JzSiTFJOQzih7BC4RB?=
 =?us-ascii?Q?SNStn+SRfjmOA3grq/7YMfw9aoHOOXCFIhmSFjr5obWBYk/8SKglIZERoMbD?=
 =?us-ascii?Q?lwM6N6zNEqLvaaHsDlDLt9FBDVixTRa6QAR2Xc0foduq8V0pSXbs8gwHtYLz?=
 =?us-ascii?Q?mEz2QH+NQEM+GhfUMvpMiHmG0AH7XbOc2i5PoamAqnHwHDkPNwRB5hLsDFWc?=
 =?us-ascii?Q?WWz9utyAH/JTkvFuFJooR/nXvtXfRwL1tR3RfJzf0dY1iZnLh/Muyn77NlC7?=
 =?us-ascii?Q?MijFKPjDYh2KlttLslV3DqdWTGgsfNiCKl1uqti3Y9j4xkMNgxMnMJ8/Fi1t?=
 =?us-ascii?Q?Lrnjnxww+peUzfihgE+h8rIFUzrxnhY2oYSzBbxcrSyKNQpS74jviA7iYWtY?=
 =?us-ascii?Q?lTpycWyf/FUw3QbAwD+765kPvQve8FIzex3vA1QsKYUTvFQUjnylvxvEz55T?=
 =?us-ascii?Q?c54DOiy8ZGHMO4fRx7WFMEFErIQViQ7YqY1Y0jdVp5RJd9pBapA4ckSil7vN?=
 =?us-ascii?Q?/NYHvA=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: bDPtvSMGD2cmVghmTqAETewhQxydLMtl+qLU6m/jgKugZsqCnDXyjrclHEyCo+YCyB0IE7wNz1LYWbrOScNadZnRWkw9Z9jvj70BdtirsgGY+w0xVfhCN4PjSHMyoykReG5qPd2DKjIj9eFKZiVPp8w7BifX1/SWUWhKEpUbyK1NgIkkU188iyhPY2E0VCJ4cTO7qqvPiJUKFAGsweE7TxtqL2i19yB6JCMTgyrvzlPk9ZgyrxzP7/KvHRx5yaXcF7eyrK8wv9wIkTPTqXpI3/DDP2TJze/7smFo6WaxMRd5caeM0Xm0+iQ8ns3iwS09m2M8t/7rHkMi2OHnU+DLZaQfxKNn2pxgVlbTLJh8ILxQpQVMcPSljJTm8+MMOMYs5FigGgHW1DJGVQ88xoD7HzImyNSpKGWxAZaD417pINuosTKDhVQwFt0tKGq/zyvb
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2026 20:37:52.7884 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e34b4684-6a22-4e40-3487-08de5f764699
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF00000017.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5847
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
index 23f73958663ad..1f60ccb8782ee 100644
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
 
 	if (ring->funcs->emit_gfx_shadow && adev->gfx.cp_gfx_shadow)
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
@@ -300,15 +275,14 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned int num_ibs,
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
@@ -316,7 +290,7 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned int num_ibs,
 	amdgpu_ring_patch_cond_exec(ring, cond_exec);
 
 	ring->current_ctx = fence_ctx;
-	if (job && ring->funcs->emit_switch_buffer)
+	if (ring->funcs->emit_switch_buffer)
 		amdgpu_ring_emit_switch_buffer(ring);
 
 	if (ring->funcs->emit_wave_limit &&
@@ -335,11 +309,6 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned int num_ibs,
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
index acf70f42c6e65..ef1e1da5df658 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
@@ -378,7 +378,7 @@ int amdgpu_job_submit_direct(struct amdgpu_job *job, struct amdgpu_ring *ring,
 	int r;
 
 	job->base.sched = &ring->sched;
-	r = amdgpu_ib_schedule(ring, job->num_ibs, job->ibs, job, fence);
+	r = amdgpu_ib_schedule(ring, job, fence);
 
 	if (r)
 		return r;
@@ -448,8 +448,7 @@ static struct dma_fence *amdgpu_job_run(struct drm_sched_job *sched_job)
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

