Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCE2CCCA478
	for <amd-gfx@archiver.kernel.org>; Thu,  2 Jun 2022 16:12:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5ADCA10F3C6;
	Thu,  2 Jun 2022 16:12:30 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2047.outbound.protection.outlook.com [40.107.102.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 40B7E10F86E
 for <amd-gfx@lists.freedesktop.org>; Thu,  2 Jun 2022 16:12:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R5ykWtv1IahWHe4ghrC6eGbi2ahzLuffdWTNcg/p0Ru4uvRiKFsU9yeLEeIaZdGZMH7LHbW+uN2LRecHkz6m7sOBzo7+yAFP8Tw0lX1EoHcEm4kuYCB6iIs5em7Z0cV+Wdq+d9fTnr6R/oRXRib6Itr3bMnbtr8p1OHd7sN246kqKzC5pn/wikfMQ/tFypl70iIvRbkQOF5PmXivVdjnKu3uYYSlkulrmVu5aGNnYuazncEpogRRQWDftFkJcB+X9gVoAK928B6i6i7u1q3QtX7+DL7F9FzqABPMHg1OLLVofZ/SR4TnUVr2/pMpCl+hxqiuU3fOC7oaAIQ7V71Szw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=72zI/BEMW4bya+F+tU2JbuUeHcnPTViN2vymGcmUvcI=;
 b=AV0/mPUl4YZ1KnkQcRhej+BGlWiVlG3o/v50fx5eaqErzFLJRXI4sVCtCqYvPOeJr6xFheEl5cP73la7n8bpig6zFt9+l/QwxBZD0ABWd55hJ27KUfrNF5LbZiMk0Gu/3V35+ndIViWAW6OeJGpMoVyACRlAtObPEjd03ByzdGWLoK+1LhibYOEAC9bwf4ab3xZf2tZGhPNQazHvHtaqbmR4ohCzh+vlpQ4Cad/9nLLtwcoFNIp0f4/+BZdESKMWa/S/dVHQx7Bv/ZOnPjAyXCaCqXmFtMbg6BDgtX6fJqbQaWASqxOLkF0x/bxPXgEhN33BX6oRVx7j/7NHv20l4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=72zI/BEMW4bya+F+tU2JbuUeHcnPTViN2vymGcmUvcI=;
 b=5kHavRmY+KlO1AogLvy0RpkhUGYGgd/ga7P5NXNNmoI5VTVOQLKDqwvktdcm500R5SQB/jfMlBeUyRlCBKrc+wHll5/B6VqcW2YZMTfX7EclqfX3Vw0yCRrtsVSlDnrQ25y+bfnIsvQn1EBKMFtZBuIoj5iUckvCogMEcFmO8+c=
Received: from BN0PR03CA0023.namprd03.prod.outlook.com (2603:10b6:408:e6::28)
 by BYAPR12MB3496.namprd12.prod.outlook.com (2603:10b6:a03:d8::26)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.17; Thu, 2 Jun
 2022 16:12:25 +0000
Received: from BN8NAM11FT031.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e6:cafe::14) by BN0PR03CA0023.outlook.office365.com
 (2603:10b6:408:e6::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.12 via Frontend
 Transport; Thu, 2 Jun 2022 16:12:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT031.mail.protection.outlook.com (10.13.177.25) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5314.12 via Frontend Transport; Thu, 2 Jun 2022 16:12:24 +0000
Received: from fedora.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Thu, 2 Jun
 2022 11:12:23 -0500
From: Luben Tuikov <luben.tuikov@amd.com>
To: <amd-gfx@lists.freedesktop.org>, =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
Subject: [PATCH 2/3] drm/amdgpu: rename vram_scratch into mem_scratch
Date: Thu, 2 Jun 2022 12:12:09 -0400
Message-ID: <20220602161210.19380-3-luben.tuikov@amd.com>
X-Mailer: git-send-email 2.36.1.74.g277cf0bc36
In-Reply-To: <20220602161210.19380-1-luben.tuikov@amd.com>
References: <20220602161210.19380-1-luben.tuikov@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 937d8c34-8a12-4183-3cad-08da44b2ae50
X-MS-TrafficTypeDiagnostic: BYAPR12MB3496:EE_
X-Microsoft-Antispam-PRVS: <BYAPR12MB3496227C075AC51B37EC81F999DE9@BYAPR12MB3496.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: X41xSkNpE+MWd3M46E6GZTwwwoZi6606ImiY3hWnsXBw7yA3n3/vBGbTl3rSCNyd43YDbPpXU1dXPFipxipOyOPkzMyALQdVhl0k8awSjbt9bDZ0l/+qlmWiuHTsR/Sfg/2XXs+yectnwfuf+hpppcoozIeIAgK3Q3N4MPzKLbfL+T/crasP9+ZTkaFQ8TVQodzaEiHMk1/6qVNrc8ehZoSOftNKoqbMTO+sd0VClmNLpnaK7MUn8s80Utzr18pP/4ocYfKRbzzB4vsKzx1medIj3YiTayNnu8dYz8L8ZYkhfUQS2NXefhvC5wg2GTm4pt8R3V9SovWbNpVF56rP3W5bRsFymb3P/Gw7soCmyBP3rdQMaUhmdW4ys6Y6U1UJuwwxxhwpXoOGavsrGMDMkO1x0eY8kmugTQXkrmcCJSZhIKgLdSQlhRWvf+8BrciXccMqv1jIzXV6+SV6G7fW464zk9AYIJ84+gSbDaVbe3Ywd0OxkU1uV5xMBJEuZo47i2sQ5fAbMoPSEZFTxXbeG4/I2h3IDZPGQlMhbtOrpHjY1a5l0/sijPUsBvRaLAHIh7CvGK47o3NqXp5oHjNVN4nr3jyJ8gUg5VQCdsxYf53yKEOLy7ey1S2eZMZu3/dYY3AsALqH3OhVrygnDP9ZreQkT62+2Cl9ssJ51L5w3ewzvYFIiySrWM/fHGsEWP1BhBBGwxNwzTLhHCGI1hNPPQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(16526019)(2616005)(8676002)(36756003)(6636002)(40460700003)(186003)(83380400001)(316002)(356005)(70206006)(70586007)(4326008)(1076003)(2906002)(82310400005)(6666004)(44832011)(30864003)(86362001)(26005)(110136005)(336012)(426003)(81166007)(47076005)(8936002)(5660300002)(7696005)(508600001)(36860700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2022 16:12:24.4926 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 937d8c34-8a12-4183-3cad-08da44b2ae50
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT031.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3496
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
Cc: Luben Tuikov <luben.tuikov@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Christian König <christian.koenig@amd.com>

Rename vram_scratch into mem_scratch and allow allocating it into GTT as
well.

The only problem with that is that we won't have a default page for the
system aperture any more.

Signed-off-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Luben Tuikov <luben.tuikov@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h        |  4 ++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 27 +++++++++++-----------
 drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c   |  2 +-
 drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c   |  2 +-
 drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c   |  2 +-
 drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0.c   |  2 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c      |  2 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c      |  2 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c      |  2 +-
 drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c    |  2 +-
 drivers/gpu/drm/amd/amdgpu/mmhub_v1_7.c    |  2 +-
 drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c    |  2 +-
 drivers/gpu/drm/amd/amdgpu/mmhub_v2_3.c    |  2 +-
 drivers/gpu/drm/amd/amdgpu/mmhub_v3_0.c    |  2 +-
 drivers/gpu/drm/amd/amdgpu/mmhub_v3_0_1.c  |  2 +-
 drivers/gpu/drm/amd/amdgpu/mmhub_v3_0_2.c  |  2 +-
 drivers/gpu/drm/amd/amdgpu/mmhub_v9_4.c    |  2 +-
 17 files changed, 31 insertions(+), 30 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 96d058c4cd4b7c..38bf6fb08773b1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -603,7 +603,7 @@ int amdgpu_cs_wait_fences_ioctl(struct drm_device *dev, void *data,
 				struct drm_file *filp);
 
 /* VRAM scratch page for HDP bug, default vram page */
-struct amdgpu_vram_scratch {
+struct amdgpu_mem_scratch {
 	struct amdgpu_bo		*robj;
 	volatile uint32_t		*ptr;
 	u64				gpu_addr;
@@ -842,7 +842,7 @@ struct amdgpu_device {
 
 	/* memory management */
 	struct amdgpu_mman		mman;
-	struct amdgpu_vram_scratch	vram_scratch;
+	struct amdgpu_mem_scratch	mem_scratch;
 	struct amdgpu_wb		wb;
 	atomic64_t			num_bytes_moved;
 	atomic64_t			num_evictions;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index b5ee0eb984ee65..2681a615054fe3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -920,32 +920,33 @@ static int amdgpu_device_asic_init(struct amdgpu_device *adev)
 }
 
 /**
- * amdgpu_device_vram_scratch_init - allocate the VRAM scratch page
+ * amdgpu_device_mem_scratch_init - allocate the VRAM scratch page
  *
  * @adev: amdgpu_device pointer
  *
  * Allocates a scratch page of VRAM for use by various things in the
  * driver.
  */
-static int amdgpu_device_vram_scratch_init(struct amdgpu_device *adev)
+static int amdgpu_device_mem_scratch_init(struct amdgpu_device *adev)
 {
-	return amdgpu_bo_create_kernel(adev, AMDGPU_GPU_PAGE_SIZE,
-				       PAGE_SIZE, AMDGPU_GEM_DOMAIN_VRAM,
-				       &adev->vram_scratch.robj,
-				       &adev->vram_scratch.gpu_addr,
-				       (void **)&adev->vram_scratch.ptr);
+	return amdgpu_bo_create_kernel(adev, AMDGPU_GPU_PAGE_SIZE, PAGE_SIZE,
+				       AMDGPU_GEM_DOMAIN_VRAM |
+				       AMDGPU_GEM_DOMAIN_GTT,
+				       &adev->mem_scratch.robj,
+				       &adev->mem_scratch.gpu_addr,
+				       (void **)&adev->mem_scratch.ptr);
 }
 
 /**
- * amdgpu_device_vram_scratch_fini - Free the VRAM scratch page
+ * amdgpu_device_mem_scratch_fini - Free the VRAM scratch page
  *
  * @adev: amdgpu_device pointer
  *
  * Frees the VRAM scratch page.
  */
-static void amdgpu_device_vram_scratch_fini(struct amdgpu_device *adev)
+static void amdgpu_device_mem_scratch_fini(struct amdgpu_device *adev)
 {
-	amdgpu_bo_free_kernel(&adev->vram_scratch.robj, NULL, NULL);
+	amdgpu_bo_free_kernel(&adev->mem_scratch.robj, NULL, NULL);
 }
 
 /**
@@ -2367,9 +2368,9 @@ static int amdgpu_device_ip_init(struct amdgpu_device *adev)
 			if (amdgpu_sriov_vf(adev))
 				amdgpu_virt_exchange_data(adev);
 
-			r = amdgpu_device_vram_scratch_init(adev);
+			r = amdgpu_device_mem_scratch_init(adev);
 			if (r) {
-				DRM_ERROR("amdgpu_vram_scratch_init failed %d\n", r);
+				DRM_ERROR("amdgpu_mem_scratch_init failed %d\n", r);
 				goto init_failed;
 			}
 			r = adev->ip_blocks[i].version->funcs->hw_init((void *)adev);
@@ -2839,7 +2840,7 @@ static int amdgpu_device_ip_fini(struct amdgpu_device *adev)
 			amdgpu_ucode_free_bo(adev);
 			amdgpu_free_static_csa(&adev->virt.csa_obj);
 			amdgpu_device_wb_fini(adev);
-			amdgpu_device_vram_scratch_fini(adev);
+			amdgpu_device_mem_scratch_fini(adev);
 			amdgpu_ib_pool_fini(adev);
 		}
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c
index ec4d5e15b766a3..ab2325f6c7ac5f 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c
@@ -120,7 +120,7 @@ static void gfxhub_v1_0_init_system_aperture_regs(struct amdgpu_device *adev)
 				max(adev->gmc.fb_end, adev->gmc.agp_end) >> 18);
 
 		/* Set default page address. */
-		value = amdgpu_gmc_vram_mc2pa(adev, adev->vram_scratch.gpu_addr);
+		value = amdgpu_gmc_vram_mc2pa(adev, adev->mem_scratch.gpu_addr);
 		WREG32_SOC15(GC, 0, mmMC_VM_SYSTEM_APERTURE_DEFAULT_ADDR_LSB,
 			     (u32)(value >> 12));
 		WREG32_SOC15(GC, 0, mmMC_VM_SYSTEM_APERTURE_DEFAULT_ADDR_MSB,
diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c
index 34513e8e151916..9b3a0252731818 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c
@@ -165,7 +165,7 @@ static void gfxhub_v2_0_init_system_aperture_regs(struct amdgpu_device *adev)
 			     max(adev->gmc.fb_end, adev->gmc.agp_end) >> 18);
 
 		/* Set default page address. */
-		value = amdgpu_gmc_vram_mc2pa(adev, adev->vram_scratch.gpu_addr);
+		value = amdgpu_gmc_vram_mc2pa(adev, adev->mem_scratch.gpu_addr);
 		WREG32_SOC15(GC, 0, mmGCMC_VM_SYSTEM_APERTURE_DEFAULT_ADDR_LSB,
 			     (u32)(value >> 12));
 		WREG32_SOC15(GC, 0, mmGCMC_VM_SYSTEM_APERTURE_DEFAULT_ADDR_MSB,
diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c
index d8c53158111693..9f7d5200eaf440 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c
@@ -167,7 +167,7 @@ static void gfxhub_v2_1_init_system_aperture_regs(struct amdgpu_device *adev)
 		     max(adev->gmc.fb_end, adev->gmc.agp_end) >> 18);
 
 	/* Set default page address. */
-	value = amdgpu_gmc_vram_mc2pa(adev, adev->vram_scratch.gpu_addr);
+	value = amdgpu_gmc_vram_mc2pa(adev, adev->mem_scratch.gpu_addr);
 	WREG32_SOC15(GC, 0, mmGCMC_VM_SYSTEM_APERTURE_DEFAULT_ADDR_LSB,
 		     (u32)(value >> 12));
 	WREG32_SOC15(GC, 0, mmGCMC_VM_SYSTEM_APERTURE_DEFAULT_ADDR_MSB,
diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0.c
index f99d7641bb2177..f0b85f51c3bcb0 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0.c
@@ -167,7 +167,7 @@ static void gfxhub_v3_0_init_system_aperture_regs(struct amdgpu_device *adev)
 		     adev->gmc.vram_end >> 18);
 
 	/* Set default page address. */
-	value = adev->vram_scratch.gpu_addr - adev->gmc.vram_start
+	value = adev->mem_scratch.gpu_addr - adev->gmc.vram_start
 		+ adev->vm_manager.vram_base_offset;
 	WREG32_SOC15(GC, 0, regGCMC_VM_SYSTEM_APERTURE_DEFAULT_ADDR_LSB,
 		     (u32)(value >> 12));
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
index ec291d28edffd8..7f4bf2efa19c42 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
@@ -258,7 +258,7 @@ static void gmc_v6_0_mc_program(struct amdgpu_device *adev)
 	WREG32(mmMC_VM_SYSTEM_APERTURE_HIGH_ADDR,
 	       adev->gmc.vram_end >> 12);
 	WREG32(mmMC_VM_SYSTEM_APERTURE_DEFAULT_ADDR,
-	       adev->vram_scratch.gpu_addr >> 12);
+	       adev->mem_scratch.gpu_addr >> 12);
 	WREG32(mmMC_VM_AGP_BASE, 0);
 	WREG32(mmMC_VM_AGP_TOP, 0x0FFFFFFF);
 	WREG32(mmMC_VM_AGP_BOT, 0x0FFFFFFF);
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
index 979da6f510e886..b309f3ab2917c3 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
@@ -292,7 +292,7 @@ static void gmc_v7_0_mc_program(struct amdgpu_device *adev)
 	WREG32(mmMC_VM_SYSTEM_APERTURE_HIGH_ADDR,
 	       adev->gmc.vram_end >> 12);
 	WREG32(mmMC_VM_SYSTEM_APERTURE_DEFAULT_ADDR,
-	       adev->vram_scratch.gpu_addr >> 12);
+	       adev->mem_scratch.gpu_addr >> 12);
 	WREG32(mmMC_VM_AGP_BASE, 0);
 	WREG32(mmMC_VM_AGP_TOP, 0x0FFFFFFF);
 	WREG32(mmMC_VM_AGP_BOT, 0x0FFFFFFF);
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
index 382dde1ce74c07..24a256cfd7ceb9 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
@@ -474,7 +474,7 @@ static void gmc_v8_0_mc_program(struct amdgpu_device *adev)
 	WREG32(mmMC_VM_SYSTEM_APERTURE_HIGH_ADDR,
 	       adev->gmc.vram_end >> 12);
 	WREG32(mmMC_VM_SYSTEM_APERTURE_DEFAULT_ADDR,
-	       adev->vram_scratch.gpu_addr >> 12);
+	       adev->mem_scratch.gpu_addr >> 12);
 
 	if (amdgpu_sriov_vf(adev)) {
 		tmp = ((adev->gmc.vram_end >> 24) & 0xFFFF) << 16;
diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c
index 3f44a099c52a41..938974bed2dbc5 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c
@@ -114,7 +114,7 @@ static void mmhub_v1_0_init_system_aperture_regs(struct amdgpu_device *adev)
 		return;
 
 	/* Set default page address. */
-	value = amdgpu_gmc_vram_mc2pa(adev, adev->vram_scratch.gpu_addr);
+	value = amdgpu_gmc_vram_mc2pa(adev, adev->mem_scratch.gpu_addr);
 	WREG32_SOC15(MMHUB, 0, mmMC_VM_SYSTEM_APERTURE_DEFAULT_ADDR_LSB,
 		     (u32)(value >> 12));
 	WREG32_SOC15(MMHUB, 0, mmMC_VM_SYSTEM_APERTURE_DEFAULT_ADDR_MSB,
diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_7.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_7.c
index 6fa7090bc6cbe3..73afbf2facc9e7 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_7.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_7.c
@@ -134,7 +134,7 @@ static void mmhub_v1_7_init_system_aperture_regs(struct amdgpu_device *adev)
 	}
 
 	/* Set default page address. */
-	value = amdgpu_gmc_vram_mc2pa(adev, adev->vram_scratch.gpu_addr);
+	value = amdgpu_gmc_vram_mc2pa(adev, adev->mem_scratch.gpu_addr);
 	WREG32_SOC15(MMHUB, 0, regMC_VM_SYSTEM_APERTURE_DEFAULT_ADDR_LSB,
 		     (u32)(value >> 12));
 	WREG32_SOC15(MMHUB, 0, regMC_VM_SYSTEM_APERTURE_DEFAULT_ADDR_MSB,
diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c
index 4d304f22889e4c..e4861d5041e758 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c
@@ -236,7 +236,7 @@ static void mmhub_v2_0_init_system_aperture_regs(struct amdgpu_device *adev)
 	}
 
 	/* Set default page address. */
-	value = amdgpu_gmc_vram_mc2pa(adev, adev->vram_scratch.gpu_addr);
+	value = amdgpu_gmc_vram_mc2pa(adev, adev->mem_scratch.gpu_addr);
 	WREG32_SOC15(MMHUB, 0, mmMMMC_VM_SYSTEM_APERTURE_DEFAULT_ADDR_LSB,
 		     (u32)(value >> 12));
 	WREG32_SOC15(MMHUB, 0, mmMMMC_VM_SYSTEM_APERTURE_DEFAULT_ADDR_MSB,
diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v2_3.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v2_3.c
index 1b027d069ab404..c4baf05438827b 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v2_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v2_3.c
@@ -164,7 +164,7 @@ static void mmhub_v2_3_init_system_aperture_regs(struct amdgpu_device *adev)
 		     max(adev->gmc.fb_end, adev->gmc.agp_end) >> 18);
 
 	/* Set default page address. */
-	value = amdgpu_gmc_vram_mc2pa(adev, adev->vram_scratch.gpu_addr);
+	value = amdgpu_gmc_vram_mc2pa(adev, adev->mem_scratch.gpu_addr);
 	WREG32_SOC15(MMHUB, 0, mmMMMC_VM_SYSTEM_APERTURE_DEFAULT_ADDR_LSB,
 		     (u32)(value >> 12));
 	WREG32_SOC15(MMHUB, 0, mmMMMC_VM_SYSTEM_APERTURE_DEFAULT_ADDR_MSB,
diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v3_0.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v3_0.c
index 4926fa82c1c4dc..6d17d025f12a71 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v3_0.c
@@ -188,7 +188,7 @@ static void mmhub_v3_0_init_system_aperture_regs(struct amdgpu_device *adev)
 	}
 
 	/* Set default page address. */
-	value = adev->vram_scratch.gpu_addr - adev->gmc.vram_start +
+	value = adev->mem_scratch.gpu_addr - adev->gmc.vram_start +
 		adev->vm_manager.vram_base_offset;
 	WREG32_SOC15(MMHUB, 0, regMMMC_VM_SYSTEM_APERTURE_DEFAULT_ADDR_LSB,
 		     (u32)(value >> 12));
diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v3_0_1.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v3_0_1.c
index cac72ced94c852..274a7f785e1afd 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v3_0_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v3_0_1.c
@@ -188,7 +188,7 @@ static void mmhub_v3_0_1_init_system_aperture_regs(struct amdgpu_device *adev)
 		     adev->gmc.vram_end >> 18);
 
 	/* Set default page address. */
-	value = adev->vram_scratch.gpu_addr - adev->gmc.vram_start +
+	value = adev->mem_scratch.gpu_addr - adev->gmc.vram_start +
 		adev->vm_manager.vram_base_offset;
 	WREG32_SOC15(MMHUB, 0, regMMMC_VM_SYSTEM_APERTURE_DEFAULT_ADDR_LSB,
 		     (u32)(value >> 12));
diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v3_0_2.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v3_0_2.c
index 5e5b884d83573a..dba0200c0b1fe6 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v3_0_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v3_0_2.c
@@ -181,7 +181,7 @@ static void mmhub_v3_0_2_init_system_aperture_regs(struct amdgpu_device *adev)
 	}
 
 	/* Set default page address. */
-	value = adev->vram_scratch.gpu_addr - adev->gmc.vram_start +
+	value = adev->mem_scratch.gpu_addr - adev->gmc.vram_start +
 		adev->vm_manager.vram_base_offset;
 	WREG32_SOC15(MMHUB, 0, regMMMC_VM_SYSTEM_APERTURE_DEFAULT_ADDR_LSB,
 		     (u32)(value >> 12));
diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v9_4.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v9_4.c
index 6e0145b2b408a0..29873f7014357d 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v9_4.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v9_4.c
@@ -136,7 +136,7 @@ static void mmhub_v9_4_init_system_aperture_regs(struct amdgpu_device *adev,
 			max(adev->gmc.fb_end, adev->gmc.agp_end) >> 18);
 
 		/* Set default page address. */
-		value = amdgpu_gmc_vram_mc2pa(adev, adev->vram_scratch.gpu_addr);
+		value = amdgpu_gmc_vram_mc2pa(adev, adev->mem_scratch.gpu_addr);
 		WREG32_SOC15_OFFSET(
 			MMHUB, 0,
 			mmVMSHAREDPF0_MC_VM_SYSTEM_APERTURE_DEFAULT_ADDR_LSB,
-- 
2.36.1.74.g277cf0bc36

