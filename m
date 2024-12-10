Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E300E77183
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Dec 2024 22:54:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DEE5310E2DD;
	Tue, 10 Dec 2024 22:54:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="dKJ553qi";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2086.outbound.protection.outlook.com [40.107.244.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 435AB10E9C2
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Dec 2024 22:54:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p3SxUTo/fhkBZjxzAda2HTVJplejVRFQJ60f6W3CnOFldc5EEpVhcjVYQ3gx62oPEmsVvm21GhiO69WKRawx8mKv5ZjjqEeqmIpA84fd/0kxEZ4pp9I7NIU0m1DZae3E2O3haOiJwtFH+Ji6b0TCcqfpW3mNqL0zCx5J5ER0i4VNNKkIQ5g0bIiUoBC1x2tfo4qHGpzzIkUTMKnE10fbqnLb18ZcLWLqgCbJ16WVad5JRrzXxTK9IjjXBtWJ8oI4J87wpmXpMXyazEEXZeBqb01T+bt2bFR6VjcvOO2nDCrbtmH8YofJtXQQzqL1/ToCoYjT2xg0sV3eboh+Q05vLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cnX7pGiP9rlbsmsrZuWV9+wY98a4P/rczszGuMMEeUc=;
 b=uDqdNdXCktqkXSyhtNUsY8QENr8pBOWJIySz9gOWEopN6cicwl5SKprzgS9xcw9hlsevEMc3TIAT+i3wwu4whcweFUtLJC8nqayidt9/Jts95fdeDRdx37D9lF6gxSdl2irIpZR/CNFzVwPPqlE0AtqYa1enQN5j/Yf+U5Z0s6VWXHOaSzqVoDxH7czcFsgL7AoFPEnMYGV4kHjrMvfOX1P3qYTkepihR/aJslGSymmCdRjNqB7uOqivx1y1mlPj43RV+bCaBhHw19SJTD4IzHv8gzkrwRpgoI6y+t0O+Cu8JbhB0u8uGcaUjt7Tzoaykp1fDdraNWWNxwxefR+jvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cnX7pGiP9rlbsmsrZuWV9+wY98a4P/rczszGuMMEeUc=;
 b=dKJ553qiOhIGGH1dHsd5pSlAzwdxBG+3q0PBUZBfmaO4TB//cK6w02V4Tn3w1EgUKmrIBCyRVHU5jM7uhqbhd21jK/H7BlR+r19JsD/nLQiJwbhkzWo0fwOQ4boMwEC3aT+7FFstCwMhNDmNXH4mQG/JKMCztYkRir8eMxzIPHc=
Received: from BN9PR03CA0232.namprd03.prod.outlook.com (2603:10b6:408:f8::27)
 by LV8PR12MB9111.namprd12.prod.outlook.com (2603:10b6:408:189::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.15; Tue, 10 Dec
 2024 22:53:54 +0000
Received: from BN2PEPF000055DA.namprd21.prod.outlook.com
 (2603:10b6:408:f8:cafe::f) by BN9PR03CA0232.outlook.office365.com
 (2603:10b6:408:f8::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8230.12 via Frontend Transport; Tue,
 10 Dec 2024 22:53:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000055DA.mail.protection.outlook.com (10.167.245.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8272.0 via Frontend Transport; Tue, 10 Dec 2024 22:53:54 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 10 Dec
 2024 16:53:53 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 02/48] drm/amdgpu/vcn3.0: split code along instances
Date: Tue, 10 Dec 2024 17:52:51 -0500
Message-ID: <20241210225337.75394-3-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241210225337.75394-1-alexander.deucher@amd.com>
References: <20241210225337.75394-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000055DA:EE_|LV8PR12MB9111:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d905c41-ec7c-4314-62e3-08dd196d85f5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|30052699003|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?uRWTRxhAjtnh9Ts3jiF55wYr4+FUYr83OL1EEmkbgndd+11JszGQdq0GJ7Z6?=
 =?us-ascii?Q?2gMayJc8vMeOltfB4uRhYoNO4D8g3ozY8k5TAta1gqaBTCxgtxFYy22OmEVI?=
 =?us-ascii?Q?AWWHSwZ7jHAms5iTm/Qdh+ZVnj8MuPzvOt8fo/DP711jExEvEfgXcB637Kd5?=
 =?us-ascii?Q?hmTTFwOrJJ2CsLZ2mf8aX9sLpBsAHuiMPdx/S7vAjCbWpVw441ZzbvRcQDG9?=
 =?us-ascii?Q?MxGUGoGIN/HszUzNTl6ILZiALdJUPNuEIxN2CvUmlm83Je8FUZWKZKBjPQI0?=
 =?us-ascii?Q?G3ogo48ujIoEnIax2Y42syyN1L+PfEfhiUnf/tJAw2xHJbo5MDEOoCmylMCK?=
 =?us-ascii?Q?Wv1KzbStGsihRCnC69wN/6QwuWUzLxSiRUiuf59ylu91FqCRDdjzE1Ewe77J?=
 =?us-ascii?Q?TD2Ds6ZIYgCTIEwnhH8k//k8F0b6zh6sVS7b/cxJetGrB1gCH2kZoo+4YUa5?=
 =?us-ascii?Q?d/80ytvDs8gSfT8milq18PCCdWkgCgKJ/c5wIa0ZFl7YFmGibwfjY05JKzKb?=
 =?us-ascii?Q?Bz4M7NrM71/E/jux7+PS5lkzA2/3VvLU9ghP3xnIpbwFqc7qvuzN1K34abm+?=
 =?us-ascii?Q?kXE9k6zqlf5yreBAopAgldzsw+heE3e36OKcvsajHaOPWsZUvBYflFA3wm5y?=
 =?us-ascii?Q?y4JJD8QSTeoFg9VyO1mM4ogRP6FnLBCeZv/YgRlzluA0IA1wXqfTsO44sinV?=
 =?us-ascii?Q?nHOOakJp+LAL2im7eLAhOeau5bnpUfnpg8vr5FISnslKrxAfHQBH1BjL3e1O?=
 =?us-ascii?Q?ZH5HwTpsCriRyRMXq84PoeYs9AfGlEIjpL7Lgs2hnkaSWjBvZ/+RWfhiC/vl?=
 =?us-ascii?Q?lDy85x6f8hTEB1t7zSakeF6A1X+4vhcsV/GeRf8FCx5AY/3RlnxH6t+WoIO8?=
 =?us-ascii?Q?2nnGFcM1iq43gvqB272qPlXjizbaAJORA68D+YuBg6aXyIYBL5t01AG/Y7QP?=
 =?us-ascii?Q?PVseznbqROuwcj19nHnWAFk6MUIwYQgQA7cMT4sXS1/Cn2dEGJP9A+5vhhCu?=
 =?us-ascii?Q?3kd0UEOJnctQIIKpbN50zD+SQ/UKmdDzLFQ69tct+TwLMWXORahtEoYovT2P?=
 =?us-ascii?Q?HdHUTlX0H5+II0upWPtugVwFt0i5rYNld79HChBdjl3CcAtUgjI/zNkfyW/Y?=
 =?us-ascii?Q?a5Z6aEkU3obRzA0nNhFMXQeWyOoLkeYQadKQrXbPJNHWBhOd1QIMWr8ShcYq?=
 =?us-ascii?Q?CTzuSMegJ/HzMwc+tvjKgu4l4FKlHJEg6Fe+e9i42JYQIPtMvp4SlaJ/gKXw?=
 =?us-ascii?Q?xG/5NY/3dwEtku+/SkqBdSzH/sNaFiaAgknt23Kj//tqa7WN4XeG1RKOwzd6?=
 =?us-ascii?Q?uBubvX7CQLu+HzCj2gWQGOYrWmzp+4WBoTJb0tPwqeSMhov6oww8dhIuBgCk?=
 =?us-ascii?Q?/QoUwHM3aHqrtPRo+/xrAiIw2nl5kcNfJsyrU6gPDHEMF0tK3Q=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(30052699003)(1800799024)(82310400026);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2024 22:53:54.5434 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d905c41-ec7c-4314-62e3-08dd196d85f5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000055DA.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9111
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
2.47.1

