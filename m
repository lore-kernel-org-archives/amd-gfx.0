Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFD40CCF9F1
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Oct 2025 17:54:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 890E510E80F;
	Wed, 29 Oct 2025 17:54:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="txDbLvSP";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012049.outbound.protection.outlook.com [40.107.209.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E56EB10E812
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Oct 2025 17:54:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Faf3QcXFwHdnAEZW8ZcuJ8uFxbqwZsodalQfeiN8YshiL8nPOXV2gYV0KwUfOxKUo2bX0Ru6CxDz9/nybgxzrbh6kNQfOAUNv7rngmB7lfT9L7S62rBVa3Tz1Nb/W5mRPRDcqfI7j4dNKN5BmK7g9djspgxa3LUTQnIJ4xz5L174UAF70QoT1eQGKxzRssJic8utMg37r5gBuwL9bzzeFXDRcErj9PG8mNKmDeKlkfYoAkFxjueu5NlSfUt8oHfNPRnlX8FlbubshVmQxnNZBOszX+UlfOT6hfWNLWHXvZDRhsJI8rqJS/kPZAmZuA3OYQDV74XSAamBaA/0CUs/Sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SPGfpwo7NZN1M5+ZNwq/xvMrQhIbOXoO28pNqTn8mdI=;
 b=GlDpga11LrpMeOiQBikVz9NuBmxfDD+TZk17qhWrLbhb/9eYusduUH5Dkl/CmwkVHNgrMD8nwLqHySRnB5tKMXy4nxpY8bTo7OAG/LFtisG5S62jqrLFGdTV/B+cWhd4WTvc6GfZVICUAg6yzlfyXlPpGg1+uUfEQAu5/GUuwQyGdg+TY9B5DDcGyHQlhg1jRBQU95dwZI0aCZVeCdwnrNhk3FRva61HL3EOy52jjH7iPbU2g8BET3u7mguEKbyF7d10OfjVpJQi0hB3AkO8sldUy8vVB+d9mDEddrmF29g7pksevaaao6SY7Va/IPvLYqPEVg8MmykSfJEI8hAodw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SPGfpwo7NZN1M5+ZNwq/xvMrQhIbOXoO28pNqTn8mdI=;
 b=txDbLvSPc/gYnRJzCgFz6a9ZTdCOIU/reEb3gzdfjwF3u5XSJMkSgg/jAqFm5XJOvUo4iwcSiNQrzq/Ci8j9KNCLKth+QLWw8+qwVwPOkfmgEWMcAbP8ran96CyqtW4UnIM19g+qoIDDFikPYt94uKXbjB+w7J7XsG3XFVqqvB8=
Received: from MN0PR04CA0012.namprd04.prod.outlook.com (2603:10b6:208:52d::31)
 by CH3PR12MB9100.namprd12.prod.outlook.com (2603:10b6:610:1a8::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.14; Wed, 29 Oct
 2025 17:54:09 +0000
Received: from BL02EPF0001A108.namprd05.prod.outlook.com
 (2603:10b6:208:52d:cafe::94) by MN0PR04CA0012.outlook.office365.com
 (2603:10b6:208:52d::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.14 via Frontend Transport; Wed,
 29 Oct 2025 17:54:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF0001A108.mail.protection.outlook.com (10.167.241.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.10 via Frontend Transport; Wed, 29 Oct 2025 17:54:09 +0000
Received: from tr4.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 29 Oct
 2025 10:54:08 -0700
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Hawking Zhang <Hawking.Zhang@amd.com>, Le Ma <le.ma@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>
Subject: [PATCH 2/4] drm/amdgpu: Add smuio v14_0_3 support v4
Date: Wed, 29 Oct 2025 13:53:51 -0400
Message-ID: <20251029175353.2861924-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251029175353.2861924-1-alexander.deucher@amd.com>
References: <20251029175353.2861924-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A108:EE_|CH3PR12MB9100:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a623c50-68ae-4930-3da7-08de1714297d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?s7KyMcJ36bYeMu08Dbqvq/NgFHGIzPvELuv4oeLoua/PpTOm+1oGt9uM/bgz?=
 =?us-ascii?Q?pUC+0U9/ioybaV7yMv/msDsrO1sjKhWPzhM6gJ3pTnQ6yhweEZ+jA0YVJ3WD?=
 =?us-ascii?Q?m/l+Km4LORhtJh3z+RWSERNkmKfgCC6UKczfcDic4le90vWiPaifXPfhRZ77?=
 =?us-ascii?Q?NXJxPmyS6JEK/ua3Yo0o37RugxtL7IfnCpVZu4bj/b8wK/9KtJrv49NIrUcw?=
 =?us-ascii?Q?Bnu2AREyOu1wdKttQqJe4pTO191CoA6aVGG1nNPfCuXZwgWtTFR7Z4QrUptt?=
 =?us-ascii?Q?U9ZXz5j1pyc6RooNaHsu7nTfVE5nI8MvMt8BCOeyX0cSxax8KRA/7tgTYs5L?=
 =?us-ascii?Q?GLSRaf/ovh3T/2S5K3375scafp6rZ+V2SQAncGqafyPUYt9dvYuwF2jfYXYv?=
 =?us-ascii?Q?+SCpXjr+TKPBuv2Zn7Mq+ckSZ9dUE23TKB+ZjeKbHKgXLFCYawj+WAHvuPQc?=
 =?us-ascii?Q?+PVH+DjR8yHFV5mktBxpmzk8UD88CgoVDGF08gEyAmm4tqXIzzcktviZ2EVj?=
 =?us-ascii?Q?cHFb8Y3nvAZM3TX7ewJgWX0AZ+fw//OupePWL2Q1mMArec6U20rE0HlWHvUv?=
 =?us-ascii?Q?SJ+aXiwLTHJdilshPnPBAo5SZjSP4DeU+XkjHveKm9jFEnVp8Ld4J88wqvvi?=
 =?us-ascii?Q?gRioGLarcCslGD1fW5kJIJ0W/A7LUfTXTaTJZRqjy4vuQ1jyvXxc9US7rNth?=
 =?us-ascii?Q?DFokYfnRLRiHNIVN4twqlrsCIJLP6W+CYh3VK4XuGjZp322T2skgeGbX0mpR?=
 =?us-ascii?Q?DOBMjJ10VGt+24cB97TcC0KYQpe6R7xIk3B783ykVPigr4PbZmHiUzHR6Gkm?=
 =?us-ascii?Q?VxTWWcod9jrMQoWnTI2/HOsbf3HzdXNgW00NzqR6gyTDcCzH4ozZ1jKAm82c?=
 =?us-ascii?Q?75MIZ5Ssvx3BSKQy3Ksmbax26wQdWWdyWU6BUEsjGOsAkRQ50Q1SmoGCueK8?=
 =?us-ascii?Q?zsbnakXcdmTO99GFeabAA/JqloQGWNNX/tCYHUgn66JVoyqUP9X46upf2OE1?=
 =?us-ascii?Q?hBY5v5kEmcJMbhFbqx2XBvz8fMexaKKlcBMQKZPgbC7P4MD1PIGMI70Lk56X?=
 =?us-ascii?Q?hhAJ+//0qzZEJHXuBl5n9cM8vnlbZ4Y4XEsKs3SdIl1ZjRAd4z/2ginQXb2u?=
 =?us-ascii?Q?py0MN3IoLdjNQ1e26Std5x0/f/FyKBskJ0se6JZBbAS3/zEyePioMcpv+O4w?=
 =?us-ascii?Q?q1n28Ky4AXxr9s7HIF6Cw2+h67YP2mF1E/qKK83+4PX2A/A8ZJqt209QYDgh?=
 =?us-ascii?Q?t+y/aLxZ2gEnEQyI0ZNPpWMcsAYPBtUOd0BstUFk4Q0KL8n0C4CLEdvLDAEd?=
 =?us-ascii?Q?p8hmWEgJue0cy72PE54duBKk0a6S7RRAr98fueGPOo6tGGsHI+5kNpF9OZCv?=
 =?us-ascii?Q?2JOklTJO7rGsRMI7FQV0OfVar32rVPwznEhM/+WYNwhbr2iGoHTQajbQKPHj?=
 =?us-ascii?Q?KUTLcWRmHKXLv2Jva9Ce54hKf/hD6ICKfXpfGd0xIyJZq1DHtrmdhCmm/1t7?=
 =?us-ascii?Q?oXzgIXzqrVv/UeUGQSO/DU71HA5rqlzv/rgp1CTRb9Rt97dVvLC4cnzKbgds?=
 =?us-ascii?Q?eriMwzHaPWLrxJg3lt8=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2025 17:54:09.5561 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a623c50-68ae-4930-3da7-08de1714297d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A108.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9100
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

From: Hawking Zhang <Hawking.Zhang@amd.com>

v14_0_3 is a new generation smuio ip block
v2: Add smuio callbacks for interface id
v3: Add smuio callback to identify custom hbm
v4: comment out unused functions (Alex)

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
Reviewed-by: Le Ma <le.ma@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/Makefile        |   3 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_smuio.h  |   3 +
 drivers/gpu/drm/amd/amdgpu/smuio_v14_0_3.c | 193 +++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/smuio_v14_0_3.h |  30 ++++
 4 files changed, 228 insertions(+), 1 deletion(-)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/smuio_v14_0_3.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/smuio_v14_0_3.h

diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile b/drivers/gpu/drm/amd/amdgpu/Makefile
index ebe08947c5a32..b408a981f4b03 100644
--- a/drivers/gpu/drm/amd/amdgpu/Makefile
+++ b/drivers/gpu/drm/amd/amdgpu/Makefile
@@ -244,7 +244,8 @@ amdgpu-y += \
 	smuio_v13_0.o \
 	smuio_v13_0_3.o \
 	smuio_v13_0_6.o \
-	smuio_v14_0_2.o
+	smuio_v14_0_2.o \
+	smuio_v14_0_3.o
 
 # add reset block
 amdgpu-y += \
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_smuio.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_smuio.h
index ec9d12f85f39f..124b13a68f3f3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_smuio.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_smuio.h
@@ -27,6 +27,7 @@ enum amdgpu_pkg_type {
 	AMDGPU_PKG_TYPE_APU = 2,
 	AMDGPU_PKG_TYPE_CEM = 3,
 	AMDGPU_PKG_TYPE_OAM = 4,
+	AMDGPU_PKG_TYPE_BB  = 5,
 	AMDGPU_PKG_TYPE_UNKNOWN,
 };
 
@@ -44,6 +45,8 @@ struct amdgpu_smuio_funcs {
 	u32 (*get_socket_id)(struct amdgpu_device *adev);
 	enum amdgpu_pkg_type (*get_pkg_type)(struct amdgpu_device *adev);
 	bool (*is_host_gpu_xgmi_supported)(struct amdgpu_device *adev);
+	bool (*is_connected_with_ethernet_switch)(struct amdgpu_device *adev);
+	bool (*is_custom_hbm_supported)(struct amdgpu_device *adev);
 	u64 (*get_gpu_clock_counter)(struct amdgpu_device *adev);
 };
 
diff --git a/drivers/gpu/drm/amd/amdgpu/smuio_v14_0_3.c b/drivers/gpu/drm/amd/amdgpu/smuio_v14_0_3.c
new file mode 100644
index 0000000000000..804b7458b0661
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/smuio_v14_0_3.c
@@ -0,0 +1,193 @@
+/*
+ * Copyright 2025 Advanced Micro Devices, Inc.
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
+#include "amdgpu.h"
+#include "smuio_v14_0_3.h"
+#include "smuio/smuio_14_0_3_offset.h"
+#include "smuio/smuio_14_0_3_sh_mask.h"
+
+#define SMUIO_MCM_CONFIG__HOST_GPU_XGMI_MASK	0x00000001L
+#define SMUIO_MCM_CONFIG__ETHERNET_SWITCH_MASK	0x00000008L
+#define SMUIO_MCM_CONFIG__CUSTOM_HBM_MASK	0x00000001L
+
+static u32 smuio_v14_0_3_get_rom_index_offset(struct amdgpu_device *adev)
+{
+	return SOC15_REG_OFFSET(SMUIO, 0, regROM_INDEX);
+}
+
+static u32 smuio_v14_0_3_get_rom_data_offset(struct amdgpu_device *adev)
+{
+	return SOC15_REG_OFFSET(SMUIO, 0, regROM_DATA);
+}
+
+static void smuio_v14_0_3_update_rom_clock_gating(struct amdgpu_device *adev, bool enable)
+{
+	return;
+}
+
+static void smuio_v14_0_3_get_clock_gating_state(struct amdgpu_device *adev, u64 *flags)
+{
+	u32 data;
+
+	/* CGTT_ROM_CLK_CTRL0 is not available for APU */
+	if (adev->flags & AMD_IS_APU)
+		return;
+
+	data = RREG32_SOC15(SMUIO, 0, regCGTT_ROM_CLK_CTRL0);
+	if (!(data & CGTT_ROM_CLK_CTRL0__SOFT_OVERRIDE0_MASK))
+		*flags |= AMD_CG_SUPPORT_ROM_MGCG;
+}
+
+/**
+ * smuio_v14_0_3_get_die_id - query die id from FCH.
+ *
+ * @adev: amdgpu device pointer
+ *
+ * Returns die id
+ */
+static u32 smuio_v14_0_3_get_die_id(struct amdgpu_device *adev)
+{
+	u32 data, die_id;
+
+	data = RREG32_SOC15(SMUIO, 0, regSMUIO_MCM_CONFIG);
+	die_id = REG_GET_FIELD(data, SMUIO_MCM_CONFIG, DIE_ID);
+
+	return die_id;
+}
+
+/**
+ * smuio_v14_0_3_get_socket_id - query socket id from FCH
+ *
+ * @adev: amdgpu device pointer
+ *
+ * Returns socket id
+ */
+static u32 smuio_v14_0_3_get_socket_id(struct amdgpu_device *adev)
+{
+	u32 data, socket_id;
+
+	data = RREG32_SOC15(SMUIO, 0, regSMUIO_MCM_CONFIG);
+	socket_id = REG_GET_FIELD(data, SMUIO_MCM_CONFIG, SOCKET_ID);
+
+	return socket_id;
+}
+
+/**
+ * smuio_v14_0_3_is_host_gpu_xgmi_supported - detect xgmi interface between cpu and gpu/s.
+ *
+ * @adev: amdgpu device pointer
+ *
+ * Returns true on success or false otherwise.
+ */
+static bool smuio_v14_0_3_is_host_gpu_xgmi_supported(struct amdgpu_device *adev)
+{
+	u32 data;
+
+	data = RREG32_SOC15(SMUIO, 0, regSMUIO_MCM_CONFIG);
+	data = REG_GET_FIELD(data, SMUIO_MCM_CONFIG, TOPOLOGY_ID);
+	/* data[4:0]
+	 * bit 0 == 0 host-gpu interface is PCIE
+	 * bit 0 == 1 host-gpu interface is Alternate Protocal
+	 * for AMD, this is XGMI
+	 */
+	data &= SMUIO_MCM_CONFIG__HOST_GPU_XGMI_MASK;
+
+	return data ? true : false;
+}
+
+#if 0
+/*
+ * smuio_v14_0_3_is_connected_with_ethernet_switch - detect systems connected with ethernet switch
+ *
+ * @adev: amdgpu device pointer
+ *
+ * Returns true on success or false otherwise.
+ */
+static bool smuio_v14_0_3_is_connected_with_ethernet_switch(struct amdgpu_device *adev)
+{
+	u32 data;
+
+	if (!(adev->flags & AMD_IS_APU))
+		return false;
+
+	data = RREG32_SOC15(SMUIO, 0, regSMUIO_MCM_CONFIG);
+	data = REG_GET_FIELD(data, SMUIO_MCM_CONFIG, TOPOLOGY_ID);
+	/* data[4:0]
+	 * bit 3 == 0 systems connected with ethernet switch
+	 */
+	data &= SMUIO_MCM_CONFIG__ETHERNET_SWITCH_MASK;
+
+	return data ? false : true;
+}
+#endif
+
+static enum amdgpu_pkg_type smuio_v14_0_3_get_pkg_type(struct amdgpu_device *adev)
+{
+	enum amdgpu_pkg_type pkg_type;
+	u32 data;
+
+	data = RREG32_SOC15(SMUIO, 0, regSMUIO_MCM_CONFIG);
+	data = REG_GET_FIELD(data, SMUIO_MCM_CONFIG, PKG_TYPE);
+
+	/* data [3:0]
+	 bit 2 and bit 3 identifies the pkg type */
+	switch (data & 0xC) {
+	case 0x0:
+		pkg_type = AMDGPU_PKG_TYPE_BB;
+		break;
+	case 0x8:
+		pkg_type = AMDGPU_PKG_TYPE_CEM;
+		break;
+	default:
+		pkg_type = AMDGPU_PKG_TYPE_UNKNOWN;
+		break;
+	}
+
+	return pkg_type;
+}
+
+#if 0
+static bool smuio_v14_0_3_is_custom_hbm_supported(struct amdgpu_device *adev)
+{
+	u32 data;
+
+	data = RREG32_SOC15(SMUIO, 0, regSMUIO_MCM_CONFIG);
+	data = REG_GET_FIELD(data, SMUIO_MCM_CONFIG, PKG_TYPE);
+
+	/* data [3:0]
+	 * bit 0 identifies custom HBM module */
+	data &= SMUIO_MCM_CONFIG__CUSTOM_HBM_MASK;
+
+	return data ? true : false;
+}
+#endif
+
+const struct amdgpu_smuio_funcs smuio_v14_0_3_funcs = {
+	.get_rom_index_offset = smuio_v14_0_3_get_rom_index_offset,
+	.get_rom_data_offset = smuio_v14_0_3_get_rom_data_offset,
+	.get_die_id = smuio_v14_0_3_get_die_id,
+	.get_socket_id = smuio_v14_0_3_get_socket_id,
+	.is_host_gpu_xgmi_supported = smuio_v14_0_3_is_host_gpu_xgmi_supported,
+	.update_rom_clock_gating = smuio_v14_0_3_update_rom_clock_gating,
+	.get_clock_gating_state = smuio_v14_0_3_get_clock_gating_state,
+	.get_pkg_type = smuio_v14_0_3_get_pkg_type,
+};
diff --git a/drivers/gpu/drm/amd/amdgpu/smuio_v14_0_3.h b/drivers/gpu/drm/amd/amdgpu/smuio_v14_0_3.h
new file mode 100644
index 0000000000000..7387f8d4a61db
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/smuio_v14_0_3.h
@@ -0,0 +1,30 @@
+/*
+ * Copyright 2025 Advanced Micro Devices, Inc.
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
+#ifndef __SMUIO_V14_0_3_H__
+#define __SMUIO_V14_0_3_H__
+
+#include "soc15_common.h"
+
+extern const struct amdgpu_smuio_funcs smuio_v14_0_3_funcs;
+
+#endif /* __SMUIO_V14_0_3_H__ */
-- 
2.51.0

