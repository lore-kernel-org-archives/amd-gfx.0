Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A84F0C64EC7
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Feb 2023 19:09:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 29A1010E89E;
	Fri,  3 Feb 2023 19:09:29 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2065.outbound.protection.outlook.com [40.107.220.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1DB4010E89E
 for <amd-gfx@lists.freedesktop.org>; Fri,  3 Feb 2023 19:09:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bkFffNwVCZmqI34gg+d2dJO9h2gSyEYQJjpuddSKCOiGlKNlwVc4PXbgeVXNp1qK9UGVR25SUHYYME0cgf9k7Omk0xblQPTJfcMieJh87O+YCSnP78OaUVhvhPY1EM8LRz0exJQYlLhecJ22h/jSQ2tlox1BrZgKQzNm+c9N7DtEzcDzK7MSKTHY49sZ6N9/DFOR/Upp//1zv0uhDeg+FJW0uyS1H1BKlA7E8T7nvMGakgfCMT4EzcoedR7lC0pSZV5sXCWcLD9/gh9TgSHyLI8mBhcTFm3sH4+cC+JAdS9Ma61km9BrYF5j7q9c9grzOq+clQwiLM5+KyQYycDm9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JFFb8QZbBykmifM2y3l6RVSU7W+7mi7wpczSaqmOoW8=;
 b=WT9JJ19Fkj+SeO1/l/gPhEr/2sQusqUr0JbcBj735/rWWrmvuhMidZ1Bz1uSHWJFfY5N4+IksXarOwA+wxfETdegCYlmawW894gBK2zvE0mDX0XGuDzkUW/MxDC8IbcJDIYqhaLwtPvdnQ6hxkKYNdSifUfTKloQPpnRMjttOtSnf+dFFEp4txUAaCiAjeSdGEaA9xuqzMA1MpspWRrnxkraaF9RFIF02H/+wXy1VgDwpLTiABFgqo6tGDA8E2l1BoMQ2Chx1ftH2jNXCrawbQeIavbxOSWv68dB2hPm1AkASp8i7Tk7HkBHq74jf15dv2DEB0x6GjvKzrzS5AURkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JFFb8QZbBykmifM2y3l6RVSU7W+7mi7wpczSaqmOoW8=;
 b=CZTODh9Uf0Su3agYJokPchbXyS4r0scZMetyD8O3nOkA39gYMTmYfc896sTGXmcyTaVRCQfY48j7a+A82CRe+maa7g4xgFSpHlLAtHFvC9ovxfqJuyOP/QUQE85m8EGxVttDht7cZWvBsLaywd7SOsUXOLks9mY9REdVhmsGEQI=
Received: from CY5PR15CA0238.namprd15.prod.outlook.com (2603:10b6:930:66::9)
 by CY8PR12MB8196.namprd12.prod.outlook.com (2603:10b6:930:78::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.24; Fri, 3 Feb
 2023 19:09:25 +0000
Received: from CY4PEPF0000B8EC.namprd05.prod.outlook.com
 (2603:10b6:930:66:cafe::74) by CY5PR15CA0238.outlook.office365.com
 (2603:10b6:930:66::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.31 via Frontend
 Transport; Fri, 3 Feb 2023 19:09:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000B8EC.mail.protection.outlook.com (10.167.241.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6086.4 via Frontend Transport; Fri, 3 Feb 2023 19:09:25 +0000
Received: from MUN-L-SHSHARMA.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 3 Feb
 2023 13:09:23 -0600
From: Shashank Sharma <shashank.sharma@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 09/13] drm/amdgpu: accommodate DOMAIN/PL_DOORBELL
Date: Fri, 3 Feb 2023 20:08:26 +0100
Message-ID: <20230203190836.1987-10-shashank.sharma@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000B8EC:EE_|CY8PR12MB8196:EE_
X-MS-Office365-Filtering-Correlation-Id: 04a1fc65-09bb-459f-9912-08db061a2a6b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 89L7eOtG9Chm6URREKkeIhWfWYl1Dec543vM6xacZkNWGbVi0Kj2lPvkL8km8GsoSx7CY5LwjqNFT182M//farKziXcI0WpEFRFCNYuiZ4AG24z0857crz+gKaAtQVdTybpLzk4IBw9F34pQoscUolaKlXnHyVcE6EfLCV50MmtjAJnE5jAOKYfekx2ErIaqx8IjI3tOBRvv7tLvjL23encs+cWvIEGQzhOCijWuTKeDHFjkd+pTprZiYhVzNO6ziB2x6P7VedBN8sCptBWB8MQfeWLUwYVUTsRQougYIFqgwKyTlz5Y4cYb3lb6R0pbu3gNdP/GPJkYFZF7p90Nha1ZOexJVyOM4PbbH8DlVGQpnGvxDRfDG+/F2ZD4sGMtpn8Z2BR5OSH5yROuqSrEvD+z/jr3avB92WTCQlpX2LAcEfQWhXsVDsjK60R0SAFbZQtQht6J2XGBdeNLnVxNEfOYfELJcHVZAhr4SIqMDo97W0QmkPS+fCYyRb3alibp3RL2flR5fHRGJh2UVOxEgiEtiUPN6iXj1noZh0lmFdg5u9COvRKIDDD06DIzHpetkEQFZ/I8kgEOEsGoz7soIW/oNWZUNnHQhasEhO/EwdvJIb2sLIJHni3za45I0jGqlaldAxPh0rhvBOg6zKbPYKtj/T4ZBO7coYRJl4RnsyZAPUvASs1Dv8JB61PSwMYOYCZRtbfeuNOQ7B+ms8Sl1cCxRgAbkCDDsV/gOU1uyA0=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(376002)(396003)(39860400002)(136003)(346002)(451199018)(40470700004)(36840700001)(46966006)(40460700003)(83380400001)(47076005)(54906003)(4326008)(70206006)(41300700001)(8936002)(70586007)(8676002)(1076003)(6916009)(316002)(2616005)(478600001)(36756003)(186003)(16526019)(7696005)(336012)(26005)(82310400005)(426003)(81166007)(86362001)(356005)(44832011)(40480700001)(5660300002)(36860700001)(82740400003)(2906002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2023 19:09:25.2418 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 04a1fc65-09bb-459f-9912-08db061a2a6b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000B8EC.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8196
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
index 0656e5bb4f05..43a3137019b1 100644
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
index 887fc53a7d16..b2cfd46c459b 100644
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
@@ -962,8 +981,9 @@ int amdgpu_bo_pin_restricted(struct amdgpu_bo *bo, u32 domain,
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
@@ -1013,6 +1033,8 @@ void amdgpu_bo_unpin(struct amdgpu_bo *bo)
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
index bb2230d14ea6..71eff2f195a7 100644
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
index 243deb1ffc54..9971665d7d99 100644
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

