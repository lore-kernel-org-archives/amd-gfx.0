Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56129EB64DB
	for <amd-gfx@archiver.kernel.org>; Tue, 20 Jun 2023 17:16:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8B51F10E2FC;
	Tue, 20 Jun 2023 17:16:41 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2059.outbound.protection.outlook.com [40.107.243.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8135110E0A4
 for <amd-gfx@lists.freedesktop.org>; Tue, 20 Jun 2023 17:16:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aFm7AsN7e7REb8gqz4d9tFYuoHnvkOmcLor50nCwX6+Frrf6EYLCHMVLbnDMJGXtr3kYBLfNESAEYF10SxvV7E5PiA1tiMxH8XE6ZP4gJzDjN+i80blDiihDCCHEhLPg2t35YA/jCRM8uGBFZNFhPcQiJ+LQZ6M1gtDYJi9ywkLXq3xGteGx3bZuo+cDmk63/jA90VgV4ou2KAWa8mfw2uAx8J9JoUnW+NspPRMFt6bR9ooN5s9ivamvWig5BGkpKO0b6518Jt2BluWJ+lpcJ/D3jufLLmi/IJCO2YdBaQpWAiMu7yF9/hDhf/N7n2H4juBtrc3fMdbVVt5CR/Hg8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eJ9pd3AnjA5dKMSinCITWYGXROKBdj7J/wgH1iklESA=;
 b=niZtRS8p/RNyrrrtbgo9auvZHJ1NTPDDRJJUnFPM8Mw9LJ2+bfgaeSKo8qh0TuY0xnpJeNZt4J9IBqtA4W89Qxxb+gStGE3oEzVMsvRlusTXnpMcNIoWbpMNLDsTWuQf3MhOfYPab+3qUsvPAtmy0//eIOSOwIC1ujSbJGNawYC0ItWFlTMODBhkiZ/+KFBmcysLkRt6R3LTS4oYnLO03RckgJV9/sQHHneLcjuqa1bSL48cyyAn++DtwGDsSgr/0/RBgP2Byd0vHXYshcV3nzGtr3dM62Ul/hUrGziljfD5TonSn+4Er2VpZhKZ3h2k1fcTyM5g2PGDF1va2Uq18w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eJ9pd3AnjA5dKMSinCITWYGXROKBdj7J/wgH1iklESA=;
 b=0laPsTHtJrpxY5UpXF36YN0TJqaVlzU5gKlABYN7+T7VdzVBURqEkP4zbKFsYokWWia1/vepvVTquWU2tMHw3rVfyWQLiVY+P6V4wMnnq2XiNYEoPRkuRGFYMYhjQClFVtsw0p1khdC/9EbQYhjPmICVXzSu4k/0pEa8+Qn7dE8=
Received: from BY5PR17CA0007.namprd17.prod.outlook.com (2603:10b6:a03:1b8::20)
 by MN2PR12MB4422.namprd12.prod.outlook.com (2603:10b6:208:265::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.37; Tue, 20 Jun
 2023 17:16:36 +0000
Received: from DM6NAM11FT090.eop-nam11.prod.protection.outlook.com
 (2603:10b6:a03:1b8:cafe::42) by BY5PR17CA0007.outlook.office365.com
 (2603:10b6:a03:1b8::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.21 via Frontend
 Transport; Tue, 20 Jun 2023 17:16:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT090.mail.protection.outlook.com (10.13.172.184) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6500.37 via Frontend Transport; Tue, 20 Jun 2023 17:16:35 +0000
Received: from MUN-L-SHSHARMA.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Tue, 20 Jun
 2023 12:16:33 -0500
From: Shashank Sharma <shashank.sharma@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v3 08/12] drm/amdgpu: use doorbell manager for kfd kernel
 doorbells
Date: Tue, 20 Jun 2023 19:16:04 +0200
Message-ID: <20230620171608.2131-9-shashank.sharma@amd.com>
X-Mailer: git-send-email 2.38.0.windows.1
In-Reply-To: <20230620171608.2131-1-shashank.sharma@amd.com>
References: <20230620171608.2131-1-shashank.sharma@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT090:EE_|MN2PR12MB4422:EE_
X-MS-Office365-Filtering-Correlation-Id: 07fff313-2af8-4ff5-5d78-08db71b219f7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Jh2pdNlWg9Tzu4Oy7nCj+u+KQwO704XOkpY7qTbD+SDl+Qx6ed1KJvB5d7TJCmv2y3H0d706qUYNICTuuPvd5YWV8A4dYXB0XpRdt4X6z0BM8qtha1K9P+DzhDcyD7MZTDHqvElBbFV+NkVEa7m0tmVZ/lFxLv3yDCfj4QNaAFtrLE7Rp4q4m2kb0Rq7cQXs14vt1u/OvV9ajmGkGQvyIcIPIpl6vwZYFz2yaYfoBFbUf7fj6BLNPqMyNtBZR46msfol6RoG5c3XEJ0X8OJY0DbYkVPwLmue8nytw74P8QqxamwX23Khgg+Dfxk/gL8W/lpSheAvDrzil+qbJ6zUH/DsaG/SaWgnMnOASCPjMu/6p24r4tTlQfOEnXa3OXlz1mJFcthhg8LsngU+5zZkl5Jfqf0nz2lngzUF4sER93SxwtTK6/xwNzMTBz8eeB514wqzq4GkZNGjoOoeCjy9IMxlmHvDrMjRQXjtQcuLsJY2zK01Ms9M0CqHLrZYseKkjOv/lC/ICO/qZscPXvQ4P3cEhgcbpbezanmllXGArZ8c0fBlkNna1x1aA8f1t4EvSFuQPaazvARUNH3OCGng2cV5dxloTj5Dy7rABH3I/TVCAW6Vv1ZOnvnPvCLzizHOrvH+BZHh4Qxcbjvm+Hh+UNma1j/NB4kFV8/dse6fps4bouk0Jea+lPwzu3R4TqydMWz78qtGlv00VhgVR0vppIzjOOtiQ7QUDFCvdKVcBOT5KH3Ab+QNNWGF+XwZcSKhL//Ugc1mS1JKsgVDHQYN7A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(376002)(39860400002)(136003)(396003)(451199021)(46966006)(36840700001)(40470700004)(6666004)(40460700003)(7696005)(478600001)(36860700001)(47076005)(16526019)(186003)(83380400001)(2616005)(336012)(426003)(26005)(1076003)(82310400005)(36756003)(86362001)(82740400003)(356005)(81166007)(40480700001)(2906002)(8936002)(8676002)(5660300002)(316002)(4326008)(70586007)(6916009)(70206006)(41300700001)(44832011)(54906003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2023 17:16:35.5409 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 07fff313-2af8-4ff5-5d78-08db71b219f7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT090.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4422
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
Cc: Alex
 Deucher <alexander.deucher@amd.com>, Felix Kuehling <Felix.Kuehling@amd.com>,
 Christian Koenig <christian.koenig@amd.com>, arvind.yadav@amd.com,
 Shashank Sharma <shashank.sharma@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This patch:
- adds a doorbell bo in kfd device structure.
- creates doorbell page for kfd kernel usages.
- updates the get_kernel_doorbell and free_kernel_doorbell functions
  accordingly

V2: Do not use wrapper API, use direct amdgpu_create_kernel(Alex)
V3:
 - Move single variable declaration below (Christian)
 - Add a to-do item to reuse the KGD kernel level doorbells for
   KFD for non-MES cases, instead of reserving one page (Felix)

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian Koenig <christian.koenig@amd.com>
Cc: Felix Kuehling <Felix.Kuehling@amd.com>
Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_device.c   |   2 -
 drivers/gpu/drm/amd/amdkfd/kfd_doorbell.c | 109 +++++++---------------
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h     |   6 ++
 3 files changed, 39 insertions(+), 78 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
index 00f528eb9812..36fbe9c840ee 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
@@ -437,8 +437,6 @@ struct kfd_dev *kgd2kfd_probe(struct amdgpu_device *adev, bool vf)
 	atomic_set(&kfd->compute_profile, 0);
 
 	mutex_init(&kfd->doorbell_mutex);
-	memset(&kfd->doorbell_available_index, 0,
-		sizeof(kfd->doorbell_available_index));
 
 	atomic_set(&kfd->sram_ecc_flag, 0);
 
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_doorbell.c b/drivers/gpu/drm/amd/amdkfd/kfd_doorbell.c
index 38c9e1ca6691..f7d45057ed32 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_doorbell.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_doorbell.c
@@ -61,81 +61,46 @@ size_t kfd_doorbell_process_slice(struct kfd_dev *kfd)
 /* Doorbell calculations for device init. */
 int kfd_doorbell_init(struct kfd_dev *kfd)
 {
-	size_t doorbell_start_offset;
-	size_t doorbell_aperture_size;
-	size_t doorbell_process_limit;
+	int size = PAGE_SIZE;
+	int r;
 
 	/*
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
+	 * Todo: KFD kernel level operations need only one doorbell for
+	 * ring test/HWS. So instead of reserving a whole page here for
+	 * kernel, reserve and consume a doorbell from existing KGD kernel
+	 * doorbell page.
 	 */
 
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
+	kfd->doorbell_bitmap = bitmap_zalloc(size / sizeof(u32), GFP_KERNEL);
+	if (!kfd->doorbell_bitmap) {
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
-
-	pr_debug("doorbell kernel address == %p\n", kfd->doorbell_kernel_ptr);
+	/* Alloc a doorbell page for KFD kernel usages */
+	r = amdgpu_bo_create_kernel(kfd->adev,
+				    size,
+				    PAGE_SIZE,
+				    AMDGPU_GEM_DOMAIN_DOORBELL,
+				    &kfd->doorbells,
+				    NULL,
+				    (void **)&kfd->doorbell_kernel_ptr);
+	if (r) {
+		pr_err("failed to allocate kernel doorbells\n");
+		bitmap_free(kfd->doorbell_bitmap);
+		return r;
+	}
 
+	pr_debug("Doorbell kernel address == %p\n", kfd->doorbell_kernel_ptr);
 	return 0;
 }
 
 void kfd_doorbell_fini(struct kfd_dev *kfd)
 {
-	if (kfd->doorbell_kernel_ptr)
-		iounmap(kfd->doorbell_kernel_ptr);
+	bitmap_free(kfd->doorbell_bitmap);
+	amdgpu_bo_free_kernel(&kfd->doorbells, NULL,
+			     (void **)&kfd->doorbell_kernel_ptr);
 }
 
 int kfd_doorbell_mmap(struct kfd_dev *dev, struct kfd_process *process,
@@ -188,22 +153,15 @@ void __iomem *kfd_get_kernel_doorbell(struct kfd_dev *kfd,
 	u32 inx;
 
 	mutex_lock(&kfd->doorbell_mutex);
-	inx = find_first_zero_bit(kfd->doorbell_available_index,
-					KFD_MAX_NUM_OF_QUEUES_PER_PROCESS);
+	inx = find_first_zero_bit(kfd->doorbell_bitmap, PAGE_SIZE / sizeof(u32));
 
-	__set_bit(inx, kfd->doorbell_available_index);
+	__set_bit(inx, kfd->doorbell_bitmap);
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
+	*doorbell_off = amdgpu_doorbell_index_on_bar(kfd->adev, kfd->doorbells, inx);
 
 	pr_debug("Get kernel queue doorbell\n"
 			"     doorbell offset   == 0x%08X\n"
@@ -217,11 +175,10 @@ void kfd_release_kernel_doorbell(struct kfd_dev *kfd, u32 __iomem *db_addr)
 {
 	unsigned int inx;
 
-	inx = (unsigned int)(db_addr - kfd->doorbell_kernel_ptr)
-		* sizeof(u32) / kfd->device_info.doorbell_size;
+	inx = (unsigned int)(db_addr - kfd->doorbell_kernel_ptr);
 
 	mutex_lock(&kfd->doorbell_mutex);
-	__clear_bit(inx, kfd->doorbell_available_index);
+	__clear_bit(inx, kfd->doorbell_bitmap);
 	mutex_unlock(&kfd->doorbell_mutex);
 }
 
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
index 94a438956868..42c215782d72 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -349,6 +349,12 @@ struct kfd_dev {
 
 	/* HMM page migration MEMORY_DEVICE_PRIVATE mapping */
 	struct dev_pagemap pgmap;
+
+	/* Kernel doorbells for KFD device */
+	struct amdgpu_bo *doorbells;
+
+	/* bitmap for dynamic doorbell allocation from this object */
+	unsigned long *doorbell_bitmap;
 };
 
 enum kfd_mempool {
-- 
2.40.1

