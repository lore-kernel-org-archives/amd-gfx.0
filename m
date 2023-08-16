Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C0FFC04A94
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Aug 2023 06:08:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B0EC110E2D3;
	Wed, 16 Aug 2023 06:08:42 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2068.outbound.protection.outlook.com [40.107.237.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B821910E2D3
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Aug 2023 06:08:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Cm/K6eFyR2JpbX3jQHeoaHXi76itTz7HF21DDzGzdeQA7Gu7g3ELX6xfkXu24tbPsxU03+wsQsPOi//dlXC8uhwpGZKN/xEEEy+B2uO6BZT8BJD+AXMYi6WudDfMdm4eU1iFGeK26SHyKSKbkevnamzoNqm3QTmAEZ5hr0kXGmTQbZkdsHjuTD+cM3Qe4izOP7DRS6jEnlv2+Y8CnCVcTNAByNYt2Nk84Gul8UW9aJXGstT/b9ZZsXza7R/SRaINZ9bQKV+yCngtSla1XsZ23xKYGYXrt8cKRUvdNXGx6jFbCrLCmT8RULpwwOtGVmJqYHzw4v0qgjGomTynjnCfWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k7gB0i9Dhz/buG4LOUtuiZUcDtfTGhdG6lNNSrC6Q4M=;
 b=GIoKXlCpby3AlKCdWSqZAlN7Ir38Qhuawxee6ZAc3wXiOj7D5paKV25VshL+vw8qwcs3i6ZGlP8zSS0wMxX6CaSWKzdIMQ5bzZnLlxzMhAS94Cv5GZua0sP7ovLssuGqyLJBqOdF4hRNfyY24DRJ9sJMMm/n/gEJPcKEaI3PnWQt7TvhxhQCQoLkvbN9jJBSfqh6Jw7uPuETukkhwBmiRoHEEdXQ4/4uFwVjkDVXD3XDmXBgpGAXpGUfpIM0FXmxOEJV5jjS379LuDJdejZYIVWE0QWlWhkWyAMD08QzyWtbgMwYFiuY1Pyvq6GQNi+XEGzNHqVTMaZ23s8uUJdD8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k7gB0i9Dhz/buG4LOUtuiZUcDtfTGhdG6lNNSrC6Q4M=;
 b=CrJs8E4baKo72vPNoY4d1R7MWjZqv3U+v7HctiGygk11oulNxR6VEWGqlOhz93xC7Qi37xmWuQgsHT6fP9sYe5oWkJp3rbkr+1ckWWaIrP3l7QU4qkxUYmQxBft7dejBWzRY2fPd8G4nUXojQN8dOpQD/eVoiWLhrGutrP05Erw=
Received: from BY3PR04CA0015.namprd04.prod.outlook.com (2603:10b6:a03:217::20)
 by DS0PR12MB6631.namprd12.prod.outlook.com (2603:10b6:8:d1::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.26; Wed, 16 Aug
 2023 06:08:37 +0000
Received: from MWH0EPF000971E7.namprd02.prod.outlook.com
 (2603:10b6:a03:217:cafe::3c) by BY3PR04CA0015.outlook.office365.com
 (2603:10b6:a03:217::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.33 via Frontend
 Transport; Wed, 16 Aug 2023 06:08:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000971E7.mail.protection.outlook.com (10.167.243.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.14 via Frontend Transport; Wed, 16 Aug 2023 06:08:37 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 16 Aug
 2023 01:08:35 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 16 Aug
 2023 01:08:35 -0500
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Wed, 16 Aug 2023 01:08:29 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 10/16] drm/amd/display: Write flip addr to scratch reg for
 subvp
Date: Wed, 16 Aug 2023 14:06:52 +0800
Message-ID: <20230816060658.2141009-11-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20230816060658.2141009-1-Wayne.Lin@amd.com>
References: <20230816060658.2141009-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E7:EE_|DS0PR12MB6631:EE_
X-MS-Office365-Filtering-Correlation-Id: e82161d6-82e2-493f-8f12-08db9e1f3b0f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PiRdz4CtGOQuGY9mx+Y+7jjcc9YEq9Xuz7VjF01YmhLT1D7kw8Fsd2zQQ8ZTsrGCCTiWyGDZ9Y7WEgJSDTuYmN9dKl0O5Khpx23t66npdH+A2mGxmbbSR7vnqft8L1p90B8u92gWZ21olakzUsKj1UEidSyhqnOUbZRe9XXvNMdYKNnmuK0Lh42TeiUzq3JgNl5aHWWDYhu/x/cLcwggcsfbnqZq4hwEtGIJfajZe9Z+7yJSt/abSDeM2ManbhLFFgfaBv6b5EgQhfzbV/bhsY0du0zgwZMxbnxv4Mz8KyehKbprfJ1fXX1/39M8edaHl4uyCVYfWH55WPu1ylWTCJGNPFgmu8agAyMuxFEKMoHbJpUfJFeRc1/Tyv4VjA//EuDeeYARJ2B0SydLUC9Ao3GQH4oQPIfdWUrWpApFq5a9smtNANjdWp8ymZImsOpW1yOW7DEmPkrI9MPbdDcwjdh8OHLpIGcJGPei5B3GjTYmYAFwkXW5c76GJzNAYE0bDalnWeoCRtd0Yj1FA7cvLbu+42OW1lYY2/UnS2rVQ2/mEfl79G30JwLA0B5bJrKOjAY1GuOTJVFkIcFH/IsY2TQinwdYzwqop3q9d4JgJC1xsCL+8qt/xmz3U3upoTjcMpxWS+mbajU8D8vy9GBKO8eDMwsskNk+9uQq6zqOTaqh2UmuX8y27iZmY1KXLUAA1aEfc0Nbc9uNO1Uw3vUwKJLLzekhCH9NpzgrKqk+7xFv0qh+0fiLldXW+Tajb7/7BRoRb0EhzveswnKvMnasPQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(39860400002)(396003)(346002)(136003)(1800799009)(82310400011)(451199024)(186009)(46966006)(36840700001)(40470700004)(6666004)(54906003)(70586007)(70206006)(7696005)(30864003)(2906002)(478600001)(1076003)(336012)(426003)(26005)(6916009)(5660300002)(2616005)(83380400001)(41300700001)(316002)(47076005)(36860700001)(8936002)(4326008)(82740400003)(8676002)(81166007)(356005)(40460700003)(36756003)(86362001)(40480700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2023 06:08:37.3544 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e82161d6-82e2-493f-8f12-08db9e1f3b0f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000971E7.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6631
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
Cc: stylon.wang@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 solomon.chiu@amd.com, Aurabindo.Pillai@amd.com, Alvin Lee <alvin.lee2@amd.com>,
 wayne.lin@amd.com, Jun Lei <jun.lei@amd.com>, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Alvin Lee <alvin.lee2@amd.com>

[Description]
SubVP needs to "calculate" the earliest in use META address
by using the current primary / meta addresses, but this leads
to a race condition where FW and driver can read/write the
address at the same time and intermittently produce inconsistent
address offsets. To mitigate this issue without locking (too slow),
save each surface flip addr into scratch registers and use this
to keep track of the earliest in use META addres.

Reviewed-by: Jun Lei <jun.lei@amd.com>
Acked-by: Wayne Lin <wayne.lin@amd.com>
Signed-off-by: Alvin Lee <alvin.lee2@amd.com>
---
 .../drm/amd/display/dc/core/dc_hw_sequencer.c | 23 ++++++++++++++
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c  |  5 ++++
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.h  |  1 +
 .../drm/amd/display/dc/dcn20/dcn20_hwseq.c    | 12 +++++++-
 .../drm/amd/display/dc/dml/dcn32/dcn32_fpu.c  | 18 +++++++++++
 .../gpu/drm/amd/display/dc/inc/core_types.h   |  2 ++
 .../gpu/drm/amd/display/dc/inc/hw_sequencer.h | 10 +++++++
 drivers/gpu/drm/amd/display/dmub/dmub_srv.h   | 17 +++++++++++
 .../gpu/drm/amd/display/dmub/src/dmub_dcn32.c | 30 +++++++++++++++++++
 .../gpu/drm/amd/display/dmub/src/dmub_dcn32.h |  7 +++++
 .../gpu/drm/amd/display/dmub/src/dmub_srv.c   | 10 +++++++
 11 files changed, 134 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c
index f99ec1b0efaf..a50df7126e39 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c
@@ -29,6 +29,8 @@
 #include "hw_sequencer.h"
 #include "hw_sequencer_private.h"
 #include "basics/dc_common.h"
+#include "resource.h"
+#include "dc_dmub_srv.h"
 
 #define NUM_ELEMENTS(a) (sizeof(a) / sizeof((a)[0]))
 
@@ -530,6 +532,15 @@ void hwss_build_fast_sequence(struct dc *dc,
 				block_sequence[*num_steps].params.update_plane_addr_params.pipe_ctx = current_mpc_pipe;
 				block_sequence[*num_steps].func = HUBP_UPDATE_PLANE_ADDR;
 				(*num_steps)++;
+
+				if (resource_is_pipe_type(current_mpc_pipe, OTG_MASTER) &&
+						current_mpc_pipe->stream->mall_stream_config.type == SUBVP_MAIN) {
+					block_sequence[*num_steps].params.subvp_save_surf_addr.dc_dmub_srv = dc->ctx->dmub_srv;
+					block_sequence[*num_steps].params.subvp_save_surf_addr.addr = &current_mpc_pipe->plane_state->address;
+					block_sequence[*num_steps].params.subvp_save_surf_addr.subvp_index = current_mpc_pipe->subvp_index;
+					block_sequence[*num_steps].func = DMUB_SUBVP_SAVE_SURF_ADDR;
+					(*num_steps)++;
+				}
 			}
 
 			if (hws->funcs.set_input_transfer_func && current_mpc_pipe->plane_state->update_flags.bits.gamma_change) {
@@ -697,6 +708,9 @@ void hwss_execute_sequence(struct dc *dc,
 		case DMUB_SEND_DMCUB_CMD:
 			hwss_send_dmcub_cmd(params);
 			break;
+		case DMUB_SUBVP_SAVE_SURF_ADDR:
+			hwss_subvp_save_surf_addr(params);
+			break;
 		default:
 			ASSERT(false);
 			break;
@@ -789,6 +803,15 @@ void hwss_set_ocsc_default(union block_sequence_params *params)
 				ocsc_mode);
 }
 
+void hwss_subvp_save_surf_addr(union block_sequence_params *params)
+{
+	struct dc_dmub_srv *dc_dmub_srv = params->subvp_save_surf_addr.dc_dmub_srv;
+	const struct dc_plane_address *addr = params->subvp_save_surf_addr.addr;
+	uint8_t subvp_index = params->subvp_save_surf_addr.subvp_index;
+
+	dc_dmub_srv_subvp_save_surf_addr(dc_dmub_srv, addr, subvp_index);
+}
+
 void get_mclk_switch_visual_confirm_color(
 		struct dc *dc,
 		struct dc_state *context,
diff --git a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
index 4c5ef3ef8dbd..f32b5c71a66b 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
+++ b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
@@ -1054,4 +1054,9 @@ void dc_dmub_srv_enable_dpia_trace(const struct dc *dc)
 	}
 
 	DC_LOG_DEBUG("Enabled DPIA trace\n");
+}
+
+void dc_dmub_srv_subvp_save_surf_addr(const struct dc_dmub_srv *dc_dmub_srv, const struct dc_plane_address *addr, uint8_t subvp_index)
+{
+	dmub_srv_subvp_save_surf_addr(dc_dmub_srv->dmub, addr, subvp_index);
 }
\ No newline at end of file
diff --git a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.h b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.h
index bb3fe162dd93..2ebd4717f4a2 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.h
@@ -89,5 +89,6 @@ void dc_send_update_cursor_info_to_dmu(struct pipe_ctx *pCtx, uint8_t pipe_idx);
 bool dc_dmub_check_min_version(struct dmub_srv *srv);
 
 void dc_dmub_srv_enable_dpia_trace(const struct dc *dc);
+void dc_dmub_srv_subvp_save_surf_addr(const struct dc_dmub_srv *dc_dmub_srv, const struct dc_plane_address *addr, uint8_t subvp_index);
 
 #endif /* _DMUB_DC_SRV_H_ */
diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
index b1046357798c..60a2941de389 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
@@ -1679,8 +1679,18 @@ static void dcn20_update_dchubp_dpp(
 
 	if (pipe_ctx->update_flags.bits.enable ||
 		pipe_ctx->update_flags.bits.plane_changed ||
-		plane_state->update_flags.bits.addr_update)
+		plane_state->update_flags.bits.addr_update) {
+		if (resource_is_pipe_type(pipe_ctx, OTG_MASTER) &&
+				pipe_ctx->stream->mall_stream_config.type == SUBVP_MAIN) {
+			union block_sequence_params params;
+
+			params.subvp_save_surf_addr.dc_dmub_srv = dc->ctx->dmub_srv;
+			params.subvp_save_surf_addr.addr = &pipe_ctx->plane_state->address;
+			params.subvp_save_surf_addr.subvp_index = pipe_ctx->subvp_index;
+			hwss_subvp_save_surf_addr(&params);
+		}
 		hws->funcs.update_plane_addr(dc, pipe_ctx);
+	}
 
 	if (pipe_ctx->update_flags.bits.enable)
 		hubp->funcs->set_blank(hubp, false);
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
index 711d4085b33b..b3252db43ecb 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
@@ -1144,6 +1144,23 @@ static bool subvp_validate_static_schedulability(struct dc *dc,
 	return schedulable;
 }
 
+static void assign_subvp_index(struct dc *dc, struct dc_state *context)
+{
+	int i;
+	int index = 0;
+
+	for (i = 0; i < dc->res_pool->pipe_count; i++) {
+		struct pipe_ctx *pipe_ctx = &context->res_ctx.pipe_ctx[i];
+
+		if (resource_is_pipe_type(pipe_ctx, OTG_MASTER) &&
+				pipe_ctx->stream->mall_stream_config.type == SUBVP_MAIN) {
+			pipe_ctx->subvp_index = index++;
+		} else {
+			pipe_ctx->subvp_index = 0;
+		}
+	}
+}
+
 static void dcn32_full_validate_bw_helper(struct dc *dc,
 				   struct dc_state *context,
 				   display_e2e_pipe_params_st *pipes,
@@ -1294,6 +1311,7 @@ static void dcn32_full_validate_bw_helper(struct dc *dc,
 			vba->VoltageLevel = *vlevel;
 			// Note: We can't apply the phantom pipes to hardware at this time. We have to wait
 			// until driver has acquired the DMCUB lock to do it safely.
+			assign_subvp_index(dc, context);
 		}
 	}
 }
diff --git a/drivers/gpu/drm/amd/display/dc/inc/core_types.h b/drivers/gpu/drm/amd/display/dc/inc/core_types.h
index 027aec70c070..7f9c75ffda18 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/core_types.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/core_types.h
@@ -408,6 +408,8 @@ struct pipe_ctx {
 	union pipe_update_flags update_flags;
 	struct tg_color visual_confirm_color;
 	bool has_vactive_margin;
+	/* subvp_index: only valid if the pipe is a SUBVP_MAIN*/
+	uint8_t subvp_index;
 };
 
 /* Data used for dynamic link encoder assignment.
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw_sequencer.h b/drivers/gpu/drm/amd/display/dc/inc/hw_sequencer.h
index 7ef0436c51b3..1b59ead7a43e 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw_sequencer.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw_sequencer.h
@@ -134,6 +134,12 @@ struct set_ocsc_default_params {
 	enum mpc_output_csc_mode ocsc_mode;
 };
 
+struct subvp_save_surf_addr {
+	struct dc_dmub_srv *dc_dmub_srv;
+	const struct dc_plane_address *addr;
+	uint8_t subvp_index;
+};
+
 union block_sequence_params {
 	struct update_plane_addr_params update_plane_addr_params;
 	struct subvp_pipe_control_lock_fast_params subvp_pipe_control_lock_fast_params;
@@ -151,6 +157,7 @@ union block_sequence_params {
 	struct power_on_mpc_mem_pwr_params power_on_mpc_mem_pwr_params;
 	struct set_output_csc_params set_output_csc_params;
 	struct set_ocsc_default_params set_ocsc_default_params;
+	struct subvp_save_surf_addr subvp_save_surf_addr;
 };
 
 enum block_sequence_func {
@@ -170,6 +177,7 @@ enum block_sequence_func {
 	MPC_POWER_ON_MPC_MEM_PWR,
 	MPC_SET_OUTPUT_CSC,
 	MPC_SET_OCSC_DEFAULT,
+	DMUB_SUBVP_SAVE_SURF_ADDR,
 };
 
 struct block_sequence {
@@ -474,4 +482,6 @@ void hwss_set_output_csc(union block_sequence_params *params);
 
 void hwss_set_ocsc_default(union block_sequence_params *params);
 
+void hwss_subvp_save_surf_addr(union block_sequence_params *params);
+
 #endif /* __DC_HW_SEQUENCER_H__ */
diff --git a/drivers/gpu/drm/amd/display/dmub/dmub_srv.h b/drivers/gpu/drm/amd/display/dmub/dmub_srv.h
index 43676c1c81d9..e7a50cbf2540 100644
--- a/drivers/gpu/drm/amd/display/dmub/dmub_srv.h
+++ b/drivers/gpu/drm/amd/display/dmub/dmub_srv.h
@@ -401,6 +401,8 @@ struct dmub_srv_hw_funcs {
 
 	bool (*should_detect)(struct dmub_srv *dmub);
 	void (*init_reg_offsets)(struct dmub_srv *dmub, struct dc_context *ctx);
+
+	void (*subvp_save_surf_addr)(struct dmub_srv *dmub, const struct dc_plane_address *addr, uint8_t subvp_index);
 };
 
 /**
@@ -835,6 +837,21 @@ enum dmub_status dmub_srv_wait_for_inbox0_ack(struct dmub_srv *dmub, uint32_t ti
  */
 enum dmub_status dmub_srv_clear_inbox0_ack(struct dmub_srv *dmub);
 
+/**
+ * dmub_srv_subvp_save_surf_addr() - Save primary and meta address for subvp on each flip
+ * @dmub: The dmub service
+ * @addr: The surface address to be programmed on the current flip
+ * @subvp_index: Index of subvp pipe, indicates which subvp pipe the address should be saved for
+ *
+ * Function to save the surface flip addr into scratch registers. This is to fix a race condition
+ * between FW and driver reading / writing to the surface address at the same time. This is
+ * required because there is no EARLIEST_IN_USE_META.
+ *
+ * Return:
+ *   void
+ */
+void dmub_srv_subvp_save_surf_addr(struct dmub_srv *dmub, const struct dc_plane_address *addr, uint8_t subvp_index);
+
 #if defined(__cplusplus)
 }
 #endif
diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn32.c b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn32.c
index 8f427047ac40..2daa1e0c8061 100644
--- a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn32.c
+++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn32.c
@@ -27,6 +27,7 @@
 #include "dmub_reg.h"
 #include "dmub_dcn32.h"
 #include "dc/dc_types.h"
+#include "dc_hw_types.h"
 
 #include "dcn/dcn_3_2_0_offset.h"
 #include "dcn/dcn_3_2_0_sh_mask.h"
@@ -506,3 +507,32 @@ uint32_t dmub_dcn32_read_inbox0_ack_register(struct dmub_srv *dmub)
 {
 	return REG_READ(DMCUB_SCRATCH17);
 }
+
+void dmub_dcn32_save_surf_addr(struct dmub_srv *dmub, const struct dc_plane_address *addr, uint8_t subvp_index)
+{
+	uint32_t index = 0;
+
+	if (subvp_index == 0) {
+		index = REG_READ(DMCUB_SCRATCH15);
+		if (index) {
+			REG_WRITE(DMCUB_SCRATCH9, addr->grph.addr.low_part);
+			REG_WRITE(DMCUB_SCRATCH11, addr->grph.meta_addr.low_part);
+		} else {
+			REG_WRITE(DMCUB_SCRATCH12,  addr->grph.addr.low_part);
+			REG_WRITE(DMCUB_SCRATCH13, addr->grph.meta_addr.low_part);
+		}
+		REG_WRITE(DMCUB_SCRATCH15, !index);
+	} else if (subvp_index == 1) {
+		index = REG_READ(DMCUB_SCRATCH23);
+		if (index) {
+			REG_WRITE(DMCUB_SCRATCH18, addr->grph.addr.low_part);
+			REG_WRITE(DMCUB_SCRATCH19, addr->grph.meta_addr.low_part);
+		} else {
+			REG_WRITE(DMCUB_SCRATCH20,  addr->grph.addr.low_part);
+			REG_WRITE(DMCUB_SCRATCH22, addr->grph.meta_addr.low_part);
+		}
+		REG_WRITE(DMCUB_SCRATCH23, !index);
+	} else {
+		return;
+	}
+}
diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn32.h b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn32.h
index 38e47065e00e..b0cd8d29402f 100644
--- a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn32.h
+++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn32.h
@@ -107,6 +107,12 @@ struct dmub_srv;
 	DMUB_SR(DMCUB_SCRATCH15) \
 	DMUB_SR(DMCUB_SCRATCH16) \
 	DMUB_SR(DMCUB_SCRATCH17) \
+	DMUB_SR(DMCUB_SCRATCH18) \
+	DMUB_SR(DMCUB_SCRATCH19) \
+	DMUB_SR(DMCUB_SCRATCH20) \
+	DMUB_SR(DMCUB_SCRATCH21) \
+	DMUB_SR(DMCUB_SCRATCH22) \
+	DMUB_SR(DMCUB_SCRATCH23) \
 	DMUB_SR(DMCUB_GPINT_DATAIN0) \
 	DMUB_SR(DMCUB_GPINT_DATAIN1) \
 	DMUB_SR(DMCUB_GPINT_DATAOUT) \
@@ -253,6 +259,7 @@ void dmub_dcn32_configure_dmub_in_system_memory(struct dmub_srv *dmub);
 void dmub_dcn32_send_inbox0_cmd(struct dmub_srv *dmub, union dmub_inbox0_data_register data);
 void dmub_dcn32_clear_inbox0_ack_register(struct dmub_srv *dmub);
 uint32_t dmub_dcn32_read_inbox0_ack_register(struct dmub_srv *dmub);
+void dmub_dcn32_save_surf_addr(struct dmub_srv *dmub, const struct dc_plane_address *addr, uint8_t subvp_index);
 
 void dmub_srv_dcn32_regs_init(struct dmub_srv *dmub, struct dc_context *ctx);
 
diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c b/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c
index 9780c157196c..53464c3e49c1 100644
--- a/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c
+++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c
@@ -278,6 +278,7 @@ static bool dmub_srv_hw_setup(struct dmub_srv *dmub, enum dmub_asic asic)
 		funcs->send_inbox0_cmd = dmub_dcn32_send_inbox0_cmd;
 		funcs->clear_inbox0_ack_register = dmub_dcn32_clear_inbox0_ack_register;
 		funcs->read_inbox0_ack_register = dmub_dcn32_read_inbox0_ack_register;
+		funcs->subvp_save_surf_addr = dmub_dcn32_save_surf_addr;
 		funcs->reset = dmub_dcn32_reset;
 		funcs->reset_release = dmub_dcn32_reset_release;
 		funcs->backdoor_load = dmub_dcn32_backdoor_load;
@@ -985,3 +986,12 @@ enum dmub_status dmub_srv_send_inbox0_cmd(struct dmub_srv *dmub,
 	dmub->hw_funcs.send_inbox0_cmd(dmub, data);
 	return DMUB_STATUS_OK;
 }
+
+void dmub_srv_subvp_save_surf_addr(struct dmub_srv *dmub, const struct dc_plane_address *addr, uint8_t subvp_index)
+{
+	if (dmub->hw_funcs.subvp_save_surf_addr) {
+		dmub->hw_funcs.subvp_save_surf_addr(dmub,
+				addr,
+				subvp_index);
+	}
+}
-- 
2.37.3

