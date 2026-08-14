Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B87B5C5DF70
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Aug 2026 21:03:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DD7B410F704;
	Fri, 14 Aug 2026 21:03:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ZMe1mjiE";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010007.outbound.protection.outlook.com [52.101.201.7])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CB88B10F6DB
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Aug 2026 21:03:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qY+KmJmfYe0RDL2jlgp91NHFJgtXpjlANwH0/XKrWPC9/INLhBIE5eut3y9bTgbueiO1V7gZCGTvqfytLovEkGLvSk2eK5tzyPAYtKr4VFS7cGWtAyvJ53ttnEsILzGGZPVpZ+BBw8z/tnb2R3p7E2LgvdXVn0gDlRRx+4n/dDjs4yAqR/TL84IVahjFG4uGL14ZKx6xh/IPiaGECgEuRZYJqnT6OwKdt+z4YBLTtM99umapmNTbXZ3uFhK0yCV4P9RkUelyGxKmYBW5AKqaigrvWn7lzuYPaas5Q9JXv8/6KV6DjafIv7KrQgd53buE6AmpJYvs1CnxaFv3Ot5X7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5rQwHL6TvOxSMBWaCO8XvcdsjKYt82K6s5cwXZIzWaY=;
 b=N6f2tPWb0RLZ9eiRcTEG1S0h70i8/8cIL38mjQ0BT3w7dfawFgiABN76UVrczZTZxxdcDwTMPdqKzXO27CbBGew5pvJq4BKTGJ+63FVBz9skDOVovkjM23Or3DsnPl2B0IWDrmsvNphZOkuO6xeGoDEj2hbsp54y0Y6XamxmZ0vz74AIRBzYp24LULsz75JpVYYCap3IjO7rjAe2VvgtULVqLwx9T7MY86B1NYt9GGRpETYblaohVa8XDMTVR5OylCgRVjQDSWCRC5qePlntKs40vWnof5heZerwDeLCQU06cybYPM3YWoxZ7Pcu7J0WhqAFvBvTXMZ/cN1iCe4xKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5rQwHL6TvOxSMBWaCO8XvcdsjKYt82K6s5cwXZIzWaY=;
 b=ZMe1mjiEgKNhgXCpjfWm/ATyE8wGzOhfE79fY7kIx3rDeQcJJ67+niCSzkarxmvYsGK17tCf+T7k+MKCrzP/KApFODHZjHCKGnCJUYd2owci8egQZwE46TjER3JF5y7sxJddbQAQER61akj+aCy6nblKPQSUiWhSPtoLgKqS5XQ=
Received: from SA1P222CA0052.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:2d0::28)
 by SJ2PR12MB8738.namprd12.prod.outlook.com (2603:10b6:a03:548::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.13; Fri, 14 Aug
 2026 21:03:15 +0000
Received: from SA2PEPF0000150B.namprd04.prod.outlook.com
 (2603:10b6:806:2d0:cafe::93) by SA1P222CA0052.outlook.office365.com
 (2603:10b6:806:2d0::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.16 via Frontend Transport; Fri,
 14 Aug 2026 21:03:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SA2PEPF0000150B.mail.protection.outlook.com (10.167.242.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.3 via Frontend Transport; Fri, 14 Aug 2026 21:03:15 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 14 Aug
 2026 16:03:08 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 14 Aug
 2026 16:03:07 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Fri, 14 Aug 2026 16:03:07 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: YiPeng Chai <YiPeng.Chai@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 017/109] drm/amd/ras: Add fifo to cache ras data from mce
 notification
Date: Fri, 14 Aug 2026 17:01:14 -0400
Message-ID: <20260814210246.3067612-18-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260814210246.3067612-1-alexander.deucher@amd.com>
References: <20260814210246.3067612-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF0000150B:EE_|SJ2PR12MB8738:EE_
X-MS-Office365-Filtering-Correlation-Id: 53045793-1b4b-4421-cd23-08defa4775ae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|1800799024|376014|23010399003|82310400026|6133799003|10067099003|56012099006|11063799006|18002099003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info: RjUbRKp27meQ6KCmZdhS+7U4VkQgIS5ZDT9XHmq1A6hkjIgsThhMzcG47fosTt6SlsJ8PMY3T2Sl4WL7U+96468ByKAGuVRftZNn1mkfxrXaTwahn1mh8GR/QwjMG/OPFFe/YSgsWyMYDKlCuPbCfBQ1meAsCzZmQtZAStmEq14syAr5RCrPySpUMt6OZ0t9p3k3d/7MWiBdodPeJgaRw3hDULW2mhllW5V7laZjJniZD42RvhhN1euCBzBdZinIH1wJ8eHNl7v3q/pK5Lv/xS3sMyQV75oEHJeDBJMVHjDDLnx+FErt61+kxmgLVSgfDSoAoBMrpXFQjDhWGkT3k82hiSotFQocO8+1SF1w3vw39ldhMp6i8lt5gZ9ptWpMgHD94nE+WuTu6sfvCAttmfUqPDM/YeQpqGbv8hXMfSqgG+2t1xi7w2SelseRd8ivLB7Mc7Bkdc+TBPYKD/uNsS7sXVUtSks2dGeEiRRW9zEZ0TZKw5/zKV3c6P1I+wW4h+8aqe9uU+UFPI4h1/2CqNMFBF3KmfNKYRCQpjLop3juOWlqui0xnB6bUGXuLoncZd6Os5b8qKfme9OqstqNEOe2rqg1hLhW09R591WOmazian/v7yx8OSz2oSLe2/OIxVQcpx9LR9Kymk0jgmnXakrVrAUNoagj3RVX50lyZ5eVf7d7z6SI0Dg76jsZopdfEXgGqadZ5r3QCswaQAwGrw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(1800799024)(376014)(23010399003)(82310400026)(6133799003)(10067099003)(56012099006)(11063799006)(18002099003)(22082099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: m8joCsvEG6S748OQGmJTD3ph5k9qjxtKGHW5dL5SWxWQ3rrn05K4Z4tV+h2WFGSBlPdzQOX1wEhvh3GIARBKABmb0MuHbF/EgU3gck9zTVUOj+VXIQBHohgG3h1eoMn4mNR4bdnc0Wc6JyrGV5u+KEO23f8upH5WlfR3yInCeX5nMKvv7n23XCMRPIiAya7ZXsXNEAY1odA6yMc1P+yCBV4bChULgXC7xKZZ6BFIklCMhalVfXOPm8NeygSA+GXGiadAwskqdcaFQp20eK3mjCmDvsDZQkn7TDDK3l0kF+NNcuc5ueu8IW7/7qZ6RFPc64Zo3ylSKHLGbRiF4/KPZFvk6GOWRDkF7l68cipqdIm4oQAkOfu19xljSeqvm4yN/aW0XmfsPM3Sa7rosdsrFnn/ja/GlCWQnSy1sv6kig8pdujEtXM0S2Fx04jMPH6u
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2026 21:03:15.6797 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 53045793-1b4b-4421-cd23-08defa4775ae
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF0000150B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8738
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

From: YiPeng Chai <YiPeng.Chai@amd.com>

Add fifo to cache ras data from mce notification.

Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/ras/core/Makefile   |   3 +-
 drivers/gpu/drm/amd/ras/core/aca.h      |   1 +
 drivers/gpu/drm/amd/ras/core/core.c     |   5 +
 drivers/gpu/drm/amd/ras/core/log_ring.h |   1 +
 drivers/gpu/drm/amd/ras/core/ras.h      |   2 +
 drivers/gpu/drm/amd/ras/core/ras_mce.c  | 146 ++++++++++++++++++++++++
 drivers/gpu/drm/amd/ras/core/ras_mce.h  |  51 +++++++++
 7 files changed, 208 insertions(+), 1 deletion(-)
 create mode 100644 drivers/gpu/drm/amd/ras/core/ras_mce.c
 create mode 100644 drivers/gpu/drm/amd/ras/core/ras_mce.h

diff --git a/drivers/gpu/drm/amd/ras/core/Makefile b/drivers/gpu/drm/amd/ras/core/Makefile
index 871c104db24e5..81f148c76d8d3 100644
--- a/drivers/gpu/drm/amd/ras/core/Makefile
+++ b/drivers/gpu/drm/amd/ras/core/Makefile
@@ -38,7 +38,8 @@ RAS_CORE_FILES = core.o \
 			ras_cper.o \
 			ras_psp.o \
 			ras_psp_v13_0.o \
-			eeprom_fw.o
+			eeprom_fw.o \
+			ras_mce.o
 
 
 RAS_CORE = $(addprefix $(AMD_GPU_RAS_PATH)/core/,$(RAS_CORE_FILES))
diff --git a/drivers/gpu/drm/amd/ras/core/aca.h b/drivers/gpu/drm/amd/ras/core/aca.h
index 343525dab744e..f42f408f4acfe 100644
--- a/drivers/gpu/drm/amd/ras/core/aca.h
+++ b/drivers/gpu/drm/amd/ras/core/aca.h
@@ -54,6 +54,7 @@ struct aca_block;
 
 struct aca_bank_reg {
 	uint64_t timestamp;
+	u32 bank_type;
 	u32 ecc_type;
 	u64 seq_no;
 	u64 regs[ACA_REG_MAX_COUNT];
diff --git a/drivers/gpu/drm/amd/ras/core/core.c b/drivers/gpu/drm/amd/ras/core/core.c
index ab5a287a83b51..2ddb011e8082b 100644
--- a/drivers/gpu/drm/amd/ras/core/core.c
+++ b/drivers/gpu/drm/amd/ras/core/core.c
@@ -375,6 +375,10 @@ int ras_core_sw_init(struct ras_core_context *ras_core)
 	if (ret)
 		return ret;
 
+	ret = ras_mce_sw_init(ras_core);
+	if (ret)
+		return ret;
+
 	return 0;
 }
 
@@ -388,6 +392,7 @@ int ras_core_sw_fini(struct ras_core_context *ras_core)
 	ras_cmd_fini(ras_core);
 	ras_umc_sw_fini(ras_core);
 	ras_aca_sw_fini(ras_core);
+	ras_mce_sw_fini(ras_core);
 
 	return 0;
 }
diff --git a/drivers/gpu/drm/amd/ras/core/log_ring.h b/drivers/gpu/drm/amd/ras/core/log_ring.h
index 2eaeccfb8965f..bcefd228aad3c 100644
--- a/drivers/gpu/drm/amd/ras/core/log_ring.h
+++ b/drivers/gpu/drm/amd/ras/core/log_ring.h
@@ -40,6 +40,7 @@ enum ras_log_event {
 	RAS_LOG_EVENT_RMA,
 	RAS_LOG_EVENT_MCE,
 	RAS_LOG_EVENT_BOOT,
+	RAS_LOG_EVENT_CPU_RAS,
 	RAS_LOG_EVENT_COUNT_MAX,
 };
 
diff --git a/drivers/gpu/drm/amd/ras/core/ras.h b/drivers/gpu/drm/amd/ras/core/ras.h
index af19a0983fcea..2fed47a476168 100644
--- a/drivers/gpu/drm/amd/ras/core/ras.h
+++ b/drivers/gpu/drm/amd/ras/core/ras.h
@@ -37,6 +37,7 @@
 #include "ras_psp.h"
 #include "log_ring.h"
 #include "eeprom_fw.h"
+#include "ras_mce.h"
 
 #define RAS_HW_ERR		"[Hardware Error]: "
 
@@ -348,6 +349,7 @@ struct ras_core_context {
 	struct ras_mp1 ras_mp1;
 	struct ras_process ras_proc;
 	struct ras_log_ring ras_log_ring;
+	struct ras_mce ras_mce;
 
 	const struct ras_sys_func *sys_fn;
 
diff --git a/drivers/gpu/drm/amd/ras/core/ras_mce.c b/drivers/gpu/drm/amd/ras/core/ras_mce.c
new file mode 100644
index 0000000000000..018429e397979
--- /dev/null
+++ b/drivers/gpu/drm/amd/ras/core/ras_mce.c
@@ -0,0 +1,146 @@
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
+#include "ras.h"
+#include "ras_mce.h"
+#define RAS_MCE_BANK_FIFO_SIZE  (1024 * sizeof(struct aca_bank_reg))
+#define RAS_MCE_BANK_COUNT(x) ((x) / sizeof(struct aca_bank_reg))
+
+struct mce_smca_bank_range {
+	u32 start;
+	u32 end;
+};
+
+static const struct mce_smca_bank_range mce_smca_bank_range_v5[] = {
+	[MCE_BANK_TYPE_GPU] = {32, 63},
+	[MCE_BANK_TYPE_CPU] = {0, 31},
+};
+
+bool ras_mce_check_bank(struct ras_core_context *ras_core,
+		enum mce_bank_type type, u32 bank)
+{
+	const struct mce_smca_bank_range *range;
+	u32 aca_ip_version = 0;
+
+	if (!ras_core || type >= MCE_BANK_TYPE_MAX)
+		return false;
+
+	if (ras_core_get_ip_version(ras_core,
+				RAS_UNIT_ID_ACA, &aca_ip_version))
+		return false;
+
+	switch (aca_ip_version) {
+	case IP_VERSION(5, 0, 0):
+		range = &mce_smca_bank_range_v5[type];
+		break;
+	default:
+		return false;
+	}
+
+	return  ((bank >= range->start) && (bank <= range->end)) ? true : false;
+}
+
+static int ras_mce_add_gpu_bank(struct ras_core_context *ras_core,
+			struct aca_bank_reg *aca_bank)
+{
+	struct ras_mce *mce = &ras_core->ras_mce;
+	int ret;
+
+	ret = kfifo_in_spinlocked(&mce->mce_fifo,
+			aca_bank, sizeof(*aca_bank), &mce->mce_fifo_lock);
+	if (ret)
+		ras_process_add_interrupt_req(ras_core, NULL, true);
+
+	return ret ? 0 : -ENOSPC;
+}
+
+static int ras_mce_log_cpu_bank(struct ras_core_context *ras_core,
+			struct aca_bank_reg *aca_bank)
+{
+
+	ras_log_ring_add_log_event(ras_core,
+		RAS_LOG_EVENT_CPU_RAS, aca_bank, sizeof(*aca_bank), NULL);
+
+	return 0;
+}
+
+int ras_mce_sw_init(struct ras_core_context *ras_core)
+{
+	struct ras_mce *mce = &ras_core->ras_mce;
+
+	if (kfifo_alloc(&mce->mce_fifo, RAS_MCE_BANK_FIFO_SIZE, GFP_KERNEL))
+		return -ENOMEM;
+
+	spin_lock_init(&mce->mce_fifo_lock);
+
+	return 0;
+}
+
+int ras_mce_sw_fini(struct ras_core_context *ras_core)
+{
+	kfifo_free(&ras_core->ras_mce.mce_fifo);
+
+	return 0;
+}
+
+int ras_mce_get_bank_count(struct ras_core_context *ras_core,
+				enum ras_err_type type, u32 *count)
+{
+	u32 data_count;
+
+	if (!ras_core || !count)
+		return -EINVAL;
+
+	data_count = RAS_MCE_BANK_COUNT(kfifo_len(&ras_core->ras_mce.mce_fifo));
+
+	*count = (data_count <= MAX_RECORD_PER_BATCH) ? data_count : MAX_RECORD_PER_BATCH;
+
+	return 0;
+}
+
+int ras_mce_dump_bank(struct ras_core_context *ras_core,
+			u32 type, u32 idx, struct aca_bank_reg *reg_bank)
+{
+	struct ras_mce *mce = &ras_core->ras_mce;
+	int ret;
+
+	if (!ras_core || !reg_bank)
+		return -EINVAL;
+
+	ret = kfifo_out_spinlocked(&mce->mce_fifo,
+				reg_bank, sizeof(*reg_bank), &mce->mce_fifo_lock);
+
+	return ret ? 0 : -ENOENT;
+}
+
+int ras_mce_add_aca_bank(struct ras_core_context *ras_core,
+		struct aca_bank_reg *aca_bank)
+{
+	if (!ras_core || !aca_bank)
+		return -EINVAL;
+
+	return (aca_bank->bank_type == MCE_BANK_TYPE_GPU) ?
+		ras_mce_add_gpu_bank(ras_core, aca_bank) :
+		ras_mce_log_cpu_bank(ras_core, aca_bank);
+}
diff --git a/drivers/gpu/drm/amd/ras/core/ras_mce.h b/drivers/gpu/drm/amd/ras/core/ras_mce.h
new file mode 100644
index 0000000000000..3b1f690d2eb69
--- /dev/null
+++ b/drivers/gpu/drm/amd/ras/core/ras_mce.h
@@ -0,0 +1,51 @@
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
+ *
+ */
+#ifndef __RAS_MCE_H__
+#define __RAS_MCE_H__
+
+enum mce_bank_type {
+	MCE_BANK_TYPE_GPU,
+	MCE_BANK_TYPE_CPU,
+	MCE_BANK_TYPE_MAX
+};
+
+struct ras_mce {
+	struct kfifo mce_fifo;
+	spinlock_t mce_fifo_lock;
+};
+
+int ras_mce_sw_init(struct ras_core_context *ras_core);
+int ras_mce_sw_fini(struct ras_core_context *ras_core);
+
+int ras_mce_get_bank_count(struct ras_core_context *ras_core,
+	enum ras_err_type type, u32 *count);
+int ras_mce_dump_bank(struct ras_core_context *ras_core,
+	u32 type, u32 idx, struct aca_bank_reg *aca_bank);
+
+bool ras_mce_check_bank(struct ras_core_context *ras_core,
+		enum mce_bank_type, u32 bank);
+int ras_mce_add_aca_bank(struct ras_core_context *ras_core,
+		struct aca_bank_reg *aca_bank);
+
+#endif
-- 
2.55.0

