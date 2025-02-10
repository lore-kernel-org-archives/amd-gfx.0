Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1274C0219D
	for <amd-gfx@archiver.kernel.org>; Mon, 10 Feb 2025 09:56:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 85C1A10E4EB;
	Mon, 10 Feb 2025 09:56:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="KGP526+Q";
	dkim-atps=neutral
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2060.outbound.protection.outlook.com [40.107.95.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EB17F10E4EB
 for <amd-gfx@lists.freedesktop.org>; Mon, 10 Feb 2025 09:56:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u1qcff8GOAuaYrkfU7NjQ99scsgEiZLuJzUYV8FrhjUBuwtuEjdBxVpUIIu+SdDSZz4kRLL/HIu/2q7vRMSNHT+mi/nwNRq0I81NovYrJUDtVXRqWZ/NU6bcBqFDLMzQzyFsgRiH4FQZHaXlB3X70kGT0fj6y6hK+jEsDqbqZZsUFtPflNPlbII3SH3lO7Ami1gCBIp4+ocsmRXQBqf2h3KlRfKIvglV40JqEtnzCUdRx+gAH/o914guL04K9ITsn70N8oj81aQFVWG+7OK1vV/WFzFptHKHajdccohhgr3F58dvCF/kiZimaCfsJSDx1/DjdVKqH6rygiuTpIS85Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B+dON4kuSmZ9ifhYqFAHjqnDS2zmd6B5aSlaRI8W/eQ=;
 b=eeRCLLliz8oecuHQOayOYsZfACEx9dubT6FKugpS38TswtT/+dG94vbECRLsO2VIgdLKgFMqWMT+mXlHmxn/fRKgw3tH2uJhie3d0f6Rb9kjfZgHpXVsbuiNhW3NKapM0pvqlGsxPOl6C6CV6FCz4aTPhQVuOuT6oHJid7yAAcI7x46zksT63+uFnxgtqt+lLT99W1YXY0ImD7gWkQaKkiwdnMxFi56idWS80g5z187aJUbT9d1M6pwLtvdti7gt1ow2GVXX52e0euKkxBcV7VIxXi1f2nkZbKBaT8Gm2llmkpREEIYQ2Zf1/m1yOCP78rPvrmd2n5cMFc3xa0E5Ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B+dON4kuSmZ9ifhYqFAHjqnDS2zmd6B5aSlaRI8W/eQ=;
 b=KGP526+QWZIj9ChnLLZoDORhcjHUQZql9p8I3NQCQgRfVW8mF/ilyGZXG+aqZmtoHFE0bjdjj0NQLTkKoLGaRhfe8RqctR41+2RhClmfNQbi8SJD0a/YNpbfdKRaoRIOm963RlfCrSunuDKL9WVsGVqanWzfunfYaj9uJkLBHEo=
Received: from CH3P220CA0001.NAMP220.PROD.OUTLOOK.COM (2603:10b6:610:1e8::23)
 by SJ2PR12MB7822.namprd12.prod.outlook.com (2603:10b6:a03:4ca::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.15; Mon, 10 Feb
 2025 09:56:43 +0000
Received: from DS3PEPF000099D6.namprd04.prod.outlook.com
 (2603:10b6:610:1e8:cafe::20) by CH3P220CA0001.outlook.office365.com
 (2603:10b6:610:1e8::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.31 via Frontend Transport; Mon,
 10 Feb 2025 09:56:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099D6.mail.protection.outlook.com (10.167.17.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8445.10 via Frontend Transport; Mon, 10 Feb 2025 09:56:42 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 10 Feb
 2025 03:56:41 -0600
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Mon, 10 Feb 2025 03:56:29 -0600
From: "Jesse.zhang@amd.com" <jesse.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <felix.kuehling@amd.com>, Jonathan Kim
 <Jonathan.Kim@amd.com>, Jiadong Zhu <Jiadong.Zhu@amd.com>,
 "Jesse.zhang@amd.com" <Jesse.zhang@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>, Jesse Zhang <jesse.zhang@amd.com>
Subject: [PATCH v5 4/4] drm/amdgpu: Improve SDMA reset logic with guilty queue
 tracking
Date: Mon, 10 Feb 2025 17:56:29 +0800
Message-ID: <20250210095629.2748149-1-jesse.zhang@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: jesse.zhang@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D6:EE_|SJ2PR12MB7822:EE_
X-MS-Office365-Filtering-Correlation-Id: 2aaab03e-735f-4998-b06f-08dd49b938c1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?AXlaiV59c6ciK+I4anCZ/1c5V0tqMbXgDwlNHrRFaKZxvCGzVRSw9oHuyWYm?=
 =?us-ascii?Q?DgpKWOa1ZNIunptzRYNy/Nq6kWIaBBmNuOKpa2/1qY9wDx/6ETX1+Lse5kuu?=
 =?us-ascii?Q?ecIshxQsitGTFpxQFLwQ1CL6tQYdoBs3C94HtM3TqmCMgX4shSTQHid9PGj/?=
 =?us-ascii?Q?DFlR3fby5cTFcP357oXZaIEtr3PGh5dVMB051z983hHEOzCi9unNw1A8f1tY?=
 =?us-ascii?Q?r039ys4q+LOFxKZ8fPun6WrpVdqxbz23hzAAvQHd+JqJLUkKV0EDkjacy6Ee?=
 =?us-ascii?Q?nYywGyxhEyCCB3fcT9YpHECVIRAUnpQnWjqDOiQ/45Zw9Wp7yO5BOIEA5RE0?=
 =?us-ascii?Q?gzrcqz8BPa6kjQnlDbEUKyee8T3vIoUQJtoEwBG4br7Zb2vUZ6sgdd4v8xkk?=
 =?us-ascii?Q?/vQmKeH0ENYwLq5bc3nI6yMcXgW7nUbVamsrLDLmZdP0/YmeiDGzO3cJd4Ty?=
 =?us-ascii?Q?OijArkgZG0407tqsePtk2E+Bmyz+77IxBeZW+2rG+WAJa0FbOCXszIMHBHwS?=
 =?us-ascii?Q?b86QXTGX7t3hpvkKMAcmf9dGJmoMsmbpqbuvIYmMfub+YqMPKNlgAsR4CdcO?=
 =?us-ascii?Q?hKNq1KskMMrk1q1aUiCbaLeZcBjnDUmogYs+xYH5Vb2ckZ1NEcAQSfQGrU/h?=
 =?us-ascii?Q?rqmvyWEC8vaTtfv/NdLfSUJZOzDQ03aYcOLk9F7/tyO+1zp35oX3QCzhBRrM?=
 =?us-ascii?Q?fCvU2K7lSi8IshrqUGHayOcpg7ViztHEL0Qo1ri8DtscYK4puhQJwrcYwHeX?=
 =?us-ascii?Q?GFs7g5XnNEXRkUsMak53Xo9PZjU/Dak/uZeoskfi5Su6vYOUXgCCtdYSFecm?=
 =?us-ascii?Q?cm+tp8MlmlOsbNFcv8B3DYLrUmkOnhklojoRh7kb6pMXq7H/ChyQ2XRAKFAB?=
 =?us-ascii?Q?uF3F94oxVxt1uUfkA3m5xVQi+j1nC9j6fQoH5RTUYuRSDJSaoAYMcfY9BHGu?=
 =?us-ascii?Q?pG+uVSZhs6g39PPPEfQZ5wa/JRZyMwbtg/ZSL9WYmO3CWKHspWISMPeugpJC?=
 =?us-ascii?Q?BVXd2vTzZ5TuOs2IdnFH1OQPPr4Leo5mlfFCc9naTXQqYpNBEB6IHRbaXnQX?=
 =?us-ascii?Q?aaAuqN6RY8mdrP8tuwLxkZSyvCLAUakKdlFH/etO5UZmjNfm64JQzUNewAiK?=
 =?us-ascii?Q?a8aySc95A3p/tMHm32FuI8KYODIekwsYmUaFAZxe2GoKZHiPKKdwFIHsKHRi?=
 =?us-ascii?Q?YQPpl94MAabW48WLQ04hQwRJ1vUUP15Kui7zLc6+SRTgEnyoW7vgNoaQbkrI?=
 =?us-ascii?Q?nXdcxVuMQOX4LOLp0zLDz41PDCcVjihzd2A1cS6jsafvFGLIoqrEu6INuiBi?=
 =?us-ascii?Q?GTatzHK8bU6mLFDpc36PoqCfYK2/1O8f1bMO5x/X06b++4fgbZNQbosEEOEz?=
 =?us-ascii?Q?ATUMaJmzIddHfqL4qLWHHmaUdtEcEQQHIgVCaxsxFmYKQNcWbF+J1LSDkq7R?=
 =?us-ascii?Q?9X50N8U4Q2a2qbE3SCjLcc/QT8aSrMcvRK9Lq23sF8Fg6mKCoaF1JEifAKj5?=
 =?us-ascii?Q?LG0Zy7JO0Tj/cE4=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2025 09:56:42.5536 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2aaab03e-735f-4998-b06f-08dd49b938c1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099D6.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7822
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
index 8864a9d7455b..02d3685d10fc 100644
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
 
@@ -513,7 +517,7 @@ int amdgpu_sdma_reset_instance(struct amdgpu_device *adev, uint32_t instance_id,
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
index c297b4a13680..ad30077ade6f 100644
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
@@ -710,10 +711,19 @@ static void sdma_v4_4_2_gfx_resume(struct amdgpu_device *adev, unsigned int i, b
 
 	/* Initialize the ring buffer's read and write pointers */
 	if (restore) {
-		WREG32_SDMA(i, regSDMA_GFX_RB_RPTR, lower_32_bits(ring->wptr << 2));
-		WREG32_SDMA(i, regSDMA_GFX_RB_RPTR_HI, upper_32_bits(ring->wptr << 2));
-		WREG32_SDMA(i, regSDMA_GFX_RB_WPTR, lower_32_bits(ring->wptr << 2));
-		WREG32_SDMA(i, regSDMA_GFX_RB_WPTR_HI, upper_32_bits(ring->wptr << 2));
+		if (guilty) {
+			/* for the guilty queue, set RPTR to the current wptr to skip bad commands */
+			WREG32_SDMA(i, regSDMA_GFX_RB_RPTR, lower_32_bits(ring->wptr << 2));
+			WREG32_SDMA(i, regSDMA_GFX_RB_RPTR_HI, upper_32_bits(ring->wptr << 2));
+			WREG32_SDMA(i, regSDMA_GFX_RB_WPTR, lower_32_bits(ring->wptr << 2));
+			WREG32_SDMA(i, regSDMA_GFX_RB_WPTR_HI, upper_32_bits(ring->wptr << 2));
+		} else {
+			/* not the guilty queue, restore the cache_rptr to continue execution */
+			WREG32_SDMA(i, regSDMA_GFX_RB_RPTR, lower_32_bits(ring->cached_rptr << 2));
+			WREG32_SDMA(i, regSDMA_GFX_RB_RPTR_HI, upper_32_bits(ring->cached_rptr << 2));
+			WREG32_SDMA(i, regSDMA_GFX_RB_WPTR, lower_32_bits(ring->cached_rptr << 2));
+			WREG32_SDMA(i, regSDMA_GFX_RB_WPTR_HI, upper_32_bits(ring->cached_rptr << 2));
+		}
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
@@ -789,10 +800,19 @@ static void sdma_v4_4_2_page_resume(struct amdgpu_device *adev, unsigned int i,
 
 	/* Initialize the ring buffer's read and write pointers */
 	if (restore) {
-		WREG32_SDMA(i, regSDMA_GFX_RB_RPTR, lower_32_bits(ring->wptr << 2));
-		WREG32_SDMA(i, regSDMA_GFX_RB_RPTR_HI, upper_32_bits(ring->wptr << 2));
-		WREG32_SDMA(i, regSDMA_GFX_RB_WPTR, lower_32_bits(ring->wptr << 2));
-		WREG32_SDMA(i, regSDMA_GFX_RB_WPTR_HI, upper_32_bits(ring->wptr << 2));
+		if (guilty) {
+			/* for the guilty queue, set RPTR to the current wptr to skip bad commands */
+			WREG32_SDMA(i, regSDMA_PAGE_RB_RPTR, lower_32_bits(ring->wptr << 2));
+			WREG32_SDMA(i, regSDMA_PAGE_RB_RPTR_HI, upper_32_bits(ring->wptr << 2));
+			WREG32_SDMA(i, regSDMA_PAGE_RB_WPTR, lower_32_bits(ring->wptr << 2));
+			WREG32_SDMA(i, regSDMA_PAGE_RB_WPTR_HI, upper_32_bits(ring->wptr << 2));
+		} else {
+			/* not the guilty queue, restore the cached_rptr to continue execution */
+			WREG32_SDMA(i, regSDMA_PAGE_RB_RPTR, lower_32_bits(ring->cached_rptr << 2));
+			WREG32_SDMA(i, regSDMA_PAGE_RB_RPTR_HI, upper_32_bits(ring->cached_rptr << 2));
+			WREG32_SDMA(i, regSDMA_PAGE_RB_WPTR, lower_32_bits(ring->cached_rptr << 2));
+			WREG32_SDMA(i, regSDMA_PAGE_RB_WPTR_HI, upper_32_bits(ring->cached_rptr << 2));
+		}
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
+static bool sdma_v4_4_2_ring_is_guilty(struct amdgpu_ring *ring)
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
+	.is_guilty = sdma_v4_4_2_ring_is_guilty,
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

