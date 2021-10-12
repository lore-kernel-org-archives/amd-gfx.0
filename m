Return-Path: <SRS0=oPsV=PA=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22BB0C433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Oct 2021 13:55:47 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E32B460E94
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Oct 2021 13:55:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org E32B460E94
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 643C46E994;
	Tue, 12 Oct 2021 13:55:46 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2082.outbound.protection.outlook.com [40.107.237.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2EC8C6E994
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Oct 2021 13:55:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a9KTixka1omG3BKOIqWBwLSdv2GOOKyKr/9tswZRwJKHoHiT0xKWPEaAdos9sIzaUF6O/lVukT+1rOgjhs2SNW4LOdDooq57E6qK8dE4GmT+4P1xiFNuTkoV+D+ehYsbCkq7iFt456Dt/vEP5Vp2A3uW9tLgaBQ6QNv7NQX6v6Ux0BbBxqST07o0vuBc4llIwUzkhDVzi7WMd4QxBa5x0tbJjWXzGuFoSFd0jI/oNk46l8msxtpzinB9crK3sQBVtCxcS7CGjQ2tF6Fjq00TRb8soB8OtgjrSgTg96ufJa5q9rESKpwnlWHOVCmQ8h3+u6LGP4klSIOfjQOHrqbjJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EEH2xVVPh9EN3/GgQ4CFseAEV+NWn/K7LcaA7uns1TM=;
 b=ZWmnOpQrn5/fCm3xBxY6oMuLrf0OypX7NZe73yAO23WLgIO4+HNkX6mKQXFFmhiMuIHtqAZ0u3nO+bTqZ75hgzY8yR1/PWAUuUiRcvzGNlvjljsjH9nosAumjtzky49pAdbT2ZdNyy/bUnsVnnOXI/XD3XgGmgwcfNvEMHO8N55RzjUs5+AVCnoiLIgLQ2U+wm2+iHozicM+NDuyLQfc9QVimyBm2tvqU1fLvabBUptQuF6MQXm9mjOqCDtrZ3fnNBpigMmR5SnuluyuBI2eIaFig+VSX5tJphBPB1rUtuCQUaYGROfK6862q4hzTNC27Hg+t3EIFCzNxhv8ChaO7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EEH2xVVPh9EN3/GgQ4CFseAEV+NWn/K7LcaA7uns1TM=;
 b=sHGO/jdtmfHefGgoa3tXxGS1UT/wveyEj3DE0qezxvofDCXVvb3jlbZ5rQYr1ws3nBm8HRz0EFmbJUgilzbXpkcAuRc3uV3AKgyG4RoiedRtvem368KG88sLmc7EnHA9SbbRaHThKUwGX7SIUJKcXNBv4JaDqUlMsG+5XqcznUs=
Received: from BN6PR14CA0005.namprd14.prod.outlook.com (2603:10b6:404:79::15)
 by BL1PR12MB5111.namprd12.prod.outlook.com (2603:10b6:208:31b::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.18; Tue, 12 Oct
 2021 13:55:42 +0000
Received: from BN8NAM11FT008.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:79:cafe::8f) by BN6PR14CA0005.outlook.office365.com
 (2603:10b6:404:79::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.18 via Frontend
 Transport; Tue, 12 Oct 2021 13:55:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT008.mail.protection.outlook.com (10.13.177.95) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4587.18 via Frontend Transport; Tue, 12 Oct 2021 13:55:42 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Tue, 12 Oct
 2021 08:55:41 -0500
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Philip Yang <Philip.Yang@amd.com>
Subject: [PATCH v2 1/3] drm/amdkfd: ratelimited svm debug messages
Date: Tue, 12 Oct 2021 09:55:25 -0400
Message-ID: <20211012135527.28083-1-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 830f5107-faf0-4452-2bf0-08d98d87fb37
X-MS-TrafficTypeDiagnostic: BL1PR12MB5111:
X-Microsoft-Antispam-PRVS: <BL1PR12MB51118883EA59F674ECF552FDE6B69@BL1PR12MB5111.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1360;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NslQbX69dg4x3kuIXkY0ypE2WW9AKocVAySOhmzhZARJpkugMlJDTQxTjqTCISLt7KSb+LqbKAtQgM9ja7cBW9SmAZsbaCI6TLgWxZ1+5gqh/in/jGWlN99DmTrNstGcZbDZUwO34SoTYs4AgA7yuZilCFvMlLpKUtMaqYTC+2yANpQt00Jho26Cza/efB2DY3sWcolzCkD3wpYQKIY6yd6FhwH80rKPoxiDdt39We/mCpXSvtbMWtk6XA301lIxUBKdCaZcxqC3d8tEw2BPRt3l59Krv/0ZNajw7b3OFEW4CfPePhu8TDwpoFD6qphOmW6cf3Oi9qqbdAkdPQhyr8VO/7tkH1pQKrMIdHwa9d9JHtYp9InPPyHR+zKAK1zWbEiBCsYyIr5B3c4/FCQ56MpwUKIflcuqdvENrvbKlbtRcgBZzt23W2FrZiDkH35VFbUwSUq/TqhdI2IBw+1IVhXwBXnVt1sXd8EzOb0/070cBnVsomtYZbdbEjdept+f6LmJtgued2oE+PP/a5CAiE3MFCe+XCtg79Rzcai9xBDIpUeyIendpxRBUFrv/C9I/IrAFwZlt0occCkZrmrXZmEFKywYAGe1sGZ8aVvR1K70jsQAcw72kk9WRreT2krH/TO4vTpFjnopMuOY+jLI2b1VDUuj03cg3lKkq2CWMKrh8e6hkeSzP9a89UixESwPn4rqdB2iX0JZS9uO8vHU5S9ODjtZ1+BXisPMtBLrrCU=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(70586007)(83380400001)(36860700001)(8936002)(6666004)(186003)(7696005)(26005)(16526019)(8676002)(36756003)(1076003)(86362001)(4326008)(2906002)(316002)(70206006)(6916009)(5660300002)(356005)(508600001)(2616005)(81166007)(336012)(426003)(15650500001)(82310400003)(47076005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2021 13:55:42.3999 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 830f5107-faf0-4452-2bf0-08d98d87fb37
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT008.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5111
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
clue to help debug without enabling dynamic debug log. Define dev_fmt to
output function name in error message.

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_migrate.c | 34 +++++++++++++-----------
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c     | 17 +++++++-----
 2 files changed, 30 insertions(+), 21 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
index f53e17a94ad8..b05c0579d0b9 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
@@ -20,7 +20,6 @@
  * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
  * OTHER DEALINGS IN THE SOFTWARE.
  */
-
 #include <linux/types.h>
 #include <linux/hmm.h>
 #include <linux/dma-direction.h>
@@ -34,6 +33,11 @@
 #include "kfd_svm.h"
 #include "kfd_migrate.h"
 
+#ifdef dev_fmt
+#undef dev_fmt
+#endif
+#define dev_fmt(fmt) "kfd_migrate: %s: " fmt, __func__
+
 static uint64_t
 svm_migrate_direct_mapping_addr(struct amdgpu_device *adev, uint64_t addr)
 {
@@ -151,14 +155,14 @@ svm_migrate_copy_memory_gart(struct amdgpu_device *adev, dma_addr_t *sys,
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
 
@@ -285,7 +289,7 @@ svm_migrate_copy_to_vram(struct amdgpu_device *adev, struct svm_range *prange,
 
 	r = svm_range_vram_node_new(adev, prange, true);
 	if (r) {
-		pr_debug("failed %d get 0x%llx pages from vram\n", r, npages);
+		dev_err(adev->dev, "fail %d to alloc vram\n", r);
 		goto out;
 	}
 
@@ -305,7 +309,7 @@ svm_migrate_copy_to_vram(struct amdgpu_device *adev, struct svm_range *prange,
 					      DMA_TO_DEVICE);
 			r = dma_mapping_error(dev, src[i]);
 			if (r) {
-				pr_debug("failed %d dma_map_page\n", r);
+				dev_err(adev->dev, "fail %d dma_map_page\n", r);
 				goto out_free_vram_pages;
 			}
 		} else {
@@ -325,8 +329,8 @@ svm_migrate_copy_to_vram(struct amdgpu_device *adev, struct svm_range *prange,
 			continue;
 		}
 
-		pr_debug("dma mapping src to 0x%llx, page_to_pfn 0x%lx\n",
-			 src[i] >> PAGE_SHIFT, page_to_pfn(spage));
+		pr_debug_ratelimited("dma mapping src to 0x%llx, pfn 0x%lx\n",
+				     src[i] >> PAGE_SHIFT, page_to_pfn(spage));
 
 		if (j >= (cursor.size >> PAGE_SHIFT) - 1 && i < npages - 1) {
 			r = svm_migrate_copy_memory_gart(adev, src + i - j,
@@ -405,8 +409,8 @@ svm_migrate_vma_to_vram(struct amdgpu_device *adev, struct svm_range *prange,
 
 	r = migrate_vma_setup(&migrate);
 	if (r) {
-		pr_debug("failed %d prepare migrate svms 0x%p [0x%lx 0x%lx]\n",
-			 r, prange->svms, prange->start, prange->last);
+		dev_err(adev->dev, "vma setup fail %d range [0x%lx 0x%lx]\n", r,
+			prange->start, prange->last);
 		goto out_free;
 	}
 	if (migrate.cpages != npages) {
@@ -506,7 +510,7 @@ static void svm_migrate_page_free(struct page *page)
 	struct svm_range_bo *svm_bo = page->zone_device_data;
 
 	if (svm_bo) {
-		pr_debug("svm_bo ref left: %d\n", kref_read(&svm_bo->kref));
+		pr_debug_ratelimited("ref: %d\n", kref_read(&svm_bo->kref));
 		svm_range_bo_unref(svm_bo);
 	}
 }
@@ -572,12 +576,12 @@ svm_migrate_copy_to_ram(struct amdgpu_device *adev, struct svm_range *prange,
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
@@ -631,8 +635,8 @@ svm_migrate_vma_to_ram(struct amdgpu_device *adev, struct svm_range *prange,
 
 	r = migrate_vma_setup(&migrate);
 	if (r) {
-		pr_debug("failed %d prepare migrate svms 0x%p [0x%lx 0x%lx]\n",
-			 r, prange->svms, prange->start, prange->last);
+		dev_err(adev->dev, "vma setup fail %d range [0x%lx 0x%lx]\n", r,
+			prange->start, prange->last);
 		goto out_free;
 	}
 
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index 425d55deca10..49c92713c2ad 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -33,6 +33,11 @@
 #include "kfd_svm.h"
 #include "kfd_migrate.h"
 
+#ifdef dev_fmt
+#undef dev_fmt
+#endif
+#define dev_fmt(fmt) "kfd_svm: %s: " fmt, __func__
+
 #define AMDGPU_SVM_RANGE_RESTORE_DELAY_MS 1
 
 /* Long enough to ensure no retry fault comes after svm range is restored and
@@ -158,17 +163,17 @@ svm_range_dma_map_dev(struct amdgpu_device *adev, struct svm_range *prange,
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
+			dev_err(dev, "failed %d dma_map_page\n", r);
 			return r;
 		}
-		pr_debug("dma mapping 0x%llx for page addr 0x%lx\n",
-			 addr[i] >> PAGE_SHIFT, page_to_pfn(page));
+		pr_debug_ratelimited("dma mapping 0x%llx for page addr 0x%lx\n",
+				     addr[i] >> PAGE_SHIFT, page_to_pfn(page));
 	}
 	return 0;
 }
@@ -217,7 +222,7 @@ void svm_range_dma_unmap(struct device *dev, dma_addr_t *dma_addr,
 	for (i = offset; i < offset + npages; i++) {
 		if (!svm_is_valid_dma_mapping_addr(dev, dma_addr[i]))
 			continue;
-		pr_debug("dma unmapping 0x%llx\n", dma_addr[i] >> PAGE_SHIFT);
+		pr_debug_ratelimited("unmap 0x%llx\n", dma_addr[i] >> PAGE_SHIFT);
 		dma_unmap_page(dev, dma_addr[i], PAGE_SIZE, dir);
 		dma_addr[i] = 0;
 	}
@@ -1454,7 +1459,7 @@ static int svm_range_validate_and_map(struct mm_struct *mm,
 		/* This should never happen. actual_loc gets set by
 		 * svm_migrate_ram_to_vram after allocating a BO.
 		 */
-		WARN(1, "VRAM BO missing during validation\n");
+		WARN_ONCE(1, "VRAM BO missing during validation\n");
 		return -EINVAL;
 	}
 
-- 
2.17.1

