Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1E39C0218F
	for <amd-gfx@archiver.kernel.org>; Fri, 31 Jan 2025 16:58:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8EE9C10E3B3;
	Fri, 31 Jan 2025 16:58:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="MSjDYDKV";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2065.outbound.protection.outlook.com [40.107.244.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3A0D510E3B3
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 Jan 2025 16:58:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FCIhf2BCFI2Q1Y36D/VTPncowVs2RP/47/0DnGtWnGU18lQGWSkRr1Foa5HRt8QtUsxO2UqhGZrd6levkIRPv7Cd1LGAO1Ei4xrJFdo5H2zil7/F31OgJQMqgiCg6CNt1/msu3i/Dn+5mpZ+Kh4YtKL3RwJCywQBYap0OlXG+vppedQydQ9MuxD21xPJ8dgoGZr1FHz6bAe0OAS5aM0vumRt/wv6+19wJa5icb9Wo7dp5Tijw5UWVl17jIcTqVevf67hIUGFA9Zgl1tFfy1hZO6j1meKoP++zkCsy1SOkhTLMUBvE0Y8/Sa3E8FcRVFoDWZc1hcN1pxPXRLpx3H+2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PUEexB9WqTksFvpjdUxumfqrwrZKwKYo0w8Y9SbWb7k=;
 b=Q/RMQCHs6H86GcKY3CNFa8WIKTXeukToX0O21AKeE73MSUwxPhPV8OlSEE9I7iFAgbANHXV67PwbV6C7/MUmMfevDKBccXnxEGEteWz8y/YRgduqNfKiHdEJD2Ap6qnRbF/WTKcYbroHEg9DlCUm3mxEWEadNsk7CYx2TmjnDpx3gPRBHrfcwllmwqkiVSyDMjgxDvmi5Sql3LaL9I/HZHqfXbWhg5ECQO3pQgQd3qAsxvoR4zBUOr8lolu7oVfHK/Q08YjC/MtM/a8rHGRNkcpxHwD3XrmS7psmKan8uzyKS0qyYOeMx221X7KkdLIngK8aMf1+/ZnxSdTErpJ9sQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PUEexB9WqTksFvpjdUxumfqrwrZKwKYo0w8Y9SbWb7k=;
 b=MSjDYDKV3RZG2Y8HvkxVbLYA0H/EthSsCqmpBlmWgUTschGHIQNu2PT9bEtQ9oUPpTFUeTMuBZC2XCtKkCbpMir3QLSYxGsjIASub0NWHdRCAPtFGyt78v3P9s1zZ91AojiAA1mYO1AXIsWTZNwGQUYOtYzah9vb4/nNLQ0kdEg=
Received: from DM6PR07CA0101.namprd07.prod.outlook.com (2603:10b6:5:337::34)
 by PH7PR12MB6668.namprd12.prod.outlook.com (2603:10b6:510:1aa::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.18; Fri, 31 Jan
 2025 16:58:09 +0000
Received: from DS2PEPF0000343C.namprd02.prod.outlook.com
 (2603:10b6:5:337:cafe::c3) by DM6PR07CA0101.outlook.office365.com
 (2603:10b6:5:337::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.21 via Frontend Transport; Fri,
 31 Jan 2025 16:58:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF0000343C.mail.protection.outlook.com (10.167.18.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8398.14 via Frontend Transport; Fri, 31 Jan 2025 16:58:06 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 31 Jan
 2025 10:58:03 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 07/44] drm/amdgpu/vcn5.0.1: split code along instances
Date: Fri, 31 Jan 2025 11:57:03 -0500
Message-ID: <20250131165741.1798488-8-alexander.deucher@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343C:EE_|PH7PR12MB6668:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b49c66b-bc87-461b-95d3-08dd42186f4f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?pGr3u1XwC1PqLmoIY/T15oPhIR8xaFJdLiJ8txfS/Y//CzOP54FtF5nd8jo3?=
 =?us-ascii?Q?HzjcrcWmyVtB0DJE9GD/aHHlwg+n3xIQ2/pP8TaDfZxkxROd6GrzUf5rImFr?=
 =?us-ascii?Q?BwxPIOTb71lqv4Qpt/MtI+/Vziq1k4u603GxjVtX/lAo1dRrMWv0zJbsTAPr?=
 =?us-ascii?Q?Vtn+E1Fwge0o/KA4ejcj2Z6xs+TsEnbgpOatctsdNVgnFBVqH/nQBaUygEv3?=
 =?us-ascii?Q?loWikKNL8y7aWdmRyEKDNABALQSzAqpNYb1KToyvtg9RsTTrxLXgmOOIeM50?=
 =?us-ascii?Q?/U/avYxY81aVybkf3Qa359CeTifG3qgXGKzWHPbIu+GhzDiiXOzm9EPbe769?=
 =?us-ascii?Q?am7x+Fd7n+f1MAZyBOJDv4r7QFYLHdpP9xiie/j0hjx9WPsU63D+UJ4t3trV?=
 =?us-ascii?Q?f5uZAtyUsMKfucxuL93CPRe6afp6WMRC7TGWB9ima21EuiQ2mqGRxEglBBn/?=
 =?us-ascii?Q?XHrP2Qfkfv/JpPpH1lX/jdmmpIak2V93cwGyFYMrXsCQJeXRL7weykO2Dcic?=
 =?us-ascii?Q?oV45QG6yg6gIjLCgDZhtZbgmk+Y296UGxVaIIUERz1lPYEOpxFzWzttWcmki?=
 =?us-ascii?Q?7CzF1xds3/tUIyHuND3ALCeh+/raZgC3lO7gwRehqMDEIsn5qtpm/IkzgAkS?=
 =?us-ascii?Q?AmyUpgVzD1odz3RNduLIIMcVSM5zXHN46WL36ndPLRTa2pTDABk6jqSWS9eC?=
 =?us-ascii?Q?scOie/kUnPJUpr5fK1448aEnjILEEwIgzKC+i8/56McHBCJWPmpzO3v8znwO?=
 =?us-ascii?Q?/c0oHLHWIQiNk49VDe0dnvQD3KQs1kpXcLwaaOnO6JTz+SctiLhrssENz/Dm?=
 =?us-ascii?Q?kBT95QL8xgx+Qioo/qmkAAnt1u+0Ng0f7VNYGt5vBx39mgFrUWuJw2lR0THu?=
 =?us-ascii?Q?X7Ll8dGfoBLjyvBKcR1hDWUalDIaJGXL7zOKRGVrYhvZ4Mf5Xj03YHR3SKW/?=
 =?us-ascii?Q?o64/7vzqhcbY07/4A35IHgnFrVJ/GAPws49lErpVldMOCFTyQ4KQYN5t/3+N?=
 =?us-ascii?Q?VVRi06UKpFpGFqJhoBVAjcmC5lRbJlY+6jGprilDK/yfNUMjJqRsBPx8AKxY?=
 =?us-ascii?Q?o6J9jYR9en7JiwwO8ChcSvyqU9CGQ7A+PrGEXQ+xCcYK3VXpgugZd5Vm1Aec?=
 =?us-ascii?Q?U4ALrXg67vY4vC6EF2fjENA78C08n53AZDGCmvSiRabbXA/bcpuyhtJLye05?=
 =?us-ascii?Q?bjNkLzXPYaA+1OGaQpOOrDe92mnUJ21ZkD7B70CGO+zsvAMWbg2kPj4qyhLV?=
 =?us-ascii?Q?X924g5fc21u0TPLKI0XstCOytv3atbxskHrktXNvepkiZQU1HSHMNXcxnYYY?=
 =?us-ascii?Q?rBZD/sIhuSelshXXSoioGJ/joU9KXBVG9OjS3WGQjcD+5sdJHWZdsnBT0D1P?=
 =?us-ascii?Q?joWCNu73iVbiUyr03xFQAyDhS00o8xxwWkUBO+bT3cViat/Sdu79T0JFqycR?=
 =?us-ascii?Q?c7/G6/booxE1+TfR4xA+roQug1ZmbNu2aQrYJ1Qk5p7mXvEisbhWCw=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2025 16:58:06.9519 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b49c66b-bc87-461b-95d3-08dd42186f4f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF0000343C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6668
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
 drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c | 352 ++++++++++++------------
 1 file changed, 174 insertions(+), 178 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
index 8b463c977d08f..25abb303d6698 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
@@ -568,149 +568,145 @@ static int vcn_v5_0_1_start_dpg_mode(struct amdgpu_device *adev, int inst_idx, b
  *
  * Start VCN block
  */
-static int vcn_v5_0_1_start(struct amdgpu_device *adev)
+static int vcn_v5_0_1_start(struct amdgpu_device *adev, int i)
 {
 	volatile struct amdgpu_vcn4_fw_shared *fw_shared;
 	struct amdgpu_ring *ring;
 	uint32_t tmp;
-	int i, j, k, r, vcn_inst;
+	int j, k, r, vcn_inst;
 
 	if (adev->pm.dpm_enabled)
 		amdgpu_dpm_enable_uvd(adev, true);
 
-	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
-		fw_shared = adev->vcn.inst[i].fw_shared.cpu_addr;
+	fw_shared = adev->vcn.inst[i].fw_shared.cpu_addr;
 
-		if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) {
-			r = vcn_v5_0_1_start_dpg_mode(adev, i, adev->vcn.indirect_sram);
-			continue;
-		}
+	if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG)
+		return vcn_v5_0_1_start_dpg_mode(adev, i, adev->vcn.indirect_sram);
 
-		vcn_inst = GET_INST(VCN, i);
+	vcn_inst = GET_INST(VCN, i);
 
-		/* set VCN status busy */
-		tmp = RREG32_SOC15(VCN, vcn_inst, regUVD_STATUS) | UVD_STATUS__UVD_BUSY;
-		WREG32_SOC15(VCN, vcn_inst, regUVD_STATUS, tmp);
-
-		/* enable VCPU clock */
-		WREG32_P(SOC15_REG_OFFSET(VCN, vcn_inst, regUVD_VCPU_CNTL),
-			UVD_VCPU_CNTL__CLK_EN_MASK, ~UVD_VCPU_CNTL__CLK_EN_MASK);
-
-		/* disable master interrupt */
-		WREG32_P(SOC15_REG_OFFSET(VCN, vcn_inst, regUVD_MASTINT_EN), 0,
-			~UVD_MASTINT_EN__VCPU_EN_MASK);
-
-		/* enable LMI MC and UMC channels */
-		WREG32_P(SOC15_REG_OFFSET(VCN, vcn_inst, regUVD_LMI_CTRL2), 0,
-			~UVD_LMI_CTRL2__STALL_ARB_UMC_MASK);
-
-		tmp = RREG32_SOC15(VCN, vcn_inst, regUVD_SOFT_RESET);
-		tmp &= ~UVD_SOFT_RESET__LMI_SOFT_RESET_MASK;
-		tmp &= ~UVD_SOFT_RESET__LMI_UMC_SOFT_RESET_MASK;
-		WREG32_SOC15(VCN, vcn_inst, regUVD_SOFT_RESET, tmp);
-
-		/* setup regUVD_LMI_CTRL */
-		tmp = RREG32_SOC15(VCN, vcn_inst, regUVD_LMI_CTRL);
-		WREG32_SOC15(VCN, vcn_inst, regUVD_LMI_CTRL, tmp |
-			UVD_LMI_CTRL__WRITE_CLEAN_TIMER_EN_MASK |
-			UVD_LMI_CTRL__MASK_MC_URGENT_MASK |
-			UVD_LMI_CTRL__DATA_COHERENCY_EN_MASK |
-			UVD_LMI_CTRL__VCPU_DATA_COHERENCY_EN_MASK);
-
-		vcn_v5_0_1_mc_resume(adev, i);
-
-		/* VCN global tiling registers */
-		WREG32_SOC15(VCN, vcn_inst, regUVD_GFX10_ADDR_CONFIG,
-			adev->gfx.config.gb_addr_config);
-
-		/* unblock VCPU register access */
-		WREG32_P(SOC15_REG_OFFSET(VCN, vcn_inst, regUVD_RB_ARB_CTRL), 0,
-			~UVD_RB_ARB_CTRL__VCPU_DIS_MASK);
-
-		/* release VCPU reset to boot */
-		WREG32_P(SOC15_REG_OFFSET(VCN, vcn_inst, regUVD_VCPU_CNTL), 0,
-			~UVD_VCPU_CNTL__BLK_RST_MASK);
-
-		for (j = 0; j < 10; ++j) {
-			uint32_t status;
-
-			for (k = 0; k < 100; ++k) {
-				status = RREG32_SOC15(VCN, vcn_inst, regUVD_STATUS);
-				if (status & 2)
-					break;
-				mdelay(100);
-				if (amdgpu_emu_mode == 1)
-					msleep(20);
-			}
+	/* set VCN status busy */
+	tmp = RREG32_SOC15(VCN, vcn_inst, regUVD_STATUS) | UVD_STATUS__UVD_BUSY;
+	WREG32_SOC15(VCN, vcn_inst, regUVD_STATUS, tmp);
+
+	/* enable VCPU clock */
+	WREG32_P(SOC15_REG_OFFSET(VCN, vcn_inst, regUVD_VCPU_CNTL),
+		 UVD_VCPU_CNTL__CLK_EN_MASK, ~UVD_VCPU_CNTL__CLK_EN_MASK);
+
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
+	WREG32_SOC15(VCN, vcn_inst, regUVD_LMI_CTRL, tmp |
+		     UVD_LMI_CTRL__WRITE_CLEAN_TIMER_EN_MASK |
+		     UVD_LMI_CTRL__MASK_MC_URGENT_MASK |
+		     UVD_LMI_CTRL__DATA_COHERENCY_EN_MASK |
+		     UVD_LMI_CTRL__VCPU_DATA_COHERENCY_EN_MASK);
+
+	vcn_v5_0_1_mc_resume(adev, i);
+
+	/* VCN global tiling registers */
+	WREG32_SOC15(VCN, vcn_inst, regUVD_GFX10_ADDR_CONFIG,
+		     adev->gfx.config.gb_addr_config);
+
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
+			status = RREG32_SOC15(VCN, vcn_inst, regUVD_STATUS);
+			if (status & 2)
+				break;
+			mdelay(100);
+			if (amdgpu_emu_mode == 1)
+				msleep(20);
+		}
 
-			if (amdgpu_emu_mode == 1) {
-				r = -1;
-				if (status & 2) {
-					r = 0;
-					break;
-				}
-			} else {
+		if (amdgpu_emu_mode == 1) {
+			r = -1;
+			if (status & 2) {
 				r = 0;
-				if (status & 2)
-					break;
-
-				dev_err(adev->dev,
-				    "VCN[%d] is not responding, trying to reset the VCPU!!!\n", i);
-				WREG32_P(SOC15_REG_OFFSET(VCN, vcn_inst, regUVD_VCPU_CNTL),
-							UVD_VCPU_CNTL__BLK_RST_MASK,
-							~UVD_VCPU_CNTL__BLK_RST_MASK);
-				mdelay(10);
-				WREG32_P(SOC15_REG_OFFSET(VCN, vcn_inst, regUVD_VCPU_CNTL), 0,
-							~UVD_VCPU_CNTL__BLK_RST_MASK);
-
-				mdelay(10);
-				r = -1;
+				break;
 			}
+		} else {
+			r = 0;
+			if (status & 2)
+				break;
+
+			dev_err(adev->dev,
+				"VCN[%d] is not responding, trying to reset the VCPU!!!\n", i);
+			WREG32_P(SOC15_REG_OFFSET(VCN, vcn_inst, regUVD_VCPU_CNTL),
+				 UVD_VCPU_CNTL__BLK_RST_MASK,
+				 ~UVD_VCPU_CNTL__BLK_RST_MASK);
+			mdelay(10);
+			WREG32_P(SOC15_REG_OFFSET(VCN, vcn_inst, regUVD_VCPU_CNTL), 0,
+				 ~UVD_VCPU_CNTL__BLK_RST_MASK);
+
+			mdelay(10);
+			r = -1;
 		}
+	}
 
-		if (r) {
-			dev_err(adev->dev, "VCN[%d] is not responding, giving up!!!\n", i);
-			return r;
-		}
+	if (r) {
+		dev_err(adev->dev, "VCN[%d] is not responding, giving up!!!\n", i);
+		return r;
+	}
 
-		/* enable master interrupt */
-		WREG32_P(SOC15_REG_OFFSET(VCN, vcn_inst, regUVD_MASTINT_EN),
-				UVD_MASTINT_EN__VCPU_EN_MASK,
-				~UVD_MASTINT_EN__VCPU_EN_MASK);
+	/* enable master interrupt */
+	WREG32_P(SOC15_REG_OFFSET(VCN, vcn_inst, regUVD_MASTINT_EN),
+		 UVD_MASTINT_EN__VCPU_EN_MASK,
+		 ~UVD_MASTINT_EN__VCPU_EN_MASK);
 
-		/* clear the busy bit of VCN_STATUS */
-		WREG32_P(SOC15_REG_OFFSET(VCN, vcn_inst, regUVD_STATUS), 0,
-			~(2 << UVD_STATUS__VCPU_REPORT__SHIFT));
+	/* clear the busy bit of VCN_STATUS */
+	WREG32_P(SOC15_REG_OFFSET(VCN, vcn_inst, regUVD_STATUS), 0,
+		 ~(2 << UVD_STATUS__VCPU_REPORT__SHIFT));
 
-		ring = &adev->vcn.inst[i].ring_enc[0];
+	ring = &adev->vcn.inst[i].ring_enc[0];
 
-		WREG32_SOC15(VCN, vcn_inst, regVCN_RB1_DB_CTRL,
-			ring->doorbell_index << VCN_RB1_DB_CTRL__OFFSET__SHIFT |
-			VCN_RB1_DB_CTRL__EN_MASK);
+	WREG32_SOC15(VCN, vcn_inst, regVCN_RB1_DB_CTRL,
+		     ring->doorbell_index << VCN_RB1_DB_CTRL__OFFSET__SHIFT |
+		     VCN_RB1_DB_CTRL__EN_MASK);
 
-		/* Read DB_CTRL to flush the write DB_CTRL command. */
-		RREG32_SOC15(VCN, vcn_inst, regVCN_RB1_DB_CTRL);
+	/* Read DB_CTRL to flush the write DB_CTRL command. */
+	RREG32_SOC15(VCN, vcn_inst, regVCN_RB1_DB_CTRL);
 
-		WREG32_SOC15(VCN, vcn_inst, regUVD_RB_BASE_LO, ring->gpu_addr);
-		WREG32_SOC15(VCN, vcn_inst, regUVD_RB_BASE_HI, upper_32_bits(ring->gpu_addr));
-		WREG32_SOC15(VCN, vcn_inst, regUVD_RB_SIZE, ring->ring_size / 4);
+	WREG32_SOC15(VCN, vcn_inst, regUVD_RB_BASE_LO, ring->gpu_addr);
+	WREG32_SOC15(VCN, vcn_inst, regUVD_RB_BASE_HI, upper_32_bits(ring->gpu_addr));
+	WREG32_SOC15(VCN, vcn_inst, regUVD_RB_SIZE, ring->ring_size / 4);
 
-		tmp = RREG32_SOC15(VCN, vcn_inst, regVCN_RB_ENABLE);
-		tmp &= ~(VCN_RB_ENABLE__RB1_EN_MASK);
-		WREG32_SOC15(VCN, vcn_inst, regVCN_RB_ENABLE, tmp);
-		fw_shared->sq.queue_mode |= FW_QUEUE_RING_RESET;
-		WREG32_SOC15(VCN, vcn_inst, regUVD_RB_RPTR, 0);
-		WREG32_SOC15(VCN, vcn_inst, regUVD_RB_WPTR, 0);
+	tmp = RREG32_SOC15(VCN, vcn_inst, regVCN_RB_ENABLE);
+	tmp &= ~(VCN_RB_ENABLE__RB1_EN_MASK);
+	WREG32_SOC15(VCN, vcn_inst, regVCN_RB_ENABLE, tmp);
+	fw_shared->sq.queue_mode |= FW_QUEUE_RING_RESET;
+	WREG32_SOC15(VCN, vcn_inst, regUVD_RB_RPTR, 0);
+	WREG32_SOC15(VCN, vcn_inst, regUVD_RB_WPTR, 0);
 
-		tmp = RREG32_SOC15(VCN, vcn_inst, regUVD_RB_RPTR);
-		WREG32_SOC15(VCN, vcn_inst, regUVD_RB_WPTR, tmp);
-		ring->wptr = RREG32_SOC15(VCN, vcn_inst, regUVD_RB_WPTR);
+	tmp = RREG32_SOC15(VCN, vcn_inst, regUVD_RB_RPTR);
+	WREG32_SOC15(VCN, vcn_inst, regUVD_RB_WPTR, tmp);
+	ring->wptr = RREG32_SOC15(VCN, vcn_inst, regUVD_RB_WPTR);
 
-		tmp = RREG32_SOC15(VCN, vcn_inst, regVCN_RB_ENABLE);
-		tmp |= VCN_RB_ENABLE__RB1_EN_MASK;
-		WREG32_SOC15(VCN, vcn_inst, regVCN_RB_ENABLE, tmp);
-		fw_shared->sq.queue_mode &= ~(FW_QUEUE_RING_RESET | FW_QUEUE_DPG_HOLD_OFF);
-	}
+	tmp = RREG32_SOC15(VCN, vcn_inst, regVCN_RB_ENABLE);
+	tmp |= VCN_RB_ENABLE__RB1_EN_MASK;
+	WREG32_SOC15(VCN, vcn_inst, regVCN_RB_ENABLE, tmp);
+	fw_shared->sq.queue_mode &= ~(FW_QUEUE_RING_RESET | FW_QUEUE_DPG_HOLD_OFF);
 
 	return 0;
 }
@@ -750,71 +746,69 @@ static void vcn_v5_0_1_stop_dpg_mode(struct amdgpu_device *adev, int inst_idx)
  *
  * Stop VCN block
  */
-static int vcn_v5_0_1_stop(struct amdgpu_device *adev)
+static int vcn_v5_0_1_stop(struct amdgpu_device *adev, int i)
 {
 	volatile struct amdgpu_vcn4_fw_shared *fw_shared;
 	uint32_t tmp;
-	int i, r = 0, vcn_inst;
+	int r = 0, vcn_inst;
 
-	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
-		vcn_inst = GET_INST(VCN, i);
+	vcn_inst = GET_INST(VCN, i);
 
-		fw_shared = adev->vcn.inst[i].fw_shared.cpu_addr;
-		fw_shared->sq.queue_mode |= FW_QUEUE_DPG_HOLD_OFF;
+	fw_shared = adev->vcn.inst[i].fw_shared.cpu_addr;
+	fw_shared->sq.queue_mode |= FW_QUEUE_DPG_HOLD_OFF;
 
-		if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) {
-			vcn_v5_0_1_stop_dpg_mode(adev, i);
-			continue;
-		}
+	if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) {
+		vcn_v5_0_1_stop_dpg_mode(adev, i);
+		return 0;
+	}
 
-		/* wait for vcn idle */
-		r = SOC15_WAIT_ON_RREG(VCN, vcn_inst, regUVD_STATUS, UVD_STATUS__IDLE, 0x7);
-		if (r)
-			return r;
+	/* wait for vcn idle */
+	r = SOC15_WAIT_ON_RREG(VCN, vcn_inst, regUVD_STATUS, UVD_STATUS__IDLE, 0x7);
+	if (r)
+		return r;
 
-		tmp = UVD_LMI_STATUS__VCPU_LMI_WRITE_CLEAN_MASK |
-		      UVD_LMI_STATUS__READ_CLEAN_MASK |
-		      UVD_LMI_STATUS__WRITE_CLEAN_MASK |
-		      UVD_LMI_STATUS__WRITE_CLEAN_RAW_MASK;
-		r = SOC15_WAIT_ON_RREG(VCN, vcn_inst, regUVD_LMI_STATUS, tmp, tmp);
-		if (r)
-			return r;
+	tmp = UVD_LMI_STATUS__VCPU_LMI_WRITE_CLEAN_MASK |
+		UVD_LMI_STATUS__READ_CLEAN_MASK |
+		UVD_LMI_STATUS__WRITE_CLEAN_MASK |
+		UVD_LMI_STATUS__WRITE_CLEAN_RAW_MASK;
+	r = SOC15_WAIT_ON_RREG(VCN, vcn_inst, regUVD_LMI_STATUS, tmp, tmp);
+	if (r)
+		return r;
 
-		/* disable LMI UMC channel */
-		tmp = RREG32_SOC15(VCN, vcn_inst, regUVD_LMI_CTRL2);
-		tmp |= UVD_LMI_CTRL2__STALL_ARB_UMC_MASK;
-		WREG32_SOC15(VCN, vcn_inst, regUVD_LMI_CTRL2, tmp);
-		tmp = UVD_LMI_STATUS__UMC_READ_CLEAN_RAW_MASK |
-		      UVD_LMI_STATUS__UMC_WRITE_CLEAN_RAW_MASK;
-		r = SOC15_WAIT_ON_RREG(VCN, vcn_inst, regUVD_LMI_STATUS, tmp, tmp);
-		if (r)
-			return r;
+	/* disable LMI UMC channel */
+	tmp = RREG32_SOC15(VCN, vcn_inst, regUVD_LMI_CTRL2);
+	tmp |= UVD_LMI_CTRL2__STALL_ARB_UMC_MASK;
+	WREG32_SOC15(VCN, vcn_inst, regUVD_LMI_CTRL2, tmp);
+	tmp = UVD_LMI_STATUS__UMC_READ_CLEAN_RAW_MASK |
+		UVD_LMI_STATUS__UMC_WRITE_CLEAN_RAW_MASK;
+	r = SOC15_WAIT_ON_RREG(VCN, vcn_inst, regUVD_LMI_STATUS, tmp, tmp);
+	if (r)
+		return r;
 
-		/* block VCPU register access */
-		WREG32_P(SOC15_REG_OFFSET(VCN, vcn_inst, regUVD_RB_ARB_CTRL),
-			UVD_RB_ARB_CTRL__VCPU_DIS_MASK,
-			~UVD_RB_ARB_CTRL__VCPU_DIS_MASK);
-
-		/* reset VCPU */
-		WREG32_P(SOC15_REG_OFFSET(VCN, vcn_inst, regUVD_VCPU_CNTL),
-			UVD_VCPU_CNTL__BLK_RST_MASK,
-			~UVD_VCPU_CNTL__BLK_RST_MASK);
-
-		/* disable VCPU clock */
-		WREG32_P(SOC15_REG_OFFSET(VCN, vcn_inst, regUVD_VCPU_CNTL), 0,
-			~(UVD_VCPU_CNTL__CLK_EN_MASK));
-
-		/* apply soft reset */
-		tmp = RREG32_SOC15(VCN, vcn_inst, regUVD_SOFT_RESET);
-		tmp |= UVD_SOFT_RESET__LMI_UMC_SOFT_RESET_MASK;
-		WREG32_SOC15(VCN, vcn_inst, regUVD_SOFT_RESET, tmp);
-		tmp = RREG32_SOC15(VCN, vcn_inst, regUVD_SOFT_RESET);
-		tmp |= UVD_SOFT_RESET__LMI_SOFT_RESET_MASK;
-		WREG32_SOC15(VCN, vcn_inst, regUVD_SOFT_RESET, tmp);
-
-		/* clear status */
-		WREG32_SOC15(VCN, vcn_inst, regUVD_STATUS, 0);
-	}
+	/* block VCPU register access */
+	WREG32_P(SOC15_REG_OFFSET(VCN, vcn_inst, regUVD_RB_ARB_CTRL),
+		 UVD_RB_ARB_CTRL__VCPU_DIS_MASK,
+		 ~UVD_RB_ARB_CTRL__VCPU_DIS_MASK);
+
+	/* reset VCPU */
+	WREG32_P(SOC15_REG_OFFSET(VCN, vcn_inst, regUVD_VCPU_CNTL),
+		 UVD_VCPU_CNTL__BLK_RST_MASK,
+		 ~UVD_VCPU_CNTL__BLK_RST_MASK);
+
+	/* disable VCPU clock */
+	WREG32_P(SOC15_REG_OFFSET(VCN, vcn_inst, regUVD_VCPU_CNTL), 0,
+		 ~(UVD_VCPU_CNTL__CLK_EN_MASK));
+
+	/* apply soft reset */
+	tmp = RREG32_SOC15(VCN, vcn_inst, regUVD_SOFT_RESET);
+	tmp |= UVD_SOFT_RESET__LMI_UMC_SOFT_RESET_MASK;
+	WREG32_SOC15(VCN, vcn_inst, regUVD_SOFT_RESET, tmp);
+	tmp = RREG32_SOC15(VCN, vcn_inst, regUVD_SOFT_RESET);
+	tmp |= UVD_SOFT_RESET__LMI_SOFT_RESET_MASK;
+	WREG32_SOC15(VCN, vcn_inst, regUVD_SOFT_RESET, tmp);
+
+	/* clear status */
+	WREG32_SOC15(VCN, vcn_inst, regUVD_STATUS, 0);
 
 	if (adev->pm.dpm_enabled)
 		amdgpu_dpm_enable_uvd(adev, false);
@@ -1010,15 +1004,17 @@ static int vcn_v5_0_1_set_powergating_state(struct amdgpu_ip_block *ip_block,
 					    enum amd_powergating_state state)
 {
 	struct amdgpu_device *adev = ip_block->adev;
-	int ret;
+	int ret = 0, i;
 
 	if (state == adev->vcn.cur_state)
 		return 0;
 
-	if (state == AMD_PG_STATE_GATE)
-		ret = vcn_v5_0_1_stop(adev);
-	else
-		ret = vcn_v5_0_1_start(adev);
+	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
+		if (state == AMD_PG_STATE_GATE)
+			ret = vcn_v5_0_1_stop(adev, i);
+		else
+			ret = vcn_v5_0_1_start(adev, i);
+	}
 
 	if (!ret)
 		adev->vcn.cur_state = state;
-- 
2.48.1

