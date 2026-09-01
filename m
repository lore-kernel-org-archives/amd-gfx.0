Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 805EDC61DD3
	for <amd-gfx@archiver.kernel.org>; Tue,  1 Sep 2026 16:54:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 02BDA10E426;
	Tue,  1 Sep 2026 16:54:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="UCvcqgNe";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010061.outbound.protection.outlook.com [52.101.85.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 602BA10E426
 for <amd-gfx@lists.freedesktop.org>; Tue,  1 Sep 2026 16:54:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VQzRwwoQQV4+QdUFWTE8/X02+iCh8vnFZy2Nqx05VQh4ETuRNcbn1ENaaEvXdFs7wLTncM7O4Z8BnfynwNWVm/DzzhNTMlstE97qL7BOlUgUn6v9Y+oF3oQDdLfDq6hrdkJAcCI2B609zgfBXeNiilKa74/QdWT016Kx2dxObklNpTVwPWCsuups4PF5C+AnPdU1usPcOx3IDLJQSy999CuMVOzkU3pkDmc5DNPuXAFV/3MST/D4ybRJDXVlja3Nrj1BQyZ6U4r/RDdrFgYOp4dDHs6ExosXb0bdSbT1qqkrdRcjdl+H85t/7jcfWjTHBbEeo4x/cely9BDVNR4A8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DYvn0XoXLmMoftNegl/7KwUnSEWRqZAEyWcUPcoBHv0=;
 b=kJaymCik0WW0dKgNoCWTK37LfZ2b+JZ+tzotnjwS+OaJhE+DBEfuRgYVRNg+M9Ujz4Ga1lo1NxIJAJwa26CYLZPj/ZlAJlcYvygJQIsWx21KkitgIup2z3B54iEP38EffjS480JpQPdjOZCFX25tSeC45meW3EuCB+9/qBeECUYmMyMyYiqO3uZNa5GWCPchrpn3Nz2p+FgcnkZFLmzjwRXFgA1Ox/JRu+B+dnvwxO/VN5c1oEV052N4TwKcpNFy5SXKuv2GZjRWfBbKSy+cXZ8PvZXwTA1sZsRdS2/tRlUoOsaf/huGxgIbSal8ALAMOIyx7IbiVeZF5PdrkMpNCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DYvn0XoXLmMoftNegl/7KwUnSEWRqZAEyWcUPcoBHv0=;
 b=UCvcqgNeNTdtnYKtiGOh8pKPDVP2MM9U9XY7otxhp6+wB3AJuOadqEVKNYAxx15VkokRrq6mf7fP7vySib4vi9hJRK/f3itGBRIm94v/XC5ElYiWR2WlIEOYuyYDfQROtTL9aOqYVfICDAQ9CQy0nIW1oqi9SAVL1SJP/UZsIlw=
Received: from DS7PR03CA0120.namprd03.prod.outlook.com (2603:10b6:5:3b7::35)
 by BN7PPF62A0C9A68.namprd12.prod.outlook.com (2603:10b6:40f:fc02::6d2) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Tue, 1 Sep
 2026 16:54:19 +0000
Received: from SN1PEPF0002BA51.namprd03.prod.outlook.com
 (2603:10b6:5:3b7:cafe::75) by DS7PR03CA0120.outlook.office365.com
 (2603:10b6:5:3b7::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.13 via Frontend Transport; Tue, 1
 Sep 2026 16:54:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF0002BA51.mail.protection.outlook.com (10.167.242.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Tue, 1 Sep 2026 16:54:17 +0000
Received: from alysaliu-dev.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Tue, 1 Sep
 2026 11:54:15 -0500
From: William Palacek <William.Palacek@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <felix.kuehling@amd.com>, <Harish.Kasiviswanathan@amd.com>,
 <kent.russell@amd.com>, <William.Palacek@amd.com>
Subject: [PATCH v2] drm/amdkfd: skip migration when the fault window is
 already in VRAM
Date: Tue, 1 Sep 2026 12:54:00 -0400
Message-ID: <20260901165400.16262-1-William.Palacek@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA51:EE_|BN7PPF62A0C9A68:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d0c1e0f-a018-4ff5-d1d0-08df0849a95e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|23010399003|36860700016|1800799024|6133799003|18002099003|56012099006|11063799006|5023799004|10067099003;
X-Microsoft-Antispam-Message-Info: OYmpN6VgYOeskcg2hd8noAgwqv6IL22vIX0sXymzd5QHFL+bgAdCsMLkRNdTPo2Ssvh499ZpBngLn765DKXE+n+Ton60jE4dJQ9zHQcDtIH+lqixsldRD+dU9O3iqDTASjRVTHURL40N54yZ1CW9oMzkj0Map6GYVI2YSQeZmfqK/2PzwBagTuVDEPGQAnCONrh0rSlPCX1yL62QLCS7dwvT9cY3AO/GqQPNMJO1q9XKZp7p32TTryZnj94xzdvUd4qyezjirt7iajnXT1fNjcmXfyNZnoal4pp5qm6QKLPM70WVdvLuq4n4ypG8FUl6cbEh3gJQYNd7NeBsZbDt1QlJJt0/1mnzWd9yOTGLCj4Xu0fxl2sD7mRm9YVuOWw1AMmHkjG7fjZ9QehhK+RrMqghkusjpJNQhD9hFJbMGBSWFns2g4k8KYgUpBvgZME6SAyK75FbEOm9khXD5EqDzPZPa41m6LG4/nsct4HZMRPwD9sqU2/Ktamr+luF4MRN+lhWZSocBy6s8FgSoVtl8QfkKQJ391CyBeJArBmLvHMV46Li1J4QzB/u7qWY+WhMWAEPrHv9YvfUh5B1djL+12uVjgGXm5Q330P7BA5k2SIRiuRxIQpy/czGuzdp5WN1PHYbonoCu4FcL1+U/NUS7JEjB1udDCmw9432t/7lsJdlE9810wfR6IyjBZ7yArC9I0GIHyqoe8GfL1rpQu2s7g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(23010399003)(36860700016)(1800799024)(6133799003)(18002099003)(56012099006)(11063799006)(5023799004)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 5u2/xjGyKdMNMSiySdw5qx0SvUh7dVsNSiKyfXGsGchEllYgG1eL+WzuiPK+MwAh7Xz55W5xj3bz22EGEczw3Gs5esd6YIc4oepPTAr+vhLSAb9bqDJYHJxVoH1l7EO4a5y1KGWK6VTYPYip+TPIVqI8ow4p4y2ah0dm1GT3A+Wg1tG1g4qx7nk8aQ91yRqLuCTaDU3F2wq87+aDZvyqeB08dANVpF6AFbOc7R41Cl4ghCnd8Rmi95gS13pPfIq/hOGrxGXhOY2yCF3YIelGEK5agnVUCm6D+kXkmquw/TH3jR/doeD3vyQjnR3YFhP0sD//h25ZjZArIQWvGaE2pVsw4sws/lWWNdaD2VljndpEBpVq+Z0ZnrhrJ1EBq5imeSsDwl7B6FDtrdEK39RZ13D4/E9MUXL6ObpGbNzguTt0pjwQREu1aQTzPFEH1TME
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2026 16:54:17.6780 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d0c1e0f-a018-4ff5-d1d0-08df0849a95e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002BA51.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPF62A0C9A68
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

svm_migrate_vma_to_vram() is called for windows that are already fully
resident in the target GPU's VRAM. migrate_vma_setup() raises an MMU
notifier invalidate before it can discover there is nothing to collect,
and with retry faults enabled svm_range_cpu_invalidate_pagetables()
special cases only MMU_NOTIFY_UNMAP, so MMU_NOTIFY_MIGRATE is handled by
its default arm, reaching svm_range_evict() and then
svm_range_unmap_from_gpus().

The attempt therefore drops the window's GPU mapping and then returns
having migrated nothing, so the next fault on that window is escalated
into another migration instead of being satisfied by mapping alone.

Measured on MI300X (gfx942, SPX/NPS1, xnack+) under an HMM
oversubscription workload, 96 to 97% of to-VRAM migration attempts
collected zero pages, and the driver unmapped a window roughly 35 times
for every migration that moved data.

Test whether every page of the faulting window is already resident in
this node's VRAM and return early if it is. prange->actual_loc alone is
not sufficient: since commit a546a2768440 ("drm/amdkfd: Use partial
migrations/mapping for GPU/CPU page faults in SVM") migration is per
window, so a range can report actual_loc == best_loc while part of it has
been evicted back to system memory. 3.3% of attempts were in exactly that
state and did have pages to move, so the per-page test is required rather
than the scalar alone. Instrumented over 100000 attempts on an earlier
run against a different driver build, the per-page test never skipped one
that had pages to move.

The actual_loc comparison is kept alongside the per-page test because
SVM_RANGE_VRAM_DOMAIN records only that a page is in some device's VRAM,
not which device's.

With this applied the fault driven phase of that workload falls from 270
to 348 s down to 45 to 48 s, across 9 patched and 7 unpatched runs with
no overlap at either oversubscription factor tested. page_in at the end
of that phase does not fall with it: 44.5 to 48.3M pages patched against
44.1 to 49.7M unpatched at factor 1.10, and 46.2 to 48.0M against 44.1 to
45.7M at factor 1.02. Those ranges overlap at 1.10, so the claim is that
no data is stranded, not that more moves. Unmaps per productive migration
fall from about 35 to about 2. Retry fault counts do not fall in any arm,
so this is not a refault loop; what changes is how often a fault
escalates into a migration.

The scan is bounded by the migration window, one granule on the fault
path and the whole range on the prefetch path. That is the same order as
the migrate_vma_setup() walk it avoids, and it returns at the first page
that is not resident, so the worst case is one extra pass over a range
that then migrates normally.

Signed-off-by: William Palacek <William.Palacek@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_migrate.c | 46 ++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
index c3411dacdf55..e91d0115cbba 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
@@ -384,6 +384,46 @@ svm_migrate_copy_to_vram(struct kfd_node *node, struct svm_range *prange,
 	return r;
 }
 
+/* Check if a range of addresses is already resident in VRAM to avoid
+ * unnecessary migrations that would trigger MMU notifiers causing the range
+ * to be unmapped and faulted again unnecessarily.
+ *
+ * Called with prange->migrate_mutex held.
+ */
+static bool
+svm_range_window_resident(struct kfd_node *node, struct svm_range *prange,
+			  u64 start, u64 end)
+{
+	struct kfd_process *p = container_of(prange->svms, struct kfd_process, svms);
+	unsigned long i, offset, npages;
+	dma_addr_t *addr;
+	uint32_t gpuid;
+	int32_t gpuidx;
+
+	if (kfd_process_gpuid_from_node(p, node, &gpuid, &gpuidx))
+		return false;
+	if (prange->actual_loc != gpuid)
+		return false;
+
+	addr = prange->dma_addr[gpuidx];
+	if (!addr)
+		return false;
+
+	start = max(start >> PAGE_SHIFT, prange->start);
+	end = min(end >> PAGE_SHIFT, prange->last + 1);
+	if (end <= start)
+		return false;
+
+	offset = start - prange->start;
+	npages = end - start;
+
+	for (i = offset; i < offset + npages; i++)
+		if (!(addr[i] & SVM_RANGE_VRAM_DOMAIN))
+			return false;
+
+	return true;
+}
+
 static long
 svm_migrate_vma_to_vram(struct kfd_node *node, struct svm_range *prange,
 			struct vm_area_struct *vma, u64 start,
@@ -401,6 +441,12 @@ svm_migrate_vma_to_vram(struct kfd_node *node, struct svm_range *prange,
 	void *buf;
 	int r = -ENOMEM;
 
+	/* Avoid unnecessary migrations and MMU notifiers if all the data is
+	 * already resident in VRAM.
+	 */
+	if (svm_range_window_resident(node, prange, start, end))
+		return 0;
+
 	memset(&migrate, 0, sizeof(migrate));
 	migrate.vma = vma;
 	migrate.start = start;
-- 
2.34.1

