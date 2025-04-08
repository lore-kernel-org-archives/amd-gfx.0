Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC2B8C3600C
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Apr 2025 08:37:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6F0C410E611;
	Tue,  8 Apr 2025 08:37:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="pBG10SM/";
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2047.outbound.protection.outlook.com [40.107.102.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 817A810E611
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Apr 2025 08:37:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NB4UxeDN46uSYPeoex3KFvnuGDfG8xyBgQAsFs3EJaz4ArRS6JrKAx+Sn/NXksErK0qSUX47niEYnINsuMacChn6OnyzGbsDoH/yBlckZuWAM6cEsnXTXv15ZA3vY8XTgNjfu5wTJwEedFjSV4fulviMvr36SOdMaxZxIn+ZhM1v18yhb7pWxUj9xM4PUztoOnAUC3RtlE+zpoh3C0fbRLe5EXzEpNU0xUu+9AobRkWdBkjEcIq6FYX5XpbzvT9ngOBUPci4LE4Z+QRfTfqrMQpxw19ew5HHE1jWzewORSdYKy20HlR0iH7ZguGiogTwzcAmsj+s0LChQDUgxPOKRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=za5P5WqTBiixpZTWjBQ/3yUbvho8fVAQL6tqdXCmxwI=;
 b=XbuY9RyzHX6YS5Hj8o8rHaC8O4dj5mfpHn4IQpWI+/HWCwoV79okkBFM9HhLFHRiz71cnZF26QHpx4U5T5OeD6+jOHYGCXvbwhFN5Rqd3sEZUWXXRETBzR/EctGXNx0gfiKdDr6lynd6vrgifHFgrqCluUoWrJxZXvViQAyOirsfOvuviHEeC4hDrYND++Q+I+Uq6sR6xCodiANzvun7cSXr2rVh6E1yaZQ6UnQY9Am94OsSvMnrtENCEtvKPuwr/JUNA4p8rCppV8+GXZuD40Fc4POaZaknoIwrbKp+S3yCqdr+NIdVIAerXu6St6j4CWLGcG/TbbnwZbWkb8LlOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=za5P5WqTBiixpZTWjBQ/3yUbvho8fVAQL6tqdXCmxwI=;
 b=pBG10SM/IEKVTTlRzA5zgInHiwbI37mF/CXkTUcoMiPGmFtfnf9yUC5gf7DsOwL7OyDNP5w2x0QDGODdinwIVffOnqHDBeGEyoTuSnX5FCP5pz1kYDQZBKeNRUNNa0+N1Z/vK3EWUUPRovmj6kYre9adHCg1W2fq4h2ECXMg5V4=
Received: from BN0PR07CA0003.namprd07.prod.outlook.com (2603:10b6:408:141::15)
 by SA1PR12MB7318.namprd12.prod.outlook.com (2603:10b6:806:2b3::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8583.42; Tue, 8 Apr
 2025 08:37:25 +0000
Received: from BL6PEPF0001AB58.namprd02.prod.outlook.com
 (2603:10b6:408:141:cafe::cb) by BN0PR07CA0003.outlook.office365.com
 (2603:10b6:408:141::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8606.35 via Frontend Transport; Tue,
 8 Apr 2025 08:37:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB58.mail.protection.outlook.com (10.167.241.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8606.22 via Frontend Transport; Tue, 8 Apr 2025 08:37:24 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 8 Apr
 2025 03:37:23 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 8 Apr
 2025 03:37:22 -0500
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Tue, 8 Apr 2025 03:37:10 -0500
From: "Jesse.zhang@amd.com" <jesse.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 <jonathan.kim@amd.com>, <jiadong.zhu@amd.com>, "Jesse.zhang@amd.com"
 <Jesse.zhang@amd.com>, Jesse Zhang <jesse.zhang@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>
Subject: [v4 4/7] drm/amd/amdgpu: Refactor SDMA v5.0 reset logic into
 top_queue and restore_queue function
Date: Tue, 8 Apr 2025 16:36:30 +0800
Message-ID: <20250408083633.2300420-4-jesse.zhang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250408083633.2300420-1-jesse.zhang@amd.com>
References: <20250408083633.2300420-1-jesse.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: jesse.zhang@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB58:EE_|SA1PR12MB7318:EE_
X-MS-Office365-Filtering-Correlation-Id: 14f86e72-08c9-41ac-de20-08dd76789657
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Nfi4TM2W+R7pVzcEtjpiI6nB8nnH7y20itGu+OKhpnV8ry89kekb/T/G0ctM?=
 =?us-ascii?Q?fzyzwOBKkqf3xWDIhZwMJkT8/1brOVaxmlG5aPwOCDK0E4AdS+4esmZ3fg0H?=
 =?us-ascii?Q?gKyB5E18+BpE+Eg8k2NW5RKB1sJzQLA2Q1K1cuXNBAODGxz9arTy39RkIw73?=
 =?us-ascii?Q?ac7RdJx8cWamjWOybf+k+wtjMFyE+XQF4Nqpih+U/4q7N9kiUlFva0GMotfI?=
 =?us-ascii?Q?QEEBsu8ITicUwwn9V5Shtrbb/tIMUZd0DfSxsnpDJ1WJg0n6lMoxX9sNow1e?=
 =?us-ascii?Q?ECLall/AskDqDrMwd3xuHCH3O4H25w7DQ6lB0XhbQLlSrS4GLb/tuOdFw08o?=
 =?us-ascii?Q?ReO/+K/kzIIumSncBSvUPFjBwIMnSZaHpmbCnMeF+ggNZQrWIi98ohrjUxaH?=
 =?us-ascii?Q?8eymZxzCOgJtnhJ8VI30RkilgS6zw0fbNh4gfZw1lqELoX+wZEG3po2f0bDg?=
 =?us-ascii?Q?Jif7uw33N8FtHyHItvKg1lxjHH2oW2PFcH9JL7kiQ7D0PYUx/MWxiB1pt1Fq?=
 =?us-ascii?Q?ff/G1nZoech6MF82m4eTIoVIfL9v2ai3H0w9UGDLUrl1vwBfx5FMPXVoY1qh?=
 =?us-ascii?Q?1TI3ZIXf9SKHWU+ytkXaDNi7uO2FFXraY9DtShB3aqeKP/ABsRXu7NwtyvUA?=
 =?us-ascii?Q?PhH4qigZuA6ADjjLHqVQ54OcVq852tX5xRAiLlwhmI4p5Uy3qAKhY6h7u9jZ?=
 =?us-ascii?Q?0k6WHlLAcmaJFvjYJmmuKaQjcEE9JpwTJEiFuBe7rRY8nw82pW6IkZQ865SI?=
 =?us-ascii?Q?1K40vTW0fS7iTtwX1i2U4v1VcKLYICS2K8IWvtZvPfjc3Z4aQKAIEORULe+q?=
 =?us-ascii?Q?7t1PJnJE2rENHNffwHX+xQwzP3iSIyg4rn00vxoqgkegEb/xL0SMbrzDnkLJ?=
 =?us-ascii?Q?LW34ax2dMq40dZ9woGEBGUlF21WE0dPCrLDjPgEQnQRGyb9bU3GxCxM3Sjsv?=
 =?us-ascii?Q?WAae9C/NMMirJJo+1EsCcWTvx1ZkEVF10MYEeoUUPsOBEfoD7qWngi/RsJMq?=
 =?us-ascii?Q?Yq4G8tSUShwibQ492Eu1bHfE4PdwjWStKa2NI0xr3WWgijl6EuDHrg7CdZEF?=
 =?us-ascii?Q?oY+GBTZ/4Y0IjxKS1T3c/URjIZNqCG8EXkTCAxyK0leQPazTnHp0lsqelXbh?=
 =?us-ascii?Q?SppjuQF55wTK0yx30zSXWcGY3tDi+jZA0vT3pMUPu+W7Xn5ndvgZdlG6JVRp?=
 =?us-ascii?Q?8h/TDy2eP0Z2Yk4E6Khu78u+W8CLQT/Xpw+6esvZDGxFV9Qv3WuMkYXwRbCq?=
 =?us-ascii?Q?kKPCoiOjm7Gw0K4WogvBvsVyCpUtEJ+WAK1RDvOvtQBVOT1GoTtp59a2Cku+?=
 =?us-ascii?Q?RmuH/fPeCzAePfkN36/f1uBzRFL+1iMLwJDtqL24QxIzeo791Y5q4TXE7n8U?=
 =?us-ascii?Q?NWPBbnp+glxklZeWsRcSmAuGIsXkak1AucyHnjKZZ1o/w4ofOlo98PxdOrYh?=
 =?us-ascii?Q?UW5dZlz55BrCp5xyFbwpjgrgnV2JlYhZX2AygOuVHZePryZ7llnyX2dh9WwV?=
 =?us-ascii?Q?K3kuc9Asnhf0i2k=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2025 08:37:24.6503 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 14f86e72-08c9-41ac-de20-08dd76789657
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB58.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7318
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

This patch refactors the SDMA v5.0 reset logic by splitting the `sdma_v5_0_reset_queue` function into two separate functions: `sdma_v5_0_stop_queue` and `sdma_v5_0_restore_queue`.
 This change aligns with the new SDMA reset mechanism, where the reset process is divided into stopping the queue, performing the reset, and restoring the queue.

    1. **Split `sdma_v5_0_reset_queue`**:
       - Extracted the queue stopping logic into `sdma_v5_0_stop_queue`.
       - Extracted the queue restoration logic into `sdma_v5_0_restore_queue`.
       - The soft reset step is now handled by the caller (`amdgpu_sdma_reset_engine`).

    2. **Update Ring Functions**:
       - Added `stop_queue` and `start_queue` to the `sdma_v5_0_ring_funcs` structure to support the new reset mechanism.

v2: remove the suspend_user_queues param when calling amdgpu_sdma_reset_engine()
v3: Update stop_queue/start_queue function paramters to use ring pointer instead of device/instance(Christian)
v4: The general coding style is to declare variables like "i" or "r" last. E.g. longest lines first and short lasts.(Chritian)
v5: move stop_queue/start_queue to struct amdgpu_sdma_instance and rename them. (Alex)

Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>
Acked-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c | 43 +++++++++++++++++---------
 1 file changed, 28 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
index 38eee309b27e..5c354552c47f 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
@@ -112,6 +112,8 @@ static void sdma_v5_0_set_ring_funcs(struct amdgpu_device *adev);
 static void sdma_v5_0_set_buffer_funcs(struct amdgpu_device *adev);
 static void sdma_v5_0_set_vm_pte_funcs(struct amdgpu_device *adev);
 static void sdma_v5_0_set_irq_funcs(struct amdgpu_device *adev);
+static int sdma_v5_0_stop_queue(struct amdgpu_ring *ring);
+static int sdma_v5_0_restore_queue(struct amdgpu_ring *ring);
 
 static const struct soc15_reg_golden golden_settings_sdma_5[] = {
 	SOC15_REG_GOLDEN_VALUE(GC, 0, mmSDMA0_CHICKEN_BITS, 0xffbf1f0f, 0x03ab0107),
@@ -1350,6 +1352,8 @@ static int sdma_v5_0_soft_reset_engine(struct amdgpu_device *adev, u32 instance_
 }
 
 static const struct amdgpu_sdma_funcs sdma_v5_0_sdma_funcs = {
+	.stop_kernel_queue = &sdma_v5_0_stop_queue,
+	.start_kernel_queue = &sdma_v5_0_restore_queue,
 	.soft_reset_kernel_queue = &sdma_v5_0_soft_reset_engine,
 };
 
@@ -1537,17 +1541,25 @@ static int sdma_v5_0_soft_reset(struct amdgpu_ip_block *ip_block)
 static int sdma_v5_0_reset_queue(struct amdgpu_ring *ring, unsigned int vmid)
 {
 	struct amdgpu_device *adev = ring->adev;
-	int j, r;
-	u32 f32_cntl, freeze, cntl, preempt, soft_reset, stat1_reg;
-	u32 inst_id;
+	u32 inst_id = ring->me;
+
+	return amdgpu_sdma_reset_engine(adev, inst_id);
+}
+
+static int sdma_v5_0_stop_queue(struct amdgpu_ring *ring)
+{
+	struct amdgpu_device *adev = ring->adev;
+	u32 f32_cntl, freeze, cntl, preempt, stat1_reg;
+	u32 inst_id = ring->me;
+	int j, r = 0;
 
 	if (amdgpu_sriov_vf(adev))
 		return -EINVAL;
-	inst_id = ring->me;
+
 	amdgpu_gfx_rlc_enter_safe_mode(adev, 0);
 
 	/* stop queue */
-	sdma_v5_0_gfx_stop(adev, 1 << ring->me);
+	sdma_v5_0_gfx_stop(adev, inst_id);
 
 	/* engine stop SDMA1_F32_CNTL.HALT to 1 and SDMAx_FREEZE freeze bit to 1 */
 	freeze = RREG32(sdma_v5_0_get_reg_offset(adev, inst_id, mmSDMA0_FREEZE));
@@ -1583,17 +1595,19 @@ static int sdma_v5_0_reset_queue(struct amdgpu_ring *ring, unsigned int vmid)
 	preempt = RREG32(sdma_v5_0_get_reg_offset(adev, inst_id, mmSDMA0_GFX_PREEMPT));
 	preempt = REG_SET_FIELD(preempt, SDMA0_GFX_PREEMPT, IB_PREEMPT, 0);
 	WREG32(sdma_v5_0_get_reg_offset(adev, inst_id, mmSDMA0_GFX_PREEMPT), preempt);
+err0:
+	amdgpu_gfx_rlc_exit_safe_mode(adev, 0);
+	return r;
+}
 
-	soft_reset = RREG32_SOC15(GC, 0, mmGRBM_SOFT_RESET);
-	soft_reset |= 1 << GRBM_SOFT_RESET__SOFT_RESET_SDMA0__SHIFT << inst_id;
-
-	WREG32_SOC15(GC, 0, mmGRBM_SOFT_RESET, soft_reset);
-
-	udelay(50);
-
-	soft_reset &= ~(1 << GRBM_SOFT_RESET__SOFT_RESET_SDMA0__SHIFT << inst_id);
-	WREG32_SOC15(GC, 0, mmGRBM_SOFT_RESET, soft_reset);
+static int sdma_v5_0_restore_queue(struct amdgpu_ring *ring)
+{
+	struct amdgpu_device *adev = ring->adev;
+	u32 inst_id = ring->me;
+	u32 freeze;
+	int r;
 
+	amdgpu_gfx_rlc_enter_safe_mode(adev, 0);
 	/* unfreeze*/
 	freeze = RREG32(sdma_v5_0_get_reg_offset(adev, inst_id, mmSDMA0_FREEZE));
 	freeze = REG_SET_FIELD(freeze, SDMA0_FREEZE, FREEZE, 0);
@@ -1601,7 +1615,6 @@ static int sdma_v5_0_reset_queue(struct amdgpu_ring *ring, unsigned int vmid)
 
 	r = sdma_v5_0_gfx_resume_instance(adev, inst_id, true);
 
-err0:
 	amdgpu_gfx_rlc_exit_safe_mode(adev, 0);
 	return r;
 }
-- 
2.25.1

