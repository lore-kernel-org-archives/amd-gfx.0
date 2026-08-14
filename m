Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41FCAC5DF76
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Aug 2026 21:03:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3A70110F726;
	Fri, 14 Aug 2026 21:03:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="4BWnGs9W";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011019.outbound.protection.outlook.com [40.107.208.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E128B10F718
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Aug 2026 21:03:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p+zFh9exU2khP1OvdKVbNbdD7tR+U5B+0vgB28aWWnd2TvSFV/1jLTvI1ot0YwPwbTsSdQnM4h9YmI37fwh4mmgK/or317KidnXU9hYrkk6KYqjJVEEkH7QVS+nNy0fkrbTiFOFfHwwWBzBds1PB4cs3KzY9MKet6Co2+oFtrGhJACM211846+n2WKYdvGTvciOeYSIRy9St/pf1LSjVJ2Wq1vBiap2REibbT84+715/t2JKERPN6JqD4GoGtQILGrvv9RUG1enXz5wWvbkLnUAcoNTTY6cq7fhZvNMGirHP6hIlxUTL8r1q4//4+25ukurde/Y2DsrpE7B/orH76w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mdrpaPXWAC4qobrG8LGsnKUzdmkC9sDkVrXPqYfwqm4=;
 b=Zg4qWQBl8GjOpjcHHxgqvCrdmam/RUsqc1kNbvHJJKGiAA3ZzGblT1n1Nm5CCDPAxNOumT9LV7ERmV8IYpHZgY1oDUizU9uzg/oTap0oE1CMssic4R7//UM49DdKYopRcMVki2Mc/hsBcLrwSVlna7STvDINxVWBECTkWMwjxVTL+PMG2Yt4JhAYTiHi8qeKcw2i1IbJ7YmomtQ5y5UNNtV46hxjPCQ6yQCxJSdEwwIA7S766viTyAB4F+bqdLfUeydu0xn+PBEjTNLBdz88pa+CwJKNwzi8A6EkkumAGV8sI/s6vwOSLYVU/BvX8ApcyuNGp3TYTC2B+lpKO8gnig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mdrpaPXWAC4qobrG8LGsnKUzdmkC9sDkVrXPqYfwqm4=;
 b=4BWnGs9WGTSFBQ4RKHCcHX6Il+54hBiHeOougSMzyJrlhl5GSCfIJPL+WQMvbGex/2TYR9lKPynuXQflBfyEyEzkscxYJ+Yma5Y/k0dcFFnZh9Pcty+ZPrtzmHwzQFMxSlLbbgxUzL8FztfSpfGbb10UUWvvMrbeQDJlh0wIytg=
Received: from DSZP220CA0002.NAMP220.PROD.OUTLOOK.COM (2603:10b6:5:280::6) by
 IA0PPF44635DB8D.namprd12.prod.outlook.com (2603:10b6:20f:fc04::bcc)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.15; Fri, 14 Aug
 2026 21:03:48 +0000
Received: from CH3PEPF00000015.namprd21.prod.outlook.com
 (2603:10b6:5:280:cafe::3f) by DSZP220CA0002.outlook.office365.com
 (2603:10b6:5:280::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.16 via Frontend Transport; Fri,
 14 Aug 2026 21:03:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH3PEPF00000015.mail.protection.outlook.com (10.167.244.120) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.0 via Frontend Transport; Fri, 14 Aug 2026 21:03:48 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 14 Aug
 2026 16:03:43 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Fri, 14 Aug 2026 16:03:42 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Xiang Liu <xiang.liu@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>,
 "Alex Deucher" <alexander.deucher@amd.com>
Subject: [PATCH 075/109] drm/amd/ras: add rascore BERT record walker
Date: Fri, 14 Aug 2026 17:02:12 -0400
Message-ID: <20260814210246.3067612-76-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260814210246.3067612-1-alexander.deucher@amd.com>
References: <20260814210246.3067612-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000015:EE_|IA0PPF44635DB8D:EE_
X-MS-Office365-Filtering-Correlation-Id: 99dca2e2-943e-4500-8b4c-08defa478926
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|36860700016|376014|1800799024|82310400026|10067099003|11063799006|56012099006|18002099003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info: rG+SkVLfNt8EFC6J1jmWdj7OgWmfuQqIZn4dLDgTGw/FDqpYY59JOAFszNNgqRlizmAp4SHhmWpKCzcq3D6BBsjpJyy1aVW+5d9XjOcAPnZop0Y0WfxGMkQaD9l/4hBkTZk025E4Nryj5f8hJCrs6Xgl4IfppmCclLrmVHRLUymBZEoXK7FxQlt9lbITJe4J+cFZWjpGfiHVhDJlK1O06h4cFn5jpsk9PK7s1sP8sKY0VnD2V+bq3UuubKBd5tIjmFij0Eivu9U/amErMF5L/tDTRdeUU81QRao3qJSSL8W3r8BLgfZORn6w78tt1JKDUe22uVRSXQTZv03VlpCSstu5N1q4hQiokrTQdAWyy7RvJ2sTiio++iOWjISwGd9n7RJlbSTt/X7zHTgmAQnodi5z0fEfnpiQ3AOw3EtHCxCBRHoNmOfil/vNFAM/5VvK3X6KIejmqsLlXgxepAbEne3OCK/lrgFbiJQBBTvnyv2ANGgnkE9bKzeMlNAU+KtENo1+f7V9uJZ2brulHTb3CnkJctXQJVScXnviItwZcOSFE6aEQSUXz8HmkfmU7H/AGlsgn3Xw2yIf7nRalbhWuGC/VVEGkeXBQEpY3xjELGtEf39ep8Lo6oN/79fBBT4HuIfcLSYjv3F5jndzsGSNljk/MqsEEpyF2BHvG71h/NQ=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(36860700016)(376014)(1800799024)(82310400026)(10067099003)(11063799006)(56012099006)(18002099003)(22082099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: XFM/AgShkJn75SSSnW7N3xDlk5kA3QFMPLOAW5u4cZUulqCe+R93alF9qbLGhMwNe6oSV+yIoa/Vy14r6CUKvNs4F2Yd2y4iNKDihmItjWq2Fqp/EKplm75XrCCZoql/AT/U5BloGrbXPYaJX8fI5CvCEe+bvldFRV9dtwNtlBehw+PLxtM3i/EPzs85d1K3gn3bHEQXmOQ3hEzgk18imJJ1BdVUq2M9OI9tc/HqgpNfDL3s58Jq0jJurgHFbCMyWGaybelRKdEAPZNvnivcwnFPlWWmsHJDiw5opT2F2EMLVZg882y3h3Jpvq2aj89Jf4+Qa+IqOv9wSgK4JYjX9VnSzt1IaU5hmng1zwMvFFAR74z5bMEKf58FE6zsuoondelVvQeAcViD6foHibUERcog2KhsdQrMHfBtb05Tf9Do54EOQWxhsH0huVk6ic+A
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2026 21:03:48.3497 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 99dca2e2-943e-4500-8b4c-08defa478926
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF00000015.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPF44635DB8D
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

From: Xiang Liu <xiang.liu@amd.com>

Add a rascore BERT record walker that validates cached BERT generic
status blocks and iterates their CPER section descriptors.

The generic APEI BERT path may have already consumed the boot error
region and cleared block_status before AMDGPU caches the payload, so do
not use block_status to decide whether cached records should be parsed.

Section-specific parsers can be added separately on top of this walker.

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Xiang Liu <xiang.liu@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/ras/core/Makefile     |  1 +
 drivers/gpu/drm/amd/ras/core/ras.h        |  3 +
 drivers/gpu/drm/amd/ras/core/ras_bert.c   | 78 +++++++++++++++++++++++
 drivers/gpu/drm/amd/ras/ras_mgr/ras_sys.h |  4 ++
 4 files changed, 86 insertions(+)
 create mode 100644 drivers/gpu/drm/amd/ras/core/ras_bert.c

diff --git a/drivers/gpu/drm/amd/ras/core/Makefile b/drivers/gpu/drm/amd/ras/core/Makefile
index def5fbb2a49e6..b2872affbf719 100644
--- a/drivers/gpu/drm/amd/ras/core/Makefile
+++ b/drivers/gpu/drm/amd/ras/core/Makefile
@@ -38,6 +38,7 @@ RAS_CORE_FILES = core.o \
 			ras_nbio.o \
 			ras_nbio_v7_9.o \
 			log_ring.o \
+			ras_bert.o \
 			ras_cper.o \
 			ras_psp.o \
 			ras_psp_v13_0.o \
diff --git a/drivers/gpu/drm/amd/ras/core/ras.h b/drivers/gpu/drm/amd/ras/core/ras.h
index 9c830b803e834..168766d449ce7 100644
--- a/drivers/gpu/drm/amd/ras/core/ras.h
+++ b/drivers/gpu/drm/amd/ras/core/ras.h
@@ -475,4 +475,7 @@ bool ras_core_poison_supported(struct ras_core_context *ras_core);
 bool ras_core_in_early_init(struct ras_core_context *ras_core);
 bool ras_core_early_init_service_enabled(struct ras_core_context *ras_core);
 int ras_core_eeprom_early_init_service(struct ras_core_context *ras_core);
+#if defined(CONFIG_X86_MCE_AMD) && defined(CONFIG_ACPI_APEI)
+int ras_bert_process_records(struct ras_core_context *ras_core, const void *bert, u32 bert_len);
+#endif
 #endif
diff --git a/drivers/gpu/drm/amd/ras/core/ras_bert.c b/drivers/gpu/drm/amd/ras/core/ras_bert.c
new file mode 100644
index 0000000000000..5d11b7d0d0c08
--- /dev/null
+++ b/drivers/gpu/drm/amd/ras/core/ras_bert.c
@@ -0,0 +1,78 @@
+// SPDX-License-Identifier: MIT
+/*
+ * Copyright 2026 Advanced Micro Devices, Inc.
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a
+ * copy of this software and associated documentation files (the "Software"),
+ * to deal in the Software without restriction, including without limitation
+ * the rights to use, copy, modify, merge, publish, sublicense,
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
+#if defined(CONFIG_X86_MCE_AMD) && defined(CONFIG_ACPI_APEI)
+int ras_bert_process_records(struct ras_core_context *ras_core,
+			     const void *bert, u32 bert_len)
+{
+	struct acpi_hest_generic_status *estatus;
+	struct acpi_hest_generic_data *gdata;
+	u32 estatus_len;
+	int remain;
+
+	if (!ras_core || !bert || bert_len < sizeof(struct acpi_hest_generic_status))
+		return -EINVAL;
+
+	estatus = (struct acpi_hest_generic_status *)bert;
+	remain = bert_len;
+
+	while (remain >= sizeof(struct acpi_hest_generic_status)) {
+		estatus_len = estatus->raw_data_length ?
+			      estatus->raw_data_offset + estatus->raw_data_length :
+			      sizeof(*estatus) + estatus->data_length;
+		if (remain < estatus_len) {
+			RAS_DEV_ERR(ras_core->dev, "truncated status block (length: %u).\n",
+				    estatus_len);
+			return -EINVAL;
+		}
+		if (!estatus_len)
+			return -EINVAL;
+
+		/*
+		 * The generic APEI BERT path may have already consumed the boot
+		 * error region and cleared block_status. AMDGPU still needs to
+		 * parse the cached BERT payload, so do not use block_status to
+		 * decide whether this status block contains records.
+		 */
+		if (cper_estatus_check(estatus)) {
+			RAS_DEV_ERR(ras_core->dev, "invalid error record.\n");
+			return -EINVAL;
+		}
+
+		gdata = (struct acpi_hest_generic_data *)(estatus + 1);
+		while ((void *)gdata - (void *)(estatus + 1) < estatus->data_length) {
+			RAS_DEV_INFO(ras_core->dev, "unknown section: %pUl\n",
+				     gdata->section_type);
+
+			gdata = acpi_hest_get_next(gdata);
+		}
+		estatus = (struct acpi_hest_generic_status *)((u8 *)estatus + estatus_len);
+		remain -= estatus_len;
+	}
+
+	return 0;
+}
+#endif
diff --git a/drivers/gpu/drm/amd/ras/ras_mgr/ras_sys.h b/drivers/gpu/drm/amd/ras/ras_mgr/ras_sys.h
index 2775c7bf41b7e..351864a1dd40d 100644
--- a/drivers/gpu/drm/amd/ras/ras_mgr/ras_sys.h
+++ b/drivers/gpu/drm/amd/ras/ras_mgr/ras_sys.h
@@ -28,6 +28,10 @@
 #include <linux/printk.h>
 #include <linux/dev_printk.h>
 #include <linux/mempool.h>
+#if defined(CONFIG_X86_MCE_AMD) && defined(CONFIG_ACPI_APEI)
+#include <linux/cper.h>
+#include <acpi/ghes.h>
+#endif
 #include "amdgpu.h"
 
 /* inject address is 52 bits */
-- 
2.55.0

