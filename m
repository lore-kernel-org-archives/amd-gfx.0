Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8524CDB476
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Jun 2026 19:57:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7B66F10E848;
	Mon, 22 Jun 2026 19:57:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="OZb2jL0a";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010063.outbound.protection.outlook.com [52.101.46.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E620F10E81F
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Jun 2026 19:57:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fXtSGwxBGR7MBUbFW1DS2cB7yEYS5a3peDHtwj0LAX9TTtKiZ+opDr6YAWTJbTNo4UomC3NoN2iDWAwcnvTaAdjr85RYMxCu64oRf9/67aAcgqvUqdqCcNiiy1/x3puhX6tQtkvMRY8yny5suqBTJRyvMF8bNQ5GK1n/LZ9EnJ8iemq3J6MYZzWynWM2h8m2FcmH1furJHaHCmtNxLCNEMPqLVGgrLs9N6CBK/4xCQzLpoXcE/HhD5y8p9laPDkhi5Pdu9Adx8H3B7qxl4hWQxiqBsxX3I1to8fEw7CsZ4hlSgFhDmiovEkOf4GhT9SoM6WsYowRayvYgh/yyYYDUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CiUXBgRfwSMbMZKFd8BziO4M1o6Xd3eOIXGrOEM6UNg=;
 b=c9Xjvf7CMZBYPTDlYOa3c+mCm4aeOAZDJOItrMoKCpkcrtmrRVj3WZZzBdqZP7hRHRwZu/20pk4O5Pe3ggdaWTLUk0qebhWN+tEJ9pBqN+9cFqLS0eUbDNNd0UPnbPMRbEFr8kaiHPvA5Y8fYzrfMukjLaxox3DdHjhZm7a9je9/k8oQqAYQb2TP5jd4Uvh8PknzXDq3rPIoyA+0sC68V1Ug7abs/uI1eyEjAGt9tHLYMTjhZXSD9u6MQeyAbDCwWi9lC9ByCGqRUFbV/SNukQ7Haio9v58B5pMAAa9Z+El9AfWxAzsZx43VhF46v8SiWqaPGARPgtqJm4PVKS6Gmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CiUXBgRfwSMbMZKFd8BziO4M1o6Xd3eOIXGrOEM6UNg=;
 b=OZb2jL0a0JDw3GvAR1fCJ1GNdLjfFgePsWP4iG4IlgsL/8v0HWAgSxZydxprS370JadrDyh/DwH52aiHn5D8p+cYiLGemjc6LJd4bld9K3xJMMMqiypE66HUHa5FQLVZWkuoAh4QUrJCBDRkVYaNrIiBFhBlwU3wXDR4maGnCm4=
Received: from PH1PEPF000132E5.NAMP220.PROD.OUTLOOK.COM (2603:10b6:518:1::25)
 by CH1PR12MB9696.namprd12.prod.outlook.com (2603:10b6:610:2b0::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.20; Mon, 22 Jun
 2026 19:57:47 +0000
Received: from CY4PEPF0000FCC3.namprd03.prod.outlook.com
 (2a01:111:f403:f910::1) by PH1PEPF000132E5.outlook.office365.com
 (2603:1036:903:47::3) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.14 via Frontend Transport; Mon,
 22 Jun 2026 19:57:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000FCC3.mail.protection.outlook.com (10.167.242.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.139.8 via Frontend Transport; Mon, 22 Jun 2026 19:57:46 +0000
Received: from amd-desktop.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 22 Jun
 2026 14:57:44 -0500
From: Shahyan Soltani <shahyan.soltani@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <alexander.deucher@amd.com>, <christian.koenig@amd.com>
Subject: [PATCH v3 5/8] drm/amdgpu: move amdgpu_acpi helpers into new header
Date: Mon, 22 Jun 2026 15:57:26 -0400
Message-ID: <20260622195729.181216-6-shahyan.soltani@amd.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260622195729.181216-1-shahyan.soltani@amd.com>
References: <20260622195729.181216-1-shahyan.soltani@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC3:EE_|CH1PR12MB9696:EE_
X-MS-Office365-Filtering-Correlation-Id: 3b6d324a-a5a2-4f02-9525-08ded0988822
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|1800799024|376014|23010399003|3023799007|18002099003|22082099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: eO86e9VMr2f8irp2L+rici8BARfA5EneErE9vza8ZRkOMG8mxMIPz25Id5hJVB0D2ZvDbnm6PV5f4f0U2t8HtkX0cGjDthvhvi5/XeAxSOUuF0Je5BrRQjEri57Vv53xVu0+YlgYr1PPLAKtjxjsW1m7BSzuhoz7pPD19e9lOizD5vY1ytVsZA47eDJIY7D0UrvY0QwF0rh0om8nKq3n+fSUDjhDVMaQo8AlSMenHiwVG4OaFvO05eBTK7xrbOn4AuXQRB9Ae+JwU3YvrxDlBI+euL+ilLEns5UqlzU/uIk5+x0XUS3T7YMhg3OLd5wBAoz4bM7vjCuvfjnVTgIphxO0d6ou4Uy0mbZKLYDKkOmprMKf7q/NEBC8bm4UuhEgdSLZUYYGdQEX/iTS/MtIj1qSg0oac9hvggBAaPHPhzRVqxJwzQaUhWsvEbLj10u+YjLW1qBVQXOSLD75dsL0k37VBFwX0Tpp3wybbvO9YxmxagIMq2ppfFeAAANPz8F2xUQgmWl8Ln1JI0VkYBBHcqlIFa5MXdx/heXs8SNCK2tImvARkmGxsc6vcL0iJ64tGxGLclHKBRmuhmPrNySEfVzOaerINbhwbkhyvBytvDOwLEyBsLMxHA8SXuXoQnDKEymM+GaEuU9i9cByWY2y7DNpGYoaYghMyght+IJsbVUnRA5EMDNaWhjJIyFyMX0vFRf3EkYQIZdQ10qPsH0J/A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(1800799024)(376014)(23010399003)(3023799007)(18002099003)(22082099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: UaqYnGj5dx1ttkdg9KBgsZd7pA1lCLrVi/IwdEPMG3UcmboH8BawMjkBC4DQkFVytzF/Ys3VLCZ3guzohdiGXhc5cvsQMYNjyCbQ1nMsIUbHrE3vbc0Aa5JKqs25xvpmitTc/G74ic4IQOIAkqAL6nFUsmeUU/gCu08Y6oJ/pXc0v+5kEFeiip3LCO6VcAd24qkk7yEbJaKdDh8D/iDg8Rtm9cKjacwMCZfnIWrRsuWLwwgdYZH+SpKdgESF3H9QV3UGf6J33coe97XcwxED2lkcWHKfDQ81B2azJhO4BOW6poZDPas19eYgeYpiVLbX4phV6n+Qazp9zOBls85tRs3THpaTXEvNgloG4qcG2Db6M5LDj92z9h8SKlwmsawA3irU2saKwqI8so3aKT64NhVU8dR4aNOw0frQgDEAVuMS+QOSU6CtPnqiW7ne0tcP
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2026 19:57:46.9865 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b6d324a-a5a2-4f02-9525-08ded0988822
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000FCC3.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PR12MB9696
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
index ca86cef62f44..24c6a21efd67 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -116,6 +116,7 @@
 #include "amdgpu_ip.h"
 #include "amdgpu_mes.h"
 #include "amdgpu_sa.h"
+#include "amdgpu_acpi.h"
 #include "amdgpu_uid.h"
 #include "amdgpu_video_codecs.h"
 #if defined(CONFIG_DRM_AMD_ISP)
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
@@ -533,38 +527,6 @@ struct amdgpu_mmio_remap {
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
@@ -1312,88 +1274,6 @@ struct amdgpu_afmt_acr {
 
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

