Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68C4CE77186
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Dec 2024 22:54:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1320210E9C2;
	Tue, 10 Dec 2024 22:54:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="3999rCeS";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2079.outbound.protection.outlook.com [40.107.236.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 339A510E9D9
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Dec 2024 22:54:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RrzuL0y0dc5svrA0wDOyRsd2tCC7OzlCSSxo0U861ubLJJHIfggCDKE4Y0kMdku3Ansc4tP7+Kgkxtwu0WdUTchbMsVyn/oTYIt+J5tsuVZMO2thE6uspy5QJC3r6sVda3OtdTMKnWbAw10YiheKGavShY839UKYnrv8BWIL+DN80RaXhawVnsh7LYCfF1IYW0dnR8v/dVJ/Dy2x40mdFhqr+7QqEU7fNhIBT9CZ6iiKPJ7mp/H5yjnvJdLp7PJPYQxWD0X3cxPZYVLsPOgC90yUO+lezheH9bs3E7dOlUUEokpIIp4rUoJNI0ubxr4GH6JuHyoyowU6oNWbnZwKSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=84xhFTqa70AaxNr0lCb069+ROlfJWxDfTLzNiHiql5o=;
 b=PbCMYAAcC3fvylWBsOIXfJJxNq56f4Y9b4bY6dVAGvvRzkiIIi0Fqu6FUX8rZykkdN0KuLyIfOvHnR49vzfXCsOSwS851ucPnJ88FE0AR8AhGiBrAJepvFRJXz2uhzn3T1LtjuRWjO3SGftfPFyxHBmDhg9flt7288uhBRPnmT4z7ehPUWjUa+BZQax96mojlnLeQjDPnGPVNToa/T8LA3e3lAGBWwiiKtG/UryCzYfrTQFhLPV0M44F8HE/tnocrhwTaDQSWyQxfZED6OMA1ilbiwAk7Qd4g1o8g3KN2IcAOUKRK3wQhuJPbJKlovy6y/xCDlQWL7svhsfITfm0ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=84xhFTqa70AaxNr0lCb069+ROlfJWxDfTLzNiHiql5o=;
 b=3999rCeSZhO5+YtueRSiHIZ/X+RrqiyWA4CEWpNLJlQJEdzAuoACEOGM+R8CHFXejGue5LENiosiKtknAD1QVp74BzvbSfGD0w/WYt+WGNNoguiQRkqOh1lHK8ghnQAU17Jz5Yh1SQH/N/FbIiam1bWNte91tGvCS5HMgB0qwMY=
Received: from MN2PR01CA0029.prod.exchangelabs.com (2603:10b6:208:10c::42) by
 CYYPR12MB8870.namprd12.prod.outlook.com (2603:10b6:930:bb::18) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8230.18; Tue, 10 Dec 2024 22:54:06 +0000
Received: from BN2PEPF000055E1.namprd21.prod.outlook.com
 (2603:10b6:208:10c:cafe::2d) by MN2PR01CA0029.outlook.office365.com
 (2603:10b6:208:10c::42) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8207.19 via Frontend Transport; Tue,
 10 Dec 2024 22:54:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000055E1.mail.protection.outlook.com (10.167.245.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8272.0 via Frontend Transport; Tue, 10 Dec 2024 22:54:06 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 10 Dec
 2024 16:54:02 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 18/48] drm/amdgpu/vcn4.0.5: convert internal functions to use
 vcn_inst
Date: Tue, 10 Dec 2024 17:53:07 -0500
Message-ID: <20241210225337.75394-19-alexander.deucher@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF000055E1:EE_|CYYPR12MB8870:EE_
X-MS-Office365-Filtering-Correlation-Id: fb23537f-47e4-4375-45cd-08dd196d8cf2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?T53/cgBJZgC8NN0xmT+zmpzY4pgshtlF0uiyHVESKZmJ3HCCa3pjQvI56Ug8?=
 =?us-ascii?Q?MfEW15oxzD9Sa/hWFEagiJLqY3Kp59snR2zb/f9mua52mhs6X7QZ1Xivohf5?=
 =?us-ascii?Q?vSURw7VYpQ67zeMoVYc3/7PfvMq/niHl070dQ09+rm3AVNqWUvG9uUODsZLe?=
 =?us-ascii?Q?u1CN4BnRd5i0FsIMkfskdW+yhIY57JDokKI4bzedy1Ir8S6OQKUUQ8gC++Y9?=
 =?us-ascii?Q?/JH2s7O2CX8ilMdAXKea8pajB62mpwQglIBA9bUQqgyLxGprjQiSdUmRMznM?=
 =?us-ascii?Q?kP2yAD+aOyVfOFdhDMKpde8nHvg1P3gnz8HZgsFzpLU8emMxtDDWXQQSLjX2?=
 =?us-ascii?Q?He4V6sVv1891/yAx0yfGH3YoLcDSfCOUC4xCv5uHz7JGkSd1QkiXu1iIO2FN?=
 =?us-ascii?Q?b+dSwkAD1Iipva+5wdXjv6JNTbSOclYUSeaAry0b0RRgk0J4AhlzckpRhguG?=
 =?us-ascii?Q?bghhs8wrzsh+AxU64BdWGXAe4iqw5xRiQr37tuNQ8ynatESiVvEHTU8vfK7E?=
 =?us-ascii?Q?PPD/3lR7hZyi+q4G+5pwrTV4jwJ/odCISzvVUDpG9ivUd73WeQ+v95Ojc9F9?=
 =?us-ascii?Q?PjIRMnlByj1wNCk+zctdgfW9UE44GqcmN3r7wBrtEYGDrGKDGBGfgXtJUdRR?=
 =?us-ascii?Q?rmlFIZQLwOeomJaNLINytXLDNN/X9XjS6YQeahbIFUmugJkfZWLdQF+fHVSK?=
 =?us-ascii?Q?IcpcfPnU7QYymV+jngLCn83IRB81Ka/HyJWsPCK02p73Sbbpaj8WCt8jLjnW?=
 =?us-ascii?Q?hL2Pt7tUZbKeHmftckpVfRGn2a2BXpdxbtnmwKZ/cEOuFnjkmEI5+0ShAaj0?=
 =?us-ascii?Q?Izb+nwQ+bexatC8LgEv9wkklKc0/diHGhKVElKT1CaO5Lz2boAU4b5gAEcSy?=
 =?us-ascii?Q?Mss4Xfa1WdJSB6Ef2SixWOGPMg3NGCtVSgQQ4lV4aIG2e4uhz914CZeDVOa8?=
 =?us-ascii?Q?XyWONCqRoyhT02FozxG9hTDdXz0Qt2WK3zU31+Aqe/gR2pt8VjEJ2/ngcjmX?=
 =?us-ascii?Q?HUGRs7oKAQbzht1qwi2Ijrc1v93OzqG0Bt0YiUK6fVux/nMja3Vy4N8BPCsV?=
 =?us-ascii?Q?+jH2DljClkychcjhSBDgSulWsLmfEbzC5v8x/k/vs6cQomUfgYe29BkybG2r?=
 =?us-ascii?Q?LNSQWWFJYU9/N4IvIf9pL6BjHOqlJRRPsNiHU0KkD/zfw94WIcBbfpXkKaMz?=
 =?us-ascii?Q?wRjoCnYowRQ7PEqWPf6ywuvudAx5gacD37xh44w0GsoYuNUdzDH5Phm91ia7?=
 =?us-ascii?Q?bw9LuXb9btEMoaweXYE4dOrV7oNAiqmSZjfe/Hqi8T4Qs/yq/vR3x/KJWvCg?=
 =?us-ascii?Q?604j7z82fpz6xqHBRwDDVCYmepJDMN2oKS6RoqS/nWWv2Zq0/0itsI9+KNFx?=
 =?us-ascii?Q?aeDrSSw8q3b6Np9S3Q3wZgJhvHGD3BqPYGm6mSd0pM2c0Xpxeg=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2024 22:54:06.2514 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fb23537f-47e4-4375-45cd-08dd196d8cf2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000055E1.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8870
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
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c | 111 ++++++++++++++----------
 1 file changed, 64 insertions(+), 47 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
index c3a2826a59631..295f39b2222d5 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
@@ -385,13 +385,14 @@ static int vcn_v4_0_5_resume(struct amdgpu_ip_block *ip_block)
 /**
  * vcn_v4_0_5_mc_resume - memory controller programming
  *
- * @adev: amdgpu_device pointer
- * @inst: instance number
+ * @vinst: VCN instance
  *
  * Let the VCN memory controller know it's offsets
  */
-static void vcn_v4_0_5_mc_resume(struct amdgpu_device *adev, int inst)
+static void vcn_v4_0_5_mc_resume(struct amdgpu_vcn_inst *vinst)
 {
+	struct amdgpu_device *adev = vinst->adev;
+	int inst = vinst->inst;
 	uint32_t offset, size;
 	const struct common_firmware_header *hdr;
 
@@ -445,14 +446,16 @@ static void vcn_v4_0_5_mc_resume(struct amdgpu_device *adev, int inst)
 /**
  * vcn_v4_0_5_mc_resume_dpg_mode - memory controller programming for dpg mode
  *
- * @adev: amdgpu_device pointer
- * @inst_idx: instance number index
+ * @vinst: VCN instance
  * @indirect: indirectly write sram
  *
  * Let the VCN memory controller know it's offsets with dpg mode
  */
-static void vcn_v4_0_5_mc_resume_dpg_mode(struct amdgpu_device *adev, int inst_idx, bool indirect)
+static void vcn_v4_0_5_mc_resume_dpg_mode(struct amdgpu_vcn_inst *vinst,
+					  bool indirect)
 {
+	struct amdgpu_device *adev = vinst->adev;
+	int inst_idx = vinst->inst;
 	uint32_t offset, size;
 	const struct common_firmware_header *hdr;
 
@@ -559,13 +562,14 @@ static void vcn_v4_0_5_mc_resume_dpg_mode(struct amdgpu_device *adev, int inst_i
 /**
  * vcn_v4_0_5_disable_static_power_gating - disable VCN static power gating
  *
- * @adev: amdgpu_device pointer
- * @inst: instance number
+ * @vinst: VCN instance
  *
  * Disable static power gating for VCN block
  */
-static void vcn_v4_0_5_disable_static_power_gating(struct amdgpu_device *adev, int inst)
+static void vcn_v4_0_5_disable_static_power_gating(struct amdgpu_vcn_inst *vinst)
 {
+	struct amdgpu_device *adev = vinst->adev;
+	int inst = vinst->inst;
 	uint32_t data = 0;
 
 	if (adev->pg_flags & AMD_PG_SUPPORT_VCN) {
@@ -618,13 +622,14 @@ static void vcn_v4_0_5_disable_static_power_gating(struct amdgpu_device *adev, i
 /**
  * vcn_v4_0_5_enable_static_power_gating - enable VCN static power gating
  *
- * @adev: amdgpu_device pointer
- * @inst: instance number
+ * @vinst: VCN instance
  *
  * Enable static power gating for VCN block
  */
-static void vcn_v4_0_5_enable_static_power_gating(struct amdgpu_device *adev, int inst)
+static void vcn_v4_0_5_enable_static_power_gating(struct amdgpu_vcn_inst *vinst)
 {
+	struct amdgpu_device *adev = vinst->adev;
+	int inst = vinst->inst;
 	uint32_t data;
 
 	if (adev->pg_flags & AMD_PG_SUPPORT_VCN) {
@@ -660,13 +665,14 @@ static void vcn_v4_0_5_enable_static_power_gating(struct amdgpu_device *adev, in
 /**
  * vcn_v4_0_5_disable_clock_gating - disable VCN clock gating
  *
- * @adev: amdgpu_device pointer
- * @inst: instance number
+ * @vinst: VCN instance
  *
  * Disable clock gating for VCN block
  */
-static void vcn_v4_0_5_disable_clock_gating(struct amdgpu_device *adev, int inst)
+static void vcn_v4_0_5_disable_clock_gating(struct amdgpu_vcn_inst *vinst)
 {
+	struct amdgpu_device *adev = vinst->adev;
+	int inst = vinst->inst;
 	uint32_t data;
 
 	if (adev->cg_flags & AMD_CG_SUPPORT_VCN_MGCG)
@@ -771,16 +777,18 @@ static void vcn_v4_0_5_disable_clock_gating(struct amdgpu_device *adev, int inst
 /**
  * vcn_v4_0_5_disable_clock_gating_dpg_mode - disable VCN clock gating dpg mode
  *
- * @adev: amdgpu_device pointer
+ * @vinst: VCN instance
  * @sram_sel: sram select
- * @inst_idx: instance number index
  * @indirect: indirectly write sram
  *
  * Disable clock gating for VCN block with dpg mode
  */
-static void vcn_v4_0_5_disable_clock_gating_dpg_mode(struct amdgpu_device *adev, uint8_t sram_sel,
-		int inst_idx, uint8_t indirect)
+static void vcn_v4_0_5_disable_clock_gating_dpg_mode(struct amdgpu_vcn_inst *vinst,
+						     uint8_t sram_sel,
+						     uint8_t indirect)
 {
+	struct amdgpu_device *adev = vinst->adev;
+	int inst_idx = vinst->inst;
 	uint32_t reg_data = 0;
 
 	if (adev->cg_flags & AMD_CG_SUPPORT_VCN_MGCG)
@@ -828,13 +836,14 @@ static void vcn_v4_0_5_disable_clock_gating_dpg_mode(struct amdgpu_device *adev,
 /**
  * vcn_v4_0_5_enable_clock_gating - enable VCN clock gating
  *
- * @adev: amdgpu_device pointer
- * @inst: instance number
+ * @vinst: VCN instance
  *
  * Enable clock gating for VCN block
  */
-static void vcn_v4_0_5_enable_clock_gating(struct amdgpu_device *adev, int inst)
+static void vcn_v4_0_5_enable_clock_gating(struct amdgpu_vcn_inst *vinst)
 {
+	struct amdgpu_device *adev = vinst->adev;
+	int inst = vinst->inst;
 	uint32_t data;
 
 	if (adev->cg_flags & AMD_CG_SUPPORT_VCN_MGCG)
@@ -887,14 +896,16 @@ static void vcn_v4_0_5_enable_clock_gating(struct amdgpu_device *adev, int inst)
 /**
  * vcn_v4_0_5_start_dpg_mode - VCN start with dpg mode
  *
- * @adev: amdgpu_device pointer
- * @inst_idx: instance number index
+ * @vinst: VCN instance
  * @indirect: indirectly write sram
  *
  * Start VCN block with dpg mode
  */
-static int vcn_v4_0_5_start_dpg_mode(struct amdgpu_device *adev, int inst_idx, bool indirect)
+static int vcn_v4_0_5_start_dpg_mode(struct amdgpu_vcn_inst *vinst,
+				     bool indirect)
 {
+	struct amdgpu_device *adev = vinst->adev;
+	int inst_idx = vinst->inst;
 	volatile struct amdgpu_vcn4_fw_shared *fw_shared = adev->vcn.inst[inst_idx].fw_shared.cpu_addr;
 	struct amdgpu_ring *ring;
 	uint32_t tmp;
@@ -913,7 +924,7 @@ static int vcn_v4_0_5_start_dpg_mode(struct amdgpu_device *adev, int inst_idx, b
 					(uint32_t *)adev->vcn.inst[inst_idx].dpg_sram_cpu_addr;
 
 	/* enable clock gating */
-	vcn_v4_0_5_disable_clock_gating_dpg_mode(adev, 0, inst_idx, indirect);
+	vcn_v4_0_5_disable_clock_gating_dpg_mode(vinst, 0, indirect);
 
 	/* enable VCPU clock */
 	tmp = (0xFF << UVD_VCPU_CNTL__PRB_TIMEOUT_VAL__SHIFT);
@@ -961,7 +972,7 @@ static int vcn_v4_0_5_start_dpg_mode(struct amdgpu_device *adev, int inst_idx, b
 		 (0x1 << UVD_MPC_SET_MUX__SET_1__SHIFT) |
 		 (0x2 << UVD_MPC_SET_MUX__SET_2__SHIFT)), 0, indirect);
 
-	vcn_v4_0_5_mc_resume_dpg_mode(adev, inst_idx, indirect);
+	vcn_v4_0_5_mc_resume_dpg_mode(vinst, indirect);
 
 	tmp = (0xFF << UVD_VCPU_CNTL__PRB_TIMEOUT_VAL__SHIFT);
 	tmp |= UVD_VCPU_CNTL__CLK_EN_MASK;
@@ -1014,13 +1025,14 @@ static int vcn_v4_0_5_start_dpg_mode(struct amdgpu_device *adev, int inst_idx, b
 /**
  * vcn_v4_0_5_start - VCN start
  *
- * @adev: amdgpu_device pointer
- * @i: instance to start
+ * @vinst: VCN instance
  *
  * Start VCN block
  */
-static int vcn_v4_0_5_start(struct amdgpu_device *adev, int i)
+static int vcn_v4_0_5_start(struct amdgpu_vcn_inst *vinst)
 {
+	struct amdgpu_device *adev = vinst->adev;
+	int i = vinst->inst;
 	volatile struct amdgpu_vcn4_fw_shared *fw_shared;
 	struct amdgpu_ring *ring;
 	uint32_t tmp;
@@ -1035,17 +1047,17 @@ static int vcn_v4_0_5_start(struct amdgpu_device *adev, int i)
 	fw_shared = adev->vcn.inst[i].fw_shared.cpu_addr;
 
 	if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG)
-		return vcn_v4_0_5_start_dpg_mode(adev, i, adev->vcn.inst[i].indirect_sram);
+		return vcn_v4_0_5_start_dpg_mode(vinst, adev->vcn.inst[i].indirect_sram);
 
 	/* disable VCN power gating */
-	vcn_v4_0_5_disable_static_power_gating(adev, i);
+	vcn_v4_0_5_disable_static_power_gating(vinst);
 
 	/* set VCN status busy */
 	tmp = RREG32_SOC15(VCN, i, regUVD_STATUS) | UVD_STATUS__UVD_BUSY;
 	WREG32_SOC15(VCN, i, regUVD_STATUS, tmp);
 
 	/* SW clock gating */
-	vcn_v4_0_5_disable_clock_gating(adev, i);
+	vcn_v4_0_5_disable_clock_gating(vinst);
 
 	/* enable VCPU clock */
 	WREG32_P(SOC15_REG_OFFSET(VCN, i, regUVD_VCPU_CNTL),
@@ -1098,7 +1110,7 @@ static int vcn_v4_0_5_start(struct amdgpu_device *adev, int i)
 		      (0x1 << UVD_MPC_SET_MUX__SET_1__SHIFT) |
 		      (0x2 << UVD_MPC_SET_MUX__SET_2__SHIFT)));
 
-	vcn_v4_0_5_mc_resume(adev, i);
+	vcn_v4_0_5_mc_resume(vinst);
 
 	/* VCN global tiling registers */
 	WREG32_SOC15(VCN, i, regUVD_GFX10_ADDR_CONFIG,
@@ -1194,13 +1206,14 @@ static int vcn_v4_0_5_start(struct amdgpu_device *adev, int i)
 /**
  * vcn_v4_0_5_stop_dpg_mode - VCN stop with dpg mode
  *
- * @adev: amdgpu_device pointer
- * @inst_idx: instance number index
+ * @vinst: VCN instance
  *
  * Stop VCN block with dpg mode
  */
-static void vcn_v4_0_5_stop_dpg_mode(struct amdgpu_device *adev, int inst_idx)
+static void vcn_v4_0_5_stop_dpg_mode(struct amdgpu_vcn_inst *vinst)
 {
+	struct amdgpu_device *adev = vinst->adev;
+	int inst_idx = vinst->inst;
 	uint32_t tmp;
 
 	/* Wait for power status to be 1 */
@@ -1222,13 +1235,14 @@ static void vcn_v4_0_5_stop_dpg_mode(struct amdgpu_device *adev, int inst_idx)
 /**
  * vcn_v4_0_5_stop - VCN stop
  *
- * @adev: amdgpu_device pointer
- * @i: instance to stop
+ * @vinst: VCN instance
  *
  * Stop VCN block
  */
-static int vcn_v4_0_5_stop(struct amdgpu_device *adev, int i)
+static int vcn_v4_0_5_stop(struct amdgpu_vcn_inst *vinst)
 {
+	struct amdgpu_device *adev = vinst->adev;
+	int i = vinst->inst;
 	volatile struct amdgpu_vcn4_fw_shared *fw_shared;
 	uint32_t tmp;
 	int r = 0;
@@ -1240,7 +1254,7 @@ static int vcn_v4_0_5_stop(struct amdgpu_device *adev, int i)
 	fw_shared->sq.queue_mode |= FW_QUEUE_DPG_HOLD_OFF;
 
 	if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) {
-		vcn_v4_0_5_stop_dpg_mode(adev, i);
+		vcn_v4_0_5_stop_dpg_mode(vinst);
 		return 0;
 	}
 
@@ -1293,10 +1307,10 @@ static int vcn_v4_0_5_stop(struct amdgpu_device *adev, int i)
 	WREG32_SOC15(VCN, i, regUVD_STATUS, 0);
 
 	/* apply HW clock gating */
-	vcn_v4_0_5_enable_clock_gating(adev, i);
+	vcn_v4_0_5_enable_clock_gating(vinst);
 
 	/* enable VCN power gating */
-	vcn_v4_0_5_enable_static_power_gating(adev, i);
+	vcn_v4_0_5_enable_static_power_gating(vinst);
 
 	if (adev->pm.dpm_enabled)
 		amdgpu_dpm_enable_vcn(adev, false, i);
@@ -1526,15 +1540,17 @@ static int vcn_v4_0_5_set_clockgating_state(struct amdgpu_ip_block *ip_block,
 	int i;
 
 	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
+		struct amdgpu_vcn_inst *vinst = &adev->vcn.inst[i];
+
 		if (adev->vcn.harvest_config & (1 << i))
 			continue;
 
 		if (enable) {
 			if (RREG32_SOC15(VCN, i, regUVD_STATUS) != UVD_STATUS__IDLE)
 				return -EBUSY;
-			vcn_v4_0_5_enable_clock_gating(adev, i);
+			vcn_v4_0_5_enable_clock_gating(vinst);
 		} else {
-			vcn_v4_0_5_disable_clock_gating(adev, i);
+			vcn_v4_0_5_disable_clock_gating(vinst);
 		}
 	}
 
@@ -1546,15 +1562,16 @@ static int vcn_v4_0_5_set_powergating_state_inst(struct amdgpu_ip_block *ip_bloc
 						 int i)
 {
 	struct amdgpu_device *adev = ip_block->adev;
+	struct amdgpu_vcn_inst *vinst = &adev->vcn.inst[i];
 	int ret = 0;
 
 	if (state == adev->vcn.inst[i].cur_state)
 		return 0;
 
 	if (state == AMD_PG_STATE_GATE)
-		ret = vcn_v4_0_5_stop(adev, i);
+		ret = vcn_v4_0_5_stop(vinst);
 	else
-		ret = vcn_v4_0_5_start(adev, i);
+		ret = vcn_v4_0_5_start(vinst);
 
 	if (!ret)
 		adev->vcn.inst[i].cur_state = state;
-- 
2.47.1

