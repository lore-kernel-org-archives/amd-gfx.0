Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62C57C02198
	for <amd-gfx@archiver.kernel.org>; Sat,  8 Feb 2025 04:00:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C388010EBCD;
	Sat,  8 Feb 2025 04:00:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="4jORagwV";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2072.outbound.protection.outlook.com [40.107.223.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4AC7410EBCD
 for <amd-gfx@lists.freedesktop.org>; Sat,  8 Feb 2025 03:58:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CZUJFPJMX7payDbuZw19iP1GGOnbhjx+AOqxEAvjMruBnbSFcHiynWKorGc6L/9w+De7e6GVa/O47HPt8LcgDHw1pOWeXBtmQSnEdvViNqycJ0ePE5js6HF6mLdSAM2XrFeuhhhL3ekYUnXHxiUkEoQ8HjJaLatQfcxbNlo5PRSc+KO0mxmT77l2SoFZTV0LQOEzuP5BOCVqb/8LGMBS3tC0xF5GGe/wNRixhzdgzYkXkXMaZOXkLcbMQ8fPtMnq7VlA7FWC+9hGRs1a7Gpmv7SNT6MWINWQLtQBlEI+j17YDqEH4U0Rvg07LLFWRJCRE7Hm/tm3nA0X6fOrpp5pGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H1Z7Pfo0TvBIYQItB+oAwE+79VGa+AncroicB9ZbY5A=;
 b=qDjxWJjcOTU1RfTs14+D+/5MH8VT1IBxfQaEeIDNUGB8YjlNwzxNYlS427CpYcP874HjP8mstIrA/tmwo3UunzS1RVrD5mrBz+KpAwyT/wNQdraXmspnsB5+a/66GKw7x1NFssRO0lYFZfGRZfY1U0LiKR+M3DCrEVgI0ysT1ao9P3GBX1y+bXn5dja/g0YHZkZS0NTdKDd61+voPlMc2AlSUYVZjMSvkECC7wTA2v/o7MglWKkZlSNQkxwclVirPxI6oNUHUTFWfgedgQlztf/9Rsyff47iI6isubXuc9erfqdpwHLvNMOwIjrmKs76Y0e2LrPDiZDyZANE+AKyyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H1Z7Pfo0TvBIYQItB+oAwE+79VGa+AncroicB9ZbY5A=;
 b=4jORagwVkBG7lSYpmtpa+/2l2RUmiVUmGa209ZVxjUqEzsAHEtllSBNNLFxHM8Um3N6ip7pyKA5GFgsrP5sVmpXG7yAoVrEpLqqGIAlh5tFr1RV0wOoH8zdGtwyAL3NHrpaRAm99g1iAmNFa3qPHgnV5+0eGH49q+K8jykA6OBA=
Received: from BYAPR08CA0014.namprd08.prod.outlook.com (2603:10b6:a03:100::27)
 by PH7PR12MB6660.namprd12.prod.outlook.com (2603:10b6:510:212::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.11; Sat, 8 Feb
 2025 03:58:49 +0000
Received: from SJ1PEPF00001CE5.namprd03.prod.outlook.com
 (2603:10b6:a03:100:cafe::8) by BYAPR08CA0014.outlook.office365.com
 (2603:10b6:a03:100::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.30 via Frontend Transport; Sat,
 8 Feb 2025 03:58:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CE5.mail.protection.outlook.com (10.167.242.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8398.14 via Frontend Transport; Sat, 8 Feb 2025 03:58:49 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 7 Feb
 2025 21:58:48 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 7 Feb
 2025 21:58:16 -0600
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Fri, 7 Feb 2025 21:58:04 -0600
From: <jesse.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Felix.Kuehling@amd.com>, Jonathan Kim
 <Jonathan.Kim@amd.com>, Jiadong Zhu <Jiadong.Zhu@amd.com>,
 "Jesse.zhang@amd.com" <Jesse.zhang@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>, Jesse Zhang <jesse.zhang@amd.com>
Subject: [PATCH 3/4] drm/amdgpu: Add common lock and reset caller parameter
 for SDMA reset synchronization
Date: Sat, 8 Feb 2025 11:57:43 +0800
Message-ID: <20250208035744.2455413-3-jesse.zhang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250208035744.2455413-1-jesse.zhang@amd.com>
References: <20250208035744.2455413-1-jesse.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: jesse.zhang@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE5:EE_|PH7PR12MB6660:EE_
X-MS-Office365-Filtering-Correlation-Id: db601985-65a4-42e6-1fc7-08dd47f4e4f3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?3NUI/wz1rK4GKE0ZcZStM05GKHxVj3Xik6duXV/Eqtc5AHI6lpqnFsaOyT8a?=
 =?us-ascii?Q?G99RWdVGpdBDFMdW1dr8nX6Bpldy05+s4+EH+lVbb6y9WISrIuGo1xcmU1Al?=
 =?us-ascii?Q?0nxEPZGRAD59rqLyMnA6Sedh781h4ld51k33ZiFp7WKgjpuZSoPPvR8/Wu/Y?=
 =?us-ascii?Q?x14o7YstraTW6aUENtks30KPl5S1elJlGlfwSdNW9bCNh/6FOQLjq98o19T4?=
 =?us-ascii?Q?FqQe87u1hs9+XJTaxA+rZqF7RQLoWR5VSwCYSI3ZDG5CV5lWP3XwXLNLkao5?=
 =?us-ascii?Q?V59Yq6k9Sg/Jst8whFfpPXEb0Lj5bka3e6UlgV3oCr+3U3JL9EUQusxQbv6C?=
 =?us-ascii?Q?ZpPKX2rTk/Rwi1ViBXZA84fIjB60JDmJ715c4LmMm9bqlQdAyZ86/f7ecgnO?=
 =?us-ascii?Q?oP3hoxbsuVtehA0BK/szUwwlhZcW5M6atbwyFC5SGzVBhlBRoDzVwjNn8IRg?=
 =?us-ascii?Q?T5J9+lEMYYbRAbmQ6RU+9uvq12abmAMkfb0J6TWhIzAluQJNrn8CC76N/XzM?=
 =?us-ascii?Q?9bnbCcFZsb1Uxe3e5gdvMpQ0AhjeephKRB2/5G1lOu1UhpEXQw7y59BifllD?=
 =?us-ascii?Q?CTD430DPanRMBKnwmNiJfAcYq16SrbWXHgrw5kWD6U0RAN66oJOg/Ea6P8eO?=
 =?us-ascii?Q?1DpRmPOFqcIehWTcnq91xdrUbm/iOTmFN1PHsbFKDAP6gsltHWU2x+JZlMlo?=
 =?us-ascii?Q?d+f8AjubaW5ckIM7BXkTXDoNvAWc4xpczTq1U62GzMl3VhAwQmwTawjfdgyo?=
 =?us-ascii?Q?Ptt9OaVLVUcCufC3vtYDBVrDVvsa7rWgJCwi5pkP+OHk10XObJNyoGbvU9Tg?=
 =?us-ascii?Q?hpXXnfuGGuHTz2NABFzyM1ta1j4TeJcU8RLrZ1yUg5SCTXHfKtP4BVcWuhWI?=
 =?us-ascii?Q?ArbNGKSNEGiLVvgGAoA3kEDBzO6fHrVT2c1HgAXKYiEPfbSFqtpjcar1z1cr?=
 =?us-ascii?Q?VAmEIf/S1bMiKWRQamqk8sE0hV2Y0+hHgmXkpsX8o9pPEMeu7bbiJYgf/VNZ?=
 =?us-ascii?Q?z6evSrhva+7qlfLb9jVNg2XKZZSwpFy9W8sJ1uxzsg5V7qWWRdbOWvTN+gc2?=
 =?us-ascii?Q?jne2IfGH0Fr/XPO2/46BBr8pBHtwtrS4W1/7Cm35/DY9WKpWWHboNxNy0f24?=
 =?us-ascii?Q?S4nNpVuJ8CQIT4uxjpw5c1YZhm9XLPTHCbkw3ciywAyhuG4a0r6UeBkj/aMF?=
 =?us-ascii?Q?c3RXAE9KgNlD8xv5tPT8it5ihN/UbfTDhgcC9e8uDKcSm0gUPKYx1H6p1eTt?=
 =?us-ascii?Q?bzADl0N/fYoFVbFIsy77RegVTV36R8xYDCzjYHrFqmwasqzlN81MtYbyNxwd?=
 =?us-ascii?Q?Gppgso0ZpVEn4jNPaaCIsptC9kNR9J4C0yn4Bud+a3zF0/kGBGQwm6FP/uRr?=
 =?us-ascii?Q?ATV7S2l28X7pck4CzKpIXz1MAnVZHwA/MZaIX+sWpLMikcCQFhYyp6C4dNhL?=
 =?us-ascii?Q?ckE2MyVTMcryc9vTG0wbqb2NpGERr3HSbLyadLwTIK0WND2hY6K+qw=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2025 03:58:49.3646 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: db601985-65a4-42e6-1fc7-08dd47f4e4f3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CE5.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6660
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

This commit introduces a caller parameter to the amdgpu_sdma_reset_instance function to differentiate
between reset requests originating from the KGD and KFD.
This change ensures proper synchronization between KGD and KFD during SDMA resets.

If the caller is KFD, the function now acquires and releases the scheduler lock (ring->sched.job_list_lock)
to protect the SDMA queue during the reset.

These changes prevent race conditions and ensure safe SDMA reset operations
when initiated by KFD, improving system stability and reliability.

V2: replace the ring_lock with the existed the scheduler
    locks for the queues (ring->sched) on the sdma engine.(Alex)

v3: call drm_sched_wqueue_stop() rather than job_list_lock.
    If a GPU ring reset was already initiated for one ring at amdgpu_job_timedout,
    skip resetting that ring and call drm_sched_wqueue_stop()
    for the other rings (Alex)

   replace  the common lock (sdma_reset_lock) with DQM lock to
   to resolve reset races between the two driver sections during KFD eviction.(Jon)

   Rename the caller to Reset_src and
   Change AMDGPU_RESET_SRC_SDMA_KGD/KFD to AMDGPU_RESET_SRC_SDMA_HWS/RING (Jon)
v4: restart the wqueue if the reset was successful,
    or fall back to a full adapter reset. (Alex)

   move definition of reset source to enumeration AMDGPU_RESET_SRCS, and
   check reset src in amdgpu_sdma_reset_instance (Jon)

Suggested-by: Alex Deucher <alexander.deucher@amd.com>
Suggested-by: Jiadong Zhu <Jiadong.Zhu@amd.com>
Suggested-by: Jonathan Kim <Jonathan.Kim@amd.com>
Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h |  2 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c  | 54 +++++++++++++++++++----
 drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h  |  6 +--
 drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c  |  8 ++--
 4 files changed, 56 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h
index 4d9b9701139b..5b86e12ff9fe 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h
@@ -43,6 +43,8 @@ enum AMDGPU_RESET_SRCS {
 	AMDGPU_RESET_SRC_MES,
 	AMDGPU_RESET_SRC_HWS,
 	AMDGPU_RESET_SRC_USER,
+	AMDGPU_RESET_SRC_SDMA_RING,
+	AMDGPU_RESET_SRC_SDMA_HWS,
 };
 
 struct amdgpu_reset_context {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
index 19c8be7d72e2..8864a9d7455b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
@@ -25,6 +25,7 @@
 #include "amdgpu.h"
 #include "amdgpu_sdma.h"
 #include "amdgpu_ras.h"
+#include "amdgpu_reset.h"
 
 #define AMDGPU_CSA_SDMA_SIZE 64
 /* SDMA CSA reside in the 3rd page of CSA */
@@ -484,6 +485,7 @@ void amdgpu_sdma_register_on_reset_callbacks(struct amdgpu_device *adev, struct
  * amdgpu_sdma_reset_instance - Reset a specific SDMA instance
  * @adev: Pointer to the AMDGPU device
  * @instance_id: ID of the SDMA engine instance to reset
+ * @src: The source of reset function (KGD or KFD)
  *
  * This function performs the following steps:
  * 1. Calls all registered pre_reset callbacks to allow KFD and AMDGPU to save their state.
@@ -492,20 +494,42 @@ void amdgpu_sdma_register_on_reset_callbacks(struct amdgpu_device *adev, struct
  *
  * Returns: 0 on success, or a negative error code on failure.
  */
-int amdgpu_sdma_reset_instance(struct amdgpu_device *adev, uint32_t instance_id)
+int amdgpu_sdma_reset_instance(struct amdgpu_device *adev, uint32_t instance_id, int src)
 {
 	struct sdma_on_reset_funcs *funcs;
-	int ret;
+	int ret = 0;
+	struct amdgpu_sdma_instance *sdma_instance = &adev->sdma.instance[instance_id];;
+	struct amdgpu_ring *gfx_ring = &sdma_instance->ring;
+	struct amdgpu_ring *page_ring = &sdma_instance->page;
+	bool gfx_sched_stopped = false, page_sched_stopped = false;
+
+	/* Check if the reset source is valid for SDMA ring reset */
+	if (src != AMDGPU_RESET_SRC_SDMA_RING && src != AMDGPU_RESET_SRC_HWS)
+		return -EINVAL;
+
+	/* Stop the scheduler's work queue for the GFX and page rings if they are running.
+	* This ensures that no new tasks are submitted to the queues while
+	* the reset is in progress.
+	*/
+	if (!amdgpu_ring_sched_ready(gfx_ring)) {
+		drm_sched_wqueue_stop(&gfx_ring->sched);
+		gfx_sched_stopped = true;;
+	}
+
+	if (adev->sdma.has_page_queue && !amdgpu_ring_sched_ready(page_ring)) {
+		drm_sched_wqueue_stop(&page_ring->sched);
+		page_sched_stopped = true;
+	}
 
 	/* Invoke all registered pre_reset callbacks */
 	list_for_each_entry(funcs, &adev->sdma.reset_callback_list, list) {
 		if (funcs->pre_reset) {
-			ret = funcs->pre_reset(adev, instance_id);
+			ret = funcs->pre_reset(adev, instance_id, src);
 			if (ret) {
 				dev_err(adev->dev,
 				"beforeReset callback failed for instance %u: %d\n",
 					instance_id, ret);
-				return ret;
+				goto exit;
 			}
 		}
 	}
@@ -514,21 +538,35 @@ int amdgpu_sdma_reset_instance(struct amdgpu_device *adev, uint32_t instance_id)
 	ret = amdgpu_dpm_reset_sdma(adev, 1 << instance_id);
 	if (ret) {
 		dev_err(adev->dev, "Failed to reset SDMA instance %u\n", instance_id);
-		return ret;
+		goto exit;
 	}
 
 	/* Invoke all registered post_reset callbacks */
 	list_for_each_entry(funcs, &adev->sdma.reset_callback_list, list) {
 		if (funcs->post_reset) {
-			ret = funcs->post_reset(adev, instance_id);
+			ret = funcs->post_reset(adev, instance_id, src);
 			if (ret) {
 				dev_err(adev->dev,
 				"afterReset callback failed for instance %u: %d\n",
 					instance_id, ret);
-				return ret;
+				goto exit;
 			}
 		}
 	}
 
-	return 0;
+exit:
+	/* Restart the scheduler's work queue for the GFX and page rings
+	 * if they were stopped by this function. This allows new tasks
+	 * to be submitted to the queues after the reset is complete.
+	 */
+	if (ret) {
+		if (gfx_sched_stopped && amdgpu_ring_sched_ready(gfx_ring)) {
+			drm_sched_wqueue_start(&gfx_ring->sched);
+		}
+		if (page_sched_stopped && amdgpu_ring_sched_ready(page_ring)) {
+			drm_sched_wqueue_start(&page_ring->sched);
+		}
+	}
+
+       return ret;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
index fbb8b04ef2cb..df5c9f7a4374 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
@@ -99,8 +99,8 @@ struct amdgpu_sdma_ras {
 };
 
 struct sdma_on_reset_funcs {
-	int (*pre_reset)(struct amdgpu_device *adev, uint32_t instance_id);
-	int (*post_reset)(struct amdgpu_device *adev, uint32_t instance_id);
+	int (*pre_reset)(struct amdgpu_device *adev, uint32_t instance_id, int src);
+	int (*post_reset)(struct amdgpu_device *adev, uint32_t instance_id, int src);
 	/* Linked list node to store this structure in a list; */
 	struct list_head list;
 };
@@ -166,7 +166,7 @@ struct amdgpu_buffer_funcs {
 };
 
 void amdgpu_sdma_register_on_reset_callbacks(struct amdgpu_device *adev, struct sdma_on_reset_funcs *funcs);
-int amdgpu_sdma_reset_instance(struct amdgpu_device *adev, uint32_t instance_id);
+int amdgpu_sdma_reset_instance(struct amdgpu_device *adev, uint32_t instance_id, int src);
 
 #define amdgpu_emit_copy_buffer(adev, ib, s, d, b, t) (adev)->mman.buffer_funcs->emit_copy_buffer((ib),  (s), (d), (b), (t))
 #define amdgpu_emit_fill_buffer(adev, ib, s, d, b) (adev)->mman.buffer_funcs->emit_fill_buffer((ib), (s), (d), (b))
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
index 3e60456b0db0..c297b4a13680 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
@@ -30,6 +30,7 @@
 #include "amdgpu_xcp.h"
 #include "amdgpu_ucode.h"
 #include "amdgpu_trace.h"
+#include "amdgpu_reset.h"
 
 #include "sdma/sdma_4_4_2_offset.h"
 #include "sdma/sdma_4_4_2_sh_mask.h"
@@ -1480,6 +1481,7 @@ static int sdma_v4_4_2_sw_init(struct amdgpu_ip_block *ip_block)
 	if (r)
 		return r;
 	INIT_LIST_HEAD(&adev->sdma.reset_callback_list);
+
 	return r;
 }
 
@@ -1608,10 +1610,10 @@ static int sdma_v4_4_2_reset_queue(struct amdgpu_ring *ring, unsigned int vmid)
 {
 	struct amdgpu_device *adev = ring->adev;
 	u32 id = GET_INST(SDMA0, ring->me);
-	return amdgpu_sdma_reset_instance(adev, id);
+	return amdgpu_sdma_reset_instance(adev, id, AMDGPU_RESET_SRC_SDMA_RING);
 }
 
-static int sdma_v4_4_2_stop_queue(struct amdgpu_device *adev, uint32_t instance_id)
+static int sdma_v4_4_2_stop_queue(struct amdgpu_device *adev, uint32_t instance_id, int src)
 {
 	u32 inst_mask;
 	struct amdgpu_ring *ring = &adev->sdma.instance[instance_id].ring;
@@ -1628,7 +1630,7 @@ static int sdma_v4_4_2_stop_queue(struct amdgpu_device *adev, uint32_t instance_
 	return 0;
 }
 
-static int sdma_v4_4_2_restore_queue(struct amdgpu_device *adev, uint32_t instance_id)
+static int sdma_v4_4_2_restore_queue(struct amdgpu_device *adev, uint32_t instance_id, int src)
 {
 	int i;
 	u32 inst_mask;
-- 
2.25.1

