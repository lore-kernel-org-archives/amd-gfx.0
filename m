Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1AFFEE49B7
	for <amd-gfx@archiver.kernel.org>; Wed, 23 Aug 2023 15:52:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A284810E458;
	Wed, 23 Aug 2023 15:52:02 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2056.outbound.protection.outlook.com [40.107.94.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 48CA910E43B
 for <amd-gfx@lists.freedesktop.org>; Wed, 23 Aug 2023 15:51:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IrhDdm0Jt1Adyv/ii/0QFv4M1boHVgVehqqKz0uyL1yDM5RoqOgU5B0TUAcjfT6xYALXT6iim+gggPc2XYJ4Zc1EIcgzySfw8vyYOh/PQjJ57T3XzRjLztTxdPRv03vjSh3qn7fFlsnHyCyIesbPrqPjcBiduBkK1ZmMLjgGt2ECI2K50yzRCj7ZcF7tRSSToiESCR/R67TeNerqaATgCvMqn/S1nj6bWtgeNsZCDrlnEamixN2fRngqLQmcO45xSobMpfcbfYPfa8h+jStTc+HO6wJJYatl54rnhjqPAwhiW4IUmJtl7gtzEsjzUt442a1K1XbtE/iuxfJyJcnCNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8wzpNHi22oO/B0yNwNcINLKUA+YaInjrpWs2WsYFWlA=;
 b=DqeD+bitmOlpHztHkhil4OQxuOSCu/HAMfA/RFakZaYoxzyPTQJsAVs3cBkd8nW51P7/SCsCGeG/FKRbA/nrM2raLSyenJh088PzUSEcaAOX6e/iO4CARSnet4yQf6AWnTZ84Xxd/E+hkWrdTuGOuZOCHU/xrK7CC1ETFR7wggVNXw+I6r1C53x46CSOVGJqlFR3w2SRo4bj8T7mtmYFxGxb2RnozsgSSw+kOio+zDMA3Vm4HAu6fsJldsR6QDHkef2KSaUz0t3+IqIpB61sJyed7cB7zqbpGo/lWSP5sID66sDE3OhvkiRgFlDWFMUG1z+FMm6Nb/HbYKlC2my1fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8wzpNHi22oO/B0yNwNcINLKUA+YaInjrpWs2WsYFWlA=;
 b=iyOkFUTjs/URNamD9Cssj2IsGYLi1nwTYdhI5BdTVvIXmBXcWlLe0gk8JXghwRL51tSrWEVqOg9wgHhc3tjtjnCv31ViV5jhaYAJIq2g/Whk7+0aBfJx/Db8AutKKGx5hKINiiSziSWvDpFGmBmrdOkeglQTjdBZW9fh7SbbcGk=
Received: from CY5PR18CA0041.namprd18.prod.outlook.com (2603:10b6:930:13::19)
 by PH0PR12MB8149.namprd12.prod.outlook.com (2603:10b6:510:297::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.26; Wed, 23 Aug
 2023 15:51:24 +0000
Received: from CY4PEPF0000EE32.namprd05.prod.outlook.com
 (2603:10b6:930:13:cafe::f9) by CY5PR18CA0041.outlook.office365.com
 (2603:10b6:930:13::19) with Microsoft SMTP Server (version=TLS1_2,
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
 2023 10:51:18 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 24/35] drm/amd/display: Add DCN35 DSC
Date: Wed, 23 Aug 2023 11:50:37 -0400
Message-ID: <20230823155048.2526343-24-alexander.deucher@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE32:EE_|PH0PR12MB8149:EE_
X-MS-Office365-Filtering-Correlation-Id: 41abb7d8-21ec-49be-947e-08dba3f0cd75
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oQCPxkIorjw8ykSlr4iXB+PBzhU9dFObpusSK9CtgA5FyCru+FPjoJhe9FeD3ayAomOpPEUc3gzke9pMgZpPPjduBJwa7EMCgZGyBbMPqQzltK05eKUOQn8SaegVoh8PDB4cMUQy6R+aqTXjmX8GjfJsCf8sr5KzeKH6dNOhUezVmOkx/JrIKkwIg+Zj8iSF57Dgv6kIPdDhN+gvLo8pjzjZrLiyH7Wbwl/eE+0XDiAKaZEvv466TT8K5Goa9gFKQ9czrFGPeXiNnZE+tnvfka+uED3YQNTnnhCw/Kcy/N1UXzYsqpVdUotaSPrysZc2padeNfEWoAgagypAVSVkqImZCKcgt43oMz0aEzxyFfswjwCXODm4alGjdTlWFGkjuMj73V1Qa6JoTy4DvtZ6Eo/44jsqa+9lw+npubDzMTHkOpVrnrDslNG+SPzlns6ltNhQz4e4NPYRzz25qWtIydfoZy+ZU1ptWqBVW2mxC+rp6cpMU/0W3QC6PuoT0L/Hg131UExl4xPZPo0/Qu+39cW7h8AiucferwQgWtM3nRrOYv3eSVdi/kPAsrM0pYmCbZoCxjzWfTrF0I19bX7LvX5CVDitXnPTQgmsBOKZfTNKt3VcafKYFetAaixTGxbwPX6sBI7+cP4/KJ9w3+x8rxVkAiK3ccOYHJng9rsnQaq2oe6OUHiFuutf1e57lgPQIhX44IPsg86S2x3iJPIWUDc/AvUlZ+BRTNoAJUgHMgPt86jdh2ricKoC0YtSeH0+eY5MwbHnfmUaoiC3G+pGgg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(346002)(376002)(136003)(39860400002)(186009)(451199024)(1800799009)(82310400011)(40470700004)(46966006)(36840700001)(2616005)(7696005)(6916009)(316002)(4326008)(8676002)(8936002)(40480700001)(54906003)(70586007)(70206006)(41300700001)(1076003)(26005)(16526019)(336012)(426003)(5660300002)(6666004)(478600001)(83380400001)(40460700003)(47076005)(36860700001)(66899024)(86362001)(36756003)(2906002)(82740400003)(81166007)(356005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2023 15:51:23.6476 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 41abb7d8-21ec-49be-947e-08dba3f0cd75
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE32.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8149
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
Add DSC handling for DCN35.

Signed-off-by: Qingqing Zhuo <Qingqing.Zhuo@amd.com>
Acked-by: Harry Wentland <Harry.Wentland@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 .../gpu/drm/amd/display/dc/dcn35/dcn35_dsc.c  | 58 +++++++++++++++++++
 .../gpu/drm/amd/display/dc/dcn35/dcn35_dsc.h  | 57 ++++++++++++++++++
 2 files changed, 115 insertions(+)
 create mode 100644 drivers/gpu/drm/amd/display/dc/dcn35/dcn35_dsc.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/dcn35/dcn35_dsc.h

diff --git a/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_dsc.c b/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_dsc.c
new file mode 100644
index 000000000000..d7915c96bcd1
--- /dev/null
+++ b/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_dsc.c
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
+#include "dcn35_dsc.h"
+#include "reg_helper.h"
+
+/* Macro definitios for REG_SET macros*/
+#define CTX \
+	dsc20->base.ctx
+
+#define REG(reg)\
+	dsc20->dsc_regs->reg
+
+#undef FN
+#define FN(reg_name, field_name)                                          \
+	((const struct dcn35_dsc_shift *)(dsc20->dsc_shift))->field_name, \
+		((const struct dcn35_dsc_mask *)(dsc20->dsc_mask))->field_name
+
+#define DC_LOGGER \
+	dsc->ctx->logger
+
+void dsc35_construct(struct dcn20_dsc *dsc,
+		struct dc_context *ctx,
+		int inst,
+		const struct dcn20_dsc_registers *dsc_regs,
+		const struct dcn35_dsc_shift *dsc_shift,
+		const struct dcn35_dsc_mask *dsc_mask)
+{
+	dsc2_construct(dsc, ctx, inst, dsc_regs,
+		(const struct dcn20_dsc_shift *)(dsc_shift),
+		(const struct dcn20_dsc_mask *)(dsc_mask));
+}
+
+void dsc35_set_fgcg(struct dcn20_dsc *dsc20, bool enable)
+{
+	REG_UPDATE(DSC_TOP_CONTROL, DSC_FGCG_REP_DIS, !enable);
+}
diff --git a/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_dsc.h b/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_dsc.h
new file mode 100644
index 000000000000..c19c2e022f12
--- /dev/null
+++ b/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_dsc.h
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
+#ifndef __DCN35_DSC_H__
+#define __DCN35_DSC_H__
+
+#include "dcn20/dcn20_dsc.h"
+
+#define DSC_REG_LIST_SH_MASK_DCN35(mask_sh)  \
+	DSC_REG_LIST_SH_MASK_DCN20(mask_sh), \
+		DSC_SF(DSC_TOP0_DSC_TOP_CONTROL, DSC_FGCG_REP_DIS, mask_sh)
+
+#define DSC_FIELD_LIST_DCN35(type)          \
+	struct {                            \
+		DSC_FIELD_LIST_DCN20(type); \
+		type DSC_FGCG_REP_DIS;      \
+	}
+
+struct dcn35_dsc_shift {
+	DSC_FIELD_LIST_DCN35(uint8_t);
+};
+
+struct dcn35_dsc_mask {
+	DSC_FIELD_LIST_DCN35(uint32_t);
+};
+
+void dsc35_construct(struct dcn20_dsc *dsc,
+		struct dc_context *ctx,
+		int inst,
+		const struct dcn20_dsc_registers *dsc_regs,
+		const struct dcn35_dsc_shift *dsc_shift,
+		const struct dcn35_dsc_mask *dsc_mask);
+
+void dsc35_set_fgcg(struct dcn20_dsc *dsc20, bool enable);
+
+#endif /* __DCN35_DSC_H__ */
-- 
2.41.0

