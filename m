Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DA20C3600C
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Apr 2025 08:37:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D258710E613;
	Tue,  8 Apr 2025 08:37:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="sqHJDVBx";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2085.outbound.protection.outlook.com [40.107.244.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1821D10E613
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Apr 2025 08:37:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r+kE4SfoUXS49MXPgaavSB6AcmLlz7JTbS5asSW7T3RQUpIuj16y5WKOiH+EcQjGGxx5SMgCKKAaKPsa+gfinlmPXbdOmT7i5mGUw/rMTxnKSoGCVnL0m2nBT2stW7xlnZb6vxGX4s08BMPe9q/vvih5jyX0jzwS94v2IDGfJqgggKBc6tXJhFbo0XcRgTBP8O9EdTxOO7iK1EdKoojwFbqHhhUdkieAoAAxQaKLlLwjrEk50XCyGLgNyeA8B1okXx5dSN6UxgiubFDkdXOU+xbP5HMOiUsL/yi9f6tcozGc9YNKoBvADxgEW4vhs6uUxypWZekZn0otPH+SdbAwXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CR3KeyHqaJqTMX7ewR5g6ky6DzgO5sokKQFXNrixnS8=;
 b=jl6Befeg9gqmh7SS56zEGM1the1wYS1RgeXB2uSB3UKGYDGex1dXZFzBBT8LwtSQCKNrwrjlLmryYtWRLfbklBSYZUS7SqcBMf/XpEly6NM5bzmn5viy90b0iyIt2bC9m3m8FMTlLsUDiPrd0FAQDXD2WOckQT34oeX1aCezP8FMiT8NDMf+NrGPXSKm4LEGuGrsIpnQBzZ370r30AVbWdjxsffr3BEESp+F3IXt07IsZ6J1zUBe+FIsOdnRJ1VXNQxu0v/woQ8+rvmR2UkANZbi5KSPsR1FMkITlcqlwhddD6FC3ulXxm5ZVrMWSVAb/kHFxQny2lchR73QHGPTQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CR3KeyHqaJqTMX7ewR5g6ky6DzgO5sokKQFXNrixnS8=;
 b=sqHJDVBxqdG63G7uuBL1CJBA0R0ab9xMo+wODZ+QWp7lt1FNeyjJIu3aAP6g+atP1XzA+3pUMJPMffuhQotOtscDbIrmiQgHrs7Sm8EESBQZIP/mZ6RvIGgiIulK2U0qyChBxJu8+GFehT1HsEzmkpaQZQOBM1+o//JELQAXmZ8=
Received: from BL1PR13CA0155.namprd13.prod.outlook.com (2603:10b6:208:2bd::10)
 by IA0PR12MB7556.namprd12.prod.outlook.com (2603:10b6:208:43c::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.35; Tue, 8 Apr
 2025 08:37:36 +0000
Received: from BL6PEPF0001AB72.namprd02.prod.outlook.com
 (2603:10b6:208:2bd:cafe::ed) by BL1PR13CA0155.outlook.office365.com
 (2603:10b6:208:2bd::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8632.19 via Frontend Transport; Tue,
 8 Apr 2025 08:37:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BL6PEPF0001AB72.mail.protection.outlook.com (10.167.242.165) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8606.22 via Frontend Transport; Tue, 8 Apr 2025 08:37:35 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 8 Apr
 2025 03:37:32 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 8 Apr
 2025 03:37:31 -0500
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Tue, 8 Apr 2025 03:37:30 -0500
From: "Jesse.zhang@amd.com" <jesse.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 <jonathan.kim@amd.com>, <jiadong.zhu@amd.com>, "Jesse.zhang@amd.com"
 <jesse.zhang@amd.com>
Subject: [v4 6/7] drm/amd/amdgpu: Refactor SDMA v5.2 reset logic into
 stop_queue and restore_queue functions
Date: Tue, 8 Apr 2025 16:36:32 +0800
Message-ID: <20250408083633.2300420-6-jesse.zhang@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB72:EE_|IA0PR12MB7556:EE_
X-MS-Office365-Filtering-Correlation-Id: fd0c32f2-ebd9-47b2-6fa9-08dd76789ce9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?KpKfWEtfik/yET+S1Hg8Xo6cO05FIUffzeyZx26jcbgIGT96b5ywln7th/QS?=
 =?us-ascii?Q?0rO+1cDg/AwJxDGIgf6sNlPRVNS/VL88+BrqRbxp+E98p79loh81jqJgQbo5?=
 =?us-ascii?Q?39OAHWP/E6w8nBg4uhtmgcPwBVYwX+VwVFeeMmfNerdhn3scaKtttbq7o6U/?=
 =?us-ascii?Q?E0OswwO0CrXiS7/k5tFvo/3sGCCb0mEvprthkbUit9pgAU32HAJUka19vIiy?=
 =?us-ascii?Q?pS9WN+fUv5yGgMYXyiqiaxNxW1AlSg7Byib3Um1L/D8Pwl3BmPifyiO5sqhU?=
 =?us-ascii?Q?N8LqAI9ygPrR27zZjHSVB1k0/9Xk9YT70XN0KrqClmv4/WVMLSnZlLUBMdUk?=
 =?us-ascii?Q?n1CFvJ+l5lSqMgCxCU38S2o9vMjaYtp2ArJFg0tv00ll8Avy+8fBeGVn5ZPy?=
 =?us-ascii?Q?wpTXYmE/soZMo93jc6elPtPNmrHAzOvxgttfW6pfFIfiMATtW5LkJXWEVi24?=
 =?us-ascii?Q?yOLGI3Z/oAZxTzau6Z/56P5pF9Lr/eDRTm2ekd8rqMyWf38Ni4MqSF9EjOeL?=
 =?us-ascii?Q?5mhcQ7mpUO7vbCk+gbIw3xqeFhY4IA7pLIUpveemTfQ4aiggCUgBw5huPD2c?=
 =?us-ascii?Q?wxD4mBMzTpUzi+Un6VeFkKYcXXbGmD/cvf/iYSsLsWW31JKJc+bUTuyxWP1F?=
 =?us-ascii?Q?zvJWfqEhtRY+9ti6m5GEywbFJDWiGvIC+mZX2zy+vGqA/8rKI1fIogeGcY1w?=
 =?us-ascii?Q?ZnanPlDG3qN4kLMNL5jZ6OxRHxNq5MsiLAEmA5P0KvSEA7NDOKjYs2aqtl9T?=
 =?us-ascii?Q?53AB3yYABEjr9ysUlz1sy0KzcjgHMDGEz6Xi7J5YENszUWj7Y4sFlD9SdRhT?=
 =?us-ascii?Q?NbD43JDvFqjTgfHY6w2m0pFdnvEEr+RuFsidnzZB8QUO9rhBmgedCyOclBuy?=
 =?us-ascii?Q?Tfz7u2BQXe9LNMaRDF+t53I0hwociJbMB2pYnFMumH6/CFnuQZdXQ0WU+9NC?=
 =?us-ascii?Q?nf++Q0yasgHseHlQTe2IT+uByPDaYEsoAIeful8qwoZ1+Mip1oldy+WKrnnq?=
 =?us-ascii?Q?8g3KPALFJAGKpkzEYqVnkFrwgVHEtGKND+CZYpBC6/rUhu3CBjqZxrh/j2sE?=
 =?us-ascii?Q?Yndc1MClmQhUoBdtLEHXAswxrDUDrtXAhBXcUG1F3nbPwJ3w0J8Ta8xlga3G?=
 =?us-ascii?Q?zEiZYcj5jENyDfHYqbXMKAPw11EXlgXN0M4p12wu9ax33M82z8o1YbSm6r8s?=
 =?us-ascii?Q?z37Ylp1lTHUaoLnGgEwfHauglGeg9kaZEuk4hsZO2CjLa5A6VMykN4T2Vxv6?=
 =?us-ascii?Q?PCDIYcPQOZ8WpIJ6KbvPy6I4rOdUmT0qPtO72mCvoL0Aur6wnF6ZsQxpdGlS?=
 =?us-ascii?Q?xKwaWzERNwkST9uV/dM8/EKbQA+6/dKN71qtWK2ro2eIcIZLR5a6Y5QH+6IA?=
 =?us-ascii?Q?v26WVw3uxq3QmMYEmFhEMkjjH8XCfwX/HMbSXXnFR6r5hMepJBy2X/KqRT7O?=
 =?us-ascii?Q?83KS0wRYz9YLgXC/y7WXfCY3GUJhLBjgxcfO4Iwab5ZE9epRuTkMSXXzybSe?=
 =?us-ascii?Q?V0D5RsthG7i4rFFkg0b12x8WxGmO214REk8F?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2025 08:37:35.6863 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fd0c32f2-ebd9-47b2-6fa9-08dd76789ce9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB72.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7556
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

This patch refactors the SDMA v5.2 reset logic by splitting the `sdma_v5_2_reset_queue` function into two separate functions: `sdma_v5_2_stop_queue` and `sdma_v5_2_restore_queue`.
This change aligns with the new SDMA reset mechanism, where the reset process is divided into stopping the queue, performing the reset, and restoring the queue.

1. **Split `sdma_v5_2_reset_queue`**:
        - Extracted the queue stopping logic into `sdma_v5_2_stop_queue`.
        - Extracted the queue restoration logic into `sdma_v5_2_restore_queue`.
        - The soft reset step is now handled by the caller (`amdgpu_sdma_reset_engine`).

2. **Update Ring Functions**:
        - Added `stop_queue` and `start_queue` to the `sdma_v5_2_ring_funcs` structure to support the new reset mechanism.

v2: remove the suspend_user_queues param when calling amdgpu_sdma_reset_engine()
v3: Update stop_queue/start_queue function paramters to use ring pointer instead of device/instance(Christian)
v4: move stop_queue/start_queue to struct amdgpu_sdma_instance and rename them. (Alex)

Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c | 44 ++++++++++++++++----------
 1 file changed, 27 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
index 6972f5dd63ef..38016fdc094a 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
@@ -113,6 +113,8 @@ static void sdma_v5_2_set_ring_funcs(struct amdgpu_device *adev);
 static void sdma_v5_2_set_buffer_funcs(struct amdgpu_device *adev);
 static void sdma_v5_2_set_vm_pte_funcs(struct amdgpu_device *adev);
 static void sdma_v5_2_set_irq_funcs(struct amdgpu_device *adev);
+static int sdma_v5_2_stop_queue(struct amdgpu_ring *ring);
+static int sdma_v5_2_restore_queue(struct amdgpu_ring *ring);
 
 static u32 sdma_v5_2_get_reg_offset(struct amdgpu_device *adev, u32 instance, u32 internal_offset)
 {
@@ -799,6 +801,8 @@ static int sdma_v5_2_soft_reset(struct amdgpu_ip_block *ip_block)
 }
 
 static const struct amdgpu_sdma_funcs sdma_v5_2_sdma_funcs = {
+	.stop_kernel_queue = &sdma_v5_2_stop_queue,
+	.start_kernel_queue = &sdma_v5_2_restore_queue,
 	.soft_reset_kernel_queue = &sdma_v5_2_soft_reset_engine,
 };
 
@@ -1450,18 +1454,24 @@ static int sdma_v5_2_wait_for_idle(struct amdgpu_ip_block *ip_block)
 static int sdma_v5_2_reset_queue(struct amdgpu_ring *ring, unsigned int vmid)
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
+static int sdma_v5_2_stop_queue(struct amdgpu_ring *ring)
+{
+	u32 f32_cntl, freeze, cntl, preempt, stat1_reg;
+	struct amdgpu_device *adev = ring->adev;
+	u32 inst_id = ring->me;
+	int j, r = 0;
 
 	if (amdgpu_sriov_vf(adev))
 		return -EINVAL;
 
-	inst_id = ring->me;
 	amdgpu_gfx_rlc_enter_safe_mode(adev, 0);
-
 	/* stop queue */
-	sdma_v5_2_gfx_stop(adev, 1 << ring->me);
+	sdma_v5_2_gfx_stop(adev, 1 << inst_id);
 
 	/*engine stop SDMA1_F32_CNTL.HALT to 1 and SDMAx_FREEZE freeze bit to 1 */
 	freeze = RREG32(sdma_v5_2_get_reg_offset(adev, inst_id, mmSDMA0_FREEZE));
@@ -1499,18 +1509,19 @@ static int sdma_v5_2_reset_queue(struct amdgpu_ring *ring, unsigned int vmid)
 	preempt = REG_SET_FIELD(preempt, SDMA0_GFX_PREEMPT, IB_PREEMPT, 0);
 	WREG32(sdma_v5_2_get_reg_offset(adev, inst_id, mmSDMA0_GFX_PREEMPT), preempt);
 
-	soft_reset = RREG32_SOC15(GC, 0, mmGRBM_SOFT_RESET);
-	soft_reset |= 1 << GRBM_SOFT_RESET__SOFT_RESET_SDMA0__SHIFT << inst_id;
-
-
-	WREG32_SOC15(GC, 0, mmGRBM_SOFT_RESET, soft_reset);
-
-	udelay(50);
-
-	soft_reset &= ~(1 << GRBM_SOFT_RESET__SOFT_RESET_SDMA0__SHIFT << inst_id);
+err0:
+	amdgpu_gfx_rlc_exit_safe_mode(adev, 0);
+	return r;
+}
 
-	WREG32_SOC15(GC, 0, mmGRBM_SOFT_RESET, soft_reset);
+static int sdma_v5_2_restore_queue(struct amdgpu_ring *ring)
+{
+	struct amdgpu_device *adev = ring->adev;
+	u32 inst_id = ring->me;
+	u32 freeze;
+	int r;
 
+	amdgpu_gfx_rlc_enter_safe_mode(adev, 0);
 	/* unfreeze and unhalt */
 	freeze = RREG32(sdma_v5_2_get_reg_offset(adev, inst_id, mmSDMA0_FREEZE));
 	freeze = REG_SET_FIELD(freeze, SDMA0_FREEZE, FREEZE, 0);
@@ -1518,7 +1529,6 @@ static int sdma_v5_2_reset_queue(struct amdgpu_ring *ring, unsigned int vmid)
 
 	r = sdma_v5_2_gfx_resume_instance(adev, inst_id, true);
 
-err0:
 	amdgpu_gfx_rlc_exit_safe_mode(adev, 0);
 	return r;
 }
-- 
2.25.1

