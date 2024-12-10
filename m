Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E56DE77182
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Dec 2024 22:54:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4B06B10E9C4;
	Tue, 10 Dec 2024 22:54:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="m5nxrEFT";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2087.outbound.protection.outlook.com [40.107.236.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2CB1C10E2DD
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Dec 2024 22:54:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PQ9B6ooHCZDhuIHwhuI+bJOWcYYv0d+fndLT8oEzF9sflVyLM0gqZH4kTUToxHvzqJlnXTtGYr9Msvc4UtfG9d+MqWggo/9UGl3hgb9vB//8y4SEiBKyRWsjVa3wu//dRDL4aXV2/4S+uNvvDR7XyU7M4oj8WkKTk71teg+64FnQ/s411Agh/K6VS5pTxKHlLcgVrfT+faHccipkPDKsqftoXPOGC68KsXHuC7Hcb8xqthdZ20K3OH4TUy/GsyfD6ZPbyHbngsmZ4rXjH+JGkENiAwCnWytIyW+N9tOYq5o002z57IlIhB8qAAzCKWtXwF9iYSXYZt5lTS5hjtPrug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XviVzvZ1+lmsUzBPld6I1bU99D3p7ivw1bBUxVgOgoM=;
 b=cYzI9P98B27jQvYbrskAlFVligqrFeB8MWh/7QJFixCpBQ4KcWad4NmfQtWBDGn1NRqpKwxoQcSA11lgm4YkL6JgAL+cEa/vN/oh9ZGgvJRXWDUamIEYpkA9yZjzQ4AqqDfPeTtpq7KBYaiTvaaIR5hcIXvZXqY+wFqwdrlY4dR7VqgZNj5Tqq+5jN9YeugYDQY72panhvp1oXzHFZCY5nfqr8jRbbqKIhzGJyfzzEofxYJw5gCjCdb2Me8QQi+leoVI9NKLT1wPL+OiV2h3hpcCbPYx/5AeOh+IgyaX37EAmyPKotV5MVjqd5WpqKWu6M98pCyiPkYFClm5spGuVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XviVzvZ1+lmsUzBPld6I1bU99D3p7ivw1bBUxVgOgoM=;
 b=m5nxrEFTOn6fEioyMqR6udpygMhT5tETQcR+HJ6YfVKewrMdehl+/OyQaCCRNXfYtKMesa4C4973UMd4fCVzFV81HSDgBH70fuomAlUG8aIY5RmUtvL2wYEukO1Z867uL5hNp8tW0Bz2aAFzgAmr48uOOGGl0Kxllj4W1K2oHeE=
Received: from BN9PR03CA0214.namprd03.prod.outlook.com (2603:10b6:408:f8::9)
 by SA3PR12MB9129.namprd12.prod.outlook.com (2603:10b6:806:397::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.14; Tue, 10 Dec
 2024 22:53:55 +0000
Received: from BN2PEPF000055DA.namprd21.prod.outlook.com
 (2603:10b6:408:f8:cafe::66) by BN9PR03CA0214.outlook.office365.com
 (2603:10b6:408:f8::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8207.19 via Frontend Transport; Tue,
 10 Dec 2024 22:53:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000055DA.mail.protection.outlook.com (10.167.245.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8272.0 via Frontend Transport; Tue, 10 Dec 2024 22:53:55 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 10 Dec
 2024 16:53:54 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 04/48] drm/amdgpu/vcn4.0.3: split code along instances
Date: Tue, 10 Dec 2024 17:52:53 -0500
Message-ID: <20241210225337.75394-5-alexander.deucher@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF000055DA:EE_|SA3PR12MB9129:EE_
X-MS-Office365-Filtering-Correlation-Id: 3b06f751-7857-4f4c-5bdb-08dd196d8690
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|30052699003|36860700013|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?tsBiLjjlIiwCJUe8VTl293SUCpiScANxAR7mZ6C+4ZrGccbgDJu4eHUa44EP?=
 =?us-ascii?Q?uUJQ9XFTn1gi/go/BsHIWsPZ1bCVkjY/q7qAO62/plomuoYeApUTPsH5ce/Y?=
 =?us-ascii?Q?hLF90GDo7ZwpGou1jH8LOwjpu67quRoAPLJRASacOFlLMpVRwn88Gdvq3+Xs?=
 =?us-ascii?Q?2lKQI3GPCcmtYU0lb0dFUxq/WP/AQqmU3LeR4wIfpeNBww3PdTFm9qdmXIhF?=
 =?us-ascii?Q?s2yV5cI3AgW9E1sjBOJhVD3laFaEuWteEP/W+8nh/+/tVIrF4OpzN0A9Tot2?=
 =?us-ascii?Q?YRMT3xtYzZjttlamMi1LskQXIbogl4BiLueFLxGQDfypVKHCb4Swne202rDp?=
 =?us-ascii?Q?rdbkgfVy93YPv78K9zwF4cxh9IV8JWxFvQ3JGegzEwK9czCzCcwKCH4/TdsB?=
 =?us-ascii?Q?m9r9ccuBptanq1jDck5k8JHkiygXXagR/jWNpzphHPYnp6iqMcssGleYkCH4?=
 =?us-ascii?Q?WwmrTbrUzNMm9x6+v+FfglzGElFT5q7wRAq1vEgEwTfCz879mx3YMPxFgdq8?=
 =?us-ascii?Q?5rktkwoU/EwYN5W7Aio8mxun9obkVOdZ2RnfDQnlizTkAc4Ji+94UN5WKc/G?=
 =?us-ascii?Q?f4d7fXbdBugAFfQNlY6YNUVi2h2zbUybpzhbdkasmY9XWBh9OA5w7A/Bca+1?=
 =?us-ascii?Q?k1eYvrWfymkJ1zAUBZOw7ljNvPwtxuFv9t1GwfG8V21NG54sWXDEsr7D5KIm?=
 =?us-ascii?Q?zsLTn2H4ou3VKEfuA5EQsBU0TkvKcs7PdCUD/cQ80FAI1bDcFwlyML81C0Rm?=
 =?us-ascii?Q?pAQHO9hwZoe3LJlHqKTdEHAlEWOgW0x6nTaJiFRwguqt0flo5YXsNRkWzz7u?=
 =?us-ascii?Q?iY5Tgq88DPSQwmvn1elyJhEq3CGb3NGNZGkB0vpQs07/kutzwgooYphDurBy?=
 =?us-ascii?Q?tvO2mbluac5AJP4/qvkubhivgQZlADN7J4PBgfkfZ2r4sE5axNh6go9awcKC?=
 =?us-ascii?Q?7gCgZyWj9RnopdH8QK6/qc8G+rM4Uau9oAgMh7gVAbacSbYyrjhyCbXuG36Y?=
 =?us-ascii?Q?48rpGC3CnicykwpLv1URZKVgP1sRW9N8ZUPdH6L3zAVBYPO32n1o7VJ+/Pmm?=
 =?us-ascii?Q?IkO2X7zXq+/niEL08h6ZVAtqqaJF5BdNYwcK+/lEjkZrH4khk0MeV8kUBoQt?=
 =?us-ascii?Q?zLzIBnqm4HK/Dwd8r0OeUCqLGPXfg+7pFAqLMrnMW+sJPNVNu/NXaNlMvk+A?=
 =?us-ascii?Q?hMgkNhiogo+jaFJdYQCuC5bfIidUfypttci0kI8ocMszTrB8yd45QFFdx1q2?=
 =?us-ascii?Q?1PbPw+JxR1PeIHT4X+uzbid8HtWUp37zVy4ZcsmhCkMX5IADZrOTQqa2YPAJ?=
 =?us-ascii?Q?nlSkSEaxfj4MTuMoS6YjAVvTSO975oQMFC8f2rU8Zuxp0a9bGB0NT8e3BPWw?=
 =?us-ascii?Q?fbDZVDBFnkFh44Da8APHN2qN1KuRuSQGoBa+ED9RJnYuAxxc5g=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(30052699003)(36860700013)(82310400026)(1800799024);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2024 22:53:55.5590 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b06f751-7857-4f4c-5bdb-08dd196d8690
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000055DA.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9129
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
index eeade7366e829..efc61e62e8d0b 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
@@ -1111,177 +1111,172 @@ static int vcn_v4_0_3_start_sriov(struct amdgpu_device *adev)
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
 
-		/* program the RB_BASE for ring buffer */
-		WREG32_SOC15(VCN, vcn_inst, regUVD_RB_BASE_LO,
-			     lower_32_bits(ring->gpu_addr));
-		WREG32_SOC15(VCN, vcn_inst, regUVD_RB_BASE_HI,
-			     upper_32_bits(ring->gpu_addr));
+	/* clear the busy bit of VCN_STATUS */
+	WREG32_P(SOC15_REG_OFFSET(VCN, vcn_inst, regUVD_STATUS), 0,
+		 ~(2 << UVD_STATUS__VCPU_REPORT__SHIFT));
 
-		WREG32_SOC15(VCN, vcn_inst, regUVD_RB_SIZE,
-			     ring->ring_size / sizeof(uint32_t));
+	ring = &adev->vcn.inst[i].ring_enc[0];
+	fw_shared = adev->vcn.inst[i].fw_shared.cpu_addr;
 
-		/* resetting ring, fw should not check RB ring */
-		tmp = RREG32_SOC15(VCN, vcn_inst, regVCN_RB_ENABLE);
-		tmp &= ~(VCN_RB_ENABLE__RB_EN_MASK);
-		WREG32_SOC15(VCN, vcn_inst, regVCN_RB_ENABLE, tmp);
+	/* program the RB_BASE for ring buffer */
+	WREG32_SOC15(VCN, vcn_inst, regUVD_RB_BASE_LO,
+		     lower_32_bits(ring->gpu_addr));
+	WREG32_SOC15(VCN, vcn_inst, regUVD_RB_BASE_HI,
+		     upper_32_bits(ring->gpu_addr));
+
+	WREG32_SOC15(VCN, vcn_inst, regUVD_RB_SIZE,
+		     ring->ring_size / sizeof(uint32_t));
+
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
 
@@ -1321,86 +1316,84 @@ static int vcn_v4_0_3_stop_dpg_mode(struct amdgpu_device *adev, int inst_idx)
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
@@ -1657,7 +1650,7 @@ static int vcn_v4_0_3_set_powergating_state(struct amdgpu_ip_block *ip_block,
 					  enum amd_powergating_state state)
 {
 	struct amdgpu_device *adev = ip_block->adev;
-	int ret;
+	int ret = 0, i;
 
 	/* for SRIOV, guest should not control VCN Power-gating
 	 * MMSCH FW should control Power-gating and clock-gating
@@ -1671,10 +1664,12 @@ static int vcn_v4_0_3_set_powergating_state(struct amdgpu_ip_block *ip_block,
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
2.47.1

