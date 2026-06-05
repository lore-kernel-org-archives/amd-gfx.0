Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68C26CD6E79
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Jun 2026 13:44:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 033EB10E62D;
	Fri,  5 Jun 2026 13:44:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="QbSh4lyF";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012054.outbound.protection.outlook.com [40.107.209.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EFEC310E62F
 for <amd-gfx@lists.freedesktop.org>; Fri,  5 Jun 2026 13:44:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UEK/b9gtk7f4hWPUj22//rykIHZitcgvim+KIMViNcFAf7WYB4XwFRmApCpEUIIuno8FkXClP2K/E79pUMq1uf0+HlibFcWNTm5vfFMfSd720M/uRJKFsWpnhqO58G+VT5tM/xDSyIX0AOZHd6Alsa+IPE4tkciictRbiKyaUN39WvaSM4NXp0SAZeEPhHKhZxJpcAInpR/QZfCU68vmEdmrS74feVS8zJc11LtkRrp/nblTb10+wOsHstsk43U3BxWldI43MJ2LM4rpgmFY0IpbkPw0+2w7YoQNTylCtoyaQRYhsvle7b97J09TKWMsdqtABdiZVxLmLl26KLkeZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pj7FPk5BaKhFRbAZSjxrccAQZiLl20EOmRXgEiMXh0c=;
 b=I0Len+R1a3k5JeMNBBEmgjhlIkUOhS3O0uGbnvef6n/4eiTyo4DAA6Yan5tPaXKKZW+e/J2zFaVc47nytFvft4p4xm7sgY28iJRAXMbRXuAQaCEPZrHjv6NbgDumIQRJohRj/PCMIAAIoTnvjBZg2ERgQ42YyGJblKKcF0CkMO+H+msBa7+SyrBeYFGzQBbQ9+NKBvBqAs7lA6WTEMr2i82t6ngadVL433pXDQr3svbV7bMF35B0r+0QY4h4UEtOZSxQIyUh0M/tz6sym0eE9tGVEpEEN9fjyc10UGp/WMWeY+TojSHEzjjnJOV2VlT72cTxyDXhw8T0jbo8Ms4ZaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pj7FPk5BaKhFRbAZSjxrccAQZiLl20EOmRXgEiMXh0c=;
 b=QbSh4lyFFpLT02lDknKsl3H4J9a2iG7ioUIKGl95LRB6EHnaz270d2HAAcbghD7vT5MqDeCHNUo829Ea2k8N5qQfdkHvkubZ8ZOeM/p9822+fuKmk2fAb6CcAFhZR/g1rRRmP4JCqUR0CaON9hQf7FB2lWqvumE29nX17gDqzLI=
Received: from CH0P221CA0040.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:11d::20)
 by IA0PPF73BED5E32.namprd12.prod.outlook.com
 (2603:10b6:20f:fc04::bd2) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Fri, 5 Jun 2026
 13:44:22 +0000
Received: from DS3PEPF0000C37A.namprd04.prod.outlook.com
 (2603:10b6:610:11d:cafe::74) by CH0P221CA0040.outlook.office365.com
 (2603:10b6:610:11d::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.9 via Frontend Transport; Fri, 5
 Jun 2026 13:44:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS3PEPF0000C37A.mail.protection.outlook.com (10.167.23.4) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Fri, 5 Jun 2026 13:44:22 +0000
Received: from amd-desktop.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 5 Jun
 2026 08:44:15 -0500
From: Shahyan Soltani <shahyan.soltani@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Shahyan Soltani <shahyan.soltani@amd.com>
Subject: [PATCH 07/11] drm/amdgpu: move amdgpu_acpi helpers into new header
Date: Fri, 5 Jun 2026 09:43:19 -0400
Message-ID: <20260605134400.956791-8-shahyan.soltani@amd.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260605134400.956791-1-shahyan.soltani@amd.com>
References: <20260605134400.956791-1-shahyan.soltani@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C37A:EE_|IA0PPF73BED5E32:EE_
X-MS-Office365-Filtering-Correlation-Id: 23cdc654-15bd-4d8d-6aed-08dec3088cc9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|1800799024|376014|82310400026|22082099003|3023799007|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: 3SlNW5KmbZddhauzpjS+/jdgYAyhRumtYs/c7MLkr8GIhAoAiCwCiwJiWPXTHcsKYrSfCLvwL412wu/6z30kXwU9O+kNYHMuorjkegXlHEptC8m6L5DVgdMild9AebiWT2HwN2ApkzbPYIcWx4unYzCABVSDX9RAiTR10kHPaks3oyLV3C6bs1qt7GvqLX1gxx17CmIY/SM8feN3bUVw92Q3JKLQ/KgUx44siU0dYNbvVG4LociMnALPOTOzag95hBcOvbsQstwYOuTLRibtBLx/HwrH5e5VRru2NX88kbcK77NwjDYxQAhfi3bGPSSeHdqgaZvWHvPTM1UxiiZ0EtObqkuxobFA4bOrsxHlpe2q/Pzv3I6fWwEMvvn8TLO7E+jHsuRpEuO3Crd84a8NQHy1SBHngThBBXFRkWviKdwBMnIiRCdKnZgXPxzoNkoHLqTRDQgIpwAbfqJZzCnWG9ooRJ/hx75/2h2w0Y4cWY6be9xFou2WMrCjcSviGpOf5morIMWBc6SAbvPP/FZhzuTGzvdJe81f6J8/63qqifU8b72JwmO5oWrcm7Q4wLgXcY/x/RAthcBewpitLoo0wc6T+5FRuDYZOZ0E7VQrBjVOhrEefBiMfLv96FKUbZDcecMJw2mOff5dRU2K3e0E1fWQ6bOy8LmLhy5k9Z0rNAu1A0N3rJGmL1QfJrVRMvPPc/9qJ2NVJkVmqhRlg96ukesBBJfH+bqLXe2zOkltZ4k=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(1800799024)(376014)(82310400026)(22082099003)(3023799007)(18002099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 1DDaQweP9coPiiWWQl5aLvdI8CyD+7f9sH6jAqKVRBgXRZJkQLSiJhNB/k6CDHlK8RYD8YZy5cWtb6+F5RO7P0ODlfba1WH4mD1l1i2qZFOewKEzNGY8x55D3rNAT1Z7xuhWAfFMfa2OjxIF4nikKNqTyKiNYDaHaZgYnXbYt9LhOuEBIFPxGy5Ug4uwxx9h6okbgfJLHQIvpWjRJjO4Q2emI2wzVCgjBU7ztehq0BbRWCxUmb1Kqy+AjSIkirEnWax8ruIOgxDF8E7+3uCOAFuijxGarWsrsDdcoo/KI6Ugc6OP3VIBXeni+jaKUVT6lOh0u+ybkZOfLyHh4pFFka7YBiHw48025o2SxUpyiQn2UikEFo8K4neEQFRaaGxg6BOOM+TMVUhilE1x6wIWrhWkm8MS/b9GsfDKi0uFl+kFgjAaRdGbb5u+fKG/QQ5n
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2026 13:44:22.1882 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 23cdc654-15bd-4d8d-6aed-08dec3088cc9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF0000C37A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPF73BED5E32
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

Move struct amdgpu_uma_carveout_option, struct amdgpu_uma_carveout_info,
struct amdgpu_numa_info, and relevant acpi helpers from the monolithic
amdgpu.h header file into a new amdgpu_acpi.h file.

This is part of the ongoing effort to reduce the size of amdgpu.h into their own respective
separate headers.

Signed-off-by: Shahyan Soltani <shahyan.soltani@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h      | 122 +-----------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.h | 151 +++++++++++++++++++++++
 2 files changed, 152 insertions(+), 121 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.h

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 07962b06168d..85d040184d13 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -114,6 +114,7 @@
 #include "amdgpu_sa.h"
 #include "amdgpu_wb.h"
 #include "amdgpu_ip.h"
+#include "amdgpu_acpi.h"
 #include "amdgpu_mqd.h"
 #include "amdgpu_init_level.h"
 #include "amdgpu_uid.h"
@@ -139,13 +140,6 @@ struct amdgpu_mgpu_info {
 	uint32_t			num_apu;
 };
 
-enum amdgpu_ss {
-	AMDGPU_SS_DRV_LOAD,
-	AMDGPU_SS_DEV_D0,
-	AMDGPU_SS_DEV_D3,
-	AMDGPU_SS_DRV_UNLOAD
-};
-
 struct amdgpu_hwip_reg_entry {
 	u32		hwip;
 	u32		inst;
@@ -537,38 +531,6 @@ struct amdgpu_mmio_remap {
 	struct amdgpu_bo *bo;
 };
 
-#define MAX_UMA_OPTION_NAME	28
-#define MAX_UMA_OPTION_ENTRIES	19
-
-#define AMDGPU_UMA_FLAG_AUTO	BIT(1)
-#define AMDGPU_UMA_FLAG_CUSTOM	BIT(0)
-
-/**
- * struct amdgpu_uma_carveout_option - single UMA carveout option
- * @name: Name of the carveout option
- * @memory_carved_mb: Amount of memory carved in MB
- * @flags: ATCS flags supported by this option
- */
-struct amdgpu_uma_carveout_option {
-	char name[MAX_UMA_OPTION_NAME];
-	uint32_t memory_carved_mb;
-	uint8_t flags;
-};
-
-/**
- * struct amdgpu_uma_carveout_info - table of available UMA carveout options
- * @num_entries: Number of available options
- * @uma_option_index: The index of the option currently applied
- * @update_lock: Lock to serialize changes to the option
- * @entries: The array of carveout options
- */
-struct amdgpu_uma_carveout_info {
-	uint8_t num_entries;
-	uint8_t uma_option_index;
-	struct mutex update_lock;
-	struct amdgpu_uma_carveout_option entries[MAX_UMA_OPTION_ENTRIES];
-};
-
 struct amd_powerplay {
 	void *pp_handle;
 	const struct amd_pm_funcs *pp_funcs;
@@ -1295,88 +1257,6 @@ struct amdgpu_afmt_acr {
 
 struct amdgpu_afmt_acr amdgpu_afmt_acr(uint32_t clock);
 
-/* amdgpu_acpi.c */
-
-struct amdgpu_numa_info {
-	uint64_t size;
-	int pxm;
-	int nid;
-};
-
-/* ATCS Device/Driver State */
-#define AMDGPU_ATCS_PSC_DEV_STATE_D0		0
-#define AMDGPU_ATCS_PSC_DEV_STATE_D3_HOT	3
-#define AMDGPU_ATCS_PSC_DRV_STATE_OPR		0
-#define AMDGPU_ATCS_PSC_DRV_STATE_NOT_OPR	1
-
-#if defined(CONFIG_ACPI)
-int amdgpu_acpi_init(struct amdgpu_device *adev);
-void amdgpu_acpi_fini(struct amdgpu_device *adev);
-bool amdgpu_acpi_is_pcie_performance_request_supported(struct amdgpu_device *adev);
-bool amdgpu_acpi_is_power_shift_control_supported(void);
-bool amdgpu_acpi_is_set_uma_allocation_size_supported(void);
-int amdgpu_acpi_pcie_performance_request(struct amdgpu_device *adev,
-						u8 perf_req, bool advertise);
-int amdgpu_acpi_power_shift_control(struct amdgpu_device *adev,
-				    u8 dev_state, bool drv_state);
-int amdgpu_acpi_smart_shift_update(struct amdgpu_device *adev,
-				   enum amdgpu_ss ss_state);
-int amdgpu_acpi_set_uma_allocation_size(struct amdgpu_device *adev, u8 index, u8 type);
-int amdgpu_acpi_pcie_notify_device_ready(struct amdgpu_device *adev);
-int amdgpu_acpi_get_tmr_info(struct amdgpu_device *adev, u64 *tmr_offset,
-			     u64 *tmr_size);
-int amdgpu_acpi_get_mem_info(struct amdgpu_device *adev, int xcc_id,
-			     struct amdgpu_numa_info *numa_info);
-
-void amdgpu_acpi_get_backlight_caps(struct amdgpu_dm_backlight_caps *caps);
-bool amdgpu_acpi_should_gpu_reset(struct amdgpu_device *adev);
-void amdgpu_acpi_detect(void);
-void amdgpu_acpi_release(void);
-#else
-static inline int amdgpu_acpi_init(struct amdgpu_device *adev) { return 0; }
-static inline int amdgpu_acpi_get_tmr_info(struct amdgpu_device *adev,
-					   u64 *tmr_offset, u64 *tmr_size)
-{
-	return -EINVAL;
-}
-static inline int amdgpu_acpi_get_mem_info(struct amdgpu_device *adev,
-					   int xcc_id,
-					   struct amdgpu_numa_info *numa_info)
-{
-	return -EINVAL;
-}
-static inline void amdgpu_acpi_fini(struct amdgpu_device *adev) { }
-static inline bool amdgpu_acpi_should_gpu_reset(struct amdgpu_device *adev) { return false; }
-static inline void amdgpu_acpi_detect(void) { }
-static inline void amdgpu_acpi_release(void) { }
-static inline bool amdgpu_acpi_is_power_shift_control_supported(void) { return false; }
-static inline bool amdgpu_acpi_is_set_uma_allocation_size_supported(void) { return false; }
-static inline int amdgpu_acpi_power_shift_control(struct amdgpu_device *adev,
-						  u8 dev_state, bool drv_state) { return 0; }
-static inline int amdgpu_acpi_smart_shift_update(struct amdgpu_device *adev,
-						 enum amdgpu_ss ss_state)
-{
-	return 0;
-}
-static inline int amdgpu_acpi_set_uma_allocation_size(struct amdgpu_device *adev, u8 index, u8 type)
-{
-	return -EINVAL;
-}
-static inline void amdgpu_acpi_get_backlight_caps(struct amdgpu_dm_backlight_caps *caps) { }
-#endif
-
-#if defined(CONFIG_ACPI) && defined(CONFIG_SUSPEND)
-bool amdgpu_acpi_is_s3_active(struct amdgpu_device *adev);
-bool amdgpu_acpi_is_s0ix_active(struct amdgpu_device *adev);
-#else
-static inline bool amdgpu_acpi_is_s0ix_active(struct amdgpu_device *adev) { return false; }
-static inline bool amdgpu_acpi_is_s3_active(struct amdgpu_device *adev) { return false; }
-#endif
-
-#if defined(CONFIG_DRM_AMD_ISP)
-int amdgpu_acpi_get_isp4_dev(struct acpi_device **dev);
-#endif
-
 void amdgpu_register_gpu_instance(struct amdgpu_device *adev);
 void amdgpu_unregister_gpu_instance(struct amdgpu_device *adev);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.h
new file mode 100644
index 000000000000..6569a4db5dae
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.h
@@ -0,0 +1,151 @@
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
+#ifndef __AMDGPU_ACPI_H__
+#define __AMDGPU_ACPI_H__
+
+#include <linux/types.h>
+#include <linux/mutex_types.h>
+
+struct amdgpu_device;
+struct acpi_device;
+struct amdgpu_dm_backlight_caps;
+
+#define MAX_UMA_OPTION_NAME	28
+#define MAX_UMA_OPTION_ENTRIES	19
+
+#define AMDGPU_UMA_FLAG_AUTO	BIT(1)
+#define AMDGPU_UMA_FLAG_CUSTOM	BIT(0)
+
+/* ATCS Device/Driver State */
+#define AMDGPU_ATCS_PSC_DEV_STATE_D0		0
+#define AMDGPU_ATCS_PSC_DEV_STATE_D3_HOT	3
+#define AMDGPU_ATCS_PSC_DRV_STATE_OPR		0
+#define AMDGPU_ATCS_PSC_DRV_STATE_NOT_OPR	1
+
+enum amdgpu_ss {
+	AMDGPU_SS_DRV_LOAD,
+	AMDGPU_SS_DEV_D0,
+	AMDGPU_SS_DEV_D3,
+	AMDGPU_SS_DRV_UNLOAD
+};
+
+/**
+ * struct amdgpu_uma_carveout_option - single UMA carveout option
+ * @name: Name of the carveout option
+ * @memory_carved_mb: Amount of memory carved in MB
+ * @flags: ATCS flags supported by this option
+ */
+struct amdgpu_uma_carveout_option {
+	char name[MAX_UMA_OPTION_NAME];
+	uint32_t memory_carved_mb;
+	uint8_t flags;
+};
+
+/**
+ * struct amdgpu_uma_carveout_info - table of available UMA carveout options
+ * @num_entries: Number of available options
+ * @uma_option_index: The index of the option currently applied
+ * @update_lock: Lock to serialize changes to the option
+ * @entries: The array of carveout options
+ */
+struct amdgpu_uma_carveout_info {
+	uint8_t num_entries;
+	uint8_t uma_option_index;
+	struct mutex update_lock;
+	struct amdgpu_uma_carveout_option entries[MAX_UMA_OPTION_ENTRIES];
+};
+
+struct amdgpu_numa_info {
+	uint64_t size;
+	int pxm;
+	int nid;
+};
+
+#if defined(CONFIG_ACPI)
+int amdgpu_acpi_init(struct amdgpu_device *adev);
+void amdgpu_acpi_fini(struct amdgpu_device *adev);
+bool amdgpu_acpi_is_pcie_performance_request_supported(struct amdgpu_device *adev);
+bool amdgpu_acpi_is_power_shift_control_supported(void);
+bool amdgpu_acpi_is_set_uma_allocation_size_supported(void);
+int amdgpu_acpi_pcie_performance_request(struct amdgpu_device *adev,
+						u8 perf_req, bool advertise);
+int amdgpu_acpi_power_shift_control(struct amdgpu_device *adev,
+				    u8 dev_state, bool drv_state);
+int amdgpu_acpi_smart_shift_update(struct amdgpu_device *adev,
+				   enum amdgpu_ss ss_state);
+int amdgpu_acpi_set_uma_allocation_size(struct amdgpu_device *adev, u8 index, u8 type);
+int amdgpu_acpi_pcie_notify_device_ready(struct amdgpu_device *adev);
+int amdgpu_acpi_get_tmr_info(struct amdgpu_device *adev, u64 *tmr_offset,
+			     u64 *tmr_size);
+int amdgpu_acpi_get_mem_info(struct amdgpu_device *adev, int xcc_id,
+			     struct amdgpu_numa_info *numa_info);
+
+void amdgpu_acpi_get_backlight_caps(struct amdgpu_dm_backlight_caps *caps);
+bool amdgpu_acpi_should_gpu_reset(struct amdgpu_device *adev);
+void amdgpu_acpi_detect(void);
+void amdgpu_acpi_release(void);
+#else
+static inline int amdgpu_acpi_init(struct amdgpu_device *adev) { return 0; }
+static inline int amdgpu_acpi_get_tmr_info(struct amdgpu_device *adev,
+					   u64 *tmr_offset, u64 *tmr_size)
+{
+	return -EINVAL;
+}
+static inline int amdgpu_acpi_get_mem_info(struct amdgpu_device *adev,
+					   int xcc_id,
+					   struct amdgpu_numa_info *numa_info)
+{
+	return -EINVAL;
+}
+static inline void amdgpu_acpi_fini(struct amdgpu_device *adev) { }
+static inline bool amdgpu_acpi_should_gpu_reset(struct amdgpu_device *adev) { return false; }
+static inline void amdgpu_acpi_detect(void) { }
+static inline void amdgpu_acpi_release(void) { }
+static inline bool amdgpu_acpi_is_power_shift_control_supported(void) { return false; }
+static inline bool amdgpu_acpi_is_set_uma_allocation_size_supported(void) { return false; }
+static inline int amdgpu_acpi_power_shift_control(struct amdgpu_device *adev,
+						  u8 dev_state, bool drv_state) { return 0; }
+static inline int amdgpu_acpi_smart_shift_update(struct amdgpu_device *adev,
+						 enum amdgpu_ss ss_state)
+{
+	return 0;
+}
+static inline int amdgpu_acpi_set_uma_allocation_size(struct amdgpu_device *adev, u8 index, u8 type)
+{
+	return -EINVAL;
+}
+static inline void amdgpu_acpi_get_backlight_caps(struct amdgpu_dm_backlight_caps *caps) { }
+#endif
+
+#if defined(CONFIG_ACPI) && defined(CONFIG_SUSPEND)
+bool amdgpu_acpi_is_s3_active(struct amdgpu_device *adev);
+bool amdgpu_acpi_is_s0ix_active(struct amdgpu_device *adev);
+#else
+static inline bool amdgpu_acpi_is_s0ix_active(struct amdgpu_device *adev) { return false; }
+static inline bool amdgpu_acpi_is_s3_active(struct amdgpu_device *adev) { return false; }
+#endif
+
+#if defined(CONFIG_DRM_AMD_ISP)
+int amdgpu_acpi_get_isp4_dev(struct acpi_device **dev);
+#endif
+#endif /* __AMDGPU_ACPI_H__ */
-- 
2.54.0

