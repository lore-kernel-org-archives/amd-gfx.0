Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 453A2CAC5A5
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Sep 2025 01:37:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D42E710E624;
	Thu, 18 Sep 2025 01:37:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="TSEVeuP2";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010002.outbound.protection.outlook.com
 [40.93.198.2])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5E44A10E619
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Sep 2025 01:37:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OFLn7VbOjgRYoWb1kEBjLn+9YEuLlIO0VcBfcrC8S7GOKTbw/eGGtsMkGJ/Upob52avrheT7Bs0jcX//f+tdvhol1bklROubfBTUS6FjeBr+9mhHlPLq0BuJKyusg0bVRCI++ri8H7j/Z45YVuKxwyIuiJQMpljlMtqMIbJMIpWGTUADqtqhjYqWZgFPSa1yAyiX25d6/PcOm5ATlB/D+OivhlivwZJEFskH3LJ7/Gl+EDBD0ZTEmN+DD8J8aQLJwnYpPA/HlPYseOD0kddBqJJG2az6m6ofRmR6sO7MAF9dNhVSG8J1bMeydm94vXjGogBLjtqn18YNs29PfeuIZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rg898yVvQbLBUxFfpRC8lQ4P1EgJV2NFvn/TjR/lgfU=;
 b=VNK3iZV5gNfy8YhFuOwspcbLCZ04vlU4Cmb+xjdLNv/LOwLMokgb+S5ahmEkbsOY67pHlsQrblXYWEpV2DjG/TNsCI2ccfQDDBt6y3AZdwyrHzLLCbhkWBwv6+yrap3i2ixCYDwZRKfObFxBWZxVBEqb9WOTJL7wMCdBCd/5BdcsOGZEikcTDnDyjRx+oI64+mgw6wPgcrWCh7feFBPw8uRu3TZ7Qk8mq83JMjZl6QmAJGRx4zUXGIDsoQXHaMYR/jJi/HVdalv/RCbxH1TkpCL1pDHWCT+4QJuLW331us89f53HrXt9Iymo23mRHHY9DqTiYfIeSORptORzS0plmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rg898yVvQbLBUxFfpRC8lQ4P1EgJV2NFvn/TjR/lgfU=;
 b=TSEVeuP2KbNYQ0HDMiPhT8rexwqo49zEKbx6U3DOLCnsIL1cpQ9OTlfktmSKwvJhBiHchTl9sBjVB+Ca8PPWqEojWbfJZWzL9RGB5AmrdOxi334gG1DYImCZytc3O5cbJfpqgL06GKffiC1oIkSecZdpsZX6e3TZTrAKijyrfBw=
Received: from SA1PR03CA0023.namprd03.prod.outlook.com (2603:10b6:806:2d3::28)
 by DS7PR12MB5886.namprd12.prod.outlook.com (2603:10b6:8:79::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.13; Thu, 18 Sep 2025 01:37:00 +0000
Received: from SA2PEPF00001508.namprd04.prod.outlook.com
 (2603:10b6:806:2d3:cafe::e1) by SA1PR03CA0023.outlook.office365.com
 (2603:10b6:806:2d3::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.14 via Frontend Transport; Thu,
 18 Sep 2025 01:37:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SA2PEPF00001508.mail.protection.outlook.com (10.167.242.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Thu, 18 Sep 2025 01:37:00 +0000
Received: from amd-02.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 17 Sep
 2025 18:36:56 -0700
From: YiPeng Chai <YiPeng.Chai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Tao.Zhou1@amd.com>, <Candice.Li@amd.com>,
 <Stanley.Yang@amd.com>, YiPeng Chai <YiPeng.Chai@amd.com>, Tao Zhou
 <tao.zhou1@amd.com>
Subject: [PATCH 08/10] drm/amd/ras: Add amdgpu ras management function.
Date: Thu, 18 Sep 2025 09:35:05 +0800
Message-ID: <20250918013507.2629620-8-YiPeng.Chai@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250918013507.2629620-1-YiPeng.Chai@amd.com>
References: <20250918013507.2629620-1-YiPeng.Chai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00001508:EE_|DS7PR12MB5886:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ab75ce9-4f3d-4716-06a2-08ddf653dcb7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?AinMNlVouwlDcSuCiuOH2WBp9HpaCUpZO1oI5iIPpBD9uh98wH6PeTJFVBP1?=
 =?us-ascii?Q?qNqdk868xS8hHNrSmemTA1C8ixFSfY4iVYmvKIX2ejWewceppbOSRY10Wg+5?=
 =?us-ascii?Q?CpD/ziwLWJMjt3tcrb9XiOFEOlMzmplBzqyxOMM0W2N3QuiL1UDbYTAnrbhQ?=
 =?us-ascii?Q?rN2MkJoywcO2NpyfcO2YVhRh7ytF0pN47mg2GSLEqu6aSJCqr2sSPUjbc9zk?=
 =?us-ascii?Q?xhtZZ/mGu7ZQ1jb/J24SApROIGYJHuWyxK9QJyTe1ZcsnOUL8SAcQ6ZRjI9Q?=
 =?us-ascii?Q?VM4sxpNxDzS4biUfHZFvaWKofOoTeImXlZWYXuysuqJx314HeTpxb6YeCnE4?=
 =?us-ascii?Q?HISx9eGrZIyJErC9oUNQ+6j6PqMJkqD5El0oiwHrlVR478YB1sw+2qskbi+7?=
 =?us-ascii?Q?x/n7PmAGaXH/n2185FOsOkDCxUl+FFOq2bwowfuS7le6+PjPmytdutFA9U4S?=
 =?us-ascii?Q?r8k5tl/Sljfz4MUTzVWF5QUx/SKGs9o5Eg6y2pC4s6X75GEpifgizLJlVBpe?=
 =?us-ascii?Q?QrPBBrt9QktYZwuxhvuVSWAMwA45GFwbWt+8YBjAjn9q4kNreVSdo27xED7V?=
 =?us-ascii?Q?VH4Bh3rFwO/64ZGuh8XiZU+ARRc9+C+1P7LiUaxrRskeMRcxd1ztd0Ke6sJr?=
 =?us-ascii?Q?ri74tCZ4mP44+rWRt0KAYoLJEBvXd/nbl3QbZ7tcoRl0BwIOyv0kyLKPI/dv?=
 =?us-ascii?Q?Vlxpl7gNVl06yUnxIrFc06WCWIcOfwCg1jjzG46qKtcfc2APUg94f4yM1VLB?=
 =?us-ascii?Q?N3+I/G/PlKRym1rVQk+toOqJ59UHUwkCD0EuZrpGgVC6IiQz9TD+hlRiYbwM?=
 =?us-ascii?Q?lIvz6SOnWqwDvgerS1uWcvWG3stvDStaSUa9g3LyujgSfWeYhKxYaj11YpK7?=
 =?us-ascii?Q?pRyHb6ywBiblopfjCNAJEYj6icN2tx5YytMpy9SoLM69Ud6NdoVEJnr0ShOY?=
 =?us-ascii?Q?qO7beqwO0XLOwGlQcbjyNeW+F5vpE8T64YGwjeA2uHH9XeOufZKmC69kRHH8?=
 =?us-ascii?Q?USeLn9FKcwcPo6N2T2GDEO8SDbI29t2UwH3rPpPoytREy23v46bZUhC/6Kg/?=
 =?us-ascii?Q?BTbgf71Csc98XIp7ofYMiuPCcXKTHYeB/4PQxi/jqkatMFYo7TT++EvfgBn/?=
 =?us-ascii?Q?t0F0rVvEBKaqQH+aHIYZ17cnJHCwCbi6+XGS+HCjY1U4PpWxTtdjPw9mP83d?=
 =?us-ascii?Q?uaDm4K63p5LeAtO+tt2c8JIGDHrEDq+CE/4Wwywi6whBrkDxadbfRgHbnsPp?=
 =?us-ascii?Q?mCY1EcM2NpSPWpklNj8L0uGzaqGrjrLTEEVrATCklkNjp50HnUUj182cIvgw?=
 =?us-ascii?Q?at6jm+vWbefdKYZgrGxhpGD0OyZp1IdPZq4ZYH/xQ0DZzu1wvePY+VihUGqc?=
 =?us-ascii?Q?YkzH/eOkyJbU2XYmcti0wytpY+28mcwiDVg8FzxmWzIytldY8chyTBmAwyzE?=
 =?us-ascii?Q?puLQmaAQ5YI6ZEmiAZ7GEFpagrYyHcU5CpGZwWkb8iWl6dpB3zaXaomq4AFn?=
 =?us-ascii?Q?NtWaC75QdDXRg6RGPcZPf0j/MmJ39N0a0BwS?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2025 01:37:00.1533 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ab75ce9-4f3d-4716-06a2-08ddf653dcb7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00001508.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5886
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

Add amdgpu system configuration parameters and
functions needed by rascore.

Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
Reviewed-by: Tao Zhou <tao.zhou1@amd.com>
---
 .../gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c  | 560 ++++++++++++++++++
 .../gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.h  |  73 +++
 2 files changed, 633 insertions(+)
 create mode 100644 drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c
 create mode 100644 drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.h

diff --git a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c
new file mode 100644
index 000000000000..a038c87c045d
--- /dev/null
+++ b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c
@@ -0,0 +1,560 @@
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
+#include "amdgpu.h"
+#include "amdgpu_reset.h"
+#include "amdgpu_xgmi.h"
+#include "ras_sys.h"
+#include "amdgpu_ras_mgr.h"
+#include "amdgpu_ras_cmd.h"
+#include "amdgpu_ras_process.h"
+#include "amdgpu_ras_eeprom_i2c.h"
+#include "amdgpu_ras_mp1_v13_0.h"
+#include "amdgpu_ras_nbio_v7_9.h"
+
+#define MAX_SOCKET_NUM_PER_HIVE		8
+#define MAX_AID_NUM_PER_SOCKET		4
+#define MAX_XCD_NUM_PER_AID			2
+
+/* typical ECC bad page rate is 1 bad page per 100MB VRAM */
+#define ESTIMATE_BAD_PAGE_THRESHOLD(size)         ((size)/(100 * 1024 * 1024ULL))
+
+#define COUNT_BAD_PAGE_THRESHOLD(size) (((size) >> 21) << 4)
+
+/* Reserve 8 physical dram row for possible retirement.
+ * In worst cases, it will lose 8 * 2MB memory in vram domain
+ */
+#define RAS_RESERVED_VRAM_SIZE_DEFAULT	(16ULL << 20)
+
+
+static void ras_mgr_init_event_mgr(struct ras_event_manager *mgr)
+{
+	struct ras_event_state *event_state;
+	int i;
+
+	memset(mgr, 0, sizeof(*mgr));
+	atomic64_set(&mgr->seqno, 0);
+
+	for (i = 0; i < ARRAY_SIZE(mgr->event_state); i++) {
+		event_state = &mgr->event_state[i];
+		event_state->last_seqno = RAS_EVENT_INVALID_ID;
+		atomic64_set(&event_state->count, 0);
+	}
+}
+
+static void amdgpu_ras_mgr_init_event_mgr(struct ras_core_context *ras_core)
+{
+	struct amdgpu_device *adev = (struct amdgpu_device *)ras_core->dev;
+	struct amdgpu_ras_mgr *ras_mgr = amdgpu_ras_mgr_get_context(adev);
+	struct ras_event_manager *event_mgr;
+	struct amdgpu_hive_info *hive;
+
+	hive = amdgpu_get_xgmi_hive(adev);
+	event_mgr = hive ? &hive->event_mgr : &ras_mgr->ras_event_mgr;
+
+	/* init event manager with node 0 on xgmi system */
+	if (!amdgpu_reset_in_recovery(adev)) {
+		if (!hive || adev->gmc.xgmi.node_id == 0)
+			ras_mgr_init_event_mgr(event_mgr);
+	}
+
+	if (hive)
+		amdgpu_put_xgmi_hive(hive);
+}
+
+static int amdgpu_ras_mgr_init_aca_config(struct amdgpu_device *adev,
+		struct ras_core_config *config)
+{
+	struct ras_aca_config *aca_cfg = &config->aca_cfg;
+
+	aca_cfg->socket_num_per_hive = MAX_SOCKET_NUM_PER_HIVE;
+	aca_cfg->aid_num_per_socket = MAX_AID_NUM_PER_SOCKET;
+	aca_cfg->xcd_num_per_aid = MAX_XCD_NUM_PER_AID;
+
+	return 0;
+}
+
+static int amdgpu_ras_mgr_init_eeprom_config(struct amdgpu_device *adev,
+		struct ras_core_config *config)
+{
+	struct ras_eeprom_config *eeprom_cfg = &config->eeprom_cfg;
+
+	eeprom_cfg->eeprom_sys_fn = &amdgpu_ras_eeprom_i2c_sys_func;
+	eeprom_cfg->eeprom_i2c_adapter = adev->pm.ras_eeprom_i2c_bus;
+	if (eeprom_cfg->eeprom_i2c_adapter) {
+		const struct i2c_adapter_quirks *quirks =
+			((struct i2c_adapter *)eeprom_cfg->eeprom_i2c_adapter)->quirks;
+
+		if (quirks) {
+			eeprom_cfg->max_i2c_read_len = quirks->max_read_len;
+			eeprom_cfg->max_i2c_write_len = quirks->max_write_len;
+		}
+	}
+
+	/*
+	 * amdgpu_bad_page_threshold is used to config
+	 * the threshold for the number of bad pages.
+	 * -1:  Threshold is set to default value
+	 *      Driver will issue a warning message when threshold is reached
+	 *      and continue runtime services.
+	 * 0:   Disable bad page retirement
+	 *      Driver will not retire bad pages
+	 *      which is intended for debugging purpose.
+	 * -2:  Threshold is determined by a formula
+	 *      that assumes 1 bad page per 100M of local memory.
+	 *      Driver will continue runtime services when threhold is reached.
+	 * 0 < threshold < max number of bad page records in EEPROM,
+	 *      A user-defined threshold is set
+	 *      Driver will halt runtime services when this custom threshold is reached.
+	 */
+	if (amdgpu_bad_page_threshold == NONSTOP_OVER_THRESHOLD)
+		eeprom_cfg->eeprom_record_threshold_count =
+				ESTIMATE_BAD_PAGE_THRESHOLD(adev->gmc.mc_vram_size);
+	else if (amdgpu_bad_page_threshold == WARN_NONSTOP_OVER_THRESHOLD)
+		eeprom_cfg->eeprom_record_threshold_count =
+				COUNT_BAD_PAGE_THRESHOLD(RAS_RESERVED_VRAM_SIZE_DEFAULT);
+	else
+		eeprom_cfg->eeprom_record_threshold_count = amdgpu_bad_page_threshold;
+
+	eeprom_cfg->eeprom_record_threshold_config = amdgpu_bad_page_threshold;
+
+	return 0;
+}
+
+static int amdgpu_ras_mgr_init_mp1_config(struct amdgpu_device *adev,
+		struct ras_core_config *config)
+{
+	struct ras_mp1_config *mp1_cfg = &config->mp1_cfg;
+	int ret = 0;
+
+	switch (config->mp1_ip_version) {
+	case IP_VERSION(13, 0, 6):
+	case IP_VERSION(13, 0, 14):
+	case IP_VERSION(13, 0, 12):
+		mp1_cfg->mp1_sys_fn = &amdgpu_ras_mp1_sys_func_v13_0;
+		break;
+	default:
+		RAS_DEV_ERR(adev,
+			"The mp1(0x%x) ras config is not right!\n",
+			config->mp1_ip_version);
+		ret = -EINVAL;
+		break;
+	}
+
+	return ret;
+}
+
+static int amdgpu_ras_mgr_init_nbio_config(struct amdgpu_device *adev,
+		struct ras_core_config *config)
+{
+	struct ras_nbio_config *nbio_cfg = &config->nbio_cfg;
+	int ret = 0;
+
+	switch (config->nbio_ip_version) {
+	case IP_VERSION(7, 9, 0):
+		nbio_cfg->nbio_sys_fn = &amdgpu_ras_nbio_sys_func_v7_9;
+		break;
+	default:
+		RAS_DEV_ERR(adev,
+			"The nbio(0x%x) ras config is not right!\n",
+			config->mp1_ip_version);
+		ret = -EINVAL;
+		break;
+	}
+
+	return ret;
+}
+
+static int amdgpu_ras_mgr_get_ras_psp_system_status(struct ras_core_context *ras_core,
+			struct ras_psp_sys_status *status)
+{
+	struct amdgpu_device *adev = (struct amdgpu_device *)ras_core->dev;
+	struct ta_context *context = &adev->psp.ras_context.context;
+
+	status->initialized = context->initialized;
+	status->session_id = context->session_id;
+	status->psp_cmd_mutex = &adev->psp.mutex;
+
+	return 0;
+}
+
+static int amdgpu_ras_mgr_get_ras_ta_init_param(struct ras_core_context *ras_core,
+	struct ras_ta_init_param *ras_ta_param)
+{
+	struct amdgpu_device *adev = (struct amdgpu_device *)ras_core->dev;
+	uint32_t nps_mode;
+
+	if (amdgpu_ras_is_poison_mode_supported(adev))
+		ras_ta_param->poison_mode_en = 1;
+
+	if (!adev->gmc.xgmi.connected_to_cpu && !adev->gmc.is_app_apu)
+		ras_ta_param->dgpu_mode = 1;
+
+	ras_ta_param->xcc_mask = adev->gfx.xcc_mask;
+	ras_ta_param->channel_dis_num = hweight32(adev->gmc.m_half_use) * 2;
+
+	ras_ta_param->active_umc_mask = adev->umc.active_mask;
+
+	if (!amdgpu_ras_mgr_get_curr_nps_mode(adev, &nps_mode))
+		ras_ta_param->nps_mode = nps_mode;
+
+	return 0;
+}
+
+const struct ras_psp_sys_func amdgpu_ras_psp_sys_func = {
+	.get_ras_psp_system_status = amdgpu_ras_mgr_get_ras_psp_system_status,
+	.get_ras_ta_init_param = amdgpu_ras_mgr_get_ras_ta_init_param,
+};
+
+static int amdgpu_ras_mgr_init_psp_config(struct amdgpu_device *adev,
+	struct ras_core_config *config)
+{
+	struct ras_psp_config *psp_cfg = &config->psp_cfg;
+
+	psp_cfg->psp_sys_fn = &amdgpu_ras_psp_sys_func;
+
+	return 0;
+}
+
+static int amdgpu_ras_mgr_init_umc_config(struct amdgpu_device *adev,
+	struct ras_core_config *config)
+{
+	struct ras_umc_config *umc_cfg = &config->umc_cfg;
+
+	umc_cfg->umc_vram_type = adev->gmc.vram_type;
+
+	return 0;
+}
+
+static struct ras_core_context *amdgpu_ras_mgr_create_ras_core(struct amdgpu_device *adev)
+{
+	struct ras_core_config init_config;
+
+	memset(&init_config, 0, sizeof(init_config));
+
+	init_config.umc_ip_version = amdgpu_ip_version(adev, UMC_HWIP, 0);
+	init_config.mp1_ip_version = amdgpu_ip_version(adev, MP1_HWIP, 0);
+	init_config.gfx_ip_version = amdgpu_ip_version(adev, GC_HWIP, 0);
+	init_config.nbio_ip_version = amdgpu_ip_version(adev, NBIO_HWIP, 0);
+	init_config.psp_ip_version = amdgpu_ip_version(adev, MP1_HWIP, 0);
+
+	if (init_config.umc_ip_version == IP_VERSION(12, 0, 0))
+		init_config.aca_ip_version = IP_VERSION(1, 0, 0);
+
+	init_config.sys_fn = &amdgpu_ras_sys_fn;
+	init_config.ras_eeprom_supported = true;
+	init_config.poison_supported =
+		amdgpu_ras_is_poison_mode_supported(adev);
+
+	amdgpu_ras_mgr_init_aca_config(adev, &init_config);
+	amdgpu_ras_mgr_init_eeprom_config(adev, &init_config);
+	amdgpu_ras_mgr_init_mp1_config(adev, &init_config);
+	amdgpu_ras_mgr_init_nbio_config(adev, &init_config);
+	amdgpu_ras_mgr_init_psp_config(adev, &init_config);
+	amdgpu_ras_mgr_init_umc_config(adev, &init_config);
+
+	return ras_core_create(&init_config);
+}
+
+static int amdgpu_ras_mgr_sw_init(struct amdgpu_ip_block *ip_block)
+{
+	struct amdgpu_device *adev = ip_block->adev;
+	struct amdgpu_ras *con = amdgpu_ras_get_context(adev);
+	struct amdgpu_ras_mgr *ras_mgr;
+	int ret = 0;
+
+	ras_mgr = kzalloc(sizeof(*ras_mgr), GFP_KERNEL);
+	if (!ras_mgr)
+		return -EINVAL;
+
+	con->ras_mgr = ras_mgr;
+	ras_mgr->adev = adev;
+
+	ras_mgr->ras_core = amdgpu_ras_mgr_create_ras_core(adev);
+	if (!ras_mgr->ras_core) {
+		RAS_DEV_ERR(adev, "Failed to create ras core!\n");
+		ret = -EINVAL;
+		goto err;
+	}
+
+	ras_mgr->ras_core->dev = adev;
+
+	amdgpu_ras_process_init(adev);
+	ras_core_sw_init(ras_mgr->ras_core);
+	amdgpu_ras_mgr_init_event_mgr(ras_mgr->ras_core);
+	return 0;
+
+err:
+	kfree(ras_mgr);
+	return ret;
+}
+
+static int amdgpu_ras_mgr_sw_fini(struct amdgpu_ip_block *ip_block)
+{
+	struct amdgpu_device *adev = ip_block->adev;
+	struct amdgpu_ras *con = amdgpu_ras_get_context(adev);
+	struct amdgpu_ras_mgr *ras_mgr = (struct amdgpu_ras_mgr *)con->ras_mgr;
+
+	if (!ras_mgr)
+		return 0;
+
+	amdgpu_ras_process_fini(adev);
+	ras_core_sw_fini(ras_mgr->ras_core);
+	ras_core_destroy(ras_mgr->ras_core);
+	ras_mgr->ras_core = NULL;
+
+	kfree(con->ras_mgr);
+	con->ras_mgr = NULL;
+
+	return 0;
+}
+
+static int amdgpu_ras_mgr_hw_init(struct amdgpu_ip_block *ip_block)
+{
+	struct amdgpu_device *adev = ip_block->adev;
+	struct amdgpu_ras_mgr *ras_mgr = amdgpu_ras_mgr_get_context(adev);
+	int ret;
+
+	if (!ras_mgr || !ras_mgr->ras_core)
+		return -EINVAL;
+
+	ret = ras_core_hw_init(ras_mgr->ras_core);
+	if (ret) {
+		RAS_DEV_ERR(adev, "Failed to initialize ras core!\n");
+		return ret;
+	}
+
+	ras_mgr->ras_is_ready = true;
+
+	RAS_DEV_INFO(adev, "AMDGPU RAS Is Ready.\n");
+	return 0;
+}
+
+static int amdgpu_ras_mgr_hw_fini(struct amdgpu_ip_block *ip_block)
+{
+	struct amdgpu_device *adev = ip_block->adev;
+	struct amdgpu_ras_mgr *ras_mgr = amdgpu_ras_mgr_get_context(adev);
+
+	if (!ras_mgr || !ras_mgr->ras_core)
+		return -EINVAL;
+
+	ras_core_hw_fini(ras_mgr->ras_core);
+
+	ras_mgr->ras_is_ready = false;
+
+	return 0;
+}
+
+struct amdgpu_ras_mgr *amdgpu_ras_mgr_get_context(struct amdgpu_device *adev)
+{
+	if (!adev || !adev->psp.ras_context.ras)
+		return NULL;
+
+	return (struct amdgpu_ras_mgr *)adev->psp.ras_context.ras->ras_mgr;
+}
+
+static const struct amd_ip_funcs ras_v1_0_ip_funcs = {
+	.name = "ras_v1_0",
+	.sw_init = amdgpu_ras_mgr_sw_init,
+	.sw_fini = amdgpu_ras_mgr_sw_fini,
+	.hw_init = amdgpu_ras_mgr_hw_init,
+	.hw_fini = amdgpu_ras_mgr_hw_fini,
+};
+
+int amdgpu_enable_unified_ras(struct amdgpu_device *adev, bool enable)
+{
+	struct amdgpu_ras_mgr *ras_mgr = amdgpu_ras_mgr_get_context(adev);
+
+	if (!ras_mgr || !ras_mgr->ras_core)
+		return -EPERM;
+
+	if (amdgpu_sriov_vf(adev))
+		return -EPERM;
+
+	RAS_DEV_INFO(adev, "Enable amdgpu unified ras!");
+	return ras_core_set_status(ras_mgr->ras_core, enable);
+}
+
+bool amdgpu_unified_ras_enabled(struct amdgpu_device *adev)
+{
+	struct amdgpu_ras_mgr *ras_mgr = amdgpu_ras_mgr_get_context(adev);
+
+	if (!ras_mgr || !ras_mgr->ras_core)
+		return false;
+
+	if (amdgpu_sriov_vf(adev))
+		return false;
+
+	return ras_core_is_enabled(ras_mgr->ras_core);
+}
+
+static bool amdgpu_ras_mgr_is_ready(struct amdgpu_device *adev)
+{
+	struct amdgpu_ras_mgr *ras_mgr = amdgpu_ras_mgr_get_context(adev);
+
+	if (ras_mgr && ras_mgr->ras_core && ras_mgr->ras_is_ready &&
+	    ras_core_is_ready(ras_mgr->ras_core))
+		return true;
+
+	return false;
+}
+
+int amdgpu_ras_mgr_handle_fatal_interrupt(struct amdgpu_device *adev, void *data)
+{
+	struct amdgpu_ras_mgr *ras_mgr = amdgpu_ras_mgr_get_context(adev);
+
+	if (!amdgpu_ras_mgr_is_ready(adev))
+		return -EPERM;
+
+	return ras_core_handle_nbio_irq(ras_mgr->ras_core, data);
+}
+
+uint64_t amdgpu_ras_mgr_gen_ras_event_seqno(struct amdgpu_device *adev,
+			enum ras_seqno_type seqno_type)
+{
+	struct amdgpu_ras_mgr *ras_mgr = amdgpu_ras_mgr_get_context(adev);
+	int ret;
+	uint64_t seq_no;
+
+	if (!amdgpu_ras_mgr_is_ready(adev) ||
+	    (seqno_type >= RAS_SEQNO_TYPE_COUNT_MAX))
+		return 0;
+
+	seq_no = ras_core_gen_seqno(ras_mgr->ras_core, seqno_type);
+
+	if ((seqno_type == RAS_SEQNO_TYPE_DE) ||
+	    (seqno_type == RAS_SEQNO_TYPE_POISON_CONSUMPTION)) {
+		ret = ras_core_put_seqno(ras_mgr->ras_core, seqno_type, seq_no);
+		if (ret)
+			RAS_DEV_WARN(adev, "There are too many ras interrupts!");
+	}
+
+	return seq_no;
+}
+
+int amdgpu_ras_mgr_handle_controller_interrupt(struct amdgpu_device *adev, void *data)
+{
+	struct amdgpu_ras_mgr *ras_mgr = amdgpu_ras_mgr_get_context(adev);
+	struct ras_ih_info *ih_info = (struct ras_ih_info *)data;
+	uint64_t seq_no = 0;
+	int ret = 0;
+
+	if (!amdgpu_ras_mgr_is_ready(adev))
+		return -EPERM;
+
+	if (ih_info && (ih_info->block == AMDGPU_RAS_BLOCK__UMC)) {
+		if (ras_mgr->ras_core->poison_supported) {
+			seq_no = amdgpu_ras_mgr_gen_ras_event_seqno(adev, RAS_SEQNO_TYPE_DE);
+			RAS_DEV_INFO(adev,
+				"{%llu} RAS poison is created, no user action is needed.\n",
+				seq_no);
+		}
+
+		ret = amdgpu_ras_process_handle_umc_interrupt(adev, ih_info);
+	} else if (ras_mgr->ras_core->poison_supported) {
+		ret = amdgpu_ras_process_handle_unexpected_interrupt(adev, ih_info);
+	} else {
+		RAS_DEV_WARN(adev,
+			"No RAS interrupt handler for non-UMC block with poison disabled.\n");
+	}
+
+	return ret;
+}
+
+int amdgpu_ras_mgr_handle_consumer_interrupt(struct amdgpu_device *adev, void *data)
+{
+	if (!amdgpu_ras_mgr_is_ready(adev))
+		return -EPERM;
+
+	return amdgpu_ras_process_handle_consumption_interrupt(adev, data);
+}
+
+int amdgpu_ras_mgr_update_ras_ecc(struct amdgpu_device *adev)
+{
+	struct amdgpu_ras_mgr *ras_mgr = amdgpu_ras_mgr_get_context(adev);
+
+	if (!amdgpu_ras_mgr_is_ready(adev))
+		return -EPERM;
+
+	return ras_core_update_ecc_info(ras_mgr->ras_core);
+}
+
+int amdgpu_ras_mgr_reset_gpu(struct amdgpu_device *adev, uint32_t flags)
+{
+	struct amdgpu_ras *con = amdgpu_ras_get_context(adev);
+
+	if (!amdgpu_ras_mgr_is_ready(adev))
+		return -EPERM;
+
+	con->gpu_reset_flags |= flags;
+	return amdgpu_ras_reset_gpu(adev);
+}
+
+bool amdgpu_ras_mgr_check_eeprom_safety_watermark(struct amdgpu_device *adev)
+{
+	struct amdgpu_ras_mgr *ras_mgr = amdgpu_ras_mgr_get_context(adev);
+
+	if (!amdgpu_ras_mgr_is_ready(adev))
+		return false;
+
+	return ras_eeprom_check_safety_watermark(ras_mgr->ras_core);
+}
+
+int amdgpu_ras_mgr_get_curr_nps_mode(struct amdgpu_device *adev,
+	uint32_t *nps_mode)
+{
+	struct amdgpu_ras_mgr *ras_mgr = amdgpu_ras_mgr_get_context(adev);
+	uint32_t mode;
+
+	if (!amdgpu_ras_mgr_is_ready(adev))
+		return -EINVAL;
+
+	mode = ras_core_get_curr_nps_mode(ras_mgr->ras_core);
+	if (!mode || mode > AMDGPU_NPS8_PARTITION_MODE)
+		return -EINVAL;
+
+	*nps_mode = mode;
+
+	return 0;
+}
+
+bool amdgpu_ras_mgr_check_retired_addr(struct amdgpu_device *adev,
+			uint64_t addr)
+{
+	struct amdgpu_ras_mgr *ras_mgr = amdgpu_ras_mgr_get_context(adev);
+
+	if (!amdgpu_ras_mgr_is_ready(adev))
+		return false;
+
+	return ras_umc_check_retired_addr(ras_mgr->ras_core, addr);
+}
+
+bool amdgpu_ras_mgr_is_rma(struct amdgpu_device *adev)
+{
+	struct amdgpu_ras_mgr *ras_mgr = amdgpu_ras_mgr_get_context(adev);
+
+	if (!ras_mgr || !ras_mgr->ras_core || !ras_mgr->ras_is_ready)
+		return false;
+
+	return ras_core_gpu_is_rma(ras_mgr->ras_core);
+}
diff --git a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.h b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.h
new file mode 100644
index 000000000000..fa761de381c1
--- /dev/null
+++ b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.h
@@ -0,0 +1,73 @@
+/* SPDX-License-Identifier: MIT */
+/*
+ * Copyright (c) 2025 Advanced Micro Devices, Inc.
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a copy
+ * of this software and associated documentation files (the "Software"), to deal
+ * in the Software without restriction, including without limitation the rights
+ * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
+ * copies of the Software, and to permit persons to whom the Software is
+ * furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL THE
+ * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+ * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
+ * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
+ * THE SOFTWARE.
+ */
+#ifndef __AMDGPU_RAS_MGR_H__
+#define __AMDGPU_RAS_MGR_H__
+#include "ras.h"
+#include "amdgpu_ras_process.h"
+
+enum ras_ih_type {
+	RAS_IH_NONE,
+	RAS_IH_FROM_BLOCK_CONTROLLER,
+	RAS_IH_FROM_CONSUMER_CLIENT,
+	RAS_IH_FROM_FATAL_ERROR,
+};
+
+struct ras_ih_info {
+	uint32_t block;
+	union {
+		struct amdgpu_iv_entry iv_entry;
+		struct {
+			uint16_t pasid;
+			uint32_t reset;
+			pasid_notify pasid_fn;
+			void *data;
+		};
+	};
+};
+
+struct amdgpu_ras_mgr {
+	struct amdgpu_device *adev;
+	struct ras_core_context *ras_core;
+	struct delayed_work retire_page_dwork;
+	struct ras_event_manager ras_event_mgr;
+	uint64_t last_poison_consumption_seqno;
+	bool ras_is_ready;
+};
+
+struct amdgpu_ras_mgr *amdgpu_ras_mgr_get_context(
+			struct amdgpu_device *adev);
+int amdgpu_enable_unified_ras(struct amdgpu_device *adev, bool enable);
+bool amdgpu_unified_ras_enabled(struct amdgpu_device *adev);
+int amdgpu_ras_mgr_handle_fatal_interrupt(struct amdgpu_device *adev, void *data);
+int amdgpu_ras_mgr_handle_controller_interrupt(struct amdgpu_device *adev, void *data);
+int amdgpu_ras_mgr_handle_consumer_interrupt(struct amdgpu_device *adev, void *data);
+int amdgpu_ras_mgr_update_ras_ecc(struct amdgpu_device *adev);
+int amdgpu_ras_mgr_reset_gpu(struct amdgpu_device *adev, uint32_t flags);
+uint64_t amdgpu_ras_mgr_gen_ras_event_seqno(struct amdgpu_device *adev,
+			enum ras_seqno_type seqno_type);
+bool amdgpu_ras_mgr_check_eeprom_safety_watermark(struct amdgpu_device *adev);
+int amdgpu_ras_mgr_get_curr_nps_mode(struct amdgpu_device *adev, uint32_t *nps_mode);
+bool amdgpu_ras_mgr_check_retired_addr(struct amdgpu_device *adev,
+			uint64_t addr);
+bool amdgpu_ras_mgr_is_rma(struct amdgpu_device *adev);
+#endif
-- 
2.34.1

