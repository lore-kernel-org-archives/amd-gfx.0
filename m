Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92636C74A5B
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Mar 2023 15:48:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 17FED10EB6E;
	Wed, 29 Mar 2023 15:48:30 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eae::600])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5B44A10EB6E
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Mar 2023 15:48:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ji5moYEYqIh5oAPh6WMP3m9IlYeDfphXk8WW3Mq8WKc8mB9YDxoT5CtwuMsO8ULlRzmGC3AR907mmxGBucYBhao3tpiefM1lVHOOctJOmmBFDCPEF70Q/CzjhXQm2jAg6JVKkTO19QGhqEd1liJne4fMLBykuy0a26aDO48oKGkwwY3fTLhF3BL4vRqufSpyRpem2+lXjEzGVC+IbVhGUkryUZQYiN+8P0FKFU6XjLrVP0nkuwKW0A+hT+xFqShqHu+yKGv4P45IdHHVOoxP3JarStHlPSOuyNNu7f7yGqC/oblOmY4h2MDT3gE93LiAL7JXS+5q/m0Knv/JJd0huw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/YRjgmGVjURpybgCEOTYAvqsA2M40XlMUUAJHLGUnaY=;
 b=bseBfnuGFA6Zv7Hl6ACT9Y8fRL74pYYdscktTHjN1eV4Rfw6xXRSqv7iP2ivtGJ9SpGYp2ZwMAR0h9asuw+Bm7/6S4f9EssFIhL0FW0OFqrvNLFfVVssjCAqafYmC/HQdT0cLRufZ5NQP5imVVpRK2CAB8wwSNb+0O/GjzY4825dgUsoZebuXiAaneBoldFevwdUuKQYU4qWiYjw75s0EZ2jWe3dR6p6sZ/rSDCHCme+jD6h9OpAZOBaOBm39dr5tsbkLRPeVei19y18JbJZFN6Iol/NgGsgs++H9iGyeHt8pDO/PazvW8pZQBZDBlGtbq/BRbzq8eDClzaEWHKjqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/YRjgmGVjURpybgCEOTYAvqsA2M40XlMUUAJHLGUnaY=;
 b=MD6pGTNIUPGhsORWfz5gdWMUtmmjQqQ1PMzih26DTurLJSpHQzcfBp+0HYaN1IJiyWH8f75RUcKhZDaJlLHtnrHINlzeX7uY6VV57ZZQpMdjAYRVZxuiL+PKdFq8f2JbivbhzDRCZxCItSEzI0niyBjSaL/4GzFy87yipmABxHM=
Received: from DS7PR03CA0253.namprd03.prod.outlook.com (2603:10b6:5:3b3::18)
 by CY8PR12MB8340.namprd12.prod.outlook.com (2603:10b6:930:7a::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.33; Wed, 29 Mar
 2023 15:48:25 +0000
Received: from DM6NAM11FT005.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b3:cafe::b0) by DS7PR03CA0253.outlook.office365.com
 (2603:10b6:5:3b3::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.20 via Frontend
 Transport; Wed, 29 Mar 2023 15:48:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT005.mail.protection.outlook.com (10.13.172.238) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6254.20 via Frontend Transport; Wed, 29 Mar 2023 15:48:24 +0000
Received: from MUN-L-SHSHARMA.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 29 Mar
 2023 10:48:23 -0500
From: Shashank Sharma <shashank.sharma@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 06/16] drm/amdgpu: accommodate DOMAIN/PL_DOORBELL
Date: Wed, 29 Mar 2023 17:47:43 +0200
Message-ID: <20230329154753.1261-7-shashank.sharma@amd.com>
X-Mailer: git-send-email 2.38.0.windows.1
In-Reply-To: <20230329154753.1261-1-shashank.sharma@amd.com>
References: <20230329154753.1261-1-shashank.sharma@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT005:EE_|CY8PR12MB8340:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d6b14c5-25aa-498d-700b-08db306d082d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kMCvP/FzkLYwC41Jqq67+4tgagLth2YQW7zl0usWKeURg8imfj+jmEZzP9yS5QtjdbLQJQQH+/66Hj04IkR5cZeu1DKSuNOHDi8LPDzc274l4Cf5GM92fJ52KoA5zX7yQr5J7P5rMLrAmKOM37gd5eCB8G3njLxdFtFXlRjKHZEA2nonDEopVGNQ8wqaYKJu26Z/b0j6JrM8flJwouruvAET/IaBwCba5OROQhVX8E1WbcScRl068kuH5Gvvyme8wDfW87a7Z+YFv3dg+d1FdhtT5liXBrWDXUNxTZ5bJbyT0gQlNjl6m7yyQPxChjpgZDfXY/KqB99DWVwynVfLLdEeqKPjGsTa/y/8NAdEvE+J6FWiAeRqM77VXNF7z6sCEqUrw4tXInxZjqwf9mmI5hB4xtlcyQ6vtwec30FULXUk3oLBANaGcLfHIzy1Ux/xZt6g+NaUFc8Ow5UnuFe12Kep/0qyzkirYNf/UeRq5h9hXrDTBGDl/TdTubDTqxIbjr7OEh8qXyj2153ohaUYvFPVAzma7cFRB0tb4abgDV68mpj8GEBXoAM+xoRAapoal0mWx0IXFGvhe+UDobbakEK4C3vbvKU/cuZZaXHcw7VsBkmGDiUYyuG7yqdjNi+MMhpdsRZq7XUsHGHLi2I1/nJUNResBSfk9tDN2UGCHxL5EyVmwu4lMwDmThZ738Bg9SZd9wGX8grrbDzC44GfziNCwe9Au01Mb62dT9j70OA=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(376002)(346002)(39860400002)(396003)(451199021)(40470700004)(46966006)(36840700001)(81166007)(83380400001)(47076005)(316002)(36756003)(86362001)(40460700003)(36860700001)(40480700001)(1076003)(44832011)(82310400005)(356005)(82740400003)(26005)(186003)(16526019)(2616005)(2906002)(336012)(426003)(478600001)(8676002)(8936002)(54906003)(4326008)(70586007)(70206006)(6916009)(5660300002)(6666004)(7696005)(41300700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2023 15:48:24.8883 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d6b14c5-25aa-498d-700b-08db306d082d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT005.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8340
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Mukul
 Joshi <mukul.joshi@amd.com>, Felix Kuehling <felix.kuehling@amd.com>,
 Christian Koenig <christian.koenig@amd.com>,
 Shashank Sharma <shashank.sharma@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Alex Deucher <alexander.deucher@amd.com>

This patch adds changes:
- to accommodate the new GEM domain DOORBELL
- to accommodate the new TTM PL DOORBELL

in order to manage doorbell pages as GEM object.

V2: Addressed reviwe comments from Christian
    - drop the doorbell changes for pinning/unpinning
    - drop the doorbell changes for dma-buf map
    - drop the doorbell changes for sgt
    - no need to handle TTM_PL_FLAG_CONTIGUOUS for doorbell
    - add caching type for doorbell

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian Koenig <christian.koenig@amd.com>

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c     | 11 ++++++++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_res_cursor.h |  2 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c        | 16 +++++++++++++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h        |  1 +
 4 files changed, 28 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
index 4e684c2afc70..0ec080e240ad 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
@@ -147,6 +147,14 @@ void amdgpu_bo_placement_from_domain(struct amdgpu_bo *abo, u32 domain)
 		c++;
 	}
 
+	if (domain & AMDGPU_GEM_DOMAIN_DOORBELL) {
+		places[c].fpfn = 0;
+		places[c].lpfn = 0;
+		places[c].mem_type = AMDGPU_PL_DOORBELL;
+		places[c].flags = 0;
+		c++;
+	}
+
 	if (domain & AMDGPU_GEM_DOMAIN_GTT) {
 		places[c].fpfn = 0;
 		places[c].lpfn = 0;
@@ -466,7 +474,7 @@ static bool amdgpu_bo_validate_size(struct amdgpu_device *adev,
 		goto fail;
 	}
 
-	/* TODO add more domains checks, such as AMDGPU_GEM_DOMAIN_CPU */
+	/* TODO add more domains checks, such as AMDGPU_GEM_DOMAIN_CPU,  AMDGPU_GEM_DOMAIN_DOORBELL */
 	return true;
 
 fail:
@@ -1013,6 +1021,7 @@ void amdgpu_bo_unpin(struct amdgpu_bo *bo)
 	} else if (bo->tbo.resource->mem_type == TTM_PL_TT) {
 		atomic64_sub(amdgpu_bo_size(bo), &adev->gart_pin_size);
 	}
+
 }
 
 static const char *amdgpu_vram_names[] = {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_res_cursor.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_res_cursor.h
index 5c4f93ee0c57..3c988cc406e4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_res_cursor.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_res_cursor.h
@@ -90,6 +90,7 @@ static inline void amdgpu_res_first(struct ttm_resource *res,
 		cur->node = block;
 		break;
 	case TTM_PL_TT:
+	case AMDGPU_PL_DOORBELL:
 		node = to_ttm_range_mgr_node(res)->mm_nodes;
 		while (start >= node->size << PAGE_SHIFT)
 			start -= node++->size << PAGE_SHIFT;
@@ -152,6 +153,7 @@ static inline void amdgpu_res_next(struct amdgpu_res_cursor *cur, uint64_t size)
 		cur->size = min(amdgpu_vram_mgr_block_size(block), cur->remaining);
 		break;
 	case TTM_PL_TT:
+	case AMDGPU_PL_DOORBELL:
 		node = cur->node;
 
 		cur->node = ++node;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index 55e0284b2bdd..6f61491ef3dd 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -128,6 +128,7 @@ static void amdgpu_evict_flags(struct ttm_buffer_object *bo,
 	case AMDGPU_PL_GDS:
 	case AMDGPU_PL_GWS:
 	case AMDGPU_PL_OA:
+	case AMDGPU_PL_DOORBELL:
 		placement->num_placement = 0;
 		placement->num_busy_placement = 0;
 		return;
@@ -500,9 +501,11 @@ static int amdgpu_bo_move(struct ttm_buffer_object *bo, bool evict,
 	if (old_mem->mem_type == AMDGPU_PL_GDS ||
 	    old_mem->mem_type == AMDGPU_PL_GWS ||
 	    old_mem->mem_type == AMDGPU_PL_OA ||
+	    old_mem->mem_type == AMDGPU_PL_DOORBELL ||
 	    new_mem->mem_type == AMDGPU_PL_GDS ||
 	    new_mem->mem_type == AMDGPU_PL_GWS ||
-	    new_mem->mem_type == AMDGPU_PL_OA) {
+	    new_mem->mem_type == AMDGPU_PL_OA ||
+	    new_mem->mem_type == AMDGPU_PL_DOORBELL) {
 		/* Nothing to save here */
 		ttm_bo_move_null(bo, new_mem);
 		goto out;
@@ -586,6 +589,12 @@ static int amdgpu_ttm_io_mem_reserve(struct ttm_device *bdev,
 		mem->bus.offset += adev->gmc.aper_base;
 		mem->bus.is_iomem = true;
 		break;
+	case AMDGPU_PL_DOORBELL:
+		mem->bus.offset = mem->start << PAGE_SHIFT;
+		mem->bus.offset += adev->doorbell.base;
+		mem->bus.is_iomem = true;
+		mem->bus.caching = ttm_uncached;
+		break;
 	default:
 		return -EINVAL;
 	}
@@ -600,6 +609,10 @@ static unsigned long amdgpu_ttm_io_mem_pfn(struct ttm_buffer_object *bo,
 
 	amdgpu_res_first(bo->resource, (u64)page_offset << PAGE_SHIFT, 0,
 			 &cursor);
+
+	if (bo->resource->mem_type == AMDGPU_PL_DOORBELL)
+		return ((uint64_t)(adev->doorbell.base + cursor.start)) >> PAGE_SHIFT;
+
 	return (adev->gmc.aper_base + cursor.start) >> PAGE_SHIFT;
 }
 
@@ -1267,6 +1280,7 @@ uint64_t amdgpu_ttm_tt_pde_flags(struct ttm_tt *ttm, struct ttm_resource *mem)
 		flags |= AMDGPU_PTE_VALID;
 
 	if (mem && (mem->mem_type == TTM_PL_TT ||
+		    mem->mem_type == AMDGPU_PL_DOORBELL ||
 		    mem->mem_type == AMDGPU_PL_PREEMPT)) {
 		flags |= AMDGPU_PTE_SYSTEM;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
index e2cd5894afc9..761cd6b2b942 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
@@ -33,6 +33,7 @@
 #define AMDGPU_PL_GWS		(TTM_PL_PRIV + 1)
 #define AMDGPU_PL_OA		(TTM_PL_PRIV + 2)
 #define AMDGPU_PL_PREEMPT	(TTM_PL_PRIV + 3)
+#define AMDGPU_PL_DOORBELL	(TTM_PL_PRIV + 4)
 
 #define AMDGPU_GTT_MAX_TRANSFER_SIZE	512
 #define AMDGPU_GTT_NUM_TRANSFER_WINDOWS	2
-- 
2.40.0

