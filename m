Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14B24C5DF7D
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Aug 2026 19:52:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A1A2C10F446;
	Fri, 21 Aug 2026 19:52:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="HfdCZs/I";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011064.outbound.protection.outlook.com [40.107.208.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6516410F446
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Aug 2026 19:52:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KiaTOBGAVC2XsRh6e/SgSABba6QO8POwOtsoecP/95kugYBPVX3Wpw/kyneDlJjLxPOFwl/qX2m6yemNHWbSEKbrrw4v/8UnrdGa+LJpPdg/7qolWzz/eDcErEQn18e9CN1BIhaYyVgG5gik8gLXgdS7AIRsxWYEQcppt+FO6G0aeOry2EhMBJXwqr6LZCJsHUcHtdsDitxtTCI7Ug6jpfca2XMHHjf9V5kF7TSzvKoYRaVRZYyZi2TtkcVne3bLj4kycdqE4I8OFaNBZgKvCmMYM0P/5eR8WjwTBBU6yb/ndzXBPCF0eSDEWoWMotUvMAWStzQ+25yq5Bmuovdfyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aVkdhyuIKSdwx/3YiW/R968qeDnuKmJvMw88AKP/w5I=;
 b=j7ICLnDT0Ww+lG7/hubeaJXcMGzRJm1g6FjKhyWkKBaVxbYEhsFbrCaawIC7l3tyzilFPwKNtjvv6B4mvB8pq47xbby/k7LEMtmRxUwa9zQ309mPXrqHg5NSxhpoG5IcETob9o3nlz0y//wGm950bmPSJ2Sket0Hmanv4F4b/V6ojooj7P6IZrvAwVk0qaObunGggJEApQ9ufZ57TyxFp17YWUjh5Bcz0KGOgaiZ0ycOFMaYBMwmwfXlLLNVjXk9X1/y8XIR2utVDD9b2lPC3CyBpi8ZTjRdect3ajdjxKNUHInLVMwl/r7ye40R7jwbKzzNT9pR3o4MF6LiqM6f1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aVkdhyuIKSdwx/3YiW/R968qeDnuKmJvMw88AKP/w5I=;
 b=HfdCZs/IY39zUED95DczSPfaMA9atbTGpuv/MRpwCAQcuogSDWX8P8h9GYEZA93/p5tgqfMr/YAZe52rUJnN1dCfxKjvGJUVjTwRC1gNlZkicmc0PSrWaDYulbuSsBCkMKEked7nZ1MjoZEgRBiO3+BkiDZlqByKHLe4un/5AkQ=
Received: from CY5PR19CA0074.namprd19.prod.outlook.com (2603:10b6:930:69::23)
 by SA1PR12MB7222.namprd12.prod.outlook.com (2603:10b6:806:2bf::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.11; Fri, 21 Aug
 2026 19:36:15 +0000
Received: from CY4PEPF0000EDD6.namprd03.prod.outlook.com
 (2603:10b6:930:69:cafe::1e) by CY5PR19CA0074.outlook.office365.com
 (2603:10b6:930:69::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.11 via Frontend Transport; Fri,
 21 Aug 2026 19:36:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CY4PEPF0000EDD6.mail.protection.outlook.com (10.167.241.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Fri, 21 Aug 2026 19:36:13 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 21 Aug
 2026 14:36:08 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 21 Aug
 2026 14:36:05 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Fri, 21 Aug 2026 14:36:05 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Lijo Lazar <lijo.lazar@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 89/95] drm/amdgpu: Move ualink ip version related changes
Date: Fri, 21 Aug 2026 15:34:52 -0400
Message-ID: <20260821193458.808626-90-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260821193458.808626-1-alexander.deucher@amd.com>
References: <20260821193458.808626-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD6:EE_|SA1PR12MB7222:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c41c0bf-d847-47c0-1611-08deffbb7631
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|1800799024|36860700016|82310400026|10067099003|11063799006|56012099006|3023799007|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: wiLFgp/k0XwOoRglvhYPK7kK9JL6SiHTcQ4Fl4mUhM1uCv4UVWNu0TmCkVVDRM3RX2Xj7xtaaptChXR9YProvz6GejBIKjsiNwZNOjNiIoYygFMcQvygb8dX+IxwB/k9Jxz3eqruqoUlLcCFawcDjMnVK7/4T8RKLI7t1n5L5wxPB68X2c1pWOKhrCbO9qvGKDfjPKkgf7mvyDlAAtE0gZhIB7urQ9vp5KOEYiLiyYCEHkR/9nDJhBNCru1GfAEahh6Jtw+jO6EhVCAAqsFRW7kumWhI9RPpJk70qEX0aZo4js9XLdMdNuZZge7UREIjz0xwI92k+5YTpnZsgXxKB3xz0+ARJiXeAMwkTOpDJe6WrKoQ0H23HbgG6EOl6DylHsUBf7wU+jioJcKJhX4eBhcVQIdHoOGMpj+Q/n7sh/h4id83XZkKIo1KNvIquK1tclsrsEHMUJHtKbNUv7c3fWi/bWiIoAPSDCCoOmhHpNziwLWaq5sFvpj7Fb5FNzrn2wgRabw1gtKhS8rSahTLyFhgzJqf3CKlypX3Gk7L6GQnYO6VnnpmqtsU0fsibo3U8sb7xg/HuA/hFtgIpI1yEi/A93/AtV5MOFUdfeY5XzsoVqsWDgWO+eJa5gLY56MZ+m0OPDA/pLBEunvJ65lR2RgQPI2yUoxG1orxAhdXJ2KWpSM0ZnucMA7YG6UCjr7Jv7Avvtm/cXLRrXu31RerQw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(1800799024)(36860700016)(82310400026)(10067099003)(11063799006)(56012099006)(3023799007)(6133799003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: dl/58O/wDHdaViuwbTAlWBjmDggfI2lurBc1nEJjigPD8/343DeFb5fdcXKCJqa/biJ21KkI0FglS9KEqJVKqayjPCEnmc4qrHIf1TaSm6zKmZPWiWog/FCB7auoa9Wch1XpKl2LwnzAs4H2+Xm0khpkL9Z7Gbaa+Z6Dt1e7vSJGQ3L6GvLB811aK70mDZD3YlkebTGUhsqKn5fQDT2I2E1JdWc5xUa+VMVMirEDGDIGcJGNgfY4EbV6bd5jR6fSOYZO9OOwb42iUnisjQYeJ9AgCUpmaj2xtfpGAv+m/9u+mm0dppJJfKL4q/nDD6E/ROeQ4qrvpE51v7pKqd8uiT2rLYK1VkZtZfJSAISQmNTzsI4D3+HnWd9g1d7e3q126l5jWHxCMGKKSl1GTQQuaWyBjn/1yU7n8nCAi135mhRWH5+PR7OUkUMMF39vOqOp
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2026 19:36:13.9249 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c41c0bf-d847-47c0-1611-08deffbb7631
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD6.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7222
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

From: Lijo Lazar <lijo.lazar@amd.com>

Move more IP version specific related things to ualink version file.
Use soc v1.0 IH client id defintion and define mpnht interrupt source
id in ivsrcid header.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c    | 28 +++++------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.h    |  4 ++-
 drivers/gpu/drm/amd/amdgpu/ualink_v1_0.c      | 24 +++++++++++++--
 .../ivsrcid/mpnht/irqsrcs_mpnht_15_0.h        | 30 +++++++++++++++++++
 4 files changed, 63 insertions(+), 23 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/include/ivsrcid/mpnht/irqsrcs_mpnht_15_0.h

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
index 63164f83342b6..58f16a5cae9e6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
@@ -1391,8 +1391,6 @@ static const struct kobj_type ualink_station_config_ktype = {
 
 int ualink_ip_sw_init(struct amdgpu_ip_block *ip_block)
 {
-	int r;
-
 	struct amdgpu_ualink_station_config *stations;
 	struct amdgpu_ualink_vpod_config *vpod_config;
 	struct amdgpu_ualink_ppod_setup *ppod_setup;
@@ -1432,12 +1430,6 @@ int ualink_ip_sw_init(struct amdgpu_ip_block *ip_block)
 	adev->ualink.config = vpod_config;
 	adev->ualink.stations = stations;
 
-	r = amdgpu_ualink_init_interrupt(adev);
-	if (r) {
-		dev_err(adev->dev, "Failed to add UALink irq: %d\n", r);
-		return r;
-	}
-
 	return 0;
 }
 
@@ -5964,32 +5956,28 @@ static const struct amdgpu_irq_src_funcs ualink_irq_funcs = {
 	.process = amdgpu_ualink_process_irq,
 };
 
-/* TODO: if move to header file soc21_enum.h */
-#define UALINK_IH_CLIENT_ID 0x1C
-#define UALINK_IH_SOURCE_ID 0x0
-
 /**
- * amdgpu_ualink_init_interrupt - initialization of UALink IRQ
+ * amdgpu_ualink_init_interrupt - register the UALink IRQ source
  * @adev: amdgpu device pointer
+ * @client_id: IH client ID for the interrupt source
+ * @src_id: source ID for the interrupt source
  *
- * Registers the UALink interrupt source with the IH (Interrupt Handler)
- * subsystem during early device initialization. This sets up the IRQ
- * callback functions for handling remote interrupts from peer GPUs.
+ * Registers the UALink interrupt source with the IH subsystem.
  *
  * Return: 0 on success, negative error code on failure
  */
-int amdgpu_ualink_init_interrupt(struct amdgpu_device *adev)
+int amdgpu_ualink_init_interrupt(struct amdgpu_device *adev,
+				 unsigned int client_id, unsigned int src_id)
 {
 	int r;
 
 	dev_dbg(adev->dev, "init ualink irq client_id 0x%x src_id 0x%x\n",
-		UALINK_IH_CLIENT_ID, UALINK_IH_SOURCE_ID);
+		client_id, src_id);
 
 	adev->ualink.irq.num_types = 1;
 	adev->ualink.irq.funcs = &ualink_irq_funcs;
 
-	r = amdgpu_irq_add_id(adev, UALINK_IH_CLIENT_ID,
-			      UALINK_IH_SOURCE_ID, &adev->ualink.irq);
+	r = amdgpu_irq_add_id(adev, client_id, src_id, &adev->ualink.irq);
 	return r;
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.h
index 97fe263a481db..22f5a48bf661d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.h
@@ -384,7 +384,9 @@ struct amdgpu_ualink_mgr {
 	unsigned long drop_msg_bitmap;
 };
 
-int amdgpu_ualink_init_interrupt(struct amdgpu_device *adev);
+int amdgpu_ualink_init_interrupt(struct amdgpu_device *adev,
+				 unsigned int client_id, unsigned int src_id);
+
 int amdgpu_ualink_sw_init(struct amdgpu_device *adev);
 void amdgpu_ualink_sw_fini(struct amdgpu_device *adev);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/ualink_v1_0.c b/drivers/gpu/drm/amd/amdgpu/ualink_v1_0.c
index 0fe2c0fba4cf9..58cf98ac94add 100644
--- a/drivers/gpu/drm/amd/amdgpu/ualink_v1_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/ualink_v1_0.c
@@ -23,6 +23,7 @@
 
 #include <linux/delay.h>
 #include "amdgpu.h"
+#include "ivsrcid/mpnht/irqsrcs_mpnht_15_0.h"
 #include "amdgpu_ualink.h"
 #include "ualink_v1_0.h"
 
@@ -104,11 +105,30 @@ static int ualink_v1_0_early_init(struct amdgpu_ip_block *ip_block)
 	return 0;
 }
 
+static int ualink_v1_0_sw_init(struct amdgpu_ip_block *ip_block)
+{
+	struct amdgpu_device *adev = ip_block->adev;
+	int r;
+
+	r = ualink_ip_sw_init(ip_block);
+	if (r)
+		return r;
+
+	r = amdgpu_ualink_init_interrupt(adev, SOC_V1_0_IH_CLIENTID_nHT,
+					 MPNHT_15_0__SRCID__REMOTE_INTERRUPT);
+	if (r) {
+		dev_err(adev->dev, "Failed to add UALink irq: %d\n", r);
+		return r;
+	}
+
+	return 0;
+}
+
 static const struct amd_ip_funcs ualink_v1_0_ip_funcs = {
 	.name = "ualink",
 	.early_init = ualink_v1_0_early_init,
 	.late_init = ualink_ip_late_init,
-	.sw_init = ualink_ip_sw_init,
+	.sw_init = ualink_v1_0_sw_init,
 	.sw_fini = ualink_ip_sw_fini,
 	.hw_init = ualink_ip_hw_init,
 };
@@ -119,4 +139,4 @@ const struct amdgpu_ip_block_version ualink_v1_0_ip_block = {
 	.minor = 0,
 	.rev = 0,
 	.funcs = &ualink_v1_0_ip_funcs,
-};
\ No newline at end of file
+};
diff --git a/drivers/gpu/drm/amd/include/ivsrcid/mpnht/irqsrcs_mpnht_15_0.h b/drivers/gpu/drm/amd/include/ivsrcid/mpnht/irqsrcs_mpnht_15_0.h
new file mode 100644
index 0000000000000..c960353f107db
--- /dev/null
+++ b/drivers/gpu/drm/amd/include/ivsrcid/mpnht/irqsrcs_mpnht_15_0.h
@@ -0,0 +1,30 @@
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
+#ifndef __IRQSRCS_MPNHT_15_0_H__
+#define __IRQSRCS_MPNHT_15_0_H__
+
+/* MPNHT remote interrupt */
+#define MPNHT_15_0__SRCID__REMOTE_INTERRUPT            0x00
+
+#endif
-- 
2.55.0

