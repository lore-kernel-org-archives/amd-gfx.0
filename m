Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18961C433F5
	for <amd-gfx@archiver.kernel.org>; Fri,  7 Jan 2022 08:51:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7B1C911AE9C;
	Fri,  7 Jan 2022 08:51:41 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2083.outbound.protection.outlook.com [40.107.94.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4DAB211AE9E
 for <amd-gfx@lists.freedesktop.org>; Fri,  7 Jan 2022 08:51:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=euOlzwBGcW+J8nWcA70af7Vq9zqErMmFc0+5xBHCrRIIz+aYelFVdjy/eSYQ2pdz5HmrUBSJ8/ZVMNrfFWKxFSyabaIN6jDYSJ9QqzvMvPp2n9oS6PN60igq1AcVWDfCllda67Qlo75gghaugB0APYmy6tHBrPx71c9q02qtiSI4Y6gxkuc557t4eAiAjHt/axkOyi/MFKpBNBkDNo7SBEhEN4/YJMipMHHRZyB1zwUpIX2gp0P0XKaMASENnr83JHr5FpdGSicXegRG7V/J3V5lUZ52CBl+7+wkwkQQGmbAK5/Esc1/nD2UeDN2Fi86VIE9y0+bDVBC02YUfVcp0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P99YzLfD7FsOX/hRiKwh5AZpSUscJ4gQTkLDnN0AKQc=;
 b=BCqyLA+oyqfyS0EKbICUz7NVuaLt6ziUGGJMpQeJgTfdCJw7/AAtXG8SATE4G5YWtMXd5OrpS+Z5MOyygi7rjI0Qv9/7yQ4rXSG/AthW18Ti6TsK0IxPa7hjcHsxMDHwVsfxtYSOGywC5uirHJTGC5vhrT2faq17XRlV/za3GallBjlVcCil9eOutRutt6ngRHBSSdUoB2FEULQq0dm3u7RoAR8kMIXtJFEIwHl8eduAj6Y4H5Bmr8i8TDR0DTccFvspWhS0ZmDq/Qsf1mAp19YIzpQWQqcahKuqEA9NIPTxkENyFj8rEfg2iI9WGQN9017cqPeA9oacOhqNVxq91A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P99YzLfD7FsOX/hRiKwh5AZpSUscJ4gQTkLDnN0AKQc=;
 b=PAk7zuQWqxfpS1w/l7KJ6lJ2D2HehIv672SJHsYTnLWfpJBs1qbjfXK3abXQJGSMoTsgPKZF5gUio/J7ZwBbFZCDcqZuGA1ZR79TNeorlj0pY2tL26U05Gveyq5lhsFOaOJPQRKdzlqlgjiP7UOKpu2cg3T5B9D5GuDvPXibp5c=
Received: from MWHPR17CA0088.namprd17.prod.outlook.com (2603:10b6:300:c2::26)
 by MWHPR12MB1696.namprd12.prod.outlook.com (2603:10b6:301:8::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.9; Fri, 7 Jan
 2022 08:51:38 +0000
Received: from CO1NAM11FT009.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:c2:cafe::5b) by MWHPR17CA0088.outlook.office365.com
 (2603:10b6:300:c2::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.7 via Frontend
 Transport; Fri, 7 Jan 2022 08:51:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT009.mail.protection.outlook.com (10.13.175.61) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4867.7 via Frontend Transport; Fri, 7 Jan 2022 08:51:38 +0000
Received: from brihaspati.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Fri, 7 Jan
 2022 02:51:36 -0600
From: Nirmoy Das <nirmoy.das@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH REBASED 3/4] drm/amdgpu: do not pass ttm_resource_manager to
 vram_mgr
Date: Fri, 7 Jan 2022 09:51:14 +0100
Message-ID: <20220107085115.8820-3-nirmoy.das@amd.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20220107085115.8820-1-nirmoy.das@amd.com>
References: <20220107085115.8820-1-nirmoy.das@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3cbe35fb-02a5-4ba1-d465-08d9d1baead1
X-MS-TrafficTypeDiagnostic: MWHPR12MB1696:EE_
X-Microsoft-Antispam-PRVS: <MWHPR12MB169634A033A91136078E31348B4D9@MWHPR12MB1696.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xeJJ0nLgL5s1/V39heDC836GVZhKeKNWj47suse5XPThl8K2vBbVUQ45JYbJbSPzQqPvzOSnvmzvEA6SozmGCPd2rSRm1q7wiV19b4o/ifvujzJ/skWBoWjLzxQG+8GpxAZIPupoiwxo68eJOdWGa101hckv+7fbprMIVEuV6PHGT1FAFE2Nf6Eqhu8oc+3TvIPASBKGyie9s1PHa8n5s8AKmKbHQb2mCR/Jii0Texn5ljobgWtbsfuE2+5RHHo2VUNbpBWCwDMUEEd8ZLdzkBrFYIH8XNBzvhv9S2nA3AD2LMv/b9EHVT/mp5PSTGaJ8LfQUmPCtZrOdUAVQ8w+AzSq5X+dySTLa0I5sV4OC4rNDdQR8F5K+GXQND4GIAFamFed3Z+DNVBHy12Ww8P3OWfdUBDwUi0WARMvDfTbyDlyq/MnWhlpDWrLPHzKXo34KP9FDocvHIXZbqiXwZS3k5hJ1/IhkM5ts5et42Dq78OsD1M3KOb8TEtkqQCd788TW87ZvfpN7BCCuvnsZPAxeBWz4OHmC1OAYMdmUmLUgnLr8tWFzlhuGUVSZcsPwiOq8BcjkvNz5s+9GQSeAsL9Rvde03Dfb+L9lVzSj9gmaLkMtS0bH+05XuANbzOnvc52h+lP/cpi9K5dxZsGG7t4CyhHXnxx3QI+LKeQxfjPIhPo52MElChJ+WZx8Sf303mLhihUCyLqHCypknzag2DeBVlkO60wkF74STZVa27McS3KR0xMPub5hvz5Qefd+iJc0SQSy8a9K86t/6/klJ5vIiX0bvOw6c8twoa2vHWnY/U=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(40470700002)(46966006)(8936002)(30864003)(16526019)(26005)(186003)(83380400001)(508600001)(356005)(86362001)(81166007)(7696005)(1076003)(6916009)(8676002)(54906003)(6666004)(40460700001)(2906002)(70206006)(82310400004)(336012)(44832011)(5660300002)(36860700001)(36756003)(426003)(70586007)(66574015)(316002)(2616005)(4326008)(47076005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2022 08:51:38.1503 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3cbe35fb-02a5-4ba1-d465-08d9d1baead1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT009.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1696
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
Cc: andrey.grodzovsky@amd.com, Nirmoy Das <nirmoy.das@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Do not allow exported amdgpu_vram_mgr_*() to accept
any ttm_resource_manager pointer. Also there is no need
to force other module to call a ttm function just to
eventually call vram_mgr functions.

v2: pass adev's vram_mgr instead of adev

Reviewed-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c       |  5 +--
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c      | 10 ++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c      |  6 +--
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h      |  8 ++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c     |  5 +--
 drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c | 40 ++++++++------------
 6 files changed, 30 insertions(+), 44 deletions(-)

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
index 763de822afa1..289521aafb79 100644
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
index 3f5bf5780ebf..4a9970423e7d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -1839,8 +1839,7 @@ static int amdgpu_ras_badpages_read(struct amdgpu_device *adev,
 			.size = AMDGPU_GPU_PAGE_SIZE,
 			.flags = AMDGPU_RAS_RETIRE_PAGE_RESERVED,
 		};
-		status = amdgpu_vram_mgr_query_page_status(
-				ttm_manager_type(&adev->mman.bdev, TTM_PL_VRAM),
+		status = amdgpu_vram_mgr_query_page_status(&adev->mman.vram_mgr,
 				data->bps[i].retired_page);
 		if (status == -EBUSY)
 			(*bps)[i].flags = AMDGPU_RAS_RETIRE_PAGE_PENDING;
@@ -1941,8 +1940,7 @@ int amdgpu_ras_add_bad_pages(struct amdgpu_device *adev,
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
index d9509c3482e2..894444ab0032 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
@@ -553,7 +553,6 @@ static void amdgpu_virt_populate_vf2pf_ucode_info(struct amdgpu_device *adev)
 static int amdgpu_virt_write_vf2pf_data(struct amdgpu_device *adev)
 {
 	struct amd_sriov_msg_vf2pf_info *vf2pf_info;
-	struct ttm_resource_manager *vram_man = ttm_manager_type(&adev->mman.bdev, TTM_PL_VRAM);
 
 	vf2pf_info = (struct amd_sriov_msg_vf2pf_info *) adev->virt.fw_reserve.p_vf2pf;
 
@@ -576,8 +575,8 @@ static int amdgpu_virt_write_vf2pf_data(struct amdgpu_device *adev)
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
2.33.1

