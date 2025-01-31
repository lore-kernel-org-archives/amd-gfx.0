Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A758C02194
	for <amd-gfx@archiver.kernel.org>; Fri, 31 Jan 2025 16:58:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 139D310E3C6;
	Fri, 31 Jan 2025 16:58:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="idoTbJ86";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2067.outbound.protection.outlook.com [40.107.94.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E894C10E3C5
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 Jan 2025 16:58:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jyUeXdHFOivwJzErpD43pVrxEG2duBjTJjdN+QwUq7ik+8J+jGcvyww7nBc9+xvJzejAibtFROwfkyPsZDb4EfQvk/yH0vzJN/AgSunjJYpTP87NWl3Gd9kFuhX7gFM/yXqMugnRSNDj7jkLInSXDnNNtFctxIc3GT/4EICS3lnUliyc6PcRu8jkTHEmBUHDM1pSZwaKTofC8YPHZmI7veog4l7jgEkvhiPHJihdcITYQ19sO1gaV06j3ZW+HOEYcOHa6cegMTFqBUIy34MRIuaYcW0qTUPoK4xqCQ9bGo6IhkIE7V7OelgALB+ZVfjFLGAYqu9NZktvz3TfxsnjIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CSUJL3bA+H9ti8cg0pjDkHPwG2VPCBwcnhiMuWz4hvA=;
 b=JQ1pYUUOWnT0BoQopy10wD2WRrfW8/BSQyz+YH6iq5gEUdfW2HdlWntg/FfyHLESSrQde+8pAy3xx4HjZeCwR+t0MoAj/igwlpbXuA8RYGzanCsTnY9NyK2DcTiSPU62lDwfS1yxk5Vtl1kusZxy98u0gIoi3GPs/sRTXLbDw+wVawLzQZeyxp7IMN0wNgDZehOddKW45GTFE6EIXmNvRxIg+r0xxdzuKKHJwy2Kv2+l0STEjXWH881a4IHkKAi6MQ+7rQKkf9R3g/G4Ev+3k3cC8t9RLFwKsdJzpgZVY5dspEWPLzxqXiX9A+L5iUl0pHU0U4H38T/BCUmik563Wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CSUJL3bA+H9ti8cg0pjDkHPwG2VPCBwcnhiMuWz4hvA=;
 b=idoTbJ86Uto56ujme8Ignnk7qij7PoYp4MAQC+/8IgR4Ft1s35q5Pk4t199FOuVAupluKP6repNfrFM0poX0ciUDhOjYLAnmMsenC93f5oDAgOP5fY1vaZkSmh7mFS7oaGLid9+Q99BuEqn1uNY3MXQ73wIOcjPW2lMXI8xE4T8=
Received: from DM6PR07CA0092.namprd07.prod.outlook.com (2603:10b6:5:337::25)
 by DS0PR12MB6535.namprd12.prod.outlook.com (2603:10b6:8:c0::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.21; Fri, 31 Jan
 2025 16:58:16 +0000
Received: from DS2PEPF0000343C.namprd02.prod.outlook.com
 (2603:10b6:5:337:cafe::46) by DM6PR07CA0092.outlook.office365.com
 (2603:10b6:5:337::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.22 via Frontend Transport; Fri,
 31 Jan 2025 16:58:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF0000343C.mail.protection.outlook.com (10.167.18.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8398.14 via Frontend Transport; Fri, 31 Jan 2025 16:58:16 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 31 Jan
 2025 10:58:11 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 20/44] drm/amdgpu/vcn5.0.1: convert internal functions to use
 vcn_inst
Date: Fri, 31 Jan 2025 11:57:16 -0500
Message-ID: <20250131165741.1798488-21-alexander.deucher@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343C:EE_|DS0PR12MB6535:EE_
X-MS-Office365-Filtering-Correlation-Id: 4523c99e-af05-48b7-9f21-08dd4218750e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ZLcy0+fEp148pqH35jlGB1BfysxQQ8SnGa8p8EnDIAHMOW0eEluFfEdFoG7/?=
 =?us-ascii?Q?SFatJBfqbNPFLb8NkyED06kgYU5I2gn4n0oy9MwIgbsbJkOnq2seufq8lvke?=
 =?us-ascii?Q?b2She7iyxsN7bt4bxX7K8gdGUvHgpNCsVmZG+bS16/RlBTXgks66iOO5tWgT?=
 =?us-ascii?Q?Qz8bgwZpoNGgC7qdF3LniwsJl02s5q+Jpvcs1IWW0WK2AcqZgh4des8LxhEx?=
 =?us-ascii?Q?97KSVuPLHS+TvgMdqfQv85/xB3Kq2zpn3zFlCFiRgWXhPhwZ5bKA3ywC2lSx?=
 =?us-ascii?Q?iBqVnUWt+ezS6O8er0f6uFLmFA48FMsaEVPTBPoGwiBKDq0/r0Gp6KQjv0vX?=
 =?us-ascii?Q?dVoK0+Q+oNQ53cKNDdoHzDewuOC3ZheT5N86YakAGwMDJufr1TKJYtdvQGCm?=
 =?us-ascii?Q?7PKCFV74wmMVVCTt4U8feRcIFdcafR2aduRFcPaPS3AefClAiHm8cvWqCwEU?=
 =?us-ascii?Q?4RaykvsYRls/i7XhKCHeLOx1WyFZ0IspgAPeDa7y0tTT3UiVubgs6NUNWsgi?=
 =?us-ascii?Q?P3TgZNI4kQlRulZehyUf2RWIYKp0zVnInqh7VchakcySuN3MBHyWCJGKpsJS?=
 =?us-ascii?Q?+Qawe5LtiGsYwyvPnK5QiOQxwQNK3ebTiV99n2UDDS50rtlptGaf8MRGm3GI?=
 =?us-ascii?Q?dM9DsTKp0oXW7E+RlzpAPOxc3rxogdDd6R/KRMzrJUR5n31vbxl8LA7FaplT?=
 =?us-ascii?Q?Tsp7qpmjQ+NvgiPv016E0FULtkxzvb5oRoIKBALM52RPIPHV2ZTDnEe14nIf?=
 =?us-ascii?Q?vrHL0A8QskIeBu18TGTHjY/ZZQBUFeq0+67pvyIC7JO1+rPQCH9p3QiSqwOU?=
 =?us-ascii?Q?3zVWtcb5sILebUOxE2hv04ENEQDBKILLImkmFSZe/mR2aIxSUkLL2qAgBM9C?=
 =?us-ascii?Q?nc7asOIjc0UuE1IR1AZOrgziaP/61JtscqoseyLB1m2CZlYjctD5LfchD22O?=
 =?us-ascii?Q?vCHFIrjU1eVPSnX9FOH26h9zrRkQd0A3TlsZ8jK1zO7e2HfS4tVYkLzgpgz0?=
 =?us-ascii?Q?fopteW0XTOFxPITuT5G3HrelrEMQjE5pYa67MQXShZgE8jcJPVXYOnadgLzs?=
 =?us-ascii?Q?JNGNPuCBUlx4vbbdjG15e0EQFqZz1Opi+iNQnZp8MxMvGUANoV4lHwmuTqw3?=
 =?us-ascii?Q?Tg4G73FyltGhz+fyXfAxG/4yUh8U7oTYRXGkcwC6hZ2dqUJQidh6Jcz4qRn1?=
 =?us-ascii?Q?noXaZUfLk/b+/WAxYsIU2j2A33K15TvXQ0qQr9rLAN0IM5DWTYyFo8eJ69pJ?=
 =?us-ascii?Q?icH5a4tYIJzaek3F9m/dn6e9gj89xgYVuYQBmSJMswtoA4qGhFV+K6vGSnZR?=
 =?us-ascii?Q?vkCiUBVEvB/doypMmuTFh/EtyVJtSRaPTmOGstRIM1iBH18h4I0Vkta1OlWY?=
 =?us-ascii?Q?E83/uD+MDV9ccPzvIWHUfNqI+HYhB/rozh8r6yKpyEsZ/YfRm3j6jOolPHdV?=
 =?us-ascii?Q?Rojq0b0ei5G37os5JU9xxzfNhi3VFQ8IenoF/gpKee9/CZp21jDIxA=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2025 16:58:16.5925 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4523c99e-af05-48b7-9f21-08dd4218750e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF0000343C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6535
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
index f49fdf2bb6e33..8eccb45b04d2c 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
@@ -282,13 +282,14 @@ static int vcn_v5_0_1_resume(struct amdgpu_ip_block *ip_block)
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
 
@@ -344,14 +345,16 @@ static void vcn_v5_0_1_mc_resume(struct amdgpu_device *adev, int inst)
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
 
@@ -456,38 +459,38 @@ static void vcn_v5_0_1_mc_resume_dpg_mode(struct amdgpu_device *adev, int inst_i
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
@@ -535,7 +538,7 @@ static int vcn_v5_0_1_start_dpg_mode(struct amdgpu_device *adev, int inst_idx, b
 	WREG32_SOC24_DPG_MODE(inst_idx, SOC24_DPG_MODE_OFFSET(
 		VCN, 0, regUVD_LMI_CTRL), tmp, 0, indirect);
 
-	vcn_v5_0_1_mc_resume_dpg_mode(adev, inst_idx, indirect);
+	vcn_v5_0_1_mc_resume_dpg_mode(vinst, indirect);
 
 	tmp = (0xFF << UVD_VCPU_CNTL__PRB_TIMEOUT_VAL__SHIFT);
 	tmp |= UVD_VCPU_CNTL__CLK_EN_MASK;
@@ -589,12 +592,14 @@ static int vcn_v5_0_1_start_dpg_mode(struct amdgpu_device *adev, int inst_idx, b
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
@@ -606,7 +611,7 @@ static int vcn_v5_0_1_start(struct amdgpu_device *adev, int i)
 	fw_shared = adev->vcn.inst[i].fw_shared.cpu_addr;
 
 	if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG)
-		return vcn_v5_0_1_start_dpg_mode(adev, i, adev->vcn.inst[i].indirect_sram);
+		return vcn_v5_0_1_start_dpg_mode(vinst, adev->vcn.inst[i].indirect_sram);
 
 	vcn_inst = GET_INST(VCN, i);
 
@@ -639,7 +644,7 @@ static int vcn_v5_0_1_start(struct amdgpu_device *adev, int i)
 		     UVD_LMI_CTRL__DATA_COHERENCY_EN_MASK |
 		     UVD_LMI_CTRL__VCPU_DATA_COHERENCY_EN_MASK);
 
-	vcn_v5_0_1_mc_resume(adev, i);
+	vcn_v5_0_1_mc_resume(vinst);
 
 	/* VCN global tiling registers */
 	WREG32_SOC15(VCN, vcn_inst, regUVD_GFX10_ADDR_CONFIG,
@@ -739,13 +744,14 @@ static int vcn_v5_0_1_start(struct amdgpu_device *adev, int i)
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
 
@@ -767,12 +773,14 @@ static void vcn_v5_0_1_stop_dpg_mode(struct amdgpu_device *adev, int inst_idx)
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
@@ -783,7 +791,7 @@ static int vcn_v5_0_1_stop(struct amdgpu_device *adev, int i)
 	fw_shared->sq.queue_mode |= FW_QUEUE_DPG_HOLD_OFF;
 
 	if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) {
-		vcn_v5_0_1_stop_dpg_mode(adev, i);
+		vcn_v5_0_1_stop_dpg_mode(vinst);
 		return 0;
 	}
 
@@ -1005,12 +1013,14 @@ static int vcn_v5_0_1_set_clockgating_state(struct amdgpu_ip_block *ip_block,
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
 
@@ -1022,15 +1032,16 @@ static int vcn_v5_0_1_set_powergating_state_inst(struct amdgpu_ip_block *ip_bloc
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
2.48.1

