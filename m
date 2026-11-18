Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB7EB60A6F78
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Nov 2026 23:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=rdfzovzI
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 43D8410E1D6;
	Wed, 18 Nov 2026 23:10:15 +0000 (UTC)
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010064.outbound.protection.outlook.com
 [40.93.198.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9B72D10E1D6
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Nov 2026 23:10:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c0RamC7C0BWUdNDn8g1sNRawV7rabl1ZxXjEitjVpi7rwNIZLbjIQhVpLNFh82TiWhWaao4PK8hrsDC4RB/gxlZLZJfaWGf6GWF8vXsl3M3aFhd8wK5xwtUIG/qlJrutZk8wRFwgxOSvoB880gYT954eufdD2tRDe5oFSZXDAsF0kjWM+zSaidg1sFGLC7YNgEVuzL9QXMERTiQJYRRDtdkV9y2ApWijOT7GZwqiwe7ruThrwv2c7HQp6kbI9F8aLtU26x3gGArhHfV2Ul35d/cn2UQoguN+dEvFm+R6e6tHuEx1h4GW3mNc8wvd98dMUVoKIyy2SQ+BpdgP6n2gLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ncJ4jjaYvuRnfZ4ZHw5lZWxfx3c4mZP6HS0EXC2qIb8=;
 b=P08vOixZishI+TDChBih4fvF+F7/cMlFyZnNuuNWYh7ItroMW+u15DFJPmkgZPz8c7QzxpUKq+4Wm8o4bm2uyhLiEuD5VU3Yce/BlJVhjju6Xy3B1Xki3EWYgSYioTdoYQAcDAgdZmMR3rT3si+9Hh6egqIyp9VyfUcA1ltEQltB0j5n9f8fyzzyMLBYEndT8Tznd9KjW0OBXrBTfz06+Z6+zfV1LD5NmUdlwnjwZu3OGWCe3SvYbqlrw3/zByhOG/oIcb9HYz30kNpGcMIdFVbocjkG4/ZTw5TGO3DtNhh5y6PNtlm1dRdWU+yVmtgoKoQO/7qv+72S8cE/hjOStA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ncJ4jjaYvuRnfZ4ZHw5lZWxfx3c4mZP6HS0EXC2qIb8=;
 b=rdfzovzIkNDsS7g+eWzIqW6P8EFkU9irLg7sXTB4IKnAi+3CeFpMsm+Pe6tSMOmagG0AZfTvS9uv4H8+smisDvCsbaojTncfoTd3LwrEVy0pQWBS/xrLbrHKf93b2QZHZ4WQeo4NkuXao97cp+uQD0GrxFpPZuxDUutTLcWNMdU=
Received: from CH0PR03CA0278.namprd03.prod.outlook.com (2603:10b6:610:e6::13)
 by SA0PR12MB4494.namprd12.prod.outlook.com (2603:10b6:806:94::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Wed, 18 Nov
 2026 23:09:58 +0000
Received: from BN3PEPF00022BC7.namprd05.prod.outlook.com
 (2603:10b6:610:e6:cafe::1b) by CH0PR03CA0278.outlook.office365.com
 (2603:10b6:610:e6::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.13 via Frontend Transport; Wed,
 18 Nov 2026 23:09:58 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN3PEPF00022BC7.mail.protection.outlook.com (10.167.248.212) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Wed, 18 Nov 2026 23:09:58 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Wed, 18 Nov
 2026 17:09:57 -0600
Received: from Xiaogang-ROCM-Dev.amd.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.57
 via Frontend Transport; Wed, 18 Nov 2026 17:09:57 -0600
From: Xiaogang.Chen <xiaogang.chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <xiaogang.chen@amd.com>
Subject: [PATCH v4 2/3] drm/amdkfd: Do not migrate partial THP memory at
 CPU/GPU page fault handler
Date: Wed, 18 Nov 2026 17:10:59 -0600
Message-ID: <20261118231100.68176-3-xiaogang.chen@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261118231100.68176-1-xiaogang.chen@amd.com>
References: <20261118231100.68176-1-xiaogang.chen@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF00022BC7:EE_|SA0PR12MB4494:EE_
X-MS-Office365-Filtering-Correlation-Id: 00517021-1b96-4933-8dbb-08df45c910c1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|36860700016|82310400026|1800799024|261102123227099003|10067099003|261026121527099003|11063799006|261102130727099003|56012099006|261026140227099003|261021123027099003|261022105027099003|261022075727099003|261021121427099003|261028144727099003|261009223027099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: QyobB71UXdljp7fSvXh35D1a8hQsXU6aLriavqH7uMZg9VFan8h3tDUMJV6NZXTAUT83slNMxSqCZZin26CoBqwBE81AKNxwhKVbDFRXLxfL3TmJr2CjbEGLs44lz88WmC4+27JopTM2dJFj8Q2s3UWa4tWHUz7luNFr2Th+QRXUFUpBVVWihin92OeDJV9CUOKh4XqL+lIOp9bz3KF2EHws+mVEu+fQAO5f+SqJxTVrEZBq7BY6oYexhO2mK0EBgNy+6ncqdC+4HmyWOQqgw9MhyXeLfDCSn1qkGwy1KzpOSNi48F8+3rQe5ygMV/0eWJg3PhIdj0yfLpGjdszmzFwM99I12ZT05oizrrupuUOR+DJrOhfLRgyvUsnOasCdae730af+LJqGgVudOQ76e/66UGFTLZNGY3S9IU6s8DsUXq9rIXDBeZs0cwdDN5zG/5bcgXKDqFyio2OIBlTJ82TTt4HbJ0Ukvfp1VCYydqAH5PZY6CRNjG4i9aq5XIup07bzn9SH5emq7HEWLszpSQwIfW7vQxgrvnyZKwsiK3S+gmsgjVgjgniqqCtwawcibsfo6kK5nkWL7T5tGPy+4+IEZOdU5MpEmgaOWExHMRQTy4TWMrt8IhLYcHz16siTy8Bk3sQ6GTLv2edrjEPJ6D3h2X8ZmJop9E5iQOyRVmrA3lgo2pswVYFOvEAz92/fg7hjjnCqAYQz9HjkoyMj0Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(36860700016)(82310400026)(1800799024)(261102123227099003)(10067099003)(261026121527099003)(11063799006)(261102130727099003)(56012099006)(261026140227099003)(261021123027099003)(261022105027099003)(261022075727099003)(261021121427099003)(261028144727099003)(261009223027099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: pBXrygwg+ncgVQIT5IRcY8XWKj+wqRxgow3iTSVUKZurM72MQQ6BfFuDB7Anf/JHkOCDGUkTbcm33DP7shwvIhf+D7WsbEthMfYiFIePedj2XoIX6df3gRpQFtXAmv9PLkZCAUhRWp0rS0XrRpN14TFpgwI95/DEc82CSrya5FCQ/45eBH+iHq4qKQ7sBnaR8uha0hFUOopLrnV52DBK3dydr10slRvpCh5nuYXbI1TRCF6I+FFh0K2hkrWi1azTfdlXgZy2WRp1j0y3kqEOJdIsRob/9S2s+c4zKUmZ19P6fQBYOojNJsUePHVq4wp6UW1g97E+ot9NpcP8QQ8KCWKWaAQD6eRPm1SfQ0EjaYCQMb6NoRAb+a80hkWy4UwqN8YD3jjl4vcCqLEt9sbHGmFAd2CPq5X0CvLl1hHEQoMrqVpvA1B68CKznpF2+739
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2026 23:09:58.1370 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 00517021-1b96-4933-8dbb-08df45c910c1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF00022BC7.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4494
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
index 20eaf01087ca..79d5f59e185e 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
@@ -1087,9 +1087,12 @@ static vm_fault_t svm_migrate_to_ram(struct vm_fault *vmf)
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
@@ -1132,8 +1135,40 @@ static vm_fault_t svm_migrate_to_ram(struct vm_fault *vmf)
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
index 8ffebc2c4237..278428d72e54 100644
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
@@ -3082,6 +3084,57 @@ svm_fault_allowed(struct vm_area_struct *vma, bool write_fault)
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
@@ -3250,8 +3303,39 @@ svm_range_restore_pages(struct amdgpu_device *adev, unsigned int pasid,
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
index 5c878e884582..2cbb8c109d03 100644
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

