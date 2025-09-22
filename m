Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 646EFCAC5A7
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Sep 2025 02:39:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F3FD310E37A;
	Mon, 22 Sep 2025 02:39:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="jnr2NVDi";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010019.outbound.protection.outlook.com
 [40.93.198.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EE94310E379
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Sep 2025 02:39:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NAjbZbush9qiDCudVGJ/IG221h9sOgUqaSeluL0M8iqfvCSRiDL9y9XCRDZdHo15j09BdwUzAsUuflkPuAEXf+nGezBsVQBXBEGN0QJODSRWf8g5x0gm/gQfh0BkhUgk6wMo1J9051hFQy1LPy7X4WqjdzzpuSjkpXxOt/cNFzgKTSj+2CCAGCtSCROS0ltaMG/txrmgn0I58XMJxeGNsi6g+GF4Fr/5ter3sn44ZHm30/mG1K3z68mRvu9IE/NTNq9ll/cSgOcYm128l8neKVl9fho5Qfno++I689qx8KSp4i+s5QvAMu8zzqrVIFKrNvLcQofnmnilJSNLYZxlYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AimhBaj+6fjlC0Dyd66GzsYYLEbqRP9lqZKFEBu2NpU=;
 b=mVrfMKHzGM/dyqyVsdKM+YPvgbz7fAclSRBldxsXiEVRGikhpWet/7el2nKVOtww1jlskFDNWsn/bO4j0AhIOvPRDqaYZrX6NsHjFfPWidXwbDHqo7dE/6wUMIfJOtA/rva92s48EnZ/O+IjpX4qwSlOC8Qu16w+4DCn9WuTJ31+cNA6ezWajKIf+yVY+UawS52ztRq6PhV36RkxZ67WK2K7Naaya7bJow1oAkuNb9SZShNagEpKuiGHiWhspUlYiCoqXyLyFJMd2PUP9U1Koj/DBU6U/pzFWgUssv7nrafSIyl3SY+mzvW7u6bByD1LMt4ckJ5ySzsy8IAVpCbyoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AimhBaj+6fjlC0Dyd66GzsYYLEbqRP9lqZKFEBu2NpU=;
 b=jnr2NVDiLP6W0k4kd6HDfqDVLMFhruziHW3P3iWNJmpVv7j0M0uTnC8oWi2t2UGYXnFAUvpKCyXRkKu8XGhX/e076cbah1RUJmsqeA8rCHvM7oMt99Tl1FdhdUzaNHx2ly8/X5jF20GnDMqZfc+m1g91AXgYpg1rUM+qmsetkc0=
Received: from BYAPR08CA0007.namprd08.prod.outlook.com (2603:10b6:a03:100::20)
 by DS0PR12MB6437.namprd12.prod.outlook.com (2603:10b6:8:cb::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.19; Mon, 22 Sep
 2025 02:39:30 +0000
Received: from CO1PEPF000044FC.namprd21.prod.outlook.com
 (2603:10b6:a03:100:cafe::88) by BYAPR08CA0007.outlook.office365.com
 (2603:10b6:a03:100::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.20 via Frontend Transport; Mon,
 22 Sep 2025 02:39:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF000044FC.mail.protection.outlook.com (10.167.241.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9182.0 via Frontend Transport; Mon, 22 Sep 2025 02:39:29 +0000
Received: from amd-02.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Sun, 21 Sep
 2025 19:39:27 -0700
From: YiPeng Chai <YiPeng.Chai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <yipechai@amd.com>, <Hawking.Zhang@amd.com>, <Tao.Zhou1@amd.com>,
 <Stanley.Yang@amd.com>, YiPeng Chai <YiPeng.Chai@amd.com>, Tao Zhou
 <tao.zhou1@amd.com>
Subject: [PATCH V5 04/20] drm/amd/ras: Add mp1 v13_0 ras functions
Date: Mon, 22 Sep 2025 10:38:28 +0800
Message-ID: <20250922023844.3108065-4-YiPeng.Chai@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000044FC:EE_|DS0PR12MB6437:EE_
X-MS-Office365-Filtering-Correlation-Id: 070d3d9c-8184-4b67-8583-08ddf9814155
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?GSEbG1hjvh50J1uAj8TB5eCr/Gwvn31fMvSzWp2DC3vmVBAYIbCTLnIvyNqh?=
 =?us-ascii?Q?hoLze7cQHzg/of/+vwc/woad8xp6067FLAQKKRpJq9vZriFE9uA22fiy9HeZ?=
 =?us-ascii?Q?K/s509WfnY7uOEuEP3wap2UDl0UR/+F4T2kKFgS/0p7ofi/4GrMIRuapocCo?=
 =?us-ascii?Q?wLBkCd6X8rT/47Ccr+soOs6q8BbaZETel1QkyUZLJVMF9VJs9sDPPEn2FKwu?=
 =?us-ascii?Q?xbVTX7ToAkpJjqBCr+J02ERK8o7M1udQISjWE3vcEpBQfZygjy0NA1i6iEzf?=
 =?us-ascii?Q?/ym7ej9x3mzyWd2WZUFfiqGM/3ZMGhqy4TCpObPO1At/chonPge0FPQ+HAdp?=
 =?us-ascii?Q?H11LtnfkOZ4YLBRK6hB4HRQxgbacUzXLBMgBAD4q1y+JOKksAggIYC08Sygu?=
 =?us-ascii?Q?bmDB3ON4ZKd2uhNZPQxS6j5diBfr6ThdhpgQ55KZYnmsjEmNDqRaBSP8Gx0C?=
 =?us-ascii?Q?4MXSkiAUUtjpxWocIme6uut3JAx2EX9/TnvMqTGTqIkMFyNQ7I+PDG/+OmIb?=
 =?us-ascii?Q?DYV+EoD7zzePoS1Qokl/ii6cggr8YDmez8UrL4iF5n7cdp66Q9oluke9B+LP?=
 =?us-ascii?Q?1M3yg5xfjca/mZLDenr/oiRSftUhJb46HHCL9l1n9alaMRZGCDpvPY6XBpOD?=
 =?us-ascii?Q?uERgSFB7bFLmw2b29rMJduk1eSObE3H42blXqn7cl6DwsoDPZ5hBTKSnDN3s?=
 =?us-ascii?Q?qOA9tvDacr+YYxHXWW2xIvMdns6TTFtUg5ex+zuMA+NbcArT24b4jFRBBv67?=
 =?us-ascii?Q?nZgwScm7J8p+c5+0RQcQ+fTnG8j1v1CbhReOfH43HgS7IX/2XmAsesBGCm5v?=
 =?us-ascii?Q?EPeE6aYJMbQXP7dZXZYfsQtDY5Rg3OMgNgpks2eg3kpaSyv2mYxvrPiD5sdV?=
 =?us-ascii?Q?apnMNF4fUUqwOpm5ns+7LTmNr1DZVqJlg8bgUFiLqUMLvNJ/CxMmX4TUMqT5?=
 =?us-ascii?Q?e9OTRSeiIbRNcDNGMq6YivmnFUq8TUcW+cB/Ft8uL7zXReLZ8A4krQEwIxN0?=
 =?us-ascii?Q?MpBCrxwEN/iIHS8NWfJxJ6tRkVhFiiowrmBQAh33/CWS2+H7fwmTsTczZopJ?=
 =?us-ascii?Q?8QMxPG0+6NnxIzupRUkHxZtoIelM9Du7yZnWlhuGpUUraLNss5ofpx/0lMlA?=
 =?us-ascii?Q?LTVIlwNfkO6hFzagju91pJO1gmOqouQbyD6AwGblnj9Wo9JyoBNggKm/f4P0?=
 =?us-ascii?Q?txS2np/53i6Ah9j1uZgr3LfNoI37RZnkwivkXOA4dLopPH1UNBx1MUVCSpwe?=
 =?us-ascii?Q?ktyOoIn3dN54MM0t2EVNcT0+LSez+3OmrsQwpBQvltPOnicTiaEwiYLNi7vv?=
 =?us-ascii?Q?W+ntcuv9p+ZNiGyrpIY2QqBpCKqzdeeapcsOZhoUC2+ap3O14/u2OWBejxKj?=
 =?us-ascii?Q?tnEyHCdHumIoh0rQaM4LX1UOAITlMhY8dZv7Km/3ReYfH2eBZ4HyIcy0witJ?=
 =?us-ascii?Q?G9PJKNqK+VEi/Ai0NdEoVKzEqNik2OBx7+4oitVWOPTi+y1rstmGJJk4BVVI?=
 =?us-ascii?Q?iZgnacPGFWpYc75IKduquwmAeXoYIYskA1mv?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2025 02:39:29.7366 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 070d3d9c-8184-4b67-8583-08ddf9814155
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044FC.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6437
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

Add mp1 v13_0 ras functions.

Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
Reviewed-by: Tao Zhou <tao.zhou1@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 .../gpu/drm/amd/ras/rascore/ras_mp1_v13_0.c   | 105 ++++++++++++++++++
 .../gpu/drm/amd/ras/rascore/ras_mp1_v13_0.h   |  30 +++++
 2 files changed, 135 insertions(+)
 create mode 100644 drivers/gpu/drm/amd/ras/rascore/ras_mp1_v13_0.c
 create mode 100644 drivers/gpu/drm/amd/ras/rascore/ras_mp1_v13_0.h

diff --git a/drivers/gpu/drm/amd/ras/rascore/ras_mp1_v13_0.c b/drivers/gpu/drm/amd/ras/rascore/ras_mp1_v13_0.c
new file mode 100644
index 000000000000..310d39fc816b
--- /dev/null
+++ b/drivers/gpu/drm/amd/ras/rascore/ras_mp1_v13_0.c
@@ -0,0 +1,105 @@
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
+#include "ras_mp1.h"
+#include "ras_core_status.h"
+#include "ras_mp1_v13_0.h"
+
+#define RAS_MP1_MSG_QueryValidMcaCount                0x36
+#define RAS_MP1_MSG_McaBankDumpDW                     0x37
+#define RAS_MP1_MSG_ClearMcaOnRead                    0x39
+#define RAS_MP1_MSG_QueryValidMcaCeCount              0x3A
+#define RAS_MP1_MSG_McaBankCeDumpDW                   0x3B
+
+#define MAX_UE_BANKS_PER_QUERY  12
+#define MAX_CE_BANKS_PER_QUERY  12
+
+static int mp1_v13_0_get_bank_count(struct ras_core_context *ras_core,
+			    enum ras_err_type type, u32 *count)
+{
+	struct ras_mp1 *mp1 = &ras_core->ras_mp1;
+	const struct ras_mp1_sys_func *sys_func = mp1->sys_func;
+	uint32_t bank_count = 0;
+	u32 msg;
+	int ret;
+
+	if (!count)
+		return -EINVAL;
+
+	if (!sys_func || !sys_func->mp1_get_valid_bank_count)
+		return -RAS_CORE_NOT_SUPPORTED;
+
+	switch (type) {
+	case RAS_ERR_TYPE__UE:
+		msg = RAS_MP1_MSG_QueryValidMcaCount;
+		break;
+	case RAS_ERR_TYPE__CE:
+	case RAS_ERR_TYPE__DE:
+		msg = RAS_MP1_MSG_QueryValidMcaCeCount;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	ret = sys_func->mp1_get_valid_bank_count(ras_core, msg, &bank_count);
+	if (!ret) {
+		if (((type == RAS_ERR_TYPE__UE) && (bank_count >= MAX_UE_BANKS_PER_QUERY)) ||
+			((type == RAS_ERR_TYPE__CE) && (bank_count >= MAX_CE_BANKS_PER_QUERY)))
+			return -EINVAL;
+
+		*count = bank_count;
+	}
+
+	return ret;
+}
+
+static int mp1_v13_0_dump_bank(struct ras_core_context *ras_core,
+			enum ras_err_type type, u32 idx, u32 reg_idx, u64 *val)
+{
+	struct ras_mp1 *mp1 = &ras_core->ras_mp1;
+	const struct ras_mp1_sys_func *sys_func = mp1->sys_func;
+	u32 msg;
+
+	if (!sys_func || !sys_func->mp1_dump_valid_bank)
+		return -RAS_CORE_NOT_SUPPORTED;
+
+	switch (type) {
+	case RAS_ERR_TYPE__UE:
+		msg = RAS_MP1_MSG_McaBankDumpDW;
+		break;
+	case RAS_ERR_TYPE__CE:
+	case RAS_ERR_TYPE__DE:
+		msg = RAS_MP1_MSG_McaBankCeDumpDW;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return sys_func->mp1_dump_valid_bank(ras_core, msg, idx, reg_idx, val);
+}
+
+const struct ras_mp1_ip_func mp1_ras_func_v13_0 = {
+	.get_valid_bank_count = mp1_v13_0_get_bank_count,
+	.dump_valid_bank = mp1_v13_0_dump_bank,
+};
diff --git a/drivers/gpu/drm/amd/ras/rascore/ras_mp1_v13_0.h b/drivers/gpu/drm/amd/ras/rascore/ras_mp1_v13_0.h
new file mode 100644
index 000000000000..2edfdb5f6a75
--- /dev/null
+++ b/drivers/gpu/drm/amd/ras/rascore/ras_mp1_v13_0.h
@@ -0,0 +1,30 @@
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
+#ifndef __RAS_MP1_V13_0_H__
+#define __RAS_MP1_V13_0_H__
+#include "ras_mp1.h"
+
+extern const struct ras_mp1_ip_func mp1_ras_func_v13_0;
+
+#endif
-- 
2.34.1

