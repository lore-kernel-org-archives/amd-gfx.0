Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8334C3ABC3
	for <amd-gfx@archiver.kernel.org>; Mon, 12 May 2025 03:44:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 14FBE10E145;
	Mon, 12 May 2025 03:44:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="DE4+BWmJ";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2050.outbound.protection.outlook.com [40.107.92.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C0D2310E114
 for <amd-gfx@lists.freedesktop.org>; Mon, 12 May 2025 03:44:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QJ2uWc5i0dCOcvrkyQwgtAYqrk5Zj2Q21s0AqisqTwkrtViiiqJ5NbjEzyRn26E3B8jzCT69oV+FM3MZiaaxVevZ88UqFyaNncN2x78XPJZYdTQev5P8LzKhWz/ldz0oUWRaFxW3rkvHUvzyseO9ABHd10soYzqfhiiNWtKG/Qcm5bEjkXqCbr5ewRXCXVePrrnL3KoMEUsii6t1zuuKDznoRH8WtdYhExxlCON5FCmEcSLumQwxz2HvGKnaHuWmpt40f9x44u421zol1BJlbabQBHjVp0fk63L9BfBAw+mnVITKzW0xV7rbnIcQ/gQahVNdPxCS5w5NA4CcX3vX6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FRLxCTc/2Sq7fs8JoSNKmc43FYt4c96qgzd4//VFpRw=;
 b=i9bqM5rh25Cfmds3P5BVpDoVEygXnR5shn+TsJCTdqxk63QFvjBn6ncQR1DXuTct+ZvBImMJko3Yt1FUtmnraSBl62IfSHH6+W2RkhOXByLGPUlpUuqD6mE/PjkmeD+mYjWhMIWYpgSdj5j4ys3JdlFAj7FZOwMLuuhWSvHsG3V1JIveJ0mWvjByzjxVuA/IcUFVEiTengKPMdTT1iNPyFZshsc7li8ZO8RHqY+1/XaRVWT8SyAlqto3SriLha39t0tfKrlSHWSo+KA/RBG5l3UEGkoRZLS1HLzjhvc94MbFcAW9YiojuPCqaR79LMblwHHuo09p703CV8zxxf5UQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FRLxCTc/2Sq7fs8JoSNKmc43FYt4c96qgzd4//VFpRw=;
 b=DE4+BWmJqf5vPIPcpMxvVDNYhe9pRDo9x2biWsO+y69IApOykneyI1erd0dHYGxU7H25lsk2T0XCxJbcXeKQia+TDx7+KIAgM/kck7/i80k+/bckUOrK74uUfXkD1faOQ9fRTRPzN81np+xTTXy3mMkPhrf5HLOISFSzOBH5evM=
Received: from CH0PR03CA0219.namprd03.prod.outlook.com (2603:10b6:610:e7::14)
 by PH7PR12MB6420.namprd12.prod.outlook.com (2603:10b6:510:1fc::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.28; Mon, 12 May
 2025 03:44:22 +0000
Received: from CH3PEPF00000010.namprd04.prod.outlook.com
 (2603:10b6:610:e7:cafe::3f) by CH0PR03CA0219.outlook.office365.com
 (2603:10b6:610:e7::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8699.33 via Frontend Transport; Mon,
 12 May 2025 03:44:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH3PEPF00000010.mail.protection.outlook.com (10.167.244.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8722.18 via Frontend Transport; Mon, 12 May 2025 03:44:20 +0000
Received: from k-Super-Server.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sun, 11 May
 2025 22:44:18 -0500
From: fanhuang <FangSheng.Huang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Hawking.Zhang@amd.com>,
 <Alexander.Deucher@amd.com>
CC: <Ahmad.Rehman@amd.com>, <Vignesh.Chander@amd.com>, fanhuang
 <FangSheng.Huang@amd.com>
Subject: [PATCH 1/3] drm/amdgpu/mmsch: Add MMSCH v5_0 support for sriov
Date: Mon, 12 May 2025 11:44:01 +0800
Message-ID: <20250512034403.381441-2-FangSheng.Huang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250512034403.381441-1-FangSheng.Huang@amd.com>
References: <20250512034403.381441-1-FangSheng.Huang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000010:EE_|PH7PR12MB6420:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e3395e7-3455-4c86-d7f0-08dd91074788
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014|43062017; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?qtuZ5fUIpyh7yl4xIf5Ri/t7wzLSjonI0Cus1KavezxQdZlbb/CvFkbwJa+k?=
 =?us-ascii?Q?EVRGRKhHGPTglFBtm7f1lOqczLQlF4JZ3WEiNf1v6V4puVrmFO1UbgWA9UnT?=
 =?us-ascii?Q?gIfl3+IBGer2WggQvnyZSY7BoKfqmcaXheQXmiVagych+FJm+u+h4HADZqv9?=
 =?us-ascii?Q?CCZ8Lu5wx7tOtQRBsfFhsJ/caGxhjX+L1xtFTJyN0mwORjhACmAZFXVHtLYo?=
 =?us-ascii?Q?DPg5C6+oPSKf+i+49YywMAU3xjBipqhq0iWK3NdYH+lY0B8YSVAnTd+Y6CKh?=
 =?us-ascii?Q?SOONEdIcAzIaZiaFOv08XsSZqcM/gS7J9Ujl5Tamx9wDXb+VMkY5nJJuNI6a?=
 =?us-ascii?Q?VMuyu2mVhY1aP3JEeZEOcgnY7kcq6+G6bvJecMid86QZ2eEDFerl8HgsrvFL?=
 =?us-ascii?Q?I3jVJUUYh2XkdGEyBxmlpszeExkpjYNCXNw3ofP/0QIuAHbavDbF0aC2oyGG?=
 =?us-ascii?Q?bGQW/NLdNuNCXn3De1i0IXCdBFmOl459eW5THjj1mReGwgmiK0EMJ52Hd6TH?=
 =?us-ascii?Q?FmhtNs5CNQnXwolqCXfENAQ5nMu2+Uen1iYOXjcmb7x1466LCS7NDCPYm+/W?=
 =?us-ascii?Q?2CF/3zSNlCeq89Muv4++/cmHSLURUbdQrFMYBMNVXTpPvKz51NCYguLHOjNU?=
 =?us-ascii?Q?7nwwFUlMk4owj1NifKwNC0kFn6/4GrgvdThWq8HO2mnQXKaVHxBho5IgiFO5?=
 =?us-ascii?Q?gkNT3T0OUnpHHiRVrUzW7b+jWZomMF51h/vxPC1trOEJis+MlKnHRJ7OL4GP?=
 =?us-ascii?Q?ep7GTgqQcPg2ph6pRj+bwfAuIR2GM9EjwymKT7sRNHV7CTThXFTm3wCEd635?=
 =?us-ascii?Q?/Qtlqg0LKQbG/KSx+DdQ+fdfhGQylenASm14MYE65n9BP78gdzLP/7qnrD9v?=
 =?us-ascii?Q?nQMIpzdCXLMDvM8/Opck0VTWmrg5L5K1x7RjbE0mEg/cxH+d4FVU0viJOO/5?=
 =?us-ascii?Q?+MS1f8UCe/qhGVgKu2snSz5BW5KewAO+7q9LfO7ugYA6jEeaBYdAR6y642C5?=
 =?us-ascii?Q?/6rJ0MWLb3RW56TuVnNCpf63B0ibx5yNc+ZePTqFLAJo6gDhM2hZ3GSCaOr2?=
 =?us-ascii?Q?CHXHbqELi9sCgXFikluD5HV7d9JxNgJC17bJNtxjIBdLHpyHySlX6AxUhUsh?=
 =?us-ascii?Q?mg8wWIw9W1ytHEgVRI8Pgav7qQ56wQYdvGaQEBrCEuZroHHi6wS34D02bNRH?=
 =?us-ascii?Q?9rMlUneywdNN3jTXsZYOufY1E05SZ9SMzJIJBf0xkJ36gchMK85OnJYOcjH0?=
 =?us-ascii?Q?6b+5yFFUJW6sqoqs9SzRb6QBl/Hf2AQ5sV2fyxrOstBkL38M6ILDrR+KTTiR?=
 =?us-ascii?Q?TqRaJUEsVru6sadwRFO5rXCeR8rHBtSH5iobFZS0rAHSi0vCbLPxm8+RELGO?=
 =?us-ascii?Q?QqiGEa/MV82rddq7VbMR8z/Q3rPNdTy6ow9J0mvoM0aCKalqE4Kka2ZPn3Tc?=
 =?us-ascii?Q?mFMa+I/bqhBpJJU3A+jmyU0H0VBhmEV/sdAlwU3ZrwXhaRufRyvWZFJi3yrQ?=
 =?us-ascii?Q?O54LhKOmzTCqQ95Y2grONWX0BmakYJ5L/yxKJMC1Xnv//6f0d/L1JV4IWA?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014)(43062017);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2025 03:44:20.6892 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e3395e7-3455-4c86-d7f0-08dd91074788
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF00000010.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6420
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

These structures are basically ported from MMSCH v4_0
The structures are the same as v4_0 except for the
init header

Signed-off-by: fanhuang <FangSheng.Huang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mmsch_v5_0.h | 144 ++++++++++++++++++++++++
 1 file changed, 144 insertions(+)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/mmsch_v5_0.h

diff --git a/drivers/gpu/drm/amd/amdgpu/mmsch_v5_0.h b/drivers/gpu/drm/amd/amdgpu/mmsch_v5_0.h
new file mode 100644
index 000000000000..6f749814929f
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/mmsch_v5_0.h
@@ -0,0 +1,144 @@
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
+#ifndef __MMSCH_V5_0_H__
+#define __MMSCH_V5_0_H__
+
+#include "amdgpu_vcn.h"
+
+#define MMSCH_VERSION_MAJOR	5
+#define MMSCH_VERSION_MINOR	0
+#define MMSCH_VERSION	(MMSCH_VERSION_MAJOR << 16 | MMSCH_VERSION_MINOR)
+
+#define RB_ENABLED (1 << 0)
+#define RB4_ENABLED (1 << 1)
+
+#define MMSCH_VF_ENGINE_STATUS__PASS 0x1
+
+#define MMSCH_VF_MAILBOX_RESP__OK                      0x1
+#define MMSCH_VF_MAILBOX_RESP__INCOMPLETE              0x2
+#define MMSCH_VF_MAILBOX_RESP__FAILED                  0x3
+#define MMSCH_VF_MAILBOX_RESP__FAILED_SMALL_CTX_SIZE   0x4
+#define MMSCH_VF_MAILBOX_RESP__UNKNOWN_CMD             0x5
+
+enum mmsch_v5_0_command_type {
+	MMSCH_COMMAND__DIRECT_REG_WRITE = 0,
+	MMSCH_COMMAND__DIRECT_REG_POLLING = 2,
+	MMSCH_COMMAND__DIRECT_REG_READ_MODIFY_WRITE = 3,
+	MMSCH_COMMAND__INDIRECT_REG_WRITE = 8,
+	MMSCH_COMMAND__END = 0xf
+};
+
+struct mmsch_v5_0_table_info {
+	uint32_t init_status;
+	uint32_t table_offset;
+	uint32_t table_size;
+};
+
+struct mmsch_v5_0_init_header {
+	uint32_t version;
+	uint32_t total_size;
+	struct mmsch_v5_0_table_info vcn0;
+	struct mmsch_v5_0_table_info mjpegdec0[5];
+	struct mmsch_v5_0_table_info mjpegdec1[5];
+};
+
+struct mmsch_v5_0_cmd_direct_reg_header {
+	uint32_t reg_offset   : 28;
+	uint32_t command_type : 4;
+};
+
+struct mmsch_v5_0_cmd_indirect_reg_header {
+	uint32_t reg_offset    : 20;
+	uint32_t reg_idx_space : 8;
+	uint32_t command_type  : 4;
+};
+
+struct mmsch_v5_0_cmd_direct_write {
+	struct mmsch_v5_0_cmd_direct_reg_header cmd_header;
+	uint32_t reg_value;
+};
+
+struct mmsch_v5_0_cmd_direct_read_modify_write {
+	struct mmsch_v5_0_cmd_direct_reg_header cmd_header;
+	uint32_t write_data;
+	uint32_t mask_value;
+};
+
+struct mmsch_v5_0_cmd_direct_polling {
+	struct mmsch_v5_0_cmd_direct_reg_header cmd_header;
+	uint32_t mask_value;
+	uint32_t wait_value;
+};
+
+struct mmsch_v5_0_cmd_end {
+	struct mmsch_v5_0_cmd_direct_reg_header cmd_header;
+};
+
+struct mmsch_v5_0_cmd_indirect_write {
+	struct mmsch_v5_0_cmd_indirect_reg_header cmd_header;
+	uint32_t reg_value;
+};
+
+#define MMSCH_V5_0_INSERT_DIRECT_RD_MOD_WT(reg, mask, data) { \
+	size = sizeof(struct mmsch_v5_0_cmd_direct_read_modify_write); \
+	size_dw = size / 4; \
+	direct_rd_mod_wt.cmd_header.reg_offset = reg; \
+	direct_rd_mod_wt.mask_value = mask; \
+	direct_rd_mod_wt.write_data = data; \
+	memcpy((void *)table_loc, &direct_rd_mod_wt, size); \
+	table_loc += size_dw; \
+	table_size += size_dw; \
+}
+
+#define MMSCH_V5_0_INSERT_DIRECT_WT(reg, value) { \
+	size = sizeof(struct mmsch_v5_0_cmd_direct_write); \
+	size_dw = size / 4; \
+	direct_wt.cmd_header.reg_offset = reg; \
+	direct_wt.reg_value = value; \
+	memcpy((void *)table_loc, &direct_wt, size); \
+	table_loc += size_dw; \
+	table_size += size_dw; \
+}
+
+#define MMSCH_V5_0_INSERT_DIRECT_POLL(reg, mask, wait) { \
+	size = sizeof(struct mmsch_v5_0_cmd_direct_polling); \
+	size_dw = size / 4; \
+	direct_poll.cmd_header.reg_offset = reg; \
+	direct_poll.mask_value = mask; \
+	direct_poll.wait_value = wait; \
+	memcpy((void *)table_loc, &direct_poll, size); \
+	table_loc += size_dw; \
+	table_size += size_dw; \
+}
+
+#define MMSCH_V5_0_INSERT_END() { \
+	size = sizeof(struct mmsch_v5_0_cmd_end); \
+	size_dw = size / 4; \
+	memcpy((void *)table_loc, &end, size); \
+	table_loc += size_dw; \
+	table_size += size_dw; \
+}
+
+#endif
+
-- 
2.34.1

