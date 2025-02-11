Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 095BDC0219E
	for <amd-gfx@archiver.kernel.org>; Tue, 11 Feb 2025 05:15:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7D1FC10E417;
	Tue, 11 Feb 2025 05:15:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="SqYNP+UT";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2050.outbound.protection.outlook.com [40.107.223.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2619010E168
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 Feb 2025 05:15:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AyuQM9BmlZWrCgk5Bkph3WP9VXmlH3aFOKqC8obEaCBGNivEwhmx5fdVJEEmXxMaDbTslqWyianBoL6M0D2Hw3f3YfDu6ZvUjNALz5hEX3e+OQcyiOVzQsbhLkVcwV9aHWMghxTQlYKlUySXoLmT4A5KF/Tj7HA8NJHQ3UQhKy4vsBF66WNyUEt+s1opwMwhunfBmVRoj7zEymwJNPxNxYxu1l+ARJJHfBnstFZHYjnVzSrHHgIGWhJc7zJoqTaSyfOJ026XGSpBTufngtCeK6oHiuUxfD5K3sSe/3X4bx+tIckzcj5SxGkHTux9Mc+LlGX++vbOOFUfQti6SPw87A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f/S0e9wGhprM5YLThgy+GRk0RLcM3caRERS71iK0M4o=;
 b=ykCFflJyQwUFW7pc8+1m6zDINI4Y5dIlTC2NS2oQd6J7kQnRsVhXN8i6bLpRnDkWtmeT0TBWvbG4Unq48Elr3Unqpoye7h8XSrWCoYO3WdpHjSe4DdM5x1I2JI+m9IbsqAGbJa3dI2DStY8QfcaeUaLk4jRZjsGrS16CLBPXkK9o6FKmeNMWTLLLOSN6pFfjPZjDsLO0nMeiwX5AAgCNgB/eysZWwjACIPDUu9cJc1dunUOXUqSOzhWlelfI6v83bOJm302eve0rnu5ldLoZKKLyqRoo94i1+OMF/L01/Xl+pawmJbM73JLs+KodE03zPXxqLBr+jyELyhFW4gtXdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f/S0e9wGhprM5YLThgy+GRk0RLcM3caRERS71iK0M4o=;
 b=SqYNP+UTOuIqXFbhCXGVLGOaggJUheQfAOv0UlnYQl0gjww+5Oze5jJ0uBEY6T3BEbISIW3Rr0ImjIVu2GHltshV24akB8B1Aq4gqFKvs3dlfD/fX9nWB64pA906fIPTDy0IWJ80XUeSOwvTP5BBxA58KUiiv6q9EfXOozDmGdw=
Received: from SN7P222CA0006.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:124::19)
 by DM4PR12MB5892.namprd12.prod.outlook.com (2603:10b6:8:68::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8422.19; Tue, 11 Feb 2025 05:15:33 +0000
Received: from SA2PEPF00001506.namprd04.prod.outlook.com
 (2603:10b6:806:124:cafe::dd) by SN7P222CA0006.outlook.office365.com
 (2603:10b6:806:124::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.31 via Frontend Transport; Tue,
 11 Feb 2025 05:15:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00001506.mail.protection.outlook.com (10.167.242.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8445.10 via Frontend Transport; Tue, 11 Feb 2025 05:15:32 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 10 Feb
 2025 23:15:32 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 10 Feb
 2025 23:15:31 -0600
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Mon, 10 Feb 2025 23:15:19 -0600
From: "Jesse.zhang@amd.com" <jesse.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <felix.kuehling@amd.com>, Jonathan Kim
 <Jonathan.Kim@amd.com>, Jiadong Zhu <Jiadong.Zhu@amd.com>,
 "Jesse.zhang@amd.com" <Jesse.zhang@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>, Jesse Zhang <jesse.zhang@amd.com>
Subject: [PATCH 3/4 v6] drm/amdgpu: Add common lock and reset caller parameter
 for SDMA reset synchronization
Date: Tue, 11 Feb 2025 13:14:53 +0800
Message-ID: <20250211051454.2811943-3-jesse.zhang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250211051454.2811943-1-jesse.zhang@amd.com>
References: <20250211051454.2811943-1-jesse.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00001506:EE_|DM4PR12MB5892:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e978cbd-c91e-4a12-36e3-08dd4a5b1be9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?w5PA4SIeb5j3VpsZ+mUAbyUSTF2VknxtWQq0vvixNeUqpeArxUYwgJbS3C/8?=
 =?us-ascii?Q?rFoT6eguiUTZAxDVmlsmZh9bv+ATzzbWEmoLT5M0A+7z4HCNdhxzahfWZ4cB?=
 =?us-ascii?Q?4ZY/Hd396JpaHiV2qqcvMam5Z9MqGhW+IXfH5yMMwuLUIwJazlDQmjJgVnsd?=
 =?us-ascii?Q?X7snJYqf7JkyDetud1ST50Xgns8z9CAX1evvf3/4Lt3yJKWrO6wLQo6jSD+u?=
 =?us-ascii?Q?Jbo+vFi/gSagcbYw1R9Clvbi8+UceDKubV8x2T+8Fks/E17UIF88DBycRNAl?=
 =?us-ascii?Q?FeplwuZBjLowrB+KvyDRstcrP/QvJ0BvygT05q497gXAErfBJV9g3nqMjsdC?=
 =?us-ascii?Q?LH9bEcrRWu7bStFaXrRc6z+OGlFHGsidaQl6g6VfttuREDV0Zn+T6b1Cq7Ll?=
 =?us-ascii?Q?Ofa6MLQvrzztCgVSFcdCScDJLGE3JtA7t3Rq7msOmMQ52ie1xrl+vibxNKgh?=
 =?us-ascii?Q?9flniXqUPtHKZOQMPnTpi4jjValcTlLsoFaMrhv17dB2tAwFGbKmzYx0kU4L?=
 =?us-ascii?Q?YQCyZpx849pNrkqpWnwB0/JiZcQQliqP7DyoclyDaJYwJq8kCqBRhBSENeS7?=
 =?us-ascii?Q?AkGEo8XY1mv3MEDAE2STHsilWObOo5EnOF/GAnTKnwghq3+QQUaKwOJXN/mM?=
 =?us-ascii?Q?7wCbt3yJxGQdP8bLCE9BBtRCaJJMfqiuWYnG64ILikSPWx7NXvrLZgtBAhZf?=
 =?us-ascii?Q?vyc51yzzCM9k5tgl//6y1rnG71uotB5/KQDsdH0gGsAvUIYHqjeC5ExLiHBM?=
 =?us-ascii?Q?0uCc3dVfi60KhKfxONfD/QYu1yWfr0o/bKSIZRvvxkGwVtSPArG8qv+fge15?=
 =?us-ascii?Q?hcZOhb85xgb8DmV6rnBaLnl0zkUCFFFbQOh2VvEvQHE5jSybLrcJCJsiFCG9?=
 =?us-ascii?Q?7aB3CwSKKFE5gXSs82mq4qI5DvEIMdwaHr5mNk/PCfavMprGCZluTaioTy6B?=
 =?us-ascii?Q?zqT3SbhABWasMpj5aXmqBVM6P4xHtGEosYoU3OepkMdF116jV1iF/ZeGx9dD?=
 =?us-ascii?Q?zHyRe7ZO+v+GjrJMT7I74ed7a1NJyOPTXVnUK8ymEDDTgyKKEjN0AKg9nDL0?=
 =?us-ascii?Q?U5poq6izZGh0sxWDNX3u+cLCaXz15Oi9XTAbNlP5cW1q/hYm2sRSFX4MzyG4?=
 =?us-ascii?Q?Ec+74NPthIe4VM641bIt2DWrrbe4WvyFF7me2YPzmZrBZjkUG0E8rAJuraZl?=
 =?us-ascii?Q?PMBWJWixrAzZij1Ic6HYmH4WsrBC1JEqYps7kgviRgIq5GG+48V3tSVNnNsk?=
 =?us-ascii?Q?EiWxEeU5BVqvkPGomvXchDZD4fdAXTuPve/9M+ewSqbYNJyNB0+eOTH/Tr8U?=
 =?us-ascii?Q?YQdKH3BbS/SeIi0QTnHhMj7E+uxjm6jCFaToRdlbV/tNg65HSRLgjpCHqiHw?=
 =?us-ascii?Q?mgrDlu+ccy3Rram7xcPqzJL7Sb2ZC5EamIqLSzH4eKFZDfBDArOevk2PRy8r?=
 =?us-ascii?Q?3+qvl08VSt0R1i+WKJFDIVAoA1UryZNwWWIkXdFUdj1ga4Hu3BrErg=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2025 05:15:32.6445 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e978cbd-c91e-4a12-36e3-08dd4a5b1be9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00001506.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5892
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

v5: Call amdgpu_amdkfd_suspend/resume at the start/end of reset function respectively under !SRC_HWS
    conditions only (Jon)

Suggested-by: Alex Deucher <alexander.deucher@amd.com>
Suggested-by: Jiadong Zhu <Jiadong.Zhu@amd.com>
Suggested-by: Jonathan Kim <Jonathan.Kim@amd.com>
Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h |  2 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c  | 65 ++++++++++++++++++++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h  |  6 +--
 drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c  |  8 +--
 4 files changed, 67 insertions(+), 14 deletions(-)

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
index 19c8be7d72e2..32eebf9d4408 100644
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
@@ -492,20 +494,49 @@ void amdgpu_sdma_register_on_reset_callbacks(struct amdgpu_device *adev, struct
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
+	/* Suspend KFD if the reset source is not SDMA_HWS.
+	 * prevent the destruction of in-flight healthy user queue packets and
+         * avoid race conditions between KFD and KGD during the reset process.
+         */
+	if (src != AMDGPU_RESET_SRC_SDMA_HWS)
+		amdgpu_amdkfd_suspend(adev, false);
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
@@ -514,21 +545,39 @@ int amdgpu_sdma_reset_instance(struct amdgpu_device *adev, uint32_t instance_id)
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
+	/* Resume KFD if the reset source is not SDMA_HWS */
+	if (src != AMDGPU_RESET_SRC_SDMA_HWS)
+		amdgpu_amdkfd_resume(adev, false);
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

