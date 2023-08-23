Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7341EE49B5
	for <amd-gfx@archiver.kernel.org>; Wed, 23 Aug 2023 15:51:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1352310E448;
	Wed, 23 Aug 2023 15:51:33 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2045.outbound.protection.outlook.com [40.107.244.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2C0EB10E43E
 for <amd-gfx@lists.freedesktop.org>; Wed, 23 Aug 2023 15:51:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BhUgseLghf98iXcp6WT0au/jkjBsIA5X9mE6NOENpjq6GI6zMzsFmDN2QAE5fFRhlh/WC6HR8Jm7k6Vt47XQZyvUKsAqJa35MsL2nx4eAM6507S83dKwdreMRxoQLMFaw9Vn4RwxEW6CAIx24jZ4GTITde7EaC/OeLQbkBO+WBEpBB3qyLRfL7Wj6N9bPDlGDJUJ6pfBEaz0KuEUYuDga1GNcGzeBVRi7Hmznfae45ciZczTBl95e/grRs+oBU6wh0uYyxtBK+ezjQPqZMft6geFCADfuLuw19WBkKuxiKAAafasRVnHRkz9OnjKyaSL/Rl4ZZ38bFrYP/a/A4388A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x5qvfN6Utj0pNnTfAHuj8L2Ca6rr/krOf7VxzlK+s1Q=;
 b=X59PKrcY+znZMNw1haOue8pL2u5DIv0m3Saa7IeUv61DRKIbtZslX8ihKsxqV9KVdAdH62k1XrLAP4AWt6Vldv8020VLQ9V1tp/vdA5yaxikIXRIpF+GP7A1MmcAXI9Gok0LsDnWuTkOXXgGoqgBKa0eRVNtwChgyNdlZwAbBJLtYXe/prSs0IX08/C3s+bg88sYvu+YbrqDnjI38nPkBdxzJC047SQK7YDqKrDM8q4/mIhugSkzILJTx5ErY6+ISgKe8K0NX7KSAFHTTH1vs1vDvHEU59czRuLERieAz/aPIhXMbcxK+c38MSyXaxnAZ/AUhhrefR1oa/JpYvmcBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x5qvfN6Utj0pNnTfAHuj8L2Ca6rr/krOf7VxzlK+s1Q=;
 b=kH86089cW+EszCrRe3tJSSbSPjfenEdtb6mZ5f9R2q1EP3ZqA2WBWNZuJjvgMe/5ogR2/YraHBs/sIABGGu3mKysMbucRZGaOSZlO5vpGYdyBz8SRcwGnZ1mS+0v7TDv/rgu5XwM3LmcXDCgQiV+4yQK6QNYqkrwtnwicf+QBZQ=
Received: from DM6PR21CA0014.namprd21.prod.outlook.com (2603:10b6:5:174::24)
 by CY5PR12MB6453.namprd12.prod.outlook.com (2603:10b6:930:37::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.24; Wed, 23 Aug
 2023 15:51:15 +0000
Received: from CY4PEPF0000EE37.namprd05.prod.outlook.com
 (2603:10b6:5:174:cafe::ac) by DM6PR21CA0014.outlook.office365.com
 (2603:10b6:5:174::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.7 via Frontend
 Transport; Wed, 23 Aug 2023 15:51:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE37.mail.protection.outlook.com (10.167.242.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.15 via Frontend Transport; Wed, 23 Aug 2023 15:51:15 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 23 Aug
 2023 10:51:12 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 14/35] drm/amd/display: Add DCN35 DCCG
Date: Wed, 23 Aug 2023 11:50:27 -0400
Message-ID: <20230823155048.2526343-14-alexander.deucher@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE37:EE_|CY5PR12MB6453:EE_
X-MS-Office365-Filtering-Correlation-Id: 06f8d14b-b73b-4bb4-8a6b-08dba3f0c895
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2kHjEt4HfNCVKf0ZuzEl/lgx7ltlhkd67TIF85amdgbvoRpGwEOfeUkKB86YVnb19ZXDPOctevQ1GZP1x0bIwbAh00obuzp50Ou8o/2yCRIIAihxBINcpnps7AUPSFm1Y1POMn3IK+Ise+nKClOn7ikFxmmErA8pmpvmZCu7SVcNFThP+X0hmgFkc/wAYJCz/7t5k5ttAJVHb1nfTB1dd72zU8C1jWDIMcTo3t6iSVhVYlIbnEJe5LQBpIjpmNVqJwegroqlpzZ9uwq5Uqhv3EaAsoAJMGn9QKsIU60Jj1d6Bveeoecm8ITsZ4/zL1BV73ZBM1yW7A8v5AA8hzHK5nu8W2qPJHDnXokP+iFr0Gey5++PRv8fTbXTteGgavYwQDdwyO6D0ytbOMzCcSXsSXqqk2DqB/Z31sxPzsN6+R6Xwc6lw8g4Fp86gj/bxNwUv81tTeAvEekZQl9Ys6cebezxyJ6E0lddZQpeNly/TV3S0cEXr57TmAIOm7xvKOGexX3S15IPlXP0iX56UMP9tWV0/DRXgaAet+Ia4yBGLapMJ1nMCL+OpguDhhzUVWU3RGyDBvaqCZ0tQ2ZPQQ4CATQ7MNvJp0e8i1ZtDzFs/VbPvgSySDEDxpH5dT3REQm6EBA6scby9t426Oc/zLhqQn/KaZOo81y9cA6DAAlKuLk7fQzjGMsoLs+dteZnfriPUias4dcCi+XxInOOimoTtVdIFB6SnzLPk69hzMbjfMP0owqzMoMWvDHY91ZqSe2mhs1/5liGIh2Io/2IKMmS7g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(396003)(136003)(346002)(39860400002)(186009)(1800799009)(451199024)(82310400011)(40470700004)(46966006)(36840700001)(54906003)(6916009)(316002)(70586007)(70206006)(66899024)(8676002)(8936002)(2616005)(4326008)(36756003)(40460700003)(41300700001)(1076003)(356005)(82740400003)(81166007)(478600001)(6666004)(40480700001)(83380400001)(30864003)(2906002)(47076005)(7696005)(36860700001)(86362001)(426003)(336012)(5660300002)(26005)(16526019)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2023 15:51:15.4685 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 06f8d14b-b73b-4bb4-8a6b-08dba3f0c895
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE37.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6453
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
Add DCCG handling for DCN35.

Signed-off-by: Qingqing Zhuo <Qingqing.Zhuo@amd.com>
Acked-by: Harry Wentland <Harry.Wentland@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 .../gpu/drm/amd/display/dc/dcn35/dcn35_dccg.c | 737 ++++++++++++++++++
 .../gpu/drm/amd/display/dc/dcn35/dcn35_dccg.h | 190 +++++
 2 files changed, 927 insertions(+)
 create mode 100644 drivers/gpu/drm/amd/display/dc/dcn35/dcn35_dccg.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/dcn35/dcn35_dccg.h

diff --git a/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_dccg.c b/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_dccg.c
new file mode 100644
index 000000000000..3a322fda35d3
--- /dev/null
+++ b/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_dccg.c
@@ -0,0 +1,737 @@
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
+#include "core_types.h"
+#include "dcn35_dccg.h"
+
+#define TO_DCN_DCCG(dccg)\
+	container_of(dccg, struct dcn_dccg, base)
+
+#define REG(reg) \
+	(dccg_dcn->regs->reg)
+
+#undef FN
+#define FN(reg_name, field_name) \
+	dccg_dcn->dccg_shift->field_name, dccg_dcn->dccg_mask->field_name
+
+#define CTX \
+	dccg_dcn->base.ctx
+#define DC_LOGGER \
+	dccg->ctx->logger
+
+static void dcn35_set_dppclk_enable(struct dccg *dccg,
+				 uint32_t dpp_inst, uint32_t enable)
+{
+	struct dcn_dccg *dccg_dcn = TO_DCN_DCCG(dccg);
+
+	switch (dpp_inst) {
+	case 0:
+		REG_UPDATE(DPPCLK_CTRL, DPPCLK0_EN, enable);
+		break;
+	case 1:
+		REG_UPDATE(DPPCLK_CTRL, DPPCLK1_EN, enable);
+		break;
+	case 2:
+		REG_UPDATE(DPPCLK_CTRL, DPPCLK2_EN, enable);
+		break;
+	case 3:
+		REG_UPDATE(DPPCLK_CTRL, DPPCLK3_EN, enable);
+		break;
+	default:
+		break;
+	}
+
+}
+
+static void dccg35_update_dpp_dto(struct dccg *dccg, int dpp_inst,
+				  int req_dppclk)
+{
+	struct dcn_dccg *dccg_dcn = TO_DCN_DCCG(dccg);
+
+	if (dccg->dpp_clock_gated[dpp_inst]) {
+		/*
+		 * Do not update the DPPCLK DTO if the clock is stopped.
+		 */
+		return;
+	}
+
+	if (dccg->ref_dppclk && req_dppclk) {
+		int ref_dppclk = dccg->ref_dppclk;
+		int modulo, phase;
+
+		// phase / modulo = dpp pipe clk / dpp global clk
+		modulo = 0xff;   // use FF at the end
+		phase = ((modulo * req_dppclk) + ref_dppclk - 1) / ref_dppclk;
+
+		if (phase > 0xff) {
+			ASSERT(false);
+			phase = 0xff;
+		}
+
+		REG_SET_2(DPPCLK_DTO_PARAM[dpp_inst], 0,
+				DPPCLK0_DTO_PHASE, phase,
+				DPPCLK0_DTO_MODULO, modulo);
+
+		dcn35_set_dppclk_enable(dccg, dpp_inst, true);
+	} else
+		dcn35_set_dppclk_enable(dccg, dpp_inst, false);
+	dccg->pipe_dppclk_khz[dpp_inst] = req_dppclk;
+}
+
+static void dccg35_get_pixel_rate_div(
+		struct dccg *dccg,
+		uint32_t otg_inst,
+		enum pixel_rate_div *k1,
+		enum pixel_rate_div *k2)
+{
+	struct dcn_dccg *dccg_dcn = TO_DCN_DCCG(dccg);
+	uint32_t val_k1 = PIXEL_RATE_DIV_NA, val_k2 = PIXEL_RATE_DIV_NA;
+
+	*k1 = PIXEL_RATE_DIV_NA;
+	*k2 = PIXEL_RATE_DIV_NA;
+
+	switch (otg_inst) {
+	case 0:
+		REG_GET_2(OTG_PIXEL_RATE_DIV,
+			OTG0_PIXEL_RATE_DIVK1, &val_k1,
+			OTG0_PIXEL_RATE_DIVK2, &val_k2);
+		break;
+	case 1:
+		REG_GET_2(OTG_PIXEL_RATE_DIV,
+			OTG1_PIXEL_RATE_DIVK1, &val_k1,
+			OTG1_PIXEL_RATE_DIVK2, &val_k2);
+		break;
+	case 2:
+		REG_GET_2(OTG_PIXEL_RATE_DIV,
+			OTG2_PIXEL_RATE_DIVK1, &val_k1,
+			OTG2_PIXEL_RATE_DIVK2, &val_k2);
+		break;
+	case 3:
+		REG_GET_2(OTG_PIXEL_RATE_DIV,
+			OTG3_PIXEL_RATE_DIVK1, &val_k1,
+			OTG3_PIXEL_RATE_DIVK2, &val_k2);
+		break;
+	default:
+		BREAK_TO_DEBUGGER();
+		return;
+	}
+
+	*k1 = (enum pixel_rate_div)val_k1;
+	*k2 = (enum pixel_rate_div)val_k2;
+}
+
+static void dccg35_set_pixel_rate_div(
+		struct dccg *dccg,
+		uint32_t otg_inst,
+		enum pixel_rate_div k1,
+		enum pixel_rate_div k2)
+{
+	struct dcn_dccg *dccg_dcn = TO_DCN_DCCG(dccg);
+	enum pixel_rate_div cur_k1 = PIXEL_RATE_DIV_NA, cur_k2 = PIXEL_RATE_DIV_NA;
+
+	// Don't program 0xF into the register field. Not valid since
+	// K1 / K2 field is only 1 / 2 bits wide
+	if (k1 == PIXEL_RATE_DIV_NA || k2 == PIXEL_RATE_DIV_NA) {
+		BREAK_TO_DEBUGGER();
+		return;
+	}
+
+	dccg35_get_pixel_rate_div(dccg, otg_inst, &cur_k1, &cur_k2);
+	if (k1 == cur_k1 && k2 == cur_k2)
+		return;
+
+	switch (otg_inst) {
+	case 0:
+		REG_UPDATE_2(OTG_PIXEL_RATE_DIV,
+				OTG0_PIXEL_RATE_DIVK1, k1,
+				OTG0_PIXEL_RATE_DIVK2, k2);
+		break;
+	case 1:
+		REG_UPDATE_2(OTG_PIXEL_RATE_DIV,
+				OTG1_PIXEL_RATE_DIVK1, k1,
+				OTG1_PIXEL_RATE_DIVK2, k2);
+		break;
+	case 2:
+		REG_UPDATE_2(OTG_PIXEL_RATE_DIV,
+				OTG2_PIXEL_RATE_DIVK1, k1,
+				OTG2_PIXEL_RATE_DIVK2, k2);
+		break;
+	case 3:
+		REG_UPDATE_2(OTG_PIXEL_RATE_DIV,
+				OTG3_PIXEL_RATE_DIVK1, k1,
+				OTG3_PIXEL_RATE_DIVK2, k2);
+		break;
+	default:
+		BREAK_TO_DEBUGGER();
+		return;
+	}
+}
+
+static void dccg35_set_dtbclk_p_src(
+		struct dccg *dccg,
+		enum streamclk_source src,
+		uint32_t otg_inst)
+{
+	struct dcn_dccg *dccg_dcn = TO_DCN_DCCG(dccg);
+
+	uint32_t p_src_sel = 0; /* selects dprefclk */
+	if (src == DTBCLK0)
+		p_src_sel = 2;  /* selects dtbclk0 */
+
+	switch (otg_inst) {
+	case 0:
+		if (src == REFCLK)
+			REG_UPDATE(DTBCLK_P_CNTL,
+					DTBCLK_P0_EN, 0);
+		else
+			REG_UPDATE_2(DTBCLK_P_CNTL,
+					DTBCLK_P0_SRC_SEL, p_src_sel,
+					DTBCLK_P0_EN, 1);
+		break;
+	case 1:
+		if (src == REFCLK)
+			REG_UPDATE(DTBCLK_P_CNTL,
+					DTBCLK_P1_EN, 0);
+		else
+			REG_UPDATE_2(DTBCLK_P_CNTL,
+					DTBCLK_P1_SRC_SEL, p_src_sel,
+					DTBCLK_P1_EN, 1);
+		break;
+	case 2:
+		if (src == REFCLK)
+			REG_UPDATE(DTBCLK_P_CNTL,
+					DTBCLK_P2_EN, 0);
+		else
+			REG_UPDATE_2(DTBCLK_P_CNTL,
+					DTBCLK_P2_SRC_SEL, p_src_sel,
+					DTBCLK_P2_EN, 1);
+		break;
+	case 3:
+		if (src == REFCLK)
+			REG_UPDATE(DTBCLK_P_CNTL,
+					DTBCLK_P3_EN, 0);
+		else
+			REG_UPDATE_2(DTBCLK_P_CNTL,
+					DTBCLK_P3_SRC_SEL, p_src_sel,
+					DTBCLK_P3_EN, 1);
+		break;
+	default:
+		BREAK_TO_DEBUGGER();
+		return;
+	}
+
+}
+
+/* Controls the generation of pixel valid for OTG in (OTG -> HPO case) */
+static void dccg35_set_dtbclk_dto(
+		struct dccg *dccg,
+		const struct dtbclk_dto_params *params)
+{
+	struct dcn_dccg *dccg_dcn = TO_DCN_DCCG(dccg);
+	/* DTO Output Rate / Pixel Rate = 1/4 */
+	int req_dtbclk_khz = params->pixclk_khz / 4;
+
+	if (params->ref_dtbclk_khz && req_dtbclk_khz) {
+		uint32_t modulo, phase;
+
+		// phase / modulo = dtbclk / dtbclk ref
+		modulo = params->ref_dtbclk_khz * 1000;
+		phase = req_dtbclk_khz * 1000;
+
+		REG_WRITE(DTBCLK_DTO_MODULO[params->otg_inst], modulo);
+		REG_WRITE(DTBCLK_DTO_PHASE[params->otg_inst], phase);
+
+		REG_UPDATE(OTG_PIXEL_RATE_CNTL[params->otg_inst],
+				DTBCLK_DTO_ENABLE[params->otg_inst], 1);
+
+		REG_WAIT(OTG_PIXEL_RATE_CNTL[params->otg_inst],
+				DTBCLKDTO_ENABLE_STATUS[params->otg_inst], 1,
+				1, 100);
+
+		/* program OTG_PIXEL_RATE_DIV for DIVK1 and DIVK2 fields */
+		dccg35_set_pixel_rate_div(dccg, params->otg_inst, PIXEL_RATE_DIV_BY_1, PIXEL_RATE_DIV_BY_1);
+
+		/* The recommended programming sequence to enable DTBCLK DTO to generate
+		 * valid pixel HPO DPSTREAM ENCODER, specifies that DTO source select should
+		 * be set only after DTO is enabled
+		 */
+		REG_UPDATE(OTG_PIXEL_RATE_CNTL[params->otg_inst],
+				PIPE_DTO_SRC_SEL[params->otg_inst], 2);
+	} else {
+		REG_UPDATE_2(OTG_PIXEL_RATE_CNTL[params->otg_inst],
+				DTBCLK_DTO_ENABLE[params->otg_inst], 0,
+				PIPE_DTO_SRC_SEL[params->otg_inst], params->is_hdmi ? 0 : 1);
+
+		REG_WRITE(DTBCLK_DTO_MODULO[params->otg_inst], 0);
+		REG_WRITE(DTBCLK_DTO_PHASE[params->otg_inst], 0);
+	}
+}
+
+static void dccg35_set_dpstreamclk(
+		struct dccg *dccg,
+		enum streamclk_source src,
+		int otg_inst,
+		int dp_hpo_inst)
+{
+	struct dcn_dccg *dccg_dcn = TO_DCN_DCCG(dccg);
+
+	/* set the dtbclk_p source */
+	dccg35_set_dtbclk_p_src(dccg, src, otg_inst);
+
+	/* enabled to select one of the DTBCLKs for pipe */
+	switch (dp_hpo_inst) {
+	case 0:
+		REG_UPDATE_2(DPSTREAMCLK_CNTL,
+				DPSTREAMCLK0_EN,
+				(src == REFCLK) ? 0 : 1, DPSTREAMCLK0_SRC_SEL, otg_inst);
+		break;
+	case 1:
+		REG_UPDATE_2(DPSTREAMCLK_CNTL, DPSTREAMCLK1_EN,
+				(src == REFCLK) ? 0 : 1, DPSTREAMCLK1_SRC_SEL, otg_inst);
+		break;
+	case 2:
+		REG_UPDATE_2(DPSTREAMCLK_CNTL, DPSTREAMCLK2_EN,
+				(src == REFCLK) ? 0 : 1, DPSTREAMCLK2_SRC_SEL, otg_inst);
+		break;
+	case 3:
+		REG_UPDATE_2(DPSTREAMCLK_CNTL, DPSTREAMCLK3_EN,
+				(src == REFCLK) ? 0 : 1, DPSTREAMCLK3_SRC_SEL, otg_inst);
+		break;
+	default:
+		BREAK_TO_DEBUGGER();
+		return;
+	}
+}
+
+static void dccg35_set_physymclk(
+		struct dccg *dccg,
+		int phy_inst,
+		enum physymclk_clock_source clk_src,
+		bool force_enable)
+{
+	struct dcn_dccg *dccg_dcn = TO_DCN_DCCG(dccg);
+
+	/* Force PHYSYMCLK on and Select phyd32clk as the source of clock which is output to PHY through DCIO */
+	switch (phy_inst) {
+	case 0:
+		if (force_enable) {
+			REG_UPDATE_2(PHYASYMCLK_CLOCK_CNTL,
+					PHYASYMCLK_EN, 1,
+					PHYASYMCLK_SRC_SEL, clk_src);
+			if (dccg->ctx->dc->debug.root_clock_optimization.bits.physymclk)
+				REG_UPDATE(DCCG_GATE_DISABLE_CNTL2,
+					PHYASYMCLK_ROOT_GATE_DISABLE, 1);
+		} else {
+			REG_UPDATE_2(PHYASYMCLK_CLOCK_CNTL,
+					PHYASYMCLK_EN, 0,
+					PHYASYMCLK_SRC_SEL, 0);
+			if (dccg->ctx->dc->debug.root_clock_optimization.bits.physymclk)
+				REG_UPDATE(DCCG_GATE_DISABLE_CNTL2,
+					PHYASYMCLK_ROOT_GATE_DISABLE, 0);
+		}
+		break;
+	case 1:
+		if (force_enable) {
+			REG_UPDATE_2(PHYBSYMCLK_CLOCK_CNTL,
+					PHYBSYMCLK_EN, 1,
+					PHYBSYMCLK_SRC_SEL, clk_src);
+			if (dccg->ctx->dc->debug.root_clock_optimization.bits.physymclk)
+				REG_UPDATE(DCCG_GATE_DISABLE_CNTL2,
+					PHYBSYMCLK_ROOT_GATE_DISABLE, 1);
+		} else {
+			REG_UPDATE_2(PHYBSYMCLK_CLOCK_CNTL,
+					PHYBSYMCLK_EN, 0,
+					PHYBSYMCLK_SRC_SEL, 0);
+			if (dccg->ctx->dc->debug.root_clock_optimization.bits.physymclk)
+				REG_UPDATE(DCCG_GATE_DISABLE_CNTL2,
+					PHYBSYMCLK_ROOT_GATE_DISABLE, 0);
+		}
+		break;
+	case 2:
+		if (force_enable) {
+			REG_UPDATE_2(PHYCSYMCLK_CLOCK_CNTL,
+					PHYCSYMCLK_EN, 1,
+					PHYCSYMCLK_SRC_SEL, clk_src);
+			if (dccg->ctx->dc->debug.root_clock_optimization.bits.physymclk)
+				REG_UPDATE(DCCG_GATE_DISABLE_CNTL2,
+					PHYCSYMCLK_ROOT_GATE_DISABLE, 1);
+		} else {
+			REG_UPDATE_2(PHYCSYMCLK_CLOCK_CNTL,
+					PHYCSYMCLK_EN, 0,
+					PHYCSYMCLK_SRC_SEL, 0);
+			if (dccg->ctx->dc->debug.root_clock_optimization.bits.physymclk)
+				REG_UPDATE(DCCG_GATE_DISABLE_CNTL2,
+					PHYCSYMCLK_ROOT_GATE_DISABLE, 0);
+		}
+		break;
+	case 3:
+		if (force_enable) {
+			REG_UPDATE_2(PHYDSYMCLK_CLOCK_CNTL,
+					PHYDSYMCLK_EN, 1,
+					PHYDSYMCLK_SRC_SEL, clk_src);
+			if (dccg->ctx->dc->debug.root_clock_optimization.bits.physymclk)
+				REG_UPDATE(DCCG_GATE_DISABLE_CNTL2,
+					PHYDSYMCLK_ROOT_GATE_DISABLE, 1);
+		} else {
+			REG_UPDATE_2(PHYDSYMCLK_CLOCK_CNTL,
+					PHYDSYMCLK_EN, 0,
+					PHYDSYMCLK_SRC_SEL, 0);
+			if (dccg->ctx->dc->debug.root_clock_optimization.bits.physymclk)
+				REG_UPDATE(DCCG_GATE_DISABLE_CNTL2,
+					PHYDSYMCLK_ROOT_GATE_DISABLE, 0);
+		}
+		break;
+	case 4:
+		if (force_enable) {
+			REG_UPDATE_2(PHYESYMCLK_CLOCK_CNTL,
+					PHYESYMCLK_EN, 1,
+					PHYESYMCLK_SRC_SEL, clk_src);
+			if (dccg->ctx->dc->debug.root_clock_optimization.bits.physymclk)
+				REG_UPDATE(DCCG_GATE_DISABLE_CNTL2,
+					PHYESYMCLK_ROOT_GATE_DISABLE, 1);
+		} else {
+			REG_UPDATE_2(PHYESYMCLK_CLOCK_CNTL,
+					PHYESYMCLK_EN, 0,
+					PHYESYMCLK_SRC_SEL, 0);
+			if (dccg->ctx->dc->debug.root_clock_optimization.bits.physymclk)
+				REG_UPDATE(DCCG_GATE_DISABLE_CNTL2,
+					PHYESYMCLK_ROOT_GATE_DISABLE, 0);
+		}
+		break;
+	default:
+		BREAK_TO_DEBUGGER();
+		return;
+	}
+}
+
+static void dccg35_set_valid_pixel_rate(
+		struct dccg *dccg,
+		int ref_dtbclk_khz,
+		int otg_inst,
+		int pixclk_khz)
+{
+	struct dtbclk_dto_params dto_params = {0};
+
+	dto_params.ref_dtbclk_khz = ref_dtbclk_khz;
+	dto_params.otg_inst = otg_inst;
+	dto_params.pixclk_khz = pixclk_khz;
+	dto_params.is_hdmi = true;
+
+	dccg35_set_dtbclk_dto(dccg, &dto_params);
+}
+
+static void dccg35_dpp_root_clock_control(
+		struct dccg *dccg,
+		unsigned int dpp_inst,
+		bool clock_on)
+{
+	struct dcn_dccg *dccg_dcn = TO_DCN_DCCG(dccg);
+
+	if (dccg->dpp_clock_gated[dpp_inst] == clock_on)
+		return;
+
+	if (clock_on) {
+		/* turn off the DTO and leave phase/modulo at max */
+		dcn35_set_dppclk_enable(dccg, dpp_inst, 0);
+		REG_SET_2(DPPCLK_DTO_PARAM[dpp_inst], 0,
+			  DPPCLK0_DTO_PHASE, 0xFF,
+			  DPPCLK0_DTO_MODULO, 0xFF);
+	} else {
+		dcn35_set_dppclk_enable(dccg, dpp_inst, 1);
+		/* turn on the DTO to generate a 0hz clock */
+		REG_SET_2(DPPCLK_DTO_PARAM[dpp_inst], 0,
+			  DPPCLK0_DTO_PHASE, 0,
+			  DPPCLK0_DTO_MODULO, 1);
+	}
+
+	dccg->dpp_clock_gated[dpp_inst] = !clock_on;
+}
+
+void dccg35_init(struct dccg *dccg)
+{
+	int otg_inst;
+	/* Set HPO stream encoder to use refclk to avoid case where PHY is
+	 * disabled and SYMCLK32 for HPO SE is sourced from PHYD32CLK which
+	 * will cause DCN to hang.
+	 */
+	for (otg_inst = 0; otg_inst < 4; otg_inst++)
+		dccg31_disable_symclk32_se(dccg, otg_inst);
+
+	if (dccg->ctx->dc->debug.root_clock_optimization.bits.symclk32_le)
+		for (otg_inst = 0; otg_inst < 2; otg_inst++)
+			dccg31_disable_symclk32_le(dccg, otg_inst);
+
+	if (dccg->ctx->dc->debug.root_clock_optimization.bits.dpstream)
+		for (otg_inst = 0; otg_inst < 4; otg_inst++)
+			dccg314_set_dpstreamclk(dccg, REFCLK, otg_inst,
+						otg_inst);
+
+	if (dccg->ctx->dc->debug.root_clock_optimization.bits.physymclk)
+		for (otg_inst = 0; otg_inst < 5; otg_inst++)
+			dccg35_set_physymclk(dccg, otg_inst,
+					     PHYSYMCLK_FORCE_SRC_SYMCLK, false);
+/*
+	dccg35_enable_global_fgcg_rep(
+		dccg, dccg->ctx->dc->debug.enable_fine_grain_clock_gating.bits
+			      .dccg_global_fgcg_rep);*/
+}
+
+void dccg35_enable_global_fgcg_rep(struct dccg *dccg, bool value)
+{
+	struct dcn_dccg *dccg_dcn = TO_DCN_DCCG(dccg);
+
+	REG_UPDATE(DCCG_GLOBAL_FGCG_REP_CNTL, DCCG_GLOBAL_FGCG_REP_DIS, !value);
+}
+
+static void dccg35_enable_dscclk(struct dccg *dccg, int inst)
+{
+	struct dcn_dccg *dccg_dcn = TO_DCN_DCCG(dccg);
+
+	//Disable DTO
+	switch (inst) {
+	case 0:
+		REG_UPDATE_2(DSCCLK0_DTO_PARAM,
+				DSCCLK0_DTO_PHASE, 0,
+				DSCCLK0_DTO_MODULO, 0);
+		REG_UPDATE(DSCCLK_DTO_CTRL,	DSCCLK0_EN, 1);
+		break;
+	case 1:
+		REG_UPDATE_2(DSCCLK1_DTO_PARAM,
+				DSCCLK1_DTO_PHASE, 0,
+				DSCCLK1_DTO_MODULO, 0);
+		REG_UPDATE(DSCCLK_DTO_CTRL, DSCCLK1_EN, 1);
+		break;
+	case 2:
+		REG_UPDATE_2(DSCCLK2_DTO_PARAM,
+				DSCCLK2_DTO_PHASE, 0,
+				DSCCLK2_DTO_MODULO, 0);
+		REG_UPDATE(DSCCLK_DTO_CTRL, DSCCLK2_EN, 1);
+		break;
+	case 3:
+		REG_UPDATE_2(DSCCLK3_DTO_PARAM,
+				DSCCLK3_DTO_PHASE, 0,
+				DSCCLK3_DTO_MODULO, 0);
+		REG_UPDATE(DSCCLK_DTO_CTRL, DSCCLK3_EN, 1);
+		break;
+	default:
+		BREAK_TO_DEBUGGER();
+		return;
+	}
+}
+
+static void dccg35_disable_dscclk(struct dccg *dccg,
+				int inst)
+{
+	struct dcn_dccg *dccg_dcn = TO_DCN_DCCG(dccg);
+
+	if (!dccg->ctx->dc->debug.root_clock_optimization.bits.dsc)
+		return;
+
+	switch (inst) {
+	case 0:
+		REG_UPDATE(DSCCLK_DTO_CTRL, DSCCLK0_EN, 0);
+		REG_UPDATE_2(DSCCLK0_DTO_PARAM,
+				DSCCLK0_DTO_PHASE, 0,
+				DSCCLK0_DTO_MODULO, 1);
+		break;
+	case 1:
+		REG_UPDATE(DSCCLK_DTO_CTRL, DSCCLK1_EN, 0);
+		REG_UPDATE_2(DSCCLK1_DTO_PARAM,
+				DSCCLK1_DTO_PHASE, 0,
+				DSCCLK1_DTO_MODULO, 1);
+		break;
+	case 2:
+		REG_UPDATE(DSCCLK_DTO_CTRL, DSCCLK2_EN, 0);
+		REG_UPDATE_2(DSCCLK2_DTO_PARAM,
+				DSCCLK2_DTO_PHASE, 0,
+				DSCCLK2_DTO_MODULO, 1);
+		break;
+	case 3:
+		REG_UPDATE(DSCCLK_DTO_CTRL, DSCCLK3_EN, 0);
+		REG_UPDATE_2(DSCCLK3_DTO_PARAM,
+				DSCCLK3_DTO_PHASE, 0,
+				DSCCLK3_DTO_MODULO, 1);
+		break;
+	default:
+		return;
+	}
+}
+
+static void dccg35_enable_symclk_se(struct dccg *dccg, uint32_t stream_enc_inst, uint32_t link_enc_inst)
+{
+	struct dcn_dccg *dccg_dcn = TO_DCN_DCCG(dccg);
+
+	switch (link_enc_inst) {
+	case 0:
+		REG_UPDATE(SYMCLKA_CLOCK_ENABLE,
+				SYMCLKA_CLOCK_ENABLE, 1);
+		break;
+	case 1:
+		REG_UPDATE(SYMCLKB_CLOCK_ENABLE,
+				SYMCLKB_CLOCK_ENABLE, 1);
+		break;
+	case 2:
+		REG_UPDATE(SYMCLKC_CLOCK_ENABLE,
+				SYMCLKC_CLOCK_ENABLE, 1);
+		break;
+	case 3:
+		REG_UPDATE(SYMCLKD_CLOCK_ENABLE,
+				SYMCLKD_CLOCK_ENABLE, 1);
+		break;
+	case 4:
+		REG_UPDATE(SYMCLKE_CLOCK_ENABLE,
+				SYMCLKE_CLOCK_ENABLE, 1);
+		break;
+	}
+
+	switch (stream_enc_inst) {
+	case 0:
+		REG_UPDATE_2(SYMCLKA_CLOCK_ENABLE,
+				SYMCLKA_FE_EN, 1,
+				SYMCLKA_FE_SRC_SEL, link_enc_inst);
+		break;
+	case 1:
+		REG_UPDATE_2(SYMCLKB_CLOCK_ENABLE,
+				SYMCLKB_FE_EN, 1,
+				SYMCLKB_FE_SRC_SEL, link_enc_inst);
+		break;
+	case 2:
+		REG_UPDATE_2(SYMCLKC_CLOCK_ENABLE,
+				SYMCLKC_FE_EN, 1,
+				SYMCLKC_FE_SRC_SEL, link_enc_inst);
+		break;
+	case 3:
+		REG_UPDATE_2(SYMCLKD_CLOCK_ENABLE,
+				SYMCLKD_FE_EN, 1,
+				SYMCLKD_FE_SRC_SEL, link_enc_inst);
+		break;
+	case 4:
+		REG_UPDATE_2(SYMCLKE_CLOCK_ENABLE,
+				SYMCLKE_FE_EN, 1,
+				SYMCLKE_FE_SRC_SEL, link_enc_inst);
+		break;
+	}
+}
+
+static void dccg35_disable_symclk_se(struct dccg *dccg, uint32_t stream_enc_inst, uint32_t link_enc_inst)
+{
+	struct dcn_dccg *dccg_dcn = TO_DCN_DCCG(dccg);
+
+	switch (stream_enc_inst) {
+	case 0:
+		REG_UPDATE(SYMCLKA_CLOCK_ENABLE,
+				SYMCLKA_FE_EN, 0);
+		break;
+	case 1:
+		REG_UPDATE(SYMCLKB_CLOCK_ENABLE,
+				SYMCLKB_FE_EN, 0);
+		break;
+	case 2:
+		REG_UPDATE(SYMCLKC_CLOCK_ENABLE,
+				SYMCLKC_FE_EN, 0);
+		break;
+	case 3:
+		REG_UPDATE(SYMCLKD_CLOCK_ENABLE,
+				SYMCLKD_FE_EN, 0);
+		break;
+	case 4:
+		REG_UPDATE(SYMCLKE_CLOCK_ENABLE,
+				SYMCLKE_FE_EN, 0);
+		break;
+	}
+
+	switch (link_enc_inst) {
+	case 0:
+		REG_UPDATE(SYMCLKA_CLOCK_ENABLE,
+				SYMCLKA_CLOCK_ENABLE, 0);
+		break;
+	case 1:
+		REG_UPDATE(SYMCLKB_CLOCK_ENABLE,
+				SYMCLKB_CLOCK_ENABLE, 0);
+		break;
+	case 2:
+		REG_UPDATE(SYMCLKC_CLOCK_ENABLE,
+				SYMCLKC_CLOCK_ENABLE, 0);
+		break;
+	case 3:
+		REG_UPDATE(SYMCLKD_CLOCK_ENABLE,
+				SYMCLKD_CLOCK_ENABLE, 0);
+		break;
+	case 4:
+		REG_UPDATE(SYMCLKE_CLOCK_ENABLE,
+				SYMCLKE_CLOCK_ENABLE, 0);
+		break;
+	}
+}
+
+static const struct dccg_funcs dccg35_funcs = {
+	.update_dpp_dto = dccg35_update_dpp_dto,
+	.dpp_root_clock_control = dccg35_dpp_root_clock_control,
+	.get_dccg_ref_freq = dccg31_get_dccg_ref_freq,
+	.dccg_init = dccg35_init,
+	.set_dpstreamclk = dccg35_set_dpstreamclk,
+	.enable_symclk32_se = dccg31_enable_symclk32_se,
+	.disable_symclk32_se = dccg31_disable_symclk32_se,
+	.enable_symclk32_le = dccg31_enable_symclk32_le,
+	.disable_symclk32_le = dccg31_disable_symclk32_le,
+	.set_physymclk = dccg35_set_physymclk,
+	.set_dtbclk_dto = dccg35_set_dtbclk_dto,
+	.set_audio_dtbclk_dto = dccg31_set_audio_dtbclk_dto,
+	.set_fifo_errdet_ovr_en = dccg2_set_fifo_errdet_ovr_en,
+	.otg_add_pixel = dccg31_otg_add_pixel,
+	.otg_drop_pixel = dccg31_otg_drop_pixel,
+	.set_dispclk_change_mode = dccg31_set_dispclk_change_mode,
+	.disable_dsc = dccg35_disable_dscclk,
+	.enable_dsc = dccg35_enable_dscclk,
+	.set_pixel_rate_div = dccg35_set_pixel_rate_div,
+	.set_valid_pixel_rate = dccg35_set_valid_pixel_rate,
+	.enable_symclk_se = dccg35_enable_symclk_se,
+	.disable_symclk_se = dccg35_disable_symclk_se,
+};
+
+struct dccg *dccg35_create(
+	struct dc_context *ctx,
+	const struct dccg_registers *regs,
+	const struct dccg_shift *dccg_shift,
+	const struct dccg_mask *dccg_mask)
+{
+	struct dcn_dccg *dccg_dcn = kzalloc(sizeof(*dccg_dcn), GFP_KERNEL);
+	struct dccg *base;
+
+	if (dccg_dcn == NULL) {
+		BREAK_TO_DEBUGGER();
+		return NULL;
+	}
+
+	base = &dccg_dcn->base;
+	base->ctx = ctx;
+	base->funcs = &dccg35_funcs;
+
+	dccg_dcn->regs = regs;
+	dccg_dcn->dccg_shift = dccg_shift;
+	dccg_dcn->dccg_mask = dccg_mask;
+
+	return &dccg_dcn->base;
+}
diff --git a/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_dccg.h b/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_dccg.h
new file mode 100644
index 000000000000..423feb4c2f3f
--- /dev/null
+++ b/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_dccg.h
@@ -0,0 +1,190 @@
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
+#ifndef __DCN35_DCCG_H__
+#define __DCN35_DCCG_H__
+
+#include "dcn314/dcn314_dccg.h"
+
+#define DCCG_SFII(block, reg_name, field_prefix, field_name, inst, post_fix)\
+	.field_prefix ## _ ## field_name[inst] = block ## inst ## _ ## reg_name ## __ ## field_prefix ## inst ## _ ## field_name ## post_fix
+
+
+#define DCCG_REG_LIST_DCN35() \
+	DCCG_REG_LIST_DCN314(),\
+	SR(DPPCLK_CTRL),\
+	SR(DCCG_GATE_DISABLE_CNTL6),\
+	SR(DCCG_GLOBAL_FGCG_REP_CNTL),\
+	SR(SYMCLKA_CLOCK_ENABLE),\
+	SR(SYMCLKB_CLOCK_ENABLE),\
+	SR(SYMCLKC_CLOCK_ENABLE),\
+	SR(SYMCLKD_CLOCK_ENABLE),\
+	SR(SYMCLKE_CLOCK_ENABLE)
+
+#define DCCG_MASK_SH_LIST_DCN35(mask_sh) \
+	DCCG_SFI(DPPCLK_DTO_CTRL, DTO_DB_EN, DPPCLK, 0, mask_sh),\
+	DCCG_SFI(DPPCLK_DTO_CTRL, DTO_DB_EN, DPPCLK, 1, mask_sh),\
+	DCCG_SFI(DPPCLK_DTO_CTRL, DTO_DB_EN, DPPCLK, 2, mask_sh),\
+	DCCG_SFI(DPPCLK_DTO_CTRL, DTO_DB_EN, DPPCLK, 3, mask_sh),\
+	DCCG_SF(DPPCLK_CTRL, DPPCLK0_EN, mask_sh),\
+	DCCG_SF(DPPCLK_CTRL, DPPCLK1_EN, mask_sh),\
+	DCCG_SF(DPPCLK_CTRL, DPPCLK2_EN, mask_sh),\
+	DCCG_SF(DPPCLK_CTRL, DPPCLK3_EN, mask_sh),\
+	DCCG_SF(DPPCLK0_DTO_PARAM, DPPCLK0_DTO_PHASE, mask_sh),\
+	DCCG_SF(DPPCLK0_DTO_PARAM, DPPCLK0_DTO_MODULO, mask_sh),\
+	DCCG_SF(HDMICHARCLK0_CLOCK_CNTL, HDMICHARCLK0_EN, mask_sh),\
+	DCCG_SF(HDMICHARCLK0_CLOCK_CNTL, HDMICHARCLK0_SRC_SEL, mask_sh),\
+	DCCG_SF(PHYASYMCLK_CLOCK_CNTL, PHYASYMCLK_EN, mask_sh),\
+	DCCG_SF(PHYASYMCLK_CLOCK_CNTL, PHYASYMCLK_SRC_SEL, mask_sh),\
+	DCCG_SF(PHYBSYMCLK_CLOCK_CNTL, PHYBSYMCLK_EN, mask_sh),\
+	DCCG_SF(PHYBSYMCLK_CLOCK_CNTL, PHYBSYMCLK_SRC_SEL, mask_sh),\
+	DCCG_SF(PHYCSYMCLK_CLOCK_CNTL, PHYCSYMCLK_EN, mask_sh),\
+	DCCG_SF(PHYCSYMCLK_CLOCK_CNTL, PHYCSYMCLK_SRC_SEL, mask_sh),\
+	DCCG_SF(PHYDSYMCLK_CLOCK_CNTL, PHYDSYMCLK_EN, mask_sh),\
+	DCCG_SF(PHYDSYMCLK_CLOCK_CNTL, PHYDSYMCLK_SRC_SEL, mask_sh),\
+	DCCG_SF(DPSTREAMCLK_CNTL, DPSTREAMCLK0_EN, mask_sh),\
+	DCCG_SF(DPSTREAMCLK_CNTL, DPSTREAMCLK1_EN, mask_sh),\
+	DCCG_SF(DPSTREAMCLK_CNTL, DPSTREAMCLK2_EN, mask_sh),\
+	DCCG_SF(DPSTREAMCLK_CNTL, DPSTREAMCLK3_EN, mask_sh),\
+	DCCG_SF(DPSTREAMCLK_CNTL, DPSTREAMCLK0_SRC_SEL, mask_sh),\
+	DCCG_SF(DPSTREAMCLK_CNTL, DPSTREAMCLK1_SRC_SEL, mask_sh),\
+	DCCG_SF(DPSTREAMCLK_CNTL, DPSTREAMCLK2_SRC_SEL, mask_sh),\
+	DCCG_SF(DPSTREAMCLK_CNTL, DPSTREAMCLK3_SRC_SEL, mask_sh),\
+	DCCG_SF(HDMISTREAMCLK_CNTL, HDMISTREAMCLK0_EN, mask_sh),\
+	DCCG_SF(HDMISTREAMCLK_CNTL, HDMISTREAMCLK0_SRC_SEL, mask_sh),\
+	DCCG_SF(DSCCLK_DTO_CTRL, DSCCLK0_EN, mask_sh),\
+	DCCG_SF(DSCCLK_DTO_CTRL, DSCCLK1_EN, mask_sh),\
+	DCCG_SF(DSCCLK_DTO_CTRL, DSCCLK2_EN, mask_sh),\
+	DCCG_SF(DSCCLK_DTO_CTRL, DSCCLK3_EN, mask_sh),\
+	DCCG_SF(DSCCLK0_DTO_PARAM, DSCCLK0_DTO_PHASE, mask_sh),\
+	DCCG_SF(DSCCLK0_DTO_PARAM, DSCCLK0_DTO_MODULO, mask_sh),\
+	DCCG_SF(DSCCLK1_DTO_PARAM, DSCCLK1_DTO_PHASE, mask_sh),\
+	DCCG_SF(DSCCLK1_DTO_PARAM, DSCCLK1_DTO_MODULO, mask_sh),\
+	DCCG_SF(DSCCLK2_DTO_PARAM, DSCCLK2_DTO_PHASE, mask_sh),\
+	DCCG_SF(DSCCLK2_DTO_PARAM, DSCCLK2_DTO_MODULO, mask_sh),\
+	DCCG_SF(DSCCLK3_DTO_PARAM, DSCCLK3_DTO_PHASE, mask_sh),\
+	DCCG_SF(DSCCLK3_DTO_PARAM, DSCCLK3_DTO_MODULO, mask_sh),\
+	DCCG_SF(SYMCLK32_SE_CNTL, SYMCLK32_SE0_SRC_SEL, mask_sh),\
+	DCCG_SF(SYMCLK32_SE_CNTL, SYMCLK32_SE1_SRC_SEL, mask_sh),\
+	DCCG_SF(SYMCLK32_SE_CNTL, SYMCLK32_SE2_SRC_SEL, mask_sh),\
+	DCCG_SF(SYMCLK32_SE_CNTL, SYMCLK32_SE3_SRC_SEL, mask_sh),\
+	DCCG_SF(SYMCLK32_SE_CNTL, SYMCLK32_SE0_EN, mask_sh),\
+	DCCG_SF(SYMCLK32_SE_CNTL, SYMCLK32_SE1_EN, mask_sh),\
+	DCCG_SF(SYMCLK32_SE_CNTL, SYMCLK32_SE2_EN, mask_sh),\
+	DCCG_SF(SYMCLK32_SE_CNTL, SYMCLK32_SE3_EN, mask_sh),\
+	DCCG_SF(SYMCLK32_LE_CNTL, SYMCLK32_LE0_SRC_SEL, mask_sh),\
+	DCCG_SF(SYMCLK32_LE_CNTL, SYMCLK32_LE1_SRC_SEL, mask_sh),\
+	DCCG_SF(SYMCLK32_LE_CNTL, SYMCLK32_LE0_EN, mask_sh),\
+	DCCG_SF(SYMCLK32_LE_CNTL, SYMCLK32_LE1_EN, mask_sh),\
+	DCCG_SFII(OTG, PIXEL_RATE_CNTL, DTBCLK_DTO, ENABLE, 0, mask_sh),\
+	DCCG_SFII(OTG, PIXEL_RATE_CNTL, DTBCLK_DTO, ENABLE, 1, mask_sh),\
+	DCCG_SFII(OTG, PIXEL_RATE_CNTL, DTBCLK_DTO, ENABLE, 2, mask_sh),\
+	DCCG_SFII(OTG, PIXEL_RATE_CNTL, DTBCLK_DTO, ENABLE, 3, mask_sh),\
+	DCCG_SFII(OTG, PIXEL_RATE_CNTL, DTBCLKDTO, ENABLE_STATUS, 0, mask_sh),\
+	DCCG_SFII(OTG, PIXEL_RATE_CNTL, DTBCLKDTO, ENABLE_STATUS, 1, mask_sh),\
+	DCCG_SFII(OTG, PIXEL_RATE_CNTL, DTBCLKDTO, ENABLE_STATUS, 2, mask_sh),\
+	DCCG_SFII(OTG, PIXEL_RATE_CNTL, DTBCLKDTO, ENABLE_STATUS, 3, mask_sh),\
+	DCCG_SFII(OTG, PIXEL_RATE_CNTL, PIPE, DTO_SRC_SEL, 0, mask_sh),\
+	DCCG_SFII(OTG, PIXEL_RATE_CNTL, PIPE, DTO_SRC_SEL, 1, mask_sh),\
+	DCCG_SFII(OTG, PIXEL_RATE_CNTL, PIPE, DTO_SRC_SEL, 2, mask_sh),\
+	DCCG_SFII(OTG, PIXEL_RATE_CNTL, PIPE, DTO_SRC_SEL, 3, mask_sh),\
+	DCCG_SFII(OTG, PIXEL_RATE_CNTL, OTG, ADD_PIXEL, 0, mask_sh),\
+	DCCG_SFII(OTG, PIXEL_RATE_CNTL, OTG, ADD_PIXEL, 1, mask_sh),\
+	DCCG_SFII(OTG, PIXEL_RATE_CNTL, OTG, ADD_PIXEL, 2, mask_sh),\
+	DCCG_SFII(OTG, PIXEL_RATE_CNTL, OTG, ADD_PIXEL, 3, mask_sh),\
+	DCCG_SF(OTG_PIXEL_RATE_DIV, OTG0_PIXEL_RATE_DIVK1, mask_sh),\
+	DCCG_SF(OTG_PIXEL_RATE_DIV, OTG0_PIXEL_RATE_DIVK2, mask_sh),\
+	DCCG_SF(OTG_PIXEL_RATE_DIV, OTG1_PIXEL_RATE_DIVK1, mask_sh),\
+	DCCG_SF(OTG_PIXEL_RATE_DIV, OTG1_PIXEL_RATE_DIVK2, mask_sh),\
+	DCCG_SF(OTG_PIXEL_RATE_DIV, OTG2_PIXEL_RATE_DIVK1, mask_sh),\
+	DCCG_SF(OTG_PIXEL_RATE_DIV, OTG2_PIXEL_RATE_DIVK2, mask_sh),\
+	DCCG_SF(OTG_PIXEL_RATE_DIV, OTG3_PIXEL_RATE_DIVK1, mask_sh),\
+	DCCG_SF(OTG_PIXEL_RATE_DIV, OTG3_PIXEL_RATE_DIVK2, mask_sh),\
+	DCCG_SF(OTG_PIXEL_RATE_DIV, OTG3_PIXEL_RATE_DIVK2, mask_sh),\
+	DCCG_SFII(OTG, PIXEL_RATE_CNTL, OTG, DROP_PIXEL, 0, mask_sh),\
+	DCCG_SFII(OTG, PIXEL_RATE_CNTL, OTG, DROP_PIXEL, 1, mask_sh),\
+	DCCG_SFII(OTG, PIXEL_RATE_CNTL, OTG, DROP_PIXEL, 2, mask_sh),\
+	DCCG_SFII(OTG, PIXEL_RATE_CNTL, OTG, DROP_PIXEL, 3, mask_sh),\
+	DCCG_SF(DTBCLK_P_CNTL, DTBCLK_P0_SRC_SEL, mask_sh),\
+	DCCG_SF(DTBCLK_P_CNTL, DTBCLK_P0_EN, mask_sh),\
+	DCCG_SF(DTBCLK_P_CNTL, DTBCLK_P1_SRC_SEL, mask_sh),\
+	DCCG_SF(DTBCLK_P_CNTL, DTBCLK_P1_EN, mask_sh),\
+	DCCG_SF(DTBCLK_P_CNTL, DTBCLK_P2_SRC_SEL, mask_sh),\
+	DCCG_SF(DTBCLK_P_CNTL, DTBCLK_P2_EN, mask_sh),\
+	DCCG_SF(DTBCLK_P_CNTL, DTBCLK_P3_SRC_SEL, mask_sh),\
+	DCCG_SF(DTBCLK_P_CNTL, DTBCLK_P3_EN, mask_sh),\
+	DCCG_SF(PHYASYMCLK_CLOCK_CNTL, PHYASYMCLK_EN, mask_sh),\
+	DCCG_SF(PHYASYMCLK_CLOCK_CNTL, PHYASYMCLK_SRC_SEL, mask_sh),\
+	DCCG_SF(PHYBSYMCLK_CLOCK_CNTL, PHYBSYMCLK_EN, mask_sh),\
+	DCCG_SF(PHYBSYMCLK_CLOCK_CNTL, PHYBSYMCLK_SRC_SEL, mask_sh),\
+	DCCG_SF(PHYCSYMCLK_CLOCK_CNTL, PHYCSYMCLK_EN, mask_sh),\
+	DCCG_SF(PHYCSYMCLK_CLOCK_CNTL, PHYCSYMCLK_SRC_SEL, mask_sh),\
+	DCCG_SF(PHYDSYMCLK_CLOCK_CNTL, PHYDSYMCLK_EN, mask_sh),\
+	DCCG_SF(PHYDSYMCLK_CLOCK_CNTL, PHYDSYMCLK_SRC_SEL, mask_sh),\
+	DCCG_SF(PHYESYMCLK_CLOCK_CNTL, PHYESYMCLK_EN, mask_sh),\
+	DCCG_SF(PHYESYMCLK_CLOCK_CNTL, PHYESYMCLK_SRC_SEL, mask_sh),\
+	DCCG_SF(DCCG_AUDIO_DTO_SOURCE, DCCG_AUDIO_DTO_SEL, mask_sh),\
+	DCCG_SF(DCCG_AUDIO_DTO_SOURCE, DCCG_AUDIO_DTO0_SOURCE_SEL, mask_sh),\
+	DCCG_SF(DENTIST_DISPCLK_CNTL, DENTIST_DISPCLK_CHG_DONE, mask_sh),\
+	DCCG_SF(DENTIST_DISPCLK_CNTL, DENTIST_DISPCLK_RDIVIDER, mask_sh),\
+	DCCG_SF(DENTIST_DISPCLK_CNTL, DENTIST_DISPCLK_WDIVIDER, mask_sh),\
+	DCCG_SF(DCCG_GATE_DISABLE_CNTL2, PHYASYMCLK_ROOT_GATE_DISABLE, mask_sh),\
+	DCCG_SF(DCCG_GATE_DISABLE_CNTL2, PHYBSYMCLK_ROOT_GATE_DISABLE, mask_sh),\
+	DCCG_SF(DCCG_GATE_DISABLE_CNTL2, PHYCSYMCLK_ROOT_GATE_DISABLE, mask_sh),\
+	DCCG_SF(DCCG_GATE_DISABLE_CNTL2, PHYDSYMCLK_ROOT_GATE_DISABLE, mask_sh),\
+	DCCG_SF(DCCG_GATE_DISABLE_CNTL2, PHYESYMCLK_ROOT_GATE_DISABLE, mask_sh),\
+	DCCG_SF(DCCG_GLOBAL_FGCG_REP_CNTL, DCCG_GLOBAL_FGCG_REP_DIS, mask_sh),\
+	DCCG_SF(SYMCLKA_CLOCK_ENABLE, SYMCLKA_CLOCK_ENABLE, mask_sh),\
+	DCCG_SF(SYMCLKB_CLOCK_ENABLE, SYMCLKB_CLOCK_ENABLE, mask_sh),\
+	DCCG_SF(SYMCLKC_CLOCK_ENABLE, SYMCLKC_CLOCK_ENABLE, mask_sh),\
+	DCCG_SF(SYMCLKD_CLOCK_ENABLE, SYMCLKD_CLOCK_ENABLE, mask_sh),\
+	DCCG_SF(SYMCLKE_CLOCK_ENABLE, SYMCLKE_CLOCK_ENABLE, mask_sh),\
+	DCCG_SF(SYMCLKA_CLOCK_ENABLE, SYMCLKA_FE_EN, mask_sh),\
+	DCCG_SF(SYMCLKB_CLOCK_ENABLE, SYMCLKB_FE_EN, mask_sh),\
+	DCCG_SF(SYMCLKC_CLOCK_ENABLE, SYMCLKC_FE_EN, mask_sh),\
+	DCCG_SF(SYMCLKD_CLOCK_ENABLE, SYMCLKD_FE_EN, mask_sh),\
+	DCCG_SF(SYMCLKE_CLOCK_ENABLE, SYMCLKE_FE_EN, mask_sh),\
+	DCCG_SF(SYMCLKA_CLOCK_ENABLE, SYMCLKA_SRC_SEL, mask_sh),\
+	DCCG_SF(SYMCLKB_CLOCK_ENABLE, SYMCLKB_SRC_SEL, mask_sh),\
+	DCCG_SF(SYMCLKC_CLOCK_ENABLE, SYMCLKC_SRC_SEL, mask_sh),\
+	DCCG_SF(SYMCLKD_CLOCK_ENABLE, SYMCLKD_SRC_SEL, mask_sh),\
+	DCCG_SF(SYMCLKE_CLOCK_ENABLE, SYMCLKE_SRC_SEL, mask_sh),\
+	DCCG_SF(SYMCLKA_CLOCK_ENABLE, SYMCLKA_FE_SRC_SEL, mask_sh),\
+	DCCG_SF(SYMCLKB_CLOCK_ENABLE, SYMCLKB_FE_SRC_SEL, mask_sh),\
+	DCCG_SF(SYMCLKC_CLOCK_ENABLE, SYMCLKC_FE_SRC_SEL, mask_sh),\
+	DCCG_SF(SYMCLKD_CLOCK_ENABLE, SYMCLKD_FE_SRC_SEL, mask_sh),\
+	DCCG_SF(SYMCLKE_CLOCK_ENABLE, SYMCLKE_FE_SRC_SEL, mask_sh)
+
+struct dccg *dccg35_create(
+		struct dc_context *ctx,
+		const struct dccg_registers *regs,
+		const struct dccg_shift *dccg_shift,
+		const struct dccg_mask *dccg_mask);
+
+void dccg35_init(struct dccg *dccg);
+
+void dccg35_enable_global_fgcg_rep(struct dccg *dccg, bool value);
+
+
+#endif //__DCN35_DCCG_H__
-- 
2.41.0

