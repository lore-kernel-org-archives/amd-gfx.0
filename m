Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D997DEE49B0
	for <amd-gfx@archiver.kernel.org>; Wed, 23 Aug 2023 15:51:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5CD9810E449;
	Wed, 23 Aug 2023 15:51:33 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2058.outbound.protection.outlook.com [40.107.94.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 95C8910E444
 for <amd-gfx@lists.freedesktop.org>; Wed, 23 Aug 2023 15:51:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZqSnVxBmUC+VQqnK4LupWc3Jd4zFPVQ7CHR6NlP4VyTuqub7fvdAA+lY12fM2Aa7Kvz6BBxNM5EM4K3KlLJ7ht//V4XIojqUjUDXZVEZYUR605AZuMWwN8ZKpk9hOHGyFJm8LqevKu7fFQJoxNIZ5JenjpzG2vMpmGFyH2bOA6BrzHJNPYnb4QIV2qJ5WechVX+h1txMzVA35iUqmG8EqQtf0ZtjfZkg/nIuoZ++yWhqxLS91VnhsYvFb50nrYz+dO+zeSXhXcSo3g2tFxlh+E2d5e8s7V+R/8uADxQKtfVd5++vttu1TeXzmXo7vkr0y6KFshPjvYEVUSpO8LfFkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Nmh531Iuy+/e75ykQiA+UWrLhW0R7pthM8urGtKEsI0=;
 b=g0qNxNWmxrCJW+rMK19U3M1kOUae7FuUMO6P+cKpfWVxej1125vuC7Ijcd1NSUk+T1ajckXgT+ruab2+vOsjGng/Rz76tqBO0Y6dP6aEaWEIxhSX1nkjYyGF+ZX3bhkGb5aJZW+aDrR8CWIFsoyEGh6jVi0Has3H2mckSKMmzWf32A6I5ANjwrfqPte+GzfVEkEBP2UaXN6UvE/t5EVuY8rlrBHq/WCW33wWlIoTkdy7WCujEcdjmCbd+vchELL4cKtUBSxCASJ10cJZveScu5QrUtJW5EeRzNDJIWizXK3q+6cNkSSWKTKYRSwblalCwbFfQfCBCBRM6uvn/R0Cog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nmh531Iuy+/e75ykQiA+UWrLhW0R7pthM8urGtKEsI0=;
 b=mEPDpVzm3HcWSMfc4ojV+WjD+NoR6cpHANW116TP0fFocVUuljPcOheXySckEnuSsuCB9hV6dXZ++5aHruJsjvGkYf/In5kxy9WcOe30LmKZKwOj9QwIQlvJPXA2NuHNN6L+yc81+IoiQrUmCEhnwdCMIDnl4rOXoryNZ385iDY=
Received: from CY5PR18CA0046.namprd18.prod.outlook.com (2603:10b6:930:13::8)
 by DM8PR12MB5464.namprd12.prod.outlook.com (2603:10b6:8:3d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.26; Wed, 23 Aug
 2023 15:51:18 +0000
Received: from CY4PEPF0000EE32.namprd05.prod.outlook.com
 (2603:10b6:930:13:cafe::7a) by CY5PR18CA0046.outlook.office365.com
 (2603:10b6:930:13::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.26 via Frontend
 Transport; Wed, 23 Aug 2023 15:51:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE32.mail.protection.outlook.com (10.167.242.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.15 via Frontend Transport; Wed, 23 Aug 2023 15:51:18 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 23 Aug
 2023 10:51:15 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 20/35] drm/amd/display: Add DCN35 DWB
Date: Wed, 23 Aug 2023 11:50:33 -0400
Message-ID: <20230823155048.2526343-20-alexander.deucher@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE32:EE_|DM8PR12MB5464:EE_
X-MS-Office365-Filtering-Correlation-Id: 4068801b-f828-467f-f2ba-08dba3f0ca69
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: k99hFnmkELBdUiAPWBOaZui9pSzY/gN7xJCjwPXEDbsCFrYWDqC93REP7f6PzUyfWboe4d4o4olp6bDR+RRZN2UvDVAkCtB3qhKs9sDA67Z5CyXxtQ8bIX1T9J1x2SUmGWlS3BhiufIKDLRhq6VjS/PTaPANucnhk6x9HhSZ74VqIl+jlWtL0ed+eOO6jU4HRy0I7Wge6Np6xOTnMdNajfA9Au9SOI3SZfJNSWDAlp3bkvDkwq7xuK3HoMnIDS25WQAB7TSLfZHnDcr7bwyXlZasj7HEy95p7dBA18IAuTQ3uRdCKl8yZEm08RvMacYx59DHT+WXDj1TgJ0oXf5fARb1kTzNVGujhZ3myMY4gHwS1LAcDT6tqUh4k+eqKki7SwUqFn0plv4uF9v8V8MePhS7kjkx+qRJc2Hbjjh0udbjwk2QYYfQ3usXfJDEaDmEhpSttlh9lyzwYF8J4ovwEwuevFntuJiP2s8HpQRLRKtxcu4m/Cmoniou+XjK+p6fcS28yfxpu2y1nD3byttpipZm3rLevMvEqoVgi8EiSglw7eEyxahJsVtGksf5HqrBSJLq1pTf08guohnf8qYu7pU2iD6LXC0bm+5LLHudfeWZqZ7VAnj9OBRon8VKdhtw3Gj6wa+5a4nmqzghxhAMHim2ddTcu7K+3xnJLRgl4C0cZYlinzYvR3VFl0oCGU1phw52J9tfT9dmXUWmsB/3Lbpet/A6zaDyoRvvwmNDCsaGz+GBdwhxr6jaTKFawhzKrvwm/2I2oC4qhGDJU8OyjQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(136003)(396003)(376002)(346002)(186009)(451199024)(1800799009)(82310400011)(40470700004)(46966006)(36840700001)(2616005)(7696005)(316002)(6916009)(4326008)(8936002)(8676002)(40480700001)(70586007)(54906003)(70206006)(41300700001)(336012)(426003)(16526019)(26005)(1076003)(5660300002)(6666004)(478600001)(83380400001)(40460700003)(47076005)(36860700001)(66899024)(36756003)(86362001)(2906002)(82740400003)(356005)(81166007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2023 15:51:18.5382 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4068801b-f828-467f-f2ba-08dba3f0ca69
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE32.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR12MB5464
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
Add DWB handling for DCN35.

Signed-off-by: Qingqing Zhuo <Qingqing.Zhuo@amd.com>
Acked-by: Harry Wentland <Harry.Wentland@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 .../gpu/drm/amd/display/dc/dcn35/dcn35_dwb.c  | 58 ++++++++++++++++++
 .../gpu/drm/amd/display/dc/dcn35/dcn35_dwb.h  | 59 +++++++++++++++++++
 2 files changed, 117 insertions(+)
 create mode 100644 drivers/gpu/drm/amd/display/dc/dcn35/dcn35_dwb.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/dcn35/dcn35_dwb.h

diff --git a/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_dwb.c b/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_dwb.c
new file mode 100644
index 000000000000..b23a809999ed
--- /dev/null
+++ b/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_dwb.c
@@ -0,0 +1,58 @@
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
+#include "reg_helper.h"
+#include "dcn35_dwb.h"
+
+#define REG(reg)\
+	dwbc30->dwbc_regs->reg
+
+#define CTX \
+	dwbc30->base.ctx
+
+#undef FN
+#define FN(reg_name, field_name)                                             \
+	((const struct dcn35_dwbc_shift *)(dwbc30->dwbc_shift))->field_name, \
+		((const struct dcn35_dwbc_mask *)(dwbc30->dwbc_mask))        \
+			->field_name
+
+#define DC_LOGGER \
+	dwbc30->base.ctx->logger
+
+void dcn35_dwbc_construct(struct dcn30_dwbc *dwbc30,
+	struct dc_context *ctx,
+	const struct dcn30_dwbc_registers *dwbc_regs,
+	const struct dcn35_dwbc_shift *dwbc_shift,
+	const struct dcn35_dwbc_mask *dwbc_mask,
+	int inst)
+{
+	dcn30_dwbc_construct(dwbc30, ctx, dwbc_regs,
+			     (const struct dcn30_dwbc_shift *)dwbc_shift,
+			     (const struct dcn30_dwbc_mask *)dwbc_mask, inst);
+}
+
+void dcn35_dwbc_set_fgcg(struct dcn30_dwbc *dwbc30, bool enable)
+{
+	REG_UPDATE(DWB_ENABLE_CLK_CTRL, DWB_FGCG_REP_DIS, !enable);
+}
diff --git a/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_dwb.h b/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_dwb.h
new file mode 100644
index 000000000000..877f93c8168e
--- /dev/null
+++ b/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_dwb.h
@@ -0,0 +1,59 @@
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
+#ifndef __DCN35_DWB_H
+#define __DCN35_DWB_H
+
+#include "resource.h"
+#include "dwb.h"
+#include "dcn30/dcn30_dwb.h"
+
+#define DWBC_COMMON_MASK_SH_LIST_DCN35(mask_sh) \
+	DWBC_COMMON_MASK_SH_LIST_DCN30(mask_sh), \
+	SF_DWB2(DWB_ENABLE_CLK_CTRL, DWB_TOP, 0, DWB_FGCG_REP_DIS, mask_sh)
+
+#define DWBC_REG_FIELD_LIST_DCN3_5(type)          \
+	struct {                                  \
+		DWBC_REG_FIELD_LIST_DCN3_0(type); \
+		type DWB_FGCG_REP_DIS;            \
+	}
+
+struct dcn35_dwbc_mask {
+	DWBC_REG_FIELD_LIST_DCN3_5(uint32_t);
+};
+
+struct dcn35_dwbc_shift {
+	DWBC_REG_FIELD_LIST_DCN3_5(uint8_t);
+};
+
+void dcn35_dwbc_construct(struct dcn30_dwbc *dwbc30,
+	struct dc_context *ctx,
+	const struct dcn30_dwbc_registers *dwbc_regs,
+	const struct dcn35_dwbc_shift *dwbc_shift,
+	const struct dcn35_dwbc_mask *dwbc_mask,
+	int inst);
+
+void dcn35_dwbc_set_fgcg(struct dcn30_dwbc *dwbc30, bool enable);
+
+#endif
-- 
2.41.0

