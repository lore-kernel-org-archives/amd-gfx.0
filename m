Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8EB8C4345F
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Apr 2024 07:14:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3987C10F946;
	Wed, 24 Apr 2024 07:14:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="pjF81UjS";
	dkim-atps=neutral
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2082.outbound.protection.outlook.com [40.107.101.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2537410F946
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Apr 2024 07:14:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HB3rLkTdBqRUEs/IkFRWko/GidCcs0d6Z90J4351Au78hy5hc+S1cBNSY8bMBEOe0zEo38hex0dFU8uVD3LvDW9ywVnu3iRXVHbZYaSoKOaXkXYuKjwHKxba3mi0SgKbohfu2eNu14+/DNBNo9d1gnfXkEdSBk1ALmuJX6VhpasCXHEgQtOge4fLbFkxNXx54g1V+4KqWuZmK2WV7xrGNxrA23dCy9KxHdm4BRO8mP4p3OsgxB7+QYu2vnntDtOcOPlhfNTET1lygEueLoJiA5h8i44S+VeuN43FQzH3XBwZlvJvGNWR2J4RlAejZFNG3L2m/vX+uk3eNGC0zePoMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4kGowfNkxa6rOODu/1duM1uw7l9yz74E5XMR6CP+CHY=;
 b=l5W+5LkSXlmFIYZAuppx2b4+kvmArHRnya3XF7f4F70da18zANhOoaCeXrBYG+xhiPoACTjZ7WlLDCMffmTn2NBaxqM1uhB09tSzEtrQJeVUhbRYVsxV8t5fw6oCBoYtL/1lognejRgdAM2e94xY9g7xtMg6I0jKuq+nQTAqgUHHxHb4eqYZ/x0lJUNHQAP2aSXFJmAsfXQwqYfDhFP98Y/k7ZQW/LCUVK4s3G4p1ath8L+k1fBJGSHLCnLNk2SX2Um7VyL0BTVgARiGSv1nYCs6Rpm0Tfr+vV77oExGWCpYRQlXn0Piinp+6xWhb8GmGCL3DDvXo/VzosImP6k9Bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4kGowfNkxa6rOODu/1duM1uw7l9yz74E5XMR6CP+CHY=;
 b=pjF81UjSbSyW1Ne/yYS9vhP3raQQDzl4bDCoG6tW1P1tm54BhqlcuPG4y/Wldx7ReP2LjbprrQ793ctjn2mjYUBhi/W51e9dGS15Q9+VMEuISnj2q3XWLYdDFnuOa1xv73FZiJRh7bfFqdX6PTCKmfmRdrE2K8CgoPBjiP/SdTI=
Received: from DM6PR07CA0130.namprd07.prod.outlook.com (2603:10b6:5:330::22)
 by MW5PR12MB5599.namprd12.prod.outlook.com (2603:10b6:303:194::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Wed, 24 Apr
 2024 07:14:18 +0000
Received: from DS2PEPF00003440.namprd02.prod.outlook.com
 (2603:10b6:5:330:cafe::f4) by DM6PR07CA0130.outlook.office365.com
 (2603:10b6:5:330::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.23 via Frontend
 Transport; Wed, 24 Apr 2024 07:14:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF00003440.mail.protection.outlook.com (10.167.18.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7519.19 via Frontend Transport; Wed, 24 Apr 2024 07:14:17 +0000
Received: from amd-X570-AORUS-ELITE.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 24 Apr 2024 02:14:09 -0500
From: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <christian.koenig@amd.com>, <alexander.deucher@amd.com>,
 <felix.kuehling@amd.com>, <philip.yang@amd.com>, Arunpravin Paneer Selvam
 <Arunpravin.PaneerSelvam@amd.com>
Subject: [PATCH v3] drm/amdgpu: Modify the contiguous flags behaviour
Date: Wed, 24 Apr 2024 12:43:37 +0530
Message-ID: <20240424071337.3206-1-Arunpravin.PaneerSelvam@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003440:EE_|MW5PR12MB5599:EE_
X-MS-Office365-Filtering-Correlation-Id: 110fcbee-1974-4798-bdac-08dc642e27dc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cjcyUWc2UGZiY1VCMHQ2Tk1kQkp0UGhseEphWXRLS1c3NWcrNTJ3eVc4MmFo?=
 =?utf-8?B?SkNTdExwWUlGUW9IVDBmWVdMTkdSNDJQczZHSUpZc0dPTHJBUlhvdWRBaHh3?=
 =?utf-8?B?RkUvZmJmamZQcTg1aG5JUmlFeVYyVFRKc3FrU0h2MDZuVHlSNGlRRDI2RmRr?=
 =?utf-8?B?eWZxa3hEajIvN3U3UC9OdVNRcmVlOThkSFBjQ3Vqb3M0MVF2c2ZsWUozZXVS?=
 =?utf-8?B?SWxYVTlMdnBUVWh1U2hDSTlpajh4QWtEKzRFMFJqVE1qNXpzS2QvR3E5NEh4?=
 =?utf-8?B?SDdQaTRCK3dRd0tQVmtZY0Y3dTlBRkM3U2Fzd1E3TnlvYTg4QlNrSTJXdjVY?=
 =?utf-8?B?RER4bUFWN0g2dStLa1hVMzlrN29KOThEQndmZ3AzVWJGRjN1aWh6QngrK1dK?=
 =?utf-8?B?TTMvKzU1aFpEV2MxZDY5TzA4QmNNdk1hUFNPaVhmMGQwV2JVeTRYL2Qwejdh?=
 =?utf-8?B?eWdnLzdJcXVJby9FQjV2d3lGQXFuRzFzZG5GR3pSRkFubGNGTCtvUUpOemxT?=
 =?utf-8?B?TWxWREl2cnVaRmc0MFc5WS9FTUVhUUhPSERDODhwblc5QU1RMEFrQ2hFeERN?=
 =?utf-8?B?bldQUm9tY0MwWHNWZzVZdCtMRnIwUDY0VkpwMnY4blJuQXRnZHpUQkQrN1Bv?=
 =?utf-8?B?LzE5bEZYTTU1eEpNK2hhUFZHOTdweEhvYzVMcyt0eWFMamROOTZKQ0VPM0Ey?=
 =?utf-8?B?UFdKZFBEVXZRYVF1Y2RRaUlvL2dBelZrTmlDZUpRZWtPZ2g5TzJGbVI1Zk1s?=
 =?utf-8?B?Vm4zem1qNVJoTDlJakRoNXYvbUg0bHB4U0J5bFlWWmNsUHNNZ2s3VlZoWUox?=
 =?utf-8?B?cGIzRzB2K1h3WnJqWlpYSFdnVXZVTjNWVTIza0dzZkNjQVZ1dGNPSmxXZWgv?=
 =?utf-8?B?TUFxNVBXNFB4ZXdNcmFvYUw2VU1nZ3dmT3FhWTdjaStJclUvOVYvaHltOFRu?=
 =?utf-8?B?b3NIekxtL0RBNTBCNjRSeG05TDR2UWtIbkdJZURZeTFGWkNOTGFFQStNK2Na?=
 =?utf-8?B?RllTbHRJa09pU2ZLQk4wSDZrM04xbUlrSG5mbXRycTFuK0ttZ1FRZ2p4bGRl?=
 =?utf-8?B?Syt6RVRoWDdiYWErRm00WkE1V2Jwdkx6Ui9mcjFQU2EvbHVYeGpMSTBLZXBD?=
 =?utf-8?B?d0JGV1FBdTNWVDRmcm5VVHFDTHNUWDRGUHo5UXROaHZzWk5OR3lEb3Q0eEZP?=
 =?utf-8?B?dnRrVi83WGxFaGdwTXltc2FwdDlYNnBQdEk4bUV3eE9KL3FES0I4TkRvcmRs?=
 =?utf-8?B?MERqRkRCcVl3OFVGdWwxOE5WTHovc054RkNweHdnNDdyV0pyL0ZSaE5DSzcv?=
 =?utf-8?B?UXFBRnpUWlRmMTBSdU1jakhBbGVIck1OWWxRdGkybGRRazlROUNXTjVQblY2?=
 =?utf-8?B?SzMzblA1ZHdxNjFnRUZUdVdRMEswemxRODY3d0I3OWxsZ1NTUzVTNjRMVVhO?=
 =?utf-8?B?S25ySkFDVmFrY2VKbnFmOGNvU2FQSkFZSnBkSXlRNDRkc1ZGVCtHUlVBS2R6?=
 =?utf-8?B?V1ZmazdJMmhhcW1IQ3dRZTRwRFZRL3pBYi9VaStJOVZsZW5Jbk83cmc5dEoz?=
 =?utf-8?B?RHlMZ0kza0N6WlJOYi81cnVVSWJwTEpZZC9lNXhTSndrd3p5YUJubDdxQ3c4?=
 =?utf-8?B?OHp2T3dkekc1VlhCd1U3bjhTMk1hSXRXanBFOFlOc0pHTkg4WFhmeVhybWk4?=
 =?utf-8?B?cFI2WFdKdDF0MmpXb2pOYjJJQmVIODhqcTZDUXhQeTZweWlQdTlxMXVXKzFU?=
 =?utf-8?B?ekJhT2VRam4ySU1rZTBSUlBMNEJBeG95c2w3Z0o5SlA2OUxkRWFLaW1tSEFF?=
 =?utf-8?B?SG9VSnZ5V2RRT2Q3VndQWEFEM1YzYkE1R3hWNzFBM0NHZTMrbVhBdzBQVTFG?=
 =?utf-8?Q?arJo2AA7+9dCp?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(1800799015)(82310400014)(376005); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2024 07:14:17.8881 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 110fcbee-1974-4798-bdac-08dc642e27dc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003440.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR12MB5599
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

Signed-off-by: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
Suggested-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c   |  8 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c | 83 ++++++++++++++------
 2 files changed, 65 insertions(+), 26 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
index 492aebc44e51..c594d2a5978e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
@@ -154,8 +154,10 @@ void amdgpu_bo_placement_from_domain(struct amdgpu_bo *abo, u32 domain)
 		else
 			places[c].flags |= TTM_PL_FLAG_TOPDOWN;
 
-		if (flags & AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS)
+		if (abo->tbo.type == ttm_bo_type_kernel &&
+		    flags & AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS)
 			places[c].flags |= TTM_PL_FLAG_CONTIGUOUS;
+
 		c++;
 	}
 
@@ -965,6 +967,10 @@ int amdgpu_bo_pin_restricted(struct amdgpu_bo *bo, u32 domain,
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
index e494f5bf136a..17c5d9ce9927 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
@@ -88,6 +88,23 @@ static inline u64 amdgpu_vram_mgr_blocks_size(struct list_head *head)
 	return size;
 }
 
+static inline void amdgpu_vram_mgr_limit_min_block_size(unsigned long pages_per_block,
+							u64 size,
+							u64 *min_block_size,
+							bool contiguous_enabled)
+{
+	if (contiguous_enabled)
+		return;
+
+	/*
+	 * if size >= 2MiB, limit the min_block_size to 2MiB
+	 * for better TLB usage.
+	 */
+	if ((size >= (u64)pages_per_block << PAGE_SHIFT) &&
+	    !(size & (((u64)pages_per_block << PAGE_SHIFT) - 1)))
+		*min_block_size = (u64)pages_per_block << PAGE_SHIFT;
+}
+
 /**
  * DOC: mem_info_vram_total
  *
@@ -452,11 +469,12 @@ static int amdgpu_vram_mgr_new(struct ttm_resource_manager *man,
 	struct amdgpu_device *adev = to_amdgpu_device(mgr);
 	struct amdgpu_bo *bo = ttm_to_amdgpu_bo(tbo);
 	u64 vis_usage = 0, max_bytes, min_block_size;
+	struct amdgpu_bo *bo = ttm_to_amdgpu_bo(tbo);
 	struct amdgpu_vram_mgr_resource *vres;
 	u64 size, remaining_size, lpfn, fpfn;
 	struct drm_buddy *mm = &mgr->mm;
-	struct drm_buddy_block *block;
 	unsigned long pages_per_block;
+	struct drm_buddy_block *block;
 	int r;
 
 	lpfn = (u64)place->lpfn << PAGE_SHIFT;
@@ -469,18 +487,14 @@ static int amdgpu_vram_mgr_new(struct ttm_resource_manager *man,
 	if (tbo->type != ttm_bo_type_kernel)
 		max_bytes -= AMDGPU_VM_RESERVED_VRAM;
 
-	if (place->flags & TTM_PL_FLAG_CONTIGUOUS) {
-		pages_per_block = ~0ul;
-	} else {
-#ifdef CONFIG_TRANSPARENT_HUGEPAGE
+	if (IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE))
 		pages_per_block = HPAGE_PMD_NR;
-#else
-		/* default to 2MB */
+	else
+		/* default to 2MiB */
 		pages_per_block = 2UL << (20UL - PAGE_SHIFT);
-#endif
-		pages_per_block = max_t(uint32_t, pages_per_block,
-					tbo->page_alignment);
-	}
+
+	pages_per_block = max_t(uint32_t, pages_per_block,
+				tbo->page_alignment);
 
 	vres = kzalloc(sizeof(*vres), GFP_KERNEL);
 	if (!vres)
@@ -499,7 +513,7 @@ static int amdgpu_vram_mgr_new(struct ttm_resource_manager *man,
 	if (place->flags & TTM_PL_FLAG_TOPDOWN)
 		vres->flags |= DRM_BUDDY_TOPDOWN_ALLOCATION;
 
-	if (place->flags & TTM_PL_FLAG_CONTIGUOUS)
+	if (bo->flags & AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS)
 		vres->flags |= DRM_BUDDY_CONTIGUOUS_ALLOCATION;
 
 	if (bo->flags & AMDGPU_GEM_CREATE_VRAM_CLEARED)
@@ -509,23 +523,23 @@ static int amdgpu_vram_mgr_new(struct ttm_resource_manager *man,
 		/* Allocate blocks in desired range */
 		vres->flags |= DRM_BUDDY_RANGE_ALLOCATION;
 
+	if (tbo->page_alignment)
+		min_block_size = (u64)tbo->page_alignment << PAGE_SHIFT;
+	else
+		min_block_size = mgr->default_page_size;
+
 	remaining_size = (u64)vres->base.size;
 
 	mutex_lock(&mgr->lock);
 	while (remaining_size) {
-		if (tbo->page_alignment)
-			min_block_size = (u64)tbo->page_alignment << PAGE_SHIFT;
-		else
-			min_block_size = mgr->default_page_size;
-
-		BUG_ON(min_block_size < mm->chunk_size);
-
 		/* Limit maximum size to 2GiB due to SG table limitations */
 		size = min(remaining_size, 2ULL << 30);
-
-		if ((size >= (u64)pages_per_block << PAGE_SHIFT) &&
-				!(size & (((u64)pages_per_block << PAGE_SHIFT) - 1)))
-			min_block_size = (u64)pages_per_block << PAGE_SHIFT;
+		amdgpu_vram_mgr_limit_min_block_size(pages_per_block,
+						     size,
+						     &min_block_size,
+						     bo->flags &
+						     AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS);
+		BUG_ON(min_block_size < mm->chunk_size);
 
 		r = drm_buddy_alloc_blocks(mm, fpfn,
 					   lpfn,
@@ -533,8 +547,27 @@ static int amdgpu_vram_mgr_new(struct ttm_resource_manager *man,
 					   min_block_size,
 					   &vres->blocks,
 					   vres->flags);
-		if (unlikely(r))
-			goto error_free_blocks;
+		if (unlikely(r)) {
+			if (bo->flags & AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS &&
+			    !(place->flags & TTM_PL_FLAG_CONTIGUOUS)) {
+				/* Fallback to non-contiguous allocation */
+				amdgpu_vram_mgr_limit_min_block_size(pages_per_block,
+								     size,
+								     &min_block_size,
+								     !(bo->flags &
+								     AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS));
+				r = drm_buddy_alloc_blocks(mm, fpfn,
+							   lpfn,
+							   size,
+							   min_block_size,
+							   &vres->blocks,
+							   vres->flags);
+				if (unlikely(r))
+					goto error_free_blocks;
+			} else {
+				goto error_free_blocks;
+			}
+		}
 
 		if (size > remaining_size)
 			remaining_size = 0;
-- 
2.25.1

