Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D6CACAC59F
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Sep 2025 01:33:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8621710E5DB;
	Thu, 18 Sep 2025 01:33:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="JZbgRoNC";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011032.outbound.protection.outlook.com
 [40.93.194.32])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 863E110E5DB
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Sep 2025 01:33:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sxkgQ92M0swjLTxpL2mb/DzEr4tjbm/WoVNPvKu1wI7TcMKbTZQrjEf6sZ6+fwb6qA2BKggX0gtkFn1VcXn1WBSGtX6q8Q8I9egpTPw3G6Kpxuxc4jL6uH6p3ag6UkLyMkW+qdRxISWUk1/JNTaYHwbeIHZ5FzMP3TB3EvDMzSxaNp0j1PYhleAeMDVmp2pFLySunEWGifJDltgEeJW86aPTABKklpV4ULWnNR5QgJlkAVCiteICuR9W0NsyXyAhUWVU+hN0fa7yPBJcW7Z2d7WcOgKc1Xpk9bWYE/1EFak8xwCzSyreqtLmTriy20T5OunZemrnD/akgwFKvAQILg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qqyKa80NXioV9wxtSGv3GP0pOhEsngMz9MFxP5p1AnE=;
 b=QkEiW6NdHdLOJnzlPtTWPOSG3zF0Pkq7HzFh62E7c+orhPwcOUVH37T5JZANRCRFiVCz7irXRUh9NH6C4DpG4BpE75MvFrjBuziibnIlm4ZqjylTnTkSZQHuiYjMl8rk79tm1urLsUvM26ChZ97pzlbpNZJYFBHmJjJVsb3F3bkhm5VSrby9gzQMVBRB8PziI1QFmF4ZMb4hln4qzAKHRjVCVDS8AzFosaWohnVatVVZ3/8jSIaaEDABef84BAxwt5C7eCCNRZaYnby9/ICUn405ARLivVluwz/nDb+vxtmj9Po/IvPR8bc4UaGp5V+bfm8v3CT/wkXn18Fi2PnUvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qqyKa80NXioV9wxtSGv3GP0pOhEsngMz9MFxP5p1AnE=;
 b=JZbgRoNCA8rOqR7LmIPzKpSLGy3ghMtu7CmCArdDkzs7gi1TsjlxWAc0Zcbonx+mKwSmtxKJfQp5rCEhw+DRiXaqjqrBdcE89D77SF3GybuZbLtcI9ID3oT574jDG/lhc+JUfE8jujPas+RsIDeWhdktNlEml9O+3TmfV+tM1ZU=
Received: from SJ0PR13CA0219.namprd13.prod.outlook.com (2603:10b6:a03:2c1::14)
 by BN3PR12MB9569.namprd12.prod.outlook.com (2603:10b6:408:2ca::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.23; Thu, 18 Sep
 2025 01:33:16 +0000
Received: from CO1PEPF000044F2.namprd05.prod.outlook.com
 (2603:10b6:a03:2c1:cafe::70) by SJ0PR13CA0219.outlook.office365.com
 (2603:10b6:a03:2c1::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.13 via Frontend Transport; Thu,
 18 Sep 2025 01:33:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF000044F2.mail.protection.outlook.com (10.167.241.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Thu, 18 Sep 2025 01:33:15 +0000
Received: from amd-02.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 17 Sep
 2025 18:33:13 -0700
From: YiPeng Chai <YiPeng.Chai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Tao.Zhou1@amd.com>, <Candice.Li@amd.com>,
 <Stanley.Yang@amd.com>, YiPeng Chai <YiPeng.Chai@amd.com>, Tao Zhou
 <tao.zhou1@amd.com>
Subject: [PATCH 05/21] drm/amd/ras: Add mp1 v13_0 ras functions
Date: Thu, 18 Sep 2025 09:32:16 +0800
Message-ID: <20250918013232.2629215-5-YiPeng.Chai@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F2:EE_|BN3PR12MB9569:EE_
X-MS-Office365-Filtering-Correlation-Id: c4daf3fc-c861-49ef-ac10-08ddf6535720
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?AvV/pUqKisZAIpbK13l2BKtB/rOu8ZnLt3pJECUg0u6D58HO81fjxZccYHL+?=
 =?us-ascii?Q?aDVpuWTgpvlpTQobaLR2ba1P7WPIvCi1vo0A3rb+GOpGD/sOOSXsce81zNFC?=
 =?us-ascii?Q?+mARxjT5xVQNHaIXntEGYKUz3nvZEqKXCs6pZBNlL8aKJNu29oNQ0jbN4bEG?=
 =?us-ascii?Q?2PbnztOMoQdOi1rBya63O+f+TIYPtq2HKWabBwNacRHHfpaOhiOnQelXMR5V?=
 =?us-ascii?Q?DC18Vbh56/Tyo2r9u6vhj2slKIeO34vzSe+5dGUjyCwi9XHrU6wF3YYDk0tP?=
 =?us-ascii?Q?nZRtjV7twaqxoyaF4HZFfso8WklH3hDtZHmN6kiEXWuJuAV3NhhJRg2f7YTz?=
 =?us-ascii?Q?hkhWhy71xzQ4L5JGIr3A6HXp6kQO3Z7Dyc77xORRpuA+iIHKczNKqiPPbX7L?=
 =?us-ascii?Q?8KhibheJ7Kab6zVlBU5vMu0qNwC8cZyeoblK8soa3KN1PFkRMj43m3Vay74O?=
 =?us-ascii?Q?kKiK/FQOBBqMU/CO9K6QaHgGoC9SicCaoR4uXE3ZIb+tYDqpY742C4MTP7wI?=
 =?us-ascii?Q?EI6G0flDomuS8Xk4G40TvDfHT6ava63E+wkqBv47EFOguPeawzHqg1rK4wI3?=
 =?us-ascii?Q?ioCCy88JgMoke9eX+vubqPuLjY9c+VFoGNlXL6Xn/Pzujge69c3jUEsEiHNp?=
 =?us-ascii?Q?XBDCeJEQF3x1mxjkPmeIJOu/P6f8SzgSa9Tm/rvoDpw3xwABUHWs4XU/OO/F?=
 =?us-ascii?Q?KXmUa4oLCA2qapLu/qMmsj1RVMk5fm/9IaaJEg0ihNhUkInLrCqhzbRi8p6j?=
 =?us-ascii?Q?gOd7zb/zH/DxYpMpwmfiKTT3LTs1yQ0NJms46yX/jNwGfQYaTwIOMdcohIrq?=
 =?us-ascii?Q?BSwVx1S96uPYgJhvrisfmYkGpkxfjl0vsdpi5hgveLIPK0ea6iiW7CcDdhbz?=
 =?us-ascii?Q?CkQg2wfHx9CzMtBsILqVsjVbIxbGckFAgbUE8tQONzDaXkv7dTylyICEIRBM?=
 =?us-ascii?Q?ise+gx87RqAuBKO2JcuYb22MrQXcoZjuT7AxIwwhyBTuT92sOZSzaPHIF8uJ?=
 =?us-ascii?Q?1y8xtPX3UZkg6GWNDzX3d92/QAzX6ENhp3FTP37K3Ii8E0+5Kb6TWXAXvlua?=
 =?us-ascii?Q?Y4tmKQti3Xhs34mKTRxfbzGyrH2LprFBcUKtjLTwgj1SNIW+JXtWxf2w9mlw?=
 =?us-ascii?Q?svln5j1CyUX2MFRd9C8eUhaWtRbKaSsqB1dKjDMsNNlyWA8FRkLHGur+792L?=
 =?us-ascii?Q?yV+kslZwrbQ7yK1f0D8SPQtlfXp3YxpSynWOaPi1b9t3Jrs+IpA7wRjtYVLS?=
 =?us-ascii?Q?MI55+uCz+pAAGYZR11dHl/grs11lQELNk0lO7ImrGkgFvfeASm4fhG43/o/6?=
 =?us-ascii?Q?VZrWhk3tu8GptLK20/JsJchQWE88uq3wzbMhNw+w90lwQB1UQcQUlSZ7MP0x?=
 =?us-ascii?Q?t3dibAbwq3Rta26+Hgfu60/AO1Y/i4F3LO9G7d2vKhf+bEpEUpbx8KMuVdrB?=
 =?us-ascii?Q?x1lkT4kXuPfkSjIWU9oRUf4iNsOf0bkUpl3EpFDixwlcg1Q/p8rExnFaC/56?=
 =?us-ascii?Q?JlqToDPNINoa/W0z0yuzOXnUF69B1EBIhEwW?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2025 01:33:15.9627 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c4daf3fc-c861-49ef-ac10-08ddf6535720
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN3PR12MB9569
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

