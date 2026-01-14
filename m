Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A65AAD38FF2
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Jan 2026 16:48:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A7F6710E668;
	Wed, 14 Jan 2026 16:48:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Adqi32jh";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010002.outbound.protection.outlook.com [52.101.56.2])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4602510E662
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Jan 2026 16:48:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jOZymCUDg3GI9xsTEHRWrRBx02QjJ1VBcsZKSGq60LSot6tH4os3/P1nRbuA0r4qJWBtYuk1fabYbZQCIjYkvrYTy3hV3I75BMMVJK3EAa1sdWqOrfVTdJ1djFPsA2dsNzLK6PbANk/LiNN825cPxrphlfa5IarU6a1LsVyzJ8WzgDi1GeWpPRWdyMvSDj/SHqV7AwT+dY1APIjfozZoE5JIdTUf3tsTeoCXCdwlrV9tKq2J0L/8ztDFiYcjyo79cG+Byp737mNMINnltyLld3N9aobnPzbw1t7nTZYE81w7f/hFHFtyoNN8UTB9osV4t8UyRJK/UtXvt93Hs1o4rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GrZ+KM+v1+iAoxCIGeFlgKrkCEYG5WJxAWBix6NbgXo=;
 b=d9rAEmz5jrojzU0Jv/X8H5ImQo69jva0glM4LrL0hb0kH5JL0m0QQXIuiwtWhYFN04jjRtNlzEnZPfuBLVQOhHnanhHfCMBZTdAXmi1xwNiiTYFBMJW4Tqaebe8Y1yu726i5KuFbeims5HV4jAeBPT/fJq1IDdhA0lTpShFgarlnXrO3fT0EPHUYdzxlvpHu/6p37ayo7N1UHRjWefaAaC1KVdetQhAroH0Vbz/quS1IRinLye3H42J/ykyyRKUShrPrQtlViWNcBMGs9vXVUCjRAywvg+eVwvH3pqp8fXVviX9mY3eOCoLd76wob7Vk0bVw0PONwtbIpabS1dUZ4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GrZ+KM+v1+iAoxCIGeFlgKrkCEYG5WJxAWBix6NbgXo=;
 b=Adqi32jhwGPwT7lmQQzzX+j6ssq/r5PT/q/MKMFDhiT/Doc6BZ+U/c0okNerHd/I6G8lhZG5JSH8h7Dtpxa+H/PVSYS06lqNK1zuoyIHICr9aM0BV774aB+kQZY/5GosR3agIobG80vAG7HYQs5kOCv37mZxcFNN+Bo+l09fc7w=
Received: from MN2PR18CA0004.namprd18.prod.outlook.com (2603:10b6:208:23c::9)
 by PH7PR12MB5854.namprd12.prod.outlook.com (2603:10b6:510:1d5::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Wed, 14 Jan
 2026 16:48:12 +0000
Received: from BL02EPF00021F6B.namprd02.prod.outlook.com
 (2603:10b6:208:23c:cafe::46) by MN2PR18CA0004.outlook.office365.com
 (2603:10b6:208:23c::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9499.7 via Frontend Transport; Wed,
 14 Jan 2026 16:47:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF00021F6B.mail.protection.outlook.com (10.167.249.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Wed, 14 Jan 2026 16:48:12 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 14 Jan
 2026 10:47:50 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 14 Jan
 2026 08:47:50 -0800
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Wed, 14 Jan 2026 10:47:50 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 30/42] drm/amdgpu: simplify VCN reset helper
Date: Wed, 14 Jan 2026 11:47:15 -0500
Message-ID: <20260114164727.15367-31-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260114164727.15367-1-alexander.deucher@amd.com>
References: <20260114164727.15367-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00021F6B:EE_|PH7PR12MB5854:EE_
X-MS-Office365-Filtering-Correlation-Id: 6edbb77c-ae16-447c-b54b-08de538cb46f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?xDWYWrsjp+OM+SEt9+DSQqRj+XoEDELnDUIoUUr2WC2iThPtYV7bDTk7dDc8?=
 =?us-ascii?Q?c5/NeOKlBhkV05U+3jGTnbl2C3vxHdhKv7wsmMJIDNsgimRaYdX90t020lmH?=
 =?us-ascii?Q?LSDxI1aMCiLQuYUB5wldxYbN7bm9/furnHU16rpuMeK0SnbthJDayDsTZzLC?=
 =?us-ascii?Q?aQv+LQJqfMH7RlV7JpkIQBYaKUhka1fj9jJE9YjTkRUrxJdaWHuEBQPdVO2o?=
 =?us-ascii?Q?dT6NbE/C2Go1oGfnMntqlsqZ7fJjfyHvURzuiCT3LR2IPEMxwceLOgLH9nJL?=
 =?us-ascii?Q?ll1jGN2/3QIWgwGV9tRllQ8udvv1vZtLlU2UXMb8HWi1o3BVEi0gu98jDFVB?=
 =?us-ascii?Q?6pGrA+oJgVUH2MhAjcQ8WIqBJQfCK2+uBU/Z9PlT0S71qGlEzfTw+xGSrcAg?=
 =?us-ascii?Q?gn8UyIScIraSQAh0EMoGNcJK/Pqu+WuOsnmgbjaNjCZb3i2s6ZFf5CeP/iRy?=
 =?us-ascii?Q?5NsuJ9V7sAB+GwihB37t/9oGsuTxxT7Y4BwyjHtIBf/h7fH/LVhfA4ZX45Qk?=
 =?us-ascii?Q?hba4cFjDeRuT72SN1wd8NwODDmGo39g+nU3hX6Ej8vBqOmjIETdDMWa0IRz0?=
 =?us-ascii?Q?/HqTe6o5BSd4O2oDmOybfQkpBcR9tFNTDEyDSMx3hBDTNI7S6hYmrwR/3JT/?=
 =?us-ascii?Q?zD77T+nEcNoGxcW5diIxwrALCi3e2QtuAg4vFiy3QdMb0JtptwH+eEwRN3VQ?=
 =?us-ascii?Q?gB1N3T/QT7W6vcMr0v5XvRzHrE/xVrxFs+OhngGvd+qmNvCqaMNoNujdVFvi?=
 =?us-ascii?Q?Wnq8EwkA9lbnh6GzJyB3g6ok4P0f35SGzVyyYfIjcrGzeIg+/uJyGYfBq0s/?=
 =?us-ascii?Q?kpEVkCKsedyNCarZTh+QTrv5yFHYIQhQ3k1twQg288EYKmTIH758SwlQ8cJy?=
 =?us-ascii?Q?t+8EKAVMWpeSe5VagQCCs3L65CFCGPpIgY/5JvwcNOxHa65awECf7CTc2MJt?=
 =?us-ascii?Q?uPQApRXUihzrFpmIxiL2EW1JhqOcPzbKKFbhd4CTsgwOM5gdNBcv8irnDJYF?=
 =?us-ascii?Q?zYK8bPPw/zWNzDcsx+LvOWDej1MuMXR1hUY+X7fXe2AiUh64nEk1akyxm4sW?=
 =?us-ascii?Q?yZEMuUZUJTlBh0G8nf11rTE8nsGhmMbMix88+EFttVGg/yF82LHNSjyWT48Z?=
 =?us-ascii?Q?kbPRJa1HRMRrovLMW3sxriOUd29UqHTIVW/sHtOIEQZ8XVp0Xqk1AAECzgZx?=
 =?us-ascii?Q?bLohhzoDfpQqT91JBlPOCWOkTkO5TE2D1Hz07XSIiAtPO8VJptD29XObCTvw?=
 =?us-ascii?Q?lq1T0Su8EZ8CjoskbPRIRB3Zme8tM7GKMAm3qNOhRl1RlJy94rpREsWeEJ2E?=
 =?us-ascii?Q?WcsI4Wuz28csoTvCPU5xmDhlXLtDTKtjvhIjQeU0c8Msw3CvGURgu9yVaYwD?=
 =?us-ascii?Q?nRCTdwloWQeFvwT0V/7+pY9XPQsZj6UZxH/s2OUdF0Bme83yoQAzb+tDXEk6?=
 =?us-ascii?Q?DIlls5LtHkjmKIgIT0HzsiUPZKxCdTTL+7srUX3OICYtUJjUy8jONWWgWH14?=
 =?us-ascii?Q?wAT6HqMtF8to3+FzjVZ5/drAq+Un21O0tZEChKDMkDLdlwaLmW+oaYpuhD2U?=
 =?us-ascii?Q?yaoNzXWxico3LdCS2aHFy4Bz9d8xo6kbISjybQ3f/fCuXRqy/6IlJGdiy9KM?=
 =?us-ascii?Q?ra8CHTySFdk511WvQe09Cv/lV5Hm2LpRPhN6LTugtrkl?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2026 16:48:12.0490 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6edbb77c-ae16-447c-b54b-08de538cb46f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF00021F6B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5854
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

Remove the wrapper function.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c | 41 ++++++++-----------------
 1 file changed, 13 insertions(+), 28 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
index d22c8980fa42b..4de5c8b9a4cc4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
@@ -1481,19 +1481,27 @@ int vcn_set_powergating_state(struct amdgpu_ip_block *ip_block,
 }
 
 /**
- * amdgpu_vcn_reset_engine - Reset a specific VCN engine
- * @ring: Pointer to the VCN ring
- * @timedout_fence: fence that timed out
+ * amdgpu_vcn_ring_reset - Reset a VCN ring
+ * @ring: ring to reset
+ * @vmid: vmid of guilty job
+ * @timedout_fence: fence of timed out job
  *
+ * This helper is for VCN blocks without unified queues because
+ * resetting the engine resets all queues in that case.  With
+ * unified queues we have one queue per engine.
  * Returns: 0 on success, or a negative error code on failure.
  */
-static int amdgpu_vcn_reset_engine(struct amdgpu_ring *ring,
-				   struct amdgpu_fence *timedout_fence)
+int amdgpu_vcn_ring_reset(struct amdgpu_ring *ring,
+			  unsigned int vmid,
+			  struct amdgpu_fence *timedout_fence)
 {
 	struct amdgpu_device *adev = ring->adev;
 	struct amdgpu_vcn_inst *vinst = &adev->vcn.inst[ring->me];
 	int r, i;
 
+	if (adev->vcn.inst[ring->me].using_unified_queue)
+		return -EINVAL;
+
 	mutex_lock(&vinst->engine_reset_mutex);
 	/* Stop the scheduler's work queue for the dec and enc rings if they are running.
 	 * This ensures that no new tasks are submitted to the queues while
@@ -1537,29 +1545,6 @@ static int amdgpu_vcn_reset_engine(struct amdgpu_ring *ring,
 	return r;
 }
 
-/**
- * amdgpu_vcn_ring_reset - Reset a VCN ring
- * @ring: ring to reset
- * @vmid: vmid of guilty job
- * @timedout_fence: fence of timed out job
- *
- * This helper is for VCN blocks without unified queues because
- * resetting the engine resets all queues in that case.  With
- * unified queues we have one queue per engine.
- * Returns: 0 on success, or a negative error code on failure.
- */
-int amdgpu_vcn_ring_reset(struct amdgpu_ring *ring,
-			  unsigned int vmid,
-			  struct amdgpu_fence *timedout_fence)
-{
-	struct amdgpu_device *adev = ring->adev;
-
-	if (adev->vcn.inst[ring->me].using_unified_queue)
-		return -EINVAL;
-
-	return amdgpu_vcn_reset_engine(ring, timedout_fence);
-}
-
 int amdgpu_vcn_reg_dump_init(struct amdgpu_device *adev,
 			     const struct amdgpu_hwip_reg_entry *reg, u32 count)
 {
-- 
2.52.0

