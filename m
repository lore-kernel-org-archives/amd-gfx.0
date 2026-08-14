Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA422C5DF79
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Aug 2026 21:03:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8FA2D10F727;
	Fri, 14 Aug 2026 21:03:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="GogjIRn0";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010026.outbound.protection.outlook.com
 [40.93.198.26])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1798610F718
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Aug 2026 21:03:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Br1QnEWkIhLiCyh7HC5DUeT88TV5KhduCPAo6FPyYEOZCmKM+Z8NlYG2KPuKgYlNtOPAxtaoMb1DuDujD7zZHItgCswLmiHh6Lyd/hy3QZJ4OrcvrfutZXTXm38FhbqMfR8FGGyXrfxmqCr71gULebnShPktw87NGcfDoEtxTAWjhEqXnDHgTDGjtGc45Cf41+HmkG0jX4+Z5pu2mVMLcg2nWXe8jLnKWh8Unlwo0g3mfUBbUJ6gAM+Fsg14pLYyZuE0R3wgud48syoPArdJYgA8GGPDYfTuWD82JuN/ZbwTwlcPhSm3LHHnAIe0pzUin00S8Hpvh/Oi9NbQMj8wLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ToEpW+m3ihiwWKOoCVRdAeheHmR6BuPFqooXO+f2xfk=;
 b=gUSFlj6hjlWSzfkwoQNidfsBsZQ0S6P9FGIndSuEL6t8/vWgtGApIw4ucD1XEcys1ui6/ePwnuxuFwxTBM01fQbCwUDx8k7/oyuQLATHsYedRCMWp0DNbSTBC2nm51NZ3Gr/sfwhzeN6msa3Xy28UQqrPpzcpdQWMU1tDk2c9m1eKXT6WpUm+cN6q1LgzXR0dQZrGqGH77K2PvgF9g7XxdCsiCs/Pc+RDbB5bvV+rBYbpt16nogpM95RqQ5T/r4YVavCh/F37+pMw+I11kQdO5QCuchY12pIdW9TtpHlTIKMN4do1xdHMuV/otooOjY4gU8O2ak/Fpar5NWCq7/2FA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ToEpW+m3ihiwWKOoCVRdAeheHmR6BuPFqooXO+f2xfk=;
 b=GogjIRn01WdjsKrBYQJ/VM7nv3JDI/pBQ6GHJIV+qGzlon6Lc4o21ImPAFsYLATIFRLhMja6AzeXM8ai1RDPLA9ROgFRthGElf9bJDj4gRcKg1DJQTw+3dfIeWv5vfvZKq3FprkiKX/evhmwHK07JUI+kyIQA2fPtHczRgS/rKQ=
Received: from BYAPR21CA0017.namprd21.prod.outlook.com (2603:10b6:a03:114::27)
 by DM4PR12MB8451.namprd12.prod.outlook.com (2603:10b6:8:182::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.15; Fri, 14 Aug
 2026 21:03:46 +0000
Received: from SJ1PEPF00001CE9.namprd03.prod.outlook.com
 (2603:10b6:a03:114:cafe::26) by BYAPR21CA0017.outlook.office365.com
 (2603:10b6:a03:114::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.6 via Frontend Transport; Fri, 14
 Aug 2026 21:03:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ1PEPF00001CE9.mail.protection.outlook.com (10.167.242.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.3 via Frontend Transport; Fri, 14 Aug 2026 21:03:46 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 14 Aug
 2026 16:03:43 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Fri, 14 Aug 2026 16:03:43 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Xiang Liu <xiang.liu@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>,
 "Alex Deucher" <alexander.deucher@amd.com>
Subject: [PATCH 076/109] drm/amd/ras: process cached BERT boot errors
Date: Fri, 14 Aug 2026 17:02:13 -0400
Message-ID: <20260814210246.3067612-77-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260814210246.3067612-1-alexander.deucher@amd.com>
References: <20260814210246.3067612-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE9:EE_|DM4PR12MB8451:EE_
X-MS-Office365-Filtering-Correlation-Id: 2fa0a254-a324-4f49-dc56-08defa4787eb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|23010399003|1800799024|376014|82310400026|3023799007|6133799003|11063799006|10067099003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: ubbDEZDYANhjaDPDxmEqRYr/iFK+499c7s+6WffxSFGt/1PatNQVuutFULXq4bOUeQTBNk+I1YIdiSwyRwr3PtMXzgFnqyuc5kW0Fduq6k0tInqoenNUR2QD7CIVGjW/nytMw75gpWxkvSpFvQ+XxDH4z8nqRSS+eyQotVcS5uy60CgSJrsKmKuZQFICWKzivJLcY1X+A6oY9vcj5hsLyX9yWI85gL2ItprTatBAp9uDFb5CxIeo6wIdl1ubUc9brkYW/u5s2rzyWq6upXZR8DZKxrt0LcnMlnbwLB+SIWT9xw0u5P/MbKZlpud6r0hH9J95F9nW8KFFBq28a40qN6TRVtSowcFxDWYSvwh6VEUdpzQ9lKD8d+zyZZzN+egC0XZ1EOpl481sY21kIvrcSfzR7VE79gPNsgbuzZfTbgjBV9yERkkjjALzAMyVEkowtFNto0kNzQdJvNpsKhp1FgdUHDocLeUv78+d3ENLkrmTvccAk1VHnKvU8NPWTQiZSAXdUomkAlq5Afap3APmI4jxgFfmisB3GRT5W2LAu/j196Lvcw9zNwfzya8/rJ6Rq0Zu5vIbW9+fIowUZ/T/+eUga4B5ugX7bWenD9eHqxUulKOs1uKgVOgOVtILxWKRGlfQDTuuF9QNZYTIb+WJ3IedImQu67WbK6deyP6+D5o29JVqL+gYs215tbz/xTE+GvpEOFz8bGkURanlDDXlgg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(23010399003)(1800799024)(376014)(82310400026)(3023799007)(6133799003)(11063799006)(10067099003)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: mbvWKellmw5TxzCgnvh6Qu9v2S79ZueFKuuelSIqq7Uw3J83Bz6rlEfKDckL49lLDLHBuI8lpKgps9dKpL33RkLHXJZ67OvTEeYnaLUTOx4vMkaHBgPgvEwqPSKV/t+6Qag5XoKtFnB1NZtU7mDxVXq7N90LDiS6xwci6UYoqaRIwXHsJ4PYXe+M7auRdU1qLoSS+TcbGbEzviqOiiM3TimtMyMexiBJSDFpUVRjW2nSxty5ySrmPszy3C8vxE/yP0q4y3hqVxUregaOQRucFG7Gw/02shtXIlQNn6LcNv9ZibU4DkhTXwf2jzd0IktMN0F8m6KD2wo1LkkHs3y4g1YyA6rx9k/6qwPIypO0FzXBT8KZfZz09XkAvT6StYAEh8xeWixvyEXp7q5oJjdRAjZo6uw1hsC6QGj9DZbEKFalJHeTcHl6jyP2dnxGbmh0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2026 21:03:46.2118 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2fa0a254-a324-4f49-dc56-08defa4787eb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CE9.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8451
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

Read and cache the ACPI BERT payload during MCE hardware init, then ask
rascore to process the cached records once for each GPU socket.

Reset the cached state when the MCE notifier chain is torn down so a new
initialization sequence can poll and process boot errors again.

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Xiang Liu <xiang.liu@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/ras/ras_mgr/Makefile      |   1 +
 .../gpu/drm/amd/ras/ras_mgr/amdgpu_ras_bert.c | 152 ++++++++++++++++++
 .../gpu/drm/amd/ras/ras_mgr/amdgpu_ras_bert.h |  32 ++++
 .../gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mce.c  |   7 +
 4 files changed, 192 insertions(+)
 create mode 100644 drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_bert.c
 create mode 100644 drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_bert.h

diff --git a/drivers/gpu/drm/amd/ras/ras_mgr/Makefile b/drivers/gpu/drm/amd/ras/ras_mgr/Makefile
index 3df2a290f67b1..4f94c97c15caa 100644
--- a/drivers/gpu/drm/amd/ras/ras_mgr/Makefile
+++ b/drivers/gpu/drm/amd/ras/ras_mgr/Makefile
@@ -27,6 +27,7 @@ RAS_MGR_FILES = amdgpu_ras_sys.o  \
 		amdgpu_virt_ras_cmd.o \
 		amdgpu_ras_process.o \
 		amdgpu_ras_nbio_v7_9.o \
+		amdgpu_ras_bert.o \
 		amdgpu_ras_mce.o
 
 
diff --git a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_bert.c b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_bert.c
new file mode 100644
index 0000000000000..29111b10b00a3
--- /dev/null
+++ b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_bert.c
@@ -0,0 +1,152 @@
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
+#include "amdgpu.h"
+#include "amdgpu_ras_bert.h"
+
+#if defined(CONFIG_X86_MCE_AMD) && defined(CONFIG_ACPI_APEI)
+#include <linux/acpi.h>
+#include <linux/mutex.h>
+
+#include "amdgpu_ras_mgr.h"
+
+static DEFINE_MUTEX(boot_err_lock);
+static bool boot_err_polled, boot_err_written[MAX_GPU_INSTANCE];
+static int boot_err_poll_result;
+static u8 *boot_err_raw_data;
+static u32 boot_err_raw_data_len;
+
+int amdgpu_ras_bert_process_boot_errors(struct amdgpu_device *adev)
+{
+	struct amdgpu_ras_mgr *ras_mgr = amdgpu_ras_mgr_get_context(adev);
+	struct acpi_bert_region *boot_error_region;
+	struct acpi_table_header *table;
+	struct acpi_table_bert *bert_tab;
+	unsigned int region_len;
+	acpi_status status;
+	u32 socket_id;
+	int ret;
+
+	if (!ras_mgr || !ras_mgr->ras_core)
+		return -EPERM;
+
+	mutex_lock(&boot_err_lock);
+
+	if (!boot_err_polled) {
+		boot_err_polled = true;
+		boot_err_poll_result = 0;
+		ret = 0;
+
+		if (acpi_disabled)
+			goto out_unlock;
+
+		status = acpi_get_table(ACPI_SIG_BERT, 0, &table);
+		if (status == AE_NOT_FOUND)
+			goto out_unlock;
+
+		if (ACPI_FAILURE(status)) {
+			RAS_DEV_ERR(adev, "get table failed, %s.\n", acpi_format_exception(status));
+			boot_err_poll_result = -EINVAL;
+			goto out_unlock;
+		}
+		bert_tab = (struct acpi_table_bert *)table;
+
+		if (bert_tab->header.length < sizeof(struct acpi_table_bert) ||
+		    bert_tab->region_length < sizeof(struct acpi_bert_region)) {
+			RAS_DEV_ERR(adev, "table invalid.\n");
+			boot_err_poll_result = -EINVAL;
+			goto out_put_bert_tab;
+		}
+
+		region_len = bert_tab->region_length;
+		boot_error_region = acpi_os_map_memory(bert_tab->address, region_len);
+		if (boot_error_region) {
+			boot_err_raw_data = kmemdup(boot_error_region, region_len, GFP_KERNEL);
+			acpi_os_unmap_memory(boot_error_region, region_len);
+			if (!boot_err_raw_data) {
+				RAS_DEV_ERR(adev, "failed to cache BERT raw data.\n");
+				boot_err_poll_result = -ENOMEM;
+			} else {
+				boot_err_raw_data_len = region_len;
+			}
+		} else {
+			RAS_DEV_ERR(adev, "failed to map BERT region.\n");
+			boot_err_poll_result = -ENOMEM;
+		}
+
+out_put_bert_tab:
+		acpi_put_table(table);
+	}
+
+	if (boot_err_poll_result) {
+		ret = boot_err_poll_result;
+		goto out_unlock;
+	}
+
+	if (!boot_err_raw_data || !boot_err_raw_data_len ||
+	    !(adev && (adev->gmc.xgmi.connected_to_cpu || adev->gmc.is_app_apu))) {
+		ret = 0;
+		goto out_unlock;
+	}
+
+	if (!adev->smuio.funcs || !adev->smuio.funcs->get_socket_id) {
+		RAS_DEV_WARN(adev, "No interface to obtain current device socket ID!\n");
+		ret = 0;
+		goto out_unlock;
+	}
+
+	socket_id = adev->smuio.funcs->get_socket_id(adev);
+	if (socket_id >= MAX_GPU_INSTANCE) {
+		ret = -EINVAL;
+		goto out_unlock;
+	}
+
+	if (boot_err_written[socket_id]) {
+		ret = 0;
+		goto out_unlock;
+	}
+
+	ret = ras_bert_process_records(ras_mgr->ras_core,
+				       boot_err_raw_data, boot_err_raw_data_len);
+	if (!ret)
+		boot_err_written[socket_id] = true;
+
+out_unlock:
+	mutex_unlock(&boot_err_lock);
+
+	return ret;
+}
+
+void amdgpu_ras_bert_reset_boot_errors(void)
+{
+	mutex_lock(&boot_err_lock);
+	memset(boot_err_written, 0, sizeof(boot_err_written));
+	kfree(boot_err_raw_data);
+	boot_err_raw_data = NULL;
+	boot_err_raw_data_len = 0;
+	boot_err_poll_result = 0;
+	boot_err_polled = false;
+	mutex_unlock(&boot_err_lock);
+}
+#endif
diff --git a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_bert.h b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_bert.h
new file mode 100644
index 0000000000000..27e2378ea5f3a
--- /dev/null
+++ b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_bert.h
@@ -0,0 +1,32 @@
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
+ */
+
+#ifndef __AMDGPU_RAS_BERT_H__
+#define __AMDGPU_RAS_BERT_H__
+
+#if defined(CONFIG_X86_MCE_AMD) && defined(CONFIG_ACPI_APEI)
+int amdgpu_ras_bert_process_boot_errors(struct amdgpu_device *adev);
+void amdgpu_ras_bert_reset_boot_errors(void);
+#endif
+
+#endif
diff --git a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mce.c b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mce.c
index bc7a44618ac6c..97ef50149fdf9 100644
--- a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mce.c
+++ b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mce.c
@@ -23,6 +23,7 @@
  */
 
 #include "amdgpu.h"
+#include "amdgpu_ras_bert.h"
 #include "amdgpu_ras_mgr.h"
 #include "amdgpu_ras_mce.h"
 #include <asm/mce.h>
@@ -122,6 +123,9 @@ static int amdgpu_ras_unregister_mce_notifier(struct amdgpu_device *adev)
 	if (atomic_read(&mce_mgr->ref_count) <= 0) {
 		atomic_set(&mce_mgr->dev_count, 0);
 		mce_unregister_decode_chain(&mce_mgr->nb);
+#ifdef CONFIG_ACPI_APEI
+		amdgpu_ras_bert_reset_boot_errors();
+#endif
 	}
 
 	return 0;
@@ -239,6 +243,9 @@ static int amdgpu_ras_mce_notifier(struct amdgpu_device *adev,
 
 int amdgpu_ras_mce_hw_init(struct amdgpu_device *adev)
 {
+#if defined(CONFIG_X86_MCE_AMD) && defined(CONFIG_ACPI_APEI)
+	amdgpu_ras_bert_process_boot_errors(adev);
+#endif
 	return 0;
 }
 
-- 
2.55.0

