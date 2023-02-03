Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83DC6C6379F
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Feb 2023 19:09:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 17A3910E8A5;
	Fri,  3 Feb 2023 19:09:33 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2063.outbound.protection.outlook.com [40.107.237.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 791FE10E8A8
 for <amd-gfx@lists.freedesktop.org>; Fri,  3 Feb 2023 19:09:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N9X9lxilKqSiA5zz58EDztIaSIczMQ1ESO4JRYGntrJZZyYI9rXTjbVNGXLemzrCkumN6/pPOao41zTYSTorxggqz7RaR/A9V0yaDEpevHMUZQ7SF93eC/kMnBDPigXdi+5sRZq8kSjOk0QEY0r7svd2AdZ5VLjC97Y7xltku9zbm+V4U25aOaYvOtJ7DF+gBLFH32Y0nB+N9w1f81hotxmqI+orIY6Ri4lYOvhOm0nGf2CryEM+i5SHonfZZaZxmu+TMxRKMmsfEWjHwc0pc/eDrz0oZt52tMdXgiybxZV25e0h871SW76kr67dqjsXKfcZRAMix/bhTOosPCeFPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rV6tD/0806LKm8Et/wehHUadTSlGW2TVtsFYUetVZ2k=;
 b=gNfkEJIwbqaWcH2yHdnANn2zhEdrsdZKTYAOQaxfzltNHWccjwbqpR1wJvKbp1Ul+fn25PcKymWDpLJu9KxSTBVeG5odnYFfi3S6Th2E26Wq2S09K12nmxOS4biDilrSf9hI77MWDvIEM5MkCchq7P97HpRl6YDItcdhlo8r16adx7BOhuZbjMuXh9P5wi1H3JA7dThcTFMNYgmDsZeM3w4cVWx1ku6aVZ4KKd2fW4T91biZO8IwkFd0D2WYUUAFO5vGhXoKuNI6wtbPViVihbnC/MyxvtzFOFN8E5L25tbQAJpEuF/joo+2JKv9Ug3Trk1TcEY6e7GqlQpHVALcYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rV6tD/0806LKm8Et/wehHUadTSlGW2TVtsFYUetVZ2k=;
 b=O60kqiW1SWA/mKj5gQTkGGFFlvm6cJITraQE7gFD0NJG1qAPPI6JeS2U56cVXL33lGvqVFZGKLi8+cBYpKbLispjDSxudvhgBoBrbYKFPWpT4Hic2bDAtflbI1XLeZP2mWDxJjyEbXkn1R0dGqjf5fBImU9c1w/EvwUoeckvno4=
Received: from DM6PR08CA0003.namprd08.prod.outlook.com (2603:10b6:5:80::16) by
 PH8PR12MB7374.namprd12.prod.outlook.com (2603:10b6:510:216::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.29; Fri, 3 Feb
 2023 19:09:28 +0000
Received: from CY4PEPF0000B8EE.namprd05.prod.outlook.com
 (2603:10b6:5:80:cafe::fd) by DM6PR08CA0003.outlook.office365.com
 (2603:10b6:5:80::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.31 via Frontend
 Transport; Fri, 3 Feb 2023 19:09:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000B8EE.mail.protection.outlook.com (10.167.241.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6086.4 via Frontend Transport; Fri, 3 Feb 2023 19:09:27 +0000
Received: from MUN-L-SHSHARMA.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 3 Feb
 2023 13:09:26 -0600
From: Shashank Sharma <shashank.sharma@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 10/14] drm/amdgpu: accommodate DOMAIN/PL_DOORBELL
Date: Fri, 3 Feb 2023 20:08:28 +0100
Message-ID: <20230203190836.1987-12-shashank.sharma@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000B8EE:EE_|PH8PR12MB7374:EE_
X-MS-Office365-Filtering-Correlation-Id: 8db68eeb-0d86-4e8c-615c-08db061a2bfc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: R/OG9m8GTVx2kjK/TzBa/lYmnmRSRsKqH1eeIesKuJnOoGm1T3Rqj58LqlHjx5fD2yBgaoJBZybFO2V2V2nn5DxvIE9u9v6oeQ9+wigfEsQWtSg/kQOqBS3bN9XiMycKtjt3tCwjGzvVOEng77kC0aQ2q7zSzPe84UfXYLu0g1DvMKGiWYy/CfXBg3NLkWR1T72U3GmskvjGpWber1L7LOofIYrcuONJZhu0eD4SKT7SZfxldlBQTyeN1co/ekz0HaZ+tx2H0GLEPJlN2hU/97f95DwQeLo+cTFMssWlsRJDQH3NWT36/5fJ8aYOFroXHiRKOt+IyEdYiK0K4hxBqunaSMvFuWLJaiSpA18+n+vIgUJ52BiWyUpulc4oEjvWkIT2JQtdEEpFPLqnWP28J8jr+YFql8jSjZZsX3M1AkvM4fi0Qc8XRiLaJ2omo9QncGxzY5s4Ce+I27hXD4PmQj+JiucruJGMtDrEhVggghP2fwkJvctAXi5q17Noqmd9OjxLmVO2I/a558mSTZqsRn4DDhogE08Gp1xPh9dimJvl1kENVgTDT97cRuq24igBBKogmb8zfW3l1+pQmKZ7iN484I/PahtqqkOVDYrzMHgQQg8VjPe4dVCvJbBpYB9ShVBcngjtYzfRDt/x2oHLVH54zu395ofc4iDG7d+J6DYgo4ofeZHG4wIoZCaJ2dhDM6Cf3LjmBBHyt+zutdGPs/ordNhaLqivyufGHIUIQ20=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(376002)(346002)(396003)(39860400002)(136003)(451199018)(46966006)(36840700001)(40470700004)(5660300002)(186003)(16526019)(44832011)(86362001)(81166007)(83380400001)(40460700003)(47076005)(82740400003)(426003)(36860700001)(40480700001)(36756003)(82310400005)(356005)(2906002)(26005)(336012)(2616005)(478600001)(8676002)(6916009)(70586007)(70206006)(4326008)(7696005)(54906003)(316002)(1076003)(8936002)(41300700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2023 19:09:27.8996 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8db68eeb-0d86-4e8c-615c-08db061a2bfc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000B8EE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7374
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

This patch adds changes to accommodate the new GEM/TTM domain
for doorbell memory.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h         |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_bar_mgr.c | 19 ++++++++++------
 drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c |  3 ++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c  | 24 ++++++++++++++++++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.h  |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c     | 17 ++++++++++++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h     |  3 ++-
 7 files changed, 58 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index e3e2e6e3b485..e1c1a360614e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -974,6 +974,7 @@ struct amdgpu_device {
 	atomic64_t vram_pin_size;
 	atomic64_t visible_pin_size;
 	atomic64_t gart_pin_size;
+	atomic64_t doorbell_pin_size;
 
 	/* soc15 register offset based on ip, instance and  segment */
 	uint32_t		*reg_offset[MAX_HWIP][HWIP_MAX_INSTANCE];
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_bar_mgr.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_bar_mgr.c
index 5c8d63dec0ba..a3b4ee760542 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_bar_mgr.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_bar_mgr.c
@@ -659,15 +659,17 @@ static void amdgpu_bar_mgr_del(struct ttm_resource_manager *man,
  * @dev: the other device
  * @dir: dma direction
  * @sgt: resulting sg table
+ * @mem_type: memory type
  *
  * Allocate and fill a sg table from a VRAM allocation.
  */
 int amdgpu_bar_mgr_alloc_sgt(struct amdgpu_device *adev,
-			      struct ttm_resource *res,
-			      u64 offset, u64 length,
-			      struct device *dev,
-			      enum dma_data_direction dir,
-			      struct sg_table **sgt)
+			     struct ttm_resource *res,
+			     u64 offset, u64 length,
+			     struct device *dev,
+			     enum dma_data_direction dir,
+			     struct sg_table **sgt,
+			     u32 mem_type)
 {
 	struct amdgpu_res_cursor cursor;
 	struct scatterlist *sg;
@@ -701,10 +703,15 @@ int amdgpu_bar_mgr_alloc_sgt(struct amdgpu_device *adev,
 	 */
 	amdgpu_res_first(res, offset, length, &cursor);
 	for_each_sgtable_sg((*sgt), sg, i) {
-		phys_addr_t phys = cursor.start + adev->gmc.vram_aper_base;
+		phys_addr_t phys = cursor.start;
 		size_t size = cursor.size;
 		dma_addr_t addr;
 
+		if (mem_type == TTM_PL_VRAM)
+			phys += adev->gmc.vram_aper_base;
+		else
+			phys += adev->gmc.doorbell_aper_base;
+
 		addr = dma_map_resource(dev, phys, size, dir,
 					DMA_ATTR_SKIP_CPU_SYNC);
 		r = dma_mapping_error(dev, addr);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
index c48ccde281c3..c645bdc49f34 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
@@ -179,9 +179,10 @@ static struct sg_table *amdgpu_dma_buf_map(struct dma_buf_attachment *attach,
 		break;
 
 	case TTM_PL_VRAM:
+	case AMDGPU_PL_DOORBELL:
 		r = amdgpu_bar_mgr_alloc_sgt(adev, bo->tbo.resource, 0,
 					     bo->tbo.base.size, attach->dev,
-					     dir, &sgt);
+					     dir, &sgt, bo->tbo.resource->mem_type);
 		if (r)
 			return ERR_PTR(r);
 		break;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
index a6876de964b6..ab32dfe68c5f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
@@ -147,6 +147,18 @@ void amdgpu_bo_placement_from_domain(struct amdgpu_bo *abo, u32 domain)
 		c++;
 	}
 
+	if (domain & AMDGPU_GEM_DOMAIN_DOORBELL) {
+		places[c].fpfn = 0;
+		places[c].lpfn = 0;
+		places[c].mem_type = AMDGPU_PL_DOORBELL;
+		places[c].flags = 0;
+		places[c].flags |= TTM_PL_FLAG_TOPDOWN;
+
+		if (flags & AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS)
+			places[c].flags |= TTM_PL_FLAG_CONTIGUOUS;
+		c++;
+	}
+
 	if (domain & AMDGPU_GEM_DOMAIN_GTT) {
 		places[c].fpfn = 0;
 		places[c].lpfn = 0;
@@ -464,6 +476,13 @@ static bool amdgpu_bo_validate_size(struct amdgpu_device *adev,
 		if (man && size < man->size)
 			return true;
 		goto fail;
+	} else if (domain & AMDGPU_GEM_DOMAIN_DOORBELL) {
+		man = ttm_manager_type(&adev->mman.bdev, AMDGPU_PL_DOORBELL);
+
+		if (size < man->size)
+			return true;
+		else
+			goto fail;
 	}
 
 	/* TODO add more domains checks, such as AMDGPU_GEM_DOMAIN_CPU */
@@ -961,8 +980,9 @@ int amdgpu_bo_pin_restricted(struct amdgpu_bo *bo, u32 domain,
 			     &adev->visible_pin_size);
 	} else if (domain == AMDGPU_GEM_DOMAIN_GTT) {
 		atomic64_add(amdgpu_bo_size(bo), &adev->gart_pin_size);
+	} else if (domain == AMDGPU_GEM_DOMAIN_DOORBELL) {
+		atomic64_add(amdgpu_bo_size(bo), &adev->doorbell_pin_size);
 	}
-
 error:
 	return r;
 }
@@ -1012,6 +1032,8 @@ void amdgpu_bo_unpin(struct amdgpu_bo *bo)
 			     &adev->visible_pin_size);
 	} else if (bo->tbo.resource->mem_type == TTM_PL_TT) {
 		atomic64_sub(amdgpu_bo_size(bo), &adev->gart_pin_size);
+	} else if (bo->tbo.resource->mem_type == AMDGPU_PL_DOORBELL) {
+		atomic64_sub(amdgpu_bo_size(bo), &adev->doorbell_pin_size);
 	}
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
index 93207badf83f..082f451d26f4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
@@ -326,7 +326,7 @@ int amdgpu_bo_sync_wait(struct amdgpu_bo *bo, void *owner, bool intr);
 u64 amdgpu_bo_gpu_offset(struct amdgpu_bo *bo);
 u64 amdgpu_bo_gpu_offset_no_check(struct amdgpu_bo *bo);
 void amdgpu_bo_get_memory(struct amdgpu_bo *bo, uint64_t *vram_mem,
-				uint64_t *gtt_mem, uint64_t *cpu_mem);
+			  uint64_t *gtt_mem, uint64_t *cpu_mem);
 void amdgpu_bo_add_to_shadow_list(struct amdgpu_bo_vm *vmbo);
 int amdgpu_bo_restore_shadow(struct amdgpu_bo *shadow,
 			     struct dma_fence **fence);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index 983826ae7509..e04409210415 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -128,6 +128,7 @@ static void amdgpu_evict_flags(struct ttm_buffer_object *bo,
 	case AMDGPU_PL_GDS:
 	case AMDGPU_PL_GWS:
 	case AMDGPU_PL_OA:
+	case AMDGPU_PL_DOORBELL:
 		placement->num_placement = 0;
 		placement->num_busy_placement = 0;
 		return;
@@ -500,9 +501,11 @@ static int amdgpu_bo_move(struct ttm_buffer_object *bo, bool evict,
 	if (old_mem->mem_type == AMDGPU_PL_GDS ||
 	    old_mem->mem_type == AMDGPU_PL_GWS ||
 	    old_mem->mem_type == AMDGPU_PL_OA ||
+	    old_mem->mem_type == AMDGPU_PL_DOORBELL ||
 	    new_mem->mem_type == AMDGPU_PL_GDS ||
 	    new_mem->mem_type == AMDGPU_PL_GWS ||
-	    new_mem->mem_type == AMDGPU_PL_OA) {
+	    new_mem->mem_type == AMDGPU_PL_OA ||
+	    new_mem->mem_type == AMDGPU_PL_DOORBELL) {
 		/* Nothing to save here */
 		ttm_bo_move_null(bo, new_mem);
 		goto out;
@@ -586,6 +589,17 @@ static int amdgpu_ttm_io_mem_reserve(struct ttm_device *bdev,
 		mem->bus.offset += adev->gmc.vram_aper_base;
 		mem->bus.is_iomem = true;
 		break;
+	case AMDGPU_PL_DOORBELL:
+		mem->bus.offset = mem->start << PAGE_SHIFT;
+
+		if (adev->mman.doorbell_aper_base_kaddr &&
+		    mem->placement & TTM_PL_FLAG_CONTIGUOUS)
+			mem->bus.addr = (u8 *)adev->mman.doorbell_aper_base_kaddr +
+					mem->bus.offset;
+
+		mem->bus.offset += adev->gmc.doorbell_aper_base;
+		mem->bus.is_iomem = true;
+		break;
 	default:
 		return -EINVAL;
 	}
@@ -1267,6 +1281,7 @@ uint64_t amdgpu_ttm_tt_pde_flags(struct ttm_tt *ttm, struct ttm_resource *mem)
 		flags |= AMDGPU_PTE_VALID;
 
 	if (mem && (mem->mem_type == TTM_PL_TT ||
+		    mem->mem_type == AMDGPU_PL_DOORBELL ||
 		    mem->mem_type == AMDGPU_PL_PREEMPT)) {
 		flags |= AMDGPU_PTE_SYSTEM;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
index 9d147740a643..a492de079c2e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
@@ -124,7 +124,8 @@ int amdgpu_bar_mgr_alloc_sgt(struct amdgpu_device *adev,
 			     u64 offset, u64 size,
 			     struct device *dev,
 			     enum dma_data_direction dir,
-			     struct sg_table **sgt);
+			     struct sg_table **sgt,
+			     u32 mem_type);
 void amdgpu_bar_mgr_free_sgt(struct device *dev,
 			     enum dma_data_direction dir,
 			     struct sg_table *sgt);
-- 
2.34.1

