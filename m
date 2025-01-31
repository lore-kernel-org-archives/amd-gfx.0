Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46899C02196
	for <amd-gfx@archiver.kernel.org>; Fri, 31 Jan 2025 16:58:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D7CF010E3C5;
	Fri, 31 Jan 2025 16:58:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="a/vZ6WTB";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2072.outbound.protection.outlook.com [40.107.220.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2A86710E3B3
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 Jan 2025 16:58:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q2UWavfY1LYfYwstCEacjiSvTJS7FIHDY72xxEnwZfEhw+cAFhmcZJzXnkXH+tOm5tR2f5RGI74WP+dW/mUdL/rDkaN0flpCaPY6bZP8FMDJ6lfJvnE985VUSddCDVwR1kn2/qrr0tPGuIrWa8+C76jfwDij5sGKIDjc3th1SnxX5V+je2wjteAo4cE1f6ozyT40tWitgDpvv9OufPemq757XLH02aEcjUPtV2ueuOz6r1bxvpyIGYbR8/1pS8MXLbYU1uVfzXxafrnfy56r5SFBkYTwmZvGeubch/wneJlkwU+mhy/CI4wcXJFLqvYt2PeZyc6AkN4G0oz4CSNtNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aOC5rxqCF7NZ+adABFa+lMyJXbK2gmZ8Dl6zlky321I=;
 b=iLMHJMtNFPPvg0y18E5Rusn97OJUi/Dg6WGZ8VWH1CCan1jXju94tCMQziGAM4VmW8RJzK6t+rMXZF5Dw4rqWExONgLqXpHsJLmBW0mLSCHMY3JsX3p4u4RFb84l7UEG0N4CpcJWRInLzjZ0UooXurhWj7vN0P51bQvpLXX66cD1oIYNL3Hmh6cwy5lGBv2SPq3JrYghoaAo3rUHgN9PFnM1ZU5Z/iOze6tbQLEH7VGS/DJWZwIDWEEFfMIiPKpcME/kmCZu5Ja0xpdgccb/rwBh/gQ7cKylr4qogwL5n3JSoM0H/cxAEmNNGovjht9cvRmvkmrUGwEOjywaemCEpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aOC5rxqCF7NZ+adABFa+lMyJXbK2gmZ8Dl6zlky321I=;
 b=a/vZ6WTB94FYzZ3VKzAj1M28s/0foKDS3m5g+9mD2tvlij9HawITj6XpdTpqYnLpVx0NNNw66Xs6JA6NMs3torkKLCUs+O6eGEwrqrHHlaClDADqQJ1SUD6lXaKBjCajI8td1hvh15KGmPppYAJPa9E+VLINNLgyiCPB6SJRcdY=
Received: from DM6PR07CA0093.namprd07.prod.outlook.com (2603:10b6:5:337::26)
 by PH7PR12MB9103.namprd12.prod.outlook.com (2603:10b6:510:2f5::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.22; Fri, 31 Jan
 2025 16:58:03 +0000
Received: from DS2PEPF0000343C.namprd02.prod.outlook.com
 (2603:10b6:5:337:cafe::17) by DM6PR07CA0093.outlook.office365.com
 (2603:10b6:5:337::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.21 via Frontend Transport; Fri,
 31 Jan 2025 16:58:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF0000343C.mail.protection.outlook.com (10.167.18.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8398.14 via Frontend Transport; Fri, 31 Jan 2025 16:58:02 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 31 Jan
 2025 10:58:01 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 02/44] drm/amdgpu/vcn3.0: split code along instances
Date: Fri, 31 Jan 2025 11:56:58 -0500
Message-ID: <20250131165741.1798488-3-alexander.deucher@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343C:EE_|PH7PR12MB9103:EE_
X-MS-Office365-Filtering-Correlation-Id: 6478ebac-1b9d-4a62-50e6-08dd42186ce1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?0GbuaxRUSPx3EybOw0+8NnBXVXzucfNqHtEetm/yUIcIzJ54fUYoL6/nwoDg?=
 =?us-ascii?Q?1ve52Mlq+S5EhjWsENlftzt04fm7lGGkrII8DtSafFASyHdIlMC0F5lGLzNY?=
 =?us-ascii?Q?hBscK51Ce6n+YZcJZZxibaMhDyVFfAMvOeC9OHm4XMYf+Au48IcqndCw3Lho?=
 =?us-ascii?Q?kth+yqfzUMRG6Fe1yXVRkKdbvU2G0aHO9FHHusanb9mmmgtNFywxUv/1hVH9?=
 =?us-ascii?Q?wcRKdSwKc5wS5fUsO7HyPPBLmybshUK/K6ouBoAnP2KMLYbJl2nu2P0cpO4W?=
 =?us-ascii?Q?EI83t35CzOptEDPSNHUf9v1237n0+WCHjDV4/4hD81rOybVTtjDk/nG1jXFt?=
 =?us-ascii?Q?NjN9sLP4G2AzBwV0EYGHFNCWL836isuv5cHhBKVAfNKh3lu1waZLc86/cEnW?=
 =?us-ascii?Q?7sBji0NWJNziU4Qf19wOHZTefBIY1mlWdk0y1ij6Zj/U2yAdvNMCRwB1fVvM?=
 =?us-ascii?Q?n6OhnZdQjEWNvR1zVGKFN7hz63HVapOA3tTzliIRde3VpamaMbdIGkx0HJ0q?=
 =?us-ascii?Q?gZJ7UFS6dR+IvljToe+DvxkmFckR41PZUna3nzNW2StTGvIerZP9wHuIAaqd?=
 =?us-ascii?Q?YlcqvLvV2cLKqCBd2/x1ICZ8ASJsPzzebZP+GFDQIDRZ9w5TPLRDCuDirQF6?=
 =?us-ascii?Q?EqeUdg6I0rS27UAJbj0pdsZd3c02ihV7QnQqjPPbsOqZCawyrofb/VSL/uQT?=
 =?us-ascii?Q?N4KUfdL1XbpD0PxUswvCzzTTsOfxg32g20Gn1BN+seOfnHsgh45mXq5BxMOu?=
 =?us-ascii?Q?7iY8eiRrG6ImcqRDTk2mR5ACc+Gik/TYz3qvWTZacwin1+xkLukkOGQ2JGQ8?=
 =?us-ascii?Q?ILEP/6wQ5Brd8xYuv5H8tIpSZePkqBmgCR01RPf336sIxMj8ylnJPlCF/hGb?=
 =?us-ascii?Q?iKn8Q8o5nAulCpgcgtIpQf2H26Jm7t9UyBSqbpE6od0tCsc9vaMwj5uxKVdL?=
 =?us-ascii?Q?SQkTOFmtzZc4k3RmRhC+1b530kylnbzUq5Zwpo8p9Tt9TP43GrUXOT5LrqeV?=
 =?us-ascii?Q?ey1/xCM39y1Cz4Exmz/ifygsA315rPgVdnXQY1/GusMvYRWsSsEYioWatIo2?=
 =?us-ascii?Q?WdcRoq86WoRGktY2p7GTnMZZNriM34lY5s8nyPARuS+IxCkQZUJIWd80I8a3?=
 =?us-ascii?Q?F7yGY+etvcjZyd3MBi9ybHt2tbAQnEE9UP/HGN2SU8pIF8BJVlbXNgteJ/o6?=
 =?us-ascii?Q?3GgR0jneP6IMclZFvU3E9pNi32cUBE0N/lCToTxLCZkP9uBHgB3AxB7nvB1v?=
 =?us-ascii?Q?gAtK6gE+TnjhDYm8pHZwnuGlEZXOVTJkGFLmkaMKvMk8GyWRgs4R7VL1+dn2?=
 =?us-ascii?Q?BB2eVh4JUMBcVE0X5h8UO8Flvtal7yKSL9PsP9awTvDGTy0ArX8eLvjJPoiN?=
 =?us-ascii?Q?jSDBcFHED8FGbuIcIjXA7FvtngeHMOgHOlY/sJaz+zFxSIMlWTenLO01x+ZF?=
 =?us-ascii?Q?hG8eEaJdFXKFbvZaOuZgdrqnqSXjd3KmIJLCOXewBlP9cDVDxkaZyw=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2025 16:58:02.8738 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6478ebac-1b9d-4a62-50e6-08dd42186ce1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF0000343C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9103
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
 drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c | 436 +++++++++++++-------------
 1 file changed, 213 insertions(+), 223 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
index 63ddd4cca9109..a3627700ed48d 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
@@ -1134,192 +1134,186 @@ static int vcn_v3_0_start_dpg_mode(struct amdgpu_device *adev, int inst_idx, boo
 	return 0;
 }
 
-static int vcn_v3_0_start(struct amdgpu_device *adev)
+static int vcn_v3_0_start(struct amdgpu_device *adev, int i)
 {
 	volatile struct amdgpu_fw_shared *fw_shared;
 	struct amdgpu_ring *ring;
 	uint32_t rb_bufsz, tmp;
-	int i, j, k, r;
+	int j, k, r;
 
-	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
-		if (adev->pm.dpm_enabled)
-			amdgpu_dpm_enable_vcn(adev, true, i);
-	}
+	if (adev->vcn.harvest_config & (1 << i))
+		return 0;
 
-	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
-		if (adev->vcn.harvest_config & (1 << i))
-			continue;
+	if (adev->pm.dpm_enabled)
+		amdgpu_dpm_enable_vcn(adev, true, i);
 
-		if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) {
-			r = vcn_v3_0_start_dpg_mode(adev, i, adev->vcn.indirect_sram);
-			continue;
-		}
+	if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG)
+		return vcn_v3_0_start_dpg_mode(adev, i, adev->vcn.indirect_sram);
 
-		/* disable VCN power gating */
-		vcn_v3_0_disable_static_power_gating(adev, i);
+	/* disable VCN power gating */
+	vcn_v3_0_disable_static_power_gating(adev, i);
 
-		/* set VCN status busy */
-		tmp = RREG32_SOC15(VCN, i, mmUVD_STATUS) | UVD_STATUS__UVD_BUSY;
-		WREG32_SOC15(VCN, i, mmUVD_STATUS, tmp);
+	/* set VCN status busy */
+	tmp = RREG32_SOC15(VCN, i, mmUVD_STATUS) | UVD_STATUS__UVD_BUSY;
+	WREG32_SOC15(VCN, i, mmUVD_STATUS, tmp);
 
-		/*SW clock gating */
-		vcn_v3_0_disable_clock_gating(adev, i);
+	/* SW clock gating */
+	vcn_v3_0_disable_clock_gating(adev, i);
 
-		/* enable VCPU clock */
-		WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_VCPU_CNTL),
-			UVD_VCPU_CNTL__CLK_EN_MASK, ~UVD_VCPU_CNTL__CLK_EN_MASK);
-
-		/* disable master interrupt */
-		WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_MASTINT_EN), 0,
-			~UVD_MASTINT_EN__VCPU_EN_MASK);
-
-		/* enable LMI MC and UMC channels */
-		WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_LMI_CTRL2), 0,
-			~UVD_LMI_CTRL2__STALL_ARB_UMC_MASK);
-
-		tmp = RREG32_SOC15(VCN, i, mmUVD_SOFT_RESET);
-		tmp &= ~UVD_SOFT_RESET__LMI_SOFT_RESET_MASK;
-		tmp &= ~UVD_SOFT_RESET__LMI_UMC_SOFT_RESET_MASK;
-		WREG32_SOC15(VCN, i, mmUVD_SOFT_RESET, tmp);
-
-		/* setup mmUVD_LMI_CTRL */
-		tmp = RREG32_SOC15(VCN, i, mmUVD_LMI_CTRL);
-		WREG32_SOC15(VCN, i, mmUVD_LMI_CTRL, tmp |
-			UVD_LMI_CTRL__WRITE_CLEAN_TIMER_EN_MASK	|
-			UVD_LMI_CTRL__MASK_MC_URGENT_MASK |
-			UVD_LMI_CTRL__DATA_COHERENCY_EN_MASK |
-			UVD_LMI_CTRL__VCPU_DATA_COHERENCY_EN_MASK);
-
-		/* setup mmUVD_MPC_CNTL */
-		tmp = RREG32_SOC15(VCN, i, mmUVD_MPC_CNTL);
-		tmp &= ~UVD_MPC_CNTL__REPLACEMENT_MODE_MASK;
-		tmp |= 0x2 << UVD_MPC_CNTL__REPLACEMENT_MODE__SHIFT;
-		WREG32_SOC15(VCN, i, mmUVD_MPC_CNTL, tmp);
-
-		/* setup UVD_MPC_SET_MUXA0 */
-		WREG32_SOC15(VCN, i, mmUVD_MPC_SET_MUXA0,
-			((0x1 << UVD_MPC_SET_MUXA0__VARA_1__SHIFT) |
-			(0x2 << UVD_MPC_SET_MUXA0__VARA_2__SHIFT) |
-			(0x3 << UVD_MPC_SET_MUXA0__VARA_3__SHIFT) |
-			(0x4 << UVD_MPC_SET_MUXA0__VARA_4__SHIFT)));
-
-		/* setup UVD_MPC_SET_MUXB0 */
-		WREG32_SOC15(VCN, i, mmUVD_MPC_SET_MUXB0,
-			((0x1 << UVD_MPC_SET_MUXB0__VARB_1__SHIFT) |
-			(0x2 << UVD_MPC_SET_MUXB0__VARB_2__SHIFT) |
-			(0x3 << UVD_MPC_SET_MUXB0__VARB_3__SHIFT) |
-			(0x4 << UVD_MPC_SET_MUXB0__VARB_4__SHIFT)));
-
-		/* setup mmUVD_MPC_SET_MUX */
-		WREG32_SOC15(VCN, i, mmUVD_MPC_SET_MUX,
-			((0x0 << UVD_MPC_SET_MUX__SET_0__SHIFT) |
-			(0x1 << UVD_MPC_SET_MUX__SET_1__SHIFT) |
-			(0x2 << UVD_MPC_SET_MUX__SET_2__SHIFT)));
-
-		vcn_v3_0_mc_resume(adev, i);
-
-		/* VCN global tiling registers */
-		WREG32_SOC15(VCN, i, mmUVD_GFX10_ADDR_CONFIG,
-			adev->gfx.config.gb_addr_config);
-
-		/* unblock VCPU register access */
-		WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_RB_ARB_CTRL), 0,
-			~UVD_RB_ARB_CTRL__VCPU_DIS_MASK);
-
-		/* release VCPU reset to boot */
-		WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_VCPU_CNTL), 0,
-			~UVD_VCPU_CNTL__BLK_RST_MASK);
+	/* enable VCPU clock */
+	WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_VCPU_CNTL),
+		 UVD_VCPU_CNTL__CLK_EN_MASK, ~UVD_VCPU_CNTL__CLK_EN_MASK);
 
-		for (j = 0; j < 10; ++j) {
-			uint32_t status;
+	/* disable master interrupt */
+	WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_MASTINT_EN), 0,
+		 ~UVD_MASTINT_EN__VCPU_EN_MASK);
 
-			for (k = 0; k < 100; ++k) {
-				status = RREG32_SOC15(VCN, i, mmUVD_STATUS);
-				if (status & 2)
-					break;
-				mdelay(10);
-			}
-			r = 0;
-			if (status & 2)
-				break;
+	/* enable LMI MC and UMC channels */
+	WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_LMI_CTRL2), 0,
+		 ~UVD_LMI_CTRL2__STALL_ARB_UMC_MASK);
 
-			DRM_ERROR("VCN[%d] decode not responding, trying to reset the VCPU!!!\n", i);
-			WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_VCPU_CNTL),
-				UVD_VCPU_CNTL__BLK_RST_MASK,
-				~UVD_VCPU_CNTL__BLK_RST_MASK);
-			mdelay(10);
-			WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_VCPU_CNTL), 0,
-				~UVD_VCPU_CNTL__BLK_RST_MASK);
+	tmp = RREG32_SOC15(VCN, i, mmUVD_SOFT_RESET);
+	tmp &= ~UVD_SOFT_RESET__LMI_SOFT_RESET_MASK;
+	tmp &= ~UVD_SOFT_RESET__LMI_UMC_SOFT_RESET_MASK;
+	WREG32_SOC15(VCN, i, mmUVD_SOFT_RESET, tmp);
+
+	/* setup mmUVD_LMI_CTRL */
+	tmp = RREG32_SOC15(VCN, i, mmUVD_LMI_CTRL);
+	WREG32_SOC15(VCN, i, mmUVD_LMI_CTRL, tmp |
+		     UVD_LMI_CTRL__WRITE_CLEAN_TIMER_EN_MASK	|
+		     UVD_LMI_CTRL__MASK_MC_URGENT_MASK |
+		     UVD_LMI_CTRL__DATA_COHERENCY_EN_MASK |
+		     UVD_LMI_CTRL__VCPU_DATA_COHERENCY_EN_MASK);
+
+	/* setup mmUVD_MPC_CNTL */
+	tmp = RREG32_SOC15(VCN, i, mmUVD_MPC_CNTL);
+	tmp &= ~UVD_MPC_CNTL__REPLACEMENT_MODE_MASK;
+	tmp |= 0x2 << UVD_MPC_CNTL__REPLACEMENT_MODE__SHIFT;
+	WREG32_SOC15(VCN, i, mmUVD_MPC_CNTL, tmp);
+
+	/* setup UVD_MPC_SET_MUXA0 */
+	WREG32_SOC15(VCN, i, mmUVD_MPC_SET_MUXA0,
+		     ((0x1 << UVD_MPC_SET_MUXA0__VARA_1__SHIFT) |
+		      (0x2 << UVD_MPC_SET_MUXA0__VARA_2__SHIFT) |
+		      (0x3 << UVD_MPC_SET_MUXA0__VARA_3__SHIFT) |
+		      (0x4 << UVD_MPC_SET_MUXA0__VARA_4__SHIFT)));
+
+	/* setup UVD_MPC_SET_MUXB0 */
+	WREG32_SOC15(VCN, i, mmUVD_MPC_SET_MUXB0,
+		     ((0x1 << UVD_MPC_SET_MUXB0__VARB_1__SHIFT) |
+		      (0x2 << UVD_MPC_SET_MUXB0__VARB_2__SHIFT) |
+		      (0x3 << UVD_MPC_SET_MUXB0__VARB_3__SHIFT) |
+		      (0x4 << UVD_MPC_SET_MUXB0__VARB_4__SHIFT)));
+
+	/* setup mmUVD_MPC_SET_MUX */
+	WREG32_SOC15(VCN, i, mmUVD_MPC_SET_MUX,
+		     ((0x0 << UVD_MPC_SET_MUX__SET_0__SHIFT) |
+		      (0x1 << UVD_MPC_SET_MUX__SET_1__SHIFT) |
+		      (0x2 << UVD_MPC_SET_MUX__SET_2__SHIFT)));
+
+	vcn_v3_0_mc_resume(adev, i);
+
+	/* VCN global tiling registers */
+	WREG32_SOC15(VCN, i, mmUVD_GFX10_ADDR_CONFIG,
+		     adev->gfx.config.gb_addr_config);
+
+	/* unblock VCPU register access */
+	WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_RB_ARB_CTRL), 0,
+		 ~UVD_RB_ARB_CTRL__VCPU_DIS_MASK);
 
+	/* release VCPU reset to boot */
+	WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_VCPU_CNTL), 0,
+		 ~UVD_VCPU_CNTL__BLK_RST_MASK);
+
+	for (j = 0; j < 10; ++j) {
+		uint32_t status;
+
+		for (k = 0; k < 100; ++k) {
+			status = RREG32_SOC15(VCN, i, mmUVD_STATUS);
+			if (status & 2)
+				break;
 			mdelay(10);
-			r = -1;
 		}
+		r = 0;
+		if (status & 2)
+			break;
 
-		if (r) {
-			DRM_ERROR("VCN[%d] decode not responding, giving up!!!\n", i);
-			return r;
-		}
+		DRM_ERROR("VCN[%d] decode not responding, trying to reset the VCPU!!!\n", i);
+		WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_VCPU_CNTL),
+			 UVD_VCPU_CNTL__BLK_RST_MASK,
+			 ~UVD_VCPU_CNTL__BLK_RST_MASK);
+		mdelay(10);
+		WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_VCPU_CNTL), 0,
+			 ~UVD_VCPU_CNTL__BLK_RST_MASK);
+
+		mdelay(10);
+		r = -1;
+	}
 
-		/* enable master interrupt */
-		WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_MASTINT_EN),
-			UVD_MASTINT_EN__VCPU_EN_MASK,
-			~UVD_MASTINT_EN__VCPU_EN_MASK);
+	if (r) {
+		DRM_ERROR("VCN[%d] decode not responding, giving up!!!\n", i);
+		return r;
+	}
 
-		/* clear the busy bit of VCN_STATUS */
-		WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_STATUS), 0,
-			~(2 << UVD_STATUS__VCPU_REPORT__SHIFT));
+	/* enable master interrupt */
+	WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_MASTINT_EN),
+		 UVD_MASTINT_EN__VCPU_EN_MASK,
+		 ~UVD_MASTINT_EN__VCPU_EN_MASK);
 
-		WREG32_SOC15(VCN, i, mmUVD_LMI_RBC_RB_VMID, 0);
+	/* clear the busy bit of VCN_STATUS */
+	WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_STATUS), 0,
+		 ~(2 << UVD_STATUS__VCPU_REPORT__SHIFT));
 
-		ring = &adev->vcn.inst[i].ring_dec;
-		/* force RBC into idle state */
-		rb_bufsz = order_base_2(ring->ring_size);
-		tmp = REG_SET_FIELD(0, UVD_RBC_RB_CNTL, RB_BUFSZ, rb_bufsz);
-		tmp = REG_SET_FIELD(tmp, UVD_RBC_RB_CNTL, RB_BLKSZ, 1);
-		tmp = REG_SET_FIELD(tmp, UVD_RBC_RB_CNTL, RB_NO_FETCH, 1);
-		tmp = REG_SET_FIELD(tmp, UVD_RBC_RB_CNTL, RB_NO_UPDATE, 1);
-		tmp = REG_SET_FIELD(tmp, UVD_RBC_RB_CNTL, RB_RPTR_WR_EN, 1);
-		WREG32_SOC15(VCN, i, mmUVD_RBC_RB_CNTL, tmp);
+	WREG32_SOC15(VCN, i, mmUVD_LMI_RBC_RB_VMID, 0);
 
-		fw_shared = adev->vcn.inst[i].fw_shared.cpu_addr;
-		fw_shared->multi_queue.decode_queue_mode |= cpu_to_le32(FW_QUEUE_RING_RESET);
+	ring = &adev->vcn.inst[i].ring_dec;
+	/* force RBC into idle state */
+	rb_bufsz = order_base_2(ring->ring_size);
+	tmp = REG_SET_FIELD(0, UVD_RBC_RB_CNTL, RB_BUFSZ, rb_bufsz);
+	tmp = REG_SET_FIELD(tmp, UVD_RBC_RB_CNTL, RB_BLKSZ, 1);
+	tmp = REG_SET_FIELD(tmp, UVD_RBC_RB_CNTL, RB_NO_FETCH, 1);
+	tmp = REG_SET_FIELD(tmp, UVD_RBC_RB_CNTL, RB_NO_UPDATE, 1);
+	tmp = REG_SET_FIELD(tmp, UVD_RBC_RB_CNTL, RB_RPTR_WR_EN, 1);
+	WREG32_SOC15(VCN, i, mmUVD_RBC_RB_CNTL, tmp);
 
-		/* programm the RB_BASE for ring buffer */
-		WREG32_SOC15(VCN, i, mmUVD_LMI_RBC_RB_64BIT_BAR_LOW,
-			lower_32_bits(ring->gpu_addr));
-		WREG32_SOC15(VCN, i, mmUVD_LMI_RBC_RB_64BIT_BAR_HIGH,
-			upper_32_bits(ring->gpu_addr));
+	fw_shared = adev->vcn.inst[i].fw_shared.cpu_addr;
+	fw_shared->multi_queue.decode_queue_mode |= cpu_to_le32(FW_QUEUE_RING_RESET);
 
-		/* Initialize the ring buffer's read and write pointers */
-		WREG32_SOC15(VCN, i, mmUVD_RBC_RB_RPTR, 0);
+	/* programm the RB_BASE for ring buffer */
+	WREG32_SOC15(VCN, i, mmUVD_LMI_RBC_RB_64BIT_BAR_LOW,
+		     lower_32_bits(ring->gpu_addr));
+	WREG32_SOC15(VCN, i, mmUVD_LMI_RBC_RB_64BIT_BAR_HIGH,
+		     upper_32_bits(ring->gpu_addr));
 
-		WREG32_SOC15(VCN, i, mmUVD_SCRATCH2, 0);
-		ring->wptr = RREG32_SOC15(VCN, i, mmUVD_RBC_RB_RPTR);
-		WREG32_SOC15(VCN, i, mmUVD_RBC_RB_WPTR,
-			lower_32_bits(ring->wptr));
-		fw_shared->rb.wptr = lower_32_bits(ring->wptr);
-		fw_shared->multi_queue.decode_queue_mode &= cpu_to_le32(~FW_QUEUE_RING_RESET);
-
-		if (amdgpu_ip_version(adev, UVD_HWIP, 0) !=
-		    IP_VERSION(3, 0, 33)) {
-			fw_shared->multi_queue.encode_generalpurpose_queue_mode |= cpu_to_le32(FW_QUEUE_RING_RESET);
-			ring = &adev->vcn.inst[i].ring_enc[0];
-			WREG32_SOC15(VCN, i, mmUVD_RB_RPTR, lower_32_bits(ring->wptr));
-			WREG32_SOC15(VCN, i, mmUVD_RB_WPTR, lower_32_bits(ring->wptr));
-			WREG32_SOC15(VCN, i, mmUVD_RB_BASE_LO, ring->gpu_addr);
-			WREG32_SOC15(VCN, i, mmUVD_RB_BASE_HI, upper_32_bits(ring->gpu_addr));
-			WREG32_SOC15(VCN, i, mmUVD_RB_SIZE, ring->ring_size / 4);
-			fw_shared->multi_queue.encode_generalpurpose_queue_mode &= cpu_to_le32(~FW_QUEUE_RING_RESET);
-
-			fw_shared->multi_queue.encode_lowlatency_queue_mode |= cpu_to_le32(FW_QUEUE_RING_RESET);
-			ring = &adev->vcn.inst[i].ring_enc[1];
-			WREG32_SOC15(VCN, i, mmUVD_RB_RPTR2, lower_32_bits(ring->wptr));
-			WREG32_SOC15(VCN, i, mmUVD_RB_WPTR2, lower_32_bits(ring->wptr));
-			WREG32_SOC15(VCN, i, mmUVD_RB_BASE_LO2, ring->gpu_addr);
-			WREG32_SOC15(VCN, i, mmUVD_RB_BASE_HI2, upper_32_bits(ring->gpu_addr));
-			WREG32_SOC15(VCN, i, mmUVD_RB_SIZE2, ring->ring_size / 4);
-			fw_shared->multi_queue.encode_lowlatency_queue_mode &= cpu_to_le32(~FW_QUEUE_RING_RESET);
-		}
+	/* Initialize the ring buffer's read and write pointers */
+	WREG32_SOC15(VCN, i, mmUVD_RBC_RB_RPTR, 0);
+
+	WREG32_SOC15(VCN, i, mmUVD_SCRATCH2, 0);
+	ring->wptr = RREG32_SOC15(VCN, i, mmUVD_RBC_RB_RPTR);
+	WREG32_SOC15(VCN, i, mmUVD_RBC_RB_WPTR,
+		     lower_32_bits(ring->wptr));
+	fw_shared->rb.wptr = lower_32_bits(ring->wptr);
+	fw_shared->multi_queue.decode_queue_mode &= cpu_to_le32(~FW_QUEUE_RING_RESET);
+
+	if (amdgpu_ip_version(adev, UVD_HWIP, 0) !=
+	    IP_VERSION(3, 0, 33)) {
+		fw_shared->multi_queue.encode_generalpurpose_queue_mode |= cpu_to_le32(FW_QUEUE_RING_RESET);
+		ring = &adev->vcn.inst[i].ring_enc[0];
+		WREG32_SOC15(VCN, i, mmUVD_RB_RPTR, lower_32_bits(ring->wptr));
+		WREG32_SOC15(VCN, i, mmUVD_RB_WPTR, lower_32_bits(ring->wptr));
+		WREG32_SOC15(VCN, i, mmUVD_RB_BASE_LO, ring->gpu_addr);
+		WREG32_SOC15(VCN, i, mmUVD_RB_BASE_HI, upper_32_bits(ring->gpu_addr));
+		WREG32_SOC15(VCN, i, mmUVD_RB_SIZE, ring->ring_size / 4);
+		fw_shared->multi_queue.encode_generalpurpose_queue_mode &= cpu_to_le32(~FW_QUEUE_RING_RESET);
+
+		fw_shared->multi_queue.encode_lowlatency_queue_mode |= cpu_to_le32(FW_QUEUE_RING_RESET);
+		ring = &adev->vcn.inst[i].ring_enc[1];
+		WREG32_SOC15(VCN, i, mmUVD_RB_RPTR2, lower_32_bits(ring->wptr));
+		WREG32_SOC15(VCN, i, mmUVD_RB_WPTR2, lower_32_bits(ring->wptr));
+		WREG32_SOC15(VCN, i, mmUVD_RB_BASE_LO2, ring->gpu_addr);
+		WREG32_SOC15(VCN, i, mmUVD_RB_BASE_HI2, upper_32_bits(ring->gpu_addr));
+		WREG32_SOC15(VCN, i, mmUVD_RB_SIZE2, ring->ring_size / 4);
+		fw_shared->multi_queue.encode_lowlatency_queue_mode &= cpu_to_le32(~FW_QUEUE_RING_RESET);
 	}
 
 	return 0;
@@ -1565,79 +1559,73 @@ static int vcn_v3_0_stop_dpg_mode(struct amdgpu_device *adev, int inst_idx)
 	return 0;
 }
 
-static int vcn_v3_0_stop(struct amdgpu_device *adev)
+static int vcn_v3_0_stop(struct amdgpu_device *adev, int i)
 {
 	uint32_t tmp;
-	int i, r = 0;
+	int r = 0;
 
-	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
-		if (adev->vcn.harvest_config & (1 << i))
-			continue;
+	if (adev->vcn.harvest_config & (1 << i))
+		return 0;
 
-		if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) {
-			r = vcn_v3_0_stop_dpg_mode(adev, i);
-			continue;
-		}
+	if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG)
+		return vcn_v3_0_stop_dpg_mode(adev, i);
 
-		/* wait for vcn idle */
-		r = SOC15_WAIT_ON_RREG(VCN, i, mmUVD_STATUS, UVD_STATUS__IDLE, 0x7);
-		if (r)
-			return r;
+	/* wait for vcn idle */
+	r = SOC15_WAIT_ON_RREG(VCN, i, mmUVD_STATUS, UVD_STATUS__IDLE, 0x7);
+	if (r)
+		return r;
 
-		tmp = UVD_LMI_STATUS__VCPU_LMI_WRITE_CLEAN_MASK |
-			UVD_LMI_STATUS__READ_CLEAN_MASK |
-			UVD_LMI_STATUS__WRITE_CLEAN_MASK |
-			UVD_LMI_STATUS__WRITE_CLEAN_RAW_MASK;
-		r = SOC15_WAIT_ON_RREG(VCN, i, mmUVD_LMI_STATUS, tmp, tmp);
-		if (r)
-			return r;
+	tmp = UVD_LMI_STATUS__VCPU_LMI_WRITE_CLEAN_MASK |
+		UVD_LMI_STATUS__READ_CLEAN_MASK |
+		UVD_LMI_STATUS__WRITE_CLEAN_MASK |
+		UVD_LMI_STATUS__WRITE_CLEAN_RAW_MASK;
+	r = SOC15_WAIT_ON_RREG(VCN, i, mmUVD_LMI_STATUS, tmp, tmp);
+	if (r)
+		return r;
 
-		/* disable LMI UMC channel */
-		tmp = RREG32_SOC15(VCN, i, mmUVD_LMI_CTRL2);
-		tmp |= UVD_LMI_CTRL2__STALL_ARB_UMC_MASK;
-		WREG32_SOC15(VCN, i, mmUVD_LMI_CTRL2, tmp);
-		tmp = UVD_LMI_STATUS__UMC_READ_CLEAN_RAW_MASK|
-			UVD_LMI_STATUS__UMC_WRITE_CLEAN_RAW_MASK;
-		r = SOC15_WAIT_ON_RREG(VCN, i, mmUVD_LMI_STATUS, tmp, tmp);
-		if (r)
-			return r;
+	/* disable LMI UMC channel */
+	tmp = RREG32_SOC15(VCN, i, mmUVD_LMI_CTRL2);
+	tmp |= UVD_LMI_CTRL2__STALL_ARB_UMC_MASK;
+	WREG32_SOC15(VCN, i, mmUVD_LMI_CTRL2, tmp);
+	tmp = UVD_LMI_STATUS__UMC_READ_CLEAN_RAW_MASK|
+		UVD_LMI_STATUS__UMC_WRITE_CLEAN_RAW_MASK;
+	r = SOC15_WAIT_ON_RREG(VCN, i, mmUVD_LMI_STATUS, tmp, tmp);
+	if (r)
+		return r;
 
-		/* block VCPU register access */
-		WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_RB_ARB_CTRL),
-			UVD_RB_ARB_CTRL__VCPU_DIS_MASK,
-			~UVD_RB_ARB_CTRL__VCPU_DIS_MASK);
+	/* block VCPU register access */
+	WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_RB_ARB_CTRL),
+		 UVD_RB_ARB_CTRL__VCPU_DIS_MASK,
+		 ~UVD_RB_ARB_CTRL__VCPU_DIS_MASK);
 
-		/* reset VCPU */
-		WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_VCPU_CNTL),
-			UVD_VCPU_CNTL__BLK_RST_MASK,
-			~UVD_VCPU_CNTL__BLK_RST_MASK);
+	/* reset VCPU */
+	WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_VCPU_CNTL),
+		 UVD_VCPU_CNTL__BLK_RST_MASK,
+		 ~UVD_VCPU_CNTL__BLK_RST_MASK);
 
-		/* disable VCPU clock */
-		WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_VCPU_CNTL), 0,
-			~(UVD_VCPU_CNTL__CLK_EN_MASK));
+	/* disable VCPU clock */
+	WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_VCPU_CNTL), 0,
+		 ~(UVD_VCPU_CNTL__CLK_EN_MASK));
 
-		/* apply soft reset */
-		tmp = RREG32_SOC15(VCN, i, mmUVD_SOFT_RESET);
-		tmp |= UVD_SOFT_RESET__LMI_UMC_SOFT_RESET_MASK;
-		WREG32_SOC15(VCN, i, mmUVD_SOFT_RESET, tmp);
-		tmp = RREG32_SOC15(VCN, i, mmUVD_SOFT_RESET);
-		tmp |= UVD_SOFT_RESET__LMI_SOFT_RESET_MASK;
-		WREG32_SOC15(VCN, i, mmUVD_SOFT_RESET, tmp);
+	/* apply soft reset */
+	tmp = RREG32_SOC15(VCN, i, mmUVD_SOFT_RESET);
+	tmp |= UVD_SOFT_RESET__LMI_UMC_SOFT_RESET_MASK;
+	WREG32_SOC15(VCN, i, mmUVD_SOFT_RESET, tmp);
+	tmp = RREG32_SOC15(VCN, i, mmUVD_SOFT_RESET);
+	tmp |= UVD_SOFT_RESET__LMI_SOFT_RESET_MASK;
+	WREG32_SOC15(VCN, i, mmUVD_SOFT_RESET, tmp);
 
-		/* clear status */
-		WREG32_SOC15(VCN, i, mmUVD_STATUS, 0);
+	/* clear status */
+	WREG32_SOC15(VCN, i, mmUVD_STATUS, 0);
 
-		/* apply HW clock gating */
-		vcn_v3_0_enable_clock_gating(adev, i);
+	/* apply HW clock gating */
+	vcn_v3_0_enable_clock_gating(adev, i);
 
-		/* enable VCN power gating */
-		vcn_v3_0_enable_static_power_gating(adev, i);
-	}
+	/* enable VCN power gating */
+	vcn_v3_0_enable_static_power_gating(adev, i);
 
-	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
-		if (adev->pm.dpm_enabled)
-			amdgpu_dpm_enable_vcn(adev, false, i);
-	}
+	if (adev->pm.dpm_enabled)
+		amdgpu_dpm_enable_vcn(adev, false, i);
 
 	return 0;
 }
@@ -2163,7 +2151,7 @@ static int vcn_v3_0_set_powergating_state(struct amdgpu_ip_block *ip_block,
 					  enum amd_powergating_state state)
 {
 	struct amdgpu_device *adev = ip_block->adev;
-	int ret;
+	int ret = 0, i;
 
 	/* for SRIOV, guest should not control VCN Power-gating
 	 * MMSCH FW should control Power-gating and clock-gating
@@ -2177,10 +2165,12 @@ static int vcn_v3_0_set_powergating_state(struct amdgpu_ip_block *ip_block,
 	if (state == adev->vcn.cur_state)
 		return 0;
 
-	if (state == AMD_PG_STATE_GATE)
-		ret = vcn_v3_0_stop(adev);
-	else
-		ret = vcn_v3_0_start(adev);
+	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
+		if (state == AMD_PG_STATE_GATE)
+			ret |= vcn_v3_0_stop(adev, i);
+		else
+			ret |= vcn_v3_0_start(adev, i);
+	}
 
 	if (!ret)
 		adev->vcn.cur_state = state;
-- 
2.48.1

