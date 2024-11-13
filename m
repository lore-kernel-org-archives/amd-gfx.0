Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9363D637CB
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Nov 2024 21:45:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9897110E2EA;
	Wed, 13 Nov 2024 21:45:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="I0Z3Znxi";
	dkim-atps=neutral
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2080.outbound.protection.outlook.com [40.107.101.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DB32710E2EA
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Nov 2024 21:45:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XKFCQgpWkqnqhlPltDJkLeqLxLoXufRsFwMOp1hYmsVtNEvaa3KFCUwW0MfkZH4YhY8tBEQzaYX+9m2GbPJJpaQUEPPxcZKhSAxSZrKBFi8UX8G1cabpPyr5M4M7+e7LJJDfABqWIvTejeRP6s2iohQvpgVFlH1b8JYzO/cKsxLNh3JyHkeG37q4PzTL3bpPwEXFJwqfXpGo1CNuuOVWA+2mCEGGxGGC9efUtAHsWAnQxH9wnEnZj0er3ozs2we2CwBdxI3oJJ31vQ3umoyQ6rjGV1Kjs3IgoS9f1Tj8eKE+M+2v5BQjZiMw6nRGTlxtdX6u7h74i1G3CGLf0ZHY6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XlnH6SBQL00BdUbFy7H2PIdQexBxM18Bwi3LBzLpwdQ=;
 b=sJFSFWwULhT5A4PJwh8D8Y5EdhJ7qHnfPmrzcbYNXdr6aDK+h2KNKuZ2oNrw18sGjWOv27KZ9DxufjRw/BICmA0R03gb7veWfrLwVTV9AccV+AZQA6nYRf3X5u54LLMcPjtqRZYjQY1jTsxTKClNfqwoMPk4CBYYXV25X67Ev7UX9Qk0tkvAd7trneSK21LCWdGx8gUKTi+GdrA60T0fHIPcYtaCpxc/a77zBuRD1In9dDEQpo/DsrHUNJEmajo73FTWZoTcBi16t8jgL7RtTa0Xd3a+Bq4LHrvZ6Axie+r9PMAK9gZRVAgfOazeYXDGciAPI3n/1dIRK2SpRCl08Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XlnH6SBQL00BdUbFy7H2PIdQexBxM18Bwi3LBzLpwdQ=;
 b=I0Z3ZnxiBvWE2omONZDGnOy8EnR6TP6IEfdQC2m1ztoi3WmVDZkTgDbi3m2lnKeFdlt+5SgXIrxK9kDq+NJR2G4O1IJYTh/UsZyvCFapaGl2z1E19e0CLu4zEnpjH5IH6T9jIXi4rmcDbz+BtKfzXfYXWoukiRcUErLQMhNl5+E=
Received: from BYAPR11CA0079.namprd11.prod.outlook.com (2603:10b6:a03:f4::20)
 by SN7PR12MB6885.namprd12.prod.outlook.com (2603:10b6:806:263::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.28; Wed, 13 Nov
 2024 21:45:16 +0000
Received: from SJ1PEPF00001CE3.namprd05.prod.outlook.com
 (2603:10b6:a03:f4:cafe::c5) by BYAPR11CA0079.outlook.office365.com
 (2603:10b6:a03:f4::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.16 via Frontend
 Transport; Wed, 13 Nov 2024 21:45:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CE3.mail.protection.outlook.com (10.167.242.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8158.14 via Frontend Transport; Wed, 13 Nov 2024 21:45:15 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 13 Nov
 2024 15:45:10 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 08/15] drm/amdgpu/vcn4.0.3: split code along instances
Date: Wed, 13 Nov 2024 16:44:44 -0500
Message-ID: <20241113214453.17081-9-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241113214453.17081-1-alexander.deucher@amd.com>
References: <20241113214453.17081-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE3:EE_|SN7PR12MB6885:EE_
X-MS-Office365-Filtering-Correlation-Id: bda577f2-4d15-4d47-b345-08dd042c75ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?oTR/2Z8VAZr7tglalviVtlE6NQ3CNQ3SReqRR5uGnMNS28/YFHsoAiH4nB1g?=
 =?us-ascii?Q?vQiSqvMFEojkw6AhFV5lMjxCMFf4Cidv5dv2u5tZ/RmKRXFmWnjUxZQNPpwE?=
 =?us-ascii?Q?Z/myqTRQo1R4RUmSkiXNm96W401jOp1y6KayskLwpqKVpoTiD5k/63WasMyk?=
 =?us-ascii?Q?Qx8IfjVftJtNExFos/rcQdOQ4KpOdTS6M8YoGNk+Cru+3jvLAZb9E29iDBKr?=
 =?us-ascii?Q?+GLh8ptHR1SMW2DwXkD1bYfdKsFSMMOotbcDQYIoPR1jaxeU5AOdfqQ4YWlT?=
 =?us-ascii?Q?UPhI+eB6r0J7EztXCZtASE8tn30mRNqiYM9g+/NVGnmfLW0DFON//vFhjdxr?=
 =?us-ascii?Q?QY5/5NeF58Xtg5KUCI9CPDiww4sEE8hugvNggtVht4zxXYz9/4/m3ECzj2ed?=
 =?us-ascii?Q?UujoCZSsXZTLt/HA8nKRSLYOTv334qlGu8kaKBO6ZuHPx7/yUJ9uhCbcg4hJ?=
 =?us-ascii?Q?zcBkhO7RyxCcRmKXJOokkTaqWSjmbp0Y42m/XHdwU6wJjYym9NwyvJEnRuWq?=
 =?us-ascii?Q?AQ4/bd70X+/Chxp6tbNS8BPLHs2s3EvLBTZI3+nnIFZSZB64pKtD1vjZ6JeD?=
 =?us-ascii?Q?0vddZefyEuqy62s/C0CCjcMr8vrlf8eRux3FRxyBnoSA0AfIqrLsa3Qu5X5W?=
 =?us-ascii?Q?+cHrP8DJN7EgbDXMvK3MONA645qgKgY2aTWWiQ5+r7IbWxymznyFWe06yDA2?=
 =?us-ascii?Q?/Ux7NB09eUyGZnjqEfUYhDIFn3buwIz4nFO1HthIadqLKLiBqv0Ehhf1HRTW?=
 =?us-ascii?Q?R86WW7AutUORA7E5/2VmsifXH+s2Z2sBuKQSYXK0IqnpJ8rAzfq9Afdes10w?=
 =?us-ascii?Q?tDp/DEPoffbYuFULG8TWL2vHw2suvhCGX2KUSWkLgHEI/X/2EUY+88Og9IrO?=
 =?us-ascii?Q?Rp/xZgDwXPxxeaqtGpMjJvN/NEnk+jusf7nTulkj00bSsUBhMpstHyXMKEGD?=
 =?us-ascii?Q?YS2XjCJxJRBJ1iYZHMHAnkPJpHlS6CcKyYOlsc1VOP6MFyVhEdph0JwHbaD9?=
 =?us-ascii?Q?3ITpk0tBiQl4I7+3K0HMuICN5I6CvHSsrrTXskpR32hXeTa9I8uFAn+9Hsif?=
 =?us-ascii?Q?5Wk7ODAmAcA9uwFEalczB0sTsX1LYuxibeLyMPX9znQsGVGN3dtmenjKzQZl?=
 =?us-ascii?Q?Eg88RVHqPmW7ixClBfOBtDDRWMM5MbfJdj7RhsY08ohMbsuEk7MuAsdXvRzl?=
 =?us-ascii?Q?e3aG6Ud7TuCNx3MbiozKDlVbokE8WA3YIEENWn71S9nQT66zFKFyNb3oFbic?=
 =?us-ascii?Q?LRIgAoEj/jVQACEaLW1A2dEMD1cQcMf8EYjSACA3+ki/kyTtwhMllRZVHirJ?=
 =?us-ascii?Q?KwH0gj/N6wZZOAtbT01MACYiY3lr7FAZ6knBxpyGVro9Xl5LxrnTVnJTsdLY?=
 =?us-ascii?Q?AgDbSKjm3gVOxJgKT+3YjQOW1c73N+yRX5ZX1Zo+bGmRH2v1rA=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2024 21:45:15.7693 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bda577f2-4d15-4d47-b345-08dd042c75ef
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CE3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6885
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

Split the code on a per instance basis.  This will allow
us to use the per instance functions in the future to
handle more things per instance.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c | 417 ++++++++++++------------
 1 file changed, 206 insertions(+), 211 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
index 78d046fd935a..d4d92d4e2cab 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
@@ -1097,177 +1097,172 @@ static int vcn_v4_0_3_start_sriov(struct amdgpu_device *adev)
  * vcn_v4_0_3_start - VCN start
  *
  * @adev: amdgpu_device pointer
+ * @i: instance to start
  *
  * Start VCN block
  */
-static int vcn_v4_0_3_start(struct amdgpu_device *adev)
+static int vcn_v4_0_3_start(struct amdgpu_device *adev, int i)
 {
 	volatile struct amdgpu_vcn4_fw_shared *fw_shared;
 	struct amdgpu_ring *ring;
-	int i, j, k, r, vcn_inst;
+	int j, k, r, vcn_inst;
 	uint32_t tmp;
 
-	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
-		if (adev->pm.dpm_enabled)
-			amdgpu_dpm_enable_vcn(adev, true, i);
-	}
+	if (adev->pm.dpm_enabled)
+		amdgpu_dpm_enable_vcn(adev, true, i);
 
-	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
-		if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) {
-			r = vcn_v4_0_3_start_dpg_mode(adev, i, adev->vcn.indirect_sram);
-			continue;
-		}
+	if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG)
+		return vcn_v4_0_3_start_dpg_mode(adev, i, adev->vcn.indirect_sram);
 
-		vcn_inst = GET_INST(VCN, i);
-		/* set VCN status busy */
-		tmp = RREG32_SOC15(VCN, vcn_inst, regUVD_STATUS) |
-		      UVD_STATUS__UVD_BUSY;
-		WREG32_SOC15(VCN, vcn_inst, regUVD_STATUS, tmp);
-
-		/*SW clock gating */
-		vcn_v4_0_3_disable_clock_gating(adev, i);
-
-		/* enable VCPU clock */
-		WREG32_P(SOC15_REG_OFFSET(VCN, vcn_inst, regUVD_VCPU_CNTL),
-			 UVD_VCPU_CNTL__CLK_EN_MASK,
-			 ~UVD_VCPU_CNTL__CLK_EN_MASK);
-
-		/* disable master interrupt */
-		WREG32_P(SOC15_REG_OFFSET(VCN, vcn_inst, regUVD_MASTINT_EN), 0,
-			 ~UVD_MASTINT_EN__VCPU_EN_MASK);
-
-		/* enable LMI MC and UMC channels */
-		WREG32_P(SOC15_REG_OFFSET(VCN, vcn_inst, regUVD_LMI_CTRL2), 0,
-			 ~UVD_LMI_CTRL2__STALL_ARB_UMC_MASK);
-
-		tmp = RREG32_SOC15(VCN, vcn_inst, regUVD_SOFT_RESET);
-		tmp &= ~UVD_SOFT_RESET__LMI_SOFT_RESET_MASK;
-		tmp &= ~UVD_SOFT_RESET__LMI_UMC_SOFT_RESET_MASK;
-		WREG32_SOC15(VCN, vcn_inst, regUVD_SOFT_RESET, tmp);
-
-		/* setup regUVD_LMI_CTRL */
-		tmp = RREG32_SOC15(VCN, vcn_inst, regUVD_LMI_CTRL);
-		WREG32_SOC15(VCN, vcn_inst, regUVD_LMI_CTRL,
-			     tmp | UVD_LMI_CTRL__WRITE_CLEAN_TIMER_EN_MASK |
-				     UVD_LMI_CTRL__MASK_MC_URGENT_MASK |
-				     UVD_LMI_CTRL__DATA_COHERENCY_EN_MASK |
-				     UVD_LMI_CTRL__VCPU_DATA_COHERENCY_EN_MASK);
-
-		/* setup regUVD_MPC_CNTL */
-		tmp = RREG32_SOC15(VCN, vcn_inst, regUVD_MPC_CNTL);
-		tmp &= ~UVD_MPC_CNTL__REPLACEMENT_MODE_MASK;
-		tmp |= 0x2 << UVD_MPC_CNTL__REPLACEMENT_MODE__SHIFT;
-		WREG32_SOC15(VCN, vcn_inst, regUVD_MPC_CNTL, tmp);
-
-		/* setup UVD_MPC_SET_MUXA0 */
-		WREG32_SOC15(VCN, vcn_inst, regUVD_MPC_SET_MUXA0,
-			     ((0x1 << UVD_MPC_SET_MUXA0__VARA_1__SHIFT) |
-			      (0x2 << UVD_MPC_SET_MUXA0__VARA_2__SHIFT) |
-			      (0x3 << UVD_MPC_SET_MUXA0__VARA_3__SHIFT) |
-			      (0x4 << UVD_MPC_SET_MUXA0__VARA_4__SHIFT)));
-
-		/* setup UVD_MPC_SET_MUXB0 */
-		WREG32_SOC15(VCN, vcn_inst, regUVD_MPC_SET_MUXB0,
-			     ((0x1 << UVD_MPC_SET_MUXB0__VARB_1__SHIFT) |
-			      (0x2 << UVD_MPC_SET_MUXB0__VARB_2__SHIFT) |
-			      (0x3 << UVD_MPC_SET_MUXB0__VARB_3__SHIFT) |
-			      (0x4 << UVD_MPC_SET_MUXB0__VARB_4__SHIFT)));
-
-		/* setup UVD_MPC_SET_MUX */
-		WREG32_SOC15(VCN, vcn_inst, regUVD_MPC_SET_MUX,
-			     ((0x0 << UVD_MPC_SET_MUX__SET_0__SHIFT) |
-			      (0x1 << UVD_MPC_SET_MUX__SET_1__SHIFT) |
-			      (0x2 << UVD_MPC_SET_MUX__SET_2__SHIFT)));
-
-		vcn_v4_0_3_mc_resume(adev, i);
-
-		/* VCN global tiling registers */
-		WREG32_SOC15(VCN, vcn_inst, regUVD_GFX8_ADDR_CONFIG,
-			     adev->gfx.config.gb_addr_config);
-		WREG32_SOC15(VCN, vcn_inst, regUVD_GFX10_ADDR_CONFIG,
-			     adev->gfx.config.gb_addr_config);
-
-		/* unblock VCPU register access */
-		WREG32_P(SOC15_REG_OFFSET(VCN, vcn_inst, regUVD_RB_ARB_CTRL), 0,
-			 ~UVD_RB_ARB_CTRL__VCPU_DIS_MASK);
-
-		/* release VCPU reset to boot */
-		WREG32_P(SOC15_REG_OFFSET(VCN, vcn_inst, regUVD_VCPU_CNTL), 0,
-			 ~UVD_VCPU_CNTL__BLK_RST_MASK);
+	vcn_inst = GET_INST(VCN, i);
+	/* set VCN status busy */
+	tmp = RREG32_SOC15(VCN, vcn_inst, regUVD_STATUS) |
+		UVD_STATUS__UVD_BUSY;
+	WREG32_SOC15(VCN, vcn_inst, regUVD_STATUS, tmp);
 
-		for (j = 0; j < 10; ++j) {
-			uint32_t status;
+	/* SW clock gating */
+	vcn_v4_0_3_disable_clock_gating(adev, i);
 
-			for (k = 0; k < 100; ++k) {
-				status = RREG32_SOC15(VCN, vcn_inst,
-						      regUVD_STATUS);
-				if (status & 2)
-					break;
-				mdelay(10);
-			}
-			r = 0;
-			if (status & 2)
-				break;
+	/* enable VCPU clock */
+	WREG32_P(SOC15_REG_OFFSET(VCN, vcn_inst, regUVD_VCPU_CNTL),
+		 UVD_VCPU_CNTL__CLK_EN_MASK,
+		 ~UVD_VCPU_CNTL__CLK_EN_MASK);
 
-			DRM_DEV_ERROR(adev->dev,
-				"VCN decode not responding, trying to reset the VCPU!!!\n");
-			WREG32_P(SOC15_REG_OFFSET(VCN, vcn_inst,
-						  regUVD_VCPU_CNTL),
-				 UVD_VCPU_CNTL__BLK_RST_MASK,
-				 ~UVD_VCPU_CNTL__BLK_RST_MASK);
-			mdelay(10);
-			WREG32_P(SOC15_REG_OFFSET(VCN, vcn_inst,
-						  regUVD_VCPU_CNTL),
-				 0, ~UVD_VCPU_CNTL__BLK_RST_MASK);
+	/* disable master interrupt */
+	WREG32_P(SOC15_REG_OFFSET(VCN, vcn_inst, regUVD_MASTINT_EN), 0,
+		 ~UVD_MASTINT_EN__VCPU_EN_MASK);
+
+	/* enable LMI MC and UMC channels */
+	WREG32_P(SOC15_REG_OFFSET(VCN, vcn_inst, regUVD_LMI_CTRL2), 0,
+		 ~UVD_LMI_CTRL2__STALL_ARB_UMC_MASK);
+
+	tmp = RREG32_SOC15(VCN, vcn_inst, regUVD_SOFT_RESET);
+	tmp &= ~UVD_SOFT_RESET__LMI_SOFT_RESET_MASK;
+	tmp &= ~UVD_SOFT_RESET__LMI_UMC_SOFT_RESET_MASK;
+	WREG32_SOC15(VCN, vcn_inst, regUVD_SOFT_RESET, tmp);
+
+	/* setup regUVD_LMI_CTRL */
+	tmp = RREG32_SOC15(VCN, vcn_inst, regUVD_LMI_CTRL);
+	WREG32_SOC15(VCN, vcn_inst, regUVD_LMI_CTRL,
+		     tmp | UVD_LMI_CTRL__WRITE_CLEAN_TIMER_EN_MASK |
+		     UVD_LMI_CTRL__MASK_MC_URGENT_MASK |
+		     UVD_LMI_CTRL__DATA_COHERENCY_EN_MASK |
+		     UVD_LMI_CTRL__VCPU_DATA_COHERENCY_EN_MASK);
+
+	/* setup regUVD_MPC_CNTL */
+	tmp = RREG32_SOC15(VCN, vcn_inst, regUVD_MPC_CNTL);
+	tmp &= ~UVD_MPC_CNTL__REPLACEMENT_MODE_MASK;
+	tmp |= 0x2 << UVD_MPC_CNTL__REPLACEMENT_MODE__SHIFT;
+	WREG32_SOC15(VCN, vcn_inst, regUVD_MPC_CNTL, tmp);
+
+	/* setup UVD_MPC_SET_MUXA0 */
+	WREG32_SOC15(VCN, vcn_inst, regUVD_MPC_SET_MUXA0,
+		     ((0x1 << UVD_MPC_SET_MUXA0__VARA_1__SHIFT) |
+		      (0x2 << UVD_MPC_SET_MUXA0__VARA_2__SHIFT) |
+		      (0x3 << UVD_MPC_SET_MUXA0__VARA_3__SHIFT) |
+		      (0x4 << UVD_MPC_SET_MUXA0__VARA_4__SHIFT)));
+
+	/* setup UVD_MPC_SET_MUXB0 */
+	WREG32_SOC15(VCN, vcn_inst, regUVD_MPC_SET_MUXB0,
+		     ((0x1 << UVD_MPC_SET_MUXB0__VARB_1__SHIFT) |
+		      (0x2 << UVD_MPC_SET_MUXB0__VARB_2__SHIFT) |
+		      (0x3 << UVD_MPC_SET_MUXB0__VARB_3__SHIFT) |
+		      (0x4 << UVD_MPC_SET_MUXB0__VARB_4__SHIFT)));
+
+	/* setup UVD_MPC_SET_MUX */
+	WREG32_SOC15(VCN, vcn_inst, regUVD_MPC_SET_MUX,
+		     ((0x0 << UVD_MPC_SET_MUX__SET_0__SHIFT) |
+		      (0x1 << UVD_MPC_SET_MUX__SET_1__SHIFT) |
+		      (0x2 << UVD_MPC_SET_MUX__SET_2__SHIFT)));
+
+	vcn_v4_0_3_mc_resume(adev, i);
+
+	/* VCN global tiling registers */
+	WREG32_SOC15(VCN, vcn_inst, regUVD_GFX8_ADDR_CONFIG,
+		     adev->gfx.config.gb_addr_config);
+	WREG32_SOC15(VCN, vcn_inst, regUVD_GFX10_ADDR_CONFIG,
+		     adev->gfx.config.gb_addr_config);
 
+	/* unblock VCPU register access */
+	WREG32_P(SOC15_REG_OFFSET(VCN, vcn_inst, regUVD_RB_ARB_CTRL), 0,
+		 ~UVD_RB_ARB_CTRL__VCPU_DIS_MASK);
+
+	/* release VCPU reset to boot */
+	WREG32_P(SOC15_REG_OFFSET(VCN, vcn_inst, regUVD_VCPU_CNTL), 0,
+		 ~UVD_VCPU_CNTL__BLK_RST_MASK);
+
+	for (j = 0; j < 10; ++j) {
+		uint32_t status;
+
+		for (k = 0; k < 100; ++k) {
+			status = RREG32_SOC15(VCN, vcn_inst,
+					      regUVD_STATUS);
+			if (status & 2)
+				break;
 			mdelay(10);
-			r = -1;
 		}
+		r = 0;
+		if (status & 2)
+			break;
 
-		if (r) {
-			DRM_DEV_ERROR(adev->dev, "VCN decode not responding, giving up!!!\n");
-			return r;
-		}
+		DRM_DEV_ERROR(adev->dev,
+			      "VCN decode not responding, trying to reset the VCPU!!!\n");
+		WREG32_P(SOC15_REG_OFFSET(VCN, vcn_inst,
+					  regUVD_VCPU_CNTL),
+			 UVD_VCPU_CNTL__BLK_RST_MASK,
+			 ~UVD_VCPU_CNTL__BLK_RST_MASK);
+		mdelay(10);
+		WREG32_P(SOC15_REG_OFFSET(VCN, vcn_inst,
+					  regUVD_VCPU_CNTL),
+			 0, ~UVD_VCPU_CNTL__BLK_RST_MASK);
 
-		/* enable master interrupt */
-		WREG32_P(SOC15_REG_OFFSET(VCN, vcn_inst, regUVD_MASTINT_EN),
-			 UVD_MASTINT_EN__VCPU_EN_MASK,
-			 ~UVD_MASTINT_EN__VCPU_EN_MASK);
+		mdelay(10);
+		r = -1;
+	}
 
-		/* clear the busy bit of VCN_STATUS */
-		WREG32_P(SOC15_REG_OFFSET(VCN, vcn_inst, regUVD_STATUS), 0,
-			 ~(2 << UVD_STATUS__VCPU_REPORT__SHIFT));
+	if (r) {
+		DRM_DEV_ERROR(adev->dev, "VCN decode not responding, giving up!!!\n");
+		return r;
+	}
 
-		ring = &adev->vcn.inst[i].ring_enc[0];
-		fw_shared = adev->vcn.inst[i].fw_shared.cpu_addr;
+	/* enable master interrupt */
+	WREG32_P(SOC15_REG_OFFSET(VCN, vcn_inst, regUVD_MASTINT_EN),
+		 UVD_MASTINT_EN__VCPU_EN_MASK,
+		 ~UVD_MASTINT_EN__VCPU_EN_MASK);
+
+	/* clear the busy bit of VCN_STATUS */
+	WREG32_P(SOC15_REG_OFFSET(VCN, vcn_inst, regUVD_STATUS), 0,
+		 ~(2 << UVD_STATUS__VCPU_REPORT__SHIFT));
 
-		/* program the RB_BASE for ring buffer */
-		WREG32_SOC15(VCN, vcn_inst, regUVD_RB_BASE_LO,
-			     lower_32_bits(ring->gpu_addr));
-		WREG32_SOC15(VCN, vcn_inst, regUVD_RB_BASE_HI,
-			     upper_32_bits(ring->gpu_addr));
+	ring = &adev->vcn.inst[i].ring_enc[0];
+	fw_shared = adev->vcn.inst[i].fw_shared.cpu_addr;
+
+	/* program the RB_BASE for ring buffer */
+	WREG32_SOC15(VCN, vcn_inst, regUVD_RB_BASE_LO,
+		     lower_32_bits(ring->gpu_addr));
+	WREG32_SOC15(VCN, vcn_inst, regUVD_RB_BASE_HI,
+		     upper_32_bits(ring->gpu_addr));
 
-		WREG32_SOC15(VCN, vcn_inst, regUVD_RB_SIZE,
-			     ring->ring_size / sizeof(uint32_t));
+	WREG32_SOC15(VCN, vcn_inst, regUVD_RB_SIZE,
+		     ring->ring_size / sizeof(uint32_t));
 
-		/* resetting ring, fw should not check RB ring */
-		tmp = RREG32_SOC15(VCN, vcn_inst, regVCN_RB_ENABLE);
-		tmp &= ~(VCN_RB_ENABLE__RB_EN_MASK);
-		WREG32_SOC15(VCN, vcn_inst, regVCN_RB_ENABLE, tmp);
+	/* resetting ring, fw should not check RB ring */
+	tmp = RREG32_SOC15(VCN, vcn_inst, regVCN_RB_ENABLE);
+	tmp &= ~(VCN_RB_ENABLE__RB_EN_MASK);
+	WREG32_SOC15(VCN, vcn_inst, regVCN_RB_ENABLE, tmp);
 
-		/* Initialize the ring buffer's read and write pointers */
-		WREG32_SOC15(VCN, vcn_inst, regUVD_RB_RPTR, 0);
-		WREG32_SOC15(VCN, vcn_inst, regUVD_RB_WPTR, 0);
+	/* Initialize the ring buffer's read and write pointers */
+	WREG32_SOC15(VCN, vcn_inst, regUVD_RB_RPTR, 0);
+	WREG32_SOC15(VCN, vcn_inst, regUVD_RB_WPTR, 0);
 
-		tmp = RREG32_SOC15(VCN, vcn_inst, regVCN_RB_ENABLE);
-		tmp |= VCN_RB_ENABLE__RB_EN_MASK;
-		WREG32_SOC15(VCN, vcn_inst, regVCN_RB_ENABLE, tmp);
+	tmp = RREG32_SOC15(VCN, vcn_inst, regVCN_RB_ENABLE);
+	tmp |= VCN_RB_ENABLE__RB_EN_MASK;
+	WREG32_SOC15(VCN, vcn_inst, regVCN_RB_ENABLE, tmp);
 
-		ring->wptr = RREG32_SOC15(VCN, vcn_inst, regUVD_RB_WPTR);
-		fw_shared->sq.queue_mode &=
-			cpu_to_le32(~(FW_QUEUE_RING_RESET | FW_QUEUE_DPG_HOLD_OFF));
+	ring->wptr = RREG32_SOC15(VCN, vcn_inst, regUVD_RB_WPTR);
+	fw_shared->sq.queue_mode &=
+		cpu_to_le32(~(FW_QUEUE_RING_RESET | FW_QUEUE_DPG_HOLD_OFF));
 
-	}
 	return 0;
 }
 
@@ -1307,86 +1302,84 @@ static int vcn_v4_0_3_stop_dpg_mode(struct amdgpu_device *adev, int inst_idx)
  * vcn_v4_0_3_stop - VCN stop
  *
  * @adev: amdgpu_device pointer
+ * @i: instance to stop
  *
  * Stop VCN block
  */
-static int vcn_v4_0_3_stop(struct amdgpu_device *adev)
+static int vcn_v4_0_3_stop(struct amdgpu_device *adev, int i)
 {
 	volatile struct amdgpu_vcn4_fw_shared *fw_shared;
-	int i, r = 0, vcn_inst;
+	int r = 0, vcn_inst;
 	uint32_t tmp;
 
-	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
-		vcn_inst = GET_INST(VCN, i);
+	vcn_inst = GET_INST(VCN, i);
 
-		fw_shared = adev->vcn.inst[i].fw_shared.cpu_addr;
-		fw_shared->sq.queue_mode |= FW_QUEUE_DPG_HOLD_OFF;
+	fw_shared = adev->vcn.inst[i].fw_shared.cpu_addr;
+	fw_shared->sq.queue_mode |= FW_QUEUE_DPG_HOLD_OFF;
 
-		if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) {
-			vcn_v4_0_3_stop_dpg_mode(adev, i);
-			continue;
-		}
+	if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) {
+		vcn_v4_0_3_stop_dpg_mode(adev, i);
+		return 0;
+	}
 
-		/* wait for vcn idle */
-		r = SOC15_WAIT_ON_RREG(VCN, vcn_inst, regUVD_STATUS,
-				       UVD_STATUS__IDLE, 0x7);
-		if (r)
-			goto Done;
-
-		tmp = UVD_LMI_STATUS__VCPU_LMI_WRITE_CLEAN_MASK |
-			UVD_LMI_STATUS__READ_CLEAN_MASK |
-			UVD_LMI_STATUS__WRITE_CLEAN_MASK |
-			UVD_LMI_STATUS__WRITE_CLEAN_RAW_MASK;
-		r = SOC15_WAIT_ON_RREG(VCN, vcn_inst, regUVD_LMI_STATUS, tmp,
-				       tmp);
-		if (r)
-			goto Done;
-
-		/* stall UMC channel */
-		tmp = RREG32_SOC15(VCN, vcn_inst, regUVD_LMI_CTRL2);
-		tmp |= UVD_LMI_CTRL2__STALL_ARB_UMC_MASK;
-		WREG32_SOC15(VCN, vcn_inst, regUVD_LMI_CTRL2, tmp);
-		tmp = UVD_LMI_STATUS__UMC_READ_CLEAN_RAW_MASK |
-			UVD_LMI_STATUS__UMC_WRITE_CLEAN_RAW_MASK;
-		r = SOC15_WAIT_ON_RREG(VCN, vcn_inst, regUVD_LMI_STATUS, tmp,
-				       tmp);
-		if (r)
-			goto Done;
+	/* wait for vcn idle */
+	r = SOC15_WAIT_ON_RREG(VCN, vcn_inst, regUVD_STATUS,
+			       UVD_STATUS__IDLE, 0x7);
+	if (r)
+		goto Done;
+
+	tmp = UVD_LMI_STATUS__VCPU_LMI_WRITE_CLEAN_MASK |
+		UVD_LMI_STATUS__READ_CLEAN_MASK |
+		UVD_LMI_STATUS__WRITE_CLEAN_MASK |
+		UVD_LMI_STATUS__WRITE_CLEAN_RAW_MASK;
+	r = SOC15_WAIT_ON_RREG(VCN, vcn_inst, regUVD_LMI_STATUS, tmp,
+			       tmp);
+	if (r)
+		goto Done;
+
+	/* stall UMC channel */
+	tmp = RREG32_SOC15(VCN, vcn_inst, regUVD_LMI_CTRL2);
+	tmp |= UVD_LMI_CTRL2__STALL_ARB_UMC_MASK;
+	WREG32_SOC15(VCN, vcn_inst, regUVD_LMI_CTRL2, tmp);
+	tmp = UVD_LMI_STATUS__UMC_READ_CLEAN_RAW_MASK |
+		UVD_LMI_STATUS__UMC_WRITE_CLEAN_RAW_MASK;
+	r = SOC15_WAIT_ON_RREG(VCN, vcn_inst, regUVD_LMI_STATUS, tmp,
+			       tmp);
+	if (r)
+		goto Done;
 
-		/* Unblock VCPU Register access */
-		WREG32_P(SOC15_REG_OFFSET(VCN, vcn_inst, regUVD_RB_ARB_CTRL),
-			 UVD_RB_ARB_CTRL__VCPU_DIS_MASK,
-			 ~UVD_RB_ARB_CTRL__VCPU_DIS_MASK);
+	/* Unblock VCPU Register access */
+	WREG32_P(SOC15_REG_OFFSET(VCN, vcn_inst, regUVD_RB_ARB_CTRL),
+		 UVD_RB_ARB_CTRL__VCPU_DIS_MASK,
+		 ~UVD_RB_ARB_CTRL__VCPU_DIS_MASK);
 
-		/* release VCPU reset to boot */
-		WREG32_P(SOC15_REG_OFFSET(VCN, vcn_inst, regUVD_VCPU_CNTL),
-			 UVD_VCPU_CNTL__BLK_RST_MASK,
-			 ~UVD_VCPU_CNTL__BLK_RST_MASK);
+	/* release VCPU reset to boot */
+	WREG32_P(SOC15_REG_OFFSET(VCN, vcn_inst, regUVD_VCPU_CNTL),
+		 UVD_VCPU_CNTL__BLK_RST_MASK,
+		 ~UVD_VCPU_CNTL__BLK_RST_MASK);
 
-		/* disable VCPU clock */
-		WREG32_P(SOC15_REG_OFFSET(VCN, vcn_inst, regUVD_VCPU_CNTL), 0,
-			 ~(UVD_VCPU_CNTL__CLK_EN_MASK));
+	/* disable VCPU clock */
+	WREG32_P(SOC15_REG_OFFSET(VCN, vcn_inst, regUVD_VCPU_CNTL), 0,
+		 ~(UVD_VCPU_CNTL__CLK_EN_MASK));
 
-		/* reset LMI UMC/LMI/VCPU */
-		tmp = RREG32_SOC15(VCN, vcn_inst, regUVD_SOFT_RESET);
-		tmp |= UVD_SOFT_RESET__LMI_UMC_SOFT_RESET_MASK;
-		WREG32_SOC15(VCN, vcn_inst, regUVD_SOFT_RESET, tmp);
+	/* reset LMI UMC/LMI/VCPU */
+	tmp = RREG32_SOC15(VCN, vcn_inst, regUVD_SOFT_RESET);
+	tmp |= UVD_SOFT_RESET__LMI_UMC_SOFT_RESET_MASK;
+	WREG32_SOC15(VCN, vcn_inst, regUVD_SOFT_RESET, tmp);
 
-		tmp = RREG32_SOC15(VCN, vcn_inst, regUVD_SOFT_RESET);
-		tmp |= UVD_SOFT_RESET__LMI_SOFT_RESET_MASK;
-		WREG32_SOC15(VCN, vcn_inst, regUVD_SOFT_RESET, tmp);
+	tmp = RREG32_SOC15(VCN, vcn_inst, regUVD_SOFT_RESET);
+	tmp |= UVD_SOFT_RESET__LMI_SOFT_RESET_MASK;
+	WREG32_SOC15(VCN, vcn_inst, regUVD_SOFT_RESET, tmp);
 
-		/* clear VCN status */
-		WREG32_SOC15(VCN, vcn_inst, regUVD_STATUS, 0);
+	/* clear VCN status */
+	WREG32_SOC15(VCN, vcn_inst, regUVD_STATUS, 0);
+
+	/* apply HW clock gating */
+	vcn_v4_0_3_enable_clock_gating(adev, i);
 
-		/* apply HW clock gating */
-		vcn_v4_0_3_enable_clock_gating(adev, i);
-	}
 Done:
-	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
-		if (adev->pm.dpm_enabled)
-			amdgpu_dpm_enable_vcn(adev, false, i);
-	}
+	if (adev->pm.dpm_enabled)
+		amdgpu_dpm_enable_vcn(adev, false, i);
 
 	return 0;
 }
@@ -1650,7 +1643,7 @@ static int vcn_v4_0_3_set_powergating_state(struct amdgpu_ip_block *ip_block,
 					  enum amd_powergating_state state)
 {
 	struct amdgpu_device *adev = ip_block->adev;
-	int ret;
+	int ret = 0, i;
 
 	/* for SRIOV, guest should not control VCN Power-gating
 	 * MMSCH FW should control Power-gating and clock-gating
@@ -1664,10 +1657,12 @@ static int vcn_v4_0_3_set_powergating_state(struct amdgpu_ip_block *ip_block,
 	if (state == adev->vcn.cur_state)
 		return 0;
 
-	if (state == AMD_PG_STATE_GATE)
-		ret = vcn_v4_0_3_stop(adev);
-	else
-		ret = vcn_v4_0_3_start(adev);
+	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
+		if (state == AMD_PG_STATE_GATE)
+			ret |= vcn_v4_0_3_stop(adev, i);
+		else
+			ret |= vcn_v4_0_3_start(adev, i);
+	}
 
 	if (!ret)
 		adev->vcn.cur_state = state;
-- 
2.47.0

