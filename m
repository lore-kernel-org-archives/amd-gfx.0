Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFB6AC0219E
	for <amd-gfx@archiver.kernel.org>; Fri, 31 Jan 2025 16:58:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 12EF910E436;
	Fri, 31 Jan 2025 16:58:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="AebJY/XW";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2058.outbound.protection.outlook.com [40.107.236.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D632110E3C1
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 Jan 2025 16:58:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w3HQ+/qLMnq32uZKXtzTkZmJZb2EuVOT0fiE7AUtrG1OnHCElDfmaLRER70Qhc4Ms/b495+cGyb9GHboxmBFjbcgZ0itAE4Ns43Pay9k2aFaBywYd2JTOSLjPZE/sjAYUCP0/HbO6vUk4iPVrWOQXf/ZzgflDfcYZr4xNcHXV2lcu1bBjnFwADy7ApfuaY4AucBdObZ2POUxcUAHMBDkzkmAYzoI2ZQlY7tZ5P/Q2zjiW/Il3u1MPq/8Jk01Po4M+9MynYjKLnknUtQoejJ93fBwmYnAyljH24L/uK6eHaNSx0YS6AEMwDuqrtWFlZBA7AiIR9MKGXdo1ikT7bNZLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hCf5NQmo14yzddXDDFWdHPgbUll20ghRuMd1kUcHyEw=;
 b=PXm3jr6li4KbTSmS06OhaWIXY1cGsjuO87NbrCMxy2UXCJf52g43jW+gFaZwj/2AwaJXbfmun9PUcy2m5908cRWflS5damLKRFAhQLzVHVp9fY0rTbTxI+bBbxh0ODdtbpTVcHkMqudA69RPNpFx0007tgrxqA8QKUDa7FXTksS2pi34EP2n4AFekXhYAomxYTPaI3vDmOtHullhw/XbeIDpsBu+a9LZ7rNzrvvIahrZQqK6BQ/cqhHTef4f//h7i0n4i2UN5v0RNm8UK0r06LO38yznPkwzN2dN8jirlfWIhxIr+AQyAAUe7+kJ9IO0c2yfoJn+jQAkfY6znp/ZAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hCf5NQmo14yzddXDDFWdHPgbUll20ghRuMd1kUcHyEw=;
 b=AebJY/XWva4wqnCwwZEbl6aibBZr9Ay1Apx+GZggzZayOL41JYwplfULFnp3KTrAYa+LBqUYbN5m+gV6Jy752iZctYK+nPIUs68Au9kxSEj/jQRGV/CwLhshDjo/ulLxu4LjGqm7BqbsRXpzBZyzlQ2YUKxazObxf1Xr94LvdII=
Received: from CH5P220CA0022.NAMP220.PROD.OUTLOOK.COM (2603:10b6:610:1ef::28)
 by PH7PR12MB5711.namprd12.prod.outlook.com (2603:10b6:510:1e2::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.18; Fri, 31 Jan
 2025 16:58:14 +0000
Received: from DS2PEPF0000343F.namprd02.prod.outlook.com
 (2603:10b6:610:1ef:cafe::1d) by CH5P220CA0022.outlook.office365.com
 (2603:10b6:610:1ef::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.21 via Frontend Transport; Fri,
 31 Jan 2025 16:58:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF0000343F.mail.protection.outlook.com (10.167.18.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8398.14 via Frontend Transport; Fri, 31 Jan 2025 16:58:13 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 31 Jan
 2025 10:58:07 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 13/44] drm/amdgpu/vcn1.0: convert internal functions to use
 vcn_inst
Date: Fri, 31 Jan 2025 11:57:09 -0500
Message-ID: <20250131165741.1798488-14-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250131165741.1798488-1-alexander.deucher@amd.com>
References: <20250131165741.1798488-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343F:EE_|PH7PR12MB5711:EE_
X-MS-Office365-Filtering-Correlation-Id: b6e7316c-6f0c-4cbf-f759-08dd4218734e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?UGbAnhnCxbB8CTde7xRXgA+wlXmxLzNn6OfAxmIcpcf7b9dfuFx8+G0SVRld?=
 =?us-ascii?Q?cmwmrhlMASiW+cCcqHNbEaOPMOGKSbm+PX7A+lQaFK6gxjAhq9Q14x2Fmdoo?=
 =?us-ascii?Q?j/zpeuhi+i4oqjKibx4MCUohhoopvQmU8DmoRLqRZNKvsiGA4YcEzYQ9clK7?=
 =?us-ascii?Q?RFtL8m9/kEEaFbZ6ks2UctHO/CmuI1OB96XmndCKfcockILW+GoXQs8czP2+?=
 =?us-ascii?Q?vRRo0kcF7M9MYZ/Q8y1PjLqBQGdZz2HBXw6o01+rkxh5tAMfEJ8eSwchjVqM?=
 =?us-ascii?Q?+WdA3Rrb7YKxV++Ju1nHVAzxVSYeWubXW83ZcXtrERNENcPlA+4rEmPBOjII?=
 =?us-ascii?Q?U+4ZeDkycgs/OEvgR3S+71NB0121OsVinJK8azqNIN1ud66RDTBYmfulFOvd?=
 =?us-ascii?Q?/wzybaKcqMxJtHXiKAHtFQ8ijW5e4gl6AOMdo/pQLFSHCeGaD7uoasYQa5tS?=
 =?us-ascii?Q?zUiMT7YyWrf5qFVHtj8FdtQ6J0wez5SOIQEK6wmTpWwYVyxLCBXCnsvrc+0v?=
 =?us-ascii?Q?7oUWhR0nGSe8+52MXxYLFD+fdFXItV9wwqIWjfSKvwfLzxzZYDcLVf3henjJ?=
 =?us-ascii?Q?YHDYLUskn+fKMqyVnaSngjp9Sl4l2zsQDxuTm7tunYQdnFA3XTAYGum9fvWs?=
 =?us-ascii?Q?BQDyTxIp63dopqXRGNYF3o1yamNQVe38uCsGQ4fSRWdT5JbC18kChl8I7MJB?=
 =?us-ascii?Q?4jGfYRtVcUqMnYO2VT6+MHV/BeqlXyYbKR29mOp5kEV7Rj/fhvFYX32TqTOk?=
 =?us-ascii?Q?Bae2crNNVCeGxA+k79096VXV5t5kH4BcYv5RwB4n7gQozEm2rXyD438StPcT?=
 =?us-ascii?Q?nz183rjAv2E+uk/LrqWMHkbzpLhNVZaeEz+qs/kS2ZXeJLAZUYtLW91IJTJ5?=
 =?us-ascii?Q?TkEFeMWp+p6x5oVpSbULI8mD0CrBaXePpwH3hAs8BVSicNZwThpFYpDrxV04?=
 =?us-ascii?Q?X+emqb9Of8AerC+HLG65VPy8oQlp0AinA97pk3OsgV2BrmPjyXfIn8ay+fFb?=
 =?us-ascii?Q?NMNFWwFBeBfln3VvczTKM79rIwFSLzRRNP1eqM+iZtN9MZgzvR07EEi8MQsK?=
 =?us-ascii?Q?L8L5CLDQyZXWof4NN49OFY9Bf34+USWJj2vmbNavUS4sbz1f7/27fWFJ4MlL?=
 =?us-ascii?Q?lBq4yg/9a3t2yXAUBdFgWGYUC/Rhgq+xPMjaX3moM/+NMSghAMXaMYuiUfx4?=
 =?us-ascii?Q?mHAk//Urs2c/XL/SWkSsZIDkZCyKvEUGSjmC7QTRcjddBZxn4w7XgYoVuchZ?=
 =?us-ascii?Q?MF1Ty39RCX6rs/GrJQpIQDO3O+fCphZmUgdIH0QxUkSvAVYyBMD4i8n2p+LI?=
 =?us-ascii?Q?7kxgG2Gjn2BXn4poQzbDh++m7bxmkyWsXjkZE7DlWYB2CQMrRXRwTEyWGUfb?=
 =?us-ascii?Q?QnkEPeXun+UMBsCiH9mAc4okiz08K7higrg/k+m3E+BwjHjEtT/06bNLq09P?=
 =?us-ascii?Q?NLTcJNQAA1HQ7fiGsEX8qCD9q263vKt+gy/UZcIf6mL39cWyQ89l7g=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2025 16:58:13.6587 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b6e7316c-6f0c-4cbf-f759-08dd4218734e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF0000343F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5711
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

Pass the vcn instance structure to these functions rather
than adev and the instance number.

TODO: clean up the function internals to use the vinst state
directly rather than accessing it indirectly via adev->vcn.inst[].

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c | 85 ++++++++++++++++-----------
 1 file changed, 51 insertions(+), 34 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
index f74767843e85d..613f17be9d829 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
@@ -81,7 +81,7 @@ static const struct amdgpu_hwip_reg_entry vcn_reg_list_1_0[] = {
 	SOC15_REG_ENTRY_STR(VCN, 0, mmUVD_DPG_PAUSE)
 };
 
-static int vcn_v1_0_stop(struct amdgpu_device *adev);
+static int vcn_v1_0_stop(struct amdgpu_vcn_inst *vinst);
 static void vcn_v1_0_set_dec_ring_funcs(struct amdgpu_device *adev);
 static void vcn_v1_0_set_enc_ring_funcs(struct amdgpu_device *adev);
 static void vcn_v1_0_set_irq_funcs(struct amdgpu_device *adev);
@@ -339,12 +339,13 @@ static int vcn_v1_0_resume(struct amdgpu_ip_block *ip_block)
 /**
  * vcn_v1_0_mc_resume_spg_mode - memory controller programming
  *
- * @adev: amdgpu_device pointer
+ * @vinst: VCN instance
  *
  * Let the VCN memory controller know it's offsets
  */
-static void vcn_v1_0_mc_resume_spg_mode(struct amdgpu_device *adev)
+static void vcn_v1_0_mc_resume_spg_mode(struct amdgpu_vcn_inst *vinst)
 {
+	struct amdgpu_device *adev = vinst->adev;
 	uint32_t size = AMDGPU_GPU_PAGE_ALIGN(adev->vcn.inst[0].fw->size + 4);
 	uint32_t offset;
 
@@ -410,8 +411,9 @@ static void vcn_v1_0_mc_resume_spg_mode(struct amdgpu_device *adev)
 			adev->gfx.config.gb_addr_config);
 }
 
-static void vcn_v1_0_mc_resume_dpg_mode(struct amdgpu_device *adev)
+static void vcn_v1_0_mc_resume_dpg_mode(struct amdgpu_vcn_inst *vinst)
 {
+	struct amdgpu_device *adev = vinst->adev;
 	uint32_t size = AMDGPU_GPU_PAGE_ALIGN(adev->vcn.inst[0].fw->size + 4);
 	uint32_t offset;
 
@@ -485,12 +487,13 @@ static void vcn_v1_0_mc_resume_dpg_mode(struct amdgpu_device *adev)
 /**
  * vcn_v1_0_disable_clock_gating - disable VCN clock gating
  *
- * @adev: amdgpu_device pointer
+ * @vinst: VCN instance
  *
  * Disable clock gating for VCN block
  */
-static void vcn_v1_0_disable_clock_gating(struct amdgpu_device *adev)
+static void vcn_v1_0_disable_clock_gating(struct amdgpu_vcn_inst *vinst)
 {
+	struct amdgpu_device *adev = vinst->adev;
 	uint32_t data;
 
 	/* JPEG disable CGC */
@@ -615,8 +618,9 @@ static void vcn_v1_0_disable_clock_gating(struct amdgpu_device *adev)
  *
  * Enable clock gating for VCN block
  */
-static void vcn_v1_0_enable_clock_gating(struct amdgpu_device *adev)
+static void vcn_v1_0_enable_clock_gating(struct amdgpu_vcn_inst *vinst)
 {
+	struct amdgpu_device *adev = vinst->adev;
 	uint32_t data = 0;
 
 	/* enable JPEG CGC */
@@ -680,8 +684,10 @@ static void vcn_v1_0_enable_clock_gating(struct amdgpu_device *adev)
 	WREG32_SOC15(VCN, 0, mmUVD_SUVD_CGC_CTRL, data);
 }
 
-static void vcn_v1_0_clock_gating_dpg_mode(struct amdgpu_device *adev, uint8_t sram_sel)
+static void vcn_v1_0_clock_gating_dpg_mode(struct amdgpu_vcn_inst *vinst,
+					   uint8_t sram_sel)
 {
+	struct amdgpu_device *adev = vinst->adev;
 	uint32_t reg_data = 0;
 
 	/* disable JPEG CGC */
@@ -734,8 +740,9 @@ static void vcn_v1_0_clock_gating_dpg_mode(struct amdgpu_device *adev, uint8_t s
 	WREG32_SOC15_DPG_MODE_1_0(UVD, 0, mmUVD_SUVD_CGC_CTRL, 0, 0xFFFFFFFF, sram_sel);
 }
 
-static void vcn_1_0_disable_static_power_gating(struct amdgpu_device *adev)
+static void vcn_1_0_disable_static_power_gating(struct amdgpu_vcn_inst *vinst)
 {
+	struct amdgpu_device *adev = vinst->adev;
 	uint32_t data = 0;
 
 	if (adev->pg_flags & AMD_PG_SUPPORT_VCN) {
@@ -779,8 +786,9 @@ static void vcn_1_0_disable_static_power_gating(struct amdgpu_device *adev)
 	WREG32_SOC15(VCN, 0, mmUVD_POWER_STATUS, data);
 }
 
-static void vcn_1_0_enable_static_power_gating(struct amdgpu_device *adev)
+static void vcn_1_0_enable_static_power_gating(struct amdgpu_vcn_inst *vinst)
 {
+	struct amdgpu_device *adev = vinst->adev;
 	uint32_t data = 0;
 
 	if (adev->pg_flags & AMD_PG_SUPPORT_VCN) {
@@ -823,12 +831,13 @@ static void vcn_1_0_enable_static_power_gating(struct amdgpu_device *adev)
 /**
  * vcn_v1_0_start_spg_mode - start VCN block
  *
- * @adev: amdgpu_device pointer
+ * @vinst: VCN instance
  *
  * Setup and start the VCN block
  */
-static int vcn_v1_0_start_spg_mode(struct amdgpu_device *adev)
+static int vcn_v1_0_start_spg_mode(struct amdgpu_vcn_inst *vinst)
 {
+	struct amdgpu_device *adev = vinst->adev;
 	struct amdgpu_ring *ring = &adev->vcn.inst->ring_dec;
 	uint32_t rb_bufsz, tmp;
 	uint32_t lmi_swap_cntl;
@@ -837,13 +846,13 @@ static int vcn_v1_0_start_spg_mode(struct amdgpu_device *adev)
 	/* disable byte swapping */
 	lmi_swap_cntl = 0;
 
-	vcn_1_0_disable_static_power_gating(adev);
+	vcn_1_0_disable_static_power_gating(vinst);
 
 	tmp = RREG32_SOC15(UVD, 0, mmUVD_STATUS) | UVD_STATUS__UVD_BUSY;
 	WREG32_SOC15(UVD, 0, mmUVD_STATUS, tmp);
 
 	/* disable clock gating */
-	vcn_v1_0_disable_clock_gating(adev);
+	vcn_v1_0_disable_clock_gating(vinst);
 
 	/* disable interupt */
 	WREG32_P(SOC15_REG_OFFSET(UVD, 0, mmUVD_MASTINT_EN), 0,
@@ -885,7 +894,7 @@ static int vcn_v1_0_start_spg_mode(struct amdgpu_device *adev)
 		(0x1 << UVD_MPC_SET_MUX__SET_1__SHIFT) |
 		(0x2 << UVD_MPC_SET_MUX__SET_2__SHIFT)));
 
-	vcn_v1_0_mc_resume_spg_mode(adev);
+	vcn_v1_0_mc_resume_spg_mode(vinst);
 
 	WREG32_SOC15(UVD, 0, mmUVD_REG_XX_MASK_1_0, 0x10);
 	WREG32_SOC15(UVD, 0, mmUVD_RBC_XX_IB_REG_CHECK_1_0,
@@ -1001,8 +1010,9 @@ static int vcn_v1_0_start_spg_mode(struct amdgpu_device *adev)
 	return 0;
 }
 
-static int vcn_v1_0_start_dpg_mode(struct amdgpu_device *adev)
+static int vcn_v1_0_start_dpg_mode(struct amdgpu_vcn_inst *vinst)
 {
+	struct amdgpu_device *adev = vinst->adev;
 	struct amdgpu_ring *ring = &adev->vcn.inst->ring_dec;
 	uint32_t rb_bufsz, tmp;
 	uint32_t lmi_swap_cntl;
@@ -1010,7 +1020,7 @@ static int vcn_v1_0_start_dpg_mode(struct amdgpu_device *adev)
 	/* disable byte swapping */
 	lmi_swap_cntl = 0;
 
-	vcn_1_0_enable_static_power_gating(adev);
+	vcn_1_0_enable_static_power_gating(vinst);
 
 	/* enable dynamic power gating mode */
 	tmp = RREG32_SOC15(UVD, 0, mmUVD_POWER_STATUS);
@@ -1019,7 +1029,7 @@ static int vcn_v1_0_start_dpg_mode(struct amdgpu_device *adev)
 	WREG32_SOC15(UVD, 0, mmUVD_POWER_STATUS, tmp);
 
 	/* enable clock gating */
-	vcn_v1_0_clock_gating_dpg_mode(adev, 0);
+	vcn_v1_0_clock_gating_dpg_mode(vinst, 0);
 
 	/* enable VCPU clock */
 	tmp = (0xFF << UVD_VCPU_CNTL__PRB_TIMEOUT_VAL__SHIFT);
@@ -1068,7 +1078,7 @@ static int vcn_v1_0_start_dpg_mode(struct amdgpu_device *adev)
 		 (0x1 << UVD_MPC_SET_MUX__SET_1__SHIFT) |
 		 (0x2 << UVD_MPC_SET_MUX__SET_2__SHIFT)), 0xFFFFFFFF, 0);
 
-	vcn_v1_0_mc_resume_dpg_mode(adev);
+	vcn_v1_0_mc_resume_dpg_mode(vinst);
 
 	WREG32_SOC15_DPG_MODE_1_0(UVD, 0, mmUVD_REG_XX_MASK, 0x10, 0xFFFFFFFF, 0);
 	WREG32_SOC15_DPG_MODE_1_0(UVD, 0, mmUVD_RBC_XX_IB_REG_CHECK, 0x3, 0xFFFFFFFF, 0);
@@ -1085,7 +1095,7 @@ static int vcn_v1_0_start_dpg_mode(struct amdgpu_device *adev)
 	WREG32_SOC15_DPG_MODE_1_0(UVD, 0, mmUVD_MASTINT_EN,
 			UVD_MASTINT_EN__VCPU_EN_MASK, UVD_MASTINT_EN__VCPU_EN_MASK, 0);
 
-	vcn_v1_0_clock_gating_dpg_mode(adev, 1);
+	vcn_v1_0_clock_gating_dpg_mode(vinst, 1);
 	/* setup mmUVD_LMI_CTRL */
 	WREG32_SOC15_DPG_MODE_1_0(UVD, 0, mmUVD_LMI_CTRL,
 		(8 << UVD_LMI_CTRL__WRITE_CLEAN_TIMER__SHIFT) |
@@ -1145,21 +1155,24 @@ static int vcn_v1_0_start_dpg_mode(struct amdgpu_device *adev)
 	return 0;
 }
 
-static int vcn_v1_0_start(struct amdgpu_device *adev)
+static int vcn_v1_0_start(struct amdgpu_vcn_inst *vinst)
 {
+	struct amdgpu_device *adev = vinst->adev;
+
 	return (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) ?
-		vcn_v1_0_start_dpg_mode(adev) : vcn_v1_0_start_spg_mode(adev);
+		vcn_v1_0_start_dpg_mode(vinst) : vcn_v1_0_start_spg_mode(vinst);
 }
 
 /**
  * vcn_v1_0_stop_spg_mode - stop VCN block
  *
- * @adev: amdgpu_device pointer
+ * @vinst: VCN instance
  *
  * stop the VCN block
  */
-static int vcn_v1_0_stop_spg_mode(struct amdgpu_device *adev)
+static int vcn_v1_0_stop_spg_mode(struct amdgpu_vcn_inst *vinst)
 {
+	struct amdgpu_device *adev = vinst->adev;
 	int tmp;
 
 	SOC15_WAIT_ON_RREG(UVD, 0, mmUVD_STATUS, UVD_STATUS__IDLE, 0x7);
@@ -1199,13 +1212,14 @@ static int vcn_v1_0_stop_spg_mode(struct amdgpu_device *adev)
 
 	WREG32_SOC15(UVD, 0, mmUVD_STATUS, 0);
 
-	vcn_v1_0_enable_clock_gating(adev);
-	vcn_1_0_enable_static_power_gating(adev);
+	vcn_v1_0_enable_clock_gating(vinst);
+	vcn_1_0_enable_static_power_gating(vinst);
 	return 0;
 }
 
-static int vcn_v1_0_stop_dpg_mode(struct amdgpu_device *adev)
+static int vcn_v1_0_stop_dpg_mode(struct amdgpu_vcn_inst *vinst)
 {
+	struct amdgpu_device *adev = vinst->adev;
 	uint32_t tmp;
 
 	/* Wait for power status to be UVD_POWER_STATUS__UVD_POWER_STATUS_TILES_OFF */
@@ -1237,14 +1251,15 @@ static int vcn_v1_0_stop_dpg_mode(struct amdgpu_device *adev)
 	return 0;
 }
 
-static int vcn_v1_0_stop(struct amdgpu_device *adev)
+static int vcn_v1_0_stop(struct amdgpu_vcn_inst *vinst)
 {
+	struct amdgpu_device *adev = vinst->adev;
 	int r;
 
 	if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG)
-		r = vcn_v1_0_stop_dpg_mode(adev);
+		r = vcn_v1_0_stop_dpg_mode(vinst);
 	else
-		r = vcn_v1_0_stop_spg_mode(adev);
+		r = vcn_v1_0_stop_spg_mode(vinst);
 
 	return r;
 }
@@ -1399,16 +1414,17 @@ static int vcn_v1_0_set_clockgating_state(struct amdgpu_ip_block *ip_block,
 					  enum amd_clockgating_state state)
 {
 	struct amdgpu_device *adev = ip_block->adev;
+	struct amdgpu_vcn_inst *vinst = adev->vcn.inst;
 	bool enable = (state == AMD_CG_STATE_GATE);
 
 	if (enable) {
 		/* wait for STATUS to clear */
 		if (!vcn_v1_0_is_idle(adev))
 			return -EBUSY;
-		vcn_v1_0_enable_clock_gating(adev);
+		vcn_v1_0_enable_clock_gating(vinst);
 	} else {
 		/* disable HW gating and enable Sw gating */
-		vcn_v1_0_disable_clock_gating(adev);
+		vcn_v1_0_disable_clock_gating(vinst);
 	}
 	return 0;
 }
@@ -1812,14 +1828,15 @@ static int vcn_v1_0_set_powergating_state(struct amdgpu_ip_block *ip_block,
 	 */
 	int ret;
 	struct amdgpu_device *adev = ip_block->adev;
+	struct amdgpu_vcn_inst *vinst = adev->vcn.inst;
 
 	if (state == adev->vcn.inst[0].cur_state)
 		return 0;
 
 	if (state == AMD_PG_STATE_GATE)
-		ret = vcn_v1_0_stop(adev);
+		ret = vcn_v1_0_stop(vinst);
 	else
-		ret = vcn_v1_0_start(adev);
+		ret = vcn_v1_0_start(vinst);
 
 	if (!ret)
 		adev->vcn.inst[0].cur_state = state;
-- 
2.48.1

