Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AC09CAC5A7
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Sep 2025 02:40:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 355AA10E387;
	Mon, 22 Sep 2025 02:40:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="AWAk49eO";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012004.outbound.protection.outlook.com [40.107.209.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 144BA10E387
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Sep 2025 02:40:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vq9eOhHvSrmXecD85X50yY4ZZRh1PqP/tV9JWxDk7Wvxu25sEMpnwo533OwDe6eBWt2wbP3F0NWd+8viiJT0a0Z773AiSJAT6FHOKPitMifuXRdQT7QGk934TyjT/6duGqMDxq+C3P46k47+bAY/v24If/BPwySesYDDAn3lEAjb+dBN3neYt+JoupotozcCKANzHO0QjjCLdWtQmyqua57q8OROKwoxnH7KCeYKw7s16qb17DQNtJILEPX0tb/MeUxfl8XHJFWrU3+YISzR2CGnE4DVaVuuhohdEOg+9I2ioG+7VmqdQNlbKGngJ6IOQQmZUf1JbY7pAZOFJvaoQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pBYx5bF6uz46ZNlt11YiixeOi91TR21eLzkVs0QwLsg=;
 b=PkgwKIue+KSQuzRbU46GPGYOJxr09Bb65pMKKjkJi0kB9X8PEs16YoAlOTUSPvYSCLpm42+Ct5fsixsS+32/6UlUtla3BZeDisR7d4WM/YhIxzPSPJo+D8QfT/4MW/s9XSCfH6IOOlFcxAIgeGKk1k8QKCXQMZd+ygkAAqUEWIdkhiHecZhYo3jrb5+bwhw/Hr00Yfl1gSYroXgpL/S+YNbwfkoDmDpfPq6O/KKKh7f9FaEoy5m470hFQpkIeMVL92/BJd1SoFZz+2FwTDFPYX8NP/T+Oig2e5ORi7ZjwV0+Vm/yIK4ZC2UdhFfw1cYTd48dLEP4eG6zfKOYf7HG/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pBYx5bF6uz46ZNlt11YiixeOi91TR21eLzkVs0QwLsg=;
 b=AWAk49eOp3YR4wENrtgwjSgyD6S0udQ0IDudQ5lnhMFbXZJPFnETIru1gTO/qIouWgT2E0lOFCunV2dFufEag9KQX2Z9KINj9bJsJ06wW3PmG5jspCm/GC7mtLdxmFOQTsMtWdeXpIsWyCr/OBH3ejCa/gCOeIN9YYOG7t+MSUI=
Received: from MW3PR05CA0030.namprd05.prod.outlook.com (2603:10b6:303:2b::35)
 by SA1PR12MB9489.namprd12.prod.outlook.com (2603:10b6:806:45c::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.20; Mon, 22 Sep
 2025 02:40:09 +0000
Received: from CO1PEPF000044FD.namprd21.prod.outlook.com
 (2603:10b6:303:2b:cafe::8d) by MW3PR05CA0030.outlook.office365.com
 (2603:10b6:303:2b::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.19 via Frontend Transport; Mon,
 22 Sep 2025 02:40:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF000044FD.mail.protection.outlook.com (10.167.241.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9182.0 via Frontend Transport; Mon, 22 Sep 2025 02:40:08 +0000
Received: from amd-02.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Sun, 21 Sep
 2025 19:40:00 -0700
From: YiPeng Chai <YiPeng.Chai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <yipechai@amd.com>, <Hawking.Zhang@amd.com>, <Tao.Zhou1@amd.com>,
 <Stanley.Yang@amd.com>, YiPeng Chai <YiPeng.Chai@amd.com>, Tao Zhou
 <tao.zhou1@amd.com>
Subject: [PATCH V5 19/20] drm/amd/ras: Add rascore unified interface function
Date: Mon, 22 Sep 2025 10:38:43 +0800
Message-ID: <20250922023844.3108065-19-YiPeng.Chai@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250922023844.3108065-1-YiPeng.Chai@amd.com>
References: <20250922023844.3108065-1-YiPeng.Chai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044FD:EE_|SA1PR12MB9489:EE_
X-MS-Office365-Filtering-Correlation-Id: 282ae15a-60a4-40cc-13b0-08ddf9815891
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Iw8opf4tvZ8oyIcvV8Lxeb8IezBrxbIZG+1fJf8dvH1aklhLx3oyi2kgfymq?=
 =?us-ascii?Q?4nqo5QkuoIsh/3iwuQ+arZryUThIeHiqDW8/+/O+xWerG4iJU8kWCnrSg+FK?=
 =?us-ascii?Q?TwVMvibhqTfV8lGl2PbI1EDsCy0fbue5ziXNHjx/ZfRjwK80+17BtLPE7FAA?=
 =?us-ascii?Q?S2bP7bbJqJSUBmgAU8T0+eds/Ws2gilqRlKb/b2TTFTaRd2Ow718OJUpP9ou?=
 =?us-ascii?Q?WxVUcJqlS4sqoBtniUoFVAJ07njWXBD0b6JcEPALZsl/QtPjc1OzibL4Y3Jj?=
 =?us-ascii?Q?M3NRrqI1R/1PLAluARvVN0i1mrNmL4qwjZ5O0cLZy8EjlG/ZBj9fk1Yl2Npj?=
 =?us-ascii?Q?9Mx3XjN2XhxqgLYZ1H2fYFrWphRckL8UeFRNJaKxPrecZvvZSbVxHpctv2NP?=
 =?us-ascii?Q?MQTAb+3/WP0ga8b2WJ0w7EkATnfkYJonil586PaSJ5IxtYRwBOzWge5415uR?=
 =?us-ascii?Q?mIWmTCrEf6EvhuoASnK/qZ4RYfZDPNMusSgj5DawL+202S+qtRPi87wkO2bm?=
 =?us-ascii?Q?v5MUjM95JYQI+D90LNCUuJZzMIGi5xxQHqnNvt8gJE4mdXgbmKeWgFj6NccU?=
 =?us-ascii?Q?GSDPIdv3srDKPUlBxpLU2Cty5wy1l4DX9nmBwHT2OnWAaPiUXdF8OZTT9K9q?=
 =?us-ascii?Q?DjOTXyKMwtLVMuhcKMuwZShEm4GwssSwU7/w/xhzJRmCwNuyJD+SqlfjjNBu?=
 =?us-ascii?Q?dbAPKikTNrPODehkOtfZgWc03KgNcZJX76hwr6zX+l6nJOs/yViXnTGyl4+n?=
 =?us-ascii?Q?NA9dvinH9EeBTFQ763pRlRRAoSYXEIZ66dNO4krAqmwTzvhZJsZnhSp7uyLI?=
 =?us-ascii?Q?8V92YtyT9uVua7IHcTcdfmMr5l6N8QyUA4Fvxaou02SuI/hhTI5af4c6eEug?=
 =?us-ascii?Q?2JSm5QxXB2tVyF5wnJWiumgTCa/xJ1TtfOzi3/WkiXTtr6Qbaih8VKPSLIoi?=
 =?us-ascii?Q?c+qB2XoSQz1XbRME8/VaqZfzOtYoZHiKbYilqCbWZ/IfbMMpfavjADgtSjLe?=
 =?us-ascii?Q?eL/VZid5Lsh/AO8aY2F4keK7FfI1l0RqqCFUhY89DWsBWdxJ3TnedILt8ONZ?=
 =?us-ascii?Q?6s+j2IMMNZe4Xy0qm0M5X/2PIc57cBqXlfjxKYkA9Xfov+cb+6o0QEb53vf7?=
 =?us-ascii?Q?eP2a0jwKQ+dH6pk7ZU9px1Sh2xokO0Rz94IpTo/CrK5xu/q4drnuH9B1ie9Y?=
 =?us-ascii?Q?+eSUncZuU8WTMeTjUaIMCadp+9tly07nBPLWo26idmnSKeIftgWVNXxNLI7s?=
 =?us-ascii?Q?IJ9Wc/ZsPmP6JCZ0omsFJXkBaKAmhK1B9jpb9R92EM2UfLa+zXD9K+0FlRvL?=
 =?us-ascii?Q?XJEoKVHCWM4STu4+o3nYWXr+zBaWH/5+JNQxzSm56+VjNChwOqw1go5g17qx?=
 =?us-ascii?Q?O0DQ6UVjTNf4h2IIAeghdPHv7TUC+BHYulBLe0c/ULqJEYSHigetUPTGMpNR?=
 =?us-ascii?Q?x7WuYB9FuqrPvC8cMZY33x3JbeoGveVkdspQnO6MJnqD+Cw5jjNDt7kR+Dou?=
 =?us-ascii?Q?EYjSKBcyLLHoe6/2mkaHEryEw2bp6uBRq5w4?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2025 02:40:08.7138 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 282ae15a-60a4-40cc-13b0-08ddf9815891
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044FD.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB9489
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

1. Complete the initialization call of all
   sub-functions.
2. Export common interfaces.

V2:
  Remove the use of typedef to define function pointer.

Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
Reviewed-by: Tao Zhou <tao.zhou1@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/ras/rascore/ras.h      | 368 +++++++++++++
 drivers/gpu/drm/amd/ras/rascore/ras_core.c | 603 +++++++++++++++++++++
 2 files changed, 971 insertions(+)
 create mode 100644 drivers/gpu/drm/amd/ras/rascore/ras.h
 create mode 100644 drivers/gpu/drm/amd/ras/rascore/ras_core.c

diff --git a/drivers/gpu/drm/amd/ras/rascore/ras.h b/drivers/gpu/drm/amd/ras/rascore/ras.h
new file mode 100644
index 000000000000..fa224b36e3f2
--- /dev/null
+++ b/drivers/gpu/drm/amd/ras/rascore/ras.h
@@ -0,0 +1,368 @@
+/* SPDX-License-Identifier: MIT */
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
+
+#ifndef __RAS_H__
+#define __RAS_H__
+#include "ras_sys.h"
+#include "ras_umc.h"
+#include "ras_aca.h"
+#include "ras_eeprom.h"
+#include "ras_core_status.h"
+#include "ras_process.h"
+#include "ras_gfx.h"
+#include "ras_cmd.h"
+#include "ras_nbio.h"
+#include "ras_mp1.h"
+#include "ras_psp.h"
+#include "ras_log_ring.h"
+
+#define RAS_HW_ERR		"[Hardware Error]: "
+
+#define RAS_GPU_PAGE_SHIFT  12
+#define RAS_ADDR_TO_PFN(addr) ((addr) >> RAS_GPU_PAGE_SHIFT)
+#define RAS_PFN_TO_ADDR(pfn) ((pfn) << RAS_GPU_PAGE_SHIFT)
+
+#define RAS_CORE_RESET_GPU 0x10000
+
+#define GPU_RESET_CAUSE_POISON  (RAS_CORE_RESET_GPU | 0x0001)
+#define GPU_RESET_CAUSE_FATAL   (RAS_CORE_RESET_GPU | 0x0002)
+#define GPU_RESET_CAUSE_RMA     (RAS_CORE_RESET_GPU | 0x0004)
+
+enum ras_block_id {
+	RAS_BLOCK_ID__UMC = 0,
+	RAS_BLOCK_ID__SDMA,
+	RAS_BLOCK_ID__GFX,
+	RAS_BLOCK_ID__MMHUB,
+	RAS_BLOCK_ID__ATHUB,
+	RAS_BLOCK_ID__PCIE_BIF,
+	RAS_BLOCK_ID__HDP,
+	RAS_BLOCK_ID__XGMI_WAFL,
+	RAS_BLOCK_ID__DF,
+	RAS_BLOCK_ID__SMN,
+	RAS_BLOCK_ID__SEM,
+	RAS_BLOCK_ID__MP0,
+	RAS_BLOCK_ID__MP1,
+	RAS_BLOCK_ID__FUSE,
+	RAS_BLOCK_ID__MCA,
+	RAS_BLOCK_ID__VCN,
+	RAS_BLOCK_ID__JPEG,
+	RAS_BLOCK_ID__IH,
+	RAS_BLOCK_ID__MPIO,
+
+	RAS_BLOCK_ID__LAST
+};
+
+enum ras_ecc_err_type {
+	RAS_ECC_ERR__NONE                = 0,
+	RAS_ECC_ERR__PARITY              = 1,
+	RAS_ECC_ERR__SINGLE_CORRECTABLE  = 2,
+	RAS_ECC_ERR__MULTI_UNCORRECTABLE = 4,
+	RAS_ECC_ERR__POISON              = 8,
+};
+
+enum ras_err_type {
+	RAS_ERR_TYPE__UE = 0,
+	RAS_ERR_TYPE__CE,
+	RAS_ERR_TYPE__DE,
+	RAS_ERR_TYPE__LAST
+};
+
+enum ras_seqno_type {
+	RAS_SEQNO_TYPE_INVALID = 0,
+	RAS_SEQNO_TYPE_UE,
+	RAS_SEQNO_TYPE_CE,
+	RAS_SEQNO_TYPE_DE,
+	RAS_SEQNO_TYPE_POISON_CONSUMPTION,
+	RAS_SEQNO_TYPE_COUNT_MAX,
+};
+
+enum ras_seqno_fifo {
+	SEQNO_FIFO_INVALID = 0,
+	SEQNO_FIFO_POISON_CREATION,
+	SEQNO_FIFO_POISON_CONSUMPTION,
+	SEQNO_FIFO_COUNT_MAX
+};
+
+enum ras_notify_event {
+	RAS_EVENT_ID__NONE,
+	RAS_EVENT_ID__BAD_PAGE_DETECTED,
+	RAS_EVENT_ID__POISON_CONSUMPTION,
+	RAS_EVENT_ID__RESERVE_BAD_PAGE,
+	RAS_EVENT_ID__DEVICE_RMA,
+	RAS_EVENT_ID__UPDATE_BAD_PAGE_NUM,
+	RAS_EVENT_ID__UPDATE_BAD_CHANNEL_BITMAP,
+	RAS_EVENT_ID__FATAL_ERROR_DETECTED,
+	RAS_EVENT_ID__RESET_GPU,
+	RAS_EVENT_ID__RESET_VF,
+};
+
+enum ras_gpu_status {
+	RAS_GPU_STATUS__NOT_READY = 0,
+	RAS_GPU_STATUS__READY = 0x1,
+	RAS_GPU_STATUS__IN_RESET = 0x2,
+	RAS_GPU_STATUS__IS_RMA = 0x4,
+	RAS_GPU_STATUS__IS_VF = 0x8,
+};
+
+struct ras_core_context;
+struct ras_bank_ecc;
+struct ras_umc;
+struct ras_aca;
+struct ras_process;
+struct ras_nbio;
+struct ras_log_ring;
+struct ras_psp;
+
+struct ras_mp1_sys_func {
+	int (*mp1_get_valid_bank_count)(struct ras_core_context *ras_core,
+			u32 msg, u32 *count);
+	int (*mp1_dump_valid_bank)(struct ras_core_context *ras_core,
+			u32 msg, u32 idx, u32 reg_idx, u64 *val);
+};
+
+struct ras_eeprom_sys_func {
+	int (*eeprom_i2c_xfer)(struct ras_core_context *ras_core,
+			u32 eeprom_addr, u8 *eeprom_buf, u32 buf_size, bool read);
+	int (*update_eeprom_i2c_config)(struct ras_core_context *ras_core);
+};
+
+struct ras_nbio_sys_func {
+	int (*set_ras_controller_irq_state)(struct ras_core_context *ras_core,
+			bool state);
+	int (*set_ras_err_event_athub_irq_state)(struct ras_core_context *ras_core,
+			bool state);
+};
+
+struct ras_time {
+	int tm_sec;
+	int tm_min;
+	int tm_hour;
+	int tm_mday;
+	int tm_mon;
+	long tm_year;
+};
+
+struct device_system_info {
+	uint32_t device_id;
+	uint32_t vendor_id;
+	uint32_t socket_id;
+};
+
+enum gpu_mem_type {
+	GPU_MEM_TYPE_DEFAULT,
+	GPU_MEM_TYPE_RAS_PSP_RING,
+	GPU_MEM_TYPE_RAS_PSP_CMD,
+	GPU_MEM_TYPE_RAS_PSP_FENCE,
+	GPU_MEM_TYPE_RAS_TA_FW,
+	GPU_MEM_TYPE_RAS_TA_CMD,
+};
+
+struct ras_psp_sys_func {
+	int (*get_ras_psp_system_status)(struct ras_core_context *ras_core,
+		struct ras_psp_sys_status *status);
+	int (*get_ras_ta_init_param)(struct ras_core_context *ras_core,
+		struct ras_ta_init_param *ras_ta_param);
+};
+
+struct ras_sys_func {
+	int (*gpu_reset_lock)(struct ras_core_context *ras_core,
+			bool down, bool try);
+	int (*check_gpu_status)(struct ras_core_context *ras_core,
+			uint32_t *status);
+	int (*gen_seqno)(struct ras_core_context *ras_core,
+			enum ras_seqno_type seqno_type, uint64_t *seqno);
+	int (*async_handle_ras_event)(struct ras_core_context *ras_core, void *data);
+	int (*ras_notifier)(struct ras_core_context *ras_core,
+		    enum ras_notify_event event_id, void *data);
+	u64 (*get_utc_second_timestamp)(struct ras_core_context *ras_core);
+	int (*get_device_system_info)(struct ras_core_context *ras_core,
+			struct device_system_info *dev_info);
+	bool (*detect_ras_interrupt)(struct ras_core_context *ras_core);
+	int (*get_gpu_mem)(struct ras_core_context *ras_core,
+		enum gpu_mem_type mem_type, struct gpu_mem_block *gpu_mem);
+	int (*put_gpu_mem)(struct ras_core_context *ras_core,
+		enum gpu_mem_type mem_type, struct gpu_mem_block *gpu_mem);
+};
+
+struct ras_ecc_count {
+	uint64_t new_ce_count;
+	uint64_t total_ce_count;
+	uint64_t new_ue_count;
+	uint64_t total_ue_count;
+	uint64_t new_de_count;
+	uint64_t total_de_count;
+};
+
+struct ras_bank_ecc {
+	uint32_t nps;
+	uint64_t seq_no;
+	uint64_t status;
+	uint64_t ipid;
+	uint64_t addr;
+};
+
+struct ras_bank_ecc_node {
+	struct list_head node;
+	struct ras_bank_ecc ecc;
+};
+
+struct ras_aca_config {
+	u32 socket_num_per_hive;
+	u32 aid_num_per_socket;
+	u32 xcd_num_per_aid;
+};
+
+struct ras_mp1_config {
+	const struct ras_mp1_sys_func *mp1_sys_fn;
+};
+
+struct ras_nbio_config {
+	const struct ras_nbio_sys_func *nbio_sys_fn;
+};
+
+struct ras_psp_config {
+	const struct ras_psp_sys_func *psp_sys_fn;
+};
+
+struct ras_umc_config {
+	uint32_t umc_vram_type;
+};
+
+struct ras_eeprom_config {
+	const struct ras_eeprom_sys_func *eeprom_sys_fn;
+	int eeprom_record_threshold_config;
+	uint32_t eeprom_record_threshold_count;
+	void *eeprom_i2c_adapter;
+	u32 eeprom_i2c_addr;
+	u32 eeprom_i2c_port;
+	u16 max_i2c_read_len;
+	u16 max_i2c_write_len;
+};
+
+struct ras_core_config {
+	u32 aca_ip_version;
+	u32 umc_ip_version;
+	u32 mp1_ip_version;
+	u32 gfx_ip_version;
+	u32 nbio_ip_version;
+	u32 psp_ip_version;
+
+	bool poison_supported;
+	bool ras_eeprom_supported;
+	const struct ras_sys_func *sys_fn;
+
+	struct ras_aca_config aca_cfg;
+	struct ras_mp1_config mp1_cfg;
+	struct ras_nbio_config nbio_cfg;
+	struct ras_psp_config psp_cfg;
+	struct ras_eeprom_config eeprom_cfg;
+	struct ras_umc_config umc_cfg;
+};
+
+struct ras_core_context {
+	void *dev;
+	struct ras_core_config *config;
+	u32 socket_num_per_hive;
+	u32 aid_num_per_socket;
+	u32 xcd_num_per_aid;
+	int max_ue_banks_per_query;
+	int max_ce_banks_per_query;
+	struct ras_aca ras_aca;
+
+	bool ras_eeprom_supported;
+	struct ras_eeprom_control ras_eeprom;
+
+	struct ras_psp ras_psp;
+	struct ras_umc ras_umc;
+	struct ras_nbio ras_nbio;
+	struct ras_gfx ras_gfx;
+	struct ras_mp1 ras_mp1;
+	struct ras_process ras_proc;
+	struct ras_cmd_mgr ras_cmd;
+	struct ras_log_ring ras_log_ring;
+
+	const struct ras_sys_func *sys_fn;
+
+	/* is poison mode supported */
+	bool poison_supported;
+
+	bool is_rma;
+	bool is_initialized;
+
+	struct kfifo de_seqno_fifo;
+	struct kfifo consumption_seqno_fifo;
+	spinlock_t seqno_lock;
+
+	bool ras_core_enabled;
+};
+
+struct ras_core_context *ras_core_create(struct ras_core_config *init_config);
+void ras_core_destroy(struct ras_core_context *ras_core);
+int ras_core_sw_init(struct ras_core_context *ras_core);
+int ras_core_sw_fini(struct ras_core_context *ras_core);
+int ras_core_hw_init(struct ras_core_context *ras_core);
+int ras_core_hw_fini(struct ras_core_context *ras_core);
+bool ras_core_is_ready(struct ras_core_context *ras_core);
+uint64_t ras_core_gen_seqno(struct ras_core_context *ras_core,
+			enum ras_seqno_type seqno_type);
+uint64_t ras_core_get_seqno(struct ras_core_context *ras_core,
+			enum ras_seqno_type seqno_type, bool pop);
+
+int ras_core_put_seqno(struct ras_core_context *ras_core,
+		enum ras_seqno_type seqno_type, uint64_t seqno);
+
+int ras_core_update_ecc_info(struct ras_core_context *ras_core);
+int ras_core_query_block_ecc_data(struct ras_core_context *ras_core,
+		enum ras_block_id block, struct ras_ecc_count *ecc_count);
+
+bool ras_core_gpu_in_reset(struct ras_core_context *ras_core);
+bool ras_core_gpu_is_rma(struct ras_core_context *ras_core);
+bool ras_core_gpu_is_vf(struct ras_core_context *ras_core);
+bool ras_core_handle_nbio_irq(struct ras_core_context *ras_core, void *data);
+int ras_core_handle_fatal_error(struct ras_core_context *ras_core);
+
+uint32_t ras_core_get_curr_nps_mode(struct ras_core_context *ras_core);
+const char *ras_core_get_ras_block_name(enum ras_block_id block_id);
+int ras_core_convert_timestamp_to_time(struct ras_core_context *ras_core,
+			uint64_t timestamp, struct ras_time *tm);
+
+int ras_core_set_status(struct ras_core_context *ras_core, bool enable);
+bool ras_core_is_enabled(struct ras_core_context *ras_core);
+uint64_t ras_core_get_utc_second_timestamp(struct ras_core_context *ras_core);
+int ras_core_translate_soc_pa_and_bank(struct ras_core_context *ras_core,
+	uint64_t *soc_pa, struct umc_bank_addr *bank_addr, bool bank_to_pa);
+bool ras_core_ras_interrupt_detected(struct ras_core_context *ras_core);
+int ras_core_get_gpu_mem(struct ras_core_context *ras_core,
+		enum gpu_mem_type mem_type, struct gpu_mem_block *gpu_mem);
+int ras_core_put_gpu_mem(struct ras_core_context *ras_core,
+		enum gpu_mem_type mem_type, struct gpu_mem_block *gpu_mem);
+bool ras_core_check_safety_watermark(struct ras_core_context *ras_core);
+int ras_core_down_trylock_gpu_reset_lock(struct ras_core_context *ras_core);
+void ras_core_down_gpu_reset_lock(struct ras_core_context *ras_core);
+void ras_core_up_gpu_reset_lock(struct ras_core_context *ras_core);
+int ras_core_event_notify(struct ras_core_context *ras_core,
+		enum ras_notify_event event_id, void *data);
+int ras_core_get_device_system_info(struct ras_core_context *ras_core,
+		struct device_system_info *dev_info);
+#endif
diff --git a/drivers/gpu/drm/amd/ras/rascore/ras_core.c b/drivers/gpu/drm/amd/ras/rascore/ras_core.c
new file mode 100644
index 000000000000..41fc9f0d84e4
--- /dev/null
+++ b/drivers/gpu/drm/amd/ras/rascore/ras_core.c
@@ -0,0 +1,603 @@
+// SPDX-License-Identifier: MIT
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
+#include "ras.h"
+#include "ras_core_status.h"
+
+#define RAS_SEQNO_FIFO_SIZE (128 * sizeof(uint64_t))
+
+#define IS_LEAP_YEAR(x) ((x % 4 == 0 && x % 100 != 0) || x % 400 == 0)
+
+static const char * const ras_block_name[] = {
+	"umc",
+	"sdma",
+	"gfx",
+	"mmhub",
+	"athub",
+	"pcie_bif",
+	"hdp",
+	"xgmi_wafl",
+	"df",
+	"smn",
+	"sem",
+	"mp0",
+	"mp1",
+	"fuse",
+	"mca",
+	"vcn",
+	"jpeg",
+	"ih",
+	"mpio",
+};
+
+const char *ras_core_get_ras_block_name(enum ras_block_id block_id)
+{
+	if (block_id >= ARRAY_SIZE(ras_block_name))
+		return "";
+
+	return ras_block_name[block_id];
+}
+
+int ras_core_convert_timestamp_to_time(struct ras_core_context *ras_core,
+			uint64_t timestamp, struct ras_time *tm)
+{
+	int days_in_month[] = {31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31};
+	uint64_t year = 0, month = 0, day = 0, hour = 0, minute = 0, second = 0;
+	int seconds_per_day = 24 * 60 * 60;
+	int seconds_per_hour = 60 * 60;
+	int seconds_per_minute = 60;
+	int days, remaining_seconds;
+
+	days = timestamp / seconds_per_day;
+	remaining_seconds = timestamp % seconds_per_day;
+
+	/* utc_timestamp follows the Unix epoch */
+	year = 1970;
+	while (days >= 365) {
+		if (IS_LEAP_YEAR(year)) {
+			if (days < 366)
+				break;
+			days -= 366;
+		} else {
+			days -= 365;
+		}
+		year++;
+	}
+
+	days_in_month[1] += IS_LEAP_YEAR(year);
+
+	month = 0;
+	while (days >= days_in_month[month]) {
+		days -= days_in_month[month];
+		month++;
+	}
+	month++;
+	day = days + 1;
+
+	if (remaining_seconds) {
+		hour = remaining_seconds / seconds_per_hour;
+		minute = (remaining_seconds % seconds_per_hour) / seconds_per_minute;
+		second = remaining_seconds % seconds_per_minute;
+	}
+
+	tm->tm_year = year;
+	tm->tm_mon = month;
+	tm->tm_mday = day;
+	tm->tm_hour = hour;
+	tm->tm_min = minute;
+	tm->tm_sec = second;
+
+	return 0;
+}
+
+bool ras_core_gpu_in_reset(struct ras_core_context *ras_core)
+{
+	uint32_t status = 0;
+
+	if (ras_core->sys_fn &&
+		ras_core->sys_fn->check_gpu_status)
+		ras_core->sys_fn->check_gpu_status(ras_core, &status);
+
+	return (status & RAS_GPU_STATUS__IN_RESET) ? true : false;
+}
+
+bool ras_core_gpu_is_vf(struct ras_core_context *ras_core)
+{
+	uint32_t status = 0;
+
+	if (ras_core->sys_fn &&
+		ras_core->sys_fn->check_gpu_status)
+		ras_core->sys_fn->check_gpu_status(ras_core, &status);
+
+	return (status & RAS_GPU_STATUS__IS_VF) ? true : false;
+}
+
+bool ras_core_gpu_is_rma(struct ras_core_context *ras_core)
+{
+	if (!ras_core)
+		return false;
+
+	return ras_core->is_rma;
+}
+
+static int ras_core_seqno_fifo_write(struct ras_core_context *ras_core,
+		enum ras_seqno_fifo fifo_type, uint64_t seqno)
+{
+	int ret = 0;
+	struct kfifo *seqno_fifo = NULL;
+
+	if (fifo_type == SEQNO_FIFO_POISON_CREATION)
+		seqno_fifo = &ras_core->de_seqno_fifo;
+	else if (fifo_type == SEQNO_FIFO_POISON_CONSUMPTION)
+		seqno_fifo = &ras_core->consumption_seqno_fifo;
+
+	if (seqno_fifo)
+		ret = kfifo_in_spinlocked(seqno_fifo,
+			&seqno, sizeof(seqno), &ras_core->seqno_lock);
+
+	return ret ? 0 : -EINVAL;
+}
+
+static int ras_core_seqno_fifo_read(struct ras_core_context *ras_core,
+		enum ras_seqno_fifo fifo_type, uint64_t *seqno, bool pop)
+{
+	int ret = 0;
+	struct kfifo *seqno_fifo = NULL;
+
+	if (fifo_type == SEQNO_FIFO_POISON_CREATION)
+		seqno_fifo = &ras_core->de_seqno_fifo;
+	else if (fifo_type == SEQNO_FIFO_POISON_CONSUMPTION)
+		seqno_fifo = &ras_core->consumption_seqno_fifo;
+
+	if (seqno_fifo) {
+		if (pop)
+			ret = kfifo_out_spinlocked(seqno_fifo,
+				seqno, sizeof(*seqno), &ras_core->seqno_lock);
+		else
+			ret = kfifo_out_peek(seqno_fifo, seqno, sizeof(*seqno));
+	}
+
+	return ret ? 0 : -EINVAL;
+}
+
+uint64_t ras_core_gen_seqno(struct ras_core_context *ras_core,
+			enum ras_seqno_type type)
+{
+	uint64_t seqno = 0;
+
+	if (ras_core->sys_fn &&
+		ras_core->sys_fn->gen_seqno)
+		ras_core->sys_fn->gen_seqno(ras_core, type, &seqno);
+
+	return seqno;
+}
+
+int ras_core_put_seqno(struct ras_core_context *ras_core,
+		enum ras_seqno_type seqno_type, uint64_t seqno)
+{
+	int ret = 0;
+
+	if (seqno_type >= RAS_SEQNO_TYPE_COUNT_MAX)
+		return -EINVAL;
+
+	if (seqno_type == RAS_SEQNO_TYPE_DE)
+		ret = ras_core_seqno_fifo_write(ras_core,
+				SEQNO_FIFO_POISON_CREATION, seqno);
+	else if (seqno_type == RAS_SEQNO_TYPE_POISON_CONSUMPTION)
+		ret = ras_core_seqno_fifo_write(ras_core,
+				SEQNO_FIFO_POISON_CONSUMPTION, seqno);
+	else
+		ret = -EINVAL;
+
+	return ret;
+}
+
+uint64_t ras_core_get_seqno(struct ras_core_context *ras_core,
+			enum ras_seqno_type seqno_type, bool pop)
+{
+	uint64_t seq_no;
+	int ret = -ENODATA;
+
+	if (seqno_type >= RAS_SEQNO_TYPE_COUNT_MAX)
+		return 0;
+
+	if (seqno_type == RAS_SEQNO_TYPE_DE)
+		ret = ras_core_seqno_fifo_read(ras_core,
+				SEQNO_FIFO_POISON_CREATION, &seq_no, pop);
+	else if (seqno_type == RAS_SEQNO_TYPE_POISON_CONSUMPTION)
+		ret = ras_core_seqno_fifo_read(ras_core,
+				SEQNO_FIFO_POISON_CONSUMPTION, &seq_no, pop);
+
+	if (ret)
+		seq_no = ras_core_gen_seqno(ras_core, seqno_type);
+
+	return seq_no;
+}
+
+static int ras_core_eeprom_recovery(struct ras_core_context *ras_core)
+{
+	int count;
+	int ret;
+
+	count = ras_eeprom_get_record_count(ras_core);
+	if (!count)
+		return 0;
+
+	/* Avoid bad page to be loaded again after gpu reset */
+	if (ras_umc_get_saved_eeprom_count(ras_core) >= count)
+		return 0;
+
+	ret = ras_umc_load_bad_pages(ras_core);
+	if (ret) {
+		RAS_DEV_ERR(ras_core->dev, "ras_umc_load_bad_pages failed: %d\n", ret);
+		return ret;
+	}
+
+	ras_eeprom_sync_info(ras_core);
+
+	return ret;
+}
+
+struct ras_core_context *ras_core_create(struct ras_core_config *init_config)
+{
+	struct ras_core_context *ras_core;
+	struct ras_core_config *config;
+
+	ras_core = kzalloc(sizeof(*ras_core), GFP_KERNEL);
+	if (!ras_core)
+		return NULL;
+
+	config = kzalloc(sizeof(*config), GFP_KERNEL);
+	if (!config) {
+		kfree(ras_core);
+		return NULL;
+	}
+
+	memcpy(config, init_config, sizeof(*config));
+	ras_core->config = config;
+
+	return ras_core;
+}
+
+void ras_core_destroy(struct ras_core_context *ras_core)
+{
+	if (ras_core)
+		kfree(ras_core->config);
+
+	kfree(ras_core);
+}
+
+int ras_core_sw_init(struct ras_core_context *ras_core)
+{
+	int ret;
+
+	if (!ras_core->config) {
+		RAS_DEV_ERR(ras_core->dev, "No ras core config!\n");
+		return -EINVAL;
+	}
+
+	ras_core->sys_fn = ras_core->config->sys_fn;
+	if (!ras_core->sys_fn)
+		return -EINVAL;
+
+	ret = kfifo_alloc(&ras_core->de_seqno_fifo,
+		 RAS_SEQNO_FIFO_SIZE, GFP_KERNEL);
+	if (ret)
+		return ret;
+
+	ret = kfifo_alloc(&ras_core->consumption_seqno_fifo,
+		 RAS_SEQNO_FIFO_SIZE, GFP_KERNEL);
+	if (ret)
+		return ret;
+
+	spin_lock_init(&ras_core->seqno_lock);
+
+	ret = ras_aca_sw_init(ras_core);
+	if (ret)
+		return ret;
+
+	ret = ras_umc_sw_init(ras_core);
+	if (ret)
+		return ret;
+
+	ret = ras_cmd_init(ras_core);
+	if (ret)
+		return ret;
+
+	ret = ras_log_ring_sw_init(ras_core);
+	if (ret)
+		return ret;
+
+	ret = ras_psp_sw_init(ras_core);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+int ras_core_sw_fini(struct ras_core_context *ras_core)
+{
+	kfifo_free(&ras_core->de_seqno_fifo);
+	kfifo_free(&ras_core->consumption_seqno_fifo);
+
+	ras_psp_sw_fini(ras_core);
+	ras_log_ring_sw_fini(ras_core);
+	ras_cmd_fini(ras_core);
+	ras_umc_sw_fini(ras_core);
+	ras_aca_sw_fini(ras_core);
+
+	return 0;
+}
+
+int ras_core_hw_init(struct ras_core_context *ras_core)
+{
+	int ret;
+
+	ras_core->ras_eeprom_supported =
+			ras_core->config->ras_eeprom_supported;
+
+	ras_core->poison_supported = ras_core->config->poison_supported;
+
+	ret = ras_psp_hw_init(ras_core);
+	if (ret)
+		return ret;
+
+	ret = ras_aca_hw_init(ras_core);
+	if (ret)
+		goto init_err1;
+
+	ret = ras_mp1_hw_init(ras_core);
+	if (ret)
+		goto init_err2;
+
+	ret = ras_nbio_hw_init(ras_core);
+	if (ret)
+		goto init_err3;
+
+	ret = ras_umc_hw_init(ras_core);
+	if (ret)
+		goto init_err4;
+
+	ret = ras_gfx_hw_init(ras_core);
+	if (ret)
+		goto init_err5;
+
+	ret = ras_eeprom_hw_init(ras_core);
+	if (ret)
+		goto init_err6;
+
+	ret = ras_core_eeprom_recovery(ras_core);
+	if (ret) {
+		RAS_DEV_ERR(ras_core->dev,
+			"Failed to recovery ras core, ret:%d\n", ret);
+		goto init_err6;
+	}
+
+	ret = ras_eeprom_check_storage_status(ras_core);
+	if (ret)
+		goto init_err6;
+
+	ret = ras_process_init(ras_core);
+	if (ret)
+		goto init_err7;
+
+	ras_core->is_initialized = true;
+
+	return 0;
+
+init_err7:
+	ras_eeprom_hw_fini(ras_core);
+init_err6:
+	ras_gfx_hw_fini(ras_core);
+init_err5:
+	ras_umc_hw_fini(ras_core);
+init_err4:
+	ras_nbio_hw_fini(ras_core);
+init_err3:
+	ras_mp1_hw_fini(ras_core);
+init_err2:
+	ras_aca_hw_fini(ras_core);
+init_err1:
+	ras_psp_hw_fini(ras_core);
+	return ret;
+}
+
+int ras_core_hw_fini(struct ras_core_context *ras_core)
+{
+	ras_core->is_initialized = false;
+
+	ras_process_fini(ras_core);
+	ras_eeprom_hw_fini(ras_core);
+	ras_gfx_hw_fini(ras_core);
+	ras_nbio_hw_fini(ras_core);
+	ras_umc_hw_fini(ras_core);
+	ras_mp1_hw_fini(ras_core);
+	ras_aca_hw_fini(ras_core);
+	ras_psp_hw_fini(ras_core);
+
+	return 0;
+}
+
+bool ras_core_handle_nbio_irq(struct ras_core_context *ras_core, void *data)
+{
+	return ras_nbio_handle_irq_error(ras_core, data);
+}
+
+int ras_core_handle_fatal_error(struct ras_core_context *ras_core)
+{
+	int ret = 0;
+
+	ras_aca_mark_fatal_flag(ras_core);
+
+	ret = ras_core_event_notify(ras_core,
+			RAS_EVENT_ID__FATAL_ERROR_DETECTED, NULL);
+
+	return ret;
+}
+
+uint32_t ras_core_get_curr_nps_mode(struct ras_core_context *ras_core)
+{
+	if (ras_core->ras_nbio.ip_func &&
+	    ras_core->ras_nbio.ip_func->get_memory_partition_mode)
+		return ras_core->ras_nbio.ip_func->get_memory_partition_mode(ras_core);
+
+	RAS_DEV_ERR(ras_core->dev, "Failed to get gpu memory nps mode!\n");
+	return 0;
+}
+
+int ras_core_update_ecc_info(struct ras_core_context *ras_core)
+{
+	int ret;
+
+	ret = ras_aca_update_ecc(ras_core, RAS_ERR_TYPE__CE, NULL);
+	if (!ret)
+		ret = ras_aca_update_ecc(ras_core, RAS_ERR_TYPE__UE, NULL);
+
+	return ret;
+}
+
+int ras_core_query_block_ecc_data(struct ras_core_context *ras_core,
+			enum ras_block_id block, struct ras_ecc_count *ecc_count)
+{
+	int ret;
+
+	if (!ecc_count || (block >= RAS_BLOCK_ID__LAST) || !ras_core)
+		return -EINVAL;
+
+	ret = ras_aca_get_block_ecc_count(ras_core, block, ecc_count);
+	if (!ret)
+		ras_aca_clear_block_new_ecc_count(ras_core, block);
+
+	return ret;
+}
+
+int ras_core_set_status(struct ras_core_context *ras_core, bool enable)
+{
+	ras_core->ras_core_enabled = enable;
+
+	return 0;
+}
+
+bool ras_core_is_enabled(struct ras_core_context *ras_core)
+{
+	return ras_core->ras_core_enabled;
+}
+
+uint64_t ras_core_get_utc_second_timestamp(struct ras_core_context *ras_core)
+{
+	if (ras_core && ras_core->sys_fn &&
+		ras_core->sys_fn->get_utc_second_timestamp)
+		return ras_core->sys_fn->get_utc_second_timestamp(ras_core);
+
+	RAS_DEV_ERR(ras_core->dev, "Failed to get system timestamp!\n");
+	return 0;
+}
+
+int ras_core_translate_soc_pa_and_bank(struct ras_core_context *ras_core,
+	uint64_t *soc_pa, struct umc_bank_addr *bank_addr, bool bank_to_pa)
+{
+	if (!ras_core || !soc_pa || !bank_addr)
+		return -EINVAL;
+
+	return ras_umc_translate_soc_pa_and_bank(ras_core, soc_pa, bank_addr, bank_to_pa);
+}
+
+bool ras_core_ras_interrupt_detected(struct ras_core_context *ras_core)
+{
+	if (ras_core && ras_core->sys_fn &&
+		ras_core->sys_fn->detect_ras_interrupt)
+		return ras_core->sys_fn->detect_ras_interrupt(ras_core);
+
+	RAS_DEV_ERR(ras_core->dev, "Failed to detect ras interrupt!\n");
+	return false;
+}
+
+int ras_core_get_gpu_mem(struct ras_core_context *ras_core,
+	enum gpu_mem_type mem_type, struct gpu_mem_block *gpu_mem)
+{
+	if (ras_core->sys_fn && ras_core->sys_fn->get_gpu_mem)
+		return ras_core->sys_fn->get_gpu_mem(ras_core, mem_type, gpu_mem);
+
+	RAS_DEV_ERR(ras_core->dev, "Not config get gpu memory API!\n");
+	return -EACCES;
+}
+
+int ras_core_put_gpu_mem(struct ras_core_context *ras_core,
+	enum gpu_mem_type mem_type, struct gpu_mem_block *gpu_mem)
+{
+	if (ras_core->sys_fn && ras_core->sys_fn->put_gpu_mem)
+		return ras_core->sys_fn->put_gpu_mem(ras_core, mem_type, gpu_mem);
+
+	RAS_DEV_ERR(ras_core->dev, "Not config put gpu memory API!!\n");
+	return -EACCES;
+}
+
+bool ras_core_is_ready(struct ras_core_context *ras_core)
+{
+	return ras_core ? ras_core->is_initialized : false;
+}
+
+bool ras_core_check_safety_watermark(struct ras_core_context *ras_core)
+{
+	return ras_eeprom_check_safety_watermark(ras_core);
+}
+
+int ras_core_down_trylock_gpu_reset_lock(struct ras_core_context *ras_core)
+{
+	if (ras_core->sys_fn && ras_core->sys_fn->gpu_reset_lock)
+		return ras_core->sys_fn->gpu_reset_lock(ras_core, true, true);
+
+	return 1;
+}
+
+void ras_core_down_gpu_reset_lock(struct ras_core_context *ras_core)
+{
+	if (ras_core->sys_fn && ras_core->sys_fn->gpu_reset_lock)
+		ras_core->sys_fn->gpu_reset_lock(ras_core, true, false);
+}
+
+void ras_core_up_gpu_reset_lock(struct ras_core_context *ras_core)
+{
+	if (ras_core->sys_fn && ras_core->sys_fn->gpu_reset_lock)
+		ras_core->sys_fn->gpu_reset_lock(ras_core, false, false);
+}
+
+int ras_core_event_notify(struct ras_core_context *ras_core,
+		enum ras_notify_event event_id, void *data)
+{
+	if (ras_core && ras_core->sys_fn &&
+		ras_core->sys_fn->ras_notifier)
+		return ras_core->sys_fn->ras_notifier(ras_core, event_id, data);
+
+	return -RAS_CORE_NOT_SUPPORTED;
+}
+
+int ras_core_get_device_system_info(struct ras_core_context *ras_core,
+		struct device_system_info *dev_info)
+{
+	if (ras_core && ras_core->sys_fn &&
+		ras_core->sys_fn->get_device_system_info)
+		return ras_core->sys_fn->get_device_system_info(ras_core, dev_info);
+
+	return -RAS_CORE_NOT_SUPPORTED;
+}
-- 
2.34.1

