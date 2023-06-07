Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F152DC7EE23
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Jun 2023 15:27:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 838FF10E527;
	Wed,  7 Jun 2023 15:27:12 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on20620.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8b::620])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 065B510E527
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 Jun 2023 15:27:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NOo9x6kM1SPpk8AVlxYEG8bWzVtXcFvknQOThj3Da79/HZVYZ4u8XJulW520kVX0rkz6PnC1tdizZA7aT0ZV/urtDVPho9OJKdZQmvU//MxQNO8PKA6YV3EYzgF5IkpSkibSUwOXXJi0ZuTG6GJgxZ/4A4Asp/riW2rCvg1/BhBPp1/PshyYijfjpocORWDb1N7PfXw6fVNCdH8IlND7DAaE69bLDE/Bl5a0nBP+oMR41HLlJddDwiz5JcT8ilXONMGNmBaDZe3SPigFpBEMXPOBSHs67r+3wtun7QaBu2rEBaJhKojEhL14DJxiNJSUgXYz6I74vtgRqUOpJcVslA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2s0o+eva46FcnPDV39p7miqkEUnnLmua3ApOndnxG1E=;
 b=mdO/gySPfUoe2g5eGEAt8TpVg18oN9mU0SluDjoR+O04j4OzLVOuEATsD4Hqjfvh9nNhSTSpQiK50edj168KZYVX/cH9i37C0maq6dcn6kt501VkFIune4/hQykYDJeImkTaXlpsjdOKxVMZ6ukt9WixHqgi41bgWpHoOAkrhkgLLywvS624zPZW4cBIzrV0GI7NRIcOmtdzZB0RYinJNu8AQDaxq+oJ1xRGLEc3mBMhx6tF0+M/1sx9y8EY0d+/rhN1lBTmwfgFAkio57vHMh+gRX3FA17sVIotg8nLbAsEMX1D1sZpBG9wneED9f4KvASHPMn2N6RSuYyUpo80SA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2s0o+eva46FcnPDV39p7miqkEUnnLmua3ApOndnxG1E=;
 b=WUQqHP/oba1gh5InHZ0lszfLoTpEyXUm0FK9g/wfh2ZMRxi1Lvt2Gn+szamuXJqw6pgmTlWCkkGPIpQKGghC/2cuHyhlo9D8mKNL6AM92dQrsu1Maeyw8WZFTp1pdTNxsfhHD0PHrQe2Hx2o0d+f6XXnZ+wcwdt3dHQqany03h0=
Received: from MWH0EPF00056D15.namprd21.prod.outlook.com
 (2603:10b6:30f:fff2:0:1:0:1e) by PH7PR12MB6786.namprd12.prod.outlook.com
 (2603:10b6:510:1ac::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Wed, 7 Jun
 2023 15:27:06 +0000
Received: from CO1NAM11FT008.eop-nam11.prod.protection.outlook.com
 (2a01:111:f400:7eab::203) by MWH0EPF00056D15.outlook.office365.com
 (2603:1036:d20::b) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.7 via Frontend
 Transport; Wed, 7 Jun 2023 15:27:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT008.mail.protection.outlook.com (10.13.175.191) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6455.36 via Frontend Transport; Wed, 7 Jun 2023 15:27:06 +0000
Received: from mukjoshi-dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 7 Jun
 2023 10:27:05 -0500
From: Mukul Joshi <mukul.joshi@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: Raname DRM schedulers in amdgpu TTM
Date: Wed, 7 Jun 2023 11:26:52 -0400
Message-ID: <20230607152652.320064-1-mukul.joshi@amd.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT008:EE_|PH7PR12MB6786:EE_
X-MS-Office365-Filtering-Correlation-Id: d1de965f-ce65-4807-0891-08db676ba6e2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Z0EAh6U7OLkuTajqMkt6dcQB2h03ZpekNjpl/HMMmZqZtYO0JZ6HogW+Y2Q7PD369gHU+NHIvHbjJdDvMASvjF8s9IJ+Cmu0VtwXzznXDpj6cugiir+w181jFLJbiwbIaAjxn6szPkl8+mCocDFA3mTUuYSCN9QIPBYMO7J5aXfVZQcbrjCAPhto3Z+lmLEIMBiv/DplfzujsZYJ2MNyFq5gWsDVI/xYw9zLEwk2vfQH53J4twhHLZyLHuIMm4JQ8g75bTMUoM6/ETgdqqx9d8EVoznQ7+3nFeBPq8sfaKUnav6GseQvTD90ihqA8lXxlTwBh+am473NVAHnup6goxBXBLha1sRMkgA0p1od4ErUMn7dtMTjCrxK0mVvaPxQxL1fS4PE/py6k+RT9CYgN4S4vkv/KPSneO+UvuS+R8+2LkqTPer2WPDz/yuh3zsntxQdf6dEyIhk949wZzWqoGUn2XqT0+Q0DdCkSz8N+27NxtwaLJCvkHZIgEV/2J5GMrJVXDEBFPwbUDsm8xrpBQ+65qVy3SJ56KIQCPLuShsh+CqzdXRh6SY3MM27amajWIuRZsVJL17kPNT2hiy9Ghev+oqNOuNoj1aH5AX+6YD1vSu7Q40miB3nnlU2kwCdMmsqwbQOURNP84xA+AaUdb+6VaxGsUTY5HmLY7EYqfdHuMBqr+MI6RKXRzInxYAPnyXGV1Bu6h7ivWFM2pS8QJwVK/Qj+18j8cN0/yau/1qz58vgaZtvJEQnctIRo4H91YT0qdhpC9Lkzp1yENMDJA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(376002)(136003)(39860400002)(396003)(451199021)(36840700001)(46966006)(40470700004)(40480700001)(7696005)(54906003)(70586007)(82740400003)(478600001)(81166007)(356005)(316002)(6916009)(47076005)(8676002)(8936002)(41300700001)(4326008)(70206006)(2616005)(186003)(426003)(336012)(36860700001)(16526019)(6666004)(83380400001)(1076003)(40460700003)(26005)(86362001)(44832011)(5660300002)(2906002)(82310400005)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2023 15:27:06.0643 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d1de965f-ce65-4807-0891-08db676ba6e2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT008.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6786
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

Rename mman.entity to mman.high_pr to make the distinction
clearer that this is a high priority scheduler. Similarly,
rename the recently added mman.delayed to mman.low_pr to
make it clear it is a low priority scheduler.
No functional change in this patch.

Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c  | 18 +++++++++---------
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h  |  8 ++++----
 drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c   |  2 +-
 drivers/gpu/drm/amd/amdkfd/kfd_migrate.c |  2 +-
 4 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index 8884c043cf76..8a55554ed69a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -228,7 +228,7 @@ static int amdgpu_ttm_map_buffer(struct ttm_buffer_object *bo,
 	num_dw = ALIGN(adev->mman.buffer_funcs->copy_num_dw, 8);
 	num_bytes = num_pages * 8 * AMDGPU_GPU_PAGES_IN_CPU_PAGE;
 
-	r = amdgpu_job_alloc_with_ib(adev, &adev->mman.entity,
+	r = amdgpu_job_alloc_with_ib(adev, &adev->mman.high_pr,
 				     AMDGPU_FENCE_OWNER_UNDEFINED,
 				     num_dw * 4 + num_bytes,
 				     AMDGPU_IB_POOL_DELAYED, &job);
@@ -1460,7 +1460,7 @@ static int amdgpu_ttm_access_memory_sdma(struct ttm_buffer_object *bo,
 		memcpy(adev->mman.sdma_access_ptr, buf, len);
 
 	num_dw = ALIGN(adev->mman.buffer_funcs->copy_num_dw, 8);
-	r = amdgpu_job_alloc_with_ib(adev, &adev->mman.entity,
+	r = amdgpu_job_alloc_with_ib(adev, &adev->mman.high_pr,
 				     AMDGPU_FENCE_OWNER_UNDEFINED,
 				     num_dw * 4, AMDGPU_IB_POOL_DELAYED,
 				     &job);
@@ -2036,7 +2036,7 @@ void amdgpu_ttm_set_buffer_funcs_status(struct amdgpu_device *adev, bool enable)
 
 		ring = adev->mman.buffer_funcs_ring;
 		sched = &ring->sched;
-		r = drm_sched_entity_init(&adev->mman.entity,
+		r = drm_sched_entity_init(&adev->mman.high_pr,
 					  DRM_SCHED_PRIORITY_KERNEL, &sched,
 					  1, NULL);
 		if (r) {
@@ -2045,7 +2045,7 @@ void amdgpu_ttm_set_buffer_funcs_status(struct amdgpu_device *adev, bool enable)
 			return;
 		}
 
-		r = drm_sched_entity_init(&adev->mman.delayed,
+		r = drm_sched_entity_init(&adev->mman.low_pr,
 					  DRM_SCHED_PRIORITY_NORMAL, &sched,
 					  1, NULL);
 		if (r) {
@@ -2054,8 +2054,8 @@ void amdgpu_ttm_set_buffer_funcs_status(struct amdgpu_device *adev, bool enable)
 			goto error_free_entity;
 		}
 	} else {
-		drm_sched_entity_destroy(&adev->mman.entity);
-		drm_sched_entity_destroy(&adev->mman.delayed);
+		drm_sched_entity_destroy(&adev->mman.high_pr);
+		drm_sched_entity_destroy(&adev->mman.low_pr);
 		dma_fence_put(man->move);
 		man->move = NULL;
 	}
@@ -2071,7 +2071,7 @@ void amdgpu_ttm_set_buffer_funcs_status(struct amdgpu_device *adev, bool enable)
 	return;
 
 error_free_entity:
-	drm_sched_entity_destroy(&adev->mman.entity);
+	drm_sched_entity_destroy(&adev->mman.high_pr);
 }
 
 static int amdgpu_ttm_prepare_job(struct amdgpu_device *adev,
@@ -2086,8 +2086,8 @@ static int amdgpu_ttm_prepare_job(struct amdgpu_device *adev,
 		AMDGPU_IB_POOL_DIRECT :
 		AMDGPU_IB_POOL_DELAYED;
 	int r;
-	struct drm_sched_entity *entity = delayed ? &adev->mman.delayed :
-						    &adev->mman.entity;
+	struct drm_sched_entity *entity = delayed ? &adev->mman.low_pr :
+						    &adev->mman.high_pr;
 	r = amdgpu_job_alloc_with_ib(adev, entity,
 				     AMDGPU_FENCE_OWNER_UNDEFINED,
 				     num_dw * 4, pool, job);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
index e82b1edee7a4..6d0d66e40db9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
@@ -59,10 +59,10 @@ struct amdgpu_mman {
 	bool					buffer_funcs_enabled;
 
 	struct mutex				gtt_window_lock;
-	/* Scheduler entity for buffer moves */
-	struct drm_sched_entity			entity;
-	/* Scheduler entity for VRAM clearing */
-	struct drm_sched_entity			delayed;
+	/* High priority scheduler entity for buffer moves */
+	struct drm_sched_entity			high_pr;
+	/* Low priority scheduler entity for VRAM clearing */
+	struct drm_sched_entity			low_pr;
 
 	struct amdgpu_vram_mgr vram_mgr;
 	struct amdgpu_gtt_mgr gtt_mgr;
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
index b2e42f1b0f12..0c8a47989576 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
@@ -382,7 +382,7 @@ static void gmc_v10_0_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
 	 * translation. Avoid this by doing the invalidation from the SDMA
 	 * itself.
 	 */
-	r = amdgpu_job_alloc_with_ib(ring->adev, &adev->mman.entity,
+	r = amdgpu_job_alloc_with_ib(ring->adev, &adev->mman.high_pr,
 				     AMDGPU_FENCE_OWNER_UNDEFINED,
 				     16 * 4, AMDGPU_IB_POOL_IMMEDIATE,
 				     &job);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
index 58d95fb99595..709ac885ca6d 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
@@ -64,7 +64,7 @@ svm_migrate_gart_map(struct amdgpu_ring *ring, uint64_t npages,
 	num_dw = ALIGN(adev->mman.buffer_funcs->copy_num_dw, 8);
 	num_bytes = npages * 8;
 
-	r = amdgpu_job_alloc_with_ib(adev, &adev->mman.entity,
+	r = amdgpu_job_alloc_with_ib(adev, &adev->mman.high_pr,
 				     AMDGPU_FENCE_OWNER_UNDEFINED,
 				     num_dw * 4 + num_bytes,
 				     AMDGPU_IB_POOL_DELAYED,
-- 
2.35.1

