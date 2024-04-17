Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FCB8C4345F
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Apr 2024 06:22:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CA2C71131B3;
	Wed, 17 Apr 2024 06:21:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="y0GVcJb2";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2040.outbound.protection.outlook.com [40.107.220.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 77A801131B3
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Apr 2024 06:21:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NA4DVDBZqiWPz5Ct10nou+ZP7FjqT7atVxWOYJM8Qd42nChazX0xlqW7rEWJQ0LUQOF/hkIqnlnpbOYROyGH0pfA6LNiAWqGS7/Ki4xa+833IFmN1wT+SfxHT42dNBqvcS0jo3AgI8Y7XRdfgalrYbIv53BGPbbRZhomiJk9btMsQlU573vFlp77Q9sx/Yu6RNRI8uxD9jB5Ce3thPOJ5rukjQ+0PrXh5PHn9TZEpMPvyt7y97YjUISWnWr2gCPPKAg0DhTJXZwVgoiXclpofKGqpl6lzan0D7dmGw4h2wrleCjjW43tVPKUi4AJcO8Us2hZPdjpmaybDWbrKhN+OA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N4CfiOFXxn9n/oHSLYgVcQdXtxcZpRCY3O0i8nNo7A4=;
 b=OuAB41p/ORzpOv4ACIIMkVPhWnBCXfaBTIHZYVR4NXxSL/8MJr64v549GzICcW+N/QgbTatmqTmY1+AdAIFdRIeuxEZ3LmJ1MOvdkVHEZl8ImEiOvnvcfadgSSRZMSumqM6Bnkpua6GkZpGrilAonzMC3gvPLh27tmHoRODaxDq+NwIERTv2JnxdPNdUFsbAYaeCaHN2AeMv8/pJz0fE2cgJKi+fiqIb9tQww5M0ETwylVuiR0RO5xtJgRGwpddseBpdgu832vBg40d8aTzrAltb7/KuMMVUCYgWP7R/N5zcP6U9R2ar0RtKaHzcZBYNiio8EDqWB8kgN3WgwnzLCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N4CfiOFXxn9n/oHSLYgVcQdXtxcZpRCY3O0i8nNo7A4=;
 b=y0GVcJb2XoBj3HdgZg3EZtSOOhGEMU26W2ECLTMezKZSxu/A7bBBw6OZa4KJy5L+xSTO7G0Adv7RThkzpQq/b7qnDxyj6smjVeV27v4mIlN55C3CrefX3RgxfucK/Ikohzp909KEoVxXa83/3Y4bKVazlwycJYcM/p2MlzbbOCg=
Received: from MN2PR01CA0040.prod.exchangelabs.com (2603:10b6:208:23f::9) by
 SA1PR12MB5638.namprd12.prod.outlook.com (2603:10b6:806:229::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Wed, 17 Apr
 2024 06:21:55 +0000
Received: from BL6PEPF0001AB75.namprd02.prod.outlook.com
 (2603:10b6:208:23f:cafe::1d) by MN2PR01CA0040.outlook.office365.com
 (2603:10b6:208:23f::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7495.23 via Frontend
 Transport; Wed, 17 Apr 2024 06:21:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB75.mail.protection.outlook.com (10.167.242.168) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7452.22 via Frontend Transport; Wed, 17 Apr 2024 06:21:55 +0000
Received: from amd-X570-AORUS-ELITE.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 17 Apr 2024 01:21:53 -0500
From: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <christian.koenig@amd.com>, <alexander.deucher@amd.com>,
 <felix.kuehling@amd.com>, <philip.yang@amd.com>, Arunpravin Paneer Selvam
 <Arunpravin.PaneerSelvam@amd.com>
Subject: [PATCH v2] drm/amdgpu: Modify the contiguous flags behaviour
Date: Wed, 17 Apr 2024 11:51:21 +0530
Message-ID: <20240417062121.3779-1-Arunpravin.PaneerSelvam@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB75:EE_|SA1PR12MB5638:EE_
X-MS-Office365-Filtering-Correlation-Id: 4694b734-421b-47ee-9aa3-08dc5ea6adf1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yjR8YRm9kqwL2FqkbM8AEI+unLNRFcE3B4MqaEPpqsuEctPoOIPiuVzDls6cSgpYqHqY1gpSIntFe/YD81mIVlvGlaMG/TTcTrcNYasfbV3Ir0oCouhSzhJ7+o+qo0FsXbfcCKIw1VNKWRP/gxgYMl8Z7Vjb8jpopDuMnMBNDKBqdDY5tLCYegzfVZduY0LgW3PHhzV0/vl0FonjL07WMqDzxw33B7n2RPzJo+l/Ntm5Rdu+A48WYfTfl/hyQPtHje9ddeuBHXd8LU/ddNyCp4ckPb486BQx/l+H2v10Nm0JxGtSFhvgWnhYZD/fEgIy/VMXoXbhNONY2W4Y5XpNavSl2p4mjo/V3qkB9/e6xzd5iSpWPb4m1ZF9FVb/K4Nb2il80Ktiq4u0zDb11wOr7od+1U8hzjbefC/7HOvRCe+YXS93dtxJCAjGKkS3Aguh0ozaXXPdjym7XqS83lBm8bfP1c2B3BzS5I6cwQC6XIl/zrEG6Jam4O4MaL/o5RNDSVpKFHNkxtd3kGxNiLHD0NTwIh1TD4RKXYVjn2HEAva8CnpPEXzzmCU6xHTWRnk8jnE1eMbCysrt3/lad8cV83kjEtncGHvx0L1JdMsBo334n8d8UHrfH7KyCqP/R/fct8/05q04/9nJy+3u3xJyOUjyWNZ7z+wI97WWR4wxuaM1VtDYenNaj2hANEeypwy1HJYSv+YuFEpOr1Y+cxfPE3Bbvh+UCrzli71R/sha+gIbxI3og3Eac3vMTbRbxbTk
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(376005)(82310400014)(36860700004)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2024 06:21:55.5173 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4694b734-421b-47ee-9aa3-08dc5ea6adf1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB75.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB5638
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

v2:
  - keep the mem_flags and bo->flags check as is(Christian)
  - place the TTM_PL_FLAG_CONTIGUOUS flag setting into the
    amdgpu_bo_pin_restricted function placement range iteration
    loop(Christian)
  - rename find_pages with amdgpu_vram_mgr_calculate_pages_per_block
    (Christian)
  - Keep the kernel BO allocation as is(Christain)
  - If BO pin vram allocation failed, we need to return -ENOSPC as
    RDMA cannot work with scattered VRAM pages(Philip)

Signed-off-by: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
Suggested-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c   |  8 ++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c | 57 +++++++++++++++-----
 2 files changed, 50 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
index 8bc79924d171..caaef7b1df49 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
@@ -153,8 +153,10 @@ void amdgpu_bo_placement_from_domain(struct amdgpu_bo *abo, u32 domain)
 		else
 			places[c].flags |= TTM_PL_FLAG_TOPDOWN;
 
-		if (flags & AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS)
+		if (abo->tbo.type == ttm_bo_type_kernel &&
+		    flags & AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS)
 			places[c].flags |= TTM_PL_FLAG_CONTIGUOUS;
+
 		c++;
 	}
 
@@ -966,6 +968,10 @@ int amdgpu_bo_pin_restricted(struct amdgpu_bo *bo, u32 domain,
 		if (!bo->placements[i].lpfn ||
 		    (lpfn && lpfn < bo->placements[i].lpfn))
 			bo->placements[i].lpfn = lpfn;
+
+		if (bo->flags & AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS &&
+		    bo->placements[i].mem_type == TTM_PL_VRAM)
+			bo->placements[i].flags |= TTM_PL_FLAG_CONTIGUOUS;
 	}
 
 	r = ttm_bo_validate(&bo->tbo, &bo->placement, &ctx);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
index 8db880244324..4be8b091099a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
@@ -88,6 +88,29 @@ static inline u64 amdgpu_vram_mgr_blocks_size(struct list_head *head)
 	return size;
 }
 
+static inline unsigned long
+amdgpu_vram_mgr_calculate_pages_per_block(struct ttm_buffer_object *tbo,
+					  const struct ttm_place *place,
+					  unsigned long bo_flags)
+{
+	unsigned long pages_per_block;
+
+	if (bo_flags & AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS) {
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
@@ -451,8 +474,10 @@ static int amdgpu_vram_mgr_new(struct ttm_resource_manager *man,
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
@@ -468,18 +493,9 @@ static int amdgpu_vram_mgr_new(struct ttm_resource_manager *man,
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
+		amdgpu_vram_mgr_calculate_pages_per_block(tbo, place,
+							  bo_flags);
 
 	vres = kzalloc(sizeof(*vres), GFP_KERNEL);
 	if (!vres)
@@ -498,7 +514,7 @@ static int amdgpu_vram_mgr_new(struct ttm_resource_manager *man,
 	if (place->flags & TTM_PL_FLAG_TOPDOWN)
 		vres->flags |= DRM_BUDDY_TOPDOWN_ALLOCATION;
 
-	if (place->flags & TTM_PL_FLAG_CONTIGUOUS)
+	if (bo_flags & AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS)
 		vres->flags |= DRM_BUDDY_CONTIGUOUS_ALLOCATION;
 
 	if (fpfn || lpfn != mgr->mm.size)
@@ -529,8 +545,21 @@ static int amdgpu_vram_mgr_new(struct ttm_resource_manager *man,
 					   min_block_size,
 					   &vres->blocks,
 					   vres->flags);
-		if (unlikely(r))
+		if (unlikely(r)) {
+			if (bo_flags & AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS &&
+			    !(place->flags & TTM_PL_FLAG_CONTIGUOUS)) {
+				/* Fallback to non contiguous allocation */
+				vres->flags &= ~DRM_BUDDY_CONTIGUOUS_ALLOCATION;
+				bo_flags &= ~AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS;
+
+				pages_per_block =
+					amdgpu_vram_mgr_calculate_pages_per_block(tbo,
+										  place,
+										  bo_flags);
+				continue;
+			}
 			goto error_free_blocks;
+		}
 
 		if (size > remaining_size)
 			remaining_size = 0;
-- 
2.25.1

