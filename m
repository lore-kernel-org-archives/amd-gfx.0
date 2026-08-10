Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87028C5AD55
	for <amd-gfx@archiver.kernel.org>; Mon, 10 Aug 2026 14:04:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F1D8F10E896;
	Mon, 10 Aug 2026 14:04:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ezY+IPjk";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013013.outbound.protection.outlook.com
 [40.93.196.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 879E010E896
 for <amd-gfx@lists.freedesktop.org>; Mon, 10 Aug 2026 14:04:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ix9OokvKKiZS6c95YNU+7YXX95HFEL3yuN1OjPsUIn1m9kZv6QjM8Nb5cbE8Zf+qbBk49HhUbtoHY8ekOdtCrhPlCbZB3+mhF6afu6oq7H3ztjTpNzdib7pErb+hyg+To8J8ZdLWyzZa6UuqTfJ9Hyt7zn9ZnU1YcSkvBcfxTiCVGx6yutDqwDAVDwGBA5lztq/KjvhglUoyj1NG45T67gN5uIVTqkgAe25AX0hVEis9EJw3VjqCYhSD1OZHGCw4RbQKN/6avp0Hz6Ysj50G0ydVXElaMWqEpSUVD6M5dfoXSaQgRQJdJTqzxfXxHrNNUkRKyh8mN3KKCf9tAy23dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=18+P3FtIAsoTTEybyEeFf5Ja1+AJAm5EBSjVTZ2X6yw=;
 b=uFEsu9PycL749WtZrX150sn0bIrxCid6mpORu3oJsXxrAA32SXPmnk+F7UboRVklUhqpbcP4ZPmxW7TMd7HUjvYGCXybEWXx5VUXi5LCKt5MT4XRQQUWsj/sNP6GBg/pekwNUA3vC6bNTt8VE0UdX09wWGCbd1/Tm5CRzx2uiwK+TazCX21nWaIKa/viGqPmJzqFJdBXI83nTdj96hqgjan67bCuT+KGKSxm98dIZkkSTd3aJ29oqnfk7R0snCLhlZLByyV66mrQaPskHDUgnGocdkb1ackTqh8zAfhCo9rD3tDQRx9+FOIvJniUnZXPjdHUXnmnP8DBh/mNVbDjiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=18+P3FtIAsoTTEybyEeFf5Ja1+AJAm5EBSjVTZ2X6yw=;
 b=ezY+IPjk2xjZzvaKNcU5xmODa1kvY+g9vWtQHcLoPEIMriVm97KQCog6VtNN2j8a/7PpRgGUHhTKXj8KtVn/81EF7ZBNJvwiYLUtNs/dUBI+ZXaIPG2SKAOhGIoY/zt3UZgosKKO10rPsmWm3OhDfOwxnLpt4z0zJulFfG0QOew=
Received: from DS3P220CA0010.NAMP220.PROD.OUTLOOK.COM (2603:10b6:8:45f::15) by
 IA5PR12MB999276.namprd12.prod.outlook.com (2603:10b6:208:60b::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Mon, 10 Aug
 2026 14:04:38 +0000
Received: from DS1PEPF00017096.namprd05.prod.outlook.com
 (2603:10b6:8:45f:cafe::50) by DS3P220CA0010.outlook.office365.com
 (2603:10b6:8:45f::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.292.25 via Frontend Transport; Mon,
 10 Aug 2026 14:04:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS1PEPF00017096.mail.protection.outlook.com (10.167.18.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.315.6 via Frontend Transport; Mon, 10 Aug 2026 14:04:37 +0000
Received: from alysaliu-dev.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Mon, 10 Aug
 2026 09:04:37 -0500
From: William Palacek <William.Palacek@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Felix.Kuehling@amd.com>, <Philip.Yang@amd.com>,
 <Harish.Kasiviswanathan@amd.com>, <William.Palacek@amd.com>,
 <Alysa.Liu@amd.com>
Subject: [PATCH v2] drm/amdkfd: don't repeat a SVM migration that collected no
 pages
Date: Mon, 10 Aug 2026 10:04:17 -0400
Message-ID: <20260810140417.3452164-1-William.Palacek@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017096:EE_|IA5PR12MB999276:EE_
X-MS-Office365-Filtering-Correlation-Id: b93c05d2-d535-4099-362f-08def6e85096
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|1800799024|82310400026|36860700016|6133799003|11063799006|5023799004|56012099006|10067099003|18002099003;
X-Microsoft-Antispam-Message-Info: jpKNuLl8uAWRgWIWq9AqoJeLhC1yCM9zvPIJRQUu8Y6lPozcM+HRnFsXO9QkKZBgs/RHzA5V8DWzOrA0X/ok8QbMd9FtW+59kwiHkfe7bbkefRH+MTO6cdVwxLNN7LWoaRu3xC9Ve/bJf1Hw82IMPbO3H4v+52oYgk7daCzsksKqH3/7g4KYKnk+gm3G8CShUkq0H2gjUzYYqRKtuqIIa84puXhEwu++nusFc2PCqZYZ8501sDPVEZrz2OYht6X9Mg/AYNi+zZ9FmhcFAbnHd0xhIjT0/FabPMIsL6NxphutIt1Tb0Rl0R7Cw4wKQDZadf4TrXym0VuJOivlCGeUDHhVoteos5u47WswoMQHRvYfZOPmtd8dgvjWYiNpGVcwRMjs9/DyeO8XEwLmUb3bkscS4vFv0lLtvIz/vXgwot00pbflKfESyWhpbOMYucdR8W8kMKhRV8hP49xPbNgYKmYS5e726lwPAGGh+oP8n0mqS8Y0gSqy82L7cn/O6hWoRZMUb/oMAeRg2UKP+2FcngxbMPtv1z5ReAZX9DDcQet9C6NZ1M0u8wiHFXtkjZhK7/LQ39TrzXdxjR+cun/MSEV2q516YFzfnn1xt60DvqqgRJmrTqtz7FCyUM+UldN/9fcOQQptxsEALlxaXBTcrudOagxYPMCvNhP3xnshQDHYtpqv/ew5kcV/2QfMKoxisQzwBNDDu52xAf3pkQJ1nw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(1800799024)(82310400026)(36860700016)(6133799003)(11063799006)(5023799004)(56012099006)(10067099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Hc0RoCjGBBDiTpfyGB8BT/hCRLo4TDq/4UeUathRJVuQcwdT1Q3Rj/k4GBaV8V3+Xcy/Ft47BeKgUSEMli/e70EKOSQIpHCILwoBNl9aDvtgfuu14GdmG7QQeo2u93rsyavcOcqk+zWQww4KtBifFJE1DFXNrTarDw2mdngucnZi5NXc+e1aCas8EfkF5WhkUI9xCr3pQrR7RMthQtj6Zp0Temo6jFvq7EwPnplHn2p9yhHadrZGarVJMwUcC4mClBufsSNxU+C6CnNCjZpaAanjzhNkajLukB1HXqvNtF0vnyUg4zmQsDVZaXfO3rtw6pdMlg64afAjS33QDJWKumk/5pKudHR7aiQppXfs2lQVVw65JZsuNGygQK8U0mIdBz/tTFg0iXxSFv29EzlrjVYZFFCPaKNV5DAptd3uYsEP7uKdjq2pqDZFU7l0ynwF
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2026 14:04:37.7708 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b93c05d2-d535-4099-362f-08def6e85096
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017096.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA5PR12MB999276
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

svm_range_restore_pages() migrates the faulting granule to best_loc
whenever prange->actual_loc or best_loc is set, without checking whether
that window already lives there.

When it does, migrate_vma_collect() issues MMU_NOTIFY_MIGRATE before it
knows what it can collect, and svm_range_cpu_invalidate_pagetables()
turns that into svm_range_unmap_from_gpus() for the window.
MIGRATE_VMA_SELECT_SYSTEM then finds nothing to collect,
migrate_vma_setup() returns cpages == 0, and svm_range_validate_and_map()
rebuilds the mapping that was just torn down. The fault is serviced, but
the pass destroys and re-creates an unchanged mapping and moves no data.
Under XNACK this dominates: in one capture only 2009 of 98728 migrations
entered from the fault path reached svm_migrate_copy_to_vram(), while the
per process migration counters stopped advancing and the GPU stayed busy.

The notification cannot be filtered by pgmap owner, as it is what
invalidates the PTEs for pages that really do move. Avoid starting a
migration that cannot move anything instead. Per window residency is not
cheaply available beforehand, so record the window of a migration that
collected nothing and do not repeat it there until a short backoff
expires.

Fixes: a546a2768440 ("drm/amdkfd: Use partial migrations/mapping for GPU/CPU page faults in SVM")
Signed-off-by: William Palacek <William.Palacek@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 23 +++++++++++++++++++++++
 drivers/gpu/drm/amd/amdkfd/kfd_svm.h |  4 ++++
 2 files changed, 27 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index fa4054d51f60..888e8934212b 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -50,6 +50,11 @@
  * page table is updated.
  */
 #define AMDGPU_SVM_RANGE_RETRY_FAULT_PENDING	(2UL * NSEC_PER_MSEC)
+
+/* Long enough that a burst of retry faults cannot repeat a migration
+ * which has already been found to have nothing to collect.
+ */
+#define AMDGPU_SVM_RANGE_NOOP_MIGRATE_BACKOFF	(100UL * NSEC_PER_MSEC)
 #if IS_ENABLED(CONFIG_DYNAMIC_DEBUG)
 #define dynamic_svm_range_dump(svms) \
 	_dynamic_func_call_no_desc("svm_range_dump", svm_range_debug_dump, svms)
@@ -3221,8 +3226,25 @@ svm_range_restore_pages(struct amdgpu_device *adev, unsigned int pasid,
 	last = min_t(unsigned long, ALIGN(addr + 1, size) - 1, prange->last);
 	if (prange->actual_loc != 0 || best_loc != 0) {
 		if (best_loc) {
+			uint64_t vram_pages = prange->vram_pages;
+
+			/* migrate_vma_setup() unmaps the window before it knows
+			 * whether it can collect anything, so a migration that
+			 * collects nothing still tears down and rebuilds an
+			 * unchanged mapping.
+			 */
+			if (start == prange->noop_migrate_start &&
+			    ktime_before(timestamp,
+					 ktime_add_ns(prange->noop_migrate_timestamp,
+						      AMDGPU_SVM_RANGE_NOOP_MIGRATE_BACKOFF)))
+				goto skip_migrate;
+
 			r = svm_migrate_to_vram(prange, best_loc, start, last,
 					mm, KFD_MIGRATE_TRIGGER_PAGEFAULT_GPU);
+			if (!r && prange->vram_pages == vram_pages) {
+				prange->noop_migrate_start = start;
+				prange->noop_migrate_timestamp = ktime_get_boottime();
+			}
 			if (r) {
 				pr_debug("svm_migrate_to_vram failed (%d) at %llx, falling back to system memory\n",
 					 r, addr);
@@ -3248,6 +3270,7 @@ svm_range_restore_pages(struct amdgpu_device *adev, unsigned int pasid,
 		}
 	}
 
+skip_migrate:
 	r = svm_range_validate_and_map(mm, start, last, prange, gpuidx, false,
 				       false, false);
 	if (r)
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
index c7d7adae4476..508a086195ac 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
@@ -93,6 +93,8 @@ struct svm_work_list_item {
  * @granularity:migration granularity, log2 num pages
  * @invalid:    not 0 means cpu page table is invalidated
  * @validate_timestamp: system timestamp when range is validated
+ * @noop_migrate_start: start of the last migration that collected no pages
+ * @noop_migrate_timestamp: system timestamp of that migration
  * @notifier:   register mmu interval notifier
  * @work_item:  deferred work item information
  * @deferred_list: list header used to add range to deferred list
@@ -131,6 +133,8 @@ struct svm_range {
 	uint8_t				granularity;
 	atomic_t			invalid;
 	ktime_t				validate_timestamp;
+	unsigned long			noop_migrate_start;
+	ktime_t				noop_migrate_timestamp;
 	struct mmu_interval_notifier	notifier;
 	struct svm_work_list_item	work_item;
 	struct list_head		deferred_list;
-- 
2.34.1

