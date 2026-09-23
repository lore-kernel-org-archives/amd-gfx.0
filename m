Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CC30C9830B
	for <amd-gfx@archiver.kernel.org>; Wed, 23 Sep 2026 15:12:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BEAF910E50A;
	Wed, 23 Sep 2026 15:12:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Ku5991vX";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010050.outbound.protection.outlook.com [52.101.85.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 514D010E50A
 for <amd-gfx@lists.freedesktop.org>; Wed, 23 Sep 2026 15:12:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TNnudoXw1tbYGN6h7eqhHc1nQLUtML4ryn5gnr9ELN3qZshE40Je+k1H49CXh6+dlVPVTZr1XIJ3DeRptmeOUtToklBYmdVX+zfHzCNudR6J0m2X7NJIxE+Zukv0Jb8hXGtkDBDP7XrCfQWU15R0TZ7icAFr85xnHDHBt6qT1Bj3prsg66bD00ZWQrHezkKnI+TT6L5LaGgxGzft2xFgh2g0CFB0uWAA/BR51/CAYZUdVQNZre71Kck+GoGc2kSDbGa/D0NbjImnxaLinh0wNEnhepvTXIcKC/fF+MwV4StZCkvqqG7hdMFeMsfp0uwviQ2ztJv2U6nCwXoQhw055Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WtNQB+wBfEp5XRttQpK4Q0VEkXRp1j7i38NbGlJAWn0=;
 b=rPegaIu3BjvkBsjP+d6zhOL710b47kuypqS7h6Tqpj2GTSaK6aORIcWbE+pyyuaOauJac/YU0Ue7O17L3jiNezqbWc3f6KUJaZNbwj+f+v5lQmiswIhqQZyK5kQgGivNuQuUj3NUFCQLV5xHfQ96eYWUKA0Y3J00StuPke0KgR4mDOdP0ahU/BhLXxCU8kg7257UA0RcPvRI9Mt8itcqZjUXvU0a0GxYjAR2xiAbv7n14aDYDhtjAktQsz1ujpSJsMCpiVfc6XArPIjVvGyRBnMmxnckDfUXQVE2c6oiybjd4CycfPrRH7qxNCVpMsEPYUF6frXdFORRoNMjWIbaJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WtNQB+wBfEp5XRttQpK4Q0VEkXRp1j7i38NbGlJAWn0=;
 b=Ku5991vXK/3GjdLmjR8QtGG1RlADu6rVaasWUEGEy5dKInhuWEguKGYAkcA3edB2GT++uP5XP+Ty8LfoztYYAzYDTkDvX772eysZqeaZZrzAb9xaxa1THqKmHV48/Bg0jQnEQ7ouoFS+dyR+lbXXbVimYOEC+T+QLaTS6RBgeo8=
Received: from MW4PR03CA0195.namprd03.prod.outlook.com (2603:10b6:303:b8::20)
 by MN2PR12MB4222.namprd12.prod.outlook.com (2603:10b6:208:19a::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.14; Wed, 23 Sep
 2026 15:12:37 +0000
Received: from CO1PEPF000066E6.namprd05.prod.outlook.com
 (2603:10b6:303:b8:cafe::17) by MW4PR03CA0195.outlook.office365.com
 (2603:10b6:303:b8::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.14 via Frontend Transport; Wed,
 23 Sep 2026 15:12:37 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF000066E6.mail.protection.outlook.com (10.167.249.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Wed, 23 Sep 2026 15:12:37 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 23 Sep
 2026 10:12:35 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.49 via Frontend
 Transport; Wed, 23 Sep 2026 10:12:35 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Frank Min <Frank.Min@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>,
 "Alex Deucher" <alexander.deucher@amd.com>
Subject: [PATCH 02/12] drm/amdgpu: Add support for PSP version 15.0.3
Date: Wed, 23 Sep 2026 11:12:16 -0400
Message-ID: <20260923151226.2778589-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260923151226.2778589-1-alexander.deucher@amd.com>
References: <20260923151226.2778589-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000066E6:EE_|MN2PR12MB4222:EE_
X-MS-Office365-Filtering-Correlation-Id: 435a4b6f-5cbb-4ff2-fbd4-08df19851a79
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|82310400026|376014|23010399003|11063799006|10067099003|56012099006|6133799003|3023799007|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 5ow4CoK46WM6DrGx7RC7sScR2mB9+/BE1sJRqScwL9HDJ6pSGcvVQAJAzwJbzsW1wy/vXQVERmT+Wf9g3xBWqPR2PCwwTQ84asHnyEclMwLk5ksE/bU2CwPrFLV6QQ8V0Yng3w8uvRcWVJXwcqEyWG0/Fz+rxPvpkZjvAMx4GNiIpsgae8nVFUjfCPl4j9CSFi/301mywMc278jRo/5SwZI0X5qtxmMc6c8rDTub1GvotFmI319y+1dgOd74wHy8eSIEx/Pr28vtmmaUCuXjsViadXgeBA7jOWf0h10yrYSNwGlzGVivZULaNFc9d2lW2JhBiBpCXGaH4IY2tlhkN0jVpjW/3pfb8Mmuy6mwZzsqHo0OSPOYydD7Pk/6/E7KCmRtURe3AUs4rTwAun9A9eNRJtXg4BpII/IBcpNp8P4tyh7BcSGYrU6ypX96H+bLyt27Fcd8yYINO0G2DcQu3vAfWgm+Cp80dYNiEFYnPI+Ba2Z3S1FMNO56Zz4Vmwp0ap9L/vptmqEyGxxHOpXXoeJb0MSyTbl9CTjhQQlxhC6rZi9To/SzADYmkObGLaG/7qQEEdWR3tl0fVwNT9gEUDNlQXFXnWhuN3ZgL+i8WkZFFXu5xTB+uBSF13TbxNlqiPyyJ1RmWe4QV33TL1g/Gj1/27YORFVKnBmtMPSZNcTIMnnUkO/31Avx9Ca7X1cgCB6itn9h4V2ORMVw4ZA8Ow==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(82310400026)(376014)(23010399003)(11063799006)(10067099003)(56012099006)(6133799003)(3023799007)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: JArtZ8N35peth9jXoS6MzKkYEG9h8NQw6VZzm6F5CV/76qJagDz051XHBI/EiSmKNqgRqc6ZNxdVLHv2qMXr44/Fsd8mVrPadECB1BLiOxh0Uq4TM0lIp+nNIHJW9BFp2vUKPelDAGINpd1i6GaYYEeUwMaagjdkR3fxBRlSpqCO1LosLkLRO4pUiMzjoy2SLl2MSjFB5e4MPRdcp8eiXI45DYVYZG904qhfvKOpp0dARTtzvCicIh0DwmFMJ3sZf2EFpz96hxBXR6Jb0GqjKGa9Vqxq7YRNwzhxqmejwAtgCPTPzgMxeU2DGBLNVueMiCQmoBCcdD5ujg9T+zu9gSVYof94qsKGc/K9yJV3bgLQ0U6B5Ss53NQuuSdQVd+nw83cevBJbqLfaZV8mbZpCqSiO97G7OZmEcGbVsee37ZdyhtEPhQDmJ5cJ45mcz+n
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2026 15:12:37.4099 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 435a4b6f-5cbb-4ff2-fbd4-08df19851a79
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000066E6.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4222
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

From: Frank Min <Frank.Min@amd.com>

Add support for PSP version 15.0.3

v2: fix psp 15.0.3 C2P message reg access issue

Signed-off-by: Frank Min <Frank.Min@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/Makefile           |   1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c |   3 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c       |  12 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h       |   1 +
 drivers/gpu/drm/amd/amdgpu/psp_v15_0_3.c      | 682 ++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/psp_v15_0_3.h      |  32 +
 6 files changed, 731 insertions(+)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/psp_v15_0_3.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/psp_v15_0_3.h

diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile b/drivers/gpu/drm/amd/amdgpu/Makefile
index 83e40f26ddf5f..ae7d8e2c6f190 100644
--- a/drivers/gpu/drm/amd/amdgpu/Makefile
+++ b/drivers/gpu/drm/amd/amdgpu/Makefile
@@ -144,6 +144,7 @@ amdgpu-y += \
 	psp_v13_0_4.o \
 	psp_v14_0.o \
 	psp_v15_0.o \
+	psp_v15_0_3.o \
 	psp_v15_0_8.o
 
 # add DCE block
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index 202e0b80e5225..89b09ab2a34f8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -2862,6 +2862,9 @@ static int amdgpu_discovery_set_psp_ip_blocks(struct amdgpu_device *adev)
 	case IP_VERSION(15, 0, 9):
 		amdgpu_device_ip_block_add(adev, &psp_v15_0_ip_block);
 		break;
+	case IP_VERSION(15, 0, 3):
+		amdgpu_device_ip_block_add(adev, &psp_v15_0_3_ip_block);
+		break;
 	case IP_VERSION(15, 0, 8):
 		amdgpu_device_ip_block_add(adev, &psp_v15_0_8_ip_block);
 		break;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index 66eb2f34cc0d9..fcf7ce0e971b4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -41,6 +41,7 @@
 #include "psp_v13_0_4.h"
 #include "psp_v14_0.h"
 #include "psp_v15_0.h"
+#include "psp_v15_0_3.h"
 #include "psp_v15_0_8.h"
 
 #include "amdgpu_ras.h"
@@ -283,6 +284,9 @@ static int psp_early_init(struct amdgpu_ip_block *ip_block)
 		psp_v15_0_0_set_psp_funcs(psp);
 		psp->boot_time_tmr = false;
 		break;
+	case IP_VERSION(15, 0, 3):
+		psp_v15_0_3_set_psp_funcs(psp);
+		break;
 	case IP_VERSION(15, 0, 8):
 		psp_v15_0_8_set_psp_funcs(psp);
 		break;
@@ -5518,6 +5522,14 @@ const struct amdgpu_ip_block_version psp_v15_0_ip_block = {
 	.funcs = &psp_ip_funcs,
 };
 
+const struct amdgpu_ip_block_version psp_v15_0_3_ip_block = {
+	.type = AMD_IP_BLOCK_TYPE_PSP,
+	.major = 15,
+	.minor = 0,
+	.rev = 3,
+	.funcs = &psp_ip_funcs,
+};
+
 const struct amdgpu_ip_block_version psp_v15_0_8_ip_block = {
 	.type = AMD_IP_BLOCK_TYPE_PSP,
 	.major = 15,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
index 35839f42b8a08..e9822e03e6190 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
@@ -606,6 +606,7 @@ extern const struct amdgpu_ip_block_version psp_v13_0_ip_block;
 extern const struct amdgpu_ip_block_version psp_v13_0_4_ip_block;
 extern const struct amdgpu_ip_block_version psp_v14_0_ip_block;
 extern const struct amdgpu_ip_block_version psp_v15_0_ip_block;
+extern const struct amdgpu_ip_block_version psp_v15_0_3_ip_block;
 extern const struct amdgpu_ip_block_version psp_v15_0_8_ip_block;
 
 int psp_wait_for(struct psp_context *psp, uint32_t reg_index,
diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v15_0_3.c b/drivers/gpu/drm/amd/amdgpu/psp_v15_0_3.c
new file mode 100644
index 0000000000000..fd9b35492fcbe
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/psp_v15_0_3.c
@@ -0,0 +1,682 @@
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
+#include <drm/drm_drv.h>
+#include <linux/vmalloc.h>
+#include "amdgpu.h"
+#include "amdgpu_psp.h"
+#include "amdgpu_ucode.h"
+#include "soc15_common.h"
+#include "psp_v15_0_3.h"
+
+#include "mp/mp_15_0_3_offset.h"
+//#include "mp/mp_15_0_3_sh_mask.h"
+
+MODULE_FIRMWARE("amdgpu/psp_15_0_3_sos.bin");
+MODULE_FIRMWARE("amdgpu/psp_15_0_3_ta.bin");
+
+/* For large FW files the time to complete can be very long */
+#define USBC_PD_POLLING_LIMIT_S 240
+
+/* Read USB-PD from LFB */
+#define GFX_CMD_USB_PD_USE_LFB 0x480
+
+/* VBIOS gfl defines */
+#define MBOX_READY_MASK 0x80000000
+#define MBOX_STATUS_MASK 0x0000FFFF
+#define MBOX_COMMAND_MASK 0x00FF0000
+#define MBOX_READY_FLAG 0x80000000
+#define C2PMSG_CMD_SPI_UPDATE_ROM_IMAGE_ADDR_LO 0x2
+#define C2PMSG_CMD_SPI_UPDATE_ROM_IMAGE_ADDR_HI 0x3
+#define C2PMSG_CMD_SPI_UPDATE_FLASH_IMAGE 0x4
+
+/* memory training timeout define */
+#define MEM_TRAIN_SEND_MSG_TIMEOUT_US	3000000
+static int psp_v15_0_3_init_microcode(struct psp_context *psp)
+{
+	struct amdgpu_device *adev = psp->adev;
+	char ucode_prefix[30];
+	int err = 0;
+
+	amdgpu_ucode_ip_version_decode(adev, MP0_HWIP, ucode_prefix, sizeof(ucode_prefix));
+
+	switch (amdgpu_ip_version(adev, MP0_HWIP, 0)) {
+	case IP_VERSION(15, 0, 3):
+		err = psp_init_sos_microcode(psp, ucode_prefix);
+		if (err)
+			return err;
+
+		break;
+	default:
+		BUG();
+	}
+
+	return 0;
+}
+
+static bool psp_v15_0_3_is_sos_alive(struct psp_context *psp)
+{
+	struct amdgpu_device *adev = psp->adev;
+	uint32_t reg_val;
+
+	reg_val = RREG32_SOC15(MP0, 0, regMPASP_PCRU0_MPASP_C2PMSG_35);
+
+	return reg_val == 0xaaaa;
+}
+
+static int psp_v15_0_3_wait_for_bootloader(struct psp_context *psp)
+{
+	struct amdgpu_device *adev = psp->adev;
+
+	int ret;
+	int retry_loop;
+
+	for (retry_loop = 0; retry_loop < 10; retry_loop++) {
+		/* Wait for bootloader to signify that is
+		    ready having bit 31 of C2PMSG_35 set to 1 */
+		ret = psp_wait_for(psp, SOC15_REG_OFFSET(MP0, 0, regMPASP_PCRU0_MPASP_C2PMSG_35),
+				   0x80000000, 0x80000000, PSP_WAITREG_NOVERBOSE);
+
+		if (ret == 0)
+			return 0;
+	}
+
+	return ret;
+}
+
+static int psp_v15_0_3_bootloader_load_component(struct psp_context  	*psp,
+					        struct psp_bin_desc 	*bin_desc,
+					        enum psp_bootloader_cmd  bl_cmd)
+{
+	int ret;
+	uint32_t psp_gfxdrv_command_reg = 0;
+	struct amdgpu_device *adev = psp->adev;
+
+	/* Check tOS sign of life register to confirm sys driver and sOS
+	 * are already been loaded.
+	 */
+	if (psp_v15_0_3_is_sos_alive(psp))
+		return 0;
+
+	ret = psp_v15_0_3_wait_for_bootloader(psp);
+	if (ret)
+		return ret;
+
+	memset(psp->fw_pri_buf, 0, PSP_1_MEG);
+
+	memcpy(psp->fw_pri_buf, bin_desc->start_addr, bin_desc->size_bytes);
+
+	WREG32_SOC15(MP0, 0, regMPASP_PCRU0_MPASP_C2PMSG_36, (uint32_t)(psp->fw_pri_mc_addr >> 20));
+	psp_gfxdrv_command_reg = bl_cmd;
+	WREG32_SOC15(MP0, 0, regMPASP_PCRU0_MPASP_C2PMSG_35, psp_gfxdrv_command_reg);
+
+	ret = psp_v15_0_3_wait_for_bootloader(psp);
+
+	return ret;
+}
+
+static int psp_v15_0_3_bootloader_load_kdb(struct psp_context *psp)
+{
+	return psp_v15_0_3_bootloader_load_component(psp, &psp->kdb, PSP_BL__LOAD_KEY_DATABASE);
+}
+
+static int psp_v15_0_3_bootloader_load_spl(struct psp_context *psp)
+{
+	return psp_v15_0_3_bootloader_load_component(psp, &psp->spl, PSP_BL__LOAD_TOS_SPL_TABLE);
+}
+
+static int psp_v15_0_3_bootloader_load_sysdrv(struct psp_context *psp)
+{
+	return psp_v15_0_3_bootloader_load_component(psp, &psp->sys, PSP_BL__LOAD_SYSDRV);
+}
+
+static int psp_v15_0_3_bootloader_load_soc_drv(struct psp_context *psp)
+{
+	return psp_v15_0_3_bootloader_load_component(psp, &psp->soc_drv, PSP_BL__LOAD_SOCDRV);
+}
+
+static int psp_v15_0_3_bootloader_load_intf_drv(struct psp_context *psp)
+{
+	return psp_v15_0_3_bootloader_load_component(psp, &psp->intf_drv, PSP_BL__LOAD_INTFDRV);
+}
+
+static int psp_v15_0_3_bootloader_load_dbg_drv(struct psp_context *psp)
+{
+	return psp_v15_0_3_bootloader_load_component(psp, &psp->dbg_drv, PSP_BL__LOAD_HADDRV);
+}
+
+static int psp_v15_0_3_bootloader_load_ras_drv(struct psp_context *psp)
+{
+	return psp_v15_0_3_bootloader_load_component(psp, &psp->ras_drv, PSP_BL__LOAD_RASDRV);
+}
+
+static int psp_v15_0_3_bootloader_load_ipkeymgr_drv(struct psp_context *psp)
+{
+	return psp_v15_0_3_bootloader_load_component(psp,&psp->ipkeymgr_drv, PSP_BL__LOAD_IPKEYMGRDRV);
+}
+
+static int psp_v15_0_3_bootloader_load_sos(struct psp_context *psp)
+{
+	int ret;
+	unsigned int psp_gfxdrv_command_reg = 0;
+	struct amdgpu_device *adev = psp->adev;
+
+	/* Check sOS sign of life register to confirm sys driver and sOS
+	 * are already been loaded.
+	 */
+	if (psp_v15_0_3_is_sos_alive(psp))
+		return 0;
+
+	ret = psp_v15_0_3_wait_for_bootloader(psp);
+	if (ret)
+		return ret;
+
+	memset(psp->fw_pri_buf, 0, PSP_1_MEG);
+
+	/* Copy Secure OS binary to PSP memory */
+	memcpy(psp->fw_pri_buf, psp->sos.start_addr, psp->sos.size_bytes);
+
+	/* Provide the PSP secure OS to bootloader */
+	WREG32_SOC15(MP0, 0, regMPASP_PCRU0_MPASP_C2PMSG_36, (uint32_t)(psp->fw_pri_mc_addr >> 20));
+	psp_gfxdrv_command_reg = PSP_BL__LOAD_SOSDRV;
+	WREG32_SOC15(MP0, 0, regMPASP_PCRU0_MPASP_C2PMSG_35, psp_gfxdrv_command_reg);
+
+	/* there might be handshake issue with hardware which needs delay */
+	mdelay(20);
+	ret = psp_wait_for(psp, SOC15_REG_OFFSET(MP0, 0, regMPASP_PCRU0_MPASP_C2PMSG_81),
+			   RREG32_SOC15(MP0, 0, regMPASP_PCRU0_MPASP_C2PMSG_81), 0,
+			   PSP_WAITREG_CHANGED);
+
+	return ret;
+}
+
+static int psp_v15_0_3_ring_stop(struct psp_context *psp,
+				 enum psp_ring_type ring_type)
+{
+	int ret = 0;
+	struct amdgpu_device *adev = psp->adev;
+
+	if (amdgpu_sriov_vf(adev)) {
+		/* Write the ring destroy command*/
+		WREG32_SOC15(MP0, 0, regMPASP_PCRU0_MPASP_C2PMSG_101, GFX_CTRL_CMD_ID_DESTROY_GPCOM_RING);
+		/* there might be handshake issue with hardware which needs delay */
+		mdelay(20);
+		/* Wait for response flag (bit 31) */
+		ret = psp_wait_for(psp, SOC15_REG_OFFSET(MP0, 0, regMPASP_PCRU0_MPASP_C2PMSG_101),
+				   MBOX_TOS_RESP_FLAG, MBOX_TOS_RESP_MASK, 0);
+	} else {
+		/* Write the ring destroy command*/
+		WREG32_SOC15(MP0, 0, regMPASP_PCRU0_MPASP_C2PMSG_64, GFX_CTRL_CMD_ID_DESTROY_RINGS);
+		/* there might be handshake issue with hardware which needs delay */
+		mdelay(20);
+		/* Wait for response flag (bit 31) */
+		ret = psp_wait_for(psp, SOC15_REG_OFFSET(MP0, 0, regMPASP_PCRU0_MPASP_C2PMSG_64),
+				   MBOX_TOS_RESP_FLAG, MBOX_TOS_RESP_MASK, 0);
+	}
+
+	return ret;
+}
+
+static int psp_v15_0_3_ring_create(struct psp_context *psp,
+				   enum psp_ring_type ring_type)
+{
+	int ret = 0;
+	unsigned int psp_ring_reg = 0;
+	struct psp_ring *ring = &psp->km_ring;
+	struct amdgpu_device *adev = psp->adev;
+
+	if (amdgpu_sriov_vf(adev)) {
+		ret = psp_v15_0_3_ring_stop(psp, ring_type);
+		if (ret) {
+			DRM_ERROR("psp_v15_0_3_ring_stop_sriov failed!\n");
+			return ret;
+		}
+
+		/* Write low address of the ring to C2PMSG_102 */
+		psp_ring_reg = lower_32_bits(ring->ring_mem_mc_addr);
+		WREG32_SOC15(MP0, 0, regMPASP_PCRU0_MPASP_C2PMSG_102, psp_ring_reg);
+		/* Write high address of the ring to C2PMSG_103 */
+		psp_ring_reg = upper_32_bits(ring->ring_mem_mc_addr);
+		WREG32_SOC15(MP0, 0, regMPASP_PCRU0_MPASP_C2PMSG_103, psp_ring_reg);
+
+		/* Write the ring initialization command to C2PMSG_101 */
+		WREG32_SOC15(MP0, 0, regMPASP_PCRU0_MPASP_C2PMSG_101, GFX_CTRL_CMD_ID_INIT_GPCOM_RING);
+
+		/* there might be handshake issue with hardware which needs delay */
+		mdelay(20);
+
+		/* Wait for response flag (bit 31) in C2PMSG_101 */
+		ret = psp_wait_for(psp, SOC15_REG_OFFSET(MP0, 0, regMPASP_PCRU0_MPASP_C2PMSG_101),
+				   MBOX_TOS_RESP_FLAG, MBOX_TOS_RESP_MASK, 0);
+
+	} else {
+		/* Wait for sOS ready for ring creation */
+		ret = psp_wait_for(psp, SOC15_REG_OFFSET(MP0, 0, regMPASP_PCRU0_MPASP_C2PMSG_64),
+				   MBOX_TOS_READY_FLAG, MBOX_TOS_READY_MASK, 0);
+		if (ret) {
+			DRM_ERROR("Failed to wait for trust OS ready for ring creation\n");
+			return ret;
+		}
+
+		/* Write low address of the ring to C2PMSG_69 */
+		psp_ring_reg = lower_32_bits(ring->ring_mem_mc_addr);
+		WREG32_SOC15(MP0, 0, regMPASP_PCRU0_MPASP_C2PMSG_69, psp_ring_reg);
+		/* Write high address of the ring to C2PMSG_70 */
+		psp_ring_reg = upper_32_bits(ring->ring_mem_mc_addr);
+		WREG32_SOC15(MP0, 0, regMPASP_PCRU0_MPASP_C2PMSG_70, psp_ring_reg);
+		/* Write size of ring to C2PMSG_71 */
+		psp_ring_reg = ring->ring_size;
+		WREG32_SOC15(MP0, 0, regMPASP_PCRU0_MPASP_C2PMSG_71, psp_ring_reg);
+		/* Write the ring initialization command to C2PMSG_64 */
+		psp_ring_reg = ring_type;
+		psp_ring_reg = psp_ring_reg << 16;
+		WREG32_SOC15(MP0, 0, regMPASP_PCRU0_MPASP_C2PMSG_64, psp_ring_reg);
+
+		/* there might be handshake issue with hardware which needs delay */
+		mdelay(20);
+
+		/* Wait for response flag (bit 31) in C2PMSG_64 */
+		ret = psp_wait_for(psp, SOC15_REG_OFFSET(MP0, 0, regMPASP_PCRU0_MPASP_C2PMSG_64),
+				   MBOX_TOS_RESP_FLAG, MBOX_TOS_RESP_MASK, 0);
+	}
+
+	return ret;
+}
+
+static int psp_v15_0_3_ring_destroy(struct psp_context *psp,
+				  enum psp_ring_type ring_type)
+{
+	int ret = 0;
+	struct psp_ring *ring = &psp->km_ring;
+	struct amdgpu_device *adev = psp->adev;
+
+	ret = psp_v15_0_3_ring_stop(psp, ring_type);
+	if (ret)
+		DRM_ERROR("Fail to stop psp ring\n");
+
+	amdgpu_bo_free_kernel(&adev->firmware.rbuf,
+			      &ring->ring_mem_mc_addr,
+			      (void **)&ring->ring_mem);
+
+	return ret;
+}
+
+static uint32_t psp_v15_0_3_ring_get_wptr(struct psp_context *psp)
+{
+	uint32_t data;
+	struct amdgpu_device *adev = psp->adev;
+
+	if (amdgpu_sriov_vf(adev))
+		data = RREG32_SOC15(MP0, 0, regMPASP_PCRU0_MPASP_C2PMSG_102);
+	else
+		data = RREG32_SOC15(MP0, 0, regMPASP_PCRU0_MPASP_C2PMSG_67);
+
+	return data;
+}
+
+static void psp_v15_0_3_ring_set_wptr(struct psp_context *psp, uint32_t value)
+{
+	struct amdgpu_device *adev = psp->adev;
+
+	if (amdgpu_sriov_vf(adev)) {
+		WREG32_SOC15(MP0, 0, regMPASP_PCRU0_MPASP_C2PMSG_102, value);
+		WREG32_SOC15(MP0, 0, regMPASP_PCRU0_MPASP_C2PMSG_101,
+			     GFX_CTRL_CMD_ID_CONSUME_CMD);
+	} else
+		WREG32_SOC15(MP0, 0, regMPASP_PCRU0_MPASP_C2PMSG_67, value);
+}
+
+static int psp_v15_0_3_memory_training_send_msg(struct psp_context *psp, int msg)
+{
+	int ret;
+	int i;
+	uint32_t data_32;
+	int max_wait;
+	struct amdgpu_device *adev = psp->adev;
+
+	data_32 = (psp->mem_train_ctx.c2p_train_data_offset >> 20);
+	WREG32_SOC15(MP0, 0, regMPASP_PCRU0_MPASP_C2PMSG_36, data_32);
+	WREG32_SOC15(MP0, 0, regMPASP_PCRU0_MPASP_C2PMSG_35, msg);
+
+	max_wait = MEM_TRAIN_SEND_MSG_TIMEOUT_US / adev->usec_timeout;
+	for (i = 0; i < max_wait; i++) {
+		ret = psp_wait_for(
+			psp, SOC15_REG_OFFSET(MP0, 0, regMPASP_PCRU0_MPASP_C2PMSG_35),
+			0x80000000, 0x80000000, PSP_WAITREG_NOVERBOSE);
+		if (ret == 0)
+			break;
+	}
+	if (i < max_wait)
+		ret = 0;
+	else
+		ret = -ETIME;
+
+	dev_dbg(adev->dev, "training %s %s, cost %d @ %d ms\n",
+		  (msg == PSP_BL__DRAM_SHORT_TRAIN) ? "short" : "long",
+		  (ret == 0) ? "succeed" : "failed",
+		  i, adev->usec_timeout/1000);
+	return ret;
+}
+
+
+static int psp_v15_0_3_memory_training(struct psp_context *psp, uint32_t ops)
+{
+	struct psp_memory_training_context *ctx = &psp->mem_train_ctx;
+	uint32_t *pcache = (uint32_t *)ctx->sys_cache;
+	struct amdgpu_device *adev = psp->adev;
+	uint32_t p2c_header[4];
+	uint32_t sz;
+	void *buf;
+	int ret, idx;
+
+	if (amdgpu_emu_mode == 1)
+		return 0;
+
+	if (ctx->init == PSP_MEM_TRAIN_NOT_SUPPORT) {
+		dev_dbg(adev->dev, "Memory training is not supported.\n");
+		return 0;
+	} else if (ctx->init != PSP_MEM_TRAIN_INIT_SUCCESS) {
+		dev_err(adev->dev, "Memory training initialization failure.\n");
+		return -EINVAL;
+	}
+
+	if (psp_v15_0_3_is_sos_alive(psp)) {
+		dev_dbg(adev->dev, "SOS is alive, skip memory training.\n");
+		return 0;
+	}
+
+	amdgpu_device_vram_access(adev, ctx->p2c_train_data_offset, p2c_header, sizeof(p2c_header), false);
+	dev_dbg(adev->dev, "sys_cache[%08x,%08x,%08x,%08x] p2c_header[%08x,%08x,%08x,%08x]\n",
+		  pcache[0], pcache[1], pcache[2], pcache[3],
+		  p2c_header[0], p2c_header[1], p2c_header[2], p2c_header[3]);
+
+	if (ops & PSP_MEM_TRAIN_SEND_SHORT_MSG) {
+		dev_dbg(adev->dev, "Short training depends on restore.\n");
+		ops |= PSP_MEM_TRAIN_RESTORE;
+	}
+
+	if ((ops & PSP_MEM_TRAIN_RESTORE) &&
+	    pcache[0] != MEM_TRAIN_SYSTEM_SIGNATURE) {
+		dev_dbg(adev->dev, "sys_cache[0] is invalid, restore depends on save.\n");
+		ops |= PSP_MEM_TRAIN_SAVE;
+	}
+
+	if (p2c_header[0] == MEM_TRAIN_SYSTEM_SIGNATURE &&
+	    !(pcache[0] == MEM_TRAIN_SYSTEM_SIGNATURE &&
+	      pcache[3] == p2c_header[3])) {
+		dev_dbg(adev->dev, "sys_cache is invalid or out-of-date, need save training data to sys_cache.\n");
+		ops |= PSP_MEM_TRAIN_SAVE;
+	}
+
+	if ((ops & PSP_MEM_TRAIN_SAVE) &&
+	    p2c_header[0] != MEM_TRAIN_SYSTEM_SIGNATURE) {
+		dev_dbg(adev->dev, "p2c_header[0] is invalid, save depends on long training.\n");
+		ops |= PSP_MEM_TRAIN_SEND_LONG_MSG;
+	}
+
+	if (ops & PSP_MEM_TRAIN_SEND_LONG_MSG) {
+		ops &= ~PSP_MEM_TRAIN_SEND_SHORT_MSG;
+		ops |= PSP_MEM_TRAIN_SAVE;
+	}
+
+	dev_dbg(adev->dev, "Memory training ops:%x.\n", ops);
+
+	if (ops & PSP_MEM_TRAIN_SEND_LONG_MSG) {
+		/*
+		 * Long training will encroach a certain amount on the bottom of VRAM;
+		 * save the content from the bottom of VRAM to system memory
+		 * before training, and restore it after training to avoid
+		 * VRAM corruption.
+		 */
+		sz = BIST_MEM_TRAINING_ENCROACHED_SIZE;
+
+		if (adev->gmc.visible_vram_size < sz || !adev->mman.aper_base_kaddr) {
+			dev_err(adev->dev, "visible_vram_size %llx or aper_base_kaddr %p is not initialized.\n",
+				  adev->gmc.visible_vram_size,
+				  adev->mman.aper_base_kaddr);
+			return -EINVAL;
+		}
+
+		buf = vmalloc(sz);
+		if (!buf) {
+			dev_err(adev->dev, "failed to allocate system memory.\n");
+			return -ENOMEM;
+		}
+
+		if (drm_dev_enter(adev_to_drm(adev), &idx)) {
+			memcpy_fromio(buf, adev->mman.aper_base_kaddr, sz);
+			ret = psp_v15_0_3_memory_training_send_msg(psp, PSP_BL__DRAM_LONG_TRAIN);
+			if (ret) {
+				DRM_ERROR("Send long training msg failed.\n");
+				vfree(buf);
+				drm_dev_exit(idx);
+				return ret;
+			}
+
+			memcpy_toio(adev->mman.aper_base_kaddr, buf, sz);
+			amdgpu_device_flush_hdp(adev, NULL);
+			vfree(buf);
+			drm_dev_exit(idx);
+		} else {
+			vfree(buf);
+			return -ENODEV;
+		}
+	}
+
+	if (ops & PSP_MEM_TRAIN_SAVE) {
+		amdgpu_device_vram_access(psp->adev, ctx->p2c_train_data_offset, ctx->sys_cache, ctx->train_data_size, false);
+	}
+
+	if (ops & PSP_MEM_TRAIN_RESTORE) {
+		amdgpu_device_vram_access(psp->adev, ctx->c2p_train_data_offset, ctx->sys_cache, ctx->train_data_size, true);
+	}
+
+	if (ops & PSP_MEM_TRAIN_SEND_SHORT_MSG) {
+		ret = psp_v15_0_3_memory_training_send_msg(psp, (amdgpu_force_long_training > 0) ?
+							 PSP_BL__DRAM_LONG_TRAIN : PSP_BL__DRAM_SHORT_TRAIN);
+		if (ret) {
+			dev_err(adev->dev, "send training msg failed.\n");
+			return ret;
+		}
+	}
+	ctx->training_cnt++;
+	return 0;
+}
+
+static int psp_v15_0_3_load_usbc_pd_fw(struct psp_context *psp, uint64_t fw_pri_mc_addr)
+{
+	struct amdgpu_device *adev = psp->adev;
+	uint32_t reg_status;
+	int ret, i = 0;
+
+	if (amdgpu_emu_mode == 1)
+		return 0;
+
+	/*
+	 * LFB address which is aligned to 1MB address and has to be
+	 * right-shifted by 20 so that LFB address can be passed on a 32-bit C2P
+	 * register
+	 */
+	WREG32_SOC15(MP0, 0, regMPASP_PCRU0_MPASP_C2PMSG_36, (fw_pri_mc_addr >> 20));
+
+	ret = psp_wait_for(psp,
+			   SOC15_REG_OFFSET(MP0, 0, regMPASP_PCRU0_MPASP_C2PMSG_35),
+			   0x80000000, 0x80000000, 0);
+	if (ret)
+		return ret;
+
+	/* Fireup interrupt so PSP can pick up the address */
+	WREG32_SOC15(MP0, 0, regMPASP_PCRU0_MPASP_C2PMSG_35, (GFX_CMD_USB_PD_USE_LFB << 16));
+
+	/* FW load takes very long time */
+	do {
+		msleep(1000);
+		reg_status = RREG32_SOC15(MP0, 0, regMPASP_PCRU0_MPASP_C2PMSG_35);
+
+		if (reg_status & 0x80000000)
+			goto done;
+
+	} while (++i < USBC_PD_POLLING_LIMIT_S);
+
+	return -ETIME;
+done:
+
+	if ((reg_status & 0xFFFF) != 0) {
+		DRM_ERROR("Address load failed - MP0_SMN_C2PMSG_35.Bits [15:0] = %04x\n",
+				reg_status & 0xFFFF);
+		return -EIO;
+	}
+
+	return 0;
+}
+
+static int psp_v15_0_3_read_usbc_pd_fw(struct psp_context *psp, uint32_t *fw_ver)
+{
+	struct amdgpu_device *adev = psp->adev;
+	int ret;
+
+	if (amdgpu_emu_mode == 1)
+		return 0;
+
+	WREG32_SOC15(MP0, 0, regMPASP_PCRU0_MPASP_C2PMSG_35, C2PMSG_CMD_GFX_USB_PD_FW_VER);
+
+	ret = psp_wait_for(psp,
+			   SOC15_REG_OFFSET(MP0, 0, regMPASP_PCRU0_MPASP_C2PMSG_35),
+			   0x80000000, 0x80000000, 0);
+	if (!ret)
+		*fw_ver = RREG32_SOC15(MP0, 0, regMPASP_PCRU0_MPASP_C2PMSG_36);
+
+	return ret;
+}
+
+static int psp_v15_0_3_exec_spi_cmd(struct psp_context *psp, int cmd)
+{
+	uint32_t reg_status = 0, reg_val = 0;
+	struct amdgpu_device *adev = psp->adev;
+	int ret;
+
+	/* clear MBX ready (MBOX_READY_MASK bit is 0) and set update command */
+	reg_val |= (cmd << 16);
+	WREG32_SOC15(MP0, 0, regMPASP_PCRU0_MPASP_C2PMSG_115,  reg_val);
+
+	/* Ring the doorbell */
+	WREG32_SOC15(MP0, 0, regMPASP_PCRU0_MPASP_C2PMSG_73, 1);
+
+	if (cmd == C2PMSG_CMD_SPI_UPDATE_FLASH_IMAGE)
+		ret = psp_wait_for_spirom_update(psp, SOC15_REG_OFFSET(MP0, 0, regMPASP_PCRU0_MPASP_C2PMSG_115),
+						 MBOX_READY_FLAG, MBOX_READY_MASK, PSP_SPIROM_UPDATE_TIMEOUT);
+	else
+		ret = psp_wait_for(
+			psp, SOC15_REG_OFFSET(MP0, 0, regMPASP_PCRU0_MPASP_C2PMSG_115),
+			MBOX_READY_FLAG, MBOX_READY_MASK, 0);
+
+	ret = psp_wait_for(psp,
+			   SOC15_REG_OFFSET(MP0, 0, regMPASP_PCRU0_MPASP_C2PMSG_115),
+			   MBOX_READY_FLAG, MBOX_READY_MASK, 0);
+	if (ret) {
+		dev_err(adev->dev, "SPI cmd %x timed out, ret = %d", cmd, ret);
+		return ret;
+	}
+
+	reg_status = RREG32_SOC15(MP0, 0, regMPASP_PCRU0_MPASP_C2PMSG_115);
+	if ((reg_status & 0xFFFF) != 0) {
+		dev_err(adev->dev, "SPI cmd %x failed, fail status = %04x\n",
+				cmd, reg_status & 0xFFFF);
+		return -EIO;
+	}
+
+	return 0;
+}
+
+static int psp_v15_0_3_update_spirom(struct psp_context *psp,
+				   uint64_t fw_pri_mc_addr)
+{
+	struct amdgpu_device *adev = psp->adev;
+	int ret;
+
+	if (amdgpu_emu_mode == 1)
+		return 0;
+
+	/* Confirm PSP is ready to start */
+	ret = psp_wait_for(psp,
+			   SOC15_REG_OFFSET(MP0, 0, regMPASP_PCRU0_MPASP_C2PMSG_115),
+			   MBOX_READY_FLAG, MBOX_READY_MASK, 0);
+	if (ret) {
+		dev_err(adev->dev, "PSP Not ready to start processing, ret = %d", ret);
+		return ret;
+	}
+
+	WREG32_SOC15(MP0, 0, regMPASP_PCRU0_MPASP_C2PMSG_116, lower_32_bits(fw_pri_mc_addr));
+
+	ret = psp_v15_0_3_exec_spi_cmd(psp, C2PMSG_CMD_SPI_UPDATE_ROM_IMAGE_ADDR_LO);
+	if (ret)
+		return ret;
+
+	WREG32_SOC15(MP0, 0, regMPASP_PCRU0_MPASP_C2PMSG_116, upper_32_bits(fw_pri_mc_addr));
+
+	ret = psp_v15_0_3_exec_spi_cmd(psp, C2PMSG_CMD_SPI_UPDATE_ROM_IMAGE_ADDR_HI);
+	if (ret)
+		return ret;
+
+	psp->vbflash_done = true;
+
+	ret = psp_v15_0_3_exec_spi_cmd(psp, C2PMSG_CMD_SPI_UPDATE_FLASH_IMAGE);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+static int psp_v15_0_3_vbflash_status(struct psp_context *psp)
+{
+	struct amdgpu_device *adev = psp->adev;
+
+	return RREG32_SOC15(MP0, 0, regMPASP_PCRU0_MPASP_C2PMSG_115);
+}
+
+static const struct psp_funcs psp_v15_0_3_funcs = {
+	.init_microcode = psp_v15_0_3_init_microcode,
+	.bootloader_load_kdb = psp_v15_0_3_bootloader_load_kdb,
+	.bootloader_load_spl = psp_v15_0_3_bootloader_load_spl,
+	.bootloader_load_sysdrv = psp_v15_0_3_bootloader_load_sysdrv,
+	.bootloader_load_soc_drv = psp_v15_0_3_bootloader_load_soc_drv,
+	.bootloader_load_intf_drv = psp_v15_0_3_bootloader_load_intf_drv,
+	.bootloader_load_dbg_drv = psp_v15_0_3_bootloader_load_dbg_drv,
+	.bootloader_load_ras_drv = psp_v15_0_3_bootloader_load_ras_drv,
+	.bootloader_load_ipkeymgr_drv = psp_v15_0_3_bootloader_load_ipkeymgr_drv,
+	.bootloader_load_sos = psp_v15_0_3_bootloader_load_sos,
+	.ring_create = psp_v15_0_3_ring_create,
+	.ring_stop = psp_v15_0_3_ring_stop,
+	.ring_destroy = psp_v15_0_3_ring_destroy,
+	.ring_get_wptr = psp_v15_0_3_ring_get_wptr,
+	.ring_set_wptr = psp_v15_0_3_ring_set_wptr,
+	.mem_training = psp_v15_0_3_memory_training,
+	.load_usbc_pd_fw = psp_v15_0_3_load_usbc_pd_fw,
+	.read_usbc_pd_fw = psp_v15_0_3_read_usbc_pd_fw,
+	.update_spirom = psp_v15_0_3_update_spirom,
+	.vbflash_stat = psp_v15_0_3_vbflash_status
+};
+
+void psp_v15_0_3_set_psp_funcs(struct psp_context *psp)
+{
+	psp->funcs = &psp_v15_0_3_funcs;
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v15_0_3.h b/drivers/gpu/drm/amd/amdgpu/psp_v15_0_3.h
new file mode 100644
index 0000000000000..12e8693b8d79c
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/psp_v15_0_3.h
@@ -0,0 +1,32 @@
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
+#ifndef __PSP_V15_0_3_H__
+#define __PSP_V15_0_3_H__
+
+#include "amdgpu_psp.h"
+
+#define PSP_SPIROM_UPDATE_TIMEOUT   60000   /* 60s */
+
+void psp_v15_0_3_set_psp_funcs(struct psp_context *psp);
+
+#endif
-- 
2.55.0

