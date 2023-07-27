Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06926C0015E
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Jul 2023 07:56:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 75A2D10E505;
	Thu, 27 Jul 2023 07:56:44 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2062e.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8b::62e])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D40C010E505
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Jul 2023 07:56:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BDuxt+XwnzcTHj10jIhaF/aBwIYWgWDHX35SPy2yKhiCcvDbAcLrF/O4PgC1cB8neQiLM5gqxmNffPRWmOtVr+voCjgyiah28J7LNuTf0kunCOPdoPWoolPsVH0Wa7V0C46A8uRT1Ksky/inYUXjhGPuWR8FU7ZJnbLP+TY+3yrxXKsFUqJ1uykEMtZKPaxz+4sToY327USth5udjfawGcrt6MVSu1TrOkKX+p7GN4gEWf02mCdt/g7BF0jc0tcOELr5d+MxrkYWjaI07dBotQbObA+rqr8PLHlK0BzcUesOdHfVwGB+4hfacc+9r2mXRQtu4rnGerELv85iiaclBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vOW7L8BMDyCqNzY2CjknM4hjPvIILvglfi6wvx0nmUE=;
 b=l9TLVJoGd0MoHxNpfLoxcZL9PqYcv96GgNmDK4bVXXZbta8iOFQmHrRIiVjZEQXnHAc3ktazIapLClDSmh8xXIcaVvvIZBEBoIJb1I/zYHKod3+YJpJT8lHOYM43acrVX46XdTRIVmm+5AaW6MjUo73X4injHSZ8Fqcw+Dszp7CD5hNTRUXYDNdNzZb5LsfN7D3u9bOfG0+YfwH4Afp6JBYkJylYshypswJjYJaLvzyj6dI+qXeigDlDkuW+k+TXWzN564OMcKLnF+NUAOXob9eC2Jd/R4jf4ZRpW9JVLB0DWJdzvf6Ew8w6UkLQr4ye2aTXbbAiMhcozbtCNpGNfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vOW7L8BMDyCqNzY2CjknM4hjPvIILvglfi6wvx0nmUE=;
 b=X3BJ7SsNqt3yl8dHJdNf4fpNXiloK1n3AvSqs15Sgt9i/TnuT92VzodQU1xOmc+oEYLikD3RcrqaRgrarKIswBb+B7CSXs/AeZzygXFyK/iGF7KSjOH7RWg5Y4mAGU0drNRYebwfFCHc+AFucAYYHNkIe0LUa32wc4CicbtoszI=
Received: from MW4PR03CA0051.namprd03.prod.outlook.com (2603:10b6:303:8e::26)
 by CY5PR12MB6036.namprd12.prod.outlook.com (2603:10b6:930:2c::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Thu, 27 Jul
 2023 07:56:40 +0000
Received: from CO1NAM11FT025.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8e:cafe::d2) by MW4PR03CA0051.outlook.office365.com
 (2603:10b6:303:8e::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29 via Frontend
 Transport; Thu, 27 Jul 2023 07:56:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT025.mail.protection.outlook.com (10.13.175.232) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6631.29 via Frontend Transport; Thu, 27 Jul 2023 07:56:39 +0000
Received: from lang-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 27 Jul
 2023 02:56:36 -0500
From: Lang Yu <Lang.Yu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/2] drm/amdgpu: refine amdgpu_bo_create_kernel_at()
Date: Thu, 27 Jul 2023 15:56:19 +0800
Message-ID: <20230727075620.728235-1-Lang.Yu@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT025:EE_|CY5PR12MB6036:EE_
X-MS-Office365-Filtering-Correlation-Id: cf7fd268-1ff8-442c-511c-08db8e7702b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LI4e4gqLBxb95P6D9Ol/ubASQWkg0OSeHmaVIbrHmcMODW6ZgEciVTH1j7+Zd4fzyAOIgeIhjJ3PaFibCFugp7wSq12FEHGWwCDWypXQKHFkW6eEktZsbO89bq6y0Y1guNQ4nJ+VVMnVpDY7ifDJluqZULwP/Cf3pZg6Qi5ff9rRle4HzjHCT0AdLbs367hWyU5wX0T0N8FDJe1ilYcH3dioay0cHcIe5PSBAzff+b1sC6zjCWntbGbqyF3UXnLL5UtjcW39xy2lGomRbZmHzk+cMGXCZXVusHy1Mly7E4YtwlbGOy8s1/oUK9XmDOItTTt7tmUoS04BpVh0HHqsMGix3b5qSANzulKK8lPoW1giieOjGziLfgv/9wH7TyqKLfd1pXE8QvnpYVmG08ZwFON/emJoP61quAGdNkKZWPgM0/HqKhZpjKoSvGletzV7rfwjMCWOTK1iCGoQXhP+jTKsm7UmdU5fy9GLgDeBj/WjL+vYa0zoRdQlpTSJjfgA9x1a18IABNg9o+zVc2zTO5JgVfrHdKsXSvEc2YcQQu727qIdr374QR5LnZzZvtco/LszXNk54kD1ZMOXCXDn0Ke/bqK1IB3EcXwsdgyov1ijlzfoFZGfKxOZHkfmG6yoIYuHzMNQQIshleRoPKtR445zgks3WkRAq9p9nH/Ws74c5Ck/A20Fx/FLf25l6yjAa/vTnRaumoiJG2IgtHJ2mD/lp8j8j6nfusU8H6AnhndjfiN1m2rFcpkTIOiZMcN90dTH9H+ooCX9HT4DF5oRYg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(136003)(39860400002)(346002)(376002)(451199021)(82310400008)(46966006)(36840700001)(40470700004)(40480700001)(7696005)(6666004)(478600001)(2616005)(86362001)(426003)(8676002)(16526019)(54906003)(5660300002)(8936002)(41300700001)(26005)(1076003)(186003)(336012)(2906002)(81166007)(82740400003)(356005)(36756003)(4326008)(316002)(6916009)(70206006)(70586007)(47076005)(40460700003)(36860700001)(83380400001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2023 07:56:39.9315 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cf7fd268-1ff8-442c-511c-08db8e7702b7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT025.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6036
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Yifan Zhang <yifan1.zhang@amd.com>, Lang
 Yu <Lang.Yu@amd.com>, Christian Koenig <christian.koenig@amd.com>,
 Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

amdgpu_bo_create_kernel_at() is used to create a physical
contiguous VRAM BO at the specific offset. It calls
amdgpu_bo_create_reserved() to create a VRAM BO first,
then frees its old memory and allocates new memory at
the specific offset. But amdgpu_bo_create_reserved() would
fail if requested VRAM BO size is too large(>128MB) on
APU which usually has a small default VRAM size(512MB).

That is because VRAM fragmentation and DRM_BUDDY_RANGE_ALLOCATION
is not natively supported by amdgpu_bo_create().

The approach is using amdgpu_bo_create_reserved() to
create a BO in CPU domain first, it will always succeed.
Then use amdgpu_bo_pin_restricted() to move the BO to
requested domain and location.

Signed-off-by: Lang Yu <Lang.Yu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 30 ++++++++--------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.h |  3 ++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c    | 15 +++++------
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c   |  2 +-
 4 files changed, 21 insertions(+), 29 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
index ff73cc11d47e..331daa47a444 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
@@ -358,6 +358,7 @@ int amdgpu_bo_create_kernel(struct amdgpu_device *adev,
  * @offset: offset of the BO
  * @size: size of the BO
  * @bo_ptr:  used to initialize BOs in structures
+ * @gpu_addr: GPU addr of the pinned BO
  * @cpu_addr: optional CPU address mapping
  *
  * Creates a kernel BO at a specific offset in VRAM.
@@ -367,42 +368,33 @@ int amdgpu_bo_create_kernel(struct amdgpu_device *adev,
  */
 int amdgpu_bo_create_kernel_at(struct amdgpu_device *adev,
 			       uint64_t offset, uint64_t size,
-			       struct amdgpu_bo **bo_ptr, void **cpu_addr)
+			       struct amdgpu_bo **bo_ptr,
+			       u64 *gpu_addr, void **cpu_addr)
 {
-	struct ttm_operation_ctx ctx = { false, false };
-	unsigned int i;
 	int r;
 
 	offset &= PAGE_MASK;
 	size = ALIGN(size, PAGE_SIZE);
 
 	r = amdgpu_bo_create_reserved(adev, size, PAGE_SIZE,
-				      AMDGPU_GEM_DOMAIN_VRAM, bo_ptr, NULL,
-				      cpu_addr);
+				      AMDGPU_GEM_DOMAIN_CPU,
+				      bo_ptr, NULL, cpu_addr);
 	if (r)
 		return r;
 
 	if ((*bo_ptr) == NULL)
 		return 0;
 
-	/*
-	 * Remove the original mem node and create a new one at the request
-	 * position.
-	 */
-	if (cpu_addr)
-		amdgpu_bo_kunmap(*bo_ptr);
-
-	ttm_resource_free(&(*bo_ptr)->tbo, &(*bo_ptr)->tbo.resource);
+	amdgpu_bo_unpin(*bo_ptr);
 
-	for (i = 0; i < (*bo_ptr)->placement.num_placement; ++i) {
-		(*bo_ptr)->placements[i].fpfn = offset >> PAGE_SHIFT;
-		(*bo_ptr)->placements[i].lpfn = (offset + size) >> PAGE_SHIFT;
-	}
-	r = ttm_bo_mem_space(&(*bo_ptr)->tbo, &(*bo_ptr)->placement,
-			     &(*bo_ptr)->tbo.resource, &ctx);
+	r = amdgpu_bo_pin_restricted(*bo_ptr, AMDGPU_GEM_DOMAIN_VRAM,
+				     offset, offset + size);
 	if (r)
 		goto error;
 
+	if (gpu_addr)
+		*gpu_addr = amdgpu_bo_gpu_offset(*bo_ptr);
+
 	if (cpu_addr) {
 		r = amdgpu_bo_kmap(*bo_ptr, cpu_addr);
 		if (r)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
index 5d3440d719e4..8f5b5664a1b6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
@@ -315,7 +315,8 @@ int amdgpu_bo_create_kernel(struct amdgpu_device *adev,
 			    u64 *gpu_addr, void **cpu_addr);
 int amdgpu_bo_create_kernel_at(struct amdgpu_device *adev,
 			       uint64_t offset, uint64_t size,
-			       struct amdgpu_bo **bo_ptr, void **cpu_addr);
+			       struct amdgpu_bo **bo_ptr,
+			       u64 *gpu_addr, void **cpu_addr);
 int amdgpu_bo_create_user(struct amdgpu_device *adev,
 			  struct amdgpu_bo_param *bp,
 			  struct amdgpu_bo_user **ubo_ptr);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index 7c6dd3de1867..a210c243dac0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -1619,7 +1619,7 @@ static int amdgpu_ttm_fw_reserve_vram_init(struct amdgpu_device *adev)
 					  adev->mman.fw_vram_usage_start_offset,
 					  adev->mman.fw_vram_usage_size,
 					  &adev->mman.fw_vram_usage_reserved_bo,
-					  &adev->mman.fw_vram_usage_va);
+					  NULL, &adev->mman.fw_vram_usage_va);
 }
 
 /**
@@ -1644,7 +1644,7 @@ static int amdgpu_ttm_drv_reserve_vram_init(struct amdgpu_device *adev)
 					  adev->mman.drv_vram_usage_start_offset,
 					  adev->mman.drv_vram_usage_size,
 					  &adev->mman.drv_vram_usage_reserved_bo,
-					  &adev->mman.drv_vram_usage_va);
+					  NULL, &adev->mman.drv_vram_usage_va);
 }
 
 /*
@@ -1729,8 +1729,7 @@ static int amdgpu_ttm_reserve_tmr(struct amdgpu_device *adev)
 		ret = amdgpu_bo_create_kernel_at(adev,
 						 ctx->c2p_train_data_offset,
 						 ctx->train_data_size,
-						 &ctx->c2p_bo,
-						 NULL);
+						 &ctx->c2p_bo, NULL, NULL);
 		if (ret) {
 			DRM_ERROR("alloc c2p_bo failed(%d)!\n", ret);
 			amdgpu_ttm_training_reserve_vram_fini(adev);
@@ -1742,7 +1741,7 @@ static int amdgpu_ttm_reserve_tmr(struct amdgpu_device *adev)
 	if (!adev->gmc.is_app_apu) {
 		ret = amdgpu_bo_create_kernel_at(
 			adev, adev->gmc.real_vram_size - reserve_size,
-			reserve_size, &adev->mman.fw_reserved_memory, NULL);
+			reserve_size, &adev->mman.fw_reserved_memory, NULL, NULL);
 		if (ret) {
 			DRM_ERROR("alloc tmr failed(%d)!\n", ret);
 			amdgpu_bo_free_kernel(&adev->mman.fw_reserved_memory,
@@ -1885,14 +1884,14 @@ int amdgpu_ttm_init(struct amdgpu_device *adev)
 		r = amdgpu_bo_create_kernel_at(adev, 0,
 					       adev->mman.stolen_vga_size,
 					       &adev->mman.stolen_vga_memory,
-					       NULL);
+					       NULL, NULL);
 		if (r)
 			return r;
 
 		r = amdgpu_bo_create_kernel_at(adev, adev->mman.stolen_vga_size,
 					       adev->mman.stolen_extended_size,
 					       &adev->mman.stolen_extended_memory,
-					       NULL);
+					       NULL, NULL);
 
 		if (r)
 			return r;
@@ -1901,7 +1900,7 @@ int amdgpu_ttm_init(struct amdgpu_device *adev)
 					       adev->mman.stolen_reserved_offset,
 					       adev->mman.stolen_reserved_size,
 					       &adev->mman.stolen_reserved_memory,
-					       NULL);
+					       NULL, NULL);
 		if (r)
 			return r;
 	} else {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
index 41aa853a07d2..b93b42b916ce 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
@@ -397,7 +397,7 @@ static void amdgpu_virt_ras_reserve_bps(struct amdgpu_device *adev)
 		 */
 		if (amdgpu_bo_create_kernel_at(adev, bp << AMDGPU_GPU_PAGE_SHIFT,
 					       AMDGPU_GPU_PAGE_SIZE,
-					       &bo, NULL))
+					       &bo, NULL, NULL))
 			DRM_DEBUG("RAS WARN: reserve vram for retired page %llx fail\n", bp);
 
 		data->bps_bo[i] = bo;
-- 
2.25.1

