Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 488D9C02198
	for <amd-gfx@archiver.kernel.org>; Mon, 10 Feb 2025 07:32:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E964110E4BF;
	Mon, 10 Feb 2025 07:32:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="D6xvlL92";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2045.outbound.protection.outlook.com [40.107.223.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BBC1F10E4BE
 for <amd-gfx@lists.freedesktop.org>; Mon, 10 Feb 2025 07:32:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u3j3yud74xvbpIusvWbLxE+hIgythAeB5zKJ4n8GidaPZ5W+xF97kvkDqNGIGO1YyG2blYPr4XpD7S/9IYkHT92ATqjnmV6FHi7mLY9m7rgL4b3IwrA30E0RuwHGoKXp2TBbAu42NaunmMbiTz/7O0nobPM14JWKjVyuOv3GYSCymWpiDSWYFDrikhlUHzXWMF1pyjgAWYSJuuga2OTe64doDhls5+L0pjPM8MKe/Q+aDXRJ4AsbEz+LIQGZUyXpeH3viIDW6ZnocxrII3EDY+bqche0NxCpZdmxG3q4JpcqhIt2W3iuI7HUaOiqt8XKaZRoNTH/0jVGBUX7lWo7Nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H1Z7Pfo0TvBIYQItB+oAwE+79VGa+AncroicB9ZbY5A=;
 b=jj+3HZkLNkSN8GrH7dtXXw6DvMwBlGfiqgDPjl7kdM1MmUEAWfwLOELxcmPVQBPMjvRsGHTHaUyPUK0kAwPpre7lEBVRjQw3wmSYFSYfMPC+tc33OGBbYYaoLhU2FyH6JEbqcxhPAzJVOVODPQcXDN1d07gUGNKk6h6wrwtFhcW/Yj1zEAAGqgfu9qdtfwI4u/8AL81eUYb8zRydAxrqJ/BHryNaxWljUxV0fQQ6hG46BZ++e21ni70MwPxSV1cfPkCb6Ne1XQhP9Qv0g80/UIQQL+Dc84z75mvQFaOLubMq7EPJLQX35CO+ia8OyJCLRJ6psoX1sxtY0D0J85HcBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H1Z7Pfo0TvBIYQItB+oAwE+79VGa+AncroicB9ZbY5A=;
 b=D6xvlL92HLW+sh5E2/r209OPpqw5ML2SwBNJw+TyAPBiE8LoJUJAkQUzjMJaexEoTT0FX7iNdcC7Y42JP+XmLbdbpH49xCZ/f/OHKezWiEYRqF43B7EM15u9pjKb+yJWpHuRZlbOjNhL4JDE09keWZL74a7geZnDAHe+OzQTmFg=
Received: from BY3PR05CA0015.namprd05.prod.outlook.com (2603:10b6:a03:254::20)
 by DS0PR12MB8294.namprd12.prod.outlook.com (2603:10b6:8:f4::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.18; Mon, 10 Feb
 2025 07:32:18 +0000
Received: from CO1PEPF000066EA.namprd05.prod.outlook.com
 (2603:10b6:a03:254:cafe::a0) by BY3PR05CA0015.outlook.office365.com
 (2603:10b6:a03:254::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8445.11 via Frontend Transport; Mon,
 10 Feb 2025 07:32:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000066EA.mail.protection.outlook.com (10.167.249.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8445.10 via Frontend Transport; Mon, 10 Feb 2025 07:32:18 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 10 Feb
 2025 01:32:17 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 10 Feb
 2025 01:32:17 -0600
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Mon, 10 Feb 2025 01:32:05 -0600
From: "Jesse.zhang@amd.com" <jesse.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <felix.kuehling@amd.com>, Jonathan Kim
 <Jonathan.Kim@amd.com>, Jiadong Zhu <Jiadong.Zhu@amd.com>,
 "Jesse.zhang@amd.com" <Jesse.zhang@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>, Jesse Zhang <jesse.zhang@amd.com>
Subject: [PATCH 3/4] drm/amdgpu: Add common lock and reset caller parameter
 for SDMA reset synchronization
Date: Mon, 10 Feb 2025 15:31:44 +0800
Message-ID: <20250210073145.2681082-3-jesse.zhang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250210073145.2681082-1-jesse.zhang@amd.com>
References: <20250210073145.2681082-1-jesse.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000066EA:EE_|DS0PR12MB8294:EE_
X-MS-Office365-Filtering-Correlation-Id: e84eaa3a-c8ed-4a61-ae98-08dd49a50c84
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?CRevGRzJJ96WOCMxGoQa9ZlCJd772LHUQSrYLeMQshO7OxKMnIz9PIwGX85Q?=
 =?us-ascii?Q?jSG9QeXXUdT0vlm6YNyJE6S3X9rYeCvLhubkD++G8QO/xuf1W8F7N7m/JodO?=
 =?us-ascii?Q?pndfqmN5Hq5Vfeg9d3M+FRZ6869lO5xT12495bdKJM5rYMQNQkBNeSTPpuD9?=
 =?us-ascii?Q?bRaSte+PV2ItHoNDU35Ht1V+tGmw7NyP+Gw1qXUIkPPryC9PEYXOpNsc9JAd?=
 =?us-ascii?Q?bTgDPWhrJbf/CPbwmazQxh7N9sq+yVS71E2Ro44yXqYFNVrKct8sjPgXdxNj?=
 =?us-ascii?Q?6ZIJUYHaPhWVYmvWBT+21mWA16BuN1Ux9HypREHDum3DoacS8eUXtHGzpKQX?=
 =?us-ascii?Q?Zz7ccD4yIC1SFPD8XM69ICM8rIzwxBLlsk9I67S20K8AL72ResipYjK+FcHs?=
 =?us-ascii?Q?fi++mY7gCJwHXwE+JRNDpJWegCGNQj+TbsYC7gO+MO1EYhx75eyv4A+3Xzp7?=
 =?us-ascii?Q?Jb9jiD2m8CQpq44sN6Lsp4QmhObt10mRDf7x6d9GVdupEoKPBx0QT5TxRHt9?=
 =?us-ascii?Q?3nHek0ecM/AsEbncwLD42ppVpoJRrytnOwHpsZs/y347uWB8b7jX9+fnLhNm?=
 =?us-ascii?Q?iACxyW9eixHImH6p4xRawlNcfC2G7soqcUXybrSkxU82sUqADy5brfXSAUwS?=
 =?us-ascii?Q?noCskpW1skxIMNxsR/jOF5jLZ7yA3LeGPBGOElvMdu+ZIIR89KA/jWSJ6ZNF?=
 =?us-ascii?Q?fWOHsnnS7ONkQcQKrsDYWrtO8XtCK3jkep7AlHg5zrW/mNrFzfaTo3zKMjgc?=
 =?us-ascii?Q?aUukMnkGfRkllhkCxCqgA87kyxoVw9LMIMcpYV91yScuaa/LkbAdRZRROrBw?=
 =?us-ascii?Q?NiDLtInQhjHNAlYstIznbt4gLR9tLlhAQW8Nq2u3mOro9P6GllFP5aBcWffT?=
 =?us-ascii?Q?7DNtgsBH2MvvXkXzuzh6liO80Ljug5PtqgKHzCsi6zFmfJmDmQnwUphFn55e?=
 =?us-ascii?Q?7hsGgwWzcWwOcWULS6Z9stg0pqeT9NtRVcYRO4yzdHEwLtJjpyhF/7J1D4Jn?=
 =?us-ascii?Q?XhJ8NdzpmMGMXQhNSIxlS8vkvSNtJTvj0ICXuiO7G0hxmulGKSCy66w/BYe1?=
 =?us-ascii?Q?Saywf8577dvYSjjyZ/3hHkVUUMdFCdbrzJ6OeMULeuW31JXWfnNUzXDc9dGt?=
 =?us-ascii?Q?xsz1nFsHbtvG/JxL06MLMdSQochYc1ZE+dLt2vcKZXUkrcQHr5GcbTwkWn4S?=
 =?us-ascii?Q?co8yTyd4jcVHN+I2UPHtnKKayVhPWDXfBqrULfaWRoXqqvlwo9yNVpouIDdO?=
 =?us-ascii?Q?tYrvCI2VoHQB3Kmz4qslwkiKdaJzepUhanG7XyBFGz9ATASnJolHdzfEFwyA?=
 =?us-ascii?Q?PL0mxF6elbFRObLorOFfd0RX52HbcBtWnnrEgLCIJVtTe0dR7BD4A1cBABh9?=
 =?us-ascii?Q?cp5Fdw1MgsJY+hGTymic+wI0ZCTtZrmrj6J6edVewwaixyG2MCIFYuDEBZYv?=
 =?us-ascii?Q?s/ysGNOSc6tPdmjnK0MxUHo+3MCdudcYJbradeg3TflxyOcxJeMW1Q=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2025 07:32:18.3056 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e84eaa3a-c8ed-4a61-ae98-08dd49a50c84
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000066EA.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8294
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

