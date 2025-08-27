Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEA21CA0EFF
	for <amd-gfx@archiver.kernel.org>; Wed, 27 Aug 2025 16:03:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8CAAE10E831;
	Wed, 27 Aug 2025 16:03:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="shJavJY8";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2044.outbound.protection.outlook.com [40.107.223.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3F4B610E831
 for <amd-gfx@lists.freedesktop.org>; Wed, 27 Aug 2025 16:03:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X1uLlJRzEoFGWPybdsRSuVkGlZs6A/cyhQQOhPyGhUc9xor+JJ2wavefN5M/pAJiOIhVYDnSMk7IBlfFuqrmrbg0J414ALBeF2BnWBDHSWahu/KEOhnZyd1ly1hGpnIV8O8AjEdQqqZdik0Ie4bfZHJxF9RkXxSnfq98pJ+tJwn3hCMJg6/Lj0ar4aotFu/zKryB1roALIkFhUyK09v0IeyPvukTH6iFXq95VjtPg9cNIzuNowZLano0KoI22UR7CX53Ss4MeEUSPCW0Db0/tyVbzVS6V9QtZ/BdfJH3azVVT4nfUb0QtFrSGxkQ5FbIAdscLyzn6Pew2rnMo91yHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uOTE11Z1q1vp5KyUmI49Q9fstjLgg9KkPNOXijVrzsg=;
 b=TcZuG5+blMqw25ugtcljUqJN9qwBgmc41mEDDmXFBN8TuSgiErahHd+ZwFpETVSWYEgSBOHn64ZxQvw/a2P9Nly5ww6oGZojMTG/+Ki4mXoFk6XbF+K/YCEZ18/QcZWzyK4aF0IcvZ7rSARc7Y4Ael4eYo02a/zbrJINaqB0d+YANxS5kFvQxhXtj/0ovSskRVPhryokrXDjHP4+7DsKzTiPDfhfilz1AniW5jPn7uTwrS4WS0ejzYYGr+qdnsfblFarkybG8TsAzc35MKm/7BKDVi0egnT7pZSTXKFcBd+yIifGC51nYKRsDSTTY6AYn4ILrriNLtGxnkKAgVuvkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uOTE11Z1q1vp5KyUmI49Q9fstjLgg9KkPNOXijVrzsg=;
 b=shJavJY8lr7TB8r+f1wsUmBOc/EpyjrwRueCJ4pQXtm0kXz1v8DcTjFviK+XN6mASBV/xWfZwKQg6TtP/3cXwA4bJpOWBdB4tMM1SKj0ltG44NcPU1zl+fatTowu0IAyWuBgdnAl+rAKq7x5Sr/GZK7MRLm7vQ2OlJFW3eWHia4=
Received: from SA1P222CA0002.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:22c::9)
 by SN7PR12MB7833.namprd12.prod.outlook.com (2603:10b6:806:344::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.13; Wed, 27 Aug
 2025 16:03:39 +0000
Received: from SA2PEPF00001507.namprd04.prod.outlook.com
 (2603:10b6:806:22c:cafe::46) by SA1P222CA0002.outlook.office365.com
 (2603:10b6:806:22c::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.21 via Frontend Transport; Wed,
 27 Aug 2025 16:03:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00001507.mail.protection.outlook.com (10.167.242.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9073.11 via Frontend Transport; Wed, 27 Aug 2025 16:03:38 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 27 Aug
 2025 11:03:37 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>, <David.Wu3@amd.com>,
 <christian.koenig@amd.com>
Subject: [PATCH] drm/amdgpu: clean up and unify hw fence handling
Date: Wed, 27 Aug 2025 12:03:23 -0400
Message-ID: <20250827160323.5913-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00001507:EE_|SN7PR12MB7833:EE_
X-MS-Office365-Filtering-Correlation-Id: fe124010-3500-4f26-b41f-08dde583492b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?D2rKNwOBxI8ONw9xdZVvx7/wkHM2HK/Raqx11kcWKSDwYly0PuUisyf1w/GX?=
 =?us-ascii?Q?hc7F1WYY6mOrN//NIxNhKjqHLL+C2ZCvHqCVsIby6fSsw3nVF9i+I3+HFqvt?=
 =?us-ascii?Q?9rMoSRkhhIZoJ14rTqHWjkiDOedBzijc4Ov0S0xgaABW6A2XxjhkTAfY6DX1?=
 =?us-ascii?Q?idcQXBcC5Wg93RehcpWxIaQjmP6AvKji6/Yofp+1caaaQQojp36mO2iuijNd?=
 =?us-ascii?Q?bhQ5LG/247iV3CeYNJKE7SpjCMjKnyfPSspx9ZpQeQUSb2BR6Sz+0AO0QzZx?=
 =?us-ascii?Q?Y6Oqn3INc2+UFSAyTThgv22p6fw7uGggf+F00kze56LTrrybpEDCLuWQAQ08?=
 =?us-ascii?Q?IjuNrmRSWOYuZ0mr8eHW0k8BcVkCaZ57/Tq+DQl5FbDOF5VwmcaZS5POsh0c?=
 =?us-ascii?Q?8nqctxKNZDhA1NX2q0sS8kxm5/ksUO8q0P6ifdmG22GEkNUoMHZkUhdq+tTj?=
 =?us-ascii?Q?UUlIORMq/uQ9K1/nCkT+8NVemqUbwlWk3XPJ2s8ZfAiGQ59lwN1qdmt5eQHP?=
 =?us-ascii?Q?GCElIwWNQe6GjzeznXOYdRTE0ZOCwZTEyo4fiFZ2qMD3SBxgBGeve0wjo+jv?=
 =?us-ascii?Q?/Hkxte9msOH7GBgDzaf8O3Vrao/4gzxcExZ/I7C/pKqxsSyhXilPLxmWDMfe?=
 =?us-ascii?Q?Ps1fiJ9+/dlCYD7iOux/3854r6euVvMuTN+WvBCHE6KIWaI9bVpxK/Gwbt16?=
 =?us-ascii?Q?osgHrknXUphUwef4Oh2q+6xbqlrRnZdQjbcspHJML86UKDxus6qbotd3sXL1?=
 =?us-ascii?Q?dPdU8zIYr9VebSOWFFznyjltQ8Uxm5nv44r0LdhSQpS4LxWpvYI+CzEH3Vcf?=
 =?us-ascii?Q?vUDeBSjAPZX73vDtynAayF6+tLNh1UakYPzkKj/PKe+AWvbBILQKDhGy0vHd?=
 =?us-ascii?Q?/QNB06qqKlMcgpzES2dPIPjH6uIDHM3w7doUR9m7Eipt82weIyzNSOxrixBe?=
 =?us-ascii?Q?vlGEcUqulo9W/EWqU7Wr9wDkiKC83lxPWBBS9iSwGsq31QnA/GY26dsmhCn/?=
 =?us-ascii?Q?rjJV14VsNKLkay1sWonH6JcFjEM+kNAYbw3Ex9BATdipJJGIEoYSWU4KnvyN?=
 =?us-ascii?Q?S/45cUNSPTj/XgVYsGXXzdY+CtY9JruiqIgKkL3gIP6orHXHf5pt7RipDpDZ?=
 =?us-ascii?Q?IXzgAdkADM+/4ddsBSD/QjSx2P67xobdjJXzk8kzAT1IhdW9t4pLoYm6RM2y?=
 =?us-ascii?Q?3vwtg6hnmyiAg8w+LzEqEtBVyr1HUIfT4v55EEYjSBB8P49X07pYQb5UA0om?=
 =?us-ascii?Q?4AeGfOZa/9nKhOQ6rEQ5AqZD6dAD10Ki4N/H/hrxgcF92/a4R62P60qBQQN/?=
 =?us-ascii?Q?gr11jXpcxHiwYWpbEqXoS3cJTqpueovc/p3V8sX+p5DmpcX1V1ljTxQUFqA5?=
 =?us-ascii?Q?kwxMdEtuwRgvi1rrvoRP/rbJgjBrvVU3GOV4hExzMg0/daNMbMyCwP1ytvTL?=
 =?us-ascii?Q?S3pCiPfvNdxFT+owiMlAjIaYFqncLTHqtBjTWbBEPRNxJfNfnzznC11AYgxy?=
 =?us-ascii?Q?w1s2va2CD8nn3BQx2SS+KeCaB6+wfZQDRu3k?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2025 16:03:38.6882 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fe124010-3500-4f26-b41f-08dde583492b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00001507.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7833
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
 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c  |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c   | 111 +++-----------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c      |  12 ++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.c     |  36 ++++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.h     |   3 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h    |   3 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c      |   6 +-
 8 files changed, 58 insertions(+), 117 deletions(-)

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
index e117494e80547..efd86f095323a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -6494,7 +6494,7 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
 	 *
 	 * job->base holds a reference to parent fence
 	 */
-	if (job && dma_fence_is_signaled(&job->hw_fence.base)) {
+	if (job && dma_fence_is_signaled(&job->hw_fence->base)) {
 		job_signaled = true;
 		dev_info(adev->dev, "Guilty job already signaled, skipping HW reset");
 		goto skip_hw_reset;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
index 2d58aefbd68a7..0afe2427c25cc 100644
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
@@ -110,35 +105,18 @@ int amdgpu_fence_emit(struct amdgpu_ring *ring, struct dma_fence **f,
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
@@ -683,18 +661,22 @@ void amdgpu_fence_driver_clear_job_fences(struct amdgpu_ring *ring)
 	for (i = 0; i <= ring->fence_drv.num_fences_mask; i++) {
 		ptr = &ring->fence_drv.fences[i];
 		old = rcu_dereference_protected(*ptr, 1);
-		if (old && old->ops == &amdgpu_job_fence_ops) {
+		if (old) {
+			struct amdgpu_fence *af;
 			struct amdgpu_job *job;
 
 			/* For non-scheduler bad job, i.e. failed ib test, we need to signal
 			 * it right here or we won't be able to track them in fence_drv
 			 * and they will remain unsignaled during sa_bo free.
 			 */
-			job = container_of(old, struct amdgpu_job, hw_fence.base);
-			if (!job->base.s_fence && !dma_fence_is_signaled(old))
-				dma_fence_signal(old);
-			RCU_INIT_POINTER(*ptr, NULL);
-			dma_fence_put(old);
+			af = container_of(old, struct amdgpu_fence, base);
+			job = af->job;
+			if (job) {
+				if (!job->base.s_fence && !dma_fence_is_signaled(old))
+					dma_fence_signal(old);
+				RCU_INIT_POINTER(*ptr, NULL);
+				dma_fence_put(old);
+			}
 		}
 	}
 }
@@ -830,13 +812,6 @@ static const char *amdgpu_fence_get_timeline_name(struct dma_fence *f)
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
@@ -853,23 +828,6 @@ static bool amdgpu_fence_enable_signaling(struct dma_fence *f)
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
@@ -885,21 +843,6 @@ static void amdgpu_fence_free(struct rcu_head *rcu)
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
@@ -913,19 +856,6 @@ static void amdgpu_fence_release(struct dma_fence *f)
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
@@ -933,13 +863,6 @@ static const struct dma_fence_ops amdgpu_fence_ops = {
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
index 7d9bcb72e8dd3..192ed1bd2ec63 100644
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
@@ -154,12 +154,15 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned int num_ibs,
 		csa_va = job->csa_va;
 		gds_va = job->gds_va;
 		init_shadow = job->init_shadow;
-		af = &job->hw_fence;
+		af = job->hw_fence;
 		/* Save the context of the job for reset handling.
 		 * The driver needs this so it can skip the ring
 		 * contents for guilty contexts.
 		 */
 		af->context = job->base.s_fence ? job->base.s_fence->finished.context : 0;
+		vm_af = job->hw_vm_fence;
+		/* the vm fence is also part of the job's context */
+		vm_af->context = job->base.s_fence ? job->base.s_fence->finished.context : 0;
 	} else {
 		vm = NULL;
 		fence_ctx = 0;
@@ -167,7 +170,10 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned int num_ibs,
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
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
index 311e97c96c4e0..4189a2b8cb674 100644
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
@@ -185,6 +185,8 @@ int amdgpu_job_alloc(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 		     struct drm_sched_entity *entity, void *owner,
 		     unsigned int num_ibs, struct amdgpu_job **job)
 {
+	struct amdgpu_fence *af;
+
 	if (num_ibs == 0)
 		return -EINVAL;
 
@@ -192,6 +194,23 @@ int amdgpu_job_alloc(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 	if (!*job)
 		return -ENOMEM;
 
+	af = kzalloc(sizeof(struct amdgpu_fence), GFP_KERNEL);
+	if (!af) {
+		kfree(*job);
+		return -ENOMEM;
+	}
+	/* assign the job so we can clean up in amdgpu_fence_driver_clear_job_fences() */
+	af->job = *job;
+	(*job)->hw_fence = af;
+
+	af = kzalloc(sizeof(struct amdgpu_fence), GFP_KERNEL);
+	if (!af) {
+		kfree((*job)->hw_fence);
+		kfree(*job);
+		return -ENOMEM;
+	}
+	(*job)->hw_vm_fence = af;
+
 	(*job)->vm = vm;
 
 	amdgpu_sync_create(&(*job)->explicit_sync);
@@ -251,8 +270,8 @@ void amdgpu_job_free_resources(struct amdgpu_job *job)
 	/* Check if any fences where initialized */
 	if (job->base.s_fence && job->base.s_fence->finished.ops)
 		f = &job->base.s_fence->finished;
-	else if (job->hw_fence.base.ops)
-		f = &job->hw_fence.base;
+	else if (job->hw_fence)
+		f = &job->hw_fence->base;
 	else
 		f = NULL;
 
@@ -268,11 +287,7 @@ static void amdgpu_job_free_cb(struct drm_sched_job *s_job)
 
 	amdgpu_sync_free(&job->explicit_sync);
 
-	/* only put the hw fence if has embedded fence */
-	if (!job->hw_fence.base.ops)
-		kfree(job);
-	else
-		dma_fence_put(&job->hw_fence.base);
+	kfree(job);
 }
 
 void amdgpu_job_set_gang_leader(struct amdgpu_job *job,
@@ -301,10 +316,7 @@ void amdgpu_job_free(struct amdgpu_job *job)
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
index 7670f5d82b9e4..ceadd7e4bdb58 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
@@ -143,6 +143,9 @@ struct amdgpu_fence {
 	struct amdgpu_ring		*ring;
 	ktime_t				start_timestamp;
 
+	/* store the job for cleanup */
+	struct amdgpu_job *job;
+
 	/* wptr for the fence for resets */
 	u64				wptr;
 	/* fence context for resets */
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index bf42246a3db2f..a287718506aa6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -772,7 +772,6 @@ int amdgpu_vm_flush(struct amdgpu_ring *ring, struct amdgpu_job *job,
 	bool cleaner_shader_needed = false;
 	bool pasid_mapping_needed = false;
 	struct dma_fence *fence = NULL;
-	struct amdgpu_fence *af;
 	unsigned int patch;
 	int r;
 
@@ -835,12 +834,9 @@ int amdgpu_vm_flush(struct amdgpu_ring *ring, struct amdgpu_job *job,
 	}
 
 	if (vm_flush_needed || pasid_mapping_needed || cleaner_shader_needed) {
-		r = amdgpu_fence_emit(ring, &fence, NULL, 0);
+		r = amdgpu_fence_emit(ring, &fence, job->hw_vm_fence, 0);
 		if (r)
 			return r;
-		/* this is part of the job's context */
-		af = container_of(fence, struct amdgpu_fence, base);
-		af->context = job->base.s_fence ? job->base.s_fence->finished.context : 0;
 	}
 
 	if (vm_flush_needed) {
-- 
2.51.0

