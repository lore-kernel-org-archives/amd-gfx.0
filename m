Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76CBFC5DF97
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Aug 2026 16:10:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5FAC210F364;
	Fri, 21 Aug 2026 16:10:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="i4EJ0GjH";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012022.outbound.protection.outlook.com [40.107.209.22])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5470E10F361
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Aug 2026 16:10:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tTxwhrSaBeuH2Re86o9NiX7pXzTRNUjIgdjBhl8nl6QMRInZnA5VD8RwsqgXVZaKiT+GOoMJDQy7WBsBIlIrrfyvTAhtTLSlArBzufPI4VIHnv7oBJChpgFI2so9X5vTfadHTReIsPfhM6HcOFT2+N4VIhBypyV1hLvk+d65QOwK/ARfnD2vNV9qKCxL+eEws8cruS71XlQe7Voa+mzAlmc6EJYTiSoFXuXYfhgqJp3lvdbPoQ4sux2Y2SrotPqdSkhqOlq+Axn0gL1S3jUJ4QG429oGNzXqozbwo3mKepriA9z+bjgkPGFsgJMyruF9GWvdvvkh43ts/ipLzZa0rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nGbS7axsz/k60mojHEd/yfxuKMyxhi7o3Ija0vhzMvY=;
 b=j8CJPlvHXnYeUnoAAtLvxbgA6oN5oM1lk69DaBHDGvsGDKAc3w7rY6J/dAS+QJOjV6CqvLxp+lr237oCm4bQjZHPaRqXWerNspfJNu6iz8nbTvBLGGvkoMbnZceW51Y+kQHuc/BvCcbfDpjzHZaiJK5Nn01uGc806xVn90nva1hHh5kJTY1SzZYYJ/h5adirnJH/tPRsWCdt0STwdFWIdKUqiZeY9QHB2GYO8wlf4SouKCozuyYux/ILvVf1jr+mxxmkHTTPG4Ly8yIoYDTs4O8BJaSB8Ybx4d6ar2uh9et/roLHOwHd0+EejiROiq1cJF6LW4D/B1xjSmn7eCLsQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nGbS7axsz/k60mojHEd/yfxuKMyxhi7o3Ija0vhzMvY=;
 b=i4EJ0GjH7yAKzAa8B+Lr9X1qB49yT8hrTkQSMwXRsObHZTa62crxVeE9Vvb6tJXBeU4wjfAaATFbH+Ja81CqUw2qCHY+NApWzhTo5ol5krCLpMerw+IgP99+wc2Br4gBaMcPSIXEoq5tIjiF0OB8KxCbUTy4UKObAlZhVKsDr80=
Received: from SA0PR11CA0045.namprd11.prod.outlook.com (2603:10b6:806:d0::20)
 by MW9PR12MB999208.namprd12.prod.outlook.com (2603:10b6:303:301::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.10; Fri, 21 Aug
 2026 16:10:13 +0000
Received: from SA2PEPF00003AE5.namprd02.prod.outlook.com
 (2603:10b6:806:d0:cafe::54) by SA0PR11CA0045.outlook.office365.com
 (2603:10b6:806:d0::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.11 via Frontend Transport; Fri,
 21 Aug 2026 16:10:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SA2PEPF00003AE5.mail.protection.outlook.com (10.167.248.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Fri, 21 Aug 2026 16:10:12 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 21 Aug
 2026 11:10:11 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 21 Aug
 2026 11:10:11 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Fri, 21 Aug 2026 11:10:11 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Hawking Zhang <Hawking.Zhang@amd.com>, Le Ma <le.ma@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>
Subject: [PATCH 03/13] drm/amdgpu: Use discovered mmhub inst_mask for v4_2_0
Date: Fri, 21 Aug 2026 12:09:48 -0400
Message-ID: <20260821160958.753063-3-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260821160958.753063-1-alexander.deucher@amd.com>
References: <20260821160958.753063-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AE5:EE_|MW9PR12MB999208:EE_
X-MS-Office365-Filtering-Correlation-Id: 922084b9-3f15-4f25-6a6f-08deff9eae69
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|23010399003|82310400026|376014|22082099003|18002099003|56012099006|10067099003|11063799006;
X-Microsoft-Antispam-Message-Info: GrJilzNrqLYvzLzleQHce/AEAiU/JBnKFwcv0adYsq09z9iD6/ATRBQ0WQUUE+KHdnX/H7JHE2Di/ciCZHaY+ouQocP9f+eZO8zvHUyyQIG33GcTHPfff2QMoAnPF/IkmaTlwUTMafxNlPaYFnLmfYclO1DTsWm99Gg111eHBP4zWHjsJfcPx7j0CCISBBvswB7DLdHQFOzcHaf7xQzW3mSd7N0+5B9Nn1skW307D0b+uqyUhtiqYgRBD549W6GowhlB+parC1U5rnGyVk6/NeJczyb5NhvGeDH2vzBm4P1IrN0UI4Fj+Ai7hmvozQsQHzXfsYAV0rWCvo3kbpPZZkqLLIirZUCtzZEIoqwu+1xl/IjC2dzeF8XMleouP+9WChphHJr38hNfimndFkkF95y/9vuO3U76RWDcHCnX5RwNZo9BTNaE0zb7dirpy19Y39ZeSx7NXKe8wiI1crFm9jC1SCdmgc1LJgCijVuQvUsSgqHX7g3AdzLMIlqlraNI4rPaE5859GYkqKW2pSjUI1IeNZnQ4UxYZwx4QxsgIOlKJMVuWbfK/gPMrb655+moOdKUDGv2l9o4sr89d8/urTIysreUtoxtlcePmZZWXIye+6vULCcmhsYrh5WM4RNFBLz/Mj9i/UyLEj8One09RqlAeDCMlxE7ooOEbUEGhsQJnrsEtILbZM+YYNhXgBoL3dHyZ2meisKAWp31M6GJog==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(23010399003)(82310400026)(376014)(22082099003)(18002099003)(56012099006)(10067099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: aB4o928JyGC1dB8NkDDMzqq3XyR67q58WzV7Elc9nQkk2sTO2cmrn/Ph7vpJG22u+kT1y0TEGLySGC593m3opGtHy7eveyjgs7oT7CETzaAe9L+zdE8CR6P27c5TstrttJyJc02Ww/vWn8bbV5lMPh708bmR9gnjNeUQCppaoWIRQXHKXMyOHWhiwZjlGlI5OIrya7ZRQ4GtjeMXdA+zSAyEFICv1auMrKLWQ0w7+t53a1kCcQ0YmFtjZLZQ9dkePhXCMNpUH3K8VrxCtksdTaqXaIeuzIvJZNeqDRd0ZlapX8M7O4AT6Ia7EMENo7khcXJc/8pEWVH3ASH+huxhEQIs8c7PJJboK7kqhf3MrPWtLYdVtKb8Lu9gLI/LOlsbqTBvChbVkv2f+0FsmMpwQYVOkpES1xRqJOWlwP1b5p214evsq85dOh6pecaRwsFY
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2026 16:10:12.3760 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 922084b9-3f15-4f25-6a6f-08deff9eae69
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003AE5.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW9PR12MB999208
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

From: Hawking Zhang <Hawking.Zhang@amd.com>

mmhub v4_2_0 used adev->aid_mask as the mid_mask
when programming MMHUB instances. That assumption
is not valid for products with more AIDs than MIDs.

Track discovered MMHUB instances in mmhub.inst_mask
and use that mask for mmhub v4_2_0 programming paths.

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
Reviewed-by: Le Ma <le.ma@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 11 +++
 drivers/gpu/drm/amd/amdgpu/amdgpu_mmhub.h     |  3 +
 drivers/gpu/drm/amd/amdgpu/mmhub_v4_2_0.c     | 94 ++++++++-----------
 drivers/gpu/drm/amd/amdgpu/soc_v1_0.c         | 22 +++--
 drivers/gpu/drm/amd/amdgpu/soc_v1_0.h         |  1 +
 5 files changed, 70 insertions(+), 61 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index 5488715938b02..66315ce79fdcc 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -1760,6 +1760,7 @@ static int amdgpu_discovery_reg_base_init(struct amdgpu_device *adev)
 	adev->sdma.sdma_mask = 0;
 	adev->vcn.inst_mask = 0;
 	adev->jpeg.inst_mask = 0;
+	adev->mmhub.inst_mask = 0;
 	r = amdgpu_discovery_get_table_info(adev, &info, IP_DISCOVERY);
 	if (r)
 		return r;
@@ -1825,6 +1826,16 @@ static int amdgpu_discovery_reg_base_init(struct amdgpu_device *adev)
 				}
 				ip->revision &= ~0xc0;
 			}
+
+			if (le16_to_cpu(ip->hw_id) == MMHUB_HWID) {
+				if (inst < AMDGPU_MAX_MMHUB_INSTANCES)
+					adev->mmhub.inst_mask |= BIT(inst);
+				else
+					dev_err(adev->dev, "Too many MMHUB instances: %d vs %d\n",
+						inst + 1,
+						AMDGPU_MAX_MMHUB_INSTANCES);
+			}
+
 			if (le16_to_cpu(ip->hw_id) == SDMA0_HWID ||
 			    le16_to_cpu(ip->hw_id) == SDMA1_HWID ||
 			    le16_to_cpu(ip->hw_id) == SDMA2_HWID ||
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mmhub.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_mmhub.h
index c5120ba51e248..bc25a13180690 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mmhub.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mmhub.h
@@ -21,6 +21,8 @@
 #ifndef __AMDGPU_MMHUB_H__
 #define __AMDGPU_MMHUB_H__
 
+#define AMDGPU_MAX_MMHUB_INSTANCES 4
+
 struct amdgpu_mmhub_ras {
 	struct amdgpu_ras_block_object ras_block;
 };
@@ -53,6 +55,7 @@ struct amdgpu_mmhub {
 	const struct amdgpu_mmhub_funcs *funcs;
 	struct amdgpu_mmhub_ras  *ras;
 	struct amdgpu_mmhub_client_ids client_ids;
+	uint32_t inst_mask;
 };
 
 static inline void
diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v4_2_0.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v4_2_0.c
index 5a29d38220ca4..8e010296b3c29 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v4_2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v4_2_0.c
@@ -137,12 +137,12 @@ static u64 mmhub_v4_2_0_get_mc_fb_offset(struct amdgpu_device *adev)
 static void mmhub_v4_2_0_mid_setup_vm_pt_regs(struct amdgpu_device *adev,
 					      uint32_t vmid,
 					      uint64_t page_table_base,
-					      uint32_t mid_mask)
+					      uint32_t inst_mask)
 {
 	struct amdgpu_vmhub *hub;
 	int i;
 
-	for_each_inst(i, mid_mask) {
+	for_each_inst(i, inst_mask) {
 		hub = &adev->vmhub[AMDGPU_MMHUB0(i)];
 		WREG32_SOC15_OFFSET(MMHUB, GET_INST(MMHUB, i),
 				    regMMVM_CONTEXT0_PAGE_TABLE_BASE_ADDR_LO32,
@@ -160,16 +160,13 @@ static void mmhub_v4_2_0_setup_vm_pt_regs(struct amdgpu_device *adev,
 					  uint32_t vmid,
 					  uint64_t page_table_base)
 {
-	uint32_t mid_mask;
-
-	mid_mask = adev->aid_mask;
 	mmhub_v4_2_0_mid_setup_vm_pt_regs(adev, vmid,
 					  page_table_base,
-					  mid_mask);
+					  adev->mmhub.inst_mask);
 }
 
 static void mmhub_v4_2_0_mid_init_gart_aperture_regs(struct amdgpu_device *adev,
-						     uint32_t mid_mask)
+						     uint32_t inst_mask)
 {
 	uint64_t pt_base;
 	int i;
@@ -179,9 +176,9 @@ static void mmhub_v4_2_0_mid_init_gart_aperture_regs(struct amdgpu_device *adev,
 	else
 		pt_base = amdgpu_gmc_pd_addr(adev->gart.bo);
 
-	mmhub_v4_2_0_mid_setup_vm_pt_regs(adev, 0, pt_base, mid_mask);
+	mmhub_v4_2_0_mid_setup_vm_pt_regs(adev, 0, pt_base, inst_mask);
 
-	for_each_inst(i, mid_mask) {
+	for_each_inst(i, inst_mask) {
 		if (adev->gmc.pdb0_bo) {
 			WREG32_SOC15(MMHUB, GET_INST(MMHUB, i),
 				     regMMVM_CONTEXT0_PAGE_TABLE_START_ADDR_LO32,
@@ -215,7 +212,7 @@ static void mmhub_v4_2_0_mid_init_gart_aperture_regs(struct amdgpu_device *adev,
 }
 
 static void mmhub_v4_2_0_mid_init_system_aperture_regs(struct amdgpu_device *adev,
-						       uint32_t mid_mask)
+						       uint32_t inst_mask)
 {
 	uint64_t value;
 	uint32_t tmp;
@@ -229,7 +226,7 @@ static void mmhub_v4_2_0_mid_init_system_aperture_regs(struct amdgpu_device *ade
 	if (amdgpu_sriov_vf(adev))
 		return;
 
-	for_each_inst(i, mid_mask) {
+	for_each_inst(i, inst_mask) {
 		if (adev->gmc.pdb0_bo) {
 			/* Disable agp and system aperture
 			 * when vmid0 page table is enabled */
@@ -328,12 +325,12 @@ static void mmhub_v4_2_0_mid_init_system_aperture_regs(struct amdgpu_device *ade
 }
 
 static void mmhub_v4_2_0_mid_init_tlb_regs(struct amdgpu_device *adev,
-					   uint32_t mid_mask)
+					   uint32_t inst_mask)
 {
 	uint32_t tmp;
 	int i;
 
-	for_each_inst(i, mid_mask) {
+	for_each_inst(i, inst_mask) {
 		/* Setup TLB control */
 		tmp = RREG32_SOC15(MMHUB, GET_INST(MMHUB, i),
 				   regMMMC_VM_MX_L1_TLB_CNTL);
@@ -353,7 +350,7 @@ static void mmhub_v4_2_0_mid_init_tlb_regs(struct amdgpu_device *adev,
 }
 
 static void mmhub_v4_2_0_mid_init_cache_regs(struct amdgpu_device *adev,
-					     uint32_t mid_mask)
+					     uint32_t inst_mask)
 {
 	uint32_t tmp;
 	int i;
@@ -364,7 +361,7 @@ static void mmhub_v4_2_0_mid_init_cache_regs(struct amdgpu_device *adev,
 	if (amdgpu_sriov_vf(adev))
 		return;
 
-	for_each_inst(i, mid_mask) {
+	for_each_inst(i, inst_mask) {
 		/* Setup L2 cache */
 		tmp = RREG32_SOC15(MMHUB, GET_INST(MMHUB, i), regMMVM_L2_CNTL);
 		tmp = REG_SET_FIELD(tmp, MMVM_L2_CNTL, ENABLE_L2_CACHE, 1);
@@ -416,12 +413,12 @@ static void mmhub_v4_2_0_mid_init_cache_regs(struct amdgpu_device *adev,
 }
 
 static void mmhub_v4_2_0_mid_enable_system_domain(struct amdgpu_device *adev,
-						  uint32_t mid_mask)
+						  uint32_t inst_mask)
 {
 	uint32_t tmp;
 	int i;
 
-	for_each_inst(i, mid_mask) {
+	for_each_inst(i, inst_mask) {
 		tmp = RREG32_SOC15(MMHUB, GET_INST(MMHUB, i),
 				   regMMVM_CONTEXT0_CNTL);
 		tmp = REG_SET_FIELD(tmp, MMVM_CONTEXT0_CNTL,
@@ -439,7 +436,7 @@ static void mmhub_v4_2_0_mid_enable_system_domain(struct amdgpu_device *adev,
 }
 
 static void mmhub_v4_2_0_mid_disable_identity_aperture(struct amdgpu_device *adev,
-						       uint32_t mid_mask)
+						       uint32_t inst_mask)
 {
 	int i;
 
@@ -449,7 +446,7 @@ static void mmhub_v4_2_0_mid_disable_identity_aperture(struct amdgpu_device *ade
 	if (amdgpu_sriov_vf(adev))
 		return;
 
-	for_each_inst(i, mid_mask) {
+	for_each_inst(i, inst_mask) {
 		WREG32_SOC15(MMHUB, GET_INST(MMHUB, i),
 			     regMMVM_L2_CONTEXT1_IDENTITY_APERTURE_LOW_ADDR_LO32,
 			     0xFFFFFFFF);
@@ -474,13 +471,13 @@ static void mmhub_v4_2_0_mid_disable_identity_aperture(struct amdgpu_device *ade
 }
 
 static void mmhub_v4_2_0_mid_setup_vmid_config(struct amdgpu_device *adev,
-					       uint32_t mid_mask)
+					       uint32_t inst_mask)
 {
 	struct amdgpu_vmhub *hub;
 	uint32_t tmp;
 	int i, j;
 
-	for_each_inst(j, mid_mask) {
+	for_each_inst(j, inst_mask) {
 		hub = &adev->vmhub[AMDGPU_MMHUB0(j)];
 		for (i = 0; i <= 14; i++) {
 			tmp = RREG32_SOC15_OFFSET(MMHUB, GET_INST(MMHUB, j),
@@ -530,12 +527,12 @@ static void mmhub_v4_2_0_mid_setup_vmid_config(struct amdgpu_device *adev,
 }
 
 static void mmhub_v4_2_0_mid_program_invalidation(struct amdgpu_device *adev,
-						  uint32_t mid_mask)
+						  uint32_t inst_mask)
 {
 	struct amdgpu_vmhub *hub;
 	unsigned int i, j;
 
-	for_each_inst(j, mid_mask) {
+	for_each_inst(j, inst_mask) {
 		hub = &adev->vmhub[AMDGPU_MMHUB0(j)];
 
 		for (i = 0; i < 18; ++i) {
@@ -550,37 +547,34 @@ static void mmhub_v4_2_0_mid_program_invalidation(struct amdgpu_device *adev,
 }
 
 static int mmhub_v4_2_0_mid_gart_enable(struct amdgpu_device *adev,
-					uint32_t mid_mask)
+					uint32_t inst_mask)
 {
 	/* GART Enable. */
-	mmhub_v4_2_0_mid_init_gart_aperture_regs(adev, mid_mask);
-	mmhub_v4_2_0_mid_init_system_aperture_regs(adev, mid_mask);
-	mmhub_v4_2_0_mid_init_tlb_regs(adev, mid_mask);
-	mmhub_v4_2_0_mid_init_cache_regs(adev, mid_mask);
+	mmhub_v4_2_0_mid_init_gart_aperture_regs(adev, inst_mask);
+	mmhub_v4_2_0_mid_init_system_aperture_regs(adev, inst_mask);
+	mmhub_v4_2_0_mid_init_tlb_regs(adev, inst_mask);
+	mmhub_v4_2_0_mid_init_cache_regs(adev, inst_mask);
 
-	mmhub_v4_2_0_mid_enable_system_domain(adev, mid_mask);
-	mmhub_v4_2_0_mid_disable_identity_aperture(adev, mid_mask);
-	mmhub_v4_2_0_mid_setup_vmid_config(adev, mid_mask);
-	mmhub_v4_2_0_mid_program_invalidation(adev, mid_mask);
+	mmhub_v4_2_0_mid_enable_system_domain(adev, inst_mask);
+	mmhub_v4_2_0_mid_disable_identity_aperture(adev, inst_mask);
+	mmhub_v4_2_0_mid_setup_vmid_config(adev, inst_mask);
+	mmhub_v4_2_0_mid_program_invalidation(adev, inst_mask);
 
 	return 0;
 }
 static int mmhub_v4_2_0_gart_enable(struct amdgpu_device *adev)
 {
-	uint32_t mid_mask;
-
-	mid_mask = adev->aid_mask;
-	return mmhub_v4_2_0_mid_gart_enable(adev, mid_mask);
+	return mmhub_v4_2_0_mid_gart_enable(adev, adev->mmhub.inst_mask);
 }
 
 static void mmhub_v4_2_0_mid_gart_disable(struct amdgpu_device *adev,
-					  uint32_t mid_mask)
+					  uint32_t inst_mask)
 {
 	struct amdgpu_vmhub *hub;
 	u32 tmp;
 	u32 i, j;
 
-	for_each_inst(j, mid_mask) {
+	for_each_inst(j, inst_mask) {
 		hub = &adev->vmhub[AMDGPU_MMHUB0(j)];
 		/* Disable all tables */
 		for (i = 0; i < 16; i++)
@@ -608,15 +602,12 @@ static void mmhub_v4_2_0_mid_gart_disable(struct amdgpu_device *adev,
 
 static void mmhub_v4_2_0_gart_disable(struct amdgpu_device *adev)
 {
-	uint32_t mid_mask;
-
-	mid_mask = adev->aid_mask;
-	mmhub_v4_2_0_mid_gart_disable(adev, mid_mask);
+	mmhub_v4_2_0_mid_gart_disable(adev, adev->mmhub.inst_mask);
 }
 
 static void
 mmhub_v4_2_0_mid_set_fault_enable_default(struct amdgpu_device *adev,
-					  bool value, uint32_t mid_mask)
+					  bool value, uint32_t inst_mask)
 {
 	u32 tmp;
 	int i;
@@ -627,7 +618,7 @@ mmhub_v4_2_0_mid_set_fault_enable_default(struct amdgpu_device *adev,
 	if (amdgpu_sriov_vf(adev))
 		return;
 
-	for_each_inst(i, mid_mask) {
+	for_each_inst(i, inst_mask) {
 		tmp = RREG32_SOC15(MMHUB, GET_INST(MMHUB, i),
 				   regMMVM_L2_PROTECTION_FAULT_CNTL_LO32);
 		tmp = REG_SET_FIELD(tmp, MMVM_L2_PROTECTION_FAULT_CNTL_LO32,
@@ -673,10 +664,8 @@ static void
 mmhub_v4_2_0_set_fault_enable_default(struct amdgpu_device *adev,
 				      bool value)
 {
-	uint32_t mid_mask;
-
-	mid_mask = adev->aid_mask;
-	mmhub_v4_2_0_mid_set_fault_enable_default(adev, value, mid_mask);
+	mmhub_v4_2_0_mid_set_fault_enable_default(adev, value,
+						  adev->mmhub.inst_mask);
 }
 
 static uint32_t mmhub_v4_2_0_get_invalidate_req(unsigned int vmid,
@@ -743,12 +732,12 @@ static const struct amdgpu_vmhub_funcs mmhub_v4_2_0_vmhub_funcs = {
 };
 
 static void mmhub_v4_2_0_mid_init(struct amdgpu_device *adev,
-				  uint32_t mid_mask)
+				  uint32_t inst_mask)
 {
 	struct amdgpu_vmhub *hub;
 	int i;
 
-	for_each_inst(i, mid_mask) {
+	for_each_inst(i, inst_mask) {
 		hub = &adev->vmhub[AMDGPU_MMHUB0(i)];
 
 		hub->ctx0_ptb_addr_lo32 =
@@ -805,10 +794,7 @@ static void mmhub_v4_2_0_mid_init(struct amdgpu_device *adev,
 
 static void mmhub_v4_2_0_init(struct amdgpu_device *adev)
 {
-	uint32_t mid_mask;
-
-	mid_mask = adev->aid_mask;
-	mmhub_v4_2_0_mid_init(adev, mid_mask);
+	mmhub_v4_2_0_mid_init(adev, adev->mmhub.inst_mask);
 
 	amdgpu_mmhub_init_client_info(&adev->mmhub,
 				     mmhub_client_ids_v4_2_0,
diff --git a/drivers/gpu/drm/amd/amdgpu/soc_v1_0.c b/drivers/gpu/drm/amd/amdgpu/soc_v1_0.c
index 8a1365ae9db6c..3c1ddbd1b93f7 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc_v1_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc_v1_0.c
@@ -823,19 +823,27 @@ static int soc_v1_0_xcp_mgr_init(struct amdgpu_device *adev)
 	return ret;
 }
 
-int soc_v1_0_init_soc_config(struct amdgpu_device *adev)
+uint32_t soc_v1_0_get_aid_mask(uint16_t xcc_mask)
 {
-	int ret, i;
 	int xcc_inst_per_aid = 4;
-	uint16_t xcc_mask, sdma_mask = 0;
+	uint32_t aid_mask = 0;
+	int i;
 
-	xcc_mask = adev->gfx.xcc_mask;
-	adev->aid_mask = 0;
 	for (i = 0; xcc_mask; xcc_mask >>= xcc_inst_per_aid, i++) {
-		if (xcc_mask & ((1U << xcc_inst_per_aid) - 1))
-			adev->aid_mask |= (1 << i);
+		if (xcc_mask & GENMASK(xcc_inst_per_aid - 1, 0))
+			aid_mask |= BIT(i);
 	}
 
+	return aid_mask;
+}
+
+int soc_v1_0_init_soc_config(struct amdgpu_device *adev)
+{
+	int ret, i;
+	uint16_t sdma_mask = 0;
+
+	adev->aid_mask = soc_v1_0_get_aid_mask(adev->gfx.xcc_mask);
+
 	adev->sdma.num_inst_per_xcc = 2;
 	for_each_inst(i, adev->gfx.xcc_mask)
 		sdma_mask |=
diff --git a/drivers/gpu/drm/amd/amdgpu/soc_v1_0.h b/drivers/gpu/drm/amd/amdgpu/soc_v1_0.h
index 16c220fcc4e92..3cbc20eb16155 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc_v1_0.h
+++ b/drivers/gpu/drm/amd/amdgpu/soc_v1_0.h
@@ -30,6 +30,7 @@ void soc_v1_0_grbm_select(struct amdgpu_device *adev,
 			  u32 queue, u32 vmid,
 			  int xcc_id);
 int soc_v1_0_init_soc_config(struct amdgpu_device *adev);
+uint32_t soc_v1_0_get_aid_mask(uint16_t xcc_mask);
 bool soc_v1_0_normalize_xcc_reg_range(uint32_t reg);
 bool soc_v1_0_mid1_reg_range(uint32_t reg);
 uint32_t soc_v1_0_normalize_xcc_reg_offset(uint32_t reg);
-- 
2.55.0

