Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D366EE49B0
	for <amd-gfx@archiver.kernel.org>; Wed, 23 Aug 2023 15:51:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8852810E446;
	Wed, 23 Aug 2023 15:51:34 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2048.outbound.protection.outlook.com [40.107.96.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5D6FC10E43B
 for <amd-gfx@lists.freedesktop.org>; Wed, 23 Aug 2023 15:51:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XgIvTfIqQq3yMQcGZr69EkQ9aFbxG7R5kRJNbXNxPIRpm93XYLsT7aNDCW1KZNrooqKnV0mE8RCWOA7ySYwJPkJopHB+Jlo1+BnfkKHXkUf/sBxtNJdya6Sxdlxyf8VEMN1OghK6uY4To7Flbq1UD00YCFk8O+u0wI9LTDvjfPcSB3KuVZnhLzotN2qPmkm7ztgczXcrMOUDFZruIRdWYOfFkn9/+ZBHeOaYYCtZ/Gc0cXHcIc20I7T+AMXR8AQ/0C6x8adicRfrgN6wZjBNScuu00+t6dbw9uuvY6MXJX851deFHLywOkZmGoRvE2StWFy3QqR6B/aZsesZ6LG+9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L1pSJoX0r1w+q5cN+vLULfX13yei7Ht0AQzA6hgpuuM=;
 b=eHZZoz4uFZbiG38k8910zUrKU4LQJQT0OBFzZyJ7j7qADEVwkrmzM3Aw6HAR6sH03AW+0GzEPoLnr/z9JH2yXCP3jiLEdmO9aZD5iqwed4dvAmAkJje1R6kd9aGwkMfZYoRK3yeJQ63EnxNZOuZoTNkaNEiCBbdP0aYoqiYKX+rTWpxnk0a2frxxAYpUdoaFK0UEmF2rX+SIjhUT11a882sjZYur9oZ7MXZjE8prtFUzIq0vE8fRxI/LieLn4ui8EyboTDHFDyf5+bAduYW5wFr3yzlxHxNRDrpUYGdI21/vK2/99nmjZ5etdsPboA1GyEDtPgzDYJnjq22GmR1uRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L1pSJoX0r1w+q5cN+vLULfX13yei7Ht0AQzA6hgpuuM=;
 b=gw+PrO29r/UV+2OhwJt+hkUfKKXaPMCBZH+S7ajHJAeHaz+0JCaAEV+3TrQ26ObmtuQLogVBjEjHdr9KbZKIR5Dy3rkr19Uipo4jmUamdzmx30V8v8VXX/vHknqPztVC9AZCS+u9Rn1dIRhZqhD+Rxyl6LVeiTbYmViz3/q0CPg=
Received: from CY5PR18CA0057.namprd18.prod.outlook.com (2603:10b6:930:13::6)
 by DM6PR12MB4532.namprd12.prod.outlook.com (2603:10b6:5:2af::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.25; Wed, 23 Aug
 2023 15:51:17 +0000
Received: from CY4PEPF0000EE32.namprd05.prod.outlook.com
 (2603:10b6:930:13:cafe::e6) by CY5PR18CA0057.outlook.office365.com
 (2603:10b6:930:13::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.26 via Frontend
 Transport; Wed, 23 Aug 2023 15:51:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE32.mail.protection.outlook.com (10.167.242.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.15 via Frontend Transport; Wed, 23 Aug 2023 15:51:17 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 23 Aug
 2023 10:51:14 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 18/35] drm/amd/display: Add DCN35 OPP
Date: Wed, 23 Aug 2023 11:50:31 -0400
Message-ID: <20230823155048.2526343-18-alexander.deucher@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE32:EE_|DM6PR12MB4532:EE_
X-MS-Office365-Filtering-Correlation-Id: f8c1cf7f-f134-42c5-71b9-08dba3f0c9a6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ef8ITOvbzFFUoI4iH51rpg81zqnXhEaoUc5yKtadBUiLbODrmsrR35c+8IlUqtVfDsM+PSc+7g+LxWX8i9O2ctHXPitsnarNrXhRH6NMdhwhwXY3JwPz1nEI/IDw0EOKSPEjtMqYI1Phn1cfue2Fzml3k35awnE9fvmPW/NtHt2umjvBCs5KOkq1y4FOJ6659rk2AVZtHFcChS3iIVaYNX8JUg+EgfwL338CW8HE6BT+erB+cW7vpJi6ZF5vlzxE6vTekYOl6wzwx7iLW3ghMZdew8zom9d6lNHvDNaH8A8N659hjK9TiTDbiL7Ozw9wx1BSWX66zjI0GWJdlkovKp0B6PoUsD552o926THYlnqBnfye3o2sLCUhjKngD+94Xh2hg48U3M0C6YNSIvheJka2rJfFc+4/7OLNQdu761mm2y9sEO6xov8VKpSh8oy4Wl0pYQCImcre1ESGGP7gOtRBU/WdjLhiTA9qrkJ9wndW9Mdc6r3KGMK3y1UUwKSQy3KXP5jc41nWW88y4Gp9EQMGV9XgkwQgZCXIA7JM1qa6vmgHj+peKiRSySucdwnC9Ttyx9CAzh1/h77OlqJ/HOcDYORJqL0GzThiOE8i4AqjZ8U9nmg3/QQi70bKT0KSIAeYq6fpjoX7LYycqBm0eRvLf5aJms38ET/k+JixujmOygePrljcFFtf/SxI91ulE8GhcqSZFRNytIYEhEjvrwtOeSWmzf57rFCppquQC9IY0evyA0wWyp4syZcn+TlJ7HeN+Q46kcW99SZh+CIrNw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(136003)(346002)(396003)(39860400002)(186009)(451199024)(1800799009)(82310400011)(46966006)(40470700004)(36840700001)(70206006)(70586007)(54906003)(6666004)(8676002)(4326008)(8936002)(7696005)(36860700001)(26005)(16526019)(2616005)(478600001)(316002)(41300700001)(5660300002)(1076003)(6916009)(426003)(336012)(83380400001)(66899024)(40460700003)(2906002)(36756003)(40480700001)(47076005)(81166007)(356005)(82740400003)(86362001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2023 15:51:17.2570 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f8c1cf7f-f134-42c5-71b9-08dba3f0c9a6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE32.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4532
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
Add OPP handling for DCN35.

Signed-off-by: Qingqing Zhuo <Qingqing.Zhuo@amd.com>
Acked-by: Harry Wentland <Harry.Wentland@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 .../gpu/drm/amd/display/dc/dcn35/dcn35_opp.c  | 51 +++++++++++++++
 .../gpu/drm/amd/display/dc/dcn35/dcn35_opp.h  | 65 +++++++++++++++++++
 2 files changed, 116 insertions(+)
 create mode 100644 drivers/gpu/drm/amd/display/dc/dcn35/dcn35_opp.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/dcn35/dcn35_opp.h

diff --git a/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_opp.c b/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_opp.c
new file mode 100644
index 000000000000..d79e8c6365c1
--- /dev/null
+++ b/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_opp.c
@@ -0,0 +1,51 @@
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
+#include "dcn35_opp.h"
+#include "reg_helper.h"
+
+#define REG(reg) ((const struct dcn35_opp_registers *)(oppn20->regs))->reg
+
+#undef FN
+#define FN(reg_name, field_name)                                           \
+	((const struct dcn35_opp_shift *)(oppn20->opp_shift))->field_name, \
+		((const struct dcn35_opp_mask *)(oppn20->opp_mask))->field_name
+
+#define CTX oppn20->base.ctx
+
+void dcn35_opp_construct(struct dcn20_opp *oppn20, struct dc_context *ctx,
+			 uint32_t inst, const struct dcn35_opp_registers *regs,
+			 const struct dcn35_opp_shift *opp_shift,
+			 const struct dcn35_opp_mask *opp_mask)
+{
+	dcn20_opp_construct(oppn20, ctx, inst,
+			    (const struct dcn20_opp_registers *)regs,
+			    (const struct dcn20_opp_shift *)opp_shift,
+			    (const struct dcn20_opp_mask *)opp_mask);
+}
+
+void dcn35_opp_set_fgcg(struct dcn20_opp *oppn20, bool enable)
+{
+	REG_UPDATE(OPP_TOP_CLK_CONTROL, OPP_FGCG_REP_DIS, !enable);
+}
diff --git a/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_opp.h b/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_opp.h
new file mode 100644
index 000000000000..9dd21b104287
--- /dev/null
+++ b/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_opp.h
@@ -0,0 +1,65 @@
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
+#ifndef __DCN35_OPP_H
+#define __DCN35_OPP_H
+
+#include "dcn20/dcn20_opp.h"
+
+#define OPP_REG_VARIABLE_LIST_DCN3_5  \
+	OPP_REG_VARIABLE_LIST_DCN2_0; \
+	uint32_t OPP_TOP_CLK_CONTROL
+
+#define OPP_MASK_SH_LIST_DCN35(mask_sh)  \
+	OPP_MASK_SH_LIST_DCN20(mask_sh), \
+		OPP_SF(OPP_TOP_CLK_CONTROL, OPP_FGCG_REP_DIS, mask_sh)
+
+#define OPP_DCN35_REG_FIELD_LIST(type)          \
+	struct {                                \
+		OPP_DCN20_REG_FIELD_LIST(type); \
+		type OPP_FGCG_REP_DIS;          \
+	}
+
+struct dcn35_opp_registers {
+	OPP_REG_VARIABLE_LIST_DCN3_5;
+};
+
+struct dcn35_opp_shift {
+	OPP_DCN35_REG_FIELD_LIST(uint8_t);
+};
+
+struct dcn35_opp_mask {
+	OPP_DCN35_REG_FIELD_LIST(uint32_t);
+};
+
+void dcn35_opp_construct(struct dcn20_opp *oppn20,
+	struct dc_context *ctx,
+	uint32_t inst,
+	const struct dcn35_opp_registers *regs,
+	const struct dcn35_opp_shift *opp_shift,
+	const struct dcn35_opp_mask *opp_mask);
+
+void dcn35_opp_set_fgcg(struct dcn20_opp *oppn20, bool enable);
+
+#endif
-- 
2.41.0

