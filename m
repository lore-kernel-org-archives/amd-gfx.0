Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6227C433EF
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Jul 2022 22:09:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 827A110ED67;
	Fri,  8 Jul 2022 22:09:15 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2087.outbound.protection.outlook.com [40.107.93.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5B6BA10ED6C
 for <amd-gfx@lists.freedesktop.org>; Fri,  8 Jul 2022 22:09:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IdgPaumGsL5/d+ejYhIR4uzptxBusXZG+ogiROyVFxWi3eG2ICD3IeT6WYzVFENyQEzMTcBpnbAKJsZh4ZeO9nJJfrKS7Qa7QpMwdsHsmndXJ7sMHHOj45CZ0tiX5NvSN3epPembxLOfL/Ckal5C88rkdfMDjbbc+lfwI6rIWcNE51nbfBLfEHdiiZho/JnVoEzibaMUymjrjWPxc0N3eF+YOJZk26XlhBdc94LZ0+45wN2+v8bq/inO6KtHvGYaGB2KXCc1UpytN6y7Wt0hJBfztlHwX17cU2z9xRuLAXtJm57QE5wg/+Nd21scQ1i6adNcK2UCT1mR86vFKpT62g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B0PbiqdEYvsJnmTza3nfuDo4jdVJ3XkYveQaD+453M4=;
 b=OE9OHCRCU4fb3GfPwFkLSlkU53iLdaCXaPw1feqC5/8plL9EdP7xXFDIXn+JcuEja0kIQZLPZ/Z6mXkl85XLycrwK9XEHK6wG/WnK9eX+N8dUE0j0t1fgy+ISLzFOWh+lfURwi0Cd8Omst3sKFAR7hSJ0wRv7Ejp2DJrIERss9KnvurtXm6xW7gopbaan4t2LObYHClXMK3Tkbs43ebiYpIMdgHGyg/Q7g6Tk49IHBTCB21n7YDYSXEEswiNhrAOe8+eIp9YIk6vhyZ/QMRWMOR6VCn0d2x4ZKUPGcOV8aAWjyH5+lzLF7U3/fYMH0oEcG9swLSbcaX6PfzPyk1XVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B0PbiqdEYvsJnmTza3nfuDo4jdVJ3XkYveQaD+453M4=;
 b=b+AVyqIjCx76J+jlfAmWYmZreVj4GVZKJ340WphXRa5MMPWhKTPkV+QdWm8gJZKnyHVitbRl3YnJff5wQRJycpUxagEtdvitycKns61W93PCO9l1RdnrtGfB4Ss/g6bPlPN2eOoIy/gRF5Mq04sZXZp4+ZZuM9ah3T+gEQXfChk=
Received: from DM6PR08CA0015.namprd08.prod.outlook.com (2603:10b6:5:80::28) by
 DM6PR12MB3068.namprd12.prod.outlook.com (2603:10b6:5:3e::25) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5417.16; Fri, 8 Jul 2022 22:09:10 +0000
Received: from DM6NAM11FT034.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:80:cafe::5d) by DM6PR08CA0015.outlook.office365.com
 (2603:10b6:5:80::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.18 via Frontend
 Transport; Fri, 8 Jul 2022 22:09:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT034.mail.protection.outlook.com (10.13.173.47) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5417.15 via Frontend Transport; Fri, 8 Jul 2022 22:09:10 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 8 Jul
 2022 17:09:08 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 3/9] drm/amd/display: Add DCN314 clock manager
Date: Fri, 8 Jul 2022 18:08:49 -0400
Message-ID: <20220708220855.1475213-3-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220708220855.1475213-1-alexander.deucher@amd.com>
References: <20220708220855.1475213-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 84082259-78d5-4d7e-519d-08da612e7c34
X-MS-TrafficTypeDiagnostic: DM6PR12MB3068:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7uJ5WAMpz3J9s+Tecfp5gbo+GidwPQAl1M1Ct6jFjNVTJV1s8vjgRkqpXpLf6Oh7mqi1+qVH6CUkV+tYPTsHVqPegR5fl11na5UEqD0VzwDvLKHI0wFWQHz3JZoI4u/xCiAH4I+/IiRBX9ny3CkMq+dN7sXak/fFIWXu7g9Tmk0tGkQUSXAvxC8MvlWmSJcR6CLQP/5LbVZNVmIlD6svMp5ZnqjL64IfJuKkKDYK/SkDq8mfubJqMF501uqM5hah29vyjDcrOWdKFv6mNpLwk+u54pgVwJ/PEqTt4jLxJXhjGsc7/gTgHt+8wC1qGTrFLB2XgGlEiIpmxZDkpV0QcasO3ZO+0jkVS7Mps92wplraRtCn59KXBQn4tRkw/uErvLzYHZcfaTMUNasy8TVLBP9GsP+A0G+JNC1ABXBjLkQ0TP+yjA28VMCtcWWUNOU7MAT5RDHRX/Uq24REYB3RSC1xR54l5g4QTo7qXxY4c0MbydMvorfWJyB+e3uZ7gfFRNf6BeQK289es1imnfLGAK3+neCHc/jmfkmMPQ5wgatlEXlsR1WAOcoq3etb/27zSHNBdw63vwwvjM0PEBYdwC9jDk0cl/vCNKZkhDGiKfL8eXoJtIVQScUSTnl/wwuzAbHqLOpy9vPC5v/qwbl+cECgQmJ4NXDue165oVQkOJicVxhAMerb7ZFZBKCgXW7iGLmnhIdhTU1amU3qhbQxFUe7hXgSj4nbP3TThTm5puk/kdx0gLveAtC4CBtWNh4L9+dmu+U02Mx2Ir/8I0oBOqY7nQS+PqXDF77E2q/l7/1sKWQqj4ZsAUVdnSis18gcjueLLn0QsFonw514zt6ozw8MoVrdeHMHcg2LbRYsEzuORPTgi6vMsmTcB7G4SArA
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(346002)(136003)(376002)(39860400002)(396003)(36840700001)(46966006)(40470700004)(70586007)(16526019)(82740400003)(2616005)(47076005)(81166007)(26005)(8676002)(34020700004)(336012)(70206006)(186003)(1076003)(426003)(40480700001)(6916009)(36860700001)(82310400005)(4326008)(36756003)(356005)(83380400001)(6666004)(478600001)(7696005)(40460700003)(41300700001)(19627235002)(5660300002)(316002)(86362001)(54906003)(2906002)(8936002)(30864003)(36900700001)(579004);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2022 22:09:10.5602 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 84082259-78d5-4d7e-519d-08da612e7c34
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT034.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3068
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Roman Li <roman.li@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Roman Li <roman.li@amd.com>

Clock and SMU interfaces for DCN 3.1.4

Signed-off-by: Roman Li <roman.li@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 .../dc/clk_mgr/dcn314/dcn314_clk_mgr.c        | 751 ++++++++++++++++++
 .../dc/clk_mgr/dcn314/dcn314_clk_mgr.h        |  57 ++
 .../display/dc/clk_mgr/dcn314/dcn314_smu.c    | 391 +++++++++
 .../display/dc/clk_mgr/dcn314/dcn314_smu.h    |  79 ++
 4 files changed, 1278 insertions(+)
 create mode 100644 drivers/gpu/drm/amd/display/dc/clk_mgr/dcn314/dcn314_clk_mgr.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/clk_mgr/dcn314/dcn314_clk_mgr.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/clk_mgr/dcn314/dcn314_smu.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/clk_mgr/dcn314/dcn314_smu.h

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn314/dcn314_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn314/dcn314_clk_mgr.c
new file mode 100644
index 000000000000..df6dd8465272
--- /dev/null
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn314/dcn314_clk_mgr.c
@@ -0,0 +1,751 @@
+// SPDX-License-Identifier: MIT
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
+ * Authors: AMD
+ *
+ */
+
+
+
+#include "dcn314_clk_mgr.h"
+
+#include "dccg.h"
+#include "clk_mgr_internal.h"
+
+// For dce12_get_dp_ref_freq_khz
+#include "dce100/dce_clk_mgr.h"
+
+// For dcn20_update_clocks_update_dpp_dto
+#include "dcn20/dcn20_clk_mgr.h"
+
+
+
+#include "reg_helper.h"
+#include "core_types.h"
+#include "dm_helpers.h"
+
+/* TODO: remove this include once we ported over remaining clk mgr functions*/
+#include "dcn30/dcn30_clk_mgr.h"
+#include "dcn31/dcn31_clk_mgr.h"
+
+#include "dc_dmub_srv.h"
+#include "dc_link_dp.h"
+#include "dcn314_smu.h"
+
+#define MAX_INSTANCE                                        7
+#define MAX_SEGMENT                                         8
+
+struct IP_BASE_INSTANCE {
+	unsigned int segment[MAX_SEGMENT];
+};
+
+struct IP_BASE {
+	struct IP_BASE_INSTANCE instance[MAX_INSTANCE];
+};
+
+static const struct IP_BASE CLK_BASE = { { { { 0x00016C00, 0x02401800, 0, 0, 0, 0, 0, 0 } },
+					{ { 0x00016E00, 0x02401C00, 0, 0, 0, 0, 0, 0 } },
+					{ { 0x00017000, 0x02402000, 0, 0, 0, 0, 0, 0 } },
+					{ { 0x00017200, 0x02402400, 0, 0, 0, 0, 0, 0 } },
+					{ { 0x0001B000, 0x0242D800, 0, 0, 0, 0, 0, 0 } },
+					{ { 0x0001B200, 0x0242DC00, 0, 0, 0, 0, 0, 0 } },
+					{ { 0x0001B400, 0x0242E000, 0, 0, 0, 0, 0, 0 } } } };
+
+#define regCLK1_CLK_PLL_REQ			0x0237
+#define regCLK1_CLK_PLL_REQ_BASE_IDX		0
+
+#define CLK1_CLK_PLL_REQ__FbMult_int__SHIFT	0x0
+#define CLK1_CLK_PLL_REQ__PllSpineDiv__SHIFT	0xc
+#define CLK1_CLK_PLL_REQ__FbMult_frac__SHIFT	0x10
+#define CLK1_CLK_PLL_REQ__FbMult_int_MASK	0x000001FFL
+#define CLK1_CLK_PLL_REQ__PllSpineDiv_MASK	0x0000F000L
+#define CLK1_CLK_PLL_REQ__FbMult_frac_MASK	0xFFFF0000L
+
+#define REG(reg_name) \
+	(CLK_BASE.instance[0].segment[reg ## reg_name ## _BASE_IDX] + reg ## reg_name)
+
+#define TO_CLK_MGR_DCN314(clk_mgr)\
+	container_of(clk_mgr, struct clk_mgr_dcn314, base)
+
+static int dcn314_get_active_display_cnt_wa(
+		struct dc *dc,
+		struct dc_state *context)
+{
+	int i, display_count;
+	bool tmds_present = false;
+
+	display_count = 0;
+	for (i = 0; i < context->stream_count; i++) {
+		const struct dc_stream_state *stream = context->streams[i];
+
+		if (stream->signal == SIGNAL_TYPE_HDMI_TYPE_A ||
+				stream->signal == SIGNAL_TYPE_DVI_SINGLE_LINK ||
+				stream->signal == SIGNAL_TYPE_DVI_DUAL_LINK)
+			tmds_present = true;
+	}
+
+	for (i = 0; i < dc->link_count; i++) {
+		const struct dc_link *link = dc->links[i];
+
+		/* abusing the fact that the dig and phy are coupled to see if the phy is enabled */
+		if (link->link_enc && link->link_enc->funcs->is_dig_enabled &&
+				link->link_enc->funcs->is_dig_enabled(link->link_enc))
+			display_count++;
+	}
+
+	/* WA for hang on HDMI after display off back on*/
+	if (display_count == 0 && tmds_present)
+		display_count = 1;
+
+	return display_count;
+}
+
+static void dcn314_disable_otg_wa(struct clk_mgr *clk_mgr_base, bool disable)
+{
+	struct dc *dc = clk_mgr_base->ctx->dc;
+	int i;
+
+	for (i = 0; i < dc->res_pool->pipe_count; ++i) {
+		struct pipe_ctx *pipe = &dc->current_state->res_ctx.pipe_ctx[i];
+
+		if (pipe->top_pipe || pipe->prev_odm_pipe)
+			continue;
+		if (pipe->stream && (pipe->stream->dpms_off || pipe->plane_state == NULL ||
+				     dc_is_virtual_signal(pipe->stream->signal))) {
+			if (disable)
+				pipe->stream_res.tg->funcs->immediate_disable_crtc(pipe->stream_res.tg);
+			else
+				pipe->stream_res.tg->funcs->enable_crtc(pipe->stream_res.tg);
+		}
+	}
+}
+
+void dcn314_update_clocks(struct clk_mgr *clk_mgr_base,
+			struct dc_state *context,
+			bool safe_to_lower)
+{
+	union dmub_rb_cmd cmd;
+	struct clk_mgr_internal *clk_mgr = TO_CLK_MGR_INTERNAL(clk_mgr_base);
+	struct dc_clocks *new_clocks = &context->bw_ctx.bw.dcn.clk;
+	struct dc *dc = clk_mgr_base->ctx->dc;
+	int display_count;
+	bool update_dppclk = false;
+	bool update_dispclk = false;
+	bool dpp_clock_lowered = false;
+
+	if (dc->work_arounds.skip_clock_update)
+		return;
+
+	/*
+	 * if it is safe to lower, but we are already in the lower state, we don't have to do anything
+	 * also if safe to lower is false, we just go in the higher state
+	 */
+	if (safe_to_lower) {
+		if (new_clocks->zstate_support != DCN_ZSTATE_SUPPORT_DISALLOW &&
+				new_clocks->zstate_support != clk_mgr_base->clks.zstate_support) {
+			dcn314_smu_set_zstate_support(clk_mgr, new_clocks->zstate_support);
+			dm_helpers_enable_periodic_detection(clk_mgr_base->ctx, true);
+			clk_mgr_base->clks.zstate_support = new_clocks->zstate_support;
+		}
+
+		if (clk_mgr_base->clks.dtbclk_en && !new_clocks->dtbclk_en) {
+			dcn314_smu_set_dtbclk(clk_mgr, false);
+			clk_mgr_base->clks.dtbclk_en = new_clocks->dtbclk_en;
+		}
+		/* check that we're not already in lower */
+		if (clk_mgr_base->clks.pwr_state != DCN_PWR_STATE_LOW_POWER) {
+			display_count = dcn314_get_active_display_cnt_wa(dc, context);
+			/* if we can go lower, go lower */
+			if (display_count == 0) {
+				union display_idle_optimization_u idle_info = { 0 };
+				idle_info.idle_info.df_request_disabled = 1;
+				idle_info.idle_info.phy_ref_clk_off = 1;
+				idle_info.idle_info.s0i2_rdy = 1;
+				dcn314_smu_set_display_idle_optimization(clk_mgr, idle_info.data);
+				/* update power state */
+				clk_mgr_base->clks.pwr_state = DCN_PWR_STATE_LOW_POWER;
+			}
+		}
+	} else {
+		if (new_clocks->zstate_support == DCN_ZSTATE_SUPPORT_DISALLOW &&
+				new_clocks->zstate_support != clk_mgr_base->clks.zstate_support) {
+			dcn314_smu_set_zstate_support(clk_mgr, DCN_ZSTATE_SUPPORT_DISALLOW);
+			dm_helpers_enable_periodic_detection(clk_mgr_base->ctx, false);
+			clk_mgr_base->clks.zstate_support = new_clocks->zstate_support;
+		}
+
+		if (!clk_mgr_base->clks.dtbclk_en && new_clocks->dtbclk_en) {
+			dcn314_smu_set_dtbclk(clk_mgr, true);
+			clk_mgr_base->clks.dtbclk_en = new_clocks->dtbclk_en;
+		}
+
+		/* check that we're not already in D0 */
+		if (clk_mgr_base->clks.pwr_state != DCN_PWR_STATE_MISSION_MODE) {
+			union display_idle_optimization_u idle_info = { 0 };
+
+			dcn314_smu_set_display_idle_optimization(clk_mgr, idle_info.data);
+			/* update power state */
+			clk_mgr_base->clks.pwr_state = DCN_PWR_STATE_MISSION_MODE;
+		}
+	}
+
+	if (should_set_clock(safe_to_lower, new_clocks->dcfclk_khz, clk_mgr_base->clks.dcfclk_khz)) {
+		clk_mgr_base->clks.dcfclk_khz = new_clocks->dcfclk_khz;
+		dcn314_smu_set_hard_min_dcfclk(clk_mgr, clk_mgr_base->clks.dcfclk_khz);
+	}
+
+	if (should_set_clock(safe_to_lower,
+			new_clocks->dcfclk_deep_sleep_khz, clk_mgr_base->clks.dcfclk_deep_sleep_khz)) {
+		clk_mgr_base->clks.dcfclk_deep_sleep_khz = new_clocks->dcfclk_deep_sleep_khz;
+		dcn314_smu_set_min_deep_sleep_dcfclk(clk_mgr, clk_mgr_base->clks.dcfclk_deep_sleep_khz);
+	}
+
+	// workaround: Limit dppclk to 100Mhz to avoid lower eDP panel switch to plus 4K monitor underflow.
+	if (!IS_DIAG_DC(dc->ctx->dce_environment)) {
+		if (new_clocks->dppclk_khz < 100000)
+			new_clocks->dppclk_khz = 100000;
+	}
+
+	if (should_set_clock(safe_to_lower, new_clocks->dppclk_khz, clk_mgr->base.clks.dppclk_khz)) {
+		if (clk_mgr->base.clks.dppclk_khz > new_clocks->dppclk_khz)
+			dpp_clock_lowered = true;
+		clk_mgr_base->clks.dppclk_khz = new_clocks->dppclk_khz;
+		update_dppclk = true;
+	}
+
+	if (should_set_clock(safe_to_lower, new_clocks->dispclk_khz, clk_mgr_base->clks.dispclk_khz)) {
+		dcn314_disable_otg_wa(clk_mgr_base, true);
+
+		clk_mgr_base->clks.dispclk_khz = new_clocks->dispclk_khz;
+		dcn314_smu_set_dispclk(clk_mgr, clk_mgr_base->clks.dispclk_khz);
+		dcn314_disable_otg_wa(clk_mgr_base, false);
+
+		update_dispclk = true;
+	}
+
+	if (dpp_clock_lowered) {
+		// increase per DPP DTO before lowering global dppclk
+		dcn20_update_clocks_update_dpp_dto(clk_mgr, context, safe_to_lower);
+		dcn314_smu_set_dppclk(clk_mgr, clk_mgr_base->clks.dppclk_khz);
+	} else {
+		// increase global DPPCLK before lowering per DPP DTO
+		if (update_dppclk || update_dispclk)
+			dcn314_smu_set_dppclk(clk_mgr, clk_mgr_base->clks.dppclk_khz);
+		// always update dtos unless clock is lowered and not safe to lower
+		if (new_clocks->dppclk_khz >= dc->current_state->bw_ctx.bw.dcn.clk.dppclk_khz)
+			dcn20_update_clocks_update_dpp_dto(clk_mgr, context, safe_to_lower);
+	}
+
+	// notify DMCUB of latest clocks
+	memset(&cmd, 0, sizeof(cmd));
+	cmd.notify_clocks.header.type = DMUB_CMD__CLK_MGR;
+	cmd.notify_clocks.header.sub_type = DMUB_CMD__CLK_MGR_NOTIFY_CLOCKS;
+	cmd.notify_clocks.clocks.dcfclk_khz = clk_mgr_base->clks.dcfclk_khz;
+	cmd.notify_clocks.clocks.dcfclk_deep_sleep_khz =
+		clk_mgr_base->clks.dcfclk_deep_sleep_khz;
+	cmd.notify_clocks.clocks.dispclk_khz = clk_mgr_base->clks.dispclk_khz;
+	cmd.notify_clocks.clocks.dppclk_khz = clk_mgr_base->clks.dppclk_khz;
+
+	dc_dmub_srv_cmd_queue(dc->ctx->dmub_srv, &cmd);
+	dc_dmub_srv_cmd_execute(dc->ctx->dmub_srv);
+	dc_dmub_srv_wait_idle(dc->ctx->dmub_srv);
+}
+
+static int get_vco_frequency_from_reg(struct clk_mgr_internal *clk_mgr)
+{
+	/* get FbMult value */
+	struct fixed31_32 pll_req;
+	unsigned int fbmult_frac_val = 0;
+	unsigned int fbmult_int_val = 0;
+
+	/*
+	 * Register value of fbmult is in 8.16 format, we are converting to 314.32
+	 * to leverage the fix point operations available in driver
+	 */
+
+	REG_GET(CLK1_CLK_PLL_REQ, FbMult_frac, &fbmult_frac_val); /* 16 bit fractional part*/
+	REG_GET(CLK1_CLK_PLL_REQ, FbMult_int, &fbmult_int_val); /* 8 bit integer part */
+
+	pll_req = dc_fixpt_from_int(fbmult_int_val);
+
+	/*
+	 * since fractional part is only 16 bit in register definition but is 32 bit
+	 * in our fix point definiton, need to shift left by 16 to obtain correct value
+	 */
+	pll_req.value |= fbmult_frac_val << 16;
+
+	/* multiply by REFCLK period */
+	pll_req = dc_fixpt_mul_int(pll_req, clk_mgr->dfs_ref_freq_khz);
+
+	/* integer part is now VCO frequency in kHz */
+	return dc_fixpt_floor(pll_req);
+}
+
+static void dcn314_enable_pme_wa(struct clk_mgr *clk_mgr_base)
+{
+	struct clk_mgr_internal *clk_mgr = TO_CLK_MGR_INTERNAL(clk_mgr_base);
+
+	dcn314_smu_enable_pme_wa(clk_mgr);
+}
+
+void dcn314_init_clocks(struct clk_mgr *clk_mgr)
+{
+	memset(&(clk_mgr->clks), 0, sizeof(struct dc_clocks));
+	// Assumption is that boot state always supports pstate
+	clk_mgr->clks.p_state_change_support = true;
+	clk_mgr->clks.prev_p_state_change_support = true;
+	clk_mgr->clks.pwr_state = DCN_PWR_STATE_UNKNOWN;
+	clk_mgr->clks.zstate_support = DCN_ZSTATE_SUPPORT_UNKNOWN;
+}
+
+bool dcn314_are_clock_states_equal(struct dc_clocks *a,
+		struct dc_clocks *b)
+{
+	if (a->dispclk_khz != b->dispclk_khz)
+		return false;
+	else if (a->dppclk_khz != b->dppclk_khz)
+		return false;
+	else if (a->dcfclk_khz != b->dcfclk_khz)
+		return false;
+	else if (a->dcfclk_deep_sleep_khz != b->dcfclk_deep_sleep_khz)
+		return false;
+	else if (a->zstate_support != b->zstate_support)
+		return false;
+	else if (a->dtbclk_en != b->dtbclk_en)
+		return false;
+
+	return true;
+}
+
+static void dcn314_dump_clk_registers(struct clk_state_registers_and_bypass *regs_and_bypass,
+		struct clk_mgr *clk_mgr_base, struct clk_log_info *log_info)
+{
+	return;
+}
+
+static struct clk_bw_params dcn314_bw_params = {
+	.vram_type = Ddr4MemType,
+	.num_channels = 1,
+	.clk_table = {
+		.num_entries = 4,
+	},
+
+};
+
+static struct wm_table ddr5_wm_table = {
+	.entries = {
+		{
+			.wm_inst = WM_A,
+			.wm_type = WM_TYPE_PSTATE_CHG,
+			.pstate_latency_us = 11.72,
+			.sr_exit_time_us = 9,
+			.sr_enter_plus_exit_time_us = 11,
+			.valid = true,
+		},
+		{
+			.wm_inst = WM_B,
+			.wm_type = WM_TYPE_PSTATE_CHG,
+			.pstate_latency_us = 11.72,
+			.sr_exit_time_us = 9,
+			.sr_enter_plus_exit_time_us = 11,
+			.valid = true,
+		},
+		{
+			.wm_inst = WM_C,
+			.wm_type = WM_TYPE_PSTATE_CHG,
+			.pstate_latency_us = 11.72,
+			.sr_exit_time_us = 9,
+			.sr_enter_plus_exit_time_us = 11,
+			.valid = true,
+		},
+		{
+			.wm_inst = WM_D,
+			.wm_type = WM_TYPE_PSTATE_CHG,
+			.pstate_latency_us = 11.72,
+			.sr_exit_time_us = 9,
+			.sr_enter_plus_exit_time_us = 11,
+			.valid = true,
+		},
+	}
+};
+
+static struct wm_table lpddr5_wm_table = {
+	.entries = {
+		{
+			.wm_inst = WM_A,
+			.wm_type = WM_TYPE_PSTATE_CHG,
+			.pstate_latency_us = 11.65333,
+			.sr_exit_time_us = 11.5,
+			.sr_enter_plus_exit_time_us = 14.5,
+			.valid = true,
+		},
+		{
+			.wm_inst = WM_B,
+			.wm_type = WM_TYPE_PSTATE_CHG,
+			.pstate_latency_us = 11.65333,
+			.sr_exit_time_us = 11.5,
+			.sr_enter_plus_exit_time_us = 14.5,
+			.valid = true,
+		},
+		{
+			.wm_inst = WM_C,
+			.wm_type = WM_TYPE_PSTATE_CHG,
+			.pstate_latency_us = 11.65333,
+			.sr_exit_time_us = 11.5,
+			.sr_enter_plus_exit_time_us = 14.5,
+			.valid = true,
+		},
+		{
+			.wm_inst = WM_D,
+			.wm_type = WM_TYPE_PSTATE_CHG,
+			.pstate_latency_us = 11.65333,
+			.sr_exit_time_us = 11.5,
+			.sr_enter_plus_exit_time_us = 14.5,
+			.valid = true,
+		},
+	}
+};
+
+static DpmClocks_t dummy_clocks;
+
+static struct dcn314_watermarks dummy_wms = { 0 };
+
+static void dcn314_build_watermark_ranges(struct clk_bw_params *bw_params, struct dcn314_watermarks *table)
+{
+	int i, num_valid_sets;
+
+	num_valid_sets = 0;
+
+	for (i = 0; i < WM_SET_COUNT; i++) {
+		/* skip empty entries, the smu array has no holes*/
+		if (!bw_params->wm_table.entries[i].valid)
+			continue;
+
+		table->WatermarkRow[WM_DCFCLK][num_valid_sets].WmSetting = bw_params->wm_table.entries[i].wm_inst;
+		table->WatermarkRow[WM_DCFCLK][num_valid_sets].WmType = bw_params->wm_table.entries[i].wm_type;
+		/* We will not select WM based on fclk, so leave it as unconstrained */
+		table->WatermarkRow[WM_DCFCLK][num_valid_sets].MinClock = 0;
+		table->WatermarkRow[WM_DCFCLK][num_valid_sets].MaxClock = 0xFFFF;
+
+		if (table->WatermarkRow[WM_DCFCLK][num_valid_sets].WmType == WM_TYPE_PSTATE_CHG) {
+			if (i == 0)
+				table->WatermarkRow[WM_DCFCLK][num_valid_sets].MinMclk = 0;
+			else {
+				/* add 1 to make it non-overlapping with next lvl */
+				table->WatermarkRow[WM_DCFCLK][num_valid_sets].MinMclk =
+						bw_params->clk_table.entries[i - 1].dcfclk_mhz + 1;
+			}
+			table->WatermarkRow[WM_DCFCLK][num_valid_sets].MaxMclk =
+					bw_params->clk_table.entries[i].dcfclk_mhz;
+
+		} else {
+			/* unconstrained for memory retraining */
+			table->WatermarkRow[WM_DCFCLK][num_valid_sets].MinClock = 0;
+			table->WatermarkRow[WM_DCFCLK][num_valid_sets].MaxClock = 0xFFFF;
+
+			/* Modify previous watermark range to cover up to max */
+			table->WatermarkRow[WM_DCFCLK][num_valid_sets - 1].MaxClock = 0xFFFF;
+		}
+		num_valid_sets++;
+	}
+
+	ASSERT(num_valid_sets != 0); /* Must have at least one set of valid watermarks */
+
+	/* modify the min and max to make sure we cover the whole range*/
+	table->WatermarkRow[WM_DCFCLK][0].MinMclk = 0;
+	table->WatermarkRow[WM_DCFCLK][0].MinClock = 0;
+	table->WatermarkRow[WM_DCFCLK][num_valid_sets - 1].MaxMclk = 0xFFFF;
+	table->WatermarkRow[WM_DCFCLK][num_valid_sets - 1].MaxClock = 0xFFFF;
+
+	/* This is for writeback only, does not matter currently as no writeback support*/
+	table->WatermarkRow[WM_SOCCLK][0].WmSetting = WM_A;
+	table->WatermarkRow[WM_SOCCLK][0].MinClock = 0;
+	table->WatermarkRow[WM_SOCCLK][0].MaxClock = 0xFFFF;
+	table->WatermarkRow[WM_SOCCLK][0].MinMclk = 0;
+	table->WatermarkRow[WM_SOCCLK][0].MaxMclk = 0xFFFF;
+}
+
+static void dcn314_notify_wm_ranges(struct clk_mgr *clk_mgr_base)
+{
+	struct clk_mgr_internal *clk_mgr = TO_CLK_MGR_INTERNAL(clk_mgr_base);
+	struct clk_mgr_dcn314 *clk_mgr_dcn314 = TO_CLK_MGR_DCN314(clk_mgr);
+	struct dcn314_watermarks *table = clk_mgr_dcn314->smu_wm_set.wm_set;
+
+	if (!clk_mgr->smu_ver)
+		return;
+
+	if (!table || clk_mgr_dcn314->smu_wm_set.mc_address.quad_part == 0)
+		return;
+
+	memset(table, 0, sizeof(*table));
+
+	dcn314_build_watermark_ranges(clk_mgr_base->bw_params, table);
+
+	dcn314_smu_set_dram_addr_high(clk_mgr,
+			clk_mgr_dcn314->smu_wm_set.mc_address.high_part);
+	dcn314_smu_set_dram_addr_low(clk_mgr,
+			clk_mgr_dcn314->smu_wm_set.mc_address.low_part);
+	dcn314_smu_transfer_wm_table_dram_2_smu(clk_mgr);
+}
+
+static void dcn314_get_dpm_table_from_smu(struct clk_mgr_internal *clk_mgr,
+		struct dcn314_smu_dpm_clks *smu_dpm_clks)
+{
+	DpmClocks_t *table = smu_dpm_clks->dpm_clks;
+
+	if (!clk_mgr->smu_ver)
+		return;
+
+	if (!table || smu_dpm_clks->mc_address.quad_part == 0)
+		return;
+
+	memset(table, 0, sizeof(*table));
+
+	dcn314_smu_set_dram_addr_high(clk_mgr,
+			smu_dpm_clks->mc_address.high_part);
+	dcn314_smu_set_dram_addr_low(clk_mgr,
+			smu_dpm_clks->mc_address.low_part);
+	dcn314_smu_transfer_dpm_table_smu_2_dram(clk_mgr);
+}
+
+static uint32_t find_max_clk_value(const uint32_t clocks[], uint32_t num_clocks)
+{
+	uint32_t max = 0;
+	int i;
+
+	for (i = 0; i < num_clocks; ++i) {
+		if (clocks[i] > max)
+			max = clocks[i];
+	}
+
+	return max;
+}
+
+static unsigned int find_clk_for_voltage(
+		const DpmClocks_t *clock_table,
+		const uint32_t clocks[],
+		unsigned int voltage)
+{
+	int i;
+	int max_voltage = 0;
+	int clock = 0;
+
+	for (i = 0; i < NUM_SOC_VOLTAGE_LEVELS; i++) {
+		if (clock_table->SocVoltage[i] == voltage) {
+			return clocks[i];
+		} else if (clock_table->SocVoltage[i] >= max_voltage &&
+				clock_table->SocVoltage[i] < voltage) {
+			max_voltage = clock_table->SocVoltage[i];
+			clock = clocks[i];
+		}
+	}
+
+	ASSERT(clock);
+	return clock;
+}
+
+static void dcn314_clk_mgr_helper_populate_bw_params(struct clk_mgr_internal *clk_mgr,
+						    struct integrated_info *bios_info,
+						    const DpmClocks_t *clock_table)
+{
+	int i, j;
+	struct clk_bw_params *bw_params = clk_mgr->base.bw_params;
+	uint32_t max_dispclk = 0, max_dppclk = 0;
+
+	j = -1;
+
+	ASSERT(NUM_DF_PSTATE_LEVELS <= MAX_NUM_DPM_LVL);
+
+	/* Find lowest DPM, FCLK is filled in reverse order*/
+
+	for (i = NUM_DF_PSTATE_LEVELS - 1; i >= 0; i--) {
+		if (clock_table->DfPstateTable[i].FClk != 0) {
+			j = i;
+			break;
+		}
+	}
+
+	if (j == -1) {
+		/* clock table is all 0s, just use our own hardcode */
+		ASSERT(0);
+		return;
+	}
+
+	bw_params->clk_table.num_entries = j + 1;
+
+	/* dispclk and dppclk can be max at any voltage, same number of levels for both */
+	if (clock_table->NumDispClkLevelsEnabled <= NUM_DISPCLK_DPM_LEVELS &&
+	    clock_table->NumDispClkLevelsEnabled <= NUM_DPPCLK_DPM_LEVELS) {
+		max_dispclk = find_max_clk_value(clock_table->DispClocks, clock_table->NumDispClkLevelsEnabled);
+		max_dppclk = find_max_clk_value(clock_table->DppClocks, clock_table->NumDispClkLevelsEnabled);
+	} else {
+		ASSERT(0);
+	}
+
+	for (i = 0; i < bw_params->clk_table.num_entries; i++, j--) {
+		bw_params->clk_table.entries[i].fclk_mhz = clock_table->DfPstateTable[j].FClk;
+		bw_params->clk_table.entries[i].memclk_mhz = clock_table->DfPstateTable[j].MemClk;
+		bw_params->clk_table.entries[i].voltage = clock_table->DfPstateTable[j].Voltage;
+		switch (clock_table->DfPstateTable[j].WckRatio) {
+		case WCK_RATIO_1_2:
+			bw_params->clk_table.entries[i].wck_ratio = 2;
+			break;
+		case WCK_RATIO_1_4:
+			bw_params->clk_table.entries[i].wck_ratio = 4;
+			break;
+		default:
+			bw_params->clk_table.entries[i].wck_ratio = 1;
+		}
+		bw_params->clk_table.entries[i].dcfclk_mhz = find_clk_for_voltage(clock_table, clock_table->DcfClocks, clock_table->DfPstateTable[j].Voltage);
+		bw_params->clk_table.entries[i].socclk_mhz = find_clk_for_voltage(clock_table, clock_table->SocClocks, clock_table->DfPstateTable[j].Voltage);
+		bw_params->clk_table.entries[i].dispclk_mhz = max_dispclk;
+		bw_params->clk_table.entries[i].dppclk_mhz = max_dppclk;
+	}
+
+	bw_params->vram_type = bios_info->memory_type;
+	bw_params->num_channels = bios_info->ma_channel_number;
+
+	for (i = 0; i < WM_SET_COUNT; i++) {
+		bw_params->wm_table.entries[i].wm_inst = i;
+
+		if (i >= bw_params->clk_table.num_entries) {
+			bw_params->wm_table.entries[i].valid = false;
+			continue;
+		}
+
+		bw_params->wm_table.entries[i].wm_type = WM_TYPE_PSTATE_CHG;
+		bw_params->wm_table.entries[i].valid = true;
+	}
+}
+
+static struct clk_mgr_funcs dcn314_funcs = {
+	.get_dp_ref_clk_frequency = dce12_get_dp_ref_freq_khz,
+	.get_dtb_ref_clk_frequency = dcn31_get_dtb_ref_freq_khz,
+	.update_clocks = dcn314_update_clocks,
+	.init_clocks = dcn314_init_clocks,
+	.enable_pme_wa = dcn314_enable_pme_wa,
+	.are_clock_states_equal = dcn314_are_clock_states_equal,
+	.notify_wm_ranges = dcn314_notify_wm_ranges
+};
+extern struct clk_mgr_funcs dcn3_fpga_funcs;
+
+void dcn314_clk_mgr_construct(
+		struct dc_context *ctx,
+		struct clk_mgr_dcn314 *clk_mgr,
+		struct pp_smu_funcs *pp_smu,
+		struct dccg *dccg)
+{
+	struct dcn314_smu_dpm_clks smu_dpm_clks = { 0 };
+
+	clk_mgr->base.base.ctx = ctx;
+	clk_mgr->base.base.funcs = &dcn314_funcs;
+
+	clk_mgr->base.pp_smu = pp_smu;
+
+	clk_mgr->base.dccg = dccg;
+	clk_mgr->base.dfs_bypass_disp_clk = 0;
+
+	clk_mgr->base.dprefclk_ss_percentage = 0;
+	clk_mgr->base.dprefclk_ss_divider = 1000;
+	clk_mgr->base.ss_on_dprefclk = false;
+	clk_mgr->base.dfs_ref_freq_khz = 48000;
+
+	clk_mgr->smu_wm_set.wm_set = (struct dcn314_watermarks *)dm_helpers_allocate_gpu_mem(
+				clk_mgr->base.base.ctx,
+				DC_MEM_ALLOC_TYPE_FRAME_BUFFER,
+				sizeof(struct dcn314_watermarks),
+				&clk_mgr->smu_wm_set.mc_address.quad_part);
+
+	if (!clk_mgr->smu_wm_set.wm_set) {
+		clk_mgr->smu_wm_set.wm_set = &dummy_wms;
+		clk_mgr->smu_wm_set.mc_address.quad_part = 0;
+	}
+	ASSERT(clk_mgr->smu_wm_set.wm_set);
+
+	smu_dpm_clks.dpm_clks = (DpmClocks_t *)dm_helpers_allocate_gpu_mem(
+				clk_mgr->base.base.ctx,
+				DC_MEM_ALLOC_TYPE_FRAME_BUFFER,
+				sizeof(DpmClocks_t),
+				&smu_dpm_clks.mc_address.quad_part);
+
+	if (smu_dpm_clks.dpm_clks == NULL) {
+		smu_dpm_clks.dpm_clks = &dummy_clocks;
+		smu_dpm_clks.mc_address.quad_part = 0;
+	}
+
+	ASSERT(smu_dpm_clks.dpm_clks);
+
+	if (IS_FPGA_MAXIMUS_DC(ctx->dce_environment)) {
+		clk_mgr->base.base.funcs = &dcn3_fpga_funcs;
+	} else {
+		struct clk_log_info log_info = {0};
+
+		clk_mgr->base.smu_ver = dcn314_smu_get_smu_version(&clk_mgr->base);
+
+		if (clk_mgr->base.smu_ver)
+			clk_mgr->base.smu_present = true;
+
+		/* TODO: Check we get what we expect during bringup */
+		clk_mgr->base.base.dentist_vco_freq_khz = get_vco_frequency_from_reg(&clk_mgr->base);
+
+		if (ctx->dc_bios->integrated_info->memory_type == LpDdr5MemType)
+			dcn314_bw_params.wm_table = lpddr5_wm_table;
+		else
+			dcn314_bw_params.wm_table = ddr5_wm_table;
+
+		/* Saved clocks configured at boot for debug purposes */
+		 dcn314_dump_clk_registers(&clk_mgr->base.base.boot_snapshot, &clk_mgr->base.base, &log_info);
+
+	}
+
+	clk_mgr->base.base.dprefclk_khz = 600000;
+	clk_mgr->base.base.clks.ref_dtbclk_khz = 600000;
+	dce_clock_read_ss_info(&clk_mgr->base);
+	/*if bios enabled SS, driver needs to adjust dtb clock, only enable with correct bios*/
+	//clk_mgr->base.dccg->ref_dtbclk_khz = dce_adjust_dp_ref_freq_for_ss(clk_mgr_internal, clk_mgr->base.base.dprefclk_khz);
+
+	clk_mgr->base.base.bw_params = &dcn314_bw_params;
+
+	if (clk_mgr->base.base.ctx->dc->debug.pstate_enabled) {
+		dcn314_get_dpm_table_from_smu(&clk_mgr->base, &smu_dpm_clks);
+
+		if (ctx->dc_bios && ctx->dc_bios->integrated_info) {
+			dcn314_clk_mgr_helper_populate_bw_params(
+					&clk_mgr->base,
+					ctx->dc_bios->integrated_info,
+					smu_dpm_clks.dpm_clks);
+		}
+	}
+
+	if (smu_dpm_clks.dpm_clks && smu_dpm_clks.mc_address.quad_part != 0)
+		dm_helpers_free_gpu_mem(clk_mgr->base.base.ctx, DC_MEM_ALLOC_TYPE_FRAME_BUFFER,
+				smu_dpm_clks.dpm_clks);
+}
+
+void dcn314_clk_mgr_destroy(struct clk_mgr_internal *clk_mgr_int)
+{
+	struct clk_mgr_dcn314 *clk_mgr = TO_CLK_MGR_DCN314(clk_mgr_int);
+
+	if (clk_mgr->smu_wm_set.wm_set && clk_mgr->smu_wm_set.mc_address.quad_part != 0)
+		dm_helpers_free_gpu_mem(clk_mgr_int->base.ctx, DC_MEM_ALLOC_TYPE_FRAME_BUFFER,
+				clk_mgr->smu_wm_set.wm_set);
+}
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn314/dcn314_clk_mgr.h b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn314/dcn314_clk_mgr.h
new file mode 100644
index 000000000000..c695a4498c50
--- /dev/null
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn314/dcn314_clk_mgr.h
@@ -0,0 +1,57 @@
+/* SPDX-License-Identifier: MIT */
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
+ * Authors: AMD
+ *
+ */
+
+#ifndef __DCN314_CLK_MGR_H__
+#define __DCN314_CLK_MGR_H__
+#include "clk_mgr_internal.h"
+
+struct dcn314_watermarks;
+
+struct dcn314_smu_watermark_set {
+	struct dcn314_watermarks *wm_set;
+	union large_integer mc_address;
+};
+
+struct clk_mgr_dcn314 {
+	struct clk_mgr_internal base;
+	struct dcn314_smu_watermark_set smu_wm_set;
+};
+
+bool dcn314_are_clock_states_equal(struct dc_clocks *a,
+		struct dc_clocks *b);
+void dcn314_init_clocks(struct clk_mgr *clk_mgr);
+void dcn314_update_clocks(struct clk_mgr *clk_mgr_base,
+			struct dc_state *context,
+			bool safe_to_lower);
+
+void dcn314_clk_mgr_construct(struct dc_context *ctx,
+		struct clk_mgr_dcn314 *clk_mgr,
+		struct pp_smu_funcs *pp_smu,
+		struct dccg *dccg);
+
+void dcn314_clk_mgr_destroy(struct clk_mgr_internal *clk_mgr_int);
+
+#endif //__DCN314_CLK_MGR_H__
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn314/dcn314_smu.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn314/dcn314_smu.c
new file mode 100644
index 000000000000..897105d1c111
--- /dev/null
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn314/dcn314_smu.c
@@ -0,0 +1,391 @@
+// SPDX-License-Identifier: MIT
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
+ * Authors: AMD
+ *
+ */
+
+
+
+#include "core_types.h"
+#include "clk_mgr_internal.h"
+#include "reg_helper.h"
+#include "dm_helpers.h"
+#include "dcn314_smu.h"
+
+#include "mp/mp_13_0_5_offset.h"
+
+/* TODO: Use the real headers when they're correct */
+#define MP1_BASE__INST0_SEG0                       0x00016000
+#define MP1_BASE__INST0_SEG1                       0x0243FC00
+#define MP1_BASE__INST0_SEG2                       0x00DC0000
+#define MP1_BASE__INST0_SEG3                       0x00E00000
+#define MP1_BASE__INST0_SEG4                       0x00E40000
+#define MP1_BASE__INST0_SEG5                       0
+
+#ifdef BASE_INNER
+#undef BASE_INNER
+#endif
+
+#define BASE_INNER(seg) MP1_BASE__INST0_SEG ## seg
+
+#define BASE(seg) BASE_INNER(seg)
+
+#define REG(reg_name) (BASE(reg##reg_name##_BASE_IDX) + reg##reg_name)
+
+#define FN(reg_name, field) \
+	FD(reg_name##__##field)
+
+#include "logger_types.h"
+#undef DC_LOGGER
+#define DC_LOGGER \
+	CTX->logger
+#define smu_print(str, ...) {DC_LOG_SMU(str, ##__VA_ARGS__); }
+
+#define VBIOSSMC_MSG_TestMessage                  0x1
+#define VBIOSSMC_MSG_GetSmuVersion                0x2
+#define VBIOSSMC_MSG_PowerUpGfx                   0x3
+#define VBIOSSMC_MSG_SetDispclkFreq               0x4
+#define VBIOSSMC_MSG_SetDprefclkFreq              0x5   //Not used. DPRef is constant
+#define VBIOSSMC_MSG_SetDppclkFreq                0x6
+#define VBIOSSMC_MSG_SetHardMinDcfclkByFreq       0x7
+#define VBIOSSMC_MSG_SetMinDeepSleepDcfclk        0x8
+#define VBIOSSMC_MSG_SetPhyclkVoltageByFreq       0x9	//Keep it in case VMIN dees not support phy clk
+#define VBIOSSMC_MSG_GetFclkFrequency             0xA
+#define VBIOSSMC_MSG_SetDisplayCount              0xB   //Not used anymore
+#define VBIOSSMC_MSG_EnableTmdp48MHzRefclkPwrDown 0xC   //Not used anymore
+#define VBIOSSMC_MSG_UpdatePmeRestore             0xD
+#define VBIOSSMC_MSG_SetVbiosDramAddrHigh         0xE   //Used for WM table txfr
+#define VBIOSSMC_MSG_SetVbiosDramAddrLow          0xF
+#define VBIOSSMC_MSG_TransferTableSmu2Dram        0x10
+#define VBIOSSMC_MSG_TransferTableDram2Smu        0x11
+#define VBIOSSMC_MSG_SetDisplayIdleOptimizations  0x12
+#define VBIOSSMC_MSG_GetDprefclkFreq              0x13
+#define VBIOSSMC_MSG_GetDtbclkFreq                0x14
+#define VBIOSSMC_MSG_AllowZstatesEntry            0x15
+#define VBIOSSMC_MSG_DisallowZstatesEntry	  0x16
+#define VBIOSSMC_MSG_SetDtbClk                    0x17
+#define VBIOSSMC_Message_Count                    0x18
+
+#define VBIOSSMC_Status_BUSY                      0x0
+#define VBIOSSMC_Result_OK                        0x1
+#define VBIOSSMC_Result_Failed                    0xFF
+#define VBIOSSMC_Result_UnknownCmd                0xFE
+#define VBIOSSMC_Result_CmdRejectedPrereq         0xFD
+#define VBIOSSMC_Result_CmdRejectedBusy           0xFC
+
+/*
+ * Function to be used instead of REG_WAIT macro because the wait ends when
+ * the register is NOT EQUAL to zero, and because the translation in msg_if.h
+ * won't work with REG_WAIT.
+ */
+static uint32_t dcn314_smu_wait_for_response(struct clk_mgr_internal *clk_mgr, unsigned int delay_us, unsigned int max_retries)
+{
+	uint32_t res_val = VBIOSSMC_Status_BUSY;
+
+	do {
+		res_val = REG_READ(MP1_SMN_C2PMSG_91);
+		if (res_val != VBIOSSMC_Status_BUSY)
+			break;
+
+		if (delay_us >= 1000)
+			msleep(delay_us/1000);
+		else if (delay_us > 0)
+			udelay(delay_us);
+	} while (max_retries--);
+
+	return res_val;
+}
+
+static int dcn314_smu_send_msg_with_param(struct clk_mgr_internal *clk_mgr,
+					 unsigned int msg_id,
+					 unsigned int param)
+{
+	uint32_t result;
+
+	result = dcn314_smu_wait_for_response(clk_mgr, 10, 200000);
+	ASSERT(result == VBIOSSMC_Result_OK);
+
+	smu_print("SMU response after wait: %d\n", result);
+
+	if (result == VBIOSSMC_Status_BUSY)
+		return -1;
+
+	/* First clear response register */
+	REG_WRITE(MP1_SMN_C2PMSG_91, VBIOSSMC_Status_BUSY);
+
+	/* Set the parameter register for the SMU message, unit is Mhz */
+	REG_WRITE(MP1_SMN_C2PMSG_83, param);
+
+	/* Trigger the message transaction by writing the message ID */
+	REG_WRITE(MP1_SMN_C2PMSG_67, msg_id);
+
+	result = dcn314_smu_wait_for_response(clk_mgr, 10, 200000);
+
+	if (result == VBIOSSMC_Result_Failed) {
+		if (msg_id == VBIOSSMC_MSG_TransferTableDram2Smu &&
+		    param == TABLE_WATERMARKS)
+			DC_LOG_WARNING("Watermarks table not configured properly by SMU");
+		else
+			ASSERT(0);
+		REG_WRITE(MP1_SMN_C2PMSG_91, VBIOSSMC_Result_OK);
+		return -1;
+	}
+
+	if (IS_SMU_TIMEOUT(result)) {
+		ASSERT(0);
+		dm_helpers_smu_timeout(CTX, msg_id, param, 10 * 200000);
+	}
+
+	return REG_READ(MP1_SMN_C2PMSG_83);
+}
+
+int dcn314_smu_get_smu_version(struct clk_mgr_internal *clk_mgr)
+{
+	return dcn314_smu_send_msg_with_param(
+			clk_mgr,
+			VBIOSSMC_MSG_GetSmuVersion,
+			0);
+}
+
+
+int dcn314_smu_set_dispclk(struct clk_mgr_internal *clk_mgr, int requested_dispclk_khz)
+{
+	int actual_dispclk_set_mhz = -1;
+
+	if (!clk_mgr->smu_present)
+		return requested_dispclk_khz;
+
+	/*  Unit of SMU msg parameter is Mhz */
+	actual_dispclk_set_mhz = dcn314_smu_send_msg_with_param(
+			clk_mgr,
+			VBIOSSMC_MSG_SetDispclkFreq,
+			khz_to_mhz_ceil(requested_dispclk_khz));
+
+	return actual_dispclk_set_mhz * 1000;
+}
+
+int dcn314_smu_set_dprefclk(struct clk_mgr_internal *clk_mgr)
+{
+	int actual_dprefclk_set_mhz = -1;
+
+	if (!clk_mgr->smu_present)
+		return clk_mgr->base.dprefclk_khz;
+
+	actual_dprefclk_set_mhz = dcn314_smu_send_msg_with_param(
+			clk_mgr,
+			VBIOSSMC_MSG_SetDprefclkFreq,
+			khz_to_mhz_ceil(clk_mgr->base.dprefclk_khz));
+
+	/* TODO: add code for programing DP DTO, currently this is down by command table */
+
+	return actual_dprefclk_set_mhz * 1000;
+}
+
+int dcn314_smu_set_hard_min_dcfclk(struct clk_mgr_internal *clk_mgr, int requested_dcfclk_khz)
+{
+	int actual_dcfclk_set_mhz = -1;
+
+	if (!clk_mgr->base.ctx->dc->debug.pstate_enabled)
+		return -1;
+
+	if (!clk_mgr->smu_present)
+		return requested_dcfclk_khz;
+
+	actual_dcfclk_set_mhz = dcn314_smu_send_msg_with_param(
+			clk_mgr,
+			VBIOSSMC_MSG_SetHardMinDcfclkByFreq,
+			khz_to_mhz_ceil(requested_dcfclk_khz));
+
+	return actual_dcfclk_set_mhz * 1000;
+}
+
+int dcn314_smu_set_min_deep_sleep_dcfclk(struct clk_mgr_internal *clk_mgr, int requested_min_ds_dcfclk_khz)
+{
+	int actual_min_ds_dcfclk_mhz = -1;
+
+	if (!clk_mgr->base.ctx->dc->debug.pstate_enabled)
+		return -1;
+
+	if (!clk_mgr->smu_present)
+		return requested_min_ds_dcfclk_khz;
+
+	actual_min_ds_dcfclk_mhz = dcn314_smu_send_msg_with_param(
+			clk_mgr,
+			VBIOSSMC_MSG_SetMinDeepSleepDcfclk,
+			khz_to_mhz_ceil(requested_min_ds_dcfclk_khz));
+
+	return actual_min_ds_dcfclk_mhz * 1000;
+}
+
+int dcn314_smu_set_dppclk(struct clk_mgr_internal *clk_mgr, int requested_dpp_khz)
+{
+	int actual_dppclk_set_mhz = -1;
+
+	if (!clk_mgr->smu_present)
+		return requested_dpp_khz;
+
+	actual_dppclk_set_mhz = dcn314_smu_send_msg_with_param(
+			clk_mgr,
+			VBIOSSMC_MSG_SetDppclkFreq,
+			khz_to_mhz_ceil(requested_dpp_khz));
+
+	return actual_dppclk_set_mhz * 1000;
+}
+
+void dcn314_smu_set_display_idle_optimization(struct clk_mgr_internal *clk_mgr, uint32_t idle_info)
+{
+	if (!clk_mgr->base.ctx->dc->debug.pstate_enabled)
+		return;
+
+	if (!clk_mgr->smu_present)
+		return;
+
+	//TODO: Work with smu team to define optimization options.
+	dcn314_smu_send_msg_with_param(
+		clk_mgr,
+		VBIOSSMC_MSG_SetDisplayIdleOptimizations,
+		idle_info);
+}
+
+void dcn314_smu_enable_phy_refclk_pwrdwn(struct clk_mgr_internal *clk_mgr, bool enable)
+{
+	union display_idle_optimization_u idle_info = { 0 };
+
+	if (!clk_mgr->smu_present)
+		return;
+
+	if (enable) {
+		idle_info.idle_info.df_request_disabled = 1;
+		idle_info.idle_info.phy_ref_clk_off = 1;
+	}
+
+	dcn314_smu_send_msg_with_param(
+			clk_mgr,
+			VBIOSSMC_MSG_SetDisplayIdleOptimizations,
+			idle_info.data);
+}
+
+void dcn314_smu_enable_pme_wa(struct clk_mgr_internal *clk_mgr)
+{
+	if (!clk_mgr->smu_present)
+		return;
+
+	dcn314_smu_send_msg_with_param(
+			clk_mgr,
+			VBIOSSMC_MSG_UpdatePmeRestore,
+			0);
+}
+
+void dcn314_smu_set_dram_addr_high(struct clk_mgr_internal *clk_mgr, uint32_t addr_high)
+{
+	if (!clk_mgr->smu_present)
+		return;
+
+	dcn314_smu_send_msg_with_param(clk_mgr,
+			VBIOSSMC_MSG_SetVbiosDramAddrHigh, addr_high);
+}
+
+void dcn314_smu_set_dram_addr_low(struct clk_mgr_internal *clk_mgr, uint32_t addr_low)
+{
+	if (!clk_mgr->smu_present)
+		return;
+
+	dcn314_smu_send_msg_with_param(clk_mgr,
+			VBIOSSMC_MSG_SetVbiosDramAddrLow, addr_low);
+}
+
+void dcn314_smu_transfer_dpm_table_smu_2_dram(struct clk_mgr_internal *clk_mgr)
+{
+	if (!clk_mgr->smu_present)
+		return;
+
+	dcn314_smu_send_msg_with_param(clk_mgr,
+			VBIOSSMC_MSG_TransferTableSmu2Dram, TABLE_DPMCLOCKS);
+}
+
+void dcn314_smu_transfer_wm_table_dram_2_smu(struct clk_mgr_internal *clk_mgr)
+{
+	if (!clk_mgr->smu_present)
+		return;
+
+	dcn314_smu_send_msg_with_param(clk_mgr,
+			VBIOSSMC_MSG_TransferTableDram2Smu, TABLE_WATERMARKS);
+}
+
+void dcn314_smu_set_zstate_support(struct clk_mgr_internal *clk_mgr, enum dcn_zstate_support_state support)
+{
+	unsigned int msg_id, param;
+
+	if (!clk_mgr->smu_present)
+		return;
+
+	if (!clk_mgr->base.ctx->dc->debug.enable_z9_disable_interface &&
+			(support == DCN_ZSTATE_SUPPORT_ALLOW_Z10_ONLY))
+		support = DCN_ZSTATE_SUPPORT_DISALLOW;
+
+
+	// Arg[15:0] = 8/9/0 for Z8/Z9/disallow -> existing bits
+	// Arg[16] = Disallow Z9 -> new bit
+	switch (support) {
+
+	case DCN_ZSTATE_SUPPORT_ALLOW:
+		msg_id = VBIOSSMC_MSG_AllowZstatesEntry;
+		param = 9;
+		break;
+
+	case DCN_ZSTATE_SUPPORT_DISALLOW:
+		msg_id = VBIOSSMC_MSG_AllowZstatesEntry;
+		param = 8;
+		break;
+
+
+	case DCN_ZSTATE_SUPPORT_ALLOW_Z10_ONLY:
+		msg_id = VBIOSSMC_MSG_AllowZstatesEntry;
+		param = 0x00010008;
+		break;
+
+	default: //DCN_ZSTATE_SUPPORT_UNKNOWN
+		msg_id = VBIOSSMC_MSG_AllowZstatesEntry;
+		param = 0;
+		break;
+	}
+
+
+	dcn314_smu_send_msg_with_param(
+		clk_mgr,
+		msg_id,
+		param);
+
+}
+
+/* Arg = 1: Turn DTB on; 0: Turn DTB CLK OFF. when it is on, it is 600MHZ */
+void dcn314_smu_set_dtbclk(struct clk_mgr_internal *clk_mgr, bool enable)
+{
+	if (!clk_mgr->smu_present)
+		return;
+
+	dcn314_smu_send_msg_with_param(
+			clk_mgr,
+			VBIOSSMC_MSG_SetDtbClk,
+			enable);
+}
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn314/dcn314_smu.h b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn314/dcn314_smu.h
new file mode 100644
index 000000000000..a7958dc96581
--- /dev/null
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn314/dcn314_smu.h
@@ -0,0 +1,79 @@
+/* SPDX-License-Identifier: MIT */
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
+ * Authors: AMD
+ *
+ */
+
+#ifndef DAL_DC_314_SMU_H_
+#define DAL_DC_314_SMU_H_
+
+#include "smu13_driver_if_v13_0_4.h"
+
+typedef enum {
+	WCK_RATIO_1_1 = 0,  // DDR5, Wck:ck is always 1:1;
+	WCK_RATIO_1_2,
+	WCK_RATIO_1_4,
+	WCK_RATIO_MAX
+} WCK_RATIO_e;
+
+struct dcn314_watermarks {
+	// Watermarks
+	WatermarkRowGeneric_t WatermarkRow[WM_COUNT][NUM_WM_RANGES];
+	uint32_t MmHubPadding[7]; // SMU internal use
+};
+
+struct dcn314_smu_dpm_clks {
+	DpmClocks_t *dpm_clks;
+	union large_integer mc_address;
+};
+
+struct display_idle_optimization {
+	unsigned int df_request_disabled : 1;
+	unsigned int phy_ref_clk_off     : 1;
+	unsigned int s0i2_rdy            : 1;
+	unsigned int reserved            : 29;
+};
+
+union display_idle_optimization_u {
+	struct display_idle_optimization idle_info;
+	uint32_t data;
+};
+
+int dcn314_smu_get_smu_version(struct clk_mgr_internal *clk_mgr);
+int dcn314_smu_set_dispclk(struct clk_mgr_internal *clk_mgr, int requested_dispclk_khz);
+int dcn314_smu_set_dprefclk(struct clk_mgr_internal *clk_mgr);
+int dcn314_smu_set_hard_min_dcfclk(struct clk_mgr_internal *clk_mgr, int requested_dcfclk_khz);
+int dcn314_smu_set_min_deep_sleep_dcfclk(struct clk_mgr_internal *clk_mgr, int requested_min_ds_dcfclk_khz);
+int dcn314_smu_set_dppclk(struct clk_mgr_internal *clk_mgr, int requested_dpp_khz);
+void dcn314_smu_set_display_idle_optimization(struct clk_mgr_internal *clk_mgr, uint32_t idle_info);
+void dcn314_smu_enable_phy_refclk_pwrdwn(struct clk_mgr_internal *clk_mgr, bool enable);
+void dcn314_smu_enable_pme_wa(struct clk_mgr_internal *clk_mgr);
+void dcn314_smu_set_dram_addr_high(struct clk_mgr_internal *clk_mgr, uint32_t addr_high);
+void dcn314_smu_set_dram_addr_low(struct clk_mgr_internal *clk_mgr, uint32_t addr_low);
+void dcn314_smu_transfer_dpm_table_smu_2_dram(struct clk_mgr_internal *clk_mgr);
+void dcn314_smu_transfer_wm_table_dram_2_smu(struct clk_mgr_internal *clk_mgr);
+
+void dcn314_smu_set_zstate_support(struct clk_mgr_internal *clk_mgr, enum dcn_zstate_support_state support);
+void dcn314_smu_set_dtbclk(struct clk_mgr_internal *clk_mgr, bool enable);
+
+#endif /* DAL_DC_314_SMU_H_ */
-- 
2.35.3

