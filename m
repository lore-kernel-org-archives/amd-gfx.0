Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD3F0ECAAA1
	for <amd-gfx@archiver.kernel.org>; Tue, 30 Aug 2022 18:41:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CB69710E39A;
	Tue, 30 Aug 2022 18:40:51 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2079.outbound.protection.outlook.com [40.107.244.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 07CB310E37B
 for <amd-gfx@lists.freedesktop.org>; Tue, 30 Aug 2022 18:40:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G/JwEY1ShRRMMSS4Qe2VeknisYzGft1TT+S5t50UinT9CRt/8oMyRjGLLMtArK50F+Rpl0DzLMlu7vVKWGnjcUjCOCcsvOj8X0Ljmng/NSIQiSLhIUbTAgV/2La5X8tCc8x2E0poUWU9Yr46EEa6uxvO8Z49BVhBZHJflk6qJXBDnUExCdQYz9fihcaKg9I64EBv3NXuOYfPrvr0ALr9inHanoKd8bnchhVnfHQU1qgolaY5pyPW9fFWegg96jqIs+nSl9MO7QNHp7v1mwEBacO5/ceilAle7sUFXZHdgD0LTaJ1gTsOi1womvWY6q54gZqG9ZQA9+5CkU9hMDnH/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0MWLkSvXqWSD33+rQsTqNyrLlQgU/b0yNb/Q5rQXWnM=;
 b=EwgxHD7Vv1LwALb6dYklXeDR26L8oiKcdtLls9JyF/5W3Dr8JVg/6XtDKR1fmXUchBQtoRfYDTR7IZqTvoeJY40N+NEC4bLTPAIG1d5uocEJAu1UekhUXY4VjCLo7Bo384dwVSXOcKKuqoOUNO2ym0fqFTsDOVuZ0nRuUJnex4ElPxRwVe/aQJYmpqLTQpxxSXkYF3p3TXewJgrZCKno7zpdoh8j1Pdhiw6vK3cUR7d8+PkK3aK8O022Sz/QeRxoywaw4+Ic4EYevhCrXKUxBIavdXLwZ308xSVS4xe+uoewLxh0J97G3KXtLk0nU+ErHqBEy1h8we2qDnVt+iPJzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0MWLkSvXqWSD33+rQsTqNyrLlQgU/b0yNb/Q5rQXWnM=;
 b=1ZSV22BhAvCdfMVSqwsa+Ae5H8Upbu5AsyBzv+ZZo+sHl+1PwoZYNtKpdkhtGU4wtZB8Y/YOTz+Q1qRCDP9ILEbSDSsjZ92Kt+PGWdNihxUyOZTcnwaVOzfHRRmP528HU/hWGgyHVhXJq96HqksjPFRlyR6eYDu3sd6c30rarfM=
Received: from DM6PR02CA0050.namprd02.prod.outlook.com (2603:10b6:5:177::27)
 by IA1PR12MB6411.namprd12.prod.outlook.com (2603:10b6:208:388::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.21; Tue, 30 Aug
 2022 18:40:38 +0000
Received: from DM6NAM11FT096.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:177:cafe::c0) by DM6PR02CA0050.outlook.office365.com
 (2603:10b6:5:177::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15 via Frontend
 Transport; Tue, 30 Aug 2022 18:40:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT096.mail.protection.outlook.com (10.13.173.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5588.10 via Frontend Transport; Tue, 30 Aug 2022 18:40:38 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 30 Aug
 2022 13:40:34 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 19/19] drm/amdgpu/vcn: Add MMSCH v4_0 support for sriov
Date: Tue, 30 Aug 2022 14:40:12 -0400
Message-ID: <20220830184012.1825313-19-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220830184012.1825313-1-alexander.deucher@amd.com>
References: <20220830184012.1825313-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3662591e-fb9e-4832-c71c-08da8ab7221e
X-MS-TrafficTypeDiagnostic: IA1PR12MB6411:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wsajTx/xLyw8oIM6sx1o1+Vk9d7ndUDwJipdBP4r0VlWqVny1gTGIxL/MFNAVtURdz8ntP0Q2husO7tkpu+0w3XU5wwusdnBYbrpBZRkbCderlp5UK33DPpYud8fRa4YfrVKYVAe1/bNjj7IUTFHfQbp15krJin82uvaU6Vh9Y8cTEFseYMEAncaIpfaYcEAGLOWDUqdP6hhzyTZKAM+4k/Fb4T2yAXMEb3oJ7q0uEN+9HU6Vq8Z31HtkpK21AR0pX9XQj8pB8JF+TkuzgqKdp99jBeD+3xOYSX5q1EFyVTVUqJ/ZNUat9X//WZz43H6SP2hh9E9kakZ+7h5wd4GWf+aTLAIRkVJUxzE6NT2CRm7q4gP8njRzSb24B6go9B3fuumahl9qteahmqJTqBzJ/0IujXOFw0ei7P5GhUvEn4mcOEwXplYdF+KDskqu3HChA4MWvY5XwY1ztpXS2ug1B+kXyKJQyhsBvEjYO9AZVJgV46BVKNcEsAhXipLzLPqrH6bJNHrI8l0G9hljjbt+3LcouAU2CQxzL/mucjKHIZHweMHLwMnsqZq/pS8/FNc1NSg/E4bTUDxawpZpO58wqhFI7ZetD03AQGN9S3zAO7hgHg1Nwa18i6d+dannnpYIb+v2HD8U3bPmEYjjCZMj4aT/ZIbroJiTP2SKrGDRhuO7mNr0Fvs9Ny+aoVvBoVK+0+LFOzG9Jpv6d6eBvuMQ1/4PmuTtt9a/5BOciYTS9+5qsjK+O/J4tResXyVfRguQzz+azzXtbjkghvfIZOG0RjZtzOJfoyqX1l/cKAi7sCXObNULOt30eooM6wJlUVn
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(39860400002)(396003)(136003)(376002)(346002)(46966006)(36840700001)(40470700004)(1076003)(336012)(426003)(356005)(16526019)(36860700001)(186003)(2616005)(6916009)(83380400001)(2906002)(316002)(54906003)(4326008)(70586007)(70206006)(47076005)(5660300002)(8676002)(478600001)(26005)(7696005)(6666004)(8936002)(40460700003)(40480700001)(41300700001)(81166007)(82310400005)(36756003)(86362001)(82740400003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2022 18:40:38.0718 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3662591e-fb9e-4832-c71c-08da8ab7221e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT096.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6411
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Jane Jian <Jane.Jian@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Jane Jian <Jane.Jian@amd.com>

These structures are basically ported from MMSCH v3_0,
besides, added RB and RB4 enablement flag to support
unified queue

Signed-off-by: Jane Jian <Jane.Jian@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mmsch_v4_0.h | 140 ++++++++++++++++++++++++
 1 file changed, 140 insertions(+)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/mmsch_v4_0.h

diff --git a/drivers/gpu/drm/amd/amdgpu/mmsch_v4_0.h b/drivers/gpu/drm/amd/amdgpu/mmsch_v4_0.h
new file mode 100644
index 000000000000..f772bb499f3e
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/mmsch_v4_0.h
@@ -0,0 +1,140 @@
+/*
+ * Copyright 2022 Advanced Micro Devices, Inc.
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
+#ifndef __MMSCH_V4_0_H__
+#define __MMSCH_V4_0_H__
+
+#include "amdgpu_vcn.h"
+
+#define MMSCH_VERSION_MAJOR	4
+#define MMSCH_VERSION_MINOR	0
+#define MMSCH_VERSION	(MMSCH_VERSION_MAJOR << 16 | MMSCH_VERSION_MINOR)
+
+#define RB_ENABLED (1 << 0)
+#define RB4_ENABLED (1 << 1)
+#define MMSCH_DOORBELL_OFFSET 0x8
+
+#define MMSCH_VF_ENGINE_STATUS__PASS 0x1
+
+#define MMSCH_VF_MAILBOX_RESP__OK 0x1
+#define MMSCH_VF_MAILBOX_RESP__INCOMPLETE 0x2
+
+enum mmsch_v4_0_command_type {
+	MMSCH_COMMAND__DIRECT_REG_WRITE = 0,
+	MMSCH_COMMAND__DIRECT_REG_POLLING = 2,
+	MMSCH_COMMAND__DIRECT_REG_READ_MODIFY_WRITE = 3,
+	MMSCH_COMMAND__INDIRECT_REG_WRITE = 8,
+	MMSCH_COMMAND__END = 0xf
+};
+
+struct mmsch_v4_0_table_info {
+	uint32_t init_status;
+	uint32_t table_offset;
+	uint32_t table_size;
+};
+
+struct mmsch_v4_0_init_header {
+	uint32_t version;
+	uint32_t total_size;
+	struct mmsch_v4_0_table_info inst[AMDGPU_MAX_VCN_INSTANCES];
+	struct mmsch_v4_0_table_info jpegdec;
+};
+
+struct mmsch_v4_0_cmd_direct_reg_header {
+	uint32_t reg_offset   : 28;
+	uint32_t command_type : 4;
+};
+
+struct mmsch_v4_0_cmd_indirect_reg_header {
+	uint32_t reg_offset    : 20;
+	uint32_t reg_idx_space : 8;
+	uint32_t command_type  : 4;
+};
+
+struct mmsch_v4_0_cmd_direct_write {
+	struct mmsch_v4_0_cmd_direct_reg_header cmd_header;
+	uint32_t reg_value;
+};
+
+struct mmsch_v4_0_cmd_direct_read_modify_write {
+	struct mmsch_v4_0_cmd_direct_reg_header cmd_header;
+	uint32_t write_data;
+	uint32_t mask_value;
+};
+
+struct mmsch_v4_0_cmd_direct_polling {
+	struct mmsch_v4_0_cmd_direct_reg_header cmd_header;
+	uint32_t mask_value;
+	uint32_t wait_value;
+};
+
+struct mmsch_v4_0_cmd_end {
+	struct mmsch_v4_0_cmd_direct_reg_header cmd_header;
+};
+
+struct mmsch_v4_0_cmd_indirect_write {
+	struct mmsch_v4_0_cmd_indirect_reg_header cmd_header;
+	uint32_t reg_value;
+};
+
+#define MMSCH_V4_0_INSERT_DIRECT_RD_MOD_WT(reg, mask, data) { \
+	size = sizeof(struct mmsch_v4_0_cmd_direct_read_modify_write); \
+	size_dw = size / 4; \
+	direct_rd_mod_wt.cmd_header.reg_offset = reg; \
+	direct_rd_mod_wt.mask_value = mask; \
+	direct_rd_mod_wt.write_data = data; \
+	memcpy((void *)table_loc, &direct_rd_mod_wt, size); \
+	table_loc += size_dw; \
+	table_size += size_dw; \
+}
+
+#define MMSCH_V4_0_INSERT_DIRECT_WT(reg, value) { \
+	size = sizeof(struct mmsch_v4_0_cmd_direct_write); \
+	size_dw = size / 4; \
+	direct_wt.cmd_header.reg_offset = reg; \
+	direct_wt.reg_value = value; \
+	memcpy((void *)table_loc, &direct_wt, size); \
+	table_loc += size_dw; \
+	table_size += size_dw; \
+}
+
+#define MMSCH_V4_0_INSERT_DIRECT_POLL(reg, mask, wait) { \
+	size = sizeof(struct mmsch_v4_0_cmd_direct_polling); \
+	size_dw = size / 4; \
+	direct_poll.cmd_header.reg_offset = reg; \
+	direct_poll.mask_value = mask; \
+	direct_poll.wait_value = wait; \
+	memcpy((void *)table_loc, &direct_poll, size); \
+	table_loc += size_dw; \
+	table_size += size_dw; \
+}
+
+#define MMSCH_V4_0_INSERT_END() { \
+	size = sizeof(struct mmsch_v4_0_cmd_end); \
+	size_dw = size / 4; \
+	memcpy((void *)table_loc, &end, size); \
+	table_loc += size_dw; \
+	table_size += size_dw; \
+}
+
+#endif
-- 
2.37.1

