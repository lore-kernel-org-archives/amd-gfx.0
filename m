Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 248F6606A89E
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Nov 2026 19:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=0ZhugIM7
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 10D0C10E440;
	Wed, 11 Nov 2026 19:23:48 +0000 (UTC)
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012045.outbound.protection.outlook.com [52.101.53.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4B36410E3FB
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Nov 2026 19:23:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jNfIloUdAyz+jee3XO9GMTNOpYdrwFsSmXZQ9q7FDqKToLN5gEt4p+oWt6X5PbUqSBcZL0wpFr0IRF6HTTyxfkQsYYnm33Uz2r39fiAvPC8rEcT+fjFZx+qjJa9jgO8psyj6bDnfp7edPGRhzIKB8/IwTG/eFK3Ki5sY3bx6mA7y08dUjNzSYPJ/r1UnLU9lwnp6NZQ+GBr0Q+PMn8PN2SQAU/9nHQi10jIhh5riq1UHViJngLvn6+GBOkfzswuvStWBZspWOABSDjs2Bhbv0s877I9aTSFew32ce0AzhQli//OpGNa6dJjqBOsUBoYRRa0gh5wfIizsU/7ovYdlbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=05DqEh9WIPlqBMOsyz6qaw8ujY2JPd4r8deBMu0ucgo=;
 b=SM4ZGneZP143hI26QGJ3VpbrJPjz1tx0nlM2bFk9wrpOgIzev6iu+I42XwV+TX2LLVM2O9GAeLXPCCnyrvVGkAvOdggPmvOSmk/N0ynqF7x6rkO2SdiUN4oVpaYH70xOI2fyz3QZFgSYZ7wiZheiQOLSruU/SckuY9uf17hQkJNtZ+KFu4kjk9RjoKf26ECzNt4wFKy2GrfL0GAxj9QUYRIl0oErXVaAHGM7L4AWcqKRHNw2FjuJOeTDHMszK//HRjJSiHPwuF0zfnLsNUjJCjivFhhzcbaKqfbx8d8uQLkeVbwk4jgO3IUdJmGuZYhgNZaXarLi0wJ2/NnszqmAjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=05DqEh9WIPlqBMOsyz6qaw8ujY2JPd4r8deBMu0ucgo=;
 b=0ZhugIM7BoZP3ASVGVHRAGHMt8uBfdw4/Rdzl/HJnLZwQwMw9Lr2W1pX46N+47mVOmCJJGK5a3avV493Wcj08kfTc4WgAqYCoK20YTib7m/tgctbyGj75bOWQtvR7eEWgwRL5vImzrqH9Cluj39Fz+YM+UWuwcF3W8Jf84Fo0E0=
Received: from YT4PR01CA0106.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:d7::12)
 by BN7PPF521FFE181.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::6d0) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.11; Wed, 11 Nov
 2026 19:23:37 +0000
Received: from BN3PEPF00022BC0.namprd04.prod.outlook.com
 (2603:10b6:b01:d7:cafe::65) by YT4PR01CA0106.outlook.office365.com
 (2603:10b6:b01:d7::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.9 via Frontend Transport; Wed, 11
 Nov 2026 19:23:37 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF00022BC0.mail.protection.outlook.com (10.167.248.123) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Wed, 11 Nov 2026 19:23:37 +0000
Received: from MKMZHLUO01.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 11 Nov
 2026 13:23:35 -0600
From: Zhigang Luo <Zhigang.Luo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <alexander.deucher@amd.com>, <christian.koenig@amd.com>,
 <Hawking.Zhang@amd.com>, <Lijo.Lazar@amd.com>, Zhigang Luo
 <Zhigang.Luo@amd.com>, Zhigang Luo <zhigang.luo@amd.com>
Subject: [PATCH 3/4] drm/amdgpu: set the A+A VF SYSTEM bit in the GFX 12.1
 helpers
Date: Wed, 11 Nov 2026 14:23:17 -0500
Message-ID: <20261111192319.297456-3-Zhigang.Luo@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261111192319.297456-1-Zhigang.Luo@amd.com>
References: <20261111192319.297456-1-Zhigang.Luo@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF00022BC0:EE_|BN7PPF521FFE181:EE_
X-MS-Office365-Filtering-Correlation-Id: 8cd7a9bf-3a3a-4220-9c25-08df402948ed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|23010399003|1800799024|36860700016|22082099003|18002099003|10067099003|56012099006|261021123027099003|11063799006|261102123227099003|261021121427099003|261009223027099003;
X-Microsoft-Antispam-Message-Info: 5yddA2M00Vf6NmZmd9LZpCQnRziDDwmtjScDC9bTrZrzOvYUF5aMp42d+YUMvo/w8zOZOTo9r5JDkdCzfp2lLtcYlYjTgPG0a7n7o/871doBx3g6e/XjtctDY9hfxGBAbVJeo8FbROSvWlamv/FHRIjN4WqoaUVrkOftiILAfsGooK/qEynJKh0cDCWox19KwkUAdLFqcw+WdJMMsvXw5V7u0iAozVDVYxMB0yZEGxc0RjmQc5wvSyD0CSAWyY03r6pXtlNUmVRcJMBNBVIdylwDUIfn6139LVCcsOqrwP8sov9TH89j8PMXuhGRfAMOomN7zpukkUPGgg6Obr4Slr+0QJIhIGpNvTQB0JkVD9MG0CanKAq7ayKHDvwkqJ0tk3PQUrZ9R3El94T7brIlm7Va2iSsU5rqMuoPxSky4PfAjqc7oIJ1UxomILQbq86llx7+myzffVqM1wNVmYXCvT8AYuKLDrzpHVY6MnCt2iavDs/Qw0ku8smRf5tePSLwJwGwnAOREo2ibohu5/TSFoNQvolzVgQovwfMdUwBmThGX2819+AhEzKtOcfEfptIt5pHDw8hhedijWtSHo1Xh4GusCOfmyMCLXVlbRRPUSSgkPfnl+Z3MWLumVR320UdZpd9Y4kmTbuoVkvzP+0zQLR6sAIwymxcd9VeDKek3Im4fyAHBE3gEmc1NLTo7Db/u4PsQhjI228K39At2DRd+Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(23010399003)(1800799024)(36860700016)(22082099003)(18002099003)(10067099003)(56012099006)(261021123027099003)(11063799006)(261102123227099003)(261021121427099003)(261009223027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: TnJ/xLYNnK8E1IzvW12sgCjMn7AN7qiA+Zi7pXWfbWSNfnBsubWLhmyYrMjeGqKBaSuGweAb80ImsFge/kROSn7UnXU7jsSUUQ5rnTNv5YPmND102heDje1biROmpF8ea9Dai0Rs4OhpmRLhkAO44O/KFPDb/9UTqhNKNEwSA2gAVrAn/0qkhCQObqqWtXrvcXo+Uq9z5SJCWmmOgY5+z1uHRmtWrE/bvhmLN7HiZT1q00rtJyEU7S5wrF3R9TxET47ahQkIipYt2fOREzQODg8afS1EV2aG8Cr1z0ZRVkNWt0GkLFlSsS7Me6vIOV238WhOl69Q4+BB9RmxVokCaS8Du9lC/s8VMZcJZvbMvCi9zljhctVMyvBSHacP45KvwWh7iDHkfPEALwD2VQvtemIvys9gcbtimcnJaklkZ7hxTcd4/rysDz8RiIMe/PeP
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2026 19:23:37.0840 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8cd7a9bf-3a3a-4220-9c25-08df402948ed
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF00022BC0.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPF521FFE181
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

gmc_v12_1_get_vm_pde() converts a VRAM MC address to a physical
address and skips that conversion when AMDGPU_PTE_SYSTEM is already
set. Set the bit after the translation so the address stays physical.

PDB0 is filled through amdgpu_gmc_get_vm_pde() so those entries take
the same path. The VRAM entries are PDE_PTEs and already hold a
physical address, so the translation is skipped. The GART PDE is
given the GART BO's MC address and translated once.

gmc_v12_1_get_vm_pte() sets the bit only for VRAM. SVM VRAM ranges
call it with a NULL buffer object and leave the bit clear. NPA
mappings are left unchanged.

Signed-off-by: Zhigang Luo <zhigang.luo@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c | 22 ++++++++++++++++------
 drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c  | 12 +++++++++++-
 2 files changed, 27 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
index 659e89e5e78f..04cf02dd22ac 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
@@ -1272,7 +1272,7 @@ void amdgpu_gmc_init_pdb0(struct amdgpu_device *adev)
 	u64 vram_size = adev->gmc.xgmi.node_segment_size * adev->gmc.xgmi.num_physical_nodes;
 	u64 pde0_page_size = (1ULL<<adev->gmc.vmid0_page_table_block_size)<<21;
 	u64 vram_addr, vram_end;
-	u64 gart_ptb_gpu_pa = amdgpu_gmc_vram_pa(adev, adev->gart.bo);
+	u64 pde_addr, pde_flags;
 	int idx;
 
 	if (!drm_dev_enter(adev_to_drm(adev), &idx))
@@ -1290,10 +1290,16 @@ void amdgpu_gmc_init_pdb0(struct amdgpu_device *adev)
 	vram_end = vram_addr + vram_size;
 
 	/* The first n PDE0 entries are used as PTE,
-	 * pointing to vram
+	 * pointing to vram. PDE_PTE already holds a physical address, so
+	 * get_vm_pde() skips translation and sets S for SPM.
 	 */
-	for (i = 0; vram_addr < vram_end; i++, vram_addr += pde0_page_size)
-		amdgpu_gmc_set_pte_pde(adev, adev->gmc.ptr_pdb0, i, vram_addr, flags);
+	for (i = 0; vram_addr < vram_end; i++, vram_addr += pde0_page_size) {
+		pde_addr = vram_addr;
+		pde_flags = flags;
+		amdgpu_gmc_get_vm_pde(adev, AMDGPU_VM_PDB0, &pde_addr, &pde_flags);
+		amdgpu_gmc_set_pte_pde(adev, adev->gmc.ptr_pdb0, i, pde_addr,
+				       pde_flags);
+	}
 
 	/* The n+1'th PDE0 entry points to a huge
 	 * PTB who has more than 512 entries each
@@ -1301,8 +1307,12 @@ void amdgpu_gmc_init_pdb0(struct amdgpu_device *adev)
 	 */
 	flags = AMDGPU_PTE_VALID;
 	flags |= AMDGPU_PTE_SNOOPED | AMDGPU_PDE_BFS_FLAG(adev, 0);
-	/* Requires gart_ptb_gpu_pa to be 4K aligned */
-	amdgpu_gmc_set_pte_pde(adev, adev->gmc.ptr_pdb0, i, gart_ptb_gpu_pa, flags);
+	/* MC address. get_vm_pde() translates it once and sets S for SPM.
+	 * Requires the GART PT to be 4K aligned.
+	 */
+	pde_addr = amdgpu_bo_gpu_offset(adev->gart.bo);
+	amdgpu_gmc_get_vm_pde(adev, AMDGPU_VM_PDB0, &pde_addr, &flags);
+	amdgpu_gmc_set_pte_pde(adev, adev->gmc.ptr_pdb0, i, pde_addr, flags);
 	drm_dev_exit(idx);
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c b/drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c
index 76391fca6c62..0fbf4525947a 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c
@@ -586,6 +586,12 @@ static void gmc_v12_1_get_vm_pde(struct amdgpu_device *adev, int level,
 		*addr = adev->vm_manager.vram_base_offset + *addr -
 			adev->gmc.vram_start;
 
+	/* SPM VRAM is reached at a system physical address. Set S after the
+	 * translation above so that translation is not skipped.
+	 */
+	if (amdgpu_virt_vram_is_spm(adev))
+		*flags |= AMDGPU_PTE_SYSTEM;
+
 	if (*addr & ~adev->gmc.pte_addr_mask) {
 		dev_err(adev->dev, "Invalid PDE address: %llx\n", *addr);
 		*addr = 0;
@@ -756,8 +762,12 @@ static void gmc_v12_1_get_vm_pte(struct amdgpu_device *adev,
 		break;
 	}
 
+	mem = bo ? bo->tbo.resource : NULL;
+	if (amdgpu_virt_vram_is_spm(adev) &&
+	    (!mem || mem->mem_type == TTM_PL_VRAM))
+		*flags |= AMDGPU_PTE_SYSTEM;
+
 	if (bo) {
-		mem = bo->tbo.resource;
 		if (mem && mem->mem_type == AMDGPU_PL_NPA) {
 			dev_dbg(adev->dev,
 				"Setting PTE for NPA BO, mem->type: %d, mem->start: %lx, mem->size: %u, cur_flags: %llx\n",
-- 
2.43.0

