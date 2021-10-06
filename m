Return-Path: <SRS0=XefO=O2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D39FC433F5
	for <amd-gfx@archiver.kernel.org>; Wed,  6 Oct 2021 14:32:35 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ECB43610C8
	for <amd-gfx@archiver.kernel.org>; Wed,  6 Oct 2021 14:32:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org ECB43610C8
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7247C6E523;
	Wed,  6 Oct 2021 14:32:34 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1anam02on2051.outbound.protection.outlook.com [40.107.96.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3ADCF6E525
 for <amd-gfx@lists.freedesktop.org>; Wed,  6 Oct 2021 14:32:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j9bxmpEKoyqFSErpZm2aeqnf8nuXt/1c4WEAEA6gGy+Wj0NauEu+Irj8ka96q9txtFMDqOPXsrW25AH2wQ1FlmodZP6ctmYTQrHM7fetFOmIDzOs5hsFZz1X+rfqQ0EHk5Z0M6gxwFKPwB+luICLJtrv+gTzW+MDh+9NFukB+F1SJPsn03ZsYSnW2ys3so6ZlzqBZ9aGgdVOYa3IOG5h4OlYn2O0hh8nBjMGWkGXvN43UELV+jQgvzovmh1FTvAQbNn+tGeRq3rDlsxOeVuUUF8km1iNn43FRg2E4uqY3ZZLG8uJ8R2wcrS/C4GBWPw2rGjVwzf//6ldMxi7HIvp+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uz+zLN39CfrwzzyDPYX8UpjxuYHK9tHWXHL637lmMVo=;
 b=dtG9i1i8aR2gT98UusVrAmfiR/FCzXcjfBWYXH4NPIDRRvYJ+scIagb2ON9Zjj5IeQFk6FqtsxGysRxdBruHrVB6LZOXX+ZX8lKqmTX2vc99hvCdA0H7MaW4J1yIGBpfbBTNaPMw7VaIQWdQhl2btwggv2SZxbnpHRaizTtDcuRcJC6Pam0dup7Q9ZcQvDsPZ9QgLKhp6oYXcKpYS2IxDylyqvGIpxO92M5D89SNg3/OMAsVjtAfnvyl0kcIk7Qvx8hk5ghfPsyOXWquT+Nom9uZJiF2kWgg7uM511hsFeAlHMotPXotODUO2tP5H505khafUKfrwFqgz21RagTvSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uz+zLN39CfrwzzyDPYX8UpjxuYHK9tHWXHL637lmMVo=;
 b=P7TLWf8/zREvHHhZLNYVj7uWxpIesIx/qHFpIoihdfxHhdRxd3L6ioJ4ASO/NlAJ+4BYlSixeYGCsUsWvkt6uEXPJCJm+KeMj/XZxCh+PICv85uPS1C3pCeIBnuL4f1ZzZzEJvTrihwnBoQq//Rz2nkZVhTYXziNW/z0sSTPfTw=
Received: from MW4PR03CA0320.namprd03.prod.outlook.com (2603:10b6:303:dd::25)
 by MWHPR12MB1376.namprd12.prod.outlook.com (2603:10b6:300:13::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.18; Wed, 6 Oct
 2021 14:32:26 +0000
Received: from CO1NAM11FT008.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:dd:cafe::f1) by MW4PR03CA0320.outlook.office365.com
 (2603:10b6:303:dd::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.22 via Frontend
 Transport; Wed, 6 Oct 2021 14:32:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT008.mail.protection.outlook.com (10.13.175.191) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4587.18 via Frontend Transport; Wed, 6 Oct 2021 14:32:26 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Wed, 6 Oct 2021
 09:32:24 -0500
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Philip Yang <Philip.Yang@amd.com>
Subject: [PATCH 1/4] drm/amdkfd: ratelimited svm debug messages
Date: Wed, 6 Oct 2021 10:32:07 -0400
Message-ID: <20211006143210.4954-1-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 21c94733-c7dd-403b-ce81-08d988d61e59
X-MS-TrafficTypeDiagnostic: MWHPR12MB1376:
X-Microsoft-Antispam-PRVS: <MWHPR12MB1376396FCD2FB0D3DB342C31E6B09@MWHPR12MB1376.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1824;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sDRiUe3X1Sr4kfe6R3WD4rQe31nYhbhzuFdYq2Xi86iI5L1Ju4D2W3l2fUauiXEjLcndTjI8Kx5guAkQ4gymh2M98S9+2S658J3opLSZxEz/SP05rNfrTCsFG9FxxDX7GZX0OQGM2dwcHkkmfQr30DtjY217vURMxMAOEszDj4HgrYNQ8lOZkz5kHWree6O8UYLpSkFdFhVLBIEcQOgTitZfPk1lyUXLSW0UKbqTTqGphoB7XMp9OlfIaNwzte8JBKy+y8HRxGfb3NxihLEtmHvSFSW7R15eovFWXacHiRS3/MOxkgJ1lWXysHYHx6IkzCnPhqyM8RPgJteBoRbZzqp3A/6cuJjMPdxuyqX1ywZRMTKfZhSy0dIlrZMqe4x+Ch/acSUUU93qY5/0b+yXGGvQT1QUjUV9DZNw79CQT8w4DmjraRAV2O5Wjmt4ss1C+3d5GnHWsaFmc4Ai+UjcYe+eM2Eh1Db5alQrRxL7uiMBjcG5qmgFksOjheURQ4G66CgGgJQXeLAdCeP3Kv3R6ZCii+9foJNHBO3scwRVa1RPypg5nuR5mBBKs4xRCzG8fgs3vrd/qacq+9m1Wa/iiP1AUMjl42vgTSxoFh7KgvS9L3PjbWQ6R+cn4OyoC1C0hYxaKgykBWP0rBcK84m86MiGJNrueEVKckEU666G/XwE/s9bC8OoMdGjIuOpaIUzLl5wplViQoOOhKGq9hp79EweVk5tSp7ag+ROalpbU8U=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(8936002)(8676002)(5660300002)(36756003)(2616005)(47076005)(4326008)(426003)(83380400001)(316002)(7696005)(1076003)(70586007)(70206006)(16526019)(186003)(36860700001)(336012)(26005)(82310400003)(81166007)(2906002)(6916009)(356005)(508600001)(6666004)(86362001)(15650500001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2021 14:32:26.1797 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 21c94733-c7dd-403b-ce81-08d988d61e59
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT008.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1376
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

No function change, use pr_debug_ratelimited to avoid per page debug
message overflowing dmesg buf and console log.

use dev_err to show error message from unexpected situation, to provide
clue to help debug without enabling dynamic debug log.

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_migrate.c | 34 ++++++++++++------------
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c     | 12 ++++-----
 2 files changed, 23 insertions(+), 23 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
index f53e17a94ad8..069422337cf7 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
@@ -151,14 +151,14 @@ svm_migrate_copy_memory_gart(struct amdgpu_device *adev, dma_addr_t *sys,
 			gart_d = svm_migrate_direct_mapping_addr(adev, *vram);
 		}
 		if (r) {
-			pr_debug("failed %d to create gart mapping\n", r);
+			dev_err(adev->dev, "fail %d create gart mapping\n", r);
 			goto out_unlock;
 		}
 
 		r = amdgpu_copy_buffer(ring, gart_s, gart_d, size * PAGE_SIZE,
 				       NULL, &next, false, true, false);
 		if (r) {
-			pr_debug("failed %d to copy memory\n", r);
+			dev_err(adev->dev, "fail %d to copy memory\n", r);
 			goto out_unlock;
 		}
 
@@ -285,7 +285,7 @@ svm_migrate_copy_to_vram(struct amdgpu_device *adev, struct svm_range *prange,
 
 	r = svm_range_vram_node_new(adev, prange, true);
 	if (r) {
-		pr_debug("failed %d get 0x%llx pages from vram\n", r, npages);
+		dev_err(adev->dev, "fail %d get %lld vram pages\n", r, npages);
 		goto out;
 	}
 
@@ -305,7 +305,7 @@ svm_migrate_copy_to_vram(struct amdgpu_device *adev, struct svm_range *prange,
 					      DMA_TO_DEVICE);
 			r = dma_mapping_error(dev, src[i]);
 			if (r) {
-				pr_debug("failed %d dma_map_page\n", r);
+				dev_err(adev->dev, "fail %d dma_map_page\n", r);
 				goto out_free_vram_pages;
 			}
 		} else {
@@ -325,8 +325,8 @@ svm_migrate_copy_to_vram(struct amdgpu_device *adev, struct svm_range *prange,
 			continue;
 		}
 
-		pr_debug("dma mapping src to 0x%llx, page_to_pfn 0x%lx\n",
-			 src[i] >> PAGE_SHIFT, page_to_pfn(spage));
+		pr_debug_ratelimited("dma mapping src to 0x%llx, pfn 0x%lx\n",
+				     src[i] >> PAGE_SHIFT, page_to_pfn(spage));
 
 		if (j >= (cursor.size >> PAGE_SHIFT) - 1 && i < npages - 1) {
 			r = svm_migrate_copy_memory_gart(adev, src + i - j,
@@ -347,7 +347,7 @@ svm_migrate_copy_to_vram(struct amdgpu_device *adev, struct svm_range *prange,
 
 out_free_vram_pages:
 	if (r) {
-		pr_debug("failed %d to copy memory to vram\n", r);
+		dev_err(adev->dev, "fail %d to copy memory to vram\n", r);
 		while (i--) {
 			svm_migrate_put_vram_page(adev, dst[i]);
 			migrate->dst[i] = 0;
@@ -405,8 +405,8 @@ svm_migrate_vma_to_vram(struct amdgpu_device *adev, struct svm_range *prange,
 
 	r = migrate_vma_setup(&migrate);
 	if (r) {
-		pr_debug("failed %d prepare migrate svms 0x%p [0x%lx 0x%lx]\n",
-			 r, prange->svms, prange->start, prange->last);
+		dev_err(adev->dev, "fail %d vma setup 0x%p [0x%lx 0x%lx]\n",
+			r, prange->svms, prange->start, prange->last);
 		goto out_free;
 	}
 	if (migrate.cpages != npages) {
@@ -506,7 +506,7 @@ static void svm_migrate_page_free(struct page *page)
 	struct svm_range_bo *svm_bo = page->zone_device_data;
 
 	if (svm_bo) {
-		pr_debug("svm_bo ref left: %d\n", kref_read(&svm_bo->kref));
+		pr_debug_ratelimited("ref: %d\n", kref_read(&svm_bo->kref));
 		svm_range_bo_unref(svm_bo);
 	}
 }
@@ -563,8 +563,8 @@ svm_migrate_copy_to_ram(struct amdgpu_device *adev, struct svm_range *prange,
 
 		dpage = svm_migrate_get_sys_page(migrate->vma, addr);
 		if (!dpage) {
-			pr_debug("failed get page svms 0x%p [0x%lx 0x%lx]\n",
-				 prange->svms, prange->start, prange->last);
+			dev_err(adev->dev, "fail get page 0x%p [0x%lx 0x%lx]\n",
+				prange->svms, prange->start, prange->last);
 			r = -ENOMEM;
 			goto out_oom;
 		}
@@ -572,12 +572,12 @@ svm_migrate_copy_to_ram(struct amdgpu_device *adev, struct svm_range *prange,
 		dst[i] = dma_map_page(dev, dpage, 0, PAGE_SIZE, DMA_FROM_DEVICE);
 		r = dma_mapping_error(dev, dst[i]);
 		if (r) {
-			pr_debug("failed %d dma_map_page\n", r);
+			dev_err(adev->dev, "fail %d dma_map_page\n", r);
 			goto out_oom;
 		}
 
-		pr_debug("dma mapping dst to 0x%llx, page_to_pfn 0x%lx\n",
-			      dst[i] >> PAGE_SHIFT, page_to_pfn(dpage));
+		pr_debug_ratelimited("dma mapping dst to 0x%llx, pfn 0x%lx\n",
+				     dst[i] >> PAGE_SHIFT, page_to_pfn(dpage));
 
 		migrate->dst[i] = migrate_pfn(page_to_pfn(dpage));
 		migrate->dst[i] |= MIGRATE_PFN_LOCKED;
@@ -631,8 +631,8 @@ svm_migrate_vma_to_ram(struct amdgpu_device *adev, struct svm_range *prange,
 
 	r = migrate_vma_setup(&migrate);
 	if (r) {
-		pr_debug("failed %d prepare migrate svms 0x%p [0x%lx 0x%lx]\n",
-			 r, prange->svms, prange->start, prange->last);
+		dev_err(adev->dev, "fail %d vma setup 0x%p [0x%lx 0x%lx]\n",
+			r, prange->svms, prange->start, prange->last);
 		goto out_free;
 	}
 
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index 7c42a0d4e0de..7f0743fcfcc3 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -158,17 +158,17 @@ svm_range_dma_map_dev(struct amdgpu_device *adev, struct svm_range *prange,
 				   bo_adev->vm_manager.vram_base_offset -
 				   bo_adev->kfd.dev->pgmap.range.start;
 			addr[i] |= SVM_RANGE_VRAM_DOMAIN;
-			pr_debug("vram address detected: 0x%llx\n", addr[i]);
+			pr_debug_ratelimited("vram address: 0x%llx\n", addr[i]);
 			continue;
 		}
 		addr[i] = dma_map_page(dev, page, 0, PAGE_SIZE, dir);
 		r = dma_mapping_error(dev, addr[i]);
 		if (r) {
-			pr_debug("failed %d dma_map_page\n", r);
+			pr_err("failed %d dma_map_page\n", r);
 			return r;
 		}
-		pr_debug("dma mapping 0x%llx for page addr 0x%lx\n",
-			 addr[i] >> PAGE_SHIFT, page_to_pfn(page));
+		pr_debug_ratelimited("dma mapping 0x%llx for page addr 0x%lx\n",
+				     addr[i] >> PAGE_SHIFT, page_to_pfn(page));
 	}
 	return 0;
 }
@@ -217,7 +217,7 @@ void svm_range_dma_unmap(struct device *dev, dma_addr_t *dma_addr,
 	for (i = offset; i < offset + npages; i++) {
 		if (!svm_is_valid_dma_mapping_addr(dev, dma_addr[i]))
 			continue;
-		pr_debug("dma unmapping 0x%llx\n", dma_addr[i] >> PAGE_SHIFT);
+		pr_debug_ratelimited("unmap 0x%llx\n", dma_addr[i] >> PAGE_SHIFT);
 		dma_unmap_page(dev, dma_addr[i], PAGE_SIZE, dir);
 		dma_addr[i] = 0;
 	}
@@ -1459,7 +1459,7 @@ static int svm_range_validate_and_map(struct mm_struct *mm,
 		/* This should never happen. actual_loc gets set by
 		 * svm_migrate_ram_to_vram after allocating a BO.
 		 */
-		WARN(1, "VRAM BO missing during validation\n");
+		WARN_ONCE(1, "VRAM BO missing during validation\n");
 		return -EINVAL;
 	}
 
-- 
2.17.1

