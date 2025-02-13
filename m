Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A51BEC021A7
	for <amd-gfx@archiver.kernel.org>; Thu, 13 Feb 2025 05:48:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 51E4A10E9E8;
	Thu, 13 Feb 2025 05:48:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="MS2TVYPy";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2062.outbound.protection.outlook.com [40.107.94.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 21A0610E9E8
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 Feb 2025 05:48:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JOloUsj3RXY44cJG0V1DZgHZusvbxgGY2avSEXa9+9Qlx2Q52rzJy1UbGwrdfjJiLJpZc3RJFCwphuURFtCPajYxqlwJYdhHYzVwryBgYvZsJaJ1tk7w9kTSWNIo3auaiEG0JKnBIo5y9tdGzk5r416jrRMHA8WsScxkGilirT8ChzA8vMFxqV7Dse8AlbJmrbysf+b3s+1oTii4SKClD1dH+/vc4pZwgSsXkhFQTQe8HQrpu369PjogBbJWxAJ/o9ZHn2KxGYt77E6L09+0Mng7Kdzzi0HSYGXzMN+cxK38SVg2e9Ii+HaylyaLH32gZOUucX+P99+V9WfdUinAMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F5O3XFD3hi7Bju0BwaF/57E8oBW2OJSrEG7BqM/TvLY=;
 b=vl1xlzCETUTui4A5SsyHJ3+i0ANLIeidShps59DUvhv0t+BnzdvK5a6dzIE2QidM4IgbEyJ4R3mAhI938MbuBZ9mLVTrkQMjE40auTGIUur2SYtg92gy16njjP+vhFe4p65kVsctuWhSM3Ff/V+cGnuUxyO1C8ON48MXIx13y4bK4QJ+eRyGa1n/xs5nquCwY/m4wO7aEnOcu4aoPMo0jNtjG/nJ4skZ6CTPhyxFDYrcNNhYxAk4IBTXAIZSXDG8N1VWt2LpczL2JcKUM/dN4RAt8qOc4qKsMlq9/F5sZFJ0tAkmBp0WesKJtWeS/dF5wUdkRBViYf0Lv06NznKUig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F5O3XFD3hi7Bju0BwaF/57E8oBW2OJSrEG7BqM/TvLY=;
 b=MS2TVYPyauEvbHtvQMpZmDY44gy7Ows4HkFyDpJfzy3etMCzCnKCxjKXzx2R2P3/e60NEFaEjUxKXeC6FuDMMpBd/cNQT8/qbdyhb8dynOB/yWLEAmwifeeY/6FO9ltYWlWpxsnM3UKsxAn8MOpLpZjzztUQjsNraX3mgg2aMD0=
Received: from DS2PEPF00004553.namprd21.prod.outlook.com
 (2603:10b6:f:fc00::51b) by CY8PR12MB8315.namprd12.prod.outlook.com
 (2603:10b6:930:7e::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.13; Thu, 13 Feb
 2025 05:48:43 +0000
Received: from DS1PEPF00017096.namprd05.prod.outlook.com
 (2603:10b6:2c:400:0:1007:0:4) by DS2PEPF00004553.outlook.office365.com
 (2603:10b6:f:fc00::51b) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.7 via Frontend Transport; Thu,
 13 Feb 2025 05:48:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF00017096.mail.protection.outlook.com (10.167.18.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8445.10 via Frontend Transport; Thu, 13 Feb 2025 05:48:43 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 12 Feb
 2025 23:48:42 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 12 Feb
 2025 23:48:42 -0600
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Wed, 12 Feb 2025 23:48:30 -0600
From: <jesse.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Felix.Kuehling@amd.com>, Jonathan Kim
 <Jonathan.Kim@amd.com>, Jiadong Zhu <Jiadong.Zhu@amd.com>,
 "Jesse.zhang@amd.com" <Jesse.zhang@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>, Jesse Zhang <jesse.zhang@amd.com>
Subject: [PATCH V7 7/9] drm/amdgpu: Improve SDMA reset logic with guilty queue
 tracking
Date: Thu, 13 Feb 2025 13:47:13 +0800
Message-ID: <20250213054715.3121445-7-jesse.zhang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250213054715.3121445-1-jesse.zhang@amd.com>
References: <20250213054715.3121445-1-jesse.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: jesse.zhang@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017096:EE_|CY8PR12MB8315:EE_
X-MS-Office365-Filtering-Correlation-Id: eced3025-6095-406f-9988-08dd4bf21324
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?htSj/eTbaI6CWVEeQ1mHFYiAIjI7vGKyUaZyq9cGuuZF/2H00iMnBKlUvC/m?=
 =?us-ascii?Q?29JlMgsqkgX1PAMqUX6BD5sSqWwOi74POCSrSfTwphW0zcD6Resgl/ZlvCV9?=
 =?us-ascii?Q?tlRD7bn7oyqmy/09IBmaTn3+q7fQ5sGmXDJYfKCoPv1dbCAUVQLqHNMixv0x?=
 =?us-ascii?Q?tX40UTqMCkigmh18+U0s4/xXt3Xz5693kukzOcOz55NuCHWI5CVG5IHJuCGy?=
 =?us-ascii?Q?BEgwPNkYSl2D2xaL/g76Q0rklt7DDq8wqgSYQ3ADsA+QSLfc9vBC2s/Tktk/?=
 =?us-ascii?Q?IiQ3ga/rxTn0YGa/3H3m25bCjv2SA9Z/32ihVv55wwSkYGVsCszOybBp9aIP?=
 =?us-ascii?Q?8WZrZbU7nyHANoAuq+wuJyX8bQftJkNTNwQ4y2h5LgWcqgqMWqmiFhCLQuo4?=
 =?us-ascii?Q?PzCrh6C3lTYO156aDJT/IiFmlTmotLNumz1XWpI4SFqNkce1YnS1+Tf+T+CT?=
 =?us-ascii?Q?vY+nkl/yHZBjJBqoEeNm9twQ5r1RwEAqWN8PuJnl8uy7Pf7eP1D6OXbTLhoq?=
 =?us-ascii?Q?LjcaPZiHrMCxUnUlXxl4MFdB/PT1PKqujXUnh8MoxIW+SUvdffd+u2XTWxhK?=
 =?us-ascii?Q?rZ19VmjugwXhpvb3UU7Af4Ehu0VHXt9pdG+SSlyCsyXNcNcg7EJtf1EJbfVX?=
 =?us-ascii?Q?iSMJ0A+aX/sQUxnL99vrvH7aX+QMfBsAXIVIbGNXqUdzL2CRb5mh5uGAqEJw?=
 =?us-ascii?Q?aCAiKqdQj52dROHAkMy4CU7C8hse1dIGWp5vgiowdNrikX80sNIdFYUlaULs?=
 =?us-ascii?Q?yRIHJBmFD5JDJWeCQ96yBF/cwGqhayyJ1/nxM7L4kKWyDyIhhOdCtu5/veig?=
 =?us-ascii?Q?0j0xDYRO6Uiy54aFr6pWoSGmujfLxBjf5hE/NRPFWSFzUMZUkUkkJxjDBZQO?=
 =?us-ascii?Q?roYae9v6ODdxfz7plxikvdYfpBILjYOizjYaX+t2duT0XIxmrDPSYEhja0Op?=
 =?us-ascii?Q?AJxFShN3/OB1RqOoEHkyF+ayQRdy+nkK8lTjSo2WVVupP6MU0Fk6WVS7FFod?=
 =?us-ascii?Q?z41kDjvQx7EArR2xUaX0HCc89mrdJp7yrXG+ARmVqeFHWnmcOcLZZ1tO3NKk?=
 =?us-ascii?Q?72zScwSdKJi4iL1bPgW1fS6x8ACVNws1Se8ZXSzJKoxZovd3DtDkD2mbMX9W?=
 =?us-ascii?Q?empcdJRwFl0h2kn4YflO2vgPnnc+qgJsNcMqYyJ/SldgQT8kNokv44H2fPTf?=
 =?us-ascii?Q?z2wePaJyFkGlv0WRrVYl8uHzKKHapl2klv8az6b8Wau1J0dHRgk8pQH0F5Ax?=
 =?us-ascii?Q?KJKiKfE/dvHbXStRpw3A72HsxaHGdEdMDY6Kz7k6ro+v3VDHgI1LvkmEFbgX?=
 =?us-ascii?Q?NdtwPFljvFCWJZEUnIwqWQHh1grMd9jL47Twk1sMzz487k1Y62/isnNiVOe3?=
 =?us-ascii?Q?wgTYNdgufGs3PnpfK75FZkaGs2VxFghpanDnnOUEWIMMdrKkeZEYAd4vakZs?=
 =?us-ascii?Q?x7X4D5fRcnFO08tpAULGlKbIhQT6RKLMlVCPVeBdd8+6fxC9ZOs7VllFK5aK?=
 =?us-ascii?Q?5ZAVh6eZnQ0m3WE=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2025 05:48:43.0719 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eced3025-6095-406f-9988-08dd4bf21324
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017096.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8315
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

This patch includes the remaining improvements to the SDMA reset logic:
- Added `gfx_guilty` and `page_guilty` flags to track guilty queues.
- Updated the reset and resume functions to handle the guilty state.
- Cached the `rptr` before reset.

v2:
   1.replace the caller with a guilty bool.
   If the queue is the guilty one, set the rptr and wptr  to the saved wptr value,
   else, set the rptr and wptr to the saved rptr value. (Alex)
   2. cache the rptr before the reset. (Alex)

v3: Keeping intermediate variables like u64 rwptr simplifies resotre rptr/wptr.(Lijo)

Suggested-by: Alex Deucher <alexander.deucher@amd.com>
Suggested-by: Jiadong Zhu <Jiadong.Zhu@amd.com>
Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c |  6 ++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h |  3 ++
 drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c | 66 +++++++++++++++++++-----
 3 files changed, 61 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
index 808c7112ef10..b9f0c78a6d77 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
@@ -475,6 +475,10 @@ void amdgpu_sdma_register_on_reset_callbacks(struct amdgpu_device *adev, struct
 	if (!funcs)
 		return;
 
+	/* Ensure the reset_callback_list is initialized */
+	if (!adev->sdma.reset_callback_list.next) {
+		INIT_LIST_HEAD(&adev->sdma.reset_callback_list);
+	}
 	/* Initialize the list node in the callback structure */
 	INIT_LIST_HEAD(&funcs->list);
 
@@ -521,7 +525,7 @@ int amdgpu_sdma_reset_engine(struct amdgpu_device *adev, uint32_t instance_id, i
 	*/
 	if (!amdgpu_ring_sched_ready(gfx_ring)) {
 		drm_sched_wqueue_stop(&gfx_ring->sched);
-		gfx_sched_stopped = true;;
+		gfx_sched_stopped = true;
 	}
 
 	if (adev->sdma.has_page_queue && !amdgpu_ring_sched_ready(page_ring)) {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
index 2ef2da772254..7effc2673466 100644
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
index b6de4eaf6088..350506b65cb4 100644
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
@@ -1644,11 +1666,29 @@ static int sdma_v4_4_2_reset_queue(struct amdgpu_ring *ring, unsigned int vmid)
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
-- 
2.25.1

