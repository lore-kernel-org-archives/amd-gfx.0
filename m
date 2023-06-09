Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0F06C7EE2E
	for <amd-gfx@archiver.kernel.org>; Fri,  9 Jun 2023 15:05:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6619510E149;
	Fri,  9 Jun 2023 15:05:40 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2070.outbound.protection.outlook.com [40.107.94.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8182D10E149
 for <amd-gfx@lists.freedesktop.org>; Fri,  9 Jun 2023 15:05:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jZUBLS284+v778dKVGaCwazdMy5J1R0hgRvgfjcCYYZCU7wRTpUFV9MFOrGSbpUFyGDu588SnBZvqCHPD1JWpepWOdxXjQq03m7St/lywFQrL6jg/gAsQd1grrZxZZte+BNsN3bFIpl3POF7X5dimDTqyEYcgqK/FiETPiuVozfnBaTh8z/iwFce/QXflwIFqJB81xIbzUXlWdfsykj1PFRmGp4+bNJLnN4hQzS+vFamNmQV5BXq7HYpYzYkZvkwCksmshwkPrHLt63nfWti72B/OaKO7myOocK1UYlJ2dyd8gKX/BMe99bOgtAWQEe4jcac6MlnFClc3lNub+aFIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9/mNuLWsJFRb7Xuis7r5bgxmUMD5iJgrvqP8TLif6Ng=;
 b=ToqqdQb/89JFEwV/tM4poTcemRjOC0fYvSfvztYL1QPeR9573MwR/qsxbqFxl7U7GKBjaTfWc/yyRLOzHqY8OfvKKVgJiepzykqgKqkYMdc8x9UTnQh/nRnwXImbz6zQg4xCTs1bL7fxVf+RhnC9Ac6tAs97ULUEIPPWGpmcFqN23kN5hO/nuT1Io/lGdeEfFFFor2SREXFtLpkahQ5e4Plo0EfKHzAjltTWVaM0ctpIH9KGnm1jleRML3rGRqkOObkNhWZ4+zeKWDTqND4ArGWBaUUJ/eGN7d8kF3k7GqyH9HhJ3I0sdhI7FHjaTr1B6Dz18q2Y3MAWvdbcOJdQkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9/mNuLWsJFRb7Xuis7r5bgxmUMD5iJgrvqP8TLif6Ng=;
 b=mlNlRvQDpjddTuapJt99ZWIboYClemu3Z8mtoKJBnhHwsX3i6cKCTMJRK+jkb7Banl7lqSpEHeMhIamH9igAA7KPzeDZ/bH70hI6UIlwP3rbnvwlcS+8fcicMZuej6JbjfyBnxSMMXuShmHR/qrBgndsXGphBr+IigM/mpsO7KE=
Received: from MW4PR04CA0190.namprd04.prod.outlook.com (2603:10b6:303:86::15)
 by CY5PR12MB6249.namprd12.prod.outlook.com (2603:10b6:930:23::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.36; Fri, 9 Jun
 2023 15:05:35 +0000
Received: from CO1PEPF000044F9.namprd21.prod.outlook.com
 (2603:10b6:303:86:cafe::ff) by MW4PR04CA0190.outlook.office365.com
 (2603:10b6:303:86::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.27 via Frontend
 Transport; Fri, 9 Jun 2023 15:05:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044F9.mail.protection.outlook.com (10.167.241.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6521.0 via Frontend Transport; Fri, 9 Jun 2023 15:05:35 +0000
Received: from MUN-L-SHSHARMA.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 9 Jun
 2023 10:05:33 -0500
From: Shashank Sharma <shashank.sharma@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2] drm/amdgpu: flush GPU TLB using SDMA ring
Date: Fri, 9 Jun 2023 17:05:21 +0200
Message-ID: <20230609150521.951-1-shashank.sharma@amd.com>
X-Mailer: git-send-email 2.38.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F9:EE_|CY5PR12MB6249:EE_
X-MS-Office365-Filtering-Correlation-Id: 204e01be-9ccc-4bdd-fa44-08db68fafa72
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WvmQeFbLmtAv3sq+vZ5N1AJ9SbeJx2pgIcepfjnR6bd/xhgt+uxjcdPN1/jg1FhKu6tm2NcJU42US7VjNlF2XxB+MBjyakWr2gzABjUk2kER2p6fn9bXtOXO0+6D+oKEowMFaW+UQIKTbEAGvlg1L8DZLNtG8UjgP4LPFj+mnUT7Zhjnojqp0xdIUVWQgyrcgwBcu0DBxmQvel+7J7tHpmzOKlOXzCwoBNRoVrmTktP++DVdSotVe7ZqiItMGIhHvCS+wBpHo7llz1lB/80pZBHxzTjkM46r2FNikqw5Ypr2XkbP8XIghdTBZDg5MYwro+9eHzKzQf6WGMLCWnh8/8Iq8ZQKzXeBOI0XtCy503GN2FhURQvAQxbwyEJXaSKpKzZ4QeDKkGPGNGF57i162C+FxYXXyzztdKuV2F/loN6cdSozIY+2e3N2btULDsRH9kkPh2Dud4EPSXueDgLq/ddUH/d4mKa27XTKeQCQFGDdFOFLlb4PTuQ0s2H6LZM86aKW7zqi3l46kTdAWfPbzMRv6FNLdvSZ0rJV8OBWv0IF7i2vL/1RkUQ/m0ugUYDQZ92iuQVhhaWxNCDdDc75Df+DWIlcDCSUrby5pLTR6cpOO5CXv44w1EcXC1DajJEx1PxniLSDUsN786NFRGwC1+zUOgbN5AcccnFP2Hjssw1IuNOGO4tX7fpmR971VpctqRen6UNcXJ3UZpm4R/NGWe80qSSWmVM3biSR87vPaY2/ZnidKQAGiGQpivMSxylzD96K5zCmg8t7O9HEYLyjnQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(346002)(39860400002)(376002)(136003)(451199021)(36840700001)(40470700004)(46966006)(47076005)(83380400001)(82740400003)(336012)(426003)(40480700001)(478600001)(8936002)(8676002)(4326008)(86362001)(70206006)(70586007)(81166007)(356005)(6916009)(5660300002)(40460700003)(41300700001)(316002)(7696005)(6666004)(36756003)(82310400005)(36860700001)(2906002)(54906003)(44832011)(16526019)(186003)(1076003)(26005)(2616005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2023 15:05:35.4602 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 204e01be-9ccc-4bdd-fa44-08db68fafa72
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F9.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6249
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
Cc: Philip Yang <philip.yang@amd.com>,
 Shashank Sharma <shashank.sharma@amd.com>, felix.kuehling@amd.com,
 Amaranath.Somalapuram@amd.com, Rajneesh.Bhardwaj@amd.com,
 Christian Koenig <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This patch moves the code to flush GPU TLB using SDMA ring and
splits it into two parts:
- a general purpose function to flush GPU TLB using any valid GPU ring.
- a wrapper which consumes this function using SDMA ring.

The idea is that KFD/KGD code should be able to flush GPU TLB
using SDMA ring if they want to.

v2: Addressed review comments on RFC
    - Make the TLB flush function generic, and add a SDMA wrapper
      to it (Christian).

Cc: Christian Koenig <christian.koenig@amd.com>
Cc: Philip Yang <philip.yang@amd.com>
Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c | 22 +++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c  | 36 ++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h  |  1 +
 drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c   | 34 +++++-----------------
 5 files changed, 67 insertions(+), 27 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
index 231ca06bc9c7..05ffeb704dc4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
@@ -30,6 +30,28 @@
 /* SDMA CSA reside in the 3rd page of CSA */
 #define AMDGPU_CSA_SDMA_OFFSET (4096 * 2)
 
+/**
+ * amdgpu_sdma_flush_tlb - flush gpu TLB using SDMA ring
+ *
+ * @adev: amdgpu device pointer
+ *
+ * return: returns 0 on success.
+ */
+int amdgpu_sdma_flush_gpu_tlb(struct amdgpu_device *adev)
+{
+	struct dma_fence *fence;
+	struct amdgpu_ring *ring = adev->mman.buffer_funcs_ring;
+
+	fence = amdgpu_ttm_flush_tlb(ring);
+	if (fence) {
+		dma_fence_wait(fence, false);
+		dma_fence_put(fence);
+		return 0;
+	}
+
+	return -1;
+}
+
 /*
  * GPU SDMA IP block helpers function.
  */
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
index fc8528812598..739077862a7d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
@@ -130,5 +130,6 @@ void amdgpu_sdma_destroy_inst_ctx(struct amdgpu_device *adev,
         bool duplicate);
 void amdgpu_sdma_unset_buffer_funcs_helper(struct amdgpu_device *adev);
 int amdgpu_sdma_ras_sw_init(struct amdgpu_device *adev);
+int amdgpu_sdma_flush_gpu_tlb(struct amdgpu_device *adev);
 
 #endif
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index c5ef7f7bdc15..1248d1dd5abc 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -81,6 +81,42 @@ static int amdgpu_ttm_init_on_chip(struct amdgpu_device *adev,
 				  false, size_in_page);
 }
 
+/**
+ * amdgpu_ttm_flush_tlb - flush gpu TLB using a GPU ring
+ *
+ * @ring: ring to submit the flushing job to
+ *
+ * return: returns dma fence which must be put by caller
+ */
+struct dma_fence *amdgpu_ttm_flush_tlb(struct amdgpu_ring *ring)
+{
+	struct amdgpu_job *job;
+	struct dma_fence *fence;
+	struct amdgpu_device *adev = ring->adev;
+	int r;
+
+	mutex_lock(&adev->mman.gtt_window_lock);
+	r = amdgpu_job_alloc_with_ib(adev, &adev->mman.entity,
+				     AMDGPU_FENCE_OWNER_UNDEFINED,
+				     16 * 4, AMDGPU_IB_POOL_IMMEDIATE,
+				     &job);
+	if (r)
+		goto error_alloc;
+
+	job->vm_pd_addr = amdgpu_gmc_pd_addr(adev->gart.bo);
+	job->vm_needs_flush = true;
+	job->ibs->ptr[job->ibs->length_dw++] = ring->funcs->nop;
+	amdgpu_ring_pad_ib(ring, &job->ibs[0]);
+	fence = amdgpu_job_submit(job);
+
+	mutex_unlock(&adev->mman.gtt_window_lock);
+	return fence;
+
+error_alloc:
+	mutex_unlock(&adev->mman.gtt_window_lock);
+	return NULL;
+}
+
 /**
  * amdgpu_evict_flags - Compute placement flags
  *
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
index e2cd5894afc9..86ba70d2eb53 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
@@ -200,5 +200,6 @@ uint64_t amdgpu_ttm_tt_pte_flags(struct amdgpu_device *adev, struct ttm_tt *ttm,
 int amdgpu_ttm_evict_resources(struct amdgpu_device *adev, int mem_type);
 
 void amdgpu_ttm_debugfs_init(struct amdgpu_device *adev);
+struct dma_fence *amdgpu_ttm_flush_tlb(struct amdgpu_ring *ring);
 
 #endif
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
index ab2556ca984e..9892b155d1ef 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
@@ -52,6 +52,7 @@
 #include "athub_v2_1.h"
 
 #include "amdgpu_reset.h"
+#include "amdgpu_sdma.h"
 
 #if 0
 static const struct soc15_reg_golden golden_settings_navi10_hdp[] =
@@ -332,10 +333,6 @@ static void gmc_v10_0_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
 					uint32_t vmhub, uint32_t flush_type)
 {
 	struct amdgpu_ring *ring = adev->mman.buffer_funcs_ring;
-	struct dma_fence *fence;
-	struct amdgpu_job *job;
-
-	int r;
 
 	/* flush hdp cache */
 	adev->hdp.funcs->flush_hdp(adev, NULL);
@@ -378,34 +375,17 @@ static void gmc_v10_0_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
 		return;
 	}
 
-	/* The SDMA on Navi has a bug which can theoretically result in memory
+	mutex_unlock(&adev->mman.gtt_window_lock);
+
+	/*
+	 * The SDMA on Navi has a bug which can theoretically result in memory
 	 * corruption if an invalidation happens at the same time as an VA
 	 * translation. Avoid this by doing the invalidation from the SDMA
 	 * itself.
 	 */
-	r = amdgpu_job_alloc_with_ib(ring->adev, &adev->mman.entity,
-				     AMDGPU_FENCE_OWNER_UNDEFINED,
-				     16 * 4, AMDGPU_IB_POOL_IMMEDIATE,
-				     &job);
-	if (r)
-		goto error_alloc;
 
-	job->vm_pd_addr = amdgpu_gmc_pd_addr(adev->gart.bo);
-	job->vm_needs_flush = true;
-	job->ibs->ptr[job->ibs->length_dw++] = ring->funcs->nop;
-	amdgpu_ring_pad_ib(ring, &job->ibs[0]);
-	fence = amdgpu_job_submit(job);
-
-	mutex_unlock(&adev->mman.gtt_window_lock);
-
-	dma_fence_wait(fence, false);
-	dma_fence_put(fence);
-
-	return;
-
-error_alloc:
-	mutex_unlock(&adev->mman.gtt_window_lock);
-	DRM_ERROR("Error flushing GPU TLB using the SDMA (%d)!\n", r);
+	if (amdgpu_sdma_flush_gpu_tlb(adev))
+		DRM_ERROR("Error flushing GPU TLB using the SDMA !\n");
 }
 
 /**
-- 
2.40.1

