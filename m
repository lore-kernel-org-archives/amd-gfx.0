Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D4D8C77B75
	for <amd-gfx@archiver.kernel.org>; Wed, 17 May 2023 21:41:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D7D5C10E4A0;
	Wed, 17 May 2023 21:41:14 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2073.outbound.protection.outlook.com [40.107.223.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B058F10E4A2
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 May 2023 21:41:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XtOFbp1K0+LjbDFoNs4tMD4BYHTqI5ujRNdSv43zan4wpyT3Vr8sq5K2GCooYXrAhhU/nicq3rFNJ3T8CttQAz7GNlMSwbNeb5nnFgDIgeP3w3uDZQZ+hBij6LnpTAg49IoXThicYSMG6PxZpGLT5e6FTBwJ9WgjxxcmR8Y+gQ5v8IfO7heOOgiRV5h+tPoXxToohUMuHqP1W96Xq06Ovw9lsANel8tm5Xck9Vgk3NqYRi43ac8kcsci+Ddc7n4o/i3ArIuh9TZLp0ax+ih/7Og8gNG2qIGlT+N5mUCR5swpNyz0BEaQsaBo+86MyAm+CAfLPFGFh63t3YCSFurpSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0Xh0rlYNnqHQ7iKYYpDCjEvE8zY59tKrcpwzl2rUF1o=;
 b=Bcjuxt6UzxD1CX5PIMlnpe58QJ1nAakuIgYIn0p/9V66wCwm1BKWcQHaU4Qpxi4dcQXeQ8KS3I8FpdPzY0eX/l7c/URh9XoAm492I8+OSkDfScAlE95dN56cdYxxOP4P0e8lRM7lclwbHAN2n0S6UxD+VuDLKCJos+DuDjH0MFNr7AUGd9o10ekLph6IzWarjdbhBblQfM3gBPq7P6U1YtMC14C1WDAqxZaZahz4JnKFK9dlw0jQfbw0Q/Bnpy8thkKUCzMylDG87XT71g52KlYWNSRJOMVqUlrA++ZGEk6qts8H6PoOQaRcMVKdTeyscwuL67S14x75SBRAEsF/rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0Xh0rlYNnqHQ7iKYYpDCjEvE8zY59tKrcpwzl2rUF1o=;
 b=tGwQ3psIXsiT9Z0Y9lqu6Yf/zwJRTNXxV97UGFLL1bdYZP143KUvqPlMRfeqkLjFX6Fb3IitR735wQM5T26eOo13xZpILsR3EiI5ovP9qepfK2reequtKqvD9aekvLtWfIc9TbFqQYBR+xzcqgM4/kYYgIDym5BTGkkwiMjifQw=
Received: from BN9PR03CA0391.namprd03.prod.outlook.com (2603:10b6:408:111::6)
 by CY5PR12MB6227.namprd12.prod.outlook.com (2603:10b6:930:21::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.33; Wed, 17 May
 2023 21:41:09 +0000
Received: from BN8NAM11FT056.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:111:cafe::4d) by BN9PR03CA0391.outlook.office365.com
 (2603:10b6:408:111::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.34 via Frontend
 Transport; Wed, 17 May 2023 21:41:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT056.mail.protection.outlook.com (10.13.177.26) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6411.17 via Frontend Transport; Wed, 17 May 2023 21:41:09 +0000
Received: from mukjoshi-dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 17 May
 2023 16:41:06 -0500
From: Mukul Joshi <mukul.joshi@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: Add a low priority scheduler for VRAM clearing
Date: Wed, 17 May 2023 17:40:40 -0400
Message-ID: <20230517214040.539342-1-mukul.joshi@amd.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT056:EE_|CY5PR12MB6227:EE_
X-MS-Office365-Filtering-Correlation-Id: 1bacaefb-13bd-43fe-9eae-08db571f6d4a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8gGaBc+PqHglS2qrAMjffe/YPA0uTEjmutyJC5V+AqM7M66jKnkLnDraXEUwlO/3Af0Nks5yo/jwoC6AwQTQXRkwH6Ck5CtdwF6ZfReCFNaRv8mqXnLeehIhgv4ShgPrwbwo+hs6OM0p6ltmlZpLqklh1NhtlqgfjMlmiutk5gtkuGU/ZuIipCTS5y4Z0PUXsKDdy8dCQkd/VOfnOVdiBQratYTkTi2k5YjvbcZZWfGcToub0iRf1XeF7Cp8LjF21Ax2XtWcKnS4SpxvKhDn7Sa037W0SfqC18iHaW/1Ku5mfKO9UDKIM6EqAmUSWZ1NYiVrL+Y/gkNHh3uvAzatUuVaTcs9YhYsHbcVTmj4vL3Zc0XwIKZvVFYB079rQBYMSsTJNPAGM6aLCh7w+wU7lIoB+1VmxhXTr6D+n/2Uy0CdoMTYWgugfIPAqFg6xOqHyxowH7J5Y2XywFfSiHcjPc6FOUg4DqyMrdBxfy5dwBorIkixFMPWO+OFCzpZEUKJfhPLDaE+DQpk/ghYkataz8L+RfufVRNKmqKaHGmjy/XhjRXNcPPIWRCJZppg4otUmOTNN6ehw7tdO4Utp/O9ZsTRweE6GJHq5DkPwkFBRZ743a9vOSa2RLSS5CK8GEMk9DuW4K4jpLitbSGnpMHC30vXri9NbbBsbFzQtIE6OivFA8OLrQCEITHaoqdi6r+1g5xiriAHoHk0Ieokh49z/cj4fzYvZx5DoDqqekuc0mHnDf/nVgqzVLGHRzun/rdjNSQqEAXRNgeOcaHn7DlsRg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(396003)(136003)(346002)(39860400002)(451199021)(46966006)(36840700001)(40470700004)(1076003)(40460700003)(26005)(7696005)(36756003)(336012)(426003)(36860700001)(2616005)(40480700001)(83380400001)(81166007)(86362001)(82310400005)(356005)(82740400003)(186003)(16526019)(47076005)(44832011)(54906003)(478600001)(316002)(2906002)(41300700001)(8676002)(5660300002)(70206006)(4326008)(6916009)(8936002)(70586007)(6666004)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2023 21:41:09.1797 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1bacaefb-13bd-43fe-9eae-08db571f6d4a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT056.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6227
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
Cc: Mukul Joshi <mukul.joshi@amd.com>, Felix.Kuehling@amd.com,
 christian.koenig@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Add a low priority DRM scheduler for VRAM clearing instead of using
the exisiting high priority scheduler. Use the high priority scheduler
for migrations and evictions.

Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c |  4 +--
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c    | 37 ++++++++++++++++------
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h    |  5 ++-
 3 files changed, 34 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
index 9924c8de57ab..46f249912b67 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
@@ -627,7 +627,7 @@ int amdgpu_bo_create(struct amdgpu_device *adev,
 	    bo->tbo.resource->mem_type == TTM_PL_VRAM) {
 		struct dma_fence *fence;
 
-		r = amdgpu_fill_buffer(bo, 0, bo->tbo.base.resv, &fence);
+		r = amdgpu_fill_buffer(bo, 0, bo->tbo.base.resv, &fence, true);
 		if (unlikely(r))
 			goto fail_unreserve;
 
@@ -1354,7 +1354,7 @@ void amdgpu_bo_release_notify(struct ttm_buffer_object *bo)
 	if (WARN_ON_ONCE(!dma_resv_trylock(bo->base.resv)))
 		return;
 
-	r = amdgpu_fill_buffer(abo, AMDGPU_POISON, bo->base.resv, &fence);
+	r = amdgpu_fill_buffer(abo, AMDGPU_POISON, bo->base.resv, &fence, true);
 	if (!WARN_ON(r)) {
 		amdgpu_bo_fence(abo, fence, false);
 		dma_fence_put(fence);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index 34724b771ace..bbdad0dc1b07 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -384,7 +384,8 @@ static int amdgpu_move_blit(struct ttm_buffer_object *bo,
 	    (abo->flags & AMDGPU_GEM_CREATE_VRAM_WIPE_ON_RELEASE)) {
 		struct dma_fence *wipe_fence = NULL;
 
-		r = amdgpu_fill_buffer(abo, AMDGPU_POISON, NULL, &wipe_fence);
+		r = amdgpu_fill_buffer(abo, AMDGPU_POISON, NULL, &wipe_fence,
+					false);
 		if (r) {
 			goto error;
 		} else if (wipe_fence) {
@@ -2040,8 +2041,18 @@ void amdgpu_ttm_set_buffer_funcs_status(struct amdgpu_device *adev, bool enable)
 				  r);
 			return;
 		}
+
+		r = drm_sched_entity_init(&adev->mman.delayed,
+					  DRM_SCHED_PRIORITY_NORMAL, &sched,
+					  1, NULL);
+		if (r) {
+			DRM_ERROR("Failed setting up TTM BO move entity (%d)\n",
+				  r);
+			goto error_free_entity;
+		}
 	} else {
 		drm_sched_entity_destroy(&adev->mman.entity);
+		drm_sched_entity_destroy(&adev->mman.delayed);
 		dma_fence_put(man->move);
 		man->move = NULL;
 	}
@@ -2053,6 +2064,11 @@ void amdgpu_ttm_set_buffer_funcs_status(struct amdgpu_device *adev, bool enable)
 		size = adev->gmc.visible_vram_size;
 	man->size = size;
 	adev->mman.buffer_funcs_enabled = enable;
+
+	return;
+
+error_free_entity:
+	drm_sched_entity_destroy(&adev->mman.entity);
 }
 
 static int amdgpu_ttm_prepare_job(struct amdgpu_device *adev,
@@ -2060,14 +2076,16 @@ static int amdgpu_ttm_prepare_job(struct amdgpu_device *adev,
 				  unsigned int num_dw,
 				  struct dma_resv *resv,
 				  bool vm_needs_flush,
-				  struct amdgpu_job **job)
+				  struct amdgpu_job **job,
+				  bool delayed)
 {
 	enum amdgpu_ib_pool_type pool = direct_submit ?
 		AMDGPU_IB_POOL_DIRECT :
 		AMDGPU_IB_POOL_DELAYED;
 	int r;
-
-	r = amdgpu_job_alloc_with_ib(adev, &adev->mman.entity,
+	struct drm_sched_entity *entity = delayed ? &adev->mman.delayed :
+						    &adev->mman.entity;
+	r = amdgpu_job_alloc_with_ib(adev, entity,
 				     AMDGPU_FENCE_OWNER_UNDEFINED,
 				     num_dw * 4, pool, job);
 	if (r)
@@ -2108,7 +2126,7 @@ int amdgpu_copy_buffer(struct amdgpu_ring *ring, uint64_t src_offset,
 	num_loops = DIV_ROUND_UP(byte_count, max_bytes);
 	num_dw = ALIGN(num_loops * adev->mman.buffer_funcs->copy_num_dw, 8);
 	r = amdgpu_ttm_prepare_job(adev, direct_submit, num_dw,
-				   resv, vm_needs_flush, &job);
+				   resv, vm_needs_flush, &job, false);
 	if (r)
 		return r;
 
@@ -2144,7 +2162,7 @@ static int amdgpu_ttm_fill_mem(struct amdgpu_ring *ring, uint32_t src_data,
 			       uint64_t dst_addr, uint32_t byte_count,
 			       struct dma_resv *resv,
 			       struct dma_fence **fence,
-			       bool vm_needs_flush)
+			       bool vm_needs_flush, bool delayed)
 {
 	struct amdgpu_device *adev = ring->adev;
 	unsigned int num_loops, num_dw;
@@ -2157,7 +2175,7 @@ static int amdgpu_ttm_fill_mem(struct amdgpu_ring *ring, uint32_t src_data,
 	num_loops = DIV_ROUND_UP_ULL(byte_count, max_bytes);
 	num_dw = ALIGN(num_loops * adev->mman.buffer_funcs->fill_num_dw, 8);
 	r = amdgpu_ttm_prepare_job(adev, false, num_dw, resv, vm_needs_flush,
-				   &job);
+				   &job, delayed);
 	if (r)
 		return r;
 
@@ -2180,7 +2198,8 @@ static int amdgpu_ttm_fill_mem(struct amdgpu_ring *ring, uint32_t src_data,
 int amdgpu_fill_buffer(struct amdgpu_bo *bo,
 			uint32_t src_data,
 			struct dma_resv *resv,
-			struct dma_fence **f)
+			struct dma_fence **f,
+			bool delayed)
 {
 	struct amdgpu_device *adev = amdgpu_ttm_adev(bo->tbo.bdev);
 	struct amdgpu_ring *ring = adev->mman.buffer_funcs_ring;
@@ -2209,7 +2228,7 @@ int amdgpu_fill_buffer(struct amdgpu_bo *bo,
 			goto error;
 
 		r = amdgpu_ttm_fill_mem(ring, src_data, to, cur_size, resv,
-					&next, true);
+					&next, true, delayed);
 		if (r)
 			goto error;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
index 8ef048a0a33e..e82b1edee7a4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
@@ -61,6 +61,8 @@ struct amdgpu_mman {
 	struct mutex				gtt_window_lock;
 	/* Scheduler entity for buffer moves */
 	struct drm_sched_entity			entity;
+	/* Scheduler entity for VRAM clearing */
+	struct drm_sched_entity			delayed;
 
 	struct amdgpu_vram_mgr vram_mgr;
 	struct amdgpu_gtt_mgr gtt_mgr;
@@ -152,7 +154,8 @@ int amdgpu_ttm_copy_mem_to_mem(struct amdgpu_device *adev,
 int amdgpu_fill_buffer(struct amdgpu_bo *bo,
 			uint32_t src_data,
 			struct dma_resv *resv,
-			struct dma_fence **fence);
+			struct dma_fence **fence,
+			bool delayed);
 
 int amdgpu_ttm_alloc_gart(struct ttm_buffer_object *bo);
 void amdgpu_ttm_recover_gart(struct ttm_buffer_object *tbo);
-- 
2.35.1

