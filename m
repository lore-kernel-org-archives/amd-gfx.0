Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91534606A327
	for <amd-gfx@archiver.kernel.org>; Sun, 22 Nov 2026 20:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=RL1dHTzv
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0F74010E641;
	Sun, 22 Nov 2026 20:26:09 +0000 (UTC)
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012025.outbound.protection.outlook.com
 [40.107.200.25])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EBCC210E641
 for <amd-gfx@lists.freedesktop.org>; Sun, 22 Nov 2026 20:25:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M7iFY8YTtsEqG1VIkeFnDOp56a6aGdzoVR5bkGQYKPPSLAEQLoN1WyeNz3x8ogLaxfS0YTg4DsddtkuCo8BQxnH5Eg/6eRYo9tdLWwuQD7Z2a56+WzBBjZIilmcFH80cja0/emRRchLncJN/S3v6s2ubheE/x0HAWdi1D1hp4BFZtpdh8rA8xIw0SjchcApYzBdqQQWjmlw1AlEG9QF5EUAqsUNQc8+mOKlIGwFubvG2ACL3CXlCw7h3op2PtApzpGwMS0HIwcrga1s96XUdh+J3BVm+uFvLLkQkvX2uO8it1l6i/P6dg5hmc7njcraXSCUYN1Cq2IGDrDA6/KW9qQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=obtFQF39hRa7V/bpKAkyV7XKc0RLiQkNytWqgFM9IlQ=;
 b=cqg8mc9ymcEUteNOyFU1L0PhW6taXpBTF2rUjbIV15hXTn77FlK9YGkOEJNb0Bs40G/lMBpJDhvzt6Z84Qa+wvFnTvHbl/818XDpc2WHRk2uNbTYd6a78WtCpqH8u+lj0gLzDiRL68g7uW5uqBd7FABbnpgjrlwRwJ7yTVQRdmdWyWuo3Bp4F9BCARcr6HhLY/7XkNaV9x4L3TrLGsfo09SOwx4czc0/IyxqRHgK5VkYa3miSH6nOGr+LGNHz7YcrFoeAJFVOz3M/Ll1wScODK2JffAC+D4erb4/EXI7nhTFoHFS9CqpLK/7qWKzKL5WiF4u+6VNOz3WDQo2EWCr/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=obtFQF39hRa7V/bpKAkyV7XKc0RLiQkNytWqgFM9IlQ=;
 b=RL1dHTzvrxf+fjWFk3rVXtJUpI9EMh2r/nFSpBGu5342W6GP/wtqBm6+tpRI9+oCFk7jl+XOiCGvV3LlovBsSy1X3sISr7WVtDtYu2ciEJRN1YPbVQ2QXABsQOgfgMcTn8g9ZaCxqqNLIKO8Y+b8SNEbOVoD8VdwoUo5zGeITgw=
Received: from CYZPR05CA0040.namprd05.prod.outlook.com (2603:10b6:930:a3::17)
 by BL1PR12MB5921.namprd12.prod.outlook.com (2603:10b6:208:398::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.13; Sun, 22 Nov
 2026 20:25:53 +0000
Received: from MWH0EPF000DD30D.namprd05.prod.outlook.com
 (2603:10b6:930:a3:cafe::ad) by CYZPR05CA0040.outlook.office365.com
 (2603:10b6:930:a3::17) with Microsoft SMTP Server (version=TLS1_3,
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
 15.21.639.5 via Frontend Transport; Sun, 22 Nov 2026 20:25:51 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Sun, 22 Nov
 2026 14:25:47 -0600
Received: from Xiaogang-ROCM-Dev.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.57
 via Frontend Transport; Sun, 22 Nov 2026 14:25:47 -0600
From: Xiaogang.Chen <xiaogang.chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Xiaogang Chen <xiaogang.chen@amd.com>
Subject: [PATCH v5 3/3] drm/amdkfd: Enable HMM device-private THP migration in
 KFD SVM driver
Date: Sun, 22 Nov 2026 14:26:53 -0600
Message-ID: <20261122202653.274580-4-xiaogang.chen@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261122202653.274580-1-xiaogang.chen@amd.com>
References: <20261122202653.274580-1-xiaogang.chen@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000DD30D:EE_|BL1PR12MB5921:EE_
X-MS-Office365-Filtering-Correlation-Id: ea80271b-d256-418d-2625-08df48d6cd79
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|36860700016|376014|1800799024|82310400026|10067099003|11063799006|56012099006|261009223027099003|261022075727099003|261021123027099003|261022105027099003|261022113327099003|261021121427099003|261102123227099003|261026121527099003|261026140227099003|261028144727099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info: JpjjD5/P9b5hIyznS4xvDYxB5C8WTtRAd0nrs9dHDKxI0sqUDrxjQFvz1qxH1Kqdj4zqWNNdpuy0rTq8LkMHxVv6GgFzTEamZX41LlSjop1ALcpc316uhaZwYJFS+qIiiVp9o82jbSsmxn6q+yYzwz5xcbNAnmlvEmpuy+IguAAvqiM/nPtNJkrdcFoniOoFNju7zx4Q/GLJ1AZnT5vViyWAWWShrjT8Ekhd5wULj9E0f1PaUVaHmiSP+OkefO3c2mzdRUniqaNmXWwdhjhd2YBLL15QllBk6jMGZVWfGX0n1KrMDsfQfn1dUJ64lUFU6KeGEp0ensUS/TIMFimPrWlV2en8byPExDDeepEjIAdPAkJUIrEgcZERTMLypzWJbGcrX/J3ImfD0LXJ01tjVT1nnyo7mw8ORaxdMFklcm+ITuL1dqYsPzXczvGIO4/2LuVAHrFQzo/cRXIe01ZX4MkYr60PXFqANGntJL88ZXhamj3hi4rvSLfU2p4151AoLaMKxe4diSzwgva3tm7UqN/PGlcAc5VoGRgo1BPai8z9wxxmduEvnkH4WA6cW3XGkmkfUEDvSNxOWtJooRttyVXjSH2O0ra70DL9PADS9Uq+ZK4OZGQ8V718lKTO0t7SxctvCCtmKjAyOc0Gd45fSDHpu6X1Od6ooyZE9jZMI7G36Y2vEGCyXu9HH0IMll0dsOsvjveLqwaUyjdh/8EmHg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(36860700016)(376014)(1800799024)(82310400026)(10067099003)(11063799006)(56012099006)(261009223027099003)(261022075727099003)(261021123027099003)(261022105027099003)(261022113327099003)(261021121427099003)(261102123227099003)(261026121527099003)(261026140227099003)(261028144727099003)(18002099003)(22082099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 7h15YBlVGCHpPEoHzIY5dzE76Op/V55HtdeCrQ2wrlBfdLUkvQcAM87IQ2f7hKGmhpoxRkDRj5fB/f9p3KIwm3LeeGzYM4fXt8OJZ6gh0rGweDnvKotcTD/jhhwUtnDTa8KL0FSdqIY1tZQKkasu90IdNXiYqCs6rIzAOv2gws1V/oWMGntEysnJzqRlXtSqfXbJg7CDh63rO/00AnOl3GnpMu0z0+Nj6bPrAH1+o50smwKly41ygueUrnxBp17NIpLlG/+KC7EBtWHoJaPOLWqToYteSj8UcLZoxdlD+lUoD9SLC08p/LnczOc9ekaJaa5lj4X8s1cMD6QDina52icUhrtAecxTQfgcOfJVwjRJEVxXEmaBfNK+AUXWzVZYpxsWXgFwgoLEdKf8wICect7bGPYdl09NhYxg5RHyaxO7HjO1OXI+UTa0hIMES6dS
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2026 20:25:51.6021 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ea80271b-d256-418d-2625-08df48d6cd79
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000DD30D.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5921
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

HMM migrates a PMD-mapped THP as one compound folio when
migrate_vma_setup() is passed MIGRATE_VMA_SELECT_COMPOUND.

Without that flag the collect path splits the source THP to 4K pages.
If split_folio() fails because of extra refs or pins, those pages are
skipped.

Set SELECT_COMPOUND for device-private ranges whose migrate window is
at least HPAGE_PMD_NR pages. The RAM<->VRAM copy path follows
MIGRATE_PFN_COMPOUND in src[] (HPAGE_PMD_ORDER device folio, THP DMA)
and keeps the existing 4K path otherwise.

Coherent zone-device memory is unchanged.

Signed-off-by: Xiaogang Chen <xiaogang.chen@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_migrate.c | 582 +++++++++++++++++++++--
 1 file changed, 530 insertions(+), 52 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
index 11cda92b8878..aeb74d812c6c 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
@@ -340,6 +340,153 @@ static unsigned long svm_migrate_successful_pages(struct migrate_vma *migrate)
 	return mpages;
 }
 
+/*
+ * A reused svm_bo VRAM page may still be held by someone else, ex:
+ * (do_swap_page -> svm_migrate_to_ram). Migrating to VRAM re-initializes
+ * the page and resets its refcount, so the other's put_page() would
+ * free it mid-migration. Report whether any of the @nr VRAM pages starting
+ * at page offset @m of @cursor is still referenced. @cursor is a copy, so
+ * the range may cross VRAM blocks without moving the caller's cursor.
+ *
+ * Check the folio, not the page: a tail page of a live device THP always
+ * has a zero refcount while its folio is held.
+ */
+static bool
+svm_migrate_vram_busy(struct amdgpu_device *adev,
+		      struct amdgpu_res_cursor cursor, u64 m, u64 nr)
+{
+	while (nr) {
+		u64 chunk = cursor.size >> PAGE_SHIFT;
+		struct page *page;
+
+		if (m >= chunk) {
+			if (cursor.remaining <= cursor.size)
+				return false;
+			amdgpu_res_next(&cursor, cursor.size);
+			m -= chunk;
+			continue;
+		}
+
+		page = pfn_to_page(svm_migrate_addr_to_pfn(adev,
+					cursor.start + (m << PAGE_SHIFT)));
+		if (folio_ref_count(page_folio(page)))
+			return true;
+		m++;
+		nr--;
+	}
+
+	return false;
+}
+
+/* Move the VRAM position (@cursor, page offset @m) forward by @nr pages. */
+static void
+svm_migrate_cursor_skip(struct amdgpu_res_cursor *cursor, u64 *m, u64 nr)
+{
+	*m += nr;
+	while (*m >= (cursor->size >> PAGE_SHIFT) &&
+	       cursor->remaining > cursor->size) {
+		*m -= cursor->size >> PAGE_SHIFT;
+		amdgpu_res_next(cursor, cursor->size);
+	}
+}
+
+/*
+ * Place one MIGRATE_PFN_COMPOUND source into 4K device pages.
+ *
+ * A device THP needs one PMD-aligned VRAM run. This folio does not have
+ * that run: its device pages continue into the next VRAM block. Publish
+ * one dst pfn per page so migrate_vma_pages() can split the source, and
+ * copy each contiguous VRAM run separately. SDMA copies a contiguous
+ * destination; a single 2MB copy cannot cross a block boundary.
+ *
+ * @m_in is the page offset in the current block. On return *@m_out is the
+ * offset of the next page, or the block size when the folio ends on a
+ * block boundary.
+ */
+static int
+svm_migrate_compound_to_4k_vram(struct amdgpu_device *adev, struct device *dev,
+				struct svm_range *prange,
+				struct migrate_vma *migrate,
+				struct dma_fence **mfence,
+				struct amdgpu_res_cursor *cursor,
+				dma_addr_t *src, u64 *dst, unsigned long idx,
+				u64 m_in, u64 *m_out)
+{
+	struct page *spage = migrate_pfn_to_page(migrate->src[idx]);
+	unsigned long done = 0;
+	bool mapped = false;
+	u64 m = m_in;
+	int r = 0;
+
+	if (spage && !is_zone_device_page(spage)) {
+		unsigned long l;
+
+		src[idx] = dma_map_page(dev, spage, 0, PAGE_SIZE * SVM_HPAGE_PMD_NR,
+					DMA_BIDIRECTIONAL);
+		r = dma_mapping_error(dev, src[idx]);
+		if (r) {
+			dev_err(dev, "%s: fail %d dma_map_page\n", __func__, r);
+			src[idx] = 0;
+			return r;
+		}
+
+		for (l = 1; l < SVM_HPAGE_PMD_NR; l++)
+			src[idx + l] = src[idx] + l * PAGE_SIZE;
+		mapped = true;
+	}
+
+	while (done < SVM_HPAGE_PMD_NR) {
+		unsigned long chunk_pages = cursor->size >> PAGE_SHIFT;
+		unsigned long room = chunk_pages > m ? chunk_pages - m : 0;
+		unsigned long step = min_t(unsigned long, SVM_HPAGE_PMD_NR - done, room);
+		unsigned long l;
+
+		if (!step) {
+			r = -ENOSPC;
+			break;
+		}
+
+		for (l = 0; l < step; l++) {
+			u64 addr = cursor->start + ((m + l) << PAGE_SHIFT);
+			unsigned long pfn = svm_migrate_addr_to_pfn(adev, addr);
+
+			dst[idx + done + l] = addr;
+			svm_migrate_get_vram_page(prange, pfn, 0);
+			migrate->dst[idx + done + l] = migrate_pfn(pfn);
+		}
+
+		if (mapped) {
+			r = svm_migrate_copy_memory_gart(adev, src + idx + done,
+							 dst + idx + done, step,
+							 FROM_RAM_TO_VRAM, mfence);
+			if (r)
+				break;
+		}
+
+		done += step;
+		m += step;
+		if (done < SVM_HPAGE_PMD_NR && m == chunk_pages) {
+			amdgpu_res_next(cursor, m << PAGE_SHIFT);
+			m = 0;
+			if (!cursor->remaining) {
+				r = -ENOSPC;
+				break;
+			}
+		}
+	}
+
+	if (mapped) {
+		unsigned long l;
+
+		src[idx] |= SVM_RANGE_DMA_THP;
+		for (l = 1; l < SVM_HPAGE_PMD_NR; l++)
+			src[idx + l] = 0;
+	}
+
+	*m_out = m;
+	return r;
+}
+
 static int
 svm_migrate_copy_to_vram(struct kfd_node *node, struct svm_range *prange,
 			 struct migrate_vma *migrate, struct dma_fence **mfence,
@@ -352,7 +499,7 @@ svm_migrate_copy_to_vram(struct kfd_node *node, struct svm_range *prange,
 	u64 mpages = 0;
 	dma_addr_t *src;
 	u64 *dst;
-	u64 i, j;
+	u64 i, j, k, l, m;
 	int r = 0;
 
 	pr_debug("svms 0x%p [0x%lx 0x%lx 0x%llx]\n", prange->svms, prange->start,
@@ -363,69 +510,251 @@ svm_migrate_copy_to_vram(struct kfd_node *node, struct svm_range *prange,
 
 	amdgpu_res_first(prange->ttm_res, ttm_res_offset,
 			 npages << PAGE_SHIFT, &cursor);
-	for (i = j = 0; (i < npages) && (mpages < migrate->cpages); i++) {
-		struct page *spage = migrate_pfn_to_page(migrate->src[i]);
+	for (i = j = m = 0; (i < npages) && (mpages < migrate->cpages);) {
+		struct page *spage;
+		unsigned long cur_dst_pfn;
+		bool thp_dst = false;
+		bool busy = false;
+
+		cur_dst_pfn = svm_migrate_addr_to_pfn(adev,
+						      cursor.start + (m << PAGE_SHIFT));
+
+		/*
+		 * MIGRATE_PFN_COMPOUND is one slot for the whole folio.
+		 * src[i+1 .. i+SVM_HPAGE_PMD_NR-1] stay zero and cpages counts
+		 * the folio once. migrate_vma_pages() splits that folio when
+		 * dst[i] is not compound and then reads every tail dst slot.
+		 * Those slots must be real pages. A device THP is placed only
+		 * at a PMD-aligned VRAM pfn. Any other compound source is
+		 * migrated as 4K device pages, including when the folio
+		 * crosses a VRAM block.
+		 */
+		if (migrate->src[i] & MIGRATE_PFN_COMPOUND) {
+			unsigned long room = (cursor.size >> PAGE_SHIFT) - m;
+			bool fits = room >= SVM_HPAGE_PMD_NR;
 
-		if (migrate->src[i] & MIGRATE_PFN_MIGRATE) {
-			dst[i] = cursor.start + (j << PAGE_SHIFT);
-			migrate->dst[i] = svm_migrate_addr_to_pfn(adev, dst[i]);
 			/*
-			 * A reused svm_bo page may still be held by a CPU fault.
+			 * HMM collects a compound entry only for a PMD fully
+			 * inside [start, end), so the folio cannot run past
+			 * npages. If it ever does, fail the whole window: the
+			 * error path releases every published VRAM page,
+			 * including the 4K pages still pending in j.
+			 */
+			if (WARN_ON_ONCE(i + SVM_HPAGE_PMD_NR > npages)) {
+				r = -EINVAL;
+				goto out_free_vram_pages;
+			}
+
+			/*
+			 * Every path below re-initializes all SVM_HPAGE_PMD_NR
+			 * VRAM pages, and a split source needs a page in every
+			 * dst slot, so single pages cannot be skipped. If any
+			 * target page is still referenced (see
+			 * svm_migrate_vram_busy()), leave the whole folio in
+			 * system memory. Flush the pending run first: the next
+			 * VRAM page is no longer contiguous with it.
+			 */
+			if (svm_migrate_vram_busy(adev, cursor, m,
+						  SVM_HPAGE_PMD_NR)) {
+				if (j) {
+					r = svm_migrate_copy_memory_gart(
+						adev, src + i - j, dst + i - j,
+						j, FROM_RAM_TO_VRAM, mfence);
+					if (r)
+						goto out_free_vram_pages;
+					j = 0;
+				}
+				svm_migrate_cursor_skip(&cursor, &m,
+							SVM_HPAGE_PMD_NR);
+				i += SVM_HPAGE_PMD_NR;
+				continue;
+			}
+
+			if (!fits) {
+				u64 m_next;
+
+				if (j) {
+					r = svm_migrate_copy_memory_gart(
+						adev, src + i - j, dst + i - j,
+						j, FROM_RAM_TO_VRAM, mfence);
+					if (r)
+						goto out_free_vram_pages;
+					j = 0;
+				}
+
+				r = svm_migrate_compound_to_4k_vram(adev, dev,
+								    prange,
+								    migrate,
+								    mfence,
+								    &cursor,
+								    src, dst,
+								    i, m,
+								    &m_next);
+				if (r)
+					goto out_free_vram_pages;
+
+				mpages++;
+				i += SVM_HPAGE_PMD_NR;
+				m = m_next;
+				if (cursor.remaining &&
+				    m == (cursor.size >> PAGE_SHIFT)) {
+					amdgpu_res_next(&cursor, m << PAGE_SHIFT);
+					m = 0;
+				}
+				continue;
+			}
+
+			k = SVM_HPAGE_PMD_NR;
+			thp_dst = IS_ALIGNED(cur_dst_pfn, SVM_HPAGE_PMD_NR);
+		} else {
+			k = 1;
+		}
+
+		if (thp_dst) {
+			dst[i] = cursor.start + (m << PAGE_SHIFT);
+			svm_migrate_get_vram_page(prange, cur_dst_pfn,
+						  SVM_HPAGE_PMD_ORDER);
+
+			migrate->dst[i] = migrate_pfn(cur_dst_pfn) |
+					  MIGRATE_PFN_COMPOUND;
+
+			for (l = 1; l < k; l++)
+				migrate->dst[i + l] = 0;
+
+			mpages++;
+		} else if (k > 1) {
+			for (l = 0; l < k; l++) {
+				unsigned long pfn = cur_dst_pfn + l;
+
+				dst[i + l] = cursor.start + ((m + l) << PAGE_SHIFT);
+				svm_migrate_get_vram_page(prange, pfn, 0);
+				migrate->dst[i + l] = migrate_pfn(pfn);
+			}
+			mpages++;
+		} else if (migrate->src[i] & MIGRATE_PFN_MIGRATE) {
+			/*
+			 * A reused svm_bo page may still be held by someone else.
 			 * Reinitializing it would free it under this migration,
 			 * so leave this page in system memory.
 			 */
-			if (page_ref_count(pfn_to_page(migrate->dst[i]))) {
-				dst[i] = 0;
-				migrate->dst[i] = 0;
-				spage = NULL;
-			} else {
-				svm_migrate_get_vram_page(prange, migrate->dst[i], 0);
-				migrate->dst[i] = migrate_pfn(migrate->dst[i]);
+			busy = svm_migrate_vram_busy(adev, cursor, m, 1);
+			if (!busy) {
+				dst[i] = cursor.start + (m << PAGE_SHIFT);
+				svm_migrate_get_vram_page(prange, cur_dst_pfn, 0);
+				migrate->dst[i] = migrate_pfn(cur_dst_pfn);
 				mpages++;
 			}
 		}
-		if (spage && !is_zone_device_page(spage)) {
-			src[i] = dma_map_page(dev, spage, 0, PAGE_SIZE,
-					      DMA_BIDIRECTIONAL);
-			r = dma_mapping_error(dev, src[i]);
-			if (r) {
-				src[i] = 0;
-				dev_err(dev, "%s: fail %d dma_map_page\n",
-					__func__, r);
-				goto out_free_vram_pages;
+
+		if (k > 1) {
+			if (j) {
+				/* migrate previous accumulated pages */
+				r = svm_migrate_copy_memory_gart(
+						adev, src + i - j,
+						dst + i - j, j,
+						FROM_RAM_TO_VRAM,
+						mfence);
+
+				if (r)
+					goto out_free_vram_pages;
+
+				j = 0;
+			}
+
+			/* for THP check if the first src page is valid
+			 * if not valid skip following SVM_HPAGE_PMD_NR - 1 pages
+			 */
+			spage = migrate_pfn_to_page(migrate->src[i]);
+			if (spage && !is_zone_device_page(spage)) {
+				/* dma_map continuous SVM_HPAGE_PMD_NR sys ram pages */
+				src[i] = dma_map_page(dev, spage, 0, PAGE_SIZE*SVM_HPAGE_PMD_NR,
+						      DMA_BIDIRECTIONAL);
+
+				r = dma_mapping_error(dev, src[i]);
+				if (r) {
+					dev_err(dev, "%s: fail %d dma_map_page\n",
+							__func__, r);
+					goto out_free_vram_pages;
+				}
+
+				/* get dma address for following SVM_HPAGE_PMD_NR-1 pages
+				 * since src pages are continuous their dma addresses
+				 * are continuous too.
+				 */
+				for (l = 1; l < k; l++)
+					src[i + l] = src[i] + l*PAGE_SIZE;
+
+				/* migrate the SVM_HPAGE_PMD_NR pages above */
+				r = svm_migrate_copy_memory_gart(
+						adev, src + i,
+						dst + i, SVM_HPAGE_PMD_NR,
+						FROM_RAM_TO_VRAM,
+						mfence);
+
+				/* mark head page dma mapping as THP, tail pages dma addr
+				 * are set to 0 for following dma_unmap
+				 */
+				src[i] |= SVM_RANGE_DMA_THP;
+				for (l = 1; l < k; l++)
+					src[i + l] = 0;
+
+				if (r)
+					goto out_free_vram_pages;
+
+				j = 0;
 			}
 		} else {
-			if (j) {
+			/*
+			 * single normal page case; a busy VRAM page is not
+			 * migrated, so treat it like a page with no source
+			 */
+			spage = busy ? NULL : migrate_pfn_to_page(migrate->src[i]);
+			if (spage && !is_zone_device_page(spage)) {
+				src[i] = dma_map_page(dev, spage, 0, PAGE_SIZE,
+						      DMA_BIDIRECTIONAL);
+
+				r = dma_mapping_error(dev, src[i]);
+
+				if (r) {
+					dev_err(dev, "%s: fail %d dma_map_page\n",
+							__func__, r);
+					goto out_free_vram_pages;
+				}
+				j += 1;
+
+			} else if (j) {
 				r = svm_migrate_copy_memory_gart(
 						adev, src + i - j,
 						dst + i - j, j,
 						FROM_RAM_TO_VRAM,
 						mfence);
+
 				if (r)
 					goto out_free_vram_pages;
-				amdgpu_res_next(&cursor, (j + 1) << PAGE_SHIFT);
+
 				j = 0;
-			} else {
-				amdgpu_res_next(&cursor, PAGE_SIZE);
 			}
-			continue;
 		}
 
-		pr_debug_ratelimited("dma mapping src to 0x%llx, pfn 0x%lx\n",
-				     src[i] >> PAGE_SHIFT, page_to_pfn(spage));
+		pr_debug_ratelimited("dma mapping %lld pages, src to 0x%llx, pfn 0x%lx\n",
+				     k, src[i] >> PAGE_SHIFT, migrate->src[i] >> MIGRATE_PFN_SHIFT);
+		i += k;
+		m += k;
+
+		if (m >= (cursor.size >> PAGE_SHIFT)) {
+			if (j > 0) {
+				r = svm_migrate_copy_memory_gart(adev, src + i - j,
+								 dst + i - j, j,
+								 FROM_RAM_TO_VRAM,
+								 mfence);
+				if (r)
+					goto out_free_vram_pages;
+			}
+
+			amdgpu_res_next(&cursor, m*PAGE_SIZE);
 
-		/* accumulated j + 1 pages reach end of current drm_buddy_block */
-		if (j + 1 >= (cursor.size >> PAGE_SHIFT)) {
-			r = svm_migrate_copy_memory_gart(adev, src + i - j,
-							 dst + i - j, j + 1,
-							 FROM_RAM_TO_VRAM,
-							 mfence);
-			if (r)
-				goto out_free_vram_pages;
-			amdgpu_res_next(&cursor, (j + 1) * PAGE_SIZE);
 			j = 0;
-		} else {
-			j++;
+			m = 0;
 		}
 	}
 
@@ -436,12 +765,16 @@ svm_migrate_copy_to_vram(struct kfd_node *node, struct svm_range *prange,
 out_free_vram_pages:
 	if (r) {
 		pr_debug("failed %d to copy memory to vram\n", r);
-		for (i = 0; i < npages && mpages; i++) {
+		/*
+		 * A split compound source allocates one dst page per tail
+		 * slot while mpages still counts the folio once. Release
+		 * every page that was published.
+		 */
+		for (i = 0; i < npages; i++) {
 			if (!dst[i])
 				continue;
 			svm_migrate_put_vram_page(adev, dst[i]);
 			migrate->dst[i] = 0;
-			mpages--;
 		}
 	}
 
@@ -514,6 +847,7 @@ svm_migrate_vma_to_vram(struct kfd_node *node, struct svm_range *prange,
 	struct kfd_process_device *pdd;
 	struct dma_fence *mfence = NULL;
 	struct migrate_vma migrate = { 0 };
+	bool is_private_device = false;
 	unsigned long cpages = 0;
 	unsigned long mpages = 0;
 	dma_addr_t *scratch;
@@ -526,11 +860,18 @@ svm_migrate_vma_to_vram(struct kfd_node *node, struct svm_range *prange,
 	if (svm_range_window_resident(node, prange, start, end))
 		return 0;
 
+	is_private_device = svm_is_private_zone(adev);
+
 	memset(&migrate, 0, sizeof(migrate));
 	migrate.vma = vma;
 	migrate.start = start;
 	migrate.end = end;
 	migrate.flags = MIGRATE_VMA_SELECT_SYSTEM;
+
+	if (SVM_THP_ENABLED && is_private_device &&
+	    ((end - start) >> PAGE_SHIFT) >= SVM_HPAGE_PMD_NR)
+		migrate.flags = migrate.flags | MIGRATE_VMA_SELECT_COMPOUND;
+
 	migrate.pgmap_owner = SVM_ADEV_PGMAP_OWNER(adev);
 
 	buf = kvcalloc(npages,
@@ -711,6 +1052,57 @@ static void svm_migrate_folio_free(struct folio *folio)
 	}
 }
 
+/*
+ * Migrate one compound device folio at @idx to 4K system pages, used when
+ * no THP destination can be allocated.
+ *
+ * When dst[idx] is not compound, migrate_vma_pages() splits the source
+ * folio and then migrates every one of its SVM_HPAGE_PMD_NR pages, reading
+ * each tail dst slot without a NULL check. So every slot must get a real
+ * page here, not just the head.
+ *
+ * The device folio is contiguous in VRAM, so one copy covers all pages.
+ * On error, pages already published in migrate->dst[] and their DMA
+ * mappings in @dst are released by the caller's error path.
+ */
+static int
+svm_migrate_compound_to_4k_ram(struct amdgpu_device *adev,
+			       struct migrate_vma *migrate,
+			       struct dma_fence **mfence, dma_addr_t *dst,
+			       u64 *src, u64 idx, u64 addr)
+{
+	struct device *dev = adev->dev;
+	unsigned long l;
+	int r;
+
+	for (l = 0; l < SVM_HPAGE_PMD_NR; l++) {
+		struct page *dpage;
+
+		dpage = svm_migrate_get_sys_page(migrate->vma,
+						 addr + l * PAGE_SIZE, 0);
+		if (!dpage)
+			return -ENOMEM;
+
+		dst[idx + l] = dma_map_page(dev, dpage, 0, PAGE_SIZE,
+					    DMA_BIDIRECTIONAL);
+		r = dma_mapping_error(dev, dst[idx + l]);
+		if (r) {
+			dev_err(dev, "%s: fail %d dma_map_page\n", __func__, r);
+			dst[idx + l] = 0;
+			unlock_page(dpage);
+			put_page(dpage);
+			return r;
+		}
+
+		migrate->dst[idx + l] = migrate_pfn(page_to_pfn(dpage));
+		src[idx + l] = src[idx] + l * PAGE_SIZE;
+	}
+
+	return svm_migrate_copy_memory_gart(adev, dst + idx, src + idx,
+					    SVM_HPAGE_PMD_NR, FROM_VRAM_TO_RAM,
+					    mfence);
+}
+
 static int
 svm_migrate_copy_to_ram(struct amdgpu_device *adev, struct svm_range *prange,
 			struct migrate_vma *migrate, struct dma_fence **mfence,
@@ -724,6 +1116,7 @@ svm_migrate_copy_to_ram(struct amdgpu_device *adev, struct svm_range *prange,
 	u64 i = 0, j;
 	u64 addr;
 	int r = 0;
+	u64 l, k;
 
 	pr_debug("svms 0x%p [0x%lx 0x%lx]\n", prange->svms, prange->start,
 		 prange->last);
@@ -732,8 +1125,7 @@ svm_migrate_copy_to_ram(struct amdgpu_device *adev, struct svm_range *prange,
 
 	src = (u64 *)(scratch + npages);
 	dst = scratch;
-
-	for (i = 0, j = 0; i < npages; i++, addr += PAGE_SIZE) {
+	for (i = 0, j = 0, k = 1; i < npages; i += k, addr += k*PAGE_SIZE, k = 1) {
 		struct page *spage;
 
 		spage = migrate_pfn_to_page(migrate->src[i]);
@@ -749,6 +1141,7 @@ svm_migrate_copy_to_ram(struct amdgpu_device *adev, struct svm_range *prange,
 					goto out_oom;
 				j = 0;
 			}
+
 			continue;
 		}
 		src[i] = svm_migrate_addr(adev, spage);
@@ -762,7 +1155,58 @@ svm_migrate_copy_to_ram(struct amdgpu_device *adev, struct svm_range *prange,
 			j = 0;
 		}
 
-		dpage = svm_migrate_get_sys_page(migrate->vma, addr, 0);
+		if (migrate->src[i] & MIGRATE_PFN_COMPOUND) {
+			/*
+			 * Flush accumulated 4K pages before mapping the 2MB
+			 * destination, so a flush failure never leaves a 2MB
+			 * dst[i] mapping that is not yet marked SVM_RANGE_DMA_THP.
+			 */
+			if (j) {
+				r = svm_migrate_copy_memory_gart(adev, dst + i - j,
+								 src + i - j, j,
+								 FROM_VRAM_TO_RAM,
+								 mfence);
+				if (r)
+					goto out_oom;
+				j = 0;
+			}
+
+			/*
+			 * HMM collects a compound entry only for a PMD fully
+			 * inside [start, end), so the folio cannot run past
+			 * npages.
+			 */
+			if (WARN_ON_ONCE(i + SVM_HPAGE_PMD_NR > npages)) {
+				r = -EINVAL;
+				goto out_oom;
+			}
+
+			k = SVM_HPAGE_PMD_NR;
+			dpage = NULL;
+			if (IS_ALIGNED(page_to_pfn(spage), SVM_HPAGE_PMD_NR) &&
+			    IS_ALIGNED(addr, SVM_HPAGE_PMD_SIZE))
+				dpage = svm_migrate_get_sys_page(migrate->vma,
+							addr, SVM_HPAGE_PMD_ORDER);
+
+			/*
+			 * No THP destination (allocation failed or THP is
+			 * disabled for the VMA): migrate the whole folio as
+			 * SVM_HPAGE_PMD_NR 4K pages so migrate_vma_pages() finds
+			 * a page in every slot after it splits the source.
+			 */
+			if (!dpage) {
+				r = svm_migrate_compound_to_4k_ram(adev, migrate,
+								   mfence, dst,
+								   src, i, addr);
+				if (r)
+					goto out_oom;
+				continue;
+			}
+		} else {
+			k = 1;
+			dpage = svm_migrate_get_sys_page(migrate->vma, addr, 0);
+		}
+
 		if (!dpage) {
 			pr_debug("failed get page svms 0x%p [0x%lx 0x%lx]\n",
 				 prange->svms, prange->start, prange->last);
@@ -770,7 +1214,7 @@ svm_migrate_copy_to_ram(struct amdgpu_device *adev, struct svm_range *prange,
 			goto out_oom;
 		}
 
-		dst[i] = dma_map_page(dev, dpage, 0, PAGE_SIZE, DMA_BIDIRECTIONAL);
+		dst[i] = dma_map_page(dev, dpage, 0, PAGE_SIZE*k, DMA_BIDIRECTIONAL);
 		r = dma_mapping_error(dev, dst[i]);
 		if (r) {
 			dev_err(adev->dev, "%s: fail %d dma_map_page\n", __func__, r);
@@ -778,13 +1222,40 @@ svm_migrate_copy_to_ram(struct amdgpu_device *adev, struct svm_range *prange,
 			goto out_oom;
 		}
 
-		pr_debug_ratelimited("dma mapping dst to 0x%llx, pfn 0x%lx\n",
-				     dst[i] >> PAGE_SHIFT, page_to_pfn(dpage));
-
 		migrate->dst[i] = migrate_pfn(page_to_pfn(dpage));
-
 		dpage = NULL;
-		j++;
+
+		if (k > 1) {
+			migrate->dst[i] |= MIGRATE_PFN_COMPOUND;
+
+			for (l = 1; l < k; l++) {
+
+				src[i + l] = src[i] + l*PAGE_SIZE;
+				dst[i + l] = dst[i] + l*PAGE_SIZE;
+				migrate->dst[i + l] = 0;
+			}
+
+			/* migrate the SVM_HPAGE_PMD_NR pages above
+			 * the migration is for 2MB THP
+			 */
+			r = svm_migrate_copy_memory_gart(
+						adev, dst + i,
+						src + i, SVM_HPAGE_PMD_NR,
+						FROM_VRAM_TO_RAM,
+						mfence);
+
+			/* mark head page dma mapping as THP, tail pages dma addr
+			 * are set to 0 for following dma_unmap
+			 */
+			dst[i] |= SVM_RANGE_DMA_THP;
+			for (l = 1; l < k; l++)
+				dst[i + l] = 0;
+
+			if (r)
+				goto out_oom;
+
+		} else
+			j++;
 	}
 
 	if (j > 0)
@@ -849,6 +1320,7 @@ svm_migrate_vma_to_ram(struct kfd_node *node, struct svm_range *prange,
 	unsigned long cpages = 0;
 	unsigned long mpages = 0;
 	struct amdgpu_device *adev = node->adev;
+	bool is_private_device = false;
 	struct kfd_process_device *pdd;
 	struct dma_fence *mfence = NULL;
 	struct migrate_vma migrate = { 0 };
@@ -856,6 +1328,8 @@ svm_migrate_vma_to_ram(struct kfd_node *node, struct svm_range *prange,
 	void *buf;
 	int r = -ENOMEM;
 
+	is_private_device = svm_is_private_zone(adev);
+
 	memset(&migrate, 0, sizeof(migrate));
 	migrate.vma = vma;
 	migrate.start = start;
@@ -866,6 +1340,10 @@ svm_migrate_vma_to_ram(struct kfd_node *node, struct svm_range *prange,
 	else
 		migrate.flags = MIGRATE_VMA_SELECT_DEVICE_PRIVATE;
 
+	if (SVM_THP_ENABLED && is_private_device &&
+	    ((end - start) >> PAGE_SHIFT) >= SVM_HPAGE_PMD_NR)
+		migrate.flags = migrate.flags | MIGRATE_VMA_SELECT_COMPOUND;
+
 	buf = kvcalloc(npages,
 		       2 * sizeof(*migrate.src) + sizeof(u64) + sizeof(dma_addr_t),
 		       GFP_KERNEL);
-- 
2.34.1

