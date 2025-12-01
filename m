Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BD5CD116F1
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Dec 2025 14:29:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1B48610E2B9;
	Mon,  1 Dec 2025 14:29:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="jWX1gjiq";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011014.outbound.protection.outlook.com [52.101.62.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 167E510E133
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Dec 2025 14:29:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LenB9TqNf6JLpf5NLlc+N+Rcqe3zQ6niJzJvxB22RRQ/v8qcYA9hAlLMp9aos2TmKQZWY2PT/0BYwq/HSZaHKMjBDBr4x3yAXOhi3by7s3c5FMr0mwR9xXxZX7vU/zN3MjajRcf1Y5U9IFgTpVzS7YllCrwx1iiarr0hbJ10UaUrX26k7uLgCdAPXhGsO5eJVRPLIoMVzNbPc71n9Fcl9GAWTYgiQXu2h9VC/ny1gu9ehxkKZvtfaEY2tBeZv5gJEykCE5lAfqa7ULukdaIlyQ+TlB2WwjpSAIQON2e0qcpmXxJxj3flSRfFt150waKqOXKFLMPlWp20V75uyQ6K8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JvdQjXUJKfYX4sXYvj4na0KaIMaB7HPRBop8UcPD1Ok=;
 b=lN2oB+J1i+Mr2wUM8Mj7w7KlybjHGpb3qozVOaCYWiEaoB2J3JKfIroUVGqyDHwBJpsJrdbBheUP6MCopg0fx2pOgPgcOwbxa/YDBwc/XZMf7dIXxq4IpgDlaAkei8YZjs6EjnIjf0cSpJSA14wwF0IKFBAi6z1pf9oaLGZfZnkRcZUAFY7o5kShCnUeo+sqvuZVbEmq1GSaef2xXDxD6nGOgdJypYWCdpLdgFwwtSfAfPKDSeJQAqSWr2voCbxrJ8TdXSnMziQpqIP83qEOKCcMaJq1FQMTZ2SMEpIAnZcDR2cwlfeFVCpbSP0ABWjrNkQwDq9xhVXpZLSJ1AkmGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JvdQjXUJKfYX4sXYvj4na0KaIMaB7HPRBop8UcPD1Ok=;
 b=jWX1gjiqOmq2V+gMFXmB5OVNY9HnSemSrbZgt+KEJ+TLqVM13yUTekbfcjwbQ2CAjlkFrNFwKNACmcB4oonPf/dXhHq0oPqxlBv623t/89kU7QDicQ5TdQzExFSk0fS4An8Xwlp/7MPB2yfcz+C9L8FNzRuvA0FfBzhC25bCBWg=
Received: from CH5PR02CA0012.namprd02.prod.outlook.com (2603:10b6:610:1ed::11)
 by SJ2PR12MB8831.namprd12.prod.outlook.com (2603:10b6:a03:4d0::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.11; Mon, 1 Dec
 2025 14:28:59 +0000
Received: from CH2PEPF00000099.namprd02.prod.outlook.com
 (2603:10b6:610:1ed:cafe::ca) by CH5PR02CA0012.outlook.office365.com
 (2603:10b6:610:1ed::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9366.17 via Frontend Transport; Mon,
 1 Dec 2025 14:28:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH2PEPF00000099.mail.protection.outlook.com (10.167.244.20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9388.8 via Frontend Transport; Mon, 1 Dec 2025 14:28:59 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 1 Dec
 2025 08:28:55 -0600
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Felix.Kuehling@amd.com>, <christian.koenig@amd.com>,
 <david.yatsin@amd.com>, Philip Yang <Philip.Yang@amd.com>
Subject: [PATCH v2 4/4] drm/amdkfd: Map VRAM MQD on GART
Date: Mon, 1 Dec 2025 09:28:38 -0500
Message-ID: <20251201142838.1516452-5-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251201142838.1516452-1-Philip.Yang@amd.com>
References: <20251201142838.1516452-1-Philip.Yang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000099:EE_|SJ2PR12MB8831:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f40cac2-fc8d-481f-72e4-08de30e5f776
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?e2b1/6RXzW85boc+CRFGcG60vXqOtZA+8qv+ss34gapoatul4vnEU48ZMPfT?=
 =?us-ascii?Q?ImmMZgqdkaFBr1ezH+TpuwP2ypqdyeDWvjrmPeF6tqdRMo0bZoMFH435O6P1?=
 =?us-ascii?Q?msRbE5FF1kpL6foRUYI4n3t7cv435QW9Y8ZYjc74ZUSKMCAYDmGxBZsMU8P3?=
 =?us-ascii?Q?xrECII2IXtuWTXK+f2KNeBzrgHoNdGs1Pt1wm0U5y7h7IEegRkfZz1XaoLbF?=
 =?us-ascii?Q?2Q67cMGSFKlvrNaDrYVRGHOueCR8DPQ74gUNLNgIB1bh3cKN/nBwiNkj9fI9?=
 =?us-ascii?Q?YFwUuBkad+4R88UCVlvCWbp9sFuoEK1FeQdrFG7S4IOK68Gq2Ze5Iul1Qi+g?=
 =?us-ascii?Q?vktwsUhwFgyWpl3Bnr4KQ+IR58w3A6SueA98m7UNibNQrnDhRprX7gjv5d4R?=
 =?us-ascii?Q?06cSQ1U3Y4yRPMRN+NE7DPH/bZKR5PCsaFFtI+VYWsfSiFWVFGYmibuZUk1Y?=
 =?us-ascii?Q?4t4FVj4y3o5khOeuTKniPNzOnaZR8U1Qb1gs4j6e6Wy7A5+nFEqNAjez4GPJ?=
 =?us-ascii?Q?7H5YFN70/YhV5+kepKJD7CNpPDJ0D4RwMvvKaXgfZFdekgpMdBwsmsQ8TNmA?=
 =?us-ascii?Q?MCErO+HX4efRAqkK2/e690BehYKzBDpEkAt2oBMfnB0W3DZH9aQn8wNR3p8d?=
 =?us-ascii?Q?YTLZCiU1KUWjUHVzfpi5n40fKWQO3jnv25ICtZ8OtVfC7aq3KwG6kkVVFS1f?=
 =?us-ascii?Q?TiOIitEGfgk0j6xvTH5d1ezzPkjtYwmzU3S+XtsBL+R3boAJefwNQtYBtMsy?=
 =?us-ascii?Q?ZSKQHcfRn15tKJAzMNQnlyYmUZ4JzdOwF1KRBmbTclbI1rzKwrIMq1KYRBPo?=
 =?us-ascii?Q?/09Wyo71XLQ86jdXAVCDZD4fE7aOpsXdHJmkp7Bpz4fyNtEFfOonrIhusjTR?=
 =?us-ascii?Q?q6V8H10gXWVmJKYaUvfI/M5pDzCNwalicBXZx5k5pprGZ/vL2b4IiGcMryM1?=
 =?us-ascii?Q?gxj8kZ5osh8+N8+urPnzTtLCy1ZhBzcJpH+Su11IgicNsj2pwddPOMNC0RI2?=
 =?us-ascii?Q?uQdK1IMwrW8d7h/wzZzn0kxR3hQ5uYNZ8IHXalQ5CP54fGW3noiSFEpgTz03?=
 =?us-ascii?Q?MUs4m22EPodPq8pZUzvSvT8US3ybrZCCYywL/hphQg3ZtEeiAaWGjFsAV3NA?=
 =?us-ascii?Q?QA2b1px2h81EaRazD/cAHtACd5zztO/GOTam9E0sQ4P6QpsHIWL8i1VD9ncr?=
 =?us-ascii?Q?erjs9cOc59pB2zUe7oAUfMBWqVcZmJsMDF3i5hEEeN7C88mSZfy5KA0HmWpx?=
 =?us-ascii?Q?1xcNtfA3peDAO2Nl+QnlTk+kt3bl6e+GagWPSlSmHWbYK88ekKb+GMv0zzaN?=
 =?us-ascii?Q?1QSTvWBcK/k1XNnfTJcw1WuWrfgH6A9cp5dx0O9LXBBf0ThzRcqcCTuzvDnA?=
 =?us-ascii?Q?glX93gjVqA3HYhidDn6KU+e18PZNEd5wQiRF5m1bZ2cotb2xO/3fmP8XHGjG?=
 =?us-ascii?Q?1MCb5UB6Me7v3qtD2lcEd2EWbYdKQseYG28yLZ1siTun9NS7VhlHL+/dEeWg?=
 =?us-ascii?Q?WxkXEFdxIsjKSGMAV+BgrX22pbEYq+3JTqilleMsfVmfW9jpxg0XxrcWXPlM?=
 =?us-ascii?Q?pDIF19QBRakLlrkiblY=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2025 14:28:59.0026 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f40cac2-fc8d-481f-72e4-08de30e5f776
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF00000099.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8831
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

MQD BO on VRAM access via FB aperture is mtype UC uncaching, map to GART
as mtype RW caching, to reduce queue switch latency.

TTM bo only has one resource, add GART resource to amdgpu_bo in order to
support dynamic GART resource and VRAM BO resource.

Update amdgpu_ttm_gart_bind_gfx9_mqd to map MQD in system or VRAM.

Add helper amdgpu_ttm_alloc_gart_for_vram_bo to alloc GART entries resource
for MQD bo->gart_res and bind to GART mapping.

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c    |   3 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.h    |   1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c       | 113 +++++++++++++++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h       |   1 +
 .../gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c   |   8 ++
 5 files changed, 108 insertions(+), 18 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
index 926a3f09a776..d267456cd181 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
@@ -1297,6 +1297,9 @@ void amdgpu_bo_release_notify(struct ttm_buffer_object *bo)
 
 	abo = ttm_to_amdgpu_bo(bo);
 
+	if (abo->gart_res)
+		ttm_resource_free(bo, &abo->gart_res);
+
 	WARN_ON(abo->vm_bo);
 
 	if (abo->kfd_bo)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
index 52c2d1731aab..a412f5ec2a09 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
@@ -106,6 +106,7 @@ struct amdgpu_bo {
 	struct ttm_place		placements[AMDGPU_BO_MAX_PLACEMENTS];
 	struct ttm_placement		placement;
 	struct ttm_buffer_object	tbo;
+	struct ttm_resource		*gart_res;
 	struct ttm_bo_kmap_obj		kmap;
 	u64				flags;
 	/* per VM structure for page tables and with virtual addresses */
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index 5f58cff2c28b..1d8f5fc66acc 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -832,14 +832,27 @@ static void amdgpu_ttm_tt_unpin_userptr(struct ttm_device *bdev,
  * Ctrl stack and modify their memory type to NC.
  */
 static void amdgpu_ttm_gart_bind_gfx9_mqd(struct amdgpu_device *adev,
-				struct ttm_tt *ttm, uint64_t flags)
+				struct ttm_buffer_object *tbo,
+				uint64_t flags)
 {
+	struct amdgpu_bo *abo = ttm_to_amdgpu_bo(tbo);
+	struct ttm_tt *ttm = tbo->ttm;
 	struct amdgpu_ttm_tt *gtt = (void *)ttm;
-	uint64_t total_pages = ttm->num_pages;
+	uint64_t total_pages;
 	int num_xcc = max(1U, adev->gfx.num_xcc_per_xcp);
 	uint64_t page_idx, pages_per_xcc;
-	int i;
 	uint64_t ctrl_flags = AMDGPU_PTE_MTYPE_VG10(flags, AMDGPU_MTYPE_NC);
+	int i;
+
+	if (!ttm && !abo->gart_res)
+		return;
+
+	if (ttm) {
+		total_pages = ttm->num_pages;
+	} else {
+		WARN_ON_ONCE(abo->gart_res->size != tbo->resource->size);
+		total_pages = (abo->gart_res->size) >> PAGE_SHIFT;
+	}
 
 	flags = AMDGPU_PTE_MTYPE_VG10(flags, AMDGPU_MTYPE_RW);
 
@@ -847,19 +860,33 @@ static void amdgpu_ttm_gart_bind_gfx9_mqd(struct amdgpu_device *adev,
 	do_div(pages_per_xcc, num_xcc);
 
 	for (i = 0, page_idx = 0; i < num_xcc; i++, page_idx += pages_per_xcc) {
-		/* MQD page: use default flags */
-		amdgpu_gart_bind(adev,
-				gtt->offset + (page_idx << PAGE_SHIFT),
-				1, &gtt->ttm.dma_address[page_idx], flags);
-		/*
-		 * Ctrl pages - modify the memory type to NC (ctrl_flags) from
-		 * the second page of the BO onward.
-		 */
-		amdgpu_gart_bind(adev,
-				gtt->offset + ((page_idx + 1) << PAGE_SHIFT),
-				pages_per_xcc - 1,
-				&gtt->ttm.dma_address[page_idx + 1],
-				ctrl_flags);
+		if (ttm) {
+			/* MQD page: use default flags */
+			amdgpu_gart_bind(adev,
+					gtt->offset + (page_idx << PAGE_SHIFT),
+					1, &gtt->ttm.dma_address[page_idx], flags);
+			/*
+			 * Ctrl pages - modify the memory type to NC (ctrl_flags) from
+			 * the second page of the BO onward.
+			 */
+			amdgpu_gart_bind(adev,
+					gtt->offset + ((page_idx + 1) << PAGE_SHIFT),
+					pages_per_xcc - 1,
+					&gtt->ttm.dma_address[page_idx + 1],
+					ctrl_flags);
+		} else {
+			u64 pa = (tbo->resource->start + page_idx) << PAGE_SHIFT;
+			u64 start_page = abo->gart_res->start + page_idx;
+
+			pa += adev->vm_manager.vram_base_offset;
+			amdgpu_gart_map_vram_range(adev, pa, start_page, 1,
+						   flags, NULL);
+
+			amdgpu_gart_map_vram_range(adev, pa + PAGE_SIZE,
+						   start_page + 1,
+						   pages_per_xcc - 1,
+						   ctrl_flags, NULL);
+		}
 	}
 }
 
@@ -875,12 +902,14 @@ static void amdgpu_ttm_gart_bind(struct amdgpu_device *adev,
 		flags |= AMDGPU_PTE_TMZ;
 
 	if (abo->flags & AMDGPU_GEM_CREATE_CP_MQD_GFX9) {
-		amdgpu_ttm_gart_bind_gfx9_mqd(adev, ttm, flags);
+		amdgpu_ttm_gart_bind_gfx9_mqd(adev, tbo, flags);
 	} else {
 		amdgpu_gart_bind(adev, gtt->offset, ttm->num_pages,
 				 gtt->ttm.dma_address, flags);
 	}
-	gtt->bound = true;
+
+	if (ttm)
+		gtt->bound = true;
 }
 
 /*
@@ -1000,6 +1029,54 @@ int amdgpu_ttm_alloc_gart(struct ttm_buffer_object *bo)
 	return 0;
 }
 
+int amdgpu_ttm_alloc_gart_vram_bo(struct amdgpu_bo *abo,
+				  u64 *gpu_addr)
+{
+	struct ttm_buffer_object *bo = &abo->tbo;
+	struct amdgpu_device *adev = amdgpu_ttm_adev(bo->bdev);
+	struct ttm_operation_ctx ctx = { false, false };
+	struct ttm_placement placement;
+	struct ttm_place placements;
+	struct ttm_resource *res;
+	uint64_t flags;
+	int r;
+
+	/* Only for valid VRAM bo resource */
+	if (bo->resource->start == AMDGPU_BO_INVALID_OFFSET)
+		return 0;
+
+	r = amdgpu_bo_reserve(abo, false);
+	if (unlikely(r))
+		return r;
+
+	/* allocate GART space */
+	placement.num_placement = 1;
+	placement.placement = &placements;
+	placements.fpfn = 0;
+	placements.lpfn = adev->gmc.gart_size >> PAGE_SHIFT;
+	placements.mem_type = TTM_PL_TT;
+	placements.flags = bo->resource->placement;
+
+	r = ttm_bo_mem_space(bo, &placement, &res, &ctx);
+	if (unlikely(r))
+		goto out_unreserve;
+
+	/* compute PTE flags for this buffer object */
+	flags = amdgpu_ttm_tt_pte_flags(adev, NULL, bo->resource);
+
+	/* Bind VRAM pages */
+	abo->gart_res = res;
+
+	amdgpu_ttm_gart_bind(adev, bo, flags);
+	amdgpu_gart_invalidate_tlb(adev);
+
+	*gpu_addr = res->start << PAGE_SHIFT;
+
+out_unreserve:
+	amdgpu_bo_unreserve(abo);
+	return r;
+}
+
 /*
  * amdgpu_ttm_recover_gart - Rebind GTT pages
  *
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
index 15e659575087..707654732759 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
@@ -179,6 +179,7 @@ int amdgpu_fill_buffer(struct amdgpu_bo *bo,
 			u64 k_job_id);
 
 int amdgpu_ttm_alloc_gart(struct ttm_buffer_object *bo);
+int amdgpu_ttm_alloc_gart_vram_bo(struct amdgpu_bo *abo, u64 *gpu_addr);
 void amdgpu_ttm_recover_gart(struct ttm_buffer_object *tbo);
 uint64_t amdgpu_ttm_domain_start(struct amdgpu_device *adev, uint32_t type);
 
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
index c6945c842267..d96de02c6bb9 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
@@ -148,6 +148,14 @@ static struct kfd_mem_obj *allocate_mqd(struct kfd_node *node,
 			kfree(mqd_mem_obj);
 			return NULL;
 		}
+
+		retval = amdgpu_ttm_alloc_gart_vram_bo(mqd_mem_obj->gtt_mem,
+						       &(mqd_mem_obj->gpu_addr));
+		if (retval) {
+			amdgpu_amdkfd_free_gtt_mem(node->adev, &(mqd_mem_obj->gtt_mem));
+			kfree(mqd_mem_obj);
+			return NULL;
+		}
 	} else {
 		retval = kfd_gtt_sa_allocate(node, sizeof(struct v9_mqd),
 				&mqd_mem_obj);
-- 
2.50.1

