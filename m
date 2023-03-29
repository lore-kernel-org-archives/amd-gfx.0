Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CF58C6FD18
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Mar 2023 15:48:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7A3B510EB69;
	Wed, 29 Mar 2023 15:48:40 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on20621.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe59::621])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A561E10EB75
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Mar 2023 15:48:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S8xSloabYKvElhiIoL6pbGk93cci0P3oi/gBwbYRDbVUcIaHYnW+aCDjptZcEEA2TJrlDoE5XqzvaPBIbrsPN/Cvzf5UVIOoyQSHZRR862zjHz4nXcz8rddrymUSu7TeCyWZZlaYg5fN7ArUdaq+GUnNe5GCYNj5JgnMTnm4+CAvcqZ0NDsBcfB14aEDQIZHtgBqc90v3PkGdixJEzWUlYLcBhVYDQHic1TX0ykXlmhxvJDwrw/bqZCO8CJRBMT+KUk8P0zPwz1UYoBWflst5pJk6j5NEFONqfKTfieMzeMJQlhPfgyDxZ//K/FpSED9gDFpDE9dYNAB0DE5Iky9WQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BkvhzEpateHuGGSkdz2tiI3LoyhRrkF8xWeB5HlauKU=;
 b=nmm/tkLqPQDIFS2CQDujfEeKyJqk3qnT4pIsyp2+yHWBzwzOHQGBIGtx/XqFS/th2bM3ZDQ4P+BQ4+hc9S6Q7mutUt280jHH15yygnbwb2VMhUf+u3qObxHfTnc6ex7uxfhkpwEy5u59uFW9Ni6j/x6LAS6yb9Qge7BeeIKfeknY9o7YprdrELZ9E2woCEb47ujbpQrI4G4XAxcO4Y2ad9bhxrZoMPCeeRq+VzBPEY8jsZdQoxGYHWLS9l4uO6wRaWNYQb/5vR0hkyQ41O+tEfoOdhutVYfEZlqw6E39B6KdL4xKdfS9U3EVtvwVFOLhCg/WCIYdOvplI02An2tTCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BkvhzEpateHuGGSkdz2tiI3LoyhRrkF8xWeB5HlauKU=;
 b=sPVm6uw8LVNZsYlYS2+sh7PlomQYwBOWMjvKgZ8dG7UjA2nseQW0jdwarpf17O56pZL/lvt1AZnQAHoKvi+TI7IQPF8wtg3RNLR8LlwXU5GPfUhPLR6gC5ulOWIBSL6yEUrF/NbSc2EO1PnTaOPjTvNc3xusD05H3/INIFFo0yI=
Received: from DM6PR02CA0081.namprd02.prod.outlook.com (2603:10b6:5:1f4::22)
 by BN9PR12MB5384.namprd12.prod.outlook.com (2603:10b6:408:105::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.33; Wed, 29 Mar
 2023 15:48:35 +0000
Received: from DM6NAM11FT078.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1f4:cafe::6e) by DM6PR02CA0081.outlook.office365.com
 (2603:10b6:5:1f4::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.20 via Frontend
 Transport; Wed, 29 Mar 2023 15:48:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT078.mail.protection.outlook.com (10.13.173.183) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6254.20 via Frontend Transport; Wed, 29 Mar 2023 15:48:35 +0000
Received: from MUN-L-SHSHARMA.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 29 Mar
 2023 10:48:33 -0500
From: Shashank Sharma <shashank.sharma@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 12/16] drm/amdgpu: use doorbell manager for kfd kernel
 doorbells
Date: Wed, 29 Mar 2023 17:47:49 +0200
Message-ID: <20230329154753.1261-13-shashank.sharma@amd.com>
X-Mailer: git-send-email 2.38.0.windows.1
In-Reply-To: <20230329154753.1261-1-shashank.sharma@amd.com>
References: <20230329154753.1261-1-shashank.sharma@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT078:EE_|BN9PR12MB5384:EE_
X-MS-Office365-Filtering-Correlation-Id: 67adcfbc-19eb-41ae-4eee-08db306d0e56
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ziSExOL4Ne/H5M9SQzSovZZ7RKZJkFPeZu+KnkL9XS2IML4qP3bW6GL2HoKAsUcn0SlymHFlL80Ipt9GfPFPOuGcKrIHLX7hHKCblxZkZcrvNXHySgR/9zrgB7T5dQr+li5iq75/je/Fp2Ak227Ey9vXXE01lguMynIofoBdVFrikZI+rltizKXmO6+t5L+JGmTDgngMhO4tvzwJVqqiXnCo9sdzRkgEvnOYxmnCAhsts7bg4P3/krgNxDiljtXlfdfeBcwqEmOSXwCjrIoLLLT4Rd1Yd/NJgFv8uDu0bT8iRPudWoF0LTZ3eji76C+MRQt1y+Gq2vbyiB2Tfzw7Qo7urz6NKKvPPwSHzSWhzCRDood0GLCOyl09imivnp0KV9K389kWyrS1GAXoqlcZFZhB2KX1/UzuGr0sBu3vKe/5O52goBEbXWbrS+KaMMlMnN5kQj3th1d9EgtZcB+YWfCkvZ4rm+ZNVavpPNu5RRCXRk/WNv1zKh3Dr+IoRrIPZokMMuixuGTlWESk0SLbj935x7roiXxY9ssXbAbFT7PSwHsCGCLndJkwKfb1hBtCHQzelr70tJtJ6eoYsxDFi6w+7WfF3rQROOJprA/Ty/ke7Ud5ZUCDkwuAj084O9fqP/WF2sZBeWw7GE0EZOP8Qwn31yhkRfGyfTHmElPvOQwbTfHChG7+LRJ8hx/xYZ/8bvSgudnrrOnrkSfG/Wbs0ulDCl1WOLRHiwiXNpYwA4E=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(376002)(39860400002)(136003)(396003)(451199021)(46966006)(36840700001)(40470700004)(70586007)(86362001)(36860700001)(70206006)(81166007)(41300700001)(4326008)(82740400003)(6916009)(8676002)(186003)(82310400005)(83380400001)(54906003)(16526019)(316002)(5660300002)(8936002)(36756003)(478600001)(356005)(47076005)(2906002)(7696005)(44832011)(426003)(26005)(1076003)(40480700001)(336012)(40460700003)(6666004)(2616005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2023 15:48:35.2381 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 67adcfbc-19eb-41ae-4eee-08db306d0e56
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT078.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5384
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Mukul
 Joshi <mukul.joshi@amd.com>, Felix Kuehling <felix.kuehling@amd.com>,
 Christian Koenig <christian.koenig@amd.com>,
 Shashank Sharma <shashank.sharma@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This patch:
- adds a doorbell manager structure in kfd device structure.
- plugs-in doorbell manager APIs for KFD kernel doorbell allocations
  an free functions.
- removes the doorbell bitmap, uses the one into the doorbell manager
  structure for all the allocations.
- updates the get_kernel_doorbell and free_kernel_doorbell functions
  accordingly

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian Koenig <christian.koenig@amd.com>
Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_device.c   |   4 +-
 drivers/gpu/drm/amd/amdkfd/kfd_doorbell.c | 109 ++++++----------------
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h     |   3 +
 3 files changed, 35 insertions(+), 81 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
index b8936340742b..a2e4cbddba26 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
@@ -435,8 +435,8 @@ struct kfd_dev *kgd2kfd_probe(struct amdgpu_device *adev, bool vf)
 	atomic_set(&kfd->compute_profile, 0);
 
 	mutex_init(&kfd->doorbell_mutex);
-	memset(&kfd->doorbell_available_index, 0,
-		sizeof(kfd->doorbell_available_index));
+	memset(kfd->kernel_doorbells.doorbell_bitmap, 0,
+	       kfd->kernel_doorbells.size / BITS_PER_LONG);
 
 	atomic_set(&kfd->sram_ecc_flag, 0);
 
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_doorbell.c b/drivers/gpu/drm/amd/amdkfd/kfd_doorbell.c
index cd4e61bf0493..df259f2cc58a 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_doorbell.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_doorbell.c
@@ -61,81 +61,37 @@ size_t kfd_doorbell_process_slice(struct kfd_dev *kfd)
 /* Doorbell calculations for device init. */
 int kfd_doorbell_init(struct kfd_dev *kfd)
 {
-	size_t doorbell_start_offset;
-	size_t doorbell_aperture_size;
-	size_t doorbell_process_limit;
+	int r;
+	struct amdgpu_doorbell_obj *kernel_doorbells = &kfd->kernel_doorbells;
 
-	/*
-	 * With MES enabled, just set the doorbell base as it is needed
-	 * to calculate doorbell physical address.
-	 */
-	if (kfd->shared_resources.enable_mes) {
-		kfd->doorbell_base =
-			kfd->shared_resources.doorbell_physical_address;
-		return 0;
-	}
-
-	/*
-	 * We start with calculations in bytes because the input data might
-	 * only be byte-aligned.
-	 * Only after we have done the rounding can we assume any alignment.
-	 */
-
-	doorbell_start_offset =
-			roundup(kfd->shared_resources.doorbell_start_offset,
-					kfd_doorbell_process_slice(kfd));
-
-	doorbell_aperture_size =
-			rounddown(kfd->shared_resources.doorbell_aperture_size,
-					kfd_doorbell_process_slice(kfd));
-
-	if (doorbell_aperture_size > doorbell_start_offset)
-		doorbell_process_limit =
-			(doorbell_aperture_size - doorbell_start_offset) /
-						kfd_doorbell_process_slice(kfd);
-	else
-		return -ENOSPC;
-
-	if (!kfd->max_doorbell_slices ||
-	    doorbell_process_limit < kfd->max_doorbell_slices)
-		kfd->max_doorbell_slices = doorbell_process_limit;
-
-	kfd->doorbell_base = kfd->shared_resources.doorbell_physical_address +
-				doorbell_start_offset;
-
-	kfd->doorbell_base_dw_offset = doorbell_start_offset / sizeof(u32);
-
-	kfd->doorbell_kernel_ptr = ioremap(kfd->doorbell_base,
-					   kfd_doorbell_process_slice(kfd));
-
-	if (!kfd->doorbell_kernel_ptr)
+	/* Bitmap to dynamically allocate doorbells from kernel page */
+	kernel_doorbells->doorbell_bitmap = bitmap_zalloc(PAGE_SIZE, GFP_KERNEL);
+	if (!kernel_doorbells->doorbell_bitmap) {
+		DRM_ERROR("Failed to allocate kernel doorbell bitmap\n");
 		return -ENOMEM;
+	}
 
-	pr_debug("Doorbell initialization:\n");
-	pr_debug("doorbell base           == 0x%08lX\n",
-			(uintptr_t)kfd->doorbell_base);
-
-	pr_debug("doorbell_base_dw_offset      == 0x%08lX\n",
-			kfd->doorbell_base_dw_offset);
-
-	pr_debug("doorbell_process_limit  == 0x%08lX\n",
-			doorbell_process_limit);
-
-	pr_debug("doorbell_kernel_offset  == 0x%08lX\n",
-			(uintptr_t)kfd->doorbell_base);
-
-	pr_debug("doorbell aperture size  == 0x%08lX\n",
-			kfd->shared_resources.doorbell_aperture_size);
+	/* Alloc and reserve doorbells for KFD kernel usages */
+	kernel_doorbells->size = PAGE_SIZE;
+	r = amdgpu_doorbell_alloc_page(kfd->adev, kernel_doorbells);
+	if (r) {
+		pr_err("failed to allocate kernel doorbells\n");
+		bitmap_free(kernel_doorbells->doorbell_bitmap);
+		return r;
+	}
 
-	pr_debug("doorbell kernel address == %p\n", kfd->doorbell_kernel_ptr);
+	kfd->doorbell_kernel_ptr = kernel_doorbells->cpu_addr;
+	pr_debug("Doorbell kernel address == %p\n", kfd->doorbell_kernel_ptr);
 
 	return 0;
 }
 
 void kfd_doorbell_fini(struct kfd_dev *kfd)
 {
-	if (kfd->doorbell_kernel_ptr)
-		iounmap(kfd->doorbell_kernel_ptr);
+	struct amdgpu_doorbell_obj *kernel_doorbells = &kfd->kernel_doorbells;
+
+	bitmap_free(kernel_doorbells->doorbell_bitmap);
+	amdgpu_doorbell_free_page(kfd->adev, kernel_doorbells);
 }
 
 int kfd_doorbell_mmap(struct kfd_dev *dev, struct kfd_process *process,
@@ -186,24 +142,19 @@ void __iomem *kfd_get_kernel_doorbell(struct kfd_dev *kfd,
 					unsigned int *doorbell_off)
 {
 	u32 inx;
+	struct amdgpu_doorbell_obj *kernel_doorbells = &kfd->kernel_doorbells;
 
 	mutex_lock(&kfd->doorbell_mutex);
-	inx = find_first_zero_bit(kfd->doorbell_available_index,
-					KFD_MAX_NUM_OF_QUEUES_PER_PROCESS);
+	inx = find_first_zero_bit(kernel_doorbells->doorbell_bitmap,
+				  kernel_doorbells->size);
 
-	__set_bit(inx, kfd->doorbell_available_index);
+	__set_bit(inx, kernel_doorbells->doorbell_bitmap);
 	mutex_unlock(&kfd->doorbell_mutex);
 
 	if (inx >= KFD_MAX_NUM_OF_QUEUES_PER_PROCESS)
 		return NULL;
 
-	inx *= kfd->device_info.doorbell_size / sizeof(u32);
-
-	/*
-	 * Calculating the kernel doorbell offset using the first
-	 * doorbell page.
-	 */
-	*doorbell_off = kfd->doorbell_base_dw_offset + inx;
+	*doorbell_off = amdgpu_doorbell_index_on_bar(kfd->adev, kernel_doorbells->bo, inx);
 
 	pr_debug("Get kernel queue doorbell\n"
 			"     doorbell offset   == 0x%08X\n"
@@ -216,12 +167,12 @@ void __iomem *kfd_get_kernel_doorbell(struct kfd_dev *kfd,
 void kfd_release_kernel_doorbell(struct kfd_dev *kfd, u32 __iomem *db_addr)
 {
 	unsigned int inx;
+	struct amdgpu_doorbell_obj *kernel_doorbells = &kfd->kernel_doorbells;
 
-	inx = (unsigned int)(db_addr - kfd->doorbell_kernel_ptr)
-		* sizeof(u32) / kfd->device_info.doorbell_size;
+	inx = (unsigned int)(db_addr - kfd->doorbell_kernel_ptr);
 
 	mutex_lock(&kfd->doorbell_mutex);
-	__clear_bit(inx, kfd->doorbell_available_index);
+	__clear_bit(inx, kernel_doorbells->doorbell_bitmap);
 	mutex_unlock(&kfd->doorbell_mutex);
 }
 
@@ -280,7 +231,7 @@ phys_addr_t kfd_get_process_doorbells(struct kfd_process_device *pdd)
 	if (!pdd->doorbell_index) {
 		int r = kfd_alloc_process_doorbells(pdd->dev,
 						    &pdd->doorbell_index);
-		if (r)
+		if (r < 0)
 			return 0;
 	}
 
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
index 552c3ac85a13..0ed33416c35f 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -346,6 +346,9 @@ struct kfd_dev {
 
 	/* HMM page migration MEMORY_DEVICE_PRIVATE mapping */
 	struct dev_pagemap pgmap;
+
+	/* Kernel doorbells for KFD device */
+	struct amdgpu_doorbell_obj kernel_doorbells;
 };
 
 enum kfd_mempool {
-- 
2.40.0

