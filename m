Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6293ED111A6
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Nov 2025 21:27:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 07DB410E6D9;
	Wed, 26 Nov 2025 21:27:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="JkjD+/Yw";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012033.outbound.protection.outlook.com [40.107.209.33])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1866A10E6D9
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Nov 2025 21:27:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jvnpyxGWoesZznaFIHUgD7YnBg/vpUdOhhKUVRhCVLUSl/hkPzPmYzyTZ/oEc4/je2YBFMe9g2fXW14XUn9T9rTuHU2ljDh5WBe4U9QAs1yCwlFE7p+sfVXhCOh3Adt7HwvkcoaHYQTntQjcUfVEmpJUVs6+sewF0Zr4Uw9Ou2QabJ+aezDNxWIYa4c1pl5yUc1jlvXIi6IEtsBeAGpKPQ3ExxS/hZehAG7QJRVPHydbPdHoiAFZJLRBK9e42kvH1U9HUYWdkZxcJCMJBt1c1bP0oE7RRTORYc1Z1wR7J42U3YlM1KTgSgTnH1BEtuSEO0EWgLmznlBKY9VnU8MB7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eS8J+mA9baNV77rvTVMNxtMKmSWh1B7hTNU07k85DHw=;
 b=w0+klEs/umo9MxHMGxK12Qx3jU6VdFIiXKtlB0tU2vrykSigm57r0mgCNn6/glYAkTWjIDQMtuB7SwqGSST7RF+8b2fFD2c6qkfKSFUoIPqxdwL1dKdSg6PvxEF87/la8VyWmKdpdHpSlMe7gqthl8pwhE4xcKaLXGVxJE7LwCtRZor/BitlBw9Xt3zXKorUbYb2z8N0skrfJalXOLQ0o2nO4NM89SGWCvLYoxkQCnJV1iykex2eVlTqiNguvMdKYxtuDFSLRq0X7AOpBCA4gHYiZgsxpDB3SkZJxSXjIw4HaFPjlgfJ9uTNnEZvmhQXW7z1fvF+nXbt2th0C2AEJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eS8J+mA9baNV77rvTVMNxtMKmSWh1B7hTNU07k85DHw=;
 b=JkjD+/Yw7NwX4qvv9znFmYlxL5gUasErhvKbzpKENEVzDr6QoJ+xkEScp3QvmS8GwsdpxNJwGCd05Xf4dTD17sVQfUpdHyihE961++UK/V1Gmz9B+W3RoaAlcwsN6kFt5x5Wf6pRnXRAX/sim+3/XHO4/zlTT75EhrBcUw9h9oM=
Received: from DS2PEPF0000455D.namprd21.prod.outlook.com
 (2603:10b6:f:fc00::515) by DM4PR12MB6639.namprd12.prod.outlook.com
 (2603:10b6:8:be::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.12; Wed, 26 Nov
 2025 21:27:40 +0000
Received: from DS3PEPF0000C37D.namprd04.prod.outlook.com
 (2603:10b6:f:fc00::207) by DS2PEPF0000455D.outlook.office365.com
 (2603:10b6:f:fc00::515) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9388.4 via Frontend Transport; Wed,
 26 Nov 2025 21:27:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS3PEPF0000C37D.mail.protection.outlook.com (10.167.23.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9366.7 via Frontend Transport; Wed, 26 Nov 2025 21:27:40 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 26 Nov
 2025 15:27:38 -0600
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Felix.Kuehling@amd.com>, <christian.koenig@amd.com>,
 <david.yatsin@amd.com>, Philip Yang <Philip.Yang@amd.com>
Subject: [PATCH 4/4] drm/amdkfd: Map VRAM MQD on GART
Date: Wed, 26 Nov 2025 16:26:32 -0500
Message-ID: <20251126212632.1522315-5-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251126212632.1522315-1-Philip.Yang@amd.com>
References: <20251126212632.1522315-1-Philip.Yang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C37D:EE_|DM4PR12MB6639:EE_
X-MS-Office365-Filtering-Correlation-Id: 9263b803-ad51-40db-2ac2-08de2d32a0dd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?nSV/zE92yTUdRoDY4kwP2c5XWJ+uNm5ZZBILJ4x4QaHGF0L7ztuJFCbVzkVF?=
 =?us-ascii?Q?1WZy+oNuJo4gkiUGVszXtgOQTBkrKKoj8yUAvLeRBxKpjjjmCiwOfsWgZnI3?=
 =?us-ascii?Q?zcI9fd8jfMNmcMJmxQYKxqFG5eE8qcLZ1oi8YOTW0AvTl4JJY1HlgO5yPkHG?=
 =?us-ascii?Q?7GqLzvfm2p2BIhlvjgsgVyrMrltXWtdBO7ljosb11tB50w0HyuCSKhRTDPpG?=
 =?us-ascii?Q?AwWlqwOcx2PDrcYu8rRh8Sh8POgObFbOXcN1E+r9Dkdr2o+PHuPsaKchaJYu?=
 =?us-ascii?Q?lv3dpkCvVFiDV3KeqIzsYO2fGf2B7YXtCUjirKxpJEZpcJdhyIaXiepr0ihp?=
 =?us-ascii?Q?L8chv1FpBqwlTGOBLSGT0DK2sBwv0mSDGdkgbwBSPD9edQ+NiRSEwwTqyqbQ?=
 =?us-ascii?Q?CN9DIx/rLYk18llZYG//NOtL5dVYmMSYnVJ29Jk5uuYV+/er0G+KTtqKfVii?=
 =?us-ascii?Q?lN+hm1Ke4VbS5nNkjdErdLEx4mNouBOYXocgW5nQ0sVeYQ3cRLXyWhx2f00i?=
 =?us-ascii?Q?X6E9Hp/0PvlZZoV4TTewaySbUhdR4HZzwKS8aSoVqCZh1HSxqdtoRYH3iURy?=
 =?us-ascii?Q?Y2Ax9d6LwX+k8YU6n8eKax5z/uCQjZ+lpuPtIZ4S09GqPBBv59IoAuAzMQXS?=
 =?us-ascii?Q?eqhhRm66WvrwWR7ho3qYszoQtP+wT88bIImEySzR0URBK6gkD5HfAkLt0djU?=
 =?us-ascii?Q?CX0nBVFm3w4KU+Q49NEPqBk/INPicCex8dgR8+C3qPu5DWqLzFovNl7deXHF?=
 =?us-ascii?Q?HbMolLIuzvjwC71ZEt8q1nnil6GvGt9Dj2djoWdC2FXhsauLXQOvjlkTHpKx?=
 =?us-ascii?Q?mv76OvdxwCdCe0XuF3LUEtj/7HsdKAhTvsB0+pdW/UbMlRiTcqqjoh0GOZci?=
 =?us-ascii?Q?FDL0C7iTtehaeg55AG2SNJUhg3hgeacdQmcWNW/QXc6z1avvdXQZLp+fLyiv?=
 =?us-ascii?Q?a+3acmRNuX0QVPSCMz/iKTufkfZSq63ePHcdwAM6aHI5LXuHGS18MdY/ItnM?=
 =?us-ascii?Q?EhYqLbjzP0Ds3Eyes6pJy70eo2OBDyNB0tHdlJ8MqgXWlpGoPV0V1YkMMc7n?=
 =?us-ascii?Q?8bWjSa+X1n+NtBrcNorDfvrDl5G/ZOwCHbBZ8jpJNK+9gV6TnDY1D0vx+Nnc?=
 =?us-ascii?Q?Ay3veccitocM/5bXcOocnDQ0zyyVMivrEqa5220kBFI/aTQp1oZbx1g9aZlo?=
 =?us-ascii?Q?/5V4Mur4lGCA8R+zLx6OHAgXx+kwAM+8TNrd8o/6vOUG11khL4lB0EPe1n3q?=
 =?us-ascii?Q?2bZ1WnsovtnALETsaR6thwgZxSdtugqGs/UuhlQX2C1kuB5zLZjV+YJzNsMY?=
 =?us-ascii?Q?ghqjucah990aLIiMqjqfQFDrgopTl/gqMf529omFHmx4XtJYqkuJ8813LbgH?=
 =?us-ascii?Q?fPskinm2r9iCjOQ4nLl0Ws3K8vBihAmpak9iWFt1omHwni13LN66LeswkT2X?=
 =?us-ascii?Q?r3327rdjOTpJn1Ro/gY0cqsF5SKsIYtzqAR1mv3XVchumLWfwi6QsnSbQjOd?=
 =?us-ascii?Q?gcTCCTADCyrIZcqgtUwenIzkvL5BNzwaPKcpra06/rC9PmbeShdFlcEdwXRn?=
 =?us-ascii?Q?bPCP4Hf3Rb/Ui4R4PQw=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2025 21:27:40.2872 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9263b803-ad51-40db-2ac2-08de2d32a0dd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF0000C37D.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6639
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
support dynamic GART allocation to map VRAM MQD BO.

Change amdgpu_ttm_gart_bind_gfx9_mqd to map MQD in GART with gtt offset
for system pages or with gart_res for VRAM BO resource.

Add helper amdgpu_ttm_alloc_gart_for_vram_bo to alloc GART entries resource
for MQD bo->gart_res and bind to GART mapping.

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c    |   3 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.h    |   1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c       | 110 +++++++++++++++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h       |   1 +
 .../gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c   |   8 ++
 5 files changed, 105 insertions(+), 18 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
index 24ebba43a469..676b039ef70a 100644
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
index b1810d0893e8..4654e4819399 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -831,14 +831,27 @@ static void amdgpu_ttm_tt_unpin_userptr(struct ttm_device *bdev,
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
 
@@ -846,19 +859,30 @@ static void amdgpu_ttm_gart_bind_gfx9_mqd(struct amdgpu_device *adev,
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
+			amdgpu_gart_map_vram_range(adev,
+					(tbo->resource->start + page_idx) << PAGE_SHIFT,
+					abo->gart_res->start + page_idx, 1, flags, NULL);
+
+			amdgpu_gart_map_vram_range(adev,
+					(tbo->resource->start + page_idx + 1) << PAGE_SHIFT,
+					abo->gart_res->start + page_idx + 1,
+					pages_per_xcc - 1, ctrl_flags, NULL);
+		}
 	}
 }
 
@@ -874,12 +898,14 @@ static void amdgpu_ttm_gart_bind(struct amdgpu_device *adev,
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
@@ -999,6 +1025,54 @@ int amdgpu_ttm_alloc_gart(struct ttm_buffer_object *bo)
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
index 74940e59ed6e..0a9d2fc72c56 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
@@ -178,6 +178,7 @@ int amdgpu_fill_buffer(struct amdgpu_bo *bo,
 			bool delayed);
 
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

