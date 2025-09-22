Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6753CCAC5A7
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Sep 2025 02:40:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F3A5910E38B;
	Mon, 22 Sep 2025 02:40:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="NRlwjK8s";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013015.outbound.protection.outlook.com
 [40.93.201.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4381D10E38B
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Sep 2025 02:40:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QhYWSScoozdzNuH+SOGnETWl1LH+jeyBV95kl0RKRepBdcMVaW3ialO/ydTTiyrYQ+owSs5TQ3w6rCbzN4463aXnVKs4B4+/6QaaUZUPlpdZLUTZOkFNihSbMOAOFhklkhHwJP0fmbDqeA1OYNMLW78dQxOSSBMzBjEYk1Oe5TpRnqNOPdASXEe6PnWA06bqzkbdVhvWUIYcWPX0AFePG8GyyFRBmLSMrurrto3n36FpJxX8vQVDZWLh3/DuqEDeLTv7IKHve4M/7hvnE8Kvmsp22VWDctkFHPqnKaT98pTENCC72kkgpmCK5xJBUSBeJUFCOglLoWMvqLl9ECDptg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1c2YaEpNd49rRdex/JF4D4RUIx3YHeDrfR3AX+RcrpA=;
 b=bOMWL86MYQA4wc5sYBorHhtrfzoryIcRipG0ZhH113LV6kaK6Zg8a8n7jTr4T6B816yfnsF9247KHGlwiIvUb3wj7f/+ix07OK43x4mnPd2Tf4PmMSrQCkGxhZICBhYMDK/mbxjDnEfYts71YFtbK7dzLEik2jcHFwPXvTnh5ZTmmpRqSj0SPtxHTYl7XiRxtZPs0l2tpbv7DAI2abrB5PY/1GhU0ydEZ63ED9at1+CH3ZTATvkDha0L+QCAqWAZFqBly+Mt/3yFVFQ0EY/JhwA32TjSLGHNjnhbDPgzv+ccrn7f342cDo3eWv4CCKoHpLEnQv2bXmqfchDnlQRVGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1c2YaEpNd49rRdex/JF4D4RUIx3YHeDrfR3AX+RcrpA=;
 b=NRlwjK8sVZ1F9lvBq43sgtXSQwhYueycJgaBko0JBlErKH+qBl7HtHbqsGkmXTv6JgDEoHaFiG008hMjRI8kYid998brZqH6MfA3N2k+S1NSRwQUK7qebs6cpETwq674N7FArZsjrLhLw5+BjSyDaZdqk+KbcNRxLndh9ClPVBA=
Received: from BYAPR01CA0058.prod.exchangelabs.com (2603:10b6:a03:94::35) by
 SN7PR12MB8001.namprd12.prod.outlook.com (2603:10b6:806:340::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.14; Mon, 22 Sep 2025 02:39:59 +0000
Received: from CO1PEPF000044F8.namprd21.prod.outlook.com
 (2603:10b6:a03:94:cafe::39) by BYAPR01CA0058.outlook.office365.com
 (2603:10b6:a03:94::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.19 via Frontend Transport; Mon,
 22 Sep 2025 02:40:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF000044F8.mail.protection.outlook.com (10.167.241.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9182.0 via Frontend Transport; Mon, 22 Sep 2025 02:39:58 +0000
Received: from amd-02.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Sun, 21 Sep
 2025 19:39:55 -0700
From: YiPeng Chai <YiPeng.Chai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <yipechai@amd.com>, <Hawking.Zhang@amd.com>, <Tao.Zhou1@amd.com>,
 <Stanley.Yang@amd.com>, YiPeng Chai <YiPeng.Chai@amd.com>, Tao Zhou
 <tao.zhou1@amd.com>
Subject: [PATCH V5 17/20] drm/amd/ras: Use ring buffer to record ras ecc data
Date: Mon, 22 Sep 2025 10:38:41 +0800
Message-ID: <20250922023844.3108065-17-YiPeng.Chai@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250922023844.3108065-1-YiPeng.Chai@amd.com>
References: <20250922023844.3108065-1-YiPeng.Chai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F8:EE_|SN7PR12MB8001:EE_
X-MS-Office365-Filtering-Correlation-Id: a286ef3e-6302-44df-ba73-08ddf9815287
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?oMCs0SzoyXzEIc9Gv08lCP2iPy37ulVjke4KzkkqNLSxdgzdkflZ7xfCITNK?=
 =?us-ascii?Q?A0B1w2mPhvIx+NKW47+t02NPPEq1es2I49HKFQlvGPMndoDTDcvR4HzkXcbl?=
 =?us-ascii?Q?AmYgG4lrrc4KCiS5cDY0aP3U43QwuMPNOqvUyOZvjfX3bqHQ28nuVGPOfVIS?=
 =?us-ascii?Q?4uVvxuVCgKhMW+MWBnZ9GxU1qXaaZ4Kz2aTE8iRNF45YkgJODCQI496mNq6V?=
 =?us-ascii?Q?RxFw2WaF2z3b7Mif5T1zKRuBTtDtwt2swTpPhXlOVUUwhkrpzZClhW5Bg/zq?=
 =?us-ascii?Q?giwtzsbokJ2UGlMrEV6NKl/ejUx3tMTVj7kFX6sr7iKpVUkMGbxm4A4vcwGx?=
 =?us-ascii?Q?ehA07hv5PUdk8h9ot0VNBohhASApdtgnZH83GElnGVdic3j9X4vo8zpIN9nB?=
 =?us-ascii?Q?eZlWv0fnJahywflR8jASok/V8sEqlJYZgrCTU2gbNkZhC9kXK/hnkpoWtSX6?=
 =?us-ascii?Q?DA2Mcm2JZHpwlfGug8lw2QptH0v2rc5z4RjqiAHsM4H17NVd+EuUFl3JOUwK?=
 =?us-ascii?Q?GyzsPkrW7dtLdzW9hPLoY2jDB4D/tyuqAHOM9TcgIdb8NrTaGqOn13/uykWK?=
 =?us-ascii?Q?/z9QbYB9ZhhZN81P0lXqceoOrvTj+lMLsZO1LVOXA4TMACsBhFb+g3WdOWZK?=
 =?us-ascii?Q?OQD3gCBh0xR8pWpYtDoBsg+sSN3bh3pbeurpscvibxIUy57tSMEITPmHrmsl?=
 =?us-ascii?Q?d6L9OEv8mq34JqjY5R+FrgcwCETyHXkdqS4sunTDkrG5wvdCQztvHafH9IEI?=
 =?us-ascii?Q?EEhUaHmEH7Wsz6jKxteEqOphY3jhGh1oQMSn4pkovNhsWVXPWNYevKJ+rAYB?=
 =?us-ascii?Q?MeYErp4H90HNe43MvEekfE8MMwz2RTdYR9S5vDdgFXVfG+Y01if0xXNobm4c?=
 =?us-ascii?Q?z2wAyc/M72DfmmS44dBQRtcbSCxJec+LaVPJqv1GPejh9HvPopB6zIiSDG9b?=
 =?us-ascii?Q?RA+ZfGYYvqBgwsjfbofyNiRE1hzlhfW8E6b8jopJkWNP6lPoOaRnRzzUAlrB?=
 =?us-ascii?Q?KugczURk/DewoF4d9zrMc0ytHmgg6qyV9RSN12tM+RSOdXIFwFzrwKKCt1yi?=
 =?us-ascii?Q?2StQlP0cEudpOJMKBHmaK95IJFxGdv+5TM+KHiEan2r/Bj5iIPWjvs4NTE+6?=
 =?us-ascii?Q?vNaei4hljjrD+rlphSIFXbvcTgsLpLLd+S+EVp/h5lVJ4LMDBT+RFeHex4P0?=
 =?us-ascii?Q?RZukH9kkla+KWkMjDCoTN3dR17EigkwKQJAu3KDXHuce0cCVsWnfLHFb1lIM?=
 =?us-ascii?Q?Rszo/rDeyoKo+hfJzACCWKeSjjqkG+sx+jvinPFd96hm18NtW6r4kAmcjNFR?=
 =?us-ascii?Q?/1Re2y8MSy4Z5FLxHHSY+bcFM8nSqcJ1J6qh4yw85hcBl2muT05xgvYUIl4m?=
 =?us-ascii?Q?LGJu4IatwdAuX8PpRKzZlCy8RpBSqBD54Si1FXWKRCtvpWstJ3afeXZ0fFos?=
 =?us-ascii?Q?52GAc+sfFfOaIjqGbq4O04HytnNKMXWKTquQbocb3KUeOULCNEqWQp9DOuRv?=
 =?us-ascii?Q?0NUU7Mq7TiJfeNs8UwoJc2vSVea2A/8DgyXL?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2025 02:39:58.5868 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a286ef3e-6302-44df-ba73-08ddf9815287
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F8.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8001
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

Use ring buffer to record ras ecc data.

V3:
  Change commit message and rename the file and
  function names.

Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
Reviewed-by: Tao Zhou <tao.zhou1@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 .../gpu/drm/amd/ras/rascore/ras_log_ring.c    | 310 ++++++++++++++++++
 .../gpu/drm/amd/ras/rascore/ras_log_ring.h    |  93 ++++++
 2 files changed, 403 insertions(+)
 create mode 100644 drivers/gpu/drm/amd/ras/rascore/ras_log_ring.c
 create mode 100644 drivers/gpu/drm/amd/ras/rascore/ras_log_ring.h

diff --git a/drivers/gpu/drm/amd/ras/rascore/ras_log_ring.c b/drivers/gpu/drm/amd/ras/rascore/ras_log_ring.c
new file mode 100644
index 000000000000..bca094058f91
--- /dev/null
+++ b/drivers/gpu/drm/amd/ras/rascore/ras_log_ring.c
@@ -0,0 +1,310 @@
+// SPDX-License-Identifier: MIT
+/*
+ * Copyright 2025 Advanced Micro Devices, Inc.
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a
+ * copy of this software and associated documentation files (the "Software"),
+ * to deal in the Software without restriction, including without limitation
+ * the rights to use, copy, modify, merge, publish, distribute, sublicense,
+ * and/or sell copies of the Software, and to permit persons to whom the
+ * Software is furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+ * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
+ * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
+ * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
+ * OTHER DEALINGS IN THE SOFTWARE.
+ *
+ */
+#include "ras.h"
+#include "ras_core_status.h"
+#include "ras_log_ring.h"
+
+#define RAS_LOG_MAX_QUERY_SIZE   0xC000
+#define RAS_LOG_MEM_TEMP_SIZE    0x200
+#define RAS_LOG_MEMPOOL_SIZE \
+	(RAS_LOG_MAX_QUERY_SIZE + RAS_LOG_MEM_TEMP_SIZE)
+
+#define BATCH_IDX_TO_TREE_IDX(batch_idx, sn) (((batch_idx) << 8) | (sn))
+
+static const uint64_t ras_rma_aca_reg[ACA_REG_MAX_COUNT] = {
+	[ACA_REG_IDX__CTL]    = 0x1,
+	[ACA_REG_IDX__STATUS] = 0xB000000000000137,
+	[ACA_REG_IDX__ADDR]   = 0x0,
+	[ACA_REG_IDX__MISC0]  = 0x0,
+	[ACA_REG_IDX__CONFG] = 0x1ff00000002,
+	[ACA_REG_IDX__IPID]   = 0x9600000000,
+	[ACA_REG_IDX__SYND]   = 0x0,
+};
+
+static uint64_t ras_log_ring_get_logged_ecc_count(struct ras_core_context *ras_core)
+{
+	struct ras_log_ring *log_ring = &ras_core->ras_log_ring;
+	uint64_t count = 0;
+
+	if (log_ring->logged_ecc_count < 0) {
+		RAS_DEV_WARN(ras_core->dev,
+			"Error: the logged ras count should not less than 0!\n");
+		count = 0;
+	} else {
+		count = log_ring->logged_ecc_count;
+	}
+
+	if (count > RAS_LOG_MEMPOOL_SIZE)
+		RAS_DEV_WARN(ras_core->dev,
+			"Error: the logged ras count is out of range!\n");
+
+	return count;
+}
+
+static int ras_log_ring_add_data(struct ras_core_context *ras_core,
+			struct ras_log_info *log, struct ras_log_batch_tag *batch_tag)
+{
+	struct ras_log_ring *log_ring = &ras_core->ras_log_ring;
+	unsigned long flags = 0;
+	int ret;
+
+	if (batch_tag && (batch_tag->sub_seqno >= MAX_RECORD_PER_BATCH)) {
+		RAS_DEV_ERR(ras_core->dev,
+			"Invalid batch sub seqno:%d, batch:0x%llx\n",
+			batch_tag->sub_seqno, batch_tag->batch_id);
+		return -EINVAL;
+	}
+
+	spin_lock_irqsave(&log_ring->spin_lock, flags);
+	if (batch_tag) {
+		log->seqno =
+			BATCH_IDX_TO_TREE_IDX(batch_tag->batch_id, batch_tag->sub_seqno);
+		batch_tag->sub_seqno++;
+	} else {
+		log->seqno = BATCH_IDX_TO_TREE_IDX(log_ring->mono_upward_batch_id, 0);
+		log_ring->mono_upward_batch_id++;
+	}
+	ret = radix_tree_insert(&log_ring->ras_log_root, log->seqno, log);
+	if (!ret)
+		log_ring->logged_ecc_count++;
+	spin_unlock_irqrestore(&log_ring->spin_lock, flags);
+
+	if (ret) {
+		RAS_DEV_ERR(ras_core->dev,
+			"Failed to add ras log! seqno:0x%llx, ret:%d\n",
+			log->seqno, ret);
+		mempool_free(log, log_ring->ras_log_mempool);
+	}
+
+	return ret;
+}
+
+static int ras_log_ring_delete_data(struct ras_core_context *ras_core, uint32_t count)
+{
+	struct ras_log_ring *log_ring = &ras_core->ras_log_ring;
+	unsigned long flags = 0;
+	uint32_t i = 0, j = 0;
+	uint64_t batch_id, idx;
+	void *data;
+	int ret = -ENODATA;
+
+	if (count > ras_log_ring_get_logged_ecc_count(ras_core))
+		return -EINVAL;
+
+	spin_lock_irqsave(&log_ring->spin_lock, flags);
+	batch_id = log_ring->last_del_batch_id;
+	while (batch_id < log_ring->mono_upward_batch_id) {
+		for (j = 0; j < MAX_RECORD_PER_BATCH; j++) {
+			idx = BATCH_IDX_TO_TREE_IDX(batch_id, j);
+			data = radix_tree_delete(&log_ring->ras_log_root, idx);
+			if (data) {
+				mempool_free(data, log_ring->ras_log_mempool);
+				log_ring->logged_ecc_count--;
+				i++;
+			}
+		}
+		batch_id = ++log_ring->last_del_batch_id;
+		if (i >= count) {
+			ret = 0;
+			break;
+		}
+	}
+	spin_unlock_irqrestore(&log_ring->spin_lock, flags);
+
+	return ret;
+}
+
+static void ras_log_ring_clear_log_tree(struct ras_core_context *ras_core)
+{
+	struct ras_log_ring *log_ring = &ras_core->ras_log_ring;
+	uint64_t batch_id, idx;
+	unsigned long flags = 0;
+	void *data;
+	int j;
+
+	if ((log_ring->mono_upward_batch_id <= log_ring->last_del_batch_id) &&
+		!log_ring->logged_ecc_count)
+		return;
+
+	spin_lock_irqsave(&log_ring->spin_lock, flags);
+	batch_id = log_ring->last_del_batch_id;
+	while (batch_id < log_ring->mono_upward_batch_id) {
+		for (j = 0; j < MAX_RECORD_PER_BATCH; j++) {
+			idx = BATCH_IDX_TO_TREE_IDX(batch_id, j);
+			data = radix_tree_delete(&log_ring->ras_log_root, idx);
+			if (data) {
+				mempool_free(data, log_ring->ras_log_mempool);
+				log_ring->logged_ecc_count--;
+			}
+		}
+		batch_id++;
+	}
+	spin_unlock_irqrestore(&log_ring->spin_lock, flags);
+
+}
+
+int ras_log_ring_sw_init(struct ras_core_context *ras_core)
+{
+	struct ras_log_ring *log_ring = &ras_core->ras_log_ring;
+
+	memset(log_ring, 0, sizeof(*log_ring));
+
+	log_ring->ras_log_mempool = mempool_create_kmalloc_pool(
+			RAS_LOG_MEMPOOL_SIZE, sizeof(struct ras_log_info));
+	if (!log_ring->ras_log_mempool)
+		return -ENOMEM;
+
+	INIT_RADIX_TREE(&log_ring->ras_log_root, GFP_KERNEL);
+
+	spin_lock_init(&log_ring->spin_lock);
+
+	return 0;
+}
+
+int ras_log_ring_sw_fini(struct ras_core_context *ras_core)
+{
+	struct ras_log_ring *log_ring = &ras_core->ras_log_ring;
+
+	ras_log_ring_clear_log_tree(ras_core);
+	log_ring->logged_ecc_count = 0;
+	log_ring->last_del_batch_id = 0;
+	log_ring->mono_upward_batch_id = 0;
+
+	mempool_destroy(log_ring->ras_log_mempool);
+
+	return 0;
+}
+
+struct ras_log_batch_tag *ras_log_ring_create_batch_tag(struct ras_core_context *ras_core)
+{
+	struct ras_log_ring *log_ring = &ras_core->ras_log_ring;
+	struct ras_log_batch_tag *batch_tag;
+	unsigned long flags;
+
+	batch_tag = kzalloc(sizeof(*batch_tag), GFP_KERNEL);
+	if (!batch_tag)
+		return NULL;
+
+	spin_lock_irqsave(&log_ring->spin_lock, flags);
+	batch_tag->batch_id = log_ring->mono_upward_batch_id;
+	log_ring->mono_upward_batch_id++;
+	spin_unlock_irqrestore(&log_ring->spin_lock, flags);
+
+	batch_tag->sub_seqno = 0;
+	batch_tag->timestamp = ras_core_get_utc_second_timestamp(ras_core);
+	return batch_tag;
+}
+
+void ras_log_ring_destroy_batch_tag(struct ras_core_context *ras_core,
+		struct ras_log_batch_tag *batch_tag)
+{
+	kfree(batch_tag);
+}
+
+void ras_log_ring_add_log_event(struct ras_core_context *ras_core,
+		enum ras_log_event event, void *data, struct ras_log_batch_tag *batch_tag)
+{
+	struct ras_log_ring *log_ring = &ras_core->ras_log_ring;
+	struct ras_log_info *log;
+	void *obj;
+
+	obj = mempool_alloc_preallocated(log_ring->ras_log_mempool);
+	if (!obj ||
+	   (ras_log_ring_get_logged_ecc_count(ras_core) >= RAS_LOG_MEMPOOL_SIZE)) {
+		ras_log_ring_delete_data(ras_core, RAS_LOG_MEM_TEMP_SIZE);
+		if (!obj)
+			obj = mempool_alloc_preallocated(log_ring->ras_log_mempool);
+	}
+
+	if (!obj) {
+		RAS_DEV_ERR(ras_core->dev, "ERROR: Failed to alloc ras log buffer!\n");
+		return;
+	}
+
+	log = (struct ras_log_info *)obj;
+
+	memset(log, 0, sizeof(*log));
+	log->timestamp =
+		batch_tag ? batch_tag->timestamp : ras_core_get_utc_second_timestamp(ras_core);
+	log->event = event;
+
+	if (data)
+		memcpy(&log->aca_reg, data, sizeof(log->aca_reg));
+
+	if (event == RAS_LOG_EVENT_RMA)
+		memcpy(&log->aca_reg, ras_rma_aca_reg, sizeof(log->aca_reg));
+
+	ras_log_ring_add_data(ras_core, log, batch_tag);
+}
+
+static struct ras_log_info *ras_log_ring_lookup_data(struct ras_core_context *ras_core,
+					uint64_t idx)
+{
+	struct ras_log_ring *log_ring = &ras_core->ras_log_ring;
+	unsigned long flags = 0;
+	void *data;
+
+	spin_lock_irqsave(&log_ring->spin_lock, flags);
+	data = radix_tree_lookup(&log_ring->ras_log_root, idx);
+	spin_unlock_irqrestore(&log_ring->spin_lock, flags);
+
+	return (struct ras_log_info *)data;
+}
+
+int ras_log_ring_get_batch_records(struct ras_core_context *ras_core, uint64_t batch_id,
+		struct ras_log_info **log_arr, uint32_t arr_num)
+{
+	struct ras_log_ring *log_ring = &ras_core->ras_log_ring;
+	uint32_t i, idx, count = 0;
+	void *data;
+
+	if ((batch_id >= log_ring->mono_upward_batch_id) ||
+		(batch_id < log_ring->last_del_batch_id))
+		return -EINVAL;
+
+	for (i = 0; i < MAX_RECORD_PER_BATCH; i++) {
+		idx = BATCH_IDX_TO_TREE_IDX(batch_id, i);
+		data = ras_log_ring_lookup_data(ras_core, idx);
+		if (data) {
+			log_arr[count++] = data;
+			if (count >= arr_num)
+				break;
+		}
+	}
+
+	return count;
+}
+
+int ras_log_ring_get_batch_overview(struct ras_core_context *ras_core,
+		struct ras_log_batch_overview *overview)
+{
+	struct ras_log_ring *log_ring = &ras_core->ras_log_ring;
+
+	overview->logged_batch_count =
+		log_ring->mono_upward_batch_id - log_ring->last_del_batch_id;
+	overview->last_batch_id = log_ring->mono_upward_batch_id;
+	overview->first_batch_id = log_ring->last_del_batch_id;
+
+	return 0;
+}
diff --git a/drivers/gpu/drm/amd/ras/rascore/ras_log_ring.h b/drivers/gpu/drm/amd/ras/rascore/ras_log_ring.h
new file mode 100644
index 000000000000..0ff6cc35678d
--- /dev/null
+++ b/drivers/gpu/drm/amd/ras/rascore/ras_log_ring.h
@@ -0,0 +1,93 @@
+/* SPDX-License-Identifier: MIT */
+/*
+ * Copyright 2025 Advanced Micro Devices, Inc.
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a
+ * copy of this software and associated documentation files (the "Software"),
+ * to deal in the Software without restriction, including without limitation
+ * the rights to use, copy, modify, merge, publish, distribute, sublicense,
+ * and/or sell copies of the Software, and to permit persons to whom the
+ * Software is furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+ * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
+ * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
+ * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
+ * OTHER DEALINGS IN THE SOFTWARE.
+ *
+ */
+#ifndef __RAS_LOG_RING_H__
+#define __RAS_LOG_RING_H__
+#include "ras_aca.h"
+
+#define MAX_RECORD_PER_BATCH 32
+
+#define RAS_LOG_SEQNO_TO_BATCH_IDX(seqno) ((seqno) >> 8)
+
+enum ras_log_event {
+	RAS_LOG_EVENT_NONE,
+	RAS_LOG_EVENT_UE,
+	RAS_LOG_EVENT_DE,
+	RAS_LOG_EVENT_CE,
+	RAS_LOG_EVENT_POISON_CREATION,
+	RAS_LOG_EVENT_POISON_CONSUMPTION,
+	RAS_LOG_EVENT_RMA,
+	RAS_LOG_EVENT_COUNT_MAX,
+};
+
+struct ras_aca_reg {
+	uint64_t regs[ACA_REG_MAX_COUNT];
+};
+
+struct ras_log_info {
+	uint64_t seqno;
+	uint64_t timestamp;
+	enum ras_log_event event;
+	union {
+		struct ras_aca_reg aca_reg;
+	};
+};
+
+struct ras_log_batch_tag {
+	uint64_t batch_id;
+	uint64_t timestamp;
+	uint32_t sub_seqno;
+};
+
+struct ras_log_ring {
+	void *ras_log_mempool;
+	struct radix_tree_root ras_log_root;
+	spinlock_t spin_lock;
+	uint64_t mono_upward_batch_id;
+	uint64_t last_del_batch_id;
+	int logged_ecc_count;
+};
+
+struct ras_log_batch_overview {
+	uint64_t first_batch_id;
+	uint64_t last_batch_id;
+	uint32_t logged_batch_count;
+};
+
+struct ras_core_context;
+
+int ras_log_ring_sw_init(struct ras_core_context *ras_core);
+int ras_log_ring_sw_fini(struct ras_core_context *ras_core);
+
+struct ras_log_batch_tag *ras_log_ring_create_batch_tag(struct ras_core_context *ras_core);
+void ras_log_ring_destroy_batch_tag(struct ras_core_context *ras_core,
+			struct ras_log_batch_tag *tag);
+void ras_log_ring_add_log_event(struct ras_core_context *ras_core,
+		enum ras_log_event event, void *data, struct ras_log_batch_tag *tag);
+
+int ras_log_ring_get_batch_records(struct ras_core_context *ras_core, uint64_t batch_idx,
+		struct ras_log_info **log_arr, uint32_t arr_num);
+
+int ras_log_ring_get_batch_overview(struct ras_core_context *ras_core,
+		struct ras_log_batch_overview *overview);
+#endif
-- 
2.34.1

