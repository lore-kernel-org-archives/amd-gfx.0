Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37F60C71136
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Jun 2025 21:48:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D386510EA53;
	Fri, 13 Jun 2025 21:48:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="CsXEHkXv";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2048.outbound.protection.outlook.com [40.107.237.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7950A10EA53
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Jun 2025 21:48:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L4Y2qHV10oyXHEuywQkokNQUSqkMaBWDvKpBW7C6iFXaBXt7dWIDAa2hxLJIufSQLzrfFtXnxeXmFwa4eWBfpEV074ORbPWfJcW22Tq2jI2/PA8yhvyGqSALvJWqy3O8CfGNXrihEwyygn2koD3ni3wZGkaEwAYJN+N6LdF+0/eZVLRC6riiW5u44j8k7jpdn/89DXpBMsM8KQBT4fv1IZfs5quEXPavWK1WsAu+Z7i2NCmW2gWZYhS/ealE+0d/QQAN8XbXX7UoBeFDrjfMViJHMoVt5KSkgEgt8Fm9rtV4Ytk2SoifSa5pGecdXtM0Za5aDHDAXZmU94KruTWnFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U0zkptwXTlVLSl3mqm1HoZkXkSachMAN7dGJCQUUr3M=;
 b=DrX4bTyWBvOL9zx/HoqIJRizDIaQ8pt4nRjnAVgcDrj4YXRSNAm9u5K14UKT8RfN68JKt4i0ltMN0kS3nb9ed2TYFUKZEE1hrELaJc+18OaoDVBqh6fNihjuPK0kRg958u4azCOaA1yvwxVxX7snw5bmAWwyF3epsbGVOnURM0l3QfhltOaoUOlSAHzifLihkbmVUIshl6S6DtmWhvC69VKKlpdE+jsdMYqnf4XEJ2/9AkJwf68cHzd96eqMHmdRtNuVy2LRtkZpn//YPQcK6F/+bbZj/9Ng+tZpn1sLGv8PGRhAyKbRKSeu2UYPh7xHxcUn5F4AtOqNEZOnNzj2+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U0zkptwXTlVLSl3mqm1HoZkXkSachMAN7dGJCQUUr3M=;
 b=CsXEHkXv5LbiL3G5lKRwKUCWLct5Jxr7aypqLFv1+Otj1MBit7iK9adU86C7JyXKhlglWxdnreks1Fc10yXH+qEfaoEFlqi1F/1XHLYq+KZ0y1zTo3BhqGDR/J0cbZweB4BLpE8Gxtmx9HSiWo4fNCkiZXSl6r9ZVgiQIB6l8/s=
Received: from CH5PR04CA0008.namprd04.prod.outlook.com (2603:10b6:610:1f4::25)
 by MW3PR12MB4425.namprd12.prod.outlook.com (2603:10b6:303:5e::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.26; Fri, 13 Jun
 2025 21:48:04 +0000
Received: from CH2PEPF00000146.namprd02.prod.outlook.com
 (2603:10b6:610:1f4::4) by CH5PR04CA0008.outlook.office365.com
 (2603:10b6:610:1f4::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.25 via Frontend Transport; Fri,
 13 Jun 2025 21:48:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF00000146.mail.protection.outlook.com (10.167.244.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8835.15 via Frontend Transport; Fri, 13 Jun 2025 21:48:04 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 13 Jun
 2025 16:48:02 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>,
 <sasundar@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 01/27] drm/amdgpu: switch job hw_fence to amdgpu_fence
Date: Fri, 13 Jun 2025 17:47:22 -0400
Message-ID: <20250613214748.5889-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250613214748.5889-1-alexander.deucher@amd.com>
References: <20250613214748.5889-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000146:EE_|MW3PR12MB4425:EE_
X-MS-Office365-Filtering-Correlation-Id: eeb29e16-eba1-4a3c-5496-08ddaac3fa0b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?BLcNHHF6UpUVv1wsRjnsi55AnijF6QKNg069onSL4h2nvIbUpwygM2aZMzOK?=
 =?us-ascii?Q?nXfHbTGXVH4HyED9AM7Crb5JEXmowTwfHYjKWBikOQLYGULaeu+zvZrwJeKy?=
 =?us-ascii?Q?SrEYoeV3Hlbywjw2oJ8TsI45I3nv1KWWJ3eLAfxoO91hYns/A4pnjoGP3KQ9?=
 =?us-ascii?Q?/tsfBJmNQ8ZtQ/eFDEaR4O+p5807btJakIZhhQRLQZqlhxnNyp7FLayTRIfU?=
 =?us-ascii?Q?SxK9rHEufKmAUz7qJvQ2CDcq3VPQm9QG5XBrY2imiGzQxOTCd+x01iq8QMkn?=
 =?us-ascii?Q?56XNUSYCf4HwD+LTU8BmNbTLjI72hKX8d1ZAcqBi98ZEWaROo1igm/SPd49N?=
 =?us-ascii?Q?p1SDbXMv6MPPOwWJ8Yl52HKHaEM2RQg0sXVCO2swyUz8VJd3TDStKz4T8B8H?=
 =?us-ascii?Q?qkeUsbjnG7wagAFc70ZqwuN9cJCeXFVyIgz9gK9aWBuKi6O82K7l3pJGiwHN?=
 =?us-ascii?Q?54xeGLW0AlKC2yUPIrI7lt47OCIlSO0Qlp2FgHgBvilG8G8sxB1Uu15Z15/d?=
 =?us-ascii?Q?zVuJMO74kFEpx54OC2Z1PWmcSdYXNS86WdwkzXk8mQUC3ly/GlTyKzrPN75W?=
 =?us-ascii?Q?el1NJ14WEgtQtRue4WUbSLy55vshfCRmq6/R6HvMJQqYQvkjYAzovSjocyzk?=
 =?us-ascii?Q?Qtbj3SgJZfjw4PRJaq1JHCnXAaLopT6rJQ2QeAaiVvnuwaTxdTrKE3qhO8xZ?=
 =?us-ascii?Q?Y9iu3SzcYvej85R+qk9VYaAjbOten4jaJQrv28oiAnncReT+EYaPLZm2/TvK?=
 =?us-ascii?Q?Drl+5MFZ+rsvoyEyGDrwgVTMGi7TM5yJ2EAYf016AO4HWOlMQol1uMQ6jT9f?=
 =?us-ascii?Q?XkuBm0Q4yo0ys3gdEq68aWNosioxVnRn/QYwFhARRvU9kTbHKnpawjtpPJ8v?=
 =?us-ascii?Q?QAqJjUFiLObdxTwImlxx01utePQLAG8rxTkJZgMkP4YpHqlCjx3ISfaomN1W?=
 =?us-ascii?Q?xno4qhUt4lwj5+cyRK91MsMxbANOyD0z5YKcMJMPu1aRpFYXa7LZvBVHiVMx?=
 =?us-ascii?Q?unlmUh6xy4vPZt8rVu+lwI7YIRTOhMOE3J0KRCyXQkQVmd9PSNq/8DltS3/Q?=
 =?us-ascii?Q?z7mCV7chVF4VyXbtfzzJoi8MId8cqyPvx8wh7RFeKKlnkUJzz+JCByaY1PXz?=
 =?us-ascii?Q?KzbBzHbhh85ffdMU21s9K/kCrsWgRix2bwhPC6UGMX5cWNmSe4BBhbsOF++9?=
 =?us-ascii?Q?v9rbRt7AvLuT+SD5ldq/A4psFqKGuURunoPRdvkCcnnL4xDs2IQcC7/pJemz?=
 =?us-ascii?Q?pCnhpVDJaweNurcj8abMdOrFjYaM5kh3/frSj0qRHEdKOmTQCbcjU666FPvY?=
 =?us-ascii?Q?4kC+HRWZpXH+WAHiEvOrnKan5o1siYabuv4OR5QrRhJEk5dh/tk27ZRURphV?=
 =?us-ascii?Q?obrq77LjOIvWK1FCDLICfKaflTyZ/8zWsSb3IBmCzt51HhcJJYTXx3x1G03n?=
 =?us-ascii?Q?e8QvyASIxePC46APFcTTmMBJGPhlu1i3DdgABPBtYDYua0uGdYHqEDSJR95R?=
 =?us-ascii?Q?Q2sp/vUxXgpaTl/KmCbl9+xioTdVLRwRy1jM?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2025 21:48:04.6305 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eeb29e16-eba1-4a3c-5496-08ddaac3fa0b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF00000146.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4425
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
data in the fence.  This also fixes the start_time handling
for MCBP since we were casting the fence to an amdgpu_fence
and it wasn't.

Fixes: 3f4c175d62d8 ("drm/amdgpu: MCBP based on DRM scheduler (v9)")
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
index 00174437b01ec..4893f834f4fd4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -6397,7 +6397,7 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
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

