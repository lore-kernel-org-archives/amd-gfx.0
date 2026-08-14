Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01212C5CFCF
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Aug 2026 21:04:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7E6E410F747;
	Fri, 14 Aug 2026 21:04:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="0K3l9xd/";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010011.outbound.protection.outlook.com
 [52.101.193.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BD7BE10F72D
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Aug 2026 21:03:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q3bBsNizQaIpO+W7S2OSMdOUGOSTC6aJDrwH5g1091jaXWi1kVZP786KcweSJzLgA0lCQKbhz7jCQqaCGU3CBSYy9N/3F8MTkD9TgADyJoeRTOxX4nF4BGeCl25UDnInAAZUD8p97h8galGFjKz6ys+rIgIVsyGeV3peHiaYqshNJ1K9Q+neTI4FtBe1elL2OXXLKKm2SmhMJxky2Er9jYe8EYJ9GG9gLfkaImPTxFbfud3ThVRsHh5TTJFzkQRo3pTHgeVRm3i0Mj/M5Ef77xwTzvW6aAFjgK2eAfw6cg6AtTDq1DX2WKBL5bDjU6p7dw1O5pQ8+iYxYIFXaO3CDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LWgiKYUmKS1pFN3vjHocrcTDtgHGhrWtfpW4ZgDPyVI=;
 b=F5T8Xy8WBtKfomHm9W18ojQi/vruod9UXN7PMjf28a3JO0kD+aAMbe7YEZvjQBT9BOJABo8mCvfG2EO9OS8fXEkZVD2LzkeHCGC3/fBMUjcw22VA7z+YEn2Kk4mmR3r4isjHi9Ss3wLJvnWpegCv9Uwk8Ld+SVzlg1BXa9qKHL9n8rG0f+J3/424/bD+nEgw6DlWoHV/tJHPACQh5W6uri7r45tqh/ppdhQCrRDXI7uA+ocPRiF1DV4ABBFZWKUrajGzEzYAalaYYCbwIR5ET5Ov0qr8iLObCdbys0D63/wkovfDpN+6N3aJ66wthGfUXCb/c8cmRpo9VGvgjmgl2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LWgiKYUmKS1pFN3vjHocrcTDtgHGhrWtfpW4ZgDPyVI=;
 b=0K3l9xd/G8i7VBkjO3jCfiwlxbNf78RsO/spB19ulwnROAwcw3juxDPBhRd8nFlmqyGfYbBJG4IdAheM7nT+iOamNtVpKl0h3LHnQSsEfFrcgcs023TCBukZyRPsvIvfup4skEVtOGFdx4RbRjr7TIr2tzvHZF1EONrw6O2TwHg=
Received: from BN9PR03CA0965.namprd03.prod.outlook.com (2603:10b6:408:109::10)
 by IA5PR12MB999301.namprd12.prod.outlook.com (2603:10b6:208:60a::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.16; Fri, 14 Aug
 2026 21:03:52 +0000
Received: from BN2PEPF0000449D.namprd02.prod.outlook.com
 (2603:10b6:408:109:cafe::14) by BN9PR03CA0965.outlook.office365.com
 (2603:10b6:408:109::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.14 via Frontend Transport; Fri,
 14 Aug 2026 21:03:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN2PEPF0000449D.mail.protection.outlook.com (10.167.243.148) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.3 via Frontend Transport; Fri, 14 Aug 2026 21:03:52 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 14 Aug
 2026 16:03:48 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Fri, 14 Aug 2026 16:03:48 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Xiang Liu <xiang.liu@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>,
 "Alex Deucher" <alexander.deucher@amd.com>
Subject: [PATCH 085/109] drm/amd/ras: add BERT CPER table helpers
Date: Fri, 14 Aug 2026 17:02:22 -0400
Message-ID: <20260814210246.3067612-86-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260814210246.3067612-1-alexander.deucher@amd.com>
References: <20260814210246.3067612-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF0000449D:EE_|IA5PR12MB999301:EE_
X-MS-Office365-Filtering-Correlation-Id: 6dce6ff6-aab6-4129-6da6-08defa478bbc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|82310400026|36860700016|376014|22082099003|18002099003|3023799007|56012099006|10067099003|11063799006;
X-Microsoft-Antispam-Message-Info: /2c5Jw4o1NtEvAsLLklgyEsziiEJ1adeShceFDldqoXevMLN9ycz4gGFqAdI9xbMjtGzc4Yhi/4OnkhcZrSO1TI8td9lnl957n0R3msNHIUzHweNUTtT2hk01LQBXhQwZC+0hYoemZTafJ4DIs+Xju2nZgvNsBShqZcBPI90i3eZ3WfMnWOO65vuipMZqb5Tza3ASS0JUW8d+DL+EIRXvA4fBiDHn+4vmRQJafHXOLNhovuJBr9RYgJ9UWcUfv/TXkmnJhnkRFxYHzljDsEWMMlzoOaDHKLXkr5+kBeZgr9QNnST66hzmhLZFgO/H3zdQrdZ0Ic8l1p4X2m3J2I6HwtdBV+qUctLHwGIO/93Wwv89mT2Y+qFD5U0Ei1NlS1CN6ZHVUcE8nOY4+WuD5Mbh9NP8y4ZUMw97sx7ojO6bCVcJqKgsuHnVUlKL/f84F9KI4VsEPooN9NfrRWDyuXE9sb8sYN+KhJ613vw15Au4109Lzggs31rutUaunqEuOQV4tNHq+NEro+FGsb9dmKJGG9ix9BBiHShJtHUiq+u9G1PyLPzFzE8E3Q8y8j6IZ2nhBFxxZfdVZmSNepnFI4eE+jy93bIVxd2uXUzFReS7FGaa6Lgp+YpW3zgLBt66yijEEWr6eJP/begz92fcb6D9tuOUQ6MIIyxl7v4nZYBdH126pT6WJ1RdxTNKCa/OAs/5/nwAjNlbwMhtojKSdxl4g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(82310400026)(36860700016)(376014)(22082099003)(18002099003)(3023799007)(56012099006)(10067099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 1AAxMTHZ8PokOijDlbGdf7QDGMWWl1TRxtSw/pccclZ1dtVnwJPtB7fckTQDUb+rHiH8XJG9qGGwKe35dYn1SoG/3ji4ZmJMXXtzZsUv6AZwpzD82yzpo5+ojTlrHT3rj9mRZxQwGBXUSEO6J///KGaqEzYegS7o/TL388KyMvoBsV5N9qj6ELYRzBhhXX4D/e4jx+ok6K9YHDIIbpMRa2vnGRF3+3xDrqJzlUFmV4y33wfc7APLcNi79vO6l4gWP3URK7lB/q7ZeNS1a9mY5hj5QYWKzYbjhsKQHNCvYPNiqqSUie1ecNyyWyTU/eXDnLjHRGqICafO3+cUDf6voKPLyhYBmbGrrVieUaV7Lbe96kD4LXaUVZya4XWFllMLtaMu/zPwI5aUN0BNfeOm8riS4ZsrD3ukLuDaKK0j+xOfx0d0JiEzLfLU4Xw3WJR2
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2026 21:03:52.6760 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6dce6ff6-aab6-4129-6da6-08defa478bbc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF0000449D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA5PR12MB999301
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

Add local HEST status and data entry layouts. Also add local helpers for
revision-aware payload access, entry walking, and basic status
validation.

Move the BERT record processing prototype into a dedicated BERT header
so the parser interface stays local to the BERT parser code.

Signed-off-by: Xiang Liu <xiang.liu@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/ras/core/ras.h        |   4 +-
 drivers/gpu/drm/amd/ras/core/ras_bert.c   | 106 ++++++++++++++++++++--
 drivers/gpu/drm/amd/ras/core/ras_bert.h   |  33 +++++++
 drivers/gpu/drm/amd/ras/ras_mgr/ras_sys.h |   4 -
 4 files changed, 131 insertions(+), 16 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/ras/core/ras_bert.h

diff --git a/drivers/gpu/drm/amd/ras/core/ras.h b/drivers/gpu/drm/amd/ras/core/ras.h
index 6aad1d8779e21..238a587447ff4 100644
--- a/drivers/gpu/drm/amd/ras/core/ras.h
+++ b/drivers/gpu/drm/amd/ras/core/ras.h
@@ -38,6 +38,7 @@
 #include "log_ring.h"
 #include "eeprom_fw.h"
 #include "ras_mce.h"
+#include "ras_bert.h"
 
 #define RAS_HW_ERR		"[Hardware Error]: "
 
@@ -477,7 +478,4 @@ bool ras_core_poison_supported(struct ras_core_context *ras_core);
 bool ras_core_in_early_init(struct ras_core_context *ras_core);
 bool ras_core_early_init_service_enabled(struct ras_core_context *ras_core);
 int ras_core_eeprom_early_init_service(struct ras_core_context *ras_core);
-#if defined(CONFIG_X86_MCE_AMD) && defined(CONFIG_ACPI_APEI)
-int ras_bert_process_records(struct ras_core_context *ras_core, const void *bert, u32 bert_len);
-#endif
 #endif
diff --git a/drivers/gpu/drm/amd/ras/core/ras_bert.c b/drivers/gpu/drm/amd/ras/core/ras_bert.c
index 5d11b7d0d0c08..991c3fa164b27 100644
--- a/drivers/gpu/drm/amd/ras/core/ras_bert.c
+++ b/drivers/gpu/drm/amd/ras/core/ras_bert.c
@@ -25,21 +25,109 @@
 #include "ras.h"
 
 #if defined(CONFIG_X86_MCE_AMD) && defined(CONFIG_ACPI_APEI)
+struct ras_bert_hest_generic_status {
+	u32 block_status;
+	u32 raw_data_offset;
+	u32 raw_data_length;
+	u32 data_length;
+	u32 error_severity;
+};
+
+struct ras_bert_hest_generic_data {
+	u8 section_type[16];
+	u32 error_severity;
+	u16 revision;
+	u8 validation_bits;
+	u8 flags;
+	u32 error_data_length;
+	u8 fru_id[16];
+	u8 fru_text[20];
+};
+
+struct ras_bert_hest_generic_data_v300 {
+	u8 section_type[16];
+	u32 error_severity;
+	u16 revision;
+	u8 validation_bits;
+	u8 flags;
+	u32 error_data_length;
+	u8 fru_id[16];
+	u8 fru_text[20];
+	u64 time_stamp;
+};
+
+static inline int ras_bert_get_version(struct ras_bert_hest_generic_data *gdata)
+{
+	return gdata->revision >> 8;
+}
+
+static inline void *ras_bert_get_payload(struct ras_bert_hest_generic_data *gdata)
+{
+	if (ras_bert_get_version(gdata) >= 3)
+		return (void *)(((struct ras_bert_hest_generic_data_v300 *)(gdata)) + 1);
+
+	return gdata + 1;
+}
+
+static inline int ras_bert_get_size(struct ras_bert_hest_generic_data *gdata)
+{
+	if (ras_bert_get_version(gdata) >= 3)
+		return sizeof(struct ras_bert_hest_generic_data_v300);
+
+	return sizeof(struct ras_bert_hest_generic_data);
+}
+
+static inline void *ras_bert_get_next(struct ras_bert_hest_generic_data *gdata)
+{
+	return (void *)gdata + ras_bert_get_size(gdata) + gdata->error_data_length;
+}
+
+static int ras_bert_estatus_check(const struct ras_bert_hest_generic_status *estatus)
+{
+	struct ras_bert_hest_generic_data *gdata;
+	unsigned int data_len, record_size;
+
+	if (estatus->data_length &&
+	    estatus->data_length < sizeof(struct ras_bert_hest_generic_data))
+		return -EINVAL;
+	if (estatus->raw_data_length &&
+	    estatus->raw_data_offset < sizeof(*estatus) + estatus->data_length)
+		return -EINVAL;
+
+	data_len = estatus->data_length;
+	gdata = (struct ras_bert_hest_generic_data *)(estatus + 1);
+	while ((void *)gdata - (void *)(estatus + 1) < estatus->data_length) {
+		if (ras_bert_get_size(gdata) > data_len)
+			return -EINVAL;
+
+		record_size = ras_bert_get_size(gdata) + gdata->error_data_length;
+		if (record_size > data_len)
+			return -EINVAL;
+
+		data_len -= record_size;
+		gdata = ras_bert_get_next(gdata);
+	}
+	if (data_len)
+		return -EINVAL;
+
+	return 0;
+}
+
 int ras_bert_process_records(struct ras_core_context *ras_core,
 			     const void *bert, u32 bert_len)
 {
-	struct acpi_hest_generic_status *estatus;
-	struct acpi_hest_generic_data *gdata;
+	struct ras_bert_hest_generic_status *estatus;
+	struct ras_bert_hest_generic_data *gdata;
 	u32 estatus_len;
 	int remain;
 
-	if (!ras_core || !bert || bert_len < sizeof(struct acpi_hest_generic_status))
+	if (!ras_core || !bert || bert_len < sizeof(struct ras_bert_hest_generic_status))
 		return -EINVAL;
 
-	estatus = (struct acpi_hest_generic_status *)bert;
+	estatus = (struct ras_bert_hest_generic_status *)bert;
 	remain = bert_len;
 
-	while (remain >= sizeof(struct acpi_hest_generic_status)) {
+	while (remain >= sizeof(struct ras_bert_hest_generic_status)) {
 		estatus_len = estatus->raw_data_length ?
 			      estatus->raw_data_offset + estatus->raw_data_length :
 			      sizeof(*estatus) + estatus->data_length;
@@ -57,19 +145,19 @@ int ras_bert_process_records(struct ras_core_context *ras_core,
 		 * parse the cached BERT payload, so do not use block_status to
 		 * decide whether this status block contains records.
 		 */
-		if (cper_estatus_check(estatus)) {
+		if (ras_bert_estatus_check(estatus)) {
 			RAS_DEV_ERR(ras_core->dev, "invalid error record.\n");
 			return -EINVAL;
 		}
 
-		gdata = (struct acpi_hest_generic_data *)(estatus + 1);
+		gdata = (struct ras_bert_hest_generic_data *)(estatus + 1);
 		while ((void *)gdata - (void *)(estatus + 1) < estatus->data_length) {
 			RAS_DEV_INFO(ras_core->dev, "unknown section: %pUl\n",
 				     gdata->section_type);
 
-			gdata = acpi_hest_get_next(gdata);
+			gdata = ras_bert_get_next(gdata);
 		}
-		estatus = (struct acpi_hest_generic_status *)((u8 *)estatus + estatus_len);
+		estatus = (struct ras_bert_hest_generic_status *)((u8 *)estatus + estatus_len);
 		remain -= estatus_len;
 	}
 
diff --git a/drivers/gpu/drm/amd/ras/core/ras_bert.h b/drivers/gpu/drm/amd/ras/core/ras_bert.h
new file mode 100644
index 0000000000000..523281afe0d00
--- /dev/null
+++ b/drivers/gpu/drm/amd/ras/core/ras_bert.h
@@ -0,0 +1,33 @@
+/* SPDX-License-Identifier: MIT */
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
+#ifndef __RAS_BERT_H__
+#define __RAS_BERT_H__
+
+struct ras_core_context;
+
+int ras_bert_process_records(struct ras_core_context *ras_core,
+			     const void *bert, u32 bert_len);
+
+#endif
diff --git a/drivers/gpu/drm/amd/ras/ras_mgr/ras_sys.h b/drivers/gpu/drm/amd/ras/ras_mgr/ras_sys.h
index 351864a1dd40d..2775c7bf41b7e 100644
--- a/drivers/gpu/drm/amd/ras/ras_mgr/ras_sys.h
+++ b/drivers/gpu/drm/amd/ras/ras_mgr/ras_sys.h
@@ -28,10 +28,6 @@
 #include <linux/printk.h>
 #include <linux/dev_printk.h>
 #include <linux/mempool.h>
-#if defined(CONFIG_X86_MCE_AMD) && defined(CONFIG_ACPI_APEI)
-#include <linux/cper.h>
-#include <acpi/ghes.h>
-#endif
 #include "amdgpu.h"
 
 /* inject address is 52 bits */
-- 
2.55.0

