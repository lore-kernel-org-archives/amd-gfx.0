Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA70FC4345F
	for <amd-gfx@archiver.kernel.org>; Sun, 14 Apr 2024 14:58:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1926810E84F;
	Sun, 14 Apr 2024 14:58:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="lXhB4O2k";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2057.outbound.protection.outlook.com [40.107.93.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2FAEC10E0EC
 for <amd-gfx@lists.freedesktop.org>; Sun, 14 Apr 2024 14:58:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bbKiZz8fdG+z7EWoIw0lh6lXGhzxgsgyyeudjPkEscnIF760v0Tz/guVAfQZZWApWZdTRxuojNg2orC3PpUYsxCcIZ6BAoY7VQ9hipJY5Eoto0xq93HVpKFDPUPnYvAHZuKUFg5+gDavpVFkQsPNIPBAPWMNzZacRwF/fO0yfuc2D49UyB1/QRO6YzzYP6AINBByOKwLrMI97h7Uz2NSWzcJfFhH1T0g787fYyqnSqQZgBGk6GrX7vo+6/TIkTvcpgOBOcI+/9D6UoFnvNmvzKUopjTg6XvNiv8XCyw4Bg5iMpm7NWG7KuaC4cNRjGbpulKA/dTl97m5Xb88+XGhdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v+LHkBi6obpmsep2xvqU4M5E3ieC0RN2zfI7EDe4AZk=;
 b=BWqHDlaogI8fyc3/nug4p50sY3WRN7dsfDVetVIHG/2a7QDeDxqPC6ncARLjqzAIY5Eq50VxatXhJw5pJH1L0g2oJseXrfxwGfyq+WXyBQA3MODjcsqS6/s6THPSwYw8JJM2y4qIHoFSbRzQyGtl0PaDzgitRs/MQ/3C7HN4Ark/u9k5KX8MXsmAotChjb4bp3i1/4V5zBn+8ltjD2kyM46vXfO89iJxZvJqAz3QXkAlikqJLgCjx8GJ6dgijk6h7sa/zZ//fxdjNhluhT/z8GFGUwmMaePXjhW4uoE36rQQFYRXvkyKBC/RueTuA1+gm+5znVIRz0O14hUVXjk9vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v+LHkBi6obpmsep2xvqU4M5E3ieC0RN2zfI7EDe4AZk=;
 b=lXhB4O2kpXZNMSPBdu8K3RzCqw3he/yEVVInOW3+uaAYwM7Ln+KaobMQ7r0sEOSggdzxr+d1aBzJJHLcFzoJ7oAxUjSCXrYUT8MTipd02RSh2L5P/YkhT987141CKPKlvsV1JWaDvaoaJB726ALyKPPwTrEbwKsZv/hbeL1OE4Y=
Received: from MN2PR10CA0016.namprd10.prod.outlook.com (2603:10b6:208:120::29)
 by SA0PR12MB7004.namprd12.prod.outlook.com (2603:10b6:806:2c0::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.49; Sun, 14 Apr
 2024 14:58:09 +0000
Received: from BL02EPF00021F6A.namprd02.prod.outlook.com
 (2603:10b6:208:120:cafe::ca) by MN2PR10CA0016.outlook.office365.com
 (2603:10b6:208:120::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.32 via Frontend
 Transport; Sun, 14 Apr 2024 14:58:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF00021F6A.mail.protection.outlook.com (10.167.249.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7452.22 via Frontend Transport; Sun, 14 Apr 2024 14:58:08 +0000
Received: from amd-X570-AORUS-ELITE.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 14 Apr 2024 09:58:06 -0500
From: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <christian.koenig@amd.com>, <alexander.deucher@amd.com>,
 <felix.kuehling@amd.com>, <philip.yang@amd.com>, Arunpravin Paneer Selvam
 <Arunpravin.PaneerSelvam@amd.com>
Subject: [PATCH] drm/amdgpu: Modify the contiguous flags behaviour
Date: Sun, 14 Apr 2024 20:27:31 +0530
Message-ID: <20240414145731.1829-1-Arunpravin.PaneerSelvam@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00021F6A:EE_|SA0PR12MB7004:EE_
X-MS-Office365-Filtering-Correlation-Id: 360533ac-333b-4b01-abd8-08dc5c934c27
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XWGNCmNGpsHNy2NxtrQ4hvtUME/7yOcjM8gzp16e3qIGjElrAGYEGAXJ7IrPyGY5opNI8k02vaGbnaVMVWRqh7XqRf/npsLVwZHu8ilJNESnntnm5gL35QcKuD3wL40xcI3Ppz44dzhfDOKADOQR18ZVCfuBC39liVtbBZ6yqyRRNhEFnFHv682LWcKDqXt33bzEwnzgj20syxh6Nl7plgcIP0q1FXqu0RWf23b+c9Rn49Md0FS5tQhj8YZLHvaTZVtDRE4p228pgxEiXixQ+QoRVzopcy//0x4YKMd1rEuoHCXPl2BG29fJOOZPHL5ChgFmT9EWZkGYnjp/h3W5KJNe086MzurXZtuCH0GpiqeoPXxFxUDP1tSUZGKOfRYZCKCs6L5sPScuqR09gaaHa5ggqJVYnQbfCXEOlW26vpLaAwYR6W1D5tXTVmc9Wqc/Oh4Hji9Gh/jQrkII7lfuZoNWGAG19XGL6yjbBvfw4wp+52wHtVpkwpEmqBAGXcRsqZfDsbc3S9ba8nAz/Z0MKLf9W4ZISxVLi3WXDvQHhquWBeZ2DkbOcPyWjj0WHktgRCyrNBu2Y2P2r2PvKLk51vrPlA8+7tw03M50SJtwEYatye5Q1d6L4+dq04rxofpprZnuSF7OpGjDYZd11U9LHVgLnQVKBWUs7NzeJFzMsvIr0KfCS7vAt2VB8/C623jiKgHJEXgIP7FZWqcMK/ItJh6jl0UIBwGHfCiefx1FKUu1Adqq/9eP3vy2tgHZCcC4
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(82310400014)(36860700004); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2024 14:58:08.6915 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 360533ac-333b-4b01-abd8-08dc5c934c27
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF00021F6A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB7004
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

Now we have two flags for contiguous VRAM buffer allocation.
If the application request for AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS,
it would set the ttm place TTM_PL_FLAG_CONTIGUOUS flag in the
buffer's placement function.

This patch will change the default behaviour of the two flags.

When we set AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS
- This means contiguous is not mandatory.
- we will try to allocate the contiguous buffer. Say if the
  allocation fails, we fallback to allocate the individual pages.

When we setTTM_PL_FLAG_CONTIGUOUS
- This means contiguous allocation is mandatory.
- we are setting this in amdgpu_bo_pin_restricted() before bo validation
  and check this flag in the vram manager file.
- if this is set, we should allocate the buffer pages contiguously.
  the allocation fails, we return -ENOSPC.

Signed-off-by: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
Suggested-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c   | 14 +++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c | 57 +++++++++++++++-----
 2 files changed, 49 insertions(+), 22 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
index 8bc79924d171..41926d631563 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
@@ -153,8 +153,6 @@ void amdgpu_bo_placement_from_domain(struct amdgpu_bo *abo, u32 domain)
 		else
 			places[c].flags |= TTM_PL_FLAG_TOPDOWN;
 
-		if (flags & AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS)
-			places[c].flags |= TTM_PL_FLAG_CONTIGUOUS;
 		c++;
 	}
 
@@ -899,6 +897,8 @@ int amdgpu_bo_pin_restricted(struct amdgpu_bo *bo, u32 domain,
 {
 	struct amdgpu_device *adev = amdgpu_ttm_adev(bo->tbo.bdev);
 	struct ttm_operation_ctx ctx = { false, false };
+	struct ttm_place *places = bo->placements;
+	u32 c = 0;
 	int r, i;
 
 	if (amdgpu_ttm_tt_get_usermm(bo->tbo.ttm))
@@ -921,16 +921,10 @@ int amdgpu_bo_pin_restricted(struct amdgpu_bo *bo, u32 domain,
 
 	if (bo->tbo.pin_count) {
 		uint32_t mem_type = bo->tbo.resource->mem_type;
-		uint32_t mem_flags = bo->tbo.resource->placement;
 
 		if (!(domain & amdgpu_mem_type_to_domain(mem_type)))
 			return -EINVAL;
 
-		if ((mem_type == TTM_PL_VRAM) &&
-		    (bo->flags & AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS) &&
-		    !(mem_flags & TTM_PL_FLAG_CONTIGUOUS))
-			return -EINVAL;
-
 		ttm_bo_pin(&bo->tbo);
 
 		if (max_offset != 0) {
@@ -968,6 +962,10 @@ int amdgpu_bo_pin_restricted(struct amdgpu_bo *bo, u32 domain,
 			bo->placements[i].lpfn = lpfn;
 	}
 
+	if (domain & AMDGPU_GEM_DOMAIN_VRAM &&
+	    !WARN_ON(places[c].mem_type != TTM_PL_VRAM))
+		places[c].flags |= TTM_PL_FLAG_CONTIGUOUS;
+
 	r = ttm_bo_validate(&bo->tbo, &bo->placement, &ctx);
 	if (unlikely(r)) {
 		dev_err(adev->dev, "%p pin failed\n", bo);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
index 8db880244324..ddbf302878f6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
@@ -88,6 +88,30 @@ static inline u64 amdgpu_vram_mgr_blocks_size(struct list_head *head)
 	return size;
 }
 
+static inline unsigned long
+amdgpu_vram_find_pages_per_block(struct ttm_buffer_object *tbo,
+				 const struct ttm_place *place,
+				 unsigned long bo_flags)
+{
+	unsigned long pages_per_block;
+
+	if (bo_flags & AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS ||
+	    place->flags & TTM_PL_FLAG_CONTIGUOUS) {
+		pages_per_block = ~0ul;
+	} else {
+#ifdef CONFIG_TRANSPARENT_HUGEPAGE
+		pages_per_block = HPAGE_PMD_NR;
+#else
+		/* default to 2MB */
+		pages_per_block = 2UL << (20UL - PAGE_SHIFT);
+#endif
+		pages_per_block = max_t(uint32_t, pages_per_block,
+					tbo->page_alignment);
+	}
+
+	return pages_per_block;
+}
+
 /**
  * DOC: mem_info_vram_total
  *
@@ -451,8 +475,10 @@ static int amdgpu_vram_mgr_new(struct ttm_resource_manager *man,
 	struct amdgpu_vram_mgr *mgr = to_vram_mgr(man);
 	struct amdgpu_device *adev = to_amdgpu_device(mgr);
 	u64 vis_usage = 0, max_bytes, min_block_size;
+	struct amdgpu_bo *bo = ttm_to_amdgpu_bo(tbo);
 	struct amdgpu_vram_mgr_resource *vres;
 	u64 size, remaining_size, lpfn, fpfn;
+	unsigned long bo_flags = bo->flags;
 	struct drm_buddy *mm = &mgr->mm;
 	struct drm_buddy_block *block;
 	unsigned long pages_per_block;
@@ -468,18 +494,8 @@ static int amdgpu_vram_mgr_new(struct ttm_resource_manager *man,
 	if (tbo->type != ttm_bo_type_kernel)
 		max_bytes -= AMDGPU_VM_RESERVED_VRAM;
 
-	if (place->flags & TTM_PL_FLAG_CONTIGUOUS) {
-		pages_per_block = ~0ul;
-	} else {
-#ifdef CONFIG_TRANSPARENT_HUGEPAGE
-		pages_per_block = HPAGE_PMD_NR;
-#else
-		/* default to 2MB */
-		pages_per_block = 2UL << (20UL - PAGE_SHIFT);
-#endif
-		pages_per_block = max_t(uint32_t, pages_per_block,
-					tbo->page_alignment);
-	}
+	pages_per_block =
+		amdgpu_vram_find_pages_per_block(tbo, place, bo_flags);
 
 	vres = kzalloc(sizeof(*vres), GFP_KERNEL);
 	if (!vres)
@@ -498,7 +514,8 @@ static int amdgpu_vram_mgr_new(struct ttm_resource_manager *man,
 	if (place->flags & TTM_PL_FLAG_TOPDOWN)
 		vres->flags |= DRM_BUDDY_TOPDOWN_ALLOCATION;
 
-	if (place->flags & TTM_PL_FLAG_CONTIGUOUS)
+	if (bo_flags & AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS ||
+	    place->flags & TTM_PL_FLAG_CONTIGUOUS)
 		vres->flags |= DRM_BUDDY_CONTIGUOUS_ALLOCATION;
 
 	if (fpfn || lpfn != mgr->mm.size)
@@ -529,8 +546,20 @@ static int amdgpu_vram_mgr_new(struct ttm_resource_manager *man,
 					   min_block_size,
 					   &vres->blocks,
 					   vres->flags);
-		if (unlikely(r))
+		if (unlikely(r)) {
+			if (bo_flags & AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS) {
+				/* Fallback to non contiguous allocation */
+				vres->flags &= ~DRM_BUDDY_CONTIGUOUS_ALLOCATION;
+				bo_flags &= ~AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS;
+
+				pages_per_block =
+					amdgpu_vram_find_pages_per_block(tbo,
+									 place,
+									 bo_flags);
+				continue;
+			}
 			goto error_free_blocks;
+		}
 
 		if (size > remaining_size)
 			remaining_size = 0;
-- 
2.25.1

