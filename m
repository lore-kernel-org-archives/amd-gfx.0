Return-Path: <SRS0=EPaF=PD=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27E23C433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Oct 2021 18:44:24 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EAC8861040
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Oct 2021 18:44:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org EAC8861040
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 068FF6EDEF;
	Fri, 15 Oct 2021 18:44:21 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2054.outbound.protection.outlook.com [40.107.237.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F3E046EDED
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 Oct 2021 18:44:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VKms+SbK4U34KvuUhLplbvihh+a2pHs2wCTQqYX7l1BjQ264o1Z3AHwSmZ95YeAPhrmOsWOpg4kt4oKyvN2+NNgu1IfKgW4RaFoq+Ovz341/UVcV+7XzBg90GbbydijzrapoRx5HvHNzNfYZAiVURLFrEDjX5WShAb14KvpLKvEgkj6mBU11GaQVNKTkPt5mbb76aroSGqNh5PrEGJHqwZ4BsH7tZt2MyjWeIm2rfduduOGTQiSq4/R9fTnMe3Kjr9SHO9iCsxNYcqxoRSrLVOlmFBf0CkRhawqP+TiiKKn5AGbZZuxI8g0wPmcv4C2SD0urtqJYCeetrWUsWDiVGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ib2IovxhE76+dGxbAMQPvikWe2EvQu2Kaqu+fQchKn0=;
 b=B4NSTwIXigdgZgPCd7tVoeScJb2w3c78LascqC4SLFy6Nph9oZRBl+1cAKJUq3Ul+NfRqpB3x8VLdFkDxC2QHoMA9HDuNd50BqNqgGQhr2L0Qve1Yzuczd9a0wgH7wvGE5jG1ubvEH+wdCX9Wiu/YKqwbKoVcYjlXwXa3AwFxwMqT1PNEYdCmBJPVQmXzpwt9OT9fbt9fFtX3t87Jz5aTD0L0Oq5wld0EVQ4VTg5Bd8LtKB+wZV9ngHfrNDm9QCBbe4ebiVQV2/iDMObEEvAq6lPaPJJ/ypBELmwy2VPmlnie+Hu7koNVEPhfqXZ1IUv0IxBrI/nXJ6bOvbWwYcOrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ib2IovxhE76+dGxbAMQPvikWe2EvQu2Kaqu+fQchKn0=;
 b=uieUpp3KU7MsNNDMTR/r/AsdrRPjjlf5NkTuTl0QnVBrDURVLhFKPK7UVNe09kySTOZvudsKlQDUgrZyImy/++zaGQG8AnfTJWWSQF6nwWTD/zdwV29uo5w1YHOuhWuIynSdgx1DpGBevsaEYrPq7kBP4Rcnq9yju8HXI0ZCqp8=
Received: from DS7PR06CA0030.namprd06.prod.outlook.com (2603:10b6:8:54::22) by
 BN9PR12MB5337.namprd12.prod.outlook.com (2603:10b6:408:102::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4608.16; Fri, 15 Oct 2021 18:44:15 +0000
Received: from DM6NAM11FT037.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:54:cafe::aa) by DS7PR06CA0030.outlook.office365.com
 (2603:10b6:8:54::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.15 via Frontend
 Transport; Fri, 15 Oct 2021 18:44:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT037.mail.protection.outlook.com (10.13.172.122) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4608.15 via Frontend Transport; Fri, 15 Oct 2021 18:44:15 +0000
Received: from ubuntu.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Fri, 15 Oct
 2021 13:44:13 -0500
From: Agustin Gutierrez <agustin.gutierrez@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Bhawanpreet.Lakha@amd.com>, <Rodrigo.Siqueira@amd.com>,
 <Aurabindo.Pillai@amd.com>, <qingqing.zhuo@amd.com>, <mikita.lipski@amd.com>, 
 <roman.li@amd.com>, <Anson.Jacob@amd.com>, <wayne.lin@amd.com>,
 <stylon.wang@amd.com>, <solomon.chiu@amd.com>, <pavle.kotarac@amd.com>,
 <agustin.gutierrez@amd.com>, Hanghong Ma <hanghong.ma@amd.com>, "Mark
 Broadworth" <mark.broadworth@amd.com>
Subject: [PATCH 27/27] Revert "drm/amd/display: Add helper for blanking all dp
 displays"
Date: Fri, 15 Oct 2021 14:43:32 -0400
Message-ID: <20211015184332.221091-28-agustin.gutierrez@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211015184332.221091-1-agustin.gutierrez@amd.com>
References: <20211015184332.221091-1-agustin.gutierrez@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4351ba94-d74c-4a08-9d9c-08d9900bc9b0
X-MS-TrafficTypeDiagnostic: BN9PR12MB5337:
X-Microsoft-Antispam-PRVS: <BN9PR12MB53378033F573DFCF2C3642BEF5B99@BN9PR12MB5337.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:983;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OjIz2/7jqhQVkckcdaW2GbxTc2e5pL6qY0knpl5m8alnGf+7mZSnry7JkuiuaYbB3SGEaRt8rRdN/biibkrbt73/pPEYegb4Vd89YGd02qywzGTQuj1B0cnXFgz3/eedCwiyqDDMnzAl2/B1iDuqJW+G0D45hHSXNdCoLGvKwBRJCDCx7NM32NzrN9RqNLS9WAAAXBMLWPcdM2HsK8+uNDQZz2ddQZpQO+UOHxWBY/+KcyAO4bmymW/cz6v3Di9cobEQqhpGIXmjr4+Azgec472IIusZujE4YUAoZteJv9eqzn44yb00T2HXywnp2fk06s1Hz/BPu5FB0LfVdhtkqUAJv/hCn5iJgoM8ZiFOw5syidoz/zSRi7BsbW0eynnOhrPGIVdYaZG2MVFUA6mLQYHGxTIckKn/+r+1qv0QJ9NG7CTNVH4atSyi4zDR7niNHpuaykpGOD/hTYaPvwUUOJn+XhDKR45w4eJGFTMVwqsE12+7RJmRIaGyOJXML+EU4iCP0ogBJ4k667PxUz63HBPPAog87BsBWQMcfzUF+wvOmg8Iq+cp0Oh0IVykfwvYGnNjfJd0jEV6KnHVQVMOz6+6QGzBGIm1bAEAmVXmz4Jq7pVzD39EcP+VLAx8YwO7slS859c18Bkbkpp/xjtARXDu7RSKTCG9gjh0j3RniSPWNNXMGXmQLb/Bxkn0cs214IA2BjJANrkWLKVL2nliKO5u2jMptL/Mm+tZdETqn/Q=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(1076003)(6666004)(8676002)(16526019)(426003)(82310400003)(508600001)(44832011)(6916009)(186003)(8936002)(54906003)(81166007)(356005)(316002)(5660300002)(70206006)(36860700001)(86362001)(36756003)(30864003)(83380400001)(70586007)(47076005)(336012)(4326008)(26005)(2616005)(2906002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2021 18:44:15.1641 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4351ba94-d74c-4a08-9d9c-08d9900bc9b0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT037.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5337
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This reverts commit 50ac5b14c74c5706796cb6378f25a2121dba5b2d.

This patch introduced a couple of dmesg warnings, this is not a valid
approach anymore. For this reason, we are reverting this patch, and we
need to revert the workaround patch.

Cc: Hanghong Ma <hanghong.ma@amd.com>
Cc: Mark Broadworth <mark.broadworth@amd.com>
Signed-off-by: Agustin Gutierrez <agustin.gutierrez@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_link.c | 45 -------------------
 drivers/gpu/drm/amd/display/dc/dc_link.h      |  1 -
 .../display/dc/dce110/dce110_hw_sequencer.c   | 24 ++++++++--
 .../amd/display/dc/dcn10/dcn10_hw_sequencer.c | 41 +++++++++++++++--
 .../drm/amd/display/dc/dcn30/dcn30_hwseq.c    | 39 ++++++++++++++--
 .../drm/amd/display/dc/dcn31/dcn31_hwseq.c    | 40 +++++++++++++++--
 6 files changed, 131 insertions(+), 59 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link.c b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
index c01309a1cbf2..e5d6cbd7ea78 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
@@ -1988,51 +1988,6 @@ static enum dc_status enable_link_dp_mst(
 	return enable_link_dp(state, pipe_ctx);
 }
 
-void blank_all_dp_displays(struct dc *dc, bool hw_init)
-{
-	unsigned int i, j, fe;
-	uint8_t dpcd_power_state = '\0';
-	enum dc_status status = DC_ERROR_UNEXPECTED;
-
-	for (i = 0; i < dc->link_count; i++) {
-		enum signal_type signal = dc->links[i]->connector_signal;
-
-		if ((signal == SIGNAL_TYPE_EDP) ||
-			(signal == SIGNAL_TYPE_DISPLAY_PORT)) {
-			if (hw_init && signal != SIGNAL_TYPE_EDP) {
-				/* DP 2.0 spec requires that we read LTTPR caps first */
-				dp_retrieve_lttpr_cap(dc->links[i]);
-				/* if any of the displays are lit up turn them off */
-				status = core_link_read_dpcd(dc->links[i], DP_SET_POWER,
-							&dpcd_power_state, sizeof(dpcd_power_state));
-			}
-
-			if ((signal != SIGNAL_TYPE_EDP && status == DC_OK && dpcd_power_state == DP_POWER_STATE_D0) ||
-					(!hw_init && dc->links[i]->link_enc &&
-					dc->links[i]->link_enc->funcs->is_dig_enabled(dc->links[i]->link_enc))) {
-				if (dc->links[i]->link_enc->funcs->get_dig_frontend) {
-					fe = dc->links[i]->link_enc->funcs->get_dig_frontend(dc->links[i]->link_enc);
-					if (fe == ENGINE_ID_UNKNOWN)
-						continue;
-
-					for (j = 0; j < dc->res_pool->stream_enc_count; j++) {
-						if (fe == dc->res_pool->stream_enc[j]->id) {
-							dc->res_pool->stream_enc[j]->funcs->dp_blank(dc->links[i],
-									dc->res_pool->stream_enc[j]);
-							break;
-						}
-					}
-				}
-
-				if (!dc->links[i]->wa_flags.dp_keep_receiver_powered ||
-					(hw_init && signal != SIGNAL_TYPE_EDP))
-					dp_receiver_power_ctrl(dc->links[i], false);
-			}
-		}
-	}
-
-}
-
 static bool get_ext_hdmi_settings(struct pipe_ctx *pipe_ctx,
 		enum engine_id eng_id,
 		struct ext_hdmi_settings *settings)
diff --git a/drivers/gpu/drm/amd/display/dc/dc_link.h b/drivers/gpu/drm/amd/display/dc/dc_link.h
index 69b008bafbbc..a73d64b1fd33 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_link.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_link.h
@@ -277,7 +277,6 @@ bool dc_link_setup_psr(struct dc_link *dc_link,
 		struct psr_context *psr_context);
 
 void dc_link_get_psr_residency(const struct dc_link *link, uint32_t *residency);
-void blank_all_dp_displays(struct dc *dc, bool hw_init);
 
 /* Request DC to detect if there is a Panel connected.
  * boot - If this call is during initial boot.
diff --git a/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
index 8108f9ae2638..af3e68d3e747 100644
--- a/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
@@ -1649,13 +1649,31 @@ static enum dc_status apply_single_controller_ctx_to_hw(
 
 static void power_down_encoders(struct dc *dc)
 {
-	int i;
-
-	blank_all_dp_displays(dc, false);
+	int i, j;
 
 	for (i = 0; i < dc->link_count; i++) {
 		enum signal_type signal = dc->links[i]->connector_signal;
 
+		if ((signal == SIGNAL_TYPE_EDP) ||
+			(signal == SIGNAL_TYPE_DISPLAY_PORT)) {
+			if (dc->links[i]->link_enc->funcs->get_dig_frontend &&
+				dc->links[i]->link_enc->funcs->is_dig_enabled(dc->links[i]->link_enc)) {
+				unsigned int fe = dc->links[i]->link_enc->funcs->get_dig_frontend(
+									dc->links[i]->link_enc);
+
+				for (j = 0; j < dc->res_pool->stream_enc_count; j++) {
+					if (fe == dc->res_pool->stream_enc[j]->id) {
+						dc->res_pool->stream_enc[j]->funcs->dp_blank(dc->links[i],
+									dc->res_pool->stream_enc[j]);
+						break;
+					}
+				}
+			}
+
+			if (!dc->links[i]->wa_flags.dp_keep_receiver_powered)
+				dp_receiver_power_ctrl(dc->links[i], false);
+		}
+
 		if (signal != SIGNAL_TYPE_EDP)
 			signal = SIGNAL_TYPE_NONE;
 
diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
index aa2d430f2a1a..44d27579d898 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
@@ -1366,7 +1366,7 @@ void dcn10_init_pipes(struct dc *dc, struct dc_state *context)
 
 void dcn10_init_hw(struct dc *dc)
 {
-	int i;
+	int i, j;
 	struct abm *abm = dc->res_pool->abm;
 	struct dmcu *dmcu = dc->res_pool->dmcu;
 	struct dce_hwseq *hws = dc->hwseq;
@@ -1462,8 +1462,43 @@ void dcn10_init_hw(struct dc *dc)
 		dmub_enable_outbox_notification(dc);
 
 	/* we want to turn off all dp displays before doing detection */
-	if (dc->config.power_down_display_on_boot)
-		blank_all_dp_displays(dc, true);
+	if (dc->config.power_down_display_on_boot) {
+		uint8_t dpcd_power_state = '\0';
+		enum dc_status status = DC_ERROR_UNEXPECTED;
+
+		for (i = 0; i < dc->link_count; i++) {
+			if (dc->links[i]->connector_signal != SIGNAL_TYPE_DISPLAY_PORT)
+				continue;
+
+			/* DP 2.0 requires that LTTPR Caps be read first */
+			dp_retrieve_lttpr_cap(dc->links[i]);
+
+			/*
+			 * If any of the displays are lit up turn them off.
+			 * The reason is that some MST hubs cannot be turned off
+			 * completely until we tell them to do so.
+			 * If not turned off, then displays connected to MST hub
+			 * won't light up.
+			 */
+			status = core_link_read_dpcd(dc->links[i], DP_SET_POWER,
+							&dpcd_power_state, sizeof(dpcd_power_state));
+			if (status == DC_OK && dpcd_power_state == DP_POWER_STATE_D0) {
+				/* blank dp stream before power off receiver*/
+				if (dc->links[i]->link_enc->funcs->get_dig_frontend) {
+					unsigned int fe = dc->links[i]->link_enc->funcs->get_dig_frontend(dc->links[i]->link_enc);
+
+					for (j = 0; j < dc->res_pool->stream_enc_count; j++) {
+						if (fe == dc->res_pool->stream_enc[j]->id) {
+							dc->res_pool->stream_enc[j]->funcs->dp_blank(dc->links[i],
+										dc->res_pool->stream_enc[j]);
+							break;
+						}
+					}
+				}
+				dp_receiver_power_ctrl(dc->links[i], false);
+			}
+		}
+	}
 
 	/* If taking control over from VBIOS, we may want to optimize our first
 	 * mode set, so we need to skip powering down pipes until we know which
diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c
index 2936a334cd64..df2717116604 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c
@@ -437,7 +437,7 @@ void dcn30_init_hw(struct dc *dc)
 	struct dce_hwseq *hws = dc->hwseq;
 	struct dc_bios *dcb = dc->ctx->dc_bios;
 	struct resource_pool *res_pool = dc->res_pool;
-	int i;
+	int i, j;
 	int edp_num;
 	uint32_t backlight = MAX_BACKLIGHT_LEVEL;
 
@@ -534,8 +534,41 @@ void dcn30_init_hw(struct dc *dc)
 			hws->funcs.dsc_pg_control(hws, res_pool->dscs[i]->inst, false);
 
 	/* we want to turn off all dp displays before doing detection */
-	if (dc->config.power_down_display_on_boot)
-		blank_all_dp_displays(dc, true);
+	if (dc->config.power_down_display_on_boot) {
+		uint8_t dpcd_power_state = '\0';
+		enum dc_status status = DC_ERROR_UNEXPECTED;
+
+		for (i = 0; i < dc->link_count; i++) {
+			if (dc->links[i]->connector_signal != SIGNAL_TYPE_DISPLAY_PORT)
+				continue;
+			/* DP 2.0 states that LTTPR regs must be read first */
+			dp_retrieve_lttpr_cap(dc->links[i]);
+
+			/* if any of the displays are lit up turn them off */
+			status = core_link_read_dpcd(dc->links[i], DP_SET_POWER,
+						     &dpcd_power_state, sizeof(dpcd_power_state));
+			if (status == DC_OK && dpcd_power_state == DP_POWER_STATE_D0) {
+				/* blank dp stream before power off receiver*/
+				if (dc->links[i]->link_enc->funcs->get_dig_frontend) {
+					unsigned int fe;
+
+					fe = dc->links[i]->link_enc->funcs->get_dig_frontend(
+										dc->links[i]->link_enc);
+					if (fe == ENGINE_ID_UNKNOWN)
+						continue;
+
+					for (j = 0; j < dc->res_pool->stream_enc_count; j++) {
+						if (fe == dc->res_pool->stream_enc[j]->id) {
+							dc->res_pool->stream_enc[j]->funcs->dp_blank(dc->links[i],
+										dc->res_pool->stream_enc[j]);
+							break;
+						}
+					}
+				}
+				dp_receiver_power_ctrl(dc->links[i], false);
+			}
+		}
+	}
 
 	/* If taking control over from VBIOS, we may want to optimize our first
 	 * mode set, so we need to skip powering down pipes until we know which
diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hwseq.c
index 186d08aec812..7308c4c744ba 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hwseq.c
@@ -72,7 +72,8 @@ void dcn31_init_hw(struct dc *dc)
 	struct dc_bios *dcb = dc->ctx->dc_bios;
 	struct resource_pool *res_pool = dc->res_pool;
 	uint32_t backlight = MAX_BACKLIGHT_LEVEL;
-	int i;
+	int i, j;
+	int edp_num;
 
 	if (dc->clk_mgr && dc->clk_mgr->funcs->init_clocks)
 		dc->clk_mgr->funcs->init_clocks(dc->clk_mgr);
@@ -190,9 +191,40 @@ void dcn31_init_hw(struct dc *dc)
 		dmub_enable_outbox_notification(dc);
 
 	/* we want to turn off all dp displays before doing detection */
-	if (dc->config.power_down_display_on_boot)
-		blank_all_dp_displays(dc, true);
-
+	if (dc->config.power_down_display_on_boot) {
+		uint8_t dpcd_power_state = '\0';
+		enum dc_status status = DC_ERROR_UNEXPECTED;
+
+		for (i = 0; i < dc->link_count; i++) {
+			if (dc->links[i]->connector_signal != SIGNAL_TYPE_DISPLAY_PORT)
+				continue;
+
+			/* if any of the displays are lit up turn them off */
+			status = core_link_read_dpcd(dc->links[i], DP_SET_POWER,
+						     &dpcd_power_state, sizeof(dpcd_power_state));
+			if (status == DC_OK && dpcd_power_state == DP_POWER_STATE_D0) {
+				/* blank dp stream before power off receiver*/
+				if (dc->links[i]->ep_type == DISPLAY_ENDPOINT_PHY &&
+						dc->links[i]->link_enc->funcs->get_dig_frontend) {
+					unsigned int fe;
+
+					fe = dc->links[i]->link_enc->funcs->get_dig_frontend(
+										dc->links[i]->link_enc);
+					if (fe == ENGINE_ID_UNKNOWN)
+						continue;
+
+					for (j = 0; j < dc->res_pool->stream_enc_count; j++) {
+						if (fe == dc->res_pool->stream_enc[j]->id) {
+							dc->res_pool->stream_enc[j]->funcs->dp_blank(dc->links[i],
+										dc->res_pool->stream_enc[j]);
+							break;
+						}
+					}
+				}
+				dp_receiver_power_ctrl(dc->links[i], false);
+			}
+		}
+	}
 
 	/* If taking control over from VBIOS, we may want to optimize our first
 	 * mode set, so we need to skip powering down pipes until we know which
-- 
2.25.1

