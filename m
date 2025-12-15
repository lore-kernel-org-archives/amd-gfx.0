Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 744A9D5B863
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Dec 2025 18:16:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 11C7F10E4C4;
	Mon, 15 Dec 2025 18:16:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="g66MWpdD";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013011.outbound.protection.outlook.com
 [40.107.201.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DAD6810E4C4
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Dec 2025 18:16:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XY928W3c/2h9W0F8+lnjweVRun3Qtbtiwe64yhwdaxWLRuGsWxOpc5K0tr97YcZPLFBWZQzZFuX3z/buxaNtMFEfnKNCHJ6LuhBX08FRV/ytHosHYMV0Z/oCi7lMAazWBhLY73PxjnGTq6DuF3YdoSc2hcocp8r25sJwDKiZ1AJV0BxwbjT6G4Cd5xywy4kPF3YBBZ5K6T6Yrjf351M92eh2Le4AmJOCRZVLxd29Uq5njlUbSWp+uwT0PiFubdlGUc1lxkc5L2o9/tNomn23Ac6w/TodwPIyQ5k6+9zU4Ca5NXqf7uojsK3mej6cNHAZWPAl5RKE0q8YrxKXhiBMpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nOMSMq7qBI++Fd/C7edr4y8YW/+Z+qdNyVJbGMzRE3M=;
 b=NbHMB/59XQPnSaja7ocfa/nDzqMZO5oRQulPzuk8DEOxIWZ1esQ6exRGpAOWTL9Ze4r78SmjRQ/uLxtkfwUrVkz+ngiEW/6DCdLwG3un6LccxlVAZfTPyyt2N+fmKtaVo6BZU5x3+bg70sqL4fGIr7tefZ+3nqYUwspxK9S1EOZNjA6SJGsqF5e6h0i2dYv6e8aoPUCoKm556SNNmf6mq8PsrMA5IqVTwkerticrdImEBs4alFNJ/Pj7xlf03rEyDuJITIwpW4jQaEOQ1fN5ZFh4Ru9aX12VODMLf3QHk0XkuVsmByAgUX8B3JVwkIidrDgg2+i74l8Ukf0uHikfyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nOMSMq7qBI++Fd/C7edr4y8YW/+Z+qdNyVJbGMzRE3M=;
 b=g66MWpdDnsiSGFAqDHRSc29ymw1QMDDB428dLEutK3PS/8cu7l9e7K0/26GWywZtCnvEv2PiqQM4XKsmBXQMfdl/AAKfXgacHSA6Wm5upTV+AoDLdgEVuQm0ksFjXJdhRCn+oJiodVCsUI80/F+MdhLnCBSwNGbpy+vTuwPDWFg=
Received: from BL1PR13CA0233.namprd13.prod.outlook.com (2603:10b6:208:2bf::28)
 by SJ2PR12MB8064.namprd12.prod.outlook.com (2603:10b6:a03:4cc::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.13; Mon, 15 Dec
 2025 18:16:26 +0000
Received: from BL6PEPF0001AB74.namprd02.prod.outlook.com
 (2603:10b6:208:2bf:cafe::4c) by BL1PR13CA0233.outlook.office365.com
 (2603:10b6:208:2bf::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9434.6 via Frontend Transport; Mon,
 15 Dec 2025 18:16:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF0001AB74.mail.protection.outlook.com (10.167.242.167) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9434.6 via Frontend Transport; Mon, 15 Dec 2025 18:16:25 +0000
Received: from tr4.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 15 Dec
 2025 12:16:23 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Likun Gao <Likun.Gao@amd.com>, Lijo Lazar <lijo.lazar@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdgpu: adjust xcc logic for gfxhub v12_1
Date: Mon, 15 Dec 2025 13:15:55 -0500
Message-ID: <20251215181607.29132-8-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251215181607.29132-1-alexander.deucher@amd.com>
References: <20251215181607.29132-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB74:EE_|SJ2PR12MB8064:EE_
X-MS-Office365-Filtering-Correlation-Id: d6d8140e-2c03-4dfc-2e0f-08de3c060f75
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?35R+x8LxxvTzgijmyWUVTp43woq6EwZTleLrmQaGMYMFz6a0oVj1tN0OiP5v?=
 =?us-ascii?Q?RGVUTnX9/XxYCNs67Odq8xtS1LjrQmj69OoI4M9hPDf1UfrPuegzbJI0TxLs?=
 =?us-ascii?Q?fSbcf5+mVMuGomTaN7tKVz6cUUEoKWhKl57dA8y3q7umXlBRyyx8fos6d9lH?=
 =?us-ascii?Q?N99+o9o29AnQkjsSyh7vwXFLfQyxy8kkpZHXODpc6W3iltrxtMVc6bR/vof4?=
 =?us-ascii?Q?bwiXMggxrkJoUdmajxdEfK2m8YFl5CG/4dUQ+1QyJP6nGYnvMpXi6PUA3Y6o?=
 =?us-ascii?Q?Dyk1XuXmBnO7ZHIorb4SG7KuSc22DvoqR1geM4mmCVkO16rmGAV9k8xObnfn?=
 =?us-ascii?Q?bJSSpOXwBOhwvgnCJaOAnw3rZxpbo9LVCmLZmp6+Vlrt18dAYxAcNneYckqk?=
 =?us-ascii?Q?QQmB7SXCNPd9uF5cmV54B2WMkgtpKUzpYfejaOqBmItPFLdzm6Ez1B7Yy/2o?=
 =?us-ascii?Q?VU0ZlZDNp457MHPps0t6XBw6aHMigaMVEt3gNdWWiTU17sMIEd5N38Htj6cj?=
 =?us-ascii?Q?3WB32UFM3t95ZgP+y3G4HVqZIVbkFLtQIK2Fn+1+S1VmG3zvh/1Ra8fWkyst?=
 =?us-ascii?Q?OpG5oIWoXlv0Ix8IPLC1zqiT9q78O/nLYPKgvkU1xaLfUdpq2VyMmwzPpIRF?=
 =?us-ascii?Q?RrmlLS1G6Yj3UKgAC7IsXD1ZzH9mUt1cjN0EMZngTwjawnrgDAmI28R7SLIv?=
 =?us-ascii?Q?NYOcSzo3EdLcF0rSXnG+9Zk6p6R4VpTh2NrB8My5j1JOnZKdFBHks7OQn0lc?=
 =?us-ascii?Q?rSg+8Ygl2D6E4AowohNu3lJMlsvJedRKRG9yRKxET1f9ojHWFvM4gNl7fRwR?=
 =?us-ascii?Q?7UOMRAmoi3E3fOHS4vxH9PlGX0OHx8FzJbOo3XEyiRCZWCyvY9tp18Zk6oao?=
 =?us-ascii?Q?8Wa9qthOsqeD0tfXUieaD+OGmfleunj7L9B3SmrUVvx4hxxWW/webKFaDeKD?=
 =?us-ascii?Q?TU9BCzQBO+iJsCxiVwdu7NTuoyGqnZEKOGg5iy7/xOihobJQBxCGtKoHQtwS?=
 =?us-ascii?Q?Mh4q3gVvGX6YLwoYSlAJXDqiW1HH8o5A0ivWyYF+XVRx0iAX09G6LqFAt7cT?=
 =?us-ascii?Q?yDZq+sP4gxQ5bptSjCe1acqburg7k6yH5OeL7iTv7Sil9krgsA01h9pHPoSF?=
 =?us-ascii?Q?UqRAPMGlObBmquT+/OKomLFF+yqQn/tRz/Z569oG1aLbrsOWmwlFNvcfuYWs?=
 =?us-ascii?Q?8+3o/FkwF6LMgN8srkwotGsFVLrfMNMQHe26TClRnMFH4WYLmTJhD/OHSTit?=
 =?us-ascii?Q?xEIUsqYT81V/7eK1+l+stX6SyS/l72si5jXpewiTl5HgQ6hrzS9R5tBmJodp?=
 =?us-ascii?Q?yIrODvZtDLQk9Q/rI8WsMcXffQK+mKY7kPd8+K+LPa9OUQbIYj1VkkJ1skqt?=
 =?us-ascii?Q?D3QxS3Y92TToL1C62S651tpPxLhH+ZLzrC5OWfVfFZ6GB+QqrKQFHRvnEve/?=
 =?us-ascii?Q?d4rjIEIfr/+i78IKmQl21+/zvy7ZJ+oVk0rG1XqOGlY+TqIGs7rISTceOTxG?=
 =?us-ascii?Q?OtBIftJ/fv+WkpgUGnEp2YbO3l68TrNOoWzNhGUUG9xXxqFGJjgwm7noSdQ7?=
 =?us-ascii?Q?zfobxsdHH+If1XEmQGY=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2025 18:16:25.9553 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d6d8140e-2c03-4dfc-2e0f-08de3c060f75
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB74.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8064
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

Adjust xcc_id logic to only use physical xcc_id when program
register, (use logic xcc_id by default), to fit for compute
partition.

Signed-off-by: Likun Gao <Likun.Gao@amd.com>
Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfxhub_v12_1.c | 52 ++++++++++++++---------
 1 file changed, 33 insertions(+), 19 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v12_1.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v12_1.c
index 662542b9cc362..4aa004ee2c4d9 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v12_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v12_1.c
@@ -65,7 +65,7 @@ static void gfxhub_v12_1_xcc_setup_vm_pt_regs(struct amdgpu_device *adev,
 	struct amdgpu_vmhub *hub;
 	int i;
 
-	for (i = 0; i < NUM_XCC(xcc_mask); i++) {
+	for_each_inst(i, xcc_mask) {
 		hub = &adev->vmhub[AMDGPU_GFXHUB(i)];
 		WREG32_SOC15_OFFSET(GC, GET_INST(GC, i),
 				    regGCVM_CONTEXT0_PAGE_TABLE_BASE_ADDR_LO32,
@@ -83,8 +83,11 @@ static void gfxhub_v12_1_setup_vm_pt_regs(struct amdgpu_device *adev,
 					  uint32_t vmid,
 					  uint64_t page_table_base)
 {
+	uint32_t xcc_mask;
+
+	xcc_mask = GENMASK(NUM_XCC(adev->gfx.xcc_mask) - 1, 0);
 	gfxhub_v12_1_xcc_setup_vm_pt_regs(adev, vmid, page_table_base,
-					  adev->gfx.xcc_mask);
+					  xcc_mask);
 }
 
 static void gfxhub_v12_1_xcc_init_gart_aperture_regs(struct amdgpu_device *adev,
@@ -103,7 +106,7 @@ static void gfxhub_v12_1_xcc_init_gart_aperture_regs(struct amdgpu_device *adev,
 	/* If use GART for FB translation, vmid0 page table covers both
 	 * vram and system memory (gart)
 	 */
-	for (i = 0; i < NUM_XCC(xcc_mask); i++) {
+	for_each_inst(i, xcc_mask) {
 		if (adev->gmc.pdb0_bo) {
 			WREG32_SOC15(GC, GET_INST(GC, i),
 				     regGCVM_CONTEXT0_PAGE_TABLE_START_ADDR_LO32,
@@ -143,7 +146,7 @@ static void gfxhub_v12_1_xcc_init_system_aperture_regs(struct amdgpu_device *ade
 	uint32_t tmp;
 	int i;
 
-	for (i = 0; i < NUM_XCC(xcc_mask); i++) {
+	for_each_inst(i, xcc_mask) {
 		/* Program the AGP BAR */
 		WREG32_SOC15_RLC(GC, GET_INST(GC, i),
 				 regGCMC_VM_AGP_BASE_LO32, 0);
@@ -245,7 +248,7 @@ static void gfxhub_v12_1_xcc_init_tlb_regs(struct amdgpu_device *adev,
 	uint32_t tmp;
 	int i;
 
-	for (i = 0; i < NUM_XCC(xcc_mask); i++) {
+	for_each_inst(i, xcc_mask) {
 		/* Setup TLB control */
 		tmp = RREG32_SOC15(GC, GET_INST(GC, i),
 				   regGCMC_VM_MX_L1_TLB_CNTL);
@@ -280,7 +283,7 @@ static void gfxhub_v12_1_xcc_init_cache_regs(struct amdgpu_device *adev,
 	uint32_t tmp;
 	int i;
 
-	for (i = 0; i < NUM_XCC(xcc_mask); i++) {
+	for_each_inst(i, xcc_mask) {
 		/* Setup L2 cache */
 		tmp = RREG32_SOC15(GC, GET_INST(GC, i), regGCVM_L2_CNTL);
 		tmp = REG_SET_FIELD(tmp, GCVM_L2_CNTL,
@@ -341,7 +344,7 @@ static void gfxhub_v12_1_xcc_enable_system_domain(struct amdgpu_device *adev,
 	uint32_t tmp;
 	int i;
 
-	for (i = 0; i < NUM_XCC(xcc_mask); i++) {
+	for_each_inst(i, xcc_mask) {
 		tmp = RREG32_SOC15(GC, GET_INST(GC, i),
 				   regGCVM_CONTEXT0_CNTL);
 		tmp = REG_SET_FIELD(tmp, GCVM_CONTEXT0_CNTL,
@@ -364,7 +367,7 @@ static void gfxhub_v12_1_xcc_disable_identity_aperture(struct amdgpu_device *ade
 {
 	int i;
 
-	for (i = 0; i < NUM_XCC(xcc_mask); i++) {
+	for_each_inst(i, xcc_mask) {
 		WREG32_SOC15(GC, GET_INST(GC, i),
 			     regGCVM_L2_CONTEXT1_IDENTITY_APERTURE_LOW_ADDR_LO32,
 			     0XFFFFFFFF);
@@ -400,7 +403,7 @@ static void gfxhub_v12_1_xcc_setup_vmid_config(struct amdgpu_device *adev,
 	block_size = adev->vm_manager.block_size;
 	block_size -= 9;
 
-	for (j = 0; j < NUM_XCC(xcc_mask); j++) {
+	for_each_inst(j, xcc_mask) {
 		hub = &adev->vmhub[AMDGPU_GFXHUB(j)];
 		for (i = 0; i <= 14; i++) {
 			tmp = RREG32_SOC15_OFFSET(GC, GET_INST(GC, j),
@@ -458,7 +461,7 @@ static void gfxhub_v12_1_xcc_program_invalidation(struct amdgpu_device *adev,
 	struct amdgpu_vmhub *hub;
 	unsigned int i, j;
 
-	for (j = 0; j < NUM_XCC(xcc_mask); j++) {
+	for_each_inst(j, xcc_mask) {
 		hub = &adev->vmhub[AMDGPU_GFXHUB(j)];
 
 		for (i = 0 ; i < 18; ++i) {
@@ -481,7 +484,7 @@ static int gfxhub_v12_1_xcc_gart_enable(struct amdgpu_device *adev,
 		/* GCMC_VM_FB_LOCATION_BASE/TOP are VF copy registers
 		 * VBIO post does not program them at boot up phase
 		 * Need driver to program them from guest side */
-		for (i = 0; i < NUM_XCC(xcc_mask); i++) {
+		for_each_inst(i, xcc_mask) {
 			WREG32_SOC15(GC, GET_INST(GC, i),
 				     regGCMC_VM_FB_LOCATION_BASE_LO32,
 				     lower_32_bits(adev->gmc.vram_start >> 24));
@@ -514,8 +517,10 @@ static int gfxhub_v12_1_xcc_gart_enable(struct amdgpu_device *adev,
 
 static int gfxhub_v12_1_gart_enable(struct amdgpu_device *adev)
 {
-	return gfxhub_v12_1_xcc_gart_enable(adev,
-					    adev->gfx.xcc_mask);
+	uint32_t xcc_mask;
+
+	xcc_mask = GENMASK(NUM_XCC(adev->gfx.xcc_mask) - 1, 0);
+	return gfxhub_v12_1_xcc_gart_enable(adev, xcc_mask);
 }
 
 static void gfxhub_v12_1_xcc_gart_disable(struct amdgpu_device *adev,
@@ -525,7 +530,7 @@ static void gfxhub_v12_1_xcc_gart_disable(struct amdgpu_device *adev,
 	u32 tmp;
 	u32 i, j;
 
-	for (j = 0; j < NUM_XCC(xcc_mask); j++) {
+	for_each_inst(j, xcc_mask) {
 		hub = &adev->vmhub[AMDGPU_GFXHUB(j)];
 		/* Disable all tables */
 		for (i = 0; i < 16; i++)
@@ -555,7 +560,10 @@ static void gfxhub_v12_1_xcc_gart_disable(struct amdgpu_device *adev,
 
 static void gfxhub_v12_1_gart_disable(struct amdgpu_device *adev)
 {
-	gfxhub_v12_1_xcc_gart_disable(adev, adev->gfx.xcc_mask);
+	uint32_t xcc_mask;
+
+	xcc_mask = GENMASK(NUM_XCC(adev->gfx.xcc_mask) - 1, 0);
+	gfxhub_v12_1_xcc_gart_disable(adev, xcc_mask);
 }
 
 static void gfxhub_v12_1_xcc_set_fault_enable_default(struct amdgpu_device *adev,
@@ -564,7 +572,7 @@ static void gfxhub_v12_1_xcc_set_fault_enable_default(struct amdgpu_device *adev
 	u32 tmp;
 	int i;
 
-	for (i = 0; i < NUM_XCC(xcc_mask); i++) {
+	for_each_inst(i, xcc_mask) {
 		tmp = RREG32_SOC15(GC, GET_INST(GC, i),
 				   regGCVM_L2_PROTECTION_FAULT_CNTL_LO32);
 		tmp = REG_SET_FIELD(tmp,
@@ -637,7 +645,10 @@ static void gfxhub_v12_1_xcc_set_fault_enable_default(struct amdgpu_device *adev
 static void gfxhub_v12_1_set_fault_enable_default(struct amdgpu_device *adev,
 						  bool value)
 {
-	gfxhub_v12_1_xcc_set_fault_enable_default(adev, value, adev->gfx.xcc_mask);
+	uint32_t xcc_mask;
+
+	xcc_mask = GENMASK(NUM_XCC(adev->gfx.xcc_mask) - 1, 0);
+	gfxhub_v12_1_xcc_set_fault_enable_default(adev, value, xcc_mask);
 }
 
 static uint32_t gfxhub_v12_1_get_invalidate_req(unsigned int vmid,
@@ -734,7 +745,7 @@ static void gfxhub_v12_1_xcc_init(struct amdgpu_device *adev, uint32_t xcc_mask)
 	struct amdgpu_vmhub *hub;
 	int i;
 
-	for (i = 0; i < NUM_XCC(xcc_mask); i++) {
+	for_each_inst(i, xcc_mask) {
 		hub = &adev->vmhub[AMDGPU_GFXHUB(i)];
 
 		hub->ctx0_ptb_addr_lo32 =
@@ -790,7 +801,10 @@ static void gfxhub_v12_1_xcc_init(struct amdgpu_device *adev, uint32_t xcc_mask)
 
 static void gfxhub_v12_1_init(struct amdgpu_device *adev)
 {
-	gfxhub_v12_1_xcc_init(adev, adev->gfx.xcc_mask);
+	uint32_t xcc_mask;
+
+	xcc_mask = GENMASK(NUM_XCC(adev->gfx.xcc_mask) - 1, 0);
+	gfxhub_v12_1_xcc_init(adev, xcc_mask);
 }
 
 static int gfxhub_v12_1_get_xgmi_info(struct amdgpu_device *adev)
-- 
2.52.0

