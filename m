Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2432C61DD3
	for <amd-gfx@archiver.kernel.org>; Tue,  1 Sep 2026 12:45:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2A69110ECBE;
	Tue,  1 Sep 2026 12:45:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="gVWkDfaK";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010035.outbound.protection.outlook.com [52.101.61.35])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1505210ECBE
 for <amd-gfx@lists.freedesktop.org>; Tue,  1 Sep 2026 12:45:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aw5oRdU9jCfVBJqhTBytxLPVTeYzIRCKujlaySBCvMozj3QBGeqUJICYHNwQoVyhJZVulm2KnlUxT/cpr8A7eUQtmtbfanJd2MCesqtyzfRE6PDT6y6wQdqRLEUX72ESG+BIAFGND7Lv/FHpvvqDTzvhGMM+UVlP4G0LQmpUWnF7qiFoLsdJcQ4BQXmW6buhgJWosPMF4rG++swXQDBnR1E5UH15lpwG4VVO7M55T9fcXCQ9eGWMtJOPjHY1fOZ5waj3mQJP3OKnDb3rjnEbHz7oDMlYY9il5zmCrBw7jcBc36f+XYrG1gOGed119y8bCowQFSDLZy2JbMVIfe3zmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wd/l18BVOb8xuB1D4Me1EkY3ByNTEXJAf16uoz+EBTA=;
 b=pmmSl0OsJ1ek2ov+tJGvPtnWh9Sli5EspM2agu23I92PxUNH6hspgOuAwRrTJdkJPidE3RrfE2M2XXiZPi7PgFnD+l5yRbPQYdgxSCnWYlQYXVmFM/xANYQqRfg7kTqP0AwyOMZnXt0rdXUCncXgQkZSqyu+NGJfH83v1wPwFNEnMmC2gGVVjzAAI2BzzzXZzq80Ba9WzgFgwRi54Q9PD5/Kf9qhM0Q5dm3HTJxiizwZ6Jo3jHcLfq55U29Q6Z6AOlv+XQFsfVfErOa3Gv04myNWcvYMUYYySetFEkUtLjw5YEqi2LuGq0oDnmFbawTpkN+TcKy4nFu2/MbmIVZb3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wd/l18BVOb8xuB1D4Me1EkY3ByNTEXJAf16uoz+EBTA=;
 b=gVWkDfaKjNJvYTseuHHcyxtJkuk4GH+2W43fNbQK3LM5ReQwvRzGXw8tL+/s/+n7nE/OJjE+Z9V2/QCz5ZE7XLcJvmtCfHYWFm9F3yucLYkdQV2DldnHf+TthRlp5QaI3/TzUamXokdhfpuQ0pq4AAx6qny+uZ/eeWNsU/rQzYw=
Received: from BYAPR21CA0013.namprd21.prod.outlook.com (2603:10b6:a03:114::23)
 by CY8PR12MB7489.namprd12.prod.outlook.com (2603:10b6:930:90::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.10; Tue, 1 Sep
 2026 12:45:30 +0000
Received: from SJ5PEPF000001F4.namprd05.prod.outlook.com
 (2603:10b6:a03:114:cafe::84) by BYAPR21CA0013.outlook.office365.com
 (2603:10b6:a03:114::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.10 via Frontend Transport; Tue, 1
 Sep 2026 12:45:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001F4.mail.protection.outlook.com (10.167.242.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Tue, 1 Sep 2026 12:45:29 +0000
Received: from alysaliu-dev.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Tue, 1 Sep
 2026 07:45:27 -0500
From: William Palacek <William.Palacek@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <felix.kuehling@amd.com>, <Harish.Kasiviswanathan@amd.com>,
 <kent.russell@amd.com>, William Palacek <William.Palacek@amd.com>
Subject: [PATCH] drm/amdkfd: skip migration when the fault window is already
 in VRAM
Date: Tue, 1 Sep 2026 08:45:16 -0400
Message-ID: <20260901124516.357959-1-William.Palacek@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F4:EE_|CY8PR12MB7489:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f48d092-bf1f-4d6d-2167-08df0826e7d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|1800799024|23010399003|82310400026|10067099003|56012099006|11063799006|5023799004|18002099003;
X-Microsoft-Antispam-Message-Info: bMiJxpIjBY7xGZzIftYKhUNcjTi8FmuFF05RWTdDB2f8Y6u6FX1i39PaCSntHbnGx9iD0MXLAlRhuE1bwWyZPhbtQdumofGOh5eRVITyIF6BooWxGcWxdSEe5ewPeyWxrnfDF7DOObG6IuD5RFbnacWwVwInkIMw0QtI64AMgzYBu0r22qJQ1i18EdmG/+5/OuljaVIh3o0L9ewop6HMesKl3+i62DhbMLe9RUhKqHRJANPRYHzzOH2X/YppzUL0+mihMavHvanRah5pK1u5c/Wx/XMrpmGp/6JTJRzEfgdZVdmtRxt714q0FiddSPZsgY4SkTYsN3mFBxiYSAMk+yYd8KUNhfxCZTd/Maq2iVjf0M/AZKGCrfLhqUJDdxJYOWO2WgQjcxu5OKeo0FamrR0IQwC28YRK3Z40x2ru8So8riw8X9yj9aYhXICCAVW0FMKkOUTpOkXRv68sG+dmlJRjDaBjTuTw+bXsFPfyIRk5/BemAC5YXPbWzIyPN9IgdNaqlImwXnwlrSB9o1YbARIbzAHZgb76+rcrG8uNcLEqWp9u1++NzdLTz7oYS1BuDhOzlBOtdEiFlFYOh5m6hW1WTjU+UsrA/xuEXZOSwVK07dKwDq2MauAD/J0BXMM09Vn8dfUiY6EnTusPQURnC0FgRWLr+yHv5PVqEWR4VXrRh99W1GOsg0GFyGJWjfMCN/kpZqpQeARNOtNIfzBV1g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(1800799024)(23010399003)(82310400026)(10067099003)(56012099006)(11063799006)(5023799004)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: o6AWlO/4OUAgdIys6Tz5zS+wX8xEpVl9WDalmCXIPEkoiM0XkrcMYVnL+SC+vRl7VUy4DShpeHxJflDqjP0+SInD68fvncuL2Y2h+Bf0JMXjELa4aTMise4tA/Vy/BUQmltQsit0uHHEON8RFHtW/AACx/yxfpnojq1qH0n7fh8uGR7BbJxseP8fBE3ghxbsc0G6IgBFxmfohJPzMs3kO7hYCdj98gq0RFQCr8VOLT5ERTiFazctdBTYbzt7BFLwuxioLfNPPamMMSlfIUhGqvsVutXMP7XT4rYfF0QKU4KHWgjdcuzGsINbuUJI0kRUfT3JgNt/ddwnlmgC/Kt+c3OWCSFTwWEiw/Hjzd35Oz3ljJMR3zvlT3l+5ofD96L3hf9ph2Q55lc/PqwFpAnGB7nAovfPuujYci9vGjDHxc3yndpqDoaGrbQqhaEYg8De
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2026 12:45:29.9967 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f48d092-bf1f-4d6d-2167-08df0826e7d6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001F4.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7489
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

With this applied the fault driven phase of that workload falls from 270
to 348 s down to 45 to 48 s, and page_in at the end of that phase is 46.2
to 48.0M pages against 44.1 to 45.7M unpatched, so the same or more data
is moved. Unmaps per productive migration fall from about 35 to about 2.
Retry fault counts do not fall in any arm, so this is not a refault loop;
what changes is how often a fault escalates into a migration.

The scan is bounded by the migration window, one granule on the fault
path and the whole range on the prefetch path. That is the same order as
the migrate_vma_setup() walk it avoids, and it returns at the first page
that is not resident, so the worst case is one extra pass over a range
that then migrates normally.

Signed-off-by: William Palacek <William.Palacek@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_migrate.c | 65 ++++++++++++++++++++++++
 1 file changed, 65 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
index c3411dacdf55..40fc21d18587 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
@@ -384,6 +384,52 @@ svm_migrate_copy_to_vram(struct kfd_node *node, struct svm_range *prange,
 	return r;
 }
 
+/* Is every page of [start, end) already resident in the VRAM of @node?
+ *
+ * prange->actual_loc is a per-range scalar and is not sufficient on its own.
+ * Since commit a546a2768440 ("drm/amdkfd: Use partial migrations/mapping for
+ * GPU/CPU page faults in SVM") migration is per window, so a range can report
+ * actual_loc == best_loc while parts of it have been evicted back to system
+ * memory. On a gfx942 oversubscription workload 3.3% of migration attempts
+ * were on windows in exactly that state and did have pages to move, so the
+ * per-page test below is needed rather than the scalar alone.
+ *
+ * SVM_RANGE_VRAM_DOMAIN records "some device VRAM", not which device, which
+ * is why the actual_loc comparison is kept as well.
+ *
+ * Called with prange->migrate_mutex held.
+ */
+static bool
+svm_range_window_resident(struct kfd_node *node, struct svm_range *prange,
+			  u64 start, u64 end)
+{
+	struct kfd_process *p = container_of(prange->svms, struct kfd_process, svms);
+	unsigned long i, offset, wpages;
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
+	offset = (start >> PAGE_SHIFT) - prange->start;
+	wpages = (end - start) >> PAGE_SHIFT;
+	if (offset + wpages > prange->npages)
+		return false;
+
+	for (i = offset; i < offset + wpages; i++)
+		if (!(addr[i] & SVM_RANGE_VRAM_DOMAIN))
+			return false;
+
+	return true;
+}
+
 static long
 svm_migrate_vma_to_vram(struct kfd_node *node, struct svm_range *prange,
 			struct vm_area_struct *vma, u64 start,
@@ -401,6 +447,25 @@ svm_migrate_vma_to_vram(struct kfd_node *node, struct svm_range *prange,
 	void *buf;
 	int r = -ENOMEM;
 
+	/* Every page of this window is already in this node's VRAM, so
+	 * migrate_vma_setup() below can collect nothing. It issues the
+	 * MMU-notifier invalidate before discovering that, and with retry
+	 * faults enabled that lands in svm_range_cpu_invalidate_pagetables(),
+	 * which special cases only MMU_NOTIFY_UNMAP, so MMU_NOTIFY_MIGRATE is
+	 * handled by its default arm, reaching svm_range_evict() and
+	 * svm_range_unmap_from_gpus(). The attempt therefore tears this
+	 * window's GPU mapping down and then finds nothing to move, so the
+	 * next fault on it is escalated back into migration instead of being
+	 * satisfied by mapping alone.
+	 *
+	 * On a gfx942 oversubscription workload such attempts were 96 to 97%
+	 * of all to-VRAM migrations, and the driver unmapped a window roughly
+	 * 35 times per migration that moved data, against about 2 with this
+	 * guard.
+	 */
+	if (svm_range_window_resident(node, prange, start, end))
+		return 0;
+
 	memset(&migrate, 0, sizeof(migrate));
 	migrate.vma = vma;
 	migrate.start = start;
-- 
2.34.1

