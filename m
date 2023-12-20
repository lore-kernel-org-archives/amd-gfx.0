Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 345ADC3DA6E
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Dec 2023 16:37:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9B3F910E5FF;
	Wed, 20 Dec 2023 16:37:24 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2085.outbound.protection.outlook.com [40.107.244.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0731D10E5FC
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 Dec 2023 16:37:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XvH34Uuq9gtYh7Ne9Au5qMu/P0YCdSGD1svRMuLpcbkspmkAws7xkLletePMp1fs+q70XUjhYOuBRcPQQ+P0lLqWXLP8IxRiTQxiQcDz1jy5E2H7bzqlj+vQK080tPkHHCw92AJbjYlvZs/B3Tx7FLOlMDpzvnWvy/QUtyGQwAGrLlaLOUnaiYpKoSuJxpepHtUIbn5vjcBmr3W+Rs4d0iAG3Pav/kync4jq0kS9sxv/zlTyP5wqG8SsMReQHoueJ2VfJVuHtp5Yej5H4rZgSpxrTe9osqw5pATqr9YK5CpC+Q3f7nMT0GPUQ2xgEYpm9JSGmYbP5zA9mX+TRtxOFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ACv46R7Gd4lneFGxyHwm4a0cD9KNL3nA+ZQzWKcAmLM=;
 b=XzetqQDBafhxK1AFgm76E0ZKpJLRhRus6GbKiB2oGxY11dG0hX9kGdEpmcxTX8QIjlTBHu83sjqEo4aUaUc5qEWf7OtzdrYy/E4HudDGQwOXL2ALJmQifkknT9OrF8igbMZ/UAYRDwPhsObM7GhLjzmdGFwlONOJ5rS0hQH6CG7Rq6YXUDCf0wWvt6KEeqI6bS21UFmsLIw4c8+L1HR/OjC1wN1k8aunXp2iPkxenBjzDxgr4JzXZKlm3n4PtApG4wq323T+trWOLdrqWSwGsVf/XQsby10isalxMklQfSSLjUpOyPrElW5U8/VaOiU/Yr4MrD3e6DHJBEg9qXgC4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ACv46R7Gd4lneFGxyHwm4a0cD9KNL3nA+ZQzWKcAmLM=;
 b=Fo0vj5j1o2+S3Vp1QyT7xUILYMCHflzB1hZFg8my1lYuVTTLHviRVPavHPt/5QIyCXLV5csZFX4aGT48Ka8Lqx8sadzRFmzEDxCF3tQgLCUzDDhJ0pzqt17xTr6fdHSpCuRL1uCCcnAn9f/4Q74EQaEkpHmPsFeEtledlTFPGhM=
Received: from BL1PR13CA0142.namprd13.prod.outlook.com (2603:10b6:208:2bb::27)
 by LV8PR12MB9232.namprd12.prod.outlook.com (2603:10b6:408:182::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.18; Wed, 20 Dec
 2023 16:37:20 +0000
Received: from BL02EPF0001A106.namprd05.prod.outlook.com
 (2603:10b6:208:2bb:cafe::56) by BL1PR13CA0142.outlook.office365.com
 (2603:10b6:208:2bb::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.18 via Frontend
 Transport; Wed, 20 Dec 2023 16:37:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A106.mail.protection.outlook.com (10.167.241.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7113.14 via Frontend Transport; Wed, 20 Dec 2023 16:37:20 +0000
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 20 Dec
 2023 10:37:15 -0600
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 20/20] drm/amd/display: Add some functions for Panel Replay
Date: Wed, 20 Dec 2023 09:33:52 -0700
Message-ID: <20231220163538.1742834-21-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231220163538.1742834-1-Rodrigo.Siqueira@amd.com>
References: <20231220163538.1742834-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A106:EE_|LV8PR12MB9232:EE_
X-MS-Office365-Filtering-Correlation-Id: 42580e84-c75e-46a8-412b-08dc0179ef89
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QPJ1Ca03ivDk4obhMtme7h5vkVDP5+9Q73aICl3ymXxQhghCSYJUEogp+tj/WL6/cdXj1YONWlYp56ci5LYLqPaQHbq/k0X1BoNaigPuNuUD73Ppvi++sVTjze1VUfchJRIwqULB9Ju2MG3b0GAuw8rvqhxJdhgKBHUZ2rlvWGh3/hemj49yPPFq6LVfvTpjN0HoINPCc9WoHImVAIAXZDD2gttnnCPjGAfEOZebmMmksNZm0oCKh5COFZUFQCbPHoRFHsr6LwNIUkNVG7Eu427gaMGNeqtNLCnWdljNjqQpdw5uNv0U6rn3DfRT9+HTtroz9a4adlKSM8ugyR2zHC1bikhqDMzUTTyfk2Obvb9trXkv4ZjhoX18VlTi315PsxI9j/+MuQovvg6Y3D6vD24LmtpYwc3MiEgxzakQE4U15bvBzYjZdnjnHggRIpAjkJ5/VIao9WnelB7yjPGn8fyTj+qd2pxlMppBGEXuDOIUqCswTggkmPRr6jfS7dMoWtJJZ3PcL08qVXixUXkzpzoMvI5yFjHBaaHv3Y13pB9ISvUloV7OWrBH6ZpINt7ennUDVslopFESE3OJkej3MfsWohsqSZfV+JlXwxHpeY6JhXXHIjJZxWx5gufglMXQ7wZU8i7tzy+xJU2d3CsYMnSl1FCbusxevgnKpr56KS1ipWIVWiONgViE4YQFywdgd2FPCkYqTDEvydMLNS7GA2o+MnBALUkgQFXwKa506RSbdYLmT6C67UW6LiH9w1bz4gQkPBBBPVWHS9fgS1eHHA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(346002)(136003)(396003)(39860400002)(230922051799003)(451199024)(186009)(1800799012)(82310400011)(64100799003)(36840700001)(40470700004)(46966006)(40460700003)(40480700001)(336012)(1076003)(6666004)(2616005)(26005)(16526019)(426003)(81166007)(356005)(82740400003)(2906002)(36756003)(86362001)(478600001)(36860700001)(8936002)(8676002)(41300700001)(4326008)(30864003)(83380400001)(47076005)(70206006)(316002)(6916009)(70586007)(54906003)(5660300002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2023 16:37:20.0719 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 42580e84-c75e-46a8-412b-08dc0179ef89
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A106.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9232
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
Cc: stylon.wang@amd.com, chiahsuan.chung@amd.com, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <rodrigo.siqueira@amd.com>, roman.li@amd.com,
 jerry.zuo@amd.com, Aurabindo.Pillai@amd.com, hersenxs.wu@amd.com,
 wayne.lin@amd.com, Harry.Wentland@amd.com, agustin.gutierrez@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Tom Chung <chiahsuan.chung@amd.com>

[WHY]
Prepare for enabling the Panel Replay feature

[HOW]
- Add some Panel Replay setting functions in DC
- Add the Panel Replay resource in dcn35_resource.c
- Add debug masks for Panel Replay

Acked-by: Rodrigo Siqueira <rodrigo.siqueira@amd.com>
Reviewed-by: Leo Li <sunpeng.li@amd.com>
Signed-off-by: Tom Chung <chiahsuan.chung@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c      | 34 +++++++
 .../drm/amd/display/dc/core/dc_link_exports.c |  7 ++
 drivers/gpu/drm/amd/display/dc/dc.h           | 23 +++++
 .../gpu/drm/amd/display/dc/dce/dmub_replay.c  | 96 +++++++++++++++++--
 .../gpu/drm/amd/display/dc/dce/dmub_replay.h  |  2 +
 drivers/gpu/drm/amd/display/dc/inc/link.h     |  2 +
 .../drm/amd/display/dc/link/link_factory.c    |  1 +
 .../link/protocols/link_edp_panel_control.c   | 27 ++++++
 .../link/protocols/link_edp_panel_control.h   |  2 +
 .../dc/resource/dcn35/dcn35_resource.c        | 13 +++
 .../amd/display/modules/power/power_helpers.c | 28 ++++++
 .../amd/display/modules/power/power_helpers.h |  5 +
 drivers/gpu/drm/amd/include/amd_shared.h      |  2 +
 13 files changed, 236 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index b7c2eaebf8bf..2d7205058c64 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -4770,6 +4770,38 @@ bool dc_set_psr_allow_active(struct dc *dc, bool enable)
 	return true;
 }
 
+/* enable/disable eDP Replay without specify stream for eDP */
+bool dc_set_replay_allow_active(struct dc *dc, bool active)
+{
+	int i;
+	bool allow_active;
+
+	for (i = 0; i < dc->current_state->stream_count; i++) {
+		struct dc_link *link;
+		struct dc_stream_state *stream = dc->current_state->streams[i];
+
+		link = stream->link;
+		if (!link)
+			continue;
+
+		if (link->replay_settings.replay_feature_enabled) {
+			if (active && !link->replay_settings.replay_allow_active) {
+				allow_active = true;
+				if (!dc_link_set_replay_allow_active(link, &allow_active,
+					false, false, NULL))
+					return false;
+			} else if (!active && link->replay_settings.replay_allow_active) {
+				allow_active = false;
+				if (!dc_link_set_replay_allow_active(link, &allow_active,
+					true, false, NULL))
+					return false;
+			}
+		}
+	}
+
+	return true;
+}
+
 void dc_allow_idle_optimizations(struct dc *dc, bool allow)
 {
 	if (dc->debug.disable_idle_power_optimizations)
@@ -5315,6 +5347,8 @@ bool dc_abm_save_restore(
 	struct dc_link *link = stream->sink->link;
 	struct dc_link *edp_links[MAX_NUM_EDP];
 
+	if (link->replay_settings.replay_feature_enabled)
+		return false;
 
 	/*find primary pipe associated with stream*/
 	for (i = 0; i < MAX_PIPES; i++) {
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_exports.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_exports.c
index f365773d5714..c6c35037bdb8 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_exports.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_exports.c
@@ -467,6 +467,13 @@ bool dc_link_setup_psr(struct dc_link *link,
 	return link->dc->link_srv->edp_setup_psr(link, stream, psr_config, psr_context);
 }
 
+bool dc_link_set_replay_allow_active(struct dc_link *link, const bool *allow_active,
+		bool wait, bool force_static, const unsigned int *power_opts)
+{
+	return link->dc->link_srv->edp_set_replay_allow_active(link, allow_active, wait,
+			force_static, power_opts);
+}
+
 bool dc_link_get_replay_state(const struct dc_link *link, uint64_t *state)
 {
 	return link->dc->link_srv->edp_get_replay_state(link, state);
diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 565de7428b6c..f30a341bc090 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -463,6 +463,12 @@ enum dml_hostvm_override_opts {
 	DML_HOSTVM_OVERRIDE_TRUE = 0x2,
 };
 
+enum dc_replay_power_opts {
+	replay_power_opt_invalid		= 0x0,
+	replay_power_opt_smu_opt_static_screen	= 0x1,
+	replay_power_opt_z10_static_screen	= 0x10,
+};
+
 enum dcc_option {
 	DCC_ENABLE = 0,
 	DCC_DISABLE = 1,
@@ -2077,6 +2083,20 @@ bool dc_link_setup_psr(struct dc_link *dc_link,
 		const struct dc_stream_state *stream, struct psr_config *psr_config,
 		struct psr_context *psr_context);
 
+/*
+ * Communicate with DMUB to allow or disallow Panel Replay on the specified link:
+ *
+ * @link: pointer to the dc_link struct instance
+ * @enable: enable(active) or disable(inactive) replay
+ * @wait: state transition need to wait the active set completed.
+ * @force_static: force disable(inactive) the replay
+ * @power_opts: set power optimazation parameters to DMUB.
+ *
+ * return: allow Replay active will return true, else will return false.
+ */
+bool dc_link_set_replay_allow_active(struct dc_link *dc_link, const bool *enable,
+		bool wait, bool force_static, const unsigned int *power_opts);
+
 bool dc_link_get_replay_state(const struct dc_link *dc_link, uint64_t *state);
 
 /* On eDP links this function call will stall until T12 has elapsed.
@@ -2321,6 +2341,9 @@ void dc_hardware_release(struct dc *dc);
 void dc_mclk_switch_using_fw_based_vblank_stretch_shut_down(struct dc *dc);
 
 bool dc_set_psr_allow_active(struct dc *dc, bool enable);
+
+bool dc_set_replay_allow_active(struct dc *dc, bool active);
+
 void dc_z10_restore(const struct dc *dc);
 void dc_z10_save_init(struct dc *dc);
 
diff --git a/drivers/gpu/drm/amd/display/dc/dce/dmub_replay.c b/drivers/gpu/drm/amd/display/dc/dce/dmub_replay.c
index 28149e53c2a6..38e4797e9476 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dmub_replay.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dmub_replay.c
@@ -258,13 +258,97 @@ static void dmub_replay_residency(struct dmub_replay *dmub, uint8_t panel_inst,
 		*residency = 0;
 }
 
+/**
+ * Set REPLAY power optimization flags and coasting vtotal.
+ */
+static void dmub_replay_set_power_opt_and_coasting_vtotal(struct dmub_replay *dmub,
+		unsigned int power_opt, uint8_t panel_inst, uint16_t coasting_vtotal)
+{
+	union dmub_rb_cmd cmd;
+	struct dc_context *dc = dmub->ctx;
+
+	memset(&cmd, 0, sizeof(cmd));
+	cmd.replay_set_power_opt_and_coasting_vtotal.header.type = DMUB_CMD__REPLAY;
+	cmd.replay_set_power_opt_and_coasting_vtotal.header.sub_type =
+		DMUB_CMD__REPLAY_SET_POWER_OPT_AND_COASTING_VTOTAL;
+	cmd.replay_set_power_opt_and_coasting_vtotal.header.payload_bytes =
+		sizeof(struct dmub_rb_cmd_replay_set_power_opt_and_coasting_vtotal);
+	cmd.replay_set_power_opt_and_coasting_vtotal.replay_set_power_opt_data.power_opt = power_opt;
+	cmd.replay_set_power_opt_and_coasting_vtotal.replay_set_power_opt_data.panel_inst = panel_inst;
+	cmd.replay_set_power_opt_and_coasting_vtotal.replay_set_coasting_vtotal_data.coasting_vtotal = coasting_vtotal;
+
+	dc_wake_and_execute_dmub_cmd(dc, &cmd, DM_DMUB_WAIT_TYPE_WAIT);
+}
+
+/**
+ * send Replay general cmd to DMUB.
+ */
+static void dmub_replay_send_cmd(struct dmub_replay *dmub,
+		enum replay_FW_Message_type msg, union dmub_replay_cmd_set *cmd_element)
+{
+	union dmub_rb_cmd cmd;
+	struct dc_context *ctx = NULL;
+
+	if (dmub == NULL || cmd_element == NULL)
+		return;
+
+	ctx = dmub->ctx;
+	if (ctx != NULL) {
+
+		if (msg != Replay_Msg_Not_Support) {
+			memset(&cmd, 0, sizeof(cmd));
+			//Header
+			cmd.replay_set_timing_sync.header.type = DMUB_CMD__REPLAY;
+		} else
+			return;
+	} else
+		return;
+
+	switch (msg) {
+	case Replay_Set_Timing_Sync_Supported:
+		//Header
+		cmd.replay_set_timing_sync.header.sub_type =
+			DMUB_CMD__REPLAY_SET_TIMING_SYNC_SUPPORTED;
+		cmd.replay_set_timing_sync.header.payload_bytes =
+			sizeof(struct dmub_rb_cmd_replay_set_timing_sync);
+		//Cmd Body
+		cmd.replay_set_timing_sync.replay_set_timing_sync_data.panel_inst =
+						cmd_element->sync_data.panel_inst;
+		cmd.replay_set_timing_sync.replay_set_timing_sync_data.timing_sync_supported =
+						cmd_element->sync_data.timing_sync_supported;
+		break;
+	case Replay_Set_Residency_Frameupdate_Timer:
+		//Header
+		cmd.replay_set_frameupdate_timer.header.sub_type =
+			DMUB_CMD__REPLAY_SET_RESIDENCY_FRAMEUPDATE_TIMER;
+		cmd.replay_set_frameupdate_timer.header.payload_bytes =
+			sizeof(struct dmub_rb_cmd_replay_set_frameupdate_timer);
+		//Cmd Body
+		cmd.replay_set_frameupdate_timer.data.panel_inst =
+						cmd_element->panel_inst;
+		cmd.replay_set_frameupdate_timer.data.enable =
+						cmd_element->timer_data.enable;
+		cmd.replay_set_frameupdate_timer.data.frameupdate_count =
+						cmd_element->timer_data.frameupdate_count;
+		break;
+	case Replay_Msg_Not_Support:
+	default:
+		return;
+		break;
+	}
+
+	dc_wake_and_execute_dmub_cmd(ctx, &cmd, DM_DMUB_WAIT_TYPE_WAIT);
+}
+
 static const struct dmub_replay_funcs replay_funcs = {
-	.replay_copy_settings		= dmub_replay_copy_settings,
-	.replay_enable			= dmub_replay_enable,
-	.replay_get_state		= dmub_replay_get_state,
-	.replay_set_power_opt		= dmub_replay_set_power_opt,
-	.replay_set_coasting_vtotal	= dmub_replay_set_coasting_vtotal,
-	.replay_residency		= dmub_replay_residency,
+	.replay_copy_settings				= dmub_replay_copy_settings,
+	.replay_enable					= dmub_replay_enable,
+	.replay_get_state				= dmub_replay_get_state,
+	.replay_set_power_opt				= dmub_replay_set_power_opt,
+	.replay_set_coasting_vtotal			= dmub_replay_set_coasting_vtotal,
+	.replay_residency				= dmub_replay_residency,
+	.replay_set_power_opt_and_coasting_vtotal	= dmub_replay_set_power_opt_and_coasting_vtotal,
+	.replay_send_cmd				= dmub_replay_send_cmd,
 };
 
 /*
diff --git a/drivers/gpu/drm/amd/display/dc/dce/dmub_replay.h b/drivers/gpu/drm/amd/display/dc/dce/dmub_replay.h
index b3ee90a0b8b3..3613aff994d7 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dmub_replay.h
+++ b/drivers/gpu/drm/amd/display/dc/dce/dmub_replay.h
@@ -51,6 +51,8 @@ struct dmub_replay_funcs {
 		uint8_t panel_inst);
 	void (*replay_residency)(struct dmub_replay *dmub,
 		uint8_t panel_inst, uint32_t *residency, const bool is_start, const bool is_alpm);
+	void (*replay_set_power_opt_and_coasting_vtotal)(struct dmub_replay *dmub,
+		unsigned int power_opt, uint8_t panel_inst, uint16_t coasting_vtotal);
 };
 
 struct dmub_replay *dmub_replay_create(struct dc_context *ctx);
diff --git a/drivers/gpu/drm/amd/display/dc/inc/link.h b/drivers/gpu/drm/amd/display/dc/inc/link.h
index 7439865d1b50..26fe81f213da 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/link.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/link.h
@@ -289,6 +289,8 @@ struct link_service {
 	bool (*edp_replay_residency)(const struct dc_link *link,
 			unsigned int *residency, const bool is_start,
 			const bool is_alpm);
+	bool (*edp_set_replay_power_opt_and_coasting_vtotal)(struct dc_link *link,
+			const unsigned int *power_opts, uint16_t coasting_vtotal);
 
 	bool (*edp_wait_for_t12)(struct dc_link *link);
 	bool (*edp_is_ilr_optimization_required)(struct dc_link *link,
diff --git a/drivers/gpu/drm/amd/display/dc/link/link_factory.c b/drivers/gpu/drm/amd/display/dc/link/link_factory.c
index 5464d8d26bd3..37d3027c32dc 100644
--- a/drivers/gpu/drm/amd/display/dc/link/link_factory.c
+++ b/drivers/gpu/drm/amd/display/dc/link/link_factory.c
@@ -216,6 +216,7 @@ static void construct_link_service_edp_panel_control(struct link_service *link_s
 	link_srv->edp_send_replay_cmd = edp_send_replay_cmd;
 	link_srv->edp_set_coasting_vtotal = edp_set_coasting_vtotal;
 	link_srv->edp_replay_residency = edp_replay_residency;
+	link_srv->edp_set_replay_power_opt_and_coasting_vtotal = edp_set_replay_power_opt_and_coasting_vtotal;
 
 	link_srv->edp_wait_for_t12 = edp_wait_for_t12;
 	link_srv->edp_is_ilr_optimization_required =
diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c
index e8de68e62403..7f1196528218 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c
@@ -1068,6 +1068,33 @@ bool edp_replay_residency(const struct dc_link *link,
 	return true;
 }
 
+bool edp_set_replay_power_opt_and_coasting_vtotal(struct dc_link *link,
+	const unsigned int *power_opts, uint16_t coasting_vtotal)
+{
+	struct dc  *dc = link->ctx->dc;
+	struct dmub_replay *replay = dc->res_pool->replay;
+	unsigned int panel_inst;
+
+	if (!dc_get_edp_link_panel_inst(dc, link, &panel_inst))
+		return false;
+
+	/* Only both power and coasting vtotal changed, this func could return true */
+	if (power_opts && link->replay_settings.replay_power_opt_active != *power_opts &&
+		coasting_vtotal && link->replay_settings.coasting_vtotal != coasting_vtotal) {
+		if (link->replay_settings.replay_feature_enabled &&
+			replay->funcs->replay_set_power_opt_and_coasting_vtotal) {
+			replay->funcs->replay_set_power_opt_and_coasting_vtotal(replay,
+				*power_opts, panel_inst, coasting_vtotal);
+			link->replay_settings.replay_power_opt_active = *power_opts;
+			link->replay_settings.coasting_vtotal = coasting_vtotal;
+		} else
+			return false;
+	} else
+		return false;
+
+	return true;
+}
+
 static struct abm *get_abm_from_stream_res(const struct dc_link *link)
 {
 	int i;
diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.h b/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.h
index b7493ff4fcee..34e521af7bb4 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.h
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.h
@@ -63,6 +63,8 @@ bool edp_set_coasting_vtotal(struct dc_link *link, uint16_t coasting_vtotal);
 bool edp_replay_residency(const struct dc_link *link,
 	unsigned int *residency, const bool is_start, const bool is_alpm);
 bool edp_get_replay_state(const struct dc_link *link, uint64_t *state);
+bool edp_set_replay_power_opt_and_coasting_vtotal(struct dc_link *link,
+	const unsigned int *power_opts, uint16_t coasting_vtotal);
 bool edp_wait_for_t12(struct dc_link *link);
 bool edp_is_ilr_optimization_required(struct dc_link *link,
        struct dc_crtc_timing *crtc_timing);
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c
index 810cfe213632..685f87e2dbde 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c
@@ -96,6 +96,7 @@
 #include "reg_helper.h"
 #include "dce/dmub_abm.h"
 #include "dce/dmub_psr.h"
+#include "dce/dmub_replay.h"
 #include "dce/dce_aux.h"
 #include "dce/dce_i2c.h"
 #include "dml/dcn31/display_mode_vba_31.h" /*temp*/
@@ -788,6 +789,7 @@ static const struct dc_panel_config panel_config_defaults = {
 	.psr = {
 		.disable_psr = false,
 		.disallow_psrsu = false,
+		.disallow_replay = false,
 	},
 	.ilr = {
 		.optimize_edp_link_rate = true,
@@ -1546,6 +1548,9 @@ static void dcn35_resource_destruct(struct dcn35_resource_pool *pool)
 	if (pool->base.psr != NULL)
 		dmub_psr_destroy(&pool->base.psr);
 
+	if (pool->base.replay != NULL)
+		dmub_replay_destroy(&pool->base.replay);
+
 	if (pool->base.pg_cntl != NULL)
 		dcn_pg_cntl_destroy(&pool->base.pg_cntl);
 
@@ -2030,6 +2035,14 @@ static bool dcn35_resource_construct(
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
diff --git a/drivers/gpu/drm/amd/display/modules/power/power_helpers.c b/drivers/gpu/drm/amd/display/modules/power/power_helpers.c
index 1675314a3ff2..34b848c981e0 100644
--- a/drivers/gpu/drm/amd/display/modules/power/power_helpers.c
+++ b/drivers/gpu/drm/amd/display/modules/power/power_helpers.c
@@ -973,6 +973,34 @@ bool psr_su_set_dsc_slice_height(struct dc *dc, struct dc_link *link,
 	return true;
 }
 
+void set_replay_coasting_vtotal(struct dc_link *link,
+	enum replay_coasting_vtotal_type type,
+	uint16_t vtotal)
+{
+	link->replay_settings.coasting_vtotal_table[type] = vtotal;
+}
+
+void calculate_replay_link_off_frame_count(struct dc_link *link,
+	uint16_t vtotal, uint16_t htotal)
+{
+	uint8_t max_link_off_frame_count = 0;
+	uint16_t max_deviation_line = 0,  pixel_deviation_per_line = 0;
+
+	max_deviation_line = link->dpcd_caps.pr_info.max_deviation_line;
+	pixel_deviation_per_line = link->dpcd_caps.pr_info.pixel_deviation_per_line;
+
+	if (htotal != 0 && vtotal != 0)
+		max_link_off_frame_count = htotal * max_deviation_line / (pixel_deviation_per_line * vtotal);
+	else
+		ASSERT(0);
+
+	link->replay_settings.link_off_frame_count_level =
+		max_link_off_frame_count >= PR_LINK_OFF_FRAME_COUNT_BEST ? PR_LINK_OFF_FRAME_COUNT_BEST :
+		max_link_off_frame_count >= PR_LINK_OFF_FRAME_COUNT_GOOD ? PR_LINK_OFF_FRAME_COUNT_GOOD :
+		PR_LINK_OFF_FRAME_COUNT_FAIL;
+
+}
+
 bool fill_custom_backlight_caps(unsigned int config_no, struct dm_acpi_atif_backlight_caps *caps)
 {
 	unsigned int data_points_size;
diff --git a/drivers/gpu/drm/amd/display/modules/power/power_helpers.h b/drivers/gpu/drm/amd/display/modules/power/power_helpers.h
index d9e0d67d67f7..c17bbc6fb38c 100644
--- a/drivers/gpu/drm/amd/display/modules/power/power_helpers.h
+++ b/drivers/gpu/drm/amd/display/modules/power/power_helpers.h
@@ -54,6 +54,11 @@ bool dmub_init_abm_config(struct resource_pool *res_pool,
 		unsigned int inst);
 
 void init_replay_config(struct dc_link *link, struct replay_config *pr_config);
+void set_replay_coasting_vtotal(struct dc_link *link,
+	enum replay_coasting_vtotal_type type,
+	uint16_t vtotal);
+void calculate_replay_link_off_frame_count(struct dc_link *link,
+	uint16_t vtotal, uint16_t htotal);
 
 bool is_psr_su_specific_panel(struct dc_link *link);
 void mod_power_calc_psr_configs(struct psr_config *psr_config,
diff --git a/drivers/gpu/drm/amd/include/amd_shared.h b/drivers/gpu/drm/amd/include/amd_shared.h
index 5cad456f2e10..da9b670fec86 100644
--- a/drivers/gpu/drm/amd/include/amd_shared.h
+++ b/drivers/gpu/drm/amd/include/amd_shared.h
@@ -244,6 +244,7 @@ enum DC_FEATURE_MASK {
 	DC_DISABLE_LTTPR_DP2_0 = (1 << 6), //0x40, disabled by default
 	DC_PSR_ALLOW_SMU_OPT = (1 << 7), //0x80, disabled by default
 	DC_PSR_ALLOW_MULTI_DISP_OPT = (1 << 8), //0x100, disabled by default
+	DC_REPLAY_MASK = (1 << 9), //0x200, disabled by default for dcn < 3.1.4
 };
 
 enum DC_DEBUG_MASK {
@@ -257,6 +258,7 @@ enum DC_DEBUG_MASK {
 	DC_ENABLE_DPIA_TRACE = 0x80,
 	DC_ENABLE_DML2 = 0x100,
 	DC_DISABLE_PSR_SU = 0x200,
+	DC_DISABLE_REPLAY = 0x400,
 };
 
 enum amd_dpm_forced_level;
-- 
2.42.0

