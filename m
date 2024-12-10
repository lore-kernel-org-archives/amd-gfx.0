Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A958EE77185
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Dec 2024 22:54:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4B68A10E9DA;
	Tue, 10 Dec 2024 22:54:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="GMFzhfR4";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2088.outbound.protection.outlook.com [40.107.92.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 82F7A10E9DA
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Dec 2024 22:54:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jb2T2hrB8lkPdrI+5/R3Xx8ozG2SsWKmhN7GeiZ6pbI9iRkTkMlx12U0gKdsYKiLJt988W1QcnDSVIgbG6WjfHEjJs6tZ0hSSpBPsbKM34XaaylcMoD3Y7S7sLfrWOToL5lbxC5OneNFywwuatQnoSNdq5q9241cR+cbY4mfO0WDdux1kTjSYYJSmCC4Y4mqlJ99ye8pl6Fo9P4e7/SLH09bZ1VFl03L7tLCGpMJPMN6RaKfCeSV/ZEEySLq8gLqy/ZqRGJp0Ih3VHUyYInbfZ/yXZnEROcBBuYuoazcS6HmG4CY4SBD4qo09ISePrYEjXAp0mxIAxjCQKZbkirpHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dEQr9TYxrnAvU671ahvjALCw9XvbcmimYNVVeI7NQNM=;
 b=IB8TEe6lSRr3MSOAry3E+xzCLj8l9VMdSR6n3CDOvGlZDzO/RcLMpLn21RUVMfyr1phvBpqV27bBJ1MA9BBgQhA+mRxlCvGEmIgzpHHWqt9EJTcnDGzQ17X70jurV7p9eLfSUCTPU+E/UCaXYJ9gaW2RUftQOnCTs4M1oNlF2aXAaubyV50/lIdKyIcg4P3SGzjbIvBuPxNXV1RODywPyxbXuxmd6lRagge9ztrdNmtfKdLoNAdR84sJ9QBD88YpV3qO6ZzX7Hk2Iyh/TjlKNsKDm7BRtpvj7ysSnuGiIQoZFK05W+2vt2Ai338zLdNUPMOgWAk39K0Jawp/9njjFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dEQr9TYxrnAvU671ahvjALCw9XvbcmimYNVVeI7NQNM=;
 b=GMFzhfR4dJoRnOKV2gZ7lD+IftHMa5mC/yBTDUDoy6n8yKB4Cf3O8p6m7AXrk7nek4LAQM5f7S7lgqWUN4lgphaPqaqw6TnDiMwtWw3qXlrJV1V/2Sks/qXWZybgjmn3t03eGeYadUN38LLr+EeGNbZ18BibFc509DWUVd8x+Ok=
Received: from BN9PR03CA0216.namprd03.prod.outlook.com (2603:10b6:408:f8::11)
 by SA1PR12MB6774.namprd12.prod.outlook.com (2603:10b6:806:259::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.11; Tue, 10 Dec
 2024 22:54:03 +0000
Received: from BN2PEPF000055DA.namprd21.prod.outlook.com
 (2603:10b6:408:f8:cafe::37) by BN9PR03CA0216.outlook.office365.com
 (2603:10b6:408:f8::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8230.12 via Frontend Transport; Tue,
 10 Dec 2024 22:54:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000055DA.mail.protection.outlook.com (10.167.245.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8272.0 via Frontend Transport; Tue, 10 Dec 2024 22:54:03 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 10 Dec
 2024 16:53:59 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 14/48] drm/amdgpu/vcn2.0: convert internal functions to use
 vcn_inst
Date: Tue, 10 Dec 2024 17:53:03 -0500
Message-ID: <20241210225337.75394-15-alexander.deucher@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF000055DA:EE_|SA1PR12MB6774:EE_
X-MS-Office365-Filtering-Correlation-Id: 7682a11e-1759-4cfa-0196-08dd196d8b04
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?WcwSmpxhJoy8YT/LKDzaa4Tf545yDot6Iug1jwWP5RyuqLVEvmCh3z7jaxXd?=
 =?us-ascii?Q?3YFiMAX8cRkfvDNy8iqs9SsDWbuH0yfsoX1vgBvQ/Z4IxlKogcR95zGfDV5W?=
 =?us-ascii?Q?iq/oOfvanp4U5IwmBkhngYiKxekV2w4uLeAmJFoSlNm+a/7vLyJ1vqhkzD+o?=
 =?us-ascii?Q?uzcgZdSIoBJwo3PIcmzbZOt4B2LHpwaR0AlIvY05s3XPhvkPTC7nbSX32IEY?=
 =?us-ascii?Q?bJxutH8yMRIzUuCPMw/YOVI/GHbD/jJRyL4/jbDLYBt4zzg5S9/DuIY/WyNR?=
 =?us-ascii?Q?VH6zt++EwAimRON4shfwytzYLYbXUeK3gj4RrQ+E67nY+My3G8lGsyGQFkme?=
 =?us-ascii?Q?3FxK96oIP+JksW6PGCjguBrNEwwZO8PqL4umBWs2/OvAaliXya06LAULMc7p?=
 =?us-ascii?Q?Z1MW1qTCwUiDAfV2N0eQFMW9zsUesEbqXLmSTSNkp77/KPMEIxYaXjP7ezFs?=
 =?us-ascii?Q?iW0idNVZKfjl3KZAEgxm0kDIp19TodkZqqDhkUOIoX+xOaq8dZ+lH0tTDeAh?=
 =?us-ascii?Q?PCZMhyvXwtIJxEhpidauHOBe9qK9SgyNfAw7V0A1Q4lhGzwh6cpN+BKrthZ3?=
 =?us-ascii?Q?ZjMa3+R7AiRd8q5aT0w/6Uv4juH7Rq8TgV5LXgvA9SIAI6IOmUqDtRZMqCGX?=
 =?us-ascii?Q?tjWD3CYjPWhoSfbBn2mue0A/32derG0NVOaLlVFm16zR/fKpfatJK7GAjiRy?=
 =?us-ascii?Q?7YqPi3hOVfFVVFz6Ov3Mk0a+g9iePaKsydiQw13T8k1fWVE4yGgjJasysdfK?=
 =?us-ascii?Q?jkppBrdcRMxG0wh869MoA4dhOTDmPNi2OGt7eru5RHGZwi1dkk4Vggp9IbAz?=
 =?us-ascii?Q?Y4abQ+4LZY1BcNtwgDcdsAMS6w+fjvMFSYJyzGCMc4dTUPMeT6W/dlOfJAXV?=
 =?us-ascii?Q?XI+J75PW3fpC5BU4tCVz6Q4+59oRjOyIWBeWPt82AGKsk6Hy+MD4QCbXaZG7?=
 =?us-ascii?Q?Avaet33GAriJe+LuifbdDN4JEusMNvaJ+S8NYVqfxIxhV0/dmcF5QtTf2KUv?=
 =?us-ascii?Q?yNFmgZdrJkDB/WHconAlC//68x5mfJz0ypSJZuyxnz3YfurW8r3TKtfDYnTX?=
 =?us-ascii?Q?39Q6oMFHiOBkeuhwyIQ41gDuzHy22DUNmIyyUFslTeMwCcm/f4UxvZ4ke3mF?=
 =?us-ascii?Q?dh63Oru4YD2VJYSzOKyjukOKeSXBLqxPXyIZ45T7cnTRspeNfChVEjVm19v2?=
 =?us-ascii?Q?fN73HzxnGcOliuALZbqkLJ/A/w81jTW/rnfU1H2nGn3aOn4ZQp6INCyGCneP?=
 =?us-ascii?Q?xkGbpSfwalSqvSh9aw75F7ZfW0CkluSCrzBf8f9z1yTjf12+BIh2DWCLjpSQ?=
 =?us-ascii?Q?ELj6MzXxm3qq92dMUGSVmN+6698Hg81uVxFsh0t4ig0HUpsNZhAPes7OLieG?=
 =?us-ascii?Q?fEqqKnB32U9nJ5lsksoTwwuiLns+/AGd+7AoI6edQxshd6biug=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2024 22:54:03.0278 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7682a11e-1759-4cfa-0196-08dd196d8b04
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000055DA.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6774
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
 drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c | 66 ++++++++++++++++-----------
 1 file changed, 39 insertions(+), 27 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
index 3902e0d239d8d..b42b369a386da 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
@@ -370,8 +370,9 @@ static int vcn_v2_0_resume(struct amdgpu_ip_block *ip_block)
  *
  * Let the VCN memory controller know it's offsets
  */
-static void vcn_v2_0_mc_resume(struct amdgpu_device *adev)
+static void vcn_v2_0_mc_resume(struct amdgpu_vcn_inst *vinst)
 {
+	struct amdgpu_device *adev = vinst->adev;
 	uint32_t size = AMDGPU_GPU_PAGE_ALIGN(adev->vcn.inst[0].fw->size + 4);
 	uint32_t offset;
 
@@ -426,8 +427,10 @@ static void vcn_v2_0_mc_resume(struct amdgpu_device *adev)
 	WREG32_SOC15(UVD, 0, mmUVD_GFX10_ADDR_CONFIG, adev->gfx.config.gb_addr_config);
 }
 
-static void vcn_v2_0_mc_resume_dpg_mode(struct amdgpu_device *adev, bool indirect)
+static void vcn_v2_0_mc_resume_dpg_mode(struct amdgpu_vcn_inst *vinst,
+					bool indirect)
 {
+	struct amdgpu_device *adev = vinst->adev;
 	uint32_t size = AMDGPU_GPU_PAGE_ALIGN(adev->vcn.inst[0].fw->size + 4);
 	uint32_t offset;
 
@@ -525,12 +528,13 @@ static void vcn_v2_0_mc_resume_dpg_mode(struct amdgpu_device *adev, bool indirec
 /**
  * vcn_v2_0_disable_clock_gating - disable VCN clock gating
  *
- * @adev: amdgpu_device pointer
+ * @vinst: VCN instance
  *
  * Disable clock gating for VCN block
  */
-static void vcn_v2_0_disable_clock_gating(struct amdgpu_device *adev)
+static void vcn_v2_0_disable_clock_gating(struct amdgpu_vcn_inst *vinst)
 {
+	struct amdgpu_device *adev = vinst->adev;
 	uint32_t data;
 
 	if (amdgpu_sriov_vf(adev))
@@ -634,9 +638,10 @@ static void vcn_v2_0_disable_clock_gating(struct amdgpu_device *adev)
 	WREG32_SOC15(VCN, 0, mmUVD_SUVD_CGC_CTRL, data);
 }
 
-static void vcn_v2_0_clock_gating_dpg_mode(struct amdgpu_device *adev,
+static void vcn_v2_0_clock_gating_dpg_mode(struct amdgpu_vcn_inst *vinst,
 		uint8_t sram_sel, uint8_t indirect)
 {
+	struct amdgpu_device *adev = vinst->adev;
 	uint32_t reg_data = 0;
 
 	/* enable sw clock gating control */
@@ -685,12 +690,13 @@ static void vcn_v2_0_clock_gating_dpg_mode(struct amdgpu_device *adev,
 /**
  * vcn_v2_0_enable_clock_gating - enable VCN clock gating
  *
- * @adev: amdgpu_device pointer
+ * @vinst: VCN instance
  *
  * Enable clock gating for VCN block
  */
-static void vcn_v2_0_enable_clock_gating(struct amdgpu_device *adev)
+static void vcn_v2_0_enable_clock_gating(struct amdgpu_vcn_inst *vinst)
 {
+	struct amdgpu_device *adev = vinst->adev;
 	uint32_t data = 0;
 
 	if (amdgpu_sriov_vf(adev))
@@ -743,8 +749,9 @@ static void vcn_v2_0_enable_clock_gating(struct amdgpu_device *adev)
 	WREG32_SOC15(VCN, 0, mmUVD_SUVD_CGC_CTRL, data);
 }
 
-static void vcn_v2_0_disable_static_power_gating(struct amdgpu_device *adev)
+static void vcn_v2_0_disable_static_power_gating(struct amdgpu_vcn_inst *vinst)
 {
+	struct amdgpu_device *adev = vinst->adev;
 	uint32_t data = 0;
 
 	if (amdgpu_sriov_vf(adev))
@@ -792,8 +799,9 @@ static void vcn_v2_0_disable_static_power_gating(struct amdgpu_device *adev)
 	WREG32_SOC15(VCN, 0, mmUVD_POWER_STATUS, data);
 }
 
-static void vcn_v2_0_enable_static_power_gating(struct amdgpu_device *adev)
+static void vcn_v2_0_enable_static_power_gating(struct amdgpu_vcn_inst *vinst)
 {
+	struct amdgpu_device *adev = vinst->adev;
 	uint32_t data = 0;
 
 	if (amdgpu_sriov_vf(adev))
@@ -834,13 +842,14 @@ static void vcn_v2_0_enable_static_power_gating(struct amdgpu_device *adev)
 	}
 }
 
-static int vcn_v2_0_start_dpg_mode(struct amdgpu_device *adev, bool indirect)
+static int vcn_v2_0_start_dpg_mode(struct amdgpu_vcn_inst *vinst, bool indirect)
 {
+	struct amdgpu_device *adev = vinst->adev;
 	volatile struct amdgpu_fw_shared *fw_shared = adev->vcn.inst->fw_shared.cpu_addr;
 	struct amdgpu_ring *ring = &adev->vcn.inst->ring_dec;
 	uint32_t rb_bufsz, tmp;
 
-	vcn_v2_0_enable_static_power_gating(adev);
+	vcn_v2_0_enable_static_power_gating(vinst);
 
 	/* enable dynamic power gating mode */
 	tmp = RREG32_SOC15(UVD, 0, mmUVD_POWER_STATUS);
@@ -852,7 +861,7 @@ static int vcn_v2_0_start_dpg_mode(struct amdgpu_device *adev, bool indirect)
 		adev->vcn.inst->dpg_sram_curr_addr = (uint32_t *)adev->vcn.inst->dpg_sram_cpu_addr;
 
 	/* enable clock gating */
-	vcn_v2_0_clock_gating_dpg_mode(adev, 0, indirect);
+	vcn_v2_0_clock_gating_dpg_mode(vinst, 0, indirect);
 
 	/* enable VCPU clock */
 	tmp = (0xFF << UVD_VCPU_CNTL__PRB_TIMEOUT_VAL__SHIFT);
@@ -901,7 +910,7 @@ static int vcn_v2_0_start_dpg_mode(struct amdgpu_device *adev, bool indirect)
 		 (0x1 << UVD_MPC_SET_MUX__SET_1__SHIFT) |
 		 (0x2 << UVD_MPC_SET_MUX__SET_2__SHIFT)), 0, indirect);
 
-	vcn_v2_0_mc_resume_dpg_mode(adev, indirect);
+	vcn_v2_0_mc_resume_dpg_mode(vinst, indirect);
 
 	WREG32_SOC15_DPG_MODE(0, SOC15_DPG_MODE_OFFSET(
 		UVD, 0, mmUVD_REG_XX_MASK), 0x10, 0, indirect);
@@ -969,8 +978,9 @@ static int vcn_v2_0_start_dpg_mode(struct amdgpu_device *adev, bool indirect)
 	return 0;
 }
 
-static int vcn_v2_0_start(struct amdgpu_device *adev)
+static int vcn_v2_0_start(struct amdgpu_vcn_inst *vinst)
 {
+	struct amdgpu_device *adev = vinst->adev;
 	volatile struct amdgpu_fw_shared *fw_shared = adev->vcn.inst->fw_shared.cpu_addr;
 	struct amdgpu_ring *ring = &adev->vcn.inst->ring_dec;
 	uint32_t rb_bufsz, tmp;
@@ -981,16 +991,16 @@ static int vcn_v2_0_start(struct amdgpu_device *adev)
 		amdgpu_dpm_enable_vcn(adev, true, 0);
 
 	if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG)
-		return vcn_v2_0_start_dpg_mode(adev, adev->vcn.inst->indirect_sram);
+		return vcn_v2_0_start_dpg_mode(vinst, adev->vcn.inst->indirect_sram);
 
-	vcn_v2_0_disable_static_power_gating(adev);
+	vcn_v2_0_disable_static_power_gating(vinst);
 
 	/* set uvd status busy */
 	tmp = RREG32_SOC15(UVD, 0, mmUVD_STATUS) | UVD_STATUS__UVD_BUSY;
 	WREG32_SOC15(UVD, 0, mmUVD_STATUS, tmp);
 
 	/*SW clock gating */
-	vcn_v2_0_disable_clock_gating(adev);
+	vcn_v2_0_disable_clock_gating(vinst);
 
 	/* enable VCPU clock */
 	WREG32_P(SOC15_REG_OFFSET(UVD, 0, mmUVD_VCPU_CNTL),
@@ -1034,7 +1044,7 @@ static int vcn_v2_0_start(struct amdgpu_device *adev)
 		(0x1 << UVD_MPC_SET_MUX__SET_1__SHIFT) |
 		(0x2 << UVD_MPC_SET_MUX__SET_2__SHIFT)));
 
-	vcn_v2_0_mc_resume(adev);
+	vcn_v2_0_mc_resume(vinst);
 
 	/* release VCPU reset to boot */
 	WREG32_P(SOC15_REG_OFFSET(UVD, 0, mmUVD_SOFT_RESET), 0,
@@ -1142,8 +1152,9 @@ static int vcn_v2_0_start(struct amdgpu_device *adev)
 	return 0;
 }
 
-static int vcn_v2_0_stop_dpg_mode(struct amdgpu_device *adev)
+static int vcn_v2_0_stop_dpg_mode(struct amdgpu_vcn_inst *vinst)
 {
+	struct amdgpu_device *adev = vinst->adev;
 	struct dpg_pause_state state = {.fw_based = VCN_DPG_STATE__UNPAUSE};
 	uint32_t tmp;
 
@@ -1172,13 +1183,14 @@ static int vcn_v2_0_stop_dpg_mode(struct amdgpu_device *adev)
 	return 0;
 }
 
-static int vcn_v2_0_stop(struct amdgpu_device *adev)
+static int vcn_v2_0_stop(struct amdgpu_vcn_inst *vinst)
 {
+	struct amdgpu_device *adev = vinst->adev;
 	uint32_t tmp;
 	int r;
 
 	if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) {
-		r = vcn_v2_0_stop_dpg_mode(adev);
+		r = vcn_v2_0_stop_dpg_mode(vinst);
 		if (r)
 			return r;
 		goto power_off;
@@ -1230,8 +1242,8 @@ static int vcn_v2_0_stop(struct amdgpu_device *adev)
 	/* clear status */
 	WREG32_SOC15(VCN, 0, mmUVD_STATUS, 0);
 
-	vcn_v2_0_enable_clock_gating(adev);
-	vcn_v2_0_enable_static_power_gating(adev);
+	vcn_v2_0_enable_clock_gating(vinst);
+	vcn_v2_0_enable_static_power_gating(vinst);
 
 power_off:
 	if (adev->pm.dpm_enabled)
@@ -1348,10 +1360,10 @@ static int vcn_v2_0_set_clockgating_state(struct amdgpu_ip_block *ip_block,
 		/* wait for STATUS to clear */
 		if (!vcn_v2_0_is_idle(adev))
 			return -EBUSY;
-		vcn_v2_0_enable_clock_gating(adev);
+		vcn_v2_0_enable_clock_gating(adev->vcn.inst);
 	} else {
 		/* disable HW gating and enable Sw gating */
-		vcn_v2_0_disable_clock_gating(adev);
+		vcn_v2_0_disable_clock_gating(adev->vcn.inst);
 	}
 	return 0;
 }
@@ -1818,9 +1830,9 @@ static int vcn_v2_0_set_powergating_state(struct amdgpu_ip_block *ip_block,
 		return 0;
 
 	if (state == AMD_PG_STATE_GATE)
-		ret = vcn_v2_0_stop(adev);
+		ret = vcn_v2_0_stop(adev->vcn.inst);
 	else
-		ret = vcn_v2_0_start(adev);
+		ret = vcn_v2_0_start(adev->vcn.inst);
 
 	if (!ret)
 		adev->vcn.inst->cur_state = state;
-- 
2.47.1

