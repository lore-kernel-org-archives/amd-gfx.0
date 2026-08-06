Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7F09C55ABF
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Aug 2026 14:32:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4307810F1E6;
	Thu,  6 Aug 2026 14:32:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="BJIkpgef";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011000.outbound.protection.outlook.com [52.101.52.0])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AD41410E33E
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Aug 2026 14:32:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EIpb/8sxqPp1zbfm0FKpi2MY4z7QMtR4hYAH95poIJSa0+moZNXV/jCHvL56EUuc/amtelY3KU9lhCam5XJ09oIg1QEHqZr+AAscQooRhV2fnF4DtyTqB/6sl/2+U1Nj3G4xekSQJYOsvDZYBtM+jx3BE4RAp2EYSCErKbhRd7vVNEWoLo5rumcnvjYke+Za0co/T3cgFT5lZs4k1vFt56S7V/sM3KXwMnr5lHs/bUsXgsCURWuuiG/BQdrLsNwBiUbNJqNe4n9kdJ4DCRX1ez2zH2qGkmLDu6B19Ui+yG0J4X48KCkvRKmCWPtYjPyiQzzKEFQGcvX7rqxyfB687Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gq06CNs/dlhsDqTwKjbJY8bc+0BesKeFzJCiHeH/1p8=;
 b=jSAlmGFhIY/doegTsAzIn+PEpBBpoJcJnqzJBhfoUgyfBCFAX1txvlyaqG6WZkgt/CZo1GqYl7SSj/hkGFkpaFOalV3jq5+MfurvPfGk1ByxwJ5n97JuwQpLEl4SxsLrhttuBUvsxlcN9BSpEYPx3Jx6IKVr81s/e7ZqI17toirotYMwxXVoxRFjfUzkGAQc60cu9irUQv6FRIyH57+EYESKLYjyC1aeq5gCPriMygXAvhFaODuvMI3PLGVYhEeODXwChVmsCKhp2s2xKXoO8IZC15VAl8XXiLOjfvPmURLXoCPnCzYjiDetN20Dl7rFN8YkrueU6z4qr9qjm14BKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gq06CNs/dlhsDqTwKjbJY8bc+0BesKeFzJCiHeH/1p8=;
 b=BJIkpgefjZy/4SEJ4QxIGRSWkHju1SYEvkYaL2L/TAQ8CNmlXajRtmiVbicP/rn+PcE8fxqi5sGp1Gb7t61TW0MBsClr19/Wt8SW30uDhzkDXEC+1k/6SJrR5P5ueGdIznsV/5B1ybdJJ9dkwtL9J1/qgWCV/t4lkl9kSxnc8Uo=
Received: from SA9PR03CA0006.namprd03.prod.outlook.com (2603:10b6:806:20::11)
 by CH2PR12MB4213.namprd12.prod.outlook.com (2603:10b6:610:a4::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.19; Thu, 6 Aug
 2026 14:32:16 +0000
Received: from SN1PEPF00036F40.namprd05.prod.outlook.com
 (2603:10b6:806:20:cafe::2e) by SA9PR03CA0006.outlook.office365.com
 (2603:10b6:806:20::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.292.21 via Frontend Transport; Thu, 6
 Aug 2026 14:32:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF00036F40.mail.protection.outlook.com (10.167.248.24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.315.6 via Frontend Transport; Thu, 6 Aug 2026 14:32:15 +0000
Received: from alysaliu-dev.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 6 Aug
 2026 09:32:15 -0500
From: William Palacek <William.Palacek@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Felix.Kuehling@amd.com>, <Philip.Yang@amd.com>,
 <harish.kasiviswanathan@amd.com>, <William.Palacek@amd.com>,
 <Alysa.Liu@amd.com>
Subject: [PATCH] drm/amdkfd: don't repeat a SVM migration that collected no
 pages
Date: Thu, 6 Aug 2026 10:31:54 -0400
Message-ID: <20260806143154.3020903-1-William.Palacek@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00036F40:EE_|CH2PR12MB4213:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b623659-0680-40c0-42fe-08def3c78338
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|23010399003|376014|36860700016|11063799006|6133799003|18002099003|5023799004|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info: uZNXuef0vXzMO4XgFnPxfzfH57WAhRHqVISNAM+tF1k3qAvCtp8bALvuks2LfpsTvQIRg1j0cQHWUaiyAP6FqPF5LF51usgrGCI9obBpcE0/JthrysWMp5bRO4lfUPaspSfkAeoma2tudmIEu003rPC/eOboNF+Kfg3JxAPa9GWwRW01cDBTSvs2DviWHwBBynfYwxubfMnVp/KFLWuoSjGhDk6HSDLb1oN07M9gBEZtDxr9yF0REtU/3qkzhrmDUzwHjaGWCuyLGcITZra/uYmzDoU8o2Rd/QMfM+XaNC/oh/K3NwGWt62Ess94JlSh23J0PS1FCrVouMB2v4xuCSxmucJ3PM7KKN7ZX2gaeTxwkPT54PJxrCrJ0ugq3OlYZjH0hSgHyI+9GC7/hSUibmb4jvDlN5iJtcUSIQ6QZXadnS+9xrk9n0Sww6pr/00Lf6WQDiQRh1sy1oQRNbkM6fz+n7OUuJbj91M3RE1xQbjqLkJEGfTqNGbkv2FQfu12blN+caDZ5ulrKo2l9c7ZDCuQn+vVMGkl+vW30iFZpRSj6yt9DH4P73qSHD+KWXyORDE2tPoY3yahKlwix+Dc5iEFfq1iSQCOeH1E/nlK7Xu5e/Jv4Bp6P0NikOlMHFyQMSd6qFGr0eHKa4hAVZogH6sTmrzC/QeZA0SCwYQTNGj0AsJrF9WnDuU55nwMACs/tErd/6woAcMoRxnUhD1gCw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(23010399003)(376014)(36860700016)(11063799006)(6133799003)(18002099003)(5023799004)(56012099006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: NMnL0ow6sXxRpTxppkCNcZEMD7w6CHglkAkOUuZxzKvN1e9rRGZCZedKfLsgXfk4AdrX/qjdqA8fjfS8DG8SMmuks9ArxOyD4ZwUige1YNBPF9Q9GwvvWAqt6f+eREWiKmfzi7kVmskyKm8nK8p3TBDiYeiiTTvmk+pQs/yyDxK+o7v5zEmPFEAqSigvJ/9FjcD1nZwmgaFm7A7XrqjItlBHCeKY4xkEk+YL1ASUvFMO38zplmIx9Xv0SMlUBDVoQV6+lXmGAE4dhncn7BhAxiaQQvtWAfOhGviXVZthSYnkbDkojAwJzzsMKZOiSfeQXmUCAfhwyDR0UY0sLtaj6ddwRGZDFQmg2lrM8JtyPGu1SBwDJKpDpt9gmBo2Omhvxyvn4lnmYoHfgoCS7eNzZws1Ro7Wvat5Sbtb5yUwgrCVrYDvW44R6lVZlYdkrKr9
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2026 14:32:15.8099 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b623659-0680-40c0-42fe-08def3c78338
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF00036F40.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4213
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

When it does, MIGRATE_VMA_SELECT_SYSTEM has nothing to collect and
migrate_vma_setup() returns cpages == 0. By then it has already issued
MMU_NOTIFY_MIGRATE, which svm_range_cpu_invalidate_pagetables() turns
into svm_range_unmap_from_gpus() for that window, so the mapping the
fault needed is torn down to service a migration that moves nothing and
the fault is re-armed rather than resolved. Under XNACK on an
oversubscribed range this becomes a loop: svm_range_restore_pages() and
svm_migrate_to_vram() are entered thousands of times per second,
svm_migrate_copy_to_vram() is never reached, and the per process
migration counters stop advancing while the GPU stays busy.

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
index fa4054d51f60..b946ae95ff12 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -50,6 +50,11 @@
  * page table is updated.
  */
 #define AMDGPU_SVM_RANGE_RETRY_FAULT_PENDING	(2UL * NSEC_PER_MSEC)
+
+/* Long enough that a retry fault storm cannot re-arm a migration which
+ * has already been found to have nothing to collect.
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
+			 * collects nothing re-arms this fault instead of
+			 * resolving it.
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

