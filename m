Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5017CC021A0
	for <amd-gfx@archiver.kernel.org>; Tue, 11 Feb 2025 05:16:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AA12310E168;
	Tue, 11 Feb 2025 05:16:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="EHPCT+X0";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2046.outbound.protection.outlook.com [40.107.93.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0F2AB10E168
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 Feb 2025 05:16:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gXTBxzVy/5nr8M3wF8mtfXSoAXKV/F1d8F7KiYLAofratbYpjOrPSQufsWD77AJMGFU/ORVpyGNlR30GmLZXrneKHJNB9aOXlB0ku03d/qN56MpTY3d/S1KMZEIrUnRvkRXWOG2rxh0OYpfBfBrWQxP5tHuTffimEmX/zm5S5xXoxmsbzHeADL/1PHmQ8hSt6xKGgldXSx2oRoxYOw1+QlMgJ6DbcBI48Liv3kC3BaCBsD6aHNoPSb7YbJ6hXJ80dFBHnvnUOhZUZV7JP9tAATNS4Odi9Is1ghzqyuZHZKA3hJ2W9RKLnMM9LHO3PDYQTEr2sv03yZgk4ZQZz/1/zA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4UapmobYZOP1OrL2dhAOCElCnA1PV8BTWtbK0WQ7AFQ=;
 b=OY88+eAFWyMkVyr1aoY3YGYEwRcKRZOzJcfzJJRmzIftwyuAl5YaNS3eN40xVUAmKijkIyZ9CD5d2Vj9SGxpygZuTsxTHTZ40InmveSXi2Dve+7uFZgQjgbI5Ok+hVdOfTrLrbY3MrZKFMuxjXDCknECSrnqDmwKz1edTKnRFCpuWyNq7bAIRj78xxHhgesxI792LKBiuoDg5lVFmuR2UfnVdisezDgEVgDO9FVoBL++4eina8Alex159Gem1LbXGrKwgb/NGHOtxAfYbm10+PVMaLoQ5twontS9dFhch0loBDxclsceilcE4zLELrLWBknuHdowC1OR3DqS+cdpWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4UapmobYZOP1OrL2dhAOCElCnA1PV8BTWtbK0WQ7AFQ=;
 b=EHPCT+X0I1hMxaBUPBjT8CigZ0Vd7SkZ+N4ZySFz0e6Z/hBzFvzZBk7xd9tqftkJHQQ90fz6G8T/D6NMGpqnksSPRr/graygkZCjp0rhdz8iKxRE4o6eOVFSF0IEMdnAGLggUk2kWjxmzjZQUUdOpGDPtlABgHIKasO+UVuRMEk=
Received: from SA0PR11CA0186.namprd11.prod.outlook.com (2603:10b6:806:1bc::11)
 by PH7PR12MB8105.namprd12.prod.outlook.com (2603:10b6:510:2b7::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.19; Tue, 11 Feb
 2025 05:16:09 +0000
Received: from SA2PEPF00001509.namprd04.prod.outlook.com
 (2603:10b6:806:1bc:cafe::11) by SA0PR11CA0186.outlook.office365.com
 (2603:10b6:806:1bc::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8445.12 via Frontend Transport; Tue,
 11 Feb 2025 05:16:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00001509.mail.protection.outlook.com (10.167.242.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8445.10 via Frontend Transport; Tue, 11 Feb 2025 05:16:09 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 10 Feb
 2025 23:16:08 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 10 Feb
 2025 23:15:44 -0600
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Mon, 10 Feb 2025 23:15:32 -0600
From: "Jesse.zhang@amd.com" <jesse.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <felix.kuehling@amd.com>, Jonathan Kim
 <Jonathan.Kim@amd.com>, Jiadong Zhu <Jiadong.Zhu@amd.com>,
 "Jesse.zhang@amd.com" <Jesse.zhang@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>, Jesse Zhang <jesse.zhang@amd.com>
Subject: [PATCH 4/4 V6] drm/amdgpu: Improve SDMA reset logic with guilty queue
 tracking
Date: Tue, 11 Feb 2025 13:14:54 +0800
Message-ID: <20250211051454.2811943-4-jesse.zhang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250211051454.2811943-1-jesse.zhang@amd.com>
References: <20250211051454.2811943-1-jesse.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: jesse.zhang@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00001509:EE_|PH7PR12MB8105:EE_
X-MS-Office365-Filtering-Correlation-Id: f17e9eaa-a80b-4333-8bff-08dd4a5b31a8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?yTBQGX34nJExq2itj4VEZOeoxTPvaLxl3+tYTEOEMWyOFiljoOvDYhsGPAZo?=
 =?us-ascii?Q?0s5k9YGbcXt9kIbSQPkaJcvuy41C94au5xLtNcu/lift7ygrvWYn8YhmHzeP?=
 =?us-ascii?Q?+jqXzOfzr1uY5Y0rMZl9Qy4gzhij23/f8iG1jWhWlnRek1wf64ypk4aV9f2z?=
 =?us-ascii?Q?CSh6Vinhb6I5ysJXei0RrEBb9iwS9hAEQRO90HA11NbBCfUeUl13XKIH6aBH?=
 =?us-ascii?Q?4XHdBZ2sW74Fc4I8CyHpP9X91ycyvKxUX96HtYpmqY0uALrrCf/K+zmOJaed?=
 =?us-ascii?Q?2/clpZW0aJKxrA+WLhllb+z2noud4MPudQ7cEtnwgtgA+xaVNGOFZnX+eVvz?=
 =?us-ascii?Q?4guQt79c2PR1KvhFgdGjFSNQtSf0gnF0w5IU8kD/oPXxO04Uh2iT5LuXh/O2?=
 =?us-ascii?Q?qlfuvrxxDn2H1632CfrIEHerapC3ZiJ914JuNc1cdEdwFIT1XuJtMK9FO73Z?=
 =?us-ascii?Q?zkHdI96jy8D3scPc0t2V2IweEiUp8kmpy37uj/Uv8dzFa/89QRIkA7PPW1lF?=
 =?us-ascii?Q?91N966bldDbST6KjvmGOiuaBvxCXdQ13nsVYQ9BHk0AB8PfXI4g3bDF/viUu?=
 =?us-ascii?Q?0pJZM9U0lSGrpJFtH2TppQeiX8DC+dbLaprClvgwnfOXY+dLhHVYDFo4U/FI?=
 =?us-ascii?Q?T1z4+Q3L59f9Cx5+r59dHKLDg0hToftbKnA4JpeG+GRIytBF979nwNmy29ci?=
 =?us-ascii?Q?snHQIHQqJSQkSJtmp4UsAW0wXYjyJIFz/jO4qcZsuuIzja4aaGDU0MZZqv6i?=
 =?us-ascii?Q?VzrKVHl234wRrNTA+5jslas49TY1OSpCs6StUDPopccpN/cvKFria+qGQlkf?=
 =?us-ascii?Q?KyzAOCmFS6A119cIFk3A/Tnej7g3SwrNpe7UiPXs7A4UmFgRMXccBMAFMeMe?=
 =?us-ascii?Q?Nnww68UI2CkRIVydx3n6HulKllJ+1tu7hHh7pdT3ga3u8sFPT8TAbYlgZVrS?=
 =?us-ascii?Q?Fi/6rZUex1Vavd/i/E/NIg1EgFu73NyyPgQ9KIDRUd2CjAcOuaJ/0kiupwuu?=
 =?us-ascii?Q?ku19IZgLrumQg2kj1D8QIYtovnFZxFKXITt1Q33eqik0g/cYi2XStwak82dd?=
 =?us-ascii?Q?BxKtUZ+FmKxI190Rb5SjYiVLt1p2oTl11f6osKFbKiaWJKqGAlqTXDhfFV9D?=
 =?us-ascii?Q?7Q8uKQ3ItLg2YQmRa9umE/F1+rCswaKOKz2tA6kj3jc5TsibMESVAe/n84z5?=
 =?us-ascii?Q?pxjagf9fYOoaD8/MCT9XXS0Qez3LLx2qTirdjDqHW8wPI4f7Rb+/rJeSdtI6?=
 =?us-ascii?Q?AGCZwZ20nCCmsMh4EY8A0MngV/mw/nEpaomsM2TdU5EdiSXWHKAn3eljn6U8?=
 =?us-ascii?Q?R9Fs8yCWsfYyPP3LQSyN30V3gPFoU3agnaVfoG9Wij+cm8nvOxl7Ij/Z144V?=
 =?us-ascii?Q?NeLAJJPi9p6f9heN55pA+FH9Dty84mTgknpzMapMWOY40DCevKBlRNdu3x4L?=
 =?us-ascii?Q?W7FhfhocTEltsW5/xlx2uUW/RIBJQgGCuEz6vqRN4ain4Fhlk/GrfUBlKZsR?=
 =?us-ascii?Q?3F2sAk7dS4TyoL4=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2025 05:16:09.1306 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f17e9eaa-a80b-4333-8bff-08dd4a5b31a8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00001509.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8105
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

From: "Jesse.zhang@amd.com" <Jesse.zhang@amd.com>

This commit introduces several improvements to the SDMA reset logic:

1. Added `cached_rptr` to the `amdgpu_ring` structure to store the read pointer
   before a reset, ensuring proper state restoration after reset.

2. Introduced `gfx_guilty` and `page_guilty` flags in the `amdgpu_sdma` structure
   to track which queue (GFX or PAGE) caused a timeout or error.

3. Replaced the `caller` parameter with a `guilty` boolean in the reset and resume
   functions to simplify the logic and handle resets based on the guilty state.

4. Added a helper function `sdma_v4_4_2_is_queue_selected` to check the
   `SDMA*_*_CONTEXT_STATUS.SELECTED` register and determine if a queue is guilty.

v2:
   1.replace the caller with a guilty bool.
   If the queue is the guilty one, set the rptr and wptr  to the saved wptr value,
   else, set the rptr and wptr to the saved rptr value. (Alex)
   2. cache the rptr before the reset. (Alex)

v3: add a new ring callback, is_guilty(), which will get called to check if
    the ring in amdgpu_job_timedout() is actually the guilty ring. If it's not,
    we can return goto exit(Alex)

v4: cache the rptr for page ring

v5: update the register addresses to correctly use the page ring registers
      (regSDMA_PAGE_RB_RPTR) in page resume.

v6: Keeping intermediate variables like u64 rwptr simplifies resotre rptr/wptr.(Lijo)

Suggested-by: Alex Deucher <alexander.deucher@amd.com>
Suggested-by: Jiadong Zhu <Jiadong.Zhu@amd.com>
Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.c  | 10 +++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c |  2 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h |  3 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c |  6 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h |  3 +
 drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c | 96 ++++++++++++++++++++----
 6 files changed, 106 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
index 100f04475943..ce3e7a9d6688 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
@@ -102,6 +102,16 @@ static enum drm_gpu_sched_stat amdgpu_job_timedout(struct drm_sched_job *s_job)
 		return DRM_GPU_SCHED_STAT_ENODEV;
 	}
 
+	/* Check if the ring is actually guilty of causing the timeout.
+	 * If not, skip error handling and fence completion.
+	 */
+	if (amdgpu_gpu_recovery && ring->funcs->is_guilty) {
+		if (!ring->funcs->is_guilty(ring)) {
+			dev_err(adev->dev, "ring %s timeout, but not guilty\n",
+				s_job->sched->name);
+			goto exit;
+		}
+	}
 	/*
 	 * Do the coredump immediately after a job timeout to get a very
 	 * close dump/snapshot/representation of GPU's current error status
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
index a6e28fe3f8d6..20cd21df38ba 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
@@ -342,6 +342,8 @@ int amdgpu_ring_init(struct amdgpu_device *adev, struct amdgpu_ring *ring,
 	ring->buf_mask = (ring->ring_size / 4) - 1;
 	ring->ptr_mask = ring->funcs->support_64bit_ptrs ?
 		0xffffffffffffffff : ring->buf_mask;
+	/*  Initialize cached_rptr to 0 */
+	ring->cached_rptr = 0;
 
 	/* Allocate ring buffer */
 	if (ring->is_mes_queue) {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
index 04af26536f97..182aa535d395 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
@@ -237,6 +237,7 @@ struct amdgpu_ring_funcs {
 	void (*patch_de)(struct amdgpu_ring *ring, unsigned offset);
 	int (*reset)(struct amdgpu_ring *ring, unsigned int vmid);
 	void (*emit_cleaner_shader)(struct amdgpu_ring *ring);
+	bool (*is_guilty)(struct amdgpu_ring *ring);
 };
 
 struct amdgpu_ring {
@@ -306,6 +307,8 @@ struct amdgpu_ring {
 
 	bool            is_sw_ring;
 	unsigned int    entry_index;
+	/* store the cached rptr to restore after reset */
+	uint64_t cached_rptr;
 
 };
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
index 32eebf9d4408..6ba785798a4a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
@@ -474,6 +474,10 @@ void amdgpu_sdma_register_on_reset_callbacks(struct amdgpu_device *adev, struct
 	if (!funcs)
 		return;
 
+	/* Ensure the reset_callback_list is initialized */
+	if (!adev->sdma.reset_callback_list.next) {
+		INIT_LIST_HEAD(&adev->sdma.reset_callback_list);
+	}
 	/* Initialize the list node in the callback structure */
 	INIT_LIST_HEAD(&funcs->list);
 
@@ -520,7 +524,7 @@ int amdgpu_sdma_reset_instance(struct amdgpu_device *adev, uint32_t instance_id,
 	*/
 	if (!amdgpu_ring_sched_ready(gfx_ring)) {
 		drm_sched_wqueue_stop(&gfx_ring->sched);
-		gfx_sched_stopped = true;;
+		gfx_sched_stopped = true;
 	}
 
 	if (adev->sdma.has_page_queue && !amdgpu_ring_sched_ready(page_ring)) {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
index df5c9f7a4374..d84c3eccc510 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
@@ -126,6 +126,9 @@ struct amdgpu_sdma {
 	uint32_t		*ip_dump;
 	uint32_t 		supported_reset;
 	struct list_head	reset_callback_list;
+	/* track guilty state of GFX and PAGE queues */
+	bool gfx_guilty;
+	bool page_guilty;
 };
 
 /*
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
index c297b4a13680..2c66382011d3 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
@@ -671,11 +671,12 @@ static uint32_t sdma_v4_4_2_rb_cntl(struct amdgpu_ring *ring, uint32_t rb_cntl)
  * @adev: amdgpu_device pointer
  * @i: instance to resume
  * @restore: used to restore wptr when restart
+ * @guilty: boolean indicating whether this queue is the guilty one (caused the timeout/error)
  *
  * Set up the gfx DMA ring buffers and enable them.
  * Returns 0 for success, error for failure.
  */
-static void sdma_v4_4_2_gfx_resume(struct amdgpu_device *adev, unsigned int i, bool restore)
+static void sdma_v4_4_2_gfx_resume(struct amdgpu_device *adev, unsigned int i, bool restore, bool guilty)
 {
 	struct amdgpu_ring *ring = &adev->sdma.instance[i].ring;
 	u32 rb_cntl, ib_cntl, wptr_poll_cntl;
@@ -683,6 +684,7 @@ static void sdma_v4_4_2_gfx_resume(struct amdgpu_device *adev, unsigned int i, b
 	u32 doorbell;
 	u32 doorbell_offset;
 	u64 wptr_gpu_addr;
+	u64 rwptr;
 
 	wb_offset = (ring->rptr_offs * 4);
 
@@ -708,12 +710,20 @@ static void sdma_v4_4_2_gfx_resume(struct amdgpu_device *adev, unsigned int i, b
 	/* before programing wptr to a less value, need set minor_ptr_update first */
 	WREG32_SDMA(i, regSDMA_GFX_MINOR_PTR_UPDATE, 1);
 
+	/* For the guilty queue, set RPTR to the current wptr to skip bad commands,
+	 * It is not a guilty queue, restore cache_rptr and continue execution.
+         */
+	if (guilty)
+		rwptr = ring->wptr;
+	else
+		rwptr = ring->cached_rptr;
+
 	/* Initialize the ring buffer's read and write pointers */
 	if (restore) {
-		WREG32_SDMA(i, regSDMA_GFX_RB_RPTR, lower_32_bits(ring->wptr << 2));
-		WREG32_SDMA(i, regSDMA_GFX_RB_RPTR_HI, upper_32_bits(ring->wptr << 2));
-		WREG32_SDMA(i, regSDMA_GFX_RB_WPTR, lower_32_bits(ring->wptr << 2));
-		WREG32_SDMA(i, regSDMA_GFX_RB_WPTR_HI, upper_32_bits(ring->wptr << 2));
+		WREG32_SDMA(i, regSDMA_GFX_RB_RPTR, lower_32_bits(rwptr << 2));
+		WREG32_SDMA(i, regSDMA_GFX_RB_RPTR_HI, upper_32_bits(rwptr << 2));
+		WREG32_SDMA(i, regSDMA_GFX_RB_WPTR, lower_32_bits(rwptr << 2));
+		WREG32_SDMA(i, regSDMA_GFX_RB_WPTR_HI, upper_32_bits(rwptr << 2));
 	} else {
 		WREG32_SDMA(i, regSDMA_GFX_RB_RPTR, 0);
 		WREG32_SDMA(i, regSDMA_GFX_RB_RPTR_HI, 0);
@@ -768,11 +778,12 @@ static void sdma_v4_4_2_gfx_resume(struct amdgpu_device *adev, unsigned int i, b
  * @adev: amdgpu_device pointer
  * @i: instance to resume
  * @restore: boolean to say restore needed or not
+ * @guilty: boolean indicating whether this queue is the guilty one (caused the timeout/error)
  *
  * Set up the page DMA ring buffers and enable them.
  * Returns 0 for success, error for failure.
  */
-static void sdma_v4_4_2_page_resume(struct amdgpu_device *adev, unsigned int i, bool restore)
+static void sdma_v4_4_2_page_resume(struct amdgpu_device *adev, unsigned int i, bool restore, bool guilty)
 {
 	struct amdgpu_ring *ring = &adev->sdma.instance[i].page;
 	u32 rb_cntl, ib_cntl, wptr_poll_cntl;
@@ -780,6 +791,7 @@ static void sdma_v4_4_2_page_resume(struct amdgpu_device *adev, unsigned int i,
 	u32 doorbell;
 	u32 doorbell_offset;
 	u64 wptr_gpu_addr;
+	u64 rwptr;
 
 	wb_offset = (ring->rptr_offs * 4);
 
@@ -787,12 +799,20 @@ static void sdma_v4_4_2_page_resume(struct amdgpu_device *adev, unsigned int i,
 	rb_cntl = sdma_v4_4_2_rb_cntl(ring, rb_cntl);
 	WREG32_SDMA(i, regSDMA_PAGE_RB_CNTL, rb_cntl);
 
+	/* For the guilty queue, set RPTR to the current wptr to skip bad commands,
+	 * It is not a guilty queue, restore cache_rptr and continue execution.
+         */
+	if (guilty)
+		rwptr = ring->wptr;
+	else
+		rwptr = ring->cached_rptr;
+
 	/* Initialize the ring buffer's read and write pointers */
 	if (restore) {
-		WREG32_SDMA(i, regSDMA_GFX_RB_RPTR, lower_32_bits(ring->wptr << 2));
-		WREG32_SDMA(i, regSDMA_GFX_RB_RPTR_HI, upper_32_bits(ring->wptr << 2));
-		WREG32_SDMA(i, regSDMA_GFX_RB_WPTR, lower_32_bits(ring->wptr << 2));
-		WREG32_SDMA(i, regSDMA_GFX_RB_WPTR_HI, upper_32_bits(ring->wptr << 2));
+		WREG32_SDMA(i, regSDMA_PAGE_RB_RPTR, lower_32_bits(rwptr << 2));
+		WREG32_SDMA(i, regSDMA_PAGE_RB_RPTR_HI, upper_32_bits(rwptr << 2));
+		WREG32_SDMA(i, regSDMA_PAGE_RB_WPTR, lower_32_bits(rwptr << 2));
+		WREG32_SDMA(i, regSDMA_PAGE_RB_WPTR_HI, upper_32_bits(rwptr << 2));
 	} else {
 		WREG32_SDMA(i, regSDMA_PAGE_RB_RPTR, 0);
 		WREG32_SDMA(i, regSDMA_PAGE_RB_RPTR_HI, 0);
@@ -968,9 +988,9 @@ static int sdma_v4_4_2_inst_start(struct amdgpu_device *adev,
 		uint32_t temp;
 
 		WREG32_SDMA(i, regSDMA_SEM_WAIT_FAIL_TIMER_CNTL, 0);
-		sdma_v4_4_2_gfx_resume(adev, i, restore);
+		sdma_v4_4_2_gfx_resume(adev, i, restore, adev->sdma.gfx_guilty);
 		if (adev->sdma.has_page_queue)
-			sdma_v4_4_2_page_resume(adev, i, restore);
+			sdma_v4_4_2_page_resume(adev, i, restore, adev->sdma.page_guilty);
 
 		/* set utc l1 enable flag always to 1 */
 		temp = RREG32_SDMA(i, regSDMA_CNTL);
@@ -1480,7 +1500,9 @@ static int sdma_v4_4_2_sw_init(struct amdgpu_ip_block *ip_block)
 	r = amdgpu_sdma_sysfs_reset_mask_init(adev);
 	if (r)
 		return r;
-	INIT_LIST_HEAD(&adev->sdma.reset_callback_list);
+	/* Initialize guilty flags for GFX and PAGE queues */
+	adev->sdma.gfx_guilty = false;
+	adev->sdma.page_guilty = false;
 
 	return r;
 }
@@ -1606,6 +1628,34 @@ static int sdma_v4_4_2_soft_reset(struct amdgpu_ip_block *ip_block)
 	return 0;
 }
 
+static bool sdma_v4_4_2_is_queue_selected(struct amdgpu_device *adev, uint32_t instance_id, bool is_page_queue)
+{
+	uint32_t reg_offset = is_page_queue ? regSDMA_PAGE_CONTEXT_STATUS : regSDMA_GFX_CONTEXT_STATUS;
+	uint32_t context_status = RREG32(sdma_v4_4_2_get_reg_offset(adev, instance_id, reg_offset));
+
+	/* Check if the SELECTED bit is set */
+	return (context_status & SDMA_GFX_CONTEXT_STATUS__SELECTED_MASK) != 0;
+}
+
+static bool sdma_v4_4_2_gfx_ring_is_guilty(struct amdgpu_ring *ring)
+{
+	struct amdgpu_device *adev = ring->adev;
+	uint32_t instance_id = ring->me;
+
+	return sdma_v4_4_2_is_queue_selected(adev, instance_id, false);
+}
+
+static bool sdma_v4_4_2_page_ring_is_guilty(struct amdgpu_ring *ring)
+{
+	struct amdgpu_device *adev = ring->adev;
+	uint32_t instance_id = ring->me;
+
+	if (adev->sdma.has_page_queue)
+		return false;
+
+	return sdma_v4_4_2_is_queue_selected(adev, instance_id, true);
+}
+
 static int sdma_v4_4_2_reset_queue(struct amdgpu_ring *ring, unsigned int vmid)
 {
 	struct amdgpu_device *adev = ring->adev;
@@ -1616,11 +1666,29 @@ static int sdma_v4_4_2_reset_queue(struct amdgpu_ring *ring, unsigned int vmid)
 static int sdma_v4_4_2_stop_queue(struct amdgpu_device *adev, uint32_t instance_id, int src)
 {
 	u32 inst_mask;
+	uint64_t rptr;
 	struct amdgpu_ring *ring = &adev->sdma.instance[instance_id].ring;
 
 	if (amdgpu_sriov_vf(adev))
 		return -EINVAL;
 
+	/* Check if this queue is the guilty one */
+	adev->sdma.gfx_guilty = sdma_v4_4_2_is_queue_selected(adev, instance_id, false);
+	if (adev->sdma.has_page_queue)
+		adev->sdma.page_guilty = sdma_v4_4_2_is_queue_selected(adev, instance_id, true);
+
+	/* Cache the rptr before reset, after the reset,
+	* all of the registers will be reset to 0
+	*/
+	rptr = amdgpu_ring_get_rptr(ring);
+	ring->cached_rptr = rptr;
+	/* Cache the rptr for the page queue if it exists */
+	if (adev->sdma.has_page_queue) {
+		struct amdgpu_ring *page_ring = &adev->sdma.instance[instance_id].page;
+		rptr = amdgpu_ring_get_rptr(page_ring);
+		page_ring->cached_rptr = rptr;
+	}
+
 	/* stop queue */
 	inst_mask = 1 << ring->me;
 	sdma_v4_4_2_inst_gfx_stop(adev, inst_mask);
@@ -2055,6 +2123,7 @@ static const struct amdgpu_ring_funcs sdma_v4_4_2_ring_funcs = {
 	.emit_reg_wait = sdma_v4_4_2_ring_emit_reg_wait,
 	.emit_reg_write_reg_wait = amdgpu_ring_emit_reg_write_reg_wait_helper,
 	.reset = sdma_v4_4_2_reset_queue,
+	.is_guilty = sdma_v4_4_2_gfx_ring_is_guilty,
 };
 
 static const struct amdgpu_ring_funcs sdma_v4_4_2_page_ring_funcs = {
@@ -2086,6 +2155,7 @@ static const struct amdgpu_ring_funcs sdma_v4_4_2_page_ring_funcs = {
 	.emit_wreg = sdma_v4_4_2_ring_emit_wreg,
 	.emit_reg_wait = sdma_v4_4_2_ring_emit_reg_wait,
 	.emit_reg_write_reg_wait = amdgpu_ring_emit_reg_write_reg_wait_helper,
+	.is_guilty = sdma_v4_4_2_page_ring_is_guilty,
 };
 
 static void sdma_v4_4_2_set_ring_funcs(struct amdgpu_device *adev)
-- 
2.25.1

