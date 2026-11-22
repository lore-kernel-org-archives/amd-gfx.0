Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04D7B606A32E
	for <amd-gfx@archiver.kernel.org>; Sun, 22 Nov 2026 20:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=2Q6uzgqV
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9B2AD10E61A;
	Sun, 22 Nov 2026 20:26:03 +0000 (UTC)
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012004.outbound.protection.outlook.com [40.107.209.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1EED610E5D6
 for <amd-gfx@lists.freedesktop.org>; Sun, 22 Nov 2026 20:25:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ibBFnxahsS/UGjfuKYhf7czgoYDorAvgKnKUUPBMWxiNX5lXMVt6NJp840hYyu8oaigtzJ2nPsnqUgYW1jxgMBY4hgImaFQCK2N4ZmLNGVzRRDiFLW4AS5wk6APOX5fpE18wBIppPWtFhycczxEyb5np0T3j0HAaK26t7qr9vUThkYhxiiBSI4LMqeBKPjAbaai6T6VYopQjHTla3O78mIJQRDhP6bnQ4uY4hOoW07r7j1cf7ZP8kYwp8dDypAsZahclTGh97Jqh+5b+GnWrLXgLFFNXlwRQOmcyClPsuuLY/UpYtHLb41eNhmCyvxlYicl9LnYR/2fl4hGp2+0zhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HapOw0L6ih9xqnLqXi9q80pCLPRsat19kXBLhRYR+w4=;
 b=Zuuz7diJlDvqMayHGTrk0AawkJweYJcb3JV7Is03k3ANKsFXgozOpR6T58GkFYjihefAAavrUPqoZcu11hVXHvwH8WYTlU8Ubwv1UNdhiLH2l1d1769LTBeA5py2g8AyRYHSh/95N/gJHNfa71/nr6yijU8CXI3KaEUc0W1MkiK+6yQMeQhuCAR6TRVRVK/L4yuiZfNLXhc5Tr36qYGpPIDEvPWSkSz7dvjKLcU7zlGgl6zrxl/rB89UZ6h4BmXePNzAPaaEr+deG+scK0bR/aRUgQArewyw3J8KqstgA1ojA4CSYSdgU9es6qdPk1mdINDyVO7QEQ8fdO20CUpGag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HapOw0L6ih9xqnLqXi9q80pCLPRsat19kXBLhRYR+w4=;
 b=2Q6uzgqVFiM12ImFuV+P6M1TGOs53oiZD+RpKkF3XCo6S/XLQQbJ/g0yLnIFHlTbKOu9g3B4rt4qs4aA2Ro9U8N56y4bMekDajYpvz+Cjr6YspnAJWC8qY3ghdevCsoKuv4xJrGOHO9w8PBze1+ZAz3muddCOWx8Vz8AMNGPqmY=
Received: from CYZPR05CA0033.namprd05.prod.outlook.com (2603:10b6:930:a3::22)
 by MW6PR12MB8735.namprd12.prod.outlook.com (2603:10b6:303:245::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.13; Sun, 22 Nov
 2026 20:25:51 +0000
Received: from MWH0EPF000DD30D.namprd05.prod.outlook.com
 (2603:10b6:930:a3:cafe::d) by CYZPR05CA0033.outlook.office365.com
 (2603:10b6:930:a3::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.662.5 via Frontend Transport; Sun, 22
 Nov 2026 20:25:51 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 MWH0EPF000DD30D.mail.protection.outlook.com (10.167.249.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.639.5 via Frontend Transport; Sun, 22 Nov 2026 20:25:50 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Sun, 22 Nov
 2026 14:25:47 -0600
Received: from Xiaogang-ROCM-Dev.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.57
 via Frontend Transport; Sun, 22 Nov 2026 14:25:46 -0600
From: Xiaogang.Chen <xiaogang.chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Xiaogang Chen <xiaogang.chen@amd.com>
Subject: [PATCH v5 2/3] drm/amdkfd: Do not migrate partial THP memory at
 CPU/GPU page fault handler
Date: Sun, 22 Nov 2026 14:26:52 -0600
Message-ID: <20261122202653.274580-3-xiaogang.chen@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261122202653.274580-1-xiaogang.chen@amd.com>
References: <20261122202653.274580-1-xiaogang.chen@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000DD30D:EE_|MW6PR12MB8735:EE_
X-MS-Office365-Filtering-Correlation-Id: deb43538-6ad9-4de3-46f5-08df48d6cd0f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|23010399003|82310400026|1800799024|376014|261026121527099003|261026140227099003|261028144727099003|261021123027099003|261021121427099003|261022105027099003|261022075727099003|261102130727099003|261102123227099003|11063799006|56012099006|10067099003|18002099003|22082099003|261009223027099003;
X-Microsoft-Antispam-Message-Info: fP0OUnFE7VgOAxUAoy9eqY9ca/Rg5HwLgQULc3HLxwI2dCzjLlUHEBEOEpoNbzrzL9UjFC6h/Dl4/puI3U2TMh7xlNE00oxar3Fhf8GIa7/8gQ4+VM4nUT77ZlELoiMmlK6dnTG8vOD5Gv+XIi5tPdosgl92gt3ci1RT+qPhvxL4lWuzJ34TyXYsQ5i2lu3kXl3HiQZuIerFsbW1FObIUYJVJtvFpaw19DsS/hwVZY/BU2EDGPQiNK6FFPCdkB87rND5VvJxAwHTPIJW+nOR4W27NzWVRpgnw4uSYr5DN30A314A/CUw7+Xc5NrTyJJ8HkcP94X9fatosnJl4LRrfKn/zuvjG60o828XIqFq2TTcFbAArFOSmrknKUQpWFmDGcfg1D3yI/IA28eGoLhp0KrzlpLqoWMLkfogN4lfTjYqx6YX/KCiPAVz3NETuMnva6S1l66qHT4W7FkpMVYY3y1SWEfcWrGeF6RVCCdPXKArHpGKRTVMJVzEqgFcRVWjiJ17kgMYM8R06n+WuRdK6WSRvlTA9uKWc1+ciC5Ct2VJRhGNmRTnabaA1EGY2QgiEkgy4AKhKgr3c7GHSXwjHJWApfl3Ltql8XptZK3CUHGOWbx4Z2X9UJRWGVfvLhrBICI+GG/wdR49TQj+h78M3fyWCz28lj7rrbwS6M/NAQD2cmQ3Sa1OQzkzNT3u6wmYQqMfBG4Irdc+t4Mi+ukIfA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(23010399003)(82310400026)(1800799024)(376014)(261026121527099003)(261026140227099003)(261028144727099003)(261021123027099003)(261021121427099003)(261022105027099003)(261022075727099003)(261102130727099003)(261102123227099003)(11063799006)(56012099006)(10067099003)(18002099003)(22082099003)(261009223027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 4gn5A2TesVVR0ZLEpIv1jJwKWb6OSHbDFf8yxffyx75fv4IGpM2wmIz4tLkyNRz+WdEWXOliZ1UI5w9C/AjPRhm53fkh8Su+7ZWpa3ycQXxcmMbFsbLpSLxRGyUNopCo4IHYzOsLqklZremRM0qKHMn1FQL3rOirmKh8TN/+nCn1hamiIyDYIfacrPAfBsz/oolsHNw2/TUetK4jKj1EHVVQxKtCzgMSZGuCODpkhyat4LQMZEG1vZVi6lKUfFZlzA2o9dqOv5T1GHBljkCt1TO7Fp068Jdla1mt27KM59lCjKr+Wsi6VsN4El8kd8hTgwPUzpogmNI6p2U0fRl66VYjdswogox5fQ36NoY6hGr1eQukqP5kBtNaV270dIqfyQyOPd2Fzw5Mm9oDS2gz7A2cguAahZoNkQ7y61kEf0QqsQyIHh1RdegECw6Bwj0I
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2026 20:25:50.9086 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: deb43538-6ad9-4de3-46f5-08df48d6cd0f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000DD30D.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8735
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

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
 drivers/gpu/drm/amd/amdkfd/kfd_migrate.c | 41 ++++++++++-
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c     | 86 +++++++++++++++++++++++-
 drivers/gpu/drm/amd/amdkfd/kfd_svm.h     | 12 ++++
 3 files changed, 135 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
index 5ead98a604b1..11cda92b8878 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
@@ -1097,9 +1097,12 @@ static vm_fault_t svm_migrate_to_ram(struct vm_fault *vmf)
 	struct svm_range *prange;
 	struct kfd_process *p;
 	struct mm_struct *mm;
+	struct folio *folio;
+	unsigned int order;
 	int r = 0;
 
-	svm_bo = vmf->page->zone_device_data;
+	folio = page_folio(vmf->page);
+	svm_bo = folio_zone_device_data(folio);
 	if (!svm_bo) {
 		pr_debug("failed get device page at addr 0x%lx\n", addr);
 		return VM_FAULT_SIGBUS;
@@ -1142,8 +1145,40 @@ static vm_fault_t svm_migrate_to_ram(struct vm_fault *vmf)
 	if (!prange->actual_loc)
 		goto out_unlock_prange;
 
-	/* Align migration range start and size to granularity size */
-	size = 1UL << prange->granularity;
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
index 35cebdad5651..ab87a6d33e73 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -39,6 +39,8 @@
 #include "kfd_svm.h"
 #include "kfd_migrate.h"
 #include "kfd_smi_events.h"
+#include <linux/mm.h>
+#include <linux/leafops.h>
 
 #ifdef dev_fmt
 #undef dev_fmt
@@ -3152,6 +3154,57 @@ svm_fault_allowed(struct vm_area_struct *vma, bool write_fault)
 	return (vma->vm_flags & requested) == requested;
 }
 
+/*
+ * svm_range_cpu_huge_folio_order - folio order of a PMD-mapped CPU mapping
+ * @vma: VMA covering @va
+ * @va: CPU virtual address of the GPU retry fault
+ *
+ * GPU retry faults have no vmf->page. Walk to the PMD (mmap read lock is
+ * already held) and report whether that mapping is a huge PMD: anonymous
+ * THP or a device-private huge PMD. PTE-mapped pages return 0 so the caller
+ * keeps prange->granularity, matching svm_migrate_to_ram() which only
+ * expands on !vmf->pte.
+ *
+ * The PMD is read without the PMD lock and without a folio reference, so
+ * the folio behind it may be split, freed or reused concurrently (e.g. by
+ * MADV_DONTNEED, deferred split or migration, none of which need the mmap
+ * write lock). Do not dereference it: a huge PMD maps exactly one
+ * SVM_HPAGE_PMD_ORDER folio, so return that order directly. The result is only
+ * a sizing hint; migrate_vma_setup() re-checks the PMD under its lock.
+ *
+ * Return: SVM_HPAGE_PMD_ORDER, or 0 if the PMD is not a huge mapping
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
+	if (pmd_trans_huge(pmd) || pmd_is_device_private_entry(pmd))
+		return SVM_HPAGE_PMD_ORDER;
+
+	return 0;
+}
+
 int
 svm_range_restore_pages(struct amdgpu_device *adev, unsigned int pasid,
 			uint32_t vmid, uint32_t node_id,
@@ -3321,8 +3374,39 @@ svm_range_restore_pages(struct amdgpu_device *adev, unsigned int pasid,
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
index 8767a784e679..830d3a168078 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
@@ -231,6 +231,13 @@ void svm_range_bo_unref_async(struct svm_range_bo *svm_bo);
 
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
 
@@ -294,6 +301,11 @@ static inline void svm_range_set_max_pages(struct amdgpu_device *adev)
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

