Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EB48CAC59F
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Sep 2025 01:33:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ED3A610E1D9;
	Thu, 18 Sep 2025 01:33:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="QocRn9md";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010005.outbound.protection.outlook.com [52.101.56.5])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B471210E5F2
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Sep 2025 01:33:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nSmLrjcTS2xYRzslsP/NuMji9G7XtBfXzNUkJyhXjUZBs5jXnrGwnRRL9IU/yQjeqgQEWDLiaDXi9MjUeCcKelZZp4/KubE6Cqbi4hRouWbyg1cnDCJt2ertd3XGEgssVz10E0JTqVxnLT8VNLiXXk69nBGF6nFsrbgGz0yi81ziqPFNxU8s2xdZN8jbCGr2ndAgSzVJhD9MZzJAbqcf9QEIZyYfz+tcXadPU9fPVAGOGpNzYuJ/TEFhW6zebaujsBIEJ/znO17/KUbszBqJK/xmzmcL/8u+zBMoWGIiP6F1DfxKgFUFv4bJsckk1sTOZxRNyRqMIWrYlKcCXLiTig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dwCc+rJTXiY7zIgbPUUEvRH8DXHQSTiReDPlJRxazz0=;
 b=F9ZW+ZOcDcYVExAdHIDwPiaPE2uQUgHwpWhsuBZXE+SVEf6obyk+LogmPV7ZckPY22w3UZNOZaK2nca16PwVWJbXwO0Sqk+500R6hozBscmZqolyH8v6Sn0Hn/aisL7N1QhJX47O/yTnPsHXV2mJuiq6eEREMePPKMA6MBXDzx0MXGtpvs+dhdbVar9HvwLCN60cuI2HzwovF3ImvFye2WGRO08dcMhPaRFjqf/E7BQho+KgFZB45DPMCfo1JNjh3dlkUZ34z+6rWh3ZSDeRpZsBhH2fIUIVeqmfkLZPNpLZtMEtXk/GzJwyHMoGvdSoNBlDgOV8QT7BTL9v6QqPiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dwCc+rJTXiY7zIgbPUUEvRH8DXHQSTiReDPlJRxazz0=;
 b=QocRn9mdH3SjkHc6r+XFY+0rm3ERMszA+7Eu22ie/HkARqhfc8xCviUZS+W5knzq8Szzzqb00ONhDRdvBg7FaHN+AfkaTv+zG3foMsWJ9YLJ3UKM5ohDfy+Wl29UOgZOwIK6WxS4UxSjQKHrZiyOFAZSu/Gmgu4/cYnz+Ru+2mc=
Received: from MW4PR04CA0224.namprd04.prod.outlook.com (2603:10b6:303:87::19)
 by PH7PR12MB8780.namprd12.prod.outlook.com (2603:10b6:510:26b::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.13; Thu, 18 Sep
 2025 01:33:18 +0000
Received: from CO1PEPF000044F1.namprd05.prod.outlook.com
 (2603:10b6:303:87:cafe::54) by MW4PR04CA0224.outlook.office365.com
 (2603:10b6:303:87::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.13 via Frontend Transport; Thu,
 18 Sep 2025 01:33:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF000044F1.mail.protection.outlook.com (10.167.241.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Thu, 18 Sep 2025 01:33:17 +0000
Received: from amd-02.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 17 Sep
 2025 18:33:15 -0700
From: YiPeng Chai <YiPeng.Chai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Tao.Zhou1@amd.com>, <Candice.Li@amd.com>,
 <Stanley.Yang@amd.com>, YiPeng Chai <YiPeng.Chai@amd.com>, Tao Zhou
 <tao.zhou1@amd.com>
Subject: [PATCH 06/21] drm/amd/ras: Add mp1 common ras functions
Date: Thu, 18 Sep 2025 09:32:17 +0800
Message-ID: <20250918013232.2629215-6-YiPeng.Chai@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250918013232.2629215-1-YiPeng.Chai@amd.com>
References: <20250918013232.2629215-1-YiPeng.Chai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F1:EE_|PH7PR12MB8780:EE_
X-MS-Office365-Filtering-Correlation-Id: 1de7a901-fc6f-4fb6-9154-08ddf6535844
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?LNKseTiQVZzv+AnXw0xhyEvp6rzZ1nNfKhNY4CHclc0GMx8Pu9+Yoxl6nVNV?=
 =?us-ascii?Q?Iavz8kwDdYX+F0m3w3MPQBcHkW6MBThCW1xQ6VXPD9qCes7c3DO9pZ1iZDuh?=
 =?us-ascii?Q?YsQVzZoACpe95nomlfHKJvMQD5/Qo39ICiBZPWp9ux+uITJBK9pbCKQSt4r7?=
 =?us-ascii?Q?hwXX3Kwjj1cWoMqG6YjWj6zZypxZ/qydySlxDxb/GhOL4O4mDm36DONhHk0c?=
 =?us-ascii?Q?q2Xjz8Bv1RvQ0N7zW/TTNvu0q9pDTR4hgoAQRCdAtJj+1S5WsqUNhbx2i64T?=
 =?us-ascii?Q?SndoICwsbQtJiDYQ1W4KYu2JtZfaWZm+TjKJIW+tBO4zuVYD1j+fixpmCRAM?=
 =?us-ascii?Q?odsf2y1zuLigx8h1Tl6H4Ra8DYTHMgGaDmb+6niTs2KVVGtxYO1N4xkM/xpR?=
 =?us-ascii?Q?FNI6tb+g7QXQfhinsHfNmM+bbWy3wd4UkFMnhWJ0Y07+1CiXj3H/298Xhu93?=
 =?us-ascii?Q?Uc+q6PhhL/cZDDW/Ue2tRXE3C8ZMPOk21RdhdA89d6Z7tIrmxM+yDJVSiTps?=
 =?us-ascii?Q?HE7Zwa4NR7/fsLVyAyRi2Pd35V7kyXYB4+A1kCvMiLQoLtOqFUzXBuBcz2GL?=
 =?us-ascii?Q?LlR+gjGifapl4DpAdyjRwVGZk2K/fGW/LuZ21DkA/Y6F8V4oNXysQz+f59JC?=
 =?us-ascii?Q?K6uKKrofsVVnBRTY2z/lARxfU/DzodvKJOP0ZqACRW/3VAD09h/2VRn/ZXyd?=
 =?us-ascii?Q?5zIacWUIjs5PBFCDmCD1XYLkrTHouyRIe/EQoWFCRiNkWFT9kgoB+7gl4CIu?=
 =?us-ascii?Q?OyBHQgUvAsKVMEIx49iuYLs+JPpxIIZWoP+tVkV7DvPYrDkiygHSADff64pt?=
 =?us-ascii?Q?JFNuIf7y2kXPFP+8RxTcEb3cQWfEgUPJqBPXvdwHRmSLVmxESZXkSAAd+TRk?=
 =?us-ascii?Q?B+nVMyhvpZnCYCEc3TCfW3y7Gxnp0B9wfLWbbylABCdela+K60X2JXNdycBE?=
 =?us-ascii?Q?pdeNj4XVSagl9xsi0cVNSjM5SSTa1rrUHWYgHasaYLJmGgrIFEDa4BZwejgK?=
 =?us-ascii?Q?rLz2wfpF156xQ0/NXCk+ikSMAnCPw132BUp46kUZeetrzPvCai2vnHegjaoZ?=
 =?us-ascii?Q?YLigs3eher7K3aOyPZPM33QjOXQz7AJCtZMug+j6vhVwObwhDeki3lbRPSiA?=
 =?us-ascii?Q?HCkHtS9HlMMTkFTVwhwusa5Oty1lwsOlxTEL+9ok1dpwW0oz7NKtsJpNhvXF?=
 =?us-ascii?Q?tQU5YYClV+7fqfefgIHA3pCc8rAZA3LiXkquH68BUMFEkAV2DZg3GgmXujf2?=
 =?us-ascii?Q?u8nJhTpIDxMcPbNMWAEz0nU7d9XV0a5NtrsVawR3rNfFOqIC3UOoFpvhndNt?=
 =?us-ascii?Q?yFayCUS2mwhhA9LZk/07rfWvOr+/53nRA4qaI7EhA+Nuw0dj//Ci5xAIWmKo?=
 =?us-ascii?Q?bgQWFgPumHNpSd0tEpYdTtRyBYUOZYJkIEAogKTC610X/jnnt3EBU58sLi8N?=
 =?us-ascii?Q?ESt5yqgmLi7P2SJZVmQFkgcZRJLZ/52JT0Zo3eXWj+Okg5zEv7O2oRCLa/XF?=
 =?us-ascii?Q?rVmaSy8W/FS2D++LpQyCJ6qx+/Vz/tiDigr1?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2025 01:33:17.8751 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1de7a901-fc6f-4fb6-9154-08ddf6535844
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8780
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

Add mp1 common ras functions.

Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
Reviewed-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/ras/rascore/ras_mp1.c | 81 +++++++++++++++++++++++
 drivers/gpu/drm/amd/ras/rascore/ras_mp1.h | 50 ++++++++++++++
 2 files changed, 131 insertions(+)
 create mode 100644 drivers/gpu/drm/amd/ras/rascore/ras_mp1.c
 create mode 100644 drivers/gpu/drm/amd/ras/rascore/ras_mp1.h

diff --git a/drivers/gpu/drm/amd/ras/rascore/ras_mp1.c b/drivers/gpu/drm/amd/ras/rascore/ras_mp1.c
new file mode 100644
index 000000000000..92f250e2466d
--- /dev/null
+++ b/drivers/gpu/drm/amd/ras/rascore/ras_mp1.c
@@ -0,0 +1,81 @@
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
+
+#include "ras.h"
+#include "ras_mp1.h"
+#include "ras_mp1_v13_0.h"
+
+static const struct ras_mp1_ip_func *ras_mp1_get_ip_funcs(
+				struct ras_core_context *ras_core, uint32_t ip_version)
+{
+	switch (ip_version) {
+	case IP_VERSION(13, 0, 6):
+	case IP_VERSION(13, 0, 14):
+	case IP_VERSION(13, 0, 12):
+		return &mp1_ras_func_v13_0;
+	default:
+		RAS_DEV_ERR(ras_core->dev,
+			"MP1 ip version(0x%x) is not supported!\n", ip_version);
+		break;
+	}
+
+	return NULL;
+}
+
+int ras_mp1_get_bank_count(struct ras_core_context *ras_core,
+			    enum ras_err_type type, u32 *count)
+{
+	struct ras_mp1 *mp1 = &ras_core->ras_mp1;
+
+	return mp1->ip_func->get_valid_bank_count(ras_core, type, count);
+}
+
+int ras_mp1_dump_bank(struct ras_core_context *ras_core,
+		enum ras_err_type type, u32 idx, u32 reg_idx, u64 *val)
+{
+	struct ras_mp1 *mp1 = &ras_core->ras_mp1;
+
+	return mp1->ip_func->dump_valid_bank(ras_core, type, idx, reg_idx, val);
+}
+
+int ras_mp1_hw_init(struct ras_core_context *ras_core)
+{
+	struct ras_mp1 *mp1 = &ras_core->ras_mp1;
+
+	mp1->mp1_ip_version = ras_core->config->mp1_ip_version;
+	mp1->sys_func = ras_core->config->mp1_cfg.mp1_sys_fn;
+	if (!mp1->sys_func) {
+		RAS_DEV_ERR(ras_core->dev, "RAS mp1 sys function not configured!\n");
+		return -EINVAL;
+	}
+
+	mp1->ip_func = ras_mp1_get_ip_funcs(ras_core, mp1->mp1_ip_version);
+
+	return mp1->ip_func ? RAS_CORE_OK : -EINVAL;
+}
+
+int ras_mp1_hw_fini(struct ras_core_context *ras_core)
+{
+	return 0;
+}
diff --git a/drivers/gpu/drm/amd/ras/rascore/ras_mp1.h b/drivers/gpu/drm/amd/ras/rascore/ras_mp1.h
new file mode 100644
index 000000000000..de1d08286f41
--- /dev/null
+++ b/drivers/gpu/drm/amd/ras/rascore/ras_mp1.h
@@ -0,0 +1,50 @@
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
+#ifndef __RAS_MP1_H__
+#define __RAS_MP1_H__
+#include "ras.h"
+
+enum ras_err_type;
+struct ras_mp1_ip_func {
+	int (*get_valid_bank_count)(struct ras_core_context *ras_core,
+			enum ras_err_type type, u32 *count);
+	int (*dump_valid_bank)(struct ras_core_context *ras_core,
+		enum ras_err_type type, u32 idx, u32 reg_idx, u64 *val);
+};
+
+struct ras_mp1 {
+	uint32_t mp1_ip_version;
+	const struct ras_mp1_ip_func *ip_func;
+	const struct ras_mp1_sys_func *sys_func;
+};
+
+int ras_mp1_hw_init(struct ras_core_context *ras_core);
+int ras_mp1_hw_fini(struct ras_core_context *ras_core);
+
+int ras_mp1_get_bank_count(struct ras_core_context *ras_core,
+			    enum ras_err_type type, u32 *count);
+
+int ras_mp1_dump_bank(struct ras_core_context *ras_core,
+		u32 ecc_type, u32 idx, u32 reg_idx, u64 *val);
+#endif
-- 
2.34.1

