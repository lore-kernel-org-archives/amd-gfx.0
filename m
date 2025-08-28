Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC171CA0EED
	for <amd-gfx@archiver.kernel.org>; Thu, 28 Aug 2025 14:06:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5248F10E9B3;
	Thu, 28 Aug 2025 14:06:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="1fjC8DK1";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2050.outbound.protection.outlook.com [40.107.92.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5EFCC10E9B3
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 Aug 2025 14:06:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cheGNxlE9KdEhsR9eeBCpqO9fHBcQxvTiKf3RDCJ0gy9W5EzTKTHZitVe+qsxnH5g17QolGIlMJ7UbdMnHbUjPSTrz/7GpBQX0mB5TwlBN9Kivzm9D3l8XqllBPioSQYThep8KniUwRSoDNslpEjw3UP8Hq8H6BBEJ9E4n3eMLDsxOcQsRHkJe7sKsielbDIfvXobmm5gsf10Ab1dX9fTGuzjDtg3v2dV/buSroFwtSUKYuWDzHlEgaLl1zMvx+PqxxcwX8l1WSZfKPCgfe0uQTq0w8X+gV8DhO9TuCPr1yRAjXCH2t40hynLQ095PRecK+cO42WGUhwJP6GXErr2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mKZB0T3I4HUv8o++S4m5mmFnp6pCUMi+CqR3eFV4Ssk=;
 b=wO/eGBsygXoyU1yGPbrU75MVs7dQc/1O+XBuV8tFBczzoZxmgXvIUL09/jkRDf0kDktHn2TNKekjH9rGPOrN1ZI5OClTs8vh+D97sxslMFJgCqarcTN098EaH8RUSHzS4vfC70bIzv05nz+tUrbbWZUUNj/Qdf8gkbUgIS3Xr/gwDqKtzE+fVCecueRK4oQVeqLytUJQk+qjqcIDs3iqe/q3j/43VX5L2jHmQ4NgOLFO5ppEKocXLhk1O0gpI+vnj3CzM2Tr2qMhc4ZVQExoK1OIjAO1rMNgdNftcYyOjRs7JHGzzQA/dxNAj5+pK2c7AgeLcF7fyokvI4jVDwW+NA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mKZB0T3I4HUv8o++S4m5mmFnp6pCUMi+CqR3eFV4Ssk=;
 b=1fjC8DK1+eJZpOonzVS1V96EwrHl0TK1OM7SoTnPk27aIoUMr0P1yA84OgdmEeXo42JXWl+F4m+45i9UF3/7PTqyzw7uYeloifJSD2RIoR1ha1ufvzueta5SBFET3FbZxAnk8VZUt7NdXTKf11xGNA7BZ5G25LoJjNvxQIQO/ek=
Received: from SJ0PR13CA0049.namprd13.prod.outlook.com (2603:10b6:a03:2c2::24)
 by BY5PR12MB4180.namprd12.prod.outlook.com (2603:10b6:a03:213::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.13; Thu, 28 Aug
 2025 14:06:05 +0000
Received: from SJ1PEPF00002316.namprd03.prod.outlook.com
 (2603:10b6:a03:2c2:cafe::89) by SJ0PR13CA0049.outlook.office365.com
 (2603:10b6:a03:2c2::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9073.12 via Frontend Transport; Thu,
 28 Aug 2025 14:06:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SJ1PEPF00002316.mail.protection.outlook.com (10.167.242.170) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9073.11 via Frontend Transport; Thu, 28 Aug 2025 14:06:05 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 28 Aug
 2025 09:06:02 -0500
Received: from tr4.amd.com (10.180.168.240) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1748.10; Thu, 28 Aug
 2025 07:06:01 -0700
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>, <David.Wu3@amd.com>,
 <christian.koenig@amd.com>
Subject: [PATCH] drm/amdgpu: clean up and unify hw fence handling
Date: Thu, 28 Aug 2025 10:05:48 -0400
Message-ID: <20250828140548.5792-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To satlexmb09.amd.com
 (10.181.42.218)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002316:EE_|BY5PR12MB4180:EE_
X-MS-Office365-Filtering-Correlation-Id: 75c48876-2ab0-4b29-8083-08dde63c075c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?g9VVDf3XQwIVXyTLXzdb3Gz8CTmj1r6l5Hb4zDxsNvw4j8kwMK2SAF6dMSUg?=
 =?us-ascii?Q?teCAO29pyohQgcd9ftP9Pc6P81K7RlTOupxy1+N/n3m/8Ju6gUKNbF3PHVjY?=
 =?us-ascii?Q?W3Rhg/kSdkA9q8l30CorZVFOPjrAvF2sPrEwSHIXqXsZ/WJivxiRFjY7vRN/?=
 =?us-ascii?Q?+IB9qnaMPpLW/4XdB42lFxMOarEwYi3lKGw+aa+z1D6Fi3SZ5cOXngRjB2uK?=
 =?us-ascii?Q?72ReNWA42bqM9b7NjSDgobPKPLq9L9aJyjXgGYDZ8bgDY/H28Qj1GnV2Yd7s?=
 =?us-ascii?Q?u+pHjXJlnfSm9mFYsbxnJNRzMeqahrEuCLtDZKd7sWPnVsioelFvMGkqa3Nv?=
 =?us-ascii?Q?GZ4end2NrT/nZGZFvdmriGRbbUC95lZQdJfMqj/SVU7k14wW300aRsAbqowe?=
 =?us-ascii?Q?EaxexGVwwk7pjfVOo89dRZU7ZRnysSwQiLzBo6XF3dv7/T7/BwZY9Qpeox3J?=
 =?us-ascii?Q?KjaNy1hhwRTW9ZDLseW+vywhpXBQnoORdTWFDhgm9tBgNWqmgH7CyecjbJkz?=
 =?us-ascii?Q?UZITBK3sO53qtrWAXyHMlKWz8KT4oKlTqWpUXhqYjKOtrBeVhrpvl4Y1Ei4A?=
 =?us-ascii?Q?iRSpCjUJ6eo4cbMz7S6GfM7UXLLzmrWo7E3yhBgROFMjYZjA2JUMxBRFBN5k?=
 =?us-ascii?Q?4mYCz8sAZlbt+4YqPhX9G+xpLiwJbGfusgjDcLnkO7epHkXV5jQuUKBEnLyE?=
 =?us-ascii?Q?WzAV/1TE+nwdjVesonVB9z8DkYxz5vFJJHzv0U+5nz0BycBz0qsMcsXH5qYm?=
 =?us-ascii?Q?1b2UaF/1/BdWUsJcTKfqjCfLe20V2Bkqc2d6KAkQ5PocoZsDxjQ551g/l3BU?=
 =?us-ascii?Q?0ua3+o5hSRol+fYxTvU/WFMC6A/uuVQzIyrPoSB8eTchibGHVhSlQyvkskv7?=
 =?us-ascii?Q?qp0+LlfWNc08mcifkIKVCu/9moEBRey9z3cNedkNtTLYKu8llL78EVyqFCBS?=
 =?us-ascii?Q?hMYX+sMdR0s9Qwhm/ZjvsVStTQBl+VuwRSgXhK7BRBJGe0D71NPizHIpwIEp?=
 =?us-ascii?Q?hkCs+YRsP2mnIgTZsf84YYG9wibcNA9hh9dPCbCGFyAawt0lN5onlW6KqEov?=
 =?us-ascii?Q?T84vOk5AUfoMW0mG7FnP7CvJkFut7Qn/vLzRCf6HuSL80UvRqMKsa2/PRHpE?=
 =?us-ascii?Q?xkGf8mVOORQ2R5nFYCUUDSpoVvmYY/VuePSRywY+vchjoF3041HBzjSQPlNR?=
 =?us-ascii?Q?hrE+fxlOOaAeH29YWnJ9Og36he+K+Dt9+WRQ2kn6PWb/78YTA6y+msMC9SMS?=
 =?us-ascii?Q?wnaXokx3WbvQ/lUGYf30idcIwmbRzCWMRniMcveS8Lc8KzNoftYL9I1ijUtW?=
 =?us-ascii?Q?1Z8IWSoXvndLriz8rbHVhlkseA5JZ5K6U0jcdAeDW0GJogXEhz+pC6TECcPx?=
 =?us-ascii?Q?j22mD/POu6sAnPmsMMaBz49xKdamqOxLWVby1dKZkpnOe+iN9txmWWAulIaw?=
 =?us-ascii?Q?nkwLQaWmGx8XWxn6tjrZzU491jGoruXS8U8WLWw6FyqdSefHl/NnL1wM7WiH?=
 =?us-ascii?Q?xjYt+jxRWOndPAZ0Ri3sDBDlfBdRT7A2Gtkt?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2025 14:06:05.1047 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 75c48876-2ab0-4b29-8083-08dde63c075c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002316.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4180
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

Cc: David.Wu3@amd.com
Cc: christian.koenig@amd.com
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---

v2: Additional cleanup suggested by Christian

 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c  |   7 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c   | 140 ++------------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c      |  22 +--
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.c     |  41 ++++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.h     |   3 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h    |   7 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c      |   7 +-
 8 files changed, 64 insertions(+), 165 deletions(-)

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
index 2d58aefbd68a7..1355fee0e978d 100644
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
@@ -98,51 +93,33 @@ static u32 amdgpu_fence_read(struct amdgpu_ring *ring)
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
+	af->seq = seq;
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
@@ -167,8 +144,6 @@ int amdgpu_fence_emit(struct amdgpu_ring *ring, struct dma_fence **f,
 	 */
 	rcu_assign_pointer(*ptr, dma_fence_get(fence));
 
-	*f = fence;
-
 	return 0;
 }
 
@@ -669,36 +644,6 @@ void amdgpu_fence_driver_hw_init(struct amdgpu_device *adev)
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
@@ -765,11 +710,9 @@ void amdgpu_fence_driver_guilty_force_completion(struct amdgpu_fence *fence)
 	amdgpu_fence_process(fence->ring);
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
@@ -830,13 +773,6 @@ static const char *amdgpu_fence_get_timeline_name(struct dma_fence *f)
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
@@ -853,23 +789,6 @@ static bool amdgpu_fence_enable_signaling(struct dma_fence *f)
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
@@ -885,21 +804,6 @@ static void amdgpu_fence_free(struct rcu_head *rcu)
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
@@ -913,19 +817,6 @@ static void amdgpu_fence_release(struct dma_fence *f)
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
@@ -933,13 +824,6 @@ static const struct dma_fence_ops amdgpu_fence_ops = {
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
index 7d9bcb72e8dd3..71215aeb1b6f5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
@@ -128,7 +128,7 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned int num_ibs,
 	struct amdgpu_device *adev = ring->adev;
 	struct amdgpu_ib *ib = &ibs[0];
 	struct dma_fence *tmp = NULL;
-	struct amdgpu_fence *af;
+	struct amdgpu_fence *af, *vm_af;
 	bool need_ctx_switch;
 	struct amdgpu_vm *vm;
 	uint64_t fence_ctx;
@@ -148,18 +148,20 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned int num_ibs,
 	/* ring tests don't use a job */
 	if (job) {
 		vm = job->vm;
-		fence_ctx = job->base.s_fence ?
-			job->base.s_fence->scheduled.context : 0;
+		fence_ctx = job->base.s_fence ? job->base.s_fence->finished.context : 0;
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
+		vm_af = job->hw_vm_fence;
+		/* the vm fence is also part of the job's context */
+		vm_af->context = fence_ctx;
 	} else {
 		vm = NULL;
 		fence_ctx = 0;
@@ -167,7 +169,10 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned int num_ibs,
 		csa_va = 0;
 		gds_va = 0;
 		init_shadow = false;
-		af = NULL;
+		af = kzalloc(sizeof(*af), GFP_NOWAIT);
+		if (!af)
+			return -ENOMEM;
+		vm_af = NULL;
 	}
 
 	if (!ring->sched.ready) {
@@ -289,7 +294,7 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned int num_ibs,
 		amdgpu_ring_init_cond_exec(ring, ring->cond_exe_gpu_addr);
 	}
 
-	r = amdgpu_fence_emit(ring, f, af, fence_flags);
+	r = amdgpu_fence_emit(ring, af, fence_flags);
 	if (r) {
 		dev_err(adev->dev, "failed to emit fence (%d)\n", r);
 		if (job && job->vmid)
@@ -297,6 +302,7 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned int num_ibs,
 		amdgpu_ring_undo(ring);
 		return r;
 	}
+	*f = &af->base;
 
 	if (ring->funcs->insert_end)
 		ring->funcs->insert_end(ring);
@@ -317,7 +323,7 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned int num_ibs,
 	 * fence so we know what rings contents to backup
 	 * after we reset the queue.
 	 */
-	amdgpu_fence_save_wptr(*f);
+	amdgpu_fence_save_wptr(af);
 
 	amdgpu_ring_ib_end(ring);
 	amdgpu_ring_commit(ring);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
index 311e97c96c4e0..9a78fe01efa3a 100644
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
@@ -251,8 +275,8 @@ void amdgpu_job_free_resources(struct amdgpu_job *job)
 	/* Check if any fences where initialized */
 	if (job->base.s_fence && job->base.s_fence->finished.ops)
 		f = &job->base.s_fence->finished;
-	else if (job->hw_fence.base.ops)
-		f = &job->hw_fence.base;
+	else if (job->hw_fence)
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
index 7670f5d82b9e4..901f8bd375212 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
@@ -152,11 +152,10 @@ struct amdgpu_fence {
 
 extern const struct drm_sched_backend_ops amdgpu_sched_ops;
 
-void amdgpu_fence_driver_clear_job_fences(struct amdgpu_ring *ring);
 void amdgpu_fence_driver_set_error(struct amdgpu_ring *ring, int error);
 void amdgpu_fence_driver_force_completion(struct amdgpu_ring *ring);
 void amdgpu_fence_driver_guilty_force_completion(struct amdgpu_fence *fence);
-void amdgpu_fence_save_wptr(struct dma_fence *fence);
+void amdgpu_fence_save_wptr(struct amdgpu_fence *af);
 
 int amdgpu_fence_driver_init_ring(struct amdgpu_ring *ring);
 int amdgpu_fence_driver_start_ring(struct amdgpu_ring *ring,
@@ -166,8 +165,8 @@ void amdgpu_fence_driver_hw_init(struct amdgpu_device *adev);
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
index bf42246a3db2f..7d1a363ad6878 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -772,7 +772,6 @@ int amdgpu_vm_flush(struct amdgpu_ring *ring, struct amdgpu_job *job,
 	bool cleaner_shader_needed = false;
 	bool pasid_mapping_needed = false;
 	struct dma_fence *fence = NULL;
-	struct amdgpu_fence *af;
 	unsigned int patch;
 	int r;
 
@@ -835,13 +834,11 @@ int amdgpu_vm_flush(struct amdgpu_ring *ring, struct amdgpu_job *job,
 	}
 
 	if (vm_flush_needed || pasid_mapping_needed || cleaner_shader_needed) {
-		r = amdgpu_fence_emit(ring, &fence, NULL, 0);
+		r = amdgpu_fence_emit(ring, job->hw_vm_fence, 0);
 		if (r)
 			return r;
-		/* this is part of the job's context */
-		af = container_of(fence, struct amdgpu_fence, base);
-		af->context = job->base.s_fence ? job->base.s_fence->finished.context : 0;
 	}
+	fence = &job->hw_vm_fence->base;
 
 	if (vm_flush_needed) {
 		mutex_lock(&id_mgr->lock);
-- 
2.51.0

