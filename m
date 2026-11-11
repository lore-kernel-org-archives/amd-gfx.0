Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C70F606A8A4
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Nov 2026 19:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=bGjQQKd4
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 044CB10E44B;
	Wed, 11 Nov 2026 19:23:44 +0000 (UTC)
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010028.outbound.protection.outlook.com [52.101.46.28])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2BEB210E32D
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Nov 2026 19:23:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=koMz33oyW+cb3Chqd9/+aT8/gN7CqM715nDFiZGDu2hRf75EK8vIxUo3Gn7MueC3D/XaWX5Jrxr+0Z3T8TJ6lLjhQaWf5X9YgKC5TycdLQzdR9014lK+US3cZMjyo4o5FzT+vDArhOc9Xks34QS9USoKA9ytgvLeOFjNPQmm/uDt49/fHUnWbQUYEOdEQIpVcRYB4VVlzy3YdcBPzb5ukopIykK9CSpgPgi+N8EkZzhAteOftJ+z21v/anEm42ospIGYSsX14xV2Ik8pLh/CzOqi9j397G/0pfcd57YPv9cJaBPClkNXQ5ssgSw02H0nie298banGzD6BdySWu9BfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Boeop3t/ryHPl0Woz43fbKm9K41x9RpqowvQ8D055iY=;
 b=gMCVgwigPMup6UcRtao5PQEUqT2/Gny4EeHOvmQjlGmolm+SyDhNpGm4bG6burqhAzMPxAWApEmNr/2flTXeOApsqYY2tPpk4qWv00HkxvDvCxKWn2Ou5PQPueVE6Ll4kppGWlOzELPYChjAIm/1vUYwfqERWEFNuNuULo50iH2/Kk80xBhBEcCUpnFv4J2mjlEw3LWV5Knla5YyAiG++sHp0kNiXCWSEmtHzjSSxSSo5GY0JgKjBnwztkfFJZJE2SleljW73J3F3Ag9V66RC53vuEL+rhx0CUpypcHp4PrZy1beSX2g53kYmDDt/c0x2CEyS9+yyZqy6Gf1GsX0vA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Boeop3t/ryHPl0Woz43fbKm9K41x9RpqowvQ8D055iY=;
 b=bGjQQKd492XZiaoPWIGMGrVleMyAZ5bMHYevru/3SPW5FgWWlIpBN3yXqiUfHpLQf8PxppgiY3D4IH0qfdwt/vhTFS5qEgGTDEODY+wlgUNJ5JIUQUn292UX+skQLzZed8A/Vty8CY7t7rTlhKJm/KcMPL6asfEvlMTYBp9wZCE=
Received: from MN0P221CA0024.NAMP221.PROD.OUTLOOK.COM (2603:10b6:208:52a::24)
 by IA1PR12MB8238.namprd12.prod.outlook.com (2603:10b6:208:3f9::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.9; Wed, 11 Nov
 2026 19:23:34 +0000
Received: from BN3PEPF00022BBD.namprd04.prod.outlook.com
 (2603:10b6:208:52a:cafe::aa) by MN0P221CA0024.outlook.office365.com
 (2603:10b6:208:52a::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.9 via Frontend Transport; Wed, 11
 Nov 2026 19:23:34 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF00022BBD.mail.protection.outlook.com (10.167.248.117) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Wed, 11 Nov 2026 19:23:34 +0000
Received: from MKMZHLUO01.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 11 Nov
 2026 13:23:32 -0600
From: Zhigang Luo <Zhigang.Luo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <alexander.deucher@amd.com>, <christian.koenig@amd.com>,
 <Hawking.Zhang@amd.com>, <Lijo.Lazar@amd.com>, Zhigang Luo
 <Zhigang.Luo@amd.com>, Zhigang Luo <zhigang.luo@amd.com>
Subject: [PATCH 1/4] Revert "drm/amdgpu: mark A+A VF VRAM mappings as system
 memory"
Date: Wed, 11 Nov 2026 14:23:15 -0500
Message-ID: <20261111192319.297456-1-Zhigang.Luo@amd.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF00022BBD:EE_|IA1PR12MB8238:EE_
X-MS-Office365-Filtering-Correlation-Id: 370f9d58-0c6f-4826-7684-08df40294745
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|23010399003|36860700016|10067099003|11063799006|261021123027099003|261021121427099003|56012099006|261009221227099003|261009223027099003|261026121527099003|261102123227099003|18002099003;
X-Microsoft-Antispam-Message-Info: M2xFQjxOMu3oSxfKo7Io3yqQ7qb+7WA809pP20rWJ9xB7XrBsPI9it+Bm3SJG0tAN9nFi2ocRVuFvtYadKomdrkjl9zmQAvNX6CUZpUp+bkkl/RTbh1R2QSqEfAMg+n5JA+CFlgnGkJGFav1e/yd+3MXO887NS5TjNWf31A8eULONKY02yvnIO7yOYSrj6dp+BTMU/GkC9NxRdx4Prp5uFTHZ3dCw3PHV+gQHUCASSntvVHCnd97pvcrN8933i/dmKjOHoIJVYpryiYwpKYzOcWKI2WubfjhB7ueCipy0gZnEVI1yBVFOkaE4PxNRuW45Or0ybmjdzIkC7Yhbwivy7NrBsNdOvxjn54eubs4rspy+kq6/7DsD+JKE+u0Fr3xAH99CGybVU7+Lhl+rT4CclhQooGq4KASZJyVHQzGfHaQ1bl2UJQDtp8cy03K7/E3CiXnpNi1PgYbMNOM4PgVENaIncyGPRwNqDVtZL8cM/3n180d57FjHm2RJ7VSIqdQt7hwrxNo47Fwo33mSxf7TnD1rQq55TSbRW9uPqPw+CenlHO36NQ6gWvoh0iJONSpEuMNXpvqgWWKqc3kB5FKyR5AwEadphITouz3skIuIeQQDUQnEruHf8dkybn559uuyo7b21JtATu4fK+X0mV4PA/AAKR4UisebS0o+bL3wV66WoAkF8D9CDMfb6AjqWbU4xKam99e13fjJB++DlIpdA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(23010399003)(36860700016)(10067099003)(11063799006)(261021123027099003)(261021121427099003)(56012099006)(261009221227099003)(261009223027099003)(261026121527099003)(261102123227099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ZJF0r8MYYAQZ8KreIjss+IGbJI3SzbcNb+O3MoqEPoQNwXo0hIOzUcNsZFhSSwVkDvHfIcQdqqIjiiLXJJtdVmhpB83AEV3P1oTHn//y9MbOg5ifQ5+sUZsH22Autxnjl6L9qtTCbSirZH52GoR1HL59bXcZH3nG7XLf7gYUu4QiFwgqStEmCeezC9kCu/fc2YoVg44aiTEdWjAnml3vGRbJRTajN7VvR2s24ti+9qJr2jp4UGTipVs97uA0tlt2CUu1f3KAgRnAPJtsUFK+1fPnIGN8A69cpiri9a3ZxNZUDINcg/vWHO9H7+ZllZmUUxgLdm0bVcQORO65DpZytoqlEB0yTpJdJxSER+xbAj250g5sW1pAkl2sZWERCvLIKXT8x0V1ZnjuvYXmFeDEE18+XxfHXjjJtCTc6+PjShj/wEkXBT1dSaQUwkO5DNIC
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2026 19:23:34.3037 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 370f9d58-0c6f-4826-7684-08df40294745
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF00022BBD.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8238
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

