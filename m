Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B3E8C5DF72
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Aug 2026 21:03:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5654310F70F;
	Fri, 14 Aug 2026 21:03:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Faqo44Cf";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012015.outbound.protection.outlook.com [52.101.53.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D6DC310F6E2
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Aug 2026 21:03:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y5LW4gYXRpywjc99UugMmfjK6TWAcI6IDVNz4zsafHUFnlHSK8YqIzer/cwk8xi6QsBTN95hQvjeDTVFLcdROAo6T6ELopHC1PvpM7AuZhcXbgAfeIShnFiQPkK6VA/UFTmk+kOpMZhDL5l+eOWWHycCTg6pWK7XhE23SsbcNr9FMBguXsyB087OX8fISKFUWSMzi+ElB84P5a558NkA0Z/10Q2GpyQBNg85XpgGv9NlhMkS6KKCES21FCE5GyGa30xPvN0bxel7QjZbQrszRtt9jCr4eAsVjtwL5yavRWhPM4M5LLNbxuZQeH2dXk5V3pVXgsXES7bvTi39GOGUFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p34e41TXmhXsos2OnxjLDud9jDzSXd6tJUp7/i1JKlU=;
 b=k1NIB4BQJv5MWSTNxosERGBvyF0tHU1VAun0oYos3C12XOifcVoMSh9aYlTr5NGmT86ADSN9r3vbWYxDhOdoMqSdRwakz8Cp7DmMi0s8aO1IN2AxDELVmMNyzgtOMaOMFiTNo3nq1PU9piCKIVgcbW7VEHVF2g+FnaIkyZ6jbRHFAaH8FIDxU+k1GMtvKAbigbJpanh/zEUw7aZ5Pgxs8KbPXe5v5oMVgTNc10Xu26dmQTRF6A1lmjnzi3glP6bgC2DEd1jJ21TUSYydUGnjYAuEo2bGzluJmmjwYypRrj8LpMjDwK1/c30IfZA+uirYvPtWRijtCRyoXjc8Pe0kZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p34e41TXmhXsos2OnxjLDud9jDzSXd6tJUp7/i1JKlU=;
 b=Faqo44Cf3fwiTx6XyUDkh8J9J+ntQPquyd9LKbpfhZikJNbIOoKBZLAe3HNcNkboyLpJGyw8e6vGhm1L6NN2kEJs/wEMDRwtaF74HoUHcJUlLTRFjjX5gkDNsDgsPOIVHJny/TkuJd1T+41DYLhO9LWxVhZyuBYuq2PipPfvsI8=
Received: from CH2PR04CA0007.namprd04.prod.outlook.com (2603:10b6:610:52::17)
 by SA5PPF80B25317E.namprd12.prod.outlook.com
 (2603:10b6:80f:fc04::8d2) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.24; Fri, 14 Aug
 2026 21:03:29 +0000
Received: from CH3PEPF00000014.namprd21.prod.outlook.com
 (2603:10b6:610:52:cafe::66) by CH2PR04CA0007.outlook.office365.com
 (2603:10b6:610:52::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.16 via Frontend Transport; Fri,
 14 Aug 2026 21:03:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH3PEPF00000014.mail.protection.outlook.com (10.167.244.119) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.0 via Frontend Transport; Fri, 14 Aug 2026 21:03:29 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 14 Aug
 2026 16:03:21 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 14 Aug
 2026 16:03:21 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Fri, 14 Aug 2026 16:03:21 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: YiPeng Chai <YiPeng.Chai@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 040/109] drm/amd/ras: Support retrieving bad page info from
 mp1_v15_0
Date: Fri, 14 Aug 2026 17:01:37 -0400
Message-ID: <20260814210246.3067612-41-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260814210246.3067612-1-alexander.deucher@amd.com>
References: <20260814210246.3067612-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000014:EE_|SA5PPF80B25317E:EE_
X-MS-Office365-Filtering-Correlation-Id: c34399a4-72ed-41a7-e160-08defa477dab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700016|23010399003|82310400026|3023799007|10067099003|22082099003|18002099003|11063799006|6133799003|56012099006;
X-Microsoft-Antispam-Message-Info: J4K++VvHsjdfHs7MMb17zvcCcE90Wxn/rhifn+xRd2pf0xrkcmkAcytRYgHLTHl9ZaCScEet5XR2L3iAUde/JcTuKQNJtm2q4SBob09JJzakKKR9dgAR8S2lY1WBuOHB+BckpWRfgtPUBpKQBVQ64j2oEWCinla0X2w21QED1XZg1G6T/5gQnSItoCm3dlxOOz9Qj3WiIC7PSGjauawSH6BfQ1gCBlo4l4WaDYC6CDDKgOxXaS3Ia9RBmxDUhXdXeP6SgJyx82Nd/9zRpee+HQMVDpC688QLCWot7PFS1KcqUJbNNIhwgqIyYu43KTpv6v0iEUfUCg1FBUMolHwhip6MmX/xUibWleIM7omx6xmG3a5XJtL+fqqSgOvR2LZ4y2C/Zin6tbGEjckX2qQbFtV+3WTIsmrMRoRgDqxDhjh78BPmPiMWArNf7wi9pd93vFLi2koVs3f8EbQwxcxlD4ynExRNH6PEuOJOnHSTVMgUHdOWeUoUoxb+fphmGiuJOtwOKUy6sY5NjHkw/9GiMosvEewDX7Ubrv8BwFN0asF+GV/oMeQ31AoVRyM2MVp/MG4AtzhF1gdaR0Efv158L6G+CCltphcbjNDnP95T9sdRGB3aWMcXll2LXKWbQwImSWxnUKuABEXBFkfB6XIBMrUIC+qAaJZ/p28vInKdMwI=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700016)(23010399003)(82310400026)(3023799007)(10067099003)(22082099003)(18002099003)(11063799006)(6133799003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: AzLZO+3U3MIzaVRpknzI8AcXB0phTb3NIQButKXdfbaH9Zve6oK+n+G+cEhvLPHWV8Vn9SWxpG45+p515FjOe59Pbun6rm0clkAxfUUQT+nDbHVa4wCdnHkWRnlGuQzPAWxLqgOV4oLFrvcwWGziudIEc2IPL1hTjT2qTCcg+45oWiy80BJOWjEmRjhvH+STWD2sogR5cxkZSPyB+vFqwT8IE21V2sboo8r0EUzRMhKshyeDgA3Xm1gH4C/K7JkXP1U6ddGZXF/7w1iiAPJu+QTq9NyXyB97YV8zyBXQNksmJGh8c1fvGOzr9ixrWeJ7RZcXeI4avJO7bSsSxfFNTn0I4ovPEirxSelY/OD7gZaRHqKHrz9dHbb678tj9jDK6UoRaieTQZbEx97FBCG2c6NB2KxmPiHbyOEyC/xlXd2koreocvPz2PNg8tYHsCji
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2026 21:03:29.0954 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c34399a4-72ed-41a7-e160-08defa477dab
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF00000014.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPF80B25317E
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

Support retrieving bad page info from mp1_v15_0.

Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/ras/core/Makefile         |   1 +
 drivers/gpu/drm/amd/ras/core/ras.h            |   2 +-
 drivers/gpu/drm/amd/ras/core/ras_mp1.c        |   4 +-
 drivers/gpu/drm/amd/ras/core/ras_mp1.h        |  14 ++
 drivers/gpu/drm/amd/ras/core/ras_mp1_v15_0.c  | 129 ++++++++++++++++++
 drivers/gpu/drm/amd/ras/core/ras_mp1_v15_0.h  |  30 ++++
 drivers/gpu/drm/amd/ras/ras_mgr/Makefile      |   1 +
 .../gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c  |   3 +-
 .../gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mp1.c  |  70 ++++++++++
 .../gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mp1.h  |  30 ++++
 10 files changed, 280 insertions(+), 4 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/ras/core/ras_mp1_v15_0.c
 create mode 100644 drivers/gpu/drm/amd/ras/core/ras_mp1_v15_0.h
 create mode 100644 drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mp1.c
 create mode 100644 drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mp1.h

diff --git a/drivers/gpu/drm/amd/ras/core/Makefile b/drivers/gpu/drm/amd/ras/core/Makefile
index 2dfb1f96b072f..1f4d6d642a73a 100644
--- a/drivers/gpu/drm/amd/ras/core/Makefile
+++ b/drivers/gpu/drm/amd/ras/core/Makefile
@@ -22,6 +22,7 @@
 RAS_CORE_FILES = core.o \
 			ras_mp1.o \
 			ras_mp1_v13_0.o \
+			ras_mp1_v15_0.o \
 			aca.o  \
 			aca_v1_0.o \
 			ras_aca_v5_0.o \
diff --git a/drivers/gpu/drm/amd/ras/core/ras.h b/drivers/gpu/drm/amd/ras/core/ras.h
index 47cc934520448..10fa7068fc7a4 100644
--- a/drivers/gpu/drm/amd/ras/core/ras.h
+++ b/drivers/gpu/drm/amd/ras/core/ras.h
@@ -200,7 +200,7 @@ struct ras_mp1_sys_func {
 	int (*mp1_dump_valid_bank)(struct ras_core_context *ras_core,
 			u32 msg, u32 idx, u32 reg_idx, u64 *val);
 	int (*mp1_send_eeprom_msg)(struct ras_core_context *ras_core,
-			enum ras_fw_eeprom_cmd index, uint32_t param, uint32_t *read_arg);
+			u32 msg_id, uint32_t param, uint32_t *read_arg);
 	int (*mp1_get_ras_enabled_mask)(struct ras_core_context *ras_core,
 			uint64_t *enabled_mask);
 	int (*mp1_set_debug_mode)(struct ras_core_context *ras_core, bool enable);
diff --git a/drivers/gpu/drm/amd/ras/core/ras_mp1.c b/drivers/gpu/drm/amd/ras/core/ras_mp1.c
index eccd6f16c35a7..7a2a6da26ae38 100644
--- a/drivers/gpu/drm/amd/ras/core/ras_mp1.c
+++ b/drivers/gpu/drm/amd/ras/core/ras_mp1.c
@@ -25,6 +25,7 @@
 #include "ras.h"
 #include "ras_mp1.h"
 #include "ras_mp1_v13_0.h"
+#include "ras_mp1_v15_0.h"
 
 static const struct ras_mp1_ip_func *ras_mp1_get_ip_funcs(
 				struct ras_core_context *ras_core, uint32_t ip_version)
@@ -35,8 +36,7 @@ static const struct ras_mp1_ip_func *ras_mp1_get_ip_funcs(
 	case IP_VERSION(13, 0, 12):
 		return &mp1_ras_func_v13_0;
 	case IP_VERSION(15, 0, 8):
-		//TBD for dGPU
-		break;
+		return &mp1_ras_func_v15_0;
 	default:
 		RAS_DEV_ERR(ras_core->dev,
 			"MP1 ip version(0x%x) is not supported!\n", ip_version);
diff --git a/drivers/gpu/drm/amd/ras/core/ras_mp1.h b/drivers/gpu/drm/amd/ras/core/ras_mp1.h
index a00eb8117885b..3b3d4cab1d0c9 100644
--- a/drivers/gpu/drm/amd/ras/core/ras_mp1.h
+++ b/drivers/gpu/drm/amd/ras/core/ras_mp1.h
@@ -25,6 +25,20 @@
 #define __RAS_MP1_H__
 #include "ras.h"
 
+enum ras_mp1_msg_id {
+	RAS_MP1_MSG_GetRasTableVersion,
+	RAS_MP1_MSG_GetRmaStatus,
+	RAS_MP1_MSG_GetBadPageCount,
+	RAS_MP1_MSG_GetBadPageMcaAddr,
+	RAS_MP1_MSG_GetBadPagePaAddr,
+	RAS_MP1_MSG_SetTimestamp,
+	RAS_MP1_MSG_GetTimestamp,
+	RAS_MP1_MSG_GetRasPolicy,
+	RAS_MP1_MSG_GetBadPageIpId,
+	RAS_MP1_MSG_EraseRasTable,
+	RAS_MP1_MSG_MAX
+};
+
 struct eeprom_err_record {
 	u32 timestamp;
 
diff --git a/drivers/gpu/drm/amd/ras/core/ras_mp1_v15_0.c b/drivers/gpu/drm/amd/ras/core/ras_mp1_v15_0.c
new file mode 100644
index 0000000000000..2cd0f266b5855
--- /dev/null
+++ b/drivers/gpu/drm/amd/ras/core/ras_mp1_v15_0.c
@@ -0,0 +1,129 @@
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
+#include "ras.h"
+#include "ras_mp1.h"
+#include "core_status.h"
+#include "ras_mp1_v13_0.h"
+
+#define MSG_DATA_LOW32(idx)   (idx | (0x1 << 16))
+#define MSG_DATA_HIGH32(idx)  (idx | (0x2 << 16))
+
+static int __send_mp1_msg(struct ras_core_context *ras_core,
+		enum ras_mp1_msg_id msg_id, u32 input, u32 *output)
+{
+	if (msg_id >= RAS_MP1_MSG_MAX)
+		return -EINVAL;
+
+	return ras_core->ras_mp1.sys_func->mp1_send_eeprom_msg(ras_core,
+				msg_id, input, output);
+}
+
+static int ras_mp1_v15_get_table_version(struct ras_core_context *ras_core,
+				     u32 *table_ver)
+{
+	return __send_mp1_msg(ras_core, RAS_MP1_MSG_GetRasTableVersion,
+			0, table_ver);
+}
+
+static bool ras_mp1_v15_rma_detected(struct ras_core_context *ras_core)
+{
+	u32 rma = 0;
+
+	if (__send_mp1_msg(ras_core, RAS_MP1_MSG_GetRmaStatus, 0, &rma))
+		return false;
+
+	return rma;
+}
+
+static int ras_mp1_v15_set_timestamp(struct ras_core_context *ras_core,
+			u32 timestamp)
+{
+	if (!timestamp)
+		return -EINVAL;
+
+	return __send_mp1_msg(ras_core, RAS_MP1_MSG_SetTimestamp, timestamp, NULL);
+}
+
+static int ras_mp1_v15_reset_ras_table(struct ras_core_context *ras_core,
+				   u32 *result)
+{
+	if (!result)
+		return -EINVAL;
+
+	return __send_mp1_msg(ras_core, RAS_MP1_MSG_EraseRasTable, 0, result);
+}
+
+static int ras_mp1_v15_get_record_count(struct ras_core_context *ras_core,
+				u32 *count)
+{
+	if (!count)
+		return -EINVAL;
+
+	*count = 0;
+
+	return __send_mp1_msg(ras_core, RAS_MP1_MSG_GetBadPageCount, 0, count);
+}
+
+static int ras_mp1_v15_get_record(struct ras_core_context *ras_core,
+			u32 idx, struct eeprom_err_record *rec)
+{
+	int ret;
+
+	if (!rec)
+		return 0;
+
+	ret = __send_mp1_msg(ras_core, RAS_MP1_MSG_GetTimestamp,
+			idx, &rec->timestamp);
+	if (ret)
+		return ret;
+
+	ret = __send_mp1_msg(ras_core, RAS_MP1_MSG_GetBadPageMcaAddr,
+			MSG_DATA_LOW32(idx), &rec->mca_addr_low);
+	if (ret)
+		return ret;
+
+	ret = __send_mp1_msg(ras_core, RAS_MP1_MSG_GetBadPageMcaAddr,
+			MSG_DATA_HIGH32(idx), &rec->mca_addr_high);
+	if (ret)
+		return ret;
+
+	ret = __send_mp1_msg(ras_core, RAS_MP1_MSG_GetBadPageIpId,
+			MSG_DATA_LOW32(idx), &rec->ipid_low);
+	if (ret)
+		return ret;
+
+	ret = __send_mp1_msg(ras_core, RAS_MP1_MSG_GetBadPageIpId,
+			MSG_DATA_HIGH32(idx), &rec->ipid_high);
+
+	return ret;
+}
+
+const struct ras_mp1_ip_func mp1_ras_func_v15_0 = {
+	.get_table_version = ras_mp1_v15_get_table_version,
+	.rma_detected = ras_mp1_v15_rma_detected,
+	.set_timestamp = ras_mp1_v15_set_timestamp,
+	.reset_ras_table = ras_mp1_v15_reset_ras_table,
+	.get_record_count = ras_mp1_v15_get_record_count,
+	.get_record = ras_mp1_v15_get_record,
+};
diff --git a/drivers/gpu/drm/amd/ras/core/ras_mp1_v15_0.h b/drivers/gpu/drm/amd/ras/core/ras_mp1_v15_0.h
new file mode 100644
index 0000000000000..c93b40a604c1a
--- /dev/null
+++ b/drivers/gpu/drm/amd/ras/core/ras_mp1_v15_0.h
@@ -0,0 +1,30 @@
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
+#ifndef __RAS_MP1_V15_0_H__
+#define __RAS_MP1_V15_0_H__
+#include "ras_mp1.h"
+
+extern const struct ras_mp1_ip_func mp1_ras_func_v15_0;
+
+#endif
diff --git a/drivers/gpu/drm/amd/ras/ras_mgr/Makefile b/drivers/gpu/drm/amd/ras/ras_mgr/Makefile
index 70649c49d1ff6..3df2a290f67b1 100644
--- a/drivers/gpu/drm/amd/ras/ras_mgr/Makefile
+++ b/drivers/gpu/drm/amd/ras/ras_mgr/Makefile
@@ -22,6 +22,7 @@ RAS_MGR_FILES = amdgpu_ras_sys.o  \
 		amdgpu_ras_mgr.o \
 		amdgpu_ras_eeprom_i2c.o \
 		amdgpu_ras_mp1_v13_0.o \
+		amdgpu_ras_mp1.o \
 		amdgpu_ras_cmd.o \
 		amdgpu_virt_ras_cmd.o \
 		amdgpu_ras_process.o \
diff --git a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c
index 030edfebd0b78..c71bd447d1b2c 100644
--- a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c
+++ b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c
@@ -31,6 +31,7 @@
 #include "amdgpu_ras_process.h"
 #include "amdgpu_ras_eeprom_i2c.h"
 #include "amdgpu_ras_mp1_v13_0.h"
+#include "amdgpu_ras_mp1.h"
 #include "amdgpu_ras_nbio_v7_9.h"
 #include "amdgpu_ras_mce.h"
 
@@ -212,7 +213,7 @@ static int amdgpu_ras_mgr_init_mp1_config(struct amdgpu_device *adev,
 		mp1_cfg->mp1_sys_fn = &amdgpu_ras_mp1_sys_func_v13_0;
 		break;
 	case IP_VERSION(15, 0, 8):
-		//TBD for dGPU
+		mp1_cfg->mp1_sys_fn = &amdgpu_ras_mp1_sys_func;
 		break;
 	default:
 		RAS_DEV_ERR(adev,
diff --git a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mp1.c b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mp1.c
new file mode 100644
index 0000000000000..b2d9148a36f99
--- /dev/null
+++ b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mp1.c
@@ -0,0 +1,70 @@
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
+#include "amdgpu_smu.h"
+#include "amdgpu_reset.h"
+#include "ras.h"
+
+static const enum smu_message_type ras_smu_msg_maps[RAS_MP1_MSG_MAX] = {
+	[RAS_MP1_MSG_GetRasTableVersion] = SMU_MSG_GetRASTableVersion,
+	[RAS_MP1_MSG_GetBadPageCount] = SMU_MSG_GetBadPageCount,
+	[RAS_MP1_MSG_GetBadPageMcaAddr] = SMU_MSG_GetBadPageMcaAddr,
+	[RAS_MP1_MSG_SetTimestamp] = SMU_MSG_SetTimestamp,
+	[RAS_MP1_MSG_GetTimestamp] = SMU_MSG_GetTimestamp,
+	[RAS_MP1_MSG_GetBadPageIpId] = SMU_MSG_GetBadPageIpid,
+	[RAS_MP1_MSG_EraseRasTable] = SMU_MSG_EraseRasTable,
+};
+
+static enum smu_message_type
+	__get_ras_smu_msg(struct ras_core_context *ras_core, u32 msg_id)
+{
+	if (msg_id >= RAS_MP1_MSG_MAX)
+		return 0;
+
+	return ras_smu_msg_maps[msg_id];
+}
+
+static int amdgpu_ras_send_mp1_msg(struct ras_core_context *ras_core,
+			u32 msg_id, uint32_t param, uint32_t *read_arg)
+{
+	struct amdgpu_device *adev = (struct amdgpu_device *)ras_core->dev;
+	enum smu_message_type smu_msg;
+	int ret = 0;
+
+	smu_msg = __get_ras_smu_msg(ras_core, msg_id);
+	if (!smu_msg)
+		return -EOPNOTSUPP;
+
+	if (down_read_trylock(&adev->reset_domain->sem)) {
+		ret = amdgpu_smu_ras_send_msg(adev, smu_msg, param, read_arg);
+		up_read(&adev->reset_domain->sem);
+	} else {
+		ret = -RAS_CORE_GPU_IN_MODE1_RESET;
+	}
+
+	return ret;
+}
+
+const struct ras_mp1_sys_func amdgpu_ras_mp1_sys_func = {
+	.mp1_send_eeprom_msg = amdgpu_ras_send_mp1_msg,
+};
diff --git a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mp1.h b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mp1.h
new file mode 100644
index 0000000000000..fa7231b03ccdf
--- /dev/null
+++ b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mp1.h
@@ -0,0 +1,30 @@
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
+#ifndef __AMDGPU_RAS_MP1_H__
+#define __AMDGPU_RAS_MP1_H__
+#include "ras.h"
+
+extern const struct ras_mp1_sys_func amdgpu_ras_mp1_sys_func;
+
+#endif
-- 
2.55.0

