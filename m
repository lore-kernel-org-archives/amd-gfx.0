Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12473E77187
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Dec 2024 22:54:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4B2B010E9D7;
	Tue, 10 Dec 2024 22:54:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="hq9mnxVO";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2070.outbound.protection.outlook.com [40.107.93.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7800A10E9CE
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Dec 2024 22:54:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TqEUxbAN1r7QAGQgM0AxJSdiiWFqf9zTZcjvPMnx/07uFlrenkr29MT4nY7nSCJVi2rw0LlGZ25MBkDFqsIVD5DldV73YA7/9o5/HvEqKdw/Of7fTQwHwPHnX5QqssJ++G90lmSrfK5gp3T8snzFuq43ta/pQpjECHX3t7UKvuTp2HXJTDxh1ZRUOE85jLIbh2G30f109ePRe9qYkU+nyTjxigYXAY903WuDjBGtXjwtJ7Dl68l0dc/vJWuL6HMI0f5qsZB9LcAt8Wx9xEH3YPDBXa3I96KrCu3nwhvM1Kie31Sr0M9g/7PZxic4jvSCWPG01Srq07rfRz0z8KofNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qsuEVwxeitNuG8WGxwQYwApC+BFqSe/NR8zBxstk64o=;
 b=uIeZPBIiJmYZ5TNCMGShQgWrBU1tsFm7WFt+n9drm+iSUV/FiSGBPdjkTrLXe7Uj4OR1YAxQ7YxmluutvnsBvomx+2St4tReMuFuP5gcsEChclqKera9wPdeKeZ8p4HGXTnpzSrWa9HCGIKfl93vAlut1FOQzvfeZ4TYv8HGUsfD5x0gT2aeTL12kgGUTaPMQXNpXqnumxjaNMfMC5OKxe43bgCAFO10ZWUBnD+q9Ks0t4HtzAoxdDmyAU363V05FlBfSBE/FkL1ZQLddtWrabNdDhZrgUe7zR2SlNe9tLCAKgp9Ze4b7r326QpNbxxcwl7h6kFNpATrQSfBkrMq3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qsuEVwxeitNuG8WGxwQYwApC+BFqSe/NR8zBxstk64o=;
 b=hq9mnxVO9C8LegKnbVlZKlovTo5k4gN7hUnmvF+s3tSntzLUzOtK+p/cBg3q6sooYOOZ4Y8YcTKLD2Avn+k2yI1BibmylBaUB1RRP0DRkDlqjI+vKOnQZ4BT6P4YLeSWpHnkNv/fB70EvRqdZFn1D7PxlWQCuVp8ZHRxxtnCrVk=
Received: from BN9PR03CA0232.namprd03.prod.outlook.com (2603:10b6:408:f8::27)
 by SN7PR12MB7023.namprd12.prod.outlook.com (2603:10b6:806:260::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.15; Tue, 10 Dec
 2024 22:54:02 +0000
Received: from BN2PEPF000055DA.namprd21.prod.outlook.com
 (2603:10b6:408:f8:cafe::ee) by BN9PR03CA0232.outlook.office365.com
 (2603:10b6:408:f8::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8230.12 via Frontend Transport; Tue,
 10 Dec 2024 22:54:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000055DA.mail.protection.outlook.com (10.167.245.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8272.0 via Frontend Transport; Tue, 10 Dec 2024 22:54:02 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 10 Dec
 2024 16:53:58 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 12/48] drm/amdgpu/vcn3.0: convert internal functions to use
 vcn_inst
Date: Tue, 10 Dec 2024 17:53:01 -0500
Message-ID: <20241210225337.75394-13-alexander.deucher@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF000055DA:EE_|SN7PR12MB7023:EE_
X-MS-Office365-Filtering-Correlation-Id: 3258741f-9ae1-4b62-05c4-08dd196d8aa7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?E0b5DrU/Tegj8S1PdqkJrfkNO2U9vlRc7uPa2pj3s4LeHU/F/WNVpni5+1E7?=
 =?us-ascii?Q?AxPLnXevmSD21GeuBzWQq/80t357DXt2RhGdZ+GeroYclGDqiIHcD0z/1Bj+?=
 =?us-ascii?Q?xaIDU66WFPVvCrNMwFGWtK6BW2OsueYrEzRgUREmmFgLxWIKY2TBS7etXzf2?=
 =?us-ascii?Q?a/5oix5kBlHdIuqCKlJlgfouqwSZG04eY9U43AFOzSEWB4BBOgPPW02UeW+R?=
 =?us-ascii?Q?fZ+lR/tlI4ySbS14+b67VYi1yYOslduYYprQteKFQbDDppWp9cjiHQ1lvfX+?=
 =?us-ascii?Q?n8wYuXyV+pzbZcqVj18KDG9CI7BxK9jrXnIqlMgJlEbDhIyaRhDfF3pXcyh2?=
 =?us-ascii?Q?Ag24FEQVeKlRlTo7bhe/ksc247yYp2EvzuGuvXlCJwJowSpC9cbHIlF1MIJr?=
 =?us-ascii?Q?XRCWl6U1zySiDOFAvegzJFse7k5UoRm3lg9E/HIjUJhYVhHNiVN4JPrbNJy5?=
 =?us-ascii?Q?fYwge/sejq8wxqRZFfCPvK0dVIjerQ+QNWTW9e5HM/L8it9GZYBTop4hBtWV?=
 =?us-ascii?Q?2fheB9iXoNL7YHHsq2La5Q3nHx4EKCvwv21oi4D4AOQblPKaEY3f3jVeoOjo?=
 =?us-ascii?Q?8j8yxTFIIllj9zSOFWz1l5uRQbUvitxp+IiwvwlwPArYa2Q7iVtc72KcdwCT?=
 =?us-ascii?Q?DZDc8ER+s5FtM4t28Hxq3atrMRbFqc11DHvdqSwYUOubYm1H6TLojePki/pa?=
 =?us-ascii?Q?ZoX9Hzheoz+lbSF3XbEw5PHFWXO54H8wRBVEw8IJfuYrwKA89IF+SEF/bgup?=
 =?us-ascii?Q?k8YPEtXRkwkIFSrDxvEkFtn39qixj+tCA2q1leURDjk/kZWNmKQMG4fM1Tje?=
 =?us-ascii?Q?H/1DkAwCsISpCrVyCNK4HiGHfKlo0fpxl1zIUWX9BuetDL+9CrQfXaNZ1Hyf?=
 =?us-ascii?Q?7iDUMQUVp/v0LBohf19QDUAjbXOtCjbXaRMA0Ul1a2lXP9Nf7eaBApB2IzZL?=
 =?us-ascii?Q?r5mLeIZcuSimcqIw8U2lfuxB5NdcbvKfUgcB/n8ujHkQRxo3RQMnO2AE0OzN?=
 =?us-ascii?Q?wpcKJNI8ebQxXn213Ts5qUSRl+TuWTKk1QglDPM8dpdNN+qRxoFGNloUov2y?=
 =?us-ascii?Q?bP0oVnIUBjuRszsQRWfAG8X3WMvPJ9DtzwJ//6Cw7S+Tn4RPpto35gqrMLzd?=
 =?us-ascii?Q?EDGR04q6AdCxzz+UdNK5OVN3nd3w4UfVYgJrtoFVlSPjg11hEc/iprQUPD3Y?=
 =?us-ascii?Q?Qtp/0WQmfk3/xcG5fOHPHf8/YckabSsM2w3gE/hLcOZIUlRMqu3dbEis/uLG?=
 =?us-ascii?Q?gUKoLeSwD5zEwNqTnO4zXeCNtlmJp8TIvkvTUjFy0dvQz7XCzTPS194VuvnP?=
 =?us-ascii?Q?UHrz8zDYtdamHknsXbCv71X9Q7VRarAamVufYDZFKSfMcsomKzxYPd86AO4H?=
 =?us-ascii?Q?nVNo/8az4k8TpetqTMCk6enFdqKU5ShhSU0K59ieYqvGcOYElA=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2024 22:54:02.4184 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3258741f-9ae1-4b62-05c4-08dd196d8aa7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000055DA.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7023
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
 drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c | 79 ++++++++++++++++++---------
 1 file changed, 52 insertions(+), 27 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
index 724f36467b068..f6f4f04d74339 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
@@ -510,13 +510,14 @@ static int vcn_v3_0_resume(struct amdgpu_ip_block *ip_block)
 /**
  * vcn_v3_0_mc_resume - memory controller programming
  *
- * @adev: amdgpu_device pointer
- * @inst: instance number
+ * @vinst: VCN instance
  *
  * Let the VCN memory controller know it's offsets
  */
-static void vcn_v3_0_mc_resume(struct amdgpu_device *adev, int inst)
+static void vcn_v3_0_mc_resume(struct amdgpu_vcn_inst *vinst)
 {
+	struct amdgpu_device *adev = vinst->adev;
+	int inst = vinst->inst;
 	uint32_t size = AMDGPU_GPU_PAGE_ALIGN(adev->vcn.inst[inst].fw->size + 4);
 	uint32_t offset;
 
@@ -565,8 +566,11 @@ static void vcn_v3_0_mc_resume(struct amdgpu_device *adev, int inst)
 		AMDGPU_GPU_PAGE_ALIGN(sizeof(struct amdgpu_fw_shared)));
 }
 
-static void vcn_v3_0_mc_resume_dpg_mode(struct amdgpu_device *adev, int inst_idx, bool indirect)
+static void vcn_v3_0_mc_resume_dpg_mode(struct amdgpu_vcn_inst *vinst,
+					bool indirect)
 {
+	struct amdgpu_device *adev = vinst->adev;
+	int inst_idx = vinst->inst;
 	uint32_t size = AMDGPU_GPU_PAGE_ALIGN(adev->vcn.inst[inst_idx].fw->size + 4);
 	uint32_t offset;
 
@@ -661,8 +665,10 @@ static void vcn_v3_0_mc_resume_dpg_mode(struct amdgpu_device *adev, int inst_idx
 		UVD, inst_idx, mmUVD_GFX10_ADDR_CONFIG), adev->gfx.config.gb_addr_config, 0, indirect);
 }
 
-static void vcn_v3_0_disable_static_power_gating(struct amdgpu_device *adev, int inst)
+static void vcn_v3_0_disable_static_power_gating(struct amdgpu_vcn_inst *vinst)
 {
+	struct amdgpu_device *adev = vinst->adev;
+	int inst = vinst->inst;
 	uint32_t data = 0;
 
 	if (adev->pg_flags & AMD_PG_SUPPORT_VCN) {
@@ -712,8 +718,10 @@ static void vcn_v3_0_disable_static_power_gating(struct amdgpu_device *adev, int
 	WREG32_SOC15(VCN, inst, mmUVD_POWER_STATUS, data);
 }
 
-static void vcn_v3_0_enable_static_power_gating(struct amdgpu_device *adev, int inst)
+static void vcn_v3_0_enable_static_power_gating(struct amdgpu_vcn_inst *vinst)
 {
+	struct amdgpu_device *adev = vinst->adev;
+	int inst = vinst->inst;
 	uint32_t data;
 
 	if (adev->pg_flags & AMD_PG_SUPPORT_VCN) {
@@ -765,8 +773,10 @@ static void vcn_v3_0_enable_static_power_gating(struct amdgpu_device *adev, int
  *
  * Disable clock gating for VCN block
  */
-static void vcn_v3_0_disable_clock_gating(struct amdgpu_device *adev, int inst)
+static void vcn_v3_0_disable_clock_gating(struct amdgpu_vcn_inst *vinst)
 {
+	struct amdgpu_device *adev = vinst->adev;
+	int inst = vinst->inst;
 	uint32_t data;
 
 	/* VCN disable CGC */
@@ -893,9 +903,12 @@ static void vcn_v3_0_disable_clock_gating(struct amdgpu_device *adev, int inst)
 	WREG32_SOC15(VCN, inst, mmUVD_SUVD_CGC_CTRL, data);
 }
 
-static void vcn_v3_0_clock_gating_dpg_mode(struct amdgpu_device *adev,
-		uint8_t sram_sel, int inst_idx, uint8_t indirect)
+static void vcn_v3_0_clock_gating_dpg_mode(struct amdgpu_vcn_inst *vinst,
+					   uint8_t sram_sel,
+					   uint8_t indirect)
 {
+	struct amdgpu_device *adev = vinst->adev;
+	int inst_idx = vinst->inst;
 	uint32_t reg_data = 0;
 
 	/* enable sw clock gating control */
@@ -949,8 +962,10 @@ static void vcn_v3_0_clock_gating_dpg_mode(struct amdgpu_device *adev,
  *
  * Enable clock gating for VCN block
  */
-static void vcn_v3_0_enable_clock_gating(struct amdgpu_device *adev, int inst)
+static void vcn_v3_0_enable_clock_gating(struct amdgpu_vcn_inst *vinst)
 {
+	struct amdgpu_device *adev = vinst->adev;
+	int inst = vinst->inst;
 	uint32_t data;
 
 	/* enable VCN CGC */
@@ -1009,8 +1024,10 @@ static void vcn_v3_0_enable_clock_gating(struct amdgpu_device *adev, int inst)
 	WREG32_SOC15(VCN, inst, mmUVD_SUVD_CGC_CTRL, data);
 }
 
-static int vcn_v3_0_start_dpg_mode(struct amdgpu_device *adev, int inst_idx, bool indirect)
+static int vcn_v3_0_start_dpg_mode(struct amdgpu_vcn_inst *vinst, bool indirect)
 {
+	struct amdgpu_device *adev = vinst->adev;
+	int inst_idx = vinst->inst;
 	volatile struct amdgpu_fw_shared *fw_shared = adev->vcn.inst[inst_idx].fw_shared.cpu_addr;
 	struct amdgpu_ring *ring;
 	uint32_t rb_bufsz, tmp;
@@ -1028,7 +1045,7 @@ static int vcn_v3_0_start_dpg_mode(struct amdgpu_device *adev, int inst_idx, boo
 		adev->vcn.inst[inst_idx].dpg_sram_curr_addr = (uint32_t *)adev->vcn.inst[inst_idx].dpg_sram_cpu_addr;
 
 	/* enable clock gating */
-	vcn_v3_0_clock_gating_dpg_mode(adev, 0, inst_idx, indirect);
+	vcn_v3_0_clock_gating_dpg_mode(vinst, 0, indirect);
 
 	/* enable VCPU clock */
 	tmp = (0xFF << UVD_VCPU_CNTL__PRB_TIMEOUT_VAL__SHIFT);
@@ -1077,7 +1094,7 @@ static int vcn_v3_0_start_dpg_mode(struct amdgpu_device *adev, int inst_idx, boo
 		 (0x1 << UVD_MPC_SET_MUX__SET_1__SHIFT) |
 		 (0x2 << UVD_MPC_SET_MUX__SET_2__SHIFT)), 0, indirect);
 
-	vcn_v3_0_mc_resume_dpg_mode(adev, inst_idx, indirect);
+	vcn_v3_0_mc_resume_dpg_mode(vinst, indirect);
 
 	WREG32_SOC15_DPG_MODE(inst_idx, SOC15_DPG_MODE_OFFSET(
 		VCN, inst_idx, mmUVD_REG_XX_MASK), 0x10, 0, indirect);
@@ -1161,8 +1178,10 @@ static int vcn_v3_0_start_dpg_mode(struct amdgpu_device *adev, int inst_idx, boo
 	return 0;
 }
 
-static int vcn_v3_0_start(struct amdgpu_device *adev, int i)
+static int vcn_v3_0_start(struct amdgpu_vcn_inst *vinst)
 {
+	struct amdgpu_device *adev = vinst->adev;
+	int i = vinst->inst;
 	volatile struct amdgpu_fw_shared *fw_shared;
 	struct amdgpu_ring *ring;
 	uint32_t rb_bufsz, tmp;
@@ -1175,17 +1194,17 @@ static int vcn_v3_0_start(struct amdgpu_device *adev, int i)
 		amdgpu_dpm_enable_vcn(adev, true, i);
 
 	if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG)
-		return vcn_v3_0_start_dpg_mode(adev, i, adev->vcn.inst[i].indirect_sram);
+		return vcn_v3_0_start_dpg_mode(vinst, vinst->indirect_sram);
 
 	/* disable VCN power gating */
-	vcn_v3_0_disable_static_power_gating(adev, i);
+	vcn_v3_0_disable_static_power_gating(vinst);
 
 	/* set VCN status busy */
 	tmp = RREG32_SOC15(VCN, i, mmUVD_STATUS) | UVD_STATUS__UVD_BUSY;
 	WREG32_SOC15(VCN, i, mmUVD_STATUS, tmp);
 
 	/* SW clock gating */
-	vcn_v3_0_disable_clock_gating(adev, i);
+	vcn_v3_0_disable_clock_gating(vinst);
 
 	/* enable VCPU clock */
 	WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_VCPU_CNTL),
@@ -1238,7 +1257,7 @@ static int vcn_v3_0_start(struct amdgpu_device *adev, int i)
 		      (0x1 << UVD_MPC_SET_MUX__SET_1__SHIFT) |
 		      (0x2 << UVD_MPC_SET_MUX__SET_2__SHIFT)));
 
-	vcn_v3_0_mc_resume(adev, i);
+	vcn_v3_0_mc_resume(vinst);
 
 	/* VCN global tiling registers */
 	WREG32_SOC15(VCN, i, mmUVD_GFX10_ADDR_CONFIG,
@@ -1555,8 +1574,10 @@ static int vcn_v3_0_start_sriov(struct amdgpu_device *adev)
 	return 0;
 }
 
-static int vcn_v3_0_stop_dpg_mode(struct amdgpu_device *adev, int inst_idx)
+static int vcn_v3_0_stop_dpg_mode(struct amdgpu_vcn_inst *vinst)
 {
+	struct amdgpu_device *adev = vinst->adev;
+	int inst_idx = vinst->inst;
 	struct dpg_pause_state state = {.fw_based = VCN_DPG_STATE__UNPAUSE};
 	uint32_t tmp;
 
@@ -1586,8 +1607,10 @@ static int vcn_v3_0_stop_dpg_mode(struct amdgpu_device *adev, int inst_idx)
 	return 0;
 }
 
-static int vcn_v3_0_stop(struct amdgpu_device *adev, int i)
+static int vcn_v3_0_stop(struct amdgpu_vcn_inst *vinst)
 {
+	struct amdgpu_device *adev = vinst->adev;
+	int i = vinst->inst;
 	uint32_t tmp;
 	int r = 0;
 
@@ -1595,7 +1618,7 @@ static int vcn_v3_0_stop(struct amdgpu_device *adev, int i)
 		return 0;
 
 	if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG)
-		return vcn_v3_0_stop_dpg_mode(adev, i);
+		return vcn_v3_0_stop_dpg_mode(vinst);
 
 	/* wait for vcn idle */
 	r = SOC15_WAIT_ON_RREG(VCN, i, mmUVD_STATUS, UVD_STATUS__IDLE, 0x7);
@@ -1646,10 +1669,10 @@ static int vcn_v3_0_stop(struct amdgpu_device *adev, int i)
 	WREG32_SOC15(VCN, i, mmUVD_STATUS, 0);
 
 	/* apply HW clock gating */
-	vcn_v3_0_enable_clock_gating(adev, i);
+	vcn_v3_0_enable_clock_gating(vinst);
 
 	/* enable VCN power gating */
-	vcn_v3_0_enable_static_power_gating(adev, i);
+	vcn_v3_0_enable_static_power_gating(vinst);
 
 	if (adev->pm.dpm_enabled)
 		amdgpu_dpm_enable_vcn(adev, false, i);
@@ -2159,15 +2182,16 @@ static int vcn_v3_0_set_clockgating_state(struct amdgpu_ip_block *ip_block,
 	int i;
 
 	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
+		struct amdgpu_vcn_inst *vinst = &adev->vcn.inst[i];
 		if (adev->vcn.harvest_config & (1 << i))
 			continue;
 
 		if (enable) {
 			if (RREG32_SOC15(VCN, i, mmUVD_STATUS) != UVD_STATUS__IDLE)
 				return -EBUSY;
-			vcn_v3_0_enable_clock_gating(adev, i);
+			vcn_v3_0_enable_clock_gating(vinst);
 		} else {
-			vcn_v3_0_disable_clock_gating(adev, i);
+			vcn_v3_0_disable_clock_gating(vinst);
 		}
 	}
 
@@ -2179,6 +2203,7 @@ static int vcn_v3_0_set_powergating_state_inst(struct amdgpu_ip_block *ip_block,
 					       int i)
 {
 	struct amdgpu_device *adev = ip_block->adev;
+	struct amdgpu_vcn_inst *vinst = &adev->vcn.inst[i];
 	int ret = 0;
 
 	/* for SRIOV, guest should not control VCN Power-gating
@@ -2194,9 +2219,9 @@ static int vcn_v3_0_set_powergating_state_inst(struct amdgpu_ip_block *ip_block,
 		return 0;
 
 	if (state == AMD_PG_STATE_GATE)
-		ret = vcn_v3_0_stop(adev, i);
+		ret = vcn_v3_0_stop(vinst);
 	else
-		ret = vcn_v3_0_start(adev, i);
+		ret = vcn_v3_0_start(vinst);
 
 	if (!ret)
 		adev->vcn.inst[i].cur_state = state;
-- 
2.47.1

