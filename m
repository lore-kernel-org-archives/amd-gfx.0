Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21732606A333
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Nov 2026 14:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=0PLsHME7
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AE6A710E6D9;
	Fri, 13 Nov 2026 14:57:33 +0000 (UTC)
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013031.outbound.protection.outlook.com
 [40.107.201.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4BEE710E7A3
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Nov 2026 14:57:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=URobYCsqvJeaH4dcuo5YC823/t1KYVjEqO89VUOkmqUuk8//lbk+FD2bjtrc+e6R63Uju77oULM34to9E/5p7fM1U5v84YX5JIiYnnE9hyPBYiVozDY/BH2wJqNnFQII5VKEtLrCFww6fgRghcZXHSil12rDmENSzRXAKQafCZkHbKAwf1xtar6pQJC2r5OYWesGjsOCzK1Ouo4L0xSnwhJHEXUh8Il8AQ2v+vvMvXvte2LlwpWXgEduXrk6nXIaeflsgEbap8yIpeIeMrOnGZXdI9FFAlhAC4Gel70q/2KbzVYZK7JbtRNqJ9C/UJxXYOlOiROA0tF3eT1FpDKWqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Boeop3t/ryHPl0Woz43fbKm9K41x9RpqowvQ8D055iY=;
 b=tca9G9nN8tP9GMs00AN1V3pxHAvOeC9n8zCNDvX9c/x95+0XaOYt7q6N4+zZVDN0Jj3P4HepFm/0cV9s6xLLeOtH32BfbrOQajF+KTOjFk0Pm1k0t8zS2TgxiqtdnfHGK4xjv0ol/eaYdd5UE9cptWEcni17dlE7K0SDOJg78qYhS/+o19Ck21HiXCah0jmBRdcqSGGBuEbPbwQ0WfOOy7uBB8P3e7hpwoWMrHnqIAMy1e9S0Yvi2EFEc2Lk0p1YIPBI1zWSiLIWYyALoWwDrC7JFKkQEHc6XOTly2v+pDt0oP9h78JzKgXa8/7MDLl+0Guv0tBCxInz6je6IC/TYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Boeop3t/ryHPl0Woz43fbKm9K41x9RpqowvQ8D055iY=;
 b=0PLsHME7Id4h9ULv3z6TXzKsqCF4tfqTq+ES8FzjbJ7NuEpW8gu+7PT7L7l58FLYocwSzSXMm8X1WprmaLIYTb/VoKFEix4F2HjaFwRjAYTkmt9+FPKnp5kihIyvYXyP8+sbiPZjpIKJ9wvJMCnxfy7jDmNey+fkwK2PeugJUaA=
Received: from CY8PR19CA0044.namprd19.prod.outlook.com (2603:10b6:930:6::13)
 by LV0PR12MB999092.namprd12.prod.outlook.com (2603:10b6:408:32e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.10; Fri, 13 Nov
 2026 14:57:22 +0000
Received: from CY7PEPF000000F3.namprd05.prod.outlook.com
 (2603:10b6:930:6:cafe::3d) by CY8PR19CA0044.outlook.office365.com
 (2603:10b6:930:6::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.9 via Frontend Transport; Fri, 13
 Nov 2026 14:57:20 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY7PEPF000000F3.mail.protection.outlook.com (10.167.247.151) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Fri, 13 Nov 2026 14:57:20 +0000
Received: from MKMZHLUO01.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Fri, 13 Nov
 2026 08:57:18 -0600
From: Zhigang Luo <Zhigang.Luo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <alexander.deucher@amd.com>, <christian.koenig@amd.com>,
 <Hawking.Zhang@amd.com>, <Lijo.Lazar@amd.com>, Zhigang Luo
 <Zhigang.Luo@amd.com>, Zhigang Luo <zhigang.luo@amd.com>
Subject: [PATCH 1/7] Revert "drm/amdgpu: mark A+A VF VRAM mappings as system
 memory"
Date: Fri, 13 Nov 2026 09:56:56 -0500
Message-ID: <20261113145702.323968-1-Zhigang.Luo@amd.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY7PEPF000000F3:EE_|LV0PR12MB999092:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b955b4c-d540-4bbe-d87a-08df41966aee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700016|376014|23010399003|18002099003|261009221227099003|261009223027099003|11063799006|56012099006|261102123227099003|261021123027099003|261021121427099003|261026121527099003|10067099003;
X-Microsoft-Antispam-Message-Info: vsnij69bKVAOy/mdlOiCiLeEo1mMgelW/K5WGyUapHXtQjlz5vI3TBWrI8CraNhIBth9KGPXRhm/Q8lTNgBd1z3R1Br6+FhFeNQhllQTT71Ki9TmBoRukc5EIl/5kXDF9tJqZWwUjmzSn1zihVLpYbczX7AjU/hAY129QhTIjvkwHrC1CEnNb4MnjyXJY0xJONQt7ONv8r78Ct5yKpnWpisD1hT30usgp31R1JJtIJki3VXKirkBUtFqieuOSNFm+Uy0juscCeCEiye4jZQ+ji7V25YxF4cfH44h89ka7PCeLsVVk0d7QwU/0vESAQGodgEpu2DROH2qVT917ZYPFaPv3V4yJe9EtdoBjFJwi7AlDzzx+UsaX/t+tQ7+XCd6N00fXwQewk6U7JAJH7AYJFtV5C8oTGw48nxx22+Xgsv3z35cbeK4yqb6PeuzZzB8Upr83FdAI/EjIN7F9KuBGACERw4WnNfnyUQbATW7j6TSCjc7ot5LvqdJwKsBUHMcDbN+Ub4rdeMCvnPaPhqvn598vDuRvRp9SkOuPRFyU5ePgkcnhPacb0RK6Elwkk0tWHHZTYD29xlVIgU2Bxnm9qsz7Rk2SDBmhAuKx0JbKwZDWJRxS5XdpUtmRXaePSj5/4pTa8HGqQ+rolTgZfVmTo32g/ir8jFQjlC7vj9z+YRhaCFwSvL++GDY/lRowEHfdPK5kqIi5/W+4RhCYspSKw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700016)(376014)(23010399003)(18002099003)(261009221227099003)(261009223027099003)(11063799006)(56012099006)(261102123227099003)(261021123027099003)(261021121427099003)(261026121527099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: hPHg+atTlMd42MEgFZOCz4fteCPEvrQnr6qTSxYTV9j5wr4agI5723PVrNWBx6NfaxtPDa1Y4rlfhPabBZZvp/DJowiLhGCUX4ckXh1hMAfmN/8frQI8VFhApaYRKqVB8qZynjNoP5nsEFInZZ3qBFZ3S3+3A2RhX2tixdvkJgCJdD6xJQlKdejONHfJq6de9+ZlFY1ueDAzsQXl9oF/4kq/Sso8K0NgbubzWGE98kitrxftZE28IbV2G4KZgrDm4kTy0cWidOMrgpK92jY4NKUGR0fZFQ627YSNbs0WwSTok7ONzmJmUjHrcjXNCVqDcXvzGGmZd2vlVyVVteMXQ/kKIwewZr5tKZnM1J4Efq4Kb/ZRefCWIcThAGJmz7Vk7Hg03/QK0+7BOyRH+sUl3KH8DZyqCHgg3GW1pka24c7oeEf1qx2FwZirPLJf99xB
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2026 14:57:20.3936 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b955b4c-d540-4bbe-d87a-08df41966aee
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY7PEPF000000F3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV0PR12MB999092
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

This reverts commit 521bedfc94cc.

The patch sets AMDGPU_PTE_SYSTEM in amdgpu_ttm_tt_pde_flags() and
converts the VRAM address with amdgpu_gmc_vram_mc2pa() inside
amdgpu_gmc_get_pde_for_bo(). gmc_v12_1_get_vm_pde() already converts
an MC address to a physical address and skips that conversion when
the SYSTEM bit is set, so setting the bit first bypasses the
translation.

The bit belongs in the GFX 12.1 helpers, after that translation.
PDB0 is written directly and does not go through get_vm_pde(), and
NPA still requires PTE.S=0, so those two pieces come back in the
following patch.

Signed-off-by: Zhigang Luo <zhigang.luo@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c    |  9 ---------
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c    | 14 +++-----------
 drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c |  1 -
 drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c     |  1 -
 4 files changed, 3 insertions(+), 22 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
index 4204c3c750a8..659e89e5e78f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
@@ -122,11 +122,6 @@ void amdgpu_gmc_get_pde_for_bo(struct amdgpu_bo *bo, int level,
 		break;
 	case TTM_PL_VRAM:
 		*addr = amdgpu_bo_gpu_offset(bo);
-		/* For SPM-backed VRAM, convert the MC address to a physical
-		 * address for system memory path access.
-		 */
-		if (amdgpu_virt_vram_is_spm(adev))
-			*addr = amdgpu_gmc_vram_mc2pa(adev, *addr);
 		break;
 	default:
 		*addr = 0;
@@ -1286,8 +1281,6 @@ void amdgpu_gmc_init_pdb0(struct amdgpu_device *adev)
 	flags |= AMDGPU_PTE_VALID | AMDGPU_PTE_READABLE;
 	flags |= AMDGPU_PTE_WRITEABLE;
 	flags |= AMDGPU_PTE_SNOOPED;
-	if (amdgpu_virt_vram_is_spm(adev))
-		flags |= AMDGPU_PTE_SYSTEM;
 	flags |= AMDGPU_PTE_FRAG((adev->gmc.vmid0_page_table_block_size + 9*1));
 	flags |= AMDGPU_PDE_PTE_FLAG(adev);
 
@@ -1307,8 +1300,6 @@ void amdgpu_gmc_init_pdb0(struct amdgpu_device *adev)
 	 * pointing to a 4K system page
 	 */
 	flags = AMDGPU_PTE_VALID;
-	if (amdgpu_virt_vram_is_spm(adev))
-		flags |= AMDGPU_PTE_SYSTEM;
 	flags |= AMDGPU_PTE_SNOOPED | AMDGPU_PDE_BFS_FLAG(adev, 0);
 	/* Requires gart_ptb_gpu_pa to be 4K aligned */
 	amdgpu_gmc_set_pte_pde(adev, adev->gmc.ptr_pdb0, i, gart_ptb_gpu_pa, flags);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index 212d86adffd8..37f7f421b470 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -1461,17 +1461,9 @@ uint64_t amdgpu_ttm_tt_pde_flags(struct ttm_tt *ttm, struct ttm_resource *mem)
 			flags |= AMDGPU_PTE_SNOOPED;
 	}
 
-	if (mem && mem->mem_type == TTM_PL_VRAM) {
-		if (mem->bo) {
-			struct amdgpu_device *adev = amdgpu_ttm_adev(mem->bo->bdev);
-
-			if (amdgpu_virt_vram_is_spm(adev))
-				flags |= AMDGPU_PTE_SYSTEM;
-		}
-
-		if (mem->bus.caching == ttm_cached)
-			flags |= AMDGPU_PTE_SNOOPED;
-	}
+	if (mem && mem->mem_type == TTM_PL_VRAM &&
+			mem->bus.caching == ttm_cached)
+		flags |= AMDGPU_PTE_SNOOPED;
 
 	return flags;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
index 11f022c56667..3bb426b33af9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
@@ -6171,7 +6171,6 @@ static int amdgpu_ualink_peer_remote_init(struct amdgpu_device *adev)
 	flags = amdgpu_ttm_tt_pte_flags(adev, bo->tbo.ttm, bo->tbo.resource);
 	flags |= AMDGPU_PTE_SNOOPED | AMDGPU_PTE_PRT_GFX12 | AMDGPU_PTE_BUS_ATOMICS;
 	flags &= ~AMDGPU_PTE_VALID;
-	flags &= ~AMDGPU_PTE_SYSTEM;
 	/* PTE.X=0 turn off RPC checks for RBs, wptr and doorbell NPA address */
 	flags &= ~AMDGPU_PTE_EXECUTABLE;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c b/drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c
index b67683012002..76391fca6c62 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c
@@ -616,7 +616,6 @@ static void gmc_v12_1_get_npa_flags(struct amdgpu_device *adev,
 	*flags |= AMDGPU_PTE_SNOOPED | AMDGPU_PTE_PRT_GFX12 |
 		   AMDGPU_PTE_BUS_ATOMICS;
 	*flags &= ~AMDGPU_PTE_VALID;
-	*flags &= ~AMDGPU_PTE_SYSTEM;
 	*flags &= ~AMDGPU_PTE_EXECUTABLE;
 }
 
-- 
2.43.0

