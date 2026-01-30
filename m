Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE660D73EB4
	for <amd-gfx@archiver.kernel.org>; Fri, 30 Jan 2026 02:30:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6175810E1FE;
	Fri, 30 Jan 2026 02:30:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="FRUMTQLu";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011028.outbound.protection.outlook.com [52.101.52.28])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4B3D610E1FE
 for <amd-gfx@lists.freedesktop.org>; Fri, 30 Jan 2026 02:30:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kIkxI9kuf9ABDmsS2zUXcwjVbPK1zbstNVj+l0l5cdP9ImOaPMOeUVZhVPEDN1NPfJRkRrziZOr2Js9SxaK72wBYgcelsZrrxGtmQ3ynBC+RQnlwcBGn5kT+OOoX8S+5SrgRd4tRp1+bbfUQ6AOIsCGBpgzoJOQMI+JezpATCKOruf0B07GOLesnIYyHVa8sO8lGfFpmVOw6+r2nNAnNCyJKTamSEfqvEKZssq/JB3C7rAljdGT4b1Yllgl6Y14rKiReQQxmz28AjCEsS/oC3OaIVxgPNVUqaU6r5ldDFv4ISVQ3itW5XPpkbFERNH5wT/rHNUxsIGWjgdiaCjWV0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CRZdplHEnaMIXxaTscD0PiWtFgjXuRzsP3Pqic9iuwQ=;
 b=nux5PG1qIJ6EoFcJXOyeNLNPZoUJz8YwyJHeFASgimJOeU0An3pPNFxIG8XwGPa6wiBggrBsVm+7Ct8cF6eHl8Yl88f+25V8qpbginpZWMytdaMhaIk9BGxXx3NV/tOny266J/cssKIFteqjhccDhrBDZxloeBo0E5UDdcmF2vYCU3xakl2PcwVR85PqClve4dnv7CeuFJnsmU0NAQtQfwI+fFNYPB0Vk7q1eAEJoKTtUbI2R1cbM3o7qmgXY5AJcJfg2SgqXabY63A/YsG5bpsbUo3XZmbVtCfXrdNcmNjJHPgHW1Ql6RzalTcLZfLfAhIpxHxiko0J4rMCWLmlOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CRZdplHEnaMIXxaTscD0PiWtFgjXuRzsP3Pqic9iuwQ=;
 b=FRUMTQLuWsEJ9rWsZZBT/VcsxevJsBg+M4sx/mBRcJKdwOHA41sViHl5mf67FS2DrzFOa1b2i8DaU10GR7f/jz2sjohppXSOjnjcR9dOvJkBydd8M1zWKzKOyjzyyQOzSsvkxBlyEsNGXiCH6nWg+8lej3VMlG21ziZu7dckAVY=
Received: from SJ0PR03CA0278.namprd03.prod.outlook.com (2603:10b6:a03:39e::13)
 by PH8PR12MB7422.namprd12.prod.outlook.com (2603:10b6:510:22a::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.15; Fri, 30 Jan
 2026 02:30:24 +0000
Received: from SJ1PEPF00001CDC.namprd05.prod.outlook.com
 (2603:10b6:a03:39e:cafe::64) by SJ0PR03CA0278.outlook.office365.com
 (2603:10b6:a03:39e::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.11 via Frontend Transport; Fri,
 30 Jan 2026 02:30:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00001CDC.mail.protection.outlook.com (10.167.242.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.3 via Frontend Transport; Fri, 30 Jan 2026 02:30:24 +0000
Received: from gangliang-mlse-vm.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 29 Jan 2026 20:30:22 -0600
From: Gangliang Xie <ganglxie@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <tao.zhou1@amd.com>, <YiPeng.Chai@amd.com>, <KevinYang.Wang@amd.com>,
 Gangliang Xie <ganglxie@amd.com>
Subject: [PATCH 04/14] drm/amd/ras: add uniras smu feature flag init func
Date: Fri, 30 Jan 2026 10:29:40 +0800
Message-ID: <20260130022950.1160058-4-ganglxie@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260130022950.1160058-1-ganglxie@amd.com>
References: <20260130022950.1160058-1-ganglxie@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CDC:EE_|PH8PR12MB7422:EE_
X-MS-Office365-Filtering-Correlation-Id: ed3dfe47-ff39-4a23-58b7-08de5fa785f5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?WaXhDlEICnWdsuaYnVlAsuKDwftWckvF5kPdhtHArSoRI8u1eyvwzkJMilU0?=
 =?us-ascii?Q?NWYYLwOZRAcYvS1iI+8Soj0a/WBNUb/8Xf1rdOLVQpWTEXhege+7z6nXbPdT?=
 =?us-ascii?Q?kuRjHKOiJ+bVsaw5uYj8pKlD7UZuHbH/zDIJXY0TFE6p4+mHTwYfEnnoW3wt?=
 =?us-ascii?Q?gCVVAT+DIPwPvOT+rTwguyEOEvt32LffKQQ5SeqBFhk+W1c+NgNH45sEOLOu?=
 =?us-ascii?Q?RxmionJvZFZ9+lw4wxzmCv5TkLpY3rbS10XfZ/0L5cxJ1HpBHZyMEPvKHH7t?=
 =?us-ascii?Q?VaxuN1ekLVmat3wsJq46geOrSZr8frDO01Oa0mTHbj2B1WBIRZR/kWSmF1Gp?=
 =?us-ascii?Q?LAzdl3hcdiEW1FznOrFpg2C6dTM0KgOh9svl8QLdZgH55A1VErjj3N9JUePt?=
 =?us-ascii?Q?xVBe3qnwKBQc9dmBor4RW9JAtPXGMGs2fmg+mUGJ9KOjn2wPCQJFFMhUTsz1?=
 =?us-ascii?Q?w52Rnp40I0nsZaGQa60TZq5E26Z4NBvmGwiYg0VvSpErO9jgr44pb/v8aoOa?=
 =?us-ascii?Q?AxgNViCeZUzGNbtqDd1xhETE3HraHeVpRObSeOSjVbjD5nIzCpzjfBDtxX33?=
 =?us-ascii?Q?CCTiDsJBwDv7oY2yAWEsXOeXuYE9Uu+7KxkFRakYTVt2sBtPNpe9fd5aPUjD?=
 =?us-ascii?Q?fJiShL9VvN/TNx0nN4iN+utKlwHRhAkbm/TI2iPY0N/EQSLxTiTZQDVYJCDj?=
 =?us-ascii?Q?BRviASqSoI2xr5ciPzcniUJKpH6M99OIfU90Tmn+LZY69N89u+8vBZq7Qmce?=
 =?us-ascii?Q?f1XOwoZ86Z+EHFmTEcsgFAr7HaQYyK4l3N14juWkisV/rTwq9fb1EV1nZc9v?=
 =?us-ascii?Q?rnXHcokdMuxlrSyCGiMCgeMP1F1xXJhXfkLznEtwAcILLBHiHhcjt13AXSVj?=
 =?us-ascii?Q?i5VbCLBY4H17xDXAyxluIa9FfvJ7OlsYfXDgM2Z492BEJpoKtYY3ypx9nBNk?=
 =?us-ascii?Q?XMEbSmFYK+WMhY1DlbRIgi+KQ9ySQOXwwxCifHE4ONyltccPWDbBnzIPzGoF?=
 =?us-ascii?Q?YNI5o7p8dgl+7Xd8eHRBdSjfUJvsH/bnjO/Q0rP3PK5aWCuDlby71zPJwivt?=
 =?us-ascii?Q?DceXKDBA5M/NlqefbY1r07c6rmXftsGGvyrtOUZSAzEuFQSSxD0YFHBDSgkg?=
 =?us-ascii?Q?4x6fAjWbGboQC5UyJfkzTqw9rC+pvYWPzm0f9ejcaYQmyFDDmzOJRHCquB/z?=
 =?us-ascii?Q?yF9sBWNGO6hw1n7motFq1gMBT7vcuU+ZlQST/Z0kbXOmjLP15qQfzMFuFO2T?=
 =?us-ascii?Q?6ANESkiGwWC2VPs2PVbRDB4qqTFswSTNvBGk2Q1MoHBXVZWk67/h2HdT/jv6?=
 =?us-ascii?Q?oFAHJAQe8u+ZF8yL6g4y3LHrNZiFpROXoFGt+cCrFmjf/s8cXytjjIgN4NtN?=
 =?us-ascii?Q?rg42+S4e6uE8tqU9Etztic5V1GhGTLVYBZd7dLM/tgbO7BCUpMIXijPk/6st?=
 =?us-ascii?Q?FsMyhmlbvayOiIXpNroxQ+Cu6AfGZn9OWUgPSzC/IxdX+13LPj6QE44WUz28?=
 =?us-ascii?Q?ih6rJAcF8ig5ohrg3y6OFlOU4iO8UL3N3R+P7Dy/T95slnDaPSPTD4ojhkEz?=
 =?us-ascii?Q?PX0m8za0yrURg0QH3RZi37yOp9qbzDReHaiymkTFluieZfdU+5GZtu/8R4F6?=
 =?us-ascii?Q?vBFI43cb3MSjCGb9pOIK8W5G4+G43h4lpxHssducN56fV1KP9f3nu0N25oEH?=
 =?us-ascii?Q?6fLvlQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: QYpYysyYXsM5Rj7vkAM7kDiZuBFBDk90V3Io6gb0r9WSbPru/O+jJ7FI4KA49e+TBcpjKl9kHAwNvBro4MQsmnW2t8LRmamCuqnnZvkzv0OdeYK9tsAbJJci6JwSckLVbTnP0e4YyOb10gJWeBCnigDn/7/VclcAdHTOUCQLBtKULr06c+d5CMMJEqeeebQVbaENA/kY9Wxp2mDkNO05QqvKB9GxQxFNoScEQnT3uqZvaYpYaKowrHO4hz63BryfrozCbUyL0frVR5XjWDH3EXiDZ3Mh748B9N2eclFhJ6iuRJ2FBgz6swPF+5LelikHpKwTcosolDmUbHR8Kv95vhtB3AEfZ8dfmqqtgyG74vnR1d4bp/co6KSzQ+6ZvHJ5N9dguJcXeBEZft8WV4m+a9zHCsRkhio6Hkyj6ruK50KYCndQul5EANHTUVrDVSc3
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2026 02:30:24.3727 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ed3dfe47-ff39-4a23-58b7-08de5fa785f5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CDC.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7422
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

add flag to indicate if pmfw eeprom is supported or
not, and initialize it

Signed-off-by: Gangliang Xie <ganglxie@amd.com>
---
 drivers/gpu/drm/amd/ras/rascore/Makefile      |  3 +-
 drivers/gpu/drm/amd/ras/rascore/ras.h         |  3 ++
 drivers/gpu/drm/amd/ras/rascore/ras_core.c    |  2 +
 .../gpu/drm/amd/ras/rascore/ras_eeprom_fw.c   | 38 +++++++++++++++++++
 .../gpu/drm/amd/ras/rascore/ras_eeprom_fw.h   | 29 ++++++++++++++
 5 files changed, 74 insertions(+), 1 deletion(-)
 create mode 100644 drivers/gpu/drm/amd/ras/rascore/ras_eeprom_fw.c
 create mode 100644 drivers/gpu/drm/amd/ras/rascore/ras_eeprom_fw.h

diff --git a/drivers/gpu/drm/amd/ras/rascore/Makefile b/drivers/gpu/drm/amd/ras/rascore/Makefile
index e826a1f86424..06b265ec1cde 100644
--- a/drivers/gpu/drm/amd/ras/rascore/Makefile
+++ b/drivers/gpu/drm/amd/ras/rascore/Makefile
@@ -36,7 +36,8 @@ RAS_CORE_FILES = ras_core.o \
 			ras_log_ring.o \
 			ras_cper.o \
 			ras_psp.o \
-			ras_psp_v13_0.o
+			ras_psp_v13_0.o \
+			ras_eeprom_fw.o
 
 
 RAS_CORE = $(addprefix $(AMD_GPU_RAS_PATH)/rascore/,$(RAS_CORE_FILES))
diff --git a/drivers/gpu/drm/amd/ras/rascore/ras.h b/drivers/gpu/drm/amd/ras/rascore/ras.h
index 2db838c444f1..6e223eff522c 100644
--- a/drivers/gpu/drm/amd/ras/rascore/ras.h
+++ b/drivers/gpu/drm/amd/ras/rascore/ras.h
@@ -36,6 +36,7 @@
 #include "ras_mp1.h"
 #include "ras_psp.h"
 #include "ras_log_ring.h"
+#include "ras_eeprom_fw.h"
 
 #define RAS_HW_ERR		"[Hardware Error]: "
 
@@ -335,6 +336,8 @@ struct ras_core_context {
 	spinlock_t seqno_lock;
 
 	bool ras_core_enabled;
+
+	u64 ras_fw_features;
 };
 
 struct ras_core_context *ras_core_create(struct ras_core_config *init_config);
diff --git a/drivers/gpu/drm/amd/ras/rascore/ras_core.c b/drivers/gpu/drm/amd/ras/rascore/ras_core.c
index 01122b55c98a..91c883f16ae5 100644
--- a/drivers/gpu/drm/amd/ras/rascore/ras_core.c
+++ b/drivers/gpu/drm/amd/ras/rascore/ras_core.c
@@ -382,6 +382,8 @@ int ras_core_hw_init(struct ras_core_context *ras_core)
 	if (ret)
 		goto init_err5;
 
+	ras_fw_init_feature_flags(ras_core);
+
 	ret = ras_eeprom_hw_init(ras_core);
 	if (ret)
 		goto init_err6;
diff --git a/drivers/gpu/drm/amd/ras/rascore/ras_eeprom_fw.c b/drivers/gpu/drm/amd/ras/rascore/ras_eeprom_fw.c
new file mode 100644
index 000000000000..e94c368c3159
--- /dev/null
+++ b/drivers/gpu/drm/amd/ras/rascore/ras_eeprom_fw.c
@@ -0,0 +1,38 @@
+// SPDX-License-Identifier: MIT
+/*
+ * Copyright 2026 Advanced Micro Devices, Inc.
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
+
+#include "ras.h"
+
+void ras_fw_init_feature_flags(struct ras_core_context *ras_core)
+{
+	struct ras_mp1 *mp1 = &ras_core->ras_mp1;
+	const struct ras_mp1_sys_func *sys_func = mp1->sys_func;
+	uint64_t flags = 0ULL;
+
+	if (!sys_func || !sys_func->mp1_get_ras_enabled_mask)
+		return;
+
+	if (!sys_func->mp1_get_ras_enabled_mask(ras_core, &flags))
+		ras_core->ras_fw_features = flags;
+}
diff --git a/drivers/gpu/drm/amd/ras/rascore/ras_eeprom_fw.h b/drivers/gpu/drm/amd/ras/rascore/ras_eeprom_fw.h
new file mode 100644
index 000000000000..b41665467368
--- /dev/null
+++ b/drivers/gpu/drm/amd/ras/rascore/ras_eeprom_fw.h
@@ -0,0 +1,29 @@
+/* SPDX-License-Identifier: MIT */
+/*
+ * Copyright 2026 Advanced Micro Devices, Inc.
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
+#ifndef __RAS_EEPROM_FW_H__
+#define __RAS_EEPROM_FW_H__
+
+void ras_fw_init_feature_flags(struct ras_core_context *ras_core);
+
+#endif
-- 
2.34.1

