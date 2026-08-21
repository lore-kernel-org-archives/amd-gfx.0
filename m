Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E495C5DF93
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Aug 2026 16:12:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 849A310F36F;
	Fri, 21 Aug 2026 16:12:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="UgsDU8Rw";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010000.outbound.protection.outlook.com [52.101.46.0])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 53F5F10F36F
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Aug 2026 16:12:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t6/WXFwObj5KE5LxIhYOL8WUoPfj9w8oYx+TxKkBbfHS5pO9hwJmuMEQUCvxEDTB7szSIeQ6RhHAvhJ0l8H/9boC+MrnmbcTACnhs0/FnyWpkknu1/2xuwy9ly6g/sIuTvqCtPgjRm7C6Ahux9Bf8uyxWps8uyIHQaEljUPWNDBG9hrEod8k/4t4x8yxvb7wXt7fyQUJH4dxV3wVe2bOb2wp/C/7wizZKRBbwqULsRaR9Ju7BDsOiOC3cEmRTb4efISRit02v6pF6BK10VODW74yNJ2aDkPD+77T4AYPpvyEU0nMiJomh9fxTU1m8cwS3TlLwv/mwLEAy2FqUMlIaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QjEglhLtd013JqFeQiREEqV9jweaDZCR0a4isVz3Nbo=;
 b=ULQPJjSrpKc+xiccu1pEzLBMG6BxDIvYbkyo2X8+Ro4atLwJm4WpMp4ejLP8jEAA52HGYrZBuouMi44cRgtbayIMNRcTr4tHO70o+y8RumbA2FhARwJtVmqjFHjmrMcylkfRKu8Af9XpDFv1Fqh2WyeIvHdqJ5E+JBLAdjy1rmA52ugE8rbXOuipqJ7fKHZ0xZnladaK9pZbx1ep/tYvfCILAMj7SiGAgdFBpvzvfcLJxGfMrtrDZFGN64vrqki1QRpRm+ymWhrYGVuQ83/LvmyEDIzuOxUpE2t8gMHr5vMddiCz4jJyILHl7cAoAwQzZ9X917wJMHlCwMxqpknJ8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QjEglhLtd013JqFeQiREEqV9jweaDZCR0a4isVz3Nbo=;
 b=UgsDU8RwEpRErW3Ro1cdOEIFPrIp9LUJVIK6OWv08hBcq4hkQlOTznyJwbJ0JP+Mh7sWvo9Dz8zB+LuOphR0UHH7gDo64ff22xnzmSCrGGFiV7c8Jj9lezr6bA+LP2GVrjD4IfUhcsuMm9ZFyrigNyNtZd28IyvuGisfgvDJoCc=
Received: from SA9P221CA0016.NAMP221.PROD.OUTLOOK.COM (2603:10b6:806:25::21)
 by DS0PR12MB6438.namprd12.prod.outlook.com (2603:10b6:8:ca::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.11; Fri, 21 Aug
 2026 16:10:39 +0000
Received: from SA2PEPF00003AE8.namprd02.prod.outlook.com
 (2603:10b6:806:25:cafe::3d) by SA9P221CA0016.outlook.office365.com
 (2603:10b6:806:25::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.10 via Frontend Transport; Fri,
 21 Aug 2026 16:10:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SA2PEPF00003AE8.mail.protection.outlook.com (10.167.248.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Fri, 21 Aug 2026 16:10:38 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 21 Aug
 2026 11:10:17 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Fri, 21 Aug 2026 11:10:16 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Hawking Zhang <Hawking.Zhang@amd.com>, Mukul Joshi <mukul.joshi@amd.com>, 
 Horatio Zhang <hongkun.zhang@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>
Subject: [PATCH 13/13] drm/amdgpu: Enable translate further for gc v12_1 v3
Date: Fri, 21 Aug 2026 12:09:58 -0400
Message-ID: <20260821160958.753063-13-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260821160958.753063-1-alexander.deucher@amd.com>
References: <20260821160958.753063-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AE8:EE_|DS0PR12MB6438:EE_
X-MS-Office365-Filtering-Correlation-Id: 748bf826-b20f-4d78-4d12-08deff9ebe0d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|82310400026|36860700016|376014|56012099006|10067099003|6133799003|22082099003|18002099003|11063799006;
X-Microsoft-Antispam-Message-Info: TvRiTkq6XY8v7R6qP8OrexNttJs+QHhvKnOuaG5AcgArLAHZf2gnIy9Cx8ultgtpKRMunroAsM0DByOJdw3N7sseuDrxvN+g8dpsSB3yGGwtgm7TGNaYgNXxoe4GpRZhkz0kNynstZhnwLFoS9m4PjTHibnzXpL3X57g75OlBpdgacrlIbzERQtYJCzkLuND1SLz7xR/iySo95dQ5fzZWG/sSRPJPTDBzp/mSQQN7cb+fDlrmEt8LSksUAAL2BtZRCz8gOfMyZcDst0LSfFYQsM/pvy3BidefBMPbZwi8GLm9UNE7w9IYyZSQPJrMfxHAXuxQjH/EkEiL8aTqjnZxY08+wPVkGfIkv/NmoW2imqcgC+i2zpTscpyuq7AgsDzkw3Is+cxhxi/BZD9x1c/xjDnnmfris3s4HScvOXLML5ubfMbq78ksuULJ2eCzjXTztg/c/1i/RT/NswIWxR3d32SDSeM0ba5kbUrCuiai05dSc3blbSexpKR6PZlFJFxOgtoEiiCbNbO9KhdFsCvXiuN5QkjVqTwb1TeL4SKgjc/eyPYlDoYfXM47eq9qMUROIqmWMwIeBEhaga65Yxd5seQLena9tNRfNN3DfD0A2+WQtUZtGBEDUOWbjkFD6alELxGEN1wEjtZTPypAPDRYZFKMPeW+kU7kAq0CSVmgDeZFEtz/IwHXplAmqvLvzctS68E4yBtsRlj7H48ABEJ/w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(82310400026)(36860700016)(376014)(56012099006)(10067099003)(6133799003)(22082099003)(18002099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: qbawSWYojhGUQjPIKDyFQvpLEqNWGZ3Y/DQfuf+hW+p8I/mFA8GwuVA7CQqEtjPBkBwKTbM6K9pKYwsar2+HJhCGReYtrp1dwetk3Dhkv2EwJ+w7zqGJCmOmFQM16b27UzwCk4GpelfdmwAJWm+U1NAep9/OPdJUDoEpzcioeybyYrzrswIOZlInReF3VF6JTci6hNNKXJxouT+7dv4JE+gkG9Eg3wnxBCmIjCr3lC3WpcGb358BdyMpfaGsw+BHCyhK3nttQVbLO5t9Dyex5q6UqUyAT5Kd5ERl8Mzna2zHlsMgtNnAl8nav03VDTa3ZxGh+DS/it/LGmPLxnO9ELnO7KH7i5hPRbrnuXVu7ACPiFwx7hp9XAhheq7D3+eJs6on66IB1ywgrob62jecIWQo+TRFlMwqcuQ020/iJmqMDTMvieBOH+vLMRt+8jAG
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2026 16:10:38.6033 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 748bf826-b20f-4d78-4d12-08deff9ebe0d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003AE8.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6438
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

Enable translate further for gc v12_1 to resolve
the tlb reach issue

v2: ensure PTE.P is set to 1 for leaf PTE

v3: Do not clear the P bit when it has been set
on a PDB0 entry by the common VM update code

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
Reviewed-by: Mukul Joshi <mukul.joshi@amd.com>
Reviewed-by: Horatio Zhang <hongkun.zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfxhub_v12_1.c |  5 ++++-
 drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c    |  3 ++-
 drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c    |  4 ----
 drivers/gpu/drm/amd/amdgpu/mmhub_v4_2_0.c | 13 ++++++++++---
 4 files changed, 16 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v12_1.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v12_1.c
index 1f7e57792d4dc..15d2a8ec55a6f 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v12_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v12_1.c
@@ -402,7 +402,10 @@ static void gfxhub_v12_1_xcc_setup_vmid_config(struct amdgpu_device *adev,
 
 	num_level = adev->vm_manager.num_level;
 	block_size = adev->vm_manager.block_size;
-	block_size -= 9;
+	if (adev->gmc.translate_further)
+		num_level -= 1;
+	else
+		block_size -= 9;
 
 	for_each_inst(j, xcc_mask) {
 		hub = &adev->vmhub[AMDGPU_GFXHUB(j)];
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
index ea240aa1e4455..e69cae39b5f75 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
@@ -645,7 +645,6 @@ static int gmc_v12_0_early_init(struct amdgpu_ip_block *ip_block)
 	case IP_VERSION(12, 1, 0):
 		gmc_v12_1_set_gmc_funcs(adev);
 		gmc_v12_1_set_irq_funcs(adev);
-		adev->gmc.init_pte_flags = AMDGPU_PTE_IS_PTE;
 		break;
 	default:
 		gmc_v12_0_set_gmc_funcs(adev);
@@ -855,6 +854,8 @@ static int gmc_v12_0_sw_init(struct amdgpu_ip_block *ip_block)
 		amdgpu_vm_adjust_size(adev, 128 * 1024 * 1024, 9, 4, 57);
 		pte_addr_mask = 0x000FFFFFFFFFF000ULL; /* 52 bit PA */
 		dma_addr_bits = 52;
+		adev->gmc.translate_further = adev->vm_manager.num_level > 1;
+		adev->gmc.init_pte_flags = AMDGPU_PTE_IS_PTE;
 		break;
 	default:
 		dev_warn(adev->dev, "Unrecognized GC IP version: 0x%08x\n",
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c b/drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c
index b0962a14fdb4d..f9887cec9a6c3 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c
@@ -597,10 +597,6 @@ static void gmc_v12_1_get_vm_pde(struct amdgpu_device *adev, int level,
 		/* Set the block fragment size */
 		if (!(*flags & AMDGPU_PDE_PTE_GFX12))
 			*flags |= AMDGPU_PDE_BFS_GFX12(0x9);
-
-	} else if (level == AMDGPU_VM_PDB0) {
-		if (*flags & AMDGPU_PDE_PTE_GFX12)
-			*flags &= ~AMDGPU_PDE_PTE_GFX12;
 	}
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v4_2_0.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v4_2_0.c
index b2a3276750deb..4495d52b4b07c 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v4_2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v4_2_0.c
@@ -518,9 +518,17 @@ static void mmhub_v4_2_0_mid_setup_vmid_config(struct amdgpu_device *adev,
 					       uint32_t inst_mask)
 {
 	struct amdgpu_vmhub *hub;
+	u32 num_level, block_size;
 	uint32_t tmp;
 	int i, j;
 
+	num_level = adev->vm_manager.num_level;
+	block_size = adev->vm_manager.block_size;
+	if (adev->gmc.translate_further)
+		num_level -= 1;
+	else
+		block_size -= 9;
+
 	for_each_inst(j, inst_mask) {
 		hub = &adev->vmhub[AMDGPU_MMHUB0(j)];
 		for (i = 0; i <= 14; i++) {
@@ -528,7 +536,7 @@ static void mmhub_v4_2_0_mid_setup_vmid_config(struct amdgpu_device *adev,
 						 i * hub->ctx_distance);
 			tmp = REG_SET_FIELD(tmp, MMVM_CONTEXT1_CNTL, ENABLE_CONTEXT, 1);
 			tmp = REG_SET_FIELD(tmp, MMVM_CONTEXT1_CNTL, PAGE_TABLE_DEPTH,
-					    adev->vm_manager.num_level);
+					    num_level);
 			tmp = REG_SET_FIELD(tmp, MMVM_CONTEXT1_CNTL,
 					    RANGE_PROTECTION_FAULT_ENABLE_DEFAULT, 1);
 			tmp = REG_SET_FIELD(tmp, MMVM_CONTEXT1_CNTL,
@@ -545,8 +553,7 @@ static void mmhub_v4_2_0_mid_setup_vmid_config(struct amdgpu_device *adev,
 			tmp = REG_SET_FIELD(tmp, MMVM_CONTEXT1_CNTL,
 					    EXECUTE_PROTECTION_FAULT_ENABLE_DEFAULT, 1);
 			tmp = REG_SET_FIELD(tmp, MMVM_CONTEXT1_CNTL,
-					    PAGE_TABLE_BLOCK_SIZE,
-					    adev->vm_manager.block_size - 9);
+					    PAGE_TABLE_BLOCK_SIZE, block_size);
 			/* Send no-retry XNACK on fault to suppress VM fault storm. */
 			tmp = REG_SET_FIELD(tmp, MMVM_CONTEXT1_CNTL,
 					    RETRY_PERMISSION_OR_INVALID_PAGE_FAULT,
-- 
2.55.0

