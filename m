Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FC88C71155
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Jun 2025 03:08:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4213F10E47E;
	Tue, 17 Jun 2025 03:08:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="eXIHhpql";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2046.outbound.protection.outlook.com [40.107.236.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 14F8910E3D8
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Jun 2025 03:08:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VxxIusW3D+NQEpbxKGCG6sCb692aoUH64XB0jfCs73mEcmE6j53llPjsJaUU8vpQfBiWJEqL1w9QiJQLcOxpYpzdGq3wo65S3WO+BsXfA0AK6iuH9cbeaQu8jLhV09vfvDPie0ttDqYBk0l0Gv48i9KlPcVRuBlsvdbh5rRlS866mV1+5EYF8nBhypH/o/NPFdVCATU03AbD5I45NH4VO3RJVSbsM6gEqXkP642tZZ2NcMDevZsE0nGK2IvdNU/TkGtS9IkgYTbRqW/NXAwxxGAvVgNY7x5pEQEJdvVL9Sy1c1Oz4esqicGaVneYzoSljS7yBstVHJmCcW3iXtVmHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9aEvO8J0YepYj5fqY3SoFEfGEYDXYyWlp++e80aXJQU=;
 b=gHchSGxurdWL43XMeFysan7Bfe3TPlMO4pcAeklRdRRpuvKhgvaRJnsqAGToCgrMbp+WFHqWkP0dlMBql1jLZ0YZO1Q25QMJI4IxdNV9Hr7Y3BpsXLWa7dVezPzrT6DpvJ7su6KNstB8e0ljcMCAv8rhSDiVGzfkY3mjCdfwxWcWUYiTrI/wosnY8Fg/ljdOOc7iFO3bPuevHxsMVkHc5gui2VFwRbkjeWIQGaGnP1OGao37as7RnTGGeE2mbeM2I1Rh7fsFX2VnrSP5vCfxMlf48T1k4fe/tGIgNzA1fEsd71gNhWmfG5OXaepO1GR/usYjwO+nuA/WPO7nhh1B/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9aEvO8J0YepYj5fqY3SoFEfGEYDXYyWlp++e80aXJQU=;
 b=eXIHhpqlMcsGxVW/ILgixGb0PXU491xgMXAA++tIXPsTLtJMzQrqGe/7g/vkIvx0I3UJMR98VOCrLWGnJWpvtZN2W90ENUYHU9jJg3Eij87py5PpWBpc1i3rNP/fHx3zCdyNqF4AhgzYma1unabFHmNN0K7B77iBpnFe89qwXwI=
Received: from MW4PR03CA0014.namprd03.prod.outlook.com (2603:10b6:303:8f::19)
 by CY3PR12MB9555.namprd12.prod.outlook.com (2603:10b6:930:10a::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.28; Tue, 17 Jun
 2025 03:08:32 +0000
Received: from SJ1PEPF00002324.namprd03.prod.outlook.com
 (2603:10b6:303:8f:cafe::13) by MW4PR03CA0014.outlook.office365.com
 (2603:10b6:303:8f::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.19 via Frontend Transport; Tue,
 17 Jun 2025 03:08:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00002324.mail.protection.outlook.com (10.167.242.87) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8835.15 via Frontend Transport; Tue, 17 Jun 2025 03:08:31 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 16 Jun
 2025 22:08:29 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>,
 <sasundar@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 01/36] drm/amdgpu: switch job hw_fence to amdgpu_fence
Date: Mon, 16 Jun 2025 23:07:40 -0400
Message-ID: <20250617030815.5785-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250617030815.5785-1-alexander.deucher@amd.com>
References: <20250617030815.5785-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002324:EE_|CY3PR12MB9555:EE_
X-MS-Office365-Filtering-Correlation-Id: b1b8ffbc-e5ea-44ed-2db6-08ddad4c3d8f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?gDoLaeaZ02WiweEfzR4NRhH14dvUv/ZSbmw/QuCoCg+X/EIK+9qnmNqGjMQM?=
 =?us-ascii?Q?LE/la2ZJCnuWzKOY8U2ymHqr4OWKAevHco7kyz7wDEyzbZJ2B/Bc4aeERs4H?=
 =?us-ascii?Q?usQ9tapNszQoR2TuTLMwGLX8FfDjFgZlRbAEbTl94PYxQ+ewyrIw4dD7pd+O?=
 =?us-ascii?Q?ramk0L4lJaNrQteUtl+/Shg4mDxkLkj0MExxaHKTvIqdg7JxYnIcmQsAk/jN?=
 =?us-ascii?Q?PKEZCGbewKhwQK44R6N8Gd/O02/hR9zYzOQE8lkb3RShUHTIWYMX80wRFOay?=
 =?us-ascii?Q?cTjUeOCAyQX0OeLzL06QwcyhRBOX3XPVZsXXykb9+iYppYINt7++vag+fW9p?=
 =?us-ascii?Q?I5i1n6ryNccqshKV3YtEGNEGPIQlXhD8Z7BN46jzb2GLlAUbOLk2NsueL1iK?=
 =?us-ascii?Q?ZKfufZTh5GMADu9lgxtAEzCij/nIq8ie9l9A41TYqvyN9hfRbkiYOgNSxyZe?=
 =?us-ascii?Q?ZWiupmWctFc/cjwoW/QMA66Rob5x57WI9Xdza9MmKw3GGPGpGpCCtdKikqxP?=
 =?us-ascii?Q?/YBRwhmfP/LCjVjQTQro6lK8cbU+XlQ0T0jfMQa9/P5rQAxCNwqxZEIhpBzA?=
 =?us-ascii?Q?3CBX/6FEuf2jXj54gr2avhlpMtnu1G2QSMKZemWheBokXDVSairLuOXgUv/0?=
 =?us-ascii?Q?9whcnYHrgcFXlDbu/QTKrGaFX8CoOfbhlKu1AdYlatsrcTqvZdvHvW26Mn7e?=
 =?us-ascii?Q?D0q+02O+eairxtfM4somJk9yYf41VIO83wCR9bNQS9KD3/eVl/yNYmBUAhEZ?=
 =?us-ascii?Q?xRYw5fOMuybw0j6sQQukjnDK+PIah6iwo0qqAEib85GF3xqo5dKE3H0pO6gS?=
 =?us-ascii?Q?v6aRyhlpf9aHOXDKXhNhinlUMGFWZnb5wyFaOt2Aj1CpP7ov5A0S4tpijmWi?=
 =?us-ascii?Q?JORHa0sZaMBePI+OB6OiiOEmA6sQTTCPz0TrH9komZbzqf6dlNPrI5+8CiJq?=
 =?us-ascii?Q?fX5ZfDO0mkhMPzo3OQsOJdvjU/Bqqfqpo7mi59kcm5Vn5BTTOo2/qqGEowaz?=
 =?us-ascii?Q?og9jH80ModGaVRqzTl8aEPWTevaklWheGN7nTOM70h77nVtNddyXzYmCJ1Jr?=
 =?us-ascii?Q?S+wCY4/T2MNkIyAxnsn0yXpTIUJBQHA9//f0m1zMxKARFiJfyZ76berhtrL3?=
 =?us-ascii?Q?YsWeEDbPvp7C26p5QxejRS6qR3yN/0sIQA/Hgber+6zcxRA1dOAsJBdM7umT?=
 =?us-ascii?Q?9AmiVAdTGPomsrXIeaVKqR9MmjJp7w4IJkLS9agZnFGa7cFSq30b52BTZAaT?=
 =?us-ascii?Q?hUJB5ELeeiFN+FwVgLSWzNTC7mzrhBYlp9TzgM2sRi8VgZUR9IW+KPbbTaPV?=
 =?us-ascii?Q?YLSZrlTmVXiNVsdU5MXGNTSwtQrhHGggKOLEptcEwrglhWc7Tfjx8X80ChsM?=
 =?us-ascii?Q?cWak0SOSPcp/yaS2/1awdO8zOcPi/GZxkfCnD7FXYaXOkfJjNSWMTNbpjIuw?=
 =?us-ascii?Q?/aRk6klNAGQ7NXkfOTnh40k2WaMbXQkJWsJ/yn6kcJsnmdM6h8RQCd3vtlxW?=
 =?us-ascii?Q?+7HYKevq5/oVPI2CYhciSlXN0HfGCKDJSCFz?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2025 03:08:31.7047 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b1b8ffbc-e5ea-44ed-2db6-08ddad4c3d8f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002324.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY3PR12MB9555
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
index f134394047603..13070211dc69c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -6427,7 +6427,7 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
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

