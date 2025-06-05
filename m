Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BF7FC61DB2
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Jun 2025 01:46:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B47D410E820;
	Thu,  5 Jun 2025 01:46:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Tf00BLj4";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2065.outbound.protection.outlook.com [40.107.92.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E249710E820
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 Jun 2025 01:46:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lz5aE4BXnkOwbdl336IiPuLXD6iD5k6HaBwbiES+x8Hm+HO6fkHSGMUSFGLlG2wYap0il0xcgYjBRIy+XZtd2AH1x7sW+J0PwPHMSSAzC/X8cArbwXn1OsC+wvFaQqIlLzy9+IFUrYU++gcvXHfcFHsMEU+yBhNWbwHTfl3tyC0pa2heDWlrjA/o+RLsB8aouQmFHZwR44JRJ/z3ABxFmINm6VJ1jECqDMGlvX924OxbS++Kh6tePhhN7jruCHw5YQ3B+ziDgtydVM20Dg3sA2uA44Mqma8tVRKanqju25wTPCrbgixdLwFmzdt3dJyY2Shw6gT5HmosNOhmi7nd7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rlj9amaf9gxdLGjSQe7+R+nLlqxY9x3IW9DCG7ney/8=;
 b=SxX1i167A56mHsn8IE7qP5iQXxGglOAccsIpbHTGeO7PLQ0otGH6tLVl3EGadzw0tIDgY8sPsduhWvw+lS/DxwES/HankpHHoj2yQqmUkA5MK08DKHV1fcvpde3ldxrpIeegKHmWldFrSJb5fxE1qoXnVc6Ta3CqgtUYdJf5LbpNkL/IDY2ajnp2iBvnpg/0iCEii7E4YOjliUwojB1N+r+0G45HuN36Y+MSDKRiy66Wx0/pz9SgSl4C96nYX7mEkhhgX+iEGSUJJ1HSjoDMSGnFJXUINvUkK81OaWNGld+w8kr/U1IWIrtuqM3x+pimP58QVnbkLP+Z9b3zcEJY8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rlj9amaf9gxdLGjSQe7+R+nLlqxY9x3IW9DCG7ney/8=;
 b=Tf00BLj4zwDySP9Hb7dD5vzpCxRWRuEOILuK/eeYKmtXaSfbpzp7/DLIym8L48WJ2XaFHxVEgVUeK4oTpw4GHLZyeR8H2X28pC7IDZISnK3uoKLPGQD0qtTcd0pZLHXwroo0caNkjOICVTnupg6UsMXzEPzYFP16ypDo9Qu7ymw=
Received: from SJ0PR03CA0143.namprd03.prod.outlook.com (2603:10b6:a03:33c::28)
 by DS0PR12MB6607.namprd12.prod.outlook.com (2603:10b6:8:d1::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.34; Thu, 5 Jun
 2025 01:46:24 +0000
Received: from SA2PEPF000015C6.namprd03.prod.outlook.com
 (2603:10b6:a03:33c:cafe::5b) by SJ0PR03CA0143.outlook.office365.com
 (2603:10b6:a03:33c::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8769.21 via Frontend Transport; Thu,
 5 Jun 2025 01:46:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF000015C6.mail.protection.outlook.com (10.167.241.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8792.29 via Frontend Transport; Thu, 5 Jun 2025 01:46:23 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 4 Jun
 2025 20:46:19 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 05/31] drm/amdgpu: switch job hw_fence to amdgpu_fence
Date: Wed, 4 Jun 2025 21:45:35 -0400
Message-ID: <20250605014602.5915-6-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250605014602.5915-1-alexander.deucher@amd.com>
References: <20250605014602.5915-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015C6:EE_|DS0PR12MB6607:EE_
X-MS-Office365-Filtering-Correlation-Id: d1190c5c-9627-4621-a513-08dda3d2c760
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?zoDQpDlGm4FjQNsrrQnFXO8BiBXTuOA8wfeGYynmRtQz8tOQuQ54M+uAsW8f?=
 =?us-ascii?Q?is5x+0mXXPVR95VmfH92kN54pLo4qhXakL+UIb2U7EqZcsXNiPU8YNLDpN4z?=
 =?us-ascii?Q?CVndXIJsXkVJTpBF1AINmS0fUnZKt1O8JhpoabJ0teYEhmF+9ZQ8bW7O1C4s?=
 =?us-ascii?Q?DHszEtChPqQt+QBRohy9ler7LzqwD4TMtugs142PCo5RALqV+r6xjISvmJEc?=
 =?us-ascii?Q?e68kNNtVPWW8sQscuH7jQ33sL34TYgbV2utLZ/ywyHgCvm2NCRNUym8/zWwc?=
 =?us-ascii?Q?A8KwMLvfC81aN46Dvqu4H1y4+H2lM5iwGsF5+vZ8wX5KFaLpTcLX6FrBnAkT?=
 =?us-ascii?Q?KjRrNjD6t00hEXEG6vXfJYNwSsIBZvwUABRyaAy0Z7jQxKvaA1gNefcnenL9?=
 =?us-ascii?Q?YPLmit8Lo9x1Ek2YpIqckYFoSkCTzLfaKMcZeXtQatZfg4c26ujfrDdcJNBn?=
 =?us-ascii?Q?nCU1ksxqWJRM6nWrEVssHSIacLY1bcJocmmeAisOYqlEFseQ6PCPA+B9S+zl?=
 =?us-ascii?Q?gr5Pu9U0kxJwM2juQ8wHnrcsusqKnJ5xI0Z8QEe0WGRbeIWWnFxDRVAAQFLg?=
 =?us-ascii?Q?80PXkAEw0wfiylrO/KeqNQzpaKZCoSnkSpULJmpl5eLwNtOFkbM1jp1jDF4O?=
 =?us-ascii?Q?On/9PtK5ta4AAKKeTPAMIi0stiD65wY+tYXL8XpBtqK3JikWTAPQEEm7sEq+?=
 =?us-ascii?Q?IWRoc6nrmM9U+TwNI+GRlTeZdqni1CIcVmLc9aD0lMa5n22GI89em1tWALXs?=
 =?us-ascii?Q?h8OHWqd/UJTk40ZDAFWZTP/TBcPZz9pcMJPnSnS6WtoqmyCalmt0JPL6EQ4Y?=
 =?us-ascii?Q?iKUNjDU1CD35zSoDxhAl9x+z7jfcE7CkHZmTWc+KuiMpRFDBc+YeZQCh4IPn?=
 =?us-ascii?Q?pNwjapm9vnBLIQ2Nwbsal57ymF9eZlpFdPygWMWBac2INeAdv78GqZhCGUa0?=
 =?us-ascii?Q?97q9WoJMMODXcyMl4W7hpgeWfGsoPHWoGUO/X5OQK3uQ+B4NRV0AqS9KjNbL?=
 =?us-ascii?Q?VUYd8I4LXMgXsczmrp2xH+b6Hsfp8NGjPYWhn0DaibgjN5rG+W4Q+0+FkQpL?=
 =?us-ascii?Q?yZeBBPoRJm/7yy4bD4WJy//RaZz/xyx9dN4BfSqeFhWeaH495XxHzypfn1Ue?=
 =?us-ascii?Q?FeGgrfS025Biv2JpF2Hr5vRbDXMifjCghUaaXQ8Fy9uNmi4CsiDbQVuQ5WI8?=
 =?us-ascii?Q?QIpaRPS+UOIfYsqpNBIkk+BPULhrew2CaDax0r37S1p6YJgHnlEMlHpZnhHm?=
 =?us-ascii?Q?mG333l9Owth8eooZ5FqgsPLKtYI5jlozvk52NykB568pJTN2AvUuRhXio9hw?=
 =?us-ascii?Q?SYahHm7ajEjeOuSRaxf+46L11TfgIUmkVYV2DQ49YR5wy9HbNmkbvLN/qQka?=
 =?us-ascii?Q?FBR6uSMOgLVKn+H/wThP6r/CXQaoFfr8BYBqppG5tgHgQ+2SfYMglw2nrQlt?=
 =?us-ascii?Q?uiQeqGuQOWICFCtGo6TJGoeTgc3UUuhDKwjv3y1HCKU+Ez18PABfu+wZMnWg?=
 =?us-ascii?Q?vzSYyLldB9PptK4lyPtujBbT3/ZShiKzu8IV?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2025 01:46:23.9200 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d1190c5c-9627-4621-a513-08dda3d2c760
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF000015C6.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6607
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
index ca882e3d95bb7..b30cec1b6a9a6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -6337,7 +6337,7 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
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

