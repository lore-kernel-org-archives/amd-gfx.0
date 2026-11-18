Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50229606A947
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Nov 2026 23:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=wHVJFIKZ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A60A41120B3;
	Wed, 18 Nov 2026 23:10:15 +0000 (UTC)
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013070.outbound.protection.outlook.com
 [40.93.201.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A808410E358
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Nov 2026 23:10:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LCVVuvBhiES5rmU6tv1FdOxnbmKCiQ/UfprYgl3OGqoBS9DfuqfR/rXynN3DOhZDN3rD1Hl8C7rWjKh/g6XASomCaARxYrDmZMZ0kxH9midTF4Fbk9INDGzsxAZo7fOqO77xXPDuvuNq7Jy+VrOGo2trj+fu1Qrh4W5ykA2PgnJCKlSqEyMCUYxppCKwHxTDD9nUcKYIWrkoWGyOkbG5JbxYoNiKORpQcYmxGd/SKaJNHgpWO1c9YGvdqNP8ZPDHFI5yurCkEPIQ2goiFvY2RH7DmPMWNQxTO9u5uZeczkSsC5OCSGp+KeKrGS8wgRNqNqa3uB1q6QElQp6CKL+tkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KA9oPpH8OqcMdlVESiUaoPhh/OvIG8qOxGsqxwyL+3g=;
 b=Cu+zSQHB8HcJ2Eh+W5SE7+XJBhHX2DTmnqKgf0DV79xlmHnOSOh/ANtvVzy/R/zXS6yGuoyTzjqayS/orAd4TF6Gw9zCH0lGB/A26rTEX+hK69AaFp58fWblOGPoLTmUu/BKkKRpTuWtg8wzUzKhicSqnFC9IswCaoHPIbHuAhru8QVwI4xjyeqRI8NRtdzaUyQFVjaOOnQ8Vi8gUbLRXAYnx2B7IkOoYoEmxWW47/KC/6Cb3z4nPrD3PiWIiDIiWfm11o5QmiMBx09EAevd1Unoy7uM383FmvC9DdzMOOa9OYTZ4H/aA69Zw2K4lTbIUfN+s1vBtTUS4xUvGWrZfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KA9oPpH8OqcMdlVESiUaoPhh/OvIG8qOxGsqxwyL+3g=;
 b=wHVJFIKZXRJcLhi7e7h8Cf+jz2XMMq9QMpXFymxgQyI3ocjzc3rsVuMKhdpsy7gzRM0mCAQpDHgsYAm5d4k4F96bhYqyh51GRDrICQnUyksOWHeBfgYh6jucqW/fNa3lm7Ik5RIGWZAeLqjwTAzhL1CBsTy/vAV2YXSP8j6FLCs=
Received: from SJ0PR05CA0190.namprd05.prod.outlook.com (2603:10b6:a03:330::15)
 by IA0PR12MB8696.namprd12.prod.outlook.com (2603:10b6:208:48f::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.9; Wed, 18 Nov
 2026 23:10:01 +0000
Received: from MWH0EPF000C618B.namprd02.prod.outlook.com
 (2603:10b6:a03:330:cafe::42) by SJ0PR05CA0190.outlook.office365.com
 (2603:10b6:a03:330::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.639.0 via Frontend Transport; Wed, 18
 Nov 2026 23:09:58 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MWH0EPF000C618B.mail.protection.outlook.com (10.167.249.123) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Wed, 18 Nov 2026 23:09:58 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Wed, 18 Nov
 2026 17:09:58 -0600
Received: from Xiaogang-ROCM-Dev.amd.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.57
 via Frontend Transport; Wed, 18 Nov 2026 17:09:57 -0600
From: Xiaogang.Chen <xiaogang.chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <xiaogang.chen@amd.com>
Subject: [PATCH v4 3/3] drm/amdkfd: Enable HMM device-private THP migration in
 KFD SVM driver
Date: Wed, 18 Nov 2026 17:11:00 -0600
Message-ID: <20261118231100.68176-4-xiaogang.chen@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261118231100.68176-1-xiaogang.chen@amd.com>
References: <20261118231100.68176-1-xiaogang.chen@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000C618B:EE_|IA0PR12MB8696:EE_
X-MS-Office365-Filtering-Correlation-Id: 951d306c-4787-4cdf-5a9b-08df45c9112a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|82310400026|376014|23010399003|22082099003|18002099003|6133799003|261009223027099003|11063799006|261102123227099003|56012099006|261026140227099003|261026121527099003|261028144727099003|261022075727099003|261022105027099003|261021121427099003|261021123027099003|261022113327099003|10067099003;
X-Microsoft-Antispam-Message-Info: afMU+Jpma51kLMx58QIbIGZkJxdbJdCf2rN9jkA0j9RzcDXz2JzQzlvx6grJEai5r+yrsPFhybcsMSeUSUQ1wal937xUzTnPJzraZsnt5dSKcnF7OeoeMaIpFPEm+EscpEkCwZ9BymxLlYl7sUf3KOHHGgriWGP0d/J5QxGfuUv+NaYy6ophIAZox2RqhF7XhJ0ycYESTqoEHR3lQaHuMzF4Lfon4ZjUe7FToAaWzsa67+S1mLHdbyC/mSl8xsnFHZLpb0ca7vSgK99VuiarbFL1UTJ6+AYVRBv8Kt8x7d/8HkW7hGq2EDIMhMFCyr34Ta2ahVOdw3nHt7QuEXIoLMhGVvoqvucCraIjb0HBFLb4javFhsuDa3VhnZ3Z6WNavPq2nZ4vsXFCUYx5Bwi6EfWAvqAfKbocjGbiSxoSbEf9qBjU5OAVT1la11Lr3NEncxXFcZxiQf8dw6vyJu9ypqja4AL0wdL7MugSWvAvnoNASftpNb80/IIrPbPtkk/3eDwiEAQw+XKqmt5fJerJx54VhrikGE33DrlxMbryAByUeqFO45qt8cDBkIc4o7pAYRIjitHK4XxVgYkTVSX8OYf3xmwrUtvb8O1+xgXXAfqii3hhO9ZHrPQ8zsTMmv4yyYzCYSCw1FQDffQv6PdUBQBtT0NWGnkBYjg34EZVLPaZgdvPo1QFyidpO5KqMJrd7H5MGejO8KeDQtP63pXkFg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(82310400026)(376014)(23010399003)(22082099003)(18002099003)(6133799003)(261009223027099003)(11063799006)(261102123227099003)(56012099006)(261026140227099003)(261026121527099003)(261028144727099003)(261022075727099003)(261022105027099003)(261021121427099003)(261021123027099003)(261022113327099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Ni3LrVQ8irWvNUkFie9IY0qDkGVjsYJSwwQBgAvK98bdaf1ApX2EzI4QgEhn3qUKcx22nt91ppaROL7cICVbG98fDSIDJApF7R/Y/BlqI6AYXD7o87rx1qJLOthHPxz/pZ2EWbD9N3JP/q1Fd4H/UKJa8bIeIt2kvhm/V6yWyoAxFpZ8YArzlHAQRVbzv6w9i+U9fNntsioad8uR7D39KmYt+ydYT0U0bo2poP+r8LBXFzCldCYaSJCf/sI2wxwv0KJIdnKIiQj63nL+Uj1jAYLoOw0NcE0GmPsk3hmVnPROMabKKQ+v9pliBDaKRtKD/dyA5RqhDsfR5vGi/2Ak8gXOHzhIHsQ6t7wceK6EWff2/aGAnovocp1v/6GNtepb8fM+eGKJ/ic0hdTMKCmKqawQIAvNrk/VlnPvAvefvlpNqKubgIK+rnsdtbF5W3OP
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2026 23:09:58.7499 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 951d306c-4787-4cdf-5a9b-08df45c9112a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000C618B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8696
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
 drivers/gpu/drm/amd/amdkfd/kfd_migrate.c | 493 ++++++++++++++++++++---
 1 file changed, 447 insertions(+), 46 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
index 79d5f59e185e..b01de9a7db6d 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
@@ -340,6 +340,103 @@ static unsigned long svm_migrate_successful_pages(struct migrate_vma *migrate)
 	return mpages;
 }
 
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
@@ -352,7 +449,7 @@ svm_migrate_copy_to_vram(struct kfd_node *node, struct svm_range *prange,
 	u64 mpages = 0;
 	dma_addr_t *src;
 	u64 *dst;
-	u64 i, j;
+	u64 i, j, k, l, m;
 	int r = 0;
 
 	pr_debug("svms 0x%p [0x%lx 0x%lx 0x%llx]\n", prange->svms, prange->start,
@@ -363,59 +460,214 @@ svm_migrate_copy_to_vram(struct kfd_node *node, struct svm_range *prange,
 
 	amdgpu_res_first(prange->ttm_res, ttm_res_offset,
 			 npages << PAGE_SHIFT, &cursor);
-	for (i = j = 0; (i < npages) && (mpages < migrate->cpages); i++) {
+	for (i = j = m = 0; (i < npages) && (mpages < migrate->cpages);) {
 		struct page *spage;
+		unsigned long cur_dst_pfn;
+		bool thp_dst = false;
 
-		if (migrate->src[i] & MIGRATE_PFN_MIGRATE) {
-			dst[i] = cursor.start + (j << PAGE_SHIFT);
-			migrate->dst[i] = svm_migrate_addr_to_pfn(adev, dst[i]);
-			svm_migrate_get_vram_page(prange, migrate->dst[i], 0);
-			migrate->dst[i] = migrate_pfn(migrate->dst[i]);
-			mpages++;
-		}
-		spage = migrate_pfn_to_page(migrate->src[i]);
-		if (spage && !is_zone_device_page(spage)) {
-			src[i] = dma_map_page(dev, spage, 0, PAGE_SIZE,
-					      DMA_BIDIRECTIONAL);
-			r = dma_mapping_error(dev, src[i]);
-			if (r) {
-				src[i] = 0;
-				dev_err(dev, "%s: fail %d dma_map_page\n",
-					__func__, r);
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
+
+			/*
+			 * HMM collects a compound entry only for a PMD fully
+			 * inside [start, end), so the folio cannot run past
+			 * npages. If it ever does, fail the whole window: the
+			 * error path releases every published VRAM page,
+			 * including the 4K pages still pending in j.
+			 */
+			if (WARN_ON_ONCE(i + SVM_HPAGE_PMD_NR > npages)) {
+				r = -EINVAL;
 				goto out_free_vram_pages;
 			}
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
 		} else {
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
+			dst[i] = cursor.start + (m << PAGE_SHIFT);
+			svm_migrate_get_vram_page(prange, cur_dst_pfn, 0);
+			migrate->dst[i] = migrate_pfn(cur_dst_pfn);
+			mpages++;
+		}
+
+		if (k > 1) {
 			if (j) {
+				/* migrate previous accumulated pages */
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
+			}
+		} else {
+			/* single normal page case */
+			spage = migrate_pfn_to_page(migrate->src[i]);
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
+				r = svm_migrate_copy_memory_gart(
+						adev, src + i - j,
+						dst + i - j, j,
+						FROM_RAM_TO_VRAM,
+						mfence);
+
+				if (r)
+					goto out_free_vram_pages;
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
 
@@ -426,12 +678,16 @@ svm_migrate_copy_to_vram(struct kfd_node *node, struct svm_range *prange,
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
 
@@ -504,6 +760,7 @@ svm_migrate_vma_to_vram(struct kfd_node *node, struct svm_range *prange,
 	struct kfd_process_device *pdd;
 	struct dma_fence *mfence = NULL;
 	struct migrate_vma migrate = { 0 };
+	bool is_private_device = false;
 	unsigned long cpages = 0;
 	unsigned long mpages = 0;
 	dma_addr_t *scratch;
@@ -516,11 +773,18 @@ svm_migrate_vma_to_vram(struct kfd_node *node, struct svm_range *prange,
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
@@ -701,6 +965,57 @@ static void svm_migrate_folio_free(struct folio *folio)
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
@@ -714,6 +1029,7 @@ svm_migrate_copy_to_ram(struct amdgpu_device *adev, struct svm_range *prange,
 	u64 i = 0, j;
 	u64 addr;
 	int r = 0;
+	u64 l, k;
 
 	pr_debug("svms 0x%p [0x%lx 0x%lx]\n", prange->svms, prange->start,
 		 prange->last);
@@ -722,8 +1038,7 @@ svm_migrate_copy_to_ram(struct amdgpu_device *adev, struct svm_range *prange,
 
 	src = (u64 *)(scratch + npages);
 	dst = scratch;
-
-	for (i = 0, j = 0; i < npages; i++, addr += PAGE_SIZE) {
+	for (i = 0, j = 0, k = 1; i < npages; i += k, addr += k*PAGE_SIZE, k = 1) {
 		struct page *spage;
 
 		spage = migrate_pfn_to_page(migrate->src[i]);
@@ -739,6 +1054,7 @@ svm_migrate_copy_to_ram(struct amdgpu_device *adev, struct svm_range *prange,
 					goto out_oom;
 				j = 0;
 			}
+
 			continue;
 		}
 		src[i] = svm_migrate_addr(adev, spage);
@@ -752,7 +1068,58 @@ svm_migrate_copy_to_ram(struct amdgpu_device *adev, struct svm_range *prange,
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
@@ -760,7 +1127,7 @@ svm_migrate_copy_to_ram(struct amdgpu_device *adev, struct svm_range *prange,
 			goto out_oom;
 		}
 
-		dst[i] = dma_map_page(dev, dpage, 0, PAGE_SIZE, DMA_BIDIRECTIONAL);
+		dst[i] = dma_map_page(dev, dpage, 0, PAGE_SIZE*k, DMA_BIDIRECTIONAL);
 		r = dma_mapping_error(dev, dst[i]);
 		if (r) {
 			dev_err(adev->dev, "%s: fail %d dma_map_page\n", __func__, r);
@@ -768,13 +1135,40 @@ svm_migrate_copy_to_ram(struct amdgpu_device *adev, struct svm_range *prange,
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
@@ -839,6 +1233,7 @@ svm_migrate_vma_to_ram(struct kfd_node *node, struct svm_range *prange,
 	unsigned long cpages = 0;
 	unsigned long mpages = 0;
 	struct amdgpu_device *adev = node->adev;
+	bool is_private_device = false;
 	struct kfd_process_device *pdd;
 	struct dma_fence *mfence = NULL;
 	struct migrate_vma migrate = { 0 };
@@ -846,6 +1241,8 @@ svm_migrate_vma_to_ram(struct kfd_node *node, struct svm_range *prange,
 	void *buf;
 	int r = -ENOMEM;
 
+	is_private_device = svm_is_private_zone(adev);
+
 	memset(&migrate, 0, sizeof(migrate));
 	migrate.vma = vma;
 	migrate.start = start;
@@ -856,6 +1253,10 @@ svm_migrate_vma_to_ram(struct kfd_node *node, struct svm_range *prange,
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

