Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6C8EC77B75
	for <amd-gfx@archiver.kernel.org>; Wed, 17 May 2023 18:41:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3DF0110E241;
	Wed, 17 May 2023 18:41:15 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2043.outbound.protection.outlook.com [40.107.237.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C709210E241
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 May 2023 18:41:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lsdwHIYKRm+8SqD2Srt5hIVfi2IgxM1yBAiD5c9bL3x64Q5GBL9kFl+RgC3thbyVWvbILQabyg7azrmFEK/ILFPsYhj5u2wlKXA1+6gtcAXU8Cn3HiB0bhs6wKdLO8dyosC06v707XvsXnTCSZ8vIGtj090Mc9Ygep6OnU7xj0wctYtpu5IkNgAvsz9kmq005l6ExFcC5rvTDhRoIsI9eFeLOAoJ5Clu4YcySfrbAYzVyiAMKhS5Nim5xdbppga7YTjAbNp92zTvFeF+coPC6Vx+YBaFPBTADJU8jU/mpxyW8Z5g8X2wvREBZfs2OxpByVbcUABq5zeNnmY8R9629w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=71un2fLt9DqU7IRh0FG27hl1moNO39DIPFmPbyQvBvU=;
 b=aVBm3Nv9I3/j76IYzBapkCA25olKaGRZgQYq+Kaeomww4TSy0K3D+HcH0HfpPycOGJ+oXSoWIKESiYq5kdiPLvuIXQX3EYs6gWI+5baz88V6H1AcScQJbTOMh0pvpOZBgaxptPcit1K2wIXdWwOJcqAfM4NRKCtf5+3PZCidXPW7PHl99GdmXaC5I/0Rj66tmgUT4rblUKTh9rngOwLPn3+hTPM+eNBpKT1TE0cUyhpesk0T451gwexOHyidAvpcmfh90bh+I54/kunBxZModGRsAx+oMZ3XMuACkbL4pA4HaMCtV0V8OWc+aqtbBHXHCwYaK2heA2vLjY85a83cXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=71un2fLt9DqU7IRh0FG27hl1moNO39DIPFmPbyQvBvU=;
 b=aa2+pMynNymh1kBdr7ThsfC2EtjAcydRcNFhG8059GlxBXRYoXbLXtYvhPDo1hLoQXPZRWF+zK2wDRurbTqsYq1oxd5gPaEOi88vAD6aN5b7D8p3yNYmNtrMU0FU2bbgwtIKHlPwtE97rkd1B5Wqo/KHWuOTvaMfjVipmF+zxIo=
Received: from MW4PR04CA0083.namprd04.prod.outlook.com (2603:10b6:303:6b::28)
 by SJ1PR12MB6315.namprd12.prod.outlook.com (2603:10b6:a03:456::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.30; Wed, 17 May
 2023 18:41:09 +0000
Received: from CO1NAM11FT079.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:6b:cafe::c6) by MW4PR04CA0083.outlook.office365.com
 (2603:10b6:303:6b::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.17 via Frontend
 Transport; Wed, 17 May 2023 18:41:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT079.mail.protection.outlook.com (10.13.175.134) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6411.15 via Frontend Transport; Wed, 17 May 2023 18:41:09 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 17 May
 2023 13:41:07 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu/gmc9: fix 64 bit division in partition code
Date: Wed, 17 May 2023 14:40:52 -0400
Message-ID: <20230517184052.165772-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT079:EE_|SJ1PR12MB6315:EE_
X-MS-Office365-Filtering-Correlation-Id: cb520dca-eec9-4b33-96cf-08db5706480a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6moAWVhGIEitfxH89QXGCkNVRvVNMHFjSri9kZOb5whFhzLWO1k8nbicuGgI6vbYPk7BLTYmswKnpYr5RcGMA3TDxKSuUStrS4NBuy8UHuBuPRPqzq5wk27ZTvfIhQ8UYqc9E/quRVdpCsDkT9nQpxZkgSXqHEl72pCt2u937FXI2XazTsy3J1gr024iK6JvgRCJ11wzlkLYSrzq/+MnppYac/oakkvEFursMkzmg4vHccaznLp9+EbU7JgVa6GtV5mfj7yDzC3XbHp38Pj+8dKU7VDigX720OMMKtUM40fzbP6HoXMZ1kS3wiTftNH+QAUh0gR2FkW+ZDnMVjskvM5gFJnAR66DBUMHXKsxT27IhYdLG+1Zli/YGNuAAzrvSVw+IOtuNV4oPmT840sFIsvmZET1i7V7hX8ykjp7Z1Ge8Td71KRa19RzLaZvAsGpwfdNZOS3nDojx3+ZbUMdGUH7Hf4aPdT/LDrennK+JdsTNsqJG02KrpNah4WPPPS76G1A3ekCT25EvoTk5BiwN0MFKH46jOXrFG5jWZrv1oRPp3qB2XZ2WM8ebf2c8Tfg9u6jFkqqZGrwoa3+LvNxjh7fkDnlWS0R41SH8hSl2b8aInW5NoTboE9wm5fsn2UZFCoYiaagik3Eh7EcZSq49le2DOrhvUpS0KTv1047wK6qa77KcDMJLPxUpsrZVzNz3pAkEmkId/Wb/4xEBzT/Afgo6Kp4xEYza7hnnD9PjBgxfCF/OPStGt9KvYCFvMDtqGMx92Ry/RQ1nFbRGr3tlA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(39860400002)(136003)(376002)(346002)(451199021)(36840700001)(40470700004)(46966006)(186003)(1076003)(26005)(83380400001)(16526019)(8676002)(8936002)(426003)(336012)(40480700001)(2616005)(47076005)(2906002)(82740400003)(36860700001)(40460700003)(356005)(6666004)(70586007)(7696005)(70206006)(316002)(6916009)(4326008)(54906003)(478600001)(36756003)(41300700001)(5660300002)(82310400005)(86362001)(81166007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2023 18:41:09.1568 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cb520dca-eec9-4b33-96cf-08db5706480a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT079.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6315
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Mukul Joshi <mukul.joshi@amd.com>,
 Guchun Chen <guchun.chen@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Rework logic or use do_div() to avoid problems on 32 bit.

v2: add a missing case for XCP macro
v3: fix out of bounds array access
v4: fix xcp handling harder

Acked-by: Guchun Chen <guchun.chen@amd.com> (v1)
Reviewed-by: Mukul Joshi <mukul.joshi@amd.com> (v3)
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c | 15 +++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h |  9 ++++-----
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c    |  5 ++++-
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c      | 11 ++++++-----
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c       |  8 ++++++--
 5 files changed, 35 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
index 739eb7c0d133..5de92c9ab18f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
@@ -794,3 +794,18 @@ void amdgpu_amdkfd_unlock_kfd(struct amdgpu_device *adev)
 {
 	kgd2kfd_unlock_kfd();
 }
+
+
+u64 amdgpu_amdkfd_xcp_memory_size(struct amdgpu_device *adev, int xcp_id)
+{
+	u64 tmp;
+	s8 mem_id = KFD_XCP_MEM_ID(adev, xcp_id);
+
+	if (adev->gmc.num_mem_partitions && xcp_id >= 0 && mem_id >= 0) {
+		tmp = adev->gmc.mem_partitions[mem_id].size;
+		do_div(tmp, adev->xcp_mgr->num_xcp_per_mem_partition);
+		return tmp;
+	} else {
+		return adev->gmc.real_vram_size;
+	}
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
index be43d71ba7ef..94cc456761e5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
@@ -333,15 +333,14 @@ int amdgpu_amdkfd_reserve_mem_limit(struct amdgpu_device *adev,
 void amdgpu_amdkfd_unreserve_mem_limit(struct amdgpu_device *adev,
 		uint64_t size, u32 alloc_flag, int8_t xcp_id);
 
+u64 amdgpu_amdkfd_xcp_memory_size(struct amdgpu_device *adev, int xcp_id);
+
 #define KFD_XCP_MEM_ID(adev, xcp_id) \
 		((adev)->xcp_mgr && (xcp_id) >= 0 ?\
 		(adev)->xcp_mgr->xcp[(xcp_id)].mem_id : -1)
 
-#define KFD_XCP_MEMORY_SIZE(adev, xcp_id)\
-		((adev)->gmc.num_mem_partitions && (xcp_id) >= 0 ?\
-		(adev)->gmc.mem_partitions[KFD_XCP_MEM_ID((adev), (xcp_id))].size /\
-		(adev)->xcp_mgr->num_xcp_per_mem_partition :\
-		(adev)->gmc.real_vram_size)
+#define KFD_XCP_MEMORY_SIZE(adev, xcp_id) amdgpu_amdkfd_xcp_memory_size((adev), (xcp_id))
+
 
 #if IS_ENABLED(CONFIG_HSA_AMD)
 void amdgpu_amdkfd_gpuvm_init_mem_limits(void);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index ad664ef640ff..34724b771ace 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -818,11 +818,14 @@ static void amdgpu_ttm_gart_bind_gfx9_mqd(struct amdgpu_device *adev,
 	struct amdgpu_ttm_tt *gtt = (void *)ttm;
 	uint64_t total_pages = ttm->num_pages;
 	int num_xcc = max(1U, adev->gfx.num_xcc_per_xcp);
-	uint64_t page_idx, pages_per_xcc = total_pages / num_xcc;
+	uint64_t page_idx, pages_per_xcc;
 	int i;
 	uint64_t ctrl_flags = (flags & ~AMDGPU_PTE_MTYPE_VG10_MASK) |
 			AMDGPU_PTE_MTYPE_VG10(AMDGPU_MTYPE_NC);
 
+	pages_per_xcc = total_pages;
+	do_div(pages_per_xcc, num_xcc);
+
 	for (i = 0, page_idx = 0; i < num_xcc; i++, page_idx += pages_per_xcc) {
 		/* MQD page: use default flags */
 		amdgpu_gart_bind(adev,
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index 938c8dba9057..d559e7bc0f09 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -1919,9 +1919,10 @@ gmc_v9_0_init_acpi_mem_ranges(struct amdgpu_device *adev,
 	adev->gmc.num_mem_partitions = num_ranges;
 
 	/* If there is only partition, don't use entire size */
-	if (adev->gmc.num_mem_partitions == 1)
-		mem_ranges[0].size =
-			(mem_ranges[0].size * (mem_groups - 1) / mem_groups);
+	if (adev->gmc.num_mem_partitions == 1) {
+		mem_ranges[0].size = mem_ranges[0].size * (mem_groups - 1);
+		do_div(mem_ranges[0].size, mem_groups);
+	}
 }
 
 static void
@@ -1953,8 +1954,8 @@ gmc_v9_0_init_sw_mem_ranges(struct amdgpu_device *adev,
 		break;
 	}
 
-	size = (adev->gmc.real_vram_size >> AMDGPU_GPU_PAGE_SHIFT) /
-	       adev->gmc.num_mem_partitions;
+	size = adev->gmc.real_vram_size >> AMDGPU_GPU_PAGE_SHIFT;
+	size /= adev->gmc.num_mem_partitions;
 
 	for (i = 0; i < adev->gmc.num_mem_partitions; ++i) {
 		mem_ranges[i].range.fpfn = start_addr;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index 41dacc015983..9ae5ebf47eb5 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -1938,10 +1938,14 @@ void svm_range_set_max_pages(struct amdgpu_device *adev)
 	uint64_t max_pages;
 	uint64_t pages, _pages;
 	uint64_t min_pages = 0;
-	int i;
+	int i, id;
 
 	for (i = 0; i < adev->kfd.dev->num_nodes; i++) {
-		pages = KFD_XCP_MEMORY_SIZE(adev, adev->kfd.dev->nodes[i]->xcp->id) >> 17;
+		if (adev->kfd.dev->nodes[i]->xcp)
+			id = adev->kfd.dev->nodes[i]->xcp->id;
+		else
+			id = -1;
+		pages = KFD_XCP_MEMORY_SIZE(adev, id) >> 17;
 		pages = clamp(pages, 1ULL << 9, 1ULL << 18);
 		pages = rounddown_pow_of_two(pages);
 		min_pages = min_not_zero(min_pages, pages);
-- 
2.40.1

