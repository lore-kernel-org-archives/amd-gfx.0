Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88F72C83F12
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Jul 2025 19:04:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0B05D10E534;
	Mon,  7 Jul 2025 19:04:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="HgD6G+NH";
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2071.outbound.protection.outlook.com [40.107.102.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CFE4310E536
 for <amd-gfx@lists.freedesktop.org>; Mon,  7 Jul 2025 19:04:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xxYO+hLr/ct64ZHwnjk6SbHjDU0ZFyu2OUEgsm3OD+t9a7kbxW8Y7U+ofB45xckKvdzFFboTkMXxJ6hCCGJmQtKj00EixevA2fB8nIgwzNwM+Z43qMjwoba8n0X0U3PBVUo25W5L8qRvoBAXli5QJa+N147H3ZTrzgeWXUg9/Hj6Yk2gInGLF/HpzjyW+O9Q7izgK7WmsDqD5FXf+MLgAq7/vfyrtEbCs5I8d2Nx9lohB1U/U4M29JAddLLbJcT9jqOoaWSlZkWakRQRowsqIv+fqBu2S55tsLw32Kx6SMTHUEODrbmNSnx8ektnVBv+/0tOmVwTgP9sdC4bG0SqSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wKDmfCcyfLQ5Y0kzwm1smnV4hFyy9Xfi6gYQlEpxNmM=;
 b=I7uZBF+GEFy25BgX9LGD2cDrFw97YQOj1cM5ZL0xcFyNPHOhLS5dI+C0jdOFIlTiF7dRvdTjCMWN3WFksniBogwTcxV7YZNnCXLaK7WZ673h+WhEE+xA5mZmLwyX8Ku1KEY1kLeyN2Z+Vy/r5uG5J1sUC8gsEJkzU8bpH3ypTXb4Ms/gP0TZn+a6OFlPbw5HCpuXqMKBzYx3Rmt5r4rS+m1NixAL7B0tP90DfdHjSIseKR20JQWURbC6qpVnaQVyJ07n5hqPk6SHlBRkm1ebHVaKoQ4p2WTApIhINiPPMWZldG5hgAr8OIH/N/wv01+wgD7zb18kHGmB6CZVNESqkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wKDmfCcyfLQ5Y0kzwm1smnV4hFyy9Xfi6gYQlEpxNmM=;
 b=HgD6G+NHAQHUtyUArnV4no/YnEfxp5824k9bKqrCa+ZxuOHCs56sdbIKwwT/qKk3/AHPeWIgUvClQiz33l+yVu53BXGW0ZfPD3fADKy7DlkNQqOUX+MgBMZwK7r1zkxnt0E8plt6Mj6B89t2zUeCFUxswsESk1Ycpi0StJtvATM=
Received: from PH8PR07CA0039.namprd07.prod.outlook.com (2603:10b6:510:2cf::7)
 by MN0PR12MB6343.namprd12.prod.outlook.com (2603:10b6:208:3c0::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.27; Mon, 7 Jul
 2025 19:04:23 +0000
Received: from CY4PEPF0000EE30.namprd05.prod.outlook.com
 (2603:10b6:510:2cf:cafe::d) by PH8PR07CA0039.outlook.office365.com
 (2603:10b6:510:2cf::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8901.27 via Frontend Transport; Mon,
 7 Jul 2025 19:04:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE30.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8901.15 via Frontend Transport; Mon, 7 Jul 2025 19:04:20 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 7 Jul
 2025 14:04:16 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>,
 <sasundar@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>, Jesse Zhang <Jesse.Zhang@amd.com>
Subject: [PATCH 14/36] drm/amdgpu/gfx10: re-emit unprocessed state on ring
 reset
Date: Mon, 7 Jul 2025 15:03:33 -0400
Message-ID: <20250707190355.837891-15-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250707190355.837891-1-alexander.deucher@amd.com>
References: <20250707190355.837891-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE30:EE_|MN0PR12MB6343:EE_
X-MS-Office365-Filtering-Correlation-Id: ca451838-7f43-4cb7-2d3f-08ddbd891431
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?YJQXiW5LHyaD44FmURlvmi/bpSowDaJMeW8sQrIPSJymP7mCAEKPD0RcT2zt?=
 =?us-ascii?Q?MlHXi0Zl28PyVbFnHR8Gd9AJuZBjp7JNflZpfFq0Vcj9T4wV5D13XBSpYq8n?=
 =?us-ascii?Q?+TZTAW4gLT/Ry1ANB99ZQ3sd4E7tBhFHEowiEKOuU5gfOJvorshlLJSfxPXq?=
 =?us-ascii?Q?Ub5Pa7RVHsUR3lYTUfeGkFhxQVZR0vVUEPeX6ji1+I5qJJmtB5lgr4SQMFPZ?=
 =?us-ascii?Q?stvP1Jxi5l9Bil9kJNrLVR4RStmuOI7wpMvBWfPjwq/XbT/YuSTyEoN7xcfG?=
 =?us-ascii?Q?nQweDG9oC+4jXNnUDLx7CMd9h4hGW0EH8IZOgdHFJLIpbK7+5g1kM089BOuX?=
 =?us-ascii?Q?fN/4KWt07FKBrf454i91koH0a5Gbw3IdET3ZdVPN7POBK6yoGs6zYEO3ryWn?=
 =?us-ascii?Q?/jsN1fvYbl8a0FNu6mbhNeyLPorKQx6WBlwy+uJtYfDYAfiHc+lS2kG5c3Wv?=
 =?us-ascii?Q?gOoDV5iGrVwbMCmiPr5687b0smSdtJa0xhKx560hZWjNENlJaG3rf06ScRGZ?=
 =?us-ascii?Q?N6Dv7y8vPEZZiLhzu1atU4WK3E/3jjetWrRHzXyMXLDuMZZbe1Qds4PCqQOu?=
 =?us-ascii?Q?Tq0oLDgH06gvVKqCEzzYLDvPzeEEg/FHrGvR/GSNcHe1UOk7+zjFAoRiZYHq?=
 =?us-ascii?Q?yJe9CZmXms4sXGYKWmCJD+YGBenIElfke+PcbKoO0j01KSXmTWPWAAmC3wif?=
 =?us-ascii?Q?COk/92ppBZPgHhtvCPOHMLj7SKmWM5g3CYCSn2imU2o40lBQqVkUuI/bpfjn?=
 =?us-ascii?Q?lc1ZVhIs8qbbg2BB5OGnnp+TCzun3yPNH5O1KMBdaYmZh6q7ArHS9Ws0CFRO?=
 =?us-ascii?Q?vAH1t3R8q1kQ3/J2vzqND0DmGq7gSoNrKqmZjuzzavN66LV1FEVqVsMKyotw?=
 =?us-ascii?Q?Sgk09eJ9vMbyOXv90Sy7kdnMyrtGhaJEzQiXXEHwyJuEEbP3+6fSZIjjRuPz?=
 =?us-ascii?Q?aGLARyEYFUBWkkFJ5OcASZQ73w9xjo9oTKC5G99FseG2zeKjC8EALK9JSLUb?=
 =?us-ascii?Q?MH+RoijROqNsxc81nza60FO7JYpoqh3hyB232+AJOTcvKLVNIgEulCrWfRIp?=
 =?us-ascii?Q?5Vw0CFKccFc30Y/hlaJkrVwMN905VNGSL3BT1oA1dIBaaQe3wDKSnLyMkCv2?=
 =?us-ascii?Q?plZqN0yzvxITxyGrTbkc1wQqP/MZqLzwBaLLAgah2TrPVKtT1lHyDZ4u1RIu?=
 =?us-ascii?Q?i0gTawJiKPDLk6Ra2bo6s+T+yaDvPLa1y+XEFy1MqQjUbX/8m7BtoBgRw83J?=
 =?us-ascii?Q?ughq5UE8x6OaCR+q/Uve8GRKe0Iw/dLdUlNRTLFfSdT5yKVWJ5lUNKy0AaFp?=
 =?us-ascii?Q?YTU9/SSBPyCQ3xHW/vBpJ6n3wzSnlvXMyMi8sZlrO0pLAYmQwZhxUfngioRY?=
 =?us-ascii?Q?JVafiN8m601+uiuZmKOZeMsBXjcASjF65xkHHkDAW0KdiUjOAq3cB7G1a2jo?=
 =?us-ascii?Q?TjwK82q8F0ws4YBhR1nzr6rmsYbd5w4U1VIv2goRgOeOLnOQjVqtlErLonCb?=
 =?us-ascii?Q?HvYPz8SDGOjkSMR2jcLYogoHBQIm0ZQP2Wm7?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2025 19:04:20.2540 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ca451838-7f43-4cb7-2d3f-08ddbd891431
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE30.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6343
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

Re-emit the unprocessed state after resetting the queue.
Drop the soft_recovery callbacks as the queue reset replaces
it.

Reviewed-by: Jesse Zhang <Jesse.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 35 +++-----------------------
 1 file changed, 4 insertions(+), 31 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index d739bfb20383e..65429afb33ec3 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -9046,21 +9046,6 @@ static void gfx_v10_0_ring_emit_reg_write_reg_wait(struct amdgpu_ring *ring,
 							   ref, mask);
 }
 
-static void gfx_v10_0_ring_soft_recovery(struct amdgpu_ring *ring,
-					 unsigned int vmid)
-{
-	struct amdgpu_device *adev = ring->adev;
-	uint32_t value = 0;
-
-	value = REG_SET_FIELD(value, SQ_CMD, CMD, 0x03);
-	value = REG_SET_FIELD(value, SQ_CMD, MODE, 0x01);
-	value = REG_SET_FIELD(value, SQ_CMD, CHECK_VMID, 1);
-	value = REG_SET_FIELD(value, SQ_CMD, VM_ID, vmid);
-	amdgpu_gfx_rlc_enter_safe_mode(adev, 0);
-	WREG32_SOC15(GC, 0, mmSQ_CMD, value);
-	amdgpu_gfx_rlc_exit_safe_mode(adev, 0);
-}
-
 static void
 gfx_v10_0_set_gfx_eop_interrupt_state(struct amdgpu_device *adev,
 				      uint32_t me, uint32_t pipe,
@@ -9540,7 +9525,7 @@ static int gfx_v10_0_reset_kgq(struct amdgpu_ring *ring,
 	if (!kiq->pmf || !kiq->pmf->kiq_unmap_queues)
 		return -EINVAL;
 
-	drm_sched_wqueue_stop(&ring->sched);
+	amdgpu_ring_reset_helper_begin(ring, timedout_fence);
 
 	spin_lock_irqsave(&kiq->ring_lock, flags);
 
@@ -9589,12 +9574,7 @@ static int gfx_v10_0_reset_kgq(struct amdgpu_ring *ring,
 	if (r)
 		return r;
 
-	r = amdgpu_ring_test_ring(ring);
-	if (r)
-		return r;
-	amdgpu_fence_driver_force_completion(ring);
-	drm_sched_wqueue_start(&ring->sched);
-	return 0;
+	return amdgpu_ring_reset_helper_end(ring, timedout_fence);
 }
 
 static int gfx_v10_0_reset_kcq(struct amdgpu_ring *ring,
@@ -9613,7 +9593,7 @@ static int gfx_v10_0_reset_kcq(struct amdgpu_ring *ring,
 	if (!kiq->pmf || !kiq->pmf->kiq_unmap_queues)
 		return -EINVAL;
 
-	drm_sched_wqueue_stop(&ring->sched);
+	amdgpu_ring_reset_helper_begin(ring, timedout_fence);
 
 	spin_lock_irqsave(&kiq->ring_lock, flags);
 
@@ -9667,12 +9647,7 @@ static int gfx_v10_0_reset_kcq(struct amdgpu_ring *ring,
 	if (r)
 		return r;
 
-	r = amdgpu_ring_test_ring(ring);
-	if (r)
-		return r;
-	amdgpu_fence_driver_force_completion(ring);
-	drm_sched_wqueue_start(&ring->sched);
-	return 0;
+	return amdgpu_ring_reset_helper_end(ring, timedout_fence);
 }
 
 static void gfx_v10_ip_print(struct amdgpu_ip_block *ip_block, struct drm_printer *p)
@@ -9907,7 +9882,6 @@ static const struct amdgpu_ring_funcs gfx_v10_0_ring_funcs_gfx = {
 	.emit_wreg = gfx_v10_0_ring_emit_wreg,
 	.emit_reg_wait = gfx_v10_0_ring_emit_reg_wait,
 	.emit_reg_write_reg_wait = gfx_v10_0_ring_emit_reg_write_reg_wait,
-	.soft_recovery = gfx_v10_0_ring_soft_recovery,
 	.emit_mem_sync = gfx_v10_0_emit_mem_sync,
 	.reset = gfx_v10_0_reset_kgq,
 	.emit_cleaner_shader = gfx_v10_0_ring_emit_cleaner_shader,
@@ -9948,7 +9922,6 @@ static const struct amdgpu_ring_funcs gfx_v10_0_ring_funcs_compute = {
 	.emit_wreg = gfx_v10_0_ring_emit_wreg,
 	.emit_reg_wait = gfx_v10_0_ring_emit_reg_wait,
 	.emit_reg_write_reg_wait = gfx_v10_0_ring_emit_reg_write_reg_wait,
-	.soft_recovery = gfx_v10_0_ring_soft_recovery,
 	.emit_mem_sync = gfx_v10_0_emit_mem_sync,
 	.reset = gfx_v10_0_reset_kcq,
 	.emit_cleaner_shader = gfx_v10_0_ring_emit_cleaner_shader,
-- 
2.50.0

