Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 783EAC7115D
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Jun 2025 03:08:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 32E8910E484;
	Tue, 17 Jun 2025 03:08:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="dfv7fJsF";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2061.outbound.protection.outlook.com [40.107.223.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 70ACF10E482
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Jun 2025 03:08:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UgS6uNegk7gnXSwSZYlL0Nm1eilwhpCJqOdLm5V/tFoRMJfV2T/5ois5N8cBT2kR1FEY4aUjQtwHnI2FcxwKo0YJThCTvctXTj9Q6zd3NABBJq/7I6PkDkafk/uK/PE1bW5keG7VVckxSwXn7iKl09o5sgtahOQOjO/80w1kCF0zy5NvrdE7O9UikpGnMOHEY62KUyVAqYKWKVNfhR7H/JXewzQ6FYkSeplv2RQIKc7nEZQiBvMAyPc3NEEw0iEcJdybtUCd+78N2LkxuEfVI27mcL3kfu4wdNSBh283SCMfpHfA20OeVJpOnJ67X0EKHpfBEtr5A+sgdnq/PLbm2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QHhcbo9IdssWZf3JT94VvvOKx+08odnXzCZxWpR4waw=;
 b=awxiof/7htqy8144qtQDGbWLYPt1Jsgq2lyPodxdNWL+8NitqfX9zVvzDh8akcGOa2Fp3FfS4/xXsxYxRsm4IbbN2BTcBn2W085PsqEfQPr8QvNG9xKBm5xdz+rDpp/jySleVAEPS7I7x5yt2rjD5BJyAMcHz48IiMkgq3cF9zshrQ+0ykZ0uY0l9Ens7zPoauuGzciH1ciEvtOqJ2XV20G8qlO5epl5z0X4CbcTXvHQxFQ7NWMoPu0gpMW37oAbMR9mpIOZN/nlZ9/BSQpY+DBkC/pjANWKYTbsFsLIp3x+mTFNFe6n/DhwIM7zaQKpT1l0lK/ExWyFQUlR89VWhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QHhcbo9IdssWZf3JT94VvvOKx+08odnXzCZxWpR4waw=;
 b=dfv7fJsFBYRw/HUNJ54Bwd3yHhWvXUWliSgWYThTAdfWLaHrACxAj19+QaJ0bxys4DzBvdDSvGXXdT1hivwpRrt5mqnuqeJoKenbt7EH3Edsg59cE8lEote+xUMF+/erzYwfv0R8czm1Kvz0yZG6C5+aelbUhGS+RGa5xXwDTUQ=
Received: from MW4PR03CA0164.namprd03.prod.outlook.com (2603:10b6:303:8d::19)
 by IA0PR12MB8280.namprd12.prod.outlook.com (2603:10b6:208:3df::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.28; Tue, 17 Jun
 2025 03:08:42 +0000
Received: from SJ1PEPF00002327.namprd03.prod.outlook.com
 (2603:10b6:303:8d:cafe::f5) by MW4PR03CA0164.outlook.office365.com
 (2603:10b6:303:8d::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.23 via Frontend Transport; Tue,
 17 Jun 2025 03:08:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00002327.mail.protection.outlook.com (10.167.242.90) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8835.15 via Frontend Transport; Tue, 17 Jun 2025 03:08:41 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 16 Jun
 2025 22:08:36 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>,
 <sasundar@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 11/36] drm/amdgpu: move guilty handling into ring resets
Date: Mon, 16 Jun 2025 23:07:50 -0400
Message-ID: <20250617030815.5785-12-alexander.deucher@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002327:EE_|IA0PR12MB8280:EE_
X-MS-Office365-Filtering-Correlation-Id: eb6e8ecf-4c98-42b6-2600-08ddad4c4366
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?MiEkpTn/LWQgChYTUP8WBNirUYa0wQbqg2zRbC1uPJD1ie7QVZ2xl7zysFcA?=
 =?us-ascii?Q?XPs7AcxvX4hVQ/u1yciRJqiPvGILw5rjDavWOITY1hIatw3K6BJoESCfZQxY?=
 =?us-ascii?Q?N7vcdxaBvWO0ScyMCBUe3IyVWYvxhIlguJI4Ui08AKHPTH0blmaZBzkvfsOI?=
 =?us-ascii?Q?Ufe7wrgWMZ1gCT2XpK/yC14xcNhq8XbAZnKIMO39Y/AOb3K4iFFjuSaNbCSc?=
 =?us-ascii?Q?QlxwyHCbvNyL9iQ/2jixpz11M3QSO5sxFD2DxOlT0Anz+3meF8KdFRYm4p60?=
 =?us-ascii?Q?dN/IZ8AEHm9gi//LzFHyE6qB7jNPBf64/vprJZl/DpL67evdSuKV2iuDtF3a?=
 =?us-ascii?Q?51xJdeJy3ktnQsKSyRVdMs1MfZPTP6N9LYfEknKxIBKKEV/01QJiOzJWBJmO?=
 =?us-ascii?Q?llaOLplEAS/qmHWUTJ/nq9r66KXUNRJ+RLE9L6JLQ+P/zOri8Y1uZZ41gEmw?=
 =?us-ascii?Q?QrTwZArC0sc1/MuwjNKL+InsOqmkg2qJhMdjEdVp8bECwBPih09LlLuIepsT?=
 =?us-ascii?Q?B0tvX/QsXSzmkx050diV1NMdFoRqPuPos+AZadZ6bEHvfXh7e6Al9Hlv+aJf?=
 =?us-ascii?Q?lZgPSMXxHEPGU94kRWFJqdHnpNmICMIspS7509afrXGmNuIaT3126KiKEU6K?=
 =?us-ascii?Q?oVL7XkwnY+lMHH07+N4Pf8GK1w/LRVxTs4vtn+0Ed+KJGiuU2LAchYiT+F2F?=
 =?us-ascii?Q?+uNs651JkdQSTdndfTpb7BFE5966RtUJpiIcKnSxa4vwOskZvXf7Zozeu4cl?=
 =?us-ascii?Q?YADVTanYP5i0aB2RRcYHujQeIfxAdm7GbPAmajOyWZgq2k5eIXsQnbfcEjOH?=
 =?us-ascii?Q?9gvbtRDrAX0MLZvGab62fVJH5N5prjlB1IqStBqxa4fGWcxNNEABN0XbFxxp?=
 =?us-ascii?Q?ZWV1rhqWyapiDdWVZqRbHEF8IzRDPFQjSriKVtTWRgJwF/DVgNHxFjmnpQz0?=
 =?us-ascii?Q?vfI+nL8o6DOdpFXeCZfR9cO6+DCONYzs7WWIOgNC+T0+n+MIzPbg4jbbAZc9?=
 =?us-ascii?Q?gUMzBHrZbVkZUMt5DXZ74v2oipSZ6ISJhvAFaPt1MfYrqOP10hkYpFMWOHv4?=
 =?us-ascii?Q?lFlM+aD3FoCPCBCiue0RqTlMMa91PizH/6WsnG5duuOS0tqLVh00EAlmjHVC?=
 =?us-ascii?Q?GoH46dEp/zBcaNuqGBsO7PFLilNDEP1A/q7VejV9JU8xOweUqUARZ10Ee1nC?=
 =?us-ascii?Q?TaOQTTs48C2eTzkv6EzNyllloZM/X0XXEaAdbeHrUEK0qZaMjYTbZDw11ThP?=
 =?us-ascii?Q?6Hm2Ah0LHehwj8ecPf39vAtDkPMGdiDGNBY+TJZge0aZZRtZtKOZpyuOwxXv?=
 =?us-ascii?Q?ZLzj52DPiKQnZAW91jKlffeTfi3I78Vl4gUFn6Zz82daZN87L04XF3bsqB6/?=
 =?us-ascii?Q?CTR+5nxPfB04SkwpyzVuFlqjXD5o5fL0f602ZeonNQGeQeN1lForMcs6vUVg?=
 =?us-ascii?Q?gW+eh7Ov2yprNKc6oT7gin/dP6dxtBYutQ5IT4IzETtb1lcwzR+FY0k/Y5Js?=
 =?us-ascii?Q?gahc/x02xkul3OT6eHFM0F5/1crIjHyltnWD?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2025 03:08:41.5020 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eb6e8ecf-4c98-42b6-2600-08ddad4c4366
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002327.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8280
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

Move guilty logic into the ring reset callbacks.  This
allows each ring reset callback to better handle fence
errors and force completions in line with the reset
behavior for each IP.  It also allows us to remove
the ring guilty callback since that logic now lives
in the reset callback.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.c  | 23 ++----------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h |  1 -
 drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c | 30 +-----------------------
 3 files changed, 3 insertions(+), 51 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
index 177f04491a11b..3b7d3844a74bc 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
@@ -91,7 +91,6 @@ static enum drm_gpu_sched_stat amdgpu_job_timedout(struct drm_sched_job *s_job)
 	struct amdgpu_job *job = to_amdgpu_job(s_job);
 	struct amdgpu_task_info *ti;
 	struct amdgpu_device *adev = ring->adev;
-	bool set_error = false;
 	int idx, r;
 
 	if (!drm_dev_enter(adev_to_drm(adev), &idx)) {
@@ -134,8 +133,6 @@ static enum drm_gpu_sched_stat amdgpu_job_timedout(struct drm_sched_job *s_job)
 	if (unlikely(adev->debug_disable_gpu_ring_reset)) {
 		dev_err(adev->dev, "Ring reset disabled by debug mask\n");
 	} else if (amdgpu_gpu_recovery && ring->funcs->reset) {
-		bool is_guilty;
-
 		dev_err(adev->dev, "Starting %s ring reset\n",
 			s_job->sched->name);
 
@@ -145,24 +142,9 @@ static enum drm_gpu_sched_stat amdgpu_job_timedout(struct drm_sched_job *s_job)
 		 */
 		drm_sched_wqueue_stop(&ring->sched);
 
-		/* for engine resets, we need to reset the engine,
-		 * but individual queues may be unaffected.
-		 * check here to make sure the accounting is correct.
-		 */
-		if (ring->funcs->is_guilty)
-			is_guilty = ring->funcs->is_guilty(ring);
-		else
-			is_guilty = true;
-
-		if (is_guilty) {
-			dma_fence_set_error(&s_job->s_fence->finished, -ETIME);
-			set_error = true;
-		}
-
 		r = amdgpu_ring_reset(ring, job->vmid, NULL);
 		if (!r) {
-			if (is_guilty)
-				atomic_inc(&ring->adev->gpu_reset_counter);
+			atomic_inc(&ring->adev->gpu_reset_counter);
 			drm_sched_wqueue_start(&ring->sched);
 			dev_err(adev->dev, "Ring %s reset succeeded\n",
 				ring->sched.name);
@@ -173,8 +155,7 @@ static enum drm_gpu_sched_stat amdgpu_job_timedout(struct drm_sched_job *s_job)
 		dev_err(adev->dev, "Ring %s reset failed\n", ring->sched.name);
 	}
 
-	if (!set_error)
-		dma_fence_set_error(&s_job->s_fence->finished, -ETIME);
+	dma_fence_set_error(&s_job->s_fence->finished, -ETIME);
 
 	if (amdgpu_device_should_recover_gpu(ring->adev)) {
 		struct amdgpu_reset_context reset_context;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
index fc36b86c6dcf8..6aaa9d0c1f25c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
@@ -271,7 +271,6 @@ struct amdgpu_ring_funcs {
 	int (*reset)(struct amdgpu_ring *ring, unsigned int vmid,
 		     struct amdgpu_fence *guilty_fence);
 	void (*emit_cleaner_shader)(struct amdgpu_ring *ring);
-	bool (*is_guilty)(struct amdgpu_ring *ring);
 };
 
 /**
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
index d3cb4dbae790b..61274579b3452 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
@@ -1655,30 +1655,10 @@ static bool sdma_v4_4_2_is_queue_selected(struct amdgpu_device *adev, uint32_t i
 	return (context_status & SDMA_GFX_CONTEXT_STATUS__SELECTED_MASK) != 0;
 }
 
-static bool sdma_v4_4_2_ring_is_guilty(struct amdgpu_ring *ring)
-{
-	struct amdgpu_device *adev = ring->adev;
-	uint32_t instance_id = ring->me;
-
-	return sdma_v4_4_2_is_queue_selected(adev, instance_id, false);
-}
-
-static bool sdma_v4_4_2_page_ring_is_guilty(struct amdgpu_ring *ring)
-{
-	struct amdgpu_device *adev = ring->adev;
-	uint32_t instance_id = ring->me;
-
-	if (!adev->sdma.has_page_queue)
-		return false;
-
-	return sdma_v4_4_2_is_queue_selected(adev, instance_id, true);
-}
-
 static int sdma_v4_4_2_reset_queue(struct amdgpu_ring *ring,
 				   unsigned int vmid,
 				   struct amdgpu_fence *guilty_fence)
 {
-	bool is_guilty = ring->funcs->is_guilty(ring);
 	struct amdgpu_device *adev = ring->adev;
 	u32 id = ring->me;
 	int r;
@@ -1689,13 +1669,7 @@ static int sdma_v4_4_2_reset_queue(struct amdgpu_ring *ring,
 	amdgpu_amdkfd_suspend(adev, true);
 	r = amdgpu_sdma_reset_engine(adev, id);
 	amdgpu_amdkfd_resume(adev, true);
-	if (r)
-		return r;
-
-	if (is_guilty)
-		amdgpu_fence_driver_force_completion(ring);
-
-	return 0;
+	return r;
 }
 
 static int sdma_v4_4_2_stop_queue(struct amdgpu_ring *ring)
@@ -2180,7 +2154,6 @@ static const struct amdgpu_ring_funcs sdma_v4_4_2_ring_funcs = {
 	.emit_reg_wait = sdma_v4_4_2_ring_emit_reg_wait,
 	.emit_reg_write_reg_wait = amdgpu_ring_emit_reg_write_reg_wait_helper,
 	.reset = sdma_v4_4_2_reset_queue,
-	.is_guilty = sdma_v4_4_2_ring_is_guilty,
 };
 
 static const struct amdgpu_ring_funcs sdma_v4_4_2_page_ring_funcs = {
@@ -2213,7 +2186,6 @@ static const struct amdgpu_ring_funcs sdma_v4_4_2_page_ring_funcs = {
 	.emit_reg_wait = sdma_v4_4_2_ring_emit_reg_wait,
 	.emit_reg_write_reg_wait = amdgpu_ring_emit_reg_write_reg_wait_helper,
 	.reset = sdma_v4_4_2_reset_queue,
-	.is_guilty = sdma_v4_4_2_page_ring_is_guilty,
 };
 
 static void sdma_v4_4_2_set_ring_funcs(struct amdgpu_device *adev)
-- 
2.49.0

