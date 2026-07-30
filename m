Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34622C531D0
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Jul 2026 06:44:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B65B710EDC3;
	Thu, 30 Jul 2026 06:44:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="LpfOHG4f";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010015.outbound.protection.outlook.com [52.101.201.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D427810EDC3
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Jul 2026 06:44:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ylakOD/oa7E56abPQUxLMZWUrDGCUylpXYqrZsTqwinf1j8uXJXWL+0GcIAs0VH/lgNTzw/KNx5x3MUUsTjKn6+DC0LK3/66ZPbJDZJhHYQCII1TSgbxO1D2tqH9wPJlky7nSJVCtXbMLb1o3RguVqQ/KqmqTloGpBUXs06pGbm0zft2qgpDchQNw0Os0M0leIYCy9GvPw8yTIMl2r4E1UoSBWzkf/EOhbGoBEyWpIRJB4h2j+QeIRYSLDB6sadoz5LJmZG4Zm6CihUoxzmxjn70XLjOK7zSaXBH3AVHMXZFph86HN8hD7v84Ff8olTV0CTG5zxsV/kG+DLPJ1gggA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=99gkAskGtLORDoYozWF0eiMAndIF+V4k4nruYx4vgVY=;
 b=xYeiW89TnasjSC4X7Vu1EnWb/g4IDkS2V7DYq8bZEriMuFZod5MIX/tZdKllSXO2Smac3XeOFTFphOCobqOggWiT6hT4GdWvbelIIulPUkKYTqxzDpBNp0XXQsSw0urk+jqPLjYqB260+RIgPDOofYcKc8+8m8RxQTUlPZLd/Gh0dkQ1jJG+ij7cdRC6FeZOQN5DLp4zaUAE4ihBgQsEpEOI0+l+CBLaHOwalsZWocgKgypfdYq/JMUKF5B+CNscdxme0YVs0hPFztuWFSBC0OYlK5YpOUqKMwsxDBiYF5kfWi7SP2nn5x0mg5l2B7kxVS+qte7OTODKRcs3zlE16Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=99gkAskGtLORDoYozWF0eiMAndIF+V4k4nruYx4vgVY=;
 b=LpfOHG4fUE16sDCp4szcKT8OGKraNbJIJ8rUwcPH80incx3FT+hZPubxyOzlRpzzKns2glnNGrBfzRt9qSKyrp6d6zgXpU9G8eU5MTn1MVabnSR34+7z3ElojyorWQvIh5OzeqzYJPwFeIuLB8ILg3zFodRTJ28BTHyxymkneqs=
Received: from SJ0PR03CA0363.namprd03.prod.outlook.com (2603:10b6:a03:3a1::8)
 by SA1PR12MB9546.namprd12.prod.outlook.com (2603:10b6:806:459::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.15; Thu, 30 Jul
 2026 06:44:08 +0000
Received: from BY1PEPF0001AE19.namprd04.prod.outlook.com
 (2603:10b6:a03:3a1:cafe::9f) by SJ0PR03CA0363.outlook.office365.com
 (2603:10b6:a03:3a1::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.270.13 via Frontend Transport; Thu,
 30 Jul 2026 06:44:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BY1PEPF0001AE19.mail.protection.outlook.com (10.167.242.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.292.8 via Frontend Transport; Thu, 30 Jul 2026 06:44:07 +0000
Received: from yifan.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 30 Jul
 2026 01:44:04 -0500
From: Yifan Zhang <yifan1.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>,
 <David.Francis@amd.com>, <Perry.Yuan@amd.com>, Yifan Zhang
 <yifan1.zhang@amd.com>
Subject: [PATCH v2] drm/amdgpu: skip BOs being torn down during GTT recovery
Date: Thu, 30 Jul 2026 14:43:50 +0800
Message-ID: <20260730064350.1040733-1-yifan1.zhang@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY1PEPF0001AE19:EE_|SA1PR12MB9546:EE_
X-MS-Office365-Filtering-Correlation-Id: c9e03331-9751-4519-8d28-08deee05f449
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|36860700016|82310400026|1800799024|376014|56012099006|10067099003|18002099003|11063799006;
X-Microsoft-Antispam-Message-Info: KFyjvbs9R3RE6q8q/sBiyHm5RpBweUUl5iVLEs+NrXivzGlLEodgk9+8/wDSGlHzABSM8XhWAXLOiCX93cqE3DJ52r0l0ZIceLu09bzA5w7g1SfKG0oZTTEnTBww63am6bHGxsfbgPcXQ+jhvMGfxTA0UyKBiB8GBGHTyX7WguOFYX39IUYDwp9I88MKA/Ll3L8/Sxe7dnkJ1a9UbR+gAk2hhjmIU7NzC0uNmFyeFS568v1z8ZIVZGlqbqBT/MMXiOJ7rtMpUpGxxQTC39qJXwU5+X4Jwq6ngXu+J+zt0iKCyRKrnP/5utjPUmP+dVuYdtDX4nrhNnFO7G1F7Vw3mOOfdSBdSKt0zO21ESxzkLU5TWiHcsjynIp9BmSavAkVfg4alxY0Mg6E5IM8upeMEuuzoakd0UqgWCQiXjnuFYISQhuKjraEeVoWq/2yrY1iwJ/ejzkuG252FXhe2odeB7RoXW5sqWRvlMNGGdGBg1XGqLoxd7Qpoq4oQAAwZThfEjYvg6ESDuQR8oaN8rbhzphjLWJRkAB7ZZ7IsoYAjVn+zr/z/Byh1miuTH9H8JSOxBp8qbkLSMeTB5kuHZfQqZqD44WFjsBUg+QZ9UdmUTVsh5JAoHsTCrfjXvh+7MBHbSnvBCumN3H1cMgIaGeeBInsLDWOqlVvkkMgOcqhKrSslOqBE5ewY1M14QxqXvYsXXPDhht3yhElZsHoomUL6g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(36860700016)(82310400026)(1800799024)(376014)(56012099006)(10067099003)(18002099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: iLi61HSqK7Mh8YfBEVp3yijUjuVQLx7tRcQU1obZQukPq38PoQVncDThfqxnmcLE4WGiZkxKkrjxY5AG0AQz63IN6TIwc/XSvbKaepVOS+TRUuCwvxBgj3980WB1p0iQh7Hib//mfWXl9Bxdlfk1jisImQ0AlPgyEV3HjVG/S42azrIFUBPFq+ItBvgSgZdTFTZ/+g1wmhAnL9FAXsDK5v74xg6GYeEOKfze5es9JJ0QDrH7GGKhjqxUOD7PmkaJNDf26Bz5ntF1YRzMzw7XGdXCdeYQt+ScWyTAqrl0fAir5vOWWxb9vnp6aFYBg7xRbjkTZPEFHYMwPQtkljMAQlfJkdD05MbBdiSywM69NTDzmFgDWArCSHq5Hm334PJ3csJ1Ek8kimuPptDqhDywx2ejcURMNIF1aQR3I7nYEWkQQvbizkDqeWMImU3v+hhY
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2026 06:44:07.2639 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c9e03331-9751-4519-8d28-08deee05f449
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BY1PEPF0001AE19.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB9546
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

A GPU reset can race with BO teardown after the BO's GTT resource has
been marked for deletion but before its drm_mm node is removed. In this
window, amdgpu_gtt_mgr_recover() can treat the node as a live BO and try
to restore its GART mapping while its TT backing is being destroyed.

Mark the GTT node with a dedicated stale-BO color from
amdgpu_bo_delete_mem_notify(). During recovery, process only nodes
colored as live BOs, leaving both stale-BO nodes and nodes without a BO
untouched.

This prevents reset recovery from accessing a BO whose backing storage
is no longer valid.

amdgpu 0000:a3:00.0: GPU reset succeeded, trying to resume
BUG: kernel NULL pointer dereference, address: 0000000000000000
PGD 62256dd067 P4D 0
Oops: Oops: 0000 [#1] SMP NOPTI
Workqueue: amdgpu-reset-dev amdgpu_debugfs_reset_work [amdgpu]
Call Trace:
 <TASK>
 amdgpu_gart_bind+0x1a/0x50 [amdgpu]
 amdgpu_ttm_gart_bind+0xd8/0xe0 [amdgpu]
 amdgpu_ttm_recover_gart+0x5f/0x80 [amdgpu]
 amdgpu_gtt_mgr_recover+0x43/0x70 [amdgpu]
 gmc_v12_0_hw_init+0x46/0x160 [amdgpu]
 gmc_v12_0_resume+0x14/0x40 [amdgpu]
 amdgpu_ip_block_resume+0x24/0x80 [amdgpu]
 amdgpu_device_ip_resume_phase1+0xce/0x180 [amdgpu]
 amdgpu_device_reinit_after_reset+0x13d/0x340 [amdgpu]
 amdgpu_do_asic_reset.part.0+0x56/0x1b0 [amdgpu]
 amdgpu_device_asic_reset+0x426/0x640 [amdgpu]
 ? srso_alias_return_thunk+0x5/0xfbef5
 amdgpu_device_gpu_recover+0x260/0x410 [amdgpu]
 amdgpu_debugfs_reset_work+0x68/0x90 [amdgpu]
 process_one_work+0x18e/0x3e0
 worker_thread+0x2e3/0x420
 ? _raw_spin_lock_irqsave+0xe/0x20
 ? srso_alias_return_thunk+0x5/0xfbef5
 ? __pfx_worker_thread+0x10/0x10
 kthread+0x10a/0x230
 ? __pfx_kthread+0x10/0x10
 ret_from_fork+0x121/0x140
 ? __pfx_kthread+0x10/0x10
 ret_from_fork_asm+0x1a/0x30
 </TASK>

Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c | 44 +++++++++++++++++++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c     |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h     |  1 +
 3 files changed, 42 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c
index 0ea32561c4bc..93d564bbad76 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c
@@ -26,7 +26,13 @@
 
 #include "amdgpu.h"
 
-#define GART_ENTRY_WITHOUT_BO_COLOR	1
+/*
+ * drm_mm node colors describing what a GART range belongs to:
+ * a usable GTT BO, no BO at all, or a GTT BO whose TT backing is going away.
+ */
+#define GART_ENTRY_COLOR_LIVE_BO	0
+#define GART_ENTRY_COLOR_NO_BO		1
+#define GART_ENTRY_COLOR_STALE_BO	2
 
 static inline struct amdgpu_gtt_mgr *
 to_gtt_mgr(struct ttm_resource_manager *man)
@@ -102,6 +108,35 @@ bool amdgpu_gtt_mgr_has_gart_addr(struct ttm_resource *res)
 	return drm_mm_node_allocated(&node->mm_nodes[0]);
 }
 
+/**
+ * amdgpu_gtt_mgr_mark_bo_teardown - exclude a BO from GART recovery
+ *
+ * @tbo: TTM BO whose TT backing is about to be destroyed
+ *
+ * Keep the GART range allocated until the resource is freed, but prevent
+ * reset recovery from using the BO after TT teardown has started.
+ */
+void amdgpu_gtt_mgr_mark_bo_teardown(struct ttm_buffer_object *tbo)
+{
+	struct amdgpu_device *adev = amdgpu_ttm_adev(tbo->bdev);
+	struct ttm_resource *res = tbo->resource;
+	struct ttm_range_mgr_node *node;
+	struct amdgpu_gtt_mgr *mgr;
+
+	dma_resv_assert_held(tbo->base.resv);
+
+	if (!res || res->mem_type != TTM_PL_TT)
+		return;
+
+	node = to_ttm_range_mgr_node(res);
+	mgr = &adev->mman.gtt_mgr;
+
+	spin_lock(&mgr->lock);
+	if (drm_mm_node_allocated(&node->mm_nodes[0]))
+		node->mm_nodes[0].color = GART_ENTRY_COLOR_STALE_BO;
+	spin_unlock(&mgr->lock);
+}
+
 /**
  * amdgpu_gtt_mgr_new - allocate a new node
  *
@@ -137,7 +172,8 @@ static int amdgpu_gtt_mgr_new(struct ttm_resource_manager *man,
 		spin_lock(&mgr->lock);
 		r = drm_mm_insert_node_in_range(&mgr->mm, &node->mm_nodes[0],
 						num_pages, tbo->page_alignment,
-						0, place->fpfn, place->lpfn,
+						GART_ENTRY_COLOR_LIVE_BO,
+						place->fpfn, place->lpfn,
 						DRM_MM_INSERT_BEST);
 		spin_unlock(&mgr->lock);
 		if (unlikely(r))
@@ -210,7 +246,7 @@ int amdgpu_gtt_mgr_alloc_entries(struct amdgpu_gtt_mgr *mgr,
 
 	spin_lock(&mgr->lock);
 	r = drm_mm_insert_node_in_range(&mgr->mm, mm_node, num_pages,
-					alignment, GART_ENTRY_WITHOUT_BO_COLOR, 0,
+					alignment, GART_ENTRY_COLOR_NO_BO, 0,
 					adev->gmc.gart_size >> PAGE_SHIFT,
 					mode);
 	spin_unlock(&mgr->lock);
@@ -248,7 +284,7 @@ void amdgpu_gtt_mgr_recover(struct amdgpu_gtt_mgr *mgr)
 	adev = container_of(mgr, typeof(*adev), mman.gtt_mgr);
 	spin_lock(&mgr->lock);
 	drm_mm_for_each_node(mm_node, &mgr->mm) {
-		if (mm_node->color == GART_ENTRY_WITHOUT_BO_COLOR)
+		if (mm_node->color != GART_ENTRY_COLOR_LIVE_BO)
 			continue;
 
 		node = container_of(mm_node, typeof(*node), mm_nodes[0]);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index c4094edbdff1..ab4c2c78f639 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -1694,6 +1694,7 @@ static int amdgpu_ttm_access_memory(struct ttm_buffer_object *bo,
 static void
 amdgpu_bo_delete_mem_notify(struct ttm_buffer_object *bo)
 {
+	amdgpu_gtt_mgr_mark_bo_teardown(bo);
 	amdgpu_bo_move_notify(bo, false, NULL);
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
index ff9e2e346609..af1e7fcc7175 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
@@ -145,6 +145,7 @@ int amdgpu_vram_mgr_init(struct amdgpu_device *adev);
 void amdgpu_vram_mgr_fini(struct amdgpu_device *adev);
 
 bool amdgpu_gtt_mgr_has_gart_addr(struct ttm_resource *mem);
+void amdgpu_gtt_mgr_mark_bo_teardown(struct ttm_buffer_object *tbo);
 void amdgpu_gtt_mgr_recover(struct amdgpu_gtt_mgr *mgr);
 
 int amdgpu_gtt_mgr_alloc_entries(struct amdgpu_gtt_mgr *mgr,
-- 
2.43.0

