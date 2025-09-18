Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C5D2CAC59F
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Sep 2025 01:33:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DB6FF10E5F8;
	Thu, 18 Sep 2025 01:33:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="pq4iElkK";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011003.outbound.protection.outlook.com
 [40.93.194.3])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 81B9A10E5F8
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Sep 2025 01:33:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hUBqPbFHaHXiGoy8RMbomUewvuERn8MD8X2mNBwppf7kQMP8vW/Ikbi1YFQPo8GZyfi/JNYj9eqPnAD8Fkllo7bE5NeyX7e21hQdLO7wxGWv4i14isvarYqwl+ZmQe063dVSaIqWhAjv36nGoaSuVBwN89fklkozjDweQbdOnbSSESe4fsJcFq64adZvyHRHbM9VH/bTeRbRlGYX1msQW6tXskQSXbV8GMIu48R7xrb3Kfhsi4lMubeMSw4ajUGPGxEYFtRmXgOsrdBUWQkJVUJol5mcT3sYhD0Nmz/VaM15H8XJHQMEi1sjiyNe9D1vhhsHxIR/RQyPWrwxv5mgdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Sn+coW4wsX5tlqp1ucJnNyeqS85AtoUMS03Ts+bd85U=;
 b=lF/CCb4p5oRxyH1iPqPTKNdlOJb3RPKSeFVDGW8O4vLcGi7838dhzPGdJKjXmaga/SAr8ktEyaL/qK021VtKARU0j697/uWBIceEfbC4zQXYjEUbSy/tF9dlG3U+J8WCxjm+IoPc45rNFLPAE460pNVI1/dKEsEwivH8zjcXgdZZCRG35a4RBrXEN+asJzweSNPi8Pf06/FWSfKy8MR76d1vApoC8KvO0QZrG4JSdgA6bF59a3+0IZuPOdDvDwcmX7Zt/o8OW/TULaSw5rAJvocWfldhlZ7QFoO7VLqZItcQJfM/8a7HdUXwdKSlsbUr5LOisjQjpjaYiKWvNqUnAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Sn+coW4wsX5tlqp1ucJnNyeqS85AtoUMS03Ts+bd85U=;
 b=pq4iElkK5y5RqZWraX1p+SfRFmfPAbsB9YyqG7+Rz0iY9rhqkWHnxanfvNvOY4Bcz/7HNI9N/Tmgtulbh0CWXaaYKLFPZyDy3vxe15ZTxEl2DhJvwmVdNwuXfKMEQxBs3QYNuKaLf7M6Lp9kToAf5MKZWduJO5O0r2u65ZcZhMY=
Received: from SJ0PR13CA0238.namprd13.prod.outlook.com (2603:10b6:a03:2c1::33)
 by DM6PR12MB4451.namprd12.prod.outlook.com (2603:10b6:5:2ab::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.13; Thu, 18 Sep
 2025 01:33:44 +0000
Received: from CO1PEPF000044F2.namprd05.prod.outlook.com
 (2603:10b6:a03:2c1:cafe::4e) by SJ0PR13CA0238.outlook.office365.com
 (2603:10b6:a03:2c1::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.13 via Frontend Transport; Thu,
 18 Sep 2025 01:33:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF000044F2.mail.protection.outlook.com (10.167.241.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Thu, 18 Sep 2025 01:33:43 +0000
Received: from amd-02.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 17 Sep
 2025 18:33:41 -0700
From: YiPeng Chai <YiPeng.Chai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Tao.Zhou1@amd.com>, <Candice.Li@amd.com>,
 <Stanley.Yang@amd.com>, YiPeng Chai <YiPeng.Chai@amd.com>, Tao Zhou
 <tao.zhou1@amd.com>
Subject: [PATCH 18/21] drm/amd/ras: Use ring buffer to record ras ecc data
Date: Thu, 18 Sep 2025 09:32:29 +0800
Message-ID: <20250918013232.2629215-18-YiPeng.Chai@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250918013232.2629215-1-YiPeng.Chai@amd.com>
References: <20250918013232.2629215-1-YiPeng.Chai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F2:EE_|DM6PR12MB4451:EE_
X-MS-Office365-Filtering-Correlation-Id: fd5780c8-ae27-4bce-4ecc-08ddf65367d1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?rKo9NSrOk7x+5H3gHFipBWPqueU7LnV0DzIU/zFC5rfCZlLm+t9pDyvZCMtr?=
 =?us-ascii?Q?IUi6zohUXkNjjneFyzt1FlRwHb0GR2dTWiJj3eP7wq9BhVH8jVFxyTz2eju9?=
 =?us-ascii?Q?kWEchVK7avNA440S86CL35rV6z/6GMprU7KNWAuf4/tcncXLfA/nLrbh0IVj?=
 =?us-ascii?Q?XefVfdazsvBSOsoZU82wBfdE8JiIaSHPSKCm/dk2eOKb987fVKEJkTCOIyzm?=
 =?us-ascii?Q?bCT8xAgvQDeY70HytrMCTkDLSoKbLtfrlck/elBnl/wLEsczsADdQC8hfaTi?=
 =?us-ascii?Q?UmyTGpoQIKteOJ8RDDySGSj0XKaoRvRcvFzxJIN2AoikwMSExFMrnFm15vUj?=
 =?us-ascii?Q?n4xz0i5Il0IgG4Nm6LxRmvZn/52PgejaBeKqMRjcqn8lH9zizagPfnNWdcn4?=
 =?us-ascii?Q?WYqj7Ryd4WoJBbo5kQFeBhirKFj5CrO+So49NhOXFcgM8uINVFsqjiym0P/G?=
 =?us-ascii?Q?nKMC2+TNR8o4aqhEW/OD0kDXGB7xCd5Z9mhJMz1Jtfzp6b6d+v6j7JRd9uL/?=
 =?us-ascii?Q?cPlnP8kN6p23OqrauTQzj+D4I2f+APfise4A++UHBoPlDOZqdaVVW4VV+kEq?=
 =?us-ascii?Q?6hyWFRp7rqGgZQx/afL0ESy11YXVD879DJzsFFlEhNtoL7Wl8qXq24pezOMu?=
 =?us-ascii?Q?C2EyVvnnxbA9AhiBwARkFPnl5UEwhjjJakEgCOy9dhBDnhij4nBHzf5UmIxY?=
 =?us-ascii?Q?IA99IszAz1angjrR7iREX/xrkK5X98YDAj+wTNo0Lfkjt88ozkpwZ9/Sw0FP?=
 =?us-ascii?Q?/SuBcETTcP48trBw6EvBpZ3K09d1Sw66NAovm1Ec1OJdGto3ivgeNGn4urfI?=
 =?us-ascii?Q?aB4eZMQ8qnyjxyzq9SCk0IYFeJ1pjp43Cc2fMbS3gnMoU7Xt3rORIrt/Cz/7?=
 =?us-ascii?Q?6Q9vkvhGR0/tokXNCXllhvMiszAkv5bgw93BYZ00GI46TL+V/qy/4Ns3ziV/?=
 =?us-ascii?Q?dCcrL5v+oZHxk8dlEto1CNd3J/4rpGSfIzU5e8+ZmORA9b/HIMf674ggzImW?=
 =?us-ascii?Q?8pOmjbg9TKne3jkK9w2teec/FVMiV1jOMaKgI1udBNF+vVqFk6boWo8AhKQR?=
 =?us-ascii?Q?uOV+L/OJZ5d7t4kG0/hMtyUrS/Giu/rFCiaWngXqCyABievk6F975qV+pjYk?=
 =?us-ascii?Q?7qv7ebOAXdER1zU6LAipIsKonWd8AB4E59cKlMZUYbdc799vVE7nRLxzqJq0?=
 =?us-ascii?Q?5I8aHZRS0d4tmsZt8MMxcXJk6Lto0TwzMslBkSWx+Mbb7N8T1kwHgupRJRd8?=
 =?us-ascii?Q?f3YZspEJYLYwDmiKDEFiHLwLeDnTF8JXOrWctZ+6uy6++Hh0bet8SYeA/hxo?=
 =?us-ascii?Q?UViKmmSeeyDyakuAHR8SVWHYPyig+UfHBpyNtiKj4dkWuKAJ4FJJY51Cw1P5?=
 =?us-ascii?Q?9c2JBsEeTIiF6rfUIS1hh0WGHstR5+uZHc28psPTM65x8X84QbNOQLh1bsFe?=
 =?us-ascii?Q?S9mGU8IjbrxnxPSWraoIgZOjZE7iUWo4+RlEokro6wgEYRWigXb8CyZVmnff?=
 =?us-ascii?Q?QRuYgc2QgEj3b2cScgfEzgUcFxtGg2mAVQUX?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2025 01:33:43.9625 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fd5780c8-ae27-4bce-4ecc-08ddf65367d1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4451
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

