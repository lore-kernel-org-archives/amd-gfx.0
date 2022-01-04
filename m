Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FD38C433EF
	for <amd-gfx@archiver.kernel.org>; Tue,  4 Jan 2022 19:12:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 14BFF10E236;
	Tue,  4 Jan 2022 19:12:30 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2079.outbound.protection.outlook.com [40.107.223.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D85FB10E239
 for <amd-gfx@lists.freedesktop.org>; Tue,  4 Jan 2022 19:12:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RtRHWaA34Df7txSqzSevlsPBzVY205bZ0ymcRIoPuZ7+F6mHS+MQajEIPlVKSj047Et58eQU7UjJw8gqBSqQIgykAR9Kz8e9FcQK7a0fe6rTzqS1EZRhF7tIiFEIl4TtltcXvlJX+uH7Vfs3NPRbO6rAYIhAFj/MkGJNF7FY2x3aI1LqQCWUgnzJ7hlx37MEj2PF0X2ive0KJQcG8HjNuUtS8i44BrI0Oqb0cpAfm4X3Om1vdY88ifviDihZC09Y+i6hOKTiqFbERBBxxAq9ZEnG1MbsfM9SFaSKmgL7g5TG+jbnhT4hmoYm1G2GylW1/NtxAZQ8mc95jMD2VUowRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H8ttVmdSYr4ptGIQtxEoA65d5DgUwyVMskKdgxmXaOo=;
 b=M5QyVcmAi9GLTbJGVZD0zxmOLaOLeGFRaEgTau9QM1T0ickA/dGxku5SoDcdgq1YHMx/b4Y+DFaTFIjbjpENz7JrplZD7ZpP5TJdnLnPVF8XUtRsCfAje40YO6noL33nY96KCjEKhLtBtXO4VNvTf4q/WF+C2dcGOoFut7x72I8MXl3VXCZ+st925djmryogCT2eQX4PLlRr+O6tufqy0PEb4E9N5FC7q5euC4WVO9qh50aCORgyw1vDN0WQyCtuhjDA2JZ2le+p1E/AQ2vQxOzu+Idp0oouTznKInNszKyP+PjSQ60oo3Aa25mFXLo+j2KXl9W4I7H5l1b/wBGXhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H8ttVmdSYr4ptGIQtxEoA65d5DgUwyVMskKdgxmXaOo=;
 b=Q6ckWsjW6YySvzF4f9iN1MMbs/gpa/HNCE41VJc/xatbjS+IQrTsG8K2ekTUMT4wDNXGdXf0fjou9wNV6KgzKLg8pH67oLulQzq/TitoKLD34k/tNQezYjxmvqREhFrMbAKJURbF9XsPmTcTCAmE9NxX/yTrWUF0taymHRpNPMI=
Received: from BN6PR2001CA0026.namprd20.prod.outlook.com
 (2603:10b6:405:16::12) by SA0PR12MB4414.namprd12.prod.outlook.com
 (2603:10b6:806:9a::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4844.15; Tue, 4 Jan
 2022 19:12:26 +0000
Received: from BN8NAM11FT051.eop-nam11.prod.protection.outlook.com
 (2603:10b6:405:16:cafe::7a) by BN6PR2001CA0026.outlook.office365.com
 (2603:10b6:405:16::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4844.15 via Frontend
 Transport; Tue, 4 Jan 2022 19:12:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT051.mail.protection.outlook.com (10.13.177.66) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4844.14 via Frontend Transport; Tue, 4 Jan 2022 19:12:26 +0000
Received: from jonathan-KFD.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Tue, 4 Jan
 2022 13:12:21 -0600
From: Jonathan Kim <jonathan.kim@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: improve debug VRAM access performance using sdma
Date: Tue, 4 Jan 2022 14:12:11 -0500
Message-ID: <20220104191211.1707514-1-jonathan.kim@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f6480fde-9edc-4412-930d-08d9cfb6253b
X-MS-TrafficTypeDiagnostic: SA0PR12MB4414:EE_
X-Microsoft-Antispam-PRVS: <SA0PR12MB4414403815C1365A0665E87C854A9@SA0PR12MB4414.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: utbzRJqTyrOtOi09sKcbX1pNJ5pNbJUbWKbq4zMrYAEzRN/66SykjJeuIVOm8mzB62AHzVE2jNjSEHq8nW8ilPt78u3aY8r2THVDlstX14RT/sxcdGfylbt7wYA01y/LvWaIK3hym5JXPwz9X553avbdvPiPmAmd5s72c59IH0A/5aP5ZZRv4jx/SsNPp9TuKwn2cli4R4iyaXHlK9TfoQIoXEhwCYVkN+PWYN3USzLuJ/OnQzPL/O/8LCPXLpJ8AIt5mBLXRgquC/JPPSNEz2sMVw6q85kxUQSX31C4KPYoTjQGP89ES+Wp2CzeuKP15Kh4r/NIjwxRKjwQyz6lILmgr3waVA/a+Hl2LKO/mHMWAzjQZ3bL1m5WB17MVyRzsrZLkdRwe+M29Ik8I7uK2o1QEyZmS+VVVkegQ8ib90TlsvCBIhJ7WBuCgL5JmoGccQM8H3FPqjLlI3BjZPtJENT6F6xmAAsZD1njFP/A0qYKeN+H4d5dqz4rR2wA1di0tz8b6narFvFVH1RvCY8CWOc5h9FDwfKlYN76s+/fx6d9DkoTuASvfTtLe85thNvnVBp1z9NmSO7MdHLiGckwUO3nxNdDQHNPK10kguROwHkmBexF1XcIcp9PB/llUGVEJSDNkhU487h+6gsp5FwhdSJhrTIfyTGnMejIVD09jZh8/UsswZ7MaQjtk4GCvWSLxaVJVxMPnDWZpSw4JmljZQvKfMM4xzKFiJhw89SG7hU639Z3eskAQcO8tkZMaAPa6Mb3lot+Mh76dEY9AuL0UkR9iBX+Yx4+8xPYH4YOQr0=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(40470700002)(46966006)(36840700001)(2906002)(40460700001)(1076003)(4326008)(47076005)(2616005)(426003)(86362001)(26005)(16526019)(5660300002)(70206006)(186003)(336012)(36756003)(8936002)(316002)(6916009)(81166007)(508600001)(36860700001)(82310400004)(44832011)(6666004)(356005)(7696005)(54906003)(83380400001)(8676002)(70586007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2022 19:12:26.4825 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f6480fde-9edc-4412-930d-08d9cfb6253b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT051.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4414
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
Cc: Felix.Kuehling@amd.com, Jonathan Kim <jonathan.kim@amd.com>,
 Christian.Koenig@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

For better performance during VRAM access for debugged processes, do
read/write copies over SDMA.

In order to fulfill post mortem debugging on a broken device, fallback to
stable MMIO access when gpu recovery is disabled or when job submission
time outs are set to max.  Failed SDMA access should automatically fall
back to MMIO access.

Use a pre-allocated GTT bounce buffer pre-mapped into GART to avoid
page-table updates and TLB flushes on access.

Signed-off-by: Jonathan Kim <jonathan.kim@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 78 +++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h |  5 +-
 2 files changed, 82 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index 367abed1d6e6..512df4c09772 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -48,6 +48,7 @@
 #include <drm/ttm/ttm_range_manager.h>
 
 #include <drm/amdgpu_drm.h>
+#include <drm/drm_drv.h>
 
 #include "amdgpu.h"
 #include "amdgpu_object.h"
@@ -1429,6 +1430,70 @@ static void amdgpu_ttm_vram_mm_access(struct amdgpu_device *adev, loff_t pos,
 	}
 }
 
+static int amdgpu_ttm_access_memory_sdma(struct ttm_buffer_object *bo,
+					unsigned long offset, void *buf, int len, int write)
+{
+	struct amdgpu_bo *abo = ttm_to_amdgpu_bo(bo);
+	struct amdgpu_device *adev = amdgpu_ttm_adev(abo->tbo.bdev);
+	struct amdgpu_job *job;
+	struct dma_fence *fence;
+	uint64_t src_addr, dst_addr;
+	unsigned int num_dw;
+	int r, idx;
+
+	if (len != PAGE_SIZE)
+		return -EINVAL;
+
+	if (!adev->mman.sdma_access_ptr)
+		return -EACCES;
+
+	r = drm_dev_enter(adev_to_drm(adev), &idx);
+	if (r)
+		return r;
+
+	if (write)
+		memcpy(adev->mman.sdma_access_ptr, buf, len);
+
+	num_dw = ALIGN(adev->mman.buffer_funcs->copy_num_dw, 8);
+	r = amdgpu_job_alloc_with_ib(adev, num_dw * 4, AMDGPU_IB_POOL_DELAYED, &job);
+	if (r)
+		goto out;
+
+	src_addr = write ? amdgpu_bo_gpu_offset(adev->mman.sdma_access_bo) :
+			amdgpu_bo_gpu_offset(abo);
+	dst_addr = write ? amdgpu_bo_gpu_offset(abo) :
+			amdgpu_bo_gpu_offset(adev->mman.sdma_access_bo);
+	amdgpu_emit_copy_buffer(adev, &job->ibs[0], src_addr, dst_addr, PAGE_SIZE, false);
+
+	amdgpu_ring_pad_ib(adev->mman.buffer_funcs_ring, &job->ibs[0]);
+	WARN_ON(job->ibs[0].length_dw > num_dw);
+
+	r = amdgpu_job_submit(job, &adev->mman.entity, AMDGPU_FENCE_OWNER_UNDEFINED, &fence);
+	if (r) {
+		amdgpu_job_free(job);
+		goto out;
+	}
+
+	if (!dma_fence_wait_timeout(fence, false, adev->sdma_timeout))
+		r = -ETIMEDOUT;
+	dma_fence_put(fence);
+
+	if (!(r || write))
+		memcpy(buf, adev->mman.sdma_access_ptr, len);
+out:
+	drm_dev_exit(idx);
+	return r;
+}
+
+static inline bool amdgpu_ttm_allow_post_mortem_debug(struct amdgpu_device *adev)
+{
+	return amdgpu_gpu_recovery == 0 ||
+		adev->gfx_timeout == MAX_SCHEDULE_TIMEOUT ||
+		adev->compute_timeout == MAX_SCHEDULE_TIMEOUT ||
+		adev->sdma_timeout == MAX_SCHEDULE_TIMEOUT ||
+		adev->video_timeout == MAX_SCHEDULE_TIMEOUT;
+}
+
 /**
  * amdgpu_ttm_access_memory - Read or Write memory that backs a buffer object.
  *
@@ -1453,6 +1518,10 @@ static int amdgpu_ttm_access_memory(struct ttm_buffer_object *bo,
 	if (bo->resource->mem_type != TTM_PL_VRAM)
 		return -EIO;
 
+	if (!amdgpu_ttm_allow_post_mortem_debug(adev) &&
+			!amdgpu_ttm_access_memory_sdma(bo, offset, buf, len, write))
+		return len;
+
 	amdgpu_res_first(bo->resource, offset, len, &cursor);
 	while (cursor.remaining) {
 		size_t count, size = cursor.size;
@@ -1793,6 +1862,12 @@ int amdgpu_ttm_init(struct amdgpu_device *adev)
 		return r;
 	}
 
+	if (amdgpu_bo_create_kernel(adev, PAGE_SIZE, PAGE_SIZE,
+				AMDGPU_GEM_DOMAIN_GTT,
+				&adev->mman.sdma_access_bo, NULL,
+				adev->mman.sdma_access_ptr))
+		DRM_WARN("Debug VRAM access will use slowpath MM access\n");
+
 	return 0;
 }
 
@@ -1823,6 +1898,9 @@ void amdgpu_ttm_fini(struct amdgpu_device *adev)
 	ttm_range_man_fini(&adev->mman.bdev, AMDGPU_PL_OA);
 	ttm_device_fini(&adev->mman.bdev);
 	adev->mman.initialized = false;
+	if (adev->mman.sdma_access_ptr)
+		amdgpu_bo_free_kernel(&adev->mman.sdma_access_bo, NULL,
+					&adev->mman.sdma_access_ptr);
 	DRM_INFO("amdgpu: ttm finalized\n");
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
index 91a087f9dc7c..b0116c4a768f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
@@ -98,6 +98,10 @@ struct amdgpu_mman {
 	u64		fw_vram_usage_size;
 	struct amdgpu_bo	*fw_vram_usage_reserved_bo;
 	void		*fw_vram_usage_va;
+
+	/* PAGE_SIZE'd BO for process memory r/w over SDMA. */
+	struct amdgpu_bo	*sdma_access_bo;
+	void			*sdma_access_ptr;
 };
 
 struct amdgpu_copy_mem {
@@ -193,5 +197,4 @@ uint64_t amdgpu_ttm_tt_pte_flags(struct amdgpu_device *adev, struct ttm_tt *ttm,
 int amdgpu_ttm_evict_resources(struct amdgpu_device *adev, int mem_type);
 
 void amdgpu_ttm_debugfs_init(struct amdgpu_device *adev);
-
 #endif
-- 
2.25.1

