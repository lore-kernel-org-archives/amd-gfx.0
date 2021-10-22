Return-Path: <SRS0=y7aQ=PK=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A518EC433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 22 Oct 2021 10:54:46 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6400A6108D
	for <amd-gfx@archiver.kernel.org>; Fri, 22 Oct 2021 10:54:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 6400A6108D
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DA2346ED0E;
	Fri, 22 Oct 2021 10:54:45 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2045.outbound.protection.outlook.com [40.107.237.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 102946ED0D
 for <amd-gfx@lists.freedesktop.org>; Fri, 22 Oct 2021 10:54:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GNBoOT5VrziCjptSV69gihxzh94Eyxw1JVfB21G8P4GfYa7T++Idom08MfLlqO1qWeaRZf2HdnNlSTXR+IQQ6q7xEudhllTecF60g/RI73yVSkB4dAk76o6jFIFs1cPVGT8N4dKkGxKH8pFeBs23sJ+JDIZBMdKXTljb/S+MBo0DLpAO+LF7/AyaNJ808PioLfH7yeyNmrkzh3rhc3RtvuLlIfdHI2ZB/BJ7/KBuABn2ND1/m2Nk30u89wTJLLYNAfG7eym3suowMPzWyqCzrn4+h2M8+aWPH7cAG72vrkHlGCaIVw2BACcILk/XzygqVLhn4Qj/H7LTmq89/CO5jA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OGmPnz2U2UmnoUDjJFUxn616bhi5hVUTGF5HIs/5JXk=;
 b=OGxmFsihwC+00LyMvDURLzNEe44DKdj/CWPrsQdgFH6EQFtyrhlYLeSqaGS/Qi46dAtE55vLG+nHjcLp387euO+apk/ows3xQqlQbODfGFTynIQrd7IUyTsycBlUI0HgOMLDvUSMoLw3ASGrPeseuP+4ZkFHxa8l172sa6rxEP+J+8uukqEzFGcStoMu3BGBT0dFWRpsRqZJcBEuqTBP8PtVABsuXkvZxXiyGZsVNhtZja51pZCNEHzHHE8+3mTv5TmI+Hlz1u5W64WXjXc/h+ruMZOPXZHMOZsCSgl+9dK+FZlrX3LvCHAGmpzrbCibRWlqHjVQB0YOBOozPB5Jqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OGmPnz2U2UmnoUDjJFUxn616bhi5hVUTGF5HIs/5JXk=;
 b=v0bRP5i0LBcI5o5P2m6t7lNOMD6jGQV6CXFwguO5ZJ5JYWiv9+m/E7FcSk8zxMxIWrrdNItglXUUkuFWVUOTZrWN6LR30DyV/6vYED61uA0EeXBLA5+7RzeVS2bCNnx22raSZlnrovnvzbJP/I4FbMpg30hHVIgP9l7MtkFMw/w=
Received: from DM6PR13CA0041.namprd13.prod.outlook.com (2603:10b6:5:134::18)
 by BYAPR12MB2677.namprd12.prod.outlook.com (2603:10b6:a03:69::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.16; Fri, 22 Oct
 2021 10:54:37 +0000
Received: from DM6NAM11FT067.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:134:cafe::fe) by DM6PR13CA0041.outlook.office365.com
 (2603:10b6:5:134::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.8 via Frontend
 Transport; Fri, 22 Oct 2021 10:54:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT067.mail.protection.outlook.com (10.13.172.76) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4628.16 via Frontend Transport; Fri, 22 Oct 2021 10:54:36 +0000
Received: from brihaspati.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Fri, 22 Oct
 2021 05:54:34 -0500
From: Nirmoy Das <nirmoy.das@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Christian.Koenig@amd.com>, <andrey.grodzovsky@amd.com>,
 <lijo.lazar@amd.com>, Nirmoy Das <nirmoy.das@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Subject: [PATCH 2/3] drm/amdgpu: do not pass ttm_resource_manager to vram_mgr
Date: Fri, 22 Oct 2021 12:54:22 +0200
Message-ID: <20211022105423.69769-2-nirmoy.das@amd.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211022105423.69769-1-nirmoy.das@amd.com>
References: <20211022105423.69769-1-nirmoy.das@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 98e96523-b8d0-4261-fb3f-08d9954a56af
X-MS-TrafficTypeDiagnostic: BYAPR12MB2677:
X-Microsoft-Antispam-PRVS: <BYAPR12MB26776B649914A256C44FCAA18B809@BYAPR12MB2677.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SzMTB84n/wqC1uu0AyFyqQkSsVVm90X42TVEhBhoU9iXUTwXgo8doPaA3cufLvOPJcRRmlWS5TgPZlqiZLvN5+zcm9jnItRb3Mlo3DDCUKLWo8u3Zkc4DzxUPHCJ5PxHxY3/vAnZJRoKCI5gJ4ctzFKSlirllSYA8zXH3F/5A6eepT149bbzsrxd2JncwOI9yEE4p7rRmHkXfQiIBQGClOtvlsDjetBCN4Fy1nN7WqbAGNGFToqWDNPLDdIwPgMrI3Sh2Hwjpajjv3ILelVOr5t6mc2gN9HJLENKAcZ6qQrFg7JejBogvzqI8fX3eJxMlLWC2/+0hfuxRQ8ceOKE9wZw4/2Wc77q43RPpIcRx3/+vBXLIuOLQEhziYPvc3g03x683UUEQjBhxkSlEXH+Wqbr2nw4K02pAljSrCvCHIVe/Qgl/EEq7Rv0uEzYsbyvH9CSVBdzH58rWZCM4+4V+I8D+Qkdx6cfLPJhSyJjtBe+YoOmfvc24F9bAefssj2Gcx+927bqXGGBa9oDJcSbGSe9O4Vieiith/ul6oPX37W2W4+aRkk1EQRedxp3hKMuIomUqWsqjfauRIYLvbvosbAk9/Y8BQBLZYDoGsdmxKyNKZg5Lwo9LAyvROFvDETxotoUhjptV+NMjXgxvuLaxuak3vjJnKa5+1ofTrE4S1u5frDf+05deQufb9h/rplbsMG9yd1ZH4aDTD9XJHd1YPpZe/FYKR4p0+Nhv0gFLJs=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(66574015)(8676002)(8936002)(508600001)(26005)(5660300002)(1076003)(6916009)(54906003)(2906002)(83380400001)(6666004)(4326008)(186003)(47076005)(316002)(36860700001)(426003)(30864003)(86362001)(336012)(44832011)(7696005)(36756003)(82310400003)(70206006)(70586007)(16526019)(2616005)(81166007)(356005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2021 10:54:36.3328 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 98e96523-b8d0-4261-fb3f-08d9954a56af
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT067.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2677
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

Do not allow exported amdgpu_vram_mgr_*() to accept
any ttm_resource_manager pointer. Also there is no need
to force other module to call a ttm function just to
eventually call vram_mgr functions.

v2: pass adev's vram_mgr instead of adev
Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c   |  3 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c       |  5 +--
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c      | 10 ++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c      |  6 +--
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h      |  8 ++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c     |  5 +--
 drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c | 40 ++++++++------------
 7 files changed, 31 insertions(+), 46 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
index 7077f21f0021..df818e145d9a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
@@ -531,9 +531,8 @@ int amdgpu_amdkfd_get_dmabuf_info(struct kgd_dev *kgd, int dma_buf_fd,
 uint64_t amdgpu_amdkfd_get_vram_usage(struct kgd_dev *kgd)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)kgd;
-	struct ttm_resource_manager *vram_man = ttm_manager_type(&adev->mman.bdev, TTM_PL_VRAM);

-	return amdgpu_vram_mgr_usage(vram_man);
+	return amdgpu_vram_mgr_usage(&adev->mman.vram_mgr);
 }

 uint64_t amdgpu_amdkfd_get_hive_id(struct kgd_dev *kgd)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
index 76fe5b71e35d..7e745164a624 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
@@ -298,7 +298,6 @@ static void amdgpu_cs_get_threshold_for_moves(struct amdgpu_device *adev,
 {
 	s64 time_us, increment_us;
 	u64 free_vram, total_vram, used_vram;
-	struct ttm_resource_manager *vram_man = ttm_manager_type(&adev->mman.bdev, TTM_PL_VRAM);
 	/* Allow a maximum of 200 accumulated ms. This is basically per-IB
 	 * throttling.
 	 *
@@ -315,7 +314,7 @@ static void amdgpu_cs_get_threshold_for_moves(struct amdgpu_device *adev,
 	}

 	total_vram = adev->gmc.real_vram_size - atomic64_read(&adev->vram_pin_size);
-	used_vram = amdgpu_vram_mgr_usage(vram_man);
+	used_vram = amdgpu_vram_mgr_usage(&adev->mman.vram_mgr);
 	free_vram = used_vram >= total_vram ? 0 : total_vram - used_vram;

 	spin_lock(&adev->mm_stats.lock);
@@ -362,7 +361,7 @@ static void amdgpu_cs_get_threshold_for_moves(struct amdgpu_device *adev,
 	if (!amdgpu_gmc_vram_full_visible(&adev->gmc)) {
 		u64 total_vis_vram = adev->gmc.visible_vram_size;
 		u64 used_vis_vram =
-		  amdgpu_vram_mgr_vis_usage(vram_man);
+		  amdgpu_vram_mgr_vis_usage(&adev->mman.vram_mgr);

 		if (used_vis_vram < total_vis_vram) {
 			u64 free_vis_vram = total_vis_vram - used_vis_vram;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
index 603ce32db5c5..b426e03ad630 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -672,10 +672,10 @@ int amdgpu_info_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
 		ui64 = atomic64_read(&adev->num_vram_cpu_page_faults);
 		return copy_to_user(out, &ui64, min(size, 8u)) ? -EFAULT : 0;
 	case AMDGPU_INFO_VRAM_USAGE:
-		ui64 = amdgpu_vram_mgr_usage(ttm_manager_type(&adev->mman.bdev, TTM_PL_VRAM));
+		ui64 = amdgpu_vram_mgr_usage(&adev->mman.vram_mgr);
 		return copy_to_user(out, &ui64, min(size, 8u)) ? -EFAULT : 0;
 	case AMDGPU_INFO_VIS_VRAM_USAGE:
-		ui64 = amdgpu_vram_mgr_vis_usage(ttm_manager_type(&adev->mman.bdev, TTM_PL_VRAM));
+		ui64 = amdgpu_vram_mgr_vis_usage(&adev->mman.vram_mgr);
 		return copy_to_user(out, &ui64, min(size, 8u)) ? -EFAULT : 0;
 	case AMDGPU_INFO_GTT_USAGE:
 		ui64 = amdgpu_gtt_mgr_usage(&adev->mman.gtt_mgr);
@@ -709,8 +709,6 @@ int amdgpu_info_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
 	}
 	case AMDGPU_INFO_MEMORY: {
 		struct drm_amdgpu_memory_info mem;
-		struct ttm_resource_manager *vram_man =
-			ttm_manager_type(&adev->mman.bdev, TTM_PL_VRAM);
 		struct ttm_resource_manager *gtt_man =
 			ttm_manager_type(&adev->mman.bdev, TTM_PL_TT);
 		memset(&mem, 0, sizeof(mem));
@@ -719,7 +717,7 @@ int amdgpu_info_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
 			atomic64_read(&adev->vram_pin_size) -
 			AMDGPU_VM_RESERVED_VRAM;
 		mem.vram.heap_usage =
-			amdgpu_vram_mgr_usage(vram_man);
+			amdgpu_vram_mgr_usage(&adev->mman.vram_mgr);
 		mem.vram.max_allocation = mem.vram.usable_heap_size * 3 / 4;

 		mem.cpu_accessible_vram.total_heap_size =
@@ -729,7 +727,7 @@ int amdgpu_info_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
 			    atomic64_read(&adev->visible_pin_size),
 			    mem.vram.usable_heap_size);
 		mem.cpu_accessible_vram.heap_usage =
-			amdgpu_vram_mgr_vis_usage(vram_man);
+			amdgpu_vram_mgr_vis_usage(&adev->mman.vram_mgr);
 		mem.cpu_accessible_vram.max_allocation =
 			mem.cpu_accessible_vram.usable_heap_size * 3 / 4;

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 08133de21fdd..4114e0d35e82 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -1804,8 +1804,7 @@ static int amdgpu_ras_badpages_read(struct amdgpu_device *adev,
 			.size = AMDGPU_GPU_PAGE_SIZE,
 			.flags = AMDGPU_RAS_RETIRE_PAGE_RESERVED,
 		};
-		status = amdgpu_vram_mgr_query_page_status(
-				ttm_manager_type(&adev->mman.bdev, TTM_PL_VRAM),
+		status = amdgpu_vram_mgr_query_page_status(&adev->mman.vram_mgr,
 				data->bps[i].retired_page);
 		if (status == -EBUSY)
 			(*bps)[i].flags = AMDGPU_RAS_RETIRE_PAGE_PENDING;
@@ -1906,8 +1905,7 @@ int amdgpu_ras_add_bad_pages(struct amdgpu_device *adev,
 			goto out;
 		}

-		amdgpu_vram_mgr_reserve_range(
-			ttm_manager_type(&adev->mman.bdev, TTM_PL_VRAM),
+		amdgpu_vram_mgr_reserve_range(&adev->mman.vram_mgr,
 			bps[i].retired_page << AMDGPU_GPU_PAGE_SHIFT,
 			AMDGPU_GPU_PAGE_SIZE);

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
index af1c4e414979..ee8ab7846905 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
@@ -129,11 +129,11 @@ int amdgpu_vram_mgr_alloc_sgt(struct amdgpu_device *adev,
 void amdgpu_vram_mgr_free_sgt(struct device *dev,
 			      enum dma_data_direction dir,
 			      struct sg_table *sgt);
-uint64_t amdgpu_vram_mgr_usage(struct ttm_resource_manager *man);
-uint64_t amdgpu_vram_mgr_vis_usage(struct ttm_resource_manager *man);
-int amdgpu_vram_mgr_reserve_range(struct ttm_resource_manager *man,
+uint64_t amdgpu_vram_mgr_usage(struct amdgpu_vram_mgr *mgr);
+uint64_t amdgpu_vram_mgr_vis_usage(struct amdgpu_vram_mgr *mgr);
+int amdgpu_vram_mgr_reserve_range(struct amdgpu_vram_mgr *mgr,
 				  uint64_t start, uint64_t size);
-int amdgpu_vram_mgr_query_page_status(struct ttm_resource_manager *man,
+int amdgpu_vram_mgr_query_page_status(struct amdgpu_vram_mgr *mgr,
 				      uint64_t start);

 int amdgpu_ttm_init(struct amdgpu_device *adev);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
index 99c149397aae..a3c7a19047e8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
@@ -548,7 +548,6 @@ static void amdgpu_virt_populate_vf2pf_ucode_info(struct amdgpu_device *adev)
 static int amdgpu_virt_write_vf2pf_data(struct amdgpu_device *adev)
 {
 	struct amd_sriov_msg_vf2pf_info *vf2pf_info;
-	struct ttm_resource_manager *vram_man = ttm_manager_type(&adev->mman.bdev, TTM_PL_VRAM);

 	vf2pf_info = (struct amd_sriov_msg_vf2pf_info *) adev->virt.fw_reserve.p_vf2pf;

@@ -571,8 +570,8 @@ static int amdgpu_virt_write_vf2pf_data(struct amdgpu_device *adev)
 	vf2pf_info->driver_cert = 0;
 	vf2pf_info->os_info.all = 0;

-	vf2pf_info->fb_usage = amdgpu_vram_mgr_usage(vram_man) >> 20;
-	vf2pf_info->fb_vis_usage = amdgpu_vram_mgr_vis_usage(vram_man) >> 20;
+	vf2pf_info->fb_usage = amdgpu_vram_mgr_usage(&adev->mman.vram_mgr) >> 20;
+	vf2pf_info->fb_vis_usage = amdgpu_vram_mgr_vis_usage(&adev->mman.vram_mgr) >> 20;
 	vf2pf_info->fb_size = adev->gmc.real_vram_size >> 20;
 	vf2pf_info->fb_vis_size = adev->gmc.visible_vram_size >> 20;

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
index 7b2b0980ec41..7a2b487db57c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
@@ -96,10 +96,9 @@ static ssize_t amdgpu_mem_info_vram_used_show(struct device *dev,
 {
 	struct drm_device *ddev = dev_get_drvdata(dev);
 	struct amdgpu_device *adev = drm_to_adev(ddev);
-	struct ttm_resource_manager *man;

-	man = ttm_manager_type(&adev->mman.bdev, TTM_PL_VRAM);
-	return sysfs_emit(buf, "%llu\n", amdgpu_vram_mgr_usage(man));
+	return sysfs_emit(buf, "%llu\n",
+			  amdgpu_vram_mgr_usage(&adev->mman.vram_mgr));
 }

 /**
@@ -116,10 +115,9 @@ static ssize_t amdgpu_mem_info_vis_vram_used_show(struct device *dev,
 {
 	struct drm_device *ddev = dev_get_drvdata(dev);
 	struct amdgpu_device *adev = drm_to_adev(ddev);
-	struct ttm_resource_manager *man;

-	man = ttm_manager_type(&adev->mman.bdev, TTM_PL_VRAM);
-	return sysfs_emit(buf, "%llu\n", amdgpu_vram_mgr_vis_usage(man));
+	return sysfs_emit(buf, "%llu\n",
+			  amdgpu_vram_mgr_vis_usage(&adev->mman.vram_mgr));
 }

 /**
@@ -263,16 +261,15 @@ static void amdgpu_vram_mgr_do_reserve(struct ttm_resource_manager *man)
 /**
  * amdgpu_vram_mgr_reserve_range - Reserve a range from VRAM
  *
- * @man: TTM memory type manager
+ * @mgr: amdgpu_vram_mgr pointer
  * @start: start address of the range in VRAM
  * @size: size of the range
  *
- * Reserve memory from start addess with the specified size in VRAM
+ * Reserve memory from start address with the specified size in VRAM
  */
-int amdgpu_vram_mgr_reserve_range(struct ttm_resource_manager *man,
+int amdgpu_vram_mgr_reserve_range(struct amdgpu_vram_mgr *mgr,
 				  uint64_t start, uint64_t size)
 {
-	struct amdgpu_vram_mgr *mgr = to_vram_mgr(man);
 	struct amdgpu_vram_reservation *rsv;

 	rsv = kzalloc(sizeof(*rsv), GFP_KERNEL);
@@ -285,7 +282,7 @@ int amdgpu_vram_mgr_reserve_range(struct ttm_resource_manager *man,

 	spin_lock(&mgr->lock);
 	list_add_tail(&mgr->reservations_pending, &rsv->node);
-	amdgpu_vram_mgr_do_reserve(man);
+	amdgpu_vram_mgr_do_reserve(&mgr->manager);
 	spin_unlock(&mgr->lock);

 	return 0;
@@ -294,7 +291,7 @@ int amdgpu_vram_mgr_reserve_range(struct ttm_resource_manager *man,
 /**
  * amdgpu_vram_mgr_query_page_status - query the reservation status
  *
- * @man: TTM memory type manager
+ * @mgr: amdgpu_vram_mgr pointer
  * @start: start address of a page in VRAM
  *
  * Returns:
@@ -302,10 +299,9 @@ int amdgpu_vram_mgr_reserve_range(struct ttm_resource_manager *man,
  *	0: the page has been reserved
  *	-ENOENT: the input page is not a reservation
  */
-int amdgpu_vram_mgr_query_page_status(struct ttm_resource_manager *man,
+int amdgpu_vram_mgr_query_page_status(struct amdgpu_vram_mgr *mgr,
 				      uint64_t start)
 {
-	struct amdgpu_vram_mgr *mgr = to_vram_mgr(man);
 	struct amdgpu_vram_reservation *rsv;
 	int ret;

@@ -632,28 +628,24 @@ void amdgpu_vram_mgr_free_sgt(struct device *dev,
 /**
  * amdgpu_vram_mgr_usage - how many bytes are used in this domain
  *
- * @man: TTM memory type manager
+ * @mgr: amdgpu_vram_mgr pointer
  *
  * Returns how many bytes are used in this domain.
  */
-uint64_t amdgpu_vram_mgr_usage(struct ttm_resource_manager *man)
+uint64_t amdgpu_vram_mgr_usage(struct amdgpu_vram_mgr *mgr)
 {
-	struct amdgpu_vram_mgr *mgr = to_vram_mgr(man);
-
 	return atomic64_read(&mgr->usage);
 }

 /**
  * amdgpu_vram_mgr_vis_usage - how many bytes are used in the visible part
  *
- * @man: TTM memory type manager
+ * @mgr: amdgpu_vram_mgr pointer
  *
  * Returns how many bytes are used in the visible part of VRAM
  */
-uint64_t amdgpu_vram_mgr_vis_usage(struct ttm_resource_manager *man)
+uint64_t amdgpu_vram_mgr_vis_usage(struct amdgpu_vram_mgr *mgr)
 {
-	struct amdgpu_vram_mgr *mgr = to_vram_mgr(man);
-
 	return atomic64_read(&mgr->vis_usage);
 }

@@ -675,8 +667,8 @@ static void amdgpu_vram_mgr_debug(struct ttm_resource_manager *man,
 	spin_unlock(&mgr->lock);

 	drm_printf(printer, "man size:%llu pages, ram usage:%lluMB, vis usage:%lluMB\n",
-		   man->size, amdgpu_vram_mgr_usage(man) >> 20,
-		   amdgpu_vram_mgr_vis_usage(man) >> 20);
+		   man->size, amdgpu_vram_mgr_usage(mgr) >> 20,
+		   amdgpu_vram_mgr_vis_usage(mgr) >> 20);
 }

 static const struct ttm_resource_manager_func amdgpu_vram_mgr_func = {
--
2.32.0

