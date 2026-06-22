Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E23FCCDB466
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Jun 2026 19:57:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5904C10E812;
	Mon, 22 Jun 2026 19:57:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="cZuE+3JN";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010033.outbound.protection.outlook.com [52.101.56.33])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AF5A010E812
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Jun 2026 19:57:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NTmUrFcuRq5e7eN16EHkNBizowBOOUGAy9uBVXE10PjOSbCBIbWqLrTWCH5xvalhDUihLwN+d3SUMKXpEltjIQWum4hmb2AD3vMFHW/FGTNvKwA8H7TRhZq6h6y0T0Q3DJKCCjI5bvBrxXC1QPXjj4ONgRP0wsHKcYWmxGj7udG9QSnOEwzVd6j5OTmETkv2kQ9ch5xGii8tBu3jZkazf/TC4+35dYJkNeXSkKUpI0qzFN7qRWk07VV9/QDYA98b3Ni0KvU6k0ePW12VJU9HMfl41aNNFuXVBHXTzIG9ee2IITxTN1ASOOGL2ed4cvhXSJrX34DMhCK3Q5qQy3nQTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qcsONZU57DMWppJwxfR18uy7x0nr0ocqfuhtnonGc70=;
 b=nhFA8huiSaHaJfcchBlg20lEns/AOxiTkXTsscNEyTeJci8TmAQgBg9gaFWGswAgePoBnoiJmNlD/RU07rvVFTuJI3GmLb4bf9ZNKVURvfKa3mhUbh8YqL/wWhAaoWzXAZMaEaPVvme3fZJ5aEcTB4agSu8v2XZdQMI1++HtCLVzArMY712TPYCK8taDUbSf2lFKi3vsLFntDpzmHbnsuyJ3NfmyBktGwkvBSJ1GBbWRW7ClV1zP9RMBwiqs9pYjVIf+ic8+xvQP3Xdjcj+BsMpl7i5Es1S64zdPUbrRgC0DCiuX2ZPzw0lmECK5g0JrheNayfzXRwP9KdbxIic9kQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qcsONZU57DMWppJwxfR18uy7x0nr0ocqfuhtnonGc70=;
 b=cZuE+3JNgJgGRMChWmfTSNM1o0YuZRFUXn/9c8AIPv+3txqkZg3FHu6KDRrl9KARx9vGPkOYpt9Snwws4nBlVNXD/kyTDnLXK4RAuRRwMDLjC9EQqKWsW+Sq2uAkqoT1KVouucAi4y+mggpJ8dsaLjthKCFvZf1KUyjsgcO1w2I=
Received: from PH1PEPF000132F0.NAMP220.PROD.OUTLOOK.COM (2603:10b6:518:1::33)
 by PH0PR12MB999113.namprd12.prod.outlook.com (2603:10b6:510:38f::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.18; Mon, 22 Jun
 2026 19:57:44 +0000
Received: from CY4PEPF0000FCC3.namprd03.prod.outlook.com
 (2a01:111:f403:f910::1) by PH1PEPF000132F0.outlook.office365.com
 (2603:1036:903:47::3) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.13 via Frontend Transport; Mon,
 22 Jun 2026 19:57:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000FCC3.mail.protection.outlook.com (10.167.242.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.139.8 via Frontend Transport; Mon, 22 Jun 2026 19:57:44 +0000
Received: from amd-desktop.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 22 Jun
 2026 14:57:43 -0500
From: Shahyan Soltani <shahyan.soltani@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <alexander.deucher@amd.com>, <christian.koenig@amd.com>
Subject: [PATCH v3 2/8] drm/amdgpu: move struct amdgpu_uid and helpers into
 separate files
Date: Mon, 22 Jun 2026 15:57:23 -0400
Message-ID: <20260622195729.181216-3-shahyan.soltani@amd.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260622195729.181216-1-shahyan.soltani@amd.com>
References: <20260622195729.181216-1-shahyan.soltani@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC3:EE_|PH0PR12MB999113:EE_
X-MS-Office365-Filtering-Correlation-Id: 45138a91-c52c-48e3-4336-08ded0988685
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700016|1800799024|23010399003|22082099003|18002099003|56012099006|11063799006|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info: d2E7mnWdmJsD7o1tiR7jthtk001e0edB1Pj/LaHTp5yeOE/7pqkUNgEAMGmEugCDtIY3HrrAushr/l7ogG+ZbEiwiaybYezHDOUfM2HVKqqu6dRncvBXUotTvkY8YG7FmEzt4SJgXyFHXKEMWkFdrkNzq+c44cuEiIGuk84h6JBJ38iK2id3Ucb0p93CXvanXfpkpwrx/X14aBSauq1ouTEwvjbQuE4b05DGhjvt6wy+UPTqs2x+t1BlMtkToE62BFk5i8SbTSTtWOdNNlCdjR1gLRh55db7XXE0SbU9ooRNcCfQcXy8yyd2h17XyfPaTaa3ouZ7suC81vPBAlf8UN7cyUixXp77CwfBdUfhjUoXZTxxylLiQAr8t0P/Hmu8E4SCLC/jDJ3N3sbCNw/B/TJPWxPuOMKHBBf/msQQNdZO4t737dJGsdbVK6e6f4p2xHB6UilkCbsIEn6UlAiWhLzpl5lVD2D01QmTU4fgRKDNr8iDpKg89wVUd9BBae4s4j4I/5/uoaj5iPD4OG41Q/H2wjTu5kzSC7AuozTFenKIGq412ha5lU/aBdRzuc65xsneC5CiVJlrXUx8IVhYDnaVnbwISem6laSwBl/GYJgxucMORWZedo7JeJPs4U+8QQrC0afRArYgQmR/gSHPn3insqYmBGJfp5yxAYXcaJ8NNdH0OAXoqA0qy7iVf/WvYmAo82/q4X6IIsM+NI6eRg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700016)(1800799024)(23010399003)(22082099003)(18002099003)(56012099006)(11063799006)(6133799003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: RYOcNrbP1iU55BxZKW1A6z+p91AQzC4Z2pkBKyED6exux4m/R3aXBOSJ9mkW7Itmhm0PCar8NYpG8ZDo2M2LkMgtUNyC6NinE627N2xRqp2wZbAn2U4E0r5glix+qChXXsN8fCvfGHr8RsXnzvyQwXNckaM3WwN3f+pY4mWPRxrr8WhfKSGnQdy2nQOYUM4lEUE863vMCMe595bGbjXF9kUioIIealnc3GdrLkC1Skly8kduDl8QyL8V5Nqp9hfyMurqklkJL483Wbw4b3Yil4YvYfqx73cIONiTyXl2wLTzbDdZjNGtm5ut5QazEI7LznrwEF2HX+i0QBvB6Vvw6a1NWdVPI1g3QqrSJzOFIm+/knNFlgco1HeWxQA8gce6cfRIerMMMClf1ouGORkeRhrGBKlpqxTphM0LFASfgcFOOg7kNwFvzNENBo2mTVyy
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2026 19:57:44.2791 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 45138a91-c52c-48e3-4336-08ded0988685
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000FCC3.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB999113
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

Move struct amdgpu_uid and helpers from the monolithic amdgpu.h file into a new amdgpu_uid.h file.

Move functions amdgpu_device_set_uid() and amdgpu_device_get_uid() out of
amdgpu_device.c into new dedicated amdgpu_uid.c file.

Update amdgpu/Makefile to build amdgpu_uid.o

This is part of the ongoing effort to reduce the size of amdgpu.h into their own respective
separate headers.

Signed-off-by: Shahyan Soltani <shahyan.soltani@amd.com>

---
This patch and patch 7 can be dropped if moving amdgpu_uid out of 
amdgpu.h is not desirable.
---
 drivers/gpu/drm/amd/amdgpu/Makefile        |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu.h        | 22 +------
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 50 ---------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_uid.c    | 75 ++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_uid.h    | 50 +++++++++++++++
 5 files changed, 127 insertions(+), 72 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_uid.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_uid.h

diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile b/drivers/gpu/drm/amd/amdgpu/Makefile
index 10dc7cfd607e..ab5fdbb5e4b4 100644
--- a/drivers/gpu/drm/amd/amdgpu/Makefile
+++ b/drivers/gpu/drm/amd/amdgpu/Makefile
@@ -72,7 +72,7 @@ amdgpu-y += amdgpu_device.o amdgpu_reg_access.o amdgpu_doorbell_mgr.o amdgpu_kms
 	amdgpu_eeprom.o amdgpu_mca.o amdgpu_psp_ta.o amdgpu_lsdma.o amdgpu_lockdep.o \
 	amdgpu_ring_mux.o amdgpu_xcp.o amdgpu_seq64.o amdgpu_aca.o amdgpu_dev_coredump.o \
 	amdgpu_cper.o amdgpu_userq_fence.o amdgpu_eviction_fence.o amdgpu_ip.o \
-	amdgpu_wb.o
+	amdgpu_wb.o amdgpu_uid.o
 
 amdgpu-$(CONFIG_PROC_FS) += amdgpu_fdinfo.o
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 4ffcc0cc6404..fe951a901d20 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -116,6 +116,7 @@
 #include "amdgpu_wb.h"
 #include "amdgpu_ip.h"
 #include "amdgpu_sa.h"
+#include "amdgpu_uid.h"
 #if defined(CONFIG_DRM_AMD_ISP)
 #include "amdgpu_isp.h"
 #endif
@@ -551,21 +552,6 @@ struct amdgpu_mmio_remap {
 	struct amdgpu_bo *bo;
 };
 
-enum amdgpu_uid_type {
-	AMDGPU_UID_TYPE_XCD,
-	AMDGPU_UID_TYPE_AID,
-	AMDGPU_UID_TYPE_SOC,
-	AMDGPU_UID_TYPE_MID,
-	AMDGPU_UID_TYPE_MAX
-};
-
-#define AMDGPU_UID_INST_MAX 8 /* max number of instances for each UID type */
-
-struct amdgpu_uid {
-	uint64_t uid[AMDGPU_UID_TYPE_MAX][AMDGPU_UID_INST_MAX];
-	struct amdgpu_device *adev;
-};
-
 #define MAX_UMA_OPTION_NAME	28
 #define MAX_UMA_OPTION_ENTRIES	19
 
@@ -1530,10 +1516,4 @@ static inline int amdgpu_device_bus_status_check(struct amdgpu_device *adev)
 
        return 0;
 }
-
-void amdgpu_device_set_uid(struct amdgpu_uid *uid_info,
-			   enum amdgpu_uid_type type, uint8_t inst,
-			   uint64_t uid);
-uint64_t amdgpu_device_get_uid(struct amdgpu_uid *uid_info,
-			       enum amdgpu_uid_type type, uint8_t inst);
 #endif
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index d6931e1184d0..8d55658ecb31 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -6717,53 +6717,3 @@ ssize_t amdgpu_show_reset_mask(char *buf, uint32_t supported_reset)
 	size += sysfs_emit_at(buf, size, "\n");
 	return size;
 }
-
-void amdgpu_device_set_uid(struct amdgpu_uid *uid_info,
-			   enum amdgpu_uid_type type, uint8_t inst,
-			   uint64_t uid)
-{
-	if (!uid_info)
-		return;
-
-	if (type >= AMDGPU_UID_TYPE_MAX) {
-		dev_err_once(uid_info->adev->dev, "Invalid UID type %d\n",
-			     type);
-		return;
-	}
-
-	if (inst >= AMDGPU_UID_INST_MAX) {
-		dev_err_once(uid_info->adev->dev, "Invalid UID instance %d\n",
-			     inst);
-		return;
-	}
-
-	if (uid_info->uid[type][inst] != 0) {
-		dev_warn_once(
-			uid_info->adev->dev,
-			"Overwriting existing UID %llu for type %d instance %d\n",
-			uid_info->uid[type][inst], type, inst);
-	}
-
-	uid_info->uid[type][inst] = uid;
-}
-
-u64 amdgpu_device_get_uid(struct amdgpu_uid *uid_info,
-			  enum amdgpu_uid_type type, uint8_t inst)
-{
-	if (!uid_info)
-		return 0;
-
-	if (type >= AMDGPU_UID_TYPE_MAX) {
-		dev_err_once(uid_info->adev->dev, "Invalid UID type %d\n",
-			     type);
-		return 0;
-	}
-
-	if (inst >= AMDGPU_UID_INST_MAX) {
-		dev_err_once(uid_info->adev->dev, "Invalid UID instance %d\n",
-			     inst);
-		return 0;
-	}
-
-	return uid_info->uid[type][inst];
-}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_uid.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_uid.c
new file mode 100644
index 000000000000..6cf6b3f12271
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_uid.c
@@ -0,0 +1,75 @@
+// SPDX-License-Identifier: GPL-2.0 OR MIT
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
+ */
+#include "amdgpu_uid.h"
+#include <linux/dev_printk.h>
+#include "amdgpu.h"
+
+void amdgpu_device_set_uid(struct amdgpu_uid *uid_info,
+			   enum amdgpu_uid_type type, uint8_t inst,
+			   uint64_t uid)
+{
+	if (!uid_info)
+		return;
+
+	if (type >= AMDGPU_UID_TYPE_MAX) {
+		dev_err_once(uid_info->adev->dev, "Invalid UID type %d\n",
+			     type);
+		return;
+	}
+
+	if (inst >= AMDGPU_UID_INST_MAX) {
+		dev_err_once(uid_info->adev->dev, "Invalid UID instance %d\n",
+			     inst);
+		return;
+	}
+
+	if (uid_info->uid[type][inst] != 0) {
+		dev_warn_once(
+			uid_info->adev->dev,
+			"Overwriting existing UID %llu for type %d instance %d\n",
+			uid_info->uid[type][inst], type, inst);
+	}
+
+	uid_info->uid[type][inst] = uid;
+}
+
+u64 amdgpu_device_get_uid(struct amdgpu_uid *uid_info,
+			  enum amdgpu_uid_type type, uint8_t inst)
+{
+	if (!uid_info)
+		return 0;
+
+	if (type >= AMDGPU_UID_TYPE_MAX) {
+		dev_err_once(uid_info->adev->dev, "Invalid UID type %d\n",
+			     type);
+		return 0;
+	}
+
+	if (inst >= AMDGPU_UID_INST_MAX) {
+		dev_err_once(uid_info->adev->dev, "Invalid UID instance %d\n",
+			     inst);
+		return 0;
+	}
+
+	return uid_info->uid[type][inst];
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_uid.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_uid.h
new file mode 100644
index 000000000000..d92ddcce9f58
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_uid.h
@@ -0,0 +1,50 @@
+/* SPDX-License-Identifier: GPL-2.0 OR MIT
+ *
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
+ */
+#ifndef __AMDGPU_UID_H__
+#define __AMDGPU_UID_H__
+
+#include <linux/types.h>
+
+#define AMDGPU_UID_INST_MAX 8 /* max number of instances for each UID type */
+
+struct amdgpu_device;
+
+enum amdgpu_uid_type {
+	AMDGPU_UID_TYPE_XCD,
+	AMDGPU_UID_TYPE_AID,
+	AMDGPU_UID_TYPE_SOC,
+	AMDGPU_UID_TYPE_MID,
+	AMDGPU_UID_TYPE_MAX
+};
+
+struct amdgpu_uid {
+	uint64_t uid[AMDGPU_UID_TYPE_MAX][AMDGPU_UID_INST_MAX];
+	struct amdgpu_device *adev;
+};
+
+void amdgpu_device_set_uid(struct amdgpu_uid *uid_info,
+			   enum amdgpu_uid_type type, uint8_t inst,
+			   uint64_t uid);
+uint64_t amdgpu_device_get_uid(struct amdgpu_uid *uid_info,
+			       enum amdgpu_uid_type type, uint8_t inst);
+#endif
-- 
2.54.0

