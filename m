Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A984BC77B7C
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Jun 2025 16:15:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2B8F510E412;
	Mon, 23 Jun 2025 16:15:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="nrzrMawc";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2074.outbound.protection.outlook.com [40.107.220.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0DFB310E40B
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Jun 2025 16:15:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KyTmDGI8Ty25L6ggQg4E8Zak/SEhVTQ2o1ssqC61J7DLylhY9hq964aEVxQsLhGeg1y9b9ekHI6x/8CtPfLZni03fzZ5ED1ocOrq592mKLRpOxQSv95UyvXCPCeyAuAJGkoe7oPxnB6Ys6zHEQvhaX1imx+9U/ZVG+r9qYiek9h/xHa6iUx9LmmrQBOCi/pYwVetSl2WVyGCFs9bwdpyhGvKZPQmL18yQ2rLgoRulmYiXQw98zD7m4HsDd4Hj/mtPOwOGIFDpPH1CvxEdFUFn/di2pF4Q4IDplcojwd26K6HPrNwywT0cNui8VPuRbQ6icux+nioGZXrO2yoOKRzZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AJfYISQbqHruIuXzy5lf1RP2U+WyhFjD9Z6Y2oKpI6g=;
 b=ROCPzQ1fL5RPQtCCqFQTcjEXUJJ+R71Nahb9eD7c8EPmyA25CGOUf6Wm3x8OM+C5pit06bh0EgkuwOwIqXByVXRiBQquwlkH5QluAk+t20eRkt6y9QMdI3iENuqoaOB/M+uHMevpjo/OIYdfBZuhHuVhGby7u/+DFsPnExwW+aBLyg505vDcA9FEeBf+EM6+JTwlRITcYVOeu6vHJu+uB7apBxsuEU+fiOaYWUO9363osDnb48UPdpZ0Y1z/wtmWJc6xXMtKiVYe97IVH4+2n/Al6/K4ndcXk5Ql0MEoOoBmuXvN7O32zGzzTYIPAdozlj7txK5k0iupVydmqRfenA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AJfYISQbqHruIuXzy5lf1RP2U+WyhFjD9Z6Y2oKpI6g=;
 b=nrzrMawcH297F/bP/GWKImQUsDKyLsUYLJHDsVbE2wUcMq08j4YZopqOiSP2IxAhBuHORrAYsU3j6T7g2dj0ZJbQGtKSapkJ+8HtIkmtSGwrMuu/tdBlZlTT8k27vzOleiZRr5cGzlGRVhMSZB4Nngrzy6AR0kNEVBP4bARt3fk=
Received: from BN9PR03CA0062.namprd03.prod.outlook.com (2603:10b6:408:fc::7)
 by MW4PR12MB5626.namprd12.prod.outlook.com (2603:10b6:303:169::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.29; Mon, 23 Jun
 2025 16:15:02 +0000
Received: from BN3PEPF0000B077.namprd04.prod.outlook.com
 (2603:10b6:408:fc:cafe::bc) by BN9PR03CA0062.outlook.office365.com
 (2603:10b6:408:fc::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.32 via Frontend Transport; Mon,
 23 Jun 2025 16:15:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B077.mail.protection.outlook.com (10.167.243.122) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8880.14 via Frontend Transport; Mon, 23 Jun 2025 16:15:01 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 23 Jun
 2025 11:14:57 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>,
 <sasundar@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 08/31] drm/amdgpu: track ring state associated with a fence
Date: Mon, 23 Jun 2025 12:14:14 -0400
Message-ID: <20250623161438.124020-9-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250623161438.124020-1-alexander.deucher@amd.com>
References: <20250623161438.124020-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B077:EE_|MW4PR12MB5626:EE_
X-MS-Office365-Filtering-Correlation-Id: 475eb493-9437-4372-cfd0-08ddb2711b5c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?7Zz1Zp2W8PCMWoyIxmjSfM+IvvcQRknUNx2ZhTWfjQ48LcTO2cwnRTekhhR4?=
 =?us-ascii?Q?iD/fujYwCgYO34015g7N/Z0BP3jwnGnKDgnX4gR2rHLrQVLPwgZ5BoicDhRn?=
 =?us-ascii?Q?tJQ/mmzvfIRPv916Ix355IDtUDGO4l5tt0CbNW7g09C96e9BVk1KtLH4CMsr?=
 =?us-ascii?Q?MZpgr+9LtH1s4wWeFhQq2Y2nSGGx+cR32dEyGkClt0vzCyePVGdyW/zjhGbW?=
 =?us-ascii?Q?dJRV64Eq2+7yhu4Risfm1gl+IstKnO3WrJus0gNLM2Om+7OLlTm45rMOfKAS?=
 =?us-ascii?Q?1kqsunv4jc75w8b49M86X/zuzsqCD/Ms3O5yHwEIx9ztuslK3gbSR3W0m9Rv?=
 =?us-ascii?Q?zyHhnQDMVA+2693iSWchfYQL/p4dPKZHa76eyIgaSIUtDaFMa4aHIUxt3Bad?=
 =?us-ascii?Q?meT2GRy1llvzEhUXltZW5SHHd8VpMvFo4q6ve2voIsRepcq4BI4lYBmTl/gh?=
 =?us-ascii?Q?h8fd7/+vVwJntHoQu9zH1SDMmSyFEOhxsk/2inDkU66b5ZaeqNCnNV4SNQF5?=
 =?us-ascii?Q?3WtbMHeoHV3pGo48wtK6+A4fBEzL+nIYLAdIonIzf/gVuM/coR0j2MDBZ6X5?=
 =?us-ascii?Q?6pFU9sA7ilwLH6etnT9bxUNsWVXzuTUII9EqJqCjUVH5CBo31q8vTg20uklF?=
 =?us-ascii?Q?0IUmmJl5o9sNdRPQ3s4+HS02X4NdyV6vsWeo7YCWUNFlvptlCk1oevvp6TyY?=
 =?us-ascii?Q?nVkQMoBFwsrNIdV6yKA9KNKXOfJJzBNN3dyZ4bCRh5Rr24Gx2tTD+ebHszkJ?=
 =?us-ascii?Q?1E0x2rWnSlmq7vPTZz9VAZ3zDVoPhkxSWyMveDCZQ3xxEwkUWgh2EXhZ5tuy?=
 =?us-ascii?Q?iEcjgi35Vqm1578Bdc9ZhEcD6nsY3yBOui70NFwWx9RqDW2IG8q9lhIa/v2U?=
 =?us-ascii?Q?SZpOxxKWVjWBUfOYILtG4osT7XAcXYocAM9ELDmFnA6dQZNxtzTjDZEgl4fD?=
 =?us-ascii?Q?UzgEJYN3upTKoXVfklbbm1Y7BznM9IPPdT/SxdjSKZbuFKcKRGKQ3Id291a/?=
 =?us-ascii?Q?ioaajYeXfjTeoZpN61M6RhgpybArnShQyw/SzYGvFcG0s/kJUin4CwR71aVP?=
 =?us-ascii?Q?8rijSujIAN1spppfta25vEcAytEsWGA9UyP8Cd9Uc3zWuQDO/2JgDac17VTu?=
 =?us-ascii?Q?3pfFD1gb0Yw2AvzQGyKr/cOknnxhLpPRdq7p4i/GAimzTdCjO7Pz47iOqgY3?=
 =?us-ascii?Q?0n3CreKadXwtQFyaIWK9XKQWLLrbHkk54/lcaBRuVgaScyGNe4W3tAAdY22F?=
 =?us-ascii?Q?6gtAkr+DkroD/yyfANbzans2IdbfEj8B6khRALFxpggmMd+O5MfaxeuFwUiO?=
 =?us-ascii?Q?zzZClhzbJYLMhWewFGzjDZEb669n48k481Nibvlvki2Mhf6SmuhnXLOJhxrb?=
 =?us-ascii?Q?kR+XPDuAfXw80N9/Lb9Ri+1msnnqTMkpWaRMWxZqLq8uCexiOE812f8JBqze?=
 =?us-ascii?Q?Vn0mWBdfOArTERUuzLjmCBjvbZBcCdk1Gm7iJPuGeax2ldk8mvxNKJIiGOOH?=
 =?us-ascii?Q?3TnADqaX0m1aOGWqZTfDx8CXsGebM00VAZrJ?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2025 16:15:01.6181 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 475eb493-9437-4372-cfd0-08ddb2711b5c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B077.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB5626
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

We need to know the wptr and sequence number associated
with a fence so that we can re-emit the unprocessed state
after a ring reset.  Pre-allocate storage space for
the ring buffer contents and add helpers to save off
and re-emit the unprocessed state so that it can be
re-emitted after the queue is reset.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c | 99 +++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c    | 15 +++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.c   |  4 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c  | 59 ++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h  | 17 ++++
 5 files changed, 191 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
index 28e2d63bea47e..0ba9a3fac1c39 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
@@ -120,11 +120,13 @@ int amdgpu_fence_emit(struct amdgpu_ring *ring, struct dma_fence **f,
 		am_fence = kzalloc(sizeof(*am_fence), GFP_KERNEL);
 		if (!am_fence)
 			return -ENOMEM;
+		am_fence->context = 0;
 	} else {
 		am_fence = af;
 	}
 	fence = &am_fence->base;
 	am_fence->ring = ring;
+	am_fence->wptr = 0;
 
 	seq = ++ring->fence_drv.sync_seq;
 	if (af) {
@@ -253,6 +255,7 @@ bool amdgpu_fence_process(struct amdgpu_ring *ring)
 
 	do {
 		struct dma_fence *fence, **ptr;
+		struct amdgpu_fence *am_fence;
 
 		++last_seq;
 		last_seq &= drv->num_fences_mask;
@@ -265,6 +268,13 @@ bool amdgpu_fence_process(struct amdgpu_ring *ring)
 		if (!fence)
 			continue;
 
+		/* Save the wptr in the fence driver so we know what the last processed
+		 * wptr was.  This is required for re-emitting the ring state for
+		 * queues that are reset but are not guilty and thus have no guilty fence.
+		 */
+		am_fence = container_of(fence, struct amdgpu_fence, base);
+		if (am_fence->wptr)
+			drv->last_wptr = am_fence->wptr;
 		dma_fence_signal(fence);
 		dma_fence_put(fence);
 		pm_runtime_mark_last_busy(adev_to_drm(adev)->dev);
@@ -725,6 +735,95 @@ void amdgpu_fence_driver_force_completion(struct amdgpu_ring *ring)
 	amdgpu_fence_process(ring);
 }
 
+
+/**
+ * Kernel queue reset handling
+ *
+ * The driver can reset individual queues for most engines, but those queues
+ * may contain work from multiple contexts.  Resetting the queue will reset
+ * lose all of that state.  In order to minimize the collatoral damage, the
+ * driver will save the ring contents which are not associated with the guilty
+ * context prior to resetting the queue.  After resetting the queue the queue
+ * contents from the other contexts is re-emitted to the rings so that it can
+ * be processed by the engine.  To handle this, we save the queue's write
+ * pointer (wptr) in the fences associated with each context.  If we get a
+ * queue timeout, we can then use the wptrs from the fences to determine
+ * which data needs to be saved out of the queue's ring buffer.
+ */
+
+/**
+ * amdgpu_fence_driver_guilty_force_completion - force signal of specified sequence
+ *
+ * @fence: fence of the ring to signal
+ *
+ */
+void amdgpu_fence_driver_guilty_force_completion(struct amdgpu_fence *fence)
+{
+	dma_fence_set_error(&fence->base, -ETIME);
+	amdgpu_fence_write(fence->ring, fence->base.seqno);
+	amdgpu_fence_process(fence->ring);
+}
+
+void amdgpu_fence_save_wptr(struct dma_fence *fence)
+{
+	struct amdgpu_fence *am_fence = container_of(fence, struct amdgpu_fence, base);
+
+	am_fence->wptr = am_fence->ring->wptr;
+}
+
+static void amdgpu_ring_backup_unprocessed_command(struct amdgpu_ring *ring,
+						   unsigned int idx,
+						   u64 start_wptr, u32 end_wptr)
+{
+	unsigned int first_idx = start_wptr & ring->buf_mask;
+	unsigned int last_idx = end_wptr & ring->buf_mask;
+	unsigned int i, count;
+
+	/* Backup the contents of the ring buffer. */
+	for (i = first_idx, count = 0; i != last_idx; ++i, i &= ring->buf_mask, ++count)
+		ring->ring_backup[count] = ring->ring[i];
+	ring->ring_backup_entries_to_copy = count;
+}
+
+void amdgpu_ring_backup_unprocessed_commands(struct amdgpu_ring *ring,
+					     struct amdgpu_fence *guilty_fence)
+{
+	struct amdgpu_fence *fence;
+	struct dma_fence *unprocessed, **ptr;
+	u64 wptr, i, seqno;
+
+	if (guilty_fence) {
+		seqno = guilty_fence->base.seqno;
+		wptr = guilty_fence->wptr;
+	} else {
+		seqno = amdgpu_fence_read(ring);
+		wptr = ring->fence_drv.last_wptr;
+	}
+	ring->ring_backup_entries_to_copy = 0;
+	for (i = seqno + 1; i <= ring->fence_drv.sync_seq; ++i) {
+		ptr = &ring->fence_drv.fences[i & ring->fence_drv.num_fences_mask];
+		rcu_read_lock();
+		unprocessed = rcu_dereference(*ptr);
+
+		if (unprocessed && !dma_fence_is_signaled(unprocessed)) {
+			fence = container_of(unprocessed, struct amdgpu_fence, base);
+
+			/* save everything if the ring is not guilty, otherwise
+			 * just save the content from other contexts.
+			 */
+			if (fence->wptr &&
+			    (!guilty_fence || (fence->context != guilty_fence->context))) {
+				amdgpu_ring_backup_unprocessed_command(ring,
+								       ring->ring_backup_entries_to_copy,
+								       wptr,
+								       fence->wptr);
+				wptr = fence->wptr;
+			}
+		}
+		rcu_read_unlock();
+	}
+}
+
 /*
  * Common fence implementation
  */
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
index 206b70acb29a0..d0f838fde2ae5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
@@ -139,7 +139,6 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned int num_ibs,
 	int vmid = AMDGPU_JOB_GET_VMID(job);
 	bool need_pipe_sync = false;
 	unsigned int cond_exec;
-
 	unsigned int i;
 	int r = 0;
 
@@ -156,6 +155,11 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned int num_ibs,
 		gds_va = job->gds_va;
 		init_shadow = job->init_shadow;
 		af = &job->hw_fence;
+		/* Save the context of the job for reset handling.
+		 * The driver needs this so it can skip the ring
+		 * contents for guilty contexts.
+		 */
+		af->context = job->base.s_fence ? job->base.s_fence->finished.context : 0;
 	} else {
 		vm = NULL;
 		fence_ctx = 0;
@@ -309,6 +313,15 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned int num_ibs,
 
 	amdgpu_ring_ib_end(ring);
 	amdgpu_ring_commit(ring);
+
+	/* Save the wptr associated with this fence.
+	 * This must be last for resets to work properly
+	 * as we need to save the wptr associated with this
+	 * fence so we know what rings contents to backup
+	 * after we reset the queue.
+	 */
+	amdgpu_fence_save_wptr(*f);
+
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
index f0b7080dccb8d..45febdc2f3493 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
@@ -89,8 +89,8 @@ static enum drm_gpu_sched_stat amdgpu_job_timedout(struct drm_sched_job *s_job)
 {
 	struct amdgpu_ring *ring = to_amdgpu_ring(s_job->sched);
 	struct amdgpu_job *job = to_amdgpu_job(s_job);
-	struct amdgpu_task_info *ti;
 	struct amdgpu_device *adev = ring->adev;
+	struct amdgpu_task_info *ti;
 	int idx, r;
 
 	if (!drm_dev_enter(adev_to_drm(adev), &idx)) {
@@ -135,7 +135,7 @@ static enum drm_gpu_sched_stat amdgpu_job_timedout(struct drm_sched_job *s_job)
 	} else if (amdgpu_gpu_recovery && ring->funcs->reset) {
 		dev_err(adev->dev, "Starting %s ring reset\n",
 			s_job->sched->name);
-		r = amdgpu_ring_reset(ring, job->vmid, NULL);
+		r = amdgpu_ring_reset(ring, job->vmid, &job->hw_fence);
 		if (!r) {
 			atomic_inc(&ring->adev->gpu_reset_counter);
 			dev_err(adev->dev, "Ring %s reset succeeded\n",
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
index 426834806fbf2..0985eba010e17 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
@@ -333,6 +333,12 @@ int amdgpu_ring_init(struct amdgpu_device *adev, struct amdgpu_ring *ring,
 	/*  Initialize cached_rptr to 0 */
 	ring->cached_rptr = 0;
 
+	if (!ring->ring_backup) {
+		ring->ring_backup = kvzalloc(ring->ring_size, GFP_KERNEL);
+		if (!ring->ring_backup)
+			return -ENOMEM;
+	}
+
 	/* Allocate ring buffer */
 	if (ring->ring_obj == NULL) {
 		r = amdgpu_bo_create_kernel(adev, ring->ring_size + ring->funcs->extra_dw, PAGE_SIZE,
@@ -342,6 +348,7 @@ int amdgpu_ring_init(struct amdgpu_device *adev, struct amdgpu_ring *ring,
 					    (void **)&ring->ring);
 		if (r) {
 			dev_err(adev->dev, "(%d) ring create failed\n", r);
+			kvfree(ring->ring_backup);
 			return r;
 		}
 		amdgpu_ring_clear_ring(ring);
@@ -385,6 +392,8 @@ void amdgpu_ring_fini(struct amdgpu_ring *ring)
 	amdgpu_bo_free_kernel(&ring->ring_obj,
 			      &ring->gpu_addr,
 			      (void **)&ring->ring);
+	kvfree(ring->ring_backup);
+	ring->ring_backup = NULL;
 
 	dma_fence_put(ring->vmid_wait);
 	ring->vmid_wait = NULL;
@@ -753,3 +762,53 @@ bool amdgpu_ring_sched_ready(struct amdgpu_ring *ring)
 
 	return true;
 }
+
+static int amdgpu_ring_reemit_unprocessed_commands(struct amdgpu_ring *ring)
+{
+	unsigned int i;
+	int r;
+
+	/* re-emit the unprocessed ring contents */
+	if (ring->ring_backup_entries_to_copy) {
+		r = amdgpu_ring_alloc(ring, ring->ring_backup_entries_to_copy);
+		if (r)
+			return r;
+		for (i = 0; i < ring->ring_backup_entries_to_copy; i++)
+			amdgpu_ring_write(ring, ring->ring_backup[i]);
+		amdgpu_ring_commit(ring);
+	}
+
+	return 0;
+}
+
+void amdgpu_ring_reset_helper_begin(struct amdgpu_ring *ring,
+				    struct amdgpu_fence *guilty_fence)
+{
+	/* Stop the scheduler to prevent anybody else from touching the ring buffer. */
+	drm_sched_wqueue_stop(&ring->sched);
+	/* back up the non-guilty commands */
+	amdgpu_ring_backup_unprocessed_commands(ring, guilty_fence);
+}
+
+int amdgpu_ring_reset_helper_end(struct amdgpu_ring *ring,
+				 struct amdgpu_fence *guilty_fence)
+{
+	int r;
+
+	/* verify that the ring is functional */
+	r = amdgpu_ring_test_ring(ring);
+	if (r)
+		return r;
+
+	/* signal the fence of the bad job */
+	if (guilty_fence)
+		amdgpu_fence_driver_guilty_force_completion(guilty_fence);
+	/* Re-emit the non-guilty commands */
+	r = amdgpu_ring_reemit_unprocessed_commands(ring);
+	if (r)
+		/* if we fail to reemit, force complete all fences */
+		amdgpu_fence_driver_force_completion(ring);
+	/* Start the scheduler again */
+	drm_sched_wqueue_start(&ring->sched);
+	return 0;
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
index 784ba2ec354c7..2b5546d15a6be 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
@@ -118,6 +118,7 @@ struct amdgpu_fence_driver {
 	/* sync_seq is protected by ring emission lock */
 	uint32_t			sync_seq;
 	atomic_t			last_seq;
+	u64				last_wptr;
 	bool				initialized;
 	struct amdgpu_irq_src		*irq_src;
 	unsigned			irq_type;
@@ -141,6 +142,11 @@ struct amdgpu_fence {
 	/* RB, DMA, etc. */
 	struct amdgpu_ring		*ring;
 	ktime_t				start_timestamp;
+
+	/* wptr for the fence for resets */
+	u64				wptr;
+	/* fence context for resets */
+	u64				context;
 };
 
 extern const struct drm_sched_backend_ops amdgpu_sched_ops;
@@ -148,6 +154,8 @@ extern const struct drm_sched_backend_ops amdgpu_sched_ops;
 void amdgpu_fence_driver_clear_job_fences(struct amdgpu_ring *ring);
 void amdgpu_fence_driver_set_error(struct amdgpu_ring *ring, int error);
 void amdgpu_fence_driver_force_completion(struct amdgpu_ring *ring);
+void amdgpu_fence_driver_guilty_force_completion(struct amdgpu_fence *fence);
+void amdgpu_fence_save_wptr(struct dma_fence *fence);
 
 int amdgpu_fence_driver_init_ring(struct amdgpu_ring *ring);
 int amdgpu_fence_driver_start_ring(struct amdgpu_ring *ring,
@@ -284,6 +292,9 @@ struct amdgpu_ring {
 
 	struct amdgpu_bo	*ring_obj;
 	uint32_t		*ring;
+	/* backups for resets */
+	uint32_t		*ring_backup;
+	unsigned int		ring_backup_entries_to_copy;
 	unsigned		rptr_offs;
 	u64			rptr_gpu_addr;
 	volatile u32		*rptr_cpu_addr;
@@ -550,4 +561,10 @@ int amdgpu_ib_pool_init(struct amdgpu_device *adev);
 void amdgpu_ib_pool_fini(struct amdgpu_device *adev);
 int amdgpu_ib_ring_tests(struct amdgpu_device *adev);
 bool amdgpu_ring_sched_ready(struct amdgpu_ring *ring);
+void amdgpu_ring_backup_unprocessed_commands(struct amdgpu_ring *ring,
+					     struct amdgpu_fence *guilty_fence);
+void amdgpu_ring_reset_helper_begin(struct amdgpu_ring *ring,
+				    struct amdgpu_fence *guilty_fence);
+int amdgpu_ring_reset_helper_end(struct amdgpu_ring *ring,
+				 struct amdgpu_fence *guilty_fence);
 #endif
-- 
2.49.0

