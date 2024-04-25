Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BADFC4345F
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Apr 2024 15:36:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E9E8911A56F;
	Thu, 25 Apr 2024 15:36:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="r36ONwiY";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2062.outbound.protection.outlook.com [40.107.92.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 904A611A56E
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Apr 2024 15:36:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HhollisG1B20cMAFz1QtR30jw716l/4i7Jrfmv0HEhW3405nFr60Wq2baou759waTBxwWYusIUhqs3KlaVNHhHcTO+FMPsRTMavUEV/3ziE8Kh/pRLlkCvb/dfDGqSoDEOzBl32b6ky8orFy59PBIkIf7ToZdr3gZFxMJvF434VlbkAhKl6/VTZnvsMecnXTAD7WnX1cs5x1yzkNOjof+8I+Ud87eTuLNLvNwcsVFjBBCTR70p7QF2yRWQ8VHv27b87nQazC3eBrz63iNQl0+qufXqm6sCTvey6/Y0wykCV0p4CSnzTXrq8kr2k8KLsLv2LAb59e4Uo/ZuHwaFRxvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dqIvdi48qWtXdyuJ7xtLnWTnfy9zytdxRWX8/Pe0Dkc=;
 b=glWkCb/4N8gFX/NvEK4YNMScZKL+1Ne+Gtf5wgfvq8jyoP0J2h3Ji64irB5Gt+ks/afHliQkMiq7gy93CBCvhV+141BlnUi5ezGpnRxUA9T3Unz0sSgpAfiUjUjJjz+BUfNJCovN6JLdImy+X8/OlvvSAB3bTGvHKdtcIdugnegrWwBOOvuJJeWWO1npWk0uhaOhNAZj9Mr0w1NwPLC/OTncEJRT0+fZrUaKAznpFR5pHqGDgXp6uKUTIYthY5Gtq3OgW9opDHG8NAOopb+FKKA9t/Tb1U8bCFj6VEtnw/k4ppTg/9OBCXfr1++ebXC7VNAOldMyaTpD2yykDKzV2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dqIvdi48qWtXdyuJ7xtLnWTnfy9zytdxRWX8/Pe0Dkc=;
 b=r36ONwiYaNKcGYOZSjromj9oI3b5YnH+8+AtzMp0ieawjpvgmbTvvKSoqAa1jwKogiOw2r+NctZOWG7s2a7SsOo1/IGOYDOWkSr4FK6cqUrONUdhAMFIUh5NzwU9pmnfTmY1wjoDwEbu8KLZoaDu+lBPSxAWgco+Bp6Favzm1lc=
Received: from BN8PR04CA0058.namprd04.prod.outlook.com (2603:10b6:408:d4::32)
 by SA1PR12MB6822.namprd12.prod.outlook.com (2603:10b6:806:25d::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.22; Thu, 25 Apr
 2024 15:36:11 +0000
Received: from BN2PEPF000044A1.namprd02.prod.outlook.com
 (2603:10b6:408:d4:cafe::a4) by BN8PR04CA0058.outlook.office365.com
 (2603:10b6:408:d4::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.28 via Frontend
 Transport; Thu, 25 Apr 2024 15:36:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000044A1.mail.protection.outlook.com (10.167.243.152) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7519.19 via Frontend Transport; Thu, 25 Apr 2024 15:36:11 +0000
Received: from amd-X570-AORUS-ELITE.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 25 Apr 2024 10:36:09 -0500
From: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <christian.koenig@amd.com>, <alexander.deucher@amd.com>,
 <felix.kuehling@amd.com>, <philip.yang@amd.com>, Arunpravin Paneer Selvam
 <Arunpravin.PaneerSelvam@amd.com>
Subject: [PATCH v5] drm/amdgpu: Modify the contiguous flags behaviour
Date: Thu, 25 Apr 2024 21:05:55 +0530
Message-ID: <20240425153555.15031-1-Arunpravin.PaneerSelvam@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A1:EE_|SA1PR12MB6822:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c04ef89-2b25-41a1-9248-08dc653d6f6a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|36860700004|376005|82310400014|1800799015; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?enlTdzJZWHB6Uy9tNzVEK05VNndjay9Gc3hDWmxKQ3JybEc1Q0lERENacTJq?=
 =?utf-8?B?alRtcHloK1NqK3NKdkJqaGFwRm5KUmdHdHh1RCtzQTdEUmFUUDRlWFJualBU?=
 =?utf-8?B?Um4yenc5bXhWQXdQN2R6MXNDSXFFVlZYS3FjTWZ0MlRKT3dhbHUxYTJuaUFj?=
 =?utf-8?B?NjdQM0FIT2xQU0ZOV3JDbG9uUWlpQ3FrcjdEdG15Mm50YU9ZL2FWVXQzRk5D?=
 =?utf-8?B?dllCZlZKdW1TNFBxMkFzQVVlMUxQQ05BOEFMUW8vdjhEcjhRaURGa1BabHFI?=
 =?utf-8?B?ZTgxQk1ISHNJTTlWZjNobE1zWGxHR0tnUmhCZk9oaWhrS1hZdVNqTTNWRE1S?=
 =?utf-8?B?SXl4UXlUcm4vMWs3b1hpdTBpMHZxR1hEZmM1bG9Uc3l5bFJ6cG8zZzcrZ3B3?=
 =?utf-8?B?NVVQWm9TZStTcWJyMm0xRGRRMVhsMXdUL3VFdzc1THU4Tk5pWklFZ245R2F3?=
 =?utf-8?B?ZzVUbjk1d3FmUWpjUEJoV2RUbks1RThuSitpTzhQZXpLeHVwdU1QZEkrcVBQ?=
 =?utf-8?B?bU4yMG1WRWJ3UStQZDBqZUZDblduYm1WVVY3aGxPc2VXTDhmbG5mVWFiSjNY?=
 =?utf-8?B?ZjhtYWtzcERhQ2VRU1hvNCttdkNKR1RPUFA1MkwvZzMvL2Z1QXI4UlAwZVZV?=
 =?utf-8?B?ZXBpZ2FyZTNVK093b0VYUWtUV0FtTDV0U2xTRXd5UmJlR3BQM3FiT1hmRkly?=
 =?utf-8?B?V0RUZ2R1TlFFN2ptdFEzSUowbWtSZzdCai9wamdUd095cXd4YW9CeGxib3Vo?=
 =?utf-8?B?T3dBQnhQdzJGRWJ4eUtYcUJwc0VUeVF0c1lUZ0I3UFhiWWprRm1DTFBBT1B4?=
 =?utf-8?B?WSt3Sisyd3ZRTTUwZjJLMWRKRnVmZGVITXF5QlFZYnVzQnRTT3p3RjZxTStL?=
 =?utf-8?B?QkdoZ1p2S1QzbE9lTllieGVWVjNJZm9EbnNkUmd2ZGZidFdZR1pOZFZuRXho?=
 =?utf-8?B?V0JSMzdCSWhVRzFTNVJZUEpaeWdoK2J6WGdTdG1sRTU4bUNiWFNmbUhYNVRR?=
 =?utf-8?B?N0d2Y0JzcDNQcHk3M2RKWkFGUTVwMS9TTC8yYjY3TExuUHZEaGg1NXpFZEdy?=
 =?utf-8?B?M0FIWFc3NG04aXBWU0hJUW9pVE1vRVd0eEoyZ2JkcDFYYmdtcWhLRFFkVmFa?=
 =?utf-8?B?UHQwcFNTeCtYYWZWUUxZRmZxKzR3Q3ZjWTRYRFUzL0dLVnpqSlQzWXpoVmZH?=
 =?utf-8?B?N2RwSkVEU055MWZQUUVMeWZnclFZK1RvTVdUYytXMUtmeHJGdFl2WTVTNzY0?=
 =?utf-8?B?ekRkWHgwbmVMWTJQeEY0cnZFb2ZtNnlLR29FWndGWTRqMTEyR3pQLzMxY3NJ?=
 =?utf-8?B?WGpCNHZ2Y0wya3Z6dEd5MTZiTllyczROdE16K2gwR0hhS3haR2k5VDVBc2Ev?=
 =?utf-8?B?a1grdU1MTS9PWU5UcGk4T3B6ak9rcll6eTExRHdqb1d2Q1dVZjgwaTVlUWNF?=
 =?utf-8?B?emluWFhjQTVKcTN2bGZKNFFZMFlWSURDM01lQjgyOUM5QzFQQXFEajdYZmJn?=
 =?utf-8?B?Yk9jYkUwMEo2UHU4eGpuTHJ3SnlBYjQ2Rm9uUzRHMWNvbFk2LzZYWkFMZ3dI?=
 =?utf-8?B?eUlqU2ZQYU94WW43ZUxZdXJpbndQZWlFSVBnbGJZQiswWUJSQ0dJRjIyUEll?=
 =?utf-8?B?TEcwY1h0VnRxT2wzU1F1eTVPdFNhMmdDT2M3NFpZRnc5SWViYW1QOG1lUXdy?=
 =?utf-8?B?ZHMvOWpBRFFWaGw4MHVjWmwzR1ZkYnd1bWpWWTFGcHBoSU1NWUpoNlhYNi9w?=
 =?utf-8?B?OHpGbUJHd3Q1bC9IL1d6TVdOSGJleWhGNWRFb0NWa0duSVowN1VlZzV4R3Vu?=
 =?utf-8?B?dlBmTEptSEhvemxDMWFjbkFJOUh5YjYzTzdXSnJCWUVpakRMSzRxZHpzY3ky?=
 =?utf-8?Q?mcMY8GKhICNXH?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(376005)(82310400014)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2024 15:36:11.5964 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c04ef89-2b25-41a1-9248-08dc653d6f6a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044A1.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6822
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

v3(Christian):
  - keep contiguous flag handling outside of pages_per_block
    calculation
  - remove the hacky implementation in contiguous flag error
    handling code

v4(Christian):
  - use any variable and return value for non-contiguous
    fallback

v5: rebase to amd-staging-drm-next branch

Signed-off-by: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
Suggested-by: Christian König <christian.koenig@amd.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c   |  8 ++++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c | 23 +++++++++++++++-----
 2 files changed, 24 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
index 331b9ed8062c..316a9f897f2b 100644
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
 
@@ -964,6 +966,10 @@ int amdgpu_bo_pin_restricted(struct amdgpu_bo *bo, u32 domain,
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
index 8db880244324..f23002ed2b42 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
@@ -450,6 +450,7 @@ static int amdgpu_vram_mgr_new(struct ttm_resource_manager *man,
 {
 	struct amdgpu_vram_mgr *mgr = to_vram_mgr(man);
 	struct amdgpu_device *adev = to_amdgpu_device(mgr);
+	struct amdgpu_bo *bo = ttm_to_amdgpu_bo(tbo);
 	u64 vis_usage = 0, max_bytes, min_block_size;
 	struct amdgpu_vram_mgr_resource *vres;
 	u64 size, remaining_size, lpfn, fpfn;
@@ -468,7 +469,7 @@ static int amdgpu_vram_mgr_new(struct ttm_resource_manager *man,
 	if (tbo->type != ttm_bo_type_kernel)
 		max_bytes -= AMDGPU_VM_RESERVED_VRAM;
 
-	if (place->flags & TTM_PL_FLAG_CONTIGUOUS) {
+	if (bo->flags & AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS) {
 		pages_per_block = ~0ul;
 	} else {
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
@@ -477,7 +478,7 @@ static int amdgpu_vram_mgr_new(struct ttm_resource_manager *man,
 		/* default to 2MB */
 		pages_per_block = 2UL << (20UL - PAGE_SHIFT);
 #endif
-		pages_per_block = max_t(uint32_t, pages_per_block,
+		pages_per_block = max_t(u32, pages_per_block,
 					tbo->page_alignment);
 	}
 
@@ -498,7 +499,7 @@ static int amdgpu_vram_mgr_new(struct ttm_resource_manager *man,
 	if (place->flags & TTM_PL_FLAG_TOPDOWN)
 		vres->flags |= DRM_BUDDY_TOPDOWN_ALLOCATION;
 
-	if (place->flags & TTM_PL_FLAG_CONTIGUOUS)
+	if (bo->flags & AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS)
 		vres->flags |= DRM_BUDDY_CONTIGUOUS_ALLOCATION;
 
 	if (fpfn || lpfn != mgr->mm.size)
@@ -514,21 +515,31 @@ static int amdgpu_vram_mgr_new(struct ttm_resource_manager *man,
 		else
 			min_block_size = mgr->default_page_size;
 
-		BUG_ON(min_block_size < mm->chunk_size);
-
 		/* Limit maximum size to 2GiB due to SG table limitations */
 		size = min(remaining_size, 2ULL << 30);
 
 		if ((size >= (u64)pages_per_block << PAGE_SHIFT) &&
-				!(size & (((u64)pages_per_block << PAGE_SHIFT) - 1)))
+		    !(size & (((u64)pages_per_block << PAGE_SHIFT) - 1)))
 			min_block_size = (u64)pages_per_block << PAGE_SHIFT;
 
+		BUG_ON(min_block_size < mm->chunk_size);
+
 		r = drm_buddy_alloc_blocks(mm, fpfn,
 					   lpfn,
 					   size,
 					   min_block_size,
 					   &vres->blocks,
 					   vres->flags);
+
+		if (unlikely(r == -ENOSPC) && pages_per_block == ~0ul &&
+		    !(place->flags & TTM_PL_FLAG_CONTIGUOUS)) {
+			vres->flags &= ~DRM_BUDDY_CONTIGUOUS_ALLOCATION;
+			pages_per_block = max_t(u32, 2UL << (20UL - PAGE_SHIFT),
+						tbo->page_alignment);
+
+			continue;
+		}
+
 		if (unlikely(r))
 			goto error_free_blocks;
 
-- 
2.25.1

