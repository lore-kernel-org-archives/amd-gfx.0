Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39F78CA5FA1
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Sep 2026 16:45:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C486910EB33;
	Mon, 28 Sep 2026 16:45:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="EnEVpaOd";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010004.outbound.protection.outlook.com [52.101.46.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F131210E938
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Sep 2026 16:44:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rqHCeWcsjldaEieluAhVKnrKx9/zLcTAjUdW2GsI6BT1f/PXO4YDj2zI3XzepC1pTviqgejBzzHGckMy5M79wOWOftnOWs2eRUHWLE6t0/bEexh8kaGaU+swdLaYsmzEoOvWviSysir/pqkLg2Ei7N1FMJbRHe3t996Yr0oh96TVbYpW4I4aZFGp3FJgFyZuudXA5BTucozP3p0kMowzbXC+xgindUTivU2CvAq0xoRk9Utj5nM6+HxMDCveNzpI6C2Xc2gWKfGasidqpfoOXUa56YEVdqN/2jQzTtHfZqNK+HCHmkztXMlSBfXv4jFaMWLGLku2kEwbAhsEELFTBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lMxRzyxlE6AbeM0KmtsSYJo/GgGVegnQ/z/B0z/5w6I=;
 b=gyGHBYqAnqMRkiF4taIVVhKIjTMb3vwzbwKvCWD6fJg0kMA05llnp9Y2gOxfSHAUY+XT0HedSRza/ZvWShVxnn2Ci0thAZvONUMslzas31UzqWPZSLEJSeMI+Xpm4Bf47AmNROZHX1jPUS833gSB/SFVW6xF4otXpQMN7J7ivVxIX1ChDGHWEMFmJq4xwdynbyqCdLviPXTiB3lHGBCVgGM74Dxlx/tTd5pveiGeVP55EjnquUIC6Ru/fCJdL2SAldhlenRa7+XVElPfAi22+rY6XZytIOOlvJcJ6HW9Dq5HHO+KMMgeClKWGsFDANLrfWlejPBCHU6fNsjOQ9hpIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lMxRzyxlE6AbeM0KmtsSYJo/GgGVegnQ/z/B0z/5w6I=;
 b=EnEVpaOd3znGLgZZmCnXl9060STIvXlEnozNRPodIz2VAR3Q1/DRKb/zUL/OBfFzx9LCE+q2h/AQ82zyoahfMUIfGPxOU+6H9KmttJvQoHWCbCK+rB3ykC54A5Qt02tOUT3/SyCb1rbY7hHW8qIq3gCXdg1BV8DFpvlXp7o26AI=
Received: from MN2PR11CA0030.namprd11.prod.outlook.com (2603:10b6:208:23b::35)
 by BY5PR12MB4290.namprd12.prod.outlook.com (2603:10b6:a03:20e::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Mon, 28 Sep
 2026 16:44:50 +0000
Received: from BN2PEPF000044A8.namprd04.prod.outlook.com
 (2603:10b6:208:23b::4) by MN2PR11CA0030.outlook.office365.com
 (2603:10b6:208:23b::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.24 via Frontend Transport; Mon,
 28 Sep 2026 16:44:49 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF000044A8.mail.protection.outlook.com (10.167.243.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Mon, 28 Sep 2026 16:44:49 +0000
Received: from MKMZHLUO01.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Mon, 28 Sep
 2026 11:44:47 -0500
From: Zhigang Luo <Zhigang.Luo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Philip.Yang@amd.com>,
 <Hawking.Zhang@amd.com>, <Lijo.Lazar@amd.com>, <Gavin.Wan@amd.com>,
 <Victor.Skvortsov@amd.com>, Zhigang Luo <Zhigang.Luo@amd.com>, Zhigang Luo
 <zhigang.luo@amd.com>, Fangsheng Huang <Fangsheng.Huang@amd.com>, YuBiao Wang
 <YuBiao.Wang@amd.com>, Philip Yang <philip.yang@amd.com>
Subject: [PATCH 5/6] drm/amdgpu: mark A+A VF VRAM mappings as system memory
Date: Mon, 28 Sep 2026 12:44:19 -0400
Message-ID: <20260928164421.10144-5-Zhigang.Luo@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260928164421.10144-1-Zhigang.Luo@amd.com>
References: <20260928164421.10144-1-Zhigang.Luo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A8:EE_|BY5PR12MB4290:EE_
X-MS-Office365-Filtering-Correlation-Id: 5db8d30c-f6ec-4d87-37b7-08df1d7fcfcd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|23010399003|36860700016|10067099003|260925022911599003|260925021911599003|260925021311599003|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: WDarx5YBbVgEGtS7Bgd6hdZtFZc6yfLlyKuufgnBZo+J81G19wHyeP8Fnl4zSSNEyeEr5Htg9bTfHpAiBB11lVKGUNQ9V0Byg4K3jimRz8Cp844z5ah7cHNu882zaubYqs+0/toftg7SL6vTs0i7OHtDsxvDT1OAqtxUZj/pwwyUFnKvXnVgkyH88LVzF7t4CS4KE1a5Xl0VQIVboN5F5CMZLqUyAH6zuAHsuv5I88clkmtZtm8DUOeSbz7+RHa8WEm0ClXsCsFT4pmXQghOfm5cF3jYCOhAFYGK1f62EF2k2mU4pD6LjnNMBozUxdmyBIv84unRnT3dTvLQBAbs8W1UWw9O6ZTkurvm3J64jqSA1Kmx2RaNKFKGrN0aPrXsxz6TUUDQ10T/ara3Yag5NmjLi/fYAy+z3hN19GC+u9dELI9e+xjnkuiwAjhzjbcSMyY7CTupPhcdnJiR9B45rC1zpTeZ1me+3t20y5iZDz80Y/Td7DRh2N4H8saWbpAHGpg/sQ+Ef9Y0lWxSZEaYp9onv7f+x1FglNYihLekd61TjEH3T4bfgNeo0Q7jdlNv5OCfSIuyTmQaQhrxv5y5vvDSKGvPWBjsFE5LtztS/DNjLypyubOpTtA6TQYJGoggn/4WTtMzthgMgROyEUhvj9KZHRSGWZfaOGjyu8waylInwTeQr6ZS2PxC05TccGAKy3GQc/A5kNyKPgHGaff1HA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(23010399003)(36860700016)(10067099003)(260925022911599003)(260925021911599003)(260925021311599003)(11063799006)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Z5vD4LpXY3B+i8lUJaWLj6bPj4TzC0+Yafe4SmxQAOUXiNJLexg6MfT14XqP/lNJZ1B5f+4ChBMFCfcm5yoz78rc0WJVX/aJNCZKvIkKegBADznq+ziwJ8Gz/KxQlogXncoqZyU4EIUyV8HCL40bfTZFsqLkqVnK91bUAAXfH3YRcC6C657Q7If+gHGyZsED9vpydpUTd48ReSWiYGZHgG4FQ7JtwIeKQwUc2PJVw5iil5eNaE+CEVBBC7e1v61zy6YspKxBIWAKiyWgyFG4KCn+Sr9uri3RHEoPXEpxt56EzPflJZo6iVcwvfkunJjvJ6vX2C17Nkw2FRYpH2dReMrtDnLkNbl3ayYTSEGhQrYkBX1YcV2nerk5+PtmG9TR2GLfDPRDbb77Gpsp5jYQ/H848j2zDWL9+WO9HlFlSrIbJS3bui7goV0utz3nE/qP
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2026 16:44:49.3858 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5db8d30c-f6ec-4d87-37b7-08df1d7fcfcd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044A8.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4290
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

On the A+A VF the GPU reaches its HBM over the system memory path at a
system physical address, so page table entries covering VRAM have to
carry AMDGPU_PTE_SYSTEM and the addresses they hold have to be physical
rather than MC addresses.

Set the SYSTEM bit in the PDB0 entries and in amdgpu_ttm_tt_pde_flags(),
and convert the VRAM address in amdgpu_gmc_get_pde_for_bo() with
amdgpu_gmc_vram_mc2pa().

NPA mappings still require VSCT=0011 (PTE.S=0). Clear SYSTEM in
gmc_v12_1_get_npa_flags() and amdgpu_ualink_peer_remote_init() so NPA
PTEs do not inherit the VRAM SYSTEM bit.

v2:
- Use (sriov_vf || passthrough) and amdgpu_virt_vram_is_spm() for
  PDB0/TTM SYSTEM bits and mc2pa.

v3:
- Rely on amdgpu_virt_vram_is_spm() without redundant VF/passthrough
  checks.

v4:
- Explicitly clear AMDGPU_PTE_SYSTEM for NPA (VSCT=0011).

Signed-off-by: Zhigang Luo <zhigang.luo@amd.com>
Signed-off-by: Fangsheng Huang <Fangsheng.Huang@amd.com>
Signed-off-by: YuBiao Wang <YuBiao.Wang@amd.com>
Reviewed-by: Philip Yang <philip.yang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c    |  9 +++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c    | 14 +++++++++++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c |  1 +
 drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c     |  1 +
 4 files changed, 22 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
index 7c0554506334..32bd8af93883 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
@@ -120,6 +120,11 @@ void amdgpu_gmc_get_pde_for_bo(struct amdgpu_bo *bo, int level,
 		break;
 	case TTM_PL_VRAM:
 		*addr = amdgpu_bo_gpu_offset(bo);
+		/* For SPM-backed VRAM, convert the MC address to a physical
+		 * address for system memory path access.
+		 */
+		if (amdgpu_virt_vram_is_spm(adev))
+			*addr = amdgpu_gmc_vram_mc2pa(adev, *addr);
 		break;
 	default:
 		*addr = 0;
@@ -1159,6 +1164,8 @@ void amdgpu_gmc_init_pdb0(struct amdgpu_device *adev)
 	flags |= AMDGPU_PTE_VALID | AMDGPU_PTE_READABLE;
 	flags |= AMDGPU_PTE_WRITEABLE;
 	flags |= AMDGPU_PTE_SNOOPED;
+	if (amdgpu_virt_vram_is_spm(adev))
+		flags |= AMDGPU_PTE_SYSTEM;
 	flags |= AMDGPU_PTE_FRAG((adev->gmc.vmid0_page_table_block_size + 9*1));
 	flags |= AMDGPU_PDE_PTE_FLAG(adev);
 
@@ -1178,6 +1185,8 @@ void amdgpu_gmc_init_pdb0(struct amdgpu_device *adev)
 	 * pointing to a 4K system page
 	 */
 	flags = AMDGPU_PTE_VALID;
+	if (amdgpu_virt_vram_is_spm(adev))
+		flags |= AMDGPU_PTE_SYSTEM;
 	flags |= AMDGPU_PTE_SNOOPED | AMDGPU_PDE_BFS_FLAG(adev, 0);
 	/* Requires gart_ptb_gpu_pa to be 4K aligned */
 	amdgpu_gmc_set_pte_pde(adev, adev->gmc.ptr_pdb0, i, gart_ptb_gpu_pa, flags);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index 3d620ec2937f..2b7b70fe90c9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -1460,9 +1460,17 @@ uint64_t amdgpu_ttm_tt_pde_flags(struct ttm_tt *ttm, struct ttm_resource *mem)
 			flags |= AMDGPU_PTE_SNOOPED;
 	}
 
-	if (mem && mem->mem_type == TTM_PL_VRAM &&
-			mem->bus.caching == ttm_cached)
-		flags |= AMDGPU_PTE_SNOOPED;
+	if (mem && mem->mem_type == TTM_PL_VRAM) {
+		if (mem->bo) {
+			struct amdgpu_device *adev = amdgpu_ttm_adev(mem->bo->bdev);
+
+			if (amdgpu_virt_vram_is_spm(adev))
+				flags |= AMDGPU_PTE_SYSTEM;
+		}
+
+		if (mem->bus.caching == ttm_cached)
+			flags |= AMDGPU_PTE_SNOOPED;
+	}
 
 	return flags;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
index ab564202f550..382fc7d85824 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
@@ -5876,6 +5876,7 @@ static int amdgpu_ualink_peer_remote_init(struct amdgpu_device *adev)
 	flags = amdgpu_ttm_tt_pte_flags(adev, bo->tbo.ttm, bo->tbo.resource);
 	flags |= AMDGPU_PTE_SNOOPED | AMDGPU_PTE_PRT_GFX12 | AMDGPU_PTE_BUS_ATOMICS;
 	flags &= ~AMDGPU_PTE_VALID;
+	flags &= ~AMDGPU_PTE_SYSTEM;
 	/* PTE.X=0 turn off RPC checks for RBs, wptr and doorbell NPA address */
 	flags &= ~AMDGPU_PTE_EXECUTABLE;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c b/drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c
index 565ee7fba3cd..bf455b3d3a43 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c
@@ -616,6 +616,7 @@ static void gmc_v12_1_get_npa_flags(struct amdgpu_device *adev,
 	*flags |= AMDGPU_PTE_SNOOPED | AMDGPU_PTE_PRT_GFX12 |
 		   AMDGPU_PTE_BUS_ATOMICS;
 	*flags &= ~AMDGPU_PTE_VALID;
+	*flags &= ~AMDGPU_PTE_SYSTEM;
 	*flags &= ~AMDGPU_PTE_EXECUTABLE;
 }
 
-- 
2.43.0

