Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A785BC0219E
	for <amd-gfx@archiver.kernel.org>; Sat,  8 Feb 2025 04:01:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BF80F10EBD2;
	Sat,  8 Feb 2025 04:00:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="tY7iHfP2";
	dkim-atps=neutral
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2053.outbound.protection.outlook.com [40.107.100.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0499C10EBCD
 for <amd-gfx@lists.freedesktop.org>; Sat,  8 Feb 2025 03:59:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kTixt5Mrxag/VYzdhjBgZQHeW1SxKXVyl7r27GgzqgkDqardRG1h2+1Ntzt/iCM5LYRWvu1dGjdW9ADO4sFF9eMEfY54e4InMNfoFha94ozyXilinvQ3rNe/6a6p78p0HIBDfj9/za5UUrE5i5Kzbffrq52RZuJLZ0jZd72ihA1U5cTVNyXI2PCSvsVlF5wn4LlESBTv1MSd8gQD02BX6iPpvJ51vY4Geyhs3xt1/KyOPkI5s9w+xFUw+Qz0ThYdgpys+tnWUyJcvWNn4E4xiTRbAOSO0j8nRNQTXAVRC6aGUtGOy8YTqHprJT38vcVqZeXzCybWCVktpv4FOFNIaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zWnVps6mwv/h9GtI0TT4L/7vM+lT8CfctuD78Rm+5Vw=;
 b=HqWLrgvDBZX3dH1VFGDOC5OjqBlZgFMLuuE9v0MAv7pEiaLcoSn9DchAJwLz511YXlyZB07W6GN/BiHEqGXuPEFp9eq+10GSuoR8cEV/L0W40BKR7b4Qzs294muCtQAdncImlRW82IZ3ACJJ27NMRo/IQW+P5czZHRDPXLfq9s30/FnagNJSXxckSFD3MbWv7S8CktNCk01XjW0DnPZbqQSnMFTmj6WAryqVmigoje0CGdOanxtcUDTj35C65zfVLji+vKZwO1eNUONG6iKxHWVJ6aK5rcRRZtcJvDjXWWFAKbGd4G4ckx4HzuALfW9ZEMFzZJb0Dd601C39pYJi3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zWnVps6mwv/h9GtI0TT4L/7vM+lT8CfctuD78Rm+5Vw=;
 b=tY7iHfP2+hsr6BHG5fJ0WzLS0LxKJ2GasomtsFrSEEX2qyLsxslv6eNOCQSKn3OHrcE+KIun2dT4LD2nBgApdBMuQPniafikI6F1QmZaAUYhONPK5mzw2d88sLzhksak0h6h9QBRmHhfNu+7VG2Nq8HPqbUvXGXaor5oRQGkS1I=
Received: from DS7PR06CA0042.namprd06.prod.outlook.com (2603:10b6:8:54::23) by
 IA0PR12MB7674.namprd12.prod.outlook.com (2603:10b6:208:434::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.13; Sat, 8 Feb
 2025 03:59:01 +0000
Received: from DS1PEPF00017095.namprd03.prod.outlook.com
 (2603:10b6:8:54:cafe::be) by DS7PR06CA0042.outlook.office365.com
 (2603:10b6:8:54::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.31 via Frontend Transport; Sat,
 8 Feb 2025 03:59:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DS1PEPF00017095.mail.protection.outlook.com (10.167.17.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8398.14 via Frontend Transport; Sat, 8 Feb 2025 03:59:01 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 7 Feb
 2025 21:59:00 -0600
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Fri, 7 Feb 2025 21:58:48 -0600
From: <jesse.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Felix.Kuehling@amd.com>, Jonathan Kim
 <Jonathan.Kim@amd.com>, Jiadong Zhu <Jiadong.Zhu@amd.com>,
 "Jesse.zhang@amd.com" <Jesse.zhang@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>, Jesse Zhang <jesse.zhang@amd.com>
Subject: [PATCH 4/4] drm/amdgpu: Improve SDMA reset logic with guilty queue
 tracking
Date: Sat, 8 Feb 2025 11:57:44 +0800
Message-ID: <20250208035744.2455413-4-jesse.zhang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250208035744.2455413-1-jesse.zhang@amd.com>
References: <20250208035744.2455413-1-jesse.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: jesse.zhang@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017095:EE_|IA0PR12MB7674:EE_
X-MS-Office365-Filtering-Correlation-Id: 82e204c3-bb6a-4aec-e4ba-08dd47f4ebe4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?oBUUvADp8Xl+S0h4xk6mr8SzWs5neFgHjJvDkSrRyvrhEEO8wBTwWpz2Id6W?=
 =?us-ascii?Q?ci5UzUnLYURThJSHQOULp/N4MxXcLgjUvItgMRndZqtpXM5ZfmSfNgW7O1C0?=
 =?us-ascii?Q?z0npJsTqnIYTz0MiTE9uWDdq1CFSuBgPTHMuP/h9LqfyVhs3L637QNcVUdTM?=
 =?us-ascii?Q?H3LLamrDEvdKFLLR2XCqUT2nAtlZfxFH8bK6rI4SemZufddU8CP5F+DQ1PlC?=
 =?us-ascii?Q?41tsn4Iou9N5COjybCI6ATsdiVAsEZxXrj2aKFfcgOFjH6y5WVIMZVagDXoX?=
 =?us-ascii?Q?NzQxvFRkFLRNxpChdFHZwohwmT95zbaQGzBJgoVcVa6kqDRaPdn8hGjP97BB?=
 =?us-ascii?Q?8ukKDwMiVvoe1eUk0yZhHAkjtVLzgkIQ5dRfZKDvw0+AEYNpJDTyHZx7KX9r?=
 =?us-ascii?Q?y2zqNkfOpfoYx26HbcSFX++jfVviDmxj3mzdAut7l4yB9YmIQkPovKgaG3yQ?=
 =?us-ascii?Q?Yc0hDg/AtWxZTfbN3sq7ZbWmnZ3LuG6+TP/Gxnd0W2EMp3CvJffo9EqRl+9e?=
 =?us-ascii?Q?Nw+Tk03RbmCds35t6ljimi2Z7LRlmZARJh6oAN5zyJTuRAKr4v1bLPVjA6Rk?=
 =?us-ascii?Q?jy81sMhRw26m8iNmaAu1JswA3P7nXAwEUp++fPbJjlaMEGcMns3fCzUet2co?=
 =?us-ascii?Q?pfhjNWJ90Y83WQrHCUs/tzr5AG/HhJj7SHmf0loyWslapIuDE4N456vVJYQK?=
 =?us-ascii?Q?Acg2cE3d/0V9+/pLD9NjWdw05YJXklfyy5mlCQst9Y79Xrvht7B2wpyrb6zC?=
 =?us-ascii?Q?pKt4s5TIYjkPKbUZFoIwudOA+VVUGfOT41IkSi1RTLHljku73vPnzJFCbf1K?=
 =?us-ascii?Q?Y2OInjUW6PkbU66lZRbfkMCdMO9B8fImPhASJyf9PBBLrYMMNUZUVrFq5Y0z?=
 =?us-ascii?Q?YPCX7AgtnOyU5ENmvAGZ+349Nq6pQQxAeCylm+P5nAGOmpe+y+3jWpWefx8f?=
 =?us-ascii?Q?xlezYrQZEfO4d8X9Z/rxMOZk4MLDj7SjX8JLcafYgtKeHDy2Poh3i677FaB7?=
 =?us-ascii?Q?AI4Jot9mlNJ59Btx1rtVVAS6IPfNc7ISDBviy9sWxp3eG5BldhwnZDetxpKY?=
 =?us-ascii?Q?nYp9hTm6a7lYHShtebrxCup31TbJ1emCHza4ZEKPTZKpdF1qrqBWzqUNat8C?=
 =?us-ascii?Q?sKK1YicbwHOFBrEuBuchvOh6BiVEyK6loIATRqHtPfYPFaSVxRWqC85iM45x?=
 =?us-ascii?Q?fRzSTyHr8+5qQtt5pl9pNFOfwYEhdjAFjyjmkD2G8+P8moCJqHRrrR5z0rxW?=
 =?us-ascii?Q?ALdpEKyAl6rsMaZKKJ91pCDZ+hh5teDQL2eMkns9yOFvqI+I8DI9OXISPPYi?=
 =?us-ascii?Q?5bb+r5VMLFNQ8CsEoUM3a67ImBfOhno5I1luklkIA3Em8pKbzwbq96SDVGdC?=
 =?us-ascii?Q?vLRn1rCMppuCMJGh1eSOzFCYd9j+4H7rU9uS4d3NqkHbaQ69HHSC23awh280?=
 =?us-ascii?Q?HML2rr07RxplK8JHmDL51OnInv7FjIocaEpBgTq4lD72A/8p9RVZn2PRkdMP?=
 =?us-ascii?Q?oRifMGCJr+A+5r4=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2025 03:59:01.0623 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 82e204c3-bb6a-4aec-e4ba-08dd47f4ebe4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017095.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7674
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

Suggested-by: Alex Deucher <alexander.deucher@amd.com>
Suggested-by: Jiadong Zhu <Jiadong.Zhu@amd.com>
Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.c  | 10 +++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c |  2 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h |  3 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c |  6 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h |  3 +
 drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c | 90 ++++++++++++++++++++----
 6 files changed, 100 insertions(+), 14 deletions(-)

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
index c297b4a13680..eb2341146612 100644
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
+			WREG32_SDMA(i, regSDMA_GFX_RB_RPTR, lower_32_bits(ring->wptr << 2));
+			WREG32_SDMA(i, regSDMA_GFX_RB_RPTR_HI, upper_32_bits(ring->wptr << 2));
+			WREG32_SDMA(i, regSDMA_GFX_RB_WPTR, lower_32_bits(ring->wptr << 2));
+			WREG32_SDMA(i, regSDMA_GFX_RB_WPTR_HI, upper_32_bits(ring->wptr << 2));
+		} else {
+			/* not the guilty queue, restore the cached_rptr to continue execution */
+			WREG32_SDMA(i, regSDMA_GFX_RB_RPTR, lower_32_bits(ring->cached_rptr << 2));
+			WREG32_SDMA(i, regSDMA_GFX_RB_RPTR_HI, upper_32_bits(ring->cached_rptr << 2));
+			WREG32_SDMA(i, regSDMA_GFX_RB_WPTR, lower_32_bits(ring->cached_rptr << 2));
+			WREG32_SDMA(i, regSDMA_GFX_RB_WPTR_HI, upper_32_bits(ring->cached_rptr << 2));
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
@@ -1616,11 +1666,23 @@ static int sdma_v4_4_2_reset_queue(struct amdgpu_ring *ring, unsigned int vmid)
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
+
 	/* stop queue */
 	inst_mask = 1 << ring->me;
 	sdma_v4_4_2_inst_gfx_stop(adev, inst_mask);
@@ -2055,6 +2117,7 @@ static const struct amdgpu_ring_funcs sdma_v4_4_2_ring_funcs = {
 	.emit_reg_wait = sdma_v4_4_2_ring_emit_reg_wait,
 	.emit_reg_write_reg_wait = amdgpu_ring_emit_reg_write_reg_wait_helper,
 	.reset = sdma_v4_4_2_reset_queue,
+	.is_guilty = sdma_v4_4_2_ring_is_guilty,
 };
 
 static const struct amdgpu_ring_funcs sdma_v4_4_2_page_ring_funcs = {
@@ -2086,6 +2149,7 @@ static const struct amdgpu_ring_funcs sdma_v4_4_2_page_ring_funcs = {
 	.emit_wreg = sdma_v4_4_2_ring_emit_wreg,
 	.emit_reg_wait = sdma_v4_4_2_ring_emit_reg_wait,
 	.emit_reg_write_reg_wait = amdgpu_ring_emit_reg_write_reg_wait_helper,
+	.is_guilty = sdma_v4_4_2_page_ring_is_guilty,
 };
 
 static void sdma_v4_4_2_set_ring_funcs(struct amdgpu_device *adev)
-- 
2.25.1

