Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66EEFEB64DB
	for <amd-gfx@archiver.kernel.org>; Thu, 15 Jun 2023 20:40:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3779610E548;
	Thu, 15 Jun 2023 20:40:00 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2069.outbound.protection.outlook.com [40.107.237.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DE9A010E19C
 for <amd-gfx@lists.freedesktop.org>; Thu, 15 Jun 2023 20:39:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NKFtyUkmOB2x5XR0GoAhATTDhGutAOPovvxyD1gXVWcL5jyzGljjo2hZEdBVaNRPyY8PgO20tYw/0jCcRcKAMvIQfkUn7A8vTCP3z3asarsZyCHUxpYzX5tEesqhnrjlzo9OYP7kh2mJqs3mvRQZujF6+NMr/2rPIYqg3FD0jGG3CaIHenj/vQhAUzUSu25LYe01HFgQGPpMqx/mmYc3ggC3A2EQfv+EdrKQmMyIHEjTFpivSsaAZ4lw3UuCZcjXPsQ6lP+4MCdszUnc1MgJ1VZuk2FpBCxne4KezJEiHXOq4aAlKHzFLCPT6YBO/Y2a5kJVtwiJg700UN8aU0gU9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=poTVPdtlroX0gvLClTzQz9+MJhf4pzw7KFoO20tp4d0=;
 b=a6l1BgfVzLjXiC7tTVsMFHrkGT06XgPIL9JNEeEJM6hB/AHIK4MOpZFCmg5ZFAudyI8L+ko64iPOVZ//cp2jvJM7YKwqKFKRu2c9c+gP95JpdxggKlD6hQzGEjj0zec03oMjxF/VqM+cSB8iM/J7MifsWek21nAzW2Mi6kB+oxiOPjfi+ab7q++vGGZ6pl3gCF/9JG47G2QQY1hije0iJyFvaACxkQ7U14w0c7R6MJyGLUD2p0SxJU6KJATiwwsd/t9EUbzg2HP0Sn+iDAKuINsUX3MlIdvDmVBNzZAY1AHpmVeKk4bNhXbxIX/q9GofjrZkji9IuyQwcOq5nJFpfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=poTVPdtlroX0gvLClTzQz9+MJhf4pzw7KFoO20tp4d0=;
 b=Bm1K0Q/3xDCppiOFioLqHR65ep240zWjJEBGHK3v97nZgdB+HTHXOzyNizvh0nfGZvTJTEPLkAMvB7RPiNlTmovRDzy7Hc2xHEjyqFeWa5DxelUojhbNqNrugtQG6B0OkcoB1+g1jMbcBtBGFH+CLm5ARSDyRwkFlm3OBffZjCw=
Received: from CY5PR22CA0047.namprd22.prod.outlook.com (2603:10b6:930:1d::34)
 by PH7PR12MB5902.namprd12.prod.outlook.com (2603:10b6:510:1d6::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.37; Thu, 15 Jun
 2023 20:39:53 +0000
Received: from CY4PEPF0000EDD1.namprd03.prod.outlook.com
 (2603:10b6:930:1d:cafe::b2) by CY5PR22CA0047.outlook.office365.com
 (2603:10b6:930:1d::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.25 via Frontend
 Transport; Thu, 15 Jun 2023 20:39:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CY4PEPF0000EDD1.mail.protection.outlook.com (10.167.241.205) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6500.27 via Frontend Transport; Thu, 15 Jun 2023 20:39:53 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Thu, 15 Jun
 2023 15:39:52 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Thu, 15 Jun
 2023 15:39:52 -0500
Received: from blakha.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.23 via Frontend
 Transport; Thu, 15 Jun 2023 15:39:51 -0500
From: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <harry.wentland@amd.com>,
 <alexander.deucher@amd.com>
Subject: [PATCH 2/6] drm/amd/display: Add Functions to enable Freesync Panel
 Replay
Date: Thu, 15 Jun 2023 16:39:26 -0400
Message-ID: <20230615203930.1715722-3-Bhawanpreet.Lakha@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230615203930.1715722-1-Bhawanpreet.Lakha@amd.com>
References: <20230615203930.1715722-1-Bhawanpreet.Lakha@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD1:EE_|PH7PR12MB5902:EE_
X-MS-Office365-Filtering-Correlation-Id: cf2db340-4634-40d4-096b-08db6de0ac34
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eDGAQ2IOKt4e4v9sCaNh1pJ+IFi/YYen/VURtiYWYthFfQ5bB4xHrJvSk9aY34lWkX6UJB7cbubb9LH9F9qH1f1WjBkCsp2qfD2OfAnrGbQNWO8L0VAjhi2qNX2VwdkOtqUKXX2mtxWCwIPWe5V340k4IQG83E96LSCZZGZOVYryfbkXVE573QbHI2sKi268s48/QfwCfc5fdQg4x/OR+SXL/qAoiF7vRt0VeHCoxwGDYC7DfeXjwn+6iCq2CZZxoIyRZcUzohFXJRRMdQ6CznHI6xtjcXx8o2yKYfR1OeJxRbG5ez/V55FyddWtelt9Z3wKF5g+uY7pPNyRJwNL8G3GOO5tISsi9dC5A6fKo2vJvAxnlxd221ioHDepSLo2wYX1mL7Hdw/ojKqnoBMelkz3rvIl7DiELey2dvSBIakPvK9qGJNB52IX1edFwI9L60+jch4G4//fdMnoHo0/kEeVBbMjs20aQQrz0L0w5E84VF+fVQxZvHjljVQLmV6df/fkCzMdtFhhKjIpKyccd/R0I+fT0eXbU8fGInirB7mJYEZAGiHPlLZldmim2DDKyan6X+6y3RzzRaErkBRgv8nRR+SJlaQYVTJHv1R56bb74Q8OfHj+OQ8l+d/cX6QD5ZFNrd+1mIrHqGwBrkN2+Ezna42qBD0TIBmxyn98rjl/ZMTnzH+t3sazxiT1vYcpRd2xJOmvH/gySIM0p2RZ9lCU2UbVQMu/UuOilgWA+Pn5ij+gQAMyW2E3fp4FBm6qXsPqPOT1fz1rxen8WO+Klw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(396003)(376002)(346002)(136003)(451199021)(46966006)(36840700001)(40470700004)(7696005)(8936002)(26005)(40460700003)(8676002)(41300700001)(36860700001)(478600001)(81166007)(36756003)(82740400003)(356005)(82310400005)(1076003)(6636002)(4326008)(86362001)(70206006)(70586007)(110136005)(316002)(6666004)(40480700001)(30864003)(83380400001)(5660300002)(336012)(186003)(426003)(2616005)(47076005)(2906002)(66899021)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2023 20:39:53.1156 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cf2db340-4634-40d4-096b-08db6de0ac34
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD1.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5902
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
Cc: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Add various functions for replay, such as construct, destroy, enable
get_state, and copy_setting etc. These functions communicate with the
firmware to setup and enable panel replay

Signed-off-by: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dce/Makefile   |   2 +-
 .../gpu/drm/amd/display/dc/dce/dmub_replay.c  | 303 ++++++++++++++++++
 .../gpu/drm/amd/display/dc/dce/dmub_replay.h  |  58 ++++
 .../drm/amd/display/dc/dcn31/dcn31_resource.c |  12 +
 .../amd/display/dc/dcn314/dcn314_resource.c   |  12 +
 drivers/gpu/drm/amd/display/dc/inc/link.h     |  14 +
 .../drm/amd/display/dc/link/link_factory.c    |   7 +
 .../link/protocols/link_edp_panel_control.c   | 165 ++++++++++
 .../link/protocols/link_edp_panel_control.h   |   8 +
 9 files changed, 580 insertions(+), 1 deletion(-)
 create mode 100644 drivers/gpu/drm/amd/display/dc/dce/dmub_replay.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/dce/dmub_replay.h

diff --git a/drivers/gpu/drm/amd/display/dc/dce/Makefile b/drivers/gpu/drm/amd/display/dc/dce/Makefile
index 01490c9ba958..15b64c26d5a2 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/dce/Makefile
@@ -30,7 +30,7 @@ DCE = dce_audio.o dce_stream_encoder.o dce_link_encoder.o dce_hwseq.o \
 dce_mem_input.o dce_clock_source.o dce_scl_filters.o dce_transform.o \
 dce_opp.o dce_dmcu.o dce_abm.o dce_ipp.o dce_aux.o \
 dce_i2c.o dce_i2c_hw.o dce_i2c_sw.o dmub_psr.o dmub_abm.o dmub_abm_lcd.o dce_panel_cntl.o \
-dmub_hw_lock_mgr.o dmub_outbox.o
+dmub_hw_lock_mgr.o dmub_outbox.o dmub_replay.o
 
 AMD_DAL_DCE = $(addprefix $(AMDDALPATH)/dc/dce/,$(DCE))
 
diff --git a/drivers/gpu/drm/amd/display/dc/dce/dmub_replay.c b/drivers/gpu/drm/amd/display/dc/dce/dmub_replay.c
new file mode 100644
index 000000000000..cab7e71fd27f
--- /dev/null
+++ b/drivers/gpu/drm/amd/display/dc/dce/dmub_replay.c
@@ -0,0 +1,303 @@
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
+ * Authors: AMD
+ *
+ */
+
+#include "dc.h"
+#include "dc_dmub_srv.h"
+#include "dmub/dmub_srv.h"
+#include "core_types.h"
+#include "dmub_replay.h"
+
+#define DC_TRACE_LEVEL_MESSAGE(...) /* do nothing */
+
+#define MAX_PIPES 6
+
+/**
+ * Get Replay state from firmware.
+ */
+static void dmub_replay_get_state(struct dmub_replay *dmub, enum replay_state *state, uint8_t panel_inst)
+{
+	struct dmub_srv *srv = dmub->ctx->dmub_srv->dmub;
+	/* uint32_t raw_state = 0; */
+	uint32_t retry_count = 0;
+	enum dmub_status status;
+
+	do {
+		// Send gpint command and wait for ack
+		status = dmub_srv_send_gpint_command(srv, DMUB_GPINT__GET_REPLAY_STATE, panel_inst, 30);
+
+		if (status == DMUB_STATUS_OK) {
+			// GPINT was executed, get response
+			dmub_srv_get_gpint_response(srv, (uint32_t *)state);
+		} else
+			// Return invalid state when GPINT times out
+			*state = REPLAY_STATE_INVALID;
+	} while (++retry_count <= 1000 && *state == REPLAY_STATE_INVALID);
+
+	// Assert if max retry hit
+	if (retry_count >= 1000 && *state == REPLAY_STATE_INVALID) {
+		ASSERT(0);
+		/* To-do: Add retry fail log */
+	}
+}
+
+/**
+ * Enable/Disable Replay.
+ */
+static void dmub_replay_enable(struct dmub_replay *dmub, bool enable, bool wait, uint8_t panel_inst)
+{
+	union dmub_rb_cmd cmd;
+	struct dc_context *dc = dmub->ctx;
+	uint32_t retry_count;
+	enum replay_state state = REPLAY_STATE_0;
+
+	memset(&cmd, 0, sizeof(cmd));
+	cmd.replay_enable.header.type = DMUB_CMD__REPLAY;
+	cmd.replay_enable.data.panel_inst = panel_inst;
+
+	cmd.replay_enable.header.sub_type = DMUB_CMD__REPLAY_ENABLE;
+	if (enable)
+		cmd.replay_enable.data.enable = REPLAY_ENABLE;
+	else
+		cmd.replay_enable.data.enable = REPLAY_DISABLE;
+
+	cmd.replay_enable.header.payload_bytes = sizeof(struct dmub_rb_cmd_replay_enable_data);
+
+	dm_execute_dmub_cmd(dc, &cmd, DM_DMUB_WAIT_TYPE_WAIT);
+
+	/* Below loops 1000 x 500us = 500 ms.
+	 *  Exit REPLAY may need to wait 1-2 frames to power up. Timeout after at
+	 *  least a few frames. Should never hit the max retry assert below.
+	 */
+	if (wait) {
+		for (retry_count = 0; retry_count <= 1000; retry_count++) {
+			dmub_replay_get_state(dmub, &state, panel_inst);
+
+			if (enable) {
+				if (state != REPLAY_STATE_0)
+					break;
+			} else {
+				if (state == REPLAY_STATE_0)
+					break;
+			}
+
+			fsleep(500);
+		}
+
+		/* assert if max retry hit */
+		if (retry_count >= 1000)
+			ASSERT(0);
+	}
+
+}
+
+/**
+ * Set REPLAY power optimization flags.
+ */
+static void dmub_replay_set_power_opt(struct dmub_replay *dmub, unsigned int power_opt, uint8_t panel_inst)
+{
+	union dmub_rb_cmd cmd;
+	struct dc_context *dc = dmub->ctx;
+
+	memset(&cmd, 0, sizeof(cmd));
+	cmd.replay_set_power_opt.header.type = DMUB_CMD__REPLAY;
+	cmd.replay_set_power_opt.header.sub_type = DMUB_CMD__SET_REPLAY_POWER_OPT;
+	cmd.replay_set_power_opt.header.payload_bytes = sizeof(struct dmub_cmd_replay_set_power_opt_data);
+	cmd.replay_set_power_opt.replay_set_power_opt_data.power_opt = power_opt;
+	cmd.replay_set_power_opt.replay_set_power_opt_data.panel_inst = panel_inst;
+
+	dm_execute_dmub_cmd(dc, &cmd, DM_DMUB_WAIT_TYPE_WAIT);
+}
+
+/**
+ * Setup Replay by programming phy registers and sending replay hw context values to firmware.
+ */
+static bool dmub_replay_copy_settings(struct dmub_replay *dmub,
+	struct dc_link *link,
+	struct replay_context *replay_context,
+	uint8_t panel_inst)
+{
+	union dmub_rb_cmd cmd;
+	struct dc_context *dc = dmub->ctx;
+	struct dmub_cmd_replay_copy_settings_data *copy_settings_data
+		= &cmd.replay_copy_settings.replay_copy_settings_data;
+	struct pipe_ctx *pipe_ctx = NULL;
+	struct resource_context *res_ctx = &link->ctx->dc->current_state->res_ctx;
+	int i = 0;
+
+	for (i = 0; i < MAX_PIPES; i++) {
+		if (res_ctx &&
+			res_ctx->pipe_ctx[i].stream &&
+			res_ctx->pipe_ctx[i].stream->link &&
+			res_ctx->pipe_ctx[i].stream->link == link &&
+			res_ctx->pipe_ctx[i].stream->link->connector_signal == SIGNAL_TYPE_EDP) {
+			pipe_ctx = &res_ctx->pipe_ctx[i];
+			//TODO: refactor for multi edp support
+			break;
+		}
+	}
+
+	if (!pipe_ctx)
+		return false;
+
+	memset(&cmd, 0, sizeof(cmd));
+	cmd.replay_copy_settings.header.type = DMUB_CMD__REPLAY;
+	cmd.replay_copy_settings.header.sub_type = DMUB_CMD__REPLAY_COPY_SETTINGS;
+	cmd.replay_copy_settings.header.payload_bytes = sizeof(struct dmub_cmd_replay_copy_settings_data);
+
+	// HW insts
+	copy_settings_data->aux_inst				= replay_context->aux_inst;
+	copy_settings_data->digbe_inst				= replay_context->digbe_inst;
+	copy_settings_data->digfe_inst				= replay_context->digfe_inst;
+
+	if (pipe_ctx->plane_res.dpp)
+		copy_settings_data->dpp_inst			= pipe_ctx->plane_res.dpp->inst;
+	else
+		copy_settings_data->dpp_inst			= 0;
+	if (pipe_ctx->stream_res.tg)
+		copy_settings_data->otg_inst			= pipe_ctx->stream_res.tg->inst;
+	else
+		copy_settings_data->otg_inst			= 0;
+
+	copy_settings_data->dpphy_inst				= link->link_enc->transmitter;
+
+	// Misc
+	copy_settings_data->line_time_in_ns			= replay_context->line_time_in_ns;
+	copy_settings_data->panel_inst				= panel_inst;
+	copy_settings_data->debug.u32All			= link->replay_settings.config.debug_flags;
+	copy_settings_data->pixel_deviation_per_line		= link->dpcd_caps.pr_info.pixel_deviation_per_line;
+	copy_settings_data->max_deviation_line			= link->dpcd_caps.pr_info.max_deviation_line;
+	copy_settings_data->smu_optimizations_en		= link->replay_settings.replay_smu_opt_enable;
+	copy_settings_data->replay_timing_sync_supported = link->replay_settings.config.replay_timing_sync_supported;
+
+	copy_settings_data->flags.u32All = 0;
+	copy_settings_data->flags.bitfields.fec_enable_status = (link->fec_state == dc_link_fec_enabled);
+	copy_settings_data->flags.bitfields.dsc_enable_status = (pipe_ctx->stream->timing.flags.DSC == 1);
+	// WA for PSRSU+DSC on specific TCON, if DSC is enabled, force PSRSU as ffu mode(full frame update)
+	if (((link->dpcd_caps.fec_cap.bits.FEC_CAPABLE &&
+		!link->dc->debug.disable_fec) &&
+		(link->dpcd_caps.dsc_caps.dsc_basic_caps.fields.dsc_support.DSC_SUPPORT &&
+		!link->panel_config.dsc.disable_dsc_edp &&
+		link->dc->caps.edp_dsc_support)) &&
+		link->dpcd_caps.sink_dev_id == DP_DEVICE_ID_38EC11 /*&&
+		(!memcmp(link->dpcd_caps.sink_dev_id_str, DP_SINK_DEVICE_STR_ID_1,
+			sizeof(DP_SINK_DEVICE_STR_ID_1)) ||
+		!memcmp(link->dpcd_caps.sink_dev_id_str, DP_SINK_DEVICE_STR_ID_2,
+			sizeof(DP_SINK_DEVICE_STR_ID_2)))*/)
+		copy_settings_data->flags.bitfields.force_wakeup_by_tps3 = 1;
+	else
+		copy_settings_data->flags.bitfields.force_wakeup_by_tps3 = 0;
+
+
+	dm_execute_dmub_cmd(dc, &cmd, DM_DMUB_WAIT_TYPE_WAIT);
+
+	return true;
+}
+
+/**
+ * Set coasting vtotal.
+ */
+static void dmub_replay_set_coasting_vtotal(struct dmub_replay *dmub,
+		uint16_t coasting_vtotal,
+		uint8_t panel_inst)
+{
+	union dmub_rb_cmd cmd;
+	struct dc_context *dc = dmub->ctx;
+
+	memset(&cmd, 0, sizeof(cmd));
+	cmd.replay_set_coasting_vtotal.header.type = DMUB_CMD__REPLAY;
+	cmd.replay_set_coasting_vtotal.header.sub_type = DMUB_CMD__REPLAY_SET_COASTING_VTOTAL;
+	cmd.replay_set_coasting_vtotal.header.payload_bytes = sizeof(struct dmub_cmd_replay_set_coasting_vtotal_data);
+	cmd.replay_set_coasting_vtotal.replay_set_coasting_vtotal_data.coasting_vtotal = coasting_vtotal;
+
+	dm_execute_dmub_cmd(dc, &cmd, DM_DMUB_WAIT_TYPE_WAIT);
+}
+
+/**
+ * Get Replay residency from firmware.
+ */
+static void dmub_replay_residency(struct dmub_replay *dmub, uint8_t panel_inst,
+	uint32_t *residency, const bool is_start, const bool is_alpm)
+{
+	struct dmub_srv *srv = dmub->ctx->dmub_srv->dmub;
+	uint16_t param = (uint16_t)(panel_inst << 8);
+
+	if (is_alpm)
+		param |= REPLAY_RESIDENCY_MODE_ALPM;
+
+	if (is_start)
+		param |= REPLAY_RESIDENCY_ENABLE;
+
+	// Send gpint command and wait for ack
+	dmub_srv_send_gpint_command(srv, DMUB_GPINT__REPLAY_RESIDENCY, param, 30);
+
+	if (!is_start)
+		dmub_srv_get_gpint_response(srv, residency);
+	else
+		*residency = 0;
+}
+
+static const struct dmub_replay_funcs replay_funcs = {
+	.replay_copy_settings		= dmub_replay_copy_settings,
+	.replay_enable			= dmub_replay_enable,
+	.replay_get_state		= dmub_replay_get_state,
+	.replay_set_power_opt		= dmub_replay_set_power_opt,
+	.replay_set_coasting_vtotal	= dmub_replay_set_coasting_vtotal,
+	.replay_residency		= dmub_replay_residency,
+};
+
+/**
+ * Construct Replay object.
+ */
+static void dmub_replay_construct(struct dmub_replay *replay, struct dc_context *ctx)
+{
+	replay->ctx = ctx;
+	replay->funcs = &replay_funcs;
+}
+
+/**
+ * Allocate and initialize Replay object.
+ */
+struct dmub_replay *dmub_replay_create(struct dc_context *ctx)
+{
+	struct dmub_replay *replay = kzalloc(sizeof(struct dmub_replay), GFP_KERNEL);
+
+	if (replay == NULL) {
+		BREAK_TO_DEBUGGER();
+		return NULL;
+	}
+
+	dmub_replay_construct(replay, ctx);
+
+	return replay;
+}
+
+/**
+ * Deallocate Replay object.
+ */
+void dmub_replay_destroy(struct dmub_replay **dmub)
+{
+	kfree(*dmub);
+	*dmub = NULL;
+}
diff --git a/drivers/gpu/drm/amd/display/dc/dce/dmub_replay.h b/drivers/gpu/drm/amd/display/dc/dce/dmub_replay.h
new file mode 100644
index 000000000000..e8385bbf51fc
--- /dev/null
+++ b/drivers/gpu/drm/amd/display/dc/dce/dmub_replay.h
@@ -0,0 +1,58 @@
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
+ * Authors: AMD
+ *
+ */
+
+#ifndef _DMUB_REPLAY_H_
+#define _DMUB_REPLAY_H_
+
+#include "dc_types.h"
+#include "dmub_cmd.h"
+struct dc_link;
+struct dmub_replay_funcs;
+
+struct dmub_replay {
+	struct dc_context *ctx;
+	const struct dmub_replay_funcs *funcs;
+};
+
+struct dmub_replay_funcs {
+	void (*replay_get_state)(struct dmub_replay *dmub, enum replay_state *state,
+		uint8_t panel_inst);
+	void (*replay_enable)(struct dmub_replay *dmub, bool enable, bool wait,
+		uint8_t panel_inst);
+	bool (*replay_copy_settings)(struct dmub_replay *dmub, struct dc_link *link,
+		struct replay_context *replay_context, uint8_t panel_inst);
+	void (*replay_set_power_opt)(struct dmub_replay *dmub, unsigned int power_opt,
+		uint8_t panel_inst);
+	void (*replay_set_coasting_vtotal)(struct dmub_replay *dmub, uint16_t coasting_vtotal,
+		uint8_t panel_inst);
+	void (*replay_residency)(struct dmub_replay *dmub,
+		uint8_t panel_inst, uint32_t *residency, const bool is_start, const bool is_alpm);
+};
+
+struct dmub_replay *dmub_replay_create(struct dc_context *ctx);
+void dmub_replay_destroy(struct dmub_replay **dmub);
+
+
+#endif /* _DMUB_REPLAY_H_ */
diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c
index fc33b5fcabe1..7b875d565808 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c
@@ -96,6 +96,7 @@
 #include "dce/dmub_psr.h"
 #include "dce/dce_aux.h"
 #include "dce/dce_i2c.h"
+#include "dce/dmub_replay.h"
 
 #include "dml/dcn30/display_mode_vba_30.h"
 #include "vm_helper.h"
@@ -1479,6 +1480,9 @@ static void dcn31_resource_destruct(struct dcn31_resource_pool *pool)
 	if (pool->base.psr != NULL)
 		dmub_psr_destroy(&pool->base.psr);
 
+	if (pool->base.replay != NULL)
+		dmub_replay_destroy(&pool->base.replay);
+
 	if (pool->base.dccg != NULL)
 		dcn_dccg_destroy(&pool->base.dccg);
 }
@@ -2085,6 +2089,14 @@ static bool dcn31_resource_construct(
 		goto create_fail;
 	}
 
+	/* Replay */
+	pool->base.replay = dmub_replay_create(ctx);
+	if (pool->base.replay == NULL) {
+		dm_error("DC: failed to create replay obj!\n");
+		BREAK_TO_DEBUGGER();
+		goto create_fail;
+	}
+
 	/* ABM */
 	for (i = 0; i < pool->base.res_cap->num_timing_generator; i++) {
 		pool->base.multiple_abms[i] = dmub_abm_create(ctx,
diff --git a/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_resource.c b/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_resource.c
index a840b008d660..60c4ab76d4da 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_resource.c
@@ -93,6 +93,7 @@
 #include "reg_helper.h"
 #include "dce/dmub_abm.h"
 #include "dce/dmub_psr.h"
+#include "dce/dmub_replay.h"
 #include "dce/dce_aux.h"
 #include "dce/dce_i2c.h"
 #include "dml/dcn314/display_mode_vba_314.h"
@@ -1528,6 +1529,9 @@ static void dcn314_resource_destruct(struct dcn314_resource_pool *pool)
 	if (pool->base.psr != NULL)
 		dmub_psr_destroy(&pool->base.psr);
 
+	if (pool->base.replay != NULL)
+		dmub_replay_destroy(&pool->base.replay);
+
 	if (pool->base.dccg != NULL)
 		dcn_dccg_destroy(&pool->base.dccg);
 }
@@ -2024,6 +2028,14 @@ static bool dcn314_resource_construct(
 		goto create_fail;
 	}
 
+	/* Replay */
+	pool->base.replay = dmub_replay_create(ctx);
+	if (pool->base.replay == NULL) {
+		dm_error("DC: failed to create replay obj!\n");
+		BREAK_TO_DEBUGGER();
+		goto create_fail;
+	}
+
 	/* ABM */
 	for (i = 0; i < pool->base.res_cap->num_timing_generator; i++) {
 		pool->base.multiple_abms[i] = dmub_abm_create(ctx,
diff --git a/drivers/gpu/drm/amd/display/dc/inc/link.h b/drivers/gpu/drm/amd/display/dc/inc/link.h
index f839494d59d8..c07096e59201 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/link.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/link.h
@@ -269,6 +269,20 @@ struct link_service {
 			uint16_t psr_vtotal_su);
 	void (*edp_get_psr_residency)(
 			const struct dc_link *link, uint32_t *residency);
+
+	bool (*edp_get_replay_state)(
+			const struct dc_link *link, uint64_t *state);
+	bool (*edp_set_replay_allow_active)(struct dc_link *dc_link,
+			const bool *enable, bool wait, bool force_static,
+			const unsigned int *power_opts);
+	bool (*edp_setup_replay)(struct dc_link *link,
+			const struct dc_stream_state *stream);
+	bool (*edp_set_coasting_vtotal)(
+			struct dc_link *link, uint16_t coasting_vtotal);
+	bool (*edp_replay_residency)(const struct dc_link *link,
+			unsigned int *residency, const bool is_start,
+			const bool is_alpm);
+
 	bool (*edp_wait_for_t12)(struct dc_link *link);
 	bool (*edp_is_ilr_optimization_required)(struct dc_link *link,
 			struct dc_crtc_timing *crtc_timing);
diff --git a/drivers/gpu/drm/amd/display/dc/link/link_factory.c b/drivers/gpu/drm/amd/display/dc/link/link_factory.c
index ac1c3e2e7c1d..bb063e1491a2 100644
--- a/drivers/gpu/drm/amd/display/dc/link/link_factory.c
+++ b/drivers/gpu/drm/amd/display/dc/link/link_factory.c
@@ -207,6 +207,13 @@ static void construct_link_service_edp_panel_control(struct link_service *link_s
 	link_srv->edp_set_sink_vtotal_in_psr_active =
 			edp_set_sink_vtotal_in_psr_active;
 	link_srv->edp_get_psr_residency = edp_get_psr_residency;
+
+	link_srv->edp_get_replay_state = edp_get_replay_state;
+	link_srv->edp_set_replay_allow_active = edp_set_replay_allow_active;
+	link_srv->edp_setup_replay = edp_setup_replay;
+	link_srv->edp_set_coasting_vtotal = edp_set_coasting_vtotal;
+	link_srv->edp_replay_residency = edp_replay_residency;
+
 	link_srv->edp_wait_for_t12 = edp_wait_for_t12;
 	link_srv->edp_is_ilr_optimization_required =
 			edp_is_ilr_optimization_required;
diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c
index 2039a345f23a..f671704767d9 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c
@@ -34,9 +34,13 @@
 #include "dm_helpers.h"
 #include "dal_asic_id.h"
 #include "dce/dmub_psr.h"
+#include "dc/dc_dmub_srv.h"
+#include "dce/dmub_replay.h"
 #include "abm.h"
 #define DC_LOGGER_INIT(logger)
 
+#define DP_SINK_PR_ENABLE_AND_CONFIGURATION		0x37B
+
 /* Travis */
 static const uint8_t DP_VGA_LVDS_CONVERTER_ID_2[] = "sivarT";
 /* Nutmeg */
@@ -807,6 +811,167 @@ bool edp_set_sink_vtotal_in_psr_active(const struct dc_link *link, uint16_t psr_
 	return true;
 }
 
+bool edp_set_replay_allow_active(struct dc_link *link, const bool *allow_active,
+	bool wait, bool force_static, const unsigned int *power_opts)
+{
+	struct dc  *dc = link->ctx->dc;
+	struct dmub_replay *replay = dc->res_pool->replay;
+	unsigned int panel_inst;
+
+	if (replay == NULL)
+		return false;
+
+	if (!dc_get_edp_link_panel_inst(dc, link, &panel_inst))
+		return false;
+
+	/* Set power optimization flag */
+	if (power_opts && link->replay_settings.replay_power_opt_active != *power_opts) {
+		if (link->replay_settings.replay_feature_enabled && replay->funcs->replay_set_power_opt) {
+			replay->funcs->replay_set_power_opt(replay, *power_opts, panel_inst);
+			link->replay_settings.replay_power_opt_active = *power_opts;
+		}
+	}
+
+	/* Activate or deactivate Replay */
+	if (allow_active && link->replay_settings.replay_allow_active != *allow_active) {
+		// TODO: Handle mux change case if force_static is set
+		// If force_static is set, just change the replay_allow_active state directly
+		if (replay != NULL && link->replay_settings.replay_feature_enabled)
+			replay->funcs->replay_enable(replay, *allow_active, wait, panel_inst);
+		link->replay_settings.replay_allow_active = *allow_active;
+	}
+
+	return true;
+}
+
+bool edp_get_replay_state(const struct dc_link *link, uint64_t *state)
+{
+	struct dc  *dc = link->ctx->dc;
+	struct dmub_replay *replay = dc->res_pool->replay;
+	unsigned int panel_inst;
+	enum replay_state pr_state = REPLAY_STATE_0;
+
+	if (!dc_get_edp_link_panel_inst(dc, link, &panel_inst))
+		return false;
+
+	if (replay != NULL && link->replay_settings.replay_feature_enabled)
+		replay->funcs->replay_get_state(replay, &pr_state, panel_inst);
+	*state = pr_state;
+
+	return true;
+}
+
+bool edp_setup_replay(struct dc_link *link, const struct dc_stream_state *stream)
+{
+	/* To-do: Setup Replay */
+	struct dc *dc = link->ctx->dc;
+	struct dmub_replay *replay = dc->res_pool->replay;
+	int i;
+	unsigned int panel_inst;
+	struct replay_context replay_context = { 0 };
+	unsigned int lineTimeInNs = 0;
+
+
+	union replay_enable_and_configuration replay_config;
+
+	union dpcd_alpm_configuration alpm_config;
+
+	replay_context.controllerId = CONTROLLER_ID_UNDEFINED;
+
+	if (!link)
+		return false;
+
+	if (!replay)
+		return false;
+
+	if (!dc_get_edp_link_panel_inst(dc, link, &panel_inst))
+		return false;
+
+	replay_context.aux_inst = link->ddc->ddc_pin->hw_info.ddc_channel;
+	replay_context.digbe_inst = link->link_enc->transmitter;
+	replay_context.digfe_inst = link->link_enc->preferred_engine;
+
+	for (i = 0; i < MAX_PIPES; i++) {
+		if (dc->current_state->res_ctx.pipe_ctx[i].stream
+				== stream) {
+			/* dmcu -1 for all controller id values,
+			 * therefore +1 here
+			 */
+			replay_context.controllerId =
+				dc->current_state->res_ctx.pipe_ctx[i].stream_res.tg->inst + 1;
+			break;
+		}
+	}
+
+	lineTimeInNs =
+		((stream->timing.h_total * 1000000) /
+			(stream->timing.pix_clk_100hz / 10)) + 1;
+
+	replay_context.line_time_in_ns = lineTimeInNs;
+
+	if (replay)
+		link->replay_settings.replay_feature_enabled =
+			replay->funcs->replay_copy_settings(replay, link, &replay_context, panel_inst);
+	if (link->replay_settings.replay_feature_enabled) {
+
+		replay_config.bits.FREESYNC_PANEL_REPLAY_MODE = 1;
+		replay_config.bits.TIMING_DESYNC_ERROR_VERIFICATION =
+			link->replay_settings.config.replay_timing_sync_supported;
+		replay_config.bits.STATE_TRANSITION_ERROR_DETECTION = 1;
+		dm_helpers_dp_write_dpcd(link->ctx, link,
+			DP_SINK_PR_ENABLE_AND_CONFIGURATION,
+			(uint8_t *)&(replay_config.raw), sizeof(uint8_t));
+
+		memset(&alpm_config, 0, sizeof(alpm_config));
+		alpm_config.bits.ENABLE = 1;
+		dm_helpers_dp_write_dpcd(
+			link->ctx,
+			link,
+			DP_RECEIVER_ALPM_CONFIG,
+			&alpm_config.raw,
+			sizeof(alpm_config.raw));
+	}
+	return true;
+}
+
+bool edp_set_coasting_vtotal(struct dc_link *link, uint16_t coasting_vtotal)
+{
+	struct dc *dc = link->ctx->dc;
+	struct dmub_replay *replay = dc->res_pool->replay;
+	unsigned int panel_inst;
+
+	if (!replay)
+		return false;
+
+	if (!dc_get_edp_link_panel_inst(dc, link, &panel_inst))
+		return false;
+
+	if (coasting_vtotal && link->replay_settings.coasting_vtotal != coasting_vtotal) {
+		replay->funcs->replay_set_coasting_vtotal(replay, coasting_vtotal, panel_inst);
+		link->replay_settings.coasting_vtotal = coasting_vtotal;
+	}
+
+	return true;
+}
+
+bool edp_replay_residency(const struct dc_link *link,
+	unsigned int *residency, const bool is_start, const bool is_alpm)
+{
+	struct dc  *dc = link->ctx->dc;
+	struct dmub_replay *replay = dc->res_pool->replay;
+	unsigned int panel_inst;
+
+	if (!dc_get_edp_link_panel_inst(dc, link, &panel_inst))
+		return false;
+
+	if (replay != NULL && link->replay_settings.replay_feature_enabled)
+		replay->funcs->replay_residency(replay, panel_inst, residency, is_start, is_alpm);
+	else
+		*residency = 0;
+
+	return true;
+}
+
 static struct abm *get_abm_from_stream_res(const struct dc_link *link)
 {
 	int i;
diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.h b/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.h
index 28f552080558..35f45ba35267 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.h
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.h
@@ -52,6 +52,14 @@ bool edp_setup_psr(struct dc_link *link,
 bool edp_set_sink_vtotal_in_psr_active(const struct dc_link *link,
        uint16_t psr_vtotal_idle, uint16_t psr_vtotal_su);
 void edp_get_psr_residency(const struct dc_link *link, uint32_t *residency);
+bool edp_set_replay_allow_active(struct dc_link *dc_link, const bool *enable,
+	bool wait, bool force_static, const unsigned int *power_opts);
+bool edp_setup_replay(struct dc_link *link,
+		const struct dc_stream_state *stream);
+bool edp_set_coasting_vtotal(struct dc_link *link, uint16_t coasting_vtotal);
+bool edp_replay_residency(const struct dc_link *link,
+	unsigned int *residency, const bool is_start, const bool is_alpm);
+bool edp_get_replay_state(const struct dc_link *link, uint64_t *state);
 bool edp_wait_for_t12(struct dc_link *link);
 bool edp_is_ilr_optimization_required(struct dc_link *link,
        struct dc_crtc_timing *crtc_timing);
-- 
2.25.1

