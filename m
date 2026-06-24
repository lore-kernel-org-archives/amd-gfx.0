Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D06E3CDB47F
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Jun 2026 17:56:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 635F510E0CC;
	Wed, 24 Jun 2026 17:56:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="zrLdy9iy";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011039.outbound.protection.outlook.com [52.101.52.39])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 816DD10EFF9
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Jun 2026 17:56:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jfyESWLmADFXRWtoHwrLkoRYpmORN4IxEEgMcU/fLlIkBaX8Im54jctpbwuYRXXcZF6j9mkVRLSdak01nucJBKy/KoXTrUbU2K6XVfcIgLc7Vkz90Z5lPmwk3YkCPhuKXSuM9oTHXrWS+lDolr77R5bq+Si7tk7Feef4lp+1eJCI9BQ7LfDXSwDBeDXgoWvyCZgq5VK/5mkITrS5pOLty1MobFc78ZfxwgYm4tgWHZ7SqRBVnfr9n+4dn9V6AEnfrsMjNZ5ovZtBqrcsp4izQTQFlsMlx/c2EQU9TM4yxdanzuwl3MrHUDauiTfiEn6oMqHDJ9G92Okv/qQCFzdnlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WZKiUT/4/4PcFNg9/2UZY+wGYrC7lkJlSpduT3lLk8w=;
 b=mksfrtG7+n6bD5AQYC+YhF3zuQBILCI1D6OdWo2zNo2+VhYI8nq7taYmRB39pBaOUE1s/E3DVXYQWScAi2d3jWEM7fS0VcroCaUEjpXPBMwxtKbQAN6rh+mDlnigqGoM8dCoypZkTHUHZOglD8cb+kZ4pjYYAWAImpU+gvYURKjf0AklCoFfs50+nM7lJMvYfeTTLw4p9C/KUfIiSAizT9TKZAcBo9Fhv41pIIpq4XEdP88VGaBBYyCu2XgAOKwOr4O6t/3tIU2wStYv7nWhhh90LTNmmvKCrTMI11uatzbtfQ/U81p+VCbkxCB6Lhe9j/A//Kn6QPA4YM1UFpCtHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WZKiUT/4/4PcFNg9/2UZY+wGYrC7lkJlSpduT3lLk8w=;
 b=zrLdy9iytkYpllTbIAt/x9jUZiKkAb3vM7AhgXjlgpRCr3RGyYd7ozdNrb/c7Ka2nzfy0kPAVnQx3JRqJV1+E6d5HrGhjMpTBk9+1g7XUxGajxZoRFWNTinbmhierZf56/CMv8Mm0l3p12u2B+Kx9wGUwIV/V5uiCbczzAH9AQ8=
Received: from BN9PR03CA0163.namprd03.prod.outlook.com (2603:10b6:408:f4::18)
 by PH0PR12MB5678.namprd12.prod.outlook.com (2603:10b6:510:14e::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.20; Wed, 24 Jun
 2026 17:56:10 +0000
Received: from BN2PEPF000044A3.namprd02.prod.outlook.com
 (2603:10b6:408:f4:cafe::2c) by BN9PR03CA0163.outlook.office365.com
 (2603:10b6:408:f4::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.20 via Frontend Transport; Wed,
 24 Jun 2026 17:56:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF000044A3.mail.protection.outlook.com (10.167.243.154) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.159.10 via Frontend Transport; Wed, 24 Jun 2026 17:56:10 +0000
Received: from amd-desktop.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 24 Jun
 2026 12:56:04 -0500
From: Shahyan Soltani <shahyan.soltani@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <alexander.deucher@amd.com>, <christian.koenig@amd.com>
Subject: [PATCH v4 4/6] drm/amdgpu: move amdgpu_acpi helpers into new header
Date: Wed, 24 Jun 2026 13:55:05 -0400
Message-ID: <20260624175554.489406-5-shahyan.soltani@amd.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260624175554.489406-1-shahyan.soltani@amd.com>
References: <20260624175554.489406-1-shahyan.soltani@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A3:EE_|PH0PR12MB5678:EE_
X-MS-Office365-Filtering-Correlation-Id: a99aafe8-4f37-4bf6-99ce-08ded219dfb0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|82310400026|1800799024|23010399003|22082099003|18002099003|11063799006|56012099006|3023799007;
X-Microsoft-Antispam-Message-Info: Yi/EcU4MN9ACTRs93JxoeUoN7vBQb1u29bU6QnhK2F96p7/Lz4bBySP4y2/TSNY8MmYfSeukCOJIUjIKcIbz0gs292SVQqi8kvehI1yJS1PJG8QmiTv4rSbhLLXrMreOis93GJrUvJ3Ux5N2bKZCERAD7iXDr8xHqZOgPYfR5NdAad5P9v3/Iulm/TN0YDdL3pFFnL+vjrBaRkhi/b+RYrNip3tnbGbGlPQyqwqRMwxF0N7nGh1x5I2EKCpeTWu3hLrMeV4eK9ZYu/fb4CYXaUl0+PkhhWPFymTdGJRw+YANgH4yevN83U49Feuq1KW3OgrQLkbCj5tmGP0+A8vg1cU/wmfgx/ILCookDoZrgTbbpWKPpXk8Xkmb6CA2KOQG7DJggrG0Plni8lVe/VmtHYPtXFD2Mmm5WGAycyHsLVEMqWnLPtPOg/NleKyvmRPOD7pWZLfpyeKTuH8Nflceyi2bmc00IopX2Xw7eBSoAJphLP4NgzEadETSKyD1df7zliQWpVABgijsljhitKBdcuVKZBBs37mEXfMzfB87Xx1DjphrlvRhofT5tKje8wg3ldjc/3LLWPEW430OH6rfqDuoa1p+xDnxZF7yr+7fAxVd4RnZtaOLMmmQIQhm3Y6rHSGdW06mmExAo6M3+iSM5RuU7BR2v4sYtQHA4mms5S1AfqSmVmEoB/RDTeGLvHbZz2jaG02vZ6xaGv2ao8Tc6w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(82310400026)(1800799024)(23010399003)(22082099003)(18002099003)(11063799006)(56012099006)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Cv/M5RTDIf/VbHZhNzNG7eH24DIMqUbo+RL8o7EYCocYHtBg0pbuEfuwsyFk+LryI45riL0yfn4kI+TaN5TerNlqK4H4/NzdH71zhGy3qXRw2riGt95cEW/bcGCUMyn1zyHa6G+BmhhTXHPJN6n4zloL5NJXXOYrjtmMiPqAinXg4sqIFzYlovs7EUcGqA9hGFoYKa5p+M+hfeREWdm51/W2diXJZwpGEL5MC+HnXSIRao6/nWD6AwwiYjGKTXjezrYjiAZjRI85J2IIS5m98cT4pxJpvFwglfO1fbsiWtQiLdVrc/4YmYo0Act3lBaimwP3aMA6MyBJ4VVN4jlMEV9825bCsK04zd/lmIaewpj/Xe9g5y3+rS/ET0qcXXRCvkI0gcerlJTCe4OepnGtAt4N7ZST6I9GyjkaQ0pZax8fgaofWWG0hzDbiRDmp4m0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2026 17:56:10.1694 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a99aafe8-4f37-4bf6-99ce-08ded219dfb0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044A3.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5678
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
Reviewed-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h      | 122 +-----------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.h | 151 +++++++++++++++++++++++
 2 files changed, 152 insertions(+), 121 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.h

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 2eaf7d570acc..b53d83bbb6ef 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -116,6 +116,7 @@
 #include "amdgpu_ip.h"
 #include "amdgpu_mes.h"
 #include "amdgpu_sa.h"
+#include "amdgpu_acpi.h"
 #include "amdgpu_video_codecs.h"
 #if defined(CONFIG_DRM_AMD_ISP)
 #include "amdgpu_isp.h"
@@ -138,13 +139,6 @@ struct amdgpu_mgpu_info {
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
@@ -548,38 +542,6 @@ struct amdgpu_uid {
 	struct amdgpu_device *adev;
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
@@ -1328,88 +1290,6 @@ struct amdgpu_afmt_acr {
 
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

