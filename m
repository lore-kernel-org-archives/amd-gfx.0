Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E00F8D3C526
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Dec 2025 07:14:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6C0E510E690;
	Wed, 10 Dec 2025 07:14:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="VFXpY18L";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013062.outbound.protection.outlook.com
 [40.93.201.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 83B8D10E68A
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Dec 2025 07:14:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eyFPdQaVhvjwn6nf9dPGhC+A48272svHoRfOqsc5vcShgvvAizkUvCmEbNTnhrMhFwdzoAXyUCMocxLTZ+Q8ko8fBdrvsAY9HZqcalmuc2i+CwTO4yxlqUt3TFCOGTKUgIjEWq+wvo2e3aCvTV8mN8SjSC5Flye6FcHqd22550IUY1W5IGFcJKBVIkj7v5LWHp3T4w+9QtL6azcQMwcoBSN1jFas+2mQBvVNzdYlcxavv74jTyT+tXry++IkEoobtXYC66bHFTHuokCeQ7nIYLJEvx/5hhxKOuEQqolMb2KqkBI+wpjL1N0Q5yJAoiPzLHQmcObI7k5WEv1EtIYiBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8hN1eUPF0r0TwmNGU1kbhCZ/RpIRO2t+epfu9YB2WKI=;
 b=AI+/X9+lqVsEwU4SvpuExaB5geUyoKHq4hL6zBPfTxODLKD/OgC6Kkd6EJkPpItPVXBeWE2Tj+FFoKLRsqXaME9M/dwKwSS+92Z1rlG4VwupoFXrDG+R1IHC7rJh2yn0kzRjIs5FYNsDhoRpkEz1gydHcQS9ci+QQ0yxdE9NejRyPVWEURtBJkLqq3ECWRKYJ635Bixq+Bf9bVPx7fY6tscJstb1c/viR+1PJZV3Ji04LW+0CNT1dKR7uBjSdc1kBeM2sfT8gKUUmOLgHe4i+rTQ+o1O/rAeuGNMaaHCAoqK3mUqPLPGDMnzaXdbPzwPNFacb1v/AnqdKo59XVNwEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8hN1eUPF0r0TwmNGU1kbhCZ/RpIRO2t+epfu9YB2WKI=;
 b=VFXpY18L7+NF+KvPJLnRpxkGwWa0C4lwVuRCfrb6RADR6Wj9Lp2sMhDoL3YmEQNMEu2kCUQuGZvhfWvkX1KTKKr9qM3OM+vx9F3gw2D5jhpnYNIKBe19k2KSHxvrbYY2REPotc6sjITgtA6JUO40m5jbzpUXfT8ZruGuUEzV+RU=
Received: from SA9PR13CA0041.namprd13.prod.outlook.com (2603:10b6:806:22::16)
 by MN0PR12MB5956.namprd12.prod.outlook.com (2603:10b6:208:37f::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.9; Wed, 10 Dec
 2025 07:14:35 +0000
Received: from SN1PEPF0002529E.namprd05.prod.outlook.com
 (2603:10b6:806:22:cafe::73) by SA9PR13CA0041.outlook.office365.com
 (2603:10b6:806:22::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9412.8 via Frontend Transport; Wed,
 10 Dec 2025 07:14:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF0002529E.mail.protection.outlook.com (10.167.242.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9412.4 via Frontend Transport; Wed, 10 Dec 2025 07:14:35 +0000
Received: from tr4.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 10 Dec
 2025 01:14:32 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Likun Gao <Likun.Gao@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>,
 "Alex Deucher" <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdgpu: Correct xcc_id input to GET_INST from physical to
 logic
Date: Wed, 10 Dec 2025 02:14:05 -0500
Message-ID: <20251210071415.19983-11-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251210071415.19983-1-alexander.deucher@amd.com>
References: <20251210071415.19983-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002529E:EE_|MN0PR12MB5956:EE_
X-MS-Office365-Filtering-Correlation-Id: 711507ec-21e0-4607-d216-08de37bbc60a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?2f9+Sd4uXPfQbiWh7kMECbaTZfpfoBXg+R+VjeGMsUre5BL9e9mOk1tp0z4i?=
 =?us-ascii?Q?9xwkwzCyBNiWChIZxto20cpowEgI6O6gOr2qDEfBMujqMljCvBtFN2j+e+Z8?=
 =?us-ascii?Q?WRbHGblBTmA/AkR/ZER65vTWP54jhrhZavR1QuTMQmzyt16pH+rrHuOO4ecA?=
 =?us-ascii?Q?IbLPpAlEpA9m/iml14MRz/YSnF8qszsSEL7cEfuzcvZRUpFGNW8cF5QAMalJ?=
 =?us-ascii?Q?oGFCsV7oW5TsdVzOiUOdbV+U6YLSPWWvpQGQD+hi80tmTrjFaNhaWPgpM5la?=
 =?us-ascii?Q?TJU7ayvZ5ds+XzE0iXewaKC0kqnj4n8nuCCDVWKwLnZIz6l/WEUThF6eHlo6?=
 =?us-ascii?Q?CR8Y5yAztTlR0rJCS+GrmJpSyhlTaJX7lwj/O0rbcbTaIdIQchZLoZtg7ICS?=
 =?us-ascii?Q?nSe12bzn/iMdXrpAkpzrYbY4CqFqmi2NS/Hl7n+E0oy8u3/tF6V/Nlmvp7ES?=
 =?us-ascii?Q?UAjV3MnQ6f+wcQxPDMdMEoluV7+UEEt0IrmCCCMT0RSVgLkGWWjXbR/wHwyx?=
 =?us-ascii?Q?k40r3Ubjrjr2smDiN80K13ylGDa2vXJkRXcjRuR1CtBCpFr278gREHS5lw5q?=
 =?us-ascii?Q?Wo3z8/6BkOk4IP7r3BoegXBVhP6uFsHUqO7IR9BEQcpDQUv7nuu1BYS29Nw8?=
 =?us-ascii?Q?hvefgMW3gtG5p3q4vgq2lTUBM2WxSBj2/FjO3HXQSrdpaAm7Ftn2enH5OunX?=
 =?us-ascii?Q?It45Rz2QR1YUuYZevHckjcENLTHIhr0Tv2lVwzduJsQOr38NhCEVM+QutYvV?=
 =?us-ascii?Q?R83YU5VfwlcdxmN4B+ZXgyDBQs5DR+zqXm7W+AvMpi5pll36Xr2fC8crsn0U?=
 =?us-ascii?Q?GmenKVHY4ctfiKq8ogQSom24bCck2le/39hT5118HQk8MB2/QRuS4i0A0S8O?=
 =?us-ascii?Q?YAfeErXD11ZRU1thug3VnvEiR/E8FPuEALLO3Iz8q3pgi3nCUvvBUjOtGkkJ?=
 =?us-ascii?Q?spdD0J+MPxZlf97z+VIgPSAkan4N7mASIV56G5+mgwvmfnW4SSbiMNYovD4N?=
 =?us-ascii?Q?35Obcw3PvNRPOTMJZK9HiyoLXfMTz4Pc+LB1Pbj/2UXY9RNBAtFsSEcwlrRe?=
 =?us-ascii?Q?veO+FIUCEV8cIwN2IX1eDXtYc7FJMx5FXXE4sM8YXccCoDdXxVHJ6UWv7B2v?=
 =?us-ascii?Q?lVnx9Lx8XD1ZwGAL+w3YAEAtvT0Yw2nPxd8dvxIfW9ng3x61nL5kEgtDGiXP?=
 =?us-ascii?Q?oSO1NtmGIaI02Y099HCJyCcnhIEIdpgR5nsavDUzz6oEfpCAY2aDT7E6lZvN?=
 =?us-ascii?Q?iM4GEB4WuQCy1jPcRqLLIgNKD21lmbgrJ3hfykhBa5UvFLDsoNvpVNllV9Hy?=
 =?us-ascii?Q?gic7yX7CT+21UTLr+x3fJJcAAu7QMzk0NCXKRmYlaxuKtEeowurQ1Lu9QDaq?=
 =?us-ascii?Q?VIZaRC+rB4fesxEwpAbK2PH0vt71PsH25dzuBDJRhRrp7XjVBp2r0YLcrykb?=
 =?us-ascii?Q?UMqQj+RF2FwGnHyqqFO5tzCgGXmzIc6qbUy7GOxYUJJNeHTR/21Fpx6SP/0l?=
 =?us-ascii?Q?9KLWkliOiPc88MexCI23AfXMHgtIcyVfLnO5hnHqrxvxTSSQrZdSH58sHelw?=
 =?us-ascii?Q?86NBJg737W2tsiCCoCQ=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2025 07:14:35.3557 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 711507ec-21e0-4607-d216-08de37bbc60a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002529E.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5956
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

From: Likun Gao <Likun.Gao@amd.com>

Correct xcc_id input to GET_INST from physical to logic for
gfx_v12_1.

Signed-off-by: Likun Gao <Likun.Gao@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c    |  6 +--
 drivers/gpu/drm/amd/amdgpu/gfxhub_v12_1.c | 53 +++++++++--------------
 drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c    |  2 +-
 3 files changed, 24 insertions(+), 37 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
index 347912596a1b0..2f94c44bd6e11 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
@@ -1935,7 +1935,7 @@ static int gfx_v12_1_xcc_cp_compute_load_microcode_rs64(struct amdgpu_device *ad
 	}
 
 	memcpy(fw_ucode_ptr, fw_ucode, fw_ucode_size);
-	for_each_inst(xcc_id, xcc_mask) {
+	for (xcc_id = 0; xcc_id < NUM_XCC(xcc_mask); xcc_id++) {
 		for (i = 0; i < adev->gfx.mec.num_pipe_per_mec; i++) {
 			u32 offset = (xcc_id * adev->gfx.mec.num_pipe_per_mec + i) *
 				     ALIGN(fw_data_size, 64 * 1024) / 4;
@@ -1948,7 +1948,7 @@ static int gfx_v12_1_xcc_cp_compute_load_microcode_rs64(struct amdgpu_device *ad
 	amdgpu_bo_unreserve(adev->gfx.mec.mec_fw_obj);
 	amdgpu_bo_unreserve(adev->gfx.mec.mec_fw_data_obj);
 
-	for_each_inst(xcc_id, xcc_mask) {
+	for (xcc_id = 0; xcc_id < NUM_XCC(xcc_mask); xcc_id++) {
 		gfx_v12_1_xcc_cp_compute_enable(adev, false, xcc_id);
 
 		tmp = RREG32_SOC15(GC, GET_INST(GC, xcc_id), regCP_CPC_IC_BASE_CNTL);
@@ -2431,7 +2431,7 @@ static int gfx_v12_1_xcc_cp_resume(struct amdgpu_device *adev, uint16_t xcc_mask
 			return r;
 	}
 
-	for_each_inst(xcc_id, xcc_mask) {
+	for (xcc_id = 0; xcc_id < NUM_XCC(xcc_mask); xcc_id++) {
 		if (!(adev->flags & AMD_IS_APU))
 			gfx_v12_1_xcc_enable_gui_idle_interrupt(adev, false, xcc_id);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v12_1.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v12_1.c
index 8f1819d15bc61..662542b9cc362 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v12_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v12_1.c
@@ -65,7 +65,7 @@ static void gfxhub_v12_1_xcc_setup_vm_pt_regs(struct amdgpu_device *adev,
 	struct amdgpu_vmhub *hub;
 	int i;
 
-	for_each_inst(i, xcc_mask) {
+	for (i = 0; i < NUM_XCC(xcc_mask); i++) {
 		hub = &adev->vmhub[AMDGPU_GFXHUB(i)];
 		WREG32_SOC15_OFFSET(GC, GET_INST(GC, i),
 				    regGCVM_CONTEXT0_PAGE_TABLE_BASE_ADDR_LO32,
@@ -83,10 +83,8 @@ static void gfxhub_v12_1_setup_vm_pt_regs(struct amdgpu_device *adev,
 					  uint32_t vmid,
 					  uint64_t page_table_base)
 {
-	uint32_t xcc_mask;
-
-	xcc_mask = GENMASK(NUM_XCC(adev->gfx.xcc_mask) - 1, 0);
-	gfxhub_v12_1_xcc_setup_vm_pt_regs(adev, vmid, page_table_base, xcc_mask);
+	gfxhub_v12_1_xcc_setup_vm_pt_regs(adev, vmid, page_table_base,
+					  adev->gfx.xcc_mask);
 }
 
 static void gfxhub_v12_1_xcc_init_gart_aperture_regs(struct amdgpu_device *adev,
@@ -105,7 +103,7 @@ static void gfxhub_v12_1_xcc_init_gart_aperture_regs(struct amdgpu_device *adev,
 	/* If use GART for FB translation, vmid0 page table covers both
 	 * vram and system memory (gart)
 	 */
-	for_each_inst(i, xcc_mask) {
+	for (i = 0; i < NUM_XCC(xcc_mask); i++) {
 		if (adev->gmc.pdb0_bo) {
 			WREG32_SOC15(GC, GET_INST(GC, i),
 				     regGCVM_CONTEXT0_PAGE_TABLE_START_ADDR_LO32,
@@ -145,7 +143,7 @@ static void gfxhub_v12_1_xcc_init_system_aperture_regs(struct amdgpu_device *ade
 	uint32_t tmp;
 	int i;
 
-	for_each_inst(i, xcc_mask) {
+	for (i = 0; i < NUM_XCC(xcc_mask); i++) {
 		/* Program the AGP BAR */
 		WREG32_SOC15_RLC(GC, GET_INST(GC, i),
 				 regGCMC_VM_AGP_BASE_LO32, 0);
@@ -247,7 +245,7 @@ static void gfxhub_v12_1_xcc_init_tlb_regs(struct amdgpu_device *adev,
 	uint32_t tmp;
 	int i;
 
-	for_each_inst(i, xcc_mask) {
+	for (i = 0; i < NUM_XCC(xcc_mask); i++) {
 		/* Setup TLB control */
 		tmp = RREG32_SOC15(GC, GET_INST(GC, i),
 				   regGCMC_VM_MX_L1_TLB_CNTL);
@@ -282,7 +280,7 @@ static void gfxhub_v12_1_xcc_init_cache_regs(struct amdgpu_device *adev,
 	uint32_t tmp;
 	int i;
 
-	for_each_inst(i, xcc_mask) {
+	for (i = 0; i < NUM_XCC(xcc_mask); i++) {
 		/* Setup L2 cache */
 		tmp = RREG32_SOC15(GC, GET_INST(GC, i), regGCVM_L2_CNTL);
 		tmp = REG_SET_FIELD(tmp, GCVM_L2_CNTL,
@@ -343,7 +341,7 @@ static void gfxhub_v12_1_xcc_enable_system_domain(struct amdgpu_device *adev,
 	uint32_t tmp;
 	int i;
 
-	for_each_inst(i, xcc_mask) {
+	for (i = 0; i < NUM_XCC(xcc_mask); i++) {
 		tmp = RREG32_SOC15(GC, GET_INST(GC, i),
 				   regGCVM_CONTEXT0_CNTL);
 		tmp = REG_SET_FIELD(tmp, GCVM_CONTEXT0_CNTL,
@@ -366,7 +364,7 @@ static void gfxhub_v12_1_xcc_disable_identity_aperture(struct amdgpu_device *ade
 {
 	int i;
 
-	for_each_inst(i, xcc_mask) {
+	for (i = 0; i < NUM_XCC(xcc_mask); i++) {
 		WREG32_SOC15(GC, GET_INST(GC, i),
 			     regGCVM_L2_CONTEXT1_IDENTITY_APERTURE_LOW_ADDR_LO32,
 			     0XFFFFFFFF);
@@ -402,7 +400,7 @@ static void gfxhub_v12_1_xcc_setup_vmid_config(struct amdgpu_device *adev,
 	block_size = adev->vm_manager.block_size;
 	block_size -= 9;
 
-	for_each_inst(j, xcc_mask) {
+	for (j = 0; j < NUM_XCC(xcc_mask); j++) {
 		hub = &adev->vmhub[AMDGPU_GFXHUB(j)];
 		for (i = 0; i <= 14; i++) {
 			tmp = RREG32_SOC15_OFFSET(GC, GET_INST(GC, j),
@@ -460,7 +458,7 @@ static void gfxhub_v12_1_xcc_program_invalidation(struct amdgpu_device *adev,
 	struct amdgpu_vmhub *hub;
 	unsigned int i, j;
 
-	for_each_inst(j, xcc_mask) {
+	for (j = 0; j < NUM_XCC(xcc_mask); j++) {
 		hub = &adev->vmhub[AMDGPU_GFXHUB(j)];
 
 		for (i = 0 ; i < 18; ++i) {
@@ -483,7 +481,7 @@ static int gfxhub_v12_1_xcc_gart_enable(struct amdgpu_device *adev,
 		/* GCMC_VM_FB_LOCATION_BASE/TOP are VF copy registers
 		 * VBIO post does not program them at boot up phase
 		 * Need driver to program them from guest side */
-		for_each_inst(i, xcc_mask) {
+		for (i = 0; i < NUM_XCC(xcc_mask); i++) {
 			WREG32_SOC15(GC, GET_INST(GC, i),
 				     regGCMC_VM_FB_LOCATION_BASE_LO32,
 				     lower_32_bits(adev->gmc.vram_start >> 24));
@@ -516,10 +514,8 @@ static int gfxhub_v12_1_xcc_gart_enable(struct amdgpu_device *adev,
 
 static int gfxhub_v12_1_gart_enable(struct amdgpu_device *adev)
 {
-	uint32_t xcc_mask;
-
-	xcc_mask = GENMASK(NUM_XCC(adev->gfx.xcc_mask) - 1, 0);
-	return gfxhub_v12_1_xcc_gart_enable(adev, xcc_mask);
+	return gfxhub_v12_1_xcc_gart_enable(adev,
+					    adev->gfx.xcc_mask);
 }
 
 static void gfxhub_v12_1_xcc_gart_disable(struct amdgpu_device *adev,
@@ -529,7 +525,7 @@ static void gfxhub_v12_1_xcc_gart_disable(struct amdgpu_device *adev,
 	u32 tmp;
 	u32 i, j;
 
-	for_each_inst(j, xcc_mask) {
+	for (j = 0; j < NUM_XCC(xcc_mask); j++) {
 		hub = &adev->vmhub[AMDGPU_GFXHUB(j)];
 		/* Disable all tables */
 		for (i = 0; i < 16; i++)
@@ -559,10 +555,7 @@ static void gfxhub_v12_1_xcc_gart_disable(struct amdgpu_device *adev,
 
 static void gfxhub_v12_1_gart_disable(struct amdgpu_device *adev)
 {
-	uint32_t xcc_mask;
-
-	xcc_mask = GENMASK(NUM_XCC(adev->gfx.xcc_mask) - 1, 0);
-	gfxhub_v12_1_xcc_gart_disable(adev, xcc_mask);
+	gfxhub_v12_1_xcc_gart_disable(adev, adev->gfx.xcc_mask);
 }
 
 static void gfxhub_v12_1_xcc_set_fault_enable_default(struct amdgpu_device *adev,
@@ -571,7 +564,7 @@ static void gfxhub_v12_1_xcc_set_fault_enable_default(struct amdgpu_device *adev
 	u32 tmp;
 	int i;
 
-	for_each_inst(i, xcc_mask) {
+	for (i = 0; i < NUM_XCC(xcc_mask); i++) {
 		tmp = RREG32_SOC15(GC, GET_INST(GC, i),
 				   regGCVM_L2_PROTECTION_FAULT_CNTL_LO32);
 		tmp = REG_SET_FIELD(tmp,
@@ -644,10 +637,7 @@ static void gfxhub_v12_1_xcc_set_fault_enable_default(struct amdgpu_device *adev
 static void gfxhub_v12_1_set_fault_enable_default(struct amdgpu_device *adev,
 						  bool value)
 {
-	uint32_t xcc_mask;
-
-	xcc_mask = GENMASK(NUM_XCC(adev->gfx.xcc_mask) - 1, 0);
-	gfxhub_v12_1_xcc_set_fault_enable_default(adev, value, xcc_mask);
+	gfxhub_v12_1_xcc_set_fault_enable_default(adev, value, adev->gfx.xcc_mask);
 }
 
 static uint32_t gfxhub_v12_1_get_invalidate_req(unsigned int vmid,
@@ -744,7 +734,7 @@ static void gfxhub_v12_1_xcc_init(struct amdgpu_device *adev, uint32_t xcc_mask)
 	struct amdgpu_vmhub *hub;
 	int i;
 
-	for_each_inst(i, xcc_mask) {
+	for (i = 0; i < NUM_XCC(xcc_mask); i++) {
 		hub = &adev->vmhub[AMDGPU_GFXHUB(i)];
 
 		hub->ctx0_ptb_addr_lo32 =
@@ -800,10 +790,7 @@ static void gfxhub_v12_1_xcc_init(struct amdgpu_device *adev, uint32_t xcc_mask)
 
 static void gfxhub_v12_1_init(struct amdgpu_device *adev)
 {
-	uint32_t xcc_mask;
-
-	xcc_mask = GENMASK(NUM_XCC(adev->gfx.xcc_mask) - 1, 0);
-	gfxhub_v12_1_xcc_init(adev, xcc_mask);
+	gfxhub_v12_1_xcc_init(adev, adev->gfx.xcc_mask);
 }
 
 static int gfxhub_v12_1_get_xgmi_info(struct amdgpu_device *adev)
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c b/drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c
index 28b3732df016a..061d1be723408 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c
@@ -319,7 +319,7 @@ static void gmc_v12_1_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
 		u32 ack = hub->vm_inv_eng0_ack + hub->eng_distance * eng;
 
 		amdgpu_gmc_fw_reg_write_reg_wait(adev, req, ack, inv_req,
-				1 << vmid, GET_INST(GC, 0));
+				1 << vmid, 0);
 		return;
 	}
 
-- 
2.52.0

