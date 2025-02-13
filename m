Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93359C021A8
	for <amd-gfx@archiver.kernel.org>; Thu, 13 Feb 2025 05:48:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 433E510E2A6;
	Thu, 13 Feb 2025 05:48:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="QXuwrccK";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2045.outbound.protection.outlook.com [40.107.223.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A810610E2A6
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 Feb 2025 05:47:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rLGn31DENXtMLi0eRpo3sDXKoclqV+g6bCgkP3uMn5isJ/uscAirmcXRM/0doOBABDxmGSu+eAAAHuzGjfALVnQjgVEA7Aa2YiOMk6R0b2a0e/RZn29xfwaPV4xlO6AbHbiI8bEglWVhX9vSE89pp7bWPlvqF8cpXuHtDlMjda+7meYDGwU7USp6gBl9wyM2/YfkW2dDBgIDM5EMEJ6KxaaIriE2FrKsHawwGpbSX+b8Hf500JD5/gkLgnEyzh6e759xUCRpheBfMKT9Gcjwm01YVrLIYtd2rxk+ZfRbWSzAG2sJHasaL5xY4tKXWj+0B4JQiOKHefW8YUEOY1dVIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BZdEU1fk+keL2gG0E1V8zKSnHi2NelWthbLlHwRHPCA=;
 b=nizDrFyUn85tLqf1XrBi/0FO8QnoVA/jrMP1DxURa3B1D76RTovgVzWSMOhxSPJhGN7kyumejzape3KBk6dpOtUkw2XHsvpSdiCHrxvppNxAtyOYD/DegPpF2ku/lIupEonLXor+qDQPb2bUDBcZ5knTvVf8JUvvLStQl2JABzMlvO/MDweLfSmwqMuCwMZyhm8MZ2VbN81jBa3VEZCLVD6PGtQFz0/WyT9UCTWTYvjZjiVnYx9Zb5Czuecgffc3jrZzgRCQq21ZytyUGxUCz+sWKAqxXmM9qReol1GQ2fMwsNOlADQgF/noz4cdIYw9LwTkTV1kIXGxtoTZ+z93rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BZdEU1fk+keL2gG0E1V8zKSnHi2NelWthbLlHwRHPCA=;
 b=QXuwrccKx/Cyjcwe+DQ7J3P+OL056JwjE3lKKQdhmNYZoUJF2D0Zp6Sk6r/q7CpcgGlogkaUOLAupOTK9I+4HXFGnyf/6/3WPU+HZvAhcrJBmSwXwsDJSVaZMNq04MxJoEhUBt5tf/YNdxwrQIaR1SjBAjSd2qxqVqAa0fKPPkA=
Received: from PH7PR02CA0006.namprd02.prod.outlook.com (2603:10b6:510:33d::17)
 by SA1PR12MB8599.namprd12.prod.outlook.com (2603:10b6:806:254::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.18; Thu, 13 Feb
 2025 05:47:54 +0000
Received: from SN1PEPF0002529E.namprd05.prod.outlook.com
 (2603:10b6:510:33d:cafe::b3) by PH7PR02CA0006.outlook.office365.com
 (2603:10b6:510:33d::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8445.13 via Frontend Transport; Thu,
 13 Feb 2025 05:47:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SN1PEPF0002529E.mail.protection.outlook.com (10.167.242.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8445.10 via Frontend Transport; Thu, 13 Feb 2025 05:47:53 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 12 Feb
 2025 23:47:53 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 12 Feb
 2025 23:47:52 -0600
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Wed, 12 Feb 2025 23:47:40 -0600
From: <jesse.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Felix.Kuehling@amd.com>, Jonathan Kim
 <Jonathan.Kim@amd.com>, Jiadong Zhu <Jiadong.Zhu@amd.com>,
 "Jesse.zhang@amd.com" <Jesse.zhang@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>, Jesse Zhang <jesse.zhang@amd.com>
Subject: [PATCH V7 3/9] drm/amdgpu: Add common lock and reset caller parameter
 for SDMA reset synchronization
Date: Thu, 13 Feb 2025 13:47:09 +0800
Message-ID: <20250213054715.3121445-3-jesse.zhang@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002529E:EE_|SA1PR12MB8599:EE_
X-MS-Office365-Filtering-Correlation-Id: d83325f2-7b19-4d00-3a35-08dd4bf1f595
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?RZcRg/GdtxH9RxMpxtsBOIcMCaf5/pSn578pj7SFJhPy4adL/3YY7VfH0Imn?=
 =?us-ascii?Q?tNcAxuvFIAq+V28L7l2Pa6lozvKA+F3pXgTlKLypagX96JZMPAK3AMvfSUEI?=
 =?us-ascii?Q?Z7mO0tmIlTYpOixmjDAeC/yyKGZy+wdTpM8dJx2IlsFH41TADgx+ANx3xLHQ?=
 =?us-ascii?Q?iqAkKB0oK0P073N3MrawjxWg/MEmCr7+FswThPDVGA7xvbjqT5/H4kuCuY8x?=
 =?us-ascii?Q?sVc9IFe442hRLO/dlsBHXrtlKg/4wyAiq67jwOBlutBITFprdit3OZ5AdjLt?=
 =?us-ascii?Q?DCkTzY1xRArX5NkgQs25im2o9tOggNCm61Ymlv3TZm8KPKltm/jcDDS3Be1A?=
 =?us-ascii?Q?BD++tie7hvHbVmoshLjcbf2ea5BmCIY0EK1FUhHvPD49G/Maq2veHJ7fY3iB?=
 =?us-ascii?Q?IQUt6HMnk4NW2a8EUa6Zl3w+rpyFxpC14+A0FRI1sPmouUDMO03ZgSNjyfkN?=
 =?us-ascii?Q?8DK+A9C3v3wtu3/HqT2IkMYLazy8uiBlhE9x2C4ANmWer0cOHAHGhc4JfNus?=
 =?us-ascii?Q?YKtuAbRk/EVuONURk2mcY0hQN/AnmOZswjcJu1VsByGhWjUi+qt6qwNuWbMG?=
 =?us-ascii?Q?zaaoNkNNaVnR4eo6x0p0MWeUlRhWTgf2gNdfmYi245eiMhsVTSPkHiY5ccY1?=
 =?us-ascii?Q?zZky9KmEXrlQ27D3O9P3ZyRXQbrpX8GwhzjwYJBztdhEvhp3HoZ+Ghs6BiFS?=
 =?us-ascii?Q?25MKFdVC6JTq75DreHn2KqTeIetv2Abe/GIX5JATf++mMa9wdv90Eb2dQeNh?=
 =?us-ascii?Q?anIX83csQJbevsBxSuhuzkUaoE8jbf7j3yyjb1Hs5iKd5SDryGqjsz2cdjDY?=
 =?us-ascii?Q?FPqHz+ktckmC1p+V9ucTWwO9g8H2RGwKyvJxPlTtCYK0BKfCrXrU9BVeCEe+?=
 =?us-ascii?Q?OKsGWgsNiHPAqtx4W8FG4vm3nX9dCevZPJm+PCig8v8t0cYOsTFg4mRUlSF9?=
 =?us-ascii?Q?QWyxV0Rh95kCrR6Nrlg0oVTwIqGrVV/61SKkSmunf/HfQZ4G7g27FPfsh/z2?=
 =?us-ascii?Q?xoLbKiOrArYdMubDqTN47ZI8fRX7aBu2wILsWrbWgnVA4xPVqPua8PAOWOCO?=
 =?us-ascii?Q?jeZBytRluZIGuIXda+zpeYnCXrm879fDqawyHZD1BlqQFAPp3FpZRBVN9q8u?=
 =?us-ascii?Q?+SqzWbRzfKUQAYAqwf3LNczLv8ZA9cNAL3wzexgneGinQlMnMiQwSrv5TZp1?=
 =?us-ascii?Q?rhEJ2nkiGmPZioY4M9OhzRVIN7Rf7psCHVHjEow0dA523eQLPXVGl/wjvzua?=
 =?us-ascii?Q?ZRCcKaQ5rYe4WWCo65XBNr21Zh2OfRmeZB1ppwyyEGlnwR1Sf8tHufvqx3mm?=
 =?us-ascii?Q?zfzQ1PTqxkh/NUgiXM/G5goQaMMdwNGWH6cRX3SdgteLKVMh4DmQ4LBkzgJD?=
 =?us-ascii?Q?n5JMABx5YGTWJrahMHn78MQLyds5Gwl3kURhJlFCfj9fXOpgoRJ6QLNDcx9q?=
 =?us-ascii?Q?/h2AT4BVFt/GVF/E1QAlMI1YpNBU57hqVcrrdQCtKL8OjHYU4WnWqw=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2025 05:47:53.5096 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d83325f2-7b19-4d00-3a35-08dd4bf1f595
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002529E.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8599
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
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
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
index fe39198307ec..808c7112ef10 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
@@ -25,6 +25,7 @@
 #include "amdgpu.h"
 #include "amdgpu_sdma.h"
 #include "amdgpu_ras.h"
+#include "amdgpu_reset.h"
 
 #define AMDGPU_CSA_SDMA_SIZE 64
 /* SDMA CSA reside in the 3rd page of CSA */
@@ -485,6 +486,7 @@ void amdgpu_sdma_register_on_reset_callbacks(struct amdgpu_device *adev, struct
  * amdgpu_sdma_reset_engine - Reset a specific SDMA engine
  * @adev: Pointer to the AMDGPU device
  * @instance_id: ID of the SDMA engine instance to reset
+ * @src: The source of reset function (KGD or KFD)
  *
  * This function performs the following steps:
  * 1. Calls all registered pre_reset callbacks to allow KFD and AMDGPU to save their state.
@@ -493,20 +495,49 @@ void amdgpu_sdma_register_on_reset_callbacks(struct amdgpu_device *adev, struct
  *
  * Returns: 0 on success, or a negative error code on failure.
  */
-int amdgpu_sdma_reset_engine(struct amdgpu_device *adev, uint32_t instance_id)
+int amdgpu_sdma_reset_engine(struct amdgpu_device *adev, uint32_t instance_id, int src)
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
+	 * avoid race conditions between KFD and KGD during the reset process.
+	 */
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
@@ -515,21 +546,39 @@ int amdgpu_sdma_reset_engine(struct amdgpu_device *adev, uint32_t instance_id)
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
index f91d75848557..2ef2da772254 100644
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
-int amdgpu_sdma_reset_engine(struct amdgpu_device *adev, uint32_t instance_id);
+int amdgpu_sdma_reset_engine(struct amdgpu_device *adev, uint32_t instance_id, int src);
 
 #define amdgpu_emit_copy_buffer(adev, ib, s, d, b, t) (adev)->mman.buffer_funcs->emit_copy_buffer((ib),  (s), (d), (b), (t))
 #define amdgpu_emit_fill_buffer(adev, ib, s, d, b) (adev)->mman.buffer_funcs->emit_fill_buffer((ib), (s), (d), (b))
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
index 29a123be90b7..50a086264792 100644
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
-	return amdgpu_sdma_reset_engine(adev, id);
+	return amdgpu_sdma_reset_engine(adev, id, AMDGPU_RESET_SRC_SDMA_RING);
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

