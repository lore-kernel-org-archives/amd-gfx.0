Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9604AC001DF
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Jul 2023 06:04:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0D27C10E647;
	Fri, 28 Jul 2023 06:04:31 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1877010E647
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Jul 2023 06:04:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iAlSt2foDpHE5BXx8pN6JS2Hy5KFLim+/0cUNDqRIzCK8wee6IoCboyUPXLNojTmKiOrZ/pAICVYqiSE68zEDXGpmjc+2DEpq8IhLwXhim9kKqCJwcRVjkQB5KCxuve1qr8NjXgn00i08pa5oC7sQNSFTtsovymqKWKJ7u7P/r4vjfpV8l1zKgKj8bf+aReGlDtQVSfjmNs9i8SDiJQHsQNq1CAIChUcSOwCxWo3FnbIz7QCJqPvilyzxpKUix600hG1KrCRqclE3aIJDsXYru73ShKPxhX8+RKacg7/LfZ4WGX26IVBF+AFFLZCT69LopOZwN44Bk+G6hXSxRHEIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=55PZDkhCjGWncUsyz/xy/IRfkSKdMHYfhEQhLongWvg=;
 b=KSd8gr8tcUcctOXegarQpIHAFFQKZJxUzOyyY8p5n/z2fW1WvJhAEfZJOOpv9uuBXe/d1fZiQ30dA31b+pCInDcZkzrC1pT8GERj9FCKYK1b6iroyzF9nkcZW1Y7imJZmjXCCUvxn+9C2smtR1xrAHAydmvtV6H6RNcDwjqfW9K9avIBfgc94jN9zHr1Gfm1OxDMK6U72Lsiw+7X+YFI3Bhc2Ta/pfoxapgQN+tuUCCfmle0Vzb4eAk9PO8bFgC1lVaELdMGZ/CAErzV70xGCtXG89ZleCW62vhnCJUYZ2TIe+QIbzWhZKAHRHrEIlJgHuukgAJKIbeB9xZzpgvZmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=55PZDkhCjGWncUsyz/xy/IRfkSKdMHYfhEQhLongWvg=;
 b=iNgBSgADAMs5h9bBD2e6klzWBCaaV9GWs3Cfbv/LZXLKozb+iKhsYM8QakUpR79heqjitDLwGpqdB5RIfBjlUWHHlLmHtn8PqPmHDeVK6jeEqRW1ipP7ZLFMM8w4HpMNgDK8Stw71z/SGXQgkcBbnxI/BgRRK4496Uy00S1/Muw=
Received: from DM6PR02CA0124.namprd02.prod.outlook.com (2603:10b6:5:1b4::26)
 by SN7PR12MB6690.namprd12.prod.outlook.com (2603:10b6:806:272::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Fri, 28 Jul
 2023 06:04:26 +0000
Received: from DM6NAM11FT048.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1b4:cafe::b3) by DM6PR02CA0124.outlook.office365.com
 (2603:10b6:5:1b4::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29 via Frontend
 Transport; Fri, 28 Jul 2023 06:04:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT048.mail.protection.outlook.com (10.13.173.114) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6631.29 via Frontend Transport; Fri, 28 Jul 2023 06:04:26 +0000
Received: from lang-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 28 Jul
 2023 01:04:22 -0500
From: Lang Yu <Lang.Yu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2] drm/amdgpu: refine amdgpu_bo_create_kernel_at()
Date: Fri, 28 Jul 2023 14:04:05 +0800
Message-ID: <20230728060405.939785-1-Lang.Yu@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT048:EE_|SN7PR12MB6690:EE_
X-MS-Office365-Filtering-Correlation-Id: 68d4bec5-6a28-44bf-a90b-08db8f307f6f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /IgucwQ3qFlcQwcFev6LiDxizntDiCw4DPxx9m1diozI8XdU9HKzvGYE7XwrWqo5QBrSMOGtRXEJza1ykPcLBX/CYGlRmYRlbylE6lWxPqxbteAG/vZmpzZZ46rEQxg9ABBzPFcCqCaWLL79SGORLqVwy3szYMcjBt6yGTgJ4DJTvzMX4KO2j372QoWLof0x5yEJ6MLOpgzNXdAFCG1YhSQ/RypxSDXAkqk1kH+rQPKacmAvL/u6cjVqw1kdaUATcm8F315ucok8gFj5eyNVv2I1GZi0V7pJ2SEhcbJqL/4Zk1n9Zzg5cIuCj184fb1+s2OHgJUXHAvwd4qlSys7p+V5x/6LYV+gyYrRWh41e1QnLIIkKUQiElFNDQ7/abb7LcxNqUJu94FYWkk27Gxw8YMxxRnCjE0fAHdFETfkd6V/szSO4JDkqJxvuUtFXTAadpAjoIRPwqSFgdEn0K68JDUQg14e+xi+kI6Cycx/yOWnkpO0h4QO8TxFnv5Qkl90rVI+bRSfNOIYyTWn884qupkSg59V6hlRB5Ysg0LKCrkCsMGgpcSfXBUgacQE1WKW5bM18gl3YI5kvIxKfnVMqlj48YxnYzRpqnVg/5AR2WPyatmA9idYBTRgr9qKoloGIVD90fcIA6nIOSd3phrFH9tcrvoyf5J3T+f6Eqh8ifPppXgHx13xmfrCaL51mqzjGVHy41yWoKccdkZWwpfQmdNHczxwinIaQCLQ2xPCIoR63VUVSd7Kuc/zCuGF/LT0v1dhgLZ0/CjouXN/5VR6GA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(346002)(396003)(376002)(39860400002)(451199021)(82310400008)(36840700001)(46966006)(40470700004)(26005)(41300700001)(316002)(8676002)(6916009)(4326008)(70206006)(8936002)(1076003)(40460700003)(54906003)(81166007)(478600001)(82740400003)(40480700001)(356005)(70586007)(7696005)(2906002)(36756003)(2616005)(426003)(83380400001)(336012)(86362001)(47076005)(6666004)(36860700001)(16526019)(186003)(5660300002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2023 06:04:26.1346 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 68d4bec5-6a28-44bf-a90b-08db8f307f6f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT048.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6690
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
Cc: Lang Yu <Lang.Yu@amd.com>, Christian Koenig <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Use amdgpu_bo_create_reserved() to create a BO in VRAM
domain would fail if requested VRAM size is large(>128MB)
on APU which usually has a default 512MB VRAM.

That's because VRAM is framgented after several allocations.

The approach is using amdgpu_bo_create_reserved() to
create a BO in CPU domain first, it will always succeed.

v2: Don't overwrite the contents at specific offset.

Signed-off-by: Lang Yu <Lang.Yu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 24 ++++++++++++++++------
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.h |  3 ++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c    | 15 +++++++-------
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c   |  2 +-
 4 files changed, 28 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
index ff73cc11d47e..fa30e96f27d0 100644
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
@@ -367,7 +368,8 @@ int amdgpu_bo_create_kernel(struct amdgpu_device *adev,
  */
 int amdgpu_bo_create_kernel_at(struct amdgpu_device *adev,
 			       uint64_t offset, uint64_t size,
-			       struct amdgpu_bo **bo_ptr, void **cpu_addr)
+			       struct amdgpu_bo **bo_ptr,
+			       u64 *gpu_addr, void **cpu_addr)
 {
 	struct ttm_operation_ctx ctx = { false, false };
 	unsigned int i;
@@ -377,32 +379,42 @@ int amdgpu_bo_create_kernel_at(struct amdgpu_device *adev,
 	size = ALIGN(size, PAGE_SIZE);
 
 	r = amdgpu_bo_create_reserved(adev, size, PAGE_SIZE,
-				      AMDGPU_GEM_DOMAIN_VRAM, bo_ptr, NULL,
-				      cpu_addr);
+				      AMDGPU_GEM_DOMAIN_CPU,
+				      bo_ptr, NULL, NULL);
 	if (r)
 		return r;
 
 	if ((*bo_ptr) == NULL)
 		return 0;
 
+	(*bo_ptr)->flags = AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS;
+	(*bo_ptr)->flags |= cpu_addr ? AMDGPU_GEM_CREATE_CPU_ACCESS_REQUIRED
+		: AMDGPU_GEM_CREATE_NO_CPU_ACCESS;
+
 	/*
 	 * Remove the original mem node and create a new one at the request
 	 * position.
 	 */
-	if (cpu_addr)
-		amdgpu_bo_kunmap(*bo_ptr);
-
 	ttm_resource_free(&(*bo_ptr)->tbo, &(*bo_ptr)->tbo.resource);
 
 	for (i = 0; i < (*bo_ptr)->placement.num_placement; ++i) {
 		(*bo_ptr)->placements[i].fpfn = offset >> PAGE_SHIFT;
 		(*bo_ptr)->placements[i].lpfn = (offset + size) >> PAGE_SHIFT;
+		(*bo_ptr)->placements[i].mem_type = TTM_PL_VRAM;
+		(*bo_ptr)->placements[i].flags = TTM_PL_FLAG_CONTIGUOUS;
+
+		if (!((*bo_ptr)->flags & AMDGPU_GEM_CREATE_CPU_ACCESS_REQUIRED))
+			(*bo_ptr)->placements[i].flags |= TTM_PL_FLAG_TOPDOWN;
 	}
+
 	r = ttm_bo_mem_space(&(*bo_ptr)->tbo, &(*bo_ptr)->placement,
 			     &(*bo_ptr)->tbo.resource, &ctx);
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

