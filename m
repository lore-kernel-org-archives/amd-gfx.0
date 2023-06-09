Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A91CC7EE2E
	for <amd-gfx@archiver.kernel.org>; Fri,  9 Jun 2023 10:03:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 754A410E677;
	Fri,  9 Jun 2023 10:03:23 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on20619.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eaa::619])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 46EA210E677
 for <amd-gfx@lists.freedesktop.org>; Fri,  9 Jun 2023 10:03:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HwAbNsXeSQ1J2y1E59K+AaePBEaSa/dtoPEmKrDeaQGw1MPgjwq14zaCPjpyXaVVNYkwQhebGZSeLfh9LcEH8/JAQMLTS0bQb/9AIqCGx3Hz+hbV6kQ7cMW8yUStic8NHTQgf2WGoBpOZTytAr6GWbrMfJ5CAW+Sy4enVySWhEwRkhzjqJOCDZtJCP5GOotagyPEjbQnojm7EJlSrRp4Yg/V0gpXJMq3l5e8IDEUhwNUuehHGfdzHtd/prj2mxWnZc6coIh6Ef9jA8WNjgxQbotMwOaredHzgcwWtw9C8pihIKDSRFcohMPAJLHesLNYjU3BVnZVqekLPfvNy6KEKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EMOOYuQs/emE2LeH3vhCupLmDMiZJBIwszNGKkJeCzs=;
 b=TZGWxVWKcQ6nIlQqQRB3W0bpEEL+7qfV8leuXdK+F3DzOWDjb+rt1Jhjp1WhQ4KgbZfNkFTJVFYiVB1xCNqwbqxpx7KpKsTUtWb0Q4xIhG+qrUI7cQLoqAXCgf/k87e0MWnKhqYjvLAeQaPR0WV51KV6cDAOjYKfWNYCN/dZoQtDRJtEW7gF64gP/hpBBz+N7ggfZqG6KHK9J257KrvQLkkDOY+cC8txRGFJnbGY0SeUF6d795NfJG0+RAV+OPF2SnLk4I6iNi7GdUsloMocksp7RBaHXckldYj+muUuX2pRrYqfo0zScqq1Hz+lwVikRI7EPy3C4quYkHC0b9/51Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EMOOYuQs/emE2LeH3vhCupLmDMiZJBIwszNGKkJeCzs=;
 b=XwF+QuThtFkvvgI/m5pgLB+XRl5kkhsCT2OxRCPUHM6gTcSlcVdLO9ymkOABDOhLmYc2XrN++OXMEQv55dwFyonU6/Zyl8j7a7Xm9byk0Y0xHnFVmyRX3AYydUGt3lgJY38eL0cCdzrpAcHl4+6VR1NVf1z8+gpImRansCmcekU=
Received: from SA0PR11CA0125.namprd11.prod.outlook.com (2603:10b6:806:131::10)
 by DM4PR12MB7718.namprd12.prod.outlook.com (2603:10b6:8:102::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Fri, 9 Jun
 2023 10:03:19 +0000
Received: from SA2PEPF0000150B.namprd04.prod.outlook.com
 (2603:10b6:806:131:cafe::4b) by SA0PR11CA0125.outlook.office365.com
 (2603:10b6:806:131::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.27 via Frontend
 Transport; Fri, 9 Jun 2023 10:03:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF0000150B.mail.protection.outlook.com (10.167.242.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6477.13 via Frontend Transport; Fri, 9 Jun 2023 10:03:19 +0000
Received: from MUN-L-SHSHARMA.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 9 Jun
 2023 05:03:17 -0500
From: Shashank Sharma <shashank.sharma@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [RFC] drm/amdgpu: flush gpu tlb using sdma ring
Date: Fri, 9 Jun 2023 12:02:57 +0200
Message-ID: <20230609100257.900-1-shashank.sharma@amd.com>
X-Mailer: git-send-email 2.38.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF0000150B:EE_|DM4PR12MB7718:EE_
X-MS-Office365-Filtering-Correlation-Id: 5abfcadb-7905-4209-bb81-08db68d0c071
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4n62aS7xuK0RWGa38uZwszVfb/8Ty+Pw3ihLIuAjRqvsBwYRQ5y560zwyCowH2nOCpi/o3I9tPPqHGZtJUgtNvw2MQCS0ZN6CccxARETxA0tKAk3xF3KmsjNvUnmZ+ZJOI5lK3K0F0JILeWlGSHcHz0JXJ1JFXig/4JmsQeZEMbYTqo0mcRWpW8zXX3i5eLDty3Ora00f5TFS76BFNqpcGiJ2cVPAjFYXcaxVtQbvUWNlSO3zF5sRd1jcT64JNCzuTXqLD2njP23ZfA/knLYyEus5mxMc51l/Eq4waIEJX4uwJJX/IqjDJAt9lZ81vDTLTmshf1uL/cq8CH2ydsaE2G9Wn0HeiA+rz9WTuuNxsXlt5rwppkDMbnRPMVoU5Z0W3ei08ezdhwv8/ij/uGp5MYnvitS3mYEQoOv79DqkWcRUhtJMVwdA6UM0PATZ56Q0wSf5NZV+n2yKYjNfhernmPL/WZZe48URZ6GzohLhox3xVqO+ho7QOPP4NwT4JrOu//lNzZPLiTVhJO3J/1yhTzLfKCozp1OepkhUIbIPWouKX8y7I/HhHKyllZz8wm+/ke/ZdY8uNZHM2nAfTQhD2l0TqBq/5RrL/81RSCHvTLV9D0nNFw09D1jztsFlG31QXMAwJFvoLcEUFE8Z0mMnyBPNKyvTeXcByGLljuMKjiyZIbJapCLP4/gF8J3VV8XZlpd0luxt0qJORNX5jwjeAYEvEkvFmEOCb1NRIRLz3bVcMr2rPc6HWULlugKzsQfrYbwqninS/qkGB9qzvJpug==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(376002)(39860400002)(346002)(136003)(451199021)(46966006)(36840700001)(40470700004)(41300700001)(47076005)(86362001)(83380400001)(336012)(426003)(82740400003)(40480700001)(44832011)(478600001)(36756003)(316002)(8676002)(40460700003)(8936002)(356005)(4326008)(70586007)(81166007)(54906003)(70206006)(6916009)(5660300002)(7696005)(6666004)(82310400005)(2906002)(36860700001)(26005)(2616005)(186003)(1076003)(16526019)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2023 10:03:19.3597 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5abfcadb-7905-4209-bb81-08db68d0c071
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF0000150B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7718
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
Cc: felix.kuehling@amd.com, Amaranath.Somalapuram@amd.com,
 Christian Koenig <christian.koenig@amd.com>,
 Shashank Sharma <shashank.sharma@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This RFC patch moves the code to flush TLB using SDMA ring to
a different place like a separate function. The idea is that
KFD/KGD code should be able to flush GPU TLB using SDMA if they
want to.

Cc: Christian Koenig <christian.koenig@amd.com>
Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c | 41 ++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h |  1 +
 drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c   | 36 +++++----------------
 3 files changed, 50 insertions(+), 28 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
index 231ca06bc9c7..20a5dad32bfc 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
@@ -30,6 +30,47 @@
 /* SDMA CSA reside in the 3rd page of CSA */
 #define AMDGPU_CSA_SDMA_OFFSET (4096 * 2)
 
+/**
+ * amdgpu_sdma_flush_tlb - flush gpu TLB using SDMA ring
+ *
+ * @adev: amdgpu device pointer
+ *
+ * return: returns dma fence which must be put by caller
+ *
+ * The SDMA on Navi has a bug which can theoretically result in memory
+ * corruption if an invalidation happens at the same time as an VA
+ * translation. Avoid this by doing the invalidation from the SDMA
+ * itself.
+ */
+struct dma_fence *amdgpu_sdma_flush_tlb(struct amdgpu_device *adev)
+{
+	int r;
+	struct dma_fence *fence;
+	struct amdgpu_job *job;
+	struct amdgpu_ring *ring = adev->mman.buffer_funcs_ring;
+
+	mutex_lock(&adev->mman.gtt_window_lock);
+	r = amdgpu_job_alloc_with_ib(ring->adev, &adev->mman.entity,
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
 /*
  * GPU SDMA IP block helpers function.
  */
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
index fc8528812598..c895948f6e82 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
@@ -130,5 +130,6 @@ void amdgpu_sdma_destroy_inst_ctx(struct amdgpu_device *adev,
         bool duplicate);
 void amdgpu_sdma_unset_buffer_funcs_helper(struct amdgpu_device *adev);
 int amdgpu_sdma_ras_sw_init(struct amdgpu_device *adev);
+struct dma_fence *amdgpu_sdma_flush_tlb(struct amdgpu_device *adev);
 
 #endif
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
index ab2556ca984e..0bfaee00a838 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
@@ -52,6 +52,7 @@
 #include "athub_v2_1.h"
 
 #include "amdgpu_reset.h"
+#include "amdgpu_sdma.h"
 
 #if 0
 static const struct soc15_reg_golden golden_settings_navi10_hdp[] =
@@ -333,9 +334,6 @@ static void gmc_v10_0_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
 {
 	struct amdgpu_ring *ring = adev->mman.buffer_funcs_ring;
 	struct dma_fence *fence;
-	struct amdgpu_job *job;
-
-	int r;
 
 	/* flush hdp cache */
 	adev->hdp.funcs->flush_hdp(adev, NULL);
@@ -378,34 +376,16 @@ static void gmc_v10_0_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
 		return;
 	}
 
-	/* The SDMA on Navi has a bug which can theoretically result in memory
-	 * corruption if an invalidation happens at the same time as an VA
-	 * translation. Avoid this by doing the invalidation from the SDMA
-	 * itself.
-	 */
-	r = amdgpu_job_alloc_with_ib(ring->adev, &adev->mman.entity,
-				     AMDGPU_FENCE_OWNER_UNDEFINED,
-				     16 * 4, AMDGPU_IB_POOL_IMMEDIATE,
-				     &job);
-	if (r)
-		goto error_alloc;
-
-	job->vm_pd_addr = amdgpu_gmc_pd_addr(adev->gart.bo);
-	job->vm_needs_flush = true;
-	job->ibs->ptr[job->ibs->length_dw++] = ring->funcs->nop;
-	amdgpu_ring_pad_ib(ring, &job->ibs[0]);
-	fence = amdgpu_job_submit(job);
-
 	mutex_unlock(&adev->mman.gtt_window_lock);
 
-	dma_fence_wait(fence, false);
-	dma_fence_put(fence);
-
-	return;
+	fence = amdgpu_sdma_flush_tlb(adev);
+	if (fence) {
+		dma_fence_wait(fence, false);
+		dma_fence_put(fence);
+		return;
+	}
 
-error_alloc:
-	mutex_unlock(&adev->mman.gtt_window_lock);
-	DRM_ERROR("Error flushing GPU TLB using the SDMA (%d)!\n", r);
+	DRM_ERROR("Error flushing GPU TLB using the SDMA !\n");
 }
 
 /**
-- 
2.40.1

