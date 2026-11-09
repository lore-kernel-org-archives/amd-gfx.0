Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DFC4606A31C
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Nov 2026 16:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=OYBuvWsM
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E301810E268;
	Mon,  9 Nov 2026 16:26:50 +0000 (UTC)
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012009.outbound.protection.outlook.com
 [40.107.200.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6316F10E268
 for <amd-gfx@lists.freedesktop.org>; Mon,  9 Nov 2026 16:26:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MldnuKTEJRdDOQQQ8IrT8eQF6WvOhfF4MC/DwerwD9XoIDohDpVFIc0XRV6JOgWa350Lny4lREEG7cRY4TPhldbtGeSVbCPsYerJ/G8Upva1yLg8O6UvHmBWMSJGk7dlaIInnCCWh24fP9IRUlQGnW8dBik/1h+VRMUIbuzo541Yo8ySjOdmd2wRDx55ph2bGHoyT5PkNBt3bkup8X4Pj/qHMMcF6GRRuBkHkNokCf4XEQWd/qfxpcXw2GCLGe6Tpduo6/LXuieg3rpb2IYSWymg5XZnrywsywWgiOr3lBpQXBcLMce5uPTa8uhW+Ekc3iYBl8gQNEr2/FXZ76YuMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Boeop3t/ryHPl0Woz43fbKm9K41x9RpqowvQ8D055iY=;
 b=AAHIsn8/IGhhbv7lOeblwRiC+F3+vc0SSgMFBwdoxCNJtEODIVNZI5b858XOUsjw1I5QW9//8q+C/UikCSGXz3Bkf8pY9Gn7Pmghh0JrJe+ySLXAMUo9k5gYvKMtqgzuISoYYUZc+l6Hs9Jx7o3E1aNiygycO2FLD4suiekA/FICDFC3QNKPhYrJY3FVfoL64pJKtv8ZgdL8SVbO/2iyWll61zuMiAew4ZULUbT6A+V/rPQkfpZk9ja2DQ5h9aD24gVrzn3qLktcaKEKsuJCmhYwhXhRek8rocovQZJE2Ys/M9vGqI4bWN81BQTqiutKdCAkrCe3ePo1ou6kcUbMkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Boeop3t/ryHPl0Woz43fbKm9K41x9RpqowvQ8D055iY=;
 b=OYBuvWsMsHuCLi0m1MXkWMMeXK2VLg2jqJN9N6CBRO6OxRqytEkrRWC3nWRvzGGgsf2xaZZ0l5/6kLq+2V+HgHFSxOi7C24lpHD/jPibrw5bsFgxuvGNk/hpY0HnUz/aPDN6dqq9nVS+xpGaJVknAt6fZZAv4qfw2JCU6YdwIbU=
Received: from CH0PR07CA0015.namprd07.prod.outlook.com (2603:10b6:610:32::20)
 by CH1PPFB21296325.namprd12.prod.outlook.com
 (2603:10b6:61f:fc00::620) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.11; Mon, 9 Nov
 2026 16:26:34 +0000
Received: from DS2PEPF00006E25.namprd05.prod.outlook.com
 (2603:10b6:610:32:cafe::39) by CH0PR07CA0015.outlook.office365.com
 (2603:10b6:610:32::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.13 via Frontend Transport; Mon, 9
 Nov 2026 16:26:34 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS2PEPF00006E25.mail.protection.outlook.com (10.167.23.218) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Mon, 9 Nov 2026 16:26:33 +0000
Received: from MKMZHLUO01.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Mon, 9 Nov
 2026 10:26:33 -0600
From: Zhigang Luo <Zhigang.Luo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <alexander.deucher@amd.com>, <christian.koenig@amd.com>,
 <Hawking.Zhang@amd.com>, <Lijo.Lazar@amd.com>, Zhigang Luo
 <Zhigang.Luo@amd.com>, Zhigang Luo <zhigang.luo@amd.com>
Subject: [PATCH 1/4] Revert "drm/amdgpu: mark A+A VF VRAM mappings as system
 memory"
Date: Mon, 9 Nov 2026 11:26:12 -0500
Message-ID: <20261109162615.167236-1-Zhigang.Luo@amd.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00006E25:EE_|CH1PPFB21296325:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b6cfa21-6241-49a9-f91f-08df3e7e3836
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|23010399003|376014|1800799024|18002099003|10067099003|11063799006|261102123227099003|261026121527099003|261009223027099003|261021121427099003|56012099006|261021123027099003|261009221227099003;
X-Microsoft-Antispam-Message-Info: NhX5hpdE97CjkTTU+pO219Jx/QwnTAL0NJiED4HwrmavP84zyfLYubQZ/EmSK3ljSn4wJfPOYXnmTTRGgLPw18SlPCgmwVPWM9OFP3kvjyLMuwNqwBa0C2seDdsaFP3UeVkqIbq/pKnepuizwRn0IYZzJ05zUY7Jjkf/M82MOTTc+P0X+9cX3TSxdRPb1OCX6Xu3ZpjeBKzmoFHoIaaRgF/pja/tFVU+ciikAy7hviDmpnChS6WjEPadSZRTXl2LpsW0xL2MiE7lHAaKH9icsgtzDc4JzkpuPK8yobbgaT9ajrUuLh7R0Fs8LwJN8A1w1n/swm9JfI9n9hYrjpykJlKPNtX9NKBI7n+CxcXdp8J7h0TCKyux9KxmdrUH0w3h2G8q58tGzvGtvX5fcWzcE4E41e5S7h/0lBu5OKhP7to9cmY2zXWdSN+hpPISaq4iTNfgHNbQWgNtovm242pIUJ7UpqW6nCYJo4phQm6ixTWysnXyfNiIeQmxxWvj+WFoyyYr9IVyB+M6b9JSHyHB0PtRLucVaRcWr46KJdP20nFvBJTaoTSI1Wu0JpcVZ1O15gHu+i+P8oNhqXV9P3x2HQJmK7b1R7YwRzd6WIbgimKmLJSzKxD8xfe6dB/EykVERBATxOXtJ3NxfeRcIApBp/pyn6DPgibxk0KnfemWQytU2e2oZuBkLQx5T8G1jMRrn8oTNMG1p27LzVuycJacsw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(23010399003)(376014)(1800799024)(18002099003)(10067099003)(11063799006)(261102123227099003)(261026121527099003)(261009223027099003)(261021121427099003)(56012099006)(261021123027099003)(261009221227099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Tp+gV9n2uBbL2JShfmFRyIOIblSES1gmPSTxD+uMIkE7vPhWzFF3oxRtEmkiFTy5Z2TNDN6PnscR5ZH2e7Za/iBjnlMdbRYdaDPSUp5ewUss/g8yT4v6C/BTwUyWjA4WINyRInYc7BST4Oxmpu2Qq38rr4HLS+8C+5mUDvzDnn9h4oSh7IHcwldsMuuC5OCC9/F0Snf7J6rZcEdqwoR4EL9y39/McxaUAH0H06n/OEbOZ8z7WK+JxQHyKpoUkj4NBKevITpd1A7mMe2SKd5z/O8xR3Q/YRtGDxCM116V2S3fBbp6I8XMaLJT80KvwGcGcFeparZsKPj5zDynr/UJstTT7/QmjxTcnei5fb7gLof++RrFWrJEUnblrMvD0tznSzQVPVKpvkab8vHilGwZP0nQ2byTwgXt0mjJHYnm3aCy+SIvhbqHd8NIKS0n6d9/
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2026 16:26:33.9041 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b6cfa21-6241-49a9-f91f-08df3e7e3836
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00006E25.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PPFB21296325
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

