Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 176F6EE49B5
	for <amd-gfx@archiver.kernel.org>; Wed, 23 Aug 2023 15:51:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4729910E44E;
	Wed, 23 Aug 2023 15:51:35 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2071.outbound.protection.outlook.com [40.107.244.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DA4E510E449
 for <amd-gfx@lists.freedesktop.org>; Wed, 23 Aug 2023 15:51:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xk8P98Dlyrb2vmW/0Qit/7tpBqvBzWBR1KVzTvsJd3Wxmsll8qrMHOfphZS/wYY4NHET2E9DMDgZioWd5VMTP7nnw5TzXIeYmYLsyYx8gkLh2N5AC/yPdLbk8npSpBSAswsZnCBwXtGF+GIBZX/RR5HXiHQ3YhXdpj/XMOsJsIl2j72Tp1auq7LQgXi2xbzIwDdegyWeCGkRM+jgsJFv7CyTj2V8w3wDUnFPtofjj9mqoowJa1+vLu0a64Lnm0BbwFt1zV6FbBoIcxkRVxNAru4TSzThOvt3m8XbMZnGs6h18pJeboFcpfBMMAoaXTOiRlAfSaF+xnOMUodnbmYs/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gV3MAR7I7IN5aIqhP6MzF92o1mTAjmABkf9HkLM5qJQ=;
 b=KhvMijKBTDwVEPqNxqjpvSERAYZtaiQNsGAFYUEzEiXzfd2adqibeY7FJcoZIP6tCvLixt6F2G2mMfkZdIVSfRLGHTwW3+alJJbKq53jRdXykPooDOTESgKc0mc6Npe9D9CzE8m0zUr1hZQZMs/7fAcBp/mrUq4pnXR1l1y0s11wqDU2ZtxTs02HgNqrsfEl/+VXOg9Lilc4GrQ4wpntS3DMFei33s85Nhk+NOj9As0TCg1oifPyt02CHxKH7rSy0KLqi4KBJvObpkhHm44tCqs1GetRayzTstc+r6jFhvqv+3h3AEzvL+Eq5O+QelpkCr5dlxno+pyAkmazy72gTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gV3MAR7I7IN5aIqhP6MzF92o1mTAjmABkf9HkLM5qJQ=;
 b=RIIscT8f/DUe9KQvITK45mDKifoHiMnumPqkn/sy1GAORn5/0sJtWQAtdIhUgKo1XUFH8BZ4M7X7Vqq3Zgw9iYiwXhY6sW/JdWfxePC28lPbJ62l6UQc0V6aSntkD9bc+I2j+vO+v2Sp2knDZ8jpUAlXEZS6kl+bz1XhdLOAAJI=
Received: from CY5PR18CA0037.namprd18.prod.outlook.com (2603:10b6:930:13::20)
 by CY8PR12MB8214.namprd12.prod.outlook.com (2603:10b6:930:76::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.24; Wed, 23 Aug
 2023 15:51:23 +0000
Received: from CY4PEPF0000EE32.namprd05.prod.outlook.com
 (2603:10b6:930:13:cafe::ac) by CY5PR18CA0037.outlook.office365.com
 (2603:10b6:930:13::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.26 via Frontend
 Transport; Wed, 23 Aug 2023 15:51:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE32.mail.protection.outlook.com (10.167.242.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.15 via Frontend Transport; Wed, 23 Aug 2023 15:51:23 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 23 Aug
 2023 10:51:17 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 23/35] drm/amd/display: Add DCN35 MMHUBBUB
Date: Wed, 23 Aug 2023 11:50:36 -0400
Message-ID: <20230823155048.2526343-23-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230823155048.2526343-1-alexander.deucher@amd.com>
References: <20230823155048.2526343-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE32:EE_|CY8PR12MB8214:EE_
X-MS-Office365-Filtering-Correlation-Id: da9bfa05-f2a9-43a6-830d-08dba3f0cd43
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MBsVW4b5ASTaX+S307hiv1GyvcvuKsKYZKa6S/tXvNMqzjS4AobaPonW3An2B+pZE0Dhy3Gk4OLvIyDN8j4wF2k5um4MpZYIdHMHzB8OGPMsqvhEPRvwqWDwWTV1cxiE53iPBhsWU5L/cG4F90825Sz6d6fmpGLt33bRGesTLFM4E3Htjzha8XO+LA1fcTNULg0luV3hqL3Upfuz5kR2BksWcI8JP93wiX+ndOjueV7XtFMPG70hi5Cjej4yNPMXVc3uVwHY+MMwwMStM9ATJOB8FY1auHjLM0oA8GhUtGH4dLmRKFPpW2nHJqWIOOBaHeSt0DvdAAo9OQrj2KI9p9MbQnLSzcH+CyM+YHUioqmmpZEzExbaJAoG/NDacIGiOODEVQ/rwfaFMq13GzW7GcUXolp+Mj+lsPfAqczRcy90hUd2hmiMos4U+/naI0Kvxxmx3UbntJiyt+CkZRKjRaeLy8GUkyuUrLcFxFe8gSMmRMUEJme+EVAjG+ouHTj+G4HklewK6vAureN//exC3yRQruFpK0tJdhhCItPbZrUF4ZfDkzKHrJO42p24hLseFOrB9RfyBoffodD7hANek4Fe1Byw8lmMr9VKJ6dz6TwNDEOSrWugGtgjjNSIfTvRH7xq5yBosgL3i0j2qv1T6QY6lvA/1WTPsfx8U1Lm8HzGjWRrp42j3MGWM1vereXtBkYcdwWznE5VuEJ+KTw3tJGg144n0kbG+a8wAYFDuz6m67hWzkxNhMXmqPa9HuZQ6Db+A7Az86LsCSmfu+WViA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(396003)(136003)(346002)(39860400002)(186009)(1800799009)(451199024)(82310400011)(40470700004)(46966006)(36840700001)(54906003)(6916009)(316002)(70586007)(70206006)(66899024)(8676002)(8936002)(2616005)(4326008)(36756003)(40460700003)(41300700001)(1076003)(356005)(82740400003)(81166007)(478600001)(6666004)(40480700001)(83380400001)(2906002)(47076005)(7696005)(36860700001)(86362001)(426003)(336012)(5660300002)(26005)(16526019)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2023 15:51:23.2726 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: da9bfa05-f2a9-43a6-830d-08dba3f0cd43
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE32.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8214
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Qingqing Zhuo <Qingqing.Zhuo@amd.com>, Harry Wentland <Harry.Wentland@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Qingqing Zhuo <Qingqing.Zhuo@amd.com>

[Why & How]
Add MMHUBBUB handling for DCN35.

Signed-off-by: Qingqing Zhuo <Qingqing.Zhuo@amd.com>
Acked-by: Harry Wentland <Harry.Wentland@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 .../drm/amd/display/dc/dcn35/dcn35_mmhubbub.c | 57 +++++++++++++++
 .../drm/amd/display/dc/dcn35/dcn35_mmhubbub.h | 73 +++++++++++++++++++
 2 files changed, 130 insertions(+)
 create mode 100644 drivers/gpu/drm/amd/display/dc/dcn35/dcn35_mmhubbub.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/dcn35/dcn35_mmhubbub.h

diff --git a/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_mmhubbub.c b/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_mmhubbub.c
new file mode 100644
index 000000000000..ea1042cdc88d
--- /dev/null
+++ b/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_mmhubbub.c
@@ -0,0 +1,57 @@
+/* SPDX-License-Identifier: MIT */
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
+#include "dcn35_mmhubbub.h"
+#include "reg_helper.h"
+
+#define REG(reg)                                                             \
+	((const struct dcn35_mmhubbub_registers *)(mcif_wb30->mcif_wb_regs)) \
+		->reg
+
+#define CTX mcif_wb30->base.ctx
+
+#undef FN
+#define FN(reg_name, field_name)                                                \
+	((const struct dcn35_mmhubbub_shift *)(mcif_wb30->mcif_wb_shift))       \
+		->field_name,                                                   \
+		((const struct dcn35_mmhubbub_mask *)(mcif_wb30->mcif_wb_mask)) \
+			->field_name
+
+void dcn35_mmhubbub_construct(
+	struct dcn30_mmhubbub *mcif_wb30, struct dc_context *ctx,
+	const struct dcn35_mmhubbub_registers *mcif_wb_regs,
+	const struct dcn35_mmhubbub_shift *mcif_wb_shift,
+	const struct dcn35_mmhubbub_mask *mcif_wb_mask, int inst)
+{
+	dcn32_mmhubbub_construct(
+		mcif_wb30, ctx,
+		(const struct dcn30_mmhubbub_registers *)(mcif_wb_regs),
+		(const struct dcn30_mmhubbub_shift *)(mcif_wb_shift),
+		(const struct dcn30_mmhubbub_mask *)(mcif_wb_mask), inst);
+}
+
+void dcn35_mmhubbub_set_fgcg(struct dcn30_mmhubbub *mcif_wb30, bool enabled)
+{
+	REG_UPDATE(MMHUBBUB_CLOCK_CNTL, MMHUBBUB_FGCG_REP_DIS, !enabled);
+}
diff --git a/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_mmhubbub.h b/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_mmhubbub.h
new file mode 100644
index 000000000000..e7b5b6703e73
--- /dev/null
+++ b/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_mmhubbub.h
@@ -0,0 +1,73 @@
+/* SPDX-License-Identifier: MIT */
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
+#ifndef __DCN35_MMHUBBUB_H
+#define __DCN35_MMHUBBUB_H
+
+#include "mcif_wb.h"
+#include "dcn32/dcn32_mmhubbub.h"
+
+#define MCIF_WB_REG_VARIABLE_LIST_DCN3_5  \
+	MCIF_WB_REG_VARIABLE_LIST_DCN3_0; \
+	uint32_t MMHUBBUB_CLOCK_CNTL
+
+#define MCIF_WB_COMMON_MASK_SH_LIST_DCN3_5(mask_sh)                            \
+	MCIF_WB_COMMON_MASK_SH_LIST_DCN32(mask_sh),                            \
+		SF(MMHUBBUB_CLOCK_CNTL, MMHUBBUB_TEST_CLK_SEL, mask_sh),       \
+		SF(MMHUBBUB_CLOCK_CNTL, DISPCLK_R_MMHUBBUB_GATE_DIS, mask_sh), \
+		SF(MMHUBBUB_CLOCK_CNTL, DISPCLK_G_WBIF0_GATE_DIS, mask_sh),    \
+		SF(MMHUBBUB_CLOCK_CNTL, SOCCLK_G_WBIF0_GATE_DIS, mask_sh),     \
+		SF(MMHUBBUB_CLOCK_CNTL, MMHUBBUB_FGCG_REP_DIS, mask_sh)
+
+#define MCIF_WB_REG_FIELD_LIST_DCN3_5(type)          \
+	struct {                                     \
+		MCIF_WB_REG_FIELD_LIST_DCN3_0(type); \
+		type MMHUBBUB_TEST_CLK_SEL;          \
+		type DISPCLK_R_MMHUBBUB_GATE_DIS;    \
+		type DISPCLK_G_WBIF0_GATE_DIS;       \
+		type SOCCLK_G_WBIF0_GATE_DIS;        \
+		type MMHUBBUB_FGCG_REP_DIS;          \
+	}
+
+struct dcn35_mmhubbub_registers {
+	MCIF_WB_REG_VARIABLE_LIST_DCN3_5;
+};
+
+struct dcn35_mmhubbub_mask {
+	MCIF_WB_REG_FIELD_LIST_DCN3_5(uint32_t);
+};
+
+struct dcn35_mmhubbub_shift {
+	MCIF_WB_REG_FIELD_LIST_DCN3_5(uint8_t);
+};
+
+void dcn35_mmhubbub_construct(
+	struct dcn30_mmhubbub *mcif_wb30, struct dc_context *ctx,
+	const struct dcn35_mmhubbub_registers *mcif_wb_regs,
+	const struct dcn35_mmhubbub_shift *mcif_wb_shift,
+	const struct dcn35_mmhubbub_mask *mcif_wb_mask, int inst);
+
+void dcn35_mmhubbub_set_fgcg(struct dcn30_mmhubbub *mcif_wb30, bool enabled);
+
+#endif // __DCN35_MMHUBBUB_H
-- 
2.41.0

