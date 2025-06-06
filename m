Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FDA3C5B549
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Jun 2025 06:44:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A5E3310E8BD;
	Fri,  6 Jun 2025 06:44:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="MTRlRuHJ";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2063.outbound.protection.outlook.com [40.107.237.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 29E5010E9D8
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Jun 2025 06:44:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sYXfbFYsJa4nh+wBdGLEarTs7EOLDUhjLsa4kpONw7AwARiR7s9yEJO3XHBpHv1bJf1aL3uaBNmGoODw88jSNQvvaGK0JFhRpG7ZkHb6jnexpmPa8yptahiiz7mESFtQcTcZXb7UUTYIV3TDnhro3+QV4ptCa+5UDuUktf7nS9u4DyccpT4jXewUufcOFOsobGq9tQZE0zL+bbPlUJIF/fEonudcC8LvSJBQSz6iXzpnaRKEBglFrKtJhaoxgbI6Cs+p4jhfMetq0DfB4f1n/q+BpIJ6R1AB2Mblw86xnhJHgMlpOGUQ7PQiIa7cYD9qB9SOc/T7BTozhC1MnhDf7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=caas/g+34fps9jC6wfv1+BeqbWaph9Icr5wmcP8K9Eg=;
 b=t9M1OcAdKAOfpXc92wmrgSA8FCwBfKqMQSvb2/JT2TnyOYjK/PuRy/TnRtS7EqQFAITYCpVFPAs6OdeyENc4vaFuIjHBImLYYpnftC9vxm8a46rPV7MpTs29gKCle1WgzMNKofTEcBimwSsui2YMd8yyGltFNfzl+6BgGE4jKS0P+BmgPD3mJVyWgcREjMgaORBGJd5ytp91L75yb22rf4lydODIJAVonpuuvoKQyo1eNxYoZD8N4Sp7OaIWics4O3CKg3kwlXO2mtMcWu6I4StvCe2xDdIuOpEZ9n/1QHVd2x6i3KlmFR134zDmgW4QFrI5Z4dwCrSLsjckbEdbSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=caas/g+34fps9jC6wfv1+BeqbWaph9Icr5wmcP8K9Eg=;
 b=MTRlRuHJKPejWJOSHrOPYCjqhsVBnudBhoqBKLuv+krYVVL1+mkctFFQEsHolxv+t/UOhkYmxAqPBs83UsmU7t21KNdNyUgHZ4LcPO0hcGGAVsOAgHNNfdGxwlgA7pxzs4LeVrZmNjvfStP+fDLdDq21IwZ8Y5Ha/wG4OwYOqNQ=
Received: from SJ0PR05CA0068.namprd05.prod.outlook.com (2603:10b6:a03:332::13)
 by SJ0PR12MB6829.namprd12.prod.outlook.com (2603:10b6:a03:47b::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.33; Fri, 6 Jun
 2025 06:44:13 +0000
Received: from SJ1PEPF00001CE4.namprd03.prod.outlook.com
 (2603:10b6:a03:332:cafe::b0) by SJ0PR05CA0068.outlook.office365.com
 (2603:10b6:a03:332::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.9 via Frontend Transport; Fri, 6
 Jun 2025 06:44:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CE4.mail.protection.outlook.com (10.167.242.20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8792.29 via Frontend Transport; Fri, 6 Jun 2025 06:44:13 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 6 Jun
 2025 01:44:10 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 05/29] drm/amdgpu: switch job hw_fence to amdgpu_fence
Date: Fri, 6 Jun 2025 02:43:30 -0400
Message-ID: <20250606064354.5858-6-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250606064354.5858-1-alexander.deucher@amd.com>
References: <20250606064354.5858-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE4:EE_|SJ0PR12MB6829:EE_
X-MS-Office365-Filtering-Correlation-Id: b51fca3f-29db-4e5f-301a-08dda4c58d15
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?4d1nu5oZKNQHzK79yaJECLydcH9Uo9slSRx5CFXbOMlc3EBQhrkQAzDPjTZR?=
 =?us-ascii?Q?JvvzDNrC/X7ETb4VZGX6cXVM/o4RO+89mLkYWp8L4nJSGv7Lx4LWZvVvQfiV?=
 =?us-ascii?Q?3QHErGwrMIOYYg4pR4YdSYzaSCk6jlbf30W6+PMLJwqCehxkIbyW5jrRefMt?=
 =?us-ascii?Q?BasTUsudQyDcOMwWK7Tk8izo96QKA7m+GikOlSPAH/HgHjGQQviZlKQpUagj?=
 =?us-ascii?Q?jnDz/MY+OhC1nrBt/9rsgDCZ2SnFhDgCH/z4d7/kRo5NaqwjkkbEHColyu5s?=
 =?us-ascii?Q?HjNtbjYR26xe+cuLs7MXMmVrXo5RWbN9wQxM+qczJBEsV+bMqlpIZLS1bbAb?=
 =?us-ascii?Q?e9oL1Nlsltjr7tOwVoCuPDhOAv+QV0iKPvzrMBcsY3lAdfA2zb1ak5J1pHIv?=
 =?us-ascii?Q?kPqFsnzvG0MuJoaEFOUYZM3GPnGG4sqlr27coZ/GIt1bXbx0XXnEvsayCfw9?=
 =?us-ascii?Q?QYV/wYVkRTC/IsSi3mL5SbH+6Dzj8zDEpcmVuKfslp1LLLE9dZvjxSCnyzDC?=
 =?us-ascii?Q?CK9t0Wy/3WR0KQzZ2Ti1waX53J6jaoD4+rpUokEdfdJ887W4//nLYVF9Vw2O?=
 =?us-ascii?Q?kw7GHlDxySScdjTI/7qnd+QUCoTab73qwDwrd9tNfU26dpIKBF7sZiLS587q?=
 =?us-ascii?Q?vEMNNYx0mbsvlW4sBf2yVCGcK3/4Gt4txTlW7LgfRS2fkSCNEg+WGCXiTaGH?=
 =?us-ascii?Q?Cn/SxbHpaOofES+qbFJ29GCRg0jnMgp8oi4k7Ciwy3KyhlIbDJ8TcoyQIZ1A?=
 =?us-ascii?Q?eKajzpjFjG28aDSasnbkA5DV1ybkzV6IQqOcX6hb3aFb1pkV5GtjT72adJRo?=
 =?us-ascii?Q?+3XU5HM1SM5AryrkfDCna9bAPkFqpJhdg3YT2i06G+56ytJiC0CL7DE/Qe+v?=
 =?us-ascii?Q?EUvtpav4IgRvOlG3UOySu2FTzdIVT55j26wgHQh0t6WB86IIEhz2lvUxe6aX?=
 =?us-ascii?Q?HRbpx/k04g2KP4KA5nF1QPh6owQt74UjgLswLLv2pJqyoEkl+U0t7XeTD69M?=
 =?us-ascii?Q?OdI79eOlWiGOiIXvgAMrm83pl57AuzPimBLMyFwa/y9VV/vkp0BRUN6GdZC6?=
 =?us-ascii?Q?ndwuVppU7P8+SEaHIqmIw3B5YSjR+cJ9gSEogaZz0Eh2LBW9Jgmmm0NBrjNr?=
 =?us-ascii?Q?DbQ9eK4m3McdZyZf92gsKIH56YQrt+ZJlauUv/mZKbVxTvXENMvBfLDVERZ+?=
 =?us-ascii?Q?W1lL9bU4LT4ppKCtMC/NFF15VHhHFa8tbuRtx3N5jbgMTBvV88Cbh9tGpfMS?=
 =?us-ascii?Q?eGuIlR6ZJ4/xYYEwJaeaO6R9CLxKrdflHF8MDXfk5fEW7Nw1kydqGoYtCSFR?=
 =?us-ascii?Q?FgRKq9iAVloTRNt8gX2suAm57pzy9Xf5/OQg6opXA5Axjn7GyDU4FBxvD89i?=
 =?us-ascii?Q?agySSwdmyNngheKYUF+w8cd3crQByCZK+DMEH/7hgS2PMsptx7a6q1sJYFxk?=
 =?us-ascii?Q?0izFyVBAWde6QU/tohWPI26vEPDG+GElIvOaXs3NjCI4mEqDGNUfVUzOB2jW?=
 =?us-ascii?Q?LQvQinQNKBJn0Rmg7j0vCTQ9xDA4Ef1+8TS7?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2025 06:44:13.7700 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b51fca3f-29db-4e5f-301a-08dda4c58d15
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CE4.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6829
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

Use the amdgpu fence container so we can store additional
data in the fence.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c  |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c   | 30 +++++----------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.c     | 12 ++++-----
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.h     |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h    | 16 +++++++++++
 6 files changed, 32 insertions(+), 32 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
index 8e626f50b362e..f81608330a3d0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
@@ -1902,7 +1902,7 @@ static void amdgpu_ib_preempt_mark_partial_job(struct amdgpu_ring *ring)
 			continue;
 		}
 		job = to_amdgpu_job(s_job);
-		if (preempted && (&job->hw_fence) == fence)
+		if (preempted && (&job->hw_fence.base) == fence)
 			/* mark the job as preempted */
 			job->preemption_status |= AMDGPU_IB_PREEMPTED;
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index ea565651f7459..8298e95e4543e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -6375,7 +6375,7 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
 	 *
 	 * job->base holds a reference to parent fence
 	 */
-	if (job && dma_fence_is_signaled(&job->hw_fence)) {
+	if (job && dma_fence_is_signaled(&job->hw_fence.base)) {
 		job_signaled = true;
 		dev_info(adev->dev, "Guilty job already signaled, skipping HW reset");
 		goto skip_hw_reset;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
index 2f24a6aa13bf6..569e0e5373927 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
@@ -41,22 +41,6 @@
 #include "amdgpu_trace.h"
 #include "amdgpu_reset.h"
 
-/*
- * Fences mark an event in the GPUs pipeline and are used
- * for GPU/CPU synchronization.  When the fence is written,
- * it is expected that all buffers associated with that fence
- * are no longer in use by the associated ring on the GPU and
- * that the relevant GPU caches have been flushed.
- */
-
-struct amdgpu_fence {
-	struct dma_fence base;
-
-	/* RB, DMA, etc. */
-	struct amdgpu_ring		*ring;
-	ktime_t				start_timestamp;
-};
-
 static struct kmem_cache *amdgpu_fence_slab;
 
 int amdgpu_fence_slab_init(void)
@@ -151,12 +135,12 @@ int amdgpu_fence_emit(struct amdgpu_ring *ring, struct dma_fence **f, struct amd
 		am_fence = kmem_cache_alloc(amdgpu_fence_slab, GFP_ATOMIC);
 		if (am_fence == NULL)
 			return -ENOMEM;
-		fence = &am_fence->base;
-		am_fence->ring = ring;
 	} else {
 		/* take use of job-embedded fence */
-		fence = &job->hw_fence;
+		am_fence = &job->hw_fence;
 	}
+	fence = &am_fence->base;
+	am_fence->ring = ring;
 
 	seq = ++ring->fence_drv.sync_seq;
 	if (job && job->job_run_counter) {
@@ -718,7 +702,7 @@ void amdgpu_fence_driver_clear_job_fences(struct amdgpu_ring *ring)
 			 * it right here or we won't be able to track them in fence_drv
 			 * and they will remain unsignaled during sa_bo free.
 			 */
-			job = container_of(old, struct amdgpu_job, hw_fence);
+			job = container_of(old, struct amdgpu_job, hw_fence.base);
 			if (!job->base.s_fence && !dma_fence_is_signaled(old))
 				dma_fence_signal(old);
 			RCU_INIT_POINTER(*ptr, NULL);
@@ -780,7 +764,7 @@ static const char *amdgpu_fence_get_timeline_name(struct dma_fence *f)
 
 static const char *amdgpu_job_fence_get_timeline_name(struct dma_fence *f)
 {
-	struct amdgpu_job *job = container_of(f, struct amdgpu_job, hw_fence);
+	struct amdgpu_job *job = container_of(f, struct amdgpu_job, hw_fence.base);
 
 	return (const char *)to_amdgpu_ring(job->base.sched)->name;
 }
@@ -810,7 +794,7 @@ static bool amdgpu_fence_enable_signaling(struct dma_fence *f)
  */
 static bool amdgpu_job_fence_enable_signaling(struct dma_fence *f)
 {
-	struct amdgpu_job *job = container_of(f, struct amdgpu_job, hw_fence);
+	struct amdgpu_job *job = container_of(f, struct amdgpu_job, hw_fence.base);
 
 	if (!timer_pending(&to_amdgpu_ring(job->base.sched)->fence_drv.fallback_timer))
 		amdgpu_fence_schedule_fallback(to_amdgpu_ring(job->base.sched));
@@ -845,7 +829,7 @@ static void amdgpu_job_fence_free(struct rcu_head *rcu)
 	struct dma_fence *f = container_of(rcu, struct dma_fence, rcu);
 
 	/* free job if fence has a parent job */
-	kfree(container_of(f, struct amdgpu_job, hw_fence));
+	kfree(container_of(f, struct amdgpu_job, hw_fence.base));
 }
 
 /**
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
index acb21fc8b3ce5..ddb9d3269357c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
@@ -272,8 +272,8 @@ void amdgpu_job_free_resources(struct amdgpu_job *job)
 	/* Check if any fences where initialized */
 	if (job->base.s_fence && job->base.s_fence->finished.ops)
 		f = &job->base.s_fence->finished;
-	else if (job->hw_fence.ops)
-		f = &job->hw_fence;
+	else if (job->hw_fence.base.ops)
+		f = &job->hw_fence.base;
 	else
 		f = NULL;
 
@@ -290,10 +290,10 @@ static void amdgpu_job_free_cb(struct drm_sched_job *s_job)
 	amdgpu_sync_free(&job->explicit_sync);
 
 	/* only put the hw fence if has embedded fence */
-	if (!job->hw_fence.ops)
+	if (!job->hw_fence.base.ops)
 		kfree(job);
 	else
-		dma_fence_put(&job->hw_fence);
+		dma_fence_put(&job->hw_fence.base);
 }
 
 void amdgpu_job_set_gang_leader(struct amdgpu_job *job,
@@ -322,10 +322,10 @@ void amdgpu_job_free(struct amdgpu_job *job)
 	if (job->gang_submit != &job->base.s_fence->scheduled)
 		dma_fence_put(job->gang_submit);
 
-	if (!job->hw_fence.ops)
+	if (!job->hw_fence.base.ops)
 		kfree(job);
 	else
-		dma_fence_put(&job->hw_fence);
+		dma_fence_put(&job->hw_fence.base);
 }
 
 struct dma_fence *amdgpu_job_submit(struct amdgpu_job *job)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
index f2c049129661f..931fed8892cc1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
@@ -48,7 +48,7 @@ struct amdgpu_job {
 	struct drm_sched_job    base;
 	struct amdgpu_vm	*vm;
 	struct amdgpu_sync	explicit_sync;
-	struct dma_fence	hw_fence;
+	struct amdgpu_fence	hw_fence;
 	struct dma_fence	*gang_submit;
 	uint32_t		preamble_status;
 	uint32_t                preemption_status;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
index b95b471107692..e1f25218943a4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
@@ -127,6 +127,22 @@ struct amdgpu_fence_driver {
 	struct dma_fence		**fences;
 };
 
+/*
+ * Fences mark an event in the GPUs pipeline and are used
+ * for GPU/CPU synchronization.  When the fence is written,
+ * it is expected that all buffers associated with that fence
+ * are no longer in use by the associated ring on the GPU and
+ * that the relevant GPU caches have been flushed.
+ */
+
+struct amdgpu_fence {
+	struct dma_fence base;
+
+	/* RB, DMA, etc. */
+	struct amdgpu_ring		*ring;
+	ktime_t				start_timestamp;
+};
+
 extern const struct drm_sched_backend_ops amdgpu_sched_ops;
 
 void amdgpu_fence_driver_clear_job_fences(struct amdgpu_ring *ring);
-- 
2.49.0

