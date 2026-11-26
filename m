Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7D45606A31E
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Nov 2026 14:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=xZQ9QGPr
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4A09610E9F7;
	Thu, 26 Nov 2026 14:43:44 +0000 (UTC)
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011037.outbound.protection.outlook.com [52.101.57.37])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9C74510E9F7
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Nov 2026 14:43:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wroucCYApYmvIowKRjKkrnPw4GDj5NpevmzS4nTBFCVnGkXGIN72FlT1tEK8DYpas541gOupxgCj16j8aCCTQ4iiomnFEThin6EjXVKoUIgKq35lF3aKF+BzJ1+CsnWI7ZuuA6dhhwUk6Uo1JMdwNs3NSIJpitLSbiwVi7fF7TJY5wjbfh06XubyW7dBzxmut9N9AIGHO/Sf8AvDos0YC2ACAWGetXMjU+51W3FbVltB1FZdEdp1yzAYmjXIqBj7oiAXhHI4DnirW7U/VNHKPQ40lINU4x2eUFdJ2RVUErhG3v/zs65FtpVzFtVLKP4tVa3/NYsGsOEtPxXbmJ8zIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n8LPgCCAOsY+tyebTS1t+mh49Xkh9YqAW0a7Rcwcstk=;
 b=CFSDH2ZvovnQt11P/ruUKkPz5NhvZ1egciX66YRuijaWD6V4l6LQ0m3iumRyrPZSgDrtkkVBLEtRkn7fUrn31Yl1g+4EoE7h07u8D+rL+WxPNdaiWCarMibaGDWm0QTbYn9+EPes2NFtvm6C7raONBqXROUJyRsXlZytxs6cxlM5sI9YaV499LYL1K336ZFVePe2cOMOF8qtov8zUv74BWB/dlJxlJkX7YgjuUw/HGKoYQALZlTikDo2tvt0oG5f+3KW7l/7rQ03XCVWV5cHeLUaEFNhAp/n08aglEPBeFhb3d/CL0d8h2atb3lOX5IaqxWhR+bBrZhfs+lh12LAxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n8LPgCCAOsY+tyebTS1t+mh49Xkh9YqAW0a7Rcwcstk=;
 b=xZQ9QGPrkVK568pGrbCNEMuFkgYUsUiFOrn0Pqtq9nHP3O8IPLxqAt9a3pI2q7e/Z0vcFLS1FJSoBdWjxNCVo48tjI5kJd4kkElGCpzuG/8gjloSC9GdVQDfGx8RyL4JauWnXX6J7kiXsMpU9PcD+EGWQajtUBlA11LiW9qsD+4=
Received: from BN0PR04CA0203.namprd04.prod.outlook.com (2603:10b6:408:e9::28)
 by DM4PR12MB8521.namprd12.prod.outlook.com (2603:10b6:8:17e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.7; Thu, 26 Nov
 2026 14:43:30 +0000
Received: from BN1PEPF00018545.namprd05.prod.outlook.com
 (2603:10b6:408:e9:cafe::87) by BN0PR04CA0203.outlook.office365.com
 (2603:10b6:408:e9::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.662.7 via Frontend Transport; Thu, 26
 Nov 2026 14:43:30 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN1PEPF00018545.mail.protection.outlook.com (10.167.248.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.688.5 via Frontend Transport; Thu, 26 Nov 2026 14:43:30 +0000
Received: from arun-nv33.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Thu, 26 Nov
 2026 08:43:28 -0600
From: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
To: <christian.koenig@amd.com>, <amd-gfx@lists.freedesktop.org>
CC: <alexander.deucher@amd.com>, Arunpravin Paneer Selvam
 <Arunpravin.PaneerSelvam@amd.com>
Subject: [PATCH] drm/amdgpu: Fix VRAM clearing after GPU reset
Date: Thu, 26 Nov 2026 20:12:40 +0530
Message-ID: <20261126144240.598627-1-Arunpravin.PaneerSelvam@amd.com>
X-Mailer: git-send-email 2.34.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00018545:EE_|DM4PR12MB8521:EE_
X-MS-Office365-Filtering-Correlation-Id: a987a6ac-5138-494f-2b53-08df4bcba35f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700016|23010399003|13003099007|261009223027099003|18002099003|10067099003|56012099006|11063799006|261026140227099003|261022105027099003|261026121527099003|261021121427099003|261028144727099003|261021123027099003|261102123227099003;
X-Microsoft-Antispam-Message-Info: N4GGCNZ5S0xCNhN/jznfFa80qjm6pAeCElC8kQT1d4M3LFJmdt+U/cX79C5NZXArQWHqYjbXu2603G0HeXgQpbSRBKav4m3RgR6g4EIT0AgsIKN3II7DL51lR5KcmfntQ5S8n0DcrSsK44N0AeIjhhdWlJErAeX4PEOBPDelujpr7eOSP9AXCaFdcRgfXo+uItIc2snDT4LR1A9Y0HgKKybP/1T9mlZFn1hu7QKQSGKw8TZvPcAMNtf58Csdek+W7Ymo4pJdPEKBfdREfuZHFutxrQTR+A8DB+FBsMgXXsoMkCeUpLuxuT21W9miaDGM80Qt6NtkkBBn76O30/zOBasOb0GlNlhPLP3vseT+0gAJ2MFFZhN9ATrrd81tLgWh1QeHFB25/VzUNwctkkhMH3rZfOxuS300lri3t4ykLNWkTLPXExdvKwD7reXiYHMVk4W3Gy4KHBFeXfI94OC/bVJcBGQRbylq54GseDQ0QPcgGwS4cAcq7U+gas40W26XwtaefXsTEGVVu5v9Vw8AhV1ZaVVKiAeKMuYnxgdfukXQ3IJp8ZErx/B4R8fxejpvU33DUsP4Sh6NJpFav8ispl3Pd4s1RGm5yF/nzf7e1nB0fhqaYHMlSZa4TB07DBFFutKdwT4W3hDyUFra5RByEQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700016)(23010399003)(13003099007)(261009223027099003)(18002099003)(10067099003)(56012099006)(11063799006)(261026140227099003)(261022105027099003)(261026121527099003)(261021121427099003)(261028144727099003)(261021123027099003)(261102123227099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: C8LCaJwg4Ds4JykYP7vABtYfw/zXXAM8HJIeNhWdGDF6M3fRDMZ/HI/EHslr1roarSzexIYToj18cMgj6EKieWjTepc3dZsvKjQJgAswHNiw4ubUo6wzmXazesXZNJzvnYaMFRwSKpBq8LFF0kkUqPtBmj3YIASrOgLKAjEgLVrgZCx9wcWeE/uU3U84zZztVk19qV9NEj3Yl8gbf7zxYskFSxZ9rxzghkoJhUZmaRmk/LOsDgLjXgkIUovLVj8CiSWpIWoEUBKlAPLZJSR3XbB5KhNOWatiwKXfpuXmx4WkUTISYPXZ9Ofzaww3mCxc6vgavWZKEpZjVyqJGsCE5qh6j2OudM4T2lyUsHuJFDzNUS1yRDjtAEBPtNE+ggtqtzHo9LhkRjXp7V5v8DTMF3+2aH9QB0j5+XRXb+iwWUMj6a7x7r1NHBSkfkTc8D6j
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2026 14:43:30.0839 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a987a6ac-5138-494f-2b53-08df4bcba35f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00018545.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8521
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

After a VRAM lost reset, freed VRAM can be handed out with old data:

1. Clear jobs inherit the error of a job cancelled by the reset and are
   skipped. Let clear jobs ignore the entity error.
2. Free blocks marked as cleared before the reset are not clear anymore.
   Reset their cleared state when the VRAM lost counter changes.
3. Blocks whose wipe was queued before the reset are freed as cleared,
   but the wipe may have been dropped. Don't mark them as cleared then.

Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/6141
Suggested-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.c      |  8 +++++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.h      |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c   |  5 +++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c      |  6 +++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c | 15 ++++++++++++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.h |  6 +++++-
 6 files changed, 33 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
index 8689a3c933b2..b186b5b73de2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
@@ -391,9 +391,11 @@ amdgpu_job_prepare_job(struct drm_sched_job *sched_job,
 	struct dma_fence *fence;
 	int r;
 
-	r = drm_sched_entity_error(s_entity);
-	if (r)
-		goto error;
+	if (!job->ignore_entity_error) {
+		r = drm_sched_entity_error(s_entity);
+		if (r)
+			goto error;
+	}
 
 	if (job->gang_submit) {
 		fence = amdgpu_device_switch_gang(ring->adev, job->gang_submit);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
index 18e788f0e790..1947d650cd7f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
@@ -75,6 +75,7 @@ struct amdgpu_job {
 	uint32_t                preemption_status;
 	bool                    vm_needs_flush;
 	bool			gds_switch_needed;
+	bool			ignore_entity_error;
 	uint64_t		vm_pd_addr;
 	unsigned		vmid;
 	unsigned		pasid;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
index d4651f2d437c..9512c778c4f1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
@@ -1366,7 +1366,7 @@ void amdgpu_bo_release_notify(struct ttm_buffer_object *bo)
 	struct amdgpu_device *adev = amdgpu_ttm_adev(bo->bdev);
 	struct dma_fence *fence = NULL;
 	struct amdgpu_bo *abo;
-	int r;
+	int vram_lost, r;
 
 	if (!amdgpu_bo_is_amdgpu_bo(bo))
 		return;
@@ -1398,13 +1398,14 @@ void amdgpu_bo_release_notify(struct ttm_buffer_object *bo)
 	if (r)
 		goto out;
 
+	vram_lost = atomic_read(&adev->vram_lost_counter);
 	r = amdgpu_ttm_clear_buffer(amdgpu_ttm_next_clear_entity(adev),
 				    abo, &bo->base._resv, &fence,
 				    false, AMDGPU_KERNEL_JOB_ID_CLEAR_ON_RELEASE);
 	if (WARN_ON(r))
 		goto out;
 
-	amdgpu_vram_mgr_set_cleared(bo->resource);
+	amdgpu_vram_mgr_set_cleared(bo->resource, vram_lost);
 	dma_resv_add_fence(&bo->base._resv, fence, DMA_RESV_USAGE_KERNEL);
 	dma_fence_put(fence);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index d5c1d044403e..5c683df901ca 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -435,13 +435,15 @@ static int amdgpu_move_blit(struct ttm_buffer_object *bo,
 	/* clear the space being freed */
 	if (old_mem->mem_type == TTM_PL_VRAM &&
 	    (abo->flags & AMDGPU_GEM_CREATE_VRAM_WIPE_ON_RELEASE)) {
+		int vram_lost = atomic_read(&adev->vram_lost_counter);
 		struct dma_fence *wipe_fence = NULL;
+
 		r = amdgpu_ttm_clear_buffer(entity, abo, NULL, &wipe_fence,
 					    false, AMDGPU_KERNEL_JOB_ID_MOVE_BLIT);
 		if (r) {
 			goto error;
 		} else if (wipe_fence) {
-			amdgpu_vram_mgr_set_cleared(bo->resource);
+			amdgpu_vram_mgr_set_cleared(bo->resource, vram_lost);
 			dma_fence_put(fence);
 			fence = wipe_fence;
 		}
@@ -2647,6 +2649,8 @@ static int amdgpu_ttm_fill_mem(struct amdgpu_device *adev,
 	if (r)
 		return r;
 
+	job->ignore_entity_error = true;
+
 	for (i = 0; i < num_loops; i++) {
 		uint32_t cur_size = min(byte_count, max_bytes);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
index 249f07f30951..ef4c7b438406 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
@@ -456,7 +456,7 @@ static int amdgpu_vram_mgr_new(struct ttm_resource_manager *man,
 	struct gpu_buddy *mm = &mgr->mm;
 	struct gpu_buddy_block *block;
 	unsigned long pages_per_block;
-	int r;
+	int vram_lost, r;
 
 	lpfn = (u64)place->lpfn << PAGE_SHIFT;
 	if (!lpfn || lpfn > man->size)
@@ -523,6 +523,13 @@ static int amdgpu_vram_mgr_new(struct ttm_resource_manager *man,
 	}
 
 	mutex_lock(&mgr->lock);
+
+	vram_lost = atomic_read(&adev->vram_lost_counter);
+	if (unlikely(mgr->vram_lost_counter != vram_lost)) {
+		gpu_buddy_reset_clear(mm, false);
+		mgr->vram_lost_counter = vram_lost;
+	}
+
 	while (remaining_size) {
 		if (tbo->page_alignment)
 			min_block_size = (u64)tbo->page_alignment << PAGE_SHIFT;
@@ -652,6 +659,11 @@ static void amdgpu_vram_mgr_del(struct ttm_resource_manager *man,
 	list_for_each_entry(block, &vres->blocks, link)
 		vis_usage += amdgpu_vram_mgr_vis_size(adev, block);
 
+	if ((vres->flags & GPU_BUDDY_CLEARED) &&
+	    vres->clear_vram_lost_counter != atomic_read(&adev->vram_lost_counter)) {
+		vres->flags &= ~GPU_BUDDY_CLEARED;
+	}
+
 	gpu_buddy_free_list(mm, &vres->blocks, vres->flags);
 	amdgpu_vram_mgr_do_reserve(man);
 	mutex_unlock(&mgr->lock);
@@ -961,6 +973,7 @@ int amdgpu_vram_mgr_init(struct amdgpu_device *adev)
 	INIT_LIST_HEAD(&mgr->reserved_pages);
 	INIT_LIST_HEAD(&mgr->allocated_vres_list);
 	mgr->default_page_size = PAGE_SIZE;
+	mgr->vram_lost_counter = atomic_read(&adev->vram_lost_counter);
 
 	man->func = &amdgpu_vram_mgr_func;
 	err = gpu_buddy_init(&mgr->mm, man->size, PAGE_SIZE);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.h
index e581cbf52fcb..378e9c89be7d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.h
@@ -39,6 +39,7 @@ struct amdgpu_vram_mgr {
 	u64 default_page_size;
 	struct list_head allocated_vres_list;
 	struct dmem_cgroup_region *cg_region;
+	int vram_lost_counter;
 };
 
 struct amdgpu_vres_task {
@@ -58,6 +59,7 @@ struct amdgpu_vram_mgr_resource {
 	unsigned long flags;
 	struct list_head vres_node;
 	struct amdgpu_vres_task task;
+	int clear_vram_lost_counter;
 };
 
 static inline u64 amdgpu_vram_mgr_block_start(struct gpu_buddy_block *block)
@@ -81,12 +83,14 @@ to_amdgpu_vram_mgr_resource(struct ttm_resource *res)
 	return container_of(res, struct amdgpu_vram_mgr_resource, base);
 }
 
-static inline void amdgpu_vram_mgr_set_cleared(struct ttm_resource *res)
+static inline void amdgpu_vram_mgr_set_cleared(struct ttm_resource *res,
+					       int vram_lost_counter)
 {
 	struct amdgpu_vram_mgr_resource *ares = to_amdgpu_vram_mgr_resource(res);
 
 	WARN_ON(ares->flags & GPU_BUDDY_CLEARED);
 	ares->flags |= GPU_BUDDY_CLEARED;
+	ares->clear_vram_lost_counter = vram_lost_counter;
 }
 
 int amdgpu_vram_mgr_query_address_block_info(struct amdgpu_vram_mgr *mgr,
-- 
2.53.0

