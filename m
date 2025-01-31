Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33894C0219E
	for <amd-gfx@archiver.kernel.org>; Fri, 31 Jan 2025 16:58:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 191DC10E3E8;
	Fri, 31 Jan 2025 16:58:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="fZ/NyrUI";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2049.outbound.protection.outlook.com [40.107.223.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C354A10E3DC
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 Jan 2025 16:58:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uoDerMoHul9OHAUgyz1PIdQ23Zt91NeaIGVYfiPp80UD3oPWEu6wpyjzo5sMzZG+tNJVCcRFN0TMVHpAEhAM32qH3L8MH4ab9Z04eg8+nm3xPqj9PoKxNCgCiVw7x2BrUOiMxTa+rdB/ytl60aVvc3OHSO6vaEsmdmdb2OL4/jRRjar4MVdYVaxEV7wS0KN6ZcI3ivx0Ti94C2yrPB1pc84ZFJRwayfz1iWltwkS078GxQ0qOfoXXzPO3uKatTm6KKrr9OZX9A4x0zVWHfBOqF0lRWyEZ2K1kh0QjmXJ2+VVoyBEY/D4FQcqtqznJ8//sRQTJcUwvDEMkXtcCI1sMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k5nvEDgM0jrAQEEDxPg2x2Q/MoDGku9tfgad27kh93Q=;
 b=DKXgi91cOc8rmUktOPLsgxFVYy/ePua2dnXn7EL7AeUNer6t8sIDcpTYNGFlcHS6+KYmi8ylwF5XHQrmqDVmF6tDOhahzkkDlItLD20aRP3qJJmAyZ6uyv5TAs376goy+4nZpoDkC1m94tSfvaJxyz1e4zCOgW9mDWps30cfNylFKuBvB/Kzp0LqA/Qk3Lg+H1+Yg6LSPSyNasi8hvYdoV7FKaguhEHL0wWNcxgaM7DTjK8GzY/1pwcSwYwr7LRQYGN5ouDDs/62vxhZr4bx569xeMf5+eJUxgdpLDN9AO3Rw5ceWUbBHGIZA0lQ4KYrn7W/+eNuYUs3Iu8yMSBRkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k5nvEDgM0jrAQEEDxPg2x2Q/MoDGku9tfgad27kh93Q=;
 b=fZ/NyrUIm5hknns/R5u+1Hd2U8BXmDXBjdNlKUUCMxwMWYF6Srx54rNX7wOiF0VJDAqKuPp0H0Cruqyh2IJ0CCX4IRipSRHGoF7k8te8ytJxGmkcxNncqQPl8dpa7rvS4VZSfN15Ikoh+ej8WliH7+zZE0kNpi3q/j5Em1MUJJU=
Received: from DM6PR07CA0090.namprd07.prod.outlook.com (2603:10b6:5:337::23)
 by CH3PR12MB8901.namprd12.prod.outlook.com (2603:10b6:610:180::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.21; Fri, 31 Jan
 2025 16:58:16 +0000
Received: from DS2PEPF0000343C.namprd02.prod.outlook.com
 (2603:10b6:5:337:cafe::e0) by DM6PR07CA0090.outlook.office365.com
 (2603:10b6:5:337::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.20 via Frontend Transport; Fri,
 31 Jan 2025 16:58:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF0000343C.mail.protection.outlook.com (10.167.18.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8398.14 via Frontend Transport; Fri, 31 Jan 2025 16:58:15 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 31 Jan
 2025 10:58:10 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 18/44] drm/amdgpu/vcn4.0.5: convert internal functions to use
 vcn_inst
Date: Fri, 31 Jan 2025 11:57:14 -0500
Message-ID: <20250131165741.1798488-19-alexander.deucher@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343C:EE_|CH3PR12MB8901:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e44f24e-28fe-4b21-cd99-08dd4218747a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ANWhyg2WCEVmRMVGEtBDBeLb3/3fQF12JJuX2Te7AKXEQOuDLr0rph0JTnTG?=
 =?us-ascii?Q?1UvsJtGasuSDPxctlaDsyvvLbyPiMX6qUhMjduLLxeCaCXztaqowHVhpB2gq?=
 =?us-ascii?Q?UguU6tN+0/Yw4Suy3ompCQQwce3ysoaPVEozAcWr9g3iTqvgnMpyx5BubYUZ?=
 =?us-ascii?Q?kiCaj22Om1ZNbJv2QlsZfMRON9Rb+ggfFo3HXH7gZXPwb7QbBNTEHarQXxN4?=
 =?us-ascii?Q?g0FyqrXZN/PY3dFCcq9zfpHX9KJcva1p0hHgVsvuoltYDH/ygfQV0dsBg4yH?=
 =?us-ascii?Q?8de/WGqv7q18X5JbaxS7J7bHetRTLL6aPdCXnJ2PMAEXepKX/ho2tSpe5pri?=
 =?us-ascii?Q?Ll01RdtjA+J5LAIORxcV9b4d789Iph8KWeeDtn4N9N0HU+i0RsXFlkdMD9PG?=
 =?us-ascii?Q?cYJx+o/pfZStS1Xo9MFwAHSivnOXsSloulI8bMiVVnnt6+/pCsruOz+evsP3?=
 =?us-ascii?Q?NEkh0VKrdk2IZzRthNXVaY4phj/TpiILnO57lInGq2nzEKrJi3SKLTOoOZaq?=
 =?us-ascii?Q?CfkAYuuQtrzFfXe9+mZb7EAvjjDPE72AZNBx7G+tppXtZ54fZfzKqNMAbRsh?=
 =?us-ascii?Q?IPWdQM/KMR2u0ULz4B3maF2v2eXINLuHGP2hRameQo7Lgue9wrk12wgxP7gy?=
 =?us-ascii?Q?TiTU5yYVn/bqchiggY/zU01IkhGXbaQd/sSGJRG+xBWvX/m7xWIMDT6SGrGc?=
 =?us-ascii?Q?BYz4TN5fxIrgf9xkY4CW9y2d4Tvnxzg0vScjoo8SUuNjxAlTcmNXeJn6Nbud?=
 =?us-ascii?Q?OuaWepSK65OqJEKofgOpRlhh6TeabHi1eBLmWLoOqa+hM4C0e537xXcaxdhC?=
 =?us-ascii?Q?XKGa9Ysk9E6Qar3j+8QwYiGS5FXGa3Wc7AnKL3Mo7yvjHEg+ocMaWCPMR5cK?=
 =?us-ascii?Q?zirbLZS9k/RjjrfqvbBdCYZQkXacJrog+gEGss34azy7NOPmn4L4CskZFQ8n?=
 =?us-ascii?Q?ijQAeRc88pE04PjWVva+HIfmXnmHmbrpOj7VbOMtND7dkgO2EyZ3Hi951c/0?=
 =?us-ascii?Q?oT1ovCfve7M/LEj9XvHkv62nXy+QQ2FuEiYNif4UQqNOO4HuQ9C/oI77Fyql?=
 =?us-ascii?Q?YfPAzYSG+Q6xrOCgdfwvLy1HtkV204dg/cKfKp0UvGrOfHKsSM0RHmF/dunq?=
 =?us-ascii?Q?rbsTdVG2fvtlW2bByH4meoIPy8nbi+V0SpErs3QAPlY7+Rr7qfMp/a5QVdMH?=
 =?us-ascii?Q?77113siQqpocjE2jAhhBCE+9rMMf0pgs1Blb7Rb+Xe1ihDiygOioRpzg4MPF?=
 =?us-ascii?Q?4y1Kgkdfss+l9C9iP7lCZrYXZtHseIxGV8d0LOf6H7Ptfdl06g89wWgjUAzf?=
 =?us-ascii?Q?963z//6jevlS0QrPJ2ITrhksqv/cX6XKhZQComiGpMonLuUrhJDZWbCox2eB?=
 =?us-ascii?Q?1TAFxB2y8Cm9s3vBbVA5FdcuCTN2ktVC4SPcZ/IZm9uJIsJyOFH9LT2YXcX2?=
 =?us-ascii?Q?Q+NDfI7q1fBA3S3V5CLOaVfEtBxLnIw+478dzGsqHPRS0gn48gdsqA=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2025 16:58:15.6238 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e44f24e-28fe-4b21-cd99-08dd4218747a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF0000343C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8901
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
2.48.1

