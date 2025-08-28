Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DD48CA0EED
	for <amd-gfx@archiver.kernel.org>; Thu, 28 Aug 2025 20:19:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D3AFC10E00E;
	Thu, 28 Aug 2025 20:19:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="kYn5Pzpt";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2046.outbound.protection.outlook.com [40.107.243.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ACFEC10E00E
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 Aug 2025 20:19:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UoiSq7WOJawfQJBIYdBgkNWPWggk1ZxMwoXVoo6zHoysbWge65pQ6z3Z6qqqbvW1CYjVYdZjKXFaeyn/Bi1Qfy5xXvW47wTPNz829ChbASNEmbZN+8MMzwVLRdRU8PFO/+qNuzJrEnuei2ckEGQ/tnDUZKRiruViCuP9e8+swl0aYv/c+NFMM1qSFtvxdagYHTyWCdOtwFDDTyOemkIVKOzeUP+yALvxpKfnW92dYuOp30R3vpyhrro+duY50vGZMDYxrZfgwfw1BaStU1mpOe9P5AE+Rj083osALS50bs7sg3ySP4J71bx+lX0x5KoJsppD9UrEyohvqhkxuPz/6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tDW+ALPIIow+mq+KVDybdaowngwRvN5qsT9XLuGOouc=;
 b=Vmei7lG42tHvyVKT9gvp1yeTb+MsXhFlg4mlTH/zxtOkOcGuNCl/1fPGftlx+ptPH5lvy8OcxLGgvpYq1mQpwqPBAr9FUqqgcLRh2Rkk+VRVWUVQhNHyGHZIkac9I8l9JGXOcVYE/LZNEkF2NnJqMplffClWs1zTLUPRDRVJv42TrHs2qR30Ki2DdPHAB9J/riYhw0DURNXVCHG+6oaKrT+hVZOKduaNl3175TOmeMnO/eg8l/GQRi3UiKt3P6WzlPFWuUOpkMrXqF2O+Tauu+WkJWtGsAJkimHYYmcXZCZUnT2kk3NN/CiC/99A68JEt2AhrYtCGTcBJzAY8H7GFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tDW+ALPIIow+mq+KVDybdaowngwRvN5qsT9XLuGOouc=;
 b=kYn5Pzpt2AYzZhq5Ybwh7PO+1iUsNlGFUHyNLHDb0bJborGl0S3+gqfjsFxl0Wfew27Fyi2qc+uAL9RKP4qxS85YyC0wNH9jXEm9FCB0ohfQXE1PuS2MjfVAuuPjjx1o7YYCls++6BFvp1WFLq7OMEKRuWoKk3gF9/1NqoQnc5s=
Received: from CY8PR12CA0025.namprd12.prod.outlook.com (2603:10b6:930:49::14)
 by CH3PR12MB8403.namprd12.prod.outlook.com (2603:10b6:610:133::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.22; Thu, 28 Aug
 2025 20:19:42 +0000
Received: from CY4PEPF0000EE3F.namprd03.prod.outlook.com
 (2603:10b6:930:49:cafe::99) by CY8PR12CA0025.outlook.office365.com
 (2603:10b6:930:49::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9073.17 via Frontend Transport; Thu,
 28 Aug 2025 20:19:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CY4PEPF0000EE3F.mail.protection.outlook.com (10.167.242.17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9073.11 via Frontend Transport; Thu, 28 Aug 2025 20:19:41 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 28 Aug
 2025 15:19:41 -0500
Received: from tr4.amd.com (10.180.168.240) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1748.10; Thu, 28 Aug
 2025 13:19:40 -0700
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>, <David.Wu3@amd.com>,
 <christian.koenig@amd.com>
Subject: [PATCH] drm/amdgpu: clean up and unify hw fence handling
Date: Thu, 28 Aug 2025 16:19:24 -0400
Message-ID: <20250828201924.5812-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To satlexmb09.amd.com
 (10.181.42.218)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3F:EE_|CH3PR12MB8403:EE_
X-MS-Office365-Filtering-Correlation-Id: 93b90184-a184-456b-80ed-08dde67038c9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?VV5SxvjRS+ntYdbj1nw2tJN+YCY8UZi/W9Fzqy94mn4+Y7dU+5VySPKlbD50?=
 =?us-ascii?Q?ysu01+3kr+AMkkbSnYIVbfOgjy/QO4qAYT3pSMzX3na5/J/gGJMNSb4/vBjg?=
 =?us-ascii?Q?ZD2pgLLxKNtvP5a6jfCQwnNbPPmroRMIGIKWQ/ydoyLrBWnMhgV5HNSm+pZl?=
 =?us-ascii?Q?f3bi/pbzFz5i0qLaTjsYjb4JhqFaMV9MvfKsIO7tQuKr+M2EyBJCRX129SLM?=
 =?us-ascii?Q?1nTz4BhydXVWkNwTPS3RteJE/dcLh7yxrU+BIvGeeCZyn+5ESnWM+y6GT5Eq?=
 =?us-ascii?Q?hGBiLLuvBw0L9oC6wWiDdzj3bPkKMokeXnbygQqgYw+WIXUQsYUo8EeGqOrq?=
 =?us-ascii?Q?6/a3PC5BjzWUI4rD8nisTVl0S4SCxxoAuBPatIUiw8Dx1pbjof5e4duxZ2Ds?=
 =?us-ascii?Q?J9lp5d2qVBNKJBoaNS5+W+BJ0Gf1AppBG1gbFrBJp8rvAku6ueTmWU6YKxM4?=
 =?us-ascii?Q?7yhc7gAfITU8ixrLXqQT3hpY7z47x2wJFAN5LnS3pTXsETmRn9xfxRSkauWL?=
 =?us-ascii?Q?FkAcrC0LQywdLm6fs3nHpD4yEfBfFlmEXybY9BoP4JW8PtnX7znJaplCaJ1d?=
 =?us-ascii?Q?soXhVLb/cZlMrCqeye0BQh95GXGWS7JSoEOKOX20Lv7JegHKhW0e0VBWBN5W?=
 =?us-ascii?Q?m8BDw+QFaNc+Tg5z9/CDOIyMNVMneLdTLvGJ8fxG5e1mauXG1pt3tVwSKHxK?=
 =?us-ascii?Q?+rDbO1/kdfZu9sYs5m4AUTbgvTp+klUOcYkZ3W31FxxcdGIUzwwF2yyYH17k?=
 =?us-ascii?Q?KKBL7uhNNNRTozxgRBoQE3ikH8hd9u5pextKJOQxnWh02/XATNndDDjuhQGT?=
 =?us-ascii?Q?1Uv9QiXi1KEU359GH1K/wZFXAovD44SmK5ueDfvgYNYk83NcnVoIlW+KMaaj?=
 =?us-ascii?Q?KUUY7/guviyYc1WtuYwSg68mf3IXbbVoPurRWU36y88Z4ZB8wt9WPpaQPswr?=
 =?us-ascii?Q?7iBBhmGFgFiZpytywjR0E9z7ulN4nOrqZ//nQEU8nJlfqYZQbf3iBHYT+Lgw?=
 =?us-ascii?Q?wyC/WnofTw6JDu3YLZuBf3Uo0E004SQTBRN2oL6bkzGAIdHwoOKxwYEylHK+?=
 =?us-ascii?Q?Dc4w2AqQ5Jrt711zPTvyfcpCwaSL5yd6/MuOzHASOlZ6ZkLBIp6aD/N2Gzrv?=
 =?us-ascii?Q?2Lspz9H4Gf65jwqkXGfWac3wEwbfcTce2YTYc1P5yMAraqGe9JNQY44Iy1FY?=
 =?us-ascii?Q?D2Bx3fht+VhBqTdMqQuwQYxp+UkYjmnQzSdCPTm5oOG+vr0vCWClCyPAuuvk?=
 =?us-ascii?Q?GMVsaPb3O5/oW0N5WfPVpwpLPDzZEVHAZYQCz7QJL0KU0DEPIr8pohqIFc00?=
 =?us-ascii?Q?TilOfVtWqLDHyUIp2fgIUKbEai8LB3kANtbdzaqFht5MoT9IPSD+cGbancGO?=
 =?us-ascii?Q?9rOX2vMjQGCT85ztwmQd7+t8m9xq0KmoTLhc1vd8wRFPsfuE/2+zCL0Px7vX?=
 =?us-ascii?Q?vQH0pFTCnb7domWXfxKooxH/wXQvQOM+t+g0Emex70uxSgLpdYljjnINhCPN?=
 =?us-ascii?Q?+3xHzRFeTSWGMYGCu0PNPeSvC04knYc7JaHm?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2025 20:19:41.9055 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 93b90184-a184-456b-80ed-08dde67038c9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE3F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8403
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

Decouple the amdgpu fence from the amdgpu_job structure.
This lets us clean up the separate fence ops for the embedded
fence and other fences.  This also allows us to allocate the
vm fence up front when we allocate the job.

v2: Additional cleanup suggested by Christian
v3: Additional cleanups suggested by Christian
v4: Additional cleanups and suggested by David and
    vm fence fix

Cc: David.Wu3@amd.com
Cc: christian.koenig@amd.com
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c  |   7 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c   | 149 +++-----------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c      |  17 ++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.c     |  43 ++++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.h     |   3 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h    |   8 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c      |   7 +-
 8 files changed, 66 insertions(+), 170 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
index f81608330a3d0..7ea3cb6491b1b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
@@ -1902,7 +1902,7 @@ static void amdgpu_ib_preempt_mark_partial_job(struct amdgpu_ring *ring)
 			continue;
 		}
 		job = to_amdgpu_job(s_job);
-		if (preempted && (&job->hw_fence.base) == fence)
+		if (preempted && (&job->hw_fence->base) == fence)
 			/* mark the job as preempted */
 			job->preemption_status |= AMDGPU_IB_PREEMPTED;
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 7783272a79302..add272fa31288 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -5798,11 +5798,6 @@ int amdgpu_device_pre_asic_reset(struct amdgpu_device *adev,
 		if (!amdgpu_ring_sched_ready(ring))
 			continue;
 
-		/* Clear job fence from fence drv to avoid force_completion
-		 * leave NULL and vm flush fence in fence drv
-		 */
-		amdgpu_fence_driver_clear_job_fences(ring);
-
 		/* after all hw jobs are reset, hw fence is meaningless, so force_completion */
 		amdgpu_fence_driver_force_completion(ring);
 	}
@@ -6526,7 +6521,7 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
 	 *
 	 * job->base holds a reference to parent fence
 	 */
-	if (job && dma_fence_is_signaled(&job->hw_fence.base)) {
+	if (job && dma_fence_is_signaled(&job->hw_fence->base)) {
 		job_signaled = true;
 		dev_info(adev->dev, "Guilty job already signaled, skipping HW reset");
 		goto skip_hw_reset;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
index 2d58aefbd68a7..00ae1ef540815 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
@@ -45,16 +45,11 @@
  * Cast helper
  */
 static const struct dma_fence_ops amdgpu_fence_ops;
-static const struct dma_fence_ops amdgpu_job_fence_ops;
 static inline struct amdgpu_fence *to_amdgpu_fence(struct dma_fence *f)
 {
 	struct amdgpu_fence *__f = container_of(f, struct amdgpu_fence, base);
 
-	if (__f->base.ops == &amdgpu_fence_ops ||
-	    __f->base.ops == &amdgpu_job_fence_ops)
-		return __f;
-
-	return NULL;
+	return __f;
 }
 
 /**
@@ -98,51 +93,32 @@ static u32 amdgpu_fence_read(struct amdgpu_ring *ring)
  * amdgpu_fence_emit - emit a fence on the requested ring
  *
  * @ring: ring the fence is associated with
- * @f: resulting fence object
  * @af: amdgpu fence input
  * @flags: flags to pass into the subordinate .emit_fence() call
  *
  * Emits a fence command on the requested ring (all asics).
  * Returns 0 on success, -ENOMEM on failure.
  */
-int amdgpu_fence_emit(struct amdgpu_ring *ring, struct dma_fence **f,
-		      struct amdgpu_fence *af, unsigned int flags)
+int amdgpu_fence_emit(struct amdgpu_ring *ring, struct amdgpu_fence *af,
+		      unsigned int flags)
 {
 	struct amdgpu_device *adev = ring->adev;
 	struct dma_fence *fence;
-	struct amdgpu_fence *am_fence;
 	struct dma_fence __rcu **ptr;
 	uint32_t seq;
 	int r;
 
-	if (!af) {
-		/* create a separate hw fence */
-		am_fence = kzalloc(sizeof(*am_fence), GFP_KERNEL);
-		if (!am_fence)
-			return -ENOMEM;
-	} else {
-		am_fence = af;
-	}
-	fence = &am_fence->base;
-	am_fence->ring = ring;
+	fence = &af->base;
+	af->ring = ring;
 
 	seq = ++ring->fence_drv.sync_seq;
-	am_fence->seq = seq;
-	if (af) {
-		dma_fence_init(fence, &amdgpu_job_fence_ops,
-			       &ring->fence_drv.lock,
-			       adev->fence_context + ring->idx, seq);
-		/* Against remove in amdgpu_job_{free, free_cb} */
-		dma_fence_get(fence);
-	} else {
-		dma_fence_init(fence, &amdgpu_fence_ops,
-			       &ring->fence_drv.lock,
-			       adev->fence_context + ring->idx, seq);
-	}
+	dma_fence_init(fence, &amdgpu_fence_ops,
+		       &ring->fence_drv.lock,
+		       adev->fence_context + ring->idx, seq);
 
 	amdgpu_ring_emit_fence(ring, ring->fence_drv.gpu_addr,
 			       seq, flags | AMDGPU_FENCE_FLAG_INT);
-	amdgpu_fence_save_wptr(fence);
+	amdgpu_fence_save_wptr(af);
 	pm_runtime_get_noresume(adev_to_drm(adev)->dev);
 	ptr = &ring->fence_drv.fences[seq & ring->fence_drv.num_fences_mask];
 	if (unlikely(rcu_dereference_protected(*ptr, 1))) {
@@ -167,8 +143,6 @@ int amdgpu_fence_emit(struct amdgpu_ring *ring, struct dma_fence **f,
 	 */
 	rcu_assign_pointer(*ptr, dma_fence_get(fence));
 
-	*f = fence;
-
 	return 0;
 }
 
@@ -669,36 +643,6 @@ void amdgpu_fence_driver_hw_init(struct amdgpu_device *adev)
 	}
 }
 
-/**
- * amdgpu_fence_driver_clear_job_fences - clear job embedded fences of ring
- *
- * @ring: fence of the ring to be cleared
- *
- */
-void amdgpu_fence_driver_clear_job_fences(struct amdgpu_ring *ring)
-{
-	int i;
-	struct dma_fence *old, **ptr;
-
-	for (i = 0; i <= ring->fence_drv.num_fences_mask; i++) {
-		ptr = &ring->fence_drv.fences[i];
-		old = rcu_dereference_protected(*ptr, 1);
-		if (old && old->ops == &amdgpu_job_fence_ops) {
-			struct amdgpu_job *job;
-
-			/* For non-scheduler bad job, i.e. failed ib test, we need to signal
-			 * it right here or we won't be able to track them in fence_drv
-			 * and they will remain unsignaled during sa_bo free.
-			 */
-			job = container_of(old, struct amdgpu_job, hw_fence.base);
-			if (!job->base.s_fence && !dma_fence_is_signaled(old))
-				dma_fence_signal(old);
-			RCU_INIT_POINTER(*ptr, NULL);
-			dma_fence_put(old);
-		}
-	}
-}
-
 /**
  * amdgpu_fence_driver_set_error - set error code on fences
  * @ring: the ring which contains the fences
@@ -755,21 +699,19 @@ void amdgpu_fence_driver_force_completion(struct amdgpu_ring *ring)
 /**
  * amdgpu_fence_driver_guilty_force_completion - force signal of specified sequence
  *
- * @fence: fence of the ring to signal
+ * @af: fence of the ring to signal
  *
  */
-void amdgpu_fence_driver_guilty_force_completion(struct amdgpu_fence *fence)
+void amdgpu_fence_driver_guilty_force_completion(struct amdgpu_fence *af)
 {
-	dma_fence_set_error(&fence->base, -ETIME);
-	amdgpu_fence_write(fence->ring, fence->seq);
-	amdgpu_fence_process(fence->ring);
+	dma_fence_set_error(&af->base, -ETIME);
+	amdgpu_fence_write(af->ring, af->base.seqno);
+	amdgpu_fence_process(af->ring);
 }
 
-void amdgpu_fence_save_wptr(struct dma_fence *fence)
+void amdgpu_fence_save_wptr(struct amdgpu_fence *af)
 {
-	struct amdgpu_fence *am_fence = container_of(fence, struct amdgpu_fence, base);
-
-	am_fence->wptr = am_fence->ring->wptr;
+	af->wptr = af->ring->wptr;
 }
 
 static void amdgpu_ring_backup_unprocessed_command(struct amdgpu_ring *ring,
@@ -830,13 +772,6 @@ static const char *amdgpu_fence_get_timeline_name(struct dma_fence *f)
 	return (const char *)to_amdgpu_fence(f)->ring->name;
 }
 
-static const char *amdgpu_job_fence_get_timeline_name(struct dma_fence *f)
-{
-	struct amdgpu_job *job = container_of(f, struct amdgpu_job, hw_fence.base);
-
-	return (const char *)to_amdgpu_ring(job->base.sched)->name;
-}
-
 /**
  * amdgpu_fence_enable_signaling - enable signalling on fence
  * @f: fence
@@ -853,23 +788,6 @@ static bool amdgpu_fence_enable_signaling(struct dma_fence *f)
 	return true;
 }
 
-/**
- * amdgpu_job_fence_enable_signaling - enable signalling on job fence
- * @f: fence
- *
- * This is the simliar function with amdgpu_fence_enable_signaling above, it
- * only handles the job embedded fence.
- */
-static bool amdgpu_job_fence_enable_signaling(struct dma_fence *f)
-{
-	struct amdgpu_job *job = container_of(f, struct amdgpu_job, hw_fence.base);
-
-	if (!timer_pending(&to_amdgpu_ring(job->base.sched)->fence_drv.fallback_timer))
-		amdgpu_fence_schedule_fallback(to_amdgpu_ring(job->base.sched));
-
-	return true;
-}
-
 /**
  * amdgpu_fence_free - free up the fence memory
  *
@@ -885,21 +803,6 @@ static void amdgpu_fence_free(struct rcu_head *rcu)
 	kfree(to_amdgpu_fence(f));
 }
 
-/**
- * amdgpu_job_fence_free - free up the job with embedded fence
- *
- * @rcu: RCU callback head
- *
- * Free up the job with embedded fence after the RCU grace period.
- */
-static void amdgpu_job_fence_free(struct rcu_head *rcu)
-{
-	struct dma_fence *f = container_of(rcu, struct dma_fence, rcu);
-
-	/* free job if fence has a parent job */
-	kfree(container_of(f, struct amdgpu_job, hw_fence.base));
-}
-
 /**
  * amdgpu_fence_release - callback that fence can be freed
  *
@@ -913,19 +816,6 @@ static void amdgpu_fence_release(struct dma_fence *f)
 	call_rcu(&f->rcu, amdgpu_fence_free);
 }
 
-/**
- * amdgpu_job_fence_release - callback that job embedded fence can be freed
- *
- * @f: fence
- *
- * This is the simliar function with amdgpu_fence_release above, it
- * only handles the job embedded fence.
- */
-static void amdgpu_job_fence_release(struct dma_fence *f)
-{
-	call_rcu(&f->rcu, amdgpu_job_fence_free);
-}
-
 static const struct dma_fence_ops amdgpu_fence_ops = {
 	.get_driver_name = amdgpu_fence_get_driver_name,
 	.get_timeline_name = amdgpu_fence_get_timeline_name,
@@ -933,13 +823,6 @@ static const struct dma_fence_ops amdgpu_fence_ops = {
 	.release = amdgpu_fence_release,
 };
 
-static const struct dma_fence_ops amdgpu_job_fence_ops = {
-	.get_driver_name = amdgpu_fence_get_driver_name,
-	.get_timeline_name = amdgpu_job_fence_get_timeline_name,
-	.enable_signaling = amdgpu_job_fence_enable_signaling,
-	.release = amdgpu_job_fence_release,
-};
-
 /*
  * Fence debugfs
  */
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
index 7d9bcb72e8dd3..39229ece83f83 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
@@ -149,17 +149,19 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned int num_ibs,
 	if (job) {
 		vm = job->vm;
 		fence_ctx = job->base.s_fence ?
-			job->base.s_fence->scheduled.context : 0;
+			job->base.s_fence->finished.context : 0;
 		shadow_va = job->shadow_va;
 		csa_va = job->csa_va;
 		gds_va = job->gds_va;
 		init_shadow = job->init_shadow;
-		af = &job->hw_fence;
+		af = job->hw_fence;
 		/* Save the context of the job for reset handling.
 		 * The driver needs this so it can skip the ring
 		 * contents for guilty contexts.
 		 */
-		af->context = job->base.s_fence ? job->base.s_fence->finished.context : 0;
+		af->context = fence_ctx;
+		/* the vm fence is also part of the job's context */
+		job->hw_vm_fence->context = fence_ctx;
 	} else {
 		vm = NULL;
 		fence_ctx = 0;
@@ -167,7 +169,9 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned int num_ibs,
 		csa_va = 0;
 		gds_va = 0;
 		init_shadow = false;
-		af = NULL;
+		af = kzalloc(sizeof(*af), GFP_ATOMIC);
+		if (!af)
+			return -ENOMEM;
 	}
 
 	if (!ring->sched.ready) {
@@ -289,7 +293,7 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned int num_ibs,
 		amdgpu_ring_init_cond_exec(ring, ring->cond_exe_gpu_addr);
 	}
 
-	r = amdgpu_fence_emit(ring, f, af, fence_flags);
+	r = amdgpu_fence_emit(ring, af, fence_flags);
 	if (r) {
 		dev_err(adev->dev, "failed to emit fence (%d)\n", r);
 		if (job && job->vmid)
@@ -297,6 +301,7 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned int num_ibs,
 		amdgpu_ring_undo(ring);
 		return r;
 	}
+	*f = &af->base;
 
 	if (ring->funcs->insert_end)
 		ring->funcs->insert_end(ring);
@@ -317,7 +322,7 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned int num_ibs,
 	 * fence so we know what rings contents to backup
 	 * after we reset the queue.
 	 */
-	amdgpu_fence_save_wptr(*f);
+	amdgpu_fence_save_wptr(af);
 
 	amdgpu_ring_ib_end(ring);
 	amdgpu_ring_commit(ring);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
index 311e97c96c4e0..e86439867e2c6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
@@ -138,7 +138,7 @@ static enum drm_gpu_sched_stat amdgpu_job_timedout(struct drm_sched_job *s_job)
 		   ring->funcs->reset) {
 		dev_err(adev->dev, "Starting %s ring reset\n",
 			s_job->sched->name);
-		r = amdgpu_ring_reset(ring, job->vmid, &job->hw_fence);
+		r = amdgpu_ring_reset(ring, job->vmid, job->hw_fence);
 		if (!r) {
 			atomic_inc(&ring->adev->gpu_reset_counter);
 			dev_err(adev->dev, "Ring %s reset succeeded\n",
@@ -185,6 +185,9 @@ int amdgpu_job_alloc(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 		     struct drm_sched_entity *entity, void *owner,
 		     unsigned int num_ibs, struct amdgpu_job **job)
 {
+	struct amdgpu_fence *af;
+	int r;
+
 	if (num_ibs == 0)
 		return -EINVAL;
 
@@ -192,6 +195,20 @@ int amdgpu_job_alloc(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 	if (!*job)
 		return -ENOMEM;
 
+	af = kzalloc(sizeof(struct amdgpu_fence), GFP_KERNEL);
+	if (!af) {
+		r = -ENOMEM;
+		goto err_job;
+	}
+	(*job)->hw_fence = af;
+
+	af = kzalloc(sizeof(struct amdgpu_fence), GFP_KERNEL);
+	if (!af) {
+		r = -ENOMEM;
+		goto err_fence;
+	}
+	(*job)->hw_vm_fence = af;
+
 	(*job)->vm = vm;
 
 	amdgpu_sync_create(&(*job)->explicit_sync);
@@ -202,6 +219,13 @@ int amdgpu_job_alloc(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 		return 0;
 
 	return drm_sched_job_init(&(*job)->base, entity, 1, owner);
+
+err_fence:
+	kfree((*job)->hw_fence);
+err_job:
+	kfree(*job);
+
+	return r;
 }
 
 int amdgpu_job_alloc_with_ib(struct amdgpu_device *adev,
@@ -248,11 +272,11 @@ void amdgpu_job_free_resources(struct amdgpu_job *job)
 	struct dma_fence *f;
 	unsigned i;
 
-	/* Check if any fences where initialized */
+	/* Check if any fences were initialized */
 	if (job->base.s_fence && job->base.s_fence->finished.ops)
 		f = &job->base.s_fence->finished;
-	else if (job->hw_fence.base.ops)
-		f = &job->hw_fence.base;
+	else if (job->hw_fence && job->hw_fence->base.ops)
+		f = &job->hw_fence->base;
 	else
 		f = NULL;
 
@@ -268,11 +292,7 @@ static void amdgpu_job_free_cb(struct drm_sched_job *s_job)
 
 	amdgpu_sync_free(&job->explicit_sync);
 
-	/* only put the hw fence if has embedded fence */
-	if (!job->hw_fence.base.ops)
-		kfree(job);
-	else
-		dma_fence_put(&job->hw_fence.base);
+	kfree(job);
 }
 
 void amdgpu_job_set_gang_leader(struct amdgpu_job *job,
@@ -301,10 +321,7 @@ void amdgpu_job_free(struct amdgpu_job *job)
 	if (job->gang_submit != &job->base.s_fence->scheduled)
 		dma_fence_put(job->gang_submit);
 
-	if (!job->hw_fence.base.ops)
-		kfree(job);
-	else
-		dma_fence_put(&job->hw_fence.base);
+	kfree(job);
 }
 
 struct dma_fence *amdgpu_job_submit(struct amdgpu_job *job)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
index 931fed8892cc1..077b2414a24b7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
@@ -48,7 +48,8 @@ struct amdgpu_job {
 	struct drm_sched_job    base;
 	struct amdgpu_vm	*vm;
 	struct amdgpu_sync	explicit_sync;
-	struct amdgpu_fence	hw_fence;
+	struct amdgpu_fence	*hw_fence;
+	struct amdgpu_fence	*hw_vm_fence;
 	struct dma_fence	*gang_submit;
 	uint32_t		preamble_status;
 	uint32_t                preemption_status;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
index 7670f5d82b9e4..77ddddadc25fe 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
@@ -147,16 +147,14 @@ struct amdgpu_fence {
 	u64				wptr;
 	/* fence context for resets */
 	u64				context;
-	uint32_t			seq;
 };
 
 extern const struct drm_sched_backend_ops amdgpu_sched_ops;
 
-void amdgpu_fence_driver_clear_job_fences(struct amdgpu_ring *ring);
 void amdgpu_fence_driver_set_error(struct amdgpu_ring *ring, int error);
 void amdgpu_fence_driver_force_completion(struct amdgpu_ring *ring);
 void amdgpu_fence_driver_guilty_force_completion(struct amdgpu_fence *fence);
-void amdgpu_fence_save_wptr(struct dma_fence *fence);
+void amdgpu_fence_save_wptr(struct amdgpu_fence *af);
 
 int amdgpu_fence_driver_init_ring(struct amdgpu_ring *ring);
 int amdgpu_fence_driver_start_ring(struct amdgpu_ring *ring,
@@ -166,8 +164,8 @@ void amdgpu_fence_driver_hw_init(struct amdgpu_device *adev);
 void amdgpu_fence_driver_hw_fini(struct amdgpu_device *adev);
 int amdgpu_fence_driver_sw_init(struct amdgpu_device *adev);
 void amdgpu_fence_driver_sw_fini(struct amdgpu_device *adev);
-int amdgpu_fence_emit(struct amdgpu_ring *ring, struct dma_fence **f,
-		      struct amdgpu_fence *af, unsigned int flags);
+int amdgpu_fence_emit(struct amdgpu_ring *ring, struct amdgpu_fence *af,
+		      unsigned int flags);
 int amdgpu_fence_emit_polling(struct amdgpu_ring *ring, uint32_t *s,
 			      uint32_t timeout);
 bool amdgpu_fence_process(struct amdgpu_ring *ring);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index bf42246a3db2f..9cf1744a4b319 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -772,7 +772,6 @@ int amdgpu_vm_flush(struct amdgpu_ring *ring, struct amdgpu_job *job,
 	bool cleaner_shader_needed = false;
 	bool pasid_mapping_needed = false;
 	struct dma_fence *fence = NULL;
-	struct amdgpu_fence *af;
 	unsigned int patch;
 	int r;
 
@@ -835,12 +834,10 @@ int amdgpu_vm_flush(struct amdgpu_ring *ring, struct amdgpu_job *job,
 	}
 
 	if (vm_flush_needed || pasid_mapping_needed || cleaner_shader_needed) {
-		r = amdgpu_fence_emit(ring, &fence, NULL, 0);
+		r = amdgpu_fence_emit(ring, job->hw_vm_fence, 0);
 		if (r)
 			return r;
-		/* this is part of the job's context */
-		af = container_of(fence, struct amdgpu_fence, base);
-		af->context = job->base.s_fence ? job->base.s_fence->finished.context : 0;
+		fence = &job->hw_vm_fence->base;
 	}
 
 	if (vm_flush_needed) {
-- 
2.51.0

