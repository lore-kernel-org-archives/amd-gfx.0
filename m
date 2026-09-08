Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2B38C79F82
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Sep 2026 11:40:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 624DD10EB5E;
	Tue,  8 Sep 2026 11:40:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="hPrfmkC+";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010034.outbound.protection.outlook.com [52.101.46.34])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3479010EB5E
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Sep 2026 11:40:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=siS4Mwj6S4lX0p4D22NV/tYrIA6TR4Oa8pi6kHqq+IIxlIGkWY9WZoGgbLVDtAoYCXvUKp+fZxjbpPlATpyS1MCXHhnDCbsRpqZut625zdXRDZMLo2A/vPNl9kgdbChtIKr7c/K9z6xefWplMoJc4FEAL6FPKpRgZbHsefYSi322cn42llS5jvtXtMXeJJm3Y0IkR/jX+k6llQmgPKhgT+eKUZZCFSivGD/X3hLZtEdu2vAyMuA8E4DUOs2DB5/SFrc1pcqdrakwhwaxQdugjA+7Cd+UIeQ8LAq4NiYv9fSpdHrzM+uwWQLnph3Wf9Tr5YkV9JvfJYl89VDk6J57NA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gEUlvJm0qHvnna5058OPqA5FajsStkdy1680rnumCAs=;
 b=NRDsEottCi0LItgXbyDfdBYaPmWfvPtfBf62AWOOoCdcndtNEDVpZCt6bJ5H09wIcpIedjO0n9Hy5NJfP1H3bXGrK+/1qbRFKDBlGV2T/xTnKXj2Y3n+3iCCbQIdiE4E4SLBXO4NqmIWpaLGNhL+09rYTEh0/4fJ0jWDWNo7+M9mxUk8fMr2q9/TV5c5Y91FaRngkUIqB3vbFMZe3hcJJYbY8BmCzHQVBdpjgA6x+co2nZcsA3hNiEvz/jAaw4e83xbJmt/gDZcc1oWAWnsExd+w9l0FderbvBaVCfRSlmn04DTcOlmnJ+SMU4j+5G5ThaUktVjduK7lzbvtNRgmYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gEUlvJm0qHvnna5058OPqA5FajsStkdy1680rnumCAs=;
 b=hPrfmkC+p6kxaX07KQyD3LbS6R071hQZXrjM+/bOhswwq4815TvA5GPTIrMEuOO1Ik9v5bMoCH0ry7KgSL8I1ScahdTZwSEEVU0LqJMcaSXgE7c++wgDg8lFOQmSXnn7lfdJIse4F8zSmZkoekj9SQvzGzGu4OhptroTas1EHzs=
Received: from BN0PR04CA0015.namprd04.prod.outlook.com (2603:10b6:408:ee::20)
 by LV3PR12MB9410.namprd12.prod.outlook.com (2603:10b6:408:212::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.14; Tue, 8 Sep
 2026 11:40:28 +0000
Received: from BN7PEPF000000A3.namprd04.prod.outlook.com
 (2603:10b6:408:ee:cafe::27) by BN0PR04CA0015.outlook.office365.com
 (2603:10b6:408:ee::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.6 via Frontend Transport; Tue, 8
 Sep 2026 11:40:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN7PEPF000000A3.mail.protection.outlook.com (10.167.248.155) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Tue, 8 Sep 2026 11:40:28 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Tue, 8 Sep
 2026 06:40:20 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Tue, 8 Sep
 2026 06:40:19 -0500
Received: from chenyu-station.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.46 via Frontend
 Transport; Tue, 8 Sep 2026 06:40:11 -0500
From: Chenyu Chen <chen-yu.chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Dominik Kaszewski <dominik.kaszewski@amd.com>,
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>, Chenyu Chen
 <chen-yu.chen@amd.com>
Subject: [PATCH 44/66] drm/amd/display: Add lock-free memory pool
Date: Tue, 8 Sep 2026 19:31:37 +0800
Message-ID: <20260908113338.2433445-45-chen-yu.chen@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260908113338.2433445-1-chen-yu.chen@amd.com>
References: <20260908113338.2433445-1-chen-yu.chen@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN7PEPF000000A3:EE_|LV3PR12MB9410:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a75405e-acfa-4d94-ef81-08df0d9dfb2c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700016|376014|23010399003|6133799003|10067099003|5023799004|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: G4WB4GoQD14tPkaeSUEv/H/Cwn+NN1PbjDzhHb+DobUNWpaEoxPU5YCw2WC3PDCH7J05q8f5ebS2131yfMTbjB0oVPehcKob41JNqrqeauDakEBJu20kFccygnwT8fBjfKrvKYnmmjaSfCHYsdGN5IWV1mzAk+wpxHJ+RbHQ8NUeKobc2NoPb7yk/5jYIcXHrZweJhcEAXWq7K1CuE9t1L0NVQfmM5+kJr3ps64ybJoiXR/S6n4VZpPmbXOhMETOg6CTTlhPvFjIvNWevtKBbp+pFY4KpfFFK+O05Hsqt3OyhoK6Xi51T+wULr+iXBVXtnLWm67hU9gTyfFbJ69NQIHGKZIs2Epj4sDltZwpoM6LbVkUyZ2AtEeFDMX+LqBmq1aXcIa5/86XV+6brjN4eZhQ6liO4G8W3LGF8/J6+7QZ3dCsrf2r/+0j3+bfzmorz5JDDGUVAaNX8S7fWPckXNCSzzLXOteuL/b3LNVEJhxS3Qe9JX/+mSNdTfv6Z4fkA0hjIAXQQO4jp+tqaEUaArVoYiCFWTRipcX4aFnaGea76dLvqQHYkXJBiOoOXWZlYAPNBl5cc/XWN6fxgZoDXCTeTsS0kngfnr4ahKWxpGbk5h9CCFlI4MjXkwGt5jGLrAgoEehNAvFjX2CwzSBXTalpYCNDUn5MfjfYxC5ZgT5ZdQixj2OA4u+SaUYSIJvCRK5eSU3/rOBv++JJQedHHA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700016)(376014)(23010399003)(6133799003)(10067099003)(5023799004)(11063799006)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: tq33vElfQ8QS3OvN1f510xhgR6kWrQmZnWz0F+y6wzm1RSzTh0HXVPDc2tYqxcFiAaPwEoSlZtjAGUh3e/yQ45ruz/kepRR1UgyGHFQoNKc6iQI6aMOOV9Q/YxSxM88x0Qli48w/DTuhtyu33zrjZSk/MXh2jfaZ30zGAQyTmoX8Sooghhy6h84xo5Snd6+lOt/Q59sUTMGrsMTWqM3j33vyToTqzG2zYtx0LlV3EmugLcIQvYjwPyVqcJgqNIpMUlUIg/vlLUzfo/3fXZHbViUNhL8YLW9N/Lg9LtsLT71RQl8ALKCtuwYIPHKnQj7hwicKRAIvVEwfs3VUbi2mSU+PliYD6GJergNx/2/CIqhkf/s2LYqM/kGhsvE/MXxcPxHVb3pxpBJg3v0qGNh7on5HqMaHVtlkCQ4xbhVpAt0UOwryW20K2nrIqoC2DpCx
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2026 11:40:28.4542 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a75405e-acfa-4d94-ef81-08df0d9dfb2c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN7PEPF000000A3.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9410
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

From: Dominik Kaszewski <dominik.kaszewski@amd.com>

[Why]
Two memory limitations - limited stack size and heap allocations
not allowed in interrupts - combined together lead to scratch
structures and buffers scattered throughout the code, requiring
piping them through interfaces.

[How]
* OS-provided lock-free lists still need external locking for some
operations, requiring a custom implementation.
* Implement memory pool which can preallocate a number of blocks
with given size, then later "allocate" from them without any heap use.
* Pool implemented as lock-free Treiber stack to avoid operations
being blocked by suspended thread, including a same-thread interrupt
exemption causing an indefinite block.
* Indexed free list and generation counter protect against ABA
data corruption.

Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Signed-off-by: Dominik Kaszewski <dominik.kaszewski@amd.com>
Signed-off-by: Chenyu Chen <chen-yu.chen@amd.com>
---
 drivers/gpu/drm/amd/display/dc/Makefile       |   1 +
 .../gpu/drm/amd/display/dc/dc_memory_pool.c   | 277 ++++++++++++++++++
 .../gpu/drm/amd/display/dc/dc_memory_pool.h   | 107 +++++++
 drivers/gpu/drm/amd/display/dc/os_types.h     |   1 +
 4 files changed, 386 insertions(+)
 create mode 100644 drivers/gpu/drm/amd/display/dc/dc_memory_pool.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/dc_memory_pool.h

diff --git a/drivers/gpu/drm/amd/display/dc/Makefile b/drivers/gpu/drm/amd/display/dc/Makefile
index 27d60493254f..99aa8f75de7b 100644
--- a/drivers/gpu/drm/amd/display/dc/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/Makefile
@@ -67,6 +67,7 @@ FILES += dc_dmub_srv.o
 FILES += dc_edid_parser.o
 FILES += dc_fused_io.o
 FILES += dc_helper.o
+FILES += dc_memory_pool.o
 FILES += core/dc.o
 FILES += core/dc_debug.o
 FILES += core/dc_hw_sequencer.o
diff --git a/drivers/gpu/drm/amd/display/dc/dc_memory_pool.c b/drivers/gpu/drm/amd/display/dc/dc_memory_pool.c
new file mode 100644
index 000000000000..904f8c4a4783
--- /dev/null
+++ b/drivers/gpu/drm/amd/display/dc/dc_memory_pool.c
@@ -0,0 +1,277 @@
+/**
+ * Copyright (C) Advanced Micro Devices, Inc. All rights reserved.
+ *
+ * You may not use this software and documentation (if any) (collectively, the
+ * "Materials") except in compliance with the terms and conditions of the
+ * Software License Agreement included with the Materials or otherwise as set
+ * forth in writing and signed by you and an authorized signatory of AMD.
+ *
+ * If you do not have a copy of the Software License Agreement, contact your AMD
+ * representative for a copy. You agree that you will not reverse engineer or
+ * decompile the Materials, in whole or in part, except as allowed by applicable
+ * law.
+ *
+ * THE MATERIALS ARE DISTRIBUTED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OR
+ * REPRESENTATIONS OF ANY KIND, EITHER EXPRESS OR IMPLIED.
+ */
+#include "dc_memory_pool.h"
+
+#include <linux/atomic.h>
+
+enum {
+	DC_MEMORY_POOL_SENTINEL = -1,
+	DC_MEMORY_POOL_ACQUIRED = -2,
+	DC_MEMORY_POOL_RELEASED = -3,
+
+	// Correct autoincrement for negative numbers
+	DC_MEMORY_POOL_ENUM_SIZE_IMPL,
+	DC_MEMORY_POOL_ENUM_SIZE = 1 - DC_MEMORY_POOL_ENUM_SIZE_IMPL,
+};
+
+// Align everything to size of page to avoid false sharing
+struct dc_memory_pool_page {
+	__aligned(PAGE_SIZE) char _dummy[PAGE_SIZE];
+};
+
+// Generation counter protects against ABA-problem
+union index_t {
+	struct {
+		int32_t value;
+		uint32_t generation;
+	} s;
+
+	int64_t raw;
+};
+
+struct dc_memory_pool {
+	// Values and pointers constant after initialization, can share page
+	__aligned(PAGE_SIZE) size_t size;
+	size_t capacity;
+
+	void *unaligned_pool;
+	void *unaligned_memory;
+	struct dc_memory_pool_page *memory;
+	atomic_t *free_list;
+
+	// Updated every operation, use separate page to avoid false sharing
+	__aligned(PAGE_SIZE) atomic64_t free_head; // index_t
+	char _reserved2[PAGE_SIZE - sizeof(atomic64_t)];
+};
+
+static_assert(sizeof(struct dc_memory_pool) == 2 * PAGE_SIZE);
+static_assert(offsetof(struct dc_memory_pool, free_head) == PAGE_SIZE);
+
+static size_t divide_ceiling(size_t x, size_t d)
+{
+	return (x + d - 1) / d;
+}
+
+static size_t round_up_to_multiple(size_t x, size_t m)
+{
+	return divide_ceiling(x, m) * m;
+}
+
+static size_t size_in_pages(size_t x)
+{
+	return divide_ceiling(x, PAGE_SIZE);
+}
+
+static void *page_align_up(void *p)
+{
+	intptr_t i = (intptr_t)p;
+
+	i = (intptr_t)round_up_to_multiple((size_t)i, PAGE_SIZE);
+	return (void *)i;
+}
+
+__must_check struct dc_memory_pool *dc_memory_pool_create(size_t size,
+							  size_t capacity)
+{
+	if (!size || !capacity)
+		return NULL;
+
+	// Limited by split between size and generation in index_t
+	if (capacity >= (uint32_t)-DC_MEMORY_POOL_ENUM_SIZE)
+		return NULL;
+
+	// uint32_t because that's what alloc functions take
+	const uint32_t block_pages = (uint32_t)size_in_pages(size);
+	const uint32_t lines = (uint32_t)capacity * block_pages;
+	const uint32_t padded_struct_size =
+		sizeof(struct dc_memory_pool) + PAGE_SIZE;
+
+	void *unaligned_pool = kzalloc(padded_struct_size, GFP_KERNEL);
+
+	if (!unaligned_pool)
+		return NULL;
+
+	struct dc_memory_pool *pool = page_align_up(unaligned_pool);
+
+	*pool = (struct dc_memory_pool){
+		.size = size,
+		.capacity = capacity,
+		.unaligned_pool = unaligned_pool,
+		.unaligned_memory = kcalloc(lines + 1, PAGE_SIZE, GFP_KERNEL),
+		.free_list = kcalloc((uint32_t)capacity, sizeof(atomic_t),
+				     GFP_KERNEL),
+		.free_head = ATOMIC_INIT(0),
+	};
+	pool->memory = page_align_up(pool->unaligned_memory);
+
+	if (!pool->unaligned_memory || !pool->free_list) {
+		dc_memory_pool_destroy(pool);
+		return NULL;
+	}
+
+	for (int32_t i = 0; i < (int32_t)capacity; i++)
+		atomic_set_release(&pool->free_list[i], i + 1);
+
+	atomic_set_release(&pool->free_list[capacity - 1],
+			   DC_MEMORY_POOL_SENTINEL);
+
+	return pool;
+}
+
+void dc_memory_pool_destroy(struct dc_memory_pool *pool)
+{
+	if (!pool)
+		return;
+
+	kfree(pool->free_list);
+	kfree(pool->unaligned_memory);
+	kfree(pool->unaligned_pool);
+}
+
+static int32_t dc_memory_pool_get_index(const struct dc_memory_pool *pool,
+					const void *memory)
+{
+	if (!pool || !memory) {
+		ASSERT(false);
+		return DC_MEMORY_POOL_SENTINEL;
+	}
+
+	// Direct pointer arithmetic would be UB if called by false `owns()`
+	if ((uintptr_t)memory < (uintptr_t)pool->memory)
+		return DC_MEMORY_POOL_SENTINEL;
+
+	const uintptr_t distance = (uintptr_t)memory - (uintptr_t)pool->memory;
+	const size_t block_size = size_in_pages(pool->size) * PAGE_SIZE;
+	const size_t i = (size_t)distance / block_size;
+
+	if (distance % (uintptr_t)block_size != 0)
+		return DC_MEMORY_POOL_SENTINEL;
+
+	if (i >= pool->capacity)
+		return DC_MEMORY_POOL_SENTINEL;
+
+	return (int32_t)i;
+}
+
+static void *dc_memory_pool_get_page(const struct dc_memory_pool *pool,
+				     int32_t index)
+{
+	if (!pool) {
+		ASSERT(false);
+		return NULL;
+	}
+
+	if (index < 0 || index >= (int32_t)pool->capacity) {
+		ASSERT(false);
+		return NULL;
+	}
+
+	return &pool->memory[(size_t)index * size_in_pages(pool->size)];
+}
+
+__must_check void *dc_memory_pool_acquire(struct dc_memory_pool *pool)
+{
+	if (!pool) {
+		ASSERT(false);
+		return NULL;
+	}
+
+	// CAS-atomic `out = head; head = head->next;`
+	union index_t old_head = {
+		.raw = atomic64_read_acquire(&pool->free_head),
+	};
+	union index_t new_head = {
+		.raw = 0,
+	};
+	int32_t i = 0;
+
+	do {
+		i = old_head.s.value;
+		if (i == DC_MEMORY_POOL_SENTINEL)
+			return NULL;
+
+		new_head = (union index_t){
+			.s.value = atomic_read_acquire(&pool->free_list[i]),
+			.s.generation = old_head.s.generation + 1,
+		};
+	} while (!atomic64_try_cmpxchg(&pool->free_head, &old_head.raw,
+				       new_head.raw));
+
+	atomic_set_release(&pool->free_list[i], DC_MEMORY_POOL_ACQUIRED);
+	return dc_memory_pool_get_page(pool, i);
+}
+
+void dc_memory_pool_release(struct dc_memory_pool *pool, void *memory)
+{
+	if (!dc_memory_pool_owns(pool, memory)) {
+		// Likely acquired in different pool or (racing?) double free
+		ASSERT(false);
+		return;
+	}
+
+	const int32_t i = dc_memory_pool_get_index(pool, memory);
+
+	if (atomic_xchg(&pool->free_list[i], DC_MEMORY_POOL_RELEASED) !=
+	    DC_MEMORY_POOL_ACQUIRED) {
+		// Double free from two racing threads, use krefs to sync
+		ASSERT(false);
+		return;
+	}
+
+	// CAS-atomic `in->next = head; head = in;`
+	union index_t old_head = {
+		.raw = atomic64_read_acquire(&pool->free_head),
+	};
+	union index_t new_head = {
+		.raw = 0,
+	};
+
+	do {
+		atomic_set_release(&pool->free_list[i], old_head.s.value);
+		new_head = (union index_t){
+			.s.value = i,
+			.s.generation = old_head.s.generation + 1,
+		};
+	} while (!atomic64_try_cmpxchg(&pool->free_head, &old_head.raw,
+				       new_head.raw));
+}
+
+__must_check bool dc_memory_pool_owns(const struct dc_memory_pool *pool,
+				      const void *memory)
+{
+	const int32_t i = dc_memory_pool_get_index(pool, memory);
+
+	if (i < 0)
+		return false;
+
+	if (atomic_read_acquire(&pool->free_list[i]) != DC_MEMORY_POOL_ACQUIRED)
+		return false;
+
+	return true;
+}
+
+__must_check size_t dc_memory_pool_size(const struct dc_memory_pool *pool)
+{
+	ASSERT(pool);
+	return pool->size;
+}
+
+__must_check size_t dc_memory_pool_capacity(const struct dc_memory_pool *pool)
+{
+	ASSERT(pool);
+	return pool->capacity;
+}
diff --git a/drivers/gpu/drm/amd/display/dc/dc_memory_pool.h b/drivers/gpu/drm/amd/display/dc/dc_memory_pool.h
new file mode 100644
index 000000000000..0ec305813d66
--- /dev/null
+++ b/drivers/gpu/drm/amd/display/dc/dc_memory_pool.h
@@ -0,0 +1,107 @@
+/**
+ * Copyright (C) Advanced Micro Devices, Inc. All rights reserved.
+ *
+ * You may not use this software and documentation (if any) (collectively, the
+ * "Materials") except in compliance with the terms and conditions of the
+ * Software License Agreement included with the Materials or otherwise as set
+ * forth in writing and signed by you and an authorized signatory of AMD.
+ *
+ * If you do not have a copy of the Software License Agreement, contact your AMD
+ * representative for a copy. You agree that you will not reverse engineer or
+ * decompile the Materials, in whole or in part, except as allowed by applicable
+ * law.
+ *
+ * THE MATERIALS ARE DISTRIBUTED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OR
+ * REPRESENTATIONS OF ANY KIND, EITHER EXPRESS OR IMPLIED.
+ */
+#ifndef DC_MEMORY_POOL_H
+#define DC_MEMORY_POOL_H
+
+#include "os_types.h"
+
+/**
+ * Non-resizable lock-free memory pool with fixed capacity.
+ *
+ * Custom implementation is used over Linux llist, as llist requires external
+ * locking if more than one thread pops from the list.
+ *
+ * Emplace and erase operations do not use any mutexes or spinlocks, which
+ * guarantees forward progress even if another thread
+ * has been suspended in the middle of the call. High contention might result
+ * in multiple internal retries, but will eventually either succeed once other
+ * threads stop actively modifying the pool, or fail if the pool is empty.
+ *
+ * Implemented as Treiber stack using indexed free list and head with generation
+ * counter to solve ABA problem, as each modification of the head increments
+ * the generation, preventing issue of `push(A)` being indistinguishable from
+ * `push(A); { push(B); pop(B); }` to another thread, corrupting data structure.
+ */
+struct dc_memory_pool;
+
+/**
+ * Create dc_memory_pool.
+ *
+ * @param size Non-zero pool block size, all acquires will be of this size.
+ * @param capacity Non-zero number of blocks that can be acquired from the pool.
+ * @return Pointer to the pool if succeeded, null if failed.
+ */
+__must_check struct dc_memory_pool *dc_memory_pool_create(size_t size,
+							  size_t capacity);
+
+/**
+ * Destroy given pool and free all allocated memory, invalidating any pointers.
+ *
+ * This operation is not synchronized, calling any other operation on the pool
+ * while it is being destroyed results in Undefined Behavior.
+ *
+ * @param pool Can be null to support common destruction patterns.
+ */
+void dc_memory_pool_destroy(struct dc_memory_pool *pool);
+
+/**
+ * Acquire single block from pool.
+ *
+ * @param pool Cannot be null.
+ * @return Pointer to block if succeeded, null if empty.
+ */
+__must_check void *dc_memory_pool_acquire(struct dc_memory_pool *pool);
+
+/**
+ * Release previously acquired block, freeing it for others to acquire.
+ *
+ * @param pool Cannot be null.
+ * @param memory Cannot be null, has to be owned by the pool.
+ */
+void dc_memory_pool_release(struct dc_memory_pool *pool, void *memory);
+
+/**
+ * Check if given memory is owned by the pool to facilitate arenas.
+ *
+ * @warning if (owns(pool, p)) release(pool, p);` pattern is not safe
+ * if used with same `p` from multiple unsynchronized threads.
+ * If multiple owning threads are desired, use krefs to assure single release.
+ *
+ * @param pool Cannot be null.
+ * @param memory Cannot be null.
+ * @return True if the memory was previously acquired from the pool.
+ */
+__must_check bool dc_memory_pool_owns(const struct dc_memory_pool *pool,
+				      const void *memory);
+
+/**
+ * Get pool block size.
+ *
+ * @param pool Cannot be null.
+ * @return Pool block size as given to dc_memory_pool_create().
+ */
+__must_check size_t dc_memory_pool_size(const struct dc_memory_pool *pool);
+
+/**
+ * Get pool block count.
+ *
+ * @param pool Cannot be null.
+ * @return Pool block count as given to dc_memory_pool_create().
+ */
+__must_check size_t dc_memory_pool_capacity(const struct dc_memory_pool *pool);
+
+#endif // Header guard
diff --git a/drivers/gpu/drm/amd/display/dc/os_types.h b/drivers/gpu/drm/amd/display/dc/os_types.h
index 339372293a98..27d4a96b958f 100644
--- a/drivers/gpu/drm/amd/display/dc/os_types.h
+++ b/drivers/gpu/drm/amd/display/dc/os_types.h
@@ -27,6 +27,7 @@
 #ifndef _OS_TYPES_H_
 #define _OS_TYPES_H_
 
+#include <linux/compiler_attributes.h>
 #include <linux/slab.h>
 #include <linux/kgdb.h>
 #include <linux/delay.h>
-- 
2.43.0

