Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42A03C5DF8C
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Aug 2026 19:53:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D240010F498;
	Fri, 21 Aug 2026 19:53:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="khZXyhUq";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011007.outbound.protection.outlook.com [52.101.57.7])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C542810F498
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Aug 2026 19:53:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rWWrZCxmft+5U+8R/Q4cj0MuBvaad3n9uk6EbPMszIbN61DXO/sm8UnxiJ6g4RLW1PHal0LzZqeGHPaAoxhnllopC/hAqLJWZgTT9v2PoqriGpXNtP2A2q7hPVdBa/p4T8r1xsepFglyIGa9N6vPrOKqQlWMc4IZs1SqlKOQVg2qvgqE0repEoWl9k2C9ccupySi/rsPvVbsIw0w+TL3n3J053Kf7yBj4MQjS1rXR/5HY2KHtCWEP2UHdrasqfmIdw2b2TqfOzc2is185wVfJLJdNBVBouFJBCfJ3O4yfECLftJxGBjS6exyUdDlNwBtqorcSNR5IgV8geocsS1Qjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=stcD1itVs3r80EpD5+EgCOjN8BwR0hun2AV5wtu2LIU=;
 b=notBaR6fqcnuG8M6TUYdlL7+UhxvRq41C8U+4p9hMd5Iq6Cl5rUQUlH29tdWhsm70he+iV0BVp5jaZ7ay/Mn2tTtkS+ZHvD7qH0WCuWUGvNcsOls5FxJ3/Vpayp7IjGcbzkHMA4kBQ8gFy7NxMMgh9FqWP7yDyRkWyu6B1pUrStzFNifEfOLbsKpwAr0OP5ECuiR5np+wh7ECqFAGCi/GAiHJEFXPkDzDxM/8usATUodLSQIDLjHMP8LHkAWmnF4dV/gLfStYuJ+kbL8/az0TATqxPfbj6ZynOb3nEY/R8X6KwkyfQshv0FHlA8R+k9DQ0000F/X3mWF0m+7qmLc1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=stcD1itVs3r80EpD5+EgCOjN8BwR0hun2AV5wtu2LIU=;
 b=khZXyhUq9avJCCTVAJk3TaKMGrwIuGQYnhjgLLGhBLt+V8vjK8FAmVs96F1GQJBA8MfnMZPfbo9jsX4qAYfOrY/RLHVBTlgCzvHoCX7r+6z0ZMmE1u6uBrjrEaK1J9fz2y0Q9TsBI2Nd9rZkmx/aVf40n7D1X7o9MW4Oos1S9o8=
Received: from CH5PR02CA0021.namprd02.prod.outlook.com (2603:10b6:610:1ed::26)
 by LV8PR12MB9451.namprd12.prod.outlook.com (2603:10b6:408:206::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.11; Fri, 21 Aug
 2026 19:35:53 +0000
Received: from CH1PEPF0000AD7C.namprd04.prod.outlook.com
 (2603:10b6:610:1ed:cafe::16) by CH5PR02CA0021.outlook.office365.com
 (2603:10b6:610:1ed::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.11 via Frontend Transport; Fri,
 21 Aug 2026 19:35:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH1PEPF0000AD7C.mail.protection.outlook.com (10.167.244.84) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Fri, 21 Aug 2026 19:35:53 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 21 Aug
 2026 14:35:45 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 21 Aug
 2026 14:35:45 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Fri, 21 Aug 2026 14:35:44 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Mukul Joshi <mukul.joshi@amd.com>, Felix Kuehling
 <felix.kuehling@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 55/95] drm/amdgpu: Setup PTE mappings for NPA addresses
Date: Fri, 21 Aug 2026 15:34:18 -0400
Message-ID: <20260821193458.808626-56-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260821193458.808626-1-alexander.deucher@amd.com>
References: <20260821193458.808626-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD7C:EE_|LV8PR12MB9451:EE_
X-MS-Office365-Filtering-Correlation-Id: d3fffe3b-85ec-481d-bd44-08deffbb6a02
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|1800799024|36860700016|82310400026|10067099003|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: sG6JD4J9fFLRYF5CfB+Q/M9PjOudRlRiXGxeI1NeT2eKgDZ0peDUVQ2VrDUDXXYaXgZWvdIApK8zPQJIIIxrHKvL78sEqN9s+iwsHcXbnCL3yOIbY+WReEYRd6Nc/I5hEIWADoop7hslxy/C140i8h45SdqIl4rJ+vWSnLQRSR9Z4x3QEn+jK4ENrD8W6x8sT2Yw+dBdDP00lMfz1z8H79Q2ch+CusBToVl9oLTvS0PBBQRcv9cabkQl1oxSUtZDfqLV+pzLw0dDqXPoHG6LoT8VzEMMBoxLDKuTCGTchn5/xfL9huUTGWPdIcB6xmB7ntJjDA6FTftOxpQE6Alg5/UobWRa3wgLVVSMiscZT1NnMo3d+1vKhl5LvPrDtaaX41DO1HNN3yJYkGq6NzVJgvhHVY2ppGhMxGhwSYh5p9aZl9iFpBE20YuLleVPzegywu8oXT4a+Bmgis0PzL9/2WD/y/T/YXNAbF7IeGOdFu6FAcO4FEgxSD3GkGDRWiNGVZVAD05ba9DETgebezlkb6sAvLaTHLLPydNtr3RhxXkLYzHB2Xl4+b1bqTrNnxHuCla2lbEdTCc7Xo2sHkYJp8HAEvpv+/5OHRivKM78+Y0Mk1IrtfyqlWhxYSZGHVkW6+KhwyMh+gaMWHepgEkIRwnNrRyfMI4sgMiRWw9zWAFVMos18Dlc3oNRheWvkJgeRcGT4IahVn7x9Sa2LpavYw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(1800799024)(36860700016)(82310400026)(10067099003)(11063799006)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: oNLNvSDLCZOjboCBuxaqKzCu0gKS5jAng4cAB7HtCZtSGBWtzD/uNlp3wun9Q4Hq5qPdjz8PnBnXzXVScoE7DHaI6IfJY/BlDT2GNk4GYTrWXmj50rW104yr+cEQZ0k6ZE/qRLbK4EOhGRpGIF2OnSbGBjZ8u+qNZZpppiAK+8rA9a9w3nTE5vEnxchMO/i77Bv6RSEppdPVH3yoUBkZ2gO9jX3mKxjgoCf4XW2TGl5Z7kgNNtVE0MfddbOacIKwmGYzw2l80l0yB9fRyBrygDyVzDxkQgpxJGT3i6DxA+Bgh2sxuVcsbQlXZtQh4KRvjZzmIdjlGangMxGl3FaIjvbcjZj56apSXpf6RCmHvZ9Y759O84bPsA6aouHgAOGXM+QuMICQzAWFNZdML/k+MY76DyL5H3ueBJIV5/n0JxTGkjgqCb9DNekP/g+Xo1+v
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2026 19:35:53.5158 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d3fffe3b-85ec-481d-bd44-08deffbb6a02
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD7C.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9451
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

From: Mukul Joshi <mukul.joshi@amd.com>

Map NPA addresses into importer's application page tables
using a unique pairing of PTE fields.

Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>
Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 .../gpu/drm/amd/amdgpu/amdgpu_res_cursor.h    |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c        |  4 ++-
 drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c        | 30 +++++++++++++++++--
 3 files changed, 32 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_res_cursor.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_res_cursor.h
index 8908d9e08a304..6650b1194c0f2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_res_cursor.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_res_cursor.h
@@ -92,6 +92,7 @@ static inline void amdgpu_res_first(struct ttm_resource *res,
 	case TTM_PL_TT:
 	case AMDGPU_PL_DOORBELL:
 	case AMDGPU_PL_MMIO_REMAP:
+	case AMDGPU_PL_NPA:
 		node = to_ttm_range_mgr_node(res)->mm_nodes;
 		while (start >= node->size << PAGE_SHIFT)
 			start -= node++->size << PAGE_SHIFT;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index f6c5de63eae61..8f8fecb9738ba 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -1193,7 +1193,9 @@ int amdgpu_vm_update_range(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 		uint64_t tmp, num_entries, addr;
 
 		num_entries = cursor.size >> AMDGPU_GPU_PAGE_SHIFT;
-		if (pages_addr) {
+		if (res && res->mem_type == AMDGPU_PL_NPA) {
+			addr = cursor.start;
+		} else if (pages_addr) {
 			bool contiguous = true;
 
 			if (num_entries > AMDGPU_GPU_PAGES_IN_CPU_PAGE) {
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c b/drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c
index a8e32ee93735d..1468047687652 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c
@@ -600,6 +600,21 @@ static void gmc_v12_1_get_vm_pde(struct amdgpu_device *adev, int level,
 	}
 }
 
+static void gmc_v12_1_get_npa_flags(struct amdgpu_device *adev,
+				    uint64_t *flags)
+{
+	bool is_aid_a1 = (adev->rev_id & 0x10);
+	unsigned int mtype_remote;
+
+	mtype_remote = is_aid_a1 ? MTYPE_NC : MTYPE_UC;
+
+	*flags = AMDGPU_PTE_MTYPE_GFX12(*flags, mtype_remote);
+	/* VSCT = 0011 to identify NPA. Additionally PTE.B = 1 */
+	*flags |= AMDGPU_PTE_SNOOPED | AMDGPU_PTE_PRT_GFX12 |
+		   AMDGPU_PTE_BUS_ATOMICS;
+	*flags &= ~AMDGPU_PTE_VALID;
+}
+
 static void gmc_v12_1_get_coherence_flags(struct amdgpu_device *adev,
 					  struct amdgpu_bo *bo,
 					  uint64_t *flags)
@@ -668,6 +683,8 @@ static void gmc_v12_1_get_vm_pte(struct amdgpu_device *adev,
 				 uint32_t vm_flags,
 				 uint64_t *flags)
 {
+	struct ttm_resource *mem;
+
 	if (vm_flags & AMDGPU_VM_PAGE_EXECUTABLE)
 		*flags |= AMDGPU_PTE_EXECUTABLE;
 	else
@@ -689,8 +706,17 @@ static void gmc_v12_1_get_vm_pte(struct amdgpu_device *adev,
 		break;
 	}
 
-	if ((*flags & AMDGPU_PTE_VALID) && bo)
-		gmc_v12_1_get_coherence_flags(adev, bo, flags);
+	if (bo) {
+		mem = bo->tbo.resource;
+		if (mem && mem->mem_type == AMDGPU_PL_NPA) {
+			dev_dbg(adev->dev,
+				"Setting PTE for NPA BO, mem->type: %d, mem->start: %lx, mem->size: %u, cur_flags: %llx\n",
+				mem->mem_type, mem->start, (u32)mem->size, *flags);
+			gmc_v12_1_get_npa_flags(adev, flags);
+		} else if (*flags & AMDGPU_PTE_VALID) {
+			gmc_v12_1_get_coherence_flags(adev, bo, flags);
+		}
+	}
 }
 
 static const struct amdgpu_gmc_funcs gmc_v12_1_gmc_funcs = {
-- 
2.55.0

