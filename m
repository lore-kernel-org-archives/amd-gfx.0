Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77E30C04FFE
	for <amd-gfx@archiver.kernel.org>; Mon, 29 Apr 2024 14:34:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8122110F313;
	Mon, 29 Apr 2024 14:34:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="BhYg7ywg";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2088.outbound.protection.outlook.com [40.107.223.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5C80210F313
 for <amd-gfx@lists.freedesktop.org>; Mon, 29 Apr 2024 14:34:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Kh2ErBHj/XCU9pQ3e+uw8m1BnA1P0tWjgGynRrFYs6SymWOozlUGZoXYm49Kn40s9MbEc17VtdC+/6ICKbjKg1tdNl0u5zNe/7z6qa9a2El+wan+69Lg2ynu5X3itpds3xsdn1MFRUVzvDLQTIjWN3Ne+SOiDHXOa0gAu1Y7N7RP+fRC9AnXdrz7lIkZeRZGQMACMZaUuiaGK7scGWeXEtpNplhrQOXk0aOhLl+kf6wTyFCLcNRtlzVitq8/8K7RX7ieTEppVN0qWtZCjUGBRbOKXgZJGOycs1fZnfSXYHkdxxwoj79mb5SpoTXCFO8F3Ilo6mmC4B13bNqI7tP8AQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zDDadGsYol0MfplR3JRr0YrLRz4+9QjSbYWZ/TA3Yxg=;
 b=CpVGwko6r7pn7I5GoZisVK5y8UzJZPAYWgrs8I8twurs4FB2hzWAPhELD3R1H2t0HYO6PBG3bTGCEiZYejjzoCj/VnmNbWkpXWPnJ5vrG/+krTy788gw47oSv5QsmIP88zp/NoJIHjT3JL+qzrFzJvW0+aXmnYyPZpgE+MxqUKLIAVNG1JtK/ASBZDeLJJU2mB4+aK6GsVMFx2SLc+CpTnNw35ejYpvCsasw0P/xSo38K8bD1h+I0BZYM5gGPyS8QSVCP2Hu2WKej/8gICOhjFxRWwiLSxO6dxx0es8UBAhNmG4RzHBoeE4+9x44yrnOnwJhkKLutUy3IateMk49YQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zDDadGsYol0MfplR3JRr0YrLRz4+9QjSbYWZ/TA3Yxg=;
 b=BhYg7ywgJ+p7ATHLxfXxEOO5SJZejhJm/BhYrjnRH9NfyGYbX6Yc7rt2BkUAR7PD2X3KzydXVQ0AvTM+mgW/OwPGZTDAPIjlkBMoC4WuPmT9LilkXde2vOdQJyasdqxICCcgnUk1Bd0syTkX6dYVawgr4LGZmcUJXWQQs4n+KEc=
Received: from BY5PR20CA0033.namprd20.prod.outlook.com (2603:10b6:a03:1f4::46)
 by IA1PR12MB7592.namprd12.prod.outlook.com (2603:10b6:208:428::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.35; Mon, 29 Apr
 2024 14:34:18 +0000
Received: from SJ1PEPF00001CE1.namprd05.prod.outlook.com
 (2603:10b6:a03:1f4:cafe::f4) by BY5PR20CA0033.outlook.office365.com
 (2603:10b6:a03:1f4::46) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.35 via Frontend
 Transport; Mon, 29 Apr 2024 14:34:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CE1.mail.protection.outlook.com (10.167.242.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7544.18 via Frontend Transport; Mon, 29 Apr 2024 14:34:18 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 29 Apr
 2024 09:34:11 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Kenneth Feng <kenneth.feng@amd.com>, Likun Gao <Likun.Gao@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>
Subject: [PATCH 16/31] drm/amd/amdgpu: imu fw loading support
Date: Mon, 29 Apr 2024 10:33:24 -0400
Message-ID: <20240429143339.3450256-16-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240429143339.3450256-1-alexander.deucher@amd.com>
References: <20240429143339.3450256-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE1:EE_|IA1PR12MB7592:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d1dff5e-0ff7-4900-8006-08dc685973a4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|82310400014|36860700004|376005|1800799015; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ftyaeDGteG6NwK8NzQ9RkYnWuZjwhNH9l+Wd28vBj/EI2ETAsX/3mS8GgxC2?=
 =?us-ascii?Q?U9416YEHpCdaOnfJGsAlWjLsnI1+a4RRQhmR/j/FcgkK1oToyNHqaW4r929c?=
 =?us-ascii?Q?oVJaNDhbrifX5P6B2nRmNMk3jDr7XMBvX4zUCJsg+akQGk9Z5yMZ8AdD5Pjf?=
 =?us-ascii?Q?l3ppavoFQI17SfS6iHQbDnRDWzmaMNAwp/A1zIZOVo5GcfRAi1fz2W9MK5bC?=
 =?us-ascii?Q?enGHiofNba6Y4HNCRPriuuZy5U1CkS/gpuS23Oi0Nd/XpHfpgaNGVu5xo9KS?=
 =?us-ascii?Q?4WI8JoeDUjHOxLk5u37RBwelGNp5Z/lhkQiSCseHCmvTRne56ifGQfM1KhYv?=
 =?us-ascii?Q?HlNS+Ti14/mLVLXJ4+by8Q2CEulNp99AgyqTIU/zaMiacv3VGRIkqAyz7bBM?=
 =?us-ascii?Q?D5f6UHTYEBwIDMJFCHbiep0Ag3MXfNztE8bjLfwjzapMdE+V4AwrUbh7iN73?=
 =?us-ascii?Q?TH3+d+gM7W9jJrAEEefd57ovrqkq+ncHHylXIK0iDwngcA/2kHyiwvJg6I/e?=
 =?us-ascii?Q?pXP9tq8+fa1D2BMh/8n1sbdDJ5R2FgxQaowcK4Dxzq5wuT5K/I/vS9VpV5R4?=
 =?us-ascii?Q?JC9ub8ddODgeHFxl/uTTcF38+NlilVBbJ9qx67ogNNQLdi931POeOC71BGQH?=
 =?us-ascii?Q?VRldSz6crKYph0Wj6uvl6yQJPjPLqWzLxeIesdnt4J9Tj/7pxqS78T+Q2EAu?=
 =?us-ascii?Q?/USLZE0OoXAnLyrbOlD0UPERjL57lI2A8/YRctvtqdCvGDF3yBKRhWebCOl9?=
 =?us-ascii?Q?YuOiwzf3qtZYBOykF+BwAnHsV1QkwNsX6dYB5onA3R4vUmEaQNE0pOk1CTzX?=
 =?us-ascii?Q?Ex4WjZp6skfMw0ypSp7Am1U03dEKRxkQPFdx1lTKS5eRa8JDKPDgEld+rZAD?=
 =?us-ascii?Q?MJuURy7pCZriifma/arLF768CAJ7/5NoxJCdTk/flvYwV+6vIRfj6macSCio?=
 =?us-ascii?Q?gPIos2UTjYffRLRdxeNEBfTFv+vnnSzmD2Mw6KtRMdQlTxJ893vhEwiq0gr8?=
 =?us-ascii?Q?2idiemq/0UZcFMM89rA0YQzbLJV3M29ZtqwKYk9TVbHqoiOSPjsE/HEXLjBn?=
 =?us-ascii?Q?zV5nVeoamDe/wE73re4rfY6hmtIwrjCE7nEZn+HSB/1ufApLzTsvOOGzCTrq?=
 =?us-ascii?Q?JtK20ErWU4MMMRXtY8SRk03KAld8kYTzau/sM5mIabNfhawlp3DsnqBpwo18?=
 =?us-ascii?Q?cNIK4JkhxRgDAPCjCELbyF8sT50Jl+Wj14s0ua3GER/vqKDS/VlE9mtQw1ce?=
 =?us-ascii?Q?I6PnGuu/Xx6eEQkgjXnJ07DiwEbYdxP5Cbm3Y5sqfpofBe/Mepd3rDGwcHo1?=
 =?us-ascii?Q?TTCJFKe04Gc+bUhZZqQVMTQ2euz5gDH0P4M4fQk8zBNdhb+h3JIagjRdq12t?=
 =?us-ascii?Q?gmTTJFI=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400014)(36860700004)(376005)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2024 14:34:18.0056 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d1dff5e-0ff7-4900-8006-08dc685973a4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CE1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7592
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

From: Kenneth Feng <kenneth.feng@amd.com>

support imu related function for gfx v12.

Signed-off-by: Kenneth Feng <kenneth.feng@amd.com>
Signed-off-by: Likun Gao <Likun.Gao@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/Makefile    |   3 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c |   4 +-
 drivers/gpu/drm/amd/amdgpu/imu_v12_0.c | 303 +++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/imu_v12_0.h |  30 +++
 4 files changed, 337 insertions(+), 3 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/imu_v12_0.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/imu_v12_0.h

diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile b/drivers/gpu/drm/amd/amdgpu/Makefile
index a6b5cb32ddf9a..099a47b3e0496 100644
--- a/drivers/gpu/drm/amd/amdgpu/Makefile
+++ b/drivers/gpu/drm/amd/amdgpu/Makefile
@@ -168,7 +168,8 @@ amdgpu-y += \
 	gfx_v11_0.o \
 	gfx_v11_0_3.o \
 	imu_v11_0_3.o \
-	gfx_v12_0.o
+	gfx_v12_0.o \
+	imu_v12_0.o
 
 # add async DMA block
 amdgpu-y += \
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
index afb977e1dfc81..1253053d10339 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
@@ -30,6 +30,7 @@
 #include "amdgpu_psp.h"
 #include "amdgpu_smu.h"
 #include "amdgpu_atomfirmware.h"
+#include "imu_v12_0.h"
 #include "soc24.h"
 #include "nvd.h"
 
@@ -4523,8 +4524,7 @@ static void gfx_v12_0_set_imu_funcs(struct amdgpu_device *adev)
 	else
 		adev->gfx.imu.mode = DEBUG_MODE;
 
-	/* TODO */
-	//adev->gfx.imu.funcs = &gfx_v12_0_imu_funcs;
+	adev->gfx.imu.funcs = &gfx_v12_0_imu_funcs;
 }
 
 static void gfx_v12_0_set_rlc_funcs(struct amdgpu_device *adev)
diff --git a/drivers/gpu/drm/amd/amdgpu/imu_v12_0.c b/drivers/gpu/drm/amd/amdgpu/imu_v12_0.c
new file mode 100644
index 0000000000000..be140ee4d9173
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/imu_v12_0.c
@@ -0,0 +1,303 @@
+/*
+ * Copyright 2023 Advanced Micro Devices, Inc.
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
+#include <linux/firmware.h>
+#include "amdgpu.h"
+#include "amdgpu_imu.h"
+#include "amdgpu_dpm.h"
+
+#include "imu_v12_0.h"
+
+#include "gc/gc_12_0_0_offset.h"
+#include "gc/gc_12_0_0_sh_mask.h"
+
+MODULE_FIRMWARE("amdgpu/gc_12_0_1_imu.bin");
+
+static int imu_v12_0_init_microcode(struct amdgpu_device *adev)
+{
+	char fw_name[40];
+	char ucode_prefix[30];
+	int err;
+	const struct imu_firmware_header_v1_0 *imu_hdr;
+	struct amdgpu_firmware_info *info = NULL;
+
+	DRM_DEBUG("\n");
+
+	amdgpu_ucode_ip_version_decode(adev, GC_HWIP, ucode_prefix, sizeof(ucode_prefix));
+
+	snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_imu.bin", ucode_prefix);
+	err = amdgpu_ucode_request(adev, &adev->gfx.imu_fw, fw_name);
+	if (err)
+		goto out;
+	imu_hdr = (const struct imu_firmware_header_v1_0 *)adev->gfx.imu_fw->data;
+	adev->gfx.imu_fw_version = le32_to_cpu(imu_hdr->header.ucode_version);
+
+	if (adev->firmware.load_type == AMDGPU_FW_LOAD_PSP) {
+		info = &adev->firmware.ucode[AMDGPU_UCODE_ID_IMU_I];
+		info->ucode_id = AMDGPU_UCODE_ID_IMU_I;
+		info->fw = adev->gfx.imu_fw;
+		adev->firmware.fw_size +=
+			ALIGN(le32_to_cpu(imu_hdr->imu_iram_ucode_size_bytes), PAGE_SIZE);
+		info = &adev->firmware.ucode[AMDGPU_UCODE_ID_IMU_D];
+		info->ucode_id = AMDGPU_UCODE_ID_IMU_D;
+		info->fw = adev->gfx.imu_fw;
+		adev->firmware.fw_size +=
+			ALIGN(le32_to_cpu(imu_hdr->imu_dram_ucode_size_bytes), PAGE_SIZE);
+	}
+
+out:
+	if (err) {
+		dev_err(adev->dev,
+			"gfx12: Failed to load firmware \"%s\"\n",
+			fw_name);
+		amdgpu_ucode_release(&adev->gfx.imu_fw);
+	}
+
+	return err;
+}
+
+static int imu_v12_0_load_microcode(struct amdgpu_device *adev)
+{
+	const struct imu_firmware_header_v1_0 *hdr;
+	const __le32 *fw_data;
+	unsigned i, fw_size;
+
+	if (!adev->gfx.imu_fw)
+		return -EINVAL;
+
+	hdr = (const struct imu_firmware_header_v1_0 *)adev->gfx.imu_fw->data;
+
+	fw_data = (const __le32 *)(adev->gfx.imu_fw->data +
+			le32_to_cpu(hdr->header.ucode_array_offset_bytes));
+	fw_size = le32_to_cpu(hdr->imu_iram_ucode_size_bytes) / 4;
+
+	WREG32_SOC15(GC, 0, regGFX_IMU_I_RAM_ADDR, 0);
+
+	for (i = 0; i < fw_size; i++)
+		WREG32_SOC15(GC, 0, regGFX_IMU_I_RAM_DATA, le32_to_cpup(fw_data++));
+
+	WREG32_SOC15(GC, 0, regGFX_IMU_I_RAM_ADDR, adev->gfx.imu_fw_version);
+
+	fw_data = (const __le32 *)(adev->gfx.imu_fw->data +
+			le32_to_cpu(hdr->header.ucode_array_offset_bytes) +
+			le32_to_cpu(hdr->imu_iram_ucode_size_bytes));
+	fw_size = le32_to_cpu(hdr->imu_dram_ucode_size_bytes) / 4;
+
+	WREG32_SOC15(GC, 0, regGFX_IMU_D_RAM_ADDR, 0);
+
+	for (i = 0; i < fw_size; i++)
+		WREG32_SOC15(GC, 0, regGFX_IMU_D_RAM_DATA, le32_to_cpup(fw_data++));
+
+	WREG32_SOC15(GC, 0, regGFX_IMU_D_RAM_ADDR, adev->gfx.imu_fw_version);
+
+	return 0;
+}
+
+static int imu_v12_0_wait_for_reset_status(struct amdgpu_device *adev)
+{
+	int i, imu_reg_val = 0;
+
+	for (i = 0; i < adev->usec_timeout; i++) {
+		imu_reg_val = RREG32_SOC15(GC, 0, regGFX_IMU_GFX_RESET_CTRL);
+		if ((imu_reg_val & 0x1f) == 0x1f)
+			break;
+		udelay(1);
+	}
+
+	if (i >= adev->usec_timeout) {
+		dev_err(adev->dev, "init imu: IMU start timeout\n");
+		return -ETIMEDOUT;
+	}
+
+	return 0;
+}
+
+static void imu_v12_0_setup(struct amdgpu_device *adev)
+{
+	int imu_reg_val;
+
+	WREG32_SOC15(GC, 0, regGFX_IMU_C2PMSG_ACCESS_CTRL0, 0xffffff);
+	WREG32_SOC15(GC, 0, regGFX_IMU_C2PMSG_ACCESS_CTRL1, 0xffff);
+
+	if (adev->gfx.imu.mode == DEBUG_MODE) {
+		imu_reg_val = RREG32_SOC15(GC, 0, regGFX_IMU_C2PMSG_16);
+		imu_reg_val |= 0x1;
+		WREG32_SOC15(GC, 0, regGFX_IMU_C2PMSG_16, imu_reg_val);
+	}
+}
+
+static int imu_v12_0_start(struct amdgpu_device *adev)
+{
+	int imu_reg_val;
+
+	imu_reg_val = RREG32_SOC15(GC, 0, regGFX_IMU_CORE_CTRL);
+	imu_reg_val &= 0xfffffffe;
+	WREG32_SOC15(GC, 0, regGFX_IMU_CORE_CTRL, imu_reg_val);
+
+	if (adev->flags & AMD_IS_APU)
+		amdgpu_dpm_set_gfx_power_up_by_imu(adev);
+
+	return imu_v12_0_wait_for_reset_status(adev);
+}
+
+static const struct imu_rlc_ram_golden imu_rlc_ram_golden_12_0_1[] = {
+	IMU_RLC_RAM_GOLDEN_VALUE(GC, 0, regCH_PIPE_STEER, 0x1e4, 0x1c0000),
+	IMU_RLC_RAM_GOLDEN_VALUE(GC, 0, regGL1X_PIPE_STEER, 0x1e4, 0x1c0000),
+	IMU_RLC_RAM_GOLDEN_VALUE(GC, 0, regGL1_PIPE_STEER, 0x1e4, 0x1c0000),
+	IMU_RLC_RAM_GOLDEN_VALUE(GC, 0, regGL2_PIPE_STEER_0, 0x13571357, 0x1c0000),
+	IMU_RLC_RAM_GOLDEN_VALUE(GC, 0, regGL2_PIPE_STEER_1, 0x64206420, 0x1c0000),
+	IMU_RLC_RAM_GOLDEN_VALUE(GC, 0, regGL2_PIPE_STEER_2, 0x2460246, 0x1c0000),
+	IMU_RLC_RAM_GOLDEN_VALUE(GC, 0, regGL2_PIPE_STEER_3, 0x75317531, 0x1c0000),
+	IMU_RLC_RAM_GOLDEN_VALUE(GC, 0, regGL2C_CTRL3, 0xc0d41183, 0x1c0000),
+	IMU_RLC_RAM_GOLDEN_VALUE(GC, 0, regSDMA0_CHICKEN_BITS, 0x507d1c0, 0x1c0000),
+	IMU_RLC_RAM_GOLDEN_VALUE(GC, 0, regSDMA1_CHICKEN_BITS, 0x507d1c0, 0x1c0000),
+	IMU_RLC_RAM_GOLDEN_VALUE(GC, 0, regCP_RB_WPTR_POLL_CNTL, 0x600100, 0x1c0000),
+	IMU_RLC_RAM_GOLDEN_VALUE(GC, 0, regGC_EA_CPWD_SDP_CREDITS, 0x3f7fff, 0x1c0000),
+	IMU_RLC_RAM_GOLDEN_VALUE(GC, 0, regGC_EA_SE_SDP_CREDITS, 0x3f7ebf, 0x1c0000),
+	IMU_RLC_RAM_GOLDEN_VALUE(GC, 0, regGC_EA_CPWD_SDP_TAG_RESERVE0, 0x2e00000, 0x1c0000),
+	IMU_RLC_RAM_GOLDEN_VALUE(GC, 0, regGC_EA_CPWD_SDP_TAG_RESERVE1, 0x1a078, 0x1c0000),
+	IMU_RLC_RAM_GOLDEN_VALUE(GC, 0, regGC_EA_CPWD_SDP_TAG_RESERVE2, 0x0, 0x1c0000),
+	IMU_RLC_RAM_GOLDEN_VALUE(GC, 0, regGC_EA_SE_SDP_TAG_RESERVE0, 0x0, 0x1c0000),
+	IMU_RLC_RAM_GOLDEN_VALUE(GC, 0, regGC_EA_SE_SDP_TAG_RESERVE1, 0x12030, 0x1c0000),
+	IMU_RLC_RAM_GOLDEN_VALUE(GC, 0, regGC_EA_SE_SDP_TAG_RESERVE2, 0x0, 0x1c0000),
+	IMU_RLC_RAM_GOLDEN_VALUE(GC, 0, regGC_EA_CPWD_SDP_VCC_RESERVE0, 0x19041000, 0x1c0000),
+	IMU_RLC_RAM_GOLDEN_VALUE(GC, 0, regGC_EA_CPWD_SDP_VCC_RESERVE1, 0x80000000, 0x1c0000),
+	IMU_RLC_RAM_GOLDEN_VALUE(GC, 0, regGC_EA_SE_SDP_VCC_RESERVE0, 0x1e080000, 0x1c0000),
+	IMU_RLC_RAM_GOLDEN_VALUE(GC, 0, regGC_EA_SE_SDP_VCC_RESERVE1, 0x80000000, 0x1c0000),
+	IMU_RLC_RAM_GOLDEN_VALUE(GC, 0, regGC_EA_CPWD_SDP_PRIORITY, 0x880, 0x1c0000),
+	IMU_RLC_RAM_GOLDEN_VALUE(GC, 0, regGC_EA_SE_SDP_PRIORITY, 0x8880, 0x1c0000),
+	IMU_RLC_RAM_GOLDEN_VALUE(GC, 0, regGC_EA_CPWD_SDP_ARB_FINAL, 0x17, 0x1c0000),
+	IMU_RLC_RAM_GOLDEN_VALUE(GC, 0, regGC_EA_SE_SDP_ARB_FINAL, 0x77, 0x1c0000),
+	IMU_RLC_RAM_GOLDEN_VALUE(GC, 0, regGC_EA_CPWD_SDP_ENABLE, 0x00000001, 0x1c0000),
+	IMU_RLC_RAM_GOLDEN_VALUE(GC, 0, regGC_EA_SE_SDP_ENABLE, 0x00000001, 0x1c0000),
+	IMU_RLC_RAM_GOLDEN_VALUE(GC, 0, regGCVM_L2_PROTECTION_FAULT_CNTL2, 0x20000, 0x1c0000),
+	IMU_RLC_RAM_GOLDEN_VALUE(GC, 0, regGCMC_VM_APT_CNTL, 0x0c, 0x1c0000),
+	IMU_RLC_RAM_GOLDEN_VALUE(GC, 0, regGCMC_VM_CACHEABLE_DRAM_ADDRESS_END, 0xfffff, 0x1c0000),
+	IMU_RLC_RAM_GOLDEN_VALUE(GC, 0, regGC_EA_CPWD_MISC, 0x0091, 0x1c0000),
+	IMU_RLC_RAM_GOLDEN_VALUE(GC, 0, regGC_EA_SE_MISC, 0x0091, 0x1c0000),
+	IMU_RLC_RAM_GOLDEN_VALUE(GC, 0, regGRBM_GFX_INDEX, 0xe0000000, 0x1c0000),
+	IMU_RLC_RAM_GOLDEN_VALUE(GC, 0, regGCR_GENERAL_CNTL, 0x00008500, 0x1c0000),
+	IMU_RLC_RAM_GOLDEN_VALUE(GC, 0, regPA_CL_ENHANCE, 0x00880007, 0x1c0000),
+	IMU_RLC_RAM_GOLDEN_VALUE(GC, 0, regTD_CNTL, 0x00000001, 0x1c0000),
+	IMU_RLC_RAM_GOLDEN_VALUE(GC, 0, regGRBM_GFX_INDEX, 0x00000000, 0x1c0000),
+	IMU_RLC_RAM_GOLDEN_VALUE(GC, 0, regRMI_GENERAL_CNTL, 0x01e00000, 0x1c0000),
+	IMU_RLC_RAM_GOLDEN_VALUE(GC, 0, regGRBM_GFX_INDEX, 0x00000001, 0x1c0000),
+	IMU_RLC_RAM_GOLDEN_VALUE(GC, 0, regRMI_GENERAL_CNTL, 0x01e00000, 0x1c0000),
+	IMU_RLC_RAM_GOLDEN_VALUE(GC, 0, regGRBM_GFX_INDEX, 0x00000100, 0x1c0000),
+	IMU_RLC_RAM_GOLDEN_VALUE(GC, 0, regRMI_GENERAL_CNTL, 0x01e00000, 0x1c0000),
+	IMU_RLC_RAM_GOLDEN_VALUE(GC, 0, regGRBM_GFX_INDEX, 0x00000101, 0x1c0000),
+	IMU_RLC_RAM_GOLDEN_VALUE(GC, 0, regRMI_GENERAL_CNTL, 0x01e00000, 0x1c0000),
+	IMU_RLC_RAM_GOLDEN_VALUE(GC, 0, regGRBM_GFX_INDEX, 0xe0000000, 0x1c0000),
+	IMU_RLC_RAM_GOLDEN_VALUE(GC, 0, regGB_ADDR_CONFIG, 0x08200545, 0x1c0000),
+	IMU_RLC_RAM_GOLDEN_VALUE(GC, 0, regGRBMH_CP_PERFMON_CNTL, 0x00000000, 0x1c0000),
+	IMU_RLC_RAM_GOLDEN_VALUE(GC, 0, regCB_PERFCOUNTER0_SELECT1, 0x000fffff, 0x1c0000),
+	IMU_RLC_RAM_GOLDEN_VALUE(GC, 0, regCP_DEBUG_2, 0x00020000, 0x1c0000),
+	IMU_RLC_RAM_GOLDEN_VALUE(GC, 0, regCP_CPC_DEBUG, 0x00500010, 0x1c0000),
+	IMU_RLC_RAM_GOLDEN_VALUE(GC, 0, regGCMC_VM_MX_L1_TLB_CNTL, 0x00000500, 0x1c0000),
+	IMU_RLC_RAM_GOLDEN_VALUE(GC, 0, regGCMC_VM_SYSTEM_APERTURE_LOW_ADDR, 0x00000001, 0x1c0000),
+	IMU_RLC_RAM_GOLDEN_VALUE(GC, 0, regGCMC_VM_SYSTEM_APERTURE_HIGH_ADDR, 0x00000000, 0x1c0000),
+	IMU_RLC_RAM_GOLDEN_VALUE(GC, 0, regGCMC_VM_LOCAL_FB_ADDRESS_START, 0x00000000, 0x1c0000),
+	IMU_RLC_RAM_GOLDEN_VALUE(GC, 0, regGCMC_VM_LOCAL_FB_ADDRESS_END, 0x0000000f, 0x1c0000),
+	IMU_RLC_RAM_GOLDEN_VALUE(GC, 0, regGCMC_VM_FB_LOCATION_BASE, 0x00006000, 0x1c0000),
+	IMU_RLC_RAM_GOLDEN_VALUE(GC, 0, regGCMC_VM_FB_LOCATION_TOP, 0x0000600f, 0x1c0000),
+	IMU_RLC_RAM_GOLDEN_VALUE(GC, 0, regGCVM_CONTEXT0_CNTL, 0x00000000, 0x1c0000),
+	IMU_RLC_RAM_GOLDEN_VALUE(GC, 0, regGCVM_CONTEXT1_CNTL, 0x00000000, 0x1c0000),
+	IMU_RLC_RAM_GOLDEN_VALUE(GC, 0, regGCMC_VM_NB_TOP_OF_DRAM_SLOT1, 0xff800000, 0xe0000000),
+	IMU_RLC_RAM_GOLDEN_VALUE(GC, 0, regGCMC_VM_NB_LOWER_TOP_OF_DRAM2, 0x00000001, 0x1c0000),
+	IMU_RLC_RAM_GOLDEN_VALUE(GC, 0, regGCMC_VM_NB_UPPER_TOP_OF_DRAM2, 0x0000ffff, 0x1c0000),
+	IMU_RLC_RAM_GOLDEN_VALUE(GC, 0, regGCMC_VM_AGP_BASE, 0x00000000, 0x1c0000),
+	IMU_RLC_RAM_GOLDEN_VALUE(GC, 0, regGCMC_VM_AGP_BOT, 0x00000002, 0x1c0000),
+	IMU_RLC_RAM_GOLDEN_VALUE(GC, 0, regGCMC_VM_AGP_TOP, 0x00000000, 0x1c0000),
+	IMU_RLC_RAM_GOLDEN_VALUE(GC, 0, regGCVM_L2_PROTECTION_FAULT_CNTL, 0x00001ffc, 0x1c0000),
+	IMU_RLC_RAM_GOLDEN_VALUE(GC, 0, regGCMC_VM_MX_L1_TLB_CNTL, 0x00000551, 0x1c0000),
+	IMU_RLC_RAM_GOLDEN_VALUE(GC, 0, regGCVM_L2_CNTL, 0x00080603, 0x1c0000),
+	IMU_RLC_RAM_GOLDEN_VALUE(GC, 0, regGCVM_L2_CNTL2, 0x00000003, 0x1c0000),
+	IMU_RLC_RAM_GOLDEN_VALUE(GC, 0, regGCVM_L2_CNTL3, 0x00100003, 0x1c0000),
+	IMU_RLC_RAM_GOLDEN_VALUE(GC, 0, regGCVM_L2_CNTL5, 0x00003fe0, 0x1c0000),
+	IMU_RLC_RAM_GOLDEN_VALUE(GC, 0, regGCMC_VM_SYSTEM_APERTURE_LOW_ADDR, 0x0003d000, 0x1c0000),
+	IMU_RLC_RAM_GOLDEN_VALUE(GC, 0, regGCMC_VM_SYSTEM_APERTURE_HIGH_ADDR, 0x0003d7ff, 0x1c0000),
+	IMU_RLC_RAM_GOLDEN_VALUE(GC, 0, regGCMC_VM_SYSTEM_APERTURE_DEFAULT_ADDR_LSB, 0, 0x1c0000),
+	IMU_RLC_RAM_GOLDEN_VALUE(GC, 0, regGCMC_VM_SYSTEM_APERTURE_DEFAULT_ADDR_MSB, 0, 0x1c0000)
+};
+
+static void program_imu_rlc_ram(struct amdgpu_device *adev,
+				const struct imu_rlc_ram_golden *regs,
+				const u32 array_size)
+{
+	const struct imu_rlc_ram_golden *entry;
+	u32 reg, data;
+	int i;
+
+	for (i = 0; i < array_size; ++i) {
+		entry = &regs[i];
+		reg =  adev->reg_offset[entry->hwip][entry->instance][entry->segment] + entry->reg;
+		reg |= entry->addr_mask;
+		data = entry->data;
+		if (entry->reg == regGCMC_VM_AGP_BASE)
+			data = 0x00ffffff;
+		else if (entry->reg == regGCMC_VM_AGP_TOP)
+			data = 0x0;
+		else if (entry->reg == regGCMC_VM_FB_LOCATION_BASE)
+			data = adev->gmc.vram_start >> 24;
+		else if (entry->reg == regGCMC_VM_FB_LOCATION_TOP)
+			data = adev->gmc.vram_end >> 24;
+
+		WREG32_SOC15(GC, 0, regGFX_IMU_RLC_RAM_ADDR_HIGH, 0);
+		WREG32_SOC15(GC, 0, regGFX_IMU_RLC_RAM_ADDR_LOW, reg);
+		WREG32_SOC15(GC, 0, regGFX_IMU_RLC_RAM_DATA, data);
+	}
+	//Indicate the latest entry
+	WREG32_SOC15(GC, 0, regGFX_IMU_RLC_RAM_ADDR_HIGH, 0);
+	WREG32_SOC15(GC, 0, regGFX_IMU_RLC_RAM_ADDR_LOW, 0);
+	WREG32_SOC15(GC, 0, regGFX_IMU_RLC_RAM_DATA, 0);
+}
+
+static void imu_v12_0_program_rlc_ram(struct amdgpu_device *adev)
+{
+	u32 reg_data;
+
+	WREG32_SOC15(GC, 0, regGFX_IMU_RLC_RAM_INDEX, 0x2);
+
+	switch (amdgpu_ip_version(adev, GC_HWIP, 0)) {
+	case IP_VERSION(12, 0, 1):
+		program_imu_rlc_ram(adev, imu_rlc_ram_golden_12_0_1,
+				(const u32)ARRAY_SIZE(imu_rlc_ram_golden_12_0_1));
+		break;
+	default:
+		BUG();
+		break;
+	}
+
+	reg_data = RREG32_SOC15(GC, 0, regGFX_IMU_RLC_RAM_INDEX);
+	reg_data |= GFX_IMU_RLC_RAM_INDEX__RAM_VALID_MASK;
+	WREG32_SOC15(GC, 0, regGFX_IMU_RLC_RAM_INDEX, reg_data);
+}
+
+const struct amdgpu_imu_funcs gfx_v12_0_imu_funcs = {
+	.init_microcode = imu_v12_0_init_microcode,
+	.load_microcode = imu_v12_0_load_microcode,
+	.setup_imu = imu_v12_0_setup,
+	.start_imu = imu_v12_0_start,
+	.program_rlc_ram = imu_v12_0_program_rlc_ram,
+	.wait_for_reset_status = imu_v12_0_wait_for_reset_status,
+};
diff --git a/drivers/gpu/drm/amd/amdgpu/imu_v12_0.h b/drivers/gpu/drm/amd/amdgpu/imu_v12_0.h
new file mode 100644
index 0000000000000..a1f50cb1aeab7
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/imu_v12_0.h
@@ -0,0 +1,30 @@
+/*
+ * Copyright 2021 Advanced Micro Devices, Inc.
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
+#ifndef __IMU_V12_0_H__
+#define __IMU_V12_0_H__
+
+extern const struct amdgpu_imu_funcs gfx_v12_0_imu_funcs;
+
+#endif
+
-- 
2.44.0

