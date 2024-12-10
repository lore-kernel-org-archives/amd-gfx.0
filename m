Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC895E77189
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Dec 2024 22:54:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 89F4A10E9DF;
	Tue, 10 Dec 2024 22:54:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="D0xKLATA";
	dkim-atps=neutral
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2078.outbound.protection.outlook.com [40.107.95.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BEA8A10E9DC
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Dec 2024 22:54:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ROnl/HRWCORhyy084cv7HyT3l+/HTKMsJwuQZaGEdk9gR55sbJ1an6tQ4v7AjT3ph8sUOR507E7K14yNh7PtDXoBBdF5eukkj07CifCbcF6LnR6wisXfOmYGrA4wpLePADWhq5GPOYdWufheG2j3dxGAOVJxaTtOa375UCy0tTRWloeH7cOwsJ+3KNCLXEGtdrHzGOMg6G2HAvEkqKwQWBPwt1xlkoE7kqvpV9ZQMPRIlWMXEgQfD1LnoBO4yA2O8yUX68iY2jUsZ05XdL3KiII17l7HXq1YnryJXdiWiCb9JrYBE9LHPMfbgUeN1XIoLtstmqcd6k6PBKkJ146b8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JKcVnxV7rgglsnKcu6Z/Bh1m6TrB1upub+gRTGpvZqk=;
 b=OkmwnT9GVapjWheSo0vbsczgmTMmKyeEcsS21QULsbE7/nQkDlMkWTVjpelq247OsrsgRee/NMzYH4wOtesxzvACAlYHB9OOx4XevtwxMc+EUf/HX1m/iyWQ0PzLOlRGuy+qjDnGmor5z/Kbace03f9XqbheLG6h4rOhFiEqLXFBHj8aPDW1zjuQZqfjgp/Ca/AeW7BIQae/89i1FoF/UB9VnNqv7zLv+OqC7PJQ4NSn68HU3x38UhXTQMTp3I3n8YIk8svytTZpx9sjn44NqdU/X6UUFXxI46BXQWakmt1UZpojoi6tOmLLNPUKn51/FTdvXKq/FAf6hpSES8PDtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JKcVnxV7rgglsnKcu6Z/Bh1m6TrB1upub+gRTGpvZqk=;
 b=D0xKLATAGr/G4zDFtsSx9LSApwzNjAQX6ypIy7Rhv8szjS3ZO9ZHRwFreRlBrnOhsfAd0Gcc3p2LnzzLqZL1oGrufd7KPdZx0pkhkNueLk53buWr7CdhcEGnqNi1cyD85k/aOHEIdN8szv/F6fLTR2iHIiffOHbQ59MseRkUIis=
Received: from MN2PR01CA0023.prod.exchangelabs.com (2603:10b6:208:10c::36) by
 SJ2PR12MB9163.namprd12.prod.outlook.com (2603:10b6:a03:559::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.15; Tue, 10 Dec
 2024 22:54:07 +0000
Received: from BN2PEPF000055E1.namprd21.prod.outlook.com
 (2603:10b6:208:10c:cafe::56) by MN2PR01CA0023.outlook.office365.com
 (2603:10b6:208:10c::36) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8230.12 via Frontend Transport; Tue,
 10 Dec 2024 22:54:01 +0000
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
Subject: [PATCH 19/48] drm/amdgpu/vcn5.0.0: convert internal functions to use
 vcn_inst
Date: Tue, 10 Dec 2024 17:53:08 -0500
Message-ID: <20241210225337.75394-20-alexander.deucher@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF000055E1:EE_|SJ2PR12MB9163:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a56c8e8-46db-45fb-1a5b-08dd196d8d48
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?YDt0iyMQo5B45LluUAIG5zcexzkMqcAqq9jgDUgUC/PqSwRtwCo3+2ZcjXlo?=
 =?us-ascii?Q?1ZJTqHNBL+Ikor5AK6aUeoFUf4Qc3FZz4aHiYV6h+ksRT4m2aViQVbvYEqBl?=
 =?us-ascii?Q?s0DjbWyNAi9YJugRFyZ8e5VCgd+2Fx9nIXgcwL1fYf9hgcKv3UQ1IOnnsshB?=
 =?us-ascii?Q?NYOiDUQxrvRgWapCSUO3q6O+F0xA4eq4tDP6FD2jOYxu3lOQwBXsgerrJIz5?=
 =?us-ascii?Q?HkSAv4s9LmiElNnYaKlvmF3ruPPGKu1ILVXKs4TiBWlDqE08fJIk4mgsQ0jC?=
 =?us-ascii?Q?xf/xXtIMR86xFJNzVb//yzt2cBwuQ28xmo7f3dlkBX1K8lnMFT3g9595o2u4?=
 =?us-ascii?Q?YDZHRAjU/aHdFrk794sQS8UseqxF5BEE8rHzNH+gJYk8m0ssRPuQHkysjGMM?=
 =?us-ascii?Q?KYM5qPthhQq08177+bpjTSmm/cDfw6Gzi+vVfjiaWn4Bt2BnD9/Sf2zkXxK4?=
 =?us-ascii?Q?kGkpzOzF4kRol05g5O1H4AhUAYnMzUOyDZ5zaxAu9+9DycEyoNBPpkt1VDnC?=
 =?us-ascii?Q?i97y/Nf/or5a8AOvGIWjnH10GbIdU+7ozFyObb3mlC4m7o5lTnxvHJQhGezw?=
 =?us-ascii?Q?7WFv23VhBBFDu/SlR+YUIZr8flg3DOM0Zo2s9D2HI/hgk1EIN0jvQi267juX?=
 =?us-ascii?Q?qpHOolPfP556BfifiyZCyBs6/cQMmM6EqycWrWr7441igmkZ8NzUE2twhJPR?=
 =?us-ascii?Q?hZKF/+qSlh6iBjkwoEk9d90qN7el4Gk9ZERFurWtStC5P0U+kWe0PrnA9kaz?=
 =?us-ascii?Q?iSX2K614jv6XkyaMFQJxUzTkgNZ/oZ1GcpKs9hlswpYRokM6KfBe6eUuOXz+?=
 =?us-ascii?Q?NPWxdFvtqm6e1PzlbGMoEEe3RKqXPRIbEn89pcHX+nhn5FNBvuAAN8zVu4D4?=
 =?us-ascii?Q?CA9XbYqG0mvsKqLCbc/JanN3EU5Q7GVc/MN5LcJpzrFS2FOZaczMz7H1ic8p?=
 =?us-ascii?Q?buM1HZ6ONhcfl6GGOtCZsFPqoKpTGwzdDGqPn7LbGtckLB9Bgbq73lsEFpY2?=
 =?us-ascii?Q?c06GWyXW2sY+lmKoDzaZDqKABL4+UFAPwOe1GsyOlo2HsIt07ew4UuePVo2L?=
 =?us-ascii?Q?E2c3R5k4dwAf4LVOtqkFIImTH3GM1Gi6OTBKCnrOPLhyonF9kRTIZJWj+tFm?=
 =?us-ascii?Q?ytZcHhSG8yXeDy8BkYrA8FITFF80691vFBNmlI5TtsCiXCcrsfaukA0BU2yM?=
 =?us-ascii?Q?GmNDQTbrvhlHU/Z90QHCoAsDtm4ilT+vRBtLICipn0Hrvb1k/G6WvykA7jk4?=
 =?us-ascii?Q?wVewT7mm2svDczTJZA1u/ocdBFhxBVTLTZJ+A5DD0IRMS3XbUnA6Le15yYFN?=
 =?us-ascii?Q?LyzbrLn1jrcBq4GPxxVx3TPYwA1dMgAlsWIV1RDFYVNd8baFqWg8fbfkrEth?=
 =?us-ascii?Q?LTo8krQ6Ll+Ln6ihAJY8LRNAjoePMJsndMPsPPTRBiLmuizyGw=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2024 22:54:06.8139 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a56c8e8-46db-45fb-1a5b-08dd196d8d48
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000055E1.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9163
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
 drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c | 99 ++++++++++++++-----------
 1 file changed, 55 insertions(+), 44 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
index d3e4d02c12a06..a71960d899e38 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
@@ -367,13 +367,14 @@ static int vcn_v5_0_0_resume(struct amdgpu_ip_block *ip_block)
 /**
  * vcn_v5_0_0_mc_resume - memory controller programming
  *
- * @adev: amdgpu_device pointer
- * @inst: instance number
+ * @vinst: VCN instance
  *
  * Let the VCN memory controller know it's offsets
  */
-static void vcn_v5_0_0_mc_resume(struct amdgpu_device *adev, int inst)
+static void vcn_v5_0_0_mc_resume(struct amdgpu_vcn_inst *vinst)
 {
+	struct amdgpu_device *adev = vinst->adev;
+	int inst = vinst->inst;
 	uint32_t offset, size;
 	const struct common_firmware_header *hdr;
 
@@ -427,14 +428,16 @@ static void vcn_v5_0_0_mc_resume(struct amdgpu_device *adev, int inst)
 /**
  * vcn_v5_0_0_mc_resume_dpg_mode - memory controller programming for dpg mode
  *
- * @adev: amdgpu_device pointer
- * @inst_idx: instance number index
+ * @vinst: VCN instance
  * @indirect: indirectly write sram
  *
  * Let the VCN memory controller know it's offsets with dpg mode
  */
-static void vcn_v5_0_0_mc_resume_dpg_mode(struct amdgpu_device *adev, int inst_idx, bool indirect)
+static void vcn_v5_0_0_mc_resume_dpg_mode(struct amdgpu_vcn_inst *vinst,
+					  bool indirect)
 {
+	struct amdgpu_device *adev = vinst->adev;
+	int inst_idx = vinst->inst;
 	uint32_t offset, size;
 	const struct common_firmware_header *hdr;
 
@@ -537,13 +540,14 @@ static void vcn_v5_0_0_mc_resume_dpg_mode(struct amdgpu_device *adev, int inst_i
 /**
  * vcn_v5_0_0_disable_static_power_gating - disable VCN static power gating
  *
- * @adev: amdgpu_device pointer
- * @inst: instance number
+ * @vinst: VCN instance
  *
  * Disable static power gating for VCN block
  */
-static void vcn_v5_0_0_disable_static_power_gating(struct amdgpu_device *adev, int inst)
+static void vcn_v5_0_0_disable_static_power_gating(struct amdgpu_vcn_inst *vinst)
 {
+	struct amdgpu_device *adev = vinst->adev;
+	int inst = vinst->inst;
 	uint32_t data = 0;
 
 	if (adev->pg_flags & AMD_PG_SUPPORT_VCN) {
@@ -604,13 +608,14 @@ static void vcn_v5_0_0_disable_static_power_gating(struct amdgpu_device *adev, i
 /**
  * vcn_v5_0_0_enable_static_power_gating - enable VCN static power gating
  *
- * @adev: amdgpu_device pointer
- * @inst: instance number
+ * @vinst: VCN instance
  *
  * Enable static power gating for VCN block
  */
-static void vcn_v5_0_0_enable_static_power_gating(struct amdgpu_device *adev, int inst)
+static void vcn_v5_0_0_enable_static_power_gating(struct amdgpu_vcn_inst *vinst)
 {
+	struct amdgpu_device *adev = vinst->adev;
+	int inst = vinst->inst;
 	uint32_t data;
 
 	if (adev->pg_flags & AMD_PG_SUPPORT_VCN) {
@@ -650,12 +655,11 @@ static void vcn_v5_0_0_enable_static_power_gating(struct amdgpu_device *adev, in
 /**
  * vcn_v5_0_0_disable_clock_gating - disable VCN clock gating
  *
- * @adev: amdgpu_device pointer
- * @inst: instance number
+ * @vinst: VCN instance
  *
  * Disable clock gating for VCN block
  */
-static void vcn_v5_0_0_disable_clock_gating(struct amdgpu_device *adev, int inst)
+static void vcn_v5_0_0_disable_clock_gating(struct amdgpu_vcn_inst *vinst)
 {
 	return;
 }
@@ -664,15 +668,15 @@ static void vcn_v5_0_0_disable_clock_gating(struct amdgpu_device *adev, int inst
 /**
  * vcn_v5_0_0_disable_clock_gating_dpg_mode - disable VCN clock gating dpg mode
  *
- * @adev: amdgpu_device pointer
+ * @vinst: VCN instance
  * @sram_sel: sram select
- * @inst_idx: instance number index
  * @indirect: indirectly write sram
  *
  * Disable clock gating for VCN block with dpg mode
  */
-static void vcn_v5_0_0_disable_clock_gating_dpg_mode(struct amdgpu_device *adev, uint8_t sram_sel,
-	int inst_idx, uint8_t indirect)
+static void vcn_v5_0_0_disable_clock_gating_dpg_mode(struct amdgpu_vcn_inst *vinst,
+						     uint8_t sram_sel,
+						     uint8_t indirect)
 {
 	return;
 }
@@ -681,12 +685,11 @@ static void vcn_v5_0_0_disable_clock_gating_dpg_mode(struct amdgpu_device *adev,
 /**
  * vcn_v5_0_0_enable_clock_gating - enable VCN clock gating
  *
- * @adev: amdgpu_device pointer
- * @inst: instance number
+ * @vinst: VCN instance
  *
  * Enable clock gating for VCN block
  */
-static void vcn_v5_0_0_enable_clock_gating(struct amdgpu_device *adev, int inst)
+static void vcn_v5_0_0_enable_clock_gating(struct amdgpu_vcn_inst *vinst)
 {
 	return;
 }
@@ -694,14 +697,16 @@ static void vcn_v5_0_0_enable_clock_gating(struct amdgpu_device *adev, int inst)
 /**
  * vcn_v5_0_0_start_dpg_mode - VCN start with dpg mode
  *
- * @adev: amdgpu_device pointer
- * @inst_idx: instance number index
+ * @vinst: VCN instance
  * @indirect: indirectly write sram
  *
  * Start VCN block with dpg mode
  */
-static int vcn_v5_0_0_start_dpg_mode(struct amdgpu_device *adev, int inst_idx, bool indirect)
+static int vcn_v5_0_0_start_dpg_mode(struct amdgpu_vcn_inst *vinst,
+				     bool indirect)
 {
+	struct amdgpu_device *adev = vinst->adev;
+	int inst_idx = vinst->inst;
 	volatile struct amdgpu_vcn5_fw_shared *fw_shared = adev->vcn.inst[inst_idx].fw_shared.cpu_addr;
 	struct amdgpu_ring *ring;
 	uint32_t tmp;
@@ -741,7 +746,7 @@ static int vcn_v5_0_0_start_dpg_mode(struct amdgpu_device *adev, int inst_idx, b
 	WREG32_SOC24_DPG_MODE(inst_idx, SOC24_DPG_MODE_OFFSET(
 		VCN, inst_idx, regUVD_LMI_CTRL), tmp, 0, indirect);
 
-	vcn_v5_0_0_mc_resume_dpg_mode(adev, inst_idx, indirect);
+	vcn_v5_0_0_mc_resume_dpg_mode(vinst, indirect);
 
 	tmp = (0xFF << UVD_VCPU_CNTL__PRB_TIMEOUT_VAL__SHIFT);
 	tmp |= UVD_VCPU_CNTL__CLK_EN_MASK;
@@ -793,13 +798,14 @@ static int vcn_v5_0_0_start_dpg_mode(struct amdgpu_device *adev, int inst_idx, b
 /**
  * vcn_v5_0_0_start - VCN start
  *
- * @adev: amdgpu_device pointer
- * @i: instance to start
+ * @vinst: VCN instance
  *
  * Start VCN block
  */
-static int vcn_v5_0_0_start(struct amdgpu_device *adev, int i)
+static int vcn_v5_0_0_start(struct amdgpu_vcn_inst *vinst)
 {
+	struct amdgpu_device *adev = vinst->adev;
+	int i = vinst->inst;
 	volatile struct amdgpu_vcn5_fw_shared *fw_shared;
 	struct amdgpu_ring *ring;
 	uint32_t tmp;
@@ -814,10 +820,10 @@ static int vcn_v5_0_0_start(struct amdgpu_device *adev, int i)
 	fw_shared = adev->vcn.inst[i].fw_shared.cpu_addr;
 
 	if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG)
-		return vcn_v5_0_0_start_dpg_mode(adev, i, adev->vcn.inst[i].indirect_sram);
+		return vcn_v5_0_0_start_dpg_mode(vinst, adev->vcn.inst[i].indirect_sram);
 
 	/* disable VCN power gating */
-	vcn_v5_0_0_disable_static_power_gating(adev, i);
+	vcn_v5_0_0_disable_static_power_gating(vinst);
 
 	/* set VCN status busy */
 	tmp = RREG32_SOC15(VCN, i, regUVD_STATUS) | UVD_STATUS__UVD_BUSY;
@@ -848,7 +854,7 @@ static int vcn_v5_0_0_start(struct amdgpu_device *adev, int i)
 		     UVD_LMI_CTRL__DATA_COHERENCY_EN_MASK |
 		     UVD_LMI_CTRL__VCPU_DATA_COHERENCY_EN_MASK);
 
-	vcn_v5_0_0_mc_resume(adev, i);
+	vcn_v5_0_0_mc_resume(vinst);
 
 	/* VCN global tiling registers */
 	WREG32_SOC15(VCN, i, regUVD_GFX10_ADDR_CONFIG,
@@ -944,13 +950,14 @@ static int vcn_v5_0_0_start(struct amdgpu_device *adev, int i)
 /**
  * vcn_v5_0_0_stop_dpg_mode - VCN stop with dpg mode
  *
- * @adev: amdgpu_device pointer
- * @inst_idx: instance number index
+ * @vinst: VCN instance
  *
  * Stop VCN block with dpg mode
  */
-static void vcn_v5_0_0_stop_dpg_mode(struct amdgpu_device *adev, int inst_idx)
+static void vcn_v5_0_0_stop_dpg_mode(struct amdgpu_vcn_inst *vinst)
 {
+	struct amdgpu_device *adev = vinst->adev;
+	int inst_idx = vinst->inst;
 	struct dpg_pause_state state = {.fw_based = VCN_DPG_STATE__UNPAUSE};
 	uint32_t tmp;
 
@@ -974,13 +981,14 @@ static void vcn_v5_0_0_stop_dpg_mode(struct amdgpu_device *adev, int inst_idx)
 /**
  * vcn_v5_0_0_stop - VCN stop
  *
- * @adev: amdgpu_device pointer
- * @i: instance to stop
+ * @vinst: VCN instance
  *
  * Stop VCN block
  */
-static int vcn_v5_0_0_stop(struct amdgpu_device *adev, int i)
+static int vcn_v5_0_0_stop(struct amdgpu_vcn_inst *vinst)
 {
+	struct amdgpu_device *adev = vinst->adev;
+	int i = vinst->inst;
 	volatile struct amdgpu_vcn5_fw_shared *fw_shared;
 	uint32_t tmp;
 	int r = 0;
@@ -992,7 +1000,7 @@ static int vcn_v5_0_0_stop(struct amdgpu_device *adev, int i)
 	fw_shared->sq.queue_mode |= FW_QUEUE_DPG_HOLD_OFF;
 
 	if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) {
-		vcn_v5_0_0_stop_dpg_mode(adev, i);
+		vcn_v5_0_0_stop_dpg_mode(vinst);
 		return 0;
 	}
 
@@ -1045,7 +1053,7 @@ static int vcn_v5_0_0_stop(struct amdgpu_device *adev, int i)
 	WREG32_SOC15(VCN, i, regUVD_STATUS, 0);
 
 	/* enable VCN power gating */
-	vcn_v5_0_0_enable_static_power_gating(adev, i);
+	vcn_v5_0_0_enable_static_power_gating(vinst);
 
 	if (adev->pm.dpm_enabled)
 		amdgpu_dpm_enable_vcn(adev, false, i);
@@ -1271,15 +1279,17 @@ static int vcn_v5_0_0_set_clockgating_state(struct amdgpu_ip_block *ip_block,
 	int i;
 
 	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
+		struct amdgpu_vcn_inst *vinst = &adev->vcn.inst[i];
+
 		if (adev->vcn.harvest_config & (1 << i))
 			continue;
 
 		if (enable) {
 			if (RREG32_SOC15(VCN, i, regUVD_STATUS) != UVD_STATUS__IDLE)
 				return -EBUSY;
-			vcn_v5_0_0_enable_clock_gating(adev, i);
+			vcn_v5_0_0_enable_clock_gating(vinst);
 		} else {
-			vcn_v5_0_0_disable_clock_gating(adev, i);
+			vcn_v5_0_0_disable_clock_gating(vinst);
 		}
 	}
 
@@ -1291,15 +1301,16 @@ static int vcn_v5_0_0_set_powergating_state_inst(struct amdgpu_ip_block *ip_bloc
 						 int i)
 {
 	struct amdgpu_device *adev = ip_block->adev;
+	struct amdgpu_vcn_inst *vinst = &adev->vcn.inst[i];
 	int ret = 0;
 
 	if (state == adev->vcn.inst[i].cur_state)
 		return 0;
 
 	if (state == AMD_PG_STATE_GATE)
-		ret = vcn_v5_0_0_stop(adev, i);
+		ret = vcn_v5_0_0_stop(vinst);
 	else
-		ret = vcn_v5_0_0_start(adev, i);
+		ret = vcn_v5_0_0_start(vinst);
 
 	if (!ret)
 		adev->vcn.inst[i].cur_state = state;
-- 
2.47.1

