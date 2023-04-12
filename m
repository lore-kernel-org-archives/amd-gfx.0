Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CF75C7619A
	for <amd-gfx@archiver.kernel.org>; Wed, 12 Apr 2023 16:26:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D804110E8AA;
	Wed, 12 Apr 2023 16:26:41 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on20608.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe59::608])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C98EC10E8A6
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 Apr 2023 16:26:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aV5/SmUBm0EtlSDzlOieLCSluVErBuIlrwWzBBlzSv4wYI7HrbkVKQEOvb6DLxaThImAqSqH9ymUTFDiLKb1i7HXsGrSWgVsDsUAFJYEOcchX/l/YRkHRioYGROkwnePBD+8FLv9M1eGTYeCMEF9VHqbzplh7M5fpijl5QO1tmHrgob1AoUmlYw0/nwZv/DgVSDbVO//24rmiYYyT0XBZ+G4trDRblRjAxtQRXVWpFug0mCtthQUDSt/ADzgoXlAlACVvUg17OP1i7fgmcLGMA8JPXjMwXX+4ofX/GLV18JHUsitwEilIhsSf3MnDDwY9cvAcp1LnxrSLO4chWmYMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TOZAwHWQMQ3FlPYNZFne1FL7v/92/ANC3w6UyEnon60=;
 b=letA3dfDd9XEI7VafNnyIKgIYCEL0X7Wle3DdAfeXJwdJzXPaSD23Wu53LGFOaMKNR8MrjmymM4n64a28xZBrE5KbkL1AA06iK0wILTLVXjZoOMjCexyOCNByeqhD+EE9E0buWfwFjUkk91v9JW8WQ5dg7tC6AOPNbCkTO9MZ9dB3H4+zWw/CW/qYP2iz3jnmTjCRmJQECzXPJ/8ge3f/2qeLsPfc2GfVvEvDVmGxAW7MhEygkhirqcr9cxL2zTSVCkGYsR+XyWFfwwMOMS7y4ZenwTNWlXNmg2sU38+FL1EwbhnvMdv1ZMvLeeBHgvZS/qmqZCFA+9kh4grNfdc5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TOZAwHWQMQ3FlPYNZFne1FL7v/92/ANC3w6UyEnon60=;
 b=fYNCI1vu6PLncucIrtTDGqK9bn69IjyZVgFFH/c/80QcmRAiHZJhpu5/XWMPP8tPGHalph3fjFFsei2kjcxHa0JUPHVMMU2rUMwE+dxYS6Yq+N6RFe/Izg2govYoi/NWRVmAdcEdECP0F1xysXFarJtoP+pVIND/IjunIf947PI=
Received: from BLAPR03CA0003.namprd03.prod.outlook.com (2603:10b6:208:32b::8)
 by SA1PR12MB7295.namprd12.prod.outlook.com (2603:10b6:806:2b6::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.36; Wed, 12 Apr
 2023 16:26:35 +0000
Received: from BL02EPF000100D2.namprd05.prod.outlook.com
 (2603:10b6:208:32b:cafe::a) by BLAPR03CA0003.outlook.office365.com
 (2603:10b6:208:32b::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.40 via Frontend
 Transport; Wed, 12 Apr 2023 16:26:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF000100D2.mail.protection.outlook.com (10.167.241.206) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6298.27 via Frontend Transport; Wed, 12 Apr 2023 16:26:35 +0000
Received: from MUN-L-SHSHARMA.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 12 Apr
 2023 11:26:33 -0500
From: Shashank Sharma <shashank.sharma@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2 08/12] drm/amdgpu: use doorbell manager for kfd kernel
 doorbells
Date: Wed, 12 Apr 2023 18:25:32 +0200
Message-ID: <20230412162537.1357-9-shashank.sharma@amd.com>
X-Mailer: git-send-email 2.38.0.windows.1
In-Reply-To: <20230412162537.1357-1-shashank.sharma@amd.com>
References: <20230412162537.1357-1-shashank.sharma@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF000100D2:EE_|SA1PR12MB7295:EE_
X-MS-Office365-Filtering-Correlation-Id: 28fd1af9-015e-48f2-77f6-08db3b72af33
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lXLx+gTcKv1wetPqlQFcXv3Eui3c/Bb/kjxG9/Mmsg/dC7kmZIj3C48jBPwjMLom5Ox4rFVapgfZGLfHbi4cspLOFQWAanfI1TF5qJU9QFhkypp9DXOqFAe1OALgHxEkUIjkJ81KgLH7ILlOl3s1frFDbu0nJgIVfzmtcgdd6GBgQn+5259wtvZgVrAeiarrAvB6x7Dux6XVFII/YfL0qbbpCGLc8xD39s4YTXAXaI9BlzghLPXVUHnlJPAV8KjtL65+Vo17xZdkM0Ee1KRrA6zawgGNCI6nu46Nis1fyZ+YIWSOGxiyfP6bZ9NX7gyg5DD7SJnpazHTcUAx8K7FZ5Fdd52vrNSmw6KyjJKDiy05Zs7nuMvuuF3IehpsD7AWhiB5ika5SMzwRxN9JpQrK6YuwN86RPV10IZT9dXN7FEoqkdYTJoi/JQx4S8Uzd1P5Yrdct0hChdNv4J/171OjmYh92yLfpyyggO55TJLYyKkWXZRFYRm31cCvTdOl29VI4oiLr990xyv2zJ9Lbop8oCw6S5q8UkMnmC6jtBbmehaLcR0n6vUVBZI2B1L0ZjCjcoL1e0770my87eixARWTxqeR02bCgNF0G6cfoOp1pQJ9fwe9bp+IJx2jWNvzRkRYe18XTzRf4k8HjmLHua5wrAJddzbYNv/aDjshuzWUCSU/RQ8bRTEgpui7f66lPB3d1DZN/2N8PoyfioPlBej+r427jv+uYoVIFqCdgEmVxlQVUHHRutgWPZogJCrx50J/Shs4zHUG8KEE1spoEU0+0B7gh05+hKePCprRlkPoDE=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(396003)(346002)(39860400002)(136003)(451199021)(46966006)(36840700001)(40470700004)(81166007)(86362001)(36756003)(7696005)(70586007)(316002)(6916009)(54906003)(41300700001)(4326008)(478600001)(8676002)(70206006)(40480700001)(5660300002)(36860700001)(8936002)(82310400005)(44832011)(2906002)(356005)(82740400003)(16526019)(186003)(83380400001)(1076003)(26005)(2616005)(336012)(426003)(47076005)(40460700003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2023 16:26:35.4284 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 28fd1af9-015e-48f2-77f6-08db3b72af33
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF000100D2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7295
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
Cc: mukul.joshi@amd.com, Shashank Sharma <shashank.sharma@amd.com>,
 Felix Kuehling <Felix.Kuehling@amd.com>, arvind.yadav@amd.com,
 Alex Deucher <alexander.deucher@amd.com>, contactshashanksharma@gmail.com,
 Christian Koenig <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This patch:
- adds a doorbell bo in kfd device structure.
- creates doorbell page for kfd kernel usages.
- updates the get_kernel_doorbell and free_kernel_doorbell functions
  accordingly

V2: Do not use wrapper API, use direct amdgpu_create_kernel(Alex)

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian Koenig <christian.koenig@amd.com>
Cc: Felix Kuehling <Felix.Kuehling@amd.com>
Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_device.c   |   2 -
 drivers/gpu/drm/amd/amdkfd/kfd_doorbell.c | 110 ++++++----------------
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h     |   6 ++
 3 files changed, 36 insertions(+), 82 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
index b8936340742b..49e3c4e021af 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
@@ -435,8 +435,6 @@ struct kfd_dev *kgd2kfd_probe(struct amdgpu_device *adev, bool vf)
 	atomic_set(&kfd->compute_profile, 0);
 
 	mutex_init(&kfd->doorbell_mutex);
-	memset(&kfd->doorbell_available_index, 0,
-		sizeof(kfd->doorbell_available_index));
 
 	atomic_set(&kfd->sram_ecc_flag, 0);
 
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_doorbell.c b/drivers/gpu/drm/amd/amdkfd/kfd_doorbell.c
index cd4e61bf0493..82b4a56b0afc 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_doorbell.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_doorbell.c
@@ -61,81 +61,39 @@ size_t kfd_doorbell_process_slice(struct kfd_dev *kfd)
 /* Doorbell calculations for device init. */
 int kfd_doorbell_init(struct kfd_dev *kfd)
 {
-	size_t doorbell_start_offset;
-	size_t doorbell_aperture_size;
-	size_t doorbell_process_limit;
+	int r;
+	int size = PAGE_SIZE;
 
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
@@ -188,22 +146,15 @@ void __iomem *kfd_get_kernel_doorbell(struct kfd_dev *kfd,
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
@@ -217,11 +168,10 @@ void kfd_release_kernel_doorbell(struct kfd_dev *kfd, u32 __iomem *db_addr)
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
 
@@ -280,7 +230,7 @@ phys_addr_t kfd_get_process_doorbells(struct kfd_process_device *pdd)
 	if (!pdd->doorbell_index) {
 		int r = kfd_alloc_process_doorbells(pdd->dev,
 						    &pdd->doorbell_index);
-		if (r)
+		if (r < 0)
 			return 0;
 	}
 
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
index 552c3ac85a13..0b199eb6dc88 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -346,6 +346,12 @@ struct kfd_dev {
 
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
2.40.0

