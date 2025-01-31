Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07025C02196
	for <amd-gfx@archiver.kernel.org>; Fri, 31 Jan 2025 16:58:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A597D10E3C4;
	Fri, 31 Jan 2025 16:58:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="MOBHgfnX";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2066.outbound.protection.outlook.com [40.107.94.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 31FC610E3B1
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 Jan 2025 16:58:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MbH601l7LfCkl1dFffArGtB+guwTPBPWTGZHDnJJh69hF4IibDX5EZOxOyG55OD2eWR2SofN5mrinygYqCjry4MZZWei0PQMsVEar9eAB1DwxMf1JnL21xdA/gQ7f6/PZmAiieK4nuzo4WC9f/YBMC4LwKBXBaCh01QIyaHDnHI6trpUBvfzQM3h6aDWsitY6fyVW2afTD0jFvbW0qZeVmW5R+EhQ9e2gkkk01Q8PGJBp20J+XOdx8Xl+hKbJWbWb7y9FdH8qKW6CfzZcXPttOwOt2FUVvdJz4g6wtQsvZLNuVpZfNxN6I8siDkocy7ukUmh1LviYh9ZyVzzDsqeVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=euLNztSP00vQnGMtS6fRFIIkOF216mYyjbXK9Oi86yE=;
 b=hUlquFZW0/Wo0dIaV3B/iW4kPT6Ub4Lxw2HojoMXRG4Tdh7LqprPOsKgz1CcOBRpYqYzIRqL6F7X7G2gs9f0H7dY85tN6f29ZC2UX/8PvaoGh8tTZtjuMEXSD/w3D9ixLYw0bU/MUYH3mATN3qXhIuJPsxDM7Z5t+CObB/6nIvlQ7rOZyv/wGQDVGuqj+TVTh1c+Nbq/oc8lhuU/42pc+A2lPorb3AQTXPhrCnurwIEmxozggzQZIplAcE4HZv/9mlV/DA9Y1S46eV2rfGSaDSi2VGq/m4ausJiHPT7OacHJqiBzOzfkL4qdEYGluJyjACZqglFNmhKPXzpAaqkgmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=euLNztSP00vQnGMtS6fRFIIkOF216mYyjbXK9Oi86yE=;
 b=MOBHgfnXlMXwgLzazpWqkPNTZQjhNPNTlwT6k8NKNDqmu9n6f6B6xERtHyoUlfQzliXWbfHHtP8f+E94uKShiMFTiamsG6uiT29IYqQ0QCj/wAhvTtgkBLpQeI/MMi64UNtmARZcErsWXLWs8z4WRPVAfImBcNrJuXeMkMCLYP4=
Received: from DM6PR07CA0090.namprd07.prod.outlook.com (2603:10b6:5:337::23)
 by MN2PR12MB4336.namprd12.prod.outlook.com (2603:10b6:208:1df::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.21; Fri, 31 Jan
 2025 16:58:14 +0000
Received: from DS2PEPF0000343C.namprd02.prod.outlook.com
 (2603:10b6:5:337:cafe::53) by DM6PR07CA0090.outlook.office365.com
 (2603:10b6:5:337::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.20 via Frontend Transport; Fri,
 31 Jan 2025 16:58:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF0000343C.mail.protection.outlook.com (10.167.18.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8398.14 via Frontend Transport; Fri, 31 Jan 2025 16:58:14 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 31 Jan
 2025 10:58:08 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 15/44] drm/amdgpu/vcn2.5: convert internal functions to use
 vcn_inst
Date: Fri, 31 Jan 2025 11:57:11 -0500
Message-ID: <20250131165741.1798488-16-alexander.deucher@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343C:EE_|MN2PR12MB4336:EE_
X-MS-Office365-Filtering-Correlation-Id: c6ea13fb-8baa-4483-8740-08dd421873d1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?l5UVDVAW1PXyKoZvynqeL4Bfr1KlUWlC7UEN9JoMgcTprzl2kc89TRnTo/QV?=
 =?us-ascii?Q?KVeaPuOHCJSPUgVmn1Y6NYEPDNsqgvdtmaQ/g+51ggMkTjRuCs6x8+S/yT/z?=
 =?us-ascii?Q?icbjsEyvjB4L1ZUDgDIGjLwAjDfuJWLLtwc1QXPlCVErerStJ0mLqZZTTadc?=
 =?us-ascii?Q?TfFx3ZIoR9+mYtZ/8uUG7Wjhm/+qlIYXePp9l4N6z+/HY4wthpQBCxj9+omd?=
 =?us-ascii?Q?FwrMOsNA92MYvim4xoaBtuX1Yz/gHqLedyLLJj1VSAFtMGIj1SapQ/IcJwyc?=
 =?us-ascii?Q?0jBsboltEEv5lIHXmzQged6+v5xVMG1OC+RaQbXlKkGDcc9+T34HX4KBDCCP?=
 =?us-ascii?Q?2WEaMwlgf/16oBRwDLwr/H/abwHcIWZHieq08PYxpI8lUbpKSW8Zlfd/RzZW?=
 =?us-ascii?Q?/4Ys4deLXUy4hr9isEco69Iqnxtq/dP0MXbUtCfkhPXkqczClh9gR7ZcoXo1?=
 =?us-ascii?Q?lAr3rmUVHK9xyzgQq0o/nZLNU/a0kj0BM9PZwM5TP1PlM6qaBQOwpFcpOjhq?=
 =?us-ascii?Q?rG4OSMRJ9hYkDveoPp45bmvCiiwzeisv2oNU7FTPBFoIdLjzXu83WpbEQ+RR?=
 =?us-ascii?Q?QsRihhFCwiNaT+mNt3WuvIt0NCGwS96tNiwj+Tsluos+XCC4xsxtEW8xVZwU?=
 =?us-ascii?Q?amJPxu/LnMA4sN4GoiOTfHoyVk1D2zXXrGXx1hwi+GzFCP07r/SjCO2hR9bY?=
 =?us-ascii?Q?qcxG80W/Oq4QH2lxKVfyEYDxoGLiI2x0zua3wW2Eshxg1XQOu1xJ5mIR+42B?=
 =?us-ascii?Q?xi1FfVfkEcvVRJvJkC23la4f2GIYmjPjkDjsbir5GL4fYz4xxa5P97KyNefc?=
 =?us-ascii?Q?Aupm4Q8ScbEWQVeXyJV1SP3S3LJx47UP+KsH3Grc0yQDMRzE6IJ3J8Vs09ld?=
 =?us-ascii?Q?tAm2Sa3Hocd8yxDYw6xnxzviDUT56Vhl+1F/7B11T8MrdgyGMwRL2GYx6CvI?=
 =?us-ascii?Q?LBkP/KnAiIIBVB6yjlXfg7oadaJGR+Qo1myrK7Dw5dRs7biuHWajXvp/0xEP?=
 =?us-ascii?Q?0t6lR6GVzTgNDqizz3dVrFL2drfIHV7Cbrp/99oZdzsVk1iGhrgVOuwcvDrC?=
 =?us-ascii?Q?gl3DVXVdSCGLvXvaMpt2sgTsphfIFT1HIEsm0Psealfuk55lRdWg1wAIwPZf?=
 =?us-ascii?Q?3pTdhrsjuR+bDIiiij81PNupWqw0bRU4YJiw5eWdUWxcZ2t/Vwa6rDqXKaAj?=
 =?us-ascii?Q?bC/RKvI5CgsN2P+vPuZ/IXtP3/75ztWYvIm9GJnbbpNM34Itv53qHPYu1MM7?=
 =?us-ascii?Q?CxtM4/Jd5qAosaGnvPBZD2Ol3Tcun8S7rvofk4b7sGH4kt9rjqVoB4JF0xvy?=
 =?us-ascii?Q?VuDwRXlIwbuXNW63+4kJTvmt8wTTiYS1HoOkexxJPMbTiPnr78Jkr9Ydb0b1?=
 =?us-ascii?Q?8yGbKXMhPRUCkduWR6FHSg/g1aUgD/1UweIWLdvdc2fefyykQW/I11TRPG97?=
 =?us-ascii?Q?jcBw0Ro4t47UfVEwuIiolixJZAfn3Ao/HYFZOgbu13Kh/2KkPeHOTw=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2025 16:58:14.5144 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c6ea13fb-8baa-4483-8740-08dd421873d1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF0000343C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4336
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
 drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c | 79 +++++++++++++++++----------
 1 file changed, 50 insertions(+), 29 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
index 4f9f3de023ffd..69cf42a4a3f18 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
@@ -468,13 +468,14 @@ static int vcn_v2_5_resume(struct amdgpu_ip_block *ip_block)
 /**
  * vcn_v2_5_mc_resume - memory controller programming
  *
- * @adev: amdgpu_device pointer
- * @i: instance to resume
+ * @vinst: VCN instance
  *
  * Let the VCN memory controller know it's offsets
  */
-static void vcn_v2_5_mc_resume(struct amdgpu_device *adev, int i)
+static void vcn_v2_5_mc_resume(struct amdgpu_vcn_inst *vinst)
 {
+	struct amdgpu_device *adev = vinst->adev;
+	int i = vinst->inst;
 	uint32_t size;
 	uint32_t offset;
 
@@ -527,8 +528,11 @@ static void vcn_v2_5_mc_resume(struct amdgpu_device *adev, int i)
 		     AMDGPU_GPU_PAGE_ALIGN(sizeof(struct amdgpu_fw_shared)));
 }
 
-static void vcn_v2_5_mc_resume_dpg_mode(struct amdgpu_device *adev, int inst_idx, bool indirect)
+static void vcn_v2_5_mc_resume_dpg_mode(struct amdgpu_vcn_inst *vinst,
+					bool indirect)
 {
+	struct amdgpu_device *adev = vinst->adev;
+	int inst_idx = vinst->inst;
 	uint32_t size = AMDGPU_GPU_PAGE_ALIGN(adev->vcn.inst[inst_idx].fw->size + 4);
 	uint32_t offset;
 
@@ -626,13 +630,14 @@ static void vcn_v2_5_mc_resume_dpg_mode(struct amdgpu_device *adev, int inst_idx
 /**
  * vcn_v2_5_disable_clock_gating - disable VCN clock gating
  *
- * @adev: amdgpu_device pointer
- * @i: instance to disable clockgating on
+ * @vinst: VCN instance
  *
  * Disable clock gating for VCN block
  */
-static void vcn_v2_5_disable_clock_gating(struct amdgpu_device *adev, int i)
+static void vcn_v2_5_disable_clock_gating(struct amdgpu_vcn_inst *vinst)
 {
+	struct amdgpu_device *adev = vinst->adev;
+	int i = vinst->inst;
 	uint32_t data;
 
 	if (adev->vcn.harvest_config & (1 << i))
@@ -738,9 +743,11 @@ static void vcn_v2_5_disable_clock_gating(struct amdgpu_device *adev, int i)
 	WREG32_SOC15(VCN, i, mmUVD_SUVD_CGC_CTRL, data);
 }
 
-static void vcn_v2_5_clock_gating_dpg_mode(struct amdgpu_device *adev,
-		uint8_t sram_sel, int inst_idx, uint8_t indirect)
+static void vcn_v2_5_clock_gating_dpg_mode(struct amdgpu_vcn_inst *vinst,
+		uint8_t sram_sel, uint8_t indirect)
 {
+	struct amdgpu_device *adev = vinst->adev;
+	int inst_idx = vinst->inst;
 	uint32_t reg_data = 0;
 
 	/* enable sw clock gating control */
@@ -789,13 +796,14 @@ static void vcn_v2_5_clock_gating_dpg_mode(struct amdgpu_device *adev,
 /**
  * vcn_v2_5_enable_clock_gating_inst - enable VCN clock gating
  *
- * @adev: amdgpu_device pointer
- * @i: instance to enable clockgating on
+ * @vinst: VCN instance
  *
  * Enable clock gating for VCN block
  */
-static void vcn_v2_5_enable_clock_gating(struct amdgpu_device *adev, int i)
+static void vcn_v2_5_enable_clock_gating(struct amdgpu_vcn_inst *vinst)
 {
+	struct amdgpu_device *adev = vinst->adev;
+	int i = vinst->inst;
 	uint32_t data = 0;
 
 	if (adev->vcn.harvest_config & (1 << i))
@@ -846,9 +854,11 @@ static void vcn_v2_5_enable_clock_gating(struct amdgpu_device *adev, int i)
 	WREG32_SOC15(VCN, i, mmUVD_SUVD_CGC_CTRL, data);
 }
 
-static void vcn_v2_6_enable_ras(struct amdgpu_device *adev, int inst_idx,
+static void vcn_v2_6_enable_ras(struct amdgpu_vcn_inst *vinst,
 				bool indirect)
 {
+	struct amdgpu_device *adev = vinst->adev;
+	int inst_idx = vinst->inst;
 	uint32_t tmp;
 
 	if (amdgpu_ip_version(adev, UVD_HWIP, 0) != IP_VERSION(2, 6, 0))
@@ -873,8 +883,10 @@ static void vcn_v2_6_enable_ras(struct amdgpu_device *adev, int inst_idx,
 			      tmp, 0, indirect);
 }
 
-static int vcn_v2_5_start_dpg_mode(struct amdgpu_device *adev, int inst_idx, bool indirect)
+static int vcn_v2_5_start_dpg_mode(struct amdgpu_vcn_inst *vinst, bool indirect)
 {
+	struct amdgpu_device *adev = vinst->adev;
+	int inst_idx = vinst->inst;
 	volatile struct amdgpu_fw_shared *fw_shared = adev->vcn.inst[inst_idx].fw_shared.cpu_addr;
 	struct amdgpu_ring *ring;
 	uint32_t rb_bufsz, tmp;
@@ -892,7 +904,7 @@ static int vcn_v2_5_start_dpg_mode(struct amdgpu_device *adev, int inst_idx, boo
 		adev->vcn.inst[inst_idx].dpg_sram_curr_addr = (uint32_t *)adev->vcn.inst[inst_idx].dpg_sram_cpu_addr;
 
 	/* enable clock gating */
-	vcn_v2_5_clock_gating_dpg_mode(adev, 0, inst_idx, indirect);
+	vcn_v2_5_clock_gating_dpg_mode(vinst, 0, indirect);
 
 	/* enable VCPU clock */
 	tmp = (0xFF << UVD_VCPU_CNTL__PRB_TIMEOUT_VAL__SHIFT);
@@ -941,7 +953,7 @@ static int vcn_v2_5_start_dpg_mode(struct amdgpu_device *adev, int inst_idx, boo
 		 (0x1 << UVD_MPC_SET_MUX__SET_1__SHIFT) |
 		 (0x2 << UVD_MPC_SET_MUX__SET_2__SHIFT)), 0, indirect);
 
-	vcn_v2_5_mc_resume_dpg_mode(adev, inst_idx, indirect);
+	vcn_v2_5_mc_resume_dpg_mode(vinst, indirect);
 
 	WREG32_SOC15_DPG_MODE(inst_idx, SOC15_DPG_MODE_OFFSET(
 		VCN, 0, mmUVD_REG_XX_MASK), 0x10, 0, indirect);
@@ -952,7 +964,7 @@ static int vcn_v2_5_start_dpg_mode(struct amdgpu_device *adev, int inst_idx, boo
 	WREG32_SOC15_DPG_MODE(inst_idx, SOC15_DPG_MODE_OFFSET(
 		VCN, 0, mmUVD_LMI_CTRL2), 0, 0, indirect);
 
-	vcn_v2_6_enable_ras(adev, inst_idx, indirect);
+	vcn_v2_6_enable_ras(vinst, indirect);
 
 	/* unblock VCPU register access */
 	WREG32_SOC15_DPG_MODE(inst_idx, SOC15_DPG_MODE_OFFSET(
@@ -1017,8 +1029,10 @@ static int vcn_v2_5_start_dpg_mode(struct amdgpu_device *adev, int inst_idx, boo
 	return 0;
 }
 
-static int vcn_v2_5_start(struct amdgpu_device *adev, int i)
+static int vcn_v2_5_start(struct amdgpu_vcn_inst *vinst)
 {
+	struct amdgpu_device *adev = vinst->adev;
+	int i = vinst->inst;
 	volatile struct amdgpu_fw_shared *fw_shared =
 		adev->vcn.inst[i].fw_shared.cpu_addr;
 	struct amdgpu_ring *ring;
@@ -1032,7 +1046,7 @@ static int vcn_v2_5_start(struct amdgpu_device *adev, int i)
 		amdgpu_dpm_enable_vcn(adev, true, i);
 
 	if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG)
-		return vcn_v2_5_start_dpg_mode(adev, i, adev->vcn.inst[i].indirect_sram);
+		return vcn_v2_5_start_dpg_mode(vinst, adev->vcn.inst[i].indirect_sram);
 
 	/* disable register anti-hang mechanism */
 	WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_POWER_STATUS), 0,
@@ -1046,7 +1060,7 @@ static int vcn_v2_5_start(struct amdgpu_device *adev, int i)
 		return 0;
 
 	/* SW clock gating */
-	vcn_v2_5_disable_clock_gating(adev, i);
+	vcn_v2_5_disable_clock_gating(vinst);
 
 	/* enable VCPU clock */
 	WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_VCPU_CNTL),
@@ -1091,7 +1105,7 @@ static int vcn_v2_5_start(struct amdgpu_device *adev, int i)
 		      (0x1 << UVD_MPC_SET_MUX__SET_1__SHIFT) |
 		      (0x2 << UVD_MPC_SET_MUX__SET_2__SHIFT)));
 
-	vcn_v2_5_mc_resume(adev, i);
+	vcn_v2_5_mc_resume(vinst);
 
 	/* VCN global tiling registers */
 	WREG32_SOC15(VCN, i, mmUVD_GFX8_ADDR_CONFIG,
@@ -1396,8 +1410,10 @@ static int vcn_v2_5_sriov_start(struct amdgpu_device *adev)
 	return vcn_v2_5_mmsch_start(adev, &adev->virt.mm_table);
 }
 
-static int vcn_v2_5_stop_dpg_mode(struct amdgpu_device *adev, int inst_idx)
+static int vcn_v2_5_stop_dpg_mode(struct amdgpu_vcn_inst *vinst)
 {
+	struct amdgpu_device *adev = vinst->adev;
+	int inst_idx = vinst->inst;
 	uint32_t tmp;
 
 	/* Wait for power status to be 1 */
@@ -1424,15 +1440,17 @@ static int vcn_v2_5_stop_dpg_mode(struct amdgpu_device *adev, int inst_idx)
 	return 0;
 }
 
-static int vcn_v2_5_stop(struct amdgpu_device *adev, int i)
+static int vcn_v2_5_stop(struct amdgpu_vcn_inst *vinst)
 {
+	struct amdgpu_device *adev = vinst->adev;
+	int i = vinst->inst;
 	uint32_t tmp;
 	int r;
 
 	if (adev->vcn.harvest_config & (1 << i))
 		return 0;
 	if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG)
-		return vcn_v2_5_stop_dpg_mode(adev, i);
+		return vcn_v2_5_stop_dpg_mode(vinst);
 
 	/* wait for vcn idle */
 	r = SOC15_WAIT_ON_RREG(VCN, i, mmUVD_STATUS, UVD_STATUS__IDLE, 0x7);
@@ -1475,7 +1493,7 @@ static int vcn_v2_5_stop(struct amdgpu_device *adev, int i)
 	/* clear status */
 	WREG32_SOC15(VCN, i, mmUVD_STATUS, 0);
 
-	vcn_v2_5_enable_clock_gating(adev, i);
+	vcn_v2_5_enable_clock_gating(vinst);
 
 	/* enable register anti-hang mechanism */
 	WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_POWER_STATUS),
@@ -1810,12 +1828,14 @@ static int vcn_v2_5_set_clockgating_state(struct amdgpu_ip_block *ip_block,
 		return 0;
 
 	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
+		struct amdgpu_vcn_inst *vinst = &adev->vcn.inst[i];
+
 		if (enable) {
 			if (!vcn_v2_5_is_idle(adev))
 				return -EBUSY;
-			vcn_v2_5_enable_clock_gating(adev, i);
+			vcn_v2_5_enable_clock_gating(vinst);
 		} else {
-			vcn_v2_5_disable_clock_gating(adev, i);
+			vcn_v2_5_disable_clock_gating(vinst);
 		}
 	}
 
@@ -1827,6 +1847,7 @@ static int vcn_v2_5_set_powergating_state_inst(struct amdgpu_ip_block *ip_block,
 					       int i)
 {
 	struct amdgpu_device *adev = ip_block->adev;
+	struct amdgpu_vcn_inst *vinst = &adev->vcn.inst[i];
 	int ret;
 
 	if (amdgpu_sriov_vf(adev))
@@ -1836,9 +1857,9 @@ static int vcn_v2_5_set_powergating_state_inst(struct amdgpu_ip_block *ip_block,
 		return 0;
 
 	if (state == AMD_PG_STATE_GATE)
-		ret = vcn_v2_5_stop(adev, i);
+		ret = vcn_v2_5_stop(vinst);
 	else
-		ret = vcn_v2_5_start(adev, i);
+		ret = vcn_v2_5_start(vinst);
 
 	if (!ret)
 		adev->vcn.inst[i].cur_state = state;
-- 
2.48.1

