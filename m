Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7F11CD8CAB
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Jun 2026 19:48:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7292E10F953;
	Mon,  8 Jun 2026 19:48:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="3GidkQVR";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010067.outbound.protection.outlook.com
 [40.93.198.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6FF9210F961
 for <amd-gfx@lists.freedesktop.org>; Mon,  8 Jun 2026 19:48:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hGZKJqRD1hTT0OUBfmlpT3Ri0wa0PEbhtLNB4K52TbEVeUosX+X/rmc5oHCqzydHZWkcadm7AmliHBxdsRmIJG110K0KBLVmT6xuoyvG4ZBbwV5JHFyxrbHGtLl/+OUoWDHqheyId6EMjvnoyeBrkjaCAZV76p07nsUY3bRUZMezpkyFJsFDHztU1ikHNDm2HQXCWZiSmeQHXTxZADOVmOfp3yi5UCrjNVIRcKsNKh6shGW9YbUEDcTiUqa6mx9b3V30Lxd0gq2x/cocdKSXGcRZIduaaJlArz/TVnSLTR5jI+eFzrTCRC0r+NN1KCx8au4z+xRwibWE7JjllrvLcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qkZEzTthDrHIlHSx2uXLBNxewWdwQ3voPn+wG3mIxqM=;
 b=HDBFebXl2j+yJW939EbT3y5Z8eyj3I48Nwxmd7yeHbJhoPDkUDF4XNZuvjSbF9aWiDqhfMVWTHPsQLRqHWH1gXQUfCPWy1qqqDeq4LcvM2l8ZK070O+E3sHKnrB/6IvAFvEqirxQEKWnOFDT0W05KQDG4YpaAvCehLNf3xs+jnQGdBrh7+FOX5hwAbA4NPrmp88yDvnoG1BENJrVPMPVTRVu5UTbGph8b5Ed90v7wov52AQjBp7m4cFKjG70rtj7K6HtrxuyIUe043m9T0WBNOsESyhSCE1g1OWjQH5HtHA4eSf9sK65QtV8mQzqmHnxlkx1bDdLFifMqg1egg+OJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qkZEzTthDrHIlHSx2uXLBNxewWdwQ3voPn+wG3mIxqM=;
 b=3GidkQVR3G46J/oQL1Sw4Dyzs+gSn6yw5bnnzMaDA/kF5fZgG+pZKEN/0mjT0GksY/R8d5eYhTRlpGCXdPG5JlXbmokJ/ifPXJfl2YB0hKepGEn/WyWVpNuNcAeDmjYzzrzq6pDvyh8+2gGYZvDCebxzOT6kh8FlEvNjFmAuxJI=
Received: from PH8PR05CA0020.namprd05.prod.outlook.com (2603:10b6:510:2cc::27)
 by CH3PR12MB7569.namprd12.prod.outlook.com (2603:10b6:610:146::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.13; Mon, 8 Jun 2026
 19:48:04 +0000
Received: from SA2PEPF00003F65.namprd04.prod.outlook.com
 (2603:10b6:510:2cc:cafe::51) by PH8PR05CA0020.outlook.office365.com
 (2603:10b6:510:2cc::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.9 via Frontend Transport; Mon, 8
 Jun 2026 19:48:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SA2PEPF00003F65.mail.protection.outlook.com (10.167.248.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.7 via Frontend Transport; Mon, 8 Jun 2026 19:48:03 +0000
Received: from amd-desktop.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 8 Jun
 2026 14:48:01 -0500
From: Shahyan Soltani <shahyan.soltani@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alexander Deucher <alexander.deucher@amd.com>, Christian Koenig
 <christian.koenig@amd.com>, Shahyan Soltani <shahyan.soltani@amd.com>
Subject: [PATCH v2 03/11] drm/amdgpu: move struct amdgpu_uid and helpers into
 separate files
Date: Mon, 8 Jun 2026 15:47:33 -0400
Message-ID: <20260608194741.1590055-4-shahyan.soltani@amd.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260608194741.1590055-1-shahyan.soltani@amd.com>
References: <20260608194741.1590055-1-shahyan.soltani@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F65:EE_|CH3PR12MB7569:EE_
X-MS-Office365-Filtering-Correlation-Id: ccb9db81-3d74-46e6-7966-08dec596da76
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|82310400026|1800799024|11063799006|56012099006|6133799003|18002099003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info: XFM14DS5giF29cZiK2AlqVrcfILO6TB1+bnBMDFYhds4e2ezZniZ6dlwgd6GdEckfG4+jjDQ33fBktsh5voh2mxF0SmU3StqrNPUW5MI34FfV2ntcGojQdkMK2HOwqGI2GAQ0AkzszE8e8MkonJoCGdwYfzIJa0XZ4cT/pR+VqiHRDUK/OEubFq7XOkI60jpQCVp2WS6/W9PUJg01tEfnqbKkRQwHG+HTf0HgzrTVJbyxg/jhPEq1HHeGIm6ahcPgqh0Js/Gv4QtAAb+yXsQy5x4RoNybWK65YK96Xt5bIx9Yq5rfQRH+d04ZHoNOn5zEWbagpX22Db6JUkxdRxqCO/giJRZ7WH8NloqX9pUHeHos0SNSbSH4ACq0wIe4n8jT9KYFOSXQaA2+LrUilZ1d9r01CcRhn45AMI4574pHSAJ9+yQZ1/6iQHX3HHebdubLNojCxLYiGgsZ6vS7qqvaBKEBEBmRRULm59z8527k71IhNSytgrdebR+ieezF80kEnyZ1e/9OSsb5NlZ+c3qTNN25+8jK5zHubal+SYA8OXhpOTOtdGjaLUubQ0ezp/qApUBjGHD3To/YQhgee8JCcGduR6OnFGNb9ZmRivh6KIC64jz0JHCJshBvk2br00ANHCtWeji67poN4ykkamCmJ+TT3Bm3kuO+ZEyZ0vrlX9HR9mpccSYjF+/AjCxYc6+op0vJSMXuuy/Zo+exaIa09C9PLBEbb9knXHEi+mjwhM=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(82310400026)(1800799024)(11063799006)(56012099006)(6133799003)(18002099003)(22082099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ACSCFkS3lnRj5/TV106dt36QJT+ylhjKV0e8QB09mlaoDzSCJGFr9ZJPCePQ2UXKRPjkg6XcFvmx1VYZBTtVZDaaoLfSI6h0HhksyPD3J47A4jjAQtEAzh1e8vMcN1ruUx/ILu+zMHliwjFwEVEUhFw/rJ20fBQSJMpfWPYYfUMcdjCPDxOuG5kyLrzBBq1QgJGnqSIgMFuDrunC7cHKJk+BjzUknGETf+QR199s6gLxx4Rq9Ce7ZaUrIQne8ec1x+Hg/+c8woIb4/m2SxabYPAo/VWEZFeQaifKIB704cto6z2U26zL1LUs0obkel1tWOqlqqUR1Dsl4YE08CoRnPd5esghpeZa5s+NpIg18HZYpjt7GCsFqJaUW2BdyHQrOELHSPNQ6ALAFuZmmRCbv8nbNp5dnHDksuQTDRgtr/VX3oxM+kVgumIQVtOBLCWp
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2026 19:48:03.3498 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ccb9db81-3d74-46e6-7966-08dec596da76
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003F65.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7569
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
 drivers/gpu/drm/amd/amdgpu/Makefile        |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu.h        | 22 +------
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 50 ---------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_uid.c    | 75 ++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_uid.h    | 50 +++++++++++++++
 5 files changed, 127 insertions(+), 72 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_uid.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_uid.h

diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile b/drivers/gpu/drm/amd/amdgpu/Makefile
index e6deb24f73bb..415e73e0a1af 100644
--- a/drivers/gpu/drm/amd/amdgpu/Makefile
+++ b/drivers/gpu/drm/amd/amdgpu/Makefile
@@ -72,7 +72,7 @@ amdgpu-y += amdgpu_device.o amdgpu_reg_access.o amdgpu_doorbell_mgr.o amdgpu_kms
 	amdgpu_eeprom.o amdgpu_mca.o amdgpu_psp_ta.o amdgpu_lsdma.o \
 	amdgpu_ring_mux.o amdgpu_xcp.o amdgpu_seq64.o amdgpu_aca.o amdgpu_dev_coredump.o \
 	amdgpu_cper.o amdgpu_userq_fence.o amdgpu_eviction_fence.o amdgpu_ip.o \
-	amdgpu_wb.o
+	amdgpu_wb.o amdgpu_uid.o
 
 amdgpu-$(CONFIG_PROC_FS) += amdgpu_fdinfo.o
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 9a714b4b59bc..0f8743254fe6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -114,6 +114,7 @@
 #include "amdgpu_sa.h"
 #include "amdgpu_wb.h"
 #include "amdgpu_ip.h"
+#include "amdgpu_uid.h"
 #if defined(CONFIG_DRM_AMD_ISP)
 #include "amdgpu_isp.h"
 #endif
@@ -553,21 +554,6 @@ struct amdgpu_mmio_remap {
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
index 15a6a9010fc8..602e7eb1cc5c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -6872,53 +6872,3 @@ ssize_t amdgpu_show_reset_mask(char *buf, uint32_t supported_reset)
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
index 000000000000..9b81e8198a73
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

