Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5851E77185
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Dec 2024 22:54:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4D2B010E9E4;
	Tue, 10 Dec 2024 22:54:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="i3NPhqSK";
	dkim-atps=neutral
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2066.outbound.protection.outlook.com [40.107.95.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D1AB710E9DD
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Dec 2024 22:54:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OfjhBeJusTG5oEjbf5N8oNvo8hZY/Y1fCwGc8+Keb25GMzYPNYEBfqV2bfqb3i63UgE1ZMRf8JOSu7DsYt/kgr3dVmps/k5pn8PWw7UPsWlmnP15n/QFLrUHsraFwRPsyKzGahTrKyZYMMVFLAa2SLO0C7QtB9q5cgopNytZK+KrPnjw0fFwhzVqVWT0cHDirAzz6NH7vvxAkBexvrUsizswq2v7ESdB5aoiOzoIRxsilFG7sp+fcOIb6W0ZGw/pe+G1b8+zAnREph2MF9+BPmPn4f+y4YqNGiFCLRtFTywem/gj+sosjx3UNZvcBmKC3lkOCvjOFQkhMB7k+LhCUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/hmHVtNz3XpQ3few/DFPHV+B2THfM/LDekBZx+P21QI=;
 b=U1SooPiXGU7rRgPNbp4BlIp6gR51BcGbXJvUzEjRpbEBBHK9kSUSODxq4MFZewlKdcX6VLSxlGczVuM6YGeEBCsFqNl2FtvqDWvJ83SXZQZxuSbGadlNs5YjlfASXyPyVARjfACeDUpjV6aUfAD5AtiBwhfJ91SclWOxbY3MHyU+s4D2emhQWcvFykcbCM28GzCLp6OhIc2k4EMQuoQHSxGWI50dbKCuY0HGtlAzqCFo0aWTGutMtmmIdnqxpQ8b+dYYIRv10GZtbYJCJzWMYFheK1gXH1JRWY6hwryEAXJtpT8OXipSEwtYZVsVVVwYC48x939Go+BNPxgUc88EQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/hmHVtNz3XpQ3few/DFPHV+B2THfM/LDekBZx+P21QI=;
 b=i3NPhqSKGWQe+kE0424dfl4byHogMeNWzdNS1NlL/F2carKL57uqjtsqmr4cFtwY6O9++naE63mmvNESncB1LZqwoPX2HtQEI3nmB7r6imGWv4M5b+8TA73kJoW40yrrCWy3yu/AV3CCRpZCSvKIC8ITeD3mJGUoYxS99njFP3M=
Received: from MN2PR01CA0005.prod.exchangelabs.com (2603:10b6:208:10c::18) by
 DS0PR12MB6485.namprd12.prod.outlook.com (2603:10b6:8:c6::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8230.12; Tue, 10 Dec 2024 22:54:08 +0000
Received: from BN2PEPF000055E1.namprd21.prod.outlook.com
 (2603:10b6:208:10c:cafe::52) by MN2PR01CA0005.outlook.office365.com
 (2603:10b6:208:10c::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8207.19 via Frontend Transport; Tue,
 10 Dec 2024 22:54:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000055E1.mail.protection.outlook.com (10.167.245.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8272.0 via Frontend Transport; Tue, 10 Dec 2024 22:54:07 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 10 Dec
 2024 16:54:03 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 20/48] drm/amdgpu/vcn5.0.1: convert internal functions to use
 vcn_inst
Date: Tue, 10 Dec 2024 17:53:09 -0500
Message-ID: <20241210225337.75394-21-alexander.deucher@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF000055E1:EE_|DS0PR12MB6485:EE_
X-MS-Office365-Filtering-Correlation-Id: f2aafcf7-80a3-474f-9c49-08dd196d8dec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?gh+FaMG++HATf9S/aV+Wf8fZgZyEPDmD/3ZMJyxJqtyEhIeORKyUsB3fbzYS?=
 =?us-ascii?Q?DeAvP2WyCbvkbbfAX2ol7man4MQG6jtra/vit0DMz/KZ505PZ5rPnxQPge8I?=
 =?us-ascii?Q?ADWIJ2uBjhT3xJHfU0omegOrI46j4GvkD9u7VU+LAe/+wX4BkNT+sRpdcdVK?=
 =?us-ascii?Q?hQRMKnSTOE1B0n1IR1hief91+C04hcEZOgsfleLwjPpOiEoqFimyjxBeG0/I?=
 =?us-ascii?Q?L7M+iG/tQ4zCDd3mF7goGhigTwTCjm+sKUThYDyVOwH9A1VDg3E8fs7URo3T?=
 =?us-ascii?Q?ga+Gwkzk3bsUfZnu3FRfwIzlzXj16ue9rO2wfX5WFQZZAumyZhHGvJ1PzsSu?=
 =?us-ascii?Q?hW2Zq6mgJxnjOWwfGQK4MG67/JO1sx4PhY5CEOXf1en3RwPw6J7x8fDMSSil?=
 =?us-ascii?Q?fYy8U8RgjmKhK2aGTFN8cVm6tYL52chZzaEb5smio6FnSrxq9/jMYShlf9Oo?=
 =?us-ascii?Q?4w+1N1bjAz6S12TpV0LnjtshjwDbq8GSWmydDTsWog/EGwvkTeCKjkDOr/yO?=
 =?us-ascii?Q?yo2bFbsLg/7vr+YaxrDW5jteaLMyWwKDUbzZ+Mqm98+agAb/1/KA55SrDDBa?=
 =?us-ascii?Q?MfXEHMlswD/RKQjpCdjTdW9VWB/hwFnbIWSoXR2KgHFmBvOJEAJZRK3IZiEM?=
 =?us-ascii?Q?PH0dQErwZOcxJ+Lh/l/lYV/flTImFwsjc7qQFr9Z0RvlrW6Bf4+DX51NMzqb?=
 =?us-ascii?Q?B3RR851bNvJT+IsdcHEPncIb787Va4pijT+ng4eNVKMmBZKPaCXUiX87Dlui?=
 =?us-ascii?Q?usHDQF8RGq7UdU8HyqI2tIpgLPPDO9BnMDb08jnGuci1ahfiWSMI+BiCNIvQ?=
 =?us-ascii?Q?8eA2tIUd6EA+2ijZ/6pMbBEd/nMTrYzSTcAqTPjOT4w7yKJKBhxLUZaF7D4K?=
 =?us-ascii?Q?Gh9VLmvtJmT52vZeFC+fBSkwyLmzEfNRBIw0+ho3mKJnzlWLQmxlMd7E4v39?=
 =?us-ascii?Q?q/PVDV3Q/MFfblyDsFDIXwM53svgcMtZyfUcBCACY7inQfjdNN0RajT+cmU1?=
 =?us-ascii?Q?wxop5bf3bRWQiXaUWLf4C6YcN17B8B7n4Ny/sdvvI+eo/R1g5bGethBkdhsZ?=
 =?us-ascii?Q?jHevNWTmstbM2GB+QxcJ1C6CcIy8uxgozgXtLDoxiygh0I5cayXGY5JYNoP5?=
 =?us-ascii?Q?Gn3VITtFJbtp0gzkeqNXetluv34/r266q+tHnh2LuNyyONnPW3QMmbZlIns+?=
 =?us-ascii?Q?Ifpovf28cS309vtH5Ln6YGDCtkaVlU/um874DznF33AmM5+0FWfAO5RYC/6q?=
 =?us-ascii?Q?C6RPAoiRH4oND+BUF4w3bM4oo8Az5chhtSew8IWazgE5Pck1BR33PQePoMLd?=
 =?us-ascii?Q?Y6UrbHrkoKVoS4Ckkj4G3QrupeH0SgO0291r/8QDXyergrhgtOlIibics1Rx?=
 =?us-ascii?Q?CVStZKLD4sseMkfqpoXc0Lpm9J6/5ATnGpV98u6wdybRbaNUWw=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2024 22:54:07.8920 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f2aafcf7-80a3-474f-9c49-08dd196d8dec
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000055E1.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6485
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
 drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c | 71 ++++++++++++++-----------
 1 file changed, 41 insertions(+), 30 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
index 74c304855c6d3..6ac6049cb9f68 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
@@ -286,13 +286,14 @@ static int vcn_v5_0_1_resume(struct amdgpu_ip_block *ip_block)
 /**
  * vcn_v5_0_1_mc_resume - memory controller programming
  *
- * @adev: amdgpu_device pointer
- * @inst: instance number
+ * @vinst: VCN instance
  *
  * Let the VCN memory controller know it's offsets
  */
-static void vcn_v5_0_1_mc_resume(struct amdgpu_device *adev, int inst)
+static void vcn_v5_0_1_mc_resume(struct amdgpu_vcn_inst *vinst)
 {
+	struct amdgpu_device *adev = vinst->adev;
+	int inst = vinst->inst;
 	uint32_t offset, size, vcn_inst;
 	const struct common_firmware_header *hdr;
 
@@ -348,14 +349,16 @@ static void vcn_v5_0_1_mc_resume(struct amdgpu_device *adev, int inst)
 /**
  * vcn_v5_0_1_mc_resume_dpg_mode - memory controller programming for dpg mode
  *
- * @adev: amdgpu_device pointer
- * @inst_idx: instance number index
+ * @vinst: VCN instance
  * @indirect: indirectly write sram
  *
  * Let the VCN memory controller know it's offsets with dpg mode
  */
-static void vcn_v5_0_1_mc_resume_dpg_mode(struct amdgpu_device *adev, int inst_idx, bool indirect)
+static void vcn_v5_0_1_mc_resume_dpg_mode(struct amdgpu_vcn_inst *vinst,
+					  bool indirect)
 {
+	struct amdgpu_device *adev = vinst->adev;
+	int inst_idx = vinst->inst;
 	uint32_t offset, size;
 	const struct common_firmware_header *hdr;
 
@@ -460,38 +463,38 @@ static void vcn_v5_0_1_mc_resume_dpg_mode(struct amdgpu_device *adev, int inst_i
 /**
  * vcn_v5_0_1_disable_clock_gating - disable VCN clock gating
  *
- * @adev: amdgpu_device pointer
- * @inst: instance number
+ * @vinst: VCN instance
  *
  * Disable clock gating for VCN block
  */
-static void vcn_v5_0_1_disable_clock_gating(struct amdgpu_device *adev, int inst)
+static void vcn_v5_0_1_disable_clock_gating(struct amdgpu_vcn_inst *vinst)
 {
 }
 
 /**
  * vcn_v5_0_1_enable_clock_gating - enable VCN clock gating
  *
- * @adev: amdgpu_device pointer
- * @inst: instance number
+ * @vinst: VCN instance
  *
  * Enable clock gating for VCN block
  */
-static void vcn_v5_0_1_enable_clock_gating(struct amdgpu_device *adev, int inst)
+static void vcn_v5_0_1_enable_clock_gating(struct amdgpu_vcn_inst *vinst)
 {
 }
 
 /**
  * vcn_v5_0_1_start_dpg_mode - VCN start with dpg mode
  *
- * @adev: amdgpu_device pointer
- * @inst_idx: instance number index
+ * @vinst: VCN instance
  * @indirect: indirectly write sram
  *
  * Start VCN block with dpg mode
  */
-static int vcn_v5_0_1_start_dpg_mode(struct amdgpu_device *adev, int inst_idx, bool indirect)
+static int vcn_v5_0_1_start_dpg_mode(struct amdgpu_vcn_inst *vinst,
+				     bool indirect)
 {
+	struct amdgpu_device *adev = vinst->adev;
+	int inst_idx = vinst->inst;
 	volatile struct amdgpu_vcn4_fw_shared *fw_shared =
 		adev->vcn.inst[inst_idx].fw_shared.cpu_addr;
 	struct amdgpu_ring *ring;
@@ -539,7 +542,7 @@ static int vcn_v5_0_1_start_dpg_mode(struct amdgpu_device *adev, int inst_idx, b
 	WREG32_SOC24_DPG_MODE(inst_idx, SOC24_DPG_MODE_OFFSET(
 		VCN, 0, regUVD_LMI_CTRL), tmp, 0, indirect);
 
-	vcn_v5_0_1_mc_resume_dpg_mode(adev, inst_idx, indirect);
+	vcn_v5_0_1_mc_resume_dpg_mode(vinst, indirect);
 
 	tmp = (0xFF << UVD_VCPU_CNTL__PRB_TIMEOUT_VAL__SHIFT);
 	tmp |= UVD_VCPU_CNTL__CLK_EN_MASK;
@@ -593,12 +596,14 @@ static int vcn_v5_0_1_start_dpg_mode(struct amdgpu_device *adev, int inst_idx, b
 /**
  * vcn_v5_0_1_start - VCN start
  *
- * @adev: amdgpu_device pointer
+ * @vinst: VCN instance
  *
  * Start VCN block
  */
-static int vcn_v5_0_1_start(struct amdgpu_device *adev, int i)
+static int vcn_v5_0_1_start(struct amdgpu_vcn_inst *vinst)
 {
+	struct amdgpu_device *adev = vinst->adev;
+	int i = vinst->inst;
 	volatile struct amdgpu_vcn4_fw_shared *fw_shared;
 	struct amdgpu_ring *ring;
 	uint32_t tmp;
@@ -610,7 +615,7 @@ static int vcn_v5_0_1_start(struct amdgpu_device *adev, int i)
 	fw_shared = adev->vcn.inst[i].fw_shared.cpu_addr;
 
 	if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG)
-		return vcn_v5_0_1_start_dpg_mode(adev, i, adev->vcn.inst[i].indirect_sram);
+		return vcn_v5_0_1_start_dpg_mode(vinst, adev->vcn.inst[i].indirect_sram);
 
 	vcn_inst = GET_INST(VCN, i);
 
@@ -643,7 +648,7 @@ static int vcn_v5_0_1_start(struct amdgpu_device *adev, int i)
 		     UVD_LMI_CTRL__DATA_COHERENCY_EN_MASK |
 		     UVD_LMI_CTRL__VCPU_DATA_COHERENCY_EN_MASK);
 
-	vcn_v5_0_1_mc_resume(adev, i);
+	vcn_v5_0_1_mc_resume(vinst);
 
 	/* VCN global tiling registers */
 	WREG32_SOC15(VCN, vcn_inst, regUVD_GFX10_ADDR_CONFIG,
@@ -743,13 +748,14 @@ static int vcn_v5_0_1_start(struct amdgpu_device *adev, int i)
 /**
  * vcn_v5_0_1_stop_dpg_mode - VCN stop with dpg mode
  *
- * @adev: amdgpu_device pointer
- * @inst_idx: instance number index
+ * @vinst: VCN instance
  *
  * Stop VCN block with dpg mode
  */
-static void vcn_v5_0_1_stop_dpg_mode(struct amdgpu_device *adev, int inst_idx)
+static void vcn_v5_0_1_stop_dpg_mode(struct amdgpu_vcn_inst *vinst)
 {
+	struct amdgpu_device *adev = vinst->adev;
+	int inst_idx = vinst->inst;
 	uint32_t tmp;
 	int vcn_inst;
 
@@ -771,12 +777,14 @@ static void vcn_v5_0_1_stop_dpg_mode(struct amdgpu_device *adev, int inst_idx)
 /**
  * vcn_v5_0_1_stop - VCN stop
  *
- * @adev: amdgpu_device pointer
+ * @vinst: VCN instance
  *
  * Stop VCN block
  */
-static int vcn_v5_0_1_stop(struct amdgpu_device *adev, int i)
+static int vcn_v5_0_1_stop(struct amdgpu_vcn_inst *vinst)
 {
+	struct amdgpu_device *adev = vinst->adev;
+	int i = vinst->inst;
 	volatile struct amdgpu_vcn4_fw_shared *fw_shared;
 	uint32_t tmp;
 	int r = 0, vcn_inst;
@@ -787,7 +795,7 @@ static int vcn_v5_0_1_stop(struct amdgpu_device *adev, int i)
 	fw_shared->sq.queue_mode |= FW_QUEUE_DPG_HOLD_OFF;
 
 	if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) {
-		vcn_v5_0_1_stop_dpg_mode(adev, i);
+		vcn_v5_0_1_stop_dpg_mode(vinst);
 		return 0;
 	}
 
@@ -1009,12 +1017,14 @@ static int vcn_v5_0_1_set_clockgating_state(struct amdgpu_ip_block *ip_block,
 	int i;
 
 	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
+		struct amdgpu_vcn_inst *vinst = &adev->vcn.inst[i];
+
 		if (enable) {
 			if (RREG32_SOC15(VCN, GET_INST(VCN, i), regUVD_STATUS) != UVD_STATUS__IDLE)
 				return -EBUSY;
-			vcn_v5_0_1_enable_clock_gating(adev, i);
+			vcn_v5_0_1_enable_clock_gating(vinst);
 		} else {
-			vcn_v5_0_1_disable_clock_gating(adev, i);
+			vcn_v5_0_1_disable_clock_gating(vinst);
 		}
 	}
 
@@ -1026,15 +1036,16 @@ static int vcn_v5_0_1_set_powergating_state_inst(struct amdgpu_ip_block *ip_bloc
 						 int i)
 {
 	struct amdgpu_device *adev = ip_block->adev;
+	struct amdgpu_vcn_inst *vinst = &adev->vcn.inst[i];
 	int ret = 0;
 
 	if (state == adev->vcn.inst[i].cur_state)
 		return 0;
 
 	if (state == AMD_PG_STATE_GATE)
-		ret = vcn_v5_0_1_stop(adev, i);
+		ret = vcn_v5_0_1_stop(vinst);
 	else
-		ret = vcn_v5_0_1_start(adev, i);
+		ret = vcn_v5_0_1_start(vinst);
 
 	if (!ret)
 		adev->vcn.inst[i].cur_state = state;
-- 
2.47.1

