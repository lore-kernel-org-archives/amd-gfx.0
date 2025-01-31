Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85C65C02190
	for <amd-gfx@archiver.kernel.org>; Fri, 31 Jan 2025 16:58:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2A96910E3C8;
	Fri, 31 Jan 2025 16:58:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="37w8TAsP";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2054.outbound.protection.outlook.com [40.107.223.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7F56210E3B1
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 Jan 2025 16:58:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Pcq7GNejnlyVjMLncgB8VxKDhK4uV7GlFDNjObbO7u4IE2zltNp8CserSjXk7jFTr5GE5sr6BWVfzlNcW0tdjV1HZJrbfj269Ff+1+zgTiWdDWI4FDRIORmaCtvlCUKZ1ZdeTsc4P7/kZTITJwadozUGRwp4VSaEqubPrkwknIMTrF88QeA4Tx3BFwnIy98T4dpWaeHA2bJG32C7UlzBtRIoLDWPY/baXJDTnDws/bo/03AQ9OthZKdN0i7qSlKRNmuxSINDs2dmtsIrFOSjhrWO4pPYd5NKTEfbnAvb2vDSKjEvq/4Q8Kf9eJraiAs9YDbIN/PJ/Brq7kLQ2xI9uA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hufe6ej4aqF/ZMUAjuy/G932mDsTsOm8ylYPeTGx5nU=;
 b=ZcCKMO/QZYebHsp19jW+WIKv2p/IXdgRRhhD+E3TBCHvqaV4hhSIGYJhg8kDhjch7irVtf8h15Ktj+8zHLwDGXblfdzF4gc8TIRHh0ROe8EUAowsI3v2hCZeNLvVPw7o1nj6hPVQpW1R7ZxEx3zClliFUaLh8zElu51vV37kzg82sBdqUaJKfnA5nUK9ucr13jn+BF0noQmHVDRRsj2LXwzbBbj1x+klYSY7kZH0pkWD+Vkctk40gzRjEOGyvCtafJLo5SkQlMIj9cDxEBLsN6YN2KCjgz5KpWiD+vs15x0C4qG3yqMwRx9mzsIEJlXMHEgyfV3BWqPqkNmjYFdhMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hufe6ej4aqF/ZMUAjuy/G932mDsTsOm8ylYPeTGx5nU=;
 b=37w8TAsPHZwP9AIrmBwfxEp5cHpdfUvlGds6r7g/qzO0BwwgYFOzNkpjqk+3r9b1zoLZ8gugetMpJNagaDSWCbXsULzH+n+WGYAehVvq0jy8ix9bqXEAYjLQKBJ7a7zS01f4QjyNuaxGiTKzGCGnPD91THuwGk4EASoQT5xqEwk=
Received: from DM6PR07CA0079.namprd07.prod.outlook.com (2603:10b6:5:337::12)
 by IA0PR12MB8326.namprd12.prod.outlook.com (2603:10b6:208:40d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.20; Fri, 31 Jan
 2025 16:58:14 +0000
Received: from DS2PEPF0000343C.namprd02.prod.outlook.com
 (2603:10b6:5:337:cafe::63) by DM6PR07CA0079.outlook.office365.com
 (2603:10b6:5:337::12) with Microsoft SMTP Server (version=TLS1_3,
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
 15.20.8398.14 via Frontend Transport; Fri, 31 Jan 2025 16:58:13 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 31 Jan
 2025 10:58:08 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 14/44] drm/amdgpu/vcn2.0: convert internal functions to use
 vcn_inst
Date: Fri, 31 Jan 2025 11:57:10 -0500
Message-ID: <20250131165741.1798488-15-alexander.deucher@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343C:EE_|IA0PR12MB8326:EE_
X-MS-Office365-Filtering-Correlation-Id: 64f9d411-e00e-47f3-5017-08dd42187379
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?TQkdRjMTC4tvwuDPoQMisNw2LSuQvHfKvYMNY/2pfxwv3XRPwqfTU8p0Y8q6?=
 =?us-ascii?Q?V9GbdtxaC9MQDSoJ6WYeoqFV3FaOtR2+lngUXiStd7N/kBNQK3E0+0zD4eza?=
 =?us-ascii?Q?ughqjuU7KXbTtNTFXx5wkJ3JC0ubohYbBS3ZOxXLvX9Em1FEvKykr62vI3j+?=
 =?us-ascii?Q?8b0L6uB7GqYThC6zj/Y8wJwo5J9oR/kvqhzR5gUuPkLP8ASr9g+xSUYS0ku8?=
 =?us-ascii?Q?Xkvv6+OrWAqEpT4rsApSihjW1zXl46AO14PiqNd3sLBqVs6CAcLaRhCJW2fb?=
 =?us-ascii?Q?avnkQG0Ay7zhmVgFHZleOkB7DBFr3fMEyKYLikKiHwI+nzUxxcbV0u/DlUKI?=
 =?us-ascii?Q?SWPVa3dY41euvxPmiYyWe/6jGB4CKdvXUuIqDVxKHJAeErGF3xJSWzfsaul2?=
 =?us-ascii?Q?QNDTg+2QCK7RtQqG3cxM9LmiBEnLEvG0CUyU7WtrqVQD6cl7eLp/gChDBDtB?=
 =?us-ascii?Q?rt+h8InBekVDtB7EcEmrKqcs2qA4hl3ofqFE/6yRiL4BeSIR4ZNWxNpXe+ST?=
 =?us-ascii?Q?iAgJoCZ51hF0vLHxSt9VokM2ZYSg+g5IdIZzy0tfAL5y7SY+pZl064sSw/B8?=
 =?us-ascii?Q?a1jABfk1n1HV3vXbWLNFCs98nga3PxrIUkLM2TXsCzAzKN5+XMuNLWRYteKk?=
 =?us-ascii?Q?ou4Ptl85Yfkmy5kplh4s2yxVUC4BClqkiJZzsDAOtuT2WEB27FdeQBlxMXGf?=
 =?us-ascii?Q?g5ksEIzS7sRAAtEu+RyWBpJKESLQ2JHNzFUMrh80OAM46CGRP4USKM0TVCb/?=
 =?us-ascii?Q?4KvPS2ep87GI1XXNWc87VWBttvsPMashlCccj40ZPoKOEdkFomnPooqF01oU?=
 =?us-ascii?Q?lIqZpdRXV3P/MRa4IY3C1uovQIP8u7/v5jNvibqqtbeC+2fm11wSzwC6HirR?=
 =?us-ascii?Q?RCntunZGFzumKhhjKE+uBf64ucK1niHDLHPOcfnZsMI5KVDlBlAUS0QJBg37?=
 =?us-ascii?Q?iZIpzQ7HTFhufF+xKOxS4bJpOjveNwzj3ZYfRlRusNMXMDguq8bJwWAkLk4y?=
 =?us-ascii?Q?g3vCChaIT9uqGmfaperT0dcFRN3Y0FVxhbm6zSXziZKpjiOd6Ddrwk1BZIv/?=
 =?us-ascii?Q?QXcCkftXJOyKWF3n1XbVQhzVbekxkDU/UAn9FjvwouJGE423Yku8ga2sjkdQ?=
 =?us-ascii?Q?ZeMjnd8hQ+PKJVCXkM0vgk+Q2UCzOgYDAvPhEkaRPbAtLcuhqt3WYyLzI6SY?=
 =?us-ascii?Q?IEM68wGrVL+i+2Qu0kjTLjO3Pa/SLlEqwjd6kH4v3hc6IYbIR8f6cMSmuLI4?=
 =?us-ascii?Q?5dAnnQv41KJGSITa7PpQNYciD2lmwVK+BCl7Ysmar0Tz4C1EY2kgGQeEvedo?=
 =?us-ascii?Q?EovxGVbQoyz0jLfKxa5T0ME9UK6CYDZ4uzcbOUTdG10baMFpfhve7xgrQEM1?=
 =?us-ascii?Q?9yhYgvHUnqIuEUFISpp7rwRo0f1ezIzUkIhva8hMLFiQIaltPjh4VEIY0sfg?=
 =?us-ascii?Q?qB9PfuhRJ+QuuOJ2ZwxqNJ1f/k8iC3ZhPdy8jUNbzMROcCnrq0OcuA=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2025 16:58:13.9363 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 64f9d411-e00e-47f3-5017-08dd42187379
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF0000343C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8326
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

v2: index instances directly on vcn1.0 and 2.0 to make
it clear that they only support a single instance (Lijo)

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c | 66 ++++++++++++++++-----------
 1 file changed, 39 insertions(+), 27 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
index 8ff5a9d67cbd2..aa61d3b54f8c2 100644
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
+		vcn_v2_0_enable_clock_gating(&adev->vcn.inst[0]);
 	} else {
 		/* disable HW gating and enable Sw gating */
-		vcn_v2_0_disable_clock_gating(adev);
+		vcn_v2_0_disable_clock_gating(&adev->vcn.inst[0]);
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
 		adev->vcn.inst[0].cur_state = state;
-- 
2.48.1

