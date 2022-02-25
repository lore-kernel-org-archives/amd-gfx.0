Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2AC8C433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 25 Feb 2022 18:06:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AF3D810E91B;
	Fri, 25 Feb 2022 18:06:49 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2073.outbound.protection.outlook.com [40.107.237.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E0CEB10E90E
 for <amd-gfx@lists.freedesktop.org>; Fri, 25 Feb 2022 18:06:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VYKRmwPI3bgmNzgt/s2X8M0d/O4/A9YwMDNRyYKk8pZRsjaqky4K0clMm6Tp3uEhFULOe2Zy3TS0NGpA5rdYbqdvppCC3HBrTZV0BIyfctL8pWmGCRcYuswFNK1+rWIdejV3NhT5bcd+kZteQNDVqfZ0c7a8m4g5QqA1JBw0VaybwQYPmBjdSOGBo4P7g30GNcWhMmS3pRUDMi2kFjXhHx0gqqTQFeu+fd9LBXSKd5gXy+wCaECH84QjVlcuyEFO+6YciP7f2VozmCOrwseQXe67ADXyJ6N+JtY8dnrV/1dvSzmJrU72OJouZGYwnktu0ArZAV/E9LerASo5EE5f8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Suu+xsULD2VZoEAeVORjo/DLG+evayLF4nO2F3pF3r0=;
 b=bhgorpbrb2OSYrxmSXvYuxiAI9E3j/6tCR5tCIOyIbpqY3Q1GHWZNI8buy/BilyDsP4mUFuenTCzs8jB7+Qa8kJ7qZiPKDfCwGsyL7oilyAW3GX3eiFehYnbor+l0hoat7wYcQqNdjkpiBtM/0nY3xOrAqM0HfbG7/F+cX4vsml7IHewG6iXgCGBy+/cPochcwPTBJMht9uhxWmwwEv7i5SZ/HppkTjLYYn4y38OltJOtjAeC4u2roFYDxjxxt3Ra7+hYyuMm3V7Xc/CaY2vLbCB/SeIRVoKg1M4Ec26L3YlKwxU50yShvUazcHzyffhRtX7dU7eYND1XS3v4Y/Nfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Suu+xsULD2VZoEAeVORjo/DLG+evayLF4nO2F3pF3r0=;
 b=tXVRq2W1UAit6J2qGMhTmZzZ5f7C04Shv8HzP5zVU5Nujdy3O9SGk43O6u9hGGPK63WOFnj/mdEfoUfQeNBPgL6NolQf0iwG434GzJQjgyGJaHsDr7LFKoq3lJ+REhIv6EqMDq9NHGOmp0L+2A+M6x4sEzLNCafg2cwBGmPJMq4=
Received: from BN0PR10CA0009.namprd10.prod.outlook.com (2603:10b6:408:143::6)
 by BYAPR12MB3304.namprd12.prod.outlook.com (2603:10b6:a03:139::33)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.26; Fri, 25 Feb
 2022 18:06:41 +0000
Received: from BN8NAM11FT052.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:143:cafe::5b) by BN0PR10CA0009.outlook.office365.com
 (2603:10b6:408:143::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.21 via Frontend
 Transport; Fri, 25 Feb 2022 18:06:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT052.mail.protection.outlook.com (10.13.177.210) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5017.22 via Frontend Transport; Fri, 25 Feb 2022 18:06:41 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Fri, 25 Feb
 2022 12:06:35 -0600
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v4 6/9] drm/amdkfd: Add migration SMI event
Date: Fri, 25 Feb 2022 13:06:16 -0500
Message-ID: <20220225180619.21732-7-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220225180619.21732-1-Philip.Yang@amd.com>
References: <20220225180619.21732-1-Philip.Yang@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a0743a04-0c74-4550-347b-08d9f889930f
X-MS-TrafficTypeDiagnostic: BYAPR12MB3304:EE_
X-Microsoft-Antispam-PRVS: <BYAPR12MB330400B85FB9121394657087E63E9@BYAPR12MB3304.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: InI5g02ddjyVkhAkv6KCsCbPJF5imaZmydigMSeXoFUcEPE9AvLitMGJuZlO0/XIFpOXeW0OMURk+X3XEMon0P6ysxJM3btMnE5FDwbYHrwZz+CTto/L2C4XJU7KMj5Np415XopUDERTzE7DN2SNDF5lzSgHXz1L/OdVOjPWXoOD7he5LvMNtQOECtXL0SmGIoH/+o3Kg7S2UFatX25xRuhoNkkPzr3eUduzpBdWxKijyKGE4fvcjvCtcN5LPpzj+5D+nydZPFupjnPFIOiY4Ejkd0QSKeOxPptFsoWQgUdlkcIflndPOO4jPbdaJvfNgKTwifaXwggLkCKcLnnatUkMI2AFb8nOuQh3nbfU6zOVdQ2V4GpiDxrwsefjo4Svv11DRuV8Sfl6BByNcpIFoqVpLGb57oEgw77SZumoycJ2KNJSwZR6IwVhJVgIqWYRRdQRCHK0hHZWFJNvoV7lJhiLL24YffHoxClLWur6uKftUDd5XsxNHWbUeCylWp8LtLuSE6XETzGU9xTl3yJQ9fVLiG1kgM5PbMgeLYL9/IBAzF0oKhn+a6T5qQABSjnb/oDEuBxzqVoA5qqsWEJ0I2Leyzar8kyvcQDyJr3fqjjyqXfoL/uXXSg/kUFGxgrAqXpnqAFQfN+XGyJRU23Jt1qyPj+OI6KbjbCVWDKfn6szmWf+vnttMUMAQerzU+3Ru3ZJYvIBSIk9DvbyRG6ULw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(16526019)(2906002)(47076005)(36860700001)(8936002)(40460700003)(1076003)(2616005)(336012)(4326008)(26005)(8676002)(70206006)(426003)(186003)(70586007)(316002)(6916009)(5660300002)(36756003)(356005)(30864003)(6666004)(7696005)(81166007)(54906003)(86362001)(82310400004)(508600001)(83380400001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2022 18:06:41.0466 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a0743a04-0c74-4550-347b-08d9f889930f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT052.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3304
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
Cc: Philip Yang <Philip.Yang@amd.com>, felix.kuehling@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

For migration start and end event, output timestamp when migration
starts, ends, svm range address and size, GPU id of migration source and
destination and svm range attributes,

Migration trigger could be prefetch, CPU or GPU page fault and TTM
eviction.

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_migrate.c    | 53 ++++++++++++++++-----
 drivers/gpu/drm/amd/amdkfd/kfd_migrate.h    |  5 +-
 drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c | 22 +++++++++
 drivers/gpu/drm/amd/amdkfd/kfd_smi_events.h |  8 ++++
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c        | 16 ++++---
 5 files changed, 83 insertions(+), 21 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
index 7f689094be5a..334af36a9281 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
@@ -32,6 +32,7 @@
 #include "kfd_priv.h"
 #include "kfd_svm.h"
 #include "kfd_migrate.h"
+#include "kfd_smi_events.h"
 
 #ifdef dev_fmt
 #undef dev_fmt
@@ -402,8 +403,9 @@ svm_migrate_copy_to_vram(struct amdgpu_device *adev, struct svm_range *prange,
 static long
 svm_migrate_vma_to_vram(struct amdgpu_device *adev, struct svm_range *prange,
 			struct vm_area_struct *vma, uint64_t start,
-			uint64_t end)
+			uint64_t end, uint32_t trigger)
 {
+	struct kfd_process *p = container_of(prange->svms, struct kfd_process, svms);
 	uint64_t npages = (end - start) >> PAGE_SHIFT;
 	struct kfd_process_device *pdd;
 	struct dma_fence *mfence = NULL;
@@ -431,6 +433,11 @@ svm_migrate_vma_to_vram(struct amdgpu_device *adev, struct svm_range *prange,
 	migrate.dst = migrate.src + npages;
 	scratch = (dma_addr_t *)(migrate.dst + npages);
 
+	kfd_smi_event_migration_start(adev->kfd.dev, p->lead_thread->pid,
+				      start >> PAGE_SHIFT, end >> PAGE_SHIFT,
+				      0, adev->kfd.dev->id, prange->prefetch_loc,
+				      prange->preferred_loc, trigger);
+
 	r = migrate_vma_setup(&migrate);
 	if (r) {
 		dev_err(adev->dev, "%s: vma setup fail %d range [0x%lx 0x%lx]\n",
@@ -459,6 +466,10 @@ svm_migrate_vma_to_vram(struct amdgpu_device *adev, struct svm_range *prange,
 	svm_migrate_copy_done(adev, mfence);
 	migrate_vma_finalize(&migrate);
 
+	kfd_smi_event_migration_end(adev->kfd.dev, p->lead_thread->pid,
+				    start >> PAGE_SHIFT, end >> PAGE_SHIFT,
+				    0, adev->kfd.dev->id, trigger);
+
 	svm_range_dma_unmap(adev->dev, scratch, 0, npages);
 	svm_range_free_dma_mappings(prange);
 
@@ -480,6 +491,7 @@ svm_migrate_vma_to_vram(struct amdgpu_device *adev, struct svm_range *prange,
  * @prange: range structure
  * @best_loc: the device to migrate to
  * @mm: the process mm structure
+ * @trigger: reason of migration
  *
  * Context: Process context, caller hold mmap read lock, svms lock, prange lock
  *
@@ -488,7 +500,7 @@ svm_migrate_vma_to_vram(struct amdgpu_device *adev, struct svm_range *prange,
  */
 static int
 svm_migrate_ram_to_vram(struct svm_range *prange, uint32_t best_loc,
-			struct mm_struct *mm)
+			struct mm_struct *mm, uint32_t trigger)
 {
 	unsigned long addr, start, end;
 	struct vm_area_struct *vma;
@@ -525,7 +537,7 @@ svm_migrate_ram_to_vram(struct svm_range *prange, uint32_t best_loc,
 			break;
 
 		next = min(vma->vm_end, end);
-		r = svm_migrate_vma_to_vram(adev, prange, vma, addr, next);
+		r = svm_migrate_vma_to_vram(adev, prange, vma, addr, next, trigger);
 		if (r < 0) {
 			pr_debug("failed %ld to migrate\n", r);
 			break;
@@ -640,8 +652,10 @@ svm_migrate_copy_to_ram(struct amdgpu_device *adev, struct svm_range *prange,
 
 static long
 svm_migrate_vma_to_ram(struct amdgpu_device *adev, struct svm_range *prange,
-		       struct vm_area_struct *vma, uint64_t start, uint64_t end)
+		       struct vm_area_struct *vma, uint64_t start, uint64_t end,
+		       uint32_t trigger)
 {
+	struct kfd_process *p = container_of(prange->svms, struct kfd_process, svms);
 	uint64_t npages = (end - start) >> PAGE_SHIFT;
 	unsigned long upages = npages;
 	unsigned long cpages = 0;
@@ -670,6 +684,11 @@ svm_migrate_vma_to_ram(struct amdgpu_device *adev, struct svm_range *prange,
 	migrate.dst = migrate.src + npages;
 	scratch = (dma_addr_t *)(migrate.dst + npages);
 
+	kfd_smi_event_migration_start(adev->kfd.dev, p->lead_thread->pid,
+				      start >> PAGE_SHIFT, end >> PAGE_SHIFT,
+				      adev->kfd.dev->id, 0, prange->prefetch_loc,
+				      prange->preferred_loc, trigger);
+
 	r = migrate_vma_setup(&migrate);
 	if (r) {
 		dev_err(adev->dev, "%s: vma setup fail %d range [0x%lx 0x%lx]\n",
@@ -700,6 +719,11 @@ svm_migrate_vma_to_ram(struct amdgpu_device *adev, struct svm_range *prange,
 
 	svm_migrate_copy_done(adev, mfence);
 	migrate_vma_finalize(&migrate);
+
+	kfd_smi_event_migration_end(adev->kfd.dev, p->lead_thread->pid,
+				    start >> PAGE_SHIFT, end >> PAGE_SHIFT,
+				    adev->kfd.dev->id, 0, trigger);
+
 	svm_range_dma_unmap(adev->dev, scratch, 0, npages);
 
 out_free:
@@ -719,13 +743,15 @@ svm_migrate_vma_to_ram(struct amdgpu_device *adev, struct svm_range *prange,
  * svm_migrate_vram_to_ram - migrate svm range from device to system
  * @prange: range structure
  * @mm: process mm, use current->mm if NULL
+ * @trigger: reason of migration
  *
  * Context: Process context, caller hold mmap read lock, svms lock, prange lock
  *
  * Return:
  * 0 - OK, otherwise error code
  */
-int svm_migrate_vram_to_ram(struct svm_range *prange, struct mm_struct *mm)
+int svm_migrate_vram_to_ram(struct svm_range *prange, struct mm_struct *mm,
+			    uint32_t trigger)
 {
 	struct amdgpu_device *adev;
 	struct vm_area_struct *vma;
@@ -763,7 +789,7 @@ int svm_migrate_vram_to_ram(struct svm_range *prange, struct mm_struct *mm)
 			break;
 
 		next = min(vma->vm_end, end);
-		r = svm_migrate_vma_to_ram(adev, prange, vma, addr, next);
+		r = svm_migrate_vma_to_ram(adev, prange, vma, addr, next, trigger);
 		if (r < 0) {
 			pr_debug("failed %ld to migrate\n", r);
 			break;
@@ -786,6 +812,7 @@ int svm_migrate_vram_to_ram(struct svm_range *prange, struct mm_struct *mm)
  * @prange: range structure
  * @best_loc: the device to migrate to
  * @mm: process mm, use current->mm if NULL
+ * @trigger: reason of migration
  *
  * Context: Process context, caller hold mmap read lock, svms lock, prange lock
  *
@@ -794,7 +821,7 @@ int svm_migrate_vram_to_ram(struct svm_range *prange, struct mm_struct *mm)
  */
 static int
 svm_migrate_vram_to_vram(struct svm_range *prange, uint32_t best_loc,
-			 struct mm_struct *mm)
+			 struct mm_struct *mm, uint32_t trigger)
 {
 	int r, retries = 3;
 
@@ -806,7 +833,7 @@ svm_migrate_vram_to_vram(struct svm_range *prange, uint32_t best_loc,
 	pr_debug("from gpu 0x%x to gpu 0x%x\n", prange->actual_loc, best_loc);
 
 	do {
-		r = svm_migrate_vram_to_ram(prange, mm);
+		r = svm_migrate_vram_to_ram(prange, mm, trigger);
 		if (r)
 			return r;
 	} while (prange->actual_loc && --retries);
@@ -814,17 +841,17 @@ svm_migrate_vram_to_vram(struct svm_range *prange, uint32_t best_loc,
 	if (prange->actual_loc)
 		return -EDEADLK;
 
-	return svm_migrate_ram_to_vram(prange, best_loc, mm);
+	return svm_migrate_ram_to_vram(prange, best_loc, mm, trigger);
 }
 
 int
 svm_migrate_to_vram(struct svm_range *prange, uint32_t best_loc,
-		    struct mm_struct *mm)
+		    struct mm_struct *mm, uint32_t trigger)
 {
 	if  (!prange->actual_loc)
-		return svm_migrate_ram_to_vram(prange, best_loc, mm);
+		return svm_migrate_ram_to_vram(prange, best_loc, mm, trigger);
 	else
-		return svm_migrate_vram_to_vram(prange, best_loc, mm);
+		return svm_migrate_vram_to_vram(prange, best_loc, mm, trigger);
 
 }
 
@@ -893,7 +920,7 @@ static vm_fault_t svm_migrate_to_ram(struct vm_fault *vmf)
 		goto out_unlock_prange;
 	}
 
-	r = svm_migrate_vram_to_ram(prange, mm);
+	r = svm_migrate_vram_to_ram(prange, mm, KFD_MIGRATE_TRIGGER_PAGEFAULT_CPU);
 	if (r)
 		pr_debug("failed %d migrate 0x%p [0x%lx 0x%lx] to ram\n", r,
 			 prange, prange->start, prange->last);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.h b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.h
index 2f5b3394c9ed..b3f0754b32fa 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.h
@@ -41,8 +41,9 @@ enum MIGRATION_COPY_DIR {
 };
 
 int svm_migrate_to_vram(struct svm_range *prange,  uint32_t best_loc,
-			struct mm_struct *mm);
-int svm_migrate_vram_to_ram(struct svm_range *prange, struct mm_struct *mm);
+			struct mm_struct *mm, uint32_t trigger);
+int svm_migrate_vram_to_ram(struct svm_range *prange, struct mm_struct *mm,
+			    uint32_t trigger);
 unsigned long
 svm_migrate_addr_to_pfn(struct amdgpu_device *adev, unsigned long addr);
 
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c b/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
index 8e147a175fea..3fb987f9e637 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
@@ -260,6 +260,28 @@ void kfd_smi_event_page_fault_end(struct kfd_dev *dev, pid_t pid,
 			  pid, address, dev->id, migration ? 'M' : 'U');
 }
 
+void kfd_smi_event_migration_start(struct kfd_dev *dev, pid_t pid,
+				   unsigned long start, unsigned long end,
+				   uint32_t from, uint32_t to,
+				   uint32_t prefetch_loc, uint32_t preferred_loc,
+				   uint32_t trigger)
+{
+	kfd_smi_event_add(pid, dev, KFD_SMI_EVENT_MIGRATE_START,
+			  "%lld -%d @%lx(%lx) %x->%x %x:%x %d\n",
+			  ktime_get_boottime_ns(), pid, start, end - start,
+			  from, to, prefetch_loc, preferred_loc, trigger);
+}
+
+void kfd_smi_event_migration_end(struct kfd_dev *dev, pid_t pid,
+				 unsigned long start, unsigned long end,
+				 uint32_t from, uint32_t to, uint32_t trigger)
+{
+	kfd_smi_event_add(pid, dev, KFD_SMI_EVENT_MIGRATE_END,
+			  "%lld -%d @%lx(%lx) %x->%x %d\n",
+			  ktime_get_boottime_ns(), pid, start, end - start,
+			  from, to, trigger);
+}
+
 int kfd_smi_event_open(struct kfd_dev *dev, uint32_t *fd)
 {
 	struct kfd_smi_client *client;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.h b/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.h
index 7903718cd9eb..ec5d74a2fef4 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.h
@@ -34,4 +34,12 @@ void kfd_smi_event_page_fault_start(struct kfd_dev *dev, pid_t pid,
 				    ktime_t ts);
 void kfd_smi_event_page_fault_end(struct kfd_dev *dev, pid_t pid,
 				  unsigned long address, bool migration);
+void kfd_smi_event_migration_start(struct kfd_dev *dev, pid_t pid,
+			     unsigned long start, unsigned long end,
+			     uint32_t from, uint32_t to,
+			     uint32_t prefetch_loc, uint32_t preferred_loc,
+			     uint32_t trigger);
+void kfd_smi_event_migration_end(struct kfd_dev *dev, pid_t pid,
+			     unsigned long start, unsigned long end,
+			     uint32_t from, uint32_t to, uint32_t trigger);
 #endif
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index c6ea52340abc..35b2a0f63521 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -2792,7 +2792,8 @@ svm_range_restore_pages(struct amdgpu_device *adev, unsigned int pasid,
 	if (prange->actual_loc != best_loc) {
 		migration = true;
 		if (best_loc) {
-			r = svm_migrate_to_vram(prange, best_loc, mm);
+			r = svm_migrate_to_vram(prange, best_loc, mm,
+					KFD_MIGRATE_TRIGGER_PAGEFAULT_GPU);
 			if (r) {
 				pr_debug("svm_migrate_to_vram failed (%d) at %llx, falling back to system memory\n",
 					 r, addr);
@@ -2800,12 +2801,14 @@ svm_range_restore_pages(struct amdgpu_device *adev, unsigned int pasid,
 				 * VRAM failed
 				 */
 				if (prange->actual_loc)
-					r = svm_migrate_vram_to_ram(prange, mm);
+					r = svm_migrate_vram_to_ram(prange, mm,
+					   KFD_MIGRATE_TRIGGER_PAGEFAULT_GPU);
 				else
 					r = 0;
 			}
 		} else {
-			r = svm_migrate_vram_to_ram(prange, mm);
+			r = svm_migrate_vram_to_ram(prange, mm,
+					KFD_MIGRATE_TRIGGER_PAGEFAULT_GPU);
 		}
 		if (r) {
 			pr_debug("failed %d to migrate svms %p [0x%lx 0x%lx]\n",
@@ -3128,12 +3131,12 @@ svm_range_trigger_migration(struct mm_struct *mm, struct svm_range *prange,
 		return 0;
 
 	if (!best_loc) {
-		r = svm_migrate_vram_to_ram(prange, mm);
+		r = svm_migrate_vram_to_ram(prange, mm, KFD_MIGRATE_TRIGGER_PREFETCH);
 		*migrated = !r;
 		return r;
 	}
 
-	r = svm_migrate_to_vram(prange, best_loc, mm);
+	r = svm_migrate_to_vram(prange, best_loc, mm, KFD_MIGRATE_TRIGGER_PREFETCH);
 	*migrated = !r;
 
 	return r;
@@ -3190,7 +3193,8 @@ static void svm_range_evict_svm_bo_worker(struct work_struct *work)
 		mutex_lock(&prange->migrate_mutex);
 		do {
 			svm_migrate_vram_to_ram(prange,
-						svm_bo->eviction_fence->mm);
+						svm_bo->eviction_fence->mm,
+						KFD_MIGRATE_TRIGGER_TTM_EVICTION);
 		} while (prange->actual_loc && --retries);
 		WARN(prange->actual_loc, "Migration failed during eviction");
 
-- 
2.17.1

