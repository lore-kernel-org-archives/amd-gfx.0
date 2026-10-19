Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85989CCF2DE
	for <amd-gfx@archiver.kernel.org>; Mon, 19 Oct 2026 13:38:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 02E3910E542;
	Mon, 19 Oct 2026 13:38:21 +0000 (UTC)
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012051.outbound.protection.outlook.com [52.101.48.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C063E10E542
 for <amd-gfx@lists.freedesktop.org>; Mon, 19 Oct 2026 13:38:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RvJdjgYPtR77tVx5OY/9gaVCDIn9xDOWeqUplvclgGeAD5P4REx/iaiyMvBlDgPICb7mV+JFkp8rMuiUU9+XrHxMA8m9HrLVDPxrQLJE4GtUEsUSlnOlJVhmcKksex26mwODwqFgavMcKtKWTuLKYDbyImy6o84ncx9mRVtRcd+aX6JGEH29z0VvDQZ2494JZZglOWutGtp0mbZU7Ona4GHHu0/NYCqxdEFeNnnf2Rj3uHO0ylpJXlo1xQXZ7JlV/Y+NwNrvS7bqolqUm9zckW4OupkQpyDenK0YzeMNsBMHjJsO20ttCCrW4Id9RLjtGE9Z6ab4Tfy6tUuIqfu3rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VRAhaInBZnywnQHe59zWTlHr2+Je4kIvgxfH22gKIS8=;
 b=HvLAq2cWK3qh1FiqIDJ2sV9EYxKoTGJy/7VykGv0FITA6eTQHApvKoc1ZEH/tDEHL40aysGKikdYP/MyFY48bMrK++jT2XuKPh4ajkpAVe3sl20s1ZTfHWvnBW+4a0USUtP03p4QWTnMIejKGiiF/szz0C4LEJ8j14XzlAEdlLJ+cxkTHDVAH+WkNNGKIY4BICdIhHjcdXZi2KXz7g127dcn486DRqv6kWSnroWvRNoAo7sbIGvoDxvxldqcyvLQ04BOGvN1EXutnk3GREbMqj+1xg9m3+7UlPWs3FM6mJ90y09HoCr0pF27ukjQnOkGVxZBzsYw362RQlAHDF4w8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VRAhaInBZnywnQHe59zWTlHr2+Je4kIvgxfH22gKIS8=;
 b=y14Cb+oCgeV5KguLC8j14QKL1pNK5ofHm+9ozleet7Bxx5/SIe44Cd7rgtQmXb3SzXHpr7/A/BD9V4lWxfxeYNt6MsWQ7xVg24KAm0GOfeYrc/kNH8z3eFQXlNrRDXK+QUDmfKWxuCCB9warSRKMoykmiGU2EZ5nzBK8v2SsS8k=
Received: from CH0PR04CA0017.namprd04.prod.outlook.com (2603:10b6:610:76::22)
 by LV0PR12MB980390.namprd12.prod.outlook.com (2603:10b6:408:3ef::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Mon, 19 Oct
 2026 13:38:09 +0000
Received: from CH1PEPF0000A348.namprd04.prod.outlook.com
 (2603:10b6:610:76:cafe::4d) by CH0PR04CA0017.outlook.office365.com
 (2603:10b6:610:76::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.19 via Frontend Transport; Mon,
 19 Oct 2026 13:38:09 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH1PEPF0000A348.mail.protection.outlook.com (10.167.244.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Mon, 19 Oct 2026 13:38:09 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Mon, 19 Oct
 2026 08:38:01 -0500
Received: from Xiaogang-ROCM-Dev.amd.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53
 via Frontend Transport; Mon, 19 Oct 2026 08:38:01 -0500
From: Xiaogang.Chen <xiaogang.chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Xiaogang Chen <xiaogang.chen@amd.com>
Subject: [PATCH v3 2/3] drm/amdkfd: Do not migrate partial THP memory at
 CPU/GPU page fault handler
Date: Mon, 19 Oct 2026 08:38:44 -0500
Message-ID: <20261019133845.166916-3-xiaogang.chen@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261019133845.166916-1-xiaogang.chen@amd.com>
References: <20261019133845.166916-1-xiaogang.chen@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A348:EE_|LV0PR12MB980390:EE_
X-MS-Office365-Filtering-Correlation-Id: d357a267-fd51-469a-ea43-08df2de636da
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700016|1800799024|23010399003|22082099003|18002099003|11063799006|10067099003|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info: Cp1+dA5rkK9MBsXY8gX6hnVMy4W7J9TQJ65kDMRc/05aQYOFjc7O57xdAjnYz1XScPWj9CeeHj4eBcKIyHAPuYHNjQx8myVsZIhMdlgsblgdStrgHA3Cmu2F11393+toROWXh/C/X8l4FmsyFJtKPCIYrE8rIMYlI62TX0hnVOunsimknNH4AX+yjVjYrVx7JnD9afn2ODP7ysyQ2DBHethGulpvhposyQGoU6O3tKew3pV4BqdWC3ocOKx6y9FsYFN4r6U2puMrDo6pDZ7DtbKPbMR8HZ+fwTr8Gcx80YlsvvISGNdt6bUK+aQyJZRIx8vTO+VR1STd7E2DgpTx7NkHvcs5FQStAvVjq5hIlfD7WKYhbXj3aHj9CSFx/hnWBH8GCFDoF3Nf+PMZ8dEbAPxx71CSZ3TfYov3MxRJRIin5a/ADhfauxQO1oF01rjy47y+O3c+I368uTiISWMf3LVgB7US1hdwa480s061OwJ0I5Vf3rRqSipfxrpNWND7V4gh+VWMDfBdAggx3GlO8jErUM/WhXCBhfTM/UYcrMLFKd1XnJZsS2k7wzJnb0ZQmCIFe36Vz6Okrk8QhcNflKitHdPRLAOFsFj3Frm5l7Kvw159qli2+60vKgx56QbDPBRi8dQJiKg9Tjr+of3f/KRawUtM0442DGN8rLwXtFsyEEZxuVuDZKSmsN3trmqUZn//BgTOuTVIqB1aeffQMg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700016)(1800799024)(23010399003)(22082099003)(18002099003)(11063799006)(10067099003)(261009223027099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: u0debgsLR4so7gvqUPUOjkJ+KLs648j92dujmbYLPhCPgDUibaqmHKZNxMHYAZwxwiTFtPpj3ddQscwdxEf7ZHgq2159d3Y1SHfqBo+gOGzteqfElR0Q3w8f8pQnFBTBsrS9UDvMd9agGImo+hfcLG9UvWGLY6ka9cEzpXBfHqCIGNUPbqLVcPzbe+S2EuJVVQgMTH6ObfBEKZ92X2CtWcF4fvW2sxx6Q/q2UT3VAFxXnsMqgyalaInGjvlBEidXQdhCDOl+73Fjdry5RM0kh2D9zZ8dcf2AFNeUStLtaujRNvf3/Da9hkofI6g5xFbTfs56OPG7bgEdVLZsXo2ghyTFvVn7xf8P+rtNJDCxoKqxZ7VwP58EEH0oIEpAjau0ztWm8GFYioeU40LqlwA0oYC23G4TYjvjw55iC3SRkO5yiXZjq5mQGmiWATAyUJRP
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2026 13:38:09.5393 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d357a267-fd51-469a-ea43-08df2de636da
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000A348.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV0PR12MB980390
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

From: Xiaogang Chen <xiaogang.chen@amd.com>

After support device THP the page fault(either CPU or GPU) address can point
to THP(device or anonymous THP).

If the correspondent svm prange covers the whole compound folio migrate at
folio order so HMM can collect MIGRATE_PFN_COMPOUND.

Do not migrate partial THP memory. If do HMM will split THP folio. If the
compound folio has extra ref/pin the split will fail, then skip migration,
leave without page restore, then cpu/gpu keep retrying.

If the prange was split and no longer covers the PMD, do not call
split_folio(): it is not exported to modules. Walk only this prange and let
migrate_vma_setup() split the PMD inside mm.

If the fault address has PTE mapping memory use prange->granularity to decide
migration size.

Signed-off-by: Xiaogang Chen <xiaogang.chen@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_migrate.c | 39 ++++++++++-
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c     | 82 +++++++++++++++++++++++-
 drivers/gpu/drm/amd/amdkfd/kfd_svm.h     | 12 ++++
 3 files changed, 130 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
index 7a129c9954fc..2febe3bb690e 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
@@ -1059,6 +1059,8 @@ static vm_fault_t svm_migrate_to_ram(struct vm_fault *vmf)
 	struct svm_range *prange;
 	struct kfd_process *p;
 	struct mm_struct *mm;
+	struct folio *folio;
+	unsigned int order;
 	int r = 0;
 
 	svm_bo = vmf->page->zone_device_data;
@@ -1104,8 +1106,41 @@ static vm_fault_t svm_migrate_to_ram(struct vm_fault *vmf)
 	if (!prange->actual_loc)
 		goto out_unlock_prange;
 
-	/* Align migration range start and size to granularity size */
-	size = 1UL << prange->granularity;
+	folio = page_folio(vmf->page);
+	order = folio_order(folio);
+
+	/*
+	 * A PMD device-private fault always passes the folio head in
+	 * vmf->page. If this prange still covers the whole folio, migrate
+	 * at folio order so HMM can collect MIGRATE_PFN_COMPOUND.
+	 *
+	 * Do not want migrate partial THP device memory. If do HMM will split
+	 * THP folio. If the compound folio has extra ref/pin the split will fail,
+	 * then skip migration, leave without page restore, then cpu keep retry.
+	 *
+	 * If the prange was split and no longer covers the PMD, do not call
+	 * split_folio() here: it is not exported to modules. Walk only this
+	 * prange and let migrate_vma_setup() split the PMD inside mm.
+	 *
+	 * If the fault address has PTE mapping device-private memory use
+	 * prange->granularity to decide migration size.
+	 */
+	if (order && !vmf->pte) {
+		unsigned long folio_start = ALIGN_DOWN(addr, 1UL << order);
+		unsigned long folio_last = folio_start + (1UL << order) - 1;
+
+		if (prange->start > folio_start || prange->last < folio_last) {
+			pr_debug("partial prange on device THP svms 0x%p prange [0x%lx 0x%lx] folio [0x%lx 0x%lx]\n",
+				 prange->svms, prange->start, prange->last,
+				 folio_start, folio_last);
+			size = 1UL << prange->granularity;
+		} else {
+			size = 1UL << max(prange->granularity, order);
+		}
+	} else {
+		size = 1UL << prange->granularity;
+	}
+
 	start = max(ALIGN_DOWN(addr, size), prange->start);
 	last = min(ALIGN(addr + 1, size) - 1, prange->last);
 
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index 8e1fb5df8abd..7443beb5778c 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -38,6 +38,8 @@
 #include "kfd_svm.h"
 #include "kfd_migrate.h"
 #include "kfd_smi_events.h"
+#include <linux/mm.h>
+#include <linux/leafops.h>
 
 #ifdef dev_fmt
 #undef dev_fmt
@@ -3078,6 +3080,53 @@ svm_fault_allowed(struct vm_area_struct *vma, bool write_fault)
 	return (vma->vm_flags & requested) == requested;
 }
 
+/*
+ * svm_range_cpu_huge_folio_order - folio order of a PMD-mapped CPU mapping
+ * @vma: VMA covering @va
+ * @va: CPU virtual address of the GPU retry fault
+ *
+ * GPU retry faults have no vmf->page. Walk to the PMD (mmap read lock is
+ * already held) and return the folio order when that mapping is a huge PMD:
+ * anonymous THP or a device-private huge PMD. PTE-mapped pages return 0 so
+ * the caller keeps prange->granularity, matching svm_migrate_to_ram() which
+ * only expands on !vmf->pte.
+ *
+ * Return: folio order, or 0 if the PMD is not a huge mapping
+ */
+static unsigned int
+svm_range_cpu_huge_folio_order(struct vm_area_struct *vma, unsigned long va)
+{
+	struct mm_struct *mm = vma->vm_mm;
+	pgd_t *pgd;
+	p4d_t *p4d;
+	pud_t *pud;
+	pmd_t *pmdp;
+	pmd_t pmd;
+
+	pgd = pgd_offset(mm, va);
+	if (pgd_none(*pgd) || unlikely(pgd_bad(*pgd)))
+		return 0;
+
+	p4d = p4d_offset(pgd, va);
+	if (p4d_none(*p4d) || unlikely(p4d_bad(*p4d)))
+		return 0;
+
+	pud = pud_offset(p4d, va);
+	if (pud_none(*pud) || unlikely(pud_bad(*pud)))
+		return 0;
+
+	pmdp = pmd_offset(pud, va);
+	pmd = pmdp_get_lockless(pmdp);
+
+	if (pmd_trans_huge(pmd))
+		return folio_order(pmd_folio(pmd));
+
+	if (pmd_is_device_private_entry(pmd))
+		return folio_order(softleaf_to_folio(softleaf_from_pmd(pmd)));
+
+	return 0;
+}
+
 int
 svm_range_restore_pages(struct amdgpu_device *adev, unsigned int pasid,
 			uint32_t vmid, uint32_t node_id,
@@ -3246,8 +3295,39 @@ svm_range_restore_pages(struct amdgpu_device *adev, unsigned int pasid,
 	kfd_smi_event_page_fault_start(node, p->lead_thread, addr,
 				       write_fault, timestamp);
 
-	/* Align migration range start and size to granularity size */
+	/*
+	 * Same policy as svm_migrate_to_ram(): if the CPU maps a device or
+	 * anonymous THP at this address and this prange still covers the
+	 * whole folio, migrate at folio order so HMM can collect
+	 * MIGRATE_PFN_COMPOUND. A split prange that not convers the THP keeps
+	 * using granularity. migrate_vma_setup() splits the PMD inside mm.
+	 *
+	 * GPU faults have no vmf->page, so inspect the PMD.
+	 *
+	 * If the fault address has PTE mapping use prange->granularity to decide
+	 * migration size.
+	 *
+	 */
 	size = 1UL << prange->granularity;
+	if (svm_is_private_zone(adev)) {
+		unsigned int order;
+
+		order = svm_range_cpu_huge_folio_order(vma, addr << PAGE_SHIFT);
+		if (order) {
+			unsigned long folio_start = ALIGN_DOWN(addr, 1UL << order);
+			unsigned long folio_last = folio_start + (1UL << order) - 1;
+
+			if (prange->start > folio_start ||
+			    prange->last < folio_last) {
+				pr_debug("partial prange on CPU THP svms 0x%p prange [0x%lx 0x%lx] folio [0x%lx 0x%lx]\n",
+					 svms, prange->start, prange->last,
+					 folio_start, folio_last);
+			} else {
+				size = 1UL << max_t(unsigned int,
+						    prange->granularity, order);
+			}
+		}
+	}
 	start = max_t(unsigned long, ALIGN_DOWN(addr, size), prange->start);
 	last = min_t(unsigned long, ALIGN(addr + 1, size) - 1, prange->last);
 	if (prange->actual_loc != 0 || best_loc != 0) {
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
index f2b3a05cd8cf..d6862a80a433 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
@@ -214,6 +214,13 @@ void svm_range_bo_unref_async(struct svm_range_bo *svm_bo);
 
 void svm_range_set_max_pages(struct amdgpu_device *adev);
 int svm_range_switch_xnack_reserve_mem(struct kfd_process *p, bool xnack_enabled);
+/* check adev has device private zone memory */
+static inline bool svm_is_private_zone(struct amdgpu_device *adev)
+{
+	struct amdgpu_kfd_dev *kfddev = &adev->kfd;
+
+	return (kfddev->pgmap.type == MEMORY_DEVICE_PRIVATE);
+}
 
 #else
 
@@ -277,6 +284,11 @@ static inline void svm_range_set_max_pages(struct amdgpu_device *adev)
 {
 }
 
+static inline bool svm_is_private_zone(struct amdgpu_device *adev)
+{
+	return false;
+}
+
 #define KFD_IS_SVM_API_SUPPORTED(dev) false
 
 #endif /* IS_ENABLED(CONFIG_HSA_AMD_SVM) */
-- 
2.34.1

