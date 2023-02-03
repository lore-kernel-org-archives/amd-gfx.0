Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40E8FC05027
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Feb 2023 19:09:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CD5CF10E894;
	Fri,  3 Feb 2023 19:09:20 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2043.outbound.protection.outlook.com [40.107.92.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7683F10E893
 for <amd-gfx@lists.freedesktop.org>; Fri,  3 Feb 2023 19:09:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JDXefouK4GD2J4vZxKguaYJbqHuXTos0Rhgj7lJKURIZ1nL6ovxbbuLBiURSjUqsK8z3o56FKkiiDfBiO7upvpfVRmmow+oNrYQTAAU89aiTgKgVL7RzUx7N8a7CRnc/0tCwwljYkqULYknfAXGhD66wcBR/BiATOD2qOwzN3gPmK8Z9iEId675/EaHmJQ9ErqQ6LFlIY0PkivaVnPE/9dslDNpXQpzC0ql4GP9qVX7cSz4fo8AMP49UoqldfvJKOHsWYdk9nqsUeobe8qnovB0WKpCJhhY5e4GwNomG2npm/X1h3+BNpjXjIcAr1A34JjS+nkZoB/4zFhSbHSqVkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lGKp7ARvegE7ymnJ6ZDIZNJruMZ+1Cwy1QciNij+/K0=;
 b=i+qe1U4+NXTe31Og4Iz6selERdFkdnXW+FsB/0SXCYktB9v6/nMIT9yYiSXjIP/00M34ABlq1A6wzoJ9vFmT3kEt0e5enGgVMFgAgRtpVW456p8dJNlk2iCMT5XNivL5OzD32E1lW2ZB49wzAsoThyl/fK026VhYyoJlbzZQpSAd1e88phiX+ddTTrRHTMd9bWEOilzSdEDZOvyIqC0FJ1T4SJ6p6hoI98WGix2vutDuLeAhEBvgd0K5I+myNOxsHHePM/JADW/dS4mG7ZVp3fj3sBCLVdqaB8VYAYZlvquCUfNSGVwdy8hLAOfXjHeSb8BMvpEcTFySm1kELQYC0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lGKp7ARvegE7ymnJ6ZDIZNJruMZ+1Cwy1QciNij+/K0=;
 b=bsKtAkYZsY9ikboW3Nnw7siXa0Xkxs7urKweSBw+Hwhf3gYXMN+83iTLZy6/Wwz/Z5X+pcXG5qJM1XPBlOU06QokPA6CwVa6Nt4I7rA9qReGVxVLpD3S+SlM+WmqCHDpJShKCzlLtQQLUGcQLwokQccSKYaWCcrBl7q+G3G4WGo=
Received: from CY5PR20CA0016.namprd20.prod.outlook.com (2603:10b6:930:3::19)
 by SA1PR12MB6821.namprd12.prod.outlook.com (2603:10b6:806:25c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.29; Fri, 3 Feb
 2023 19:09:15 +0000
Received: from CY4PEPF0000B8EB.namprd05.prod.outlook.com
 (2603:10b6:930:3:cafe::21) by CY5PR20CA0016.outlook.office365.com
 (2603:10b6:930:3::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.31 via Frontend
 Transport; Fri, 3 Feb 2023 19:09:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000B8EB.mail.protection.outlook.com (10.167.241.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6064.15 via Frontend Transport; Fri, 3 Feb 2023 19:09:15 +0000
Received: from MUN-L-SHSHARMA.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 3 Feb
 2023 13:09:13 -0600
From: Shashank Sharma <shashank.sharma@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 02/13] drm/amdgpu: rename vram_mgr functions to bar_mgr
Date: Fri, 3 Feb 2023 20:08:19 +0100
Message-ID: <20230203190836.1987-3-shashank.sharma@amd.com>
X-Mailer: git-send-email 2.38.0.windows.1
In-Reply-To: <20230203190836.1987-1-shashank.sharma@amd.com>
References: <20230203190836.1987-1-shashank.sharma@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000B8EB:EE_|SA1PR12MB6821:EE_
X-MS-Office365-Filtering-Correlation-Id: e9a1acc9-89c4-49fe-8e39-08db061a248a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fs+iPfsh5G+4PKqHJAe12TkAxYaFNnKCJ9JNGTBX0mlEuu7tukYC6wP7KzCF8XhFJDNi5dmGnArxVs8fcOe0PmCfunkdF+ggQqLvqHD3wgIxXUVbTIwL9bnPS+in8EWhbLVmWgPHKI0c9xwrc8MPztqz4AnRqFpLKHkexrkM/xz+lVPbsDyJny83Ce2SU+YjAjsTBFeITUw0lSxqrCpoS+a/NKqFaW79zIxEuKD3hXYAjylcRctmUNf5/ck3P3El/ydtrBscXM6dKWFX7yMg/L4k8OvEVjLjKktrdsCINIFcFwif8Pu9o4EBVaK2uwaHoLsqH8claRUCqcXill5WeiE5BPBi6cpuBVi3dlknWGFoktc7GqJeuJG/6M/czZa1H9P2O1zUBYL38/kA14T4PPQwIhDx4CNpQqJoDu0RQuaGx6kci0zeqnmn7QgFlO5W6LoqlPJRCQjefCr7iJElykgFutgZGrBD70kT+f/v66u3deVdjqLNWIo7uLE/RSatUVkupYBvBkwV3zS/ruXl6Fjn4RuAIO7MV2SkKGrDsPc24EIjICrF1SZjGCynIxgO2k0FIC5dqsu3Uiady9LVrnuG3PoX6HGAvDN8s7Mte9GChZT8fpdsW095ElIQK3QSYEI3LRHQyWrL2kcwYJmkWym0XF4g6SozH1+G1d10G3rbOMdqORyWBIE9yls7tPo2Tz3UHeCaUv2LGzCUGnCgZvnVvt5/QEx59DoNBp1ZzOE=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(396003)(136003)(376002)(39860400002)(346002)(451199018)(36840700001)(46966006)(40470700004)(6916009)(4326008)(8676002)(26005)(82740400003)(70586007)(70206006)(186003)(16526019)(30864003)(44832011)(8936002)(36756003)(1076003)(5660300002)(40460700003)(2616005)(336012)(83380400001)(426003)(47076005)(40480700001)(2906002)(41300700001)(86362001)(36860700001)(54906003)(81166007)(316002)(7696005)(82310400005)(356005)(478600001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2023 19:09:15.4095 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e9a1acc9-89c4-49fe-8e39-08db061a248a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000B8EB.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6821
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
Cc: alexander.deucher@amd.com, christian.koenig@amd.com,
 shashank.sharma@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Alex Deucher <alexander.deucher@amd.com>

Rename the VRAM manager functions so they can be resused to manage
doorbell BAR as well.

Cc: Christian Koenig <christian.koenig@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c        |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c   |   8 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c       |   4 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c       |   4 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c    |   4 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c       |   4 +-
 .../gpu/drm/amd/amdgpu/amdgpu_res_cursor.h    |  14 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c       |   4 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h       |  36 ++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c      |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c  | 200 ++++++++++--------
 drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.h  |  18 +-
 12 files changed, 157 insertions(+), 143 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
index 7b5ce00f0602..e34eae8d64cf 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
@@ -723,7 +723,7 @@ static void amdgpu_cs_get_threshold_for_moves(struct amdgpu_device *adev,
 	if (!amdgpu_gmc_vram_full_visible(&adev->gmc)) {
 		u64 total_vis_vram = adev->gmc.visible_vram_size;
 		u64 used_vis_vram =
-		  amdgpu_vram_mgr_vis_usage(&adev->mman.vram_mgr);
+		  amdgpu_bar_mgr_vis_usage(&adev->mman.vram_mgr);
 
 		if (used_vis_vram < total_vis_vram) {
 			u64 free_vis_vram = total_vis_vram - used_vis_vram;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
index 271e30e34d93..c48ccde281c3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
@@ -179,9 +179,9 @@ static struct sg_table *amdgpu_dma_buf_map(struct dma_buf_attachment *attach,
 		break;
 
 	case TTM_PL_VRAM:
-		r = amdgpu_vram_mgr_alloc_sgt(adev, bo->tbo.resource, 0,
-					      bo->tbo.base.size, attach->dev,
-					      dir, &sgt);
+		r = amdgpu_bar_mgr_alloc_sgt(adev, bo->tbo.resource, 0,
+					     bo->tbo.base.size, attach->dev,
+					     dir, &sgt);
 		if (r)
 			return ERR_PTR(r);
 		break;
@@ -215,7 +215,7 @@ static void amdgpu_dma_buf_unmap(struct dma_buf_attachment *attach,
 		sg_free_table(sgt);
 		kfree(sgt);
 	} else {
-		amdgpu_vram_mgr_free_sgt(attach->dev, dir, sgt);
+		amdgpu_bar_mgr_free_sgt(attach->dev, dir, sgt);
 	}
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index cd4caaa29528..9f148ea7ca66 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -2807,12 +2807,12 @@ static struct pci_error_handlers amdgpu_pci_err_handler = {
 	.resume		= amdgpu_pci_resume,
 };
 
-extern const struct attribute_group amdgpu_vram_mgr_attr_group;
+extern const struct attribute_group amdgpu_bar_mgr_attr_group;
 extern const struct attribute_group amdgpu_gtt_mgr_attr_group;
 extern const struct attribute_group amdgpu_vbios_version_attr_group;
 
 static const struct attribute_group *amdgpu_sysfs_groups[] = {
-	&amdgpu_vram_mgr_attr_group,
+	&amdgpu_bar_mgr_attr_group,
 	&amdgpu_gtt_mgr_attr_group,
 	&amdgpu_vbios_version_attr_group,
 	NULL,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
index 7aa7e52ca784..2ce11434fb22 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -650,7 +650,7 @@ int amdgpu_info_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
 		ui64 = ttm_resource_manager_usage(&adev->mman.vram_mgr.manager);
 		return copy_to_user(out, &ui64, min(size, 8u)) ? -EFAULT : 0;
 	case AMDGPU_INFO_VIS_VRAM_USAGE:
-		ui64 = amdgpu_vram_mgr_vis_usage(&adev->mman.vram_mgr);
+		ui64 = amdgpu_bar_mgr_vis_usage(&adev->mman.vram_mgr);
 		return copy_to_user(out, &ui64, min(size, 8u)) ? -EFAULT : 0;
 	case AMDGPU_INFO_GTT_USAGE:
 		ui64 = ttm_resource_manager_usage(&adev->mman.gtt_mgr.manager);
@@ -704,7 +704,7 @@ int amdgpu_info_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
 			    atomic64_read(&adev->visible_pin_size),
 			    mem.vram.usable_heap_size);
 		mem.cpu_accessible_vram.heap_usage =
-			amdgpu_vram_mgr_vis_usage(&adev->mman.vram_mgr);
+			amdgpu_bar_mgr_vis_usage(&adev->mman.vram_mgr);
 		mem.cpu_accessible_vram.max_allocation =
 			mem.cpu_accessible_vram.usable_heap_size * 3 / 4;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
index 25a68d8888e0..ca85d64a72c2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
@@ -958,7 +958,7 @@ int amdgpu_bo_pin_restricted(struct amdgpu_bo *bo, u32 domain,
 	domain = amdgpu_mem_type_to_domain(bo->tbo.resource->mem_type);
 	if (domain == AMDGPU_GEM_DOMAIN_VRAM) {
 		atomic64_add(amdgpu_bo_size(bo), &adev->vram_pin_size);
-		atomic64_add(amdgpu_vram_mgr_bo_visible_size(bo),
+		atomic64_add(amdgpu_bar_mgr_bo_visible_size(bo),
 			     &adev->visible_pin_size);
 	} else if (domain == AMDGPU_GEM_DOMAIN_GTT) {
 		atomic64_add(amdgpu_bo_size(bo), &adev->gart_pin_size);
@@ -1009,7 +1009,7 @@ void amdgpu_bo_unpin(struct amdgpu_bo *bo)
 
 	if (bo->tbo.resource->mem_type == TTM_PL_VRAM) {
 		atomic64_sub(amdgpu_bo_size(bo), &adev->vram_pin_size);
-		atomic64_sub(amdgpu_vram_mgr_bo_visible_size(bo),
+		atomic64_sub(amdgpu_bar_mgr_bo_visible_size(bo),
 			     &adev->visible_pin_size);
 	} else if (bo->tbo.resource->mem_type == TTM_PL_TT) {
 		atomic64_sub(amdgpu_bo_size(bo), &adev->gart_pin_size);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index ad490c1e2f57..4e64a035d49d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -1899,7 +1899,7 @@ static int amdgpu_ras_badpages_read(struct amdgpu_device *adev,
 			.size = AMDGPU_GPU_PAGE_SIZE,
 			.flags = AMDGPU_RAS_RETIRE_PAGE_RESERVED,
 		};
-		status = amdgpu_vram_mgr_query_page_status(&adev->mman.vram_mgr,
+		status = amdgpu_bar_mgr_query_page_status(&adev->mman.vram_mgr,
 				data->bps[i].retired_page);
 		if (status == -EBUSY)
 			(*bps)[i].flags = AMDGPU_RAS_RETIRE_PAGE_PENDING;
@@ -2012,7 +2012,7 @@ int amdgpu_ras_add_bad_pages(struct amdgpu_device *adev,
 			goto out;
 		}
 
-		amdgpu_vram_mgr_reserve_range(&adev->mman.vram_mgr,
+		amdgpu_bar_mgr_reserve_range(&adev->mman.vram_mgr,
 			bps[i].retired_page << AMDGPU_GPU_PAGE_SHIFT,
 			AMDGPU_GPU_PAGE_SIZE);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_res_cursor.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_res_cursor.h
index 5c4f93ee0c57..dd2b43acc600 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_res_cursor.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_res_cursor.h
@@ -68,7 +68,7 @@ static inline void amdgpu_res_first(struct ttm_resource *res,
 
 	switch (cur->mem_type) {
 	case TTM_PL_VRAM:
-		head = &to_amdgpu_vram_mgr_resource(res)->blocks;
+		head = &to_amdgpu_bar_mgr_resource(res)->blocks;
 
 		block = list_first_entry_or_null(head,
 						 struct drm_buddy_block,
@@ -76,16 +76,16 @@ static inline void amdgpu_res_first(struct ttm_resource *res,
 		if (!block)
 			goto fallback;
 
-		while (start >= amdgpu_vram_mgr_block_size(block)) {
-			start -= amdgpu_vram_mgr_block_size(block);
+		while (start >= amdgpu_bar_mgr_block_size(block)) {
+			start -= amdgpu_bar_mgr_block_size(block);
 
 			next = block->link.next;
 			if (next != head)
 				block = list_entry(next, struct drm_buddy_block, link);
 		}
 
-		cur->start = amdgpu_vram_mgr_block_start(block) + start;
-		cur->size = min(amdgpu_vram_mgr_block_size(block) - start, size);
+		cur->start = amdgpu_bar_mgr_block_start(block) + start;
+		cur->size = min(amdgpu_bar_mgr_block_size(block) - start, size);
 		cur->remaining = size;
 		cur->node = block;
 		break;
@@ -148,8 +148,8 @@ static inline void amdgpu_res_next(struct amdgpu_res_cursor *cur, uint64_t size)
 		block = list_entry(next, struct drm_buddy_block, link);
 
 		cur->node = block;
-		cur->start = amdgpu_vram_mgr_block_start(block);
-		cur->size = min(amdgpu_vram_mgr_block_size(block), cur->remaining);
+		cur->start = amdgpu_bar_mgr_block_start(block);
+		cur->size = min(amdgpu_bar_mgr_block_size(block), cur->remaining);
 		break;
 	case TTM_PL_TT:
 		node = cur->node;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index 55e0284b2bdd..668826653591 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -1735,7 +1735,7 @@ int amdgpu_ttm_init(struct amdgpu_device *adev)
 	adev->mman.initialized = true;
 
 	/* Initialize VRAM pool with all of VRAM divided into pages */
-	r = amdgpu_vram_mgr_init(adev);
+	r = amdgpu_bar_mgr_init(adev, TTM_PL_VRAM);
 	if (r) {
 		DRM_ERROR("Failed initializing VRAM heap.\n");
 		return r;
@@ -1911,7 +1911,7 @@ void amdgpu_ttm_fini(struct amdgpu_device *adev)
 		drm_dev_exit(idx);
 	}
 
-	amdgpu_vram_mgr_fini(adev);
+	amdgpu_bar_mgr_fini(adev, TTM_PL_VRAM);
 	amdgpu_gtt_mgr_fini(adev);
 	amdgpu_preempt_mgr_fini(adev);
 	ttm_range_man_fini(&adev->mman.bdev, AMDGPU_PL_GDS);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
index e2cd5894afc9..a918bbd67004 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
@@ -61,7 +61,7 @@ struct amdgpu_mman {
 	/* Scheduler entity for buffer moves */
 	struct drm_sched_entity			entity;
 
-	struct amdgpu_vram_mgr vram_mgr;
+	struct amdgpu_bar_mgr vram_mgr;
 	struct amdgpu_gtt_mgr gtt_mgr;
 	struct ttm_resource_manager preempt_mgr;
 
@@ -107,29 +107,29 @@ int amdgpu_gtt_mgr_init(struct amdgpu_device *adev, uint64_t gtt_size);
 void amdgpu_gtt_mgr_fini(struct amdgpu_device *adev);
 int amdgpu_preempt_mgr_init(struct amdgpu_device *adev);
 void amdgpu_preempt_mgr_fini(struct amdgpu_device *adev);
-int amdgpu_vram_mgr_init(struct amdgpu_device *adev);
-void amdgpu_vram_mgr_fini(struct amdgpu_device *adev);
+int amdgpu_bar_mgr_init(struct amdgpu_device *adev, u32 domain);
+void amdgpu_bar_mgr_fini(struct amdgpu_device *adev, u32 domain);
 
 bool amdgpu_gtt_mgr_has_gart_addr(struct ttm_resource *mem);
 void amdgpu_gtt_mgr_recover(struct amdgpu_gtt_mgr *mgr);
 
 uint64_t amdgpu_preempt_mgr_usage(struct ttm_resource_manager *man);
 
-u64 amdgpu_vram_mgr_bo_visible_size(struct amdgpu_bo *bo);
-int amdgpu_vram_mgr_alloc_sgt(struct amdgpu_device *adev,
-			      struct ttm_resource *mem,
-			      u64 offset, u64 size,
-			      struct device *dev,
-			      enum dma_data_direction dir,
-			      struct sg_table **sgt);
-void amdgpu_vram_mgr_free_sgt(struct device *dev,
-			      enum dma_data_direction dir,
-			      struct sg_table *sgt);
-uint64_t amdgpu_vram_mgr_vis_usage(struct amdgpu_vram_mgr *mgr);
-int amdgpu_vram_mgr_reserve_range(struct amdgpu_vram_mgr *mgr,
-				  uint64_t start, uint64_t size);
-int amdgpu_vram_mgr_query_page_status(struct amdgpu_vram_mgr *mgr,
-				      uint64_t start);
+u64 amdgpu_bar_mgr_bo_visible_size(struct amdgpu_bo *bo);
+int amdgpu_bar_mgr_alloc_sgt(struct amdgpu_device *adev,
+			     struct ttm_resource *mem,
+			     u64 offset, u64 size,
+			     struct device *dev,
+			     enum dma_data_direction dir,
+			     struct sg_table **sgt);
+void amdgpu_bar_mgr_free_sgt(struct device *dev,
+			     enum dma_data_direction dir,
+			     struct sg_table *sgt);
+uint64_t amdgpu_bar_mgr_vis_usage(struct amdgpu_bar_mgr *mgr);
+int amdgpu_bar_mgr_reserve_range(struct amdgpu_bar_mgr *mgr,
+				 uint64_t start, uint64_t size);
+int amdgpu_bar_mgr_query_page_status(struct amdgpu_bar_mgr *mgr,
+				     uint64_t start);
 
 int amdgpu_ttm_init(struct amdgpu_device *adev);
 void amdgpu_ttm_fini(struct amdgpu_device *adev);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
index 2994b9db196f..fc9edc3028b6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
@@ -599,7 +599,7 @@ static int amdgpu_virt_write_vf2pf_data(struct amdgpu_device *adev)
 	vf2pf_info->fb_usage =
 		ttm_resource_manager_usage(&adev->mman.vram_mgr.manager) >> 20;
 	vf2pf_info->fb_vis_usage =
-		amdgpu_vram_mgr_vis_usage(&adev->mman.vram_mgr) >> 20;
+		amdgpu_bar_mgr_vis_usage(&adev->mman.vram_mgr) >> 20;
 	vf2pf_info->fb_size = adev->gmc.real_vram_size >> 20;
 	vf2pf_info->fb_vis_size = adev->gmc.visible_vram_size >> 20;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
index 9fa1d814508a..30d68e3a2469 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
@@ -31,46 +31,46 @@
 #include "amdgpu_atomfirmware.h"
 #include "atom.h"
 
-struct amdgpu_vram_reservation {
+struct amdgpu_bar_reservation {
 	u64 start;
 	u64 size;
 	struct list_head allocated;
 	struct list_head blocks;
 };
 
-static inline struct amdgpu_vram_mgr *
-to_vram_mgr(struct ttm_resource_manager *man)
+static inline struct amdgpu_bar_mgr *
+to_bar_mgr(struct ttm_resource_manager *man)
 {
-	return container_of(man, struct amdgpu_vram_mgr, manager);
+	return container_of(man, struct amdgpu_bar_mgr, manager);
 }
 
 static inline struct amdgpu_device *
-to_amdgpu_device(struct amdgpu_vram_mgr *mgr)
+to_amdgpu_device(struct amdgpu_bar_mgr *mgr)
 {
 	return container_of(mgr, struct amdgpu_device, mman.vram_mgr);
 }
 
 static inline struct drm_buddy_block *
-amdgpu_vram_mgr_first_block(struct list_head *list)
+amdgpu_bar_mgr_first_block(struct list_head *list)
 {
 	return list_first_entry_or_null(list, struct drm_buddy_block, link);
 }
 
-static inline bool amdgpu_is_vram_mgr_blocks_contiguous(struct list_head *head)
+static inline bool amdgpu_is_bar_mgr_blocks_contiguous(struct list_head *head)
 {
 	struct drm_buddy_block *block;
 	u64 start, size;
 
-	block = amdgpu_vram_mgr_first_block(head);
+	block = amdgpu_bar_mgr_first_block(head);
 	if (!block)
 		return false;
 
 	while (head != block->link.next) {
-		start = amdgpu_vram_mgr_block_start(block);
-		size = amdgpu_vram_mgr_block_size(block);
+		start = amdgpu_bar_mgr_block_start(block);
+		size = amdgpu_bar_mgr_block_size(block);
 
 		block = list_entry(block->link.next, struct drm_buddy_block, link);
-		if (start + size != amdgpu_vram_mgr_block_start(block))
+		if (start + size != amdgpu_bar_mgr_block_start(block))
 			return false;
 	}
 
@@ -100,7 +100,7 @@ static ssize_t amdgpu_mem_info_vram_total_show(struct device *dev,
  * DOC: mem_info_vis_vram_total
  *
  * The amdgpu driver provides a sysfs API for reporting current total
- * visible VRAM available on the device
+ * visible BAR available on the device
  * The file mem_info_vis_vram_total is used for this and returns the total
  * amount of visible VRAM in bytes
  */
@@ -148,7 +148,7 @@ static ssize_t amdgpu_mem_info_vis_vram_used_show(struct device *dev,
 	struct amdgpu_device *adev = drm_to_adev(ddev);
 
 	return sysfs_emit(buf, "%llu\n",
-			  amdgpu_vram_mgr_vis_usage(&adev->mman.vram_mgr));
+			  amdgpu_bar_mgr_vis_usage(&adev->mman.vram_mgr));
 }
 
 /**
@@ -203,7 +203,7 @@ static DEVICE_ATTR(mem_info_vis_vram_used, S_IRUGO,
 static DEVICE_ATTR(mem_info_vram_vendor, S_IRUGO,
 		   amdgpu_mem_info_vram_vendor, NULL);
 
-static struct attribute *amdgpu_vram_mgr_attributes[] = {
+static struct attribute *amdgpu_bar_mgr_attributes[] = {
 	&dev_attr_mem_info_vram_total.attr,
 	&dev_attr_mem_info_vis_vram_total.attr,
 	&dev_attr_mem_info_vram_used.attr,
@@ -212,23 +212,23 @@ static struct attribute *amdgpu_vram_mgr_attributes[] = {
 	NULL
 };
 
-const struct attribute_group amdgpu_vram_mgr_attr_group = {
-	.attrs = amdgpu_vram_mgr_attributes
+const struct attribute_group amdgpu_bar_mgr_attr_group = {
+	.attrs = amdgpu_bar_mgr_attributes
 };
 
 /**
- * amdgpu_vram_mgr_vis_size - Calculate visible block size
+ * amdgpu_bar_mgr_vis_size - Calculate visible block size
  *
  * @adev: amdgpu_device pointer
  * @block: DRM BUDDY block structure
  *
  * Calculate how many bytes of the DRM BUDDY block are inside visible VRAM
  */
-static u64 amdgpu_vram_mgr_vis_size(struct amdgpu_device *adev,
+static u64 amdgpu_bar_mgr_vis_size(struct amdgpu_device *adev,
 				    struct drm_buddy_block *block)
 {
-	u64 start = amdgpu_vram_mgr_block_start(block);
-	u64 end = start + amdgpu_vram_mgr_block_size(block);
+	u64 start = amdgpu_bar_mgr_block_start(block);
+	u64 end = start + amdgpu_bar_mgr_block_size(block);
 
 	if (start >= adev->gmc.visible_vram_size)
 		return 0;
@@ -238,18 +238,18 @@ static u64 amdgpu_vram_mgr_vis_size(struct amdgpu_device *adev,
 }
 
 /**
- * amdgpu_vram_mgr_bo_visible_size - CPU visible BO size
+ * amdgpu_bar_mgr_bo_visible_size - CPU visible BO size
  *
  * @bo: &amdgpu_bo buffer object (must be in VRAM)
  *
  * Returns:
  * How much of the given &amdgpu_bo buffer object lies in CPU visible VRAM.
  */
-u64 amdgpu_vram_mgr_bo_visible_size(struct amdgpu_bo *bo)
+u64 amdgpu_bar_mgr_bo_visible_size(struct amdgpu_bo *bo)
 {
 	struct amdgpu_device *adev = amdgpu_ttm_adev(bo->tbo.bdev);
 	struct ttm_resource *res = bo->tbo.resource;
-	struct amdgpu_vram_mgr_resource *vres = to_amdgpu_vram_mgr_resource(res);
+	struct amdgpu_bar_mgr_resource *vres = to_amdgpu_bar_mgr_resource(res);
 	struct drm_buddy_block *block;
 	u64 usage = 0;
 
@@ -260,18 +260,18 @@ u64 amdgpu_vram_mgr_bo_visible_size(struct amdgpu_bo *bo)
 		return 0;
 
 	list_for_each_entry(block, &vres->blocks, link)
-		usage += amdgpu_vram_mgr_vis_size(adev, block);
+		usage += amdgpu_bar_mgr_vis_size(adev, block);
 
 	return usage;
 }
 
 /* Commit the reservation of VRAM pages */
-static void amdgpu_vram_mgr_do_reserve(struct ttm_resource_manager *man)
+static void amdgpu_bar_mgr_do_reserve(struct ttm_resource_manager *man)
 {
-	struct amdgpu_vram_mgr *mgr = to_vram_mgr(man);
+	struct amdgpu_bar_mgr *mgr = to_bar_mgr(man);
 	struct amdgpu_device *adev = to_amdgpu_device(mgr);
 	struct drm_buddy *mm = &mgr->mm;
-	struct amdgpu_vram_reservation *rsv, *temp;
+	struct amdgpu_bar_reservation *rsv, *temp;
 	struct drm_buddy_block *block;
 	uint64_t vis_usage;
 
@@ -281,14 +281,14 @@ static void amdgpu_vram_mgr_do_reserve(struct ttm_resource_manager *man)
 					   DRM_BUDDY_RANGE_ALLOCATION))
 			continue;
 
-		block = amdgpu_vram_mgr_first_block(&rsv->allocated);
+		block = amdgpu_bar_mgr_first_block(&rsv->allocated);
 		if (!block)
 			continue;
 
 		dev_dbg(adev->dev, "Reservation 0x%llx - %lld, Succeeded\n",
 			rsv->start, rsv->size);
 
-		vis_usage = amdgpu_vram_mgr_vis_size(adev, block);
+		vis_usage = amdgpu_bar_mgr_vis_size(adev, block);
 		atomic64_add(vis_usage, &mgr->vis_usage);
 		spin_lock(&man->bdev->lru_lock);
 		man->usage += rsv->size;
@@ -298,18 +298,18 @@ static void amdgpu_vram_mgr_do_reserve(struct ttm_resource_manager *man)
 }
 
 /**
- * amdgpu_vram_mgr_reserve_range - Reserve a range from VRAM
+ * amdgpu_bar_mgr_reserve_range - Reserve a range from VRAM
  *
- * @mgr: amdgpu_vram_mgr pointer
+ * @mgr: amdgpu_bar_mgr pointer
  * @start: start address of the range in VRAM
  * @size: size of the range
  *
  * Reserve memory from start address with the specified size in VRAM
  */
-int amdgpu_vram_mgr_reserve_range(struct amdgpu_vram_mgr *mgr,
+int amdgpu_bar_mgr_reserve_range(struct amdgpu_bar_mgr *mgr,
 				  uint64_t start, uint64_t size)
 {
-	struct amdgpu_vram_reservation *rsv;
+	struct amdgpu_bar_reservation *rsv;
 
 	rsv = kzalloc(sizeof(*rsv), GFP_KERNEL);
 	if (!rsv)
@@ -323,16 +323,16 @@ int amdgpu_vram_mgr_reserve_range(struct amdgpu_vram_mgr *mgr,
 
 	mutex_lock(&mgr->lock);
 	list_add_tail(&rsv->blocks, &mgr->reservations_pending);
-	amdgpu_vram_mgr_do_reserve(&mgr->manager);
+	amdgpu_bar_mgr_do_reserve(&mgr->manager);
 	mutex_unlock(&mgr->lock);
 
 	return 0;
 }
 
 /**
- * amdgpu_vram_mgr_query_page_status - query the reservation status
+ * amdgpu_bar_mgr_query_page_status - query the reservation status
  *
- * @mgr: amdgpu_vram_mgr pointer
+ * @mgr: amdgpu_bar_mgr pointer
  * @start: start address of a page in VRAM
  *
  * Returns:
@@ -340,10 +340,10 @@ int amdgpu_vram_mgr_reserve_range(struct amdgpu_vram_mgr *mgr,
  *	0: the page has been reserved
  *	-ENOENT: the input page is not a reservation
  */
-int amdgpu_vram_mgr_query_page_status(struct amdgpu_vram_mgr *mgr,
+int amdgpu_bar_mgr_query_page_status(struct amdgpu_bar_mgr *mgr,
 				      uint64_t start)
 {
-	struct amdgpu_vram_reservation *rsv;
+	struct amdgpu_bar_reservation *rsv;
 	int ret;
 
 	mutex_lock(&mgr->lock);
@@ -371,7 +371,7 @@ int amdgpu_vram_mgr_query_page_status(struct amdgpu_vram_mgr *mgr,
 }
 
 /**
- * amdgpu_vram_mgr_new - allocate new ranges
+ * amdgpu_bar_mgr_new - allocate new ranges
  *
  * @man: TTM memory type manager
  * @tbo: TTM BO we need this range for
@@ -380,15 +380,15 @@ int amdgpu_vram_mgr_query_page_status(struct amdgpu_vram_mgr *mgr,
  *
  * Allocate VRAM for the given BO.
  */
-static int amdgpu_vram_mgr_new(struct ttm_resource_manager *man,
+static int amdgpu_bar_mgr_new(struct ttm_resource_manager *man,
 			       struct ttm_buffer_object *tbo,
 			       const struct ttm_place *place,
 			       struct ttm_resource **res)
 {
 	u64 vis_usage = 0, max_bytes, cur_size, min_block_size;
-	struct amdgpu_vram_mgr *mgr = to_vram_mgr(man);
+	struct amdgpu_bar_mgr *mgr = to_bar_mgr(man);
 	struct amdgpu_device *adev = to_amdgpu_device(mgr);
-	struct amdgpu_vram_mgr_resource *vres;
+	struct amdgpu_bar_mgr_resource *vres;
 	u64 size, remaining_size, lpfn, fpfn;
 	struct drm_buddy *mm = &mgr->mm;
 	struct drm_buddy_block *block;
@@ -512,7 +512,7 @@ static int amdgpu_vram_mgr_new(struct ttm_resource_manager *man,
 			 * Compute the original_size value by subtracting the
 			 * last block size with (aligned size - original size)
 			 */
-			original_size = amdgpu_vram_mgr_block_size(block) - (size - cur_size);
+			original_size = amdgpu_bar_mgr_block_size(block) - (size - cur_size);
 		}
 
 		mutex_lock(&mgr->lock);
@@ -529,8 +529,8 @@ static int amdgpu_vram_mgr_new(struct ttm_resource_manager *man,
 	list_for_each_entry(block, &vres->blocks, link) {
 		unsigned long start;
 
-		start = amdgpu_vram_mgr_block_start(block) +
-			amdgpu_vram_mgr_block_size(block);
+		start = amdgpu_bar_mgr_block_start(block) +
+			amdgpu_bar_mgr_block_size(block);
 		start >>= PAGE_SHIFT;
 
 		if (start > PFN_UP(vres->base.size))
@@ -539,10 +539,10 @@ static int amdgpu_vram_mgr_new(struct ttm_resource_manager *man,
 			start = 0;
 		vres->base.start = max(vres->base.start, start);
 
-		vis_usage += amdgpu_vram_mgr_vis_size(adev, block);
+		vis_usage += amdgpu_bar_mgr_vis_size(adev, block);
 	}
 
-	if (amdgpu_is_vram_mgr_blocks_contiguous(&vres->blocks))
+	if (amdgpu_is_bar_mgr_blocks_contiguous(&vres->blocks))
 		vres->base.placement |= TTM_PL_FLAG_CONTIGUOUS;
 
 	if (adev->gmc.xgmi.connected_to_cpu)
@@ -565,18 +565,18 @@ static int amdgpu_vram_mgr_new(struct ttm_resource_manager *man,
 }
 
 /**
- * amdgpu_vram_mgr_del - free ranges
+ * amdgpu_bar_mgr_del - free ranges
  *
  * @man: TTM memory type manager
  * @res: TTM memory object
  *
  * Free the allocated VRAM again.
  */
-static void amdgpu_vram_mgr_del(struct ttm_resource_manager *man,
+static void amdgpu_bar_mgr_del(struct ttm_resource_manager *man,
 				struct ttm_resource *res)
 {
-	struct amdgpu_vram_mgr_resource *vres = to_amdgpu_vram_mgr_resource(res);
-	struct amdgpu_vram_mgr *mgr = to_vram_mgr(man);
+	struct amdgpu_bar_mgr_resource *vres = to_amdgpu_bar_mgr_resource(res);
+	struct amdgpu_bar_mgr *mgr = to_bar_mgr(man);
 	struct amdgpu_device *adev = to_amdgpu_device(mgr);
 	struct drm_buddy *mm = &mgr->mm;
 	struct drm_buddy_block *block;
@@ -584,9 +584,9 @@ static void amdgpu_vram_mgr_del(struct ttm_resource_manager *man,
 
 	mutex_lock(&mgr->lock);
 	list_for_each_entry(block, &vres->blocks, link)
-		vis_usage += amdgpu_vram_mgr_vis_size(adev, block);
+		vis_usage += amdgpu_bar_mgr_vis_size(adev, block);
 
-	amdgpu_vram_mgr_do_reserve(man);
+	amdgpu_bar_mgr_do_reserve(man);
 
 	drm_buddy_free_list(mm, &vres->blocks);
 	mutex_unlock(&mgr->lock);
@@ -598,7 +598,7 @@ static void amdgpu_vram_mgr_del(struct ttm_resource_manager *man,
 }
 
 /**
- * amdgpu_vram_mgr_alloc_sgt - allocate and fill a sg table
+ * amdgpu_bar_mgr_alloc_sgt - allocate and fill a sg table
  *
  * @adev: amdgpu device pointer
  * @res: TTM memory object
@@ -610,7 +610,7 @@ static void amdgpu_vram_mgr_del(struct ttm_resource_manager *man,
  *
  * Allocate and fill a sg table from a VRAM allocation.
  */
-int amdgpu_vram_mgr_alloc_sgt(struct amdgpu_device *adev,
+int amdgpu_bar_mgr_alloc_sgt(struct amdgpu_device *adev,
 			      struct ttm_resource *res,
 			      u64 offset, u64 length,
 			      struct device *dev,
@@ -685,7 +685,7 @@ int amdgpu_vram_mgr_alloc_sgt(struct amdgpu_device *adev,
 }
 
 /**
- * amdgpu_vram_mgr_free_sgt - allocate and fill a sg table
+ * amdgpu_bar_mgr_free_sgt - allocate and fill a sg table
  *
  * @dev: device pointer
  * @dir: data direction of resource to unmap
@@ -693,7 +693,7 @@ int amdgpu_vram_mgr_alloc_sgt(struct amdgpu_device *adev,
  *
  * Free a previously allocate sg table.
  */
-void amdgpu_vram_mgr_free_sgt(struct device *dev,
+void amdgpu_bar_mgr_free_sgt(struct device *dev,
 			      enum dma_data_direction dir,
 			      struct sg_table *sgt)
 {
@@ -709,19 +709,19 @@ void amdgpu_vram_mgr_free_sgt(struct device *dev,
 }
 
 /**
- * amdgpu_vram_mgr_vis_usage - how many bytes are used in the visible part
+ * amdgpu_bar_mgr_vis_usage - how many bytes are used in the visible part
  *
- * @mgr: amdgpu_vram_mgr pointer
+ * @mgr: amdgpu_bar_mgr pointer
  *
  * Returns how many bytes are used in the visible part of VRAM
  */
-uint64_t amdgpu_vram_mgr_vis_usage(struct amdgpu_vram_mgr *mgr)
+uint64_t amdgpu_bar_mgr_vis_usage(struct amdgpu_bar_mgr *mgr)
 {
 	return atomic64_read(&mgr->vis_usage);
 }
 
 /**
- * amdgpu_vram_mgr_intersects - test each drm buddy block for intersection
+ * amdgpu_bar_mgr_intersects - test each drm buddy block for intersection
  *
  * @man: TTM memory type manager
  * @res: The resource to test
@@ -730,20 +730,20 @@ uint64_t amdgpu_vram_mgr_vis_usage(struct amdgpu_vram_mgr *mgr)
  *
  * Test each drm buddy block for intersection for eviction decision.
  */
-static bool amdgpu_vram_mgr_intersects(struct ttm_resource_manager *man,
+static bool amdgpu_bar_mgr_intersects(struct ttm_resource_manager *man,
 				       struct ttm_resource *res,
 				       const struct ttm_place *place,
 				       size_t size)
 {
-	struct amdgpu_vram_mgr_resource *mgr = to_amdgpu_vram_mgr_resource(res);
+	struct amdgpu_bar_mgr_resource *mgr = to_amdgpu_bar_mgr_resource(res);
 	struct drm_buddy_block *block;
 
 	/* Check each drm buddy block individually */
 	list_for_each_entry(block, &mgr->blocks, link) {
 		unsigned long fpfn =
-			amdgpu_vram_mgr_block_start(block) >> PAGE_SHIFT;
+			amdgpu_bar_mgr_block_start(block) >> PAGE_SHIFT;
 		unsigned long lpfn = fpfn +
-			(amdgpu_vram_mgr_block_size(block) >> PAGE_SHIFT);
+			(amdgpu_bar_mgr_block_size(block) >> PAGE_SHIFT);
 
 		if (place->fpfn < lpfn &&
 		    (!place->lpfn || place->lpfn > fpfn))
@@ -754,7 +754,7 @@ static bool amdgpu_vram_mgr_intersects(struct ttm_resource_manager *man,
 }
 
 /**
- * amdgpu_vram_mgr_compatible - test each drm buddy block for compatibility
+ * amdgpu_bar_mgr_compatible - test each drm buddy block for compatibility
  *
  * @man: TTM memory type manager
  * @res: The resource to test
@@ -763,20 +763,20 @@ static bool amdgpu_vram_mgr_intersects(struct ttm_resource_manager *man,
  *
  * Test each drm buddy block for placement compatibility.
  */
-static bool amdgpu_vram_mgr_compatible(struct ttm_resource_manager *man,
+static bool amdgpu_bar_mgr_compatible(struct ttm_resource_manager *man,
 				       struct ttm_resource *res,
 				       const struct ttm_place *place,
 				       size_t size)
 {
-	struct amdgpu_vram_mgr_resource *mgr = to_amdgpu_vram_mgr_resource(res);
+	struct amdgpu_bar_mgr_resource *mgr = to_amdgpu_bar_mgr_resource(res);
 	struct drm_buddy_block *block;
 
 	/* Check each drm buddy block individually */
 	list_for_each_entry(block, &mgr->blocks, link) {
 		unsigned long fpfn =
-			amdgpu_vram_mgr_block_start(block) >> PAGE_SHIFT;
+			amdgpu_bar_mgr_block_start(block) >> PAGE_SHIFT;
 		unsigned long lpfn = fpfn +
-			(amdgpu_vram_mgr_block_size(block) >> PAGE_SHIFT);
+			(amdgpu_bar_mgr_block_size(block) >> PAGE_SHIFT);
 
 		if (fpfn < place->fpfn ||
 		    (place->lpfn && lpfn > place->lpfn))
@@ -787,22 +787,22 @@ static bool amdgpu_vram_mgr_compatible(struct ttm_resource_manager *man,
 }
 
 /**
- * amdgpu_vram_mgr_debug - dump VRAM table
+ * amdgpu_bar_mgr_debug - dump VRAM table
  *
  * @man: TTM memory type manager
  * @printer: DRM printer to use
  *
  * Dump the table content using printk.
  */
-static void amdgpu_vram_mgr_debug(struct ttm_resource_manager *man,
+static void amdgpu_bar_mgr_debug(struct ttm_resource_manager *man,
 				  struct drm_printer *printer)
 {
-	struct amdgpu_vram_mgr *mgr = to_vram_mgr(man);
+	struct amdgpu_bar_mgr *mgr = to_bar_mgr(man);
 	struct drm_buddy *mm = &mgr->mm;
 	struct drm_buddy_block *block;
 
 	drm_printf(printer, "  vis usage:%llu\n",
-		   amdgpu_vram_mgr_vis_usage(mgr));
+		   amdgpu_bar_mgr_vis_usage(mgr));
 
 	mutex_lock(&mgr->lock);
 	drm_printf(printer, "default_page_size: %lluKiB\n",
@@ -816,31 +816,38 @@ static void amdgpu_vram_mgr_debug(struct ttm_resource_manager *man,
 	mutex_unlock(&mgr->lock);
 }
 
-static const struct ttm_resource_manager_func amdgpu_vram_mgr_func = {
-	.alloc	= amdgpu_vram_mgr_new,
-	.free	= amdgpu_vram_mgr_del,
-	.intersects = amdgpu_vram_mgr_intersects,
-	.compatible = amdgpu_vram_mgr_compatible,
-	.debug	= amdgpu_vram_mgr_debug
+static const struct ttm_resource_manager_func amdgpu_bar_mgr_func = {
+	.alloc	= amdgpu_bar_mgr_new,
+	.free	= amdgpu_bar_mgr_del,
+	.intersects = amdgpu_bar_mgr_intersects,
+	.compatible = amdgpu_bar_mgr_compatible,
+	.debug	= amdgpu_bar_mgr_debug
 };
 
 /**
- * amdgpu_vram_mgr_init - init VRAM manager and DRM MM
+ * amdgpu_bar_mgr_init - init BAR manager and DRM MM
  *
  * @adev: amdgpu_device pointer
+ * @domain: memory domain to initialize
  *
  * Allocate and initialize the VRAM manager.
  */
-int amdgpu_vram_mgr_init(struct amdgpu_device *adev)
+int amdgpu_bar_mgr_init(struct amdgpu_device *adev, u32 domain)
 {
-	struct amdgpu_vram_mgr *mgr = &adev->mman.vram_mgr;
-	struct ttm_resource_manager *man = &mgr->manager;
+	struct amdgpu_bar_mgr *mgr;
+	struct ttm_resource_manager *man;
 	int err;
 
+	if (domain != TTM_PL_VRAM)
+		return -EINVAL;
+
+	mgr = &adev->mman.vram_mgr;
+	man = &mgr->manager;
+
 	ttm_resource_manager_init(man, &adev->mman.bdev,
 				  adev->gmc.real_vram_size);
 
-	man->func = &amdgpu_vram_mgr_func;
+	man->func = &amdgpu_bar_mgr_func;
 
 	err = drm_buddy_init(&mgr->mm, man->size, PAGE_SIZE);
 	if (err)
@@ -851,25 +858,32 @@ int amdgpu_vram_mgr_init(struct amdgpu_device *adev)
 	INIT_LIST_HEAD(&mgr->reserved_pages);
 	mgr->default_page_size = PAGE_SIZE;
 
-	ttm_set_driver_manager(&adev->mman.bdev, TTM_PL_VRAM, &mgr->manager);
+	ttm_set_driver_manager(&adev->mman.bdev, domain, &mgr->manager);
 	ttm_resource_manager_set_used(man, true);
 	return 0;
 }
 
 /**
- * amdgpu_vram_mgr_fini - free and destroy VRAM manager
+ * amdgpu_bar_mgr_fini - free and destroy VRAM manager
  *
  * @adev: amdgpu_device pointer
+ * @domain: memory domain to destroy
  *
- * Destroy and free the VRAM manager, returns -EBUSY if ranges are still
+ * Destroy and free the BAR manager, returns -EBUSY if ranges are still
  * allocated inside it.
  */
-void amdgpu_vram_mgr_fini(struct amdgpu_device *adev)
+void amdgpu_bar_mgr_fini(struct amdgpu_device *adev, u32 domain)
 {
-	struct amdgpu_vram_mgr *mgr = &adev->mman.vram_mgr;
-	struct ttm_resource_manager *man = &mgr->manager;
+	struct amdgpu_bar_mgr *mgr;
+	struct ttm_resource_manager *man;
 	int ret;
-	struct amdgpu_vram_reservation *rsv, *temp;
+	struct amdgpu_bar_reservation *rsv, *temp;
+
+	if (domain != TTM_PL_VRAM)
+		return;
+
+	mgr = &adev->mman.vram_mgr;
+	man = &mgr->manager;
 
 	ttm_resource_manager_set_used(man, false);
 
@@ -889,5 +903,5 @@ void amdgpu_vram_mgr_fini(struct amdgpu_device *adev)
 	mutex_unlock(&mgr->lock);
 
 	ttm_resource_manager_cleanup(man);
-	ttm_set_driver_manager(&adev->mman.bdev, TTM_PL_VRAM, NULL);
+	ttm_set_driver_manager(&adev->mman.bdev, domain, NULL);
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.h
index 0e04e42cf809..241faba5ae55 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.h
@@ -21,12 +21,12 @@
  *
  */
 
-#ifndef __AMDGPU_VRAM_MGR_H__
-#define __AMDGPU_VRAM_MGR_H__
+#ifndef __AMDGPU_BAR_MGR_H__
+#define __AMDGPU_BAR_MGR_H__
 
 #include <drm/drm_buddy.h>
 
-struct amdgpu_vram_mgr {
+struct amdgpu_bar_mgr {
 	struct ttm_resource_manager manager;
 	struct drm_buddy mm;
 	/* protects access to buffer objects */
@@ -37,26 +37,26 @@ struct amdgpu_vram_mgr {
 	u64 default_page_size;
 };
 
-struct amdgpu_vram_mgr_resource {
+struct amdgpu_bar_mgr_resource {
 	struct ttm_resource base;
 	struct list_head blocks;
 	unsigned long flags;
 };
 
-static inline u64 amdgpu_vram_mgr_block_start(struct drm_buddy_block *block)
+static inline u64 amdgpu_bar_mgr_block_start(struct drm_buddy_block *block)
 {
 	return drm_buddy_block_offset(block);
 }
 
-static inline u64 amdgpu_vram_mgr_block_size(struct drm_buddy_block *block)
+static inline u64 amdgpu_bar_mgr_block_size(struct drm_buddy_block *block)
 {
 	return (u64)PAGE_SIZE << drm_buddy_block_order(block);
 }
 
-static inline struct amdgpu_vram_mgr_resource *
-to_amdgpu_vram_mgr_resource(struct ttm_resource *res)
+static inline struct amdgpu_bar_mgr_resource *
+to_amdgpu_bar_mgr_resource(struct ttm_resource *res)
 {
-	return container_of(res, struct amdgpu_vram_mgr_resource, base);
+	return container_of(res, struct amdgpu_bar_mgr_resource, base);
 }
 
 #endif
-- 
2.34.1

